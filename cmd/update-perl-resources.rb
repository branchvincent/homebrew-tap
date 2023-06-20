# typed: true
# frozen_string_literal: true

require "cli/parser"

# typed: false
# frozen_string_literal: true

# Helper functions for updating CPAN resources.
#
# @api private
module CPAN
  module_function

  METACPAN_URL_PREFIX = "https://cpan.metacpan.org/"
  private_constant :METACPAN_URL_PREFIX

  # CPAN Package
  #
  # @api private
  class Package
    attr_accessor :name, :version

    sig { params(package_string: String, is_url: T::Boolean).void }
    def initialize(package_string, is_url: false)
      @cpan_info = nil

      if is_url
        match = if package_string.start_with?(METACPAN_URL_PREFIX)
          File.basename(package_string).match(/^(.+)-([a-z\d.]+?)(?:.tar.gz|.zip)$/)
        end
        raise ArgumentError, "package should be a valid CPAN URL" if match.blank?

        @name = match[1]
        @version = match[2]
        return
      end

      @name = package_string
      @name, @version = @name.split("==") if @name.include? "=="
    end

    # Get name, URL, SHA-256 checksum, and latest version for a given CPAN package.
    sig { params(version: T.nilable(T.any(String, Version))).returns(T.nilable(T::Array[String])) }
    def cpan_info(version: nil)
      return @cpan_info if @cpan_info.present? && version.blank?

      version ||= @version
      metadata_url = if version.present?
        "https://fastapi.metacpan.org/v1/download_url/#{@name}?version===#{version}"
      else
        "https://fastapi.metacpan.org/v1/download_url/#{@name}"
      end
      out, _, status = curl_output metadata_url, "--location"

      return unless status.success?

      begin
        json = JSON.parse out
      rescue JSON::ParserError
        return
      end

      @cpan_info = [@name, json["download_url"], json["checksum_sha256"], json["version"]]
    end

    sig { returns(String) }
    def to_s
      out = @name
      out += "==#{@version}" if @version.present?
      out
    end
  end

  # Return true if resources were checked (even if no change).
  sig {
    params(
      formula:                  Formula,
      version:                  T.nilable(String),
      package_name:             T.nilable(String),
      print_only:               T.nilable(T::Boolean),
      silent:                   T.nilable(T::Boolean),
      ignore_non_cpan_packages: T.nilable(T::Boolean),
    ).returns(T.nilable(T::Boolean))
  }
  def update_perl_resources!(formula, version: nil, package_name: nil, print_only: false, silent: false,
                             ignore_non_cpan_packages: false)
    new_resource_blocks = ""
    formula.resources.each do |resource|
      if !print_only && !resource.url.start_with?(METACPAN_URL_PREFIX)
        odie "\"#{formula.name}\" contains non-CPAN resources. Please update the resources manually."
      end

      package = Package.new(resource.name)
      ohai "Getting CPAN info for \"#{package}\"" if !print_only && !silent
      name, url, checksum = package.cpan_info

      # Fail if unable to find name, url or checksum for any resource
      if name.blank?
        odie "Unable to resolve some dependencies. Please update the resources for \"#{formula.name}\" manually."
      elsif url.blank? || checksum.blank?
        odie <<~EOS
          Unable to find the URL and/or sha256 for the "#{name}" resource.
          Please update the resources for "#{formula.name}" manually.
        EOS
      end

      # Append indented resource block
      new_resource_blocks += <<-EOS
  resource "#{name}" do
    url "#{url}"
    sha256 "#{checksum}"
  end

      EOS
    end

    if print_only
      puts new_resource_blocks.chomp
      return
    end

    # Check whether resources already exist (excluding virtualenv dependencies)
    if formula.resources.all? { |resource| resource.name.start_with?("homebrew-") }
      # Place resources above install method
      inreplace_regex = /  def install/
      new_resource_blocks += "  def install"
    else
      # Replace existing resource blocks with new resource blocks
      inreplace_regex = /  (resource .* do\s+url .*\s+sha256 .*\s+ end\s*)+/
      new_resource_blocks += "  "
    end

    ohai "Updating resource blocks" unless silent
    Utils::Inreplace.inreplace formula.path do |s|
      if s.inreplace_string.scan(inreplace_regex).length > 1
        odie "Unable to update resource blocks for \"#{formula.name}\" automatically. Please update them manually."
      end
      s.sub! inreplace_regex, new_resource_blocks
    end

    true
  end
end

module Homebrew
  module_function

  sig { returns(CLI::Parser) }
  def update_perl_resources_args
    Homebrew::CLI::Parser.new do
      description <<~EOS
        Update versions for CPAN resource blocks in <formula>.
      EOS
      switch "-p", "--print-only",
             description: "Print the updated resource blocks instead of changing <formula>."
      switch "-s", "--silent",
             description: "Suppress any output."
      switch "--ignore-non-cpan-packages",
             description: "Don't fail if <formula> is not a CPAN package."
      flag   "--version=",
             description: "Use the specified <version> when finding resources for <formula>. " \
                          "If no version is specified, the current version for <formula> will be used."
      flag   "--package-name=",
             description: "Use the specified <package-name> when finding resources for <formula>. " \
                          "If no package name is specified, it will be inferred from the formula's stable URL."

      named_args :formula, min: 1
    end
  end

  def update_perl_resources
    args = update_perl_resources_args.parse

    args.named.to_formulae.each do |formula|
      CPAN.update_perl_resources! formula,
                                  version:                  args.version,
                                  package_name:             args.package_name,
                                  print_only:               args.print_only?,
                                  silent:                   args.silent?,
                                  ignore_non_cpan_packages: args.ignore_non_cpan_packages?
    end
  end
end
