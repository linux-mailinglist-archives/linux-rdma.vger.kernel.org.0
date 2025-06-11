Return-Path: <linux-rdma+bounces-11212-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F13AD6028
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jun 2025 22:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607521BC04CA
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jun 2025 20:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10658233707;
	Wed, 11 Jun 2025 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="isZL5tLL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37991D5CDD
	for <linux-rdma@vger.kernel.org>; Wed, 11 Jun 2025 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749674235; cv=none; b=hQCScBSYSjJQ1FIxYmF+0yJ4CKzw3DJTBg8aBbMgqbE72QEajIA2CRmuQKGx0yQr4w8O7+Gehc46AM0P+0AsiJo7t7/FyqxFEguj2A1+5eA6k3EPFP5bGaA5yFtflQKUPPQyFTUHtwwGwZeJxpy0nC1rIcGDsAmoBJmHpu44a0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749674235; c=relaxed/simple;
	bh=imcor03du5uJHqCsLZCduImedJYLhxsu/euXUpPBr1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MvwWotITtkvlyAyrkF/kZVr8m2pmwQl1nb7vW5VS8MRZURbAhGBCblfMj80dh8yiFln3YE4wQ2nkzmeunhtXjVRUR2uf8KGWn5uaOUTFGe4bJmHp3EGtUWvZiJ7Lx5M5qRIiRpJ1eGln5sqyj/oirGahya3sZZDVZBOkIcAIXjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=isZL5tLL; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <31dc8069-4a4c-44ad-b224-aa06e13f79c1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749674230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OQOOcJTHfFhVgrzvUaE6YRRH1rAPpp5OatedLCcm/Vo=;
	b=isZL5tLLkMQ71EN2RiOQ2aOH7b0ctbeXpK0sYvAn7J6fEDr45mZmKtmLq9GRM1LoEbzC8M
	gWW504uuJWogUiJH/hSwuXLxHbP/IN5dJhH6jqzupegDcGEv/uDtJbzFA5yDzAYtV2xoMu
	W2vqOjO2iWjfyGilICzDc/NIqjlWvDc=
Date: Wed, 11 Jun 2025 13:37:01 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v3] RDMA/rxe: Remove redundant page presence
 check
To: Daisuke Matsuda <dskmtsd@gmail.com>, linux-rdma@vger.kernel.org,
 leon@kernel.org, jgg@ziepe.ca, zyjzyj2000@gmail.com
References: <20250611162758.10000-1-dskmtsd@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250611162758.10000-1-dskmtsd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/6/11 9:27, Daisuke Matsuda 写道:
> hmm_pfn_to_page() does not return NULL. ib_umem_odp_map_dma_and_lock()
> should return an error in case the target pages cannot be mapped until
> timeout, so these checks can safely be removed.
> 
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
> 
> v2->v3:
>    - Move page_offset error check before hmm_pfn_to_page(), as suggested by Zhu

I am fine with this commit.

Thanks a lot for your effort.

Zhu Yanjun

> 
> ---
>   drivers/infiniband/sw/rxe/rxe_odp.c | 23 ++++++-----------------
>   1 file changed, 6 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> index dbc5a5600eb7..0846bd972e15 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -203,8 +203,6 @@ static int __rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
>   
>   		page = hmm_pfn_to_page(umem_odp->map.pfn_list[idx]);
>   		user_va = kmap_local_page(page);
> -		if (!user_va)
> -			return -EFAULT;
>   
>   		src = (dir == RXE_TO_MR_OBJ) ? addr : user_va;
>   		dest = (dir == RXE_TO_MR_OBJ) ? user_va : addr;
> @@ -283,17 +281,15 @@ static enum resp_states rxe_odp_do_atomic_op(struct rxe_mr *mr, u64 iova,
>   		return RESPST_ERR_RKEY_VIOLATION;
>   	}
>   
> -	idx = rxe_odp_iova_to_index(umem_odp, iova);
>   	page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);
> -	page = hmm_pfn_to_page(umem_odp->map.pfn_list[idx]);
> -	if (!page)
> -		return RESPST_ERR_RKEY_VIOLATION;
> -
>   	if (unlikely(page_offset & 0x7)) {
>   		rxe_dbg_mr(mr, "iova not aligned\n");
>   		return RESPST_ERR_MISALIGNED_ATOMIC;
>   	}
>   
> +	idx = rxe_odp_iova_to_index(umem_odp, iova);
> +	page = hmm_pfn_to_page(umem_odp->map.pfn_list[idx]);
> +
>   	va = kmap_local_page(page);
>   
>   	spin_lock_bh(&atomic_ops_lock);
> @@ -352,10 +348,6 @@ int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
>   		page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);
>   
>   		page = hmm_pfn_to_page(umem_odp->map.pfn_list[index]);
> -		if (!page) {
> -			mutex_unlock(&umem_odp->umem_mutex);
> -			return -EFAULT;
> -		}
>   
>   		bytes = min_t(unsigned int, length,
>   			      mr_page_size(mr) - page_offset);
> @@ -396,12 +388,6 @@ enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
>   		return RESPST_ERR_RKEY_VIOLATION;
>   
>   	page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);
> -	index = rxe_odp_iova_to_index(umem_odp, iova);
> -	page = hmm_pfn_to_page(umem_odp->map.pfn_list[index]);
> -	if (!page) {
> -		mutex_unlock(&umem_odp->umem_mutex);
> -		return RESPST_ERR_RKEY_VIOLATION;
> -	}
>   	/* See IBA A19.4.2 */
>   	if (unlikely(page_offset & 0x7)) {
>   		mutex_unlock(&umem_odp->umem_mutex);
> @@ -409,6 +395,9 @@ enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
>   		return RESPST_ERR_MISALIGNED_ATOMIC;
>   	}
>   
> +	index = rxe_odp_iova_to_index(umem_odp, iova);
> +	page = hmm_pfn_to_page(umem_odp->map.pfn_list[index]);
> +
>   	va = kmap_local_page(page);
>   	/* Do atomic write after all prior operations have completed */
>   	smp_store_release(&va[page_offset >> 3], value);


