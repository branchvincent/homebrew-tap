class Powerlevel10k < Formula
  desc "Zsh theme"
  homepage "https://github.com/romkatv/powerlevel10k"
  url "https://github.com/romkatv/powerlevel10k/archive/v1.16.1.tar.gz"
  sha256 "c81bf8ca42db47b8427d112acf525c98b1db362d67b1c8d434c0350fd72d19a2"
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
