Return-Path: <linux-rdma+bounces-876-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 296F8847E6B
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Feb 2024 03:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84DE28ADA4
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Feb 2024 02:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741221C02;
	Sat,  3 Feb 2024 02:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zt+RmWdU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5878663AE
	for <linux-rdma@vger.kernel.org>; Sat,  3 Feb 2024 02:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706927503; cv=none; b=FezjERjlqhveN1wl8WJVNXF7RVxh90EjoLYUxG/y8IhIOafI6QGJMU2t2GvnKvoSw59vqETc72EuH7gAsYv9yRtiI/sMeqdJw0lNYf4JJOVLFAIX2w1jhmfNPJkNeGALlm6nSNmTz2P3+GxIACJ9PKah9VboqtlsDuFasiXY/XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706927503; c=relaxed/simple;
	bh=JByoG+mePGG2CGIrb4+Ct/jHsBMs+gVJrYQRz6FPSio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UO6aUk6ml2/Hjr3in5imo3dNGMvnm0g1hrpuTtLxAGDFdDitonXDhHdiXyls5CUh8GtPOuKuWdHnnBO12pb4eu4O1YE4h2xGL5oCTb+LYdk6wFA5K0ghEm30onJ4mMGZzvmNpmhCam0jgvMqvIBF/jNq39+q3XzzDHCWScenY5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zt+RmWdU; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bb83910b-d249-4060-b9ed-38e0d4aad213@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706927498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E/VrcVhvfODqXE/qXp7gcceThKizCQSOvGPWf1LxpVw=;
	b=Zt+RmWdUA2iiTcz7GWiFgycHiRJIn14v67spYxUo2/MyLtBVUsIgwXPT2EYCRckC9On/E5
	edshEwhTMSrd82NVMCMhRZC2dv+HWwWef9hq7qevEs0Zdd6TLAIFvvCFTtN89bybjpO6AD
	ilfDjKfRS8BkRMWIBcMZPcbnOkcHIwo=
Date: Sat, 3 Feb 2024 10:31:30 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] RDMA/rxe: Remove unused 'iova' parameter from
 rxe_mr_init_user
To: Guoqing Jiang <guoqing.jiang@linux.dev>, zyjzyj2000@gmail.com,
 jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org
References: <20240202124144.16033-1-guoqing.jiang@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240202124144.16033-1-guoqing.jiang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/2/2 20:41, Guoqing Jiang 写道:
> This one is not needed since commit 954afc5a8fd8 ("RDMA/rxe:
> Use members of generic struct in rxe_mr").
> 
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Thanks,
Zhu Yanjun

> ---
> v2 changes:
> 1. add relevant change in rxe_reg_user_mr, thanks for Yanjun's reminder
> 
>   drivers/infiniband/sw/rxe/rxe_loc.h   | 2 +-
>   drivers/infiniband/sw/rxe/rxe_mr.c    | 2 +-
>   drivers/infiniband/sw/rxe/rxe_verbs.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 4d2a8ef52c85..746110898a0e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -59,7 +59,7 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
>   /* rxe_mr.c */
>   u8 rxe_get_next_key(u32 last_key);
>   void rxe_mr_init_dma(int access, struct rxe_mr *mr);
> -int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
> +int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
>   		     int access, struct rxe_mr *mr);
>   int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr);
>   int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int length);
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index bc81fde696ee..da3dee520876 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -126,7 +126,7 @@ static int rxe_mr_fill_pages_from_sgt(struct rxe_mr *mr, struct sg_table *sgt)
>   	return xas_error(&xas);
>   }
>   
> -int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
> +int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
>   		     int access, struct rxe_mr *mr)
>   {
>   	struct ib_umem *umem;
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index f0a03b910702..614581989b38 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -1278,7 +1278,7 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
>   	mr->ibmr.pd = ibpd;
>   	mr->ibmr.device = ibpd->device;
>   
> -	err = rxe_mr_init_user(rxe, start, length, iova, access, mr);
> +	err = rxe_mr_init_user(rxe, start, length, access, mr);
>   	if (err) {
>   		rxe_dbg_mr(mr, "reg_user_mr failed, err = %d\n", err);
>   		goto err_cleanup;


