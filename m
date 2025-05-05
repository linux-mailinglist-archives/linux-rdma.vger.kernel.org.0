Return-Path: <linux-rdma+bounces-9969-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1543FAA8DB4
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 09:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661033A3DE6
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 07:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4391DED4A;
	Mon,  5 May 2025 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="whFYwnxF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6E91B424A
	for <linux-rdma@vger.kernel.org>; Mon,  5 May 2025 07:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746431885; cv=none; b=rCnPIl4QLsC/hOG/FdHmAfZ6qErYePmtpUegZ8TmQ8BMm3bnL275+mej696VN5tq2FTTR9Lp8l6BlwVE/PwNAUn1RxKitVbq92Ac+BJVJ7hDBjPXWpQBUJiPYvIY1xmWkrYRkwSxjhv8ERWwvNWZfHk3Cg16umHTBRxr/w8V8P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746431885; c=relaxed/simple;
	bh=BC6yh8feRGe0HTksMyAzP0kruepYkQ9pZ5Zi+hcEdjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BC3e+ciaDqLSy1BQR1J2lJBv3hXjDePRxJp3k5HQ8T01/A9F/9qYsFym1lGICQsIO4lQZ7wdOii/MIzA+BkLYKLuhvgA6CIEnVfl+ohVhhfu3URWqONoUTLPlSh7hvJ/mjpj//QKU+MFUyrbKGkKGgPXYMLyX0ZvUCF3CYhicwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=whFYwnxF; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2e3676d3-ce82-4a87-be33-9ce6d7007c3b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746431878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zRjj2CDxRbfCsULDTH03+1VRA4nDtCwu722TDI87JmA=;
	b=whFYwnxFDF2dTnR+DMchcijZ0Qcz/KACdj8p75esEhxcumw0Wkk5Ca8UZKtM1gc5eoWzPp
	7SpEZ3TT1eEPMOt7vZlxCNFmI0cf6+Bp7/pNi4rt6XsQUD8o5R/3NtajzPV36aGs9aKJ1s
	eNoreJe2q+l6wK6CjOCn7VjkiGdw8nU=
Date: Mon, 5 May 2025 09:57:56 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v2 1/2] RDMA/rxe: Implement synchronous prefetch
 for ODP MRs
To: Daisuke Matsuda <dskmtsd@gmail.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
 zyjzyj2000@gmail.com
References: <20250503134224.4867-1-dskmtsd@gmail.com>
 <20250503134224.4867-2-dskmtsd@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250503134224.4867-2-dskmtsd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 03.05.25 15:42, Daisuke Matsuda wrote:
> Minimal implementation of ibv_advise_mr(3) requires synchronous calls being
> successful with the IBV_ADVISE_MR_FLAG_FLUSH flag. Asynchronous requests,
> which are best-effort, will be added subsequently.
> 
> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
> ---
>   drivers/infiniband/sw/rxe/rxe.c     |  7 +++
>   drivers/infiniband/sw/rxe/rxe_loc.h | 10 ++++
>   drivers/infiniband/sw/rxe/rxe_odp.c | 86 +++++++++++++++++++++++++++++
>   3 files changed, 103 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index 3a77d6db1720..e891199cbdef 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -34,6 +34,10 @@ void rxe_dealloc(struct ib_device *ib_dev)
>   	mutex_destroy(&rxe->usdev_lock);
>   }
>   
> +static const struct ib_device_ops rxe_ib_dev_odp_ops = {
> +	.advise_mr = rxe_ib_advise_mr,
> +};
> +
>   /* initialize rxe device parameters */
>   static void rxe_init_device_param(struct rxe_dev *rxe, struct net_device *ndev)
>   {
> @@ -103,6 +107,9 @@ static void rxe_init_device_param(struct rxe_dev *rxe, struct net_device *ndev)
>   		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_SRQ_RECV;
>   		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_FLUSH;
>   		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_ATOMIC_WRITE;
> +
> +		/* set handler for ODP prefetching API - ibv_advise_mr(3) */
> +		ib_set_device_ops(&rxe->ib_dev, &rxe_ib_dev_odp_ops);
>   	}
>   }
>   
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index f7dbb9cddd12..21b070f3dbb8 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -197,6 +197,9 @@ enum resp_states rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
>   int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
>   			    unsigned int length);
>   enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value);
> +int rxe_ib_advise_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
> +		     u32 flags, struct ib_sge *sg_list, u32 num_sge,
> +		     struct uverbs_attr_bundle *attrs);
>   #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
>   static inline int
>   rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
> @@ -225,6 +228,13 @@ static inline enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr,
>   {
>   	return RESPST_ERR_UNSUPPORTED_OPCODE;
>   }
> +static inline int rxe_ib_advise_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
> +				   u32 flags, struct ib_sge *sg_list, u32 num_sge,
> +				   struct uverbs_attr_bundle *attrs)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>   #endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
>   
>   #endif /* RXE_LOC_H */
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> index 6149d9ffe7f7..e5c60b061d7e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -424,3 +424,89 @@ enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
>   
>   	return RESPST_NONE;
>   }
> +
> +static int rxe_ib_prefetch_sg_list(struct ib_pd *ibpd,
> +				   enum ib_uverbs_advise_mr_advice advice,
> +				   u32 pf_flags, struct ib_sge *sg_list,
> +				   u32 num_sge)
> +{
> +	struct rxe_pd *pd = container_of(ibpd, struct rxe_pd, ibpd);
> +	unsigned int i;
> +	int ret = 0;
> +
> +	for (i = 0; i < num_sge; ++i) {

i is unsigned int, num_sge is u32. Perhaps they all use u32 type?
It is a minor problem.
Other than that, I am fine with this commit.

I have made tests with rdma-core. Both the synchronous and asynchrounos 
modes can work well.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> +		struct rxe_mr *mr;
> +		struct ib_umem_odp *umem_odp;
> +
> +		mr = lookup_mr(pd, IB_ACCESS_LOCAL_WRITE,
> +			       sg_list[i].lkey, RXE_LOOKUP_LOCAL);
> +
> +		if (IS_ERR(mr)) {
> +			rxe_dbg_pd(pd, "mr with lkey %x not found\n", sg_list[i].lkey);
> +			return PTR_ERR(mr);
> +		}
> +
> +		if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE &&
> +		    !mr->umem->writable) {
> +			rxe_dbg_mr(mr, "missing write permission\n");
> +			rxe_put(mr);
> +			return -EPERM;
> +		}
> +
> +		ret = rxe_odp_do_pagefault_and_lock(mr, sg_list[i].addr,
> +						    sg_list[i].length, pf_flags);
> +		if (ret < 0) {
> +			if (sg_list[i].length == 0)
> +				continue;
> +
> +			rxe_dbg_mr(mr, "failed to prefetch the mr\n");
> +			rxe_put(mr);
> +			return ret;
> +		}
> +
> +		umem_odp = to_ib_umem_odp(mr->umem);
> +		mutex_unlock(&umem_odp->umem_mutex);
> +
> +		rxe_put(mr);
> +	}
> +
> +	return 0;
> +}
> +
> +static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
> +				     enum ib_uverbs_advise_mr_advice advice,
> +				     u32 flags, struct ib_sge *sg_list, u32 num_sge)
> +{
> +	u32 pf_flags = RXE_PAGEFAULT_DEFAULT;
> +
> +	if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH)
> +		pf_flags |= RXE_PAGEFAULT_RDONLY;
> +
> +	if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_NO_FAULT)
> +		pf_flags |= RXE_PAGEFAULT_SNAPSHOT;
> +
> +	/* Synchronous call */
> +	if (flags & IB_UVERBS_ADVISE_MR_FLAG_FLUSH)
> +		return rxe_ib_prefetch_sg_list(ibpd, advice, pf_flags, sg_list,
> +					       num_sge);
> +
> +	/* Asynchronous call is "best-effort" */
> +
> +	return 0;
> +}
> +
> +int rxe_ib_advise_mr(struct ib_pd *ibpd,
> +		     enum ib_uverbs_advise_mr_advice advice,
> +		     u32 flags,
> +		     struct ib_sge *sg_list,
> +		     u32 num_sge,
> +		     struct uverbs_attr_bundle *attrs)
> +{
> +	if (advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH &&
> +	    advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE &&
> +	    advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_NO_FAULT)
> +		return -EOPNOTSUPP;
> +
> +	return rxe_ib_advise_mr_prefetch(ibpd, advice, flags,
> +					 sg_list, num_sge);
> +}


