class Pulsarctl < Formula
  desc "CLI for Apache Pulsar written in Go"
  homepage "https://streamnative.io/"
  url "https://github.com/streamnative/pulsarctl.git",
    tag:      "v2.9.0-rc-202107030819",
    revision: "1830f24c845f1a4a2298acf114a32e922fc3e374"
  license "Apache-2.0"

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
diff --git a/go.mod b/go.mod
index b1486d7..d4598d7 100644
--- a/go.mod
+++ b/go.mod
@@ -5,26 +5,30 @@ go 1.13
 require (
 	github.com/99designs/keyring v1.1.6
 	github.com/apache/pulsar-client-go/oauth2 v0.0.0-20210220083636-af91e9ca0ee2
+	github.com/armon/consul-api v0.0.0-20180202201655-eb2c6b5be1b6 // indirect
+	github.com/coreos/etcd v3.3.10+incompatible // indirect
+	github.com/coreos/go-etcd v2.0.0+incompatible // indirect
+	github.com/cpuguy83/go-md2man v1.0.10 // indirect
 	github.com/dgrijalva/jwt-go v3.2.0+incompatible
 	github.com/docker/go-connections v0.4.0
 	github.com/fatih/color v1.7.0
 	github.com/ghodss/yaml v1.0.0
-	github.com/golang/protobuf v1.4.3
+	github.com/golang/protobuf v1.5.2
 	github.com/imdario/mergo v0.3.8
 	github.com/kris-nova/logger v0.0.0-20181127235838-fd0d87064b06
 	github.com/kris-nova/lolgopher v0.0.0-20180921204813-313b3abb0d9b
-	github.com/magiconair/properties v1.8.0
+	github.com/magiconair/properties v1.8.5
 	github.com/mattn/go-colorable v0.1.2 // indirect
 	github.com/mattn/go-runewidth v0.0.4 // indirect
 	github.com/olekukonko/tablewriter v0.0.1
 	github.com/pkg/errors v0.9.1
-	github.com/spf13/cobra v0.0.5
+	github.com/spf13/cobra v1.2.1
 	github.com/spf13/pflag v1.0.5
-	github.com/stretchr/testify v1.4.0
+	github.com/stretchr/testify v1.7.0
 	github.com/testcontainers/testcontainers-go v0.0.10
-	golang.org/x/net v0.0.0-20210220033124-5f55cee0dc0d // indirect
-	golang.org/x/oauth2 v0.0.0-20210220000619-9bb904979d93
+	github.com/ugorji/go/codec v0.0.0-20181204163529-d75b2dcb6bc8 // indirect
+	github.com/xordataexchange/crypt v0.0.3-0.20170626215501-b2862e3d0a77 // indirect
+	golang.org/x/oauth2 v0.0.0-20210402161424-2e8d93401602
 	google.golang.org/appengine v1.6.7 // indirect
-	google.golang.org/protobuf v1.25.0 // indirect
-	gopkg.in/yaml.v2 v2.3.0
+	gopkg.in/yaml.v2 v2.4.0
 )
diff --git a/go.sum b/go.sum
index f3e50ca..60aa383 100644
--- a/go.sum
+++ b/go.sum
@@ -13,6 +13,11 @@ cloud.google.com/go v0.56.0/go.mod h1:jr7tqZxxKOVYizybht9+26Z/gUq7tiRzu+ACVAMbKV
 cloud.google.com/go v0.57.0/go.mod h1:oXiQ6Rzq3RAkkY7N6t3TcE6jE+CIBBbA36lwQ1JyzZs=
 cloud.google.com/go v0.62.0/go.mod h1:jmCYTdRCQuc1PHIIJ/maLInMho30T/Y0M4hTdTShOYc=
 cloud.google.com/go v0.65.0/go.mod h1:O5N8zS7uWy9vkA9vayVHs65eM1ubvY4h553ofrNHObY=
+cloud.google.com/go v0.72.0/go.mod h1:M+5Vjvlc2wnp6tjzE102Dw08nGShTscUx2nZMufOKPI=
+cloud.google.com/go v0.74.0/go.mod h1:VV1xSbzvo+9QJOxLDaJfTjx5e+MePCpCWwvftOeQmWk=
+cloud.google.com/go v0.78.0/go.mod h1:QjdrLG0uq+YwhjoVOLsS1t7TW8fs36kLs4XO5R5ECHg=
+cloud.google.com/go v0.79.0/go.mod h1:3bzgcEeQlzbuEAYu4mrWhKqWjmpprinYgKJLgKHnbb8=
+cloud.google.com/go v0.81.0/go.mod h1:mk/AM35KwGk/Nm2YSeZbxXdrNK3KZOYHmLkOqC2V6E0=
 cloud.google.com/go/bigquery v1.0.1/go.mod h1:i/xbL2UlR5RvWAURpBYZTtm/cXjCha9lbfbpx4poX+o=
 cloud.google.com/go/bigquery v1.3.0/go.mod h1:PjpwJnslEMmckchkHFfq+HTD2DmtT67aNFKH1/VBDHE=
 cloud.google.com/go/bigquery v1.4.0/go.mod h1:S8dzgnTigyfTmLBfrtrhyYhwRxG72rYxvftPBK2Dvzc=
@@ -21,6 +26,7 @@ cloud.google.com/go/bigquery v1.7.0/go.mod h1://okPTzCYNXSlb24MZs83e2Do+h+VXtc4g
 cloud.google.com/go/bigquery v1.8.0/go.mod h1:J5hqkt3O0uAFnINi6JXValWIb1v0goeZM77hZzJN/fQ=
 cloud.google.com/go/datastore v1.0.0/go.mod h1:LXYbyblFSglQ5pkeyhO+Qmw7ukd3C+pD7TKLgZqpHYE=
 cloud.google.com/go/datastore v1.1.0/go.mod h1:umbIZjpQpHh4hmRpGhH4tLFup+FVzqBi1b3c64qFpCk=
+cloud.google.com/go/firestore v1.1.0/go.mod h1:ulACoGHTpvq5r8rxGJ4ddJZBZqakUQqClKRT5SZwBmk=
 cloud.google.com/go/pubsub v1.0.1/go.mod h1:R0Gpsv3s54REJCy4fxDixWD93lHJMoZTyQ2kNxGRt3I=
 cloud.google.com/go/pubsub v1.1.0/go.mod h1:EwwdRX2sKPjnvnqCa270oGRyludottCI76h+R3AArQw=
 cloud.google.com/go/pubsub v1.2.0/go.mod h1:jhfEVHT8odbXTkndysNHCcx0awwzvfOlguIAii9o8iA=
@@ -47,6 +53,7 @@ github.com/alecthomas/template v0.0.0-20160405071501-a0175ee3bccc/go.mod h1:LOuy
 github.com/alecthomas/template v0.0.0-20190718012654-fb15b899a751/go.mod h1:LOuyumcjzFXgccqObfd/Ljyb9UuFJ6TxHnclSeseNhc=
 github.com/alecthomas/units v0.0.0-20151022065526-2efee857e7cf/go.mod h1:ybxpYRFXyAe+OPACYpWeL0wqObRcbAqCMya13uyzqw0=
 github.com/alecthomas/units v0.0.0-20190717042225-c3de453c63f4/go.mod h1:ybxpYRFXyAe+OPACYpWeL0wqObRcbAqCMya13uyzqw0=
+github.com/antihax/optional v1.0.0/go.mod h1:uupD/76wgC+ih3iEmQUL+0Ugr19nfwCT1kdvxnR2qWY=
 github.com/apache/pulsar-client-go v0.3.0 h1:rNhJ/ENwoEfZPHHwUHNxPBTNqNQE2LQEm7DXu043giM=
 github.com/apache/pulsar-client-go/oauth2 v0.0.0-20200715083626-b9f8c5cedefb h1:E1P0FudxDdj2RhbveZC9i3PwukLCA/4XQSkBS/dw6/I=
 github.com/apache/pulsar-client-go/oauth2 v0.0.0-20200715083626-b9f8c5cedefb/go.mod h1:0UtvvETGDdvXNDCHa8ZQpxl+w3HbdFtfYZvDHLgWGTY=
@@ -56,11 +63,16 @@ github.com/apache/pulsar-client-go/oauth2 v0.0.0-20210220083636-af91e9ca0ee2 h1:
 github.com/apache/pulsar-client-go/oauth2 v0.0.0-20210220083636-af91e9ca0ee2/go.mod h1:gnyVPrpIp2XhG07THJh3ce3693JLtTRZ/TzgyZcF+ns=
 github.com/ardielle/ardielle-go v1.5.2/go.mod h1:I4hy1n795cUhaVt/ojz83SNVCYIGsAFAONtv2Dr7HUI=
 github.com/ardielle/ardielle-tools v1.5.4/go.mod h1:oZN+JRMnqGiIhrzkRN9l26Cej9dEx4jeNG6A+AdkShk=
+github.com/armon/circbuf v0.0.0-20150827004946-bbbad097214e/go.mod h1:3U/XgcO3hCbHZ8TKRvWD2dDTCfh9M9ya+I9JpbB7O8o=
 github.com/armon/consul-api v0.0.0-20180202201655-eb2c6b5be1b6/go.mod h1:grANhF5doyWs3UAsr3K4I6qtAmlQcZDesFNEHPZAzj8=
+github.com/armon/go-metrics v0.0.0-20180917152333-f0300d1749da/go.mod h1:Q73ZrmVTwzkszR9V5SSuryQ31EELlFMUz1kKyl939pY=
+github.com/armon/go-radix v0.0.0-20180808171621-7fddfc383310/go.mod h1:ufUuZ+zHj4x4TnLV4JWEpy2hxWSpsRywHrMgIH9cCH8=
 github.com/beefsack/go-rate v0.0.0-20180408011153-efa7637bb9b6/go.mod h1:6YNgTHLutezwnBvyneBbwvB8C82y3dcoOj5EQJIdGXA=
 github.com/beorn7/perks v0.0.0-20180321164747-3a771d992973/go.mod h1:Dwedo/Wpr24TaqPxmxbtue+5NUziq4I4S80YR8gNf3Q=
 github.com/beorn7/perks v1.0.0/go.mod h1:KWe93zE9D1o94FZ5RNwFwVgaQK1VOXiVxmqh+CedLV8=
 github.com/beorn7/perks v1.0.1/go.mod h1:G2ZrVWU2WbWT9wwq4/hrbKbnv/1ERSJQ0ibhJ6rlkpw=
+github.com/bgentry/speakeasy v0.1.0/go.mod h1:+zsyZBPWlz7T6j88CTgSN5bM796AkVf0kBD4zp0CCIs=
+github.com/bketelsen/crypt v0.0.4/go.mod h1:aI6NrJ0pMGgvZKL1iVgXLnfIFJtfV+bKCoqOes/6LfM=
 github.com/bmizerany/perks v0.0.0-20141205001514-d9a9656a3a4b/go.mod h1:ac9efd0D1fsDb3EJvhqgXRbFx7bs2wqZ10HQPeU8U/Q=
 github.com/boynton/repl v0.0.0-20170116235056-348863958e3e/go.mod h1:Crc/GCZ3NXDVCio7Yr0o+SSrytpcFhLmVCIzi0s49t4=
 github.com/cenkalti/backoff v2.2.1+incompatible h1:tNowT99t7UNflLxfYYSlKYsBpXdEet03Pg2g16Swow4=
@@ -72,12 +84,17 @@ github.com/chzyer/readline v0.0.0-20180603132655-2972be24d48e/go.mod h1:nSuG5e5P
 github.com/chzyer/test v0.0.0-20180213035817-a1ea475d72b1/go.mod h1:Q3SI9o4m/ZMnBNeIyt5eFwwo7qiLfzFZmjNmxjkiQlU=
 github.com/client9/misspell v0.3.4/go.mod h1:qj6jICC3Q7zFZvVWo7KLAzC3yx5G7kyvSDkc90ppPyw=
 github.com/cncf/udpa/go v0.0.0-20191209042840-269d4d468f6f/go.mod h1:M8M6+tZqaGXZJjfX53e64911xZQV5JYwmTeXPW+k8Sc=
+github.com/cncf/udpa/go v0.0.0-20200629203442-efcf912fb354/go.mod h1:WmhPx2Nbnhtbo57+VJT5O0JRkEi1Wbu0z5j0R8u5Hbk=
+github.com/cncf/udpa/go v0.0.0-20201120205902-5459f2c99403/go.mod h1:WmhPx2Nbnhtbo57+VJT5O0JRkEi1Wbu0z5j0R8u5Hbk=
 github.com/containerd/continuity v0.0.0-20190426062206-aaeac12a7ffc h1:TP+534wVlf61smEIq1nwLLAjQVEK2EADoW3CX9AuT+8=
 github.com/containerd/continuity v0.0.0-20190426062206-aaeac12a7ffc/go.mod h1:GL3xCUCBDV3CZiTSEKksMWbLE66hEyuu9qyDOOqM47Y=
 github.com/coreos/etcd v3.3.10+incompatible/go.mod h1:uF7uidLiAD3TWHmW31ZFd/JWoc32PjwdhPthX9715RE=
 github.com/coreos/go-etcd v2.0.0+incompatible/go.mod h1:Jez6KQU2B/sWsbdaef3ED8NzMklzPG4d5KIOhIy30Tk=
 github.com/coreos/go-semver v0.2.0/go.mod h1:nnelYz7RCh+5ahJtPPxZlU+153eP4D4r3EedlOD2RNk=
+github.com/coreos/go-semver v0.3.0/go.mod h1:nnelYz7RCh+5ahJtPPxZlU+153eP4D4r3EedlOD2RNk=
+github.com/coreos/go-systemd/v22 v22.3.2/go.mod h1:Y58oyj3AT4RCenI/lSvhwexgC+NSVTIJ3seZv2GcEnc=
 github.com/cpuguy83/go-md2man v1.0.10/go.mod h1:SmD6nW6nTyfqj6ABTjUi3V3JVMnlJmwcJI5acqYI6dE=
+github.com/cpuguy83/go-md2man/v2 v2.0.0/go.mod h1:maD7wRr/U5Z6m/iR4s+kqSMx2CaBsrgA7czyZG/E6dU=
 github.com/danieljoos/wincred v1.0.2 h1:zf4bhty2iLuwgjgpraD2E9UbvO+fe54XXGJbOwe23fU=
 github.com/danieljoos/wincred v1.0.2/go.mod h1:SnuYRW9lp1oJrZX/dXJqr0cPK5gYXqx3EJbmjhLdK9U=
 github.com/datadog/zstd v1.4.6-0.20200617134701-89f69fb7df32/go.mod h1:inRp+etsHuvVqMPNTXaFlpf/Tj7wqviBtdJoPVrPEFQ=
@@ -102,6 +119,9 @@ github.com/dvsekhvalnov/jose2go v0.0.0-20200901110807-248326c1351b/go.mod h1:7Bv
 github.com/envoyproxy/go-control-plane v0.9.0/go.mod h1:YTl/9mNaCwkRvm6d1a2C3ymFceY/DCBVvsKhRF0iEA4=
 github.com/envoyproxy/go-control-plane v0.9.1-0.20191026205805-5f8ba28d4473/go.mod h1:YTl/9mNaCwkRvm6d1a2C3ymFceY/DCBVvsKhRF0iEA4=
 github.com/envoyproxy/go-control-plane v0.9.4/go.mod h1:6rpuAdCZL397s3pYoYcLgu1mIlRU8Am5FuJP05cCM98=
+github.com/envoyproxy/go-control-plane v0.9.7/go.mod h1:cwu0lG7PUMfa9snN8LXBig5ynNVH9qI8YYLbd1fK2po=
+github.com/envoyproxy/go-control-plane v0.9.9-0.20201210154907-fd9021fe5dad/go.mod h1:cXg6YxExXjJnVBQHBLXeUAgxn2UodCpnH306RInaBQk=
+github.com/envoyproxy/go-control-plane v0.9.9-0.20210217033140-668b12f5399d/go.mod h1:cXg6YxExXjJnVBQHBLXeUAgxn2UodCpnH306RInaBQk=
 github.com/envoyproxy/protoc-gen-validate v0.1.0/go.mod h1:iSmxcyjqTsJpI2R4NaDN7+kN2VEUnK/pcBlmesArF7c=
 github.com/fatih/color v1.7.0 h1:DkWD4oS2D8LGGgTQ6IvwJJXSL5Vp2ffcQg58nFV38Ys=
 github.com/fatih/color v1.7.0/go.mod h1:Zm6kSWBoL9eyXnKyktHP6abPY2pDugNf5KwzbycvMj4=
@@ -124,6 +144,7 @@ github.com/go-sql-driver/mysql v1.4.1/go.mod h1:zAC/RDZ24gD3HViQzih4MyKcchzm+sOG
 github.com/go-stack/stack v1.8.0/go.mod h1:v0f6uXyyMGvRgIKkXu+yp6POWl0qKG85gN/melR3HDY=
 github.com/godbus/dbus v0.0.0-20190726142602-4481cbc300e2 h1:ZpnhV/YsD2/4cESfV5+Hoeu/iUR3ruzNvZ+yQfO03a0=
 github.com/godbus/dbus v0.0.0-20190726142602-4481cbc300e2/go.mod h1:bBOAhwG1umN6/6ZUMtDFBMQR8jRg9O75tm9K00oMsK4=
+github.com/godbus/dbus/v5 v5.0.4/go.mod h1:xhWf0FNVPg57R7Z0UbKHbJfkEywrmjJnf7w5xrFpKfA=
 github.com/gogo/protobuf v1.1.1/go.mod h1:r8qH/GZQm5c6nD/R0oafs1akxWv10x8SbQlK7atdtwQ=
 github.com/gogo/protobuf v1.2.0 h1:xU6/SpYbvkNYiptHJYEDRseDLvYE7wSqhYYNy0QSUzI=
 github.com/gogo/protobuf v1.2.0/go.mod h1:r8qH/GZQm5c6nD/R0oafs1akxWv10x8SbQlK7atdtwQ=
@@ -140,6 +161,7 @@ github.com/golang/mock v1.4.0/go.mod h1:UOMv5ysSaYNkG+OFQykRIcU/QvvxJf3p21QfJ2Bt
 github.com/golang/mock v1.4.1/go.mod h1:UOMv5ysSaYNkG+OFQykRIcU/QvvxJf3p21QfJ2Bt3cw=
 github.com/golang/mock v1.4.3/go.mod h1:UOMv5ysSaYNkG+OFQykRIcU/QvvxJf3p21QfJ2Bt3cw=
 github.com/golang/mock v1.4.4/go.mod h1:l3mdAwkq5BuhzHwde/uurv3sEJeZMXNpwsxVWU71h+4=
+github.com/golang/mock v1.5.0/go.mod h1:CWnOUgYIOo4TcNZ0wHX3YZCqsaM1I1Jvs6v3mP3KVu8=
 github.com/golang/protobuf v1.2.0/go.mod h1:6lQm79b+lXiMfvg/cZm0SGofjICqVBUtrP5yJMmIC1U=
 github.com/golang/protobuf v1.3.1/go.mod h1:6lQm79b+lXiMfvg/cZm0SGofjICqVBUtrP5yJMmIC1U=
 github.com/golang/protobuf v1.3.2 h1:6nsPYzhq5kReh6QImI3k5qWzO4PEbvbIW2cwSfR/6xs=
@@ -157,6 +179,10 @@ github.com/golang/protobuf v1.4.2 h1:+Z5KGCizgyZCbGh1KZqA0fcLLkwbsjIzS4aV2v7wJX0
 github.com/golang/protobuf v1.4.2/go.mod h1:oDoupMAO8OvCJWAcko0GGGIgR6R6ocIYbsSw735rRwI=
 github.com/golang/protobuf v1.4.3 h1:JjCZWpVbqXDqFVmTfYWEVTMIYrL/NPdPSCHPJ0T/raM=
 github.com/golang/protobuf v1.4.3/go.mod h1:oDoupMAO8OvCJWAcko0GGGIgR6R6ocIYbsSw735rRwI=
+github.com/golang/protobuf v1.5.0/go.mod h1:FsONVRAS9T7sI+LIUmWTfcYkHO4aIWwzhcaSAoJOfIk=
+github.com/golang/protobuf v1.5.1/go.mod h1:DopwsBzvsk0Fs44TXzsVbJyPhcCPeIwnvohx4u74HPM=
+github.com/golang/protobuf v1.5.2 h1:ROPKBNFfQgOUMifHyP+KYbvpjbdoFNs+aK7DXlji0Tw=
+github.com/golang/protobuf v1.5.2/go.mod h1:XVQd3VNwM+JqD3oG2Ue2ip4fOMUkwXdXDdiuN0vRsmY=
 github.com/golang/snappy v0.0.1/go.mod h1:/XxbfmMg8lxefKM7IXC3fBNl/7bRcc72aCRzEWrmP2Q=
 github.com/google/btree v0.0.0-20180813153112-4030bb1f1f0c/go.mod h1:lNA+9X1NB3Zf8V7Ke586lFgjr2dZNuvo3lPJSGZ5JPQ=
 github.com/google/btree v1.0.0/go.mod h1:lNA+9X1NB3Zf8V7Ke586lFgjr2dZNuvo3lPJSGZ5JPQ=
@@ -168,9 +194,14 @@ github.com/google/go-cmp v0.4.1/go.mod h1:v8dTdLbMG2kIc/vJvl+f65V22dbkXbowE6jgT/
 github.com/google/go-cmp v0.5.0 h1:/QaMHBdZ26BB3SSst0Iwl10Epc+xhTquomWX0oZEB6w=
 github.com/google/go-cmp v0.5.0/go.mod h1:v8dTdLbMG2kIc/vJvl+f65V22dbkXbowE6jgT/gNBxE=
 github.com/google/go-cmp v0.5.1/go.mod h1:v8dTdLbMG2kIc/vJvl+f65V22dbkXbowE6jgT/gNBxE=
+github.com/google/go-cmp v0.5.2/go.mod h1:v8dTdLbMG2kIc/vJvl+f65V22dbkXbowE6jgT/gNBxE=
+github.com/google/go-cmp v0.5.3/go.mod h1:v8dTdLbMG2kIc/vJvl+f65V22dbkXbowE6jgT/gNBxE=
+github.com/google/go-cmp v0.5.4/go.mod h1:v8dTdLbMG2kIc/vJvl+f65V22dbkXbowE6jgT/gNBxE=
+github.com/google/go-cmp v0.5.5/go.mod h1:v8dTdLbMG2kIc/vJvl+f65V22dbkXbowE6jgT/gNBxE=
 github.com/google/gofuzz v1.0.0/go.mod h1:dBl0BpW6vV/+mYPU4Po3pmUjxk6FQPldtuIdl/M65Eg=
 github.com/google/martian v2.1.0+incompatible/go.mod h1:9I4somxYTbIHy5NJKHRl3wXiIaQGbYVAs8BPL6v8lEs=
 github.com/google/martian/v3 v3.0.0/go.mod h1:y5Zk1BBys9G+gd6Jrk0W3cC1+ELVxBWuIGO+w/tUAp0=
+github.com/google/martian/v3 v3.1.0/go.mod h1:y5Zk1BBys9G+gd6Jrk0W3cC1+ELVxBWuIGO+w/tUAp0=
 github.com/google/pprof v0.0.0-20181206194817-3ea8567a2e57/go.mod h1:zfwlbNMJ+OItoe0UupaVj+oy1omPYYDuagoSzA8v9mc=
 github.com/google/pprof v0.0.0-20190515194954-54271f7e092f/go.mod h1:zfwlbNMJ+OItoe0UupaVj+oy1omPYYDuagoSzA8v9mc=
 github.com/google/pprof v0.0.0-20191218002539-d4f498aebedc/go.mod h1:ZgVRPoUq/hfqzAqh7sHMqb3I9Rq5C59dIz2SbBwJ4eM=
@@ -178,23 +209,47 @@ github.com/google/pprof v0.0.0-20200212024743-f11f1df84d12/go.mod h1:ZgVRPoUq/hf
 github.com/google/pprof v0.0.0-20200229191704-1ebb73c60ed3/go.mod h1:ZgVRPoUq/hfqzAqh7sHMqb3I9Rq5C59dIz2SbBwJ4eM=
 github.com/google/pprof v0.0.0-20200430221834-fc25d7d30c6d/go.mod h1:ZgVRPoUq/hfqzAqh7sHMqb3I9Rq5C59dIz2SbBwJ4eM=
 github.com/google/pprof v0.0.0-20200708004538-1a94d8640e99/go.mod h1:ZgVRPoUq/hfqzAqh7sHMqb3I9Rq5C59dIz2SbBwJ4eM=
+github.com/google/pprof v0.0.0-20201023163331-3e6fc7fc9c4c/go.mod h1:kpwsk12EmLew5upagYY7GY0pfYCcupk39gWOCRROcvE=
+github.com/google/pprof v0.0.0-20201203190320-1bf35d6f28c2/go.mod h1:kpwsk12EmLew5upagYY7GY0pfYCcupk39gWOCRROcvE=
+github.com/google/pprof v0.0.0-20210122040257-d980be63207e/go.mod h1:kpwsk12EmLew5upagYY7GY0pfYCcupk39gWOCRROcvE=
+github.com/google/pprof v0.0.0-20210226084205-cbba55b83ad5/go.mod h1:kpwsk12EmLew5upagYY7GY0pfYCcupk39gWOCRROcvE=
 github.com/google/renameio v0.1.0/go.mod h1:KWCgfxg9yswjAJkECMjeO8J8rahYeXnNhOm40UhjYkI=
 github.com/google/uuid v1.1.2/go.mod h1:TIyPZe4MgqvfeYDBFedMoGGpEw/LqOeaOT+nhxU+yHo=
 github.com/googleapis/gax-go/v2 v2.0.4/go.mod h1:0Wqv26UfaUD9n4G6kQubkQ+KchISgw+vpHVxEJEs9eg=
 github.com/googleapis/gax-go/v2 v2.0.5/go.mod h1:DWXyrwAJ9X0FpwwEdw+IPEYBICEFu5mhpdKc/us6bOk=
+github.com/gopherjs/gopherjs v0.0.0-20181017120253-0766667cb4d1/go.mod h1:wJfORRmW1u3UXTncJ5qlYoELFm8eSnnEO6hX4iZ3EWY=
 github.com/gorilla/context v1.1.1 h1:AWwleXJkX/nhcU9bZSnZoi3h/qGYqQAGhq6zZe/aQW8=
 github.com/gorilla/context v1.1.1/go.mod h1:kBGZzfjB9CEq2AlWe17Uuf7NDRt0dE0s8S51q0aT7Yg=
 github.com/gorilla/mux v1.6.2 h1:Pgr17XVTNXAk3q/r4CpKzC5xBM/qW1uVLV+IhRZpIIk=
 github.com/gorilla/mux v1.6.2/go.mod h1:1lud6UwP+6orDFRuTfBEV8e9/aOM/c4fVVCaMa2zaAs=
 github.com/gorilla/mux v1.7.3/go.mod h1:1lud6UwP+6orDFRuTfBEV8e9/aOM/c4fVVCaMa2zaAs=
+github.com/grpc-ecosystem/grpc-gateway v1.16.0/go.mod h1:BDjrQk3hbvj6Nolgz8mAMFbcEtjT1g+wF4CSlocrBnw=
 github.com/gsterjov/go-libsecret v0.0.0-20161001094733-a6f4afe4910c h1:6rhixN/i8ZofjG1Y75iExal34USq5p+wiN1tpie8IrU=
 github.com/gsterjov/go-libsecret v0.0.0-20161001094733-a6f4afe4910c/go.mod h1:NMPJylDgVpX0MLRlPy15sqSwOFv/U1GZ2m21JhFfek0=
+github.com/hashicorp/consul/api v1.1.0/go.mod h1:VmuI/Lkw1nC05EYQWNKwWGbkg+FbDBtguAZLlVdkD9Q=
+github.com/hashicorp/consul/sdk v0.1.1/go.mod h1:VKf9jXwCTEY1QZP2MOLRhb5i/I/ssyNV1vwHyQBF0x8=
+github.com/hashicorp/errwrap v1.0.0/go.mod h1:YH+1FKiLXxHSkmPseP+kNlulaMuP3n2brvKWEqk/Jc4=
+github.com/hashicorp/go-cleanhttp v0.5.1/go.mod h1:JpRdi6/HCYpAwUzNwuwqhbovhLtngrth3wmdIIUrZ80=
+github.com/hashicorp/go-immutable-radix v1.0.0/go.mod h1:0y9vanUI8NX6FsYoO3zeMjhV/C5i9g4Q3DwcSNZ4P60=
+github.com/hashicorp/go-msgpack v0.5.3/go.mod h1:ahLV/dePpqEmjfWmKiqvPkv/twdG7iPBM1vqhUKIvfM=
+github.com/hashicorp/go-multierror v1.0.0/go.mod h1:dHtQlpGsu+cZNNAkkCN/P3hoUDHhCYQXV3UM06sGGrk=
+github.com/hashicorp/go-rootcerts v1.0.0/go.mod h1:K6zTfqpRlCUIjkwsN4Z+hiSfzSTQa6eBIzfwKfwNnHU=
+github.com/hashicorp/go-sockaddr v1.0.0/go.mod h1:7Xibr9yA9JjQq1JpNB2Vw7kxv8xerXegt+ozgdvDeDU=
+github.com/hashicorp/go-syslog v1.0.0/go.mod h1:qPfqrKkXGihmCqbJM2mZgkZGvKG1dFdvsLplgctolz4=
+github.com/hashicorp/go-uuid v1.0.0/go.mod h1:6SBZvOh/SIDV7/2o3Jml5SYk/TvGqwFJ/bN7x4byOro=
+github.com/hashicorp/go-uuid v1.0.1/go.mod h1:6SBZvOh/SIDV7/2o3Jml5SYk/TvGqwFJ/bN7x4byOro=
+github.com/hashicorp/go.net v0.0.1/go.mod h1:hjKkEWcCURg++eb33jQU7oqQcI9XDCnUzHA0oac0k90=
 github.com/hashicorp/golang-lru v0.5.0/go.mod h1:/m3WP610KZHVQ1SGc6re/UDhFvYD7pJ4Ao+sR/qLZy8=
 github.com/hashicorp/golang-lru v0.5.1/go.mod h1:/m3WP610KZHVQ1SGc6re/UDhFvYD7pJ4Ao+sR/qLZy8=
 github.com/hashicorp/hcl v1.0.0/go.mod h1:E5yfLk+7swimpb2L/Alb/PJmXilQ/rhwaUYs4T20WEQ=
+github.com/hashicorp/logutils v1.0.0/go.mod h1:QIAnNjmIWmVIIkWDTG1z5v++HQmx9WQRO+LraFDTW64=
+github.com/hashicorp/mdns v1.0.0/go.mod h1:tL+uN++7HEJ6SQLQ2/p+z2pH24WQKWjBPkE0mNTz8vQ=
+github.com/hashicorp/memberlist v0.1.3/go.mod h1:ajVTdAv/9Im8oMAAj5G31PhhMCZJV2pPBoIllUwCN7I=
+github.com/hashicorp/serf v0.8.2/go.mod h1:6hOLApaqBFA1NXqRQAsxw9QxuDEvNxSQRwA/JwenrHc=
 github.com/hpcloud/tail v1.0.0 h1:nfCOvKYfkgYP8hkirhJocXT2+zOD8yUNjXaWfTlyFKI=
 github.com/hpcloud/tail v1.0.0/go.mod h1:ab1qPbhIpdTxEkNHXyeSf5vhxWSCs/tWer42PpOxQnU=
 github.com/ianlancetaylor/demangle v0.0.0-20181102032728-5e5cf60278f6/go.mod h1:aSSvb/t6k1mPoxDqO4vJh6VOCGPwU4O0C2/Eqndh1Sc=
+github.com/ianlancetaylor/demangle v0.0.0-20200824232613-28f6c0f3b639/go.mod h1:aSSvb/t6k1mPoxDqO4vJh6VOCGPwU4O0C2/Eqndh1Sc=
 github.com/imdario/mergo v0.3.8 h1:CGgOkSJeqMRmt0D9XLWExdT4m4F1vd3FV3VPt+0VxkQ=
 github.com/imdario/mergo v0.3.8/go.mod h1:2EnlNZ0deacrJVfApfmtdGgDfMuh/nq6Ok1EcJh5FfA=
 github.com/inconshreveable/mousetrap v1.0.0 h1:Z8tu5sraLXCXIcARxBp/8cbvlwVa7Z1NHg9XEKhtSvM=
@@ -203,8 +258,10 @@ github.com/jawher/mow.cli v1.0.4/go.mod h1:5hQj2V8g+qYmLUVWqu4Wuja1pI57M83EChYLV
 github.com/jawher/mow.cli v1.1.0/go.mod h1:aNaQlc7ozF3vw6IJ2dHjp2ZFiA4ozMIYY6PyuRJwlUg=
 github.com/json-iterator/go v1.1.6/go.mod h1:+SdeFBvtyEkXs7REEP0seUULqWtbJapLOCVDaaPEHmU=
 github.com/json-iterator/go v1.1.10/go.mod h1:KdQUCv79m/52Kvf8AW2vK1V8akMuk1QjK/uOdHXbAo4=
+github.com/json-iterator/go v1.1.11/go.mod h1:KdQUCv79m/52Kvf8AW2vK1V8akMuk1QjK/uOdHXbAo4=
 github.com/jstemmer/go-junit-report v0.0.0-20190106144839-af01ea7f8024/go.mod h1:6v2b51hI/fHJwM22ozAgKL4VKDeJcHhJFhtBdhmNjmU=
 github.com/jstemmer/go-junit-report v0.9.1/go.mod h1:Brl9GWCQeLvo8nXZwPNNblvFj/XSXhF0NWZEnDohbsk=
+github.com/jtolds/gls v4.20.0+incompatible/go.mod h1:QJZ7F/aHp+rZTRtaJ1ow/lLfFfVYBRgL+9YlvaHOwJU=
 github.com/julienschmidt/httprouter v1.2.0/go.mod h1:SYymIcj16QtmaHHD7aYtjjsJG7VTCxuUUipMqKk8s4w=
 github.com/keybase/go-keychain v0.0.0-20190712205309-48d3d31d256d h1:Z+RDyXzjKE0i2sTjZ/b1uxiGtPhFy34Ou/Tk0qwN0kM=
 github.com/keybase/go-keychain v0.0.0-20190712205309-48d3d31d256d/go.mod h1:JJNrCn9otv/2QP4D7SMJBgaleKpOf66PnW6F5WGNRIc=
@@ -213,6 +270,7 @@ github.com/kisielk/gotool v1.0.0/go.mod h1:XhKaO+MFFWcvkIS/tQcRk01m1F5IRFswLeQ+o
 github.com/klauspost/compress v1.10.8/go.mod h1:aoV0uJVorq1K+umq18yTdKaF57EivdYsUV+/s2qKfXs=
 github.com/konsorten/go-windows-terminal-sequences v1.0.1 h1:mweAR1A6xJ3oS2pRaGiHgQ4OO8tzTaLawm8vnODuwDk=
 github.com/konsorten/go-windows-terminal-sequences v1.0.1/go.mod h1:T0+1ngSBFLxvqU3pZ+m/2kptfBszLMUkC4ZK/EgS/cQ=
+github.com/kr/fs v0.1.0/go.mod h1:FFnZGqtBN9Gxj7eW1uZ42v5BccTP0vu6NEaFoC2HwRg=
 github.com/kr/logfmt v0.0.0-20140226030751-b84e30acd515/go.mod h1:+0opPa2QZZtGFBFZlji/RkVcI2GknAs/DXo4wKdlNEc=
 github.com/kr/pretty v0.1.0 h1:L/CwN0zerZDmRFUapSPitk6f+Q3+0za1rQkzVuMiMFI=
 github.com/kr/pretty v0.1.0/go.mod h1:dAy3ld7l9f0ibDNOQOHHMYYIIbhfbHSm3C4ZsoJORNo=
@@ -227,16 +285,28 @@ github.com/kris-nova/lolgopher v0.0.0-20180921204813-313b3abb0d9b/go.mod h1:V0HF
 github.com/linkedin/goavro/v2 v2.9.8/go.mod h1:UgQUb2N/pmueQYH9bfqFioWxzYCZXSfF8Jw03O5sjqA=
 github.com/magiconair/properties v1.8.0 h1:LLgXmsheXeRoUOBOjtwPQCWIYqM/LU1ayDtDePerRcY=
 github.com/magiconair/properties v1.8.0/go.mod h1:PppfXfuXeibc/6YijjN8zIbojt8czPbwD3XqdrwzmxQ=
+github.com/magiconair/properties v1.8.5 h1:b6kJs+EmPFMYGkow9GiUyCyOvIwYetYJ3fSaWak/Gls=
+github.com/magiconair/properties v1.8.5/go.mod h1:y3VJvCyxH9uVvJTWEGAELF3aiYNyPKd5NZ3oSwXrF60=
+github.com/mattn/go-colorable v0.0.9/go.mod h1:9vuHe8Xs5qXnSaW/c/ABM9alt+Vo+STaOChaDxuIBZU=
 github.com/mattn/go-colorable v0.1.2 h1:/bC9yWikZXAL9uJdulbSfyVNIR3n3trXl+v8+1sx8mU=
 github.com/mattn/go-colorable v0.1.2/go.mod h1:U0ppj6V5qS13XJ6of8GYAs25YV2eR4EVcfRqFIhoBtE=
+github.com/mattn/go-isatty v0.0.3/go.mod h1:M+lRXTBqGeGNdLjl/ufCoiOlB5xdOkqRJdNxMWT7Zi4=
 github.com/mattn/go-isatty v0.0.8 h1:HLtExJ+uU2HOZ+wI0Tt5DtUDrx8yhUqDcp7fYERX4CE=
 github.com/mattn/go-isatty v0.0.8/go.mod h1:Iq45c/XA43vh69/j3iqttzPXn0bhXyGjM0Hdxcsrc5s=
 github.com/mattn/go-runewidth v0.0.4 h1:2BvfKmzob6Bmd4YsL0zygOqfdFnK7GR4QL06Do4/p7Y=
 github.com/mattn/go-runewidth v0.0.4/go.mod h1:LwmH8dsx7+W8Uxz3IHJYH5QSwggIsqBzpuz5H//U1FU=
 github.com/matttproud/golang_protobuf_extensions v1.0.1/go.mod h1:D8He9yQNgCq6Z5Ld7szi9bcBfOoFv/3dc6xSMkL2PC0=
+github.com/miekg/dns v1.0.14/go.mod h1:W1PPwlIAgtquWBMBEV9nkV9Cazfe8ScdGz/Lj7v3Nrg=
+github.com/mitchellh/cli v1.0.0/go.mod h1:hNIlj7HEI86fIcpObd7a0FcrxTWetlwJDGcceTlRvqc=
+github.com/mitchellh/go-homedir v1.0.0/go.mod h1:SfyaCUpYCn1Vlf4IUYiD9fPX4A5wJrkLzIz1N1q0pr0=
 github.com/mitchellh/go-homedir v1.1.0 h1:lukF9ziXFxDFPkA1vsr5zpc1XuPDn/wFntq5mG+4E0Y=
 github.com/mitchellh/go-homedir v1.1.0/go.mod h1:SfyaCUpYCn1Vlf4IUYiD9fPX4A5wJrkLzIz1N1q0pr0=
+github.com/mitchellh/go-testing-interface v1.0.0/go.mod h1:kRemZodwjscx+RGhAo8eIhFbs2+BFgRtFPeD/KE+zxI=
+github.com/mitchellh/gox v0.4.0/go.mod h1:Sd9lOJ0+aimLBi73mGofS1ycjY8lL3uZM3JPS42BGNg=
+github.com/mitchellh/iochan v1.0.0/go.mod h1:JwYml1nuB7xOzsp52dPpHFffvOCDupsG0QubkSMEySY=
+github.com/mitchellh/mapstructure v0.0.0-20160808181253-ca63d7c062ee/go.mod h1:FVVH3fgwuzCH5S8UJGiWEs2h04kUh9fWfEaFds41c1Y=
 github.com/mitchellh/mapstructure v1.1.2/go.mod h1:FVVH3fgwuzCH5S8UJGiWEs2h04kUh9fWfEaFds41c1Y=
+github.com/mitchellh/mapstructure v1.4.1/go.mod h1:bFUtVrKA4DC2yAKiSyO/QUcy7e+RRV2QTWOzhPopBRo=
 github.com/modern-go/concurrent v0.0.0-20180228061459-e0a39a4cb421/go.mod h1:6dJC0mAP4ikYIbvyc7fijjWJddQyLn8Ig3JB5CqoB9Q=
 github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd/go.mod h1:6dJC0mAP4ikYIbvyc7fijjWJddQyLn8Ig3JB5CqoB9Q=
 github.com/modern-go/reflect2 v0.0.0-20180701023420-4b7aa43c6742/go.mod h1:bx2lNnkwVCuqBIxFjflWJWanXIb3RllmbCylyMrvgv0=
@@ -265,15 +335,19 @@ github.com/opencontainers/image-spec v1.0.1 h1:JMemWkRwHx4Zj+fVxWoMCFm/8sYGGrUVo
 github.com/opencontainers/image-spec v1.0.1/go.mod h1:BtxoFyWECRxE4U/7sNtV5W15zMzWCbyJoFRP3s7yZA0=
 github.com/opencontainers/runc v0.1.1 h1:GlxAyO6x8rfZYN9Tt0Kti5a/cP41iuiO2yYT0IJGY8Y=
 github.com/opencontainers/runc v0.1.1/go.mod h1:qT5XzbpPznkRYVz/mWwUaVBUv2rmF59PVA73FjuZG0U=
+github.com/pascaldekloe/goe v0.0.0-20180627143212-57f6aae5913c/go.mod h1:lzWF7FIEvWOWxwDKqyGYQf6ZUaNfKdP144TG7ZOy1lc=
 github.com/pelletier/go-toml v1.2.0/go.mod h1:5z9KED0ma1S8pY6P1sdut58dfprrGBbd/94hg7ilaic=
+github.com/pelletier/go-toml v1.9.3/go.mod h1:u1nR/EPcESfeI/szUZKdtJ0xRNbUoANCkoOuaOx1Y+c=
 github.com/pierrec/lz4 v2.0.5+incompatible/go.mod h1:pdkljMzZIN41W+lC3N2tnIh5sFi+IEE17M5jbnwPHcY=
 github.com/pkg/errors v0.8.0/go.mod h1:bwawxfHBFNV+L2hUp1rHADufV3IMtnDRdf1r5NINEl0=
 github.com/pkg/errors v0.8.1 h1:iURUrRGxPUNPdy5/HRSm+Yj6okJ6UtLINN0Q9M4+h3I=
 github.com/pkg/errors v0.8.1/go.mod h1:bwawxfHBFNV+L2hUp1rHADufV3IMtnDRdf1r5NINEl0=
 github.com/pkg/errors v0.9.1 h1:FEBLx1zS214owpjy7qsBeixbURkuhQAwrK5UwLGTwt4=
 github.com/pkg/errors v0.9.1/go.mod h1:bwawxfHBFNV+L2hUp1rHADufV3IMtnDRdf1r5NINEl0=
+github.com/pkg/sftp v1.10.1/go.mod h1:lYOWFsE0bwd1+KfKJaKeuokY15vzFx25BLbzYYoAxZI=
 github.com/pmezard/go-difflib v1.0.0 h1:4DBwDE0NGyQoBHbLQYPwSUPoCMWR5BEzIk/f1lZbAQM=
 github.com/pmezard/go-difflib v1.0.0/go.mod h1:iKH77koFhYxTK1pcRnkKkqfTogsbg7gZNVY4sRDYZ/4=
+github.com/posener/complete v1.1.1/go.mod h1:em0nMJCgc9GFtwrmVmEMR/ZL6WyhyjMBndrE9hABlRI=
 github.com/prometheus/client_golang v0.9.1/go.mod h1:7SWBe2y4D6OKWSNQJUaRYU/AaXPKyh/dDVn+NZz0KFw=
 github.com/prometheus/client_golang v1.0.0/go.mod h1:db9x61etRT2tGnBNRi70OPL5FsnadC4Ky3P0J6CfImo=
 github.com/prometheus/client_golang v1.7.1/go.mod h1:PY5Wy2awLA44sXw4AOSfFBetzPP4j5+D6mVACh+pe2M=
@@ -286,24 +360,37 @@ github.com/prometheus/common v0.10.0/go.mod h1:Tlit/dnDKsSWFlCLTWaA1cyBgKHSMdTB8
 github.com/prometheus/procfs v0.0.0-20181005140218-185b4288413d/go.mod h1:c3At6R/oaqEKCNdg8wHV1ftS6bRYblBhIjjI8uT2IGk=
 github.com/prometheus/procfs v0.0.2/go.mod h1:TjEm7ze935MbeOT/UhFTIMYKhuLP4wbCsTZCD3I8kEA=
 github.com/prometheus/procfs v0.1.3/go.mod h1:lV6e/gmhEcM9IjHGsFOCxxuZ+z1YqCvr4OA4YeYWdaU=
+github.com/rogpeppe/fastuuid v1.2.0/go.mod h1:jVj6XXZzXRy/MSR5jhDC/2q6DgLz+nrA6LYCDYWNEvQ=
 github.com/rogpeppe/go-internal v1.3.0/go.mod h1:M8bDsm7K2OlrFYOpmOWEs/qY81heoFRclV5y23lUDJ4=
 github.com/russross/blackfriday v1.5.2/go.mod h1:JO/DiYxRf+HjHt06OyowR9PTA263kcR/rfWxYHBV53g=
+github.com/russross/blackfriday/v2 v2.0.1/go.mod h1:+Rmxgy9KzJVeS9/2gXHxylqXiyQDYRxCVz55jmeOWTM=
+github.com/ryanuber/columnize v0.0.0-20160712163229-9b3edd62028f/go.mod h1:sm1tb6uqfes/u+d4ooFouqFdy9/2g9QGwK3SQygK0Ts=
 github.com/satori/go.uuid v1.2.0 h1:0uYX9dsZ2yD7q2RtLRtPSdGDWzjeM3TbMJP9utgA0ww=
 github.com/satori/go.uuid v1.2.0/go.mod h1:dA0hQrYB0VpLJoorglMZABFdXlWrHn1NEOzdhQKdks0=
+github.com/sean-/seed v0.0.0-20170313163322-e2103e2c3529/go.mod h1:DxrIzT+xaE7yg65j358z/aeFdxmN0P9QXhEzd20vsDc=
+github.com/shurcooL/sanitized_anchor_name v1.0.0/go.mod h1:1NzhyTcUVG4SuEtjjoZeVRXNmyL/1OwPU0+IJeTBvfc=
 github.com/sirupsen/logrus v1.2.0 h1:juTguoYk5qI21pwyTXY3B3Y5cOTH3ZUyZCg1v/mihuo=
 github.com/sirupsen/logrus v1.2.0/go.mod h1:LxeOpSwHxABJmUn/MG1IvRgCAasNZTLOkJPxbbu5VWo=
 github.com/sirupsen/logrus v1.4.2/go.mod h1:tLMulIdttU9McNUspp0xgXVQah82FyeX6MwdIuYE2rE=
+github.com/smartystreets/assertions v0.0.0-20180927180507-b2de0cb4f26d/go.mod h1:OnSkiWE9lh6wB0YB77sQom3nweQdgAjqCqsofrRNTgc=
+github.com/smartystreets/goconvey v1.6.4/go.mod h1:syvi0/a8iFYH4r/RixwvyeAJjdLS9QV7WQ/tjFTllLA=
 github.com/spaolacci/murmur3 v1.1.0/go.mod h1:JwIasOWyU6f++ZhiEuf87xNszmSA2myDM2Kzu9HwQUA=
 github.com/spf13/afero v1.1.2/go.mod h1:j4pytiNVoe2o6bmDsKpLACNPDBIoEAkihy7loJ1B0CQ=
+github.com/spf13/afero v1.6.0/go.mod h1:Ai8FlHk4v/PARR026UzYexafAt9roJ7LcLMAmO6Z93I=
 github.com/spf13/cast v1.3.0/go.mod h1:Qx5cxh0v+4UWYiBimWS+eyWzqEqokIECu5etghLkUJE=
+github.com/spf13/cast v1.3.1/go.mod h1:Qx5cxh0v+4UWYiBimWS+eyWzqEqokIECu5etghLkUJE=
 github.com/spf13/cobra v0.0.3/go.mod h1:1l0Ry5zgKvJasoi3XT1TypsSe7PqH0Sj9dhYf7v3XqQ=
 github.com/spf13/cobra v0.0.5 h1:f0B+LkLX6DtmRH1isoNA9VTtNUK9K8xYd28JNNfOv/s=
 github.com/spf13/cobra v0.0.5/go.mod h1:3K3wKZymM7VvHMDS9+Akkh4K60UwM26emMESw8tLCHU=
+github.com/spf13/cobra v1.2.1 h1:+KmjbUw1hriSNMF55oPrkZcb27aECyrj8V2ytv7kWDw=
+github.com/spf13/cobra v1.2.1/go.mod h1:ExllRjgxM/piMAM+3tAZvg8fsklGAf3tPfi+i8t68Nk=
 github.com/spf13/jwalterweatherman v1.0.0/go.mod h1:cQK4TGJAtQXfYWX+Ddv3mKDzgVb68N+wFjFa4jdeBTo=
+github.com/spf13/jwalterweatherman v1.1.0/go.mod h1:aNWZUN0dPAAO/Ljvb5BEdw96iTZ0EXowPYD95IqWIGo=
 github.com/spf13/pflag v1.0.3/go.mod h1:DYY7MBk1bdzusC3SYhjObp+wFpr4gzcvqqNjLnInEg4=
 github.com/spf13/pflag v1.0.5 h1:iy+VFUOCP1a+8yFto/drg2CJ5u0yRoB7fZw3DKv/JXA=
 github.com/spf13/pflag v1.0.5/go.mod h1:McXfInJRrz4CZXVZOBLb0bTZqETkiAhM9Iw0y3An2Bg=
 github.com/spf13/viper v1.3.2/go.mod h1:ZiWeW+zYFKm7srdB9IoDzzZXaJaI5eL9QjNiN/DMA2s=
+github.com/spf13/viper v1.8.1/go.mod h1:o0Pch8wJ9BVSWGQMbra6iw0oQ5oktSIBaujf1rJH9Ns=
 github.com/stretchr/objx v0.1.0/go.mod h1:HFkY916IF+rwdDfMAkV7OtwuqBVzrE8GR6GFx+wExME=
 github.com/stretchr/objx v0.1.1/go.mod h1:HFkY916IF+rwdDfMAkV7OtwuqBVzrE8GR6GFx+wExME=
 github.com/stretchr/objx v0.2.0 h1:Hbg2NidpLE8veEBkEZTL3CvlkUIVzuU9jDplZO54c48=
@@ -312,6 +399,10 @@ github.com/stretchr/testify v1.2.2/go.mod h1:a8OnRcib4nhh0OaRAV+Yts87kKdq0PP7pXf
 github.com/stretchr/testify v1.3.0/go.mod h1:M5WIy9Dh21IEIfnGCwXGc5bZfKNJtfHm1UVUgZn+9EI=
 github.com/stretchr/testify v1.4.0 h1:2E4SXV/wtOkTonXsotYi4li6zVWxYlZuYNCXe9XRJyk=
 github.com/stretchr/testify v1.4.0/go.mod h1:j7eGeouHqKxXV5pUuKE4zz7dFj8WfuZ+81PSLYec5m4=
+github.com/stretchr/testify v1.5.1/go.mod h1:5W2xD1RspED5o8YsWQXVCued0rvSQ+mT+I5cxcmMvtA=
+github.com/stretchr/testify v1.6.1/go.mod h1:6Fq8oRcR53rry900zMqJjRRixrwX3KX962/h/Wwjteg=
+github.com/stretchr/testify v1.7.0/go.mod h1:6Fq8oRcR53rry900zMqJjRRixrwX3KX962/h/Wwjteg=
+github.com/subosito/gotenv v1.2.0/go.mod h1:N0PQaV/YGNqwC0u51sEeR/aUtSLEXKX9iv69rRypqCw=
 github.com/testcontainers/testcontainers-go v0.0.10 h1:WP99DOGWmkr+RXHURyAXnvZqZO0x3VXkRYAzQ+mwtpQ=
 github.com/testcontainers/testcontainers-go v0.0.10/go.mod h1:2kePcwMHd3ix/BU3cTDuhvggUgMBAit+qcWwadeMXok=
 github.com/ugorji/go/codec v0.0.0-20181204163529-d75b2dcb6bc8/go.mod h1:VFNgLljTbGfSG7qAOspJ7OScBnGdDN/yBr0sguwnwf0=
@@ -321,18 +412,28 @@ github.com/yuin/goldmark v1.1.25/go.mod h1:3hX8gzYuyVAZsxl0MRgGTJEmQBFcNTphYh9de
 github.com/yuin/goldmark v1.1.27/go.mod h1:3hX8gzYuyVAZsxl0MRgGTJEmQBFcNTphYh9decYSb74=
 github.com/yuin/goldmark v1.1.32/go.mod h1:3hX8gzYuyVAZsxl0MRgGTJEmQBFcNTphYh9decYSb74=
 github.com/yuin/goldmark v1.2.1/go.mod h1:3hX8gzYuyVAZsxl0MRgGTJEmQBFcNTphYh9decYSb74=
+github.com/yuin/goldmark v1.3.5/go.mod h1:mwnBkeHKe2W/ZEtQ+71ViKU8L12m81fl3OWwC1Zlc8k=
+go.etcd.io/etcd/api/v3 v3.5.0/go.mod h1:cbVKeC6lCfl7j/8jBhAK6aIYO9XOjdptoxU/nLQcPvs=
+go.etcd.io/etcd/client/pkg/v3 v3.5.0/go.mod h1:IJHfcCEKxYu1Os13ZdwCwIUTUVGYTSAM3YSwc9/Ac1g=
+go.etcd.io/etcd/client/v2 v2.305.0/go.mod h1:h9puh54ZTgAKtEbut2oe9P4L/oqKCVB6xsXlzd7alYQ=
 go.opencensus.io v0.21.0/go.mod h1:mSImk1erAIZhrmZN+AvHh14ztQfjbGwt4TtuofqLduU=
 go.opencensus.io v0.22.0/go.mod h1:+kGneAE2xo2IficOXnaByMWTGM9T73dGwxeWcUqIpI8=
 go.opencensus.io v0.22.2/go.mod h1:yxeiOL68Rb0Xd1ddK5vPZ/oVn4vY4Ynel7k9FzqtOIw=
 go.opencensus.io v0.22.3/go.mod h1:yxeiOL68Rb0Xd1ddK5vPZ/oVn4vY4Ynel7k9FzqtOIw=
 go.opencensus.io v0.22.4/go.mod h1:yxeiOL68Rb0Xd1ddK5vPZ/oVn4vY4Ynel7k9FzqtOIw=
+go.opencensus.io v0.22.5/go.mod h1:5pWMHQbX5EPX2/62yrJeAkowc+lfs/XD7Uxpq3pI6kk=
+go.opencensus.io v0.23.0/go.mod h1:XItmlyltB5F7CS4xOC1DcqMoFqwtC6OG2xF7mCv7P7E=
 go.uber.org/atomic v1.7.0/go.mod h1:fEN4uk6kAWBTFdckzkM89CLk9XfWZrxpCo0nPH17wJc=
+go.uber.org/multierr v1.6.0/go.mod h1:cdWPpRnG4AhwMwsgIHip0KRBQjJy5kYEpYjJxpXp9iU=
+go.uber.org/zap v1.17.0/go.mod h1:MXVU+bhUf/A7Xi2HNOnopQOrmycQ5Ih87HtOu4q5SSo=
 golang.org/x/crypto v0.0.0-20180904163835-0709b304e793/go.mod h1:6SG95UA2DQfeDnfUPMdvaQW0Q7yPrPDi9nlGo2tz2b4=
+golang.org/x/crypto v0.0.0-20181029021203-45a5f77698d3/go.mod h1:6SG95UA2DQfeDnfUPMdvaQW0Q7yPrPDi9nlGo2tz2b4=
 golang.org/x/crypto v0.0.0-20181203042331-505ab145d0a9/go.mod h1:6SG95UA2DQfeDnfUPMdvaQW0Q7yPrPDi9nlGo2tz2b4=
 golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod h1:djNgcEr1/C05ACkg1iLfiJU5Ep61QUkGW8qpdssI0+w=
 golang.org/x/crypto v0.0.0-20190510104115-cbcb75029529/go.mod h1:yigFU9vqHzYiE8UmvKecakEJjdnWj3jj499lnFckfCI=
 golang.org/x/crypto v0.0.0-20190605123033-f99c8df09eb5/go.mod h1:yigFU9vqHzYiE8UmvKecakEJjdnWj3jj499lnFckfCI=
 golang.org/x/crypto v0.0.0-20190701094942-4def268fd1a4/go.mod h1:yigFU9vqHzYiE8UmvKecakEJjdnWj3jj499lnFckfCI=
+golang.org/x/crypto v0.0.0-20190820162420-60c769a6c586/go.mod h1:yigFU9vqHzYiE8UmvKecakEJjdnWj3jj499lnFckfCI=
 golang.org/x/crypto v0.0.0-20191011191535-87dc89f01550/go.mod h1:yigFU9vqHzYiE8UmvKecakEJjdnWj3jj499lnFckfCI=
 golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9 h1:psW17arqaxU48Z5kZ0CQnkZWQJsqcURM6tKiBApRjXI=
 golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9/go.mod h1:LzIPMQfyMNhhGPhUkYOs5KpL4U8rLKemX1yGLhDgUto=
@@ -358,6 +459,8 @@ golang.org/x/lint v0.0.0-20190930215403-16217165b5de/go.mod h1:6SW0HCj/g11FgYtHl
 golang.org/x/lint v0.0.0-20191125180803-fdd1cda4f05f/go.mod h1:5qLYkcX4OjUUV8bRuDixDT3tpyyb+LUpUlRWLxfhWrs=
 golang.org/x/lint v0.0.0-20200130185559-910be7a94367/go.mod h1:3xt1FjdF8hUf6vQPIChWIBhFzV8gjjsPE/fR3IyQdNY=
 golang.org/x/lint v0.0.0-20200302205851-738671d3881b/go.mod h1:3xt1FjdF8hUf6vQPIChWIBhFzV8gjjsPE/fR3IyQdNY=
+golang.org/x/lint v0.0.0-20201208152925-83fdc39ff7b5/go.mod h1:3xt1FjdF8hUf6vQPIChWIBhFzV8gjjsPE/fR3IyQdNY=
+golang.org/x/lint v0.0.0-20210508222113-6edffad5e616/go.mod h1:3xt1FjdF8hUf6vQPIChWIBhFzV8gjjsPE/fR3IyQdNY=
 golang.org/x/mobile v0.0.0-20190312151609-d3739f865fa6/go.mod h1:z+o9i4GpDbdi3rU15maQ/Ox0txvL9dWGYEHz965HBQE=
 golang.org/x/mobile v0.0.0-20190719004257-d2bd2a29d028/go.mod h1:E/iHnbuqvinMTCcRqshq8CkpyQDoeVncDDYHnLhea+o=
 golang.org/x/mod v0.0.0-20190513183733-4bf6d317e70e/go.mod h1:mXi4GBBbnImb6dmsKGUJ2LatrhH/nqhxcFungHvyanc=
@@ -366,10 +469,15 @@ golang.org/x/mod v0.1.1-0.20191105210325-c90efee705ee/go.mod h1:QqPTAvyqsEbceGzB
 golang.org/x/mod v0.1.1-0.20191107180719-034126e5016b/go.mod h1:QqPTAvyqsEbceGzBzNggFXnrqF1CaUcvgkdR5Ot7KZg=
 golang.org/x/mod v0.2.0/go.mod h1:s0Qsj1ACt9ePp/hMypM3fl4fZqREWJwdYDEqhRiZZUA=
 golang.org/x/mod v0.3.0/go.mod h1:s0Qsj1ACt9ePp/hMypM3fl4fZqREWJwdYDEqhRiZZUA=
+golang.org/x/mod v0.4.0/go.mod h1:s0Qsj1ACt9ePp/hMypM3fl4fZqREWJwdYDEqhRiZZUA=
+golang.org/x/mod v0.4.1/go.mod h1:s0Qsj1ACt9ePp/hMypM3fl4fZqREWJwdYDEqhRiZZUA=
+golang.org/x/mod v0.4.2/go.mod h1:s0Qsj1ACt9ePp/hMypM3fl4fZqREWJwdYDEqhRiZZUA=
 golang.org/x/net v0.0.0-20180724234803-3673e40ba225/go.mod h1:mL1N/T3taQHkDXs73rZJwtUhF3w3ftmwwsq0BUmARs4=
 golang.org/x/net v0.0.0-20180826012351-8a410e7b638d/go.mod h1:mL1N/T3taQHkDXs73rZJwtUhF3w3ftmwwsq0BUmARs4=
 golang.org/x/net v0.0.0-20180906233101-161cd47e91fd/go.mod h1:mL1N/T3taQHkDXs73rZJwtUhF3w3ftmwwsq0BUmARs4=
+golang.org/x/net v0.0.0-20181023162649-9b4f9f5ad519/go.mod h1:mL1N/T3taQHkDXs73rZJwtUhF3w3ftmwwsq0BUmARs4=
 golang.org/x/net v0.0.0-20181114220301-adae6a3d119a/go.mod h1:mL1N/T3taQHkDXs73rZJwtUhF3w3ftmwwsq0BUmARs4=
+golang.org/x/net v0.0.0-20181201002055-351d144fa1fc/go.mod h1:mL1N/T3taQHkDXs73rZJwtUhF3w3ftmwwsq0BUmARs4=
 golang.org/x/net v0.0.0-20190108225652-1e06a53dbb7e/go.mod h1:mL1N/T3taQHkDXs73rZJwtUhF3w3ftmwwsq0BUmARs4=
 golang.org/x/net v0.0.0-20190213061140-3a22650c66bd/go.mod h1:mL1N/T3taQHkDXs73rZJwtUhF3w3ftmwwsq0BUmARs4=
 golang.org/x/net v0.0.0-20190311183353-d8887717615a/go.mod h1:t9HGtf8HONx5eT2rtn7q6eTqICYqUVnKs3thJo3Qplg=
@@ -399,18 +507,32 @@ golang.org/x/net v0.0.0-20200707034311-ab3426394381 h1:VXak5I6aEWmAXeQjA+QSZzlgN
 golang.org/x/net v0.0.0-20200707034311-ab3426394381/go.mod h1:/O7V0waA8r7cgGh81Ro3o1hOxt32SMVPicZroKQ2sZA=
 golang.org/x/net v0.0.0-20200822124328-c89045814202/go.mod h1:/O7V0waA8r7cgGh81Ro3o1hOxt32SMVPicZroKQ2sZA=
 golang.org/x/net v0.0.0-20201021035429-f5854403a974/go.mod h1:sp8m0HH+o8qH0wwXwYZr8TS3Oi6o0r6Gce1SSxlDquU=
+golang.org/x/net v0.0.0-20201031054903-ff519b6c9102/go.mod h1:sp8m0HH+o8qH0wwXwYZr8TS3Oi6o0r6Gce1SSxlDquU=
+golang.org/x/net v0.0.0-20201110031124-69a78807bb2b/go.mod h1:sp8m0HH+o8qH0wwXwYZr8TS3Oi6o0r6Gce1SSxlDquU=
+golang.org/x/net v0.0.0-20201209123823-ac852fbbde11/go.mod h1:m0MpNAwzfU5UDzcl9v0D8zg8gWTRqZa9RBIspLL5mdg=
 golang.org/x/net v0.0.0-20210119194325-5f4716e94777 h1:003p0dJM77cxMSyCPFphvZf/Y5/NXf5fzg6ufd1/Oew=
 golang.org/x/net v0.0.0-20210119194325-5f4716e94777/go.mod h1:m0MpNAwzfU5UDzcl9v0D8zg8gWTRqZa9RBIspLL5mdg=
 golang.org/x/net v0.0.0-20210220033124-5f55cee0dc0d h1:1aflnvSoWWLI2k/dMUAl5lvU1YO4Mb4hz0gh+1rjcxU=
 golang.org/x/net v0.0.0-20210220033124-5f55cee0dc0d/go.mod h1:m0MpNAwzfU5UDzcl9v0D8zg8gWTRqZa9RBIspLL5mdg=
+golang.org/x/net v0.0.0-20210226172049-e18ecbb05110/go.mod h1:m0MpNAwzfU5UDzcl9v0D8zg8gWTRqZa9RBIspLL5mdg=
+golang.org/x/net v0.0.0-20210316092652-d523dce5a7f4/go.mod h1:RBQZq4jEuRlivfhVLdyRGr576XBO4/greRjx4P4O3yc=
+golang.org/x/net v0.0.0-20210405180319-a5a99cb37ef4 h1:4nGaVu0QrbjT/AK2PRLuQfQuh6DJve+pELhqTdAj3x0=
+golang.org/x/net v0.0.0-20210405180319-a5a99cb37ef4/go.mod h1:p54w0d4576C0XHj96bSt6lcn1PtDYWL6XObtHCRCNQM=
 golang.org/x/oauth2 v0.0.0-20180821212333-d2e6202438be/go.mod h1:N/0e6XlmueqKjAGxoOufVs8QHGRruUQn6yWY3a++T0U=
 golang.org/x/oauth2 v0.0.0-20190226205417-e64efc72b421/go.mod h1:gOpvHmFTYa4IltrdGE7lF6nIHvwfUNPOp7c8zoXwtLw=
 golang.org/x/oauth2 v0.0.0-20190604053449-0f29369cfe45/go.mod h1:gOpvHmFTYa4IltrdGE7lF6nIHvwfUNPOp7c8zoXwtLw=
 golang.org/x/oauth2 v0.0.0-20191202225959-858c2ad4c8b6/go.mod h1:gOpvHmFTYa4IltrdGE7lF6nIHvwfUNPOp7c8zoXwtLw=
 golang.org/x/oauth2 v0.0.0-20200107190931-bf48bf16ab8d h1:TzXSXBo42m9gQenoE3b9BGiEpg5IG2JkU5FkPIawgtw=
 golang.org/x/oauth2 v0.0.0-20200107190931-bf48bf16ab8d/go.mod h1:gOpvHmFTYa4IltrdGE7lF6nIHvwfUNPOp7c8zoXwtLw=
+golang.org/x/oauth2 v0.0.0-20200902213428-5d25da1a8d43/go.mod h1:KelEdhl1UZF7XfJ4dDtk6s++YSgaE7mD/BuKKDLBl4A=
+golang.org/x/oauth2 v0.0.0-20201109201403-9fd604954f58/go.mod h1:KelEdhl1UZF7XfJ4dDtk6s++YSgaE7mD/BuKKDLBl4A=
+golang.org/x/oauth2 v0.0.0-20201208152858-08078c50e5b5/go.mod h1:KelEdhl1UZF7XfJ4dDtk6s++YSgaE7mD/BuKKDLBl4A=
+golang.org/x/oauth2 v0.0.0-20210218202405-ba52d332ba99/go.mod h1:KelEdhl1UZF7XfJ4dDtk6s++YSgaE7mD/BuKKDLBl4A=
 golang.org/x/oauth2 v0.0.0-20210220000619-9bb904979d93 h1:alLDrZkL34Y2bnGHfvC1CYBRBXCXgx8AC2vY4MRtYX4=
 golang.org/x/oauth2 v0.0.0-20210220000619-9bb904979d93/go.mod h1:KelEdhl1UZF7XfJ4dDtk6s++YSgaE7mD/BuKKDLBl4A=
+golang.org/x/oauth2 v0.0.0-20210313182246-cd4f82c27b84/go.mod h1:KelEdhl1UZF7XfJ4dDtk6s++YSgaE7mD/BuKKDLBl4A=
+golang.org/x/oauth2 v0.0.0-20210402161424-2e8d93401602 h1:0Ja1LBD+yisY6RWM/BH7TJVXWsSjs2VwBSmvSX4HdBc=
+golang.org/x/oauth2 v0.0.0-20210402161424-2e8d93401602/go.mod h1:KelEdhl1UZF7XfJ4dDtk6s++YSgaE7mD/BuKKDLBl4A=
 golang.org/x/sync v0.0.0-20180314180146-1d60e4601c6f/go.mod h1:RxMgew5VJxzue5/jJTE5uejpjVlOe/izrB70Jof72aM=
 golang.org/x/sync v0.0.0-20181108010431-42b317875d0f/go.mod h1:RxMgew5VJxzue5/jJTE5uejpjVlOe/izrB70Jof72aM=
 golang.org/x/sync v0.0.0-20181221193216-37e7f081c4d4/go.mod h1:RxMgew5VJxzue5/jJTE5uejpjVlOe/izrB70Jof72aM=
@@ -421,9 +543,13 @@ golang.org/x/sync v0.0.0-20190911185100-cd5d95a43a6e/go.mod h1:RxMgew5VJxzue5/jJ
 golang.org/x/sync v0.0.0-20200317015054-43a5402ce75a/go.mod h1:RxMgew5VJxzue5/jJTE5uejpjVlOe/izrB70Jof72aM=
 golang.org/x/sync v0.0.0-20200625203802-6e8e738ad208/go.mod h1:RxMgew5VJxzue5/jJTE5uejpjVlOe/izrB70Jof72aM=
 golang.org/x/sync v0.0.0-20201020160332-67f06af15bc9/go.mod h1:RxMgew5VJxzue5/jJTE5uejpjVlOe/izrB70Jof72aM=
+golang.org/x/sync v0.0.0-20201207232520-09787c993a3a/go.mod h1:RxMgew5VJxzue5/jJTE5uejpjVlOe/izrB70Jof72aM=
+golang.org/x/sync v0.0.0-20210220032951-036812b2e83c/go.mod h1:RxMgew5VJxzue5/jJTE5uejpjVlOe/izrB70Jof72aM=
+golang.org/x/sys v0.0.0-20180823144017-11551d06cbcc/go.mod h1:STP8DvDyc/dI5b8T5hshtkjS+E42TnysNCUPdjciGhY=
 golang.org/x/sys v0.0.0-20180830151530-49385e6e1522/go.mod h1:STP8DvDyc/dI5b8T5hshtkjS+E42TnysNCUPdjciGhY=
 golang.org/x/sys v0.0.0-20180905080454-ebe1bf3edb33/go.mod h1:STP8DvDyc/dI5b8T5hshtkjS+E42TnysNCUPdjciGhY=
 golang.org/x/sys v0.0.0-20180909124046-d0be0721c37e/go.mod h1:STP8DvDyc/dI5b8T5hshtkjS+E42TnysNCUPdjciGhY=
+golang.org/x/sys v0.0.0-20181026203630-95b1ffbd15a5/go.mod h1:STP8DvDyc/dI5b8T5hshtkjS+E42TnysNCUPdjciGhY=
 golang.org/x/sys v0.0.0-20181116152217-5ac8a444bdc5/go.mod h1:STP8DvDyc/dI5b8T5hshtkjS+E42TnysNCUPdjciGhY=
 golang.org/x/sys v0.0.0-20181205085412-a5c9d58dba9a/go.mod h1:STP8DvDyc/dI5b8T5hshtkjS+E42TnysNCUPdjciGhY=
 golang.org/x/sys v0.0.0-20181228144115-9a3f9b0469bb/go.mod h1:STP8DvDyc/dI5b8T5hshtkjS+E42TnysNCUPdjciGhY=
@@ -463,9 +589,21 @@ golang.org/x/sys v0.0.0-20200519105757-fe76b779f299/go.mod h1:h1NjWce9XRLGQEsW7w
 golang.org/x/sys v0.0.0-20200523222454-059865788121/go.mod h1:h1NjWce9XRLGQEsW7wpKNCjG9DtNlClVuFLEZdDNbEs=
 golang.org/x/sys v0.0.0-20200615200032-f1bc736245b1/go.mod h1:h1NjWce9XRLGQEsW7wpKNCjG9DtNlClVuFLEZdDNbEs=
 golang.org/x/sys v0.0.0-20200803210538-64077c9b5642/go.mod h1:h1NjWce9XRLGQEsW7wpKNCjG9DtNlClVuFLEZdDNbEs=
+golang.org/x/sys v0.0.0-20200905004654-be1d3432aa8f/go.mod h1:h1NjWce9XRLGQEsW7wpKNCjG9DtNlClVuFLEZdDNbEs=
 golang.org/x/sys v0.0.0-20200930185726-fdedc70b468f/go.mod h1:h1NjWce9XRLGQEsW7wpKNCjG9DtNlClVuFLEZdDNbEs=
 golang.org/x/sys v0.0.0-20201119102817-f84b799fce68 h1:nxC68pudNYkKU6jWhgrqdreuFiOQWj1Fs7T3VrH4Pjw=
 golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod h1:h1NjWce9XRLGQEsW7wpKNCjG9DtNlClVuFLEZdDNbEs=
+golang.org/x/sys v0.0.0-20201201145000-ef89a241ccb3/go.mod h1:h1NjWce9XRLGQEsW7wpKNCjG9DtNlClVuFLEZdDNbEs=
+golang.org/x/sys v0.0.0-20210104204734-6f8348627aad/go.mod h1:h1NjWce9XRLGQEsW7wpKNCjG9DtNlClVuFLEZdDNbEs=
+golang.org/x/sys v0.0.0-20210119212857-b64e53b001e4/go.mod h1:h1NjWce9XRLGQEsW7wpKNCjG9DtNlClVuFLEZdDNbEs=
+golang.org/x/sys v0.0.0-20210220050731-9a76102bfb43/go.mod h1:h1NjWce9XRLGQEsW7wpKNCjG9DtNlClVuFLEZdDNbEs=
+golang.org/x/sys v0.0.0-20210305230114-8fe3ee5dd75b/go.mod h1:h1NjWce9XRLGQEsW7wpKNCjG9DtNlClVuFLEZdDNbEs=
+golang.org/x/sys v0.0.0-20210315160823-c6e025ad8005/go.mod h1:h1NjWce9XRLGQEsW7wpKNCjG9DtNlClVuFLEZdDNbEs=
+golang.org/x/sys v0.0.0-20210320140829-1e4c9ba3b0c4/go.mod h1:h1NjWce9XRLGQEsW7wpKNCjG9DtNlClVuFLEZdDNbEs=
+golang.org/x/sys v0.0.0-20210330210617-4fbd30eecc44/go.mod h1:h1NjWce9XRLGQEsW7wpKNCjG9DtNlClVuFLEZdDNbEs=
+golang.org/x/sys v0.0.0-20210403161142-5e06dd20ab57/go.mod h1:h1NjWce9XRLGQEsW7wpKNCjG9DtNlClVuFLEZdDNbEs=
+golang.org/x/sys v0.0.0-20210510120138-977fb7262007 h1:gG67DSER+11cZvqIMb8S8bt0vZtiN6xWYARwirrOSfE=
+golang.org/x/sys v0.0.0-20210510120138-977fb7262007/go.mod h1:oPkhp1MJrh7nUepCBck5+mAzfO9JrbApNNgaTdGDITg=
 golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod h1:bj7SfCRtBDWHUb9snDiAeCFNEtKQo2Wmx5Cou7ajbmo=
 golang.org/x/text v0.0.0-20170915032832-14c0d48ead0c/go.mod h1:NqM8EUOU14njkJ3fqMW+pc6Ldnwhi/IjpwHt7yyuwOQ=
 golang.org/x/text v0.3.0 h1:g61tztE5qeGQ89tm6NTjjM9VPIm088od1l6aSorWRWg=
@@ -474,6 +612,8 @@ golang.org/x/text v0.3.1-0.20180807135948-17ff2d5776d2/go.mod h1:NqM8EUOU14njkJ3
 golang.org/x/text v0.3.2 h1:tW2bmiBqwgJj/UpqtC8EpXEZVYOwU0yG4iWbprSVAcs=
 golang.org/x/text v0.3.2/go.mod h1:bEr9sfX3Q8Zfm5fL9x+3itogRgK3+ptLWKqgva+5dAk=
 golang.org/x/text v0.3.3/go.mod h1:5Zoc/QRtKVWzQhOtBMvqHzDpF6irO9z98xDceosuGiQ=
+golang.org/x/text v0.3.4/go.mod h1:5Zoc/QRtKVWzQhOtBMvqHzDpF6irO9z98xDceosuGiQ=
+golang.org/x/text v0.3.5/go.mod h1:5Zoc/QRtKVWzQhOtBMvqHzDpF6irO9z98xDceosuGiQ=
 golang.org/x/time v0.0.0-20181108054448-85acf8d2951c h1:fqgJT0MGcGpPgpWU7VRdRjuArfcOvC4AoJmILihzhDg=
 golang.org/x/time v0.0.0-20181108054448-85acf8d2951c/go.mod h1:tRJNPiyCQ0inRvYxbN9jk5I+vvW/OXSQhTDSoE431IQ=
 golang.org/x/time v0.0.0-20190308202827-9d24e82272b4/go.mod h1:tRJNPiyCQ0inRvYxbN9jk5I+vvW/OXSQhTDSoE431IQ=
@@ -486,6 +626,7 @@ golang.org/x/tools v0.0.0-20190226205152-f727befe758c/go.mod h1:9Yl7xja0Znq3iFh3
 golang.org/x/tools v0.0.0-20190311212946-11955173bddd/go.mod h1:LCzVGOaR6xXOjkQ3onu1FJEFr0SW1gC7cKk1uF8kGRs=
 golang.org/x/tools v0.0.0-20190312151545-0bb0c0a6e846/go.mod h1:LCzVGOaR6xXOjkQ3onu1FJEFr0SW1gC7cKk1uF8kGRs=
 golang.org/x/tools v0.0.0-20190312170243-e65039ee4138/go.mod h1:LCzVGOaR6xXOjkQ3onu1FJEFr0SW1gC7cKk1uF8kGRs=
+golang.org/x/tools v0.0.0-20190328211700-ab21143f2384/go.mod h1:LCzVGOaR6xXOjkQ3onu1FJEFr0SW1gC7cKk1uF8kGRs=
 golang.org/x/tools v0.0.0-20190425150028-36563e24a262/go.mod h1:RgjU9mgBXZiqYHBnxXauZ1Gv1EHHAz9KjViQ78xBX0Q=
 golang.org/x/tools v0.0.0-20190506145303-2d16b83fe98c/go.mod h1:RgjU9mgBXZiqYHBnxXauZ1Gv1EHHAz9KjViQ78xBX0Q=
 golang.org/x/tools v0.0.0-20190524140312-2c0ae7006135/go.mod h1:RgjU9mgBXZiqYHBnxXauZ1Gv1EHHAz9KjViQ78xBX0Q=
@@ -496,6 +637,7 @@ golang.org/x/tools v0.0.0-20190808195139-e713427fea3f/go.mod h1:b+2E5dAYhXwXZwtn
 golang.org/x/tools v0.0.0-20190816200558-6889da9d5479/go.mod h1:b+2E5dAYhXwXZwtnZ6UAqBI28+e2cm9otk0dWdXHAEo=
 golang.org/x/tools v0.0.0-20190911174233-4f2ddba30aff/go.mod h1:b+2E5dAYhXwXZwtnZ6UAqBI28+e2cm9otk0dWdXHAEo=
 golang.org/x/tools v0.0.0-20191012152004-8de300cfc20a/go.mod h1:b+2E5dAYhXwXZwtnZ6UAqBI28+e2cm9otk0dWdXHAEo=
+golang.org/x/tools v0.0.0-20191112195655-aa38f8e97acc/go.mod h1:b+2E5dAYhXwXZwtnZ6UAqBI28+e2cm9otk0dWdXHAEo=
 golang.org/x/tools v0.0.0-20191113191852-77e3bb0ad9e7/go.mod h1:b+2E5dAYhXwXZwtnZ6UAqBI28+e2cm9otk0dWdXHAEo=
 golang.org/x/tools v0.0.0-20191115202509-3a792d9c32b2/go.mod h1:b+2E5dAYhXwXZwtnZ6UAqBI28+e2cm9otk0dWdXHAEo=
 golang.org/x/tools v0.0.0-20191119224855-298f0cb1881e/go.mod h1:b+2E5dAYhXwXZwtnZ6UAqBI28+e2cm9otk0dWdXHAEo=
@@ -522,7 +664,14 @@ golang.org/x/tools v0.0.0-20200619180055-7c47624df98f/go.mod h1:EkVYQZoAsY45+roY
 golang.org/x/tools v0.0.0-20200729194436-6467de6f59a7/go.mod h1:njjCfa9FT2d7l9Bc6FUM5FLjQPp3cFF28FI3qnDFljA=
 golang.org/x/tools v0.0.0-20200804011535-6c149bb5ef0d/go.mod h1:njjCfa9FT2d7l9Bc6FUM5FLjQPp3cFF28FI3qnDFljA=
 golang.org/x/tools v0.0.0-20200825202427-b303f430e36d/go.mod h1:njjCfa9FT2d7l9Bc6FUM5FLjQPp3cFF28FI3qnDFljA=
+golang.org/x/tools v0.0.0-20200904185747-39188db58858/go.mod h1:Cj7w3i3Rnn0Xh82ur9kSqwfTHTeVxaDqrfMjpcNT6bE=
+golang.org/x/tools v0.0.0-20201110124207-079ba7bd75cd/go.mod h1:emZCQorbCU4vsT4fOWvOPXz4eW1wZW4PmDk9uLelYpA=
+golang.org/x/tools v0.0.0-20201201161351-ac6f37ff4c2a/go.mod h1:emZCQorbCU4vsT4fOWvOPXz4eW1wZW4PmDk9uLelYpA=
+golang.org/x/tools v0.0.0-20201208233053-a543418bbed2/go.mod h1:emZCQorbCU4vsT4fOWvOPXz4eW1wZW4PmDk9uLelYpA=
+golang.org/x/tools v0.0.0-20210105154028-b0ab187a4818/go.mod h1:emZCQorbCU4vsT4fOWvOPXz4eW1wZW4PmDk9uLelYpA=
 golang.org/x/tools v0.0.0-20210106214847-113979e3529a/go.mod h1:emZCQorbCU4vsT4fOWvOPXz4eW1wZW4PmDk9uLelYpA=
+golang.org/x/tools v0.1.0/go.mod h1:xkSsbof2nBLbhDlRMhhhyNLN/zl3eTqcnHD5viDpcZ0=
+golang.org/x/tools v0.1.2/go.mod h1:o0xws9oXOQQZyjljx8fwUC0k7L1pTE6eaCbjGeHmOkk=
 golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod h1:I/5z698sn9Ka8TeJc9MKroUUfqBBauWjQqLJ2OPfmY0=
 golang.org/x/xerrors v0.0.0-20191011141410-1b5146add898/go.mod h1:I/5z698sn9Ka8TeJc9MKroUUfqBBauWjQqLJ2OPfmY0=
 golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543 h1:E7g+9GITq07hpfrRu66IVDexMakfv52eLZ2CXBWiKr4=
@@ -544,6 +693,12 @@ google.golang.org/api v0.24.0/go.mod h1:lIXQywCXRcnZPGlsd8NbLnOjtAoL6em04bJ9+z0M
 google.golang.org/api v0.28.0/go.mod h1:lIXQywCXRcnZPGlsd8NbLnOjtAoL6em04bJ9+z0MncE=
 google.golang.org/api v0.29.0/go.mod h1:Lcubydp8VUV7KeIHD9z2Bys/sm/vGKnG1UHuDBSrHWM=
 google.golang.org/api v0.30.0/go.mod h1:QGmEvQ87FHZNiUVJkT14jQNYJ4ZJjdRF23ZXz5138Fc=
+google.golang.org/api v0.35.0/go.mod h1:/XrVsuzM0rZmrsbjJutiuftIzeuTQcEeaYcSk/mQ1dg=
+google.golang.org/api v0.36.0/go.mod h1:+z5ficQTmoYpPn8LCUNVpK5I7hwkpjbcgqA7I34qYtE=
+google.golang.org/api v0.40.0/go.mod h1:fYKFpnQN0DsDSKRVRcQSDQNtqWPfM9i+zNPxepjRCQ8=
+google.golang.org/api v0.41.0/go.mod h1:RkxM5lITDfTzmyKFPt+wGrCJbVfniCr2ool8kTBzRTU=
+google.golang.org/api v0.43.0/go.mod h1:nQsDGjRXMo4lvh5hP0TKqF244gqhGcr/YSIykhUk/94=
+google.golang.org/api v0.44.0/go.mod h1:EBOGZqzyhtvMDoxwS97ctnh0zUmYY6CxqXsc1AvkYD8=
 google.golang.org/appengine v1.1.0/go.mod h1:EbEs0AVv82hx2wNQdGPgUI5lhzA/G0D9YwlJXL52JkM=
 google.golang.org/appengine v1.4.0 h1:/wp5JvzpHIxhs/dumFmF7BXTf3Z+dd4uXta4kVyO508=
 google.golang.org/appengine v1.4.0/go.mod h1:xpcJRLb0r/rnEns0DIKYYv+WjYCduHsrkT7/EB5XEv4=
@@ -578,6 +733,7 @@ google.golang.org/genproto v0.0.0-20200312145019-da6875a35672/go.mod h1:55QSHmfG
 google.golang.org/genproto v0.0.0-20200331122359-1ee6d9798940/go.mod h1:55QSHmfGQM9UVYDPBsyGGes0y52j32PQ3BqQfXhyH3c=
 google.golang.org/genproto v0.0.0-20200430143042-b979b6f78d84/go.mod h1:55QSHmfGQM9UVYDPBsyGGes0y52j32PQ3BqQfXhyH3c=
 google.golang.org/genproto v0.0.0-20200511104702-f5ebc3bea380/go.mod h1:55QSHmfGQM9UVYDPBsyGGes0y52j32PQ3BqQfXhyH3c=
+google.golang.org/genproto v0.0.0-20200513103714-09dca8ec2884/go.mod h1:55QSHmfGQM9UVYDPBsyGGes0y52j32PQ3BqQfXhyH3c=
 google.golang.org/genproto v0.0.0-20200515170657-fc4c6c6a6587/go.mod h1:YsZOwe1myG/8QRHRsmBRE1LrgQY60beZKjly0O1fX9U=
 google.golang.org/genproto v0.0.0-20200526211855-cb27e3aa2013 h1:+kGHl1aib/qcwaRi1CbqBZ1rk19r85MNUf8HaBghugY=
 google.golang.org/genproto v0.0.0-20200526211855-cb27e3aa2013/go.mod h1:NbSheEEYHJ7i3ixzK3sjbqSGDJWnxyFXZblF3eUsNvo=
@@ -585,6 +741,17 @@ google.golang.org/genproto v0.0.0-20200618031413-b414f8b61790/go.mod h1:jDfRM7Fc
 google.golang.org/genproto v0.0.0-20200729003335-053ba62fc06f/go.mod h1:FWY/as6DDZQgahTzZj3fqbO1CbirC29ZNUFHwi0/+no=
 google.golang.org/genproto v0.0.0-20200804131852-c06518451d9c/go.mod h1:FWY/as6DDZQgahTzZj3fqbO1CbirC29ZNUFHwi0/+no=
 google.golang.org/genproto v0.0.0-20200825200019-8632dd797987/go.mod h1:FWY/as6DDZQgahTzZj3fqbO1CbirC29ZNUFHwi0/+no=
+google.golang.org/genproto v0.0.0-20200904004341-0bd0a958aa1d/go.mod h1:FWY/as6DDZQgahTzZj3fqbO1CbirC29ZNUFHwi0/+no=
+google.golang.org/genproto v0.0.0-20201109203340-2640f1f9cdfb/go.mod h1:FWY/as6DDZQgahTzZj3fqbO1CbirC29ZNUFHwi0/+no=
+google.golang.org/genproto v0.0.0-20201201144952-b05cb90ed32e/go.mod h1:FWY/as6DDZQgahTzZj3fqbO1CbirC29ZNUFHwi0/+no=
+google.golang.org/genproto v0.0.0-20201210142538-e3217bee35cc/go.mod h1:FWY/as6DDZQgahTzZj3fqbO1CbirC29ZNUFHwi0/+no=
+google.golang.org/genproto v0.0.0-20201214200347-8c77b98c765d/go.mod h1:FWY/as6DDZQgahTzZj3fqbO1CbirC29ZNUFHwi0/+no=
+google.golang.org/genproto v0.0.0-20210222152913-aa3ee6e6a81c/go.mod h1:FWY/as6DDZQgahTzZj3fqbO1CbirC29ZNUFHwi0/+no=
+google.golang.org/genproto v0.0.0-20210303154014-9728d6b83eeb/go.mod h1:FWY/as6DDZQgahTzZj3fqbO1CbirC29ZNUFHwi0/+no=
+google.golang.org/genproto v0.0.0-20210310155132-4ce2db91004e/go.mod h1:FWY/as6DDZQgahTzZj3fqbO1CbirC29ZNUFHwi0/+no=
+google.golang.org/genproto v0.0.0-20210319143718-93e7006c17a6/go.mod h1:FWY/as6DDZQgahTzZj3fqbO1CbirC29ZNUFHwi0/+no=
+google.golang.org/genproto v0.0.0-20210402141018-6c239bbf2bb1/go.mod h1:9lPAdzaEmUacj36I+k7YKbEc5CXzPIeORRgDAUOu28A=
+google.golang.org/genproto v0.0.0-20210602131652-f16073e35f0c/go.mod h1:UODoCrxHCcBojKKwX1terBiRUaqAsFqJiF615XL43r0=
 google.golang.org/grpc v1.17.0 h1:TRJYBgMclJvGYn2rIMjj+h9KtMt5r1Ij7ODVRIZkwhk=
 google.golang.org/grpc v1.17.0/go.mod h1:6QZJwpn2B+Zp71q/5VxRsJ6NXXVCE5NRUHRo+f3cWCs=
 google.golang.org/grpc v1.19.0/go.mod h1:mqu4LbDTu4XGKhr4mRzUsmM4RtVoemTSY81AxZiDr8c=
@@ -600,6 +767,14 @@ google.golang.org/grpc v1.28.0/go.mod h1:rpkK4SK4GF4Ach/+MFLZUBavHOvF2JJB5uozKKa
 google.golang.org/grpc v1.29.1/go.mod h1:itym6AZVZYACWQqET3MqgPpjcuV5QH3BxFS3IjizoKk=
 google.golang.org/grpc v1.30.0/go.mod h1:N36X2cJ7JwdamYAgDz+s+rVMFjt3numwzf/HckM8pak=
 google.golang.org/grpc v1.31.0/go.mod h1:N36X2cJ7JwdamYAgDz+s+rVMFjt3numwzf/HckM8pak=
+google.golang.org/grpc v1.31.1/go.mod h1:N36X2cJ7JwdamYAgDz+s+rVMFjt3numwzf/HckM8pak=
+google.golang.org/grpc v1.33.1/go.mod h1:fr5YgcSWrqhRRxogOsw7RzIpsmvOZ6IcH4kBYTpR3n0=
+google.golang.org/grpc v1.33.2/go.mod h1:JMHMWHQWaTccqQQlmk3MJZS+GWXOdAesneDmEnv2fbc=
+google.golang.org/grpc v1.34.0/go.mod h1:WotjhfgOW/POjDeRt8vscBtXq+2VjORFy659qA51WJ8=
+google.golang.org/grpc v1.35.0/go.mod h1:qjiiYl8FncCW8feJPdyg3v6XW24KsRHe+dy9BAGRRjU=
+google.golang.org/grpc v1.36.0/go.mod h1:qjiiYl8FncCW8feJPdyg3v6XW24KsRHe+dy9BAGRRjU=
+google.golang.org/grpc v1.36.1/go.mod h1:qjiiYl8FncCW8feJPdyg3v6XW24KsRHe+dy9BAGRRjU=
+google.golang.org/grpc v1.38.0/go.mod h1:NREThFqKR1f3iQ6oBuvc5LadQuXVGo9rkm5ZGrQdJfM=
 google.golang.org/protobuf v0.0.0-20200109180630-ec00e32a8dfd/go.mod h1:DFci5gLYBciE7Vtevhsrf46CRTquxDuWsQurQQe4oz8=
 google.golang.org/protobuf v0.0.0-20200221191635-4d8936d0db64/go.mod h1:kwYJMbMJ01Woi6D6+Kah6886xMZcty6N08ah7+eCXa0=
 google.golang.org/protobuf v0.0.0-20200228230310-ab0ca4ff8a60/go.mod h1:cfTl7dwQJ+fmap5saPgwCLgHXTUD7jkjRqWcaiX5VyM=
@@ -612,6 +787,9 @@ google.golang.org/protobuf v1.23.1-0.20200526195155-81db48ad09cc/go.mod h1:EGpAD
 google.golang.org/protobuf v1.24.0/go.mod h1:r/3tXBNzIEhYS9I1OUVjXDlt8tc493IdKGjtUeSXeh4=
 google.golang.org/protobuf v1.25.0 h1:Ejskq+SyPohKW+1uil0JJMtmHCgJPJ/qWTxr8qp+R4c=
 google.golang.org/protobuf v1.25.0/go.mod h1:9JNX74DMeImyA3h4bdi1ymwjUzf21/xIlbajtzgsN7c=
+google.golang.org/protobuf v1.26.0-rc.1/go.mod h1:jlhhOSvTdKEhbULTjvd4ARK9grFBp09yW+WbY/TyQbw=
+google.golang.org/protobuf v1.26.0 h1:bxAC2xTBsZGibn2RTntX0oH50xLsqy1OxA9tTL3p/lk=
+google.golang.org/protobuf v1.26.0/go.mod h1:9q0QmTI4eRPtz6boOQmLYwt+qCgq0jsYwAQnmE0givc=
 gopkg.in/alecthomas/kingpin.v2 v2.2.6/go.mod h1:FMv+mEhP44yOT+4EoQTLFTRgOQ1FBLkstjWtayDeSgw=
 gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod h1:Co6ibVJAznAaIkqp8huTwlJQCZ016jof/cbN4VW5Yz0=
 gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127 h1:qIbj1fsPNlZgppZ+VLlY7N33q108Sa+fhmuc+sWQYwY=
@@ -620,17 +798,24 @@ gopkg.in/check.v1 v1.0.0-20190902080502-41f04d3bba15/go.mod h1:Co6ibVJAznAaIkqp8
 gopkg.in/errgo.v2 v2.1.0/go.mod h1:hNsd1EY+bozCKY1Ytp96fpM3vjJbqLJn88ws8XvfDNI=
 gopkg.in/fsnotify.v1 v1.4.7 h1:xOHLXZwVvI9hhs+cLKq5+I5onOuwQLhQwiu63xxlHs4=
 gopkg.in/fsnotify.v1 v1.4.7/go.mod h1:Tz8NjZHkW78fSQdbUxIjBTcgA1z1m8ZHf0WmKUhAMys=
+gopkg.in/ini.v1 v1.62.0/go.mod h1:pNLf8WUiyNEtQjuu5G5vTm06TEv9tsIgeAvK8hOrP4k=
 gopkg.in/natefinch/lumberjack.v2 v2.0.0/go.mod h1:l0ndWWf7gzL7RNwBG7wST/UCcT4T24xpD6X8LsfU/+k=
 gopkg.in/square/go-jose.v2 v2.4.1/go.mod h1:M9dMgbHiYLoDGQrXy7OpJDJWiKiU//h+vD76mk0e1AI=
 gopkg.in/tomb.v1 v1.0.0-20141024135613-dd632973f1e7 h1:uRGJdciOHaEIrze2W8Q3AKkepLTh2hOroT7a+7czfdQ=
 gopkg.in/tomb.v1 v1.0.0-20141024135613-dd632973f1e7/go.mod h1:dt/ZhP58zS4L8KSrWDmTeBkI65Dw0HsyUHuEVlX15mw=
 gopkg.in/yaml.v2 v2.2.1/go.mod h1:hI93XBmqTisBFMUTm0b8Fm+jr3Dg1NNxqwp+5A1VGuI=
 gopkg.in/yaml.v2 v2.2.2/go.mod h1:hI93XBmqTisBFMUTm0b8Fm+jr3Dg1NNxqwp+5A1VGuI=
+gopkg.in/yaml.v2 v2.2.3/go.mod h1:hI93XBmqTisBFMUTm0b8Fm+jr3Dg1NNxqwp+5A1VGuI=
 gopkg.in/yaml.v2 v2.2.4/go.mod h1:hI93XBmqTisBFMUTm0b8Fm+jr3Dg1NNxqwp+5A1VGuI=
 gopkg.in/yaml.v2 v2.2.5/go.mod h1:hI93XBmqTisBFMUTm0b8Fm+jr3Dg1NNxqwp+5A1VGuI=
 gopkg.in/yaml.v2 v2.2.7/go.mod h1:hI93XBmqTisBFMUTm0b8Fm+jr3Dg1NNxqwp+5A1VGuI=
+gopkg.in/yaml.v2 v2.2.8/go.mod h1:hI93XBmqTisBFMUTm0b8Fm+jr3Dg1NNxqwp+5A1VGuI=
 gopkg.in/yaml.v2 v2.3.0 h1:clyUAQHOM3G0M3f5vQj7LuJrETvjVot3Z5el9nffUtU=
 gopkg.in/yaml.v2 v2.3.0/go.mod h1:hI93XBmqTisBFMUTm0b8Fm+jr3Dg1NNxqwp+5A1VGuI=
+gopkg.in/yaml.v2 v2.4.0 h1:D8xgwECY7CYvx+Y2n4sBz93Jn9JRvxdiyyo8CTfuKaY=
+gopkg.in/yaml.v2 v2.4.0/go.mod h1:RDklbk79AGWmwhnvt/jBztapEOGDOx6ZbXqjP6csGnQ=
+gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod h1:K4uyk7z7BCEPqu6E+C64Yfv1cQ7kz7rIZviUmN+EgEM=
+gopkg.in/yaml.v3 v3.0.0-20210107192922-496545a6307b/go.mod h1:K4uyk7z7BCEPqu6E+C64Yfv1cQ7kz7rIZviUmN+EgEM=
 gotest.tools v0.0.0-20181223230014-1083505acf35 h1:zpdCK+REwbk+rqjJmHhiCN6iBIigrZ39glqSF0P3KF0=
 gotest.tools v0.0.0-20181223230014-1083505acf35/go.mod h1:R//lfYlUuTOTfblYI3lGoAAAebUdzjvbmQsuB7Ykd90=
 honnef.co/go/tools v0.0.0-20180728063816-88497007e858/go.mod h1:rf3lG4BRIbNafJWhAfAdb/ePZxsR/4RtNHQocxwk9r4=
diff --git a/pkg/ctl/completion/completion.go b/pkg/ctl/completion/completion.go
deleted file mode 100644
index ce7da1c..0000000
--- a/pkg/ctl/completion/completion.go
+++ /dev/null
@@ -1,82 +0,0 @@
-// Licensed to the Apache Software Foundation (ASF) under one
-// or more contributor license agreements.  See the NOTICE file
-// distributed with this work for additional information
-// regarding copyright ownership.  The ASF licenses this file
-// to you under the Apache License, Version 2.0 (the
-// "License"); you may not use this file except in compliance
-// with the License.  You may obtain a copy of the License at
-//
-//   http://www.apache.org/licenses/LICENSE-2.0
-//
-// Unless required by applicable law or agreed to in writing,
-// software distributed under the License is distributed on an
-// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
-// KIND, either express or implied.  See the License for the
-// specific language governing permissions and limitations
-// under the License.
-
-package completion
-
-import (
-	"os"
-
-	"github.com/kris-nova/logger"
-	"github.com/spf13/cobra"
-)
-
-func Command(rootCmd *cobra.Command) *cobra.Command {
-	var bashCompletionCmd = &cobra.Command{
-		Use:   "bash",
-		Short: "Generates bash completion scripts",
-		Long: `To load completion run
-
-. <(pulsarctl completion bash)
-
-To configure your bash shell to load completions for each session add to your bashrc
-
-# ~/.bashrc or ~/.profile
-. <(pulsarctl completion bash)
-
-If you are stuck on Bash 3 (macOS) use
-
-source /dev/stdin <<<"$(pulsarctl completion bash)"
-`,
-		RunE: func(cmd *cobra.Command, args []string) error {
-			return rootCmd.GenBashCompletion(os.Stdout)
-		},
-	}
-
-	var zshCompletionCmd = &cobra.Command{
-		Use:   "zsh",
-		Short: "Generates zsh completion scripts",
-		Long: `To configure your zsh shell, run:
-
-mkdir -p ~/.zsh/completion/
-pulsarctl completion zsh > ~/.zsh/completion/_pulsarctl
-
-# Include the directory in your $fpath, for example by adding in ~/.zshrc:
-fpath=($fpath ~/.zsh/completion)
-
-# You may have to force rebuild zcompdump:
-rm -f ~/.zcompdump; compinit
-`,
-		RunE: func(cmd *cobra.Command, args []string) error {
-			return rootCmd.GenZshCompletion(os.Stdout)
-		},
-	}
-
-	cmd := &cobra.Command{
-		Use:   "completion",
-		Short: "Generates shell completion scripts",
-		Run: func(cmd *cobra.Command, args []string) {
-			if err := cmd.Help(); err != nil {
-				logger.Debug("ignoring error %q", err.Error())
-			}
-		},
-	}
-
-	cmd.AddCommand(bashCompletionCmd)
-	cmd.AddCommand(zshCompletionCmd)
-
-	return cmd
-}
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
