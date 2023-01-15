Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F2C66B09F
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Jan 2023 12:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjAOL2V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 06:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjAOL2U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 06:28:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0C7F777
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 03:28:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C294F60C92
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 11:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31E9C433EF;
        Sun, 15 Jan 2023 11:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673782098;
        bh=nMWtlMI7fv5Yk8Dlw4HRT6m7mQcZlT1hJ766qIQpW3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fc9oLUZLc7j8cIjdditpeiGV3DgOoThJ3wZ8zWYDVFxmNiAnvxOcHrFDEeZc0zEYu
         wdm8nmoLqbeIqKsbqkpDu9BJ3kxyygrU5bu/N22EXB2yoEJ/H7Zdjf6l4+mvYyb7aG
         yHpy7ufMIuWOBOlA+neLt9BXk03NCipMJ5kaRmI3eAJy0x2yfo/oJ+j9rlVHZnFX+Y
         v+5uYDE/HLwY2yIx/nLsbxjrI+CGxiMarusD+XhqTA9dfiYPqH7xJwpScqoC2mNlIG
         BOuuJZgNar93WiXO3Hdhv5iavvk86gkGaXzlCtFwWpyFcvVNrdxkTk/78MFiaZ3EbQ
         U1VkPcPh7vm4Q==
Date:   Sun, 15 Jan 2023 13:28:13 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCHv2 for-next 4/4] RDMA/irdma: Split CQ handler into
 irdma_reg_user_mr_type_cq
Message-ID: <Y8PjTUxb/9HJ7XWH@unreal>
References: <20230112000617.1659337-1-yanjun.zhu@intel.com>
 <20230112000617.1659337-5-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112000617.1659337-5-yanjun.zhu@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 11, 2023 at 07:06:17PM -0500, Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Split the source codes related with CQ handling into a new function.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 63 +++++++++++++++++------------
>  1 file changed, 37 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> index 74dd1972c325..3902c74d59f2 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -2867,6 +2867,40 @@ static int irdma_reg_user_mr_type_qp(struct irdma_mem_reg_req req,
>  	return err;
>  }
>  
> +static int irdma_reg_user_mr_type_cq(struct irdma_mem_reg_req req,
> +				     struct ib_udata *udata,
> +				     struct irdma_mr *iwmr)
> +{
> +	int err;
> +	u8 shadow_pgcnt = 1;
> +	bool use_pbles;
> +	struct irdma_ucontext *ucontext;
> +	unsigned long flags;
> +	u32 total;
> +	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
> +	struct irdma_device *iwdev = to_iwdev(iwmr->ibmr.device);

It will be nice to see more structured variable initialization.

I'm not going to insist on it, but IMHO netdev reverse Christmas
tree rule looks more appealing than this random list.

> +
> +	if (iwdev->rf->sc_dev.hw_attrs.uk_attrs.feature_flags & IRDMA_FEATURE_CQ_RESIZE)
> +		shadow_pgcnt = 0;
> +	total = req.cq_pages + shadow_pgcnt;
> +	if (total > iwmr->page_cnt)
> +		return -EINVAL;
> +
> +	use_pbles = (req.cq_pages > 1);
> +	err = irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
> +	if (err)
> +		return err;
> +
> +	ucontext = rdma_udata_to_drv_context(udata, struct irdma_ucontext,
> +					     ibucontext);
> +	spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
> +	list_add_tail(&iwpbl->list, &ucontext->cq_reg_mem_list);
> +	iwpbl->on_list = true;
> +	spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
> +
> +	return err;

return 0;

> +}
> +
>  /**
>   * irdma_reg_user_mr - Register a user memory region
>   * @pd: ptr of pd
> @@ -2882,16 +2916,10 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
>  {
>  #define IRDMA_MEM_REG_MIN_REQ_LEN offsetofend(struct irdma_mem_reg_req, sq_pages)
>  	struct irdma_device *iwdev = to_iwdev(pd->device);
> -	struct irdma_ucontext *ucontext;
> -	struct irdma_pbl *iwpbl;
>  	struct irdma_mr *iwmr;
>  	struct ib_umem *region;
>  	struct irdma_mem_reg_req req;
> -	u32 total;
> -	u8 shadow_pgcnt = 1;
> -	bool use_pbles = false;
> -	unsigned long flags;
> -	int err = -EINVAL;
> +	int err;
>  
>  	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
>  		return ERR_PTR(-EINVAL);
> @@ -2918,8 +2946,6 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
>  		return (struct ib_mr *)iwmr;
>  	}
>  
> -	iwpbl = &iwmr->iwpbl;
> -
>  	switch (req.reg_type) {
>  	case IRDMA_MEMREG_TYPE_QP:
>  		err = irdma_reg_user_mr_type_qp(req, udata, iwmr);
> @@ -2928,25 +2954,9 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
>  
>  		break;
>  	case IRDMA_MEMREG_TYPE_CQ:
> -		if (iwdev->rf->sc_dev.hw_attrs.uk_attrs.feature_flags & IRDMA_FEATURE_CQ_RESIZE)
> -			shadow_pgcnt = 0;
> -		total = req.cq_pages + shadow_pgcnt;
> -		if (total > iwmr->page_cnt) {
> -			err = -EINVAL;
> -			goto error;
> -		}
> -
> -		use_pbles = (req.cq_pages > 1);
> -		err = irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
> +		err = irdma_reg_user_mr_type_cq(req, udata, iwmr);
>  		if (err)
>  			goto error;
> -
> -		ucontext = rdma_udata_to_drv_context(udata, struct irdma_ucontext,
> -						     ibucontext);
> -		spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
> -		list_add_tail(&iwpbl->list, &ucontext->cq_reg_mem_list);
> -		iwpbl->on_list = true;
> -		spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
>  		break;
>  	case IRDMA_MEMREG_TYPE_MEM:
>  		err = irdma_reg_user_mr_type_mem(iwmr, access);
> @@ -2955,6 +2965,7 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
>  
>  		break;
>  	default:
> +		err = -EINVAL;
>  		goto error;
>  	}
>  
> -- 
> 2.31.1
> 
