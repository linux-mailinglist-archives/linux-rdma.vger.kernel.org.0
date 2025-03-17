Return-Path: <linux-rdma+bounces-8755-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAFCA65C72
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 19:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1946319A1895
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 18:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D3F1DE2D6;
	Mon, 17 Mar 2025 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/+Zl2nl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295DF1DE3CB
	for <linux-rdma@vger.kernel.org>; Mon, 17 Mar 2025 18:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235773; cv=none; b=YcqUuexA1ZfKvdb0eWD1hZ+glzzBPshyBthtTPORUB8TS+/Z4W/milZWwO+jd8KyDKas7KisoLWCgNzJUwiq2OzIjPbu6ZUdqpy9FLoaY1HgllqtlsT3iVUjnixPk3/TYmm4rhJjT+lY9uC+o1wDSm/LHq5I0CClJP94R8jm9Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235773; c=relaxed/simple;
	bh=Lrsae4wn89SYoIb/YPkHSLO2RGvSnv5YG/450rqbRMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=da5O9HdwMFNAU38Dsba9NYinxaCRneTu9MGYfF+U5VUXqCA/2e867/7vas26usGgwuhYOZRPpxkVzAxKDj+FkJSX+be1SttdqXGPHt4Zn37mzjoP6l8Lw/z6yWCpO+bWm7EpTTov7nWIr03JDQqmdAeIruq1p3z3JcxHyFGCadQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/+Zl2nl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFFAC4CEF2;
	Mon, 17 Mar 2025 18:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742235772;
	bh=Lrsae4wn89SYoIb/YPkHSLO2RGvSnv5YG/450rqbRMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G/+Zl2nlkBdYhRGyx+Wxe8PN/pDgiYx+AbhTivz5xi903ILZyaBix11hA+D00Ljie
	 n+Yhfrr6vd0gkYCGm0Ghhe6MCk4ngKu4A/nsaqTX8pGMu6hxIlTJABzpUOv4QUjv4J
	 xg87iNsTubeNaSTbji1Ie7NMPfCCGZDTZMIVYABQNWccPX3vwPBAK/BMky/t9UnT3a
	 6TnMMB/oipVMD2Mesg5dDG3GqE3kEwSeL5drjOcMuIRHyIQ1yrhvbVU+nY1BOUZJZ0
	 D4/7LN2vx3mYX+f1ekjsY2QAZhT7Me5bNEjXZIIboSP88341nODoVlzNee5z1jF4Hl
	 ku6sp3sFBcfdg==
Date: Mon, 17 Mar 2025 20:22:47 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, zyjzyj2000@gmail.com,
	lizhijian@fujitsu.com
Subject: Re: [PATCH for-next v1 1/2] RDMA/rxe: Enable ODP in RDMA FLUSH
 operation
Message-ID: <20250317182247.GY1322339@unreal>
References: <20250314081056.3496708-1-matsuda-daisuke@fujitsu.com>
 <20250314081056.3496708-2-matsuda-daisuke@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314081056.3496708-2-matsuda-daisuke@fujitsu.com>

On Fri, Mar 14, 2025 at 05:10:55PM +0900, Daisuke Matsuda wrote:
> For persistent memories, add rxe_odp_flush_pmem_iova() so that ODP specific
> steps are executed. Otherwise, no additional consideration is required.
> 
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe.c      |  1 +
>  drivers/infiniband/sw/rxe/rxe_loc.h  |  7 +++
>  drivers/infiniband/sw/rxe/rxe_odp.c  | 73 ++++++++++++++++++++++++++--
>  drivers/infiniband/sw/rxe/rxe_resp.c | 13 ++---
>  include/rdma/ib_verbs.h              |  1 +
>  5 files changed, 85 insertions(+), 10 deletions(-)

<...>

>  
> +static unsigned long rxe_odp_iova_to_index(struct ib_umem_odp *umem_odp, u64 iova)
> +{
> +	return (iova - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
> +}
> +
> +static unsigned long rxe_odp_iova_to_page_offset(struct ib_umem_odp *umem_odp, u64 iova)
> +{
> +	return iova & (BIT(umem_odp->page_shift) - 1);
> +}
> +
>  static int rxe_odp_map_range_and_lock(struct rxe_mr *mr, u64 iova, int length, u32 flags)
>  {
>  	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
> @@ -190,8 +201,8 @@ static int __rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
>  	size_t offset;
>  	u8 *user_va;
>  
> -	idx = (iova - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
> -	offset = iova & (BIT(umem_odp->page_shift) - 1);
> +	idx = rxe_odp_iova_to_index(umem_odp, iova);
> +	offset = rxe_odp_iova_to_page_offset(umem_odp, iova);
>  
>  	while (length > 0) {
>  		u8 *src, *dest;
> @@ -277,8 +288,8 @@ static int rxe_odp_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
>  		return RESPST_ERR_RKEY_VIOLATION;
>  	}
>  
> -	idx = (iova - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
> -	page_offset = iova & (BIT(umem_odp->page_shift) - 1);
> +	idx = rxe_odp_iova_to_index(umem_odp, iova);
> +	page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);
>  	page = hmm_pfn_to_page(umem_odp->pfn_list[idx]);
>  	if (!page)
>  		return RESPST_ERR_RKEY_VIOLATION;
> @@ -324,3 +335,57 @@ int rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
>  
>  	return err;
>  }
> +
> +int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
> +			    unsigned int length)
> +{

This function looks almost similar to existing rxe_flush_pmem_iova().
Can't you reuse existing functions instead of duplicating?

Thanks

> +	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
> +	unsigned int page_offset;
> +	unsigned long index;
> +	struct page *page;
> +	unsigned int bytes;
> +	int err;
> +	u8 *va;
> +
> +	/* mr must be valid even if length is zero */
> +	if (WARN_ON(!mr))
> +		return -EINVAL;
> +
> +	if (length == 0)
> +		return 0;
> +
> +	err = mr_check_range(mr, iova, length);
> +	if (err)
> +		return err;
> +
> +	err = rxe_odp_map_range_and_lock(mr, iova, length,
> +					 RXE_PAGEFAULT_DEFAULT);
> +	if (err)
> +		return err;
> +
> +	while (length > 0) {
> +		index = rxe_odp_iova_to_index(umem_odp, iova);
> +		page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);
> +
> +		page = hmm_pfn_to_page(umem_odp->pfn_list[index]);
> +		if (!page) {
> +			mutex_unlock(&umem_odp->umem_mutex);
> +			return -EFAULT;
> +		}
> +
> +		bytes = min_t(unsigned int, length,
> +			      mr_page_size(mr) - page_offset);
> +
> +		va = kmap_local_page(page);
> +		arch_wb_cache_pmem(va + page_offset, bytes);
> +		kunmap_local(va);
> +
> +		length -= bytes;
> +		iova += bytes;
> +		page_offset = 0;
> +	}
> +
> +	mutex_unlock(&umem_odp->umem_mutex);
> +
> +	return 0;
> +}

