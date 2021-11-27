class Kubectx < Formula
  desc "Tool that can switch between kubectl contexts easily and create aliases"
  homepage "https://github.com/ahmetb/kubectx"
  url "https://github.com/ahmetb/kubectx/archive/v0.9.4.tar.gz"
  sha256 "91e6b2e0501bc581f006322d621adad928ea3bd3d8df6612334804b93efd258c"
  license "Apache-2.0"
  head "https://github.com/ahmetb/kubectx.git", branch: "master"

  bottle do
    root_url "https://github.com/branchvincent/homebrew-tap/releases/download/kubectx-0.9.4"
    rebuild 1
    sha256 cellar: :any_skip_relocation, big_sur:      "34f6653176491b5d44935aabb89f42d4369daa0dbadfe338cd1176d320430d81"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a2e1e506a4edc64cfb270482b3425d74a460d7a64e8198cc4968ab8b620f0231"
  end

  depends_on "go" => :build
  depends_on "kubernetes-cli" => :test

  def install
    %w[kubectx kubens].each do |cmd|
      system "go", "build", *std_go_args(ldflags: "-s -w"), "-o", bin/cmd, "./cmd/#{cmd}"
      bash_completion.install "completion/#{cmd}.bash" => cmd.to_s
      zsh_completion.install "completion/#{cmd}.zsh" => "_#{cmd}"
      fish_completion.install "completion/#{cmd}.fish"
    end
  end

  test do
    system "kubectl", "config", "set-context", "my-context", "--namespace=my-namespace"
    system "kubectl", "config", "use-context", "my-context"
    assert_match "my-context", shell_output(bin/"kubectx --current")
    assert_match "my-namespace", shell_output(bin/"kubens --current")
  end
end
