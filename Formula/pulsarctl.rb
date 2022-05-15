class Pulsarctl < Formula
  desc "CLI for Apache Pulsar written in Go"
  homepage "https://streamnative.io/"
  url "https://github.com/streamnative/pulsarctl.git",
    tag:      "v2.10.0.3",
    revision: "d10256065b39674017899d956f442b1952bbee07"
  license "Apache-2.0"
  head "https://github.com/streamnative/pulsarctl.git", branch: "master"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://github.com/branchvincent/homebrew-tap/releases/download/pulsarctl-2.10.0.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "89b8173603d73ca952b18afdf398a149cfb7f8e5a122fcaac35b23af7b691c4f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d8bcd4288b642d394794437d355882898234a30083640286bbba22f2244c9e44"
  end

  depends_on "go" => :build

  # Remove custom completion command
  patch :DATA

  def install
    # HACK: Update github.com/spf13/cobra for fish completions
    system "go get -u github.com/spf13/cobra@v1.3.0 && go mod tidy"

    ldflags = %W[
      -s -w
      -X github.com/streamnative/pulsarctl/pkg/cmdutils.ReleaseVersion=v#{version}
      -X github.com/streamnative/pulsarctl/pkg/cmdutils.BuildTS=#{time.iso8601}
      -X github.com/streamnative/pulsarctl/pkg/cmdutils.GitHash=#{Utils.git_head}
      -X github.com/streamnative/pulsarctl/pkg/cmdutils.GitBranch=master
      -X github.com/streamnative/pulsarctl/pkg/cmdutils.GoVersion=go#{Formula["go"].version}
    ]
    system "go", "build", *std_go_args(ldflags: ldflags)

    # Install shell completions
    (bash_completion/"pulsarctl").write Utils.safe_popen_read(bin/"pulsarctl", "completion", "bash")
    (fish_completion/"pulsarctl.fish").write Utils.safe_popen_read(bin/"pulsarctl", "completion", "fish")
    (zsh_completion/"_pulsarctl").write Utils.safe_popen_read(bin/"pulsarctl", "completion", "zsh")
  end

  test do
    assert_match version.to_s, shell_output(bin/"pulsarctl --version")
    assert_match "a CLI for Apache Pulsar", shell_output(bin/"pulsarctl 2>&1")
  end
end
__END__
diff --git a/pkg/pulsarctl.go b/pkg/pulsarctl.go
index bef3c97..38acd2a 100644
--- a/pkg/pulsarctl.go
+++ b/pkg/pulsarctl.go
@@ -23,7 +23,6 @@ import (
 	"github.com/streamnative/pulsarctl/pkg/ctl/brokers"
 	"github.com/streamnative/pulsarctl/pkg/ctl/brokerstats"
 	"github.com/streamnative/pulsarctl/pkg/ctl/cluster"
-	"github.com/streamnative/pulsarctl/pkg/ctl/completion"
 	"github.com/streamnative/pulsarctl/pkg/ctl/context"
 	"github.com/streamnative/pulsarctl/pkg/ctl/functionsworker"
 	"github.com/streamnative/pulsarctl/pkg/ctl/namespace"
@@ -114,7 +113,6 @@ func NewPulsarctlCmd() *cobra.Command {

 	rootCmd.AddCommand(cluster.Command(flagGrouping))
 	rootCmd.AddCommand(tenant.Command(flagGrouping))
-	rootCmd.AddCommand(completion.Command(rootCmd))
 	rootCmd.AddCommand(function.Command(flagGrouping))
 	rootCmd.AddCommand(source.Command(flagGrouping))
 	rootCmd.AddCommand(sink.Command(flagGrouping))
