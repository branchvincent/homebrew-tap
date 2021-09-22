class Texlive < Formula
  desc "Free software distribution for the TeX typesetting system"
  homepage "https://www.tug.org/texlive/"
  url "https://github.com/TeX-Live/texlive-source/archive/svn58837.tar.gz"
  sha256 "0afa6919e44675b7afe0fa45344747afef07b6ee98eeb14ff6a2ef78f458fc12"
  license :public_domain
  head "https://github.com/TeX-Live/texlive-source.git", branch: "trunk"

  bottle do
    root_url "https://github.com/branchvincent/homebrew-tap/releases/download/texlive-58837"
    sha256 big_sur:      "708bc3d5251e358bb75cfc955dabf0e1ec892d73d0c2b5c63a5118cf05e95db5"
    sha256 x86_64_linux: "7ec785c21f1680dcc6d78f9f5119444d565359df5474cf6079b1bd3622822d64"
  end

  depends_on "cairo"
  depends_on "clisp"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "gd"
  depends_on "ghostscript"
  depends_on "gmp"
  depends_on "graphite2"
  depends_on "harfbuzz"
  depends_on "libpng"
  depends_on "lua"
  depends_on "luajit-openresty"
  depends_on "mpfr"
  depends_on "perl"
  depends_on "pixman"
  depends_on "potrace"

  uses_from_macos "icu4c"
  uses_from_macos "ncurses"
  uses_from_macos "zlib"

  on_linux do
    depends_on "pkg-config" => :build
    depends_on "gcc"
    depends_on "libice"
    depends_on "libsm"
    depends_on "libx11"
    depends_on "libxaw"
    depends_on "libxext"
    depends_on "libxmu"
    depends_on "libxpm"
    depends_on "libxt"
  end

  fails_with gcc: "5"

  resource "texlive-extra" do
    url "https://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2021/texlive-20210325-extra.tar.xz"
    sha256 "46a3f385d0b30893eec6b39352135d2929ee19a0a81df2441bfcaa9f6c78339c"
  end

  resource "install-tl" do
    url "https://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2021/install-tl-unx.tar.gz"
    sha256 "74eac0855e1e40c8db4f28b24ef354bd7263c1f76031bdc02b52156b572b7a1d"
  end

  resource "texlive-texmf" do
    url "https://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2021/texlive-20210325-texmf.tar.xz"
    sha256 "ff12d436c23e99fb30aad55924266104356847eb0238c193e839c150d9670f1c"
  end

  def install
    # Install resources
    resource("texlive-extra").stage do
      (libexec/"share").install "tlpkg"
    end

    resource("install-tl").stage do
      cd "tlpkg" do
        (libexec/"share/tlpkg").install "installer"
      end
    end

    resource("texlive-texmf").stage do
      (libexec/"share").install "texmf-dist"
    end

    # Clean unused files
    rm_rf libexec/"share/texmf-dist/doc"
    rm_rf libexec/"share/tlpkg/installer/wget"
    rm_rf libexec/"share/tlpkg/installer/xz"

    args = [
      "--prefix=#{libexec}",
      "--disable-debug",
      "--disable-dependency-tracking",
      "--disable-dvisvgm", # needs its own formula
      "--disable-missing",
      "--disable-native-texlive-build", # needed when doing a distro build
      "--disable-ps2eps", # provided by ps2eps formula
      "--disable-psutils", # provided by psutils formula
      "--disable-static",
      "--disable-t1utils", # provided by t1utils formula
      "--enable-build-in-source-tree",
      "--enable-shared",
      "--enable-compiler-warnings=yes",
      "--with-banner-add=/#{tap.user}",
      "--with-system-clisp-runtime=system",
      "--with-system-cairo",
      "--with-system-freetype2",
      "--with-system-gd",
      "--with-system-gmp",
      "--with-system-graphite2",
      "--with-system-harfbuzz",
      "--with-system-icu",
      "--with-system-libpng",
      "--with-system-mpfr",
      "--with-system-ncurses",
      "--with-system-pixman",
      "--with-system-potrace",
      "--with-system-zlib",
    ]

    args << if OS.mac?
      "--without-x"
    else
      # Make sure xdvi uses xaw, even if motif is available
      "--with-xdvi-x-toolkit=xaw"
    end

    system "./configure", *args
    system "make"
    system "make", "install"
    system "make", "texlinks"

    # Create tlmgr config file.  This file limits the actions that the user
    # can perform in 'system' mode, which would write to the cellar.  'tlmgr' should
    # be used with --usermode whenever possible.
    (libexec/"share/texmf-config/tlmgr/config").write <<~EOS
      allowed-actions=candidates,check,dump-tlpdb,help,info,list,print-platform,print-platform-info,search,show,version,init-usertree
    EOS

    # Create and link some directories into prefix and share.  Both links are needed
    # because some scripts expect the directories to be in TEXMFROOT, and
    # others in TEXMFROOT/share.
    mkdir libexec/"share/texmf-var/tex/generic/config"
    texdirs = %w[texmf-config texmf-dist texmf-var tlpkg]
    texdirs.each do |texdir|
      prefix.install_symlink libexec/"share"/texdir
      share.install_symlink libexec/"share"/texdir
    end

    # Delete some binaries that are provided by existing formulae as newer versions.
    rm libexec/"bin/latexindent" # provided by latexindent formula
    rm libexec/"bin/latexdiff" # provided by latexdiff formula
    rm libexec/"bin/latexdiff-vc" # provided by latexdiff formula
    rm libexec/"bin/latexrevise" # provided by latexdiff formula

    # Link everything from libexec into prefix
    bin.install_symlink Dir[libexec/"bin/*"]
    include.install_symlink Dir[libexec/"include/*"]

    lib.install_symlink Dir[libexec/"lib"/shared_library("*")]
    (lib/"pkgconfig").install_symlink Dir[libexec/"lib/pkgconfig/*"]

    (share/"info").install_symlink Dir[libexec/"share/info/*"]
    (share/"man/man1").install_symlink Dir[libexec/"share/man/man1/*"]
    (share/"man/man5").install_symlink Dir[libexec/"share/man/man5/*"]

    # Initialize texlive environment
    ENV.prepend_path "PATH", bin
    system "mktexlsr"
    system "fmtutil-sys", "--all"
    system "mtxrun", "--generate"
  end

  test do
    assert_match "Usage", shell_output("#{bin}/tex --help")
    assert_match "revision", shell_output("#{bin}/tlmgr --version")
    assert_match "AMS mathematical facilities for LaTeX", shell_output("#{bin}/tlmgr info amsmath")
  end
end
