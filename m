Return-Path: <linux-rdma+bounces-20860-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPzGHX9qCmp+1AQAu9opvQ
	(envelope-from <linux-rdma+bounces-20860-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 03:25:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF44564C32
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 03:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D68F8301C6F5
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 01:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C327923E358;
	Mon, 18 May 2026 01:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1GAG74S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869DB23A564;
	Mon, 18 May 2026 01:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779067486; cv=none; b=kcMUn66qUovEMuN2kv/LEDPidjbHf1y5T4KSZXyVVJpYkCeMNeYKUBygL8ZbyF0XfBFnCVkEbH/e/Q4o2yyKvPlFdofy4+m6pa0ojvY0E+zkj4SWvwtErbcbxnLzzIHiRkskt4K5R3euaGEsRFHpIjyQIhJW+XPpi76KaRFF9sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779067486; c=relaxed/simple;
	bh=E1xyMiQI3a+NBPD0CN4xnRb0A6/n2wAIge/br0Vpo5A=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lsDc1ByXnMx/Dfw9Jb8kd025v71wnb1vs50xlL+SBVz4LEjp3uDSYVIM4MGV04wafMJTSmnEl+NKm/ekydBx0U3eTxVhtvEb/b9trAzpBefQbhFiNdyWLBpl2889pfo27Ik50KwX4QDtYsSuKwYEtNjxDLRR8tlanowRt06q8CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1GAG74S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22FEC2BCB3;
	Mon, 18 May 2026 01:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779067486;
	bh=E1xyMiQI3a+NBPD0CN4xnRb0A6/n2wAIge/br0Vpo5A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=J1GAG74SbnvPgRlr4b/LhnTOozZpl1zu24WgmXjKAHr4pwCPPe8ZvA9njAABk/Ocm
	 4ooL8YMhaCTuo/awcow7sm+znWP2vsHw784mg38td2ei0fUejvOVgg95XV9jm6O5jB
	 80mg7fhDb65epJ4THUapNdKCJ6AN7dqvtpb9FIAaTgnal2vhvlEsPh2BBz9RAhvP9b
	 J6N3K9KcZKGtpaCvnwPe+Y7HgpZj6pnqj/uaNuskMIpVchKm5Eeu9tdiAQSuorPs+K
	 NGlIbElKr3gZCamdufIONjPnbn6AJ1mYn9Cgl0Ok/c/0K25smIg8iUo6gliGFkZja+
	 oDGskAUvJzKKQ==
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
Subject: [PATCH net-next v3 02/11] selftests: rds: Add helper function setup_tcp() in test.py
Date: Sun, 17 May 2026 18:24:34 -0700
Message-Id: <20260518012443.2629206-3-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260518012443.2629206-1-achender@kernel.org>
References: <20260518012443.2629206-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EFF44564C32
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
	TAGGED_FROM(0.00)[bounces-20860-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,test.py:url]
X-Rspamd-Action: no action

Hoist the network configs in test.py into a tcp specific helper
function, setup_tcp().  This is a preparatory refactoring for the
rds over ROCE series which will add separate function for rdma
specific configs.  No functional changes are introduced in this patch.

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/test.py | 113 +++++++++++++-----------
 1 file changed, 60 insertions(+), 53 deletions(-)

diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
index 6db6067792312..118a5da83c98e 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -32,6 +32,15 @@ NET1 = 'net1'
 VETH0 = 'veth0'
 VETH1 = 'veth1'
 
+tcpdump_procs = []
+tcp_addrs = [
+    # we technically don't need different port numbers, but this will
+    # help identify traffic in the network analyzer
+    ('10.0.0.1', 10000),
+    ('10.0.0.2', 20000),
+]
+
+
 # Helper function for creating a socket inside a network namespace.
 # We need this because otherwise RDS will detect that the two TCP
 # sockets are on the same interface and use the loop transport instead
@@ -100,6 +109,55 @@ def signal_handler(_sig, _frame):
     print("not ok 1 rds selftest")
     sys.exit(1)
 
+def setup_tcp():
+    """
+    Configure tcp network
+    """
+
+    ip(f"netns add {NET0}")
+    ip(f"netns add {NET1}")
+    ip("link add type veth")
+
+    # Move TCP interfaces into separate namespaces so they can no longer be
+    # bound directly; this prevents rds from switching over from the tcp
+    # transport to the loop transport.
+    ip(f"link set {VETH0} netns {NET0} up")
+    ip(f"link set {VETH1} netns {NET1} up")
+
+    # add addresses
+    ip(f"-n {NET0} addr add {tcp_addrs[0][0]}/32 dev {VETH0}")
+    ip(f"-n {NET1} addr add {tcp_addrs[1][0]}/32 dev {VETH1}")
+
+    # add routes
+    ip(f"-n {NET0} route add {tcp_addrs[1][0]}/32 dev {VETH0}")
+    ip(f"-n {NET1} route add {tcp_addrs[0][0]}/32 dev {VETH1}")
+
+    # sanity check that our two interfaces/addresses are correctly set up
+    # and communicating by doing a single ping
+    ip(f"netns exec {NET0} ping -c 1 {tcp_addrs[1][0]}")
+
+    # Start a packet capture on each network
+    if logdir is not None:
+        for netn in [NET0, NET1]:
+            pcap = logdir+'/rds-'+netn+'.pcap'
+
+            tcpdump_cmd = ['ip', 'netns', 'exec', netn, '/usr/sbin/tcpdump']
+            sudo_user = os.environ.get('SUDO_USER')
+            if sudo_user:
+                tcpdump_cmd.extend(['-Z', sudo_user])
+            tcpdump_cmd.extend(['-i', 'any', '-w', pcap])
+
+            # pylint: disable-next=consider-using-with
+            p = subprocess.Popen(tcpdump_cmd,
+                                 stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
+            tcpdump_procs.append(p)
+
+    # simulate packet loss, duplication and corruption
+    for netn, iface in [(NET0, VETH0), (NET1, VETH1)]:
+        ip(f"netns exec {netn} /usr/sbin/tc qdisc add dev {iface} root netem  \
+             corrupt {PACKET_CORRUPTION} loss {PACKET_LOSS} duplicate  \
+             {PACKET_DUPLICATE}")
+
 #Parse out command line arguments.  We take an optional
 # timeout parameter and an optional log output folder
 parser = argparse.ArgumentParser(description="init script args",
@@ -120,59 +178,8 @@ PACKET_LOSS=str(args.loss)+'%'
 PACKET_CORRUPTION=str(args.corruption)+'%'
 PACKET_DUPLICATE=str(args.duplicate)+'%'
 
-ip(f"netns add {NET0}")
-ip(f"netns add {NET1}")
-ip("link add type veth")
-
-addrs = [
-    # we technically don't need different port numbers, but this will
-    # help identify traffic in the network analyzer
-    ('10.0.0.1', 10000),
-    ('10.0.0.2', 20000),
-]
-
-# move interfaces to separate namespaces so they can no longer be
-# bound directly; this prevents rds from switching over from the tcp
-# transport to the loop transport.
-ip(f"link set {VETH0} netns {NET0} up")
-ip(f"link set {VETH1} netns {NET1} up")
-
-
-
-# add addresses
-ip(f"-n {NET0} addr add {addrs[0][0]}/32 dev {VETH0}")
-ip(f"-n {NET1} addr add {addrs[1][0]}/32 dev {VETH1}")
-
-# add routes
-ip(f"-n {NET0} route add {addrs[1][0]}/32 dev {VETH0}")
-ip(f"-n {NET1} route add {addrs[0][0]}/32 dev {VETH1}")
-
-# sanity check that our two interfaces/addresses are correctly set up
-# and communicating by doing a single ping
-ip(f"netns exec {NET0} ping -c 1 {addrs[1][0]}")
-
-tcpdump_procs = []
-# Start a packet capture on each network
-if logdir is not None:
-    for net in [NET0, NET1]:
-        pcap = logdir+'/rds-'+net+'.pcap'
-
-        tcpdump_cmd = ['ip', 'netns', 'exec', net, '/usr/sbin/tcpdump']
-        sudo_user = os.environ.get('SUDO_USER')
-        if sudo_user:
-            tcpdump_cmd.extend(['-Z', sudo_user])
-        tcpdump_cmd.extend(['-i', 'any', '-w', pcap])
-
-        # pylint: disable-next=consider-using-with
-        p = subprocess.Popen(tcpdump_cmd,
-                             stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
-        tcpdump_procs.append(p)
-
-# simulate packet loss, duplication and corruption
-for net, iface in [(NET0, VETH0), (NET1, VETH1)]:
-    ip(f"netns exec {net} /usr/sbin/tc qdisc add dev {iface} root netem  \
-         corrupt {PACKET_CORRUPTION} loss {PACKET_LOSS} duplicate  \
-         {PACKET_DUPLICATE}")
+setup_tcp()
+addrs = tcp_addrs
 
 print("TAP version 13")
 print("1..1")
-- 
2.25.1


