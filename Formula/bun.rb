class Bun < Formula
  desc "Fast all-in-one JavaScript runtime"
  homepage "https://bun.sh"
  url "https://github.com/oven-sh/bun/releases/download/bun-v0.1.11/bun-darwin-aarch64.zip"
  version "0.1.11"
  sha256 "475ec66b80ba3d2c5f2f56f3e88063c747581665fdde2d32f2eab11b579929de"
  license "MIT"

  livecheck do
    url :stable
    regex(/bun-v?(\d+(?:\.\d+)+)/i)
  end

  depends_on :macos

  resource "completions" do
    url "https://github.com/oven-sh/bun/archive/bun-v0.1.11.tar.gz"
    sha256 "e7668660b4c1608d7eb481a2a12cd7f427597c7be0a42bc8ab068ca0a3953a9e"
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
