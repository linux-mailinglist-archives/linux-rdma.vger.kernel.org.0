Return-Path: <linux-rdma+bounces-15229-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5146CDF49F
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Dec 2025 06:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5CA63006A95
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Dec 2025 05:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB02219FC;
	Sat, 27 Dec 2025 05:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DG1d8dlR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B343A1E68
	for <linux-rdma@vger.kernel.org>; Sat, 27 Dec 2025 05:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766813451; cv=none; b=hxGVy2+b8RBw1kTazBHczhFCLFRHIe3ineAn9YUWtNwiq7/XnbnSqiX5o2kLswHE4+E3Lz37lE9hrFB74PLFvmoasf9OMYL++Y2WAHqbngE7sJhTNJdSa/LFDyh/ACrXv/7f63Wu1QONssPHj8vArKf0kFxopo6DoC2L+2RZVMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766813451; c=relaxed/simple;
	bh=AGJUyxUGJf2sRndL5BaTZPal/g0gjTG/rWD5iGoXb5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKOVggWdO+877a6RPmSID12TZO8Zg6MKXVE3JWr8uMbtu4+s1TUaG2RADA7Y8b0+Se8LlAEjFlkpCAxiW0KIYdL9G1jY0DX6T/Oq7CI8LfRgvZ2OzUKCEIJM3m4tSY8QGVUS/5GhHgdYUnTqRdjuRfr93X5vN3LvGWCmcFCzwLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DG1d8dlR; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <20a9c8d2-1151-4318-8e77-3cced4040128@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766813446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ic329E6f7rpibmopmNxHnsgOp2wCIzrnu4OlFdxbf2o=;
	b=DG1d8dlRgT1wv+QAePUtDDG+muZsc50YLQuLN1ZHqB129hWMGVCfOskhAVEogP7/Vb263r
	M7pZ0TOSlaE47oUBithhL67W4NHfv4nc9coOsJDbZegJjtE+wdhtr1dM6bevJ7uQf583SW
	+DZ5KFqhZLfY+Uw2tZc0GwzpgXwBZwg=
Date: Fri, 26 Dec 2025 21:30:38 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Remove unused page_offset member
To: Li Zhijian <lizhijian@fujitsu.com>, linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zyjzyj2000@gmail.com, jgg@ziepe.ca,
 leon@kernel.org
References: <20251226094159.3042935-1-lizhijian@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20251226094159.3042935-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/12/26 1:41, Li Zhijian 写道:
> The `page_offset` member of the `rxe_mr` struct was initialized based on
> `ibmr.iova`, which at the initialization point hadn't been properly set.
> 
> Consequently, the value assigned to `page_offset` was incorrect. However,

Hi, Zhijian

Why page_offset was incorrect? Can you explain it and add the 
explainations into commit log?

But removing page_offset seems correct.

Thanks,
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> since `page_offset` was never utilized throughout the code, it can be safely
> removed to clean up the codebase and avoid future confusion.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_mr.c    | 1 -
>   drivers/infiniband/sw/rxe/rxe_odp.c   | 1 -
>   drivers/infiniband/sw/rxe/rxe_verbs.h | 1 -
>   3 files changed, 3 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index bcb97b3ea58a..b28b56db725a 100644
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
> index f58e3ec6252f..8b6a8b064d3c 100644
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


