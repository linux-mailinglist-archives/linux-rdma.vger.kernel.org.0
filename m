Return-Path: <linux-rdma+bounces-4327-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EBF94EB6B
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 12:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01811F226ED
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 10:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EC9170822;
	Mon, 12 Aug 2024 10:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SAVDnvfz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7461DFFD
	for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2024 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723459551; cv=none; b=Kw2SZOwJuDFmx8aGZduIVY+MNQl+D6fhAIIvGAXVrhRNrcxOc1oR86YBvpq97EPbBwE3DAgJFye4jtSEGDtg98Lp2+GnighBWz8YvASyY2TFkr/yhXokEzfs6qrraehR+L1AD4dhPQ12AxTrunk0VIQYcEtxYTIcVvaZAzgDw0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723459551; c=relaxed/simple;
	bh=ntpVsl2RESctTRdN6anRat8qiP2jUaJ1UrKXbOfoUbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QuajUNkdleOEvzyEK8P64TeIcIBM50cQNYBYtgf0rpjgVlgLVo8zeTXFW8jhJQ5pCXCvXo/GqK59UebBnv4Hnj4fCeJEMwn1GjgUNxxrvsoiJocZSBqTsRiwpzRIm4p1JEAbub7sAhk8INJSs6L0O25IMz3EHlgeYxMQ667BFpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SAVDnvfz; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ec209630-97a9-490b-980f-570136f62f6a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723459546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oqA0mMO3Ng7PSKMt/EUPfK0QP4Rg9GEHujg7I/T8714=;
	b=SAVDnvfz29YVXz9/5lJ0zBOxLLc3AEBObld4eyt7sAfJNvOjOckmtSwfokqWPI9xs+K+wp
	DkDLd5Kkg1Y5lUmUeGny7Ex/axZyIaZsGye+J/8iNnWSb83LnZsSFuK8g53sMRy9/kiypr
	KFN8Di48aiai9+HvUNIKLH77NjzEJ1U=
Date: Mon, 12 Aug 2024 18:45:38 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next 2/4] RDMA/bnxt_re: Get the WQE index from slot
 index while completing the WQEs
To: Leon Romanovsky <leon@kernel.org>
Cc: Selvin Xavier <selvin.xavier@broadcom.com>, jgg@ziepe.ca,
 linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
 Hongguang Gao <hong``guang.gao@broadcom.com>
References: <1723317553-13002-1-git-send-email-selvin.xavier@broadcom.com>
 <1723317553-13002-3-git-send-email-selvin.xavier@broadcom.com>
 <bda30518-00cf-43eb-a463-e4b7ce7057d8@linux.dev>
 <20240812100818.GB12060@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240812100818.GB12060@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/8/12 18:08, Leon Romanovsky 写道:
> On Mon, Aug 12, 2024 at 04:48:44PM +0800, Zhu Yanjun wrote:
>> 在 2024/8/11 3:19, Selvin Xavier 写道:
>>> While reporting the completions, SQ Work Queue index is required to
>>> identify the WQE that generated the completions. In variable WQE mode,
>>> FW returns the slot index for Error completions. Driver need to walk
>>> through the shadow queue between the consumer index  and producer index
>>> and matches the slot index returned by FW. If a match is found, the next
>>> index of the shadow queue is the WQE index to be considered for remaining
>>> poll_cq loop.
>>>
>>> Signed-off-by: Hongguang Gao <hong``guang.gao@broadcom.com>
>>> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
>>> ---
>>>    drivers/infiniband/hw/bnxt_re/qplib_fp.c | 40 ++++++++++++++++++++++++++++++++
>>>    drivers/infiniband/hw/bnxt_re/qplib_fp.h | 10 ++++++++
>>>    2 files changed, 50 insertions(+)
>>>
>>> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
>>> index 0af09e7..b49f49c 100644
>>> --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
>>> +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
>>> @@ -2471,6 +2471,32 @@ static int do_wa9060(struct bnxt_qplib_qp *qp, struct bnxt_qplib_cq *cq,
>>>    	return rc;
>>>    }
>>> +static int bnxt_qplib_get_cqe_sq_cons(struct bnxt_qplib_q *sq, u32 cqe_slot)
>>> +{
>>> +	struct bnxt_qplib_hwq *sq_hwq;
>>> +	struct bnxt_qplib_swq *swq;
>>> +	int cqe_sq_cons = -1;
>>> +	u32 start, last;
>>> +
>>> +	sq_hwq = &sq->hwq;
>>> +
>>> +	start = sq->swq_start;
>>> +	last = sq->swq_last;
>>> +
>>> +	while (last != start) {
>>> +		swq = &sq->swq[last];
>>> +		if (swq->slot_idx  == cqe_slot) {
>>> +			cqe_sq_cons = swq->next_idx;
>>> +			dev_err(&sq_hwq->pdev->dev, "%s: Found cons wqe = %d slot = %d\n",
>>> +				__func__, cqe_sq_cons, cqe_slot);
>>> +			break;
>>> +		}
>>> +
>>> +		last = swq->next_idx;
>>> +	}
>>> +	return cqe_sq_cons;
>>> +}
>>> +
>>>    static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
>>>    				     struct cq_req *hwcqe,
>>>    				     struct bnxt_qplib_cqe **pcqe, int *budget,
>>> @@ -2481,6 +2507,7 @@ static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
>>>    	struct bnxt_qplib_qp *qp;
>>>    	struct bnxt_qplib_q *sq;
>>>    	u32 cqe_sq_cons;
>>> +	int cqe_cons;
>>>    	int rc = 0;
>>>    	qp = (struct bnxt_qplib_qp *)((unsigned long)
>>> @@ -2498,6 +2525,19 @@ static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
>>>    			"%s: QP in Flush QP = %p\n", __func__, qp);
>>>    		goto done;
>>>    	}
>>> +
>>> +	if (__is_err_cqe_for_var_wqe(qp, hwcqe->status)) {
>>> +		cqe_cons = bnxt_qplib_get_cqe_sq_cons(sq, hwcqe->sq_cons_idx);
>>> +		if (cqe_cons < 0) {
>>> +			dev_err(&cq->hwq.pdev->dev, "%s: Wrong SQ cons cqe_slot_indx = %d\n",
>>> +				__func__, hwcqe->sq_cons_idx);
>>> +			goto done;
>>> +		}
>>> +		cqe_sq_cons = cqe_cons;
>>> +		dev_err(&cq->hwq.pdev->dev, "%s: cqe_sq_cons = %d swq_last = %d swq_start = %d\n",
>>> +			__func__, cqe_sq_cons, sq->swq_last, sq->swq_start);
>>> +	}
>>> +
>>>    	/* Require to walk the sq's swq to fabricate CQEs for all previously
>>>    	 * signaled SWQEs due to CQE aggregation from the current sq cons
>>>    	 * to the cqe_sq_cons
>>> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
>>> index f54d7a0..2e7a4fd 100644
>>> --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
>>> +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
>>> @@ -649,4 +649,14 @@ static inline __le64 bnxt_re_update_msn_tbl(u32 st_idx, u32 npsn, u32 start_psn)
>>>    		(((start_psn) << SQ_MSN_SEARCH_START_PSN_SFT) &
>>>    		SQ_MSN_SEARCH_START_PSN_MASK));
>>>    }
>>> +
>>> +static inline bool __is_var_wqe(struct bnxt_qplib_qp *qp)
>> IIRC, inline is not needed here. The compiler will determine if the function
>> inline is needed or not.
> Selvin added inline functions to *.h file and not to *.c file.

Yeah. I mistook that these 2 functions were in *.c file.

Thanks.

Zhu Yanjun

>
> Thanks
>
>> It is a trivial problem.
>>
>> Zhu Yanjun
>>
>>> +{
>>> +	return (qp->wqe_mode == BNXT_QPLIB_WQE_MODE_VARIABLE);
>>> +}
>>> +
>>> +static inline bool __is_err_cqe_for_var_wqe(struct bnxt_qplib_qp *qp, u8 status)
>> ditto.
>>
>>> +{
>>> +	return (status != CQ_REQ_STATUS_OK) && __is_var_wqe(qp);
>>> +}
>>>    #endif /* __BNXT_QPLIB_FP_H__ */

-- 
Best Regards,
Yanjun.Zhu


