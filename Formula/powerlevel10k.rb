class Powerlevel10k < Formula
  desc "Zsh theme"
  homepage "https://github.com/romkatv/powerlevel10k"
  url "https://github.com/romkatv/powerlevel10k/archive/v1.16.1.tar.gz"
  sha256 "c81bf8ca42db47b8427d112acf525c98b1db362d67b1c8d434c0350fd72d19a2"
  head "https://github.com/romkatv/powerlevel10k.git", branch: "master"

  bottle do
    root_url "https://github.com/branchvincent/homebrew-tap/releases/download/powerlevel10k-1.16.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "a0ba77adc3e85dca90f401cb9d8018831b9971f06bb838dd3e0eda1e01cd7bf8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4128ce7d91e45229f028cf44ce267480c16ff82f038eeb40a21e54e2d9c629b9"
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
