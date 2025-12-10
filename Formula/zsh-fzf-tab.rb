class ZshFzfTab < Formula
  desc "Replace zsh's default completion selection menu with fzf"
  homepage "https://github.com/Aloxaf/fzf-tab"
  url "https://github.com/Aloxaf/fzf-tab.git", revision: "e85f76a3af3b6b6b799ad3d64899047962b9ce52"
  version "0.2.2"
  license "MIT"
  head "https://github.com/Aloxaf/fzf-tab.git", branch: "master"

  bottle do
    root_url "https://github.com/branchv/homebrew-tap/releases/download/zsh-fzf-tab-0.2.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "25db53134b79dc85c4f0c8bd2f483f0eedb965e0a1a479c3aba21f0eb4e00a39"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bc3ede7c899d636c6cdab1d927dacae9af1649c4e2d9d017f7babb9101f8548f"
  end

  depends_on "fzf"
  uses_from_macos "zsh" => :test

  def install
    libexec.install "lib", "fzf-tab.zsh"
    pkgshare.install_symlink libexec/"fzf-tab.zsh" => "zsh-fzf-tab.zsh"
  end

  def caveats
    <<~EOS
      To activate, add the following to the end of your .zshrc:
        source #{HOMEBREW_PREFIX}/share/#{name}/#{name}.zsh
    EOS
  end

  test do
    assert_equal libexec.to_s,
      shell_output("zsh -c '. #{pkgshare}/zsh-fzf-tab.zsh && printf $FZF_TAB_HOME'")
  end
end
