class Littlecheck < Formula
  include Language::Python::Virtualenv

  desc "Command-line tool tester"
  homepage "https://github.com/ridiculousfish/littlecheck"
  url "https://github.com/ridiculousfish/littlecheck/archive/e6d56afd8dd14d8ce69d69326353f77d09e71c38.tar.gz"
  sha256 "514c15df1a193d377582f15b965bfa9a87ed00e718dda3d3f806f57db16bdb57"

  bottle do
    root_url "https://github.com/branchvincent/homebrew-tap/releases/download/littlecheck-38"
    sha256 cellar: :any_skip_relocation, catalina: "48ae757282649cbe2ef6775fcc421ce58746f3f529ac50c6a0c00341bfc0f7f7"
  end

  head do
    url "https://github.com/ridiculousfish/littlecheck.git"
  end

  depends_on "python@3.9"

  def install
    (buildpath/"setup.py").write <<~PYTHON
      from setuptools import setup

      setup(
          name="littecheck",
          packages=("littlecheck",),
          entry_points={"console_scripts": ["littlecheck=littlecheck:main"]},
      )
    PYTHON

    virtualenv_install_with_resources
  end

  test do
    assert_match "littlecheck: command line tool tester.", shell_output("#{bin}/littlecheck --help")
  end
end
