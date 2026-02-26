Return-Path: <linux-rdma+bounces-17245-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCxmAI68oGkDmQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17245-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 22:35:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C0A1AFE18
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 22:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93ED0301AA87
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 21:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B880426EBF;
	Thu, 26 Feb 2026 21:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzXk8lea"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D772389E14;
	Thu, 26 Feb 2026 21:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772141696; cv=none; b=POvIRo63851neaeSmQatzVBW6vvvQyd9SidQ4xjzG/XTqG68gV1bFzKxGaGKmGvxJmZXAagRk6K5Q1sFuwotRRfr/SMvM4D3dlrjbiXapPIBhykOGhF/ZwJRwezobqMuhyu7xxdwtBbY9tQ34RJUezWmEVez8xvKvJbUGFEGqtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772141696; c=relaxed/simple;
	bh=9nUUaoM3WbzkeWzo1yrHWw8wUwpA8/X0UVvQxvXVE60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gjV47vpzwdEa7WVzeyfJd75eemHcUvWifAEuwWHp0nt9pak4CwG27Kjy7rVLrFkEKjVLOfLxzhXJ/eEQQ5JXwSk+JsM8E5eB+AKSEoOpq4u/16ot1Qly1dlFOHVf/cRpci+AtPPr/4rwG6zb2k3TkcG+GqFmI7ZW/HGvewlpDNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzXk8lea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230CBC19423;
	Thu, 26 Feb 2026 21:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772141695;
	bh=9nUUaoM3WbzkeWzo1yrHWw8wUwpA8/X0UVvQxvXVE60=;
	h=From:To:Cc:Subject:Date:From;
	b=BzXk8lea11EjSe2Ca8CztMeOaCs8VlYfJo+r0Ex6gJ9j/m5/3mF12YwzcQ95CCsFz
	 bD1wLeYHdc04+SyJmhInvl9cgduChYxvdADojI9g8V+ENwrebOeEhnYnJddv6y4hNy
	 OAoSDe37XKXXAGjd8Wv0VGxuyHMbL6Ebtr9OuhLOeRk9iGlTnXG/Df1pDk7hzaIywR
	 93s9x/QcjtWE/dMUklO0PbTfdm2k4/EybdbATy5Dy0dU55BvCkw5vk7SQpHbeE9rEz
	 DoTFd6D+exQevPdVgeHIGeB2nyuAdd3Dk3i9AWxRSFf2BBWSyeHOqRqxSBZx9li15M
	 m3bsMYjP37vEQ==
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
Subject: [PATCH net-next] net/rds: Fix circular locking dependency in rds_tcp_tune
Date: Thu, 26 Feb 2026 14:34:54 -0700
Message-ID: <20260226213454.85586-1-achender@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-17245-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 70C0A1AFE18
X-Rspamd-Action: no action

syzbot reported a circular locking dependency in rds_tcp_tune() where
sk_net_refcnt_upgrade() is called while holding the socket lock:

======================================================
WARNING: possible circular locking dependency detected
------------------------------------------------------
kworker/u10:8/15040 is trying to acquire lock:
ffffffff8e9aaf80 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_cache_noprof+0x4b/0x6f0

but task is already holding lock:
ffff88805a3c1ce0 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: rds_tcp_tune+0xd7/0x930

The issue occurs because sk_net_refcnt_upgrade() performs memory allocation
(via get_net_track() -> ref_tracker_alloc()) while the socket lock is held,
creating a circular dependency with fs_reclaim.

Fix this by moving sk_net_refcnt_upgrade() outside the socket lock critical
section. Since the fresh socket is not yet exposed to other threads, no
locks are needed at this time.

Reported-by: syzbot+2e2cf5331207053b8106@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2e2cf5331207053b8106
Fixes: 5c70eb5c593d ("net: better track kernel sockets lifetime")
Signed-off-by: Allison Henderson <achender@kernel.org>
---
 net/rds/tcp.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 04f310255692..da22b3dfdbf0 100644
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
+		 * We call sk_net_refcnt_upgrade before the lock_sock since it is
+		 * not yet shared, no lock is needed at this time.  Further,
+		 * because sk_net_refcnt_upgrade does a GFP_KERNEL allocation,
+		 * this can trigger an fs_reclaim in other systems which creates
+		 * a circular lock dependancy.  Avoid this by upgrading the
+		 * refcnt before the locking the socket.
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


