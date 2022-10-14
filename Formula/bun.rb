class Bun < Formula
  desc "Fast all-in-one JavaScript runtime"
  homepage "https://bun.sh"
  url "https://github.com/oven-sh/bun/releases/download/bun-v0.2.0/bun-darwin-aarch64.zip"
  version "0.2.0"
  sha256 "7ea57f1c17b3554c3ba953c2e35db39e90efee9161d1bf75212cb638d79d5e00"
  license "MIT"

  livecheck do
    url :stable
    regex(/bun-v?(\d+(?:\.\d+)+)/i)
  end

  depends_on :macos

  resource "completions" do
    url "https://github.com/oven-sh/bun/archive/bun-v0.2.0.tar.gz"
    sha256 "4e9a12b07a4033d2dde7cf504f99631b62ae0b85cdf31013f1f55e62a270aa7c"
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
