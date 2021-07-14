class Powerlevel10k < Formula
  desc "Zsh theme"
  homepage "https://github.com/romkatv/powerlevel10k"
  url "https://github.com/romkatv/powerlevel10k/archive/v1.15.0.tar.gz"
  sha256 "3482ae9b876890b78dd2567066cf5ceecd37eb2117c12248106710655a7dc1dc"

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
