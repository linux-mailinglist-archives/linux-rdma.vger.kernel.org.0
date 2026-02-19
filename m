Return-Path: <linux-rdma+bounces-17007-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMUwKI7ClmnjmAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17007-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 08:58:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0224F15CDFD
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 08:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEA773011C70
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 07:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAA03346B5;
	Thu, 19 Feb 2026 07:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lkQr5cRZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BmyviFyt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lkQr5cRZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BmyviFyt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B00619CD19
	for <linux-rdma@vger.kernel.org>; Thu, 19 Feb 2026 07:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771487881; cv=none; b=eu+slsQNdTKsq077VUP+ElqYnwVVIWxjqVypXt5YxX40Gj57SRirytiWRM2/N7kUYtSa3olIRp5n2mXa+easD4ee4AA6uIyYPIBuyaxlJ253fpqribTmKYJs/s35wzWU/3PbrwWbP5gRMkfehpeQfsVnIIsk17A/U0YPW41C5Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771487881; c=relaxed/simple;
	bh=e5bN8nw75LATuV/fHy7w/iNFPX9Ka0rmFDPS+JrWCS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=le45mCNTMWQnxGBzCZS+fsinrHLyQ1jO4oDqVi9YKaava8v9OOIZ1oh4sJSIA2focQEy8iSxVwfevLezpphgRsUgC1dnRLyLAlAjKZzrdMKl93NBKPl8CABEzQsaebf7D4ru1X5DXk8UIjuY4n4Qnf/ZrR271NkmsIqUNTQyLGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lkQr5cRZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BmyviFyt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lkQr5cRZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BmyviFyt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 46A055BCC3;
	Thu, 19 Feb 2026 07:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771487878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ygjc/uH2gjSmPoe9nD4e21U+qRN3Vh3aXZUJ/DBOSps=;
	b=lkQr5cRZVVXKMbgZ/bnWrsQSgGaFIDWyHzQijMCF83tGILJJ+kdny9k9jYLEdUAFEiVn0i
	7EzZaYmIGaMmo+FRLJXxuse85ZO5YYxm8zGyi5uYJUa9H3qdn04WF89CkLY2KCcXSqRKFZ
	QzAFGGVUNwnWwOD5p3CZE2jazqalAaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771487878;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ygjc/uH2gjSmPoe9nD4e21U+qRN3Vh3aXZUJ/DBOSps=;
	b=BmyviFytapaDMrbcJOaJBxwRnljsqL/83j5ornbQcQ85udWwRUXNYVwQUoSaNdXEUyIWXo
	D/YeceNI6M4hf4AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771487878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ygjc/uH2gjSmPoe9nD4e21U+qRN3Vh3aXZUJ/DBOSps=;
	b=lkQr5cRZVVXKMbgZ/bnWrsQSgGaFIDWyHzQijMCF83tGILJJ+kdny9k9jYLEdUAFEiVn0i
	7EzZaYmIGaMmo+FRLJXxuse85ZO5YYxm8zGyi5uYJUa9H3qdn04WF89CkLY2KCcXSqRKFZ
	QzAFGGVUNwnWwOD5p3CZE2jazqalAaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771487878;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ygjc/uH2gjSmPoe9nD4e21U+qRN3Vh3aXZUJ/DBOSps=;
	b=BmyviFytapaDMrbcJOaJBxwRnljsqL/83j5ornbQcQ85udWwRUXNYVwQUoSaNdXEUyIWXo
	D/YeceNI6M4hf4AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 684EE3EA65;
	Thu, 19 Feb 2026 07:57:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UYgaFoXClml2SwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 19 Feb 2026 07:57:57 +0000
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
Subject: [PATCH net v3] net/rds: fix recursive lock in rds_tcp_conn_slots_available
Date: Thu, 19 Feb 2026 08:57:38 +0100
Message-ID: <20260219075738.4403-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17007-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,5efae91f60932839f0a5];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email,suse.de:mid,suse.de:dkim,suse.de:email]
X-Rspamd-Queue-Id: 0224F15CDFD
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

Reading from the socket struct directly is safe from possible paths. For
rds_tcp_accept_one(), the socket has just been accepted and is not yet
exposed to concurrent access. For rds_tcp_conn_slots_available(), direct
access avoids the recursive deadlock seen during backlog processing
where the socket lock is already held from the __release_sock().

However, rds_tcp_conn_slots_available() is also called from the normal
softirq path via tcp_data_ready() where the lock is not held. This is
also safe because inet_dport is a stable 16 bits field. A READ_ONCE()
annotation as the value might be accessed lockless in a concurrent
access context.

Note that it is also safe to call rds_tcp_conn_slots_available() from
rds_conn_shutdown() because the fan-out is disabled.

Fixes: 9d27a0fb122f ("net/rds: Trigger rds_send_ping() more than once")
Reported-by: syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5efae91f60932839f0a5
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: clarified commit message and add a comment around
rds_conn_shutdown() path 
v3: used READ_ONCE() for lockless read and adjusted commit message
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
index 6fb5c928b8fd..dce7ac9d3197 100644
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
+	return ntohs(READ_ONCE(inet_sk(sk)->inet_dport));
 }
 
 /* rds_tcp_accept_one_path(): if accepting on cp_index > 0, make sure the
-- 
2.53.0


