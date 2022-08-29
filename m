Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAB75A44CA
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 10:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiH2IQR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 04:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiH2IQH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 04:16:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C451E4B0D0;
        Mon, 29 Aug 2022 01:16:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11AE360DE4;
        Mon, 29 Aug 2022 08:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87ADC433C1;
        Mon, 29 Aug 2022 08:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661760960;
        bh=UWwY3Af7IKEUO4nLKlGbtQuRQ96FU24HUXJEzDT7wqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ul4+n76QreCtEx5zZF4zYm/1yCAfE5t952aAwI/VjV4og2KeZsHEf9f/UO2Z6BYdE
         ZIXLw40dLL6ybKnLhjgauM1XZl5HfqhAdcPWFbeuF0rWNjvlYKFwx8bPSeXsaSGtHg
         we40gi9cvKxImoX+1Qq/zcgguSOSEGXanEwSljHyWP/pnA8T0nBBXbsUXp2w4FstHR
         JEqJdBuTLQbR77dyqEk7KP/41iozoKNNrEPEMTDktvTiaEdVoMxB5KregHVhDD8eG/
         GueEX/9nh9m/xGe6aaRWC9+x5s6nsUf/w3fdrxkMINifbYCwx2FEpewf7giUxUAat7
         Qpp43u4faobxQ==
Date:   Mon, 29 Aug 2022 11:15:56 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Yishai Hadas <yishaih@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RESEND rdma-rc] IB/core: Fix a nested dead lock as part
 of ODP flow
Message-ID: <Ywx1vEF4GDT5whkt@unreal>
References: <74d93541ea533ef7daec6f126deb1072500aeb16.1661251841.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74d93541ea533ef7daec6f126deb1072500aeb16.1661251841.git.leonro@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 24, 2022 at 09:10:36AM +0300, Leon Romanovsky wrote:
> From: Yishai Hadas <yishaih@nvidia.com>
> 
> Fix a nested dead lock as part of ODP flow by using mmput_async().
> 
> From the below call trace [1] can see that calling mmput() once we have
> the umem_odp->umem_mutex locked as required by
> ib_umem_odp_map_dma_and_lock() might trigger in the same task the
> exit_mmap()->__mmu_notifier_release()->mlx5_ib_invalidate_range() which
> may dead lock when trying to lock the same mutex.
> 
> Moving to use mmput_async() will solve the problem as the above
> exit_mmap() flow will be called in other task and will be executed once
> the lock will be available.
> 
> [1]
> [64843.077665] task:kworker/u133:2  state:D stack:    0 pid:80906 ppid:
> 2 flags:0x00004000
> [64843.077672] Workqueue: mlx5_ib_page_fault mlx5_ib_eqe_pf_action [mlx5_ib]
> [64843.077719] Call Trace:
> [64843.077722]  <TASK>
> [64843.077724]  __schedule+0x23d/0x590
> [64843.077729]  schedule+0x4e/0xb0
> [64843.077735]  schedule_preempt_disabled+0xe/0x10
> [64843.077740]  __mutex_lock.constprop.0+0x263/0x490
> [64843.077747]  __mutex_lock_slowpath+0x13/0x20
> [64843.077752]  mutex_lock+0x34/0x40
> [64843.077758]  mlx5_ib_invalidate_range+0x48/0x270 [mlx5_ib]
> [64843.077808]  __mmu_notifier_release+0x1a4/0x200
> [64843.077816]  exit_mmap+0x1bc/0x200
> [64843.077822]  ? walk_page_range+0x9c/0x120
> [64843.077828]  ? __cond_resched+0x1a/0x50
> [64843.077833]  ? mutex_lock+0x13/0x40
> [64843.077839]  ? uprobe_clear_state+0xac/0x120
> [64843.077860]  mmput+0x5f/0x140
> [64843.077867]  ib_umem_odp_map_dma_and_lock+0x21b/0x580 [ib_core]
> [64843.077931]  pagefault_real_mr+0x9a/0x140 [mlx5_ib]
> [64843.077962]  pagefault_mr+0xb4/0x550 [mlx5_ib]
> [64843.077992]  pagefault_single_data_segment.constprop.0+0x2ac/0x560
> [mlx5_ib]
> [64843.078022]  mlx5_ib_eqe_pf_action+0x528/0x780 [mlx5_ib]
> [64843.078051]  process_one_work+0x22b/0x3d0
> [64843.078059]  worker_thread+0x53/0x410
> [64843.078065]  ? process_one_work+0x3d0/0x3d0
> [64843.078073]  kthread+0x12a/0x150
> [64843.078079]  ? set_kthread_struct+0x50/0x50
> [64843.078085]  ret_from_fork+0x22/0x30
> [64843.078093]  </TASK>
> 
> Fixes: 36f30e486dce ("IB/core: Improve ODP to use hmm_range_fault()")
> Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Resend to larger forum.
> https://lore.kernel.org/all/74d93541ea533ef7daec6f126deb1072500aeb16.1661251841.git.leonro@nvidia.com
> ---
>  drivers/infiniband/core/umem_odp.c | 2 +-
>  kernel/fork.c                      | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)

Any objections?

Thanks

> 
> diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
> index 186ed8859920..d39e16c211e8 100644
> --- a/drivers/infiniband/core/umem_odp.c
> +++ b/drivers/infiniband/core/umem_odp.c
> @@ -462,7 +462,7 @@ int ib_umem_odp_map_dma_and_lock(struct ib_umem_odp *umem_odp, u64 user_virt,
>  		mutex_unlock(&umem_odp->umem_mutex);
>  
>  out_put_mm:
> -	mmput(owning_mm);
> +	mmput_async(owning_mm);
>  out_put_task:
>  	if (owning_process)
>  		put_task_struct(owning_process);
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 90c85b17bf69..8a9e92068b15 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1225,6 +1225,7 @@ void mmput_async(struct mm_struct *mm)
>  		schedule_work(&mm->async_put_work);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(mmput_async);
>  #endif
>  
>  /**
> -- 
> 2.37.2
> 
