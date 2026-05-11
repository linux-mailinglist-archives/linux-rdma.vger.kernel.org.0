Return-Path: <linux-rdma+bounces-20363-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBBlGiGEAWoFcAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20363-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 09:24:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E7B50916E
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 09:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 15ABD3008C9B
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 07:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083AA37F755;
	Mon, 11 May 2026 07:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXP6GWlX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FC637E2FE;
	Mon, 11 May 2026 07:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484201; cv=none; b=KK4UTfBE+qG5dIyZRwcjCeyW8hc4oWq24KLBIwgoMWmgf8G2sDzrqBtdFb6jIvL0l4HeJGTeOOj0ea0XmwqQvS26Rzsx3Z8sO0ATdCOCIkODl63zhW/gvvEB6djk7aKhV3CYHuWceNFE7xhNN0QoujdN+Q6fxl/N1Q3v7Yt0CFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484201; c=relaxed/simple;
	bh=rKiyxebOuqrCeHbPM0slncl8AbCPS5FpQRQhSCf4ygE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EW6DNu6jFlIMGMXu4BGwaraAA7pw1QbCFsV24o4rQRdNSSGLbHv5C6gtushA0iSazkmpHxyvYShgtKDNyxKoHlEP55CLSb/c7bXpnJ2pi9J/A3bwgZenB1BtQ50O6ihoAkwV3n1bOTrQNc78ZwtP6n/tZf5pzB+IBBm/KbyGHPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXP6GWlX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E9FC2BCFB;
	Mon, 11 May 2026 07:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778484201;
	bh=rKiyxebOuqrCeHbPM0slncl8AbCPS5FpQRQhSCf4ygE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lXP6GWlXNdCn4jSEdft3r6HpxkrfirzDjrtik7yenLzGoQMnyyVwAcoY/lnCAmkRZ
	 K5/oT0BwQcDRbhK0YxGlD44+1XKSmSpDoCuUvx9M7MPFv+0v3/fWPr9TH3k3QBoXAa
	 dnWHcYLr80DiLo8f3d1gp+2p/3+gKS4+zrq1LsSz8fZaQLpl3lHgmfD/0OzpRl6sD/
	 5wqJI1pDqneffoSazYAKVu+zHOuHr6ws5zOshulovyqsf5kgajwBLlfD3+7AePyrZQ
	 0xc2qyzowchpaKm0t99luhjtwppd0o2M3CdeB/DRVSpfIgw9l+bHMZdpWlahZ51R83
	 PLV/6eRs4DOug==
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
Subject: [PATCH net-next v1 5/9] selftests: rds: Add helper function recv_burst() in test.py
Date: Mon, 11 May 2026 00:23:12 -0700
Message-Id: <20260511072316.1174045-6-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260511072316.1174045-1-achender@kernel.org>
References: <20260511072316.1174045-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 82E7B50916E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-20363-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,test.py:url]
X-Rspamd-Action: no action

Hoist receive packet logic in test.py into a helper function,
recv_burst().  This is a preparatory refactoring for the rds over ROCE
series that helps modularize the send/recv logic. Breaking up the logic
now will help avoid large function pylint errors later.  No functional
changes are introduced in this patch.

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/test.py | 39 ++++++++++++-------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
index d34e1af7887e..2e06e95827dd 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -104,6 +104,24 @@ def send_burst(socks, ip_addrs, snd_hashes, nr_sent, nr_total):
         nr_sent += 1
     return nr_sent
 
+def recv_burst(epoll, socks, ip_addrs, rcv_hashes, nr_rcv):
+    """Drain whatever's readable from epoll. Return updated nr_recv."""
+    for filen, evntmask in epoll.poll():
+        if not evntmask & select.EPOLLRDNORM:
+            continue
+        rcv = next(s for s in socks if s.fileno() == filen)
+        while True:
+            try:
+                data, adr = rcv.recvfrom(1024)
+            except BlockingIOError:
+                break
+            snd_idx = ip_addrs.index(adr);
+            snd = socks[snd_idx]
+            rcv_hashes.setdefault((snd.fileno(), rcv.fileno()),
+                    hashlib.sha256()).update(f'<{data}>'.encode('utf-8'))
+            nr_rcv += 1
+    return nr_rcv
+
 def check_info(socks):
     """
     Check all rds info pages for errors
@@ -253,12 +271,6 @@ for s, addr in zip(sockets, addrs):
     s.bind(addr)
     s.setblocking(0)
 
-fileno_to_socket = {
-    s.fileno(): s for s in sockets
-}
-
-addr_to_socket = dict(zip(addrs, sockets))
-
 send_hashes = {}
 recv_hashes = {}
 
@@ -280,20 +292,7 @@ while nr_send < NUM_PACKETS:
     # Receive as much as we can without blocking
     ksft_pr("receiving...", nr_send, nr_recv)
     while nr_recv < nr_send:
-        for fileno, eventmask in ep.poll():
-            receiver = fileno_to_socket[fileno]
-
-            if eventmask & select.EPOLLRDNORM:
-                while True:
-                    try:
-                        recv_data, address = receiver.recvfrom(1024)
-                        sender = addr_to_socket[address]
-                        recv_hashes.setdefault((sender.fileno(),
-                            receiver.fileno()), hashlib.sha256()).update(
-                                    f'<{recv_data}>'.encode('utf-8'))
-                        nr_recv = nr_recv + 1
-                    except BlockingIOError:
-                        break
+        nr_recv = recv_burst(ep, sockets, addrs, recv_hashes, nr_recv)
 
     # exercise net/rds/tcp.c:rds_tcp_sysctl_reset()
     for net in [NET0, NET1]:
-- 
2.25.1


