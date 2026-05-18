Return-Path: <linux-rdma+bounces-20862-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGu0M6BqCmp+1AQAu9opvQ
	(envelope-from <linux-rdma+bounces-20862-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 03:25:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D16564C76
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 03:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7006C30234DD
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 01:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B176258EFF;
	Mon, 18 May 2026 01:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7oZstat"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C78B23A564;
	Mon, 18 May 2026 01:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779067488; cv=none; b=TPv+M5EFk1i34shyaRPkNWQ480WZSHS/SPcZBkjgVW4qyq7585/Vu0wftJGdviFitbDJ6yb77GPG8hmu7ryP0WMGBm11Hx6ZKrdtcXNmIBmUXsc+jT+q52X7LUBUSh0jIIHZTxPuEgBG+y/qmtf8PoupuCs9EhSMxNlPSzX/aBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779067488; c=relaxed/simple;
	bh=KXhbGx709dHbyVlecT2ABR6CZcd93YZjlz3txdsNrf8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f1qVT8QluJGqdrgLB9MSwNKFMfmPtBYCN24f8CJVdYm8WKjD6Tuiarui1+VUUzCa/GgZK3ECP4QL1Z5868vyhMzIk45BlxGJKIcpYUip3XPaUEfoTVzQh47xGwWi/Ysyoc8TaRfzowZC5GuyIroCugTBoCs2r0KhkrMSkoeuz6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7oZstat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36837C2BCB0;
	Mon, 18 May 2026 01:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779067487;
	bh=KXhbGx709dHbyVlecT2ABR6CZcd93YZjlz3txdsNrf8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Y7oZstatUlCrr+/E9XDOAgJlnT8pObc1TryUOfnhsUhRDqKaW+Lphs8b7DQ8P+BKJ
	 U+ZKJKaFGTp+WHmzlF5Bd5S/2geZvE1EN3sGwxcoNd5kyUCSr3a80tJmk8cpnDCnVP
	 epNwLDec1bCBKtcgql4a6SsO38kRr69P9WajjGj3S41fzB/p1ug4ml6+fZF/SthzAK
	 0EPuICp9nrarrXA893XO9UHCzz3ykIqsoJkNGB5J9Lg9prD8bhvcssT7GL+SGCylZj
	 KMocOsprQsAIIzqkclTIniuVSMlb8xmjaSJR0WZgcQzQML5CBkejDVSEGeXNILeeor
	 xNkiSKnA1RjfQ==
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
Subject: [PATCH net-next v3 04/11] selftests: rds: Add helper function send_burst() in test.py
Date: Sun, 17 May 2026 18:24:36 -0700
Message-Id: <20260518012443.2629206-5-achender@kernel.org>
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
X-Rspamd-Queue-Id: 52D16564C76
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
	TAGGED_FROM(0.00)[bounces-20862-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,test.py:url]
X-Rspamd-Action: no action

Hoist the send packet logic in test.py into a helper function,
send_burst().  This is a preparatory refactoring for the rds over ROCE
series that helps modularize the send/recv logic. Breaking up the logic
now will help avoid large function pylint errors later.  No functional
changes are introduced in this patch.

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/test.py | 50 +++++++++++++------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
index d64af9e662e8c..d6e872af13600 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -79,6 +79,31 @@ def netns_socket(netns, *sock_args):
     u1.close()
     return socket.fromfd(fds[0], *sock_args)
 
+def send_burst(socks, ip_addrs, snd_hashes, nr_sent, nr_total):
+    """Send until blocked or nr_total reached. Return updated nr_sent."""
+
+    while nr_sent < nr_total:
+        data = hashlib.sha256(
+            f'packet {nr_sent}'.encode('utf-8')).hexdigest().encode('utf-8')
+        # pseudo-random send/receive pattern
+        snd_idx = nr_sent % 2
+        rcv_idx = 1 - (nr_sent % 3) % 2
+
+        snd = socks[snd_idx]
+        rcv = socks[rcv_idx]
+        try:
+            snd.sendto(data, ip_addrs[rcv_idx])
+        except BlockingIOError:
+            return nr_sent
+        except OSError as e:
+            if e.errno in (errno.ENOBUFS, errno.ECONNRESET, errno.EPIPE):
+                return nr_sent
+            raise
+        snd_hashes.setdefault((snd.fileno(), rcv.fileno()),
+                hashlib.sha256()).update(f'<{data}>'.encode('utf-8'))
+        nr_sent += 1
+    return nr_sent
+
 def check_info(socks):
     """
     Check all rds info pages for errors
@@ -234,10 +259,6 @@ fileno_to_socket = {
 
 addr_to_socket = dict(zip(addrs, sockets))
 
-socket_to_addr = {
-    s: addr for addr, s in zip(addrs, sockets)
-}
-
 send_hashes = {}
 recv_hashes = {}
 
@@ -251,27 +272,10 @@ nr_send = 0
 nr_recv = 0
 
 while nr_send < NUM_PACKETS:
+
     # Send as much as we can without blocking
     ksft_pr("sending...", nr_send, nr_recv)
-    while nr_send < NUM_PACKETS:
-        send_data = hashlib.sha256(
-            f'packet {nr_send}'.encode('utf-8')).hexdigest().encode('utf-8')
-
-        # pseudo-random send/receive pattern
-        sender = sockets[nr_send % 2]
-        receiver = sockets[1 - (nr_send % 3) % 2]
-
-        try:
-            sender.sendto(send_data, socket_to_addr[receiver])
-            send_hashes.setdefault((sender.fileno(), receiver.fileno()),
-                    hashlib.sha256()).update(f'<{send_data}>'.encode('utf-8'))
-            nr_send = nr_send + 1
-        except BlockingIOError:
-            break
-        except OSError as e:
-            if e.errno in [errno.ENOBUFS, errno.ECONNRESET, errno.EPIPE]:
-                break
-            raise
+    nr_send = send_burst(sockets, addrs, send_hashes, nr_send, NUM_PACKETS)
 
     # Receive as much as we can without blocking
     ksft_pr("receiving...", nr_send, nr_recv)
-- 
2.25.1


