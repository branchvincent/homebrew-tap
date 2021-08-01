class Kubectx < Formula
  desc "Tool that can switch between kubectl contexts easily and create aliases"
  homepage "https://github.com/ahmetb/kubectx"
  url "https://github.com/ahmetb/kubectx/archive/v0.9.4.tar.gz"
  sha256 "91e6b2e0501bc581f006322d621adad928ea3bd3d8df6612334804b93efd258c"
  license "Apache-2.0"
  head "https://github.com/ahmetb/kubectx.git"

  bottle do
    root_url "https://github.com/branchvincent/homebrew-tap/releases/download/kubectx-0.9.4"
    sha256 cellar: :any_skip_relocation, catalina: "ba31793fe049a729da399d7e0114b74f72dbcb8309a39c4db853da17dd8a3de6"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-o", bin/"kubectx", "./cmd/kubectx"
    system "go", "build", *std_go_args, "-o", bin/"kubens", "./cmd/kubens"

    bash_completion.install "completion/kubectx.bash" => "kubectx"
    bash_completion.install "completion/kubens.bash" => "kubens"
    zsh_completion.install "completion/kubectx.zsh" => "_kubectx"
    zsh_completion.install "completion/kubens.zsh" => "_kubens"
    fish_completion.install "completion/kubectx.fish"
    fish_completion.install "completion/kubens.fish"
  end

  test do
    assert_match "USAGE:", shell_output(bin/"kubectx -h 2>&1")
    assert_match "USAGE:", shell_output(bin/"kubens -h 2>&1")
  end
end
