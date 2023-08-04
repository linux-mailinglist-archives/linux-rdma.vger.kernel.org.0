Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A098E76FEB9
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Aug 2023 12:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjHDKox (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Aug 2023 06:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjHDKos (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Aug 2023 06:44:48 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AE349C3;
        Fri,  4 Aug 2023 03:44:46 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3E07932004CE;
        Fri,  4 Aug 2023 06:44:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 04 Aug 2023 06:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691145883; x=1691232283; bh=5K
        VBfdwlrDZxwIIRGmoNBH6YnC5ESzexzoRqpWv1xrc=; b=PSk2cUnCKp09Of3fvU
        qz5XQYWc9vxPZVNdH4EvpfykSMhDLSR9zcTbPJvR2emN//qavArtK/ojYCdeUFfu
        iMTuYreM+XagnocVW3TArZvG2ebdMZVAd+Udpaku7X/uOqxl7/QeMmoM0DVfnnMO
        syUXYyrfPwdMt9NoGpuJ0l4hkzn+pvOiUj5ZVzGIeTlTidkJx1tJ53VYtdWmcXxI
        S8JxiZE5AZOjsF6EMzOQQSYdFMVjibcjf2B6TOajS6frM3iLRvUGZdZBMQatUx4A
        G2NdlAwLkvquvbsWv5rDaMs3uU6vrBWhvQr2ew5pV1wXvVgf0C5ayL4bgSFLIgVZ
        WMoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691145883; x=1691232283; bh=5KVBfdwlrDZxw
        IIRGmoNBH6YnC5ESzexzoRqpWv1xrc=; b=0e3bPJeKn0a2ZrFzwCDRobdZWJE9T
        aOWjgmFZtQzxJo7quRkqIaNVSLPGLwXdkidCR5QYng+j1iNUVTLSgwBpCgesza9U
        +rPNKryiTZJnv97OBLrUxItmjZYHKG8Xu5XmYjmJgJwwtsm/Sj5CyHEhEkuQ3OEF
        eIXEJkq4TcWJPObpmhFAK7DiqAqAYTCECEfzLcol4JVCGFHRyZSTrNYjSjDknEo6
        NRKWbH7icmUZnZHG1Rx2zjoM3EwyViKZmmx1syMn4mLaSNu6rr7DI1lBHae22i22
        St5fUxjwQEoPFkq11mQTKRBdBT2gNoDc3K6eomMRatFh9LydNCzge7Rmg==
X-ME-Sender: <xms:m9bMZA6Kwvx2uu0t4ZMZ8EUkGMopMIMFRt9DgZ6MXS-F4gNe8wtfTg>
    <xme:m9bMZB54uxczWpnE0DrSmyVq0Yi4wdfZLypagi3f-dXbbvRYfwW0gkMXxg7lxWnWO
    86MGsnMuAFY1Q>
X-ME-Received: <xmr:m9bMZPdwxT_4EkRhwF0YfrGpxSwhmpYTbSNgcVfFb4nvLB837ogq7zMx8MMGumnao3Q47dwP54ROrrv-3MBkObmj3OG7ru8eZDmj0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkeeggdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhe
    fgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:m9bMZFJvJiW70aCFvidR3yCLgjAXt8XTSIRNFgbqKvFY61owkER0dw>
    <xmx:m9bMZELWPFFwKqrA9jbLOpOago6nj933UCk_Oj0Kp8CocX0UiyFRTw>
    <xmx:m9bMZGwiJYEtuGou0SkB2XvQqOO-7XOosyNCuLyYNaM3gQp1KAHSkQ>
    <xmx:m9bMZJAA3_JEasiVknHDnpG69XVCbjILMy7ezuPldI-LibBCSED4gw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Aug 2023 06:44:42 -0400 (EDT)
Date:   Fri, 4 Aug 2023 12:44:39 +0200
From:   Greg KH <greg@kroah.com>
To:     Hardik Garg <hargar@linux.microsoft.com>
Cc:     stable@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        shayd@nvidia.com, saeedm@nvidia.com, fred@cloudflare.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1 5.15] net/mlx5: Free irqs only on shutdown callback
Message-ID: <2023080429-shelf-truce-7fed@gregkh>
References: <20230803192832.22966-1-hargar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803192832.22966-1-hargar@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 03, 2023 at 07:28:32PM +0000, Hardik Garg wrote:
> commit 9c2d08010963 ("net/mlx5: Free irqs only on shutdown callback")
> backport this v6.4 commit to v6.1 and v5.15
> 
> Whenever a shutdown is invoked, free irqs only and keep mlx5_irq
> synthetic wrapper intact in order to avoid use-after-free on
> system shutdown.
> 
> for example:
> ==================================================================
> BUG: KASAN: use-after-free in _find_first_bit+0x66/0x80
> Read of size 8 at addr ffff88823fc0d318 by task kworker/u192:0/13608
> 
> CPU: 25 PID: 13608 Comm: kworker/u192:0 Tainted: 
> G    B   W  O  6.1.21-cloudflare-kasan-2023.3.21 #1
> Hardware name: GIGABYTE R162-R2-GEN0/MZ12-HD2-CD, BIOS R14 05/03/2021
> Workqueue: mlx5e mlx5e_tx_timeout_work [mlx5_core]
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x34/0x48
>   print_report+0x170/0x473
>   ? _find_first_bit+0x66/0x80
>   kasan_report+0xad/0x130
>   ? _find_first_bit+0x66/0x80
>   _find_first_bit+0x66/0x80
>   mlx5e_open_channels+0x3c5/0x3a10 [mlx5_core]
>   ? console_unlock+0x2fa/0x430
>   ? _raw_spin_lock_irqsave+0x8d/0xf0
>   ? _raw_spin_unlock_irqrestore+0x42/0x80
>   ? preempt_count_add+0x7d/0x150
>   ? __wake_up_klogd.part.0+0x7d/0xc0
>   ? vprintk_emit+0xfe/0x2c0
>   ? mlx5e_trigger_napi_sched+0x40/0x40 [mlx5_core]
>   ? dev_attr_show.cold+0x35/0x35
>   ? devlink_health_do_dump.part.0+0x174/0x340
>   ? devlink_health_report+0x504/0x810
>   ? mlx5e_reporter_tx_timeout+0x29d/0x3a0 [mlx5_core]
>   ? mlx5e_tx_timeout_work+0x17c/0x230 [mlx5_core]
>   ? process_one_work+0x680/0x1050
>   mlx5e_safe_switch_params+0x156/0x220 [mlx5_core]
>   ? mlx5e_switch_priv_channels+0x310/0x310 [mlx5_core]
>   ? mlx5_eq_poll_irq_disabled+0xb6/0x100 [mlx5_core]
>   mlx5e_tx_reporter_timeout_recover+0x123/0x240 [mlx5_core]
>   ? __mutex_unlock_slowpath.constprop.0+0x2b0/0x2b0
>   devlink_health_reporter_recover+0xa6/0x1f0
>   devlink_health_report+0x2f7/0x810
>   ? vsnprintf+0x854/0x15e0
>   mlx5e_reporter_tx_timeout+0x29d/0x3a0 [mlx5_core]
>   ? mlx5e_reporter_tx_err_cqe+0x1a0/0x1a0 [mlx5_core]
>   ? mlx5e_tx_reporter_timeout_dump+0x50/0x50 [mlx5_core]
>   ? mlx5e_tx_reporter_dump_sq+0x260/0x260 [mlx5_core]
>   ? newidle_balance+0x9b7/0xe30
>   ? psi_group_change+0x6a7/0xb80
>   ? mutex_lock+0x96/0xf0
>   ? __mutex_lock_slowpath+0x10/0x10
>   mlx5e_tx_timeout_work+0x17c/0x230 [mlx5_core]
>   process_one_work+0x680/0x1050
>   worker_thread+0x5a0/0xeb0
>   ? process_one_work+0x1050/0x1050
>   kthread+0x2a2/0x340
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork+0x22/0x30
>   </TASK>
> 
> Freed by task 1:
>   kasan_save_stack+0x23/0x50
>   kasan_set_track+0x21/0x30
>   kasan_save_free_info+0x2a/0x40
>   ____kasan_slab_free+0x169/0x1d0
>   slab_free_freelist_hook+0xd2/0x190
>   __kmem_cache_free+0x1a1/0x2f0
>   irq_pool_free+0x138/0x200 [mlx5_core]
>   mlx5_irq_table_destroy+0xf6/0x170 [mlx5_core]
>   mlx5_core_eq_free_irqs+0x74/0xf0 [mlx5_core]
>   shutdown+0x194/0x1aa [mlx5_core]
>   pci_device_shutdown+0x75/0x120
>   device_shutdown+0x35c/0x620
>   kernel_restart+0x60/0xa0
>   __do_sys_reboot+0x1cb/0x2c0
>   do_syscall_64+0x3b/0x90
>   entry_SYSCALL_64_after_hwframe+0x4b/0xb5
> 
> The buggy address belongs to the object at ffff88823fc0d300
>   which belongs to the cache kmalloc-192 of size 192
> The buggy address is located 24 bytes inside of
>   192-byte region [ffff88823fc0d300, ffff88823fc0d3c0)
> 
> The buggy address belongs to the physical page:
> page:0000000010139587 refcount:1 mapcount:0 mapping:0000000000000000
> index:0x0 pfn:0x23fc0c
> head:0000000010139587 order:1 compound_mapcount:0 compound_pincount:0
> flags: 0x2ffff800010200(slab|head|node=0|zone=2|lastcpupid=0x1ffff)
> raw: 002ffff800010200 0000000000000000 dead000000000122 ffff88810004ca00
> raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>   ffff88823fc0d200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff88823fc0d280: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>  >ffff88823fc0d300: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                              ^
>   ffff88823fc0d380: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>   ffff88823fc0d400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================
> general protection fault, probably for non-canonical address
> 0xdffffc005c40d7ac: 0000 [#1] PREEMPT SMP KASAN NOPTI
> KASAN: probably user-memory-access in range 
> [0x00000002e206bd60-0x00000002e206bd67]
> CPU: 25 PID: 13608 Comm: kworker/u192:0 Tainted: 
> G    B   W  O  6.1.21-cloudflare-kasan-2023.3.21 #1
> Hardware name: GIGABYTE R162-R2-GEN0/MZ12-HD2-CD, BIOS R14 05/03/2021
> Workqueue: mlx5e mlx5e_tx_timeout_work [mlx5_core]
> RIP: 0010:__alloc_pages+0x141/0x5c0
> Call Trace:
>   <TASK>
>   ? sysvec_apic_timer_interrupt+0xa0/0xc0
>   ? asm_sysvec_apic_timer_interrupt+0x16/0x20
>   ? __alloc_pages_slowpath.constprop.0+0x1ec0/0x1ec0
>   ? _raw_spin_unlock_irqrestore+0x3d/0x80
>   __kmalloc_large_node+0x80/0x120
>   ? kvmalloc_node+0x4e/0x170
>   __kmalloc_node+0xd4/0x150
>   kvmalloc_node+0x4e/0x170
>   mlx5e_open_channels+0x631/0x3a10 [mlx5_core]
>   ? console_unlock+0x2fa/0x430
>   ? _raw_spin_lock_irqsave+0x8d/0xf0
>   ? _raw_spin_unlock_irqrestore+0x42/0x80
>   ? preempt_count_add+0x7d/0x150
>   ? __wake_up_klogd.part.0+0x7d/0xc0
>   ? vprintk_emit+0xfe/0x2c0
>   ? mlx5e_trigger_napi_sched+0x40/0x40 [mlx5_core]
>   ? dev_attr_show.cold+0x35/0x35
>   ? devlink_health_do_dump.part.0+0x174/0x340
>   ? devlink_health_report+0x504/0x810
>   ? mlx5e_reporter_tx_timeout+0x29d/0x3a0 [mlx5_core]
>   ? mlx5e_tx_timeout_work+0x17c/0x230 [mlx5_core]
>   ? process_one_work+0x680/0x1050
>   mlx5e_safe_switch_params+0x156/0x220 [mlx5_core]
>   ? mlx5e_switch_priv_channels+0x310/0x310 [mlx5_core]
>   ? mlx5_eq_poll_irq_disabled+0xb6/0x100 [mlx5_core]
>   mlx5e_tx_reporter_timeout_recover+0x123/0x240 [mlx5_core]
>   ? __mutex_unlock_slowpath.constprop.0+0x2b0/0x2b0
>   devlink_health_reporter_recover+0xa6/0x1f0
>   devlink_health_report+0x2f7/0x810
>   ? vsnprintf+0x854/0x15e0
>   mlx5e_reporter_tx_timeout+0x29d/0x3a0 [mlx5_core]
>   ? mlx5e_reporter_tx_err_cqe+0x1a0/0x1a0 [mlx5_core]
>   ? mlx5e_tx_reporter_timeout_dump+0x50/0x50 [mlx5_core]
>   ? mlx5e_tx_reporter_dump_sq+0x260/0x260 [mlx5_core]
>   ? newidle_balance+0x9b7/0xe30
>   ? psi_group_change+0x6a7/0xb80
>   ? mutex_lock+0x96/0xf0
>   ? __mutex_lock_slowpath+0x10/0x10
>   mlx5e_tx_timeout_work+0x17c/0x230 [mlx5_core]
>   process_one_work+0x680/0x1050
>   worker_thread+0x5a0/0xeb0
>   ? process_one_work+0x1050/0x1050
>   kthread+0x2a2/0x340
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork+0x22/0x30
>   </TASK>
> ---[ end trace 0000000000000000  ]---
> RIP: 0010:__alloc_pages+0x141/0x5c0
> Code: e0 39 a3 96 89 e9 b8 22 01 32 01 83 e1 0f 48 89 fa 01 c9 48 c1 ea
> 03 d3 f8 83 e0 03 89 44 24 6c 48 b8 00 00 00 00 00 fc ff df <80> 3c 02
> 00 0f 85 fc 03 00 00 89 e8 4a 8b 14 f5 e0 39 a3 96 4c 89
> RSP: 0018:ffff888251f0f438 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 1ffff1104a3e1e8b RCX: 0000000000000000
> RDX: 000000005c40d7ac RSI: 0000000000000003 RDI: 00000002e206bd60
> RBP: 0000000000052dc0 R08: ffff8882b0044218 R09: ffff8882b0045e8a
> R10: fffffbfff300fefc R11: ffff888167af4000 R12: 0000000000000003
> R13: 0000000000000000 R14: 00000000696c7070 R15: ffff8882373f4380
> FS:  0000000000000000(0000) GS:ffff88bf2be80000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005641d031eee8 CR3: 0000002e7ca14000 CR4: 0000000000350ee0
> Kernel panic - not syncing: Fatal exception
> Kernel Offset: 0x11000000 from 0xffffffff81000000 (relocation range:
> 0xffffffff80000000-0xffffffffbfffffff)
> ---[ end Kernel panic - not syncing: Fatal exception  ]---]
> 
> Reported-by: Frederick Lawler <fred@cloudflare.com>
> Link: https://lore.kernel.org/netdev/be5b9271-7507-19c5-ded1-fa78f1980e69@cloudflare.com
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> [hardik: Refer to the irqn member of the mlx5_irq struct, instead of
>  the msi_map, since we don't have upstream v6.4 commit 235a25fe28de
>  ("net/mlx5: Modify struct mlx5_irq to use struct msi_map")].
> [hardik: Refer to the pf_pool member of the mlx5_irq_table struct,
>  instead of pcif_pool, since we don't have upstream v6.4 commit
>  8bebfd767909 ("net/mlx5: Improve naming of pci function vectors")].

Now queued up, thanks.

greg k-h
