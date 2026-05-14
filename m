Return-Path: <linux-rdma+bounces-20640-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APswM9pQBWpRUwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20640-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 06:34:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9277053DB21
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 06:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3D7E305D382
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 04:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C323B83E3;
	Thu, 14 May 2026 04:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUuSLAca"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268B73B0ACE;
	Thu, 14 May 2026 04:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778733215; cv=none; b=oUDWhKjDgAxBShxZ23an6+epZvMr8WAnN+yLsdIhXRJoeGQpOn40F5rU1tI6zKLxey0VgJoXl4OvdZfNO5wegW2lK7Fznv7rcz0ovP1t6er6+iSZiOaH9YeFL66SSWnz5I9XduVXUMSAuIJBywkWbFSZAydWsKLUiSFaKu/QbyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778733215; c=relaxed/simple;
	bh=1MS+y8yt3Mph4v3tJsrbiJz4dts1TO9yaQQzyrhwjjg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TZ4xtdJG7dlt/rpf09id18xWavhkbsPMoZoShuNuhkNn/Ip0gEDqeP9DiEmlb1R15eyez3whU3FySfsJKaZ1i2ppU/PNY70hDUx7DkPrjaXJrCoPyJayl0RnphDcStWW9ofRH7Mhevd+i1G5ksaff7/5nFbD/Ps/sqEWZPAM4F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUuSLAca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772FDC2BCC6;
	Thu, 14 May 2026 04:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778733215;
	bh=1MS+y8yt3Mph4v3tJsrbiJz4dts1TO9yaQQzyrhwjjg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VUuSLAcaH6O0amhucU49+TPHiGKWOoi9mpa6ocduiaMfLm15TB/GVQaNx5Sy5aJ0/
	 3xg9BE84X4n5GMHYnVeLoDXwFEopb6zyx36SS6XhUADaI20Bs1HShnh2KKga/Sy44H
	 2QKu4AoKM5dQiKFvH3dnR35deJaVQ7Q1bo35UlLucIWSoaY9y6lSbskSZ+5+4mNAWL
	 1hp0EJR4MhOme+rsKZKTKJiCqAWHcijKR2T77FzffykeA5r5/8UgfO1rpdBqs/o+cf
	 yT+2ritcWZmW0H4Qdc1ZVx5sbGWAX/MeuOAxUH7r6px2ZjqQYUyj10g6OqG1Q5B7Q8
	 JvdtVVnWeY/1Q==
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
Subject: [PATCH net-next v2 4/9] selftests: rds: Add helper function recv_burst() in test.py
Date: Wed, 13 May 2026 21:33:25 -0700
Message-Id: <20260514043330.1718969-5-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260514043330.1718969-1-achender@kernel.org>
References: <20260514043330.1718969-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9277053DB21
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
	TAGGED_FROM(0.00)[bounces-20640-lists,linux-rdma=lfdr.de];
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
index d6e872af1360..ae74117b4174 100755
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
+            snd_idx = ip_addrs.index(adr)
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


