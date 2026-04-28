Return-Path: <linux-rdma+bounces-19698-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKSlFUc18WltegEAu9opvQ
	(envelope-from <linux-rdma+bounces-19698-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:31:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E605248CA07
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF9FF31200AE
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 22:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D1137F72D;
	Tue, 28 Apr 2026 22:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJ4oQ55x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E7F37F728;
	Tue, 28 Apr 2026 22:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777415243; cv=none; b=AE6JA8IYPyrDr1kZ9eOWTz2mY56QLe9YvnLaCyt/vQJ+Txd4HKNsm3u7kbT2tFEs073ADg2y/nqb84XuRKGISoiJoO7ocHWvGsmNlkHSHFUrQ56kpAOkeNJM1KhZ2NjLMaBmsDAbqaz+EzMVOonY0run206Tnt7SiOfrsn2odeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777415243; c=relaxed/simple;
	bh=4n2kKgEphFG3liuH2VGMUuhJ/xFkobdIxnWp8con/vc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LGm/0KKy0HuwTnEiQvRLI621w/hbi1uJ0y9qUzx7VkFTfHSaIdFi2m0Z5xQtT1bT3thnrSglKkzEDMwXiUjrt5c3fNdUezk05GQ7KyLaVGgvhEk+QJR5I6oUXDsepRonPsUDdg5NUsPX8wet1yJStq8AVoYqNgnwuj2lHz730BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJ4oQ55x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08297C2BCB3;
	Tue, 28 Apr 2026 22:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777415243;
	bh=4n2kKgEphFG3liuH2VGMUuhJ/xFkobdIxnWp8con/vc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WJ4oQ55x6t8RsZhcAbCef1RmUe3o9tAegBhqy8BI0k+mi487sOQpt1K3oUMTAwugk
	 t/8DDlXS56JclAuWo0zyztY7UW6fIVBrmHaD0dHZA5J5YFvDsTQRHi4J+7Rt4OeqIi
	 ltOWX/AYZooQL2DkTeW4ABVv+l5miWP/RYKGUj+Tgm6yVyS3xTabpXdqPN3KIoietM
	 57upJRvLH7qWfs1jnjq7lWah9kD4ZNSv+0oJRMEXyI4Idrm72VdSllMP9i76UilTr6
	 l0uo/Czyh8w5iWWdYZG5gY4vPQQlC9tug8g8apHMMHelbHHDSIWjzZVWGJZTv02aMQ
	 00osBnQqL8sHg==
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
Subject: [PATCH net-next v2 7/7] selftests: rds: Make rds selftests TAP compliant
Date: Tue, 28 Apr 2026 15:27:16 -0700
Message-Id: <20260428222716.2960871-8-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260428222716.2960871-1-achender@kernel.org>
References: <20260428222716.2960871-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E605248CA07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19698-lists,linux-rdma=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This patch updates the rds selftests output to be TAP compliant.

Use ksft_pr() to mark debug output with a leading '# ' so that TAP
parsers treat it as commentary, and convert all informational print()
calls to use ksft_pr(). sys.exit(0) is changed to os._exit(0) to
avoid duplicate prints from the buffered TAP output. The console
output from the tcpdump subprocess is silenced, and the gcov console
output is redirected to a gcovr.log.

Finally adjust the exit path so that the hash check loop sets a
return code instead exiting directly. Then print the TAP results
and totals lines before exiting.

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/run.sh  | 18 +++++----
 tools/testing/selftests/net/rds/test.py | 54 ++++++++++++++++---------
 2 files changed, 45 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/net/rds/run.sh b/tools/testing/selftests/net/rds/run.sh
index 3fc116d23410..805cd0915585 100755
--- a/tools/testing/selftests/net/rds/run.sh
+++ b/tools/testing/selftests/net/rds/run.sh
@@ -205,8 +205,8 @@ if ! mountpoint -q /tmp 2>/dev/null; then
 fi
 
 set +e
-echo running RDS tests...
-echo Traces will be logged to "$TRACE_FILE"
+echo "# running RDS tests..."
+echo "# Traces will be logged to $TRACE_FILE"
 rm -f "$TRACE_FILE"
 strace -T -tt -o "$TRACE_FILE" python3 "$(dirname "$0")/test.py" \
 	-t "$TIMEOUT" -d "$LOG_DIR" -l "$PLOSS" -c "$PCORRUPT" \
@@ -216,7 +216,7 @@ test_rc=$?
 dmesg > "${LOG_DIR}/dmesg.out"
 
 if [ "$GENERATE_GCOV_REPORT" -eq 1 ]; then
-       echo saving coverage data...
+       echo "# saving coverage data..."
 
        # Ensure debugfs is mounted
        if ! test -d /sys/kernel/debug/gcov; then
@@ -229,17 +229,19 @@ if [ "$GENERATE_GCOV_REPORT" -eq 1 ]; then
                cat < "/sys/kernel/debug/gcov/$f" > "/$f"
        done)
 
-       echo running gcovr...
+       echo "# running gcovr..."
        gcovr -s --html-details --gcov-executable "$GCOV_CMD" --gcov-ignore-parse-errors \
-             --root "${ksrc_dir}" -o "${COVR_DIR}/gcovr" "${ksrc_dir}/net/rds/"
+             --root "${ksrc_dir}" -o "${COVR_DIR}/gcovr" "${ksrc_dir}/net/rds/" \
+             > "${LOG_DIR}/gcovr.log" 2>&1
+       echo "# gcovr log: ${LOG_DIR}/gcovr.log"
 else
-       echo "Coverage report will be skipped"
+       echo "# Coverage report will be skipped"
 fi
 
 if [ "$test_rc" -eq 0 ]; then
-	echo "PASS: Test completed successfully"
+	echo "# PASS: Test completed successfully"
 else
-	echo "FAIL: Test failed"
+	echo "# FAIL: Test failed"
 fi
 
 exit "$test_rc"
diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
index 1c7aebddeb61..530ad9f9acba 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -22,6 +22,8 @@ this_dir = os.path.dirname(os.path.realpath(__file__))
 sys.path.append(os.path.join(this_dir, "../"))
 # pylint: disable-next=wrong-import-position,import-error,no-name-in-module
 from lib.py.utils import ip # noqa: E402
+# pylint: disable-next=wrong-import-position,import-error,no-name-in-module
+from lib.py.ksft import ksft_pr # noqa: E402
 
 libc = ctypes.cdll.LoadLibrary('libc.so.6')
 setns = libc.setns
@@ -61,7 +63,7 @@ def netns_socket(netns, *sock_args):
         # send resulting socket to parent
         socket.send_fds(u0, [], [sock.fileno()])
 
-        sys.exit(0)
+        os._exit(0)
 
     # receive socket from child
     _, fds, _, _ = socket.recv_fds(u1, 0, 1)
@@ -72,7 +74,7 @@ def netns_socket(netns, *sock_args):
 
 def collect_pcaps():
     """Stop tcpdump processes and move their pcaps into the log dir."""
-    print("Stopping network packet captures")
+    ksft_pr("Stopping network packet captures")
     for proc, tmp_path, dest_path, fno in tcpdump_procs:
         proc.terminate()
         proc.wait()
@@ -83,8 +85,9 @@ def signal_handler(_sig, _frame):
     """
     Test timed out signal handler
     """
-    print('Test timed out')
+    ksft_pr("Test timed out")
     collect_pcaps()
+    print("not ok 1 rds selftest")
     sys.exit(1)
 
 #Parse out command line arguments.  We take an optional
@@ -146,7 +149,8 @@ for net in [NET0, NET1]:
     # pylint: disable-next=consider-using-with
     p = subprocess.Popen(
         ['ip', 'netns', 'exec', net,
-         '/usr/sbin/tcpdump', '-i', 'any', '-w', pcap_tmp])
+         '/usr/sbin/tcpdump', '-i', 'any', '-w', pcap_tmp],
+         stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
     tcpdump_procs.append((p, pcap_tmp, pcap, fd))
 
 # simulate packet loss, duplication and corruption
@@ -155,6 +159,9 @@ for net, iface in [(NET0, VETH0), (NET1, VETH1)]:
          corrupt {PACKET_CORRUPTION} loss {PACKET_LOSS} duplicate  \
          {PACKET_DUPLICATE}")
 
+print("TAP version 13")
+print("1..1")
+
 # add a timeout
 if args.timeout > 0:
     signal.alarm(args.timeout)
@@ -193,7 +200,7 @@ nr_recv = 0
 
 while nr_send < NUM_PACKETS:
     # Send as much as we can without blocking
-    print("sending...", nr_send, nr_recv)
+    ksft_pr("sending...", nr_send, nr_recv)
     while nr_send < NUM_PACKETS:
         send_data = hashlib.sha256(
             f'packet {nr_send}'.encode('utf-8')).hexdigest().encode('utf-8')
@@ -215,7 +222,7 @@ while nr_send < NUM_PACKETS:
             raise
 
     # Receive as much as we can without blocking
-    print("receiving...", nr_send, nr_recv)
+    ksft_pr("receiving...", nr_send, nr_recv)
     while nr_recv < nr_send:
         for fileno, eventmask in ep.poll():
             receiver = fileno_to_socket[fileno]
@@ -237,7 +244,7 @@ while nr_send < NUM_PACKETS:
         ip(f"netns exec {net} /usr/sbin/sysctl net.rds.tcp.rds_tcp_rcvbuf=10000")
         ip(f"netns exec {net} /usr/sbin/sysctl net.rds.tcp.rds_tcp_sndbuf=10000")
 
-print("done", nr_send, nr_recv)
+ksft_pr("done", nr_send, nr_recv)
 
 # the Python socket module doesn't know these
 RDS_INFO_FIRST = 10000
@@ -260,25 +267,34 @@ for s in sockets:
                 # ignore
                 pass
 
-print(f"getsockopt(): {nr_success}/{nr_error}")
+ksft_pr(f"getsockopt(): {nr_success}/{nr_error}")
 collect_pcaps()
 
 # We're done sending and receiving stuff, now let's check if what
 # we received is what we sent.
+ret = 0
 for (sender, receiver), send_hash in send_hashes.items():
     recv_hash = recv_hashes.get((sender, receiver))
 
     if recv_hash is None:
-        print("FAIL: No data received")
-        sys.exit(1)
+        ksft_pr("FAIL: No data received")
+        ret = 1
+        break
 
     if send_hash.hexdigest() != recv_hash.hexdigest():
-        print("FAIL: Send/recv mismatch")
-        print("hash expected:", send_hash.hexdigest())
-        print("hash received:", recv_hash.hexdigest())
-        sys.exit(1)
-
-    print(f"{sender}/{receiver}: ok")
-
-print("Success")
-sys.exit(0)
+        ksft_pr("FAIL: Send/recv mismatch")
+        ksft_pr("hash expected:", send_hash.hexdigest())
+        ksft_pr("hash received:", recv_hash.hexdigest())
+        ret = 1
+        break
+
+    ksft_pr(f"{sender}/{receiver}: ok")
+
+if ret == 0:
+    ksft_pr("Success")
+    print("ok 1 rds selftest")
+else:
+    print("not ok 1 rds selftest")
+
+ksft_pr(f"Totals: pass:{1-ret} fail:{ret} skip:0")
+sys.exit(ret)
-- 
2.25.1


