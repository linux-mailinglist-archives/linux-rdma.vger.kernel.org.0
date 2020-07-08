Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5598217F27
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2020 07:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgGHFjE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jul 2020 01:39:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgGHFjE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Jul 2020 01:39:04 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D1112078B;
        Wed,  8 Jul 2020 05:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594186743;
        bh=ctupYvPMbJ0opz75EH8OzMF0/JaVooxAvz7EyylMh9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zd1Dj7Hy4dP8fANXLMXUgKEODEit9nI3bGQNAqsB/aTc9AL5naLP63dSr7sjwiCDK
         rYFtmCne2SO6fmxlur0dSfvZwyYVp9Y+LitnSZdOVyFaZTy28TpJs0VwD43rDgVCit
         pUisKaa6ea1XI7pf1SCIrNw2Xh2ZU3seiHnQwF6g=
Date:   Wed, 8 Jul 2020 08:39:00 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yuval Basson <ybason@marvell.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>
Subject: Re: [PATCH v2 rdma-next] RDMA/qedr: SRQ's bug fixes
Message-ID: <20200708053900.GQ207186@unreal>
References: <20200707171847.29352-1-ybason@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707171847.29352-1-ybason@marvell.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 07, 2020 at 08:18:47PM +0300, Yuval Basson wrote:
> QP's with the same SRQ, working on different CQs and running in parallel
> on different CPUs could lead to a race when maintaining the SRQ consumer
> count, and leads to FW running out of SRQs. Update the consumer atomically.
> Make sure the wqe_prod is updated after the sge_prod due to FW
> requirements.
>
> Fixes: 3491c9e799fb9 ("RDMA/qedr: Add support for kernel mode SRQ's")
> Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
> Signed-off-by: Yuval Basson <ybason@marvell.com>
>
> Changes in v2:

"Changes ..." should come after "---".

Thanks

>  Replace barrier() with dma_wmb()
>  Remove redundant dma_wmb()
> ---
>  drivers/infiniband/hw/qedr/qedr.h  |  4 ++--
>  drivers/infiniband/hw/qedr/verbs.c | 23 +++++++++++------------
>  2 files changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/infiniband/hw/qedr/qedr.h b/drivers/infiniband/hw/qedr/qedr.h
> index fdf90ec..aa33202 100644
> --- a/drivers/infiniband/hw/qedr/qedr.h
> +++ b/drivers/infiniband/hw/qedr/qedr.h
> @@ -344,10 +344,10 @@ struct qedr_srq_hwq_info {
>  	u32 wqe_prod;
>  	u32 sge_prod;
>  	u32 wr_prod_cnt;
> -	u32 wr_cons_cnt;
> +	atomic_t wr_cons_cnt;
>  	u32 num_elems;
>
> -	u32 *virt_prod_pair_addr;
> +	struct rdma_srq_producers *virt_prod_pair_addr;
>  	dma_addr_t phy_prod_pair_addr;
>  };
>
> diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
> index 9b9e802..444537b 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -1510,6 +1510,7 @@ int qedr_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init_attr,
>  	srq->dev = dev;
>  	hw_srq = &srq->hw_srq;
>  	spin_lock_init(&srq->lock);
> +	atomic_set(&hw_srq->wr_cons_cnt, 0);
>
>  	hw_srq->max_wr = init_attr->attr.max_wr;
>  	hw_srq->max_sges = init_attr->attr.max_sge;
> @@ -3686,7 +3687,7 @@ static u32 qedr_srq_elem_left(struct qedr_srq_hwq_info *hw_srq)
>  	 * count and consumer count and subtract it from max
>  	 * work request supported so that we get elements left.
>  	 */
> -	used = hw_srq->wr_prod_cnt - hw_srq->wr_cons_cnt;
> +	used = hw_srq->wr_prod_cnt - (u32)atomic_read(&hw_srq->wr_cons_cnt);
>
>  	return hw_srq->max_wr - used;
>  }
> @@ -3701,7 +3702,6 @@ int qedr_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
>  	unsigned long flags;
>  	int status = 0;
>  	u32 num_sge;
> -	u32 offset;
>
>  	spin_lock_irqsave(&srq->lock, flags);
>
> @@ -3714,7 +3714,8 @@ int qedr_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
>  		if (!qedr_srq_elem_left(hw_srq) ||
>  		    wr->num_sge > srq->hw_srq.max_sges) {
>  			DP_ERR(dev, "Can't post WR  (%d,%d) || (%d > %d)\n",
> -			       hw_srq->wr_prod_cnt, hw_srq->wr_cons_cnt,
> +			       hw_srq->wr_prod_cnt,
> +			       atomic_read(&hw_srq->wr_cons_cnt),
>  			       wr->num_sge, srq->hw_srq.max_sges);
>  			status = -ENOMEM;
>  			*bad_wr = wr;
> @@ -3748,22 +3749,20 @@ int qedr_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
>  			hw_srq->sge_prod++;
>  		}
>
> -		/* Flush WQE and SGE information before
> +		/* Update WQE and SGE information before
>  		 * updating producer.
>  		 */
> -		wmb();
> +		dma_wmb();
>
>  		/* SRQ producer is 8 bytes. Need to update SGE producer index
>  		 * in first 4 bytes and need to update WQE producer in
>  		 * next 4 bytes.
>  		 */
> -		*srq->hw_srq.virt_prod_pair_addr = hw_srq->sge_prod;
> -		offset = offsetof(struct rdma_srq_producers, wqe_prod);
> -		*((u8 *)srq->hw_srq.virt_prod_pair_addr + offset) =
> -			hw_srq->wqe_prod;
> +		srq->hw_srq.virt_prod_pair_addr->sge_prod = hw_srq->sge_prod;
> +		/* Make sure sge producer is updated first */
> +		dma_wmb();
> +		srq->hw_srq.virt_prod_pair_addr->wqe_prod = hw_srq->wqe_prod;
>
> -		/* Flush producer after updating it. */
> -		wmb();
>  		wr = wr->next;
>  	}
>
> @@ -4182,7 +4181,7 @@ static int process_resp_one_srq(struct qedr_dev *dev, struct qedr_qp *qp,
>  	} else {
>  		__process_resp_one(dev, qp, cq, wc, resp, wr_id);
>  	}
> -	srq->hw_srq.wr_cons_cnt++;
> +	atomic_inc(&srq->hw_srq.wr_cons_cnt);
>
>  	return 1;
>  }
> --
> 1.8.3.1
>
