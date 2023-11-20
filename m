Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A977F1422
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Nov 2023 14:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjKTNNV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Nov 2023 08:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjKTNNU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Nov 2023 08:13:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956EEF2;
        Mon, 20 Nov 2023 05:13:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B035CC433C7;
        Mon, 20 Nov 2023 13:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700485997;
        bh=EdLuhwM7Jtz2SU14padLa5AJv5bzwq3E/Djcv5K11gQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qsNq/mpBUNNeEZJh168u3w41TsczwfkNL5GVNI0206KdYZvP8FjbVlO2Y/tH1pI0L
         OeZUkTuYA962aukwWdPtNsLrBnSJYSc+f4n1A4JQCHOFqZE63Vl7snEUztuAPdFuR7
         7Pl5oWEq2LVlJBwqM/2PdsAdWyt4mPtgVnXIxOhO7ca1uOgVJD4fu7U8OhmAjw9Mb5
         q4fOieTxKXfcWR5SBPjhpAb/k7h8LbAGwIg4IhctZTqH/U4aFFMOBqoJG7Z4FYNrmO
         hktx7i45Qwx/lqS6IkXGpb2Stbncd/cObXmGi54blCz+0N48oERzQl6qnDUzIFQQ3B
         4Yq5PfltWGpNw==
Date:   Mon, 20 Nov 2023 15:13:12 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Shifeng Li <lishifeng1992@126.com>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinghui@sangfor.com.cn
Subject: Re: [PATCH v2] RDMA/irdma: Fix UAF in irdma_sc_ccq_get_cqe_info()
Message-ID: <20231120131312.GC15293@unreal>
References: <20231120024940.17321-1-lishifeng1992@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120024940.17321-1-lishifeng1992@126.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 19, 2023 at 06:49:40PM -0800, Shifeng Li wrote:
> When removing the irdma driver or unplugging its aux device, the ccq
> queue is released before destorying the cqp_cmpl_wq queue.
> But in the window, there may still be completion events for wqes. That
> will cause a UAF in irdma_sc_ccq_get_cqe_info().
> 
> [34693.333191] BUG: KASAN: use-after-free in irdma_sc_ccq_get_cqe_info+0x82f/0x8c0 [irdma]
> [34693.333194] Read of size 8 at addr ffff889097f80818 by task kworker/u67:1/26327
> [34693.333194]
> [34693.333199] CPU: 9 PID: 26327 Comm: kworker/u67:1 Kdump: loaded Tainted: G           O     --------- -t - 4.18.0 #1
> [34693.333200] Hardware name: SANGFOR Inspur/NULL, BIOS 4.1.13 08/01/2016
> [34693.333211] Workqueue: cqp_cmpl_wq cqp_compl_worker [irdma]
> [34693.333213] Call Trace:
> [34693.333220]  dump_stack+0x71/0xab
> [34693.333226]  print_address_description+0x6b/0x290
> [34693.333238]  ? irdma_sc_ccq_get_cqe_info+0x82f/0x8c0 [irdma]
> [34693.333240]  kasan_report+0x14a/0x2b0
> [34693.333251]  irdma_sc_ccq_get_cqe_info+0x82f/0x8c0 [irdma]
> [34693.333264]  ? irdma_free_cqp_request+0x151/0x1e0 [irdma]
> [34693.333274]  irdma_cqp_ce_handler+0x1fb/0x3b0 [irdma]
> [34693.333285]  ? irdma_ctrl_init_hw+0x2c20/0x2c20 [irdma]
> [34693.333290]  ? __schedule+0x836/0x1570
> [34693.333293]  ? strscpy+0x83/0x180
> [34693.333296]  process_one_work+0x56a/0x11f0
> [34693.333298]  worker_thread+0x8f/0xf40
> [34693.333301]  ? __kthread_parkme+0x78/0xf0
> [34693.333303]  ? rescuer_thread+0xc50/0xc50
> [34693.333305]  kthread+0x2a0/0x390
> [34693.333308]  ? kthread_destroy_worker+0x90/0x90
> [34693.333310]  ret_from_fork+0x1f/0x40
> 
> Fixes: 44d9e52977a1 ("RDMA/irdma: Implement device initialization definitions")
> Signed-off-by: Shifeng Li <lishifeng1992@126.com>
> Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/hw.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> ---
> v1->v2: add Fixes line.

This patch doesn't apply cleanly due to this patch.
https://lore.kernel.org/all/20230725155505.1069-3-shiraz.saleem@intel.com/

Thanks

> 
> diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
> index ab246447520b..de7337a6a874 100644
> --- a/drivers/infiniband/hw/irdma/hw.c
> +++ b/drivers/infiniband/hw/irdma/hw.c
> @@ -570,8 +570,6 @@ static void irdma_destroy_cqp(struct irdma_pci_f *rf, bool free_hwcqp)
>  	struct irdma_cqp *cqp = &rf->cqp;
>  	int status = 0;
>  
> -	if (rf->cqp_cmpl_wq)
> -		destroy_workqueue(rf->cqp_cmpl_wq);
>  	if (free_hwcqp)
>  		status = irdma_sc_cqp_destroy(dev->cqp);
>  	if (status)
> @@ -737,6 +735,8 @@ static void irdma_destroy_ccq(struct irdma_pci_f *rf)
>  	struct irdma_ccq *ccq = &rf->ccq;
>  	int status = 0;
>  
> +	if (rf->cqp_cmpl_wq)
> +		destroy_workqueue(rf->cqp_cmpl_wq);
>  	if (!rf->reset)
>  		status = irdma_sc_ccq_destroy(dev->ccq, 0, true);
>  	if (status)
> -- 
> 2.25.1
> 
