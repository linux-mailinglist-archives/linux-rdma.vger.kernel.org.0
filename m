Return-Path: <linux-rdma+bounces-11062-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD69AD11EB
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Jun 2025 13:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B487F169D89
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Jun 2025 11:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27990202C5C;
	Sun,  8 Jun 2025 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e2mA5F9H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DAB3D544
	for <linux-rdma@vger.kernel.org>; Sun,  8 Jun 2025 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749381810; cv=none; b=N5HKgBE0N04KG8rP0SCbNYYuiMHvSWo/GFWoyQzMF5Px5ktYbDsmPERKlNBA0jDDnCFCcuBEbIgM286tKM8Evi4Zvb3CnxCGtAah67W0o26gUD6k1+w4zzFnPT/m3mueSUih7mi3os+9qR10WPDJmTrlLY1Osq6kXV1R7Mj0bvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749381810; c=relaxed/simple;
	bh=vBmVa7+HT3ViIIYGboa8Z7ZUcGoENSu0gRQmBGL1pBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rk2JHmIDpc9EVSeHdr2p1P5bngl1WFJdtOZmY6TU1ubR/eTpWmrw/KcGWfbsV51TpAMaiXvkKAMUNKXwlDNi12mA0sC3ObpA6U/F0Ijlv2vJpzIOJl3fK1TYsSdE8XCkBvaGXF76IFNNCIwiH2PSrdGl2te00dHeFTc5HA2HZpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e2mA5F9H; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c63d3202-8a5d-448d-b802-f8a7e0275265@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749381805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oV/g9IcWkYk25U7TyFCt/av8AbniaH2IFDp1/9aw+TQ=;
	b=e2mA5F9HSorfB/NsPDyc/ilcbaVo0SUniYatRyTNlS2nSvgGIgiqg9U9BRHSkjACrnXxSY
	waQiCR8FiFytxDrAob8ggh4MbtZvScsF9GT9WUJ7wBi4b8hQgZX8+q6LEyYsjhoLm+kGlj
	cY4WN4pITv2DOiS1hl/8d1wTx3KPlI8=
Date: Sun, 8 Jun 2025 13:23:19 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v2] RDMA/rxe: Remove redundant page presence
 check
To: Daisuke Matsuda <dskmtsd@gmail.com>, linux-rdma@vger.kernel.org,
 leon@kernel.org, jgg@ziepe.ca, zyjzyj2000@gmail.com
References: <20250608095916.6313-1-dskmtsd@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250608095916.6313-1-dskmtsd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/6/8 11:59, Daisuke Matsuda 写道:
> hmm_pfn_to_page() does not return NULL. ib_umem_odp_map_dma_and_lock()
> should return an error in case the target pages cannot be mapped until
> timeout, so these checks can safely be removed.
> 
> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_odp.c | 13 +------------
>   1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> index dbc5a5600eb7..02841346e30c 100644
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
> @@ -286,8 +284,6 @@ static enum resp_states rxe_odp_do_atomic_op(struct rxe_mr *mr, u64 iova,
>   	idx = rxe_odp_iova_to_index(umem_odp, iova);
>   	page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);
>   	page = hmm_pfn_to_page(umem_odp->map.pfn_list[idx]);

The function hmm_pfn_to_page will finally be "(mem_map + ((pfn) - 
ARCH_PFN_OFFSET))"

The procedure is as below:

hmm_pfn_to_page -- > pfn_to_page -- > __pfn_to_page -- > (mem_map + 
((pfn) - ARCH_PFN_OFFSET))

Thus, I am fine with it.

> -	if (!page)
> -		return RESPST_ERR_RKEY_VIOLATION;
>   
>   	if (unlikely(page_offset & 0x7)) {

Normally page_offset error handler should be after this line 
"page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);"

Why is this error handler after hmm_pfn_to_page?

>   		rxe_dbg_mr(mr, "iova not aligned\n");
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
> @@ -398,10 +390,7 @@ enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
>   	page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);
>   	index = rxe_odp_iova_to_index(umem_odp, iova);
>   	page = hmm_pfn_to_page(umem_odp->map.pfn_list[index]);
> -	if (!page) {
> -		mutex_unlock(&umem_odp->umem_mutex);
> -		return RESPST_ERR_RKEY_VIOLATION;
> -	}
> +
>   	/* See IBA A19.4.2 */
>   	if (unlikely(page_offset & 0x7)) {

Ditto, page_offset error handler is not after the line "page_offset = 
rxe_odp_iova_to_page_offset(umem_odp, iova);" ?

Thanks
Yanjun.Zhu

>   		mutex_unlock(&umem_odp->umem_mutex);


