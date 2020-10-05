Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD4E283036
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Oct 2020 07:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgJEF45 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Oct 2020 01:56:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgJEF45 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 5 Oct 2020 01:56:57 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4472420796;
        Mon,  5 Oct 2020 05:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601877417;
        bh=PLuPHmSn4b7qMaXgVprvoKzz9BnSd4fi4U7PGnqw8/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XB2NXcmRjrssF4oURdWwU6UtL1/QsZHqXh8j5z5sVIrANtz0HNoXNkIfs6aLBcLqK
         W8WopagQEGTCzDx2HimCzmvN0w0bVYYlFub+kxdqYDW+JviZvsH6edIWqu6BFqEU06
         BvXKltJgYMZW+3qsohQZ21huaDL26m57L5tpooGY=
Date:   Mon, 5 Oct 2020 08:56:52 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        linux-rdma@vger.kernel.org, Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH 01/11] RDMA/cxgb4: Remove MW support
Message-ID: <20201005055652.GE9764@unreal>
References: <0-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
 <1-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Oct 03, 2020 at 08:20:01PM -0300, Jason Gunthorpe wrote:
> This driver never enabled IB_USER_VERBS_CMD_ALLOC_MW so memory windows
> were not usable from userspace. The kernel side was removed long ago. Drop
> this dead code.
>
> Fixes: feb7c1e38bcc ("IB: remove in-kernel support for memory windows")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/hw/cxgb4/iw_cxgb4.h |  2 -
>  drivers/infiniband/hw/cxgb4/mem.c      | 84 --------------------------
>  drivers/infiniband/hw/cxgb4/provider.c |  2 -
>  3 files changed, 88 deletions(-)
>
> diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
> index a27899402f59a5..f85477f3b037d2 100644
> --- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
> +++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
> @@ -983,9 +983,7 @@ struct ib_mr *c4iw_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
>  			    u32 max_num_sg);
>  int c4iw_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
>  		   unsigned int *sg_offset);
> -int c4iw_dealloc_mw(struct ib_mw *mw);
>  void c4iw_dealloc(struct uld_ctx *ctx);
> -int c4iw_alloc_mw(struct ib_mw *mw, struct ib_udata *udata);
>  struct ib_mr *c4iw_reg_user_mr(struct ib_pd *pd, u64 start,
>  					   u64 length, u64 virt, int acc,
>  					   struct ib_udata *udata);
> diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb4/mem.c
> index 42234df896fb2c..a2c71a1d93d5a8 100644
> --- a/drivers/infiniband/hw/cxgb4/mem.c
> +++ b/drivers/infiniband/hw/cxgb4/mem.c
> @@ -365,22 +365,6 @@ static int dereg_mem(struct c4iw_rdev *rdev, u32 stag, u32 pbl_size,
>  			       pbl_size, pbl_addr, skb, wr_waitp);
>  }
>
> -static int allocate_window(struct c4iw_rdev *rdev, u32 *stag, u32 pdid,
> -			   struct c4iw_wr_wait *wr_waitp)
> -{
> -	*stag = T4_STAG_UNSET;
> -	return write_tpt_entry(rdev, 0, stag, 0, pdid, FW_RI_STAG_MW, 0, 0, 0,
> -			       0UL, 0, 0, 0, 0, NULL, wr_waitp);
> -}
> -
> -static int deallocate_window(struct c4iw_rdev *rdev, u32 stag,
> -			     struct sk_buff *skb,
> -			     struct c4iw_wr_wait *wr_waitp)
> -{
> -	return write_tpt_entry(rdev, 1, &stag, 0, 0, 0, 0, 0, 0, 0UL, 0, 0, 0,
> -			       0, skb, wr_waitp);
> -}
> -
>  static int allocate_stag(struct c4iw_rdev *rdev, u32 *stag, u32 pdid,
>  			 u32 pbl_size, u32 pbl_addr,
>  			 struct c4iw_wr_wait *wr_waitp)
> @@ -611,74 +595,6 @@ struct ib_mr *c4iw_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
>  	return ERR_PTR(err);
>  }
>
> -int c4iw_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
> -{
> -	struct c4iw_mw *mhp = to_c4iw_mw(ibmw);
> -	struct c4iw_dev *rhp;
> -	struct c4iw_pd *php;
> -	u32 mmid;
> -	u32 stag = 0;
> -	int ret;
> -
> -	if (ibmw->type != IB_MW_TYPE_1)
> -		return -EINVAL;
> -
> -	php = to_c4iw_pd(ibmw->pd);
> -	rhp = php->rhp;
> -	mhp->wr_waitp = c4iw_alloc_wr_wait(GFP_KERNEL);
> -	if (!mhp->wr_waitp)
> -		return -ENOMEM;
> -
> -	mhp->dereg_skb = alloc_skb(SGE_MAX_WR_LEN, GFP_KERNEL);
> -	if (!mhp->dereg_skb) {
> -		ret = -ENOMEM;
> -		goto free_wr_wait;
> -	}
> -
> -	ret = allocate_window(&rhp->rdev, &stag, php->pdid, mhp->wr_waitp);
> -	if (ret)
> -		goto free_skb;
> -
> -	mhp->rhp = rhp;
> -	mhp->attr.pdid = php->pdid;
> -	mhp->attr.type = FW_RI_STAG_MW;

75% of "enum fw_ri_stag_type" can be removed too.

Thanks
