Return-Path: <linux-rdma+bounces-22206-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JsXrFw5lLmoovQQAu9opvQ
	(envelope-from <linux-rdma+bounces-22206-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 10:23:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 02684680A65
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 10:23:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b="goCOGx/f";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22206-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22206-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDE1230065E8
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 08:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A22C399889;
	Sun, 14 Jun 2026 08:23:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101C42F90C5;
	Sun, 14 Jun 2026 08:23:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781425411; cv=none; b=Ltud+oBrC5OnoDXY2xmeBxa7cIotb6xVbtBh6BW7qQPq1UP/4PIQZsPiWwbyqjzRWUN0DiiyzwUpivu+LzU8QeRl6GirHQ4f/OOzXIVAk/lT06OYAmVBxRAoiJPzj5NyT6+eTXOgt4iu2fLT+hvQKfUIQLMdHrcps/Yi5ndcCdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781425411; c=relaxed/simple;
	bh=PAjVurddjqVXeQuWOvVMD5hsHg8qW5JVWuh3lEpyVDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nCnGUDJsfhFjZzBZ2jgWCQ3CGQ8tQA7nOlcepPgO/Z+UVrC2O61D/zOhSziT5Y9bvzMxH5h3x9lVfAjwBgQVDuDA5kWOKbR7f2ikiBkw4dET2ew2wR4DbBn5bBdhjbXJFIbF2aOr55/FYiDjL21vgnIJqIWguuDqPK9Ya5bkxKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goCOGx/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8742C4AF10;
	Sun, 14 Jun 2026 08:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781425410;
	bh=PAjVurddjqVXeQuWOvVMD5hsHg8qW5JVWuh3lEpyVDg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=goCOGx/fMlcen7y2ufWoGQgSWjTl2U7Y+nluNqKXNkLcUO3lu9R1Iu8JfvpShuZmn
	 7/PaCYMxRsOGyFGITQ/IegKj8cggGsN8ogv7hQxm3KtwPy1jZMdnQMVBLoe/qajUP1
	 TnFuOhPGi1oTjg0m9h/H7YcxqmUJN9+/+lXhni1ZqL38Qi3H8jTj159OQKJG0+Z1Zn
	 g0WgTDFtiwH/kXdueT4O6iY7Sk57+eYGV76gSBs7qP/YGsqIqI1CZwK+X9+HOk7LB8
	 P1hMMwqQyK3zPWM5gYdOLll9eJ6CtlIp4BbCL5lyWUpw9FA0ArQj67hxbjmcwsgkGY
	 ajZuhHlUJwvYg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4E9CD98D8;
	Sun, 14 Jun 2026 08:23:30 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Sun, 14 Jun 2026 03:23:31 -0500
Subject: [PATCH v3 2/3] net/smc: bound the receive length to the RMB in
 smc_rx_recvmsg()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260614-b4-disp-edd64be9-v3-2-551fa514257e@proton.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781425409; l=2584;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=Y/3QqJVlrCKltO0Cz8rMmwTKlkY3BnW+tSsL2yrTGTg=;
 b=GL4RXe2Aexldd9WYN3tIcnVonPl/3AH6Rwtwx/IAFov+okzHX1u4sH6uvMbQEBdupWnDeCaFG
 Qm+sfIAVaCABCQilKVxVdP+Ex/1Q3Y/MLGptSxJ5YFxJx6ht84IOzdF
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
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
	TAGGED_FROM(0.00)[bounces-22206-lists,linux-rdma=lfdr.de,hexlabsecurity.proton.me];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 02684680A65

From: Bryam Vargas <hexlabsecurity@proton.me>

conn->bytes_to_rcv is accumulated in the receive tasklet from the peer's
producer cursor:

	diff_prod = smc_curs_diff(rmb_desc->len, &prod_old, &prod_new);
	atomic_add(diff_prod, &conn->bytes_to_rcv);

smc_curs_diff()'s differing-wrap branch returns (size - old.count) +
new.count, which exceeds rmb_desc->len for a forged producer cursor and
accumulates across CDC messages, so bytes_to_rcv can grow past the RMB
(and across many messages can overflow the signed counter negative).
smc_rx_recvmsg() reads it as the number of readable bytes and performs a
wrap-around copy whose second chunk (copylen - first_chunk, read from
ring offset 0) is never re-bounded to rmb_desc->len, reading past the
RMB into adjacent kernel memory and disclosing it to the peer.

Bound the readable count to rmb_desc->len where it is consumed, treating
a negative (sign-overflowed) value as out of range too, so the copy
length can never exceed the ring.  This enforces the documented
0 <= bytes_to_rcv <= rmb_desc->len invariant at the consumer, where it
is race-free against the producer update that runs in the receive
tasklet.

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



