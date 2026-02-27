Return-Path: <linux-rdma+bounces-17320-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +D5rOlb+oWl4yAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17320-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 21:28:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FC91BD9FE
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 21:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E92453087D39
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 20:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B28451066;
	Fri, 27 Feb 2026 20:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="in37zzSy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BB438B7C1;
	Fri, 27 Feb 2026 20:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772223818; cv=none; b=HOWkm+RBRdKP3Cpx+hYDMmG5V/1QUheQWnhRMS6pLSImO8GcUxpFo6ZBjlNXvpnNhvfTGZF25wqyHyYcVDxM5XxO5B6/wK+tibzdIhZjtc2sFcO73SYBv7F7JJ+UVhyR2lS5Ly6SoxbE9ZYKWE0lZamX2MD3l9NASAetSFNPxQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772223818; c=relaxed/simple;
	bh=ORNhQA+f5As1svKofS6FajCIQbe9YoKE8GkVfQUGCOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C18rZg0RiSTfKAQEBHcSPgYQ7Ly+ETt/S2P7d0UbVpz3mGkGiLSdpx8eKywC8641OvtLAV07dGz8QbTEOqOM5iLPDJIBP8c/THdOJwp1qGH4M4b+pmQ7YWQI6CAQwpEBsjq8Xgm5LInWCiOu8pHKW2iVBdbHh7+0sKramqPBDDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=in37zzSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5C6C116C6;
	Fri, 27 Feb 2026 20:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772223817;
	bh=ORNhQA+f5As1svKofS6FajCIQbe9YoKE8GkVfQUGCOc=;
	h=From:To:Cc:Subject:Date:From;
	b=in37zzSyNDRmzaQTF8cASNe5eyrsMY/qybw+Kwtljh77/wJHIMdQ5FFKjEWtRmFa6
	 b4P3+AhT5B5w97Efs6yezWmIjTNQezZnGzz1HYbCrc5FqhQp+vvBhVH8XJ1pk8Opea
	 +nB/XPK8sOGGFKQb5jAcba+0e1761Weha0VFoRclk3zUrxo0NNXR8loOCAYYbdKs1F
	 ACvJ5BU32J1FO8X3MU2Qdal+f8TSZGAi8QRitEP2EVcEeCUt8dw5oeTWLTkttQAK/M
	 kaP018voC/C+4hgj47WHHhSPsZxtysLyS6yi2TtfRiLKrUFL1FoHeXMOILZF5PMfBB
	 sLVrGbabsZ9ZQ==
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
Subject: [PATCH net v2] net/rds: Fix circular locking dependency in rds_tcp_tune
Date: Fri, 27 Feb 2026 13:23:36 -0700
Message-ID: <20260227202336.167757-1-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-17320-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 95FC91BD9FE
X-Rspamd-Action: no action

syzbot reported a circular locking dependency in rds_tcp_tune() where
sk_net_refcnt_upgrade() is called while holding the socket lock:

======================================================
WARNING: possible circular locking dependency detected
======================================================
kworker/u10:8/15040 is trying to acquire lock:
ffffffff8e9aaf80 (fs_reclaim){+.+.}-{0:0},
at: __kmalloc_cache_noprof+0x4b/0x6f0

but task is already holding lock:
ffff88805a3c1ce0 (k-sk_lock-AF_INET6){+.+.}-{0:0},
at: rds_tcp_tune+0xd7/0x930

The issue occurs because sk_net_refcnt_upgrade() performs memory
allocation (via get_net_track() -> ref_tracker_alloc()) while the
socket lock is held, creating a circular dependency with fs_reclaim.

Fix this by moving sk_net_refcnt_upgrade() outside the socket lock
critical section. This is safe because the fields modified by the
sk_net_refcnt_upgrade() call (sk_net_refcnt, ns_tracker) are not
accessed by any concurrent code path at this point.

v2:
  - Corrected fixes tag
  - check patch line wrap nits
  - ai commentary nits

Reported-by: syzbot+2e2cf5331207053b8106@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2e2cf5331207053b8106
Fixes: 3a58f13a881e ("net: rds: acquire refcount on TCP sockets")
Signed-off-by: Allison Henderson <achender@kernel.org>
---
 net/rds/tcp.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 04f310255692..654e23d13e3d 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -490,18 +490,24 @@ bool rds_tcp_tune(struct socket *sock)
 	struct rds_tcp_net *rtn;
 
 	tcp_sock_set_nodelay(sock->sk);
-	lock_sock(sk);
 	/* TCP timer functions might access net namespace even after
 	 * a process which created this net namespace terminated.
 	 */
 	if (!sk->sk_net_refcnt) {
-		if (!maybe_get_net(net)) {
-			release_sock(sk);
+		if (!maybe_get_net(net))
 			return false;
-		}
+		/*
+		 * sk_net_refcnt_upgrade() must be called before lock_sock()
+		 * because it does a GFP_KERNEL allocation, which can trigger
+		 * fs_reclaim and create a circular lock dependency with the
+		 * socket lock.  The fields it modifies (sk_net_refcnt,
+		 * ns_tracker) are not accessed by any concurrent code path
+		 * at this point.
+		 */
 		sk_net_refcnt_upgrade(sk);
 		put_net(net);
 	}
+	lock_sock(sk);
 	rtn = net_generic(net, rds_tcp_netid);
 	if (rtn->sndbuf_size > 0) {
 		sk->sk_sndbuf = rtn->sndbuf_size;
-- 
2.43.0


