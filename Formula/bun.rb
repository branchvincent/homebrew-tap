class Bun < Formula
  desc "Fast all-in-one JavaScript runtime"
  homepage "https://bun.sh"
  url "https://github.com/oven-sh/bun/releases/download/bun-v0.2.1/bun-darwin-aarch64.zip"
  version "0.2.1"
  sha256 "9f5bae71c8889ceaef7497d7c1b92af36d129a70ab0c4649cce813b59e52b567"
  license "MIT"

  livecheck do
    url :stable
    regex(/bun-v?(\d+(?:\.\d+)+)/i)
  end

  depends_on :macos

  resource "completions" do
    url "https://github.com/oven-sh/bun/archive/bun-v0.2.1.tar.gz"
    sha256 "e3aeea6f35fb4732cf27660fd08085d9355b74dbd78884e478d606b782ca60ef"
  end

  def install
    bin.install "bun"

    # Install shell completions
    resource("completions").stage do
      bash_completion.install "completions/bun.bash" => "bun"
      zsh_completion.install "completions/bun.zsh" => "_bun"
      fish_completion.install "completions/bun.fish"
    end
  end

  test do
    (testpath/"hello.ts").write <<~EOS
      console.log("hello", "bun");
    EOS
    assert_match "hello bun", shell_output("#{bin}/bun run hello.ts")
  end
end
