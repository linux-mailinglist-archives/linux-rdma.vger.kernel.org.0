Return-Path: <linux-rdma+bounces-19897-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OA80NOgx+GlBrQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19897-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 07:43:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5001B4B8A31
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 07:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5748301B164
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 05:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AD62BE65B;
	Mon,  4 May 2026 05:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgRQRXI4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEEE2BD58A;
	Mon,  4 May 2026 05:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777873308; cv=none; b=uH2c0tKn3760FGMZXzAqO33WVqtwTlukuRw+G3YkT2941tJAQp1d7Sxb2Hlkwz2qkO7QxNGPmFzub7VnsrS0JgTdlZzfdlVh+ckqDy1Gv03VnzKAU5vKNxgUsscK2fDCz0CNDKf/Q2lmcNcew4wP+A9RGoK8X2VFsbYkvsgXvlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777873308; c=relaxed/simple;
	bh=iicQIB0iexrTkwzjP/BTSfnR8bW5k29hd0OyJrHoVcs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mwl68zZ49OUKN6owteUqW78oJab3SNC0eIsw6Mnl6TDV397FMrg2ZF12fA2WJQMFtc5EDVlZBUUZSYt7nokzKZLQyOTUlhg1s/TZWxxnYTGh+zcn0vE+H4mwj7XlaZx7qxsKTfpoabH4ea8bS3vg4ybMZnVADvflDRKVVvztDh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgRQRXI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24D3C2BCF4;
	Mon,  4 May 2026 05:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777873308;
	bh=iicQIB0iexrTkwzjP/BTSfnR8bW5k29hd0OyJrHoVcs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lgRQRXI4qPR+aIlN0fFFWlOoiy/SszVowP79e7x2sh5n7KUulOgeCmJIs8QGcmgcs
	 m4Mo5+pbU3XFXT16hc17a+ulYVIG+L4ZUeqR703TY3LRc0M8F8fWzSYhOwMKPcal2w
	 dfGcVqPudmi9Q1vTzs6Yqij/cJxmjiVqFnI0J3JL66OzK1LWVUuwZT66t77czjcJa4
	 cr7dGjbJvJa2gV5dM/+g0DGfRXC93NNOO6CKgtivF/GkINCc47xPgHyoZFbCgZfZCB
	 OnA/KTZNl20eoHkhwukHHB5eYrIywBOdzOYksnJITjiZZ+sg3H5aQ+qHX56JCNuTg2
	 nXjM6QaiQJzjg==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	achender@kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: [PATCH net-next v3 05/10] selftests: rds: Add RDS_LOG_DIR env variable
Date: Sun,  3 May 2026 22:41:38 -0700
Message-Id: <20260504054143.4027538-6-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260504054143.4027538-1-achender@kernel.org>
References: <20260504054143.4027538-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5001B4B8A31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-19897-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[run.sh:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

This patch modifies the rds selftest to look for an env variable
RDS_LOG_DIR, and log all traces, pcaps and gcov collections to
the folder specified in RDS_LOG_DIR.  If RDS_LOG_DIR is unset,
logs are not collected.

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/README.txt | 19 +++++++--
 tools/testing/selftests/net/rds/run.sh     | 45 ++++++++++++----------
 tools/testing/selftests/net/rds/test.py    | 34 ++++++++--------
 3 files changed, 59 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/net/rds/README.txt b/tools/testing/selftests/net/rds/README.txt
index be9c7e25694e..e629e08f04ef 100644
--- a/tools/testing/selftests/net/rds/README.txt
+++ b/tools/testing/selftests/net/rds/README.txt
@@ -15,7 +15,9 @@ USAGE:
 	       [-u packet_duplicate] [-t timeout]
 
 OPTIONS:
-	-d	Log directory.  Defaults to tools/testing/selftests/net/rds/rds_logs
+	-d	Log directory.  If set, logs will be stored in the
+		given dir, or skipped if unset.  Log dir can also be
+		set through the RDS_LOG_DIR env variable
 
 	-l	Simulates a percentage of packet loss
 
@@ -25,6 +27,16 @@ OPTIONS:
 
 	-t	Test timeout.  Defaults to tools/testing/selftests/net/rds/settings
 
+ENV VARIABLES:
+	RDS_LOG_DIR	Log directory.  If set, logs will be stored in
+			the given dir, or skipped if unset. Log dir
+			can also be set with the -d flag.
+
+			Use with --rwdir on the CI path to retain logs after
+			test compleation.  Log dir end point must be within
+			the specified --rwdir path for logs to persist on
+			the host.
+
 EXAMPLE:
 
     # Create a suitable gcov enabled .config
@@ -41,6 +53,7 @@ EXAMPLE:
 
     # launch the tests in a VM
     vng -v --rwdir ./ --run . --user root --cpus 4 -- \
-        "export PYTHONPATH=tools/testing/selftests/net/; tools/testing/selftests/net/rds/run.sh"
+        "export PYTHONPATH=tools/testing/selftests/net/; \
+         export RDS_LOG_DIR=tools/testing/selftests/net/rds/rds_logs; \
+         tools/testing/selftests/net/rds/run.sh"
 
-An HTML coverage report will be output in tools/testing/selftests/net/rds/rds_logs/coverage/.
diff --git a/tools/testing/selftests/net/rds/run.sh b/tools/testing/selftests/net/rds/run.sh
index bc2e53126aab..edc021f4dec9 100755
--- a/tools/testing/selftests/net/rds/run.sh
+++ b/tools/testing/selftests/net/rds/run.sh
@@ -150,28 +150,26 @@ check_env()
 	fi
 }
 
-LOG_DIR="$current_dir"/rds_logs
-PLOSS=0
-PCORRUPT=0
-PDUP=0
+LOG_DIR="${RDS_LOG_DIR:-}"
 TIMEOUT=$timeout
 GENERATE_GCOV_REPORT=1
+FLAGS=()
 while getopts "d:l:c:u:t:" opt; do
   case ${opt} in
     d)
       LOG_DIR=${OPTARG}
       ;;
     l)
-      PLOSS=${OPTARG}
+      FLAGS+=("-l" "${OPTARG}")
       ;;
     c)
-      PCORRUPT=${OPTARG}
+      FLAGS+=("-c" "${OPTARG}")
       ;;
     t)
       TIMEOUT=${OPTARG}
       ;;
     u)
-      PDUP=${OPTARG}
+      FLAGS+=("-u" "${OPTARG}")
       ;;
     :)
       echo "USAGE: run.sh [-d logdir] [-l packet_loss] [-c packet_corruption]" \
@@ -185,30 +183,37 @@ while getopts "d:l:c:u:t:" opt; do
   esac
 done
 
-
 check_env
 check_conf
 check_gcov_conf
 
+TRACE_CMD=()
+if [[ -n "$LOG_DIR" ]]; then
+   rm -fr "$LOG_DIR"
+   FLAGS+=("-d" "$LOG_DIR")
+
+   TRACE_FILE="${LOG_DIR}/rds-strace.txt"
+   COVR_DIR="${LOG_DIR}/coverage/"
+   mkdir -p  "$LOG_DIR"
+   mkdir -p "$COVR_DIR"
+
+   echo Traces will be logged to "${TRACE_FILE}"
+   rm -f "$TRACE_FILE"
 
-rm -fr "$LOG_DIR"
-TRACE_FILE="${LOG_DIR}/rds-strace.txt"
-COVR_DIR="${LOG_DIR}/coverage/"
-mkdir -p  "$LOG_DIR"
-mkdir -p "$COVR_DIR"
+   TRACE_CMD=(strace -T -tt -o "${TRACE_FILE}")
+fi
 
 set +e
 echo running RDS tests...
-echo Traces will be logged to "$TRACE_FILE"
-rm -f "$TRACE_FILE"
-strace -T -tt -o "$TRACE_FILE" python3 "$(dirname "$0")/test.py" \
-	-t "$TIMEOUT" -d "$LOG_DIR" -l "$PLOSS" -c "$PCORRUPT" \
-	-u "$PDUP"
+"${TRACE_CMD[@]}" python3 "$(dirname "$0")/test.py" "${FLAGS[@]}" -t "$TIMEOUT"
 
 test_rc=$?
-dmesg > "${LOG_DIR}/dmesg.out"
 
-if [ "$GENERATE_GCOV_REPORT" -eq 1 ]; then
+if [[ -n "$LOG_DIR" ]]; then
+   dmesg > "${LOG_DIR}/dmesg.out"
+fi
+
+if [[ -n "$LOG_DIR" ]] && [ "$GENERATE_GCOV_REPORT" -eq 1 ]; then
        echo saving coverage data...
        (set +x; cd /sys/kernel/debug/gcov; find ./* -name '*.gcda' | \
        while read -r f
diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
index d48533505f0f..0ece8324d255 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -82,7 +82,7 @@ def signal_handler(_sig, _frame):
 parser = argparse.ArgumentParser(description="init script args",
                   formatter_class=argparse.ArgumentDefaultsHelpFormatter)
 parser.add_argument("-d", "--logdir", action="store",
-                    help="directory to store logs", default="/tmp")
+                    help="directory to store logs", default=None)
 parser.add_argument('-t', '--timeout', help="timeout to terminate hung test",
                     type=int, default=0)
 parser.add_argument('-l', '--loss', help="Simulate tcp packet loss",
@@ -128,16 +128,17 @@ ip(f"-n {NET1} route add {addrs[0][0]}/32 dev {VETH1}")
 # and communicating by doing a single ping
 ip(f"netns exec {NET0} ping -c 1 {addrs[1][0]}")
 
-# Start a packet capture on each network
 tcpdump_procs = []
-for net in [NET0, NET1]:
-    pcap = logdir+'/'+net+'.pcap'
-    fd, pcap_tmp = tempfile.mkstemp(suffix=".pcap", prefix=f"{net}-", dir="/tmp")
-    # pylint: disable-next=consider-using-with
-    p = subprocess.Popen(
-        ['ip', 'netns', 'exec', net,
-         '/usr/sbin/tcpdump', '-i', 'any', '-w', pcap_tmp])
-    tcpdump_procs.append((p, pcap_tmp, pcap, fd))
+# Start a packet capture on each network
+if logdir is not None:
+    for net in [NET0, NET1]:
+        pcap = logdir+'/'+net+'.pcap'
+        fd, pcap_tmp = tempfile.mkstemp(suffix=".pcap", prefix=f"{net}-", dir="/tmp")
+        # pylint: disable-next=consider-using-with
+        p = subprocess.Popen(
+            ['ip', 'netns', 'exec', net,
+             '/usr/sbin/tcpdump', '-i', 'any', '-w', pcap_tmp])
+        tcpdump_procs.append((p, pcap_tmp, pcap, fd))
 
 # simulate packet loss, duplication and corruption
 for net, iface in [(NET0, VETH0), (NET1, VETH1)]:
@@ -252,12 +253,13 @@ for s in sockets:
 
 print(f"getsockopt(): {nr_success}/{nr_error}")
 
-print("Stopping network packet captures")
-for p, pcap_tmp, pcap, fd in tcpdump_procs:
-    p.terminate()
-    p.wait()
-    os.close(fd)
-    shutil.move(pcap_tmp, pcap)
+if logdir is not None:
+    print("Stopping network packet captures")
+    for p, pcap_tmp, pcap, fd in tcpdump_procs:
+        p.terminate()
+        p.wait()
+        os.close(fd)
+        shutil.move(pcap_tmp, pcap)
 
 # We're done sending and receiving stuff, now let's check if what
 # we received is what we sent.
-- 
2.25.1


