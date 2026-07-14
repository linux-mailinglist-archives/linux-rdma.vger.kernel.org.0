Return-Path: <linux-rdma+bounces-23218-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UbUMB5FiVmom4gAAu9opvQ
	(envelope-from <linux-rdma+bounces-23218-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 18:23:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E5A756E58
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 18:23:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=mVPloanl;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23218-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23218-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9183F3142771
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 16:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54444ADD9B;
	Tue, 14 Jul 2026 16:20:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B4C13AD1C;
	Tue, 14 Jul 2026 16:20:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784046054; cv=none; b=Vr5LIiD4yxFM8XtTB1SAYWnu5dJB/6QvaAglbec3dAmBjwLU/NMzSR4bfJK8R/zrdEDio+b8dyunbHX/Llaiebx6LCQdzpF94kGnXx2ad2gacFRZ2IPRy5nIxAVelS48vKXsSTLPStU0K6M/EL4Y7GOgzOudzGrythRt+CzLNBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784046054; c=relaxed/simple;
	bh=e+W3ydYo5hqo1n1JHrVTRBBxe/WDbbgTlNposaeYIic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgvWz69owq182gL1CMhT75BqYn2Oo/lYaPE4ZP6kdKbcVb9P9j0v1XXULeTkhnP1T/RcA/YSdIYBYg8/TTH5CkHAJdKEGUd2Z5hjGsMOxviceIeFzZOZNK8C1Kyd1NJVzoaH6oKrB5RHg3IBogcvJMvVYvLghdjYg+7Wv1gqjNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mVPloanl; arc=none smtp.client-ip=115.124.30.130
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784046043; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=L5HDedMOkOv2o1qYbYljTVZQzB0Jz5OVt0Sh6QKTHBo=;
	b=mVPloanlYZWJSONEEZCOS648Un42/XvTxr7VTNll9htZC4ARFOxm/o89ayuXcax015kt08bDjLnnRzqHXIJWQ++f5KMjBtqoKh6LJPm2Hp9GU0rQjuLJ6eu8EKda1Acp2S7DHos4+CGG/tPeCrTqM16Q8goxYUnwHkGaVbYMbLQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X75Dk4z_1784046042;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X75Dk4z_1784046042 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Jul 2026 00:20:43 +0800
Date: Wed, 15 Jul 2026 00:20:42 +0800
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
Subject: Re: [PATCH net v4 3/3] net/smc: bound the send length to the send
 buffer in smc_tx_sendmsg()
Message-ID: <alZh2puH6EMlyE__@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20260705-b4-disp-28a1bbca-v4-0-be089b98acc6@proton.me>
 <20260705-b4-disp-28a1bbca-v4-3-be089b98acc6@proton.me>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705-b4-disp-28a1bbca-v4-3-be089b98acc6@proton.me>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-23218-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,alibaba.com:email,proton.me:email,linux.alibaba.com:from_mime,linux.alibaba.com:mid,linux.alibaba.com:dkim,linux.alibaba.com:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3E5A756E58

On 2026-07-05 02:54:07, Bryam Vargas via B4 Relay wrote:
>From: Bryam Vargas <hexlabsecurity@proton.me>
>
>On the SMC-D DMB-merge (nocopy) path, smc_cdc_msg_recv_action()
>advances conn->sndbuf_space from the peer's wire-controlled consumer
>cursor via smc_curs_diff(), which can return more than sndbuf_desc->len;
>a forged cursor drives sndbuf_space past the send buffer, and over many
>CDC messages overflows the signed counter negative. smc_tx_sendmsg()
>reads it as the write space and does a wrap-around copy whose second
>chunk is not re-bounded to sndbuf_desc->len, spilling the local
>sender's outbound data past the send buffer at a peer-controlled
>length: a heap out-of-bounds write. The nearby len > sndbuf_desc->len
>test only feeds SMC_STAT_RMB_TX_SIZE_SMALL on the user length; it does
>not bound the copy.
>
>Bound the write space to sndbuf_desc->len at the consumer, treating a
>negative (sign-overflowed) value as out of range too, so the copy can
>never exceed the ring. This enforces the documented
>0 <= sndbuf_space <= sndbuf_desc->len invariant where it is race-free
>against the CDC tasklet; conforming peers are unaffected.
>
>Fixes: cc0ab806fc52 ("net/smc: adapt cursor update when sndbuf and peer DMB are merged")
>Cc: stable@vger.kernel.org
>Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

Best regards,
Dust


>---
> net/smc/smc_tx.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
>
>diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
>index 3144b4b1fe29..5916f02060fb 100644
>--- a/net/smc/smc_tx.c
>+++ b/net/smc/smc_tx.c
>@@ -233,6 +233,19 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
> 		/* initialize variables for 1st iteration of subsequent loop */
> 		/* could be just 1 byte, even after smc_tx_wait above */
> 		writespace = atomic_read(&conn->sndbuf_space);
>+		/* sndbuf_space is advanced from the peer's wire-controlled
>+		 * consumer cursor on the SMC-D DMB-merge path; a forged cursor
>+		 * can inflate it past the send buffer, or overflow the signed
>+		 * accumulator to a negative value across many CDC messages
>+		 * (which a plain "> len" check would miss before the size_t
>+		 * cast below turns it huge).  Bound it to the send buffer in
>+		 * either case so the wrap-around write cannot run past
>+		 * sndbuf_desc->len.  This enforces the documented
>+		 * 0 <= sndbuf_space <= sndbuf_desc->len invariant at the
>+		 * producer, race-free against the CDC tasklet.
>+		 */
>+		if (writespace < 0 || writespace > conn->sndbuf_desc->len)
>+			writespace = conn->sndbuf_desc->len;
> 		/* not more than what user space asked for */
> 		copylen = min_t(size_t, send_remaining, writespace);
> 		/* determine start of sndbuf */
>
>-- 
>2.43.0
>

