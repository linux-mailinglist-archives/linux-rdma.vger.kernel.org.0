Return-Path: <linux-rdma+bounces-17356-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EWlEWYmpWm14AUAu9opvQ
	(envelope-from <linux-rdma+bounces-17356-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 06:55:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DEB1D34A8
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 06:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A6613027125
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 05:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160CC3803D6;
	Mon,  2 Mar 2026 05:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSZGK1AA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4861237BE9E;
	Mon,  2 Mar 2026 05:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772430922; cv=none; b=jKkjqVfnjW38DtKJGvgHGBzRW2kbgho5mENalVqzqMm5J1B//BvJ2e98w9opL10dgI1XI72htTuKlpHUTrKUnrwWlJz9VdLj1zcMniH6YidjEsuzusNErkipy6lgoI4mLMiUtC20HEeO/njqi7R/n+ceGhlqcSFBZhvhJq44ak4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772430922; c=relaxed/simple;
	bh=pTuQCLhN9KL16zzH5GBjK6Dww8U4RLJIFjvuWPiUXeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qADxVFmuiY4YM58DUR1xRkrUXSEEKGdPBm3Vj3U/hzWbsCFzAzA1G5tZ9i+K+V9VA4vflGgTA5VmTBHvMxD8gHRmrrtx7+TWQ20ikTiwYRTvip5cX3ZsbuDZDSb5WgHJOtE/WCn7uxuOccrkqumbJtVxDUfGBSFDqG7PkQIC8yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSZGK1AA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BB5C2BC9E;
	Mon,  2 Mar 2026 05:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772430921;
	bh=pTuQCLhN9KL16zzH5GBjK6Dww8U4RLJIFjvuWPiUXeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XSZGK1AAn8V8aMQf9MqT7xBohXRb2tuaTkLkE2WdoYLts8YQSegxlm2YXoShtSPLZ
	 376rT/+j2ic0z+w2CVuFxI9KjsSrzOOSeyCokRUMKlB552FHnCrvcu/4Fl0b02646x
	 1h0xrwgh76QMTpjmlUYs2n48CmBJe7EJBVxKCeP1XSRLL/kWKrYenNyBzj163JqiWZ
	 079wAuB4QbUl88A2gZNI/lBM19uBIGEi/ffCumoNBOW566RJhLhKsPelho+KAxwEaU
	 ayXufduU6/uCbzRGThhxA4iaudUMqaZB+RBuDiIPKNREsoRXRQH6oONiPiI8+3I1ma
	 +alPYmQkLJVfA==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	allison.henderson@oracle.com
Subject: [PATCH net-next v1 2/2] selftests: rds: Add rds_stress.py
Date: Sun,  1 Mar 2026 22:55:18 -0700
Message-ID: <20260302055518.301620-3-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302055518.301620-1-achender@kernel.org>
References: <20260302055518.301620-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-17356-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8DEB1D34A8
X-Rspamd-Action: no action

From: Allison Henderson <allison.henderson@oracle.com>

This patch adds a new rds stress test to the rds selftests suite.
rds_stress is available through the rds-tools package, and can be
run in the selftests infrastructure if it is installed on the host.
We also add new test flags --rds_stress and --rds_basic to the
calling test.py script to run one or both of the tests.

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/Makefile      |  1 +
 tools/testing/selftests/net/rds/rds_stress.py | 58 +++++++++++++++++++
 tools/testing/selftests/net/rds/run.sh        | 42 ++++++++++++--
 tools/testing/selftests/net/rds/test.py       | 27 ++++++++-
 4 files changed, 123 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/rds/Makefile b/tools/testing/selftests/net/rds/Makefile
index 611ed6f2bf91..a37bd4314f0e 100644
--- a/tools/testing/selftests/net/rds/Makefile
+++ b/tools/testing/selftests/net/rds/Makefile
@@ -9,6 +9,7 @@ TEST_FILES := \
 	include.sh \
 	test.py \
 	rds_basic.py \
+	rds_stress.py \
 # end of TEST_FILES
 
 EXTRA_CLEAN := \
diff --git a/tools/testing/selftests/net/rds/rds_stress.py b/tools/testing/selftests/net/rds/rds_stress.py
new file mode 100644
index 000000000000..8a86fa0b050d
--- /dev/null
+++ b/tools/testing/selftests/net/rds/rds_stress.py
@@ -0,0 +1,58 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import subprocess
+import time
+
+def run_test(env):
+    """Run RDS stress selftest.
+
+    env is a dictionary provided by test.py and is expected to contain:
+      - 'addrs':   list of (ip, port) tuples matching the sockets
+      - 'netns':   list of network namespace names (for sysctl exercises)
+    """
+    addrs = env['addrs']      # [('10.0.0.1', 10000), ('10.0.0.2', 20000)]
+    netns_list = env['netns'] # ['net0', 'net1']
+
+    a0, a1 = addrs
+    recv_addr = a0[0]
+    send_addr = a1[0]
+    port = a0[1]
+
+    nr_tasks = 1  # max child tasks created
+    q_depth = 1   # max outstanding messages
+    duration = 60 # duration of test in seconds
+
+    # server side
+    p0 = subprocess.Popen([
+        'ip', 'netns', 'exec', netns_list[0],
+        'rds-stress',
+        '-r', str(recv_addr),
+        '-p', str(port),
+        '-t', str(nr_tasks),
+        '-d', str(q_depth),
+        '-T', str(duration+5) # add some extra time to let the client finish
+    ])
+
+    time.sleep(1) # delay to allow server time to come up
+
+    # client side
+    p1 = subprocess.Popen([
+        'ip', 'netns', 'exec', netns_list[1],
+        'rds-stress',
+        '-r', str(send_addr), '-s', str(recv_addr),
+        '-p', str(port),
+        '-t', str(nr_tasks),
+        '-d', str(q_depth),
+        '-T', str(duration)
+    ])
+
+    rc1 = p1.wait() # wait for client
+    rc0 = p0.wait() # then wait for the server
+
+    if rc0 != 0 or rc1 != 0:
+        print(f"rds-stress failed: server={rc0} client={rc1}")
+        return 1
+
+    print("Success")
+    return 0
diff --git a/tools/testing/selftests/net/rds/run.sh b/tools/testing/selftests/net/rds/run.sh
index 8aee244f582a..5917c3222237 100755
--- a/tools/testing/selftests/net/rds/run.sh
+++ b/tools/testing/selftests/net/rds/run.sh
@@ -152,7 +152,34 @@ PLOSS=0
 PCORRUPT=0
 PDUP=0
 GENERATE_GCOV_REPORT=1
-while getopts "d:l:c:u:" opt; do
+RDS_BASIC=0
+RDS_STRESS=0
+FLAGS=""
+
+check_flags()
+{
+	if [ "$RDS_STRESS" -ne 0 ] && ! which rds-stress > /dev/null 2>&1; then
+		echo "selftests: Could not run rds-stress.  Disabling rds-stress."
+		RDS_STRESS=0
+	fi
+	if [ "$RDS_STRESS" -eq 0 ] && [ "$RDS_BASIC" -eq 0 ]; then
+		echo "selftests: Default to rds basic tests"
+		RDS_BASIC=1
+	fi
+}
+
+set_flags()
+{
+	if [ "$RDS_STRESS" -ne 0 ];then
+		FLAGS="$FLAGS -s"
+	fi
+
+	if [ "$RDS_BASIC" -ne 0 ]; then
+		FLAGS="$FLAGS -b"
+	fi
+}
+
+while getopts "d:l:c:u:bs" opt; do
   case ${opt} in
     d)
       LOG_DIR=${OPTARG}
@@ -166,9 +193,15 @@ while getopts "d:l:c:u:" opt; do
     u)
       PDUP=${OPTARG}
       ;;
+    b)
+      RDS_BASIC=1
+      ;;
+    s)
+      RDS_STRESS=1
+      ;;
     :)
       echo "USAGE: run.sh [-d logdir] [-l packet_loss] [-c packet_corruption]" \
-           "[-u packet_duplcate] [-g]"
+           "[-u packet_duplcate] [-g] [-b] [-s]"
       exit 1
       ;;
     ?)
@@ -182,7 +215,8 @@ done
 check_env
 check_conf
 check_gcov_conf
-
+check_flags
+set_flags
 
 rm -fr "$LOG_DIR"
 TRACE_FILE="${LOG_DIR}/rds-strace.txt"
@@ -195,7 +229,7 @@ echo running RDS tests...
 echo Traces will be logged to "$TRACE_FILE"
 rm -f "$TRACE_FILE"
 strace -T -tt -o "$TRACE_FILE" python3 "$(dirname "$0")/test.py" --timeout 400 -d "$LOG_DIR" \
-       -l "$PLOSS" -c "$PCORRUPT" -u "$PDUP"
+       -l "$PLOSS" -c "$PCORRUPT" -u "$PDUP" $FLAGS
 
 test_rc=$?
 dmesg > "${LOG_DIR}/dmesg.out"
diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
index 0cb060073f6d..6a02809e27e6 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -9,6 +9,7 @@ import sys
 from pwd import getpwuid
 from os import stat
 import rds_basic
+import rds_stress
 
 # Allow utils module to be imported from different directory
 this_dir = os.path.dirname(os.path.realpath(__file__))
@@ -21,6 +22,20 @@ net1 = 'net1'
 veth0 = 'veth0'
 veth1 = 'veth1'
 
+def increment_ports(addrs, inc):
+    """Increment port numbers in the addrs list by inc.
+       Use between tests to make the port numbers unique
+
+    addrs: list of (ip, port) tuples
+    inc: int
+    """
+    new_addrs = []
+
+    for addr, port in addrs:
+        new_addrs.append((addr, port + inc))
+
+    return new_addrs
+
 def signal_handler(sig, frame):
     print('Test timed out')
     sys.exit(1)
@@ -31,6 +46,10 @@ parser = argparse.ArgumentParser(description="init script args",
                   formatter_class=argparse.ArgumentDefaultsHelpFormatter)
 parser.add_argument("-d", "--logdir", action="store",
                     help="directory to store logs", default="/tmp")
+parser.add_argument("-b", "--rds_basic", action="store_true",
+                    help="Run rds basic tests")
+parser.add_argument("-s", "--rds_stress", action="store_true",
+                    help="Run rds stress tests")
 parser.add_argument('--timeout', help="timeout to terminate hung test",
                     type=int, default=0)
 parser.add_argument('-l', '--loss', help="Simulate tcp packet loss",
@@ -102,7 +121,13 @@ env = {
     'netns': [net0, net1],
 }
 
-ret = rds_basic.run_test(env)
+ret = 0
+if args.rds_basic:
+    ret = rds_basic.run_test(env)
+
+if ret == 0 and args.rds_stress:
+    env['addrs'] = increment_ports(env['addrs'], 1000)
+    ret = rds_stress.run_test(env)
 
 print("Stopping network packet captures")
 subprocess.check_call(['killall', '-q', 'tcpdump'])
-- 
2.43.0


