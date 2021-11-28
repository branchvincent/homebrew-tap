class ZshFzfTab < Formula
  desc "Replace zsh's default completion selection menu with fzf"
  homepage "https://github.com/Aloxaf/fzf-tab"
  url "https://github.com/Aloxaf/fzf-tab.git", revision: "e85f76a3af3b6b6b799ad3d64899047962b9ce52"
  version "0.2.2"
  license "MIT"
  head "https://github.com/Aloxaf/fzf-tab.git", branch: "master"

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
