Return-Path: <linux-rdma+bounces-4323-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5C394EA7F
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 12:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1EA61F22919
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 10:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA6616EB5D;
	Mon, 12 Aug 2024 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6Mh+PLD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E8F1876
	for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2024 10:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723457303; cv=none; b=M3NBeTh6g3hUB9Rei4Z+KwT0AKIX5ylSkjUAUuREk9MSIaajtpmQXy14+/U6+kNwTLDLetShBTKWBjwhga65zgdHLMNY0gFdJmLRiSOz6VNLqqpzhLcbUctRKuvZX6+tHCtJMap/ARCVoLtlHMczVMMpi6r59MA89FsXaPJ1FpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723457303; c=relaxed/simple;
	bh=FMeH+HcGZjJuyHtgdsO9Y9Nm+Gdzw/uvmKVVp7kNXXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJvmyJZ8/qnUe0gzXf8vDw2NMsqpFbjcww4ge0huLwCS306pEiU0x9UJEzIFK7V6Tn3gEyGxb0Zh9yC/LiYhgfmidqh00GKNbiNM9UmGsFU7Sv3ahe7UVhzONYDXkeR/EaUwOpMGT4JuXzu66XHBSqTTNB+ty0ZEk3VrCbcaQpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6Mh+PLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8BEC32782;
	Mon, 12 Aug 2024 10:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723457302;
	bh=FMeH+HcGZjJuyHtgdsO9Y9Nm+Gdzw/uvmKVVp7kNXXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e6Mh+PLDrblYx8RqLxC4N3ptXqu9I2RZY9nJ2Tu8QhHTiItB7VOrBdDKWZg3HMOye
	 daMew92wrfD9YZpVO7AyfTrBV97BRz+RNdzABZ/T7O+7nwaHq5qVMO28FNYPs1I3g5
	 RGeVlK42gbx5e32IbPXpwHDame9AVSPsskULm5CYrvqSxVyL/HX01NNm7LLE5z/MCe
	 wSxSbiLmGhxoC7msMoGYaUfRN8lzv+XPaOUxYi0YrBGPNrTRS2F9myJSgn+4hWaB7N
	 Nc+jUsxbPY5B5uRiUfZkfXUEWW2SO3lbx+QYJGSnZSVwXWuxA8CKkDtZEv17UaiAr7
	 8xlRkpWCoQgFA==
Date: Mon, 12 Aug 2024 13:08:18 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Selvin Xavier <selvin.xavier@broadcom.com>, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
	Hongguang Gao <hong``guang.gao@broadcom.com>
Subject: Re: [PATCH for-next 2/4] RDMA/bnxt_re: Get the WQE index from slot
 index while completing the WQEs
Message-ID: <20240812100818.GB12060@unreal>
References: <1723317553-13002-1-git-send-email-selvin.xavier@broadcom.com>
 <1723317553-13002-3-git-send-email-selvin.xavier@broadcom.com>
 <bda30518-00cf-43eb-a463-e4b7ce7057d8@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bda30518-00cf-43eb-a463-e4b7ce7057d8@linux.dev>

On Mon, Aug 12, 2024 at 04:48:44PM +0800, Zhu Yanjun wrote:
> 在 2024/8/11 3:19, Selvin Xavier 写道:
> > While reporting the completions, SQ Work Queue index is required to
> > identify the WQE that generated the completions. In variable WQE mode,
> > FW returns the slot index for Error completions. Driver need to walk
> > through the shadow queue between the consumer index  and producer index
> > and matches the slot index returned by FW. If a match is found, the next
> > index of the shadow queue is the WQE index to be considered for remaining
> > poll_cq loop.
> > 
> > Signed-off-by: Hongguang Gao <hong``guang.gao@broadcom.com>
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >   drivers/infiniband/hw/bnxt_re/qplib_fp.c | 40 ++++++++++++++++++++++++++++++++
> >   drivers/infiniband/hw/bnxt_re/qplib_fp.h | 10 ++++++++
> >   2 files changed, 50 insertions(+)
> > 
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> > index 0af09e7..b49f49c 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> > @@ -2471,6 +2471,32 @@ static int do_wa9060(struct bnxt_qplib_qp *qp, struct bnxt_qplib_cq *cq,
> >   	return rc;
> >   }
> > +static int bnxt_qplib_get_cqe_sq_cons(struct bnxt_qplib_q *sq, u32 cqe_slot)
> > +{
> > +	struct bnxt_qplib_hwq *sq_hwq;
> > +	struct bnxt_qplib_swq *swq;
> > +	int cqe_sq_cons = -1;
> > +	u32 start, last;
> > +
> > +	sq_hwq = &sq->hwq;
> > +
> > +	start = sq->swq_start;
> > +	last = sq->swq_last;
> > +
> > +	while (last != start) {
> > +		swq = &sq->swq[last];
> > +		if (swq->slot_idx  == cqe_slot) {
> > +			cqe_sq_cons = swq->next_idx;
> > +			dev_err(&sq_hwq->pdev->dev, "%s: Found cons wqe = %d slot = %d\n",
> > +				__func__, cqe_sq_cons, cqe_slot);
> > +			break;
> > +		}
> > +
> > +		last = swq->next_idx;
> > +	}
> > +	return cqe_sq_cons;
> > +}
> > +
> >   static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
> >   				     struct cq_req *hwcqe,
> >   				     struct bnxt_qplib_cqe **pcqe, int *budget,
> > @@ -2481,6 +2507,7 @@ static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
> >   	struct bnxt_qplib_qp *qp;
> >   	struct bnxt_qplib_q *sq;
> >   	u32 cqe_sq_cons;
> > +	int cqe_cons;
> >   	int rc = 0;
> >   	qp = (struct bnxt_qplib_qp *)((unsigned long)
> > @@ -2498,6 +2525,19 @@ static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
> >   			"%s: QP in Flush QP = %p\n", __func__, qp);
> >   		goto done;
> >   	}
> > +
> > +	if (__is_err_cqe_for_var_wqe(qp, hwcqe->status)) {
> > +		cqe_cons = bnxt_qplib_get_cqe_sq_cons(sq, hwcqe->sq_cons_idx);
> > +		if (cqe_cons < 0) {
> > +			dev_err(&cq->hwq.pdev->dev, "%s: Wrong SQ cons cqe_slot_indx = %d\n",
> > +				__func__, hwcqe->sq_cons_idx);
> > +			goto done;
> > +		}
> > +		cqe_sq_cons = cqe_cons;
> > +		dev_err(&cq->hwq.pdev->dev, "%s: cqe_sq_cons = %d swq_last = %d swq_start = %d\n",
> > +			__func__, cqe_sq_cons, sq->swq_last, sq->swq_start);
> > +	}
> > +
> >   	/* Require to walk the sq's swq to fabricate CQEs for all previously
> >   	 * signaled SWQEs due to CQE aggregation from the current sq cons
> >   	 * to the cqe_sq_cons
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> > index f54d7a0..2e7a4fd 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> > @@ -649,4 +649,14 @@ static inline __le64 bnxt_re_update_msn_tbl(u32 st_idx, u32 npsn, u32 start_psn)
> >   		(((start_psn) << SQ_MSN_SEARCH_START_PSN_SFT) &
> >   		SQ_MSN_SEARCH_START_PSN_MASK));
> >   }
> > +
> > +static inline bool __is_var_wqe(struct bnxt_qplib_qp *qp)
> 
> IIRC, inline is not needed here. The compiler will determine if the function
> inline is needed or not.

Selvin added inline functions to *.h file and not to *.c file.

Thanks

> 
> It is a trivial problem.
> 
> Zhu Yanjun
> 
> > +{
> > +	return (qp->wqe_mode == BNXT_QPLIB_WQE_MODE_VARIABLE);
> > +}
> > +
> > +static inline bool __is_err_cqe_for_var_wqe(struct bnxt_qplib_qp *qp, u8 status)
> 
> ditto.
> 
> > +{
> > +	return (status != CQ_REQ_STATUS_OK) && __is_var_wqe(qp);
> > +}
> >   #endif /* __BNXT_QPLIB_FP_H__ */
> 

