class Bun < Formula
  desc "Fast all-in-one JavaScript runtime"
  homepage "https://bun.sh"
  url "https://github.com/oven-sh/bun/releases/download/bun-v0.1.13/bun-darwin-aarch64.zip"
  version "0.1.13"
  sha256 "4584d171cf3171c466c6e28e5f05f76c15894972c8dbf5df1f8ffb65d71405d1"
  license "MIT"

  livecheck do
    url :stable
    regex(/bun-v?(\d+(?:\.\d+)+)/i)
  end

  depends_on :macos

  resource "completions" do
    url "https://github.com/oven-sh/bun/archive/bun-v0.1.13.tar.gz"
    sha256 "9fbf3e38860827399169364d920274a99b6cf3817ba71af7751a082cd703c9b2"
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
