class Littlecheck < Formula
  include Language::Python::Shebang

  desc "Command-line tool tester"
  homepage "https://github.com/ridiculousfish/littlecheck"
  url "https://github.com/ridiculousfish/littlecheck/archive/ef94a661b8bd8878f4b1136b6d1963119cf67c04.tar.gz"
  version "0.1.1"
  sha256 "524e76987f3cfd4e8c951b4063a7866cbbd05412457fb660ededdf9ceb70de65"
  head "https://github.com/ridiculousfish/littlecheck.git", branch: "master"

  bottle do
    root_url "https://github.com/branchvincent/homebrew-tap/releases/download/littlecheck-38"
    rebuild 1
    sha256 cellar: :any_skip_relocation, big_sur: "955aac2ff5b92d21d67596dd320b7cfe7da1698ce810b380f0171bbb1206ed62"
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
