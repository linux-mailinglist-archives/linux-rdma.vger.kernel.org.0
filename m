Return-Path: <linux-rdma+bounces-15611-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DA0D2B14A
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 05:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C67F2301670E
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 03:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2303B342CA7;
	Fri, 16 Jan 2026 03:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KVBBIdJ2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE42618FC86
	for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 03:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768535971; cv=none; b=nlVbO/PyaxbWBTmI+59v40IiQoByxoniozq1ol0VmadweVCac8ExQCKkw9/iWegbgNoKwTdWA1L9a/t5VlXWVY1JQT3ssIRncZy6qR6IV1pfetkq8kw4MAFC3FyVarnYfM6SdLegz516ZV6v15SUIqaQ1WPgC3RMmYvHRP5WFaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768535971; c=relaxed/simple;
	bh=pEsW3vwQZKm24Fwnb4G2BTOggsH4W7DtPWoIq9FAnz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IdovSbTniDu0qi0RCcHpl5SG9XmUk83+1rqgMmeIrtZMegikusx6TPvN1LeJG05eTPGNl4MZhb7FCGyYsLfhnPyC3h8JQnafwwvW6oOcG6g+47+YlKJ70taPqCgmdiGRjDEIbI1QOp7Xqj2Ex+0020UrbC/V31B4+Vnb4N0Lfg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KVBBIdJ2; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f4685558-4735-4e55-b05f-0c8b55580c17@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768535967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wiLn0XpFrzxmu9P+1J3h9OnFEdTWYbXbcUgaANEcCcY=;
	b=KVBBIdJ28KnhC3GDGaUaQH8f19bwc7YekE1PFzup0poSVOC6SZtJyBLi2J5VWOA/i617tH
	EheUyeYR7kRMIXLxWJ4nMDLzmYQ8yH+7rtTChQ8SyvWRbgVFYWnnpvtN0SHH/LPbCZqTb3
	RtQin9k42xsH1siSBfBNrD7r7GMUSjQ=
Date: Thu, 15 Jan 2026 19:59:20 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] RDMA/rxe: Remove unused page_offset member
To: Li Zhijian <lizhijian@fujitsu.com>, linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zyjzyj2000@gmail.com, jgg@ziepe.ca,
 leon@kernel.org
References: <20260116032833.2574627-1-lizhijian@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260116032833.2574627-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2026/1/15 19:28, Li Zhijian 写道:
> In rxe_map_mr_sg(), the `page_offset` member of the `rxe_mr` struct
> was initialized based on `ibmr.iova`, which will be updated inside
> ib_sg_to_pages() later.
>
> Consequently, the value assigned to `page_offset` was incorrect. However,
> since `page_offset` was never utilized throughout the code, it can be safely
> removed to clean up the codebase and avoid future confusion.
>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Thanks a lot. I am fine with it.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> ---
> V2: make commit log more clear # Zhu
> ---
>   drivers/infiniband/sw/rxe/rxe_mr.c    | 1 -
>   drivers/infiniband/sw/rxe/rxe_odp.c   | 1 -
>   drivers/infiniband/sw/rxe/rxe_verbs.h | 1 -
>   3 files changed, 3 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index b1df05238848..05710d785a7e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -237,7 +237,6 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
>   	mr->nbuf = 0;
>   	mr->page_shift = ilog2(page_size);
>   	mr->page_mask = ~((u64)page_size - 1);
> -	mr->page_offset = mr->ibmr.iova & (page_size - 1);
>   
>   	return ib_sg_to_pages(ibmr, sgl, sg_nents, sg_offset, rxe_set_page);
>   }
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> index c928cbf2e35f..d3a54bfaf92f 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -110,7 +110,6 @@ int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
>   	mr->access = access_flags;
>   	mr->ibmr.length = length;
>   	mr->ibmr.iova = iova;
> -	mr->page_offset = ib_umem_offset(&umem_odp->umem);
>   
>   	err = rxe_odp_init_pages(mr);
>   	if (err) {
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index fd48075810dd..f94ce85eb807 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -347,7 +347,6 @@ struct rxe_mr {
>   	int			access;
>   	atomic_t		num_mw;
>   
> -	unsigned int		page_offset;
>   	unsigned int		page_shift;
>   	u64			page_mask;
>   

-- 
Best Regards,
Yanjun.Zhu


