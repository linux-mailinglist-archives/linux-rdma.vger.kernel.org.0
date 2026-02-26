Return-Path: <linux-rdma+bounces-17193-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Iq/Kk+nn2mHdAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17193-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 02:52:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2896F19FF32
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 02:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E73BE304001C
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 01:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4579133C53F;
	Thu, 26 Feb 2026 01:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qQUd5uku"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340D2374166
	for <linux-rdma@vger.kernel.org>; Thu, 26 Feb 2026 01:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772070731; cv=none; b=UZ+fiw8zkpXZBNHexn23SA9C1cQ0oPjWeCrwKkylI5wnXSoLRhQFJFAmN+HxzzCu8GXxIi4rnyRF4mH4lJy2piyZjNeIWrQhHY/9j8kyAQiCPoe/qXzqb+uYx6EmIniAWi0RS1iboXrfmvsJo5psvDXXy/niMBaouCNv3FUCZYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772070731; c=relaxed/simple;
	bh=IlG05IFFM3x/WnUUcPGqP0w99uyphPKPoeWDZIo9IYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=IqFJL6pKZY8tNpIpeT5gHlstRCp72UpjMZ6LsYvz7GPQVT7s8XiFbehMMPxoRNM4Rkj0lfhyuG9j6Qisrsjvm6MxAIQnQbhGnQTd86XFdILmaPMk9/cBbONr4Lv5fyBVjhJp/ttezPuRhhvCuAa8mq8EDURZaF3dLmjrgGUPNa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qQUd5uku; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772070720; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jKNFhnViK1dxZNd2xLTxhht+YzmLWpohsC3w8IMN5e0=;
	b=qQUd5ukuL6OsnM5TdDhaMTPruZyCW5RJSR/gZ+CNG4zCH49w8dHQyjHOCm1YAyEO62Z5bAhpalh9okzDwnrXPznCq5bbFRpqaiJju7nVmT0THjnR/D4/4/Xkr0OjcoFQNrTc7dcCePc6WEYOrx6eB1cSfb7vs3ndl9iilg4yRQ0=
Received: from 30.221.97.172(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WzpWdZ3_1772070719 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Feb 2026 09:51:59 +0800
Message-ID: <cfe73c43-1b3f-4f7c-adcb-d5a38d6f4acd@linux.alibaba.com>
Date: Thu, 26 Feb 2026 09:51:59 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH][rdma-next] RDMA/erdma: Use NUMA-aware allocation for MTT
 tables
Content-Language: en-US
To: lirongqing <lirongqing@baidu.com>, Kai Shen <kaishen@linux.alibaba.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
References: <20260225085143.1721-1-lirongqing@baidu.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From: Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20260225085143.1721-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-17193-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chengyou@linux.alibaba.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim,alibaba.com:email]
X-Rspamd-Queue-Id: 2896F19FF32
X-Rspamd-Action: no action



On 2/25/26 4:51 PM, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> Currently, MTT (Memory Translation Table) buffers are allocated without
> NUMA awareness using kzalloc() and vzalloc(), which allocate memory on
> the NUMA node of the calling CPU. This can lead to cross-node memory
> access latencies if the erdma device is attached to a different NUMA
> socket.
> 
> Switch to kzalloc_node() and vzalloc_node() to ensure MTT buffers are
> allocated on the local NUMA node of the PCIe device (dev->attrs.numa_node).
> This reduces latency for hardware access and improves performance.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/infiniband/hw/erdma/erdma_verbs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Cheng Xu <chengyou@linux.alibaba.com>

> diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
> index 9f74aad..58da6ef 100644
> --- a/drivers/infiniband/hw/erdma/erdma_verbs.c
> +++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
> @@ -604,7 +604,7 @@ static struct erdma_mtt *erdma_create_cont_mtt(struct erdma_dev *dev,
>  		return ERR_PTR(-ENOMEM);
>  
>  	mtt->size = size;
> -	mtt->buf = kzalloc(mtt->size, GFP_KERNEL);
> +	mtt->buf = kzalloc_node(mtt->size, GFP_KERNEL, dev->attrs.numa_node);
>  	if (!mtt->buf)
>  		goto err_free_mtt;
>  
> @@ -729,7 +729,7 @@ static struct erdma_mtt *erdma_create_scatter_mtt(struct erdma_dev *dev,
>  		return ERR_PTR(-ENOMEM);
>  
>  	mtt->size = ALIGN(size, PAGE_SIZE);
> -	mtt->buf = vzalloc(mtt->size);
> +	mtt->buf = vzalloc_node(mtt->size, dev->attrs.numa_node);
>  	mtt->continuous = false;
>  	if (!mtt->buf)
>  		goto err_free_mtt;

