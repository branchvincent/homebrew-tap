class Ty < Formula
  desc "Extremely fast Python type checker and language server"
  homepage "https://docs.astral.sh/ty/"
  url "https://github.com/astral-sh/ty.git",
    tag:      "0.0.1-alpha.34",
    revision: "ef3d48ac4a72a9e7831419542b440c5bcec5623d"
  license "MIT"
  head "https://github.com/astral-sh/ty.git", branch: "main"

  livecheck do
    url :stable
  end

  bottle do
    root_url "https://github.com/branchv/homebrew-tap/releases/download/ty-0.0.1-alpha.33"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "21d415f2a24db3271c9a428fbd7fdce3810c16e6f062963bfb4610f3a37d052e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "44ab6578af54084aeaf16e3e6ea385244c2efe16f40f33cdfb87e7d12935e72e"
  end

  depends_on "rust" => :build

  def install
    ENV["TY_COMMIT_SHORT_HASH"] = tap.user
    ENV["TY_COMMIT_DATE"] = time.strftime("%F")
    system "cargo", "install", *std_cargo_args(path: "ruff/crates/ty")
    generate_completions_from_executable(bin/"ty", "generate-shell-completion")
  end

  test do
    (testpath/"t.py").write <<~PY
      def f(x: int) -> int:
        return "nope"
    PY

    out = shell_output("#{bin}/ty check #{testpath}/t.py 2>&1", 1)
    assert_match "Return type does not match returned value", out
  end
end
