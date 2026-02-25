Return-Path: <linux-rdma+bounces-17150-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFPaDQvfnmkTXgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17150-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 12:37:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3991969BF
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 12:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A67183015CB6
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 11:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF735394476;
	Wed, 25 Feb 2026 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="d5Xnpy0e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074C1394485;
	Wed, 25 Feb 2026 11:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772019240; cv=none; b=eJjjMcw0RDDcvlHPgEThVovBCZSp3eW6XrIfgkjkHaXa49nHi8lkbCcVdlIaXBn4xFpNUKh5bRcLfSK8WTPfBlYeQaespRPCZ0+8LBOTcMmMsedKNT6U//gKoFKLAvKkhqO5YowWwKiT93gIaKlkFtqfqr0dsk3KM0Wu3GGQT+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772019240; c=relaxed/simple;
	bh=4WXj/H8diYk72UqPYfujuh4wbhoPzyMPYzScMipEO7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HQstBYz0h+V1a6UMAdKBdhTPwZAA8eiCBAEnipGI3AuxjZH3P9emqL6IBBCXcBzYRzRU0KTCX1TKUO5SeWTXug5+roQYp48xYNKiLNCvVozFYIGE1Nz0viePU8IlFGytuLZr99VzDRT6NkMsSyAdtaNZWsmkkb2qx9o3Lwjmk+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=d5Xnpy0e; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772019230; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uJmBxdOoqgQ8mbe+SMlYCNL/yPqxR9ND6i9YPMlifnc=;
	b=d5Xnpy0e7EQRZPrfg0IxP/OVKZMHw0R3wqmpgXGib+/lJ8+utz7qLyR3axCGefiF9b6c11eVZb6QC/TY9tAuCAdL83eTSKLGNF6/AKPCD1yCXTgYLE489Bj1cTEY/K8YpkmrD/Obg+V/nRjgZYyzrSEs/PMYezenMcVJ6Gl7U+k=
Received: from 30.221.115.37(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WzmIOvs_1772019229 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Feb 2026 19:33:50 +0800
Message-ID: <7cfd31d3-fe40-8b2d-cea8-14748db5f35b@linux.alibaba.com>
Date: Wed, 25 Feb 2026 19:33:49 +0800
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
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260225085143.1721-1-lirongqing@baidu.com>
From: Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20260225085143.1721-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17150-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chengyou@linux.alibaba.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D3991969BF
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

Hi, Li RongQing,

Thanks for the patch. However, I think it is better to keep the current
behavior, for the following reasons:

1. This path is in the control plane, so allocating memory from a remote
   NUMA node should not have a noticeable performance impact.
2. With this change, the driver may fail the allocation when the local NUMA
   node is out of memory, even if other nodes still have available memory.

Thanks,
Cheng Xu

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

