Return-Path: <linux-rdma+bounces-22761-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xhc3IqQNSmpn9wAAu9opvQ
	(envelope-from <linux-rdma+bounces-22761-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 09:54:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 014CD709417
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 09:54:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=sP0RVb+f;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22761-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22761-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 900B7300CFFC
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2026 07:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FD4367285;
	Sun,  5 Jul 2026 07:54:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A89F25B085;
	Sun,  5 Jul 2026 07:54:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783238046; cv=none; b=Gg81ZdFpTOg+a+FH9IP/UAI4LoRReYUN+PlYFM8/vx/SnLXnLjEq0eC+UjQUxat/4ARSFSsivxMRqeYdy5gzNs6rojuL0HVZyh/w1pK4cR4o9lavz6TjmTf54IA2USej2FmZgMpK7vZ0eQDcf5fPse1Y7v95nhrQlGLa1BLsjmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783238046; c=relaxed/simple;
	bh=n2GyQ/H/7d31tZ1hqL32A711a82Cf5C6FGNUFvFI2wo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZM4wKFzMuYNrH13vPyepItQIkK/tF2TGaU9a/JBs54s0XRX0FoJkedqnl5O4QqfaMjXQq6r57czZqhQsfFCd/yZRRGsY++0kEdMXNwe9e3Srpz3v9nbtTeRYMbJyxwqljUMPywCHymEkGXPsIvaXQvRuQjxt0NB7eNBkzdTT1Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sP0RVb+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B2EEC2BCC6;
	Sun,  5 Jul 2026 07:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783238046;
	bh=n2GyQ/H/7d31tZ1hqL32A711a82Cf5C6FGNUFvFI2wo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sP0RVb+f5OG2fkCdWzPXVW3E54v3SM12RCfOBZL/5z38kQ6DcLROrEF5ty7GzFVGD
	 O0IJLJTXqT3ZAriOg2M1SHyw8lT7At2jZtkT9hgFZQQjcKQARANWMD4rPPAZbcFCs6
	 JHK7FMwYIRKxtfog97F09IJfwfwCSOZDqYNyMd1oubd9OSftud4jbubJ+0DgLAKWd+
	 0XbRo8f5zWRCPqODTsNetDcdHJLsVWCt3k3jYuEOVuMro4fNxik00fzUUjXO+aHiEc
	 oqlSLfyADazNIDDs18Hi22X2NADjwHc1//owI5uNg89ptdHEqVP1jILUJiNeb+evYk
	 e8FJ2ZCN4N3UQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1764C44500;
	Sun,  5 Jul 2026 07:54:05 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Sun, 05 Jul 2026 02:54:05 -0500
Subject: [PATCH net v4 1/3] net/smc: bound the wire-controlled producer
 cursor to the RMB
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-b4-disp-28a1bbca-v4-1-be089b98acc6@proton.me>
References: <20260705-b4-disp-28a1bbca-v4-0-be089b98acc6@proton.me>
In-Reply-To: <20260705-b4-disp-28a1bbca-v4-0-be089b98acc6@proton.me>
To: Dust Li <dust.li@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Sidraya Jayagond <sidraya@linux.ibm.com>, 
 Eric Dumazet <edumazet@google.com>, "D. Wythe" <alibuda@linux.alibaba.com>, 
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
 Wenjia Zhang <wenjia@linux.ibm.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Stefan Raspl <raspl@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Mahanta Jambigi <mjambigi@linux.ibm.com>, 
 Tony Lu <tonylu@linux.alibaba.com>, Ursula Braun <ubraun@linux.ibm.com>, 
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783238044; l=3661;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=dK/lA0d+Xw6g4N5W2Xg6NTDQYO7ediB5H1cZmNqV8pQ=;
 b=s1TEuFC9c3O8kmST6wxjYYkUaXsu9w/WlMvh7M1rhX+qNvjFC5ZrdMCHc4BwanxJqwMQ7D/T3
 NX7otoDTXYaCJ6qkRD1UwA+yKoQJHkgzd6cE+sWw5kP5jX8igf0Hxp9
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dust.li@linux.alibaba.com,m:davem@davemloft.net,m:sidraya@linux.ibm.com,m:edumazet@google.com,m:alibuda@linux.alibaba.com,m:kuba@kernel.org,m:horms@kernel.org,m:wenjia@linux.ibm.com,m:pabeni@redhat.com,m:raspl@linux.ibm.com,m:guwen@linux.alibaba.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:ubraun@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22761-lists,linux-rdma=lfdr.de,hexlabsecurity.proton.me];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-rdma@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	HAS_REPLYTO(0.00)[hexlabsecurity@proton.me];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 014CD709417

From: Bryam Vargas <hexlabsecurity@proton.me>

smcr_cdc_msg_to_host() and smcd_cdc_msg_to_host() import a peer's
producer cursor from the wire into conn->local_rx_ctrl.prod without
bounding it against the receive buffer. The urgent-data path in
smc_cdc_msg_recv_action() then uses that count as a raw index into the
RMB, so a peer that advertises a producer cursor past rmb_desc->len
reads out of bounds of the RMB allocation in the receive tasklet and
can disclose adjacent kernel memory.

Bound the producer cursor count to rmb_desc->len at the wire-to-host
conversion, for both SMC-R and SMC-D. Bound only the producer cursor:
the consumer cursor indexes the peer's RMB and is bounded by
peer_rmbe_size, so clamping it to our rmb_desc->len would under-credit
peer_rmbe_space and stall transmit to a peer with a larger RMB.
Conforming peers are unaffected.

Fixes: de8474eb9d50 ("net/smc: urgent data support")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 net/smc/smc_cdc.h | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
index 696cc11f2303..ca76ef630356 100644
--- a/net/smc/smc_cdc.h
+++ b/net/smc/smc_cdc.h
@@ -221,7 +221,8 @@ static inline void smc_host_msg_to_cdc(struct smc_cdc_msg *peer,
 
 static inline void smc_cdc_cursor_to_host(union smc_host_cursor *local,
 					  union smc_cdc_cursor *peer,
-					  struct smc_connection *conn)
+					  struct smc_connection *conn,
+					  int max_count)
 {
 	union smc_host_cursor temp, old;
 	union smc_cdc_cursor net;
@@ -235,6 +236,15 @@ static inline void smc_cdc_cursor_to_host(union smc_host_cursor *local,
 	if ((old.wrap == temp.wrap) &&
 	    (old.count > temp.count))
 		return;
+	/* The peer producer cursor is wire-controlled and is later used as a
+	 * raw index into our RMB by the urgent path; bound its count to the
+	 * RMB.  max_count == 0 leaves the consumer cursor unbounded here: it
+	 * indexes the peer's RMB (bounded by peer_rmbe_size, not our
+	 * rmb_desc->len), so clamping it to rmb_desc->len would under-credit
+	 * peer_rmbe_space and stall transmit to peers with a larger RMB.
+	 */
+	if (max_count && temp.count > max_count)
+		temp.count = max_count;
 	smc_curs_copy(local, &temp, conn);
 }
 
@@ -246,8 +256,13 @@ static inline void smcr_cdc_msg_to_host(struct smc_host_cdc_msg *local,
 	local->len = peer->len;
 	local->seqno = ntohs(peer->seqno);
 	local->token = ntohl(peer->token);
-	smc_cdc_cursor_to_host(&local->prod, &peer->prod, conn);
-	smc_cdc_cursor_to_host(&local->cons, &peer->cons, conn);
+	/* bound the wire-controlled producer cursor to our RMB (used as a raw
+	 * index by the urgent path); leave the consumer cursor unbounded -- it
+	 * indexes the peer's RMB and is bounded by peer_rmbe_size.
+	 */
+	smc_cdc_cursor_to_host(&local->prod, &peer->prod, conn,
+			       conn->rmb_desc->len);
+	smc_cdc_cursor_to_host(&local->cons, &peer->cons, conn, 0);
 	local->prod_flags = peer->prod_flags;
 	local->conn_state_flags = peer->conn_state_flags;
 }
@@ -260,6 +275,12 @@ static inline void smcd_cdc_msg_to_host(struct smc_host_cdc_msg *local,
 
 	temp.wrap = peer->prod.wrap;
 	temp.count = peer->prod.count;
+	/* the peer producer cursor is wire-controlled and is used as a raw
+	 * index into our RMB by the urgent path; bound it to the RMB.  The
+	 * consumer cursor below indexes the peer's RMB and is left unbounded.
+	 */
+	if (temp.count > conn->rmb_desc->len)
+		temp.count = conn->rmb_desc->len;
 	smc_curs_copy(&local->prod, &temp, conn);
 
 	temp.wrap = peer->cons.wrap;

-- 
2.43.0



