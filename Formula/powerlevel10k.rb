class Powerlevel10k < Formula
  desc "Zsh theme"
  homepage "https://github.com/romkatv/powerlevel10k"
  url "https://github.com/romkatv/powerlevel10k/archive/v1.18.0.tar.gz"
  sha256 "08a64ab10fae468fdb3697e63405a9aacf085d81cd88c1c5d7b86151b165738a"
  head "https://github.com/romkatv/powerlevel10k.git", branch: "master"

  bottle do
    root_url "https://github.com/branchvincent/homebrew-tap/releases/download/powerlevel10k-1.16.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "c66f0550dfede8785f89979c492eff210ef77e195a46bb896c78efe3b416b605"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7b936fb772549f22cf868d5618af5814df22110328aafcdb28183aef39625fe4"
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
