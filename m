Return-Path: <linux-rdma+bounces-17688-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FaWMB0QrWmBxwEAu9opvQ
	(envelope-from <linux-rdma+bounces-17688-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 06:58:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 692A222E9EE
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 06:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 339F23024A1B
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 05:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2343290C6;
	Sun,  8 Mar 2026 05:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTIhUO4t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED46328611;
	Sun,  8 Mar 2026 05:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772949517; cv=none; b=mV3/hmIwNKKLQd1W3B1Pw5cevGrjsvm8YHVf/MdT0tEuTL9A2/Hoc0e0mjEqbj21YfLOubMIZVUOaBU53JD/mp0z7JDHfAOGBTf7T7MjAs7SQrdSXa8O1UTg8Q5DBD1qD4fiIrHDVg4U8U0Lt2+5ySL7TawCfTGEL3ztrjKhzQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772949517; c=relaxed/simple;
	bh=tdQdpipgWK74ci2PkRSs5EjCAGan/5v4cz5W7I4jObc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ix+XO9HwybrgO5ygjxNE8vSNhmSgq2zXbt5P21zCGXGzes/JizkgzoyWZT9OEnjdoPMdXih4oaHIfipPDq32RgsjzOn80i8NTr4bNtRmXkPpf4WL/VfeP+RmokBSLcl4vvHiquzP1M3MUV2Dd3o0CVGt5zbXcLugdDbW4mpZsiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTIhUO4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE54C2BCB0;
	Sun,  8 Mar 2026 05:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772949517;
	bh=tdQdpipgWK74ci2PkRSs5EjCAGan/5v4cz5W7I4jObc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iTIhUO4tPhOQVDAj+x/HDhW5XL2VsokfOA0RMt94q/ftI8TCTc1UepgNVykU+mVBc
	 zO0S3XcYvpnWIOLaWMZ3IUcmcWF7yrOWVdvLtaUm3RA3cfz3knNeZtwGn9nIumXQoK
	 ByVefe4OH2mx8QcKXqlUln76jxTfcOkJJbxgxMQwklpXIuxCg1MMHqvqwdAa7iZ5hK
	 jDlfU6pqYlM41YgghYzJ4HWuZAQ2TJKErkFjvcDnfPc5BFlhxVt8OHVF4Mg/4EhYhY
	 JBcGGeRqZmWo0je5MMrOSgzCCowhTd1mIvt6J2pJAntLg1dN/Ji0OZXM8E+XXtyw70
	 dUwvZTql5CZYQ==
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
Subject: [PATCH net-next v1 1/3] selftests: rds: Fix pylint warnings
Date: Sat,  7 Mar 2026 22:58:33 -0700
Message-ID: <20260308055835.1338257-2-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260308055835.1338257-1-achender@kernel.org>
References: <20260308055835.1338257-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 692A222E9EE
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
	TAGGED_FROM(0.00)[bounces-17688-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.986];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[test.py:url]
X-Rspamd-Action: no action

Tidy up all exiting pylint errors in test.py.  No functional
changes are introduced in this patch

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/test.py | 84 +++++++++++++------------
 1 file changed, 45 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
index 4a7178d11193..8256afe6ad6f 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -11,7 +11,6 @@ import signal
 import socket
 import subprocess
 import sys
-import atexit
 from pwd import getpwuid
 from os import stat
 
@@ -23,45 +22,54 @@ from lib.py.utils import ip
 libc = ctypes.cdll.LoadLibrary('libc.so.6')
 setns = libc.setns
 
-net0 = 'net0'
-net1 = 'net1'
+NET0 = 'net0'
+NET1 = 'net1'
 
-veth0 = 'veth0'
-veth1 = 'veth1'
+VETH0 = 'veth0'
+VETH1 = 'veth1'
 
 # Helper function for creating a socket inside a network namespace.
 # We need this because otherwise RDS will detect that the two TCP
 # sockets are on the same interface and use the loop transport instead
 # of the TCP transport.
-def netns_socket(netns, *args):
+def netns_socket(netns, *sock_args):
+    """
+    Creates sockets inside of network namespace
+
+    :param netns: the name of the network namespace
+    :param sock_args: socket family and type
+    """
     u0, u1 = socket.socketpair(socket.AF_UNIX, socket.SOCK_SEQPACKET)
 
     child = os.fork()
     if child == 0:
         # change network namespace
-        with open(f'/var/run/netns/{netns}') as f:
+        with open(f'/var/run/netns/{netns}', encoding='utf-8') as f:
             try:
-                ret = setns(f.fileno(), 0)
+                setns(f.fileno(), 0)
             except IOError as e:
                 print(e.errno)
                 print(e)
 
         # create socket in target namespace
-        s = socket.socket(*args)
+        sock = socket.socket(*sock_args)
 
         # send resulting socket to parent
-        socket.send_fds(u0, [], [s.fileno()])
+        socket.send_fds(u0, [], [sock.fileno()])
 
         sys.exit(0)
 
     # receive socket from child
-    _, s, _, _ = socket.recv_fds(u1, 0, 1)
+    _, fds, _, _ = socket.recv_fds(u1, 0, 1)
     os.waitpid(child, 0)
     u0.close()
     u1.close()
-    return socket.fromfd(s[0], *args)
+    return socket.fromfd(fds[0], *sock_args)
 
-def signal_handler(sig, frame):
+def signal_handler(_sig, _frame):
+    """
+    Test timed out signal handler
+    """
     print('Test timed out')
     sys.exit(1)
 
@@ -81,13 +89,13 @@ parser.add_argument('-u', '--duplicate', help="Simulate tcp packet duplication",
                     type=int, default=0)
 args = parser.parse_args()
 logdir=args.logdir
-packet_loss=str(args.loss)+'%'
-packet_corruption=str(args.corruption)+'%'
-packet_duplicate=str(args.duplicate)+'%'
+PACKET_LOSS=str(args.loss)+'%'
+PACKET_CORRUPTION=str(args.corruption)+'%'
+PACKET_DUPLICATE=str(args.duplicate)+'%'
 
-ip(f"netns add {net0}")
-ip(f"netns add {net1}")
-ip(f"link add type veth")
+ip(f"netns add {NET0}")
+ip(f"netns add {NET1}")
+ip("link add type veth")
 
 addrs = [
     # we technically don't need different port numbers, but this will
@@ -99,25 +107,25 @@ addrs = [
 # move interfaces to separate namespaces so they can no longer be
 # bound directly; this prevents rds from switching over from the tcp
 # transport to the loop transport.
-ip(f"link set {veth0} netns {net0} up")
-ip(f"link set {veth1} netns {net1} up")
+ip(f"link set {VETH0} netns {NET0} up")
+ip(f"link set {VETH1} netns {NET1} up")
 
 
 
 # add addresses
-ip(f"-n {net0} addr add {addrs[0][0]}/32 dev {veth0}")
-ip(f"-n {net1} addr add {addrs[1][0]}/32 dev {veth1}")
+ip(f"-n {NET0} addr add {addrs[0][0]}/32 dev {VETH0}")
+ip(f"-n {NET1} addr add {addrs[1][0]}/32 dev {VETH1}")
 
 # add routes
-ip(f"-n {net0} route add {addrs[1][0]}/32 dev {veth0}")
-ip(f"-n {net1} route add {addrs[0][0]}/32 dev {veth1}")
+ip(f"-n {NET0} route add {addrs[1][0]}/32 dev {VETH0}")
+ip(f"-n {NET1} route add {addrs[0][0]}/32 dev {VETH1}")
 
 # sanity check that our two interfaces/addresses are correctly set up
 # and communicating by doing a single ping
-ip(f"netns exec {net0} ping -c 1 {addrs[1][0]}")
+ip(f"netns exec {NET0} ping -c 1 {addrs[1][0]}")
 
 # Start a packet capture on each network
-for net in [net0, net1]:
+for net in [NET0, NET1]:
     tcpdump_pid = os.fork()
     if tcpdump_pid == 0:
         pcap = logdir+'/'+net+'.pcap'
@@ -127,10 +135,10 @@ for net in [net0, net1]:
         sys.exit(0)
 
 # simulate packet loss, duplication and corruption
-for net, iface in [(net0, veth0), (net1, veth1)]:
+for net, iface in [(NET0, VETH0), (NET1, VETH1)]:
     ip(f"netns exec {net} /usr/sbin/tc qdisc add dev {iface} root netem  \
-         corrupt {packet_corruption} loss {packet_loss} duplicate  \
-         {packet_duplicate}")
+         corrupt {PACKET_CORRUPTION} loss {PACKET_LOSS} duplicate  \
+         {PACKET_DUPLICATE}")
 
 # add a timeout
 if args.timeout > 0:
@@ -138,8 +146,8 @@ if args.timeout > 0:
     signal.signal(signal.SIGALRM, signal_handler)
 
 sockets = [
-    netns_socket(net0, socket.AF_RDS, socket.SOCK_SEQPACKET),
-    netns_socket(net1, socket.AF_RDS, socket.SOCK_SEQPACKET),
+    netns_socket(NET0, socket.AF_RDS, socket.SOCK_SEQPACKET),
+    netns_socket(NET1, socket.AF_RDS, socket.SOCK_SEQPACKET),
 ]
 
 for s, addr in zip(sockets, addrs):
@@ -150,9 +158,7 @@ fileno_to_socket = {
     s.fileno(): s for s in sockets
 }
 
-addr_to_socket = {
-    addr: s for addr, s in zip(addrs, sockets)
-}
+addr_to_socket = dict(zip(addrs, sockets))
 
 socket_to_addr = {
     s: addr for addr, s in zip(addrs, sockets)
@@ -166,14 +172,14 @@ ep = select.epoll()
 for s in sockets:
     ep.register(s, select.EPOLLRDNORM)
 
-n = 50000
+NUM_PACKETS = 50000
 nr_send = 0
 nr_recv = 0
 
-while nr_send < n:
+while nr_send < NUM_PACKETS:
     # Send as much as we can without blocking
     print("sending...", nr_send, nr_recv)
-    while nr_send < n:
+    while nr_send < NUM_PACKETS:
         send_data = hashlib.sha256(
             f'packet {nr_send}'.encode('utf-8')).hexdigest().encode('utf-8')
 
@@ -212,7 +218,7 @@ while nr_send < n:
                         break
 
     # exercise net/rds/tcp.c:rds_tcp_sysctl_reset()
-    for net in [net0, net1]:
+    for net in [NET0, NET1]:
         ip(f"netns exec {net} /usr/sbin/sysctl net.rds.tcp.rds_tcp_rcvbuf=10000")
         ip(f"netns exec {net} /usr/sbin/sysctl net.rds.tcp.rds_tcp_sndbuf=10000")
 
-- 
2.43.0


