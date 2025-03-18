Return-Path: <linux-rdma+bounces-8774-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FD2A670CF
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 11:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B057F3B4431
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 10:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350BC205AC1;
	Tue, 18 Mar 2025 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNtGbE3a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F05157E6B
	for <linux-rdma@vger.kernel.org>; Tue, 18 Mar 2025 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292619; cv=none; b=Ejr1qgloG46Ev9mFLXpVn6RHiU0v4NXRQQ8E8/qfpvKEqjS15RAfqPzL1q0ivh0Lw8A9GjUJ2s0MA4qZpVZGh1+XKJv/QqatcL70ddyyAIVrWycgPEJrmhP4m11m013M1Da5s33M5FuEmmwm5Dki6YLXHsBjTLQclEAlvnzQkGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292619; c=relaxed/simple;
	bh=h3i6cFyhyTW6WSqDttMrGeOHuEvK0fPK4Kxi34eqWfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyWxAR6OtjWD4c2CD4b47sQIMoQ9FAdhfPLxQYASOtdvTFewE0TC24DA0JL8FUtvPlnCtFDdU5QA1gk4SptczE0Kwzol/Yznsbj+QVCODrm7PhYNBeYHC/CseHp39Q5TrdE84vwyN54s1v8IE+9aTLjo810LpZJkBVjw5vuctkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNtGbE3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F18C4CEDD;
	Tue, 18 Mar 2025 10:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742292618;
	bh=h3i6cFyhyTW6WSqDttMrGeOHuEvK0fPK4Kxi34eqWfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qNtGbE3aQj/Yg2jNcpNkkmtUkloywKsFmPbV09QVWjelkqNLG+MmoGQyE0M4BvB20
	 xbSrTtWAv8zYiHL3FG7eBxAJf55GW31ZV4ZTpjs1CvuuGKxm/ggtqAVmCw5kucuFiR
	 Q1dAmix2EfdffdAKa2GjBuzwL8VE0IFVad2wPlgVq9Sr8OYR6OVdDH89AuyCiSZ6K5
	 33zpkb4X7SvgeP3c02RAp3tC0Tcbyqo5P2tNXZnBlFtdQ/E1+9vamdBv+9g1KwzY5E
	 7jNCaxRTi+HyLz/IDj1+ys/Ky7028m/odZpVs8WQCwdg0G5Q04Dzz8EHerfbLKpof/
	 sUbVIiYb9T/ng==
Date: Tue, 18 Mar 2025 12:10:14 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, zyjzyj2000@gmail.com,
	lizhijian@fujitsu.com
Subject: Re: [PATCH for-next v2 2/2] RDMA/rxe: Enable ODP in ATOMIC WRITE
 operation
Message-ID: <20250318101014.GA1322339@unreal>
References: <20250318094932.2643614-1-matsuda-daisuke@fujitsu.com>
 <20250318094932.2643614-3-matsuda-daisuke@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318094932.2643614-3-matsuda-daisuke@fujitsu.com>

On Tue, Mar 18, 2025 at 06:49:32PM +0900, Daisuke Matsuda wrote:
> Add rxe_odp_do_atomic_write() so that ODP specific steps are applied to
> ATOMIC WRITE requests.
> 
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe.c      |  1 +
>  drivers/infiniband/sw/rxe/rxe_loc.h  |  5 +++
>  drivers/infiniband/sw/rxe/rxe_mr.c   | 12 -------
>  drivers/infiniband/sw/rxe/rxe_odp.c  | 53 ++++++++++++++++++++++++++++
>  drivers/infiniband/sw/rxe/rxe_resp.c | 11 +++++-
>  include/rdma/ib_verbs.h              |  1 +
>  6 files changed, 70 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index df66f8f9efa1..21ce2d876b42 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -110,6 +110,7 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
>  		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_ATOMIC;
>  		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_SRQ_RECV;
>  		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_FLUSH;
> +		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_ATOMIC_WRITE;
>  	}
>  }

<...>

> +static inline int rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
> +{
> +	return RESPST_ERR_UNSUPPORTED_OPCODE;
> +}
>  #endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */

You are returning "enum resp_states", while function expects to return "int". You should return -EOPNOTSUPP.

>  
>  #endif /* RXE_LOC_H */
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 93e4b5acd3ac..d40fbe10633f 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -547,16 +547,6 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
>  	struct page *page;
>  	u64 *va;
>  
> -	/* ODP is not supported right now. WIP. */
> -	if (mr->umem->is_odp)
> -		return RESPST_ERR_UNSUPPORTED_OPCODE;
> -
> -	/* See IBA oA19-28 */
> -	if (unlikely(mr->state != RXE_MR_STATE_VALID)) {
> -		rxe_dbg_mr(mr, "mr not in valid state\n");
> -		return RESPST_ERR_RKEY_VIOLATION;
> -	}
> -
>  	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
>  		page_offset = iova & (PAGE_SIZE - 1);
>  		page = ib_virt_dma_to_page(iova);
> @@ -584,10 +574,8 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
>  	}
>  
>  	va = kmap_local_page(page);
> -
>  	/* Do atomic write after all prior operations have completed */
>  	smp_store_release(&va[page_offset >> 3], value);
> -
>  	kunmap_local(va);
>  
>  	return 0;
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> index 9a9aae967486..f3443c604a7f 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -378,3 +378,56 @@ int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
>  
>  	return 0;
>  }
> +
> +#if defined CONFIG_64BIT
> +/* only implemented or called for 64 bit architectures */
> +int rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
> +{
> +	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
> +	unsigned int page_offset;
> +	unsigned long index;
> +	struct page *page;
> +	int err;
> +	u64 *va;
> +
> +	/* See IBA oA19-28 */
> +	err = mr_check_range(mr, iova, sizeof(value));
> +	if (unlikely(err)) {
> +		rxe_dbg_mr(mr, "iova out of range\n");
> +		return RESPST_ERR_RKEY_VIOLATION;

Please don't redefine returned errors.

> +	}

<...>

> +#else
> +int rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
> +{
> +	return RESPST_ERR_UNSUPPORTED_OPCODE;
> +}
> +#endif

You already have empty declaration in rxe_loc.h, use it.

Thanks

