Return-Path: <linux-rdma+bounces-8722-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 834A7A6320F
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Mar 2025 20:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F321891D7C
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Mar 2025 19:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5DE19C543;
	Sat, 15 Mar 2025 19:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jazCynRo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094F0199E8D
	for <linux-rdma@vger.kernel.org>; Sat, 15 Mar 2025 19:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742066624; cv=none; b=F/1XMmQkv4Zu8BVWPyNBwJuPlznEQJNaAY4KolHKIqw1nrk3CZ9Q4ADHp09kldqILQDIbWU9gUTgdCUGOlUaTzZVgNkpnvvtSi1nUNxUk/uGTsZ36N0HJtYDMMysbROE89l5uu2Z1wiugHLSKh+MLki2+iX9f61x9aaw+umD6lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742066624; c=relaxed/simple;
	bh=/bV2Q92BKgDfLONe/6TmDmp6LtQ9bP76/NoLIqj8RI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CvZG69YFkqyvSqSY3QHAu8L121mQ8rLG4HEIkr3IijzCgJqca5gpT8zZPfw46T7OWhnnW7KojeI8oPfYufrpgzf/WMUmzMZSFZNqFtPpYD3baYmik319rrAMUL1bWkjTu0C0SEjVt7oqbIhF/sWP1r94hH/StzNl2WIXc7S61j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jazCynRo; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <89a99715-873c-4eab-8db2-8c8570432177@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742066619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eioAVuUloTKwVSaGjKESWoJM4nSOYMpt7f7DvzSz5yw=;
	b=jazCynRo13P/1fHZ9uDw4TbrUeju85I60gl2otUxDH1Mj/T/J6wrgX3BnNtlO0873NTFgu
	3SYv/dYjX+oYbrMLF8ZMazM+qTAoS7emJdAeYdxbkjjkXkQrnTbj1TzmVQhy4BphmHzwpS
	BTbghDYyVhN1f3vgYN7Ice4nI11eRKw=
Date: Sat, 15 Mar 2025 20:23:33 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v1 2/2] RDMA/rxe: Enable ODP in ATOMIC WRITE
 operation
To: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
 linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
 zyjzyj2000@gmail.com
Cc: lizhijian@fujitsu.com
References: <20250314081056.3496708-1-matsuda-daisuke@fujitsu.com>
 <20250314081056.3496708-3-matsuda-daisuke@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250314081056.3496708-3-matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/3/14 9:10, Daisuke Matsuda 写道:
> Add rxe_odp_do_atomic_write() so that ODP specific steps are applied to
> ATOMIC WRITE requests.
> 
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>

Thanks a lot. It is better if the perftest results are also attached.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> ---
>   drivers/infiniband/sw/rxe/rxe.c      |  1 +
>   drivers/infiniband/sw/rxe/rxe_loc.h  |  5 +++
>   drivers/infiniband/sw/rxe/rxe_mr.c   |  4 --
>   drivers/infiniband/sw/rxe/rxe_odp.c  | 59 ++++++++++++++++++++++++++++
>   drivers/infiniband/sw/rxe/rxe_resp.c |  5 ++-
>   include/rdma/ib_verbs.h              |  1 +
>   6 files changed, 70 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index df66f8f9efa1..21ce2d876b42 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -110,6 +110,7 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
>   		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_ATOMIC;
>   		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_SRQ_RECV;
>   		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_FLUSH;
> +		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_ATOMIC_WRITE;
>   	}
>   }
>   
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 0012bebe96ef..8b1517c0894c 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -196,6 +196,7 @@ int rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
>   			 u64 compare, u64 swap_add, u64 *orig_val);
>   int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
>   			    unsigned int length);
> +int rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value);
>   #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
>   static inline int
>   rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
> @@ -219,6 +220,10 @@ static inline int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
>   {
>   	return -EOPNOTSUPP;
>   }
> +static inline int rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
> +{
> +	return RESPST_ERR_UNSUPPORTED_OPCODE;
> +}
>   #endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
>   
>   #endif /* RXE_LOC_H */
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 868d2f0b74e9..3aecb5be26d9 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -535,10 +535,6 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
>   	struct page *page;
>   	u64 *va;
>   
> -	/* ODP is not supported right now. WIP. */
> -	if (mr->umem->is_odp)
> -		return RESPST_ERR_UNSUPPORTED_OPCODE;
> -
>   	/* See IBA oA19-28 */
>   	if (unlikely(mr->state != RXE_MR_STATE_VALID)) {
>   		rxe_dbg_mr(mr, "mr not in valid state\n");
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> index c1671e5efd70..79ef5fe41f8e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -389,3 +389,62 @@ int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
>   
>   	return 0;
>   }
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
> +	if (unlikely(mr->state != RXE_MR_STATE_VALID)) {
> +		rxe_dbg_mr(mr, "mr not in valid state\n");
> +		return RESPST_ERR_RKEY_VIOLATION;
> +	}
> +
> +	/* See IBA oA19-28 */
> +	err = mr_check_range(mr, iova, sizeof(value));
> +	if (unlikely(err)) {
> +		rxe_dbg_mr(mr, "iova out of range\n");
> +		return RESPST_ERR_RKEY_VIOLATION;
> +	}
> +
> +	err = rxe_odp_map_range_and_lock(mr, iova, sizeof(value),
> +					 RXE_PAGEFAULT_DEFAULT);
> +	if (err)
> +		return RESPST_ERR_RKEY_VIOLATION;
> +
> +	page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);
> +	index = rxe_odp_iova_to_index(umem_odp, iova);
> +	page = hmm_pfn_to_page(umem_odp->pfn_list[index]);
> +	if (!page) {
> +		mutex_unlock(&umem_odp->umem_mutex);
> +		return RESPST_ERR_RKEY_VIOLATION;
> +	}
> +	/* See IBA A19.4.2 */
> +	if (unlikely(page_offset & 0x7)) {
> +		mutex_unlock(&umem_odp->umem_mutex);
> +		rxe_dbg_mr(mr, "misaligned address\n");
> +		return RESPST_ERR_MISALIGNED_ATOMIC;
> +	}
> +
> +	va = kmap_local_page(page);
> +	/* Do atomic write after all prior operations have completed */
> +	smp_store_release(&va[page_offset >> 3], value);
> +	kunmap_local(va);
> +
> +	mutex_unlock(&umem_odp->umem_mutex);
> +
> +	return 0;
> +}
> +#else
> +int rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
> +{
> +	return RESPST_ERR_UNSUPPORTED_OPCODE;
> +}
> +#endif
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index dd65a8872111..1505d933c09b 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -754,7 +754,10 @@ static enum resp_states atomic_write_reply(struct rxe_qp *qp,
>   	value = *(u64 *)payload_addr(pkt);
>   	iova = qp->resp.va + qp->resp.offset;
>   
> -	err = rxe_mr_do_atomic_write(mr, iova, value);
> +	if (mr->umem->is_odp)
> +		err = rxe_odp_do_atomic_write(mr, iova, value);
> +	else
> +		err = rxe_mr_do_atomic_write(mr, iova, value);
>   	if (err)
>   		return err;
>   
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index da07d3e2db1d..bfa1bff3c720 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -326,6 +326,7 @@ enum ib_odp_transport_cap_bits {
>   	IB_ODP_SUPPORT_ATOMIC	= 1 << 4,
>   	IB_ODP_SUPPORT_SRQ_RECV	= 1 << 5,
>   	IB_ODP_SUPPORT_FLUSH	= 1 << 6,
> +	IB_ODP_SUPPORT_ATOMIC_WRITE	= 1 << 7,
>   };
>   
>   struct ib_odp_caps {


