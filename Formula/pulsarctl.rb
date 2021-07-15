class Pulsarctl < Formula
  desc "CLI for Apache Pulsar written in Go"
  homepage "https://streamnative.io/"
  url "https://github.com/streamnative/pulsarctl.git",
    tag:      "v2.9.0-rc-202107030819",
    revision: "1830f24c845f1a4a2298acf114a32e922fc3e374"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/branchvincent/homebrew-tap/releases/download/pulsarctl-202107030819"
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina: "228ef439cc97abbccf9b2a24fd1375a1e13b4ebb2f9b6f043f1352a7aa71f4a3"
  end

  head do
    url "https://github.com/streamnative/pulsarctl.git"
  end

  depends_on "go" => :build

  # Update github.com/spf13/cobra for fish completions
  patch :DATA

  def install
    system "make", "pulsarctl"
    bin.install "bin/pulsarctl"

    # Install shell completions
    (bash_completion/"pulsarctl").write Utils.safe_popen_read("#{bin}/pulsarctl", "completion", "bash")
    (fish_completion/"pulsarctl.fish").write Utils.safe_popen_read("#{bin}/pulsarctl", "completion", "fish")
    (zsh_completion/"_pulsarctl").write Utils.safe_popen_read("#{bin}/pulsarctl", "completion", "zsh")
  end

  test do
    out = shell_output("#{bin}/pulsarctl 2>&1")
    assert_match "a CLI for Apache Pulsar", out
  end
end
__END__
diff --git a/Makefile b/Makefile
index b735079..0925600 100644
--- a/Makefile
+++ b/Makefile
@@ -27,4 +27,6 @@ cli: cleancli
 	mv ${PWD}/site/gen-pulsarctldocs/generators/pulsarctl-site-${VERSION}.tar.gz ${PWD}/pulsarctl-site-${VERSION}.tar.gz
 
 pulsarctl: 
+	$(GO) get -u github.com/spf13/cobra@v1.2.1
+	$(GO) mod tidy
 	$(GOBUILD) -ldflags '$(LDFLAGS)' -o bin/pulsarctl
\ No newline at end of file
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
