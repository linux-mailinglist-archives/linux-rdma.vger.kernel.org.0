Return-Path: <linux-rdma+bounces-20362-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MM3GInyEAWoFcAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20362-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 09:25:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDD05091F3
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 09:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A899303A241
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 07:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C116C37E30F;
	Mon, 11 May 2026 07:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SY9jJWGC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20DA37C909;
	Mon, 11 May 2026 07:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484200; cv=none; b=lQhOu8ycadQafPVFj2uMf05dgByMLkLUa2uFsVIVtfs/+aZoUG+KWWTzAlqDCx7KL4yvWH3sWO8ibYpZmi8TzcvjqUrm/eH1DDWXDMewML108+Nt2BPMlFBuHxl8G3l0fTkdCtmqF3oqB9WyZb6jLLFk6KmiXSeMnMMNBRgfGCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484200; c=relaxed/simple;
	bh=V3qXU3fR9Gh++RAdEZYQVSjSwBR795LlMb2T5AKtxfs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AI5/6l2tFPBQgVqG4DYjGpeBn0LSw00+DHRZGwaGm3Iw0exDAv5fmzIHKoLV8UNxiXAS9lKH51x+VHIYaCN9dRA5JlThrmgSEzQNDxv/4SGi23MMoJSxS/oqcRxnqVSUn72hR7JFgxlE/MMjbIoqzKdL5tDvTyZd6q1oA7qgn3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SY9jJWGC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE04CC2BCF5;
	Mon, 11 May 2026 07:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778484200;
	bh=V3qXU3fR9Gh++RAdEZYQVSjSwBR795LlMb2T5AKtxfs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SY9jJWGC9fh7YKFozsgNZyngCz9bur8kMA+P6wTTxO8YOayQiEwHOzaeHykvwkUzH
	 0U81FNY1b2rpQyjyNYh95knJtM50xXmZ4P8u1Zmv9D1VBYir9SqNHtuz8k/dHROVlC
	 I22nXuMT6R3GRDvICR3huNaxR10rOBO2iO6qFZYufBp2ZnHyVgueAIvqzteEWKkRp2
	 Wk4Eh8yzcNpo4mjiHc0H9cb8uR0IdSKI+bRruw/ZcGNjTeJIbM6zBr6Ar3Clahzy1U
	 0zU3+QWtUJJYCb173KQWy60Rdg4Fh5WmNlcU4NdFIsypLXcHKMRahsuUqFL213j+ve
	 RgB3CB8yUDgqw==
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
Subject: [PATCH net-next v1 4/9] selftests: rds: Add helper function send_burst() in test.py
Date: Mon, 11 May 2026 00:23:11 -0700
Message-Id: <20260511072316.1174045-5-achender@kernel.org>
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
X-Rspamd-Queue-Id: 2FDD05091F3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-20362-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,test.py:url]
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
index 5d4b039580df..d34e1af7887e 100755
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


