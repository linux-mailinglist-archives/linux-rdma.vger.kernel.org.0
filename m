Return-Path: <linux-rdma+bounces-16620-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNG/DmdRhWmV/wMAu9opvQ
	(envelope-from <linux-rdma+bounces-16620-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 03:26:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D0AF9478
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 03:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A88130431FD
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 02:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC23E26B77D;
	Fri,  6 Feb 2026 02:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtaEGCJh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAAC2376FD;
	Fri,  6 Feb 2026 02:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770344662; cv=none; b=Hzu8r55AXacOG8G0wrBDOP7VB1rGxjKcy+m0fSMqlJTZPoC5i8aKUt7rsZNtsALO8zfArCDLlNMR4R+9sIl3cOCB4OIF5BF60lJJGcKQStvBZatzzwKqZGDeuxaxIE0Lw3wgxDARN/lqEYdNdchSl/RFKzw5+lz8mKqGAmHC5Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770344662; c=relaxed/simple;
	bh=qDdyGBzY/1nJ3t8A3gYk8gVpOyr/91l2SBoUj7qH2uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u07JPqpYdhWXqRD4ANwrAdidymKno+LpYFTdQLItBaLO57GsEFsi1MehY0FMjShw7yRRgYqcWGkKuAFjz8mo7dWgLg6zhAhoR7wAHw9+ayIp16m5UoRDeQUwYFjwLGZQJtwKLorobMl/frtGw6ycbkBeTjSwqWiQpe/iUQvkb/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtaEGCJh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D69C2BC86;
	Fri,  6 Feb 2026 02:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770344662;
	bh=qDdyGBzY/1nJ3t8A3gYk8gVpOyr/91l2SBoUj7qH2uI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RtaEGCJhzehCyTDYtFSe+TsDjM0lyiLhICm3UAqNTRnrydP32NmMvTGHKXwnkEp/Z
	 Z96CCIkfsENEOTd8bDSxxojANRoM2sx5T2XW3rVHb79FTUUy8xoOHpx3fMAAKfeZxT
	 3uxubUNmhH2D73haWn5zNZQw7K1oGnHSvRQ770P7vmk/GvenslFB7mAYOMM/RxO9G9
	 grVhtVT2xxl+v6Jj7ELHcCKLNhQWf6tIgf48Fsxy3jYcypDvjG7/7a4RaPjA7KBtHB
	 gAy7aAc2Bv25oEJtMeAsWKZmCLEoNYWyd2ZaEbvwMnjww9bgD5moWz8qvBWzBI9iTp
	 jO13Mp+lfId9w==
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
Subject: [PATCH net-next v1 2/3] net/rds: Use proper peer port number even when not connected
Date: Thu,  5 Feb 2026 19:24:18 -0700
Message-ID: <20260206022419.1357513-3-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206022419.1357513-1-achender@kernel.org>
References: <20260206022419.1357513-1-achender@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-16620-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D7D0AF9478
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
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/tcp_listen.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 8fb8f7d26683..db4938fd1672 100644
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
-- 
2.43.0


