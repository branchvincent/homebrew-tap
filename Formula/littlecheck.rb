class Littlecheck < Formula
  include Language::Python::Shebang

  desc "Command-line tool tester"
  homepage "https://github.com/ridiculousfish/littlecheck"
  url "https://github.com/ridiculousfish/littlecheck/archive/e6d56afd8dd14d8ce69d69326353f77d09e71c38.tar.gz"
  sha256 "514c15df1a193d377582f15b965bfa9a87ed00e718dda3d3f806f57db16bdb57"
  head "https://github.com/ridiculousfish/littlecheck.git"

  bottle do
    root_url "https://github.com/branchvincent/homebrew-tap/releases/download/littlecheck-38"
    sha256 cellar: :any_skip_relocation, catalina: "48ae757282649cbe2ef6775fcc421ce58746f3f529ac50c6a0c00341bfc0f7f7"
  end

  depends_on "python@3.9"

  def install
    rewrite_shebang detected_python_shebang, "littlecheck/littlecheck.py"
    bin.install "littlecheck/littlecheck.py" => "littlecheck"
  end

  test do
    assert_match "littlecheck: command line tool tester.", shell_output("#{bin}/littlecheck --help")
  end
end
