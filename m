Return-Path: <linux-rdma+bounces-9971-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8634AA9772
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 17:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9CD168386
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 15:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D732E25C809;
	Mon,  5 May 2025 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SG4YBXSN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5964725C6EA
	for <linux-rdma@vger.kernel.org>; Mon,  5 May 2025 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458736; cv=none; b=Pwuk/42/n2hCYbuiZRPSj9rLbKjyfFbWpxEWOGT4zt/xFcmnmEgNiX9IDm6X4Udu17j/D/3D0kMmppMqkLbnB0qhaym/GLt8a5ZYuwLAn96X0si9OW7VjFm1H+sE1TRj/d8th6KjmDEFmUYVVPTPOas9eRUon1JnNL8U3HBrb1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458736; c=relaxed/simple;
	bh=s+fPTgi+PnfcHm8KT9pxFAJyEcOpPBROHIKmCaeZRzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Dd2m6DFYgINBnAIr3zukYuV8apyNokvZy4ERffb/pGdGd3U/otb3/KfSVOVRgQ2P9PCr3jkAhhPGYniHUoq8otJAyLsEjxPQrTPZvv5Q+YuHMUpWjtR5cFRsIPfl0o7p2bguhuQXOg7QQ29GAmPcALQX6C90nGneSI9G7R51BlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SG4YBXSN; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dbc1bcdf-144d-44d2-8fc8-77bc2ad58b51@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746458730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Nqp0itdoqW9IkU14n7l4W+RXavOiRNHEeUpgqQ00TM=;
	b=SG4YBXSNXCYM2O5ykctPWYC11DrwHq3W8DTZZkiQDKAx/rFv/rGrbiU4XxeNhW2e/RTtWk
	B5I+PX9jUnePayFxers4wMXhzJwcaiteTzK9ka5X/RO2uduwqlVsAarnrImmDDNCWykTE1
	/RIeJrSyZBmrADF5JnT+b5C8Gv3RPDA=
Date: Mon, 5 May 2025 17:25:26 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v2 2/2] RDMA/rxe: Enable asynchronous prefetch
 for ODP MRs
To: Daisuke Matsuda <dskmtsd@gmail.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
 zyjzyj2000@gmail.com
References: <20250503134224.4867-1-dskmtsd@gmail.com>
 <20250503134224.4867-3-dskmtsd@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250503134224.4867-3-dskmtsd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 03.05.25 15:42, Daisuke Matsuda wrote:
> Calling ibv_advise_mr(3) with flags other than IBV_ADVISE_MR_FLAG_FLUSH
> invokes asynchronous requests. It is best-effort, and thus can safely be
> deferred to the system-wide workqueue.
> 
> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>

I have made tests with rdma-core after applying this patch series. It 
seems that it can work well.
I read through this commit. Other than the following minor problems, I 
am fine with this commit.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

> ---
>   drivers/infiniband/sw/rxe/rxe_odp.c | 81 ++++++++++++++++++++++++++++-
>   1 file changed, 80 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> index e5c60b061d7e..d98b385a18ce 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -425,6 +425,73 @@ enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
>   	return RESPST_NONE;
>   }
>   
> +struct prefetch_mr_work {
> +	struct work_struct work;
> +	u32 pf_flags;
> +	u32 num_sge;
> +	struct {
> +		u64 io_virt;
> +		struct rxe_mr *mr;
> +		size_t length;
> +	} frags[];
> +};

The struct prefetch_mr_work should be moved into header file? IMO, it is 
better to move this struct to rxe_loc.h?

> +
> +static void rxe_ib_prefetch_mr_work(struct work_struct *w)
> +{
> +	struct prefetch_mr_work *work =
> +		container_of(w, struct prefetch_mr_work, work);
> +	int ret;
> +	u32 i;
> +
> +	/* We rely on IB/core that work is executed if we have num_sge != 0 only. */
> +	WARN_ON(!work->num_sge);
> +	for (i = 0; i < work->num_sge; ++i) {
> +		struct ib_umem_odp *umem_odp;
> +
> +		ret = rxe_odp_do_pagefault_and_lock(work->frags[i].mr, work->frags[i].io_virt,
> +						    work->frags[i].length, work->pf_flags);
> +		if (ret < 0) {
> +			rxe_dbg_mr(work->frags[i].mr, "failed to prefetch the mr\n");
> +			continue;
> +		}
> +
> +		umem_odp = to_ib_umem_odp(work->frags[i].mr->umem);
> +		mutex_unlock(&umem_odp->umem_mutex);

Obviously this function is dependent on the mutex lock umem_mutex. So in 
the beginning of this function, it is better to  add 
lockdep_assert_held(&umem_odp->umem_mutex)?

Zhu Yanjun

> +	}
> +
> +	kvfree(work);
> +}
> +
> +static int rxe_init_prefetch_work(struct ib_pd *ibpd,
> +				  enum ib_uverbs_advise_mr_advice advice,
> +				  u32 pf_flags, struct prefetch_mr_work *work,
> +				  struct ib_sge *sg_list, u32 num_sge)
> +{
> +	struct rxe_pd *pd = container_of(ibpd, struct rxe_pd, ibpd);
> +	u32 i;
> +
> +	INIT_WORK(&work->work, rxe_ib_prefetch_mr_work);
> +	work->pf_flags = pf_flags;
> +
> +	for (i = 0; i < num_sge; ++i) {
> +		struct rxe_mr *mr;
> +
> +		mr = lookup_mr(pd, IB_ACCESS_LOCAL_WRITE,
> +			       sg_list[i].lkey, RXE_LOOKUP_LOCAL);
> +		if (IS_ERR(mr)) {
> +			work->num_sge = i;
> +			return PTR_ERR(mr);
> +		}
> +		work->frags[i].io_virt = sg_list[i].addr;
> +		work->frags[i].length = sg_list[i].length;
> +		work->frags[i].mr = mr;
> +
> +		rxe_put(mr);
> +	}
> +	work->num_sge = num_sge;
> +	return 0;
> +}
> +
>   static int rxe_ib_prefetch_sg_list(struct ib_pd *ibpd,
>   				   enum ib_uverbs_advise_mr_advice advice,
>   				   u32 pf_flags, struct ib_sge *sg_list,
> @@ -478,6 +545,8 @@ static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
>   				     u32 flags, struct ib_sge *sg_list, u32 num_sge)
>   {
>   	u32 pf_flags = RXE_PAGEFAULT_DEFAULT;
> +	struct prefetch_mr_work *work;
> +	int rc;
>   
>   	if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH)
>   		pf_flags |= RXE_PAGEFAULT_RDONLY;
> @@ -490,7 +559,17 @@ static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
>   		return rxe_ib_prefetch_sg_list(ibpd, advice, pf_flags, sg_list,
>   					       num_sge);
>   
> -	/* Asynchronous call is "best-effort" */
> +	/* Asynchronous call is "best-effort" and allowed to fail */
> +	work = kvzalloc(struct_size(work, frags, num_sge), GFP_KERNEL);
> +	if (!work)
> +		return -ENOMEM;
> +
> +	rc = rxe_init_prefetch_work(ibpd, advice, pf_flags, work, sg_list, num_sge);
> +	if (rc) {
> +		kvfree(work);
> +		return rc;
> +	}
> +	queue_work(system_unbound_wq, &work->work);
>   
>   	return 0;
>   }


