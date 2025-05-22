Return-Path: <linux-rdma+bounces-10541-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A3FAC101D
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 17:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA911BA6382
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 15:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7D729826D;
	Thu, 22 May 2025 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K8mVXRIk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06D9539A
	for <linux-rdma@vger.kernel.org>; Thu, 22 May 2025 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747928446; cv=none; b=LrgveruC0newffiPFY61IdcLfrnJ3nCSpFBV1CEmKGwObHgTHGx4L1QfKOKOtDXUIwFFFcy7ZjR846k/pnjz//loQGf+hQTwJ17qWpeBxcA+wXMtxaXr7fDnB8vbhaGbXl4ph5AViPhZtaazQ+UV9cqEk/s6yeE1Bd3IifLzmoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747928446; c=relaxed/simple;
	bh=Cik4EPQbVMtRDN9JVXUxSnWfW9xZ2v/2sUaiEja/2+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jk6E1oGUav14qAMd1v4oeHFFyPKDzUbjvVf6nz7GO/oopd2S3KJYtdCmJW4hE4wzV5PoPYBqwOITxkpfWSUCOvcm7xYhhPwNjbRnKPT+M3Z2JounG1KGOmcgaXkSiNs9GuvAOWUtMwfurfKd+kYx75PUmMfi5H9HGpjfRgwG5CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K8mVXRIk; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bb5dcd1c-669a-4e23-8b41-4dc018331b82@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747928441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDseSkGiHlxcROLD09BA7MJUv7elUR0+RmU7GnDypXY=;
	b=K8mVXRIkrifEBh4PZZ8+iHOeVHmXveAS1W/n+IE4JPbeNuJI0BqoXO3U8BqWKIXQtDUPzo
	7f583o7r/q7ZvAkVhy9Pj/YjygJa+C14vJJMpN4twfyfmU3cYdAxqj8fO3QJ1Nwvyxr+cJ
	OKR0CFvJrY4a9DlPavkhSX2J03Zf1N0=
Date: Thu, 22 May 2025 17:40:38 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next] RDMA/rxe: Break endless pagefault loop for RO
 pages
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, Daisuke Matsuda <dskmtsd@gmail.com>,
 linux-rdma@vger.kernel.org, Zhu Yanjun <zyjzyj2000@gmail.com>
References: <096fab178d48ed86942ee22eafe9be98e29092aa.1747913377.git.leonro@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <096fab178d48ed86942ee22eafe9be98e29092aa.1747913377.git.leonro@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/5/22 13:36, Leon Romanovsky 写道:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> RO pages has "perm" equal to 0, that caused to the situation
> where such pages were marked as needed to have fault and caused
> to infinite loop.
> 
> Fixes: eedd5b1276e7 ("RDMA/umem: Store ODP access mask information in PFN")
> Reported-by: Daisuke Matsuda <dskmtsd@gmail.com>
> Closes: https://lore.kernel.org/all/3e8f343f-7d66-4f7a-9f08-3910623e322f@gmail.com
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_odp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> index a1416626f61a5..0f67167ddddd1 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -137,7 +137,7 @@ static inline bool rxe_check_pagefault(struct ib_umem_odp *umem_odp,
>   	while (addr < iova + length) {
>   		idx = (addr - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
>   
> -		if (!(umem_odp->map.pfn_list[idx] & perm)) {
> +		if (!(umem_odp->map.pfn_list[idx] & HMM_PFN_VALID)) {

Because perm is not used, it is not necessary to calculate and pass perm 
to rxe_check_pagefault. The cleanup is as below:

diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c 
b/drivers/infiniband/sw/rxe/rxe_odp.c
index 9f6e2bb2a269..f385fccd5988 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -125,7 +125,7 @@ int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 
start, u64 length,
  }

  static inline bool rxe_check_pagefault(struct ib_umem_odp *umem_odp,
-                                      u64 iova, int length, u32 perm)
+                                      u64 iova, int length)
  {
         bool need_fault = false;
         u64 addr;
@@ -137,7 +137,7 @@ static inline bool rxe_check_pagefault(struct 
ib_umem_odp *umem_odp,
         while (addr < iova + length) {
                 idx = (addr - ib_umem_start(umem_odp)) >> 
umem_odp->page_shift;

-               if (!(umem_odp->dma_list[idx] & perm)) {
+               if (!(umem_odp->dma_list[idx] & HMM_PFN_VALID)) {
                         need_fault = true;
                         break;
                 }
@@ -151,19 +151,14 @@ static int rxe_odp_map_range_and_lock(struct 
rxe_mr *mr, u64 iova, int length, u
  {
         struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
         bool need_fault;
-       u64 perm;
         int err;

         if (unlikely(length < 1))
                 return -EINVAL;

-       perm = ODP_READ_ALLOWED_BIT;
-       if (!(flags & RXE_PAGEFAULT_RDONLY))
-               perm |= ODP_WRITE_ALLOWED_BIT;
-
         mutex_lock(&umem_odp->umem_mutex);

-       need_fault = rxe_check_pagefault(umem_odp, iova, length, perm);
+       need_fault = rxe_check_pagefault(umem_odp, iova, length);
         if (need_fault) {
                 mutex_unlock(&umem_odp->umem_mutex);

@@ -173,7 +168,7 @@ static int rxe_odp_map_range_and_lock(struct rxe_mr 
*mr, u64 iova, int length, u
                 if (err < 0)
                         return err;

-               need_fault = rxe_check_pagefault(umem_odp, iova, length, 
perm);
+               need_fault = rxe_check_pagefault(umem_odp, iova, length);
                 if (need_fault)
                         return -EFAULT;
         }

Zhu Yanjun

>   			need_fault = true;
>   			break;
>   		}


