Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D48F4B6D50
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 14:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbiBONY0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 08:24:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbiBONY0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 08:24:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C59B106626
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 05:24:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09BDAB818FB
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 13:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6561C340EB;
        Tue, 15 Feb 2022 13:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644931449;
        bh=0X5vRCM4tfiFapmTZLfiC+uWGv1ZN0hkHt+XJa2wJOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=do+Bs6vseBN+qltlcMH/5IaRx3Oprlw8SAx7Li5XnD9kxk7K8hKU+Vf63epSin2gP
         heHCXPlvyaAy2oJfo7JpY62kbRN4O3xvRm0murC1j0yUwXDRGRFPkLJL4Jtz231j3q
         vM5bB5IXkrEVH+fWzo/znstcqFlQ/0uYquqc5We4KBDvP+WsWUevteX6jDOk928NWG
         XsYOJyONZ8PoBCDRCbk2o2y9gqB3s5Vt433/mGyoBse4q1bNiAD3zjd1oG8ISKXtYj
         cHhqjQNJEmqwPnLNbSXnlsvFwAg80DPi4hbyL5KXT7kNHn4BDs67XvnAsfbVV/juBv
         Pf/Q2MRC0cobA==
Date:   Tue, 15 Feb 2022 15:24:04 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, jgg@nvidia.com, sagi@grimberg.me,
        oren@nvidia.com, sergeygo@nvidia.com
Subject: Re: [PATCH 1/4] IB/iser: remove iser_reg_data_sg helper function
Message-ID: <YgupdG6M/TZL20iX@unreal>
References: <20220215110632.10697-1-mgurtovoy@nvidia.com>
 <20220215110632.10697-2-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215110632.10697-2-mgurtovoy@nvidia.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 15, 2022 at 01:06:29PM +0200, Max Gurtovoy wrote:
> Open coding it makes the code more readable and simple.
> 
> Reviewed-by: Sergey Gorenko <sergeygo@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  drivers/infiniband/ulp/iser/iser_memory.c | 32 ++++++++---------------
>  1 file changed, 11 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/iser/iser_memory.c b/drivers/infiniband/ulp/iser/iser_memory.c
> index 660982625488..2738ec56c918 100644
> --- a/drivers/infiniband/ulp/iser/iser_memory.c
> +++ b/drivers/infiniband/ulp/iser/iser_memory.c
> @@ -327,40 +327,29 @@ static int iser_fast_reg_mr(struct iscsi_iser_task *iser_task,
>  	return 0;
>  }
>  
> -static int iser_reg_data_sg(struct iscsi_iser_task *task,
> -			    struct iser_data_buf *mem,
> -			    struct iser_fr_desc *desc, bool use_dma_key,
> -			    struct iser_mem_reg *reg)
> -{
> -	struct iser_device *device = task->iser_conn->ib_conn.device;
> -
> -	if (use_dma_key)
> -		return iser_reg_dma(device, mem, reg);
> -
> -	return iser_fast_reg_mr(task, mem, &desc->rsc, reg);
> -}
> -
>  int iser_reg_mem_fastreg(struct iscsi_iser_task *task,
>  			 enum iser_data_dir dir,
>  			 bool all_imm)
>  {
>  	struct ib_conn *ib_conn = &task->iser_conn->ib_conn;
> +	struct iser_device *device = ib_conn->device;
>  	struct iser_data_buf *mem = &task->data[dir];
>  	struct iser_mem_reg *reg = &task->rdma_reg[dir];
> -	struct iser_fr_desc *desc = NULL;
> +	struct iser_fr_desc *desc;
>  	bool use_dma_key;
>  	int err;
>  
>  	use_dma_key = mem->dma_nents == 1 && (all_imm || !iser_always_reg) &&
>  		      scsi_get_prot_op(task->sc) == SCSI_PROT_NORMAL;
> +	if (use_dma_key)
> +		return iser_reg_dma(device, mem, reg);
>  
> -	if (!use_dma_key) {
> -		desc = iser_reg_desc_get_fr(ib_conn);
> -		reg->mem_h = desc;
> -	}
> +	desc = iser_reg_desc_get_fr(ib_conn);

It can't be NULL,
iser_reg_desc_get_fr():
   52         spin_lock_irqsave(&fr_pool->lock, flags);
   53         desc = list_first_entry(&fr_pool->list,
   54                                 struct iser_fr_desc, list);
   55         list_del(&desc->list);

If desc is NULL, it will crash.

   56         spin_unlock_irqrestore(&fr_pool->lock, flags);
   57
   58         return desc;


> +	if (unlikely(!desc))
> +		return -ENOMEM;
>  
>  	if (scsi_get_prot_op(task->sc) == SCSI_PROT_NORMAL) {
> -		err = iser_reg_data_sg(task, mem, desc, use_dma_key, reg);
> +		err = iser_fast_reg_mr(task, mem, &desc->rsc, reg);
>  		if (unlikely(err))
>  			goto err_reg;
>  	} else {
> @@ -372,11 +361,12 @@ int iser_reg_mem_fastreg(struct iscsi_iser_task *task,
>  		desc->sig_protected = true;
>  	}
>  
> +	reg->mem_h = desc;
> +
>  	return 0;
>  
>  err_reg:
> -	if (desc)
> -		iser_reg_desc_put_fr(ib_conn, desc);
> +	iser_reg_desc_put_fr(ib_conn, desc);
>  
>  	return err;
>  }
> -- 
> 2.18.1
> 
