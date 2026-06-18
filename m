Return-Path: <linux-rdma+bounces-22356-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TYYXAqgYNGqnOQYAu9opvQ
	(envelope-from <linux-rdma+bounces-22356-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 18:11:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 533706A1809
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 18:11:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=IHojqSEF;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22356-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22356-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51D9031071C9
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 16:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C9D348C6C;
	Thu, 18 Jun 2026 16:03:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90783446C9;
	Thu, 18 Jun 2026 16:03:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798604; cv=none; b=FYhyZ+HAtGxmUYO0zU7ivOGY64Fpydo5ogDm+cGrvEXhhSSqvlYxXBIIOatU8cgnVretE46PmULva6baeyPxtEy/l/8LKZ29MxwfMGaZWyU/DtEZ0nT7fe0Xz9+kJFgkfS0xANnhqn3Ii/KdyU7EiNPkewSuflq349/WY5nLxkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798604; c=relaxed/simple;
	bh=2fKCewmHDraKBYdD2hFnuHNGMxtXSmQnBm6eLyC1XOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOvB4DyjrpYLA+NPUAdNQ2s+1woFBi9tfQUQx0zvCoa4StfdguNs/ilry4V/qpMds8YQFQooQFsuILpLIvb20vtazua/jhVEb4r2eEgwLVEh7/vgXVwQK0Nd4J8H+3B4PIzKeRAhSe+SLw4+X5iiGy2deeAaX1HEBLLRA2U/rzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IHojqSEF; arc=none smtp.client-ip=115.124.30.118
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781798598; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=gkqxdjTyrjDufw0wAGal9WNmShdcAlZ9wp5Pmo/sHyE=;
	b=IHojqSEFw9VNBvSPnGx4S5k6h0UAbjV5s3Xb7zTFZsFHBz3LEr5y6T0kNe8lSveaeiDo2BnoorM/O1xn6fNyyS8x/NH+EnmAJOiqVL/dGAyK0zYVkd3IlDBgGCLT3AEfvt6/6docOG6BxSXa1cZYI7HAA73P3HYA0OoqJ+s4Des=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X57Pyhp_1781798597;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X57Pyhp_1781798597 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 19 Jun 2026 00:03:17 +0800
Date: Fri, 19 Jun 2026 00:03:17 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: hexlabsecurity@proton.me, Wenjia Zhang <wenjia@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Wen Gu <guwen@linux.alibaba.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, Ursula Braun <ubraun@linux.ibm.com>,
	Stefan Raspl <raspl@linux.ibm.com>, linux-s390@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Tony Lu <tonylu@linux.alibaba.com>
Subject: Re: [PATCH v3 2/3] net/smc: bound the receive length to the RMB in
 smc_rx_recvmsg()
Message-ID: <ajQWxQZXzM2J8kaZ@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20260614-b4-disp-edd64be9-v3-0-551fa514257e@proton.me>
 <20260614-b4-disp-edd64be9-v3-2-551fa514257e@proton.me>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614-b4-disp-edd64be9-v3-2-551fa514257e@proton.me>
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
	FORGED_RECIPIENTS(0.00)[m:hexlabsecurity@proton.me,m:wenjia@linux.ibm.com,m:alibuda@linux.alibaba.com,m:sidraya@linux.ibm.com,m:edumazet@google.com,m:davem@davemloft.net,m:mjambigi@linux.ibm.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:ubraun@linux.ibm.com,m:raspl@linux.ibm.com,m:linux-s390@vger.kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:kuba@kernel.org,m:tonylu@linux.alibaba.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22356-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	HAS_REPLYTO(0.00)[dust.li@linux.alibaba.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,proton.me:email,linux.alibaba.com:dkim,linux.alibaba.com:replyto,linux.alibaba.com:mid,linux.alibaba.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 533706A1809

On 2026-06-14 03:23:31, Bryam Vargas via B4 Relay wrote:
>From: Bryam Vargas <hexlabsecurity@proton.me>
>
>conn->bytes_to_rcv is accumulated in the receive tasklet from the peer's
>producer cursor:
>
>	diff_prod = smc_curs_diff(rmb_desc->len, &prod_old, &prod_new);
>	atomic_add(diff_prod, &conn->bytes_to_rcv);
>
>smc_curs_diff()'s differing-wrap branch returns (size - old.count) +
>new.count, which exceeds rmb_desc->len for a forged producer cursor and
>accumulates across CDC messages, so bytes_to_rcv can grow past the RMB
>(and across many messages can overflow the signed counter negative).
>smc_rx_recvmsg() reads it as the number of readable bytes and performs a
>wrap-around copy whose second chunk (copylen - first_chunk, read from
>ring offset 0) is never re-bounded to rmb_desc->len, reading past the
>RMB into adjacent kernel memory and disclosing it to the peer.

Hi Bryam,

Once we validate the CDC message at the input boundary (as in the
previous patch), bytes_to_rcv can never exceed rmb_desc->len, so
this check becomes unreachable. So I don't think this patch is needed.

Best regards,
Dust


>
>Bound the readable count to rmb_desc->len where it is consumed, treating
>a negative (sign-overflowed) value as out of range too, so the copy
>length can never exceed the ring.  This enforces the documented
>0 <= bytes_to_rcv <= rmb_desc->len invariant at the consumer, where it
>is race-free against the producer update that runs in the receive
>tasklet.
>
>Fixes: 952310ccf2d8 ("smc: receive data from RMBE")
>Cc: stable@vger.kernel.org
>Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
>---
> net/smc/smc_rx.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>
>diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
>index c1d9b923938d..f461cf10b085 100644
>--- a/net/smc/smc_rx.c
>+++ b/net/smc/smc_rx.c
>@@ -442,6 +442,18 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
> 		/* initialize variables for 1st iteration of subsequent loop */
> 		/* could be just 1 byte, even after waiting on data above */
> 		readable = smc_rx_data_available(conn, peeked_bytes);
>+		/* bytes_to_rcv is accumulated from the peer's wire-controlled
>+		 * producer cursor; a forged cursor can drive it past the RMB,
>+		 * or overflow the signed accumulator to a negative value across
>+		 * many CDC messages (which a plain "> len" check would miss
>+		 * before the size_t cast below turns it huge).  Bound it to the
>+		 * RMB in either case so the wrap-around copy cannot run past
>+		 * rmb_desc->len.  This enforces the documented
>+		 * 0 <= bytes_to_rcv <= rmb_desc->len invariant at the consumer,
>+		 * race-free against the producer update in the receive tasklet.
>+		 */
>+		if (readable < 0 || readable > conn->rmb_desc->len)
>+			readable = conn->rmb_desc->len;
> 		splbytes = atomic_read(&conn->splice_pending);
> 		if (!readable || (msg && splbytes)) {
> 			if (splbytes)
>
>-- 
>2.43.0
>

