Return-Path: <linux-rdma+bounces-16916-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2G5LJ8MIk2nO1AEAu9opvQ
	(envelope-from <linux-rdma+bounces-16916-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 13:08:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C102F14339E
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 13:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 586B230015AF
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 12:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D771E30BF67;
	Mon, 16 Feb 2026 12:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Omjdcv3r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T+P+p3HJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Omjdcv3r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T+P+p3HJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9005A30C600
	for <linux-rdma@vger.kernel.org>; Mon, 16 Feb 2026 12:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771243710; cv=none; b=Y1SB9OoKAZKijbEy3RjhU/GpdMRcPhiTN7LHC2dXTyyDc4oNwzUinX0aOwyav6swdGp8up+DlZ4Uo0GFLFD8+gjik3/0+ZXju5iDLtmEEEVdi8Z3fq6qf/FyfPitxWQroSmCu7xaPLlK6gRhNtuaw6jEN4I1A2vINuU2L9kf5ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771243710; c=relaxed/simple;
	bh=6GPXy7vXHQlTym7ySv+gPvl8Qg7QGZUPlVsI+isqPbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=duZ6hR7mM/Snuuo0B5K3C4tptQAQZDxcCQc96cuY5BOivPuCYi9jpzBif9JymeUcT2H+Zs049wPjzqCHFQcMdRBCN2td2WSN9It2MAOxC4HfRlQNUJN+xfoMQZQQgXateUnT5AhPEf7OR69XKwwOxOn+8Vn3gk0afp2P0cA7+ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Omjdcv3r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T+P+p3HJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Omjdcv3r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T+P+p3HJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C32CC3E786;
	Mon, 16 Feb 2026 12:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771243706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=F5eHPdfnUZ49Jdwt5KIEyLMIFSoJX6GP49O+mT8nS3M=;
	b=Omjdcv3rzEAILDh7zR0NLm2g/EWq01P7kZginytGzLymwWd8WrdPUPUJWk3RjevDSVCBsn
	+AdybnAE30bAHXbvq9zsErkqBMyuqhQfR816RZGEBO/vfOc0RcmZ/zZPgXRhWdbXQapwAJ
	6l/Tx5hZmcE/sKjCW2TEbVrGuvVXe50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771243706;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=F5eHPdfnUZ49Jdwt5KIEyLMIFSoJX6GP49O+mT8nS3M=;
	b=T+P+p3HJ7U69VXjV4VBrqqbkcP4cqCdxnv0B8oKIRH4xKb9atlCEQ64FXkkQcZwurBs7Zs
	UWM6W64gSIGlM8Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Omjdcv3r;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=T+P+p3HJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771243706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=F5eHPdfnUZ49Jdwt5KIEyLMIFSoJX6GP49O+mT8nS3M=;
	b=Omjdcv3rzEAILDh7zR0NLm2g/EWq01P7kZginytGzLymwWd8WrdPUPUJWk3RjevDSVCBsn
	+AdybnAE30bAHXbvq9zsErkqBMyuqhQfR816RZGEBO/vfOc0RcmZ/zZPgXRhWdbXQapwAJ
	6l/Tx5hZmcE/sKjCW2TEbVrGuvVXe50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771243706;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=F5eHPdfnUZ49Jdwt5KIEyLMIFSoJX6GP49O+mT8nS3M=;
	b=T+P+p3HJ7U69VXjV4VBrqqbkcP4cqCdxnv0B8oKIRH4xKb9atlCEQ64FXkkQcZwurBs7Zs
	UWM6W64gSIGlM8Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0A473EA62;
	Mon, 16 Feb 2026 12:08:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uXoMLbkIk2lKHAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 16 Feb 2026 12:08:25 +0000
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
Subject: [PATCH net] net/rds: fix recursive lock in rds_tcp_conn_slots_available
Date: Mon, 16 Feb 2026 13:08:04 +0100
Message-ID: <20260216120804.14840-1-fmancera@suse.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16916-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,5efae91f60932839f0a5];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email]
X-Rspamd-Queue-Id: C102F14339E
X-Rspamd-Action: no action

syzbot reported a recursive lock warning in rds_tcp_get_peer_sport() as
it calls inet6_getname() which acquires the socket lock that was already
held by __release_lock().

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
paths, rds_tcp_accept_one() and rds_tcp_conn_slots_available() when
performing fan-out.

Fixes: 9d27a0fb122f ("net/rds: Trigger rds_send_ping() more than once")
Reported-by: syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5efae91f60932839f0a5
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
Note: syzbot failed to apply the patch for some reason. I don't
understand why.
---
 net/rds/tcp_listen.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

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


