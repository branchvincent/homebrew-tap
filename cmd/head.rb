# typed: strict
# frozen_string_literal: true

require "abstract_command"
require "formula"

module Homebrew
  module Cmd
    class Head < AbstractCommand
      cmd_args do
        description <<~EOS
          Open a <formula>'s HEAD repository in a browser, or open
          Homebrew's own repository if no argument is provided.
        EOS

        named_args :formula
      end

      sig { override.void }
      def run
        if args.no_named?
          exec_browser "https://github.com/Homebrew/brew"
          return
        end

        heads = args.named.to_resolved_formulae.map do |formula|
          puts "Opening HEAD for Formula #{formula.name}"
          formula.head.url
        end

        exec_browser(*heads)
      end
    end
  end
end
