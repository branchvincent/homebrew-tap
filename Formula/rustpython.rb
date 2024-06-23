class Rustpython < Formula
  desc "Python Interpreter written in Rust"
  homepage "https://rustpython.github.io"
  url "https://github.com/RustPython/RustPython/archive/d3e8e47c9ee18015586348690a815cc49622141d.tar.gz"
  version "0.1.2.post0" # v0.1.2 requires a yanked cargo dep
  sha256 "86100542fa63cce665ed67956e611a67117d5b3441c57aeab55e186a76fceec7"
  license "MIT"
  head "https://github.com/RustPython/RustPython.git", branch: "main"

  depends_on "rust" => :build
  depends_on "openssl@1.1"

  uses_from_macos "zlib"

  def install
    ENV["OPENSSL_DIR"] = Formula["openssl@1.1"].opt_prefix
    system "cargo", "install", "--features=ssl", *std_cargo_args
    (lib/"rustpython").install Dir["Lib/*"]
    bin.env_script_all_files libexec/"bin", RUSTPYTHONPATH: lib/"rustpython"

    # Install pip
    # Blocked by https://github.com/RustPython/RustPython/issues/3829
    # system bin/"rustpython", "--install-pip" if OS.mac?

    # Replace references to Homebrew shims
    # inreplace libexec/"bin/rustpython", Superenv.shims_path, ""
  end

  test do
    system bin/"rustpython", "-c", "print('Hello, RustPython!')"
    # system bin/"rustpython", "-m", "pip", "list", "--format=columns" if OS.mac?
  end
end
