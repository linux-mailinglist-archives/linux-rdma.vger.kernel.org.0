Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760CD66B095
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Jan 2023 12:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjAOLX6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 06:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjAOLX4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 06:23:56 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2461E1732
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 03:23:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 62C33CE0B59
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 11:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D2AC433D2;
        Sun, 15 Jan 2023 11:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673781831;
        bh=RZdvkm3WF6qDsqlluPgpTuCVA6ZicpCokru8HQbHX2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S3Rvz00tJ9rSTZw8bVzXrwlqNS5clkletbomftsmdif7mRyoi36FTRtyBsS/ZSaGQ
         LPky9hOURTZXUnR2PcDAMId6ZcN8HATrepoc2N5Qh9S5nOmU5Jkxmnu+FpQ9SBq8wJ
         lL/e7lriDSNVXfi8WyX1n6SeoG2DA9z2ZF7L8f6SAHjyY/vyaSCUQTqJ4aA7iJPHmF
         2Nbl3PmO2IMTy94gLDXqw4fwit/EM30wKxg5DMWHeHHu9YmglaDbXwl9O/zIao3Oo0
         +Go6I8W8XsQ2nzE+sH9fiROIcXl1+0uNXVL9g3WSZt5yB+Vfw5NE9FI16jxV8Bwot2
         /rtmo65+d0vyA==
Date:   Sun, 15 Jan 2023 13:23:47 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCHv2 for-next 3/4] RDMA/irdma: Split QP handler into
 irdma_reg_user_mr_type_qp
Message-ID: <Y8PiQz47jQurznMH@unreal>
References: <20230112000617.1659337-1-yanjun.zhu@intel.com>
 <20230112000617.1659337-4-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112000617.1659337-4-yanjun.zhu@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 11, 2023 at 07:06:16PM -0500, Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Split the source codes related with QP handling into a new function.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 48 ++++++++++++++++++++---------
>  1 file changed, 34 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> index f4712276b920..74dd1972c325 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -2834,6 +2834,39 @@ static void irdma_free_iwmr(struct irdma_mr *iwmr)
>  	kfree(iwmr);
>  }
>  
> +static int irdma_reg_user_mr_type_qp(struct irdma_mem_reg_req req,
> +				     struct ib_udata *udata,
> +				     struct irdma_mr *iwmr)
> +{
> +	u32 total;
> +	int err;
> +	u8 shadow_pgcnt = 1;

It is constant, you don't need variable for that.

> +	bool use_pbles;
> +	unsigned long flags;
> +	struct irdma_ucontext *ucontext;
> +	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
> +	struct irdma_device *iwdev = to_iwdev(iwmr->ibmr.device);
> +
> +	total = req.sq_pages + req.rq_pages + shadow_pgcnt;
> +	if (total > iwmr->page_cnt)
> +		return -EINVAL;
> +
> +	total = req.sq_pages + req.rq_pages;
> +	use_pbles = (total > 2);

There is no need in brackets here.

> +	err = irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
> +	if (err)
> +		return err;
> +
> +	ucontext = rdma_udata_to_drv_context(udata, struct irdma_ucontext,
> +					     ibucontext);
> +	spin_lock_irqsave(&ucontext->qp_reg_mem_list_lock, flags);
> +	list_add_tail(&iwpbl->list, &ucontext->qp_reg_mem_list);
> +	iwpbl->on_list = true;
> +	spin_unlock_irqrestore(&ucontext->qp_reg_mem_list_lock, flags);
> +
> +	return err;

return 0;

> +}
> +
>  /**
>   * irdma_reg_user_mr - Register a user memory region
>   * @pd: ptr of pd
> @@ -2889,23 +2922,10 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
>  
>  	switch (req.reg_type) {
>  	case IRDMA_MEMREG_TYPE_QP:
> -		total = req.sq_pages + req.rq_pages + shadow_pgcnt;
> -		if (total > iwmr->page_cnt) {
> -			err = -EINVAL;
> -			goto error;
> -		}
> -		total = req.sq_pages + req.rq_pages;
> -		use_pbles = (total > 2);
> -		err = irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
> +		err = irdma_reg_user_mr_type_qp(req, udata, iwmr);
>  		if (err)
>  			goto error;
>  
> -		ucontext = rdma_udata_to_drv_context(udata, struct irdma_ucontext,
> -						     ibucontext);
> -		spin_lock_irqsave(&ucontext->qp_reg_mem_list_lock, flags);
> -		list_add_tail(&iwpbl->list, &ucontext->qp_reg_mem_list);
> -		iwpbl->on_list = true;
> -		spin_unlock_irqrestore(&ucontext->qp_reg_mem_list_lock, flags);
>  		break;
>  	case IRDMA_MEMREG_TYPE_CQ:
>  		if (iwdev->rf->sc_dev.hw_attrs.uk_attrs.feature_flags & IRDMA_FEATURE_CQ_RESIZE)
> -- 
> 2.31.1
> 
