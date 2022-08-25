class Bun < Formula
  desc "Fast all-in-one JavaScript runtime"
  homepage "https://bun.sh"
  url "https://github.com/oven-sh/bun/releases/download/bun-v0.1.10/bun-darwin-aarch64.zip"
  version "0.1.10"
  sha256 "f37a77ed4c503540dcfebbd39261b55c9c5ccc5599d8edcf502752949a4b2dbe"
  license "MIT"

  livecheck do
    url :stable
    regex(/bun-v?(\d+(?:\.\d+)+)/i)
  end

  depends_on :macos

  resource "completions" do
    url "https://github.com/oven-sh/bun/archive/refs/tags/bun-v0.1.10.tar.gz"
    sha256 "ea3cdfa538a155341adedfb395c39596a6b2ba0c60ff6250e47aa381b99af775"
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
