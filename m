Return-Path: <linux-rdma+bounces-22204-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +jjeBxNlLmoqvQQAu9opvQ
	(envelope-from <linux-rdma+bounces-22204-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 10:23:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB86680A6D
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 10:23:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=RPY5kOlP;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22204-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22204-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3E1D3013B4D
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 08:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A95399360;
	Sun, 14 Jun 2026 08:23:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100DA1B4257;
	Sun, 14 Jun 2026 08:23:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781425411; cv=none; b=pnpP4u/EBCis+RvLMJKI/zxL/aQY1eMw6I5NqU3XgBKaCpI4LLhuZPPeqho3FhLyJ0hBc0C2+8lKAkI3AqHU9ZA40wI+f7vY6aHH75KNdCHRjBWzR3IvDkdtspXH3dwGdSnvsLBnfON9z9bF4nld2JdZ9duk3H3d6Iau6jQDKNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781425411; c=relaxed/simple;
	bh=b+X76Jqeyl1k2/QdL0QNY3q3FN2nF5XGKxliGYbOeUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qiWegfjSmNPwQK+FQnmSJzknXWKfdULBoa5HZgEcBo3bq17mlLwwCJDCt8fQulaKBduriG/x7wkD5KOmm6WwuPD8Zs68FBvS2dV86O+OwTmc9EQ8mPxXuIji+oxei/bHjbTYv8cn5MfRr2nGmZWs6A1Wu+4hun7wSTXpzuW88wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPY5kOlP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2D53C2BCC7;
	Sun, 14 Jun 2026 08:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781425410;
	bh=b+X76Jqeyl1k2/QdL0QNY3q3FN2nF5XGKxliGYbOeUs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RPY5kOlP7vwe2uCJB3J3ZhpCU2BqBZgC94961x1+bLydCyArZc3CmEAYx4gwdb6Jn
	 96K0p5jlKNCnCUy6nbZkyiUgEQ5v2k1CutDgenDd/KqU6XGfscHHnB7VsnwjLEAhgU
	 E36hBuqUB/wbi2i2csHfKKMDq/jyVa0bMt1enrUG/FeTfG+S1i0VQWoyvCO3yfcgEW
	 uqKMfvg6ql0Z5NTgBoGhvKtukQz4/gWqKn0ypu61a+VEX77MwsAUb1DsbcvotAPT3H
	 9+CThhJ4gQ5tUTsLW3KF4Cr6ggly2LBjEQOqgtJ18lrCUdF+C50zwUQOGdUFP3YcTI
	 m8xsuqFfy2G9g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC55CD98D2;
	Sun, 14 Jun 2026 08:23:30 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Sun, 14 Jun 2026 03:23:30 -0500
Subject: [PATCH v3 1/3] net/smc: bound the wire-controlled producer cursor
 to the RMB
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260614-b4-disp-edd64be9-v3-1-551fa514257e@proton.me>
References: <20260614-b4-disp-edd64be9-v3-0-551fa514257e@proton.me>
In-Reply-To: <20260614-b4-disp-edd64be9-v3-0-551fa514257e@proton.me>
To: Wenjia Zhang <wenjia@linux.ibm.com>, 
 Dust Li <dust.li@linux.alibaba.com>, "D. Wythe" <alibuda@linux.alibaba.com>, 
 Sidraya Jayagond <sidraya@linux.ibm.com>
Cc: Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Mahanta Jambigi <mjambigi@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>, 
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 Ursula Braun <ubraun@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, 
 linux-s390@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781425409; l=3713;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=zcWVVdJAtU3Ek9J3YXu5ehPHOy4NLE09j+aVok3P17Y=;
 b=VcxLxDzN10zmwq5aTgCWcrq3CXAVMqLFrIjZJH7HHT2+6Ocawxh7tdBcuymfRmnh/Ww2RFGNG
 wBmLEMrmylBD6DOKi5TREz9YOXsGi3B4KpfBPxH2NTBLf+BsHOK3hWw
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:wenjia@linux.ibm.com,m:dust.li@linux.alibaba.com,m:alibuda@linux.alibaba.com,m:sidraya@linux.ibm.com,m:edumazet@google.com,m:davem@davemloft.net,m:mjambigi@linux.ibm.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:ubraun@linux.ibm.com,m:raspl@linux.ibm.com,m:linux-s390@vger.kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:kuba@kernel.org,m:tonylu@linux.alibaba.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22204-lists,linux-rdma=lfdr.de,hexlabsecurity.proton.me];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9CB86680A6D

From: Bryam Vargas <hexlabsecurity@proton.me>

smc_cdc_cursor_to_host() (SMC-R) and smcd_cdc_msg_to_host() (SMC-D)
import the peer's producer cursor from the wire into the local
connection cursor with no upper bound against the receive buffer (RMB).
The urgent path then uses that count as a raw index:

	base = conn->rmb_desc->cpu_addr + conn->rx_off;
	conn->urg_rx_byte = *(base + conn->urg_curs.count - 1);

so a peer that advertises a producer cursor past rmb_desc->len reads
out of bounds of the RMB allocation in the receive tasklet (softirq).

Bound the producer cursor count to rmb_desc->len at the conversion
boundary, for both SMC-R and SMC-D.  Apply the bound to the producer
cursor only: the consumer cursor indexes the peer's RMB and is bounded
by peer_rmbe_size, so clamping it to our rmb_desc->len would
under-credit peer_rmbe_space and stall transmit to a peer whose RMB is
larger than ours.

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



