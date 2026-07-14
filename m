Return-Path: <linux-rdma+bounces-23216-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r4mRCflhVmru4QAAu9opvQ
	(envelope-from <linux-rdma+bounces-23216-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 18:21:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CA8756E30
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 18:21:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=WHgwPPuf;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23216-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23216-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 849C430E587B
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 16:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF0C4ADD80;
	Tue, 14 Jul 2026 16:20:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA1413AD1C;
	Tue, 14 Jul 2026 16:20:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784046007; cv=none; b=vCOex7C/Jok6cXl1UCn7zYyNcnHedjUJ0RqwFJICvHz/KJDeFYefw5KyS2s2wz106zOKGDARBkgfg3eYjhl5v0X7xikTcKVMBfSO1fFqJ+0TBmLpmXWvOAaclhEzBglM5X3rAhfhvU+fw0Ojk+s44hRBw4i9HQWTBykkyHvOch0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784046007; c=relaxed/simple;
	bh=7mdBjTcRAOTBzxiyRj8jNp4uqDtYgdwRcIVIJl5ps4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2/1YOETZx35kGVEDgkFiiFok50boYDwd658S+CtPVDaDCS/KlaPklEJl1hPhDzrAfqCwW/nQctu9AOOIxE9Cg7X5QqUeeFv2gM09kDKAlFWyLZsZdDmqYVlyM2OG27Qs1YBPY8NGRGyCc7NrDCQyyauMsqUR9tT4t66Q8a7uUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WHgwPPuf; arc=none smtp.client-ip=115.124.30.133
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784046000; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=6aQrwdcfxTvqZJZreEIuqR1wdpjUcWmUsmmW8Zlwfok=;
	b=WHgwPPufnqDmyocG+6H5X26/hdBXkYe8K0xlrAoV5NwhzzADOli/kpZUFPzCOpSNIiJRSZEIHZnIsfgJCBuUeLMn+CBV4PBagbGkb6DZiLafg/nLSbR06kW9p0uAiQeVcgQcBBFC3kvi/spcYYnNwyA6n/krM+zPu7o8IrKzHPc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X757QPQ_1784045999;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X757QPQ_1784045999 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Jul 2026 00:20:00 +0800
Date: Wed, 15 Jul 2026 00:19:59 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: hexlabsecurity@proton.me, "David S. Miller" <davem@davemloft.net>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Eric Dumazet <edumazet@google.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Stefan Raspl <raspl@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Ursula Braun <ubraun@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH net v4 1/3] net/smc: bound the wire-controlled producer
 cursor to the RMB
Message-ID: <alZhr5oWEdL9iQas@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20260705-b4-disp-28a1bbca-v4-0-be089b98acc6@proton.me>
 <20260705-b4-disp-28a1bbca-v4-1-be089b98acc6@proton.me>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705-b4-disp-28a1bbca-v4-1-be089b98acc6@proton.me>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hexlabsecurity@proton.me,m:davem@davemloft.net,m:sidraya@linux.ibm.com,m:edumazet@google.com,m:alibuda@linux.alibaba.com,m:kuba@kernel.org,m:horms@kernel.org,m:wenjia@linux.ibm.com,m:pabeni@redhat.com,m:raspl@linux.ibm.com,m:guwen@linux.alibaba.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:ubraun@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-23216-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	HAS_REPLYTO(0.00)[dust.li@linux.alibaba.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:from_mime,linux.alibaba.com:mid,linux.alibaba.com:dkim,linux.alibaba.com:replyto,proton.me:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3CA8756E30

On 2026-07-05 02:54:05, Bryam Vargas via B4 Relay wrote:
>From: Bryam Vargas <hexlabsecurity@proton.me>
>
>smcr_cdc_msg_to_host() and smcd_cdc_msg_to_host() import a peer's
>producer cursor from the wire into conn->local_rx_ctrl.prod without
>bounding it against the receive buffer. The urgent-data path in
>smc_cdc_msg_recv_action() then uses that count as a raw index into the
>RMB, so a peer that advertises a producer cursor past rmb_desc->len
>reads out of bounds of the RMB allocation in the receive tasklet and
>can disclose adjacent kernel memory.
>
>Bound the producer cursor count to rmb_desc->len at the wire-to-host
>conversion, for both SMC-R and SMC-D. Bound only the producer cursor:
>the consumer cursor indexes the peer's RMB and is bounded by
>peer_rmbe_size, so clamping it to our rmb_desc->len would under-credit
>peer_rmbe_space and stall transmit to a peer with a larger RMB.
>Conforming peers are unaffected.
>
>Fixes: de8474eb9d50 ("net/smc: urgent data support")
>Cc: stable@vger.kernel.org
>Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

Best regards,
Dust

>---
> net/smc/smc_cdc.h | 27 ++++++++++++++++++++++++---
> 1 file changed, 24 insertions(+), 3 deletions(-)
>
>diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
>index 696cc11f2303..ca76ef630356 100644
>--- a/net/smc/smc_cdc.h
>+++ b/net/smc/smc_cdc.h
>@@ -221,7 +221,8 @@ static inline void smc_host_msg_to_cdc(struct smc_cdc_msg *peer,
> 
> static inline void smc_cdc_cursor_to_host(union smc_host_cursor *local,
> 					  union smc_cdc_cursor *peer,
>-					  struct smc_connection *conn)
>+					  struct smc_connection *conn,
>+					  int max_count)
> {
> 	union smc_host_cursor temp, old;
> 	union smc_cdc_cursor net;
>@@ -235,6 +236,15 @@ static inline void smc_cdc_cursor_to_host(union smc_host_cursor *local,
> 	if ((old.wrap == temp.wrap) &&
> 	    (old.count > temp.count))
> 		return;
>+	/* The peer producer cursor is wire-controlled and is later used as a
>+	 * raw index into our RMB by the urgent path; bound its count to the
>+	 * RMB.  max_count == 0 leaves the consumer cursor unbounded here: it
>+	 * indexes the peer's RMB (bounded by peer_rmbe_size, not our
>+	 * rmb_desc->len), so clamping it to rmb_desc->len would under-credit
>+	 * peer_rmbe_space and stall transmit to peers with a larger RMB.
>+	 */
>+	if (max_count && temp.count > max_count)
>+		temp.count = max_count;
> 	smc_curs_copy(local, &temp, conn);
> }
> 
>@@ -246,8 +256,13 @@ static inline void smcr_cdc_msg_to_host(struct smc_host_cdc_msg *local,
> 	local->len = peer->len;
> 	local->seqno = ntohs(peer->seqno);
> 	local->token = ntohl(peer->token);
>-	smc_cdc_cursor_to_host(&local->prod, &peer->prod, conn);
>-	smc_cdc_cursor_to_host(&local->cons, &peer->cons, conn);
>+	/* bound the wire-controlled producer cursor to our RMB (used as a raw
>+	 * index by the urgent path); leave the consumer cursor unbounded -- it
>+	 * indexes the peer's RMB and is bounded by peer_rmbe_size.
>+	 */
>+	smc_cdc_cursor_to_host(&local->prod, &peer->prod, conn,
>+			       conn->rmb_desc->len);
>+	smc_cdc_cursor_to_host(&local->cons, &peer->cons, conn, 0);
> 	local->prod_flags = peer->prod_flags;
> 	local->conn_state_flags = peer->conn_state_flags;
> }
>@@ -260,6 +275,12 @@ static inline void smcd_cdc_msg_to_host(struct smc_host_cdc_msg *local,
> 
> 	temp.wrap = peer->prod.wrap;
> 	temp.count = peer->prod.count;
>+	/* the peer producer cursor is wire-controlled and is used as a raw
>+	 * index into our RMB by the urgent path; bound it to the RMB.  The
>+	 * consumer cursor below indexes the peer's RMB and is left unbounded.
>+	 */
>+	if (temp.count > conn->rmb_desc->len)
>+		temp.count = conn->rmb_desc->len;
> 	smc_curs_copy(&local->prod, &temp, conn);
> 
> 	temp.wrap = peer->cons.wrap;
>
>-- 
>2.43.0
>

