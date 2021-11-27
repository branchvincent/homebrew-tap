class Powerlevel10k < Formula
  desc "Zsh theme"
  homepage "https://github.com/romkatv/powerlevel10k"
  url "https://github.com/romkatv/powerlevel10k/archive/v1.15.0.tar.gz"
  sha256 "3482ae9b876890b78dd2567066cf5ceecd37eb2117c12248106710655a7dc1dc"
  head "https://github.com/romkatv/powerlevel10k.git", branch: "master"

  bottle do
    root_url "https://github.com/branchvincent/homebrew-tap/releases/download/powerlevel10k-1.15.0"
    sha256 cellar: :any_skip_relocation, catalina: "10e6544e42deb1cce0f5541de5dd95193ad482bfa506cf59e075a4e043e99fc8"
  end

  depends_on "zsh"

  def install
    system "make", "pkg"
    prefix.install Dir["*"]
  end

  test do
    assert_match "SUCCESS",
      shell_output("zsh -fic '. #{opt_prefix}/powerlevel10k.zsh-theme && (( ${+P9K_SSH} )) && echo SUCCESS'")
  end
end
