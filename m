Return-Path: <linux-rdma+bounces-4321-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B57F94E8D5
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 10:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E88C1C2166B
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 08:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC6C16BE25;
	Mon, 12 Aug 2024 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bsulJrki"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E509914EC40
	for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2024 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723452545; cv=none; b=jXSYt+HXCfZ6F/p5HoB0TEbLiiwOC4qeAe1K4mKjTvADEuZ2VHUCzomew+ddNuVso1RMQb9tQqa/SlE6EPSzlCOFg7ZaJTrxhuc6gTdKJU3Y3gl/BNgS+hJbN5ezbjA2HuSpQWA+BRJ9962s6+Kk1tM00MiovLVKUPGDBdjTn94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723452545; c=relaxed/simple;
	bh=8nRkFtYQ62v9Kyg+Pj9tFmEj93oFFyOU7HjGnKDdP2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IRqoY2ZTlUyvRmS+zWpYwL+7rlR/Qy/7Kw2V64fVuV84mGkeD/qeuAk2lQei3k8erXm8z8qht/vE9H7R+EAJ0avK/RTXmchBf5LX10m8d7tPGtVEbHvDQQNpPl2IrUaalVRyiUJMB+MVlkIojioGNmzh1Lt3XTxai5T8/IOrttU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bsulJrki; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bda30518-00cf-43eb-a463-e4b7ce7057d8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723452537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=afq4+OOsCy0yYtUyuU+tcorAiPD7f7+9cNfbNj2S4Ks=;
	b=bsulJrkintiZKeosPIaxtaZOoFTReQ8ZEUTJ+jyEtFKVvlxlflKAD+EzAEK8RuM9+5NEC2
	Fg6kliKjiTAq/rWR/tg3i16oYgYhiPZSLvgsyRSLmwXpvfSvyGRhY2D+67Unx4jr0nJ9Su
	Bic0+2UAZZ0f9pLspB4yxB9pR2D9hA0=
Date: Mon, 12 Aug 2024 16:48:44 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next 2/4] RDMA/bnxt_re: Get the WQE index from slot
 index while completing the WQEs
To: Selvin Xavier <selvin.xavier@broadcom.com>, leon@kernel.org, jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
 Hongguang Gao <hong``guang.gao@broadcom.com>
References: <1723317553-13002-1-git-send-email-selvin.xavier@broadcom.com>
 <1723317553-13002-3-git-send-email-selvin.xavier@broadcom.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1723317553-13002-3-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/8/11 3:19, Selvin Xavier 写道:
> While reporting the completions, SQ Work Queue index is required to
> identify the WQE that generated the completions. In variable WQE mode,
> FW returns the slot index for Error completions. Driver need to walk
> through the shadow queue between the consumer index  and producer index
> and matches the slot index returned by FW. If a match is found, the next
> index of the shadow queue is the WQE index to be considered for remaining
> poll_cq loop.
> 
> Signed-off-by: Hongguang Gao <hong``guang.gao@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>   drivers/infiniband/hw/bnxt_re/qplib_fp.c | 40 ++++++++++++++++++++++++++++++++
>   drivers/infiniband/hw/bnxt_re/qplib_fp.h | 10 ++++++++
>   2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> index 0af09e7..b49f49c 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> @@ -2471,6 +2471,32 @@ static int do_wa9060(struct bnxt_qplib_qp *qp, struct bnxt_qplib_cq *cq,
>   	return rc;
>   }
>   
> +static int bnxt_qplib_get_cqe_sq_cons(struct bnxt_qplib_q *sq, u32 cqe_slot)
> +{
> +	struct bnxt_qplib_hwq *sq_hwq;
> +	struct bnxt_qplib_swq *swq;
> +	int cqe_sq_cons = -1;
> +	u32 start, last;
> +
> +	sq_hwq = &sq->hwq;
> +
> +	start = sq->swq_start;
> +	last = sq->swq_last;
> +
> +	while (last != start) {
> +		swq = &sq->swq[last];
> +		if (swq->slot_idx  == cqe_slot) {
> +			cqe_sq_cons = swq->next_idx;
> +			dev_err(&sq_hwq->pdev->dev, "%s: Found cons wqe = %d slot = %d\n",
> +				__func__, cqe_sq_cons, cqe_slot);
> +			break;
> +		}
> +
> +		last = swq->next_idx;
> +	}
> +	return cqe_sq_cons;
> +}
> +
>   static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
>   				     struct cq_req *hwcqe,
>   				     struct bnxt_qplib_cqe **pcqe, int *budget,
> @@ -2481,6 +2507,7 @@ static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
>   	struct bnxt_qplib_qp *qp;
>   	struct bnxt_qplib_q *sq;
>   	u32 cqe_sq_cons;
> +	int cqe_cons;
>   	int rc = 0;
>   
>   	qp = (struct bnxt_qplib_qp *)((unsigned long)
> @@ -2498,6 +2525,19 @@ static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
>   			"%s: QP in Flush QP = %p\n", __func__, qp);
>   		goto done;
>   	}
> +
> +	if (__is_err_cqe_for_var_wqe(qp, hwcqe->status)) {
> +		cqe_cons = bnxt_qplib_get_cqe_sq_cons(sq, hwcqe->sq_cons_idx);
> +		if (cqe_cons < 0) {
> +			dev_err(&cq->hwq.pdev->dev, "%s: Wrong SQ cons cqe_slot_indx = %d\n",
> +				__func__, hwcqe->sq_cons_idx);
> +			goto done;
> +		}
> +		cqe_sq_cons = cqe_cons;
> +		dev_err(&cq->hwq.pdev->dev, "%s: cqe_sq_cons = %d swq_last = %d swq_start = %d\n",
> +			__func__, cqe_sq_cons, sq->swq_last, sq->swq_start);
> +	}
> +
>   	/* Require to walk the sq's swq to fabricate CQEs for all previously
>   	 * signaled SWQEs due to CQE aggregation from the current sq cons
>   	 * to the cqe_sq_cons
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> index f54d7a0..2e7a4fd 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> @@ -649,4 +649,14 @@ static inline __le64 bnxt_re_update_msn_tbl(u32 st_idx, u32 npsn, u32 start_psn)
>   		(((start_psn) << SQ_MSN_SEARCH_START_PSN_SFT) &
>   		SQ_MSN_SEARCH_START_PSN_MASK));
>   }
> +
> +static inline bool __is_var_wqe(struct bnxt_qplib_qp *qp)

IIRC, inline is not needed here. The compiler will determine if the 
function inline is needed or not.

It is a trivial problem.

Zhu Yanjun

> +{
> +	return (qp->wqe_mode == BNXT_QPLIB_WQE_MODE_VARIABLE);
> +}
> +
> +static inline bool __is_err_cqe_for_var_wqe(struct bnxt_qplib_qp *qp, u8 status)

ditto.

> +{
> +	return (status != CQ_REQ_STATUS_OK) && __is_var_wqe(qp);
> +}
>   #endif /* __BNXT_QPLIB_FP_H__ */


