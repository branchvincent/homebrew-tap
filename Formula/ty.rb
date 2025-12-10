class Ty < Formula
  desc "Extremely fast Python type checker and language server"
  homepage "https://docs.astral.sh/ty/"
  url "https://github.com/astral-sh/ty.git",
    tag:      "0.0.1-alpha.33",
    revision: "35e23aa481211acfc35dd7ff9f1a0be384f4fab7"
  license "MIT"
  head "https://github.com/astral-sh/ty.git", branch: "main"

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
