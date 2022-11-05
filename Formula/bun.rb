class Bun < Formula
  desc "Fast all-in-one JavaScript runtime"
  homepage "https://bun.sh"
  version "0.2.2"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/oven-sh/bun/releases/download/bun-v#{version}/bun-darwin-aarch64.zip"
      sha256 "208cb9644c7ff92b4086d45c1aa337bafbc4aaee301b319496cd0afe8b788d12"
    elsif Hardware::CPU.avx2?
      url "https://github.com/oven-sh/bun/releases/download/bun-v#{version}/bun-darwin-x64.zip"
      sha256 "dcf74b573e2a4c940798cf6568be35df19d9692b83eb195a4b2f1cb89f4cf2eb"
    else
      url "https://github.com/oven-sh/bun/releases/download/bun-v#{version}/bun-darwin-x64-baseline.zip"
      sha256 "4f75f22dd6aa4bd721a4abf6b5bae57a33b540ca11a93b6dac805b07eec1e4ed"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/oven-sh/bun/releases/download/bun-v#{version}/bun-linux-aarch64.zip"
      sha256 "e5c49c2d7ba3366d78f920abf0e70ef774432f711f023b2e0337dcc23f8430ab"
    elsif Hardware::CPU.avx2?
      url "https://github.com/oven-sh/bun/releases/download/bun-v#{version}/bun-linux-x64.zip"
      sha256 "795128a52bf28f363c277ab9db0a304e54951d9e2cd6521cf3fc94e986bed105"
    else
      url "https://github.com/oven-sh/bun/releases/download/bun-v#{version}/bun-linux-x64-baseline.zip"
      sha256 "0df289bbebf5426652c4618ab3809e92585050f0acf6b14f2712e94272bb6b5d"
    end
  end

  livecheck do
    url :stable
    regex(/bun-v?(\d+(?:\.\d+)+)/i)
  end

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
