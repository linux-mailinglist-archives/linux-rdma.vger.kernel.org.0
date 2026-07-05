Return-Path: <linux-rdma+bounces-22760-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OLTDNbMNSmp09wAAu9opvQ
	(envelope-from <linux-rdma+bounces-22760-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 09:54:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E610709437
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 09:54:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=b83cgTXA;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22760-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22760-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 685AA301052E
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2026 07:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE52E36655C;
	Sun,  5 Jul 2026 07:54:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A834433E89;
	Sun,  5 Jul 2026 07:54:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783238046; cv=none; b=lISdpwGDYIypvK8jGgMQXZr1e375FWFVAcqkmWhor7514VRbAqEP6fdNDdF/pVk2uK9ceTSupJt2BxX6Ho+7og2EekfKJooWNl7dwnwG27GAIF58dhOHLKfieKkKu3vthsonARthaXawKTo+JXRGMgIYpwEFE97EKVO2hUfGD84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783238046; c=relaxed/simple;
	bh=YL/WHd/8TFPHx4l3DQrXPuhucRcZBRkd5xOZrS5L7Yo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZD0Nzu2INWqjYja/MWwzb/d/2ISAw33MO9nEnud/Ww92YnVdfaEkFeuOmHaWBmIih7R9eu4aIYqpwLJI92Y4W0h20hr4J11FMicvR+DnL7ffLkHlmR0xioA/6bVPRb73ByB/0IJB5UceqfPyK+2D9RXsGF4NSJaTxCeniFkp+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b83cgTXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B8F0C2BCF5;
	Sun,  5 Jul 2026 07:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783238046;
	bh=YL/WHd/8TFPHx4l3DQrXPuhucRcZBRkd5xOZrS5L7Yo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=b83cgTXAFOgwxU9jfBq+ziR4vJFH8dgNyF0QGn6zJEbMn+BWB3dJnySbkVrJDe/MY
	 HHfdggWmrJd7cIHgZoW1Dyz3L2SqYErLLE/lqFG/KtRSayo2Inal+1LRP6aMeylxtw
	 Wfshmlpv7x2Cd/EBXH6oLsjuW2av9QVb2peRDV4YFrGAURBVc/lPg5MLRr1BlH+i9U
	 GTaBeZm2Ty1TkFp9aseiGRkGjNGAp55LA391RGmCUfHkyrbT0vPSlPA++yaUcPsP83
	 pxr1nFqWIN1SXdK5Akvn3EJWYzgkoAmie4MUazb5ISvNDZdMizW0mTCMsuSXeuTThR
	 YxcP08Ut0wkjQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCD3C44501;
	Sun,  5 Jul 2026 07:54:06 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Sun, 05 Jul 2026 02:54:06 -0500
Subject: [PATCH net v4 2/3] net/smc: bound the receive length to the RMB in
 smc_rx_recvmsg()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-b4-disp-28a1bbca-v4-2-be089b98acc6@proton.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783238044; l=2445;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=I0K6pB19Txw2xkjG1QzwzyDeX8rOXh7QApCt4GO9qIc=;
 b=/I0Zd31bYSOXxpR0waqZvHv4r013dQLQJXOXfqYo0YJhIZvn5GziX/nXs6nYGTJsb/F5lHiMP
 TVdAwebAdJHC6UL/D2LPnRi2QKME2z4EByX4fsntrARFHTsgcSv72ts
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-22760-lists,linux-rdma=lfdr.de,hexlabsecurity.proton.me];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E610709437

From: Bryam Vargas <hexlabsecurity@proton.me>

conn->bytes_to_rcv is accumulated in the receive tasklet from the
peer's wire-controlled producer cursor via smc_curs_diff(), whose
differing-wrap branch can exceed rmb_desc->len; a forged cursor drives
bytes_to_rcv past the RMB, and over many CDC messages overflows the
signed counter negative. smc_rx_recvmsg() reads it as the readable
length and does a wrap-around copy whose second chunk is not re-bounded
to rmb_desc->len, reading past the RMB into adjacent kernel memory and
disclosing it to the peer. The nearby readable >= rmb_desc->len test
only feeds SMC_STAT_RMB_RX_FULL on a separate earlier read; it does not
bound the copy.

Bound the readable length to rmb_desc->len at the consumer, treating a
negative (sign-overflowed) value as out of range too, so the copy can
never exceed the ring. This enforces the documented
0 <= bytes_to_rcv <= rmb_desc->len invariant where it is race-free
against the producer update in the tasklet; conforming peers are
unaffected.

Fixes: 952310ccf2d8 ("smc: receive data from RMBE")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 net/smc/smc_rx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index c1d9b923938d..f461cf10b085 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -442,6 +442,18 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
 		/* initialize variables for 1st iteration of subsequent loop */
 		/* could be just 1 byte, even after waiting on data above */
 		readable = smc_rx_data_available(conn, peeked_bytes);
+		/* bytes_to_rcv is accumulated from the peer's wire-controlled
+		 * producer cursor; a forged cursor can drive it past the RMB,
+		 * or overflow the signed accumulator to a negative value across
+		 * many CDC messages (which a plain "> len" check would miss
+		 * before the size_t cast below turns it huge).  Bound it to the
+		 * RMB in either case so the wrap-around copy cannot run past
+		 * rmb_desc->len.  This enforces the documented
+		 * 0 <= bytes_to_rcv <= rmb_desc->len invariant at the consumer,
+		 * race-free against the producer update in the receive tasklet.
+		 */
+		if (readable < 0 || readable > conn->rmb_desc->len)
+			readable = conn->rmb_desc->len;
 		splbytes = atomic_read(&conn->splice_pending);
 		if (!readable || (msg && splbytes)) {
 			if (splbytes)

-- 
2.43.0



