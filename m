Return-Path: <linux-rdma+bounces-19902-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2APMETEy+GlBrQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19902-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 07:44:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 064D94B8A92
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 07:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22E37300D615
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 05:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C812DB7BA;
	Mon,  4 May 2026 05:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZcnbb8B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE642DA74A;
	Mon,  4 May 2026 05:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777873311; cv=none; b=ERZ+yhpYP/Gwd5XKZ0xClE3skx8VHKyYbzw6u99FySVbUYU48r2sdSIm9Hf7cxQ7ltnnZQ3DewGiUn7H6iKEE/5ImpZCocf+pUHVyY7VAJIT7YtCAB5gGTwI0cQrR3QbWagOZUnGCaZJE68EhOWCJkHcNqX2e0BYfSvdIEm0y2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777873311; c=relaxed/simple;
	bh=5LJ0h2VmJjwEk6HzMZgrvmBpuYmQnMrK9aBruHI/17w=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YcQLIlgT3caHMQL1s0dqk7gMg0CmwRzl2av9gbTLv1y/NtPh9ZwKvW8HiHm9FbU/ApoOslEeia4nCRQjQMQg59cfhahwhla3oDWjGXfJyAcFHQSgIsc3QRw588v7hN5GXuLbdvMfSmHSGsSjCOEO5WcKs481iLBzFgUxMJ5pW6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZcnbb8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C48EC2BCC9;
	Mon,  4 May 2026 05:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777873311;
	bh=5LJ0h2VmJjwEk6HzMZgrvmBpuYmQnMrK9aBruHI/17w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NZcnbb8BX0kWIZLB5SFBFqyUtyxUmDL7xzH7Mx9eE0nTiwldcAheucbM2T0A7xDUP
	 6XnLd1U/qlcD2zGbjfQS0BSw+alWSYyK/VuuXYbQ0nroRQibKVQhxn6PafYNcQqZeX
	 EJIM7hAeoBtoIK5LsPnQ8tNfS9BbhX8dQi7Sw+Q4sJP5BmDGmmedr11WfZjxmr/Ysq
	 qHUJvKx35m1bHKi6lCjfbx//7/AcwuNYzV0+P4S+3c/6J3bH7BP31Y1M4Lr5ioLlO3
	 8GGBBLncXtQayQr9GIZNB0yl+OTDLLZBQBGickivC6Co4NGmMGbu506JteBAYmR4Vm
	 F7VWHDplD4ufQ==
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
Subject: [PATCH net-next v3 10/10] selftests: rds: Make rds selftests TAP compliant
Date: Sun,  3 May 2026 22:41:43 -0700
Message-Id: <20260504054143.4027538-11-achender@kernel.org>
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
X-Rspamd-Queue-Id: 064D94B8A92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-19902-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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
 tools/testing/selftests/net/rds/run.sh  | 18 ++++----
 tools/testing/selftests/net/rds/test.py | 55 ++++++++++++++++---------
 2 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/net/rds/run.sh b/tools/testing/selftests/net/rds/run.sh
index c07e3785ff79..2404a889767a 100755
--- a/tools/testing/selftests/net/rds/run.sh
+++ b/tools/testing/selftests/net/rds/run.sh
@@ -197,14 +197,14 @@ if [[ -n "$LOG_DIR" ]]; then
    mkdir -p  "$LOG_DIR"
    mkdir -p "$COVR_DIR"
 
-   echo Traces will be logged to "${TRACE_FILE}"
+   echo "#Traces will be logged to ${TRACE_FILE}"
    rm -f "$TRACE_FILE"
 
    TRACE_CMD=(strace -T -tt -o "${TRACE_FILE}")
 fi
 
 set +e
-echo running RDS tests...
+echo "#running RDS tests..."
 "${TRACE_CMD[@]}" python3 "$(dirname "$0")/test.py" "${FLAGS[@]}" -t "$TIMEOUT"
 
 test_rc=$?
@@ -214,7 +214,7 @@ if [[ -n "$LOG_DIR" ]]; then
 fi
 
 if [[ -n "$LOG_DIR" ]] && [ "$GENERATE_GCOV_REPORT" -eq 1 ]; then
-       echo saving coverage data...
+       echo "# saving coverage data..."
 
        # Ensure debugfs is mounted before reading gcov data.
        if ! mountpoint -q /sys/kernel/debug 2>/dev/null; then
@@ -227,17 +227,19 @@ if [[ -n "$LOG_DIR" ]] && [ "$GENERATE_GCOV_REPORT" -eq 1 ]; then
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
index faf751863478..d19d30e5ec6f 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -20,6 +20,8 @@ this_dir = os.path.dirname(os.path.realpath(__file__))
 sys.path.append(os.path.join(this_dir, "../"))
 # pylint: disable-next=wrong-import-position,import-error,no-name-in-module
 from lib.py.utils import ip # noqa: E402
+# pylint: disable-next=wrong-import-position,import-error,no-name-in-module
+from lib.py.ksft import ksft_pr # noqa: E402
 
 libc = ctypes.cdll.LoadLibrary('libc.so.6')
 setns = libc.setns
@@ -59,7 +61,7 @@ def netns_socket(netns, *sock_args):
         # send resulting socket to parent
         socket.send_fds(u0, [], [sock.fileno()])
 
-        sys.exit(0)
+        os._exit(0)
 
     # receive socket from child
     _, fds, _, _ = socket.recv_fds(u1, 0, 1)
@@ -75,7 +77,7 @@ def stop_pcaps():
     completes after the signal handler is fired.  List will be empty
     if logdir is not set
     """
-    print("Stopping network packet captures")
+    ksft_pr("Stopping network packet captures")
     while tcpdump_procs:
         proc = tcpdump_procs.pop()
         proc.terminate()
@@ -89,8 +91,9 @@ def signal_handler(_sig, _frame):
     """
     Test timed out signal handler
     """
-    print('Test timed out')
+    ksft_pr("Test timed out")
     stop_pcaps()
+    print("not ok 1 rds selftest")
     sys.exit(1)
 
 #Parse out command line arguments.  We take an optional
@@ -157,7 +160,8 @@ if logdir is not None:
         tcpdump_cmd.extend(['-i', 'any', '-w', pcap])
 
         # pylint: disable-next=consider-using-with
-        p = subprocess.Popen(tcpdump_cmd)
+        p = subprocess.Popen(tcpdump_cmd,
+                             stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
         tcpdump_procs.append(p)
 
 # simulate packet loss, duplication and corruption
@@ -166,6 +170,9 @@ for net, iface in [(NET0, VETH0), (NET1, VETH1)]:
          corrupt {PACKET_CORRUPTION} loss {PACKET_LOSS} duplicate  \
          {PACKET_DUPLICATE}")
 
+print("TAP version 13")
+print("1..1")
+
 # add a timeout
 if args.timeout > 0:
     signal.alarm(args.timeout)
@@ -204,7 +211,7 @@ nr_recv = 0
 
 while nr_send < NUM_PACKETS:
     # Send as much as we can without blocking
-    print("sending...", nr_send, nr_recv)
+    ksft_pr("sending...", nr_send, nr_recv)
     while nr_send < NUM_PACKETS:
         send_data = hashlib.sha256(
             f'packet {nr_send}'.encode('utf-8')).hexdigest().encode('utf-8')
@@ -226,7 +233,7 @@ while nr_send < NUM_PACKETS:
             raise
 
     # Receive as much as we can without blocking
-    print("receiving...", nr_send, nr_recv)
+    ksft_pr("receiving...", nr_send, nr_recv)
     while nr_recv < nr_send:
         for fileno, eventmask in ep.poll():
             receiver = fileno_to_socket[fileno]
@@ -248,7 +255,7 @@ while nr_send < NUM_PACKETS:
         ip(f"netns exec {net} /usr/sbin/sysctl net.rds.tcp.rds_tcp_rcvbuf=10000")
         ip(f"netns exec {net} /usr/sbin/sysctl net.rds.tcp.rds_tcp_sndbuf=10000")
 
-print("done", nr_send, nr_recv)
+ksft_pr("done", nr_send, nr_recv)
 
 # the Python socket module doesn't know these
 RDS_INFO_FIRST = 10000
@@ -271,26 +278,34 @@ for s in sockets:
                 # ignore
                 pass
 
-print(f"getsockopt(): {nr_success}/{nr_error}")
-
+ksft_pr(f"getsockopt(): {nr_success}/{nr_error}")
 stop_pcaps()
 
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


