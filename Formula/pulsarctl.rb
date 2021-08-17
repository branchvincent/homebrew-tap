class Pulsarctl < Formula
  desc "CLI for Apache Pulsar written in Go"
  homepage "https://streamnative.io/"
  url "https://github.com/streamnative/pulsarctl.git",
    tag:      "v2.9.0-rc-202108131436",
    revision: "1d6cc581e4b4e335122c98c63a08795022bbc25a"
  license "Apache-2.0"
  head "https://github.com/streamnative/pulsarctl.git"

  depends_on "go" => :build

  # Update github.com/spf13/cobra for fish completions
  patch :DATA

  def install
    system "make", "pulsarctl"
    bin.install "bin/pulsarctl"

    # Install shell completions
    (bash_completion/"pulsarctl").write Utils.safe_popen_read(bin/"pulsarctl", "completion", "bash")
    (fish_completion/"pulsarctl.fish").write Utils.safe_popen_read(bin/"pulsarctl", "completion", "fish")
    (zsh_completion/"_pulsarctl").write Utils.safe_popen_read(bin/"pulsarctl", "completion", "zsh")
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
