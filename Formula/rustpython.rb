class Rustpython < Formula
  desc "Python Interpreter written in Rust"
  homepage "https://rustpython.github.io"
  url "https://github.com/RustPython/RustPython/archive/refs/tags/2025-08-18-main-43.tar.gz"
  sha256 "389a62912475f459ab7da083c63f963523098e18a602105a32b32ab3dbcc01e7"
  license "MIT"
  head "https://github.com/RustPython/RustPython.git", branch: "main"

  depends_on "rust" => :build
  depends_on "openssl@3"

  uses_from_macos "zlib"

  def install
    # Avoid references to Homebrew shims
    inreplace "vm/build.rs", "std::env::vars_os()",
                             'std::env::vars_os().filter(|(k, _)| k != "PATH" && k != "RUSTC_WRAPPER")'

    ENV["OPENSSL_DIR"] = Formula["openssl@3"].opt_prefix
    system "cargo", "install", "--features=ssl", *std_cargo_args
    (lib/"rustpython").install buildpath.glob("Lib/*")
    bin.env_script_all_files libexec/"bin", RUSTPYTHONPATH: lib/"rustpython"

    # TODO: Install pip
    # system bin/"rustpython", "--install-pip" if OS.mac?
  end

  test do
    system bin/"rustpython", "-c", "print('Hello, RustPython!')"
    # system bin/"rustpython", "-m", "pip", "list", "--format=columns" if OS.mac?
  end
end
