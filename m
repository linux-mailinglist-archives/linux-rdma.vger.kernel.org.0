Return-Path: <linux-rdma+bounces-14461-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E12DCC572E7
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 12:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79FE84E3C34
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 11:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040F933BBA6;
	Thu, 13 Nov 2025 11:27:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1098433F381
	for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 11:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033269; cv=none; b=Yjauwv2chfpRm8dGq932spVtrMkEhtPNTNtRagn6G5KTQCXp1sfDW2mrnB6ujC253EvvzKbjXYI3TfZzMbY/pfSud02B7f0hab2nahktqlPPbulVIyel9vYIvXBJT/mkbNgYVLszEYpkMV8PZ+tZ1Civ807uJlbEzXh8oPA8bHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033269; c=relaxed/simple;
	bh=dFtiDGz2KxFul2YF+9mqRdNElyQbFSC2bJZ601rTn6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FGsXmv8gjQahLyjRbgtGk+AuaKD8ZREre+Jm+FApoAzlcsNM14ldnkl9AQzugwuvbfNuhq+gO6gUDVXWO0oeyHkkt796W9Ma8PWpCvKX4amBhXUxmaptv7I+98dQ3f0wlh5aHwA35AnsvkVzrRvtM2gyV6XKGuUb0Ezi5lkKTWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4d6dHn3TbCzmVCN;
	Thu, 13 Nov 2025 19:25:57 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id C031D1A016C;
	Thu, 13 Nov 2025 19:27:37 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Nov 2025 19:27:37 +0800
Message-ID: <7f1305c4-e0e8-9988-3ac2-6c81a1917e97@hisilicon.com>
Date: Thu, 13 Nov 2025 19:27:36 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH][v2] RDMA/core: Prevent soft lockup during large user
 memory region cleanup
To: lirongqing <lirongqing@baidu.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, <linux-rdma@vger.kernel.org>
References: <20251113095317.2628-1-lirongqing@baidu.com>
Content-Language: en-US
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20251113095317.2628-1-lirongqing@baidu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2025/11/13 17:53, lirongqing wrote:
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
> Fix soft lockup issues by incorporating cond_resched() calls within
> __ib_umem_release(), and this SG entries are typically grouped in 2MB
> chunks on x86_64, adding cond_resched() should has minimal performance
> impact.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> diff v1: move the cond_sched into loop, add the calling trace to change log
> 
>  drivers/infiniband/core/umem.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index c5b6863..8fd84aa 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -55,9 +55,11 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
>  		ib_dma_unmap_sgtable_attrs(dev, &umem->sgt_append.sgt,
>  					   DMA_BIDIRECTIONAL, 0);
>  
> -	for_each_sgtable_sg(&umem->sgt_append.sgt, sg, i)
> +	for_each_sgtable_sg(&umem->sgt_append.sgt, sg, i) {
>  		unpin_user_page_range_dirty_lock(sg_page(sg),
>  			DIV_ROUND_UP(sg->length, PAGE_SIZE), make_dirty);
> +		cond_resched();
> +	}

Acked-by: Junxian Huang <huangjunxian6@hisilicon.com>

>  
>  	sg_free_append_table(&umem->sgt_append);
>  }

