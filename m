Return-Path: <linux-rdma+bounces-16975-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOMFBVrulGnUIwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16975-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 23:40:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B24D6151909
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 23:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 776B1305375F
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 22:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C642318ED4;
	Tue, 17 Feb 2026 22:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v4zQslIL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3MVrS0KF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v4zQslIL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3MVrS0KF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F1A31BC94
	for <linux-rdma@vger.kernel.org>; Tue, 17 Feb 2026 22:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771367900; cv=none; b=pRSqQPQ/e28fJesuLDeA9okB1JKvjbUC5bdhrVg5OoM3bmHv4bBDm82cqQ3NzZ42WTNkMG35t3CiveNPBFve0sAu1rUv+4QRRRqfi3R39T3QWyN53qu9UVIDIrNunzKLI/1Lg6LJ6vtOJ59kqAL8Tmuje/poSouIor+n4XWWLwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771367900; c=relaxed/simple;
	bh=+DKt1mBzsLiShFFh8B6iBpud8ciA04kW82+oYG7pWLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aB7J9EaKVdCbbf7Zp+L+u0DTJUlhRoOSoHeECO3sanktNdAOrYmOcuWVm9zCUiwgtaRtCQYfu5BxYcADNhvuw+obSCtGf1DfLCbmq/uxeAg+h0DVVZVCvImcuxqHy8ZZBaJxE5gISclu1mt4VAzvuLqSkKpzAKlXdBrPopTkjm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v4zQslIL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3MVrS0KF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v4zQslIL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3MVrS0KF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8F4F93E72D;
	Tue, 17 Feb 2026 22:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771367896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ECOJdeq+iDoHzzyDiLrLZgE3lGYGDY7fJRokmdCYTb8=;
	b=v4zQslILrf5B/Ge5tmSoO8ntESgjkwc+9pYkhcT/YWlLI38wQt96HD4iL6PmfFSGmnIEKO
	W3eFPgl7EH0MZhdGY3cWGpnHS2KlQAN+xuvgpO118B/DPmd5H9elCYG1GzQG9fqmwQWizV
	MVsBObf+2wBxfHtACSH2k9snM7gDyRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771367896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ECOJdeq+iDoHzzyDiLrLZgE3lGYGDY7fJRokmdCYTb8=;
	b=3MVrS0KFkA5TEUtoVrXDhu4u8Mnd8ge3hpli4QoB9LxchSg71zxIw9oNcBFIH7uO8YlhdF
	WKdSwQdcPwTjZtBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=v4zQslIL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3MVrS0KF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771367896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ECOJdeq+iDoHzzyDiLrLZgE3lGYGDY7fJRokmdCYTb8=;
	b=v4zQslILrf5B/Ge5tmSoO8ntESgjkwc+9pYkhcT/YWlLI38wQt96HD4iL6PmfFSGmnIEKO
	W3eFPgl7EH0MZhdGY3cWGpnHS2KlQAN+xuvgpO118B/DPmd5H9elCYG1GzQG9fqmwQWizV
	MVsBObf+2wBxfHtACSH2k9snM7gDyRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771367896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ECOJdeq+iDoHzzyDiLrLZgE3lGYGDY7fJRokmdCYTb8=;
	b=3MVrS0KFkA5TEUtoVrXDhu4u8Mnd8ge3hpli4QoB9LxchSg71zxIw9oNcBFIH7uO8YlhdF
	WKdSwQdcPwTjZtBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B498C3EA65;
	Tue, 17 Feb 2026 22:38:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zFPMKNftlGnzUwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 17 Feb 2026 22:38:15 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: rds-devel@oss.oracle.com,
	linux-rdma@vger.kernel.org,
	gerd.rausch@oracle.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	allison.henderson@oracle.com,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com
Subject: [PATCH net v2] net/rds: fix recursive lock in rds_tcp_conn_slots_available
Date: Tue, 17 Feb 2026 23:38:02 +0100
Message-ID: <20260217223802.21659-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16975-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,5efae91f60932839f0a5];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B24D6151909
X-Rspamd-Action: no action

syzbot reported a recursive lock warning in rds_tcp_get_peer_sport() as
it calls inet6_getname() which acquires the socket lock that was already
held by __release_sock().

 kworker/u8:6/2985 is trying to acquire lock:
 ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
 ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: inet6_getname+0x15d/0x650 net/ipv6/af_inet6.c:533

 but task is already holding lock:
 ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
 ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: tcp_sock_set_cork+0x2c/0x2e0 net/ipv4/tcp.c:3694
   lock_sock_nested+0x48/0x100 net/core/sock.c:3780
   lock_sock include/net/sock.h:1709 [inline]
   inet6_getname+0x15d/0x650 net/ipv6/af_inet6.c:533
   rds_tcp_get_peer_sport net/rds/tcp_listen.c:70 [inline]
   rds_tcp_conn_slots_available+0x288/0x470 net/rds/tcp_listen.c:149
   rds_recv_hs_exthdrs+0x60f/0x7c0 net/rds/recv.c:265
   rds_recv_incoming+0x9f6/0x12d0 net/rds/recv.c:389
   rds_tcp_data_recv+0x7f1/0xa40 net/rds/tcp_recv.c:243
   __tcp_read_sock+0x196/0x970 net/ipv4/tcp.c:1702
   rds_tcp_read_sock net/rds/tcp_recv.c:277 [inline]
   rds_tcp_data_ready+0x369/0x950 net/rds/tcp_recv.c:331
   tcp_rcv_established+0x19e9/0x2670 net/ipv4/tcp_input.c:6675
   tcp_v6_do_rcv+0x8eb/0x1ba0 net/ipv6/tcp_ipv6.c:1609
   sk_backlog_rcv include/net/sock.h:1185 [inline]
   __release_sock+0x1b8/0x3a0 net/core/sock.c:3213

Reading from the socket struct directly is safe from both possible
paths. For rds_tcp_accept_one(), the socket was just accepted and no
concurrent access is possible yet. For rds_tcp_conn_slots_available()
the lock is already held because we are in the receiving path.

Note that it is also safe to call rds_tcp_conn_slots_available() from
rds_conn_shutdown() because the fan-out is disabled.

Fixes: 9d27a0fb122f ("net/rds: Trigger rds_send_ping() more than once")
Reported-by: syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5efae91f60932839f0a5
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: clarified commit message and add a comment around
rds_conn_shutdown() path 
---
 net/rds/connection.c |  3 +++
 net/rds/tcp_listen.c | 28 +++++-----------------------
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index 185f73b01694..a542f94c0214 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -455,6 +455,9 @@ void rds_conn_shutdown(struct rds_conn_path *cp)
 		rcu_read_unlock();
 	}
 
+	/* we do not hold the socket lock here but it is safe because
+	 * fan-out is disabled when calling conn_slots_available()
+	 */
 	if (conn->c_trans->conn_slots_available)
 		conn->c_trans->conn_slots_available(conn, false);
 }
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 6fb5c928b8fd..a36e5dfd6c66 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -59,30 +59,12 @@ void rds_tcp_keepalive(struct socket *sock)
 static int
 rds_tcp_get_peer_sport(struct socket *sock)
 {
-	union {
-		struct sockaddr_storage storage;
-		struct sockaddr addr;
-		struct sockaddr_in sin;
-		struct sockaddr_in6 sin6;
-	} saddr;
-	int sport;
-
-	if (kernel_getpeername(sock, &saddr.addr) >= 0) {
-		switch (saddr.addr.sa_family) {
-		case AF_INET:
-			sport = ntohs(saddr.sin.sin_port);
-			break;
-		case AF_INET6:
-			sport = ntohs(saddr.sin6.sin6_port);
-			break;
-		default:
-			sport = -1;
-		}
-	} else {
-		sport = -1;
-	}
+	struct sock *sk = sock->sk;
+
+	if (!sk)
+		return -1;
 
-	return sport;
+	return ntohs(inet_sk(sk)->inet_dport);
 }
 
 /* rds_tcp_accept_one_path(): if accepting on cp_index > 0, make sure the
-- 
2.53.0


