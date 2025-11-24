Return-Path: <linux-rdma+bounces-14716-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B5BC7FCE1
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 11:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4DE56341793
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 10:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C9A2F60C4;
	Mon, 24 Nov 2025 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vC9LBixI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A19F2F49F2
	for <linux-rdma@vger.kernel.org>; Mon, 24 Nov 2025 10:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763978859; cv=none; b=QpViBnsyK73fANiajiQyWd/MccoDuuV4YNbAZufPlo5MPbutEau3StU0CIJbEi7JSXlTIh8I8osT8VRk/zpny1Um1XY4J04jZFxLg8ETB8TvGhzrW29GcEELJM7weYjjnjapgoP5SSu5sZtAQayNarX6B1Lw9Bjv36YqGex1v8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763978859; c=relaxed/simple;
	bh=TNqPVW9p9MSdmb/WAkCmXYYZzMCybbaGVAd9rDheD7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bpl0VQ13J5D9iL95rBUEwqcORwvkx1RvcVscAOXq9evXWbHn26NU/HeeAj+/kBCLaLsYZ8xHRaR7NdPAAWYCDt5zrk5nhXr0cbM5KgFO6L07dLUz+pyX8uePajnFMWqHvt/8SRPVGKULN2rWj5Dma70if65Yy0p60n8s+OiRw/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vC9LBixI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FFBC116D0;
	Mon, 24 Nov 2025 10:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763978858;
	bh=TNqPVW9p9MSdmb/WAkCmXYYZzMCybbaGVAd9rDheD7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vC9LBixIaQJd3+N5fFE9ObnMuFRoOjl8prpzFsg763UwO4quQxjOx+TNSiPuyp1bE
	 PW5Xw99jwszdXujHPs2B5dEOA7ldKXXH9Ohnp7I370dZdlgdWKDPQqUawy0MxJgaUq
	 mpT7wCdb6llpjwJVQcL6eAN/yY6ugi5vtl9MBjlOYZzb/zeE/JwoWzDH3fT7LG20S/
	 bpCtZm93LEqMJCWj9VX0Qjqyy4INS1BpvdFLvt8eRFA2lQi5PmK/YnNFaqnUD6//rk
	 sNEMGFKpzr5cDBP9c4US/YA837bHp2MSZmjF29m/wI7KdIRYrVXLQy07mpmRAqjLFt
	 6fA9PY4T7c2Yw==
Date: Mon, 24 Nov 2025 12:07:34 +0200
From: Leon Romanovsky <leon@kernel.org>
To: lirongqing <lirongqing@baidu.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, huangjunxian6@hisilicon.com,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH][v3] RDMA/core: Prevent soft lockup during large user
 memory region cleanup
Message-ID: <20251124100734.GA12483@unreal>
References: <20251124050621.2622-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124050621.2622-1-lirongqing@baidu.com>

On Mon, Nov 24, 2025 at 01:06:21PM +0800, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> When a process exits with numerous large, pinned memory regions consisting
> of 4KB pages, the cleanup of the memory region through __ib_umem_release()
> may cause soft lockups. This is because unpin_user_page_range_dirty_lock()
> is called in a tight loop for unpin and releasing page without yielding the
> CPU.
> 
>  watchdog: BUG: soft lockup - CPU#44 stuck for 26s! [python3:73464]
>  Kernel panic - not syncing: softlockup: hung tasks
>  CPU: 44 PID: 73464 Comm: python3 Tainted: G           OEL
> 
>  asm_sysvec_apic_timer_interrupt+0x1b/0x20
>  RIP: 0010:free_unref_page+0xff/0x190
> 
>   ? free_unref_page+0xe3/0x190
>   __put_page+0x77/0xe0
>   put_compound_head+0xed/0x100
>   unpin_user_page_range_dirty_lock+0xb2/0x180
>   __ib_umem_release+0x57/0xb0 [ib_core]
>   ib_umem_release+0x3f/0xd0 [ib_core]
>   mlx5_ib_dereg_mr+0x2e9/0x440 [mlx5_ib]
>   ib_dereg_mr_user+0x43/0xb0 [ib_core]
>   uverbs_free_mr+0x15/0x20 [ib_uverbs]
>   destroy_hw_idr_uobject+0x21/0x60 [ib_uverbs]
>   uverbs_destroy_uobject+0x38/0x1b0 [ib_uverbs]
>   __uverbs_cleanup_ufile+0xd1/0x150 [ib_uverbs]
>   uverbs_destroy_ufile_hw+0x3f/0x100 [ib_uverbs]
>   ib_uverbs_close+0x1f/0xb0 [ib_uverbs]
>   __fput+0x9c/0x280
>   ____fput+0xe/0x20
>   task_work_run+0x6a/0xb0
>   do_exit+0x217/0x3c0
>   do_group_exit+0x3b/0xb0
>   get_signal+0x150/0x900
>   arch_do_signal_or_restart+0xde/0x100
>   exit_to_user_mode_loop+0xc4/0x160
>   exit_to_user_mode_prepare+0xa0/0xb0
>   syscall_exit_to_user_mode+0x27/0x50
>   do_syscall_64+0x63/0xb0
> 
> Fix the soft lockup by adding cond_resched() calls in __ib_umem_release, To
> minimize performance impact on releasing memory regions, introduce a
> RESCHED_THRESHOLD_ON_PAGE, call cond_resched() per it, and cond_resched()
> to be called during the very first iteration.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> diff v2: limit calling cond_resched per 4k

It is already too late for v3, because v2 was already merged.
Please send separate patch.

Thanks

> 
>  drivers/infiniband/core/umem.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index c5b6863..ff540a2 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -45,6 +45,8 @@
>  
>  #include "uverbs.h"
>  
> +#define RESCHED_LOOP_CNT_THRESHOLD 0x1000
> +
>  static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int dirty)
>  {
>  	bool make_dirty = umem->writable && dirty;
> @@ -55,10 +57,14 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
>  		ib_dma_unmap_sgtable_attrs(dev, &umem->sgt_append.sgt,
>  					   DMA_BIDIRECTIONAL, 0);
>  
> -	for_each_sgtable_sg(&umem->sgt_append.sgt, sg, i)
> +	for_each_sgtable_sg(&umem->sgt_append.sgt, sg, i) {
>  		unpin_user_page_range_dirty_lock(sg_page(sg),
>  			DIV_ROUND_UP(sg->length, PAGE_SIZE), make_dirty);
>  
> +		if (!(i % RESCHED_LOOP_CNT_THRESHOLD))
> +			cond_resched();
> +	}
> +
>  	sg_free_append_table(&umem->sgt_append);
>  }
>  
> -- 
> 2.9.4
> 

