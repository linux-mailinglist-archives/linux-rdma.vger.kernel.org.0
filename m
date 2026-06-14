Return-Path: <linux-rdma+bounces-22207-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ENrcFQ9lLmopvQQAu9opvQ
	(envelope-from <linux-rdma+bounces-22207-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 10:23:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA97680A68
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 10:23:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=jRyPJJMR;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22207-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22207-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E8B430054E1
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 08:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635C8399CE2;
	Sun, 14 Jun 2026 08:23:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8AA3009F2;
	Sun, 14 Jun 2026 08:23:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781425411; cv=none; b=eiJqYVoPV5fjVDS9Gold2Mcx7jqDs+kwofUHju/BmBhVHUAqScifiufXJg4mUjFqydQPpJ9levKdAOgCdibPDsWOVc+iERR6l4PX4I34xOYCNzf6BHauKtUbioEUnDs8952Mga7kXrhepVs4m91LVTbWj2fy6vEAoucTzE1kZtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781425411; c=relaxed/simple;
	bh=B+dlIsg1kysJEgDY3LnyTyifSwe6gmLPvME+hAiBa50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KIUKaxTRo9uS9DfnEXZFSId7Oi7y/u9iDwq198nGH+8PLWIjIeoJxaIpZOaxL7IS6xemQATD+yQut4jqfk+AzNHJqKuWoRVKTa8bgrC2XV5Bz3NydeokxxTH8ljpbUFN8TFIXIstd0sl1LsFwNwxr93uhn0UErJJgVYKjaNduug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRyPJJMR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB21EC4AF11;
	Sun, 14 Jun 2026 08:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781425410;
	bh=B+dlIsg1kysJEgDY3LnyTyifSwe6gmLPvME+hAiBa50=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jRyPJJMRh2HnwHVNugOzLwDeQffSnjB7uYqlDdjYk+U7hFQFympf9PcRaLBoPfzTB
	 ddFRVeNP+69YpP0j22OE4GMSKQ0CV/sOVhCSYYjTGgFHU5ISDm93rayQUlpR0qV6hJ
	 zEhZ486UdfoOwPuj/oYd2aI54iHmAYJHwn8vk47PDtXDVriT8D0Pp/YiND6NRQnJUz
	 9vFVyKVzEN9FFexG5yBRjBdormUqQf3B2U80ksc5pnZuj4J8jZKHvzUXSa+c6Afs+p
	 /b8D/1gYRFlbrgbNRyMz5GE/JnV81UeEggC/wYMDSRZHfesvyg8stvd/by7A4rdAbo
	 oU4UwhVkcVdew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0C6CD98D6;
	Sun, 14 Jun 2026 08:23:30 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Sun, 14 Jun 2026 03:23:32 -0500
Subject: [PATCH v3 3/3] net/smc: bound the send length to the send buffer
 in smc_tx_sendmsg()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260614-b4-disp-edd64be9-v3-3-551fa514257e@proton.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781425409; l=2754;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=4S35QpGjFI4Nol8jEunjm9yblHJ/ApOBlLnW/qpjsWU=;
 b=vwFLjibbCYXZPOBwsd2IHPubLmw+2WKN4GI/oz8r7HApaeyQqzparJCEYXby2jhTaf9CytpYQ
 rJx8harvq6wC02iIhBc4p0unRq1vFURj+feqTJEG/a3OHtb8mocCe+7
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-22207-lists,linux-rdma=lfdr.de,hexlabsecurity.proton.me];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EA97680A68

From: Bryam Vargas <hexlabsecurity@proton.me>

On the SMC-D DMB-merge (nocopy) path, smc_cdc_msg_recv_action() advances
conn->sndbuf_space from the peer's consumer cursor:

	diff_tx = smc_curs_diff(sndbuf_desc->len, &tx_curs_fin,
				&local_rx_ctrl.cons);
	atomic_add(diff_tx, &conn->sndbuf_space);

The consumer cursor is wire-controlled and unvalidated, and
smc_curs_diff()'s differing-wrap branch can return more than
sndbuf_desc->len, so a forged cursor drives sndbuf_space past the send
buffer (and across many CDC messages can overflow the signed counter
negative).  smc_tx_sendmsg() reads it as the available write space and
performs a wrap-around copy whose second chunk (copylen - first_chunk,
written at ring offset 0) is never re-bounded to sndbuf_desc->len,
writing user data past the send buffer -- a heap out-of-bounds write of
attacker-influenced length and content.

Bound the write space to sndbuf_desc->len where it is consumed, treating
a negative (sign-overflowed) value as out of range too, so the copy
length can never exceed the ring.  This enforces the documented
0 <= sndbuf_space <= sndbuf_desc->len invariant at the producer,
race-free against the CDC tasklet that advances sndbuf_space.

Fixes: cc0ab806fc52 ("net/smc: adapt cursor update when sndbuf and peer DMB are merged")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 net/smc/smc_tx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 3144b4b1fe29..5916f02060fb 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -233,6 +233,19 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
 		/* initialize variables for 1st iteration of subsequent loop */
 		/* could be just 1 byte, even after smc_tx_wait above */
 		writespace = atomic_read(&conn->sndbuf_space);
+		/* sndbuf_space is advanced from the peer's wire-controlled
+		 * consumer cursor on the SMC-D DMB-merge path; a forged cursor
+		 * can inflate it past the send buffer, or overflow the signed
+		 * accumulator to a negative value across many CDC messages
+		 * (which a plain "> len" check would miss before the size_t
+		 * cast below turns it huge).  Bound it to the send buffer in
+		 * either case so the wrap-around write cannot run past
+		 * sndbuf_desc->len.  This enforces the documented
+		 * 0 <= sndbuf_space <= sndbuf_desc->len invariant at the
+		 * producer, race-free against the CDC tasklet.
+		 */
+		if (writespace < 0 || writespace > conn->sndbuf_desc->len)
+			writespace = conn->sndbuf_desc->len;
 		/* not more than what user space asked for */
 		copylen = min_t(size_t, send_remaining, writespace);
 		/* determine start of sndbuf */

-- 
2.43.0



