Return-Path: <linux-rdma+bounces-1735-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A69818952F6
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 14:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5888C284517
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 12:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018C477F15;
	Tue,  2 Apr 2024 12:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKyF8MC9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24116E602
	for <linux-rdma@vger.kernel.org>; Tue,  2 Apr 2024 12:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061001; cv=none; b=Js9tln2PEq9T0JHI9q8c7Luhps+F+Hn0i+wOQj6XHXDNspVsUIQ8tpaqQnsFCiuZ5+3PhkzluSNjoTsx+O/9zqA0xKRTkCmy97OZDi2SwpQzcDUXieCORticydvW+Y05Z1Z3xhEjyVqmtg7JVGDRsPFy5ckryaPXJsc4fjscjAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061001; c=relaxed/simple;
	bh=fq7aIpqYHaDwFzNo2Ioze5LU4oc4pSU15SxSLnrQ2Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1jorCGDqJhxMKlfRBT7GE48qJO9E78lWxN+TSqFoCh0T9mi4dAeSGBbQKJqeRCIR81JMnTLCf/NYT0kw0LslEFwcSniQ0HRdBuPB0hVXh50KbntrYNUUc8FBl5YuGyxueUwLQliAj7jt2+H4cAvJv+BJbHT6yckTN/8QjtB7Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKyF8MC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC3BC433C7;
	Tue,  2 Apr 2024 12:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712061001;
	bh=fq7aIpqYHaDwFzNo2Ioze5LU4oc4pSU15SxSLnrQ2Dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jKyF8MC9OLr80Qg0WfNYfVl+p9TPBYbpWT3g5f7bdzUtVyY7XKwFB+m9dwf5Alt2G
	 eHT6VQYOjs6jC8/HG7BVmhKA9jZ/lrAl8eAF9So3WpmGNrfL0H4Een5yYguQv+cLBK
	 Iv5GvG1G8CN558oAUFedIbcUuiUtVSo0QfHTdOe6jeAznJG6orW7VlLt3UD4fvb4YJ
	 X/Jui3M2lUl7cmeZ3RL6ErXYuyUXIzCFC0xTgFZeEnTlR5l+MH4mFlrxk9CIMtvOVQ
	 wyMFyt6XjdAoHW2sayVE2Q1Fd8FhqfHby9pMJiz4p8v1ri+/d7sSkBVtLN9mrslp8x
	 1pi2PTZQ/gQrw==
Date: Tue, 2 Apr 2024 15:29:56 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Bob Pearson <rpearsonhpe@gmail.com>
Cc: yanjun.zhu@linux.dev, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	jhack@hpe.com
Subject: Re: [PATCH for-next 07/11] RDMA/rxe: Don't call rxe_requester from
 rxe_completer
Message-ID: <20240402122956.GH11187@unreal>
References: <20240326174325.300849-2-rpearsonhpe@gmail.com>
 <20240326174325.300849-9-rpearsonhpe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326174325.300849-9-rpearsonhpe@gmail.com>

On Tue, Mar 26, 2024 at 12:43:22PM -0500, Bob Pearson wrote:
> Instead of rescheduling rxe_requester from rxe_completer() just extend
> the duration of rxe_sender() by one pass. Setting run_requester_again
> forces rxe_completer() to return 0 which will cause rxe_sender() to be
> called at least one more time.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_comp.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
> index ea64a25fe876..c41743fbd5f1 100644
> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
> @@ -82,6 +82,8 @@ static unsigned long rnrnak_usec[32] = {
>  	[IB_RNR_TIMER_491_52] = 491520,
>  };
>  
> +static int run_requester_again;

Is it safe to write, read and rely on value from this global variable without any locking?

Thanks

> +
>  static inline unsigned long rnrnak_jiffies(u8 timeout)
>  {
>  	return max_t(unsigned long,
> @@ -325,7 +327,7 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
>  					qp->comp.psn = pkt->psn;
>  					if (qp->req.wait_psn) {
>  						qp->req.wait_psn = 0;
> -						rxe_sched_task(&qp->send_task);
> +						run_requester_again = 1;
>  					}
>  				}
>  				return COMPST_ERROR_RETRY;
> @@ -476,7 +478,7 @@ static void do_complete(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
>  	 */
>  	if (qp->req.wait_fence) {
>  		qp->req.wait_fence = 0;
> -		rxe_sched_task(&qp->send_task);
> +		run_requester_again = 1;
>  	}
>  }
>  
> @@ -515,7 +517,7 @@ static inline enum comp_state complete_ack(struct rxe_qp *qp,
>  		if (qp->req.need_rd_atomic) {
>  			qp->comp.timeout_retry = 0;
>  			qp->req.need_rd_atomic = 0;
> -			rxe_sched_task(&qp->send_task);
> +			run_requester_again = 1;
>  		}
>  	}
>  
> @@ -541,7 +543,7 @@ static inline enum comp_state complete_wqe(struct rxe_qp *qp,
>  
>  		if (qp->req.wait_psn) {
>  			qp->req.wait_psn = 0;
> -			rxe_sched_task(&qp->send_task);
> +			run_requester_again = 1;
>  		}
>  	}
>  
> @@ -654,6 +656,8 @@ int rxe_completer(struct rxe_qp *qp)
>  	int ret;
>  	unsigned long flags;
>  
> +	run_requester_again = 0;
> +
>  	spin_lock_irqsave(&qp->state_lock, flags);
>  	if (!qp->valid || qp_state(qp) == IB_QPS_ERR ||
>  			  qp_state(qp) == IB_QPS_RESET) {
> @@ -737,7 +741,7 @@ int rxe_completer(struct rxe_qp *qp)
>  
>  			if (qp->req.wait_psn) {
>  				qp->req.wait_psn = 0;
> -				rxe_sched_task(&qp->send_task);
> +				run_requester_again = 1;
>  			}
>  
>  			state = COMPST_DONE;
> @@ -792,7 +796,7 @@ int rxe_completer(struct rxe_qp *qp)
>  							RXE_CNT_COMP_RETRY);
>  					qp->req.need_retry = 1;
>  					qp->comp.started_retry = 1;
> -					rxe_sched_task(&qp->send_task);
> +					run_requester_again = 1;
>  				}
>  				goto done;
>  
> @@ -843,8 +847,9 @@ int rxe_completer(struct rxe_qp *qp)
>  	ret = 0;
>  	goto out;
>  exit:
> -	ret = -EAGAIN;
> +	ret = (run_requester_again) ? 0 : -EAGAIN;
>  out:
> +	run_requester_again = 0;
>  	if (pkt)
>  		free_pkt(pkt);
>  	return ret;
> -- 
> 2.43.0
> 

