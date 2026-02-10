Return-Path: <linux-rdma+bounces-16702-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIDbMsD2imkePAAAu9opvQ
	(envelope-from <linux-rdma+bounces-16702-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 10:13:36 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB5F118B53
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 10:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7C563047DCB
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 09:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0689D340D8C;
	Tue, 10 Feb 2026 09:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkA0C70N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC19B340A4C;
	Tue, 10 Feb 2026 09:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770714759; cv=none; b=hkQMU668MZ9pKrecH2L0VxL7fsPIOAkbrQB6MVFl5HRfaPXFred24yY+Ke5xHQyRHITAnKhuI27EINop8Euj3cPQMcIsgifitEfc1PP6v/0XbnYGTbdhnXZfprLvbTQ5CEJNncCt4VIFA/ReyW4t+VhwfdrhuUQRLJzOjpRJCWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770714759; c=relaxed/simple;
	bh=GwpcvvAZ0c+F+p4CirK9eRn7hEIXOAm+mSqjiOX0OZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSDNjOGxyE6nnS4Q50dFH41vIbvCkMYzN4n6Ty/OHsxfLfZjHVcsrLI5ls/in6Iu9AZ9iGsEYpfBBN4pyEUlxO5ODX2W156bx/YlGtW7jrNdjDUB49bO3MGutX5j3Ul0KOWSaH0MeWxTbolCTYwWpKAVt7E020qPWnLDuWfPZlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkA0C70N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29562C2BCAF;
	Tue, 10 Feb 2026 09:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770714759;
	bh=GwpcvvAZ0c+F+p4CirK9eRn7hEIXOAm+mSqjiOX0OZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LkA0C70N30oqUliez5ebVINuO3tuHeZaQ4kEgYvmbwCnvjDJ1EXRbwWysNw3Rn32/
	 GEp8sfGsIyqcXNt9FSw64lHLPoBk+2jJ82cfQtqOuaxGCE4GW51D8+4ZfZ7/ZoDECx
	 eAvfVVZ84rqVV5oEFPUvGQtYE/X5Ss8IULBCE/EojrmjvcmBeUv1qNnKJuruw5j+Gr
	 tMMMsL1nfmRK9ZmsBEhJFkcYNP163oPwzkrVU/gwir4s4IGjhKNXwqAvFahbtBFASP
	 Zza6B6Au+9n6hkju2NpjFrU8CGnEJULUVu90JByjVf485vtbGFgaH3gbYqvbpT8Ujl
	 cqJ1ODNMcMBrg==
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
Subject: [PATCH net-next v3 4/4] net/rds: Use proper peer port number even when not connected
Date: Tue, 10 Feb 2026 02:12:35 -0700
Message-ID: <20260210091235.1817860-5-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210091235.1817860-1-achender@kernel.org>
References: <20260210091235.1817860-1-achender@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16702-lists,linux-rdma=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CB5F118B53
X-Rspamd-Action: no action

From: Greg Jumper <greg.jumper@oracle.com>

The function rds_tcp_get_peer_sport() should return the peer port of a
socket, even when the socket is not currently connected, so that RDS
can reliably determine the MPRDS "lane" corresponding to the port.

rds_tcp_get_peer_sport() calls kernel_getpeername() to get the port
number; however, when paths between endpoints frequently drop and
reconnect, kernel_getpeername() can return -ENOTCONN, causing
rds_tcp_get_peer_sport() to return an error, and ultimately causing
RDS to use the wrong lane for a port when reconnecting to a peer.

This patch modifies rds_tcp_get_peer_sport() to directly call the
socket-specific get-name function (inet_getname() in this case) that
kernel_getpeername() also calls.  The socket-specific function offers
an additional argument which, when set to a value greater than 1,
causes the function to return the socket's peer name even when the
socket is not connected, which in turn allows rds_tcp_get_peer_sport()
to return the correct port number.

Signed-off-by: Greg Jumper <greg.jumper@oracle.com>
Signed-off-by: Allison Henderson <achender@kernel.org>
---
 net/rds/tcp_listen.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index f2c4778be0b3..ba283c8ffa64 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -67,7 +67,14 @@ rds_tcp_get_peer_sport(struct socket *sock)
 	} saddr;
 	int sport;
 
-	if (kernel_getpeername(sock, &saddr.addr) >= 0) {
+	/* Call the socket's getname() function (inet_getname() in this case)
+	 * with a final argument greater than 1 to get the peer's port
+	 * regardless of whether the socket is currently connected.
+	 * Using peer=2 will get the peer port even during reconnection states
+	 * (TCPF_CLOSE, TCPF_SYN_SENT). This avoids -ENOTCONN while
+	 * inet_dport still contains the correct peer port.
+	 */
+	if (sock->ops->getname(sock, &saddr.addr, 2) >= 0) {
 		switch (saddr.addr.sa_family) {
 		case AF_INET:
 			sport = ntohs(saddr.sin.sin_port);
@@ -177,7 +184,7 @@ void rds_tcp_conn_slots_available(struct rds_connection *conn, bool fan_out)
 
 	if (fan_out)
 		/* Delegate fan-out to a background worker in order
-		 * to allow "kernel_getpeername" to acquire a lock
+		 * to allow "sock->ops->getname()" to acquire a lock
 		 * on the socket.
 		 * The socket is already locked in this context
 		 * by either "rds_tcp_recv_path" or "tcp_v{4,6}_rcv",
-- 
2.43.0


