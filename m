Return-Path: <linux-rdma+bounces-20865-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGI+MY9qCmp+1AQAu9opvQ
	(envelope-from <linux-rdma+bounces-20865-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 03:25:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B205D564C58
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 03:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97B84300C034
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 01:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D27B27281D;
	Mon, 18 May 2026 01:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1YBfkS+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F179F21D590;
	Mon, 18 May 2026 01:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779067490; cv=none; b=QKabKrGIHVoxVyfWSxV4I80YM+Eh38UjQS+Z4qZ6VHuWwtOTbRNQsa9GnWwQopOh0tO8u8/lxL52wL0poxT1zA6osJ1HVYmD/3vpvFKtuxnygjVv4BLiDC1BFmpYZ+Mm0NHNStcSu7aTmFQKKCy45iZVpyQw3+P2cxaVES9mX+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779067490; c=relaxed/simple;
	bh=D9aqmV4Qj7vVA5k92KHWySaH8uAfgMfomQHrg4nNkXI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qPd2X3qbAq0BK/dBsOAPq5JRlY7UT24Ke9dkMKZulnioTW33jlOI3Pow02JFoNprEn2ZWEOXSuyTB/7SJ4xkQwgH3uksn72VbLMwNYwsO/FP/U/YZ0SHBArIBIZrGMWl1fELmSssNmmXF9jubUZoQbDN/p/wn/6GhZuSN2xnkmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1YBfkS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55260C2BCB3;
	Mon, 18 May 2026 01:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779067489;
	bh=D9aqmV4Qj7vVA5k92KHWySaH8uAfgMfomQHrg4nNkXI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=b1YBfkS+GzerEku/YmLcycUq/J0hByv86HTtzRs7V/dkbXUeLNkrjm+BRzrvSrozw
	 hmMNCBZf5adj1F3GdA+NFshF2fOPh6YnMAFSAAJG8y+ReB8yGVnUf8hfYYqxpSTt4y
	 XnAH8JxEOD5Ik3UIa6mCMakEtXC2aGJt5mzIZymrsLWf/0GMwj5Lz5xBBOlLpKkzQl
	 cRQoXpR4Y+n2nMuMDu2AZ3vOAdnPbGjfaMeZk22A7AOHfdIcDIFE5LJg0Xo17uPFaD
	 4vQ4pqcncubh7Fx4rK4pQTw/QtyTep8TaM2xvF7zsXmld2uU9uS9GukeUuaqo8gqfj
	 NvqSbbUK1E9yg==
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
Subject: [PATCH net-next v3 07/11] selftests: rds: Add helper function snd_rcv_packets() in test.py
Date: Sun, 17 May 2026 18:24:39 -0700
Message-Id: <20260518012443.2629206-8-achender@kernel.org>
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
X-Rspamd-Queue-Id: B205D564C58
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-20865-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[test.py:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hoist the send/recv logic in test.py into a helper function,
snd_rcv_packets().  This is a preparatory refactoring for the
rds over ROCE series which can use the same function to run
the test over tcp, rdma, or both.  No functional changes are
introduced in this patch.

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/test.py | 99 ++++++++++++++-----------
 1 file changed, 54 insertions(+), 45 deletions(-)

diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
index a3def413d84ad..f7d0dba85131e 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -167,6 +167,59 @@ def verify_hashes(snd_hashes, rcv_hashes):
         ksft_pr(f"{key[0]}/{key[1]}: ok")
     return 0
 
+def snd_rcv_packets(addrs, netns_list):
+    """
+    Send packets on the given network interfaces
+
+    :param addrs: list of (ip, port) tuples matching the sockets
+    :param netns_list: list of network namespaces
+    """
+
+    sockets = [
+        netns_socket(netns_list[0], socket.AF_RDS, socket.SOCK_SEQPACKET),
+        netns_socket(netns_list[1], socket.AF_RDS, socket.SOCK_SEQPACKET),
+    ]
+
+    for s, addr in zip(sockets, addrs):
+        s.bind(addr)
+        s.setblocking(0)
+
+    send_hashes = {}
+    recv_hashes = {}
+
+    ep = select.epoll()
+
+    for s in sockets:
+        ep.register(s, select.EPOLLRDNORM)
+
+    num_packets = 50000
+    nr_send = 0
+    nr_recv = 0
+
+    while nr_send < num_packets:
+
+        # Send as much as we can without blocking
+        ksft_pr("sending...", nr_send, nr_recv)
+        nr_send = send_burst(sockets, addrs, send_hashes, nr_send, num_packets)
+
+        # Receive as much as we can without blocking
+        ksft_pr("receiving...", nr_send, nr_recv)
+        while nr_recv < nr_send:
+            nr_recv = recv_burst(ep, sockets, addrs, recv_hashes, nr_recv)
+
+        # exercise net/rds/tcp.c:rds_tcp_sysctl_reset()
+        for net in netns_list:
+            ip(f"netns exec {net} /usr/sbin/sysctl net.rds.tcp.rds_tcp_rcvbuf=10000")
+            ip(f"netns exec {net} /usr/sbin/sysctl net.rds.tcp.rds_tcp_sndbuf=10000")
+
+    ksft_pr("done", nr_send, nr_recv)
+
+    check_info(sockets)
+
+    # We're done sending and receiving stuff, now let's check if what
+    # we received is what we sent.
+    return verify_hashes(send_hashes, recv_hashes)
+
 def stop_pcaps():
     """Stop tcpdump processes.
 
@@ -267,7 +320,6 @@ PACKET_CORRUPTION=str(args.corruption)+'%'
 PACKET_DUPLICATE=str(args.duplicate)+'%'
 
 setup_tcp()
-addrs = tcp_addrs
 
 print("TAP version 13")
 print("1..1")
@@ -277,56 +329,13 @@ if args.timeout > 0:
     signal.alarm(args.timeout)
     signal.signal(signal.SIGALRM, signal_handler)
 
-sockets = [
-    netns_socket(NET0, socket.AF_RDS, socket.SOCK_SEQPACKET),
-    netns_socket(NET1, socket.AF_RDS, socket.SOCK_SEQPACKET),
-]
-
-for s, addr in zip(sockets, addrs):
-    s.bind(addr)
-    s.setblocking(0)
-
-send_hashes = {}
-recv_hashes = {}
-
-ep = select.epoll()
-
-for s in sockets:
-    ep.register(s, select.EPOLLRDNORM)
-
-NUM_PACKETS = 50000
-nr_send = 0
-nr_recv = 0
-
-while nr_send < NUM_PACKETS:
-
-    # Send as much as we can without blocking
-    ksft_pr("sending...", nr_send, nr_recv)
-    nr_send = send_burst(sockets, addrs, send_hashes, nr_send, NUM_PACKETS)
-
-    # Receive as much as we can without blocking
-    ksft_pr("receiving...", nr_send, nr_recv)
-    while nr_recv < nr_send:
-        nr_recv = recv_burst(ep, sockets, addrs, recv_hashes, nr_recv)
-
-    # exercise net/rds/tcp.c:rds_tcp_sysctl_reset()
-    for net in [NET0, NET1]:
-        ip(f"netns exec {net} /usr/sbin/sysctl net.rds.tcp.rds_tcp_rcvbuf=10000")
-        ip(f"netns exec {net} /usr/sbin/sysctl net.rds.tcp.rds_tcp_sndbuf=10000")
-
-ksft_pr("done", nr_send, nr_recv)
-
-check_info(sockets)
+ret = snd_rcv_packets(tcp_addrs, [NET0, NET1])
 
 # cancel timeout
 signal.alarm(0)
 
 stop_pcaps()
 
-# We're done sending and receiving stuff, now let's check if what
-# we received is what we sent.
-ret = verify_hashes(send_hashes, recv_hashes)
-
 if ret == 0:
     ksft_pr("Success")
     print("ok 1 rds selftest")
-- 
2.25.1


