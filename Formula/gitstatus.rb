class Gitstatus < Formula
  desc "Faster git status for Bash and Zsh prompt"
  homepage "https://github.com/romkatv/gitstatus"
  url "https://github.com/romkatv/gitstatus/archive/v1.5.2.tar.gz"
  sha256 "8eb904b46876c6f8cf5314502f7cb5a25fa1ec220154ce883a1189760da99b98"
  head "https://github.com/romkatv/gitstatus.git", branch: "master"

  depends_on "zsh" => :test

  def install
    system "make", "pkg"
    prefix.install Dir["*"]
  end

  test do
    cmd = ". #{opt_prefix}/gitstatus.prompt.zsh && gitstatus_start MY && echo SUCCESS"
    assert_match "SUCCESS", shell_output("GITSTATUS_LOG_LEVEL=DEBUG zsh -fic '#{cmd}'")
    # with_env("GITSTATUS_LOG_LEVEL" => "DEBUG") do
    #   assert_match "SUCCESS", shell_output("zsh -fic '#{cmd}'")
    # end
  end
end
