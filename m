Return-Path: <linux-rdma+bounces-22397-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WsAIEbijOGoffAcAu9opvQ
	(envelope-from <linux-rdma+bounces-22397-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 04:53:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 882CF6AC3B7
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 04:53:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=hZsERzrB;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22397-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22397-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0E73303FFA3
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 02:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA9033689A;
	Mon, 22 Jun 2026 02:49:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761FC337110
	for <linux-rdma@vger.kernel.org>; Mon, 22 Jun 2026 02:49:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782096545; cv=none; b=Id+KRcH6OTBmtFFhtkegd9DlicN20pal7NunuHuOwhtfk8b+TlR52LnDWQbtiaxfd154dpSnI6wy6EPyqYTidaNs1kGwv0zoR57Wse+UVNw4soOYaAunim58tMcFzvjB/i0gG0+EZYTbmVFazL+mwxo5H6Pw4/OgHx/Xa/6IOHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782096545; c=relaxed/simple;
	bh=+ORRixjLnKppx9dnrbYbgn63F4Xoap3LaSTe+gHGDJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ADZntIje0NwcXqs6E2C8xOn/SDKiXfMCBZhXljqDa0ejZnFCMbmGFPzPlYAz5sR2XjsumBucMsAgG2zdbrj+ehIn2sr6dozD3t6PxbL0Pl1jkS8nyGrJJVJ+BRmDl9g43tCPiwAdFNZhLfLPjahVxYzlSzwIxlwDQU4H8Ld1OYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hZsERzrB; arc=none smtp.client-ip=115.124.30.98
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782096541; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lbf0sR8BvqGVH7I+I2J6TcPj88hE6FxucrKaZfwKg3Y=;
	b=hZsERzrB5gdJ8RDyKCpsSeKtT47yK2mliu+PU2gSxvkt0bwxHnTLLacCZNduv6j+VFnoaBRJu8w/W0R++Jw8U8tt+9c8dTQmQohMf0ypD2fo1PIO9OhH5ZHqJSNkOIok8TnB1B4dxfbv9rDVtlYKzt61xj7w3eE85787Z0dic2I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X5GhcBP_1782096540;
Received: from 30.221.101.45(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0X5GhcBP_1782096540 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Jun 2026 10:49:00 +0800
Message-ID: <2ab39704-bc44-6898-46ea-241496ab594d@linux.alibaba.com>
Date: Mon, 22 Jun 2026 10:48:59 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] RDMA/erdma: initialize ret for empty receive WR
 lists
To: Ruoyu Wang <ruoyuw560@gmail.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>
Cc: Kai Shen <kaishen@linux.alibaba.com>, linux-rdma@vger.kernel.org
References: <20260618041752.481193-1-ruoyuw560@gmail.com>
Content-Language: en-US
From: Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20260618041752.481193-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:jgg@nvidia.com,m:leonro@nvidia.com,m:kaishen@linux.alibaba.com,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[chengyou@linux.alibaba.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chengyou@linux.alibaba.com,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22397-lists,linux-rdma=lfdr.de];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,vger.kernel.org:from_smtp,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 882CF6AC3B7

Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>

On 6/18/26 12:17 PM, Ruoyu Wang wrote:
> erdma_post_recv() returns ret after walking the receive work request list.
> If the caller passes an empty list, the loop is skipped and ret is not
> assigned.
> 
> Initialize ret to 0 so an empty receive work request list returns success
> instead of stack data.
> 
> Fixes: 155055771704 ("RDMA/erdma: Add verbs implementation")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
> v2:
> - Split the erdma and mana_ib changes into separate patches.
> - Add a driver-specific Fixes tag.
> 
>  drivers/infiniband/hw/erdma/erdma_qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/erdma/erdma_qp.c b/drivers/infiniband/hw/erdma/erdma_qp.c
> index 25f6c49aec779..e002343832f74 100644
> --- a/drivers/infiniband/hw/erdma/erdma_qp.c
> +++ b/drivers/infiniband/hw/erdma/erdma_qp.c
> @@ -734,7 +734,7 @@ int erdma_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *recv_wr,
>  	const struct ib_recv_wr *wr = recv_wr;
>  	struct erdma_qp *qp = to_eqp(ibqp);
>  	unsigned long flags;
> -	int ret;
> +	int ret = 0;
>  
>  	spin_lock_irqsave(&qp->lock, flags);
>  

