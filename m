Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472C5215CCB
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 19:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbgGFRPQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 13:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbgGFRPP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 13:15:15 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D39C061755
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jul 2020 10:15:15 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k5so7723556pjg.3
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jul 2020 10:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5K6ZU7Ciw9ZPpdnVA+PXC1IY2DrJdmnwnAneC3IjPEk=;
        b=GJ0WSOfKeCv+DkL1N84gA/TLrLZA/Qi3MKR/0nLRo6a+bQ1n7aT9zlHxi823HizxJu
         WoWHltSPRbjgR4+i2ZdRy0RV6Kb8M18mzwAN6e//Lv5bZ/r2GDgI6dAQA4ZsuTG/Zqpy
         go1kytaCwH7g3266ESe2VZcjmfdpOFHhbkkD7qZZYE7R2C6X+Lgh/QQK62h1+gBxnWQl
         DWOIXF2WWhlISjJfL5NUzn14v5093D8Eua+QgYOUn80uJe2D84WsULfCJ2G1nc12JuM4
         4UN0BKpfE7sqAk2RNmYlnlQwU4FezuXpLDuaPDoxpU6CfnlsgH5EF40K6IaU97yN7STR
         Cq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5K6ZU7Ciw9ZPpdnVA+PXC1IY2DrJdmnwnAneC3IjPEk=;
        b=qdS6N0lsW5YjQgsusA4Hm1XgQ01vDNCwLY1pLO0l9jg3L39fASWyHmNhXc4i1HlGCr
         dRMEYTIhQfiy8ixCSkBcnslac+lksfM9DumZjLnbUnQC8suzP+4/SUJyoJlZTkcVQF+U
         yo46tlOhOIGQtI1blXKZnhf3cwiRbQbJBBGbepaHs76aRcVL+3c0AXMPocFoFm90Z0hb
         u+PHYTxZVJDCe3paskMQbPOUU7FYU1KgAHGY1tLF1QGK8fbhwWVtXMNc9eBsc1NFE+pl
         RcLSgWsdT7tcZR0ljSGI3rfkmiUdRjR2nhM1LiGZc3P8uZaJQdJVaJtpKxF2jEzCIOwC
         b82g==
X-Gm-Message-State: AOAM530bKg+qyZWcIO/AWGh1rFMxSb8Iz8V4puRBUVqVCXLyoHhMgkwh
        OcGR4C91mwrAE8VnarNl3K29SmJj7X2/vA==
X-Google-Smtp-Source: ABdhPJwYxKvbLf/NO1tp/0x1vgOsjl58AF2g5mEwK/3pDlhMA8hJYOzY+MkLqMoN3u1tiUSy/kDXAA==
X-Received: by 2002:a17:90b:918:: with SMTP id bo24mr211992pjb.191.1594055714698;
        Mon, 06 Jul 2020 10:15:14 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id gv16sm78178pjb.5.2020.07.06.10.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 10:15:14 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jsUi0-0052Xk-72; Mon, 06 Jul 2020 14:15:12 -0300
Date:   Mon, 6 Jul 2020 14:15:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yuval Basson <ybason@marvell.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>
Subject: Re: [PATCH rdma-next] RDMA/qedr: SRQ's bug fixes
Message-ID: <20200706171512.GV25301@ziepe.ca>
References: <20200706111352.21667-1-ybason@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706111352.21667-1-ybason@marvell.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 06, 2020 at 02:13:52PM +0300, Yuval Basson wrote:
> QP's with the same SRQ, working on different CQs and running in parallel
> on different CPUs could lead to a race when maintaining the SRQ consumer
> count, and leads to FW running out of SRQs. Update the consumer atomically.
> Make sure the wqe_prod is updated after the sge_prod due to FW
> requirements.
> 
> Fixes: 3491c9e799fb9 ("RDMA/qedr: Add support for kernel mode SRQ's")
> Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
> Signed-off-by: Yuval Basson <ybason@marvell.com>
>  drivers/infiniband/hw/qedr/qedr.h  |  4 ++--
>  drivers/infiniband/hw/qedr/verbs.c | 23 ++++++++++++-----------
>  2 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/qedr/qedr.h b/drivers/infiniband/hw/qedr/qedr.h
> index fdf90ec..aa33202 100644
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
> index 9b9e802..394adbd 100644
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
> @@ -3748,22 +3749,22 @@ int qedr_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
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
> +		barrier();
> +		srq->hw_srq.virt_prod_pair_addr->wqe_prod = hw_srq->wqe_prod;

That is not what barrier does

This is DMA coherent memory and you need to ensure that a DMA observes
sge_prod before wqe_prod? That is the very definition of dma_wmb()

>  		/* Flush producer after updating it. */
> -		wmb();
> +		dma_wmb();
>  		wr = wr->next;

Why are there more dma_wmb()s? What dma'able memory is this protecting?

Jason
