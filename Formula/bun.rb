class Bun < Formula
  desc "Fast all-in-one JavaScript runtime"
  homepage "https://bun.sh"
  url "https://github.com/oven-sh/bun/releases/download/bun-v0.2.2/bun-darwin-aarch64.zip"
  version "0.2.2"
  sha256 "208cb9644c7ff92b4086d45c1aa337bafbc4aaee301b319496cd0afe8b788d12"
  license "MIT"

  livecheck do
    url :stable
    regex(/bun-v?(\d+(?:\.\d+)+)/i)
  end

  depends_on :macos

  def install
    bin.install "bun"
    ENV["BUN_INSTALL"] = bin.to_s
    generate_completions_from_executable(bin/"bun", "completions")
  end

  test do
    (testpath/"hello.ts").write <<~EOS
      console.log("hello", "bun");
    EOS
    assert_match "hello bun", shell_output("#{bin}/bun run hello.ts")
  end
end
