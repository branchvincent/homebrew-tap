class Littlecheck < Formula
  include Language::Python::Shebang

  desc "Command-line tool tester"
  homepage "https://github.com/ridiculousfish/littlecheck"
  url "https://github.com/ridiculousfish/littlecheck/archive/ef94a661b8bd8878f4b1136b6d1963119cf67c04.tar.gz"
  version "0.1.1"
  sha256 "524e76987f3cfd4e8c951b4063a7866cbbd05412457fb660ededdf9ceb70de65"
  head "https://github.com/ridiculousfish/littlecheck.git", branch: "master"

  bottle do
    root_url "https://github.com/branchvincent/homebrew-tap/releases/download/littlecheck-0.1.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "303c75552ffce77099957a8f6ae4bb0b26d43cb988f10d29556c40ed424f7a08"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9bcc160474db487ba31107f614ce227e9aee627126d25b180b7b9a28704fab72"
  end

  depends_on "python@3.10"

  def install
    rewrite_shebang detected_python_shebang, "littlecheck/littlecheck.py"
    bin.install "littlecheck/littlecheck.py" => "littlecheck"
  end

  test do
    assert_match "littlecheck: command line tool tester.", shell_output("#{bin}/littlecheck --help")
  end
end
