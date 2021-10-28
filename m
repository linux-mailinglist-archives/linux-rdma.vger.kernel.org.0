Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BAB43DE5E
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Oct 2021 12:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhJ1KEQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Oct 2021 06:04:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229768AbhJ1KEP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 28 Oct 2021 06:04:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C802610D2;
        Thu, 28 Oct 2021 10:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635415309;
        bh=ubPglQKi5qdBB7SW3jvzjMWfQ4c3OQdkzH2VTgO6jIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fs0Ps9edZXXwYmlk9scnkTeYgMV0YQMxxFarPmCa+GlVOOGKS75n0Q8S64CkmeXxo
         IBCKGsLZ0fWZUqaXO22jpD0SyA1/AHed25JWb0b6cPCqSq7wZ+4dUjde0Zwvra7MXe
         +qk3PGEqetlW/+jZhWEyjk8iRJFVs9vBVXc2kCez+Phe/ZQ3tKcvvob9qdjYcFPHR/
         dEyT+wQ9mc22qYoMASq17h6QmPbdN5N/SJfCJ/Rc0+jyjxl64YhThMX0Abs9kc7FEQ
         clurJt8hbO8cYT4fxI+kZGJSh4NneABtZ3Wl4gTfMCN81Ochh2Eij6uD4FWYhYcviF
         VKbEW5WgZ1WTQ==
Date:   Thu, 28 Oct 2021 13:01:45 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Aharon Landau <aharonl@nvidia.com>
Subject: Re: [PATCH for-next] RDMA/bnxt_re: Fix kernel panic when trying to
 access bnxt_re_stat_descs
Message-ID: <YXp1CTujf9ZCToEq@unreal>
References: <20211027205448.127821-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027205448.127821-1-kamalheib1@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 27, 2021 at 11:54:48PM +0300, Kamal Heib wrote:
> For some reason when introducing 13f30b0fa0a9 commit the "active_pds" and
> "active_ahs" descriptors got dropped, which lead to the following panic
> when trying to access the first entry in the descriptors. Avoid this by
> return the dropped hunks.
> 
>  bnxt_re: Broadcom NetXtreme-C/E RoCE Driver
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: 0000 [#1] SMP PTI
>  CPU: 2 PID: 594 Comm: kworker/u32:1 Not tainted 5.15.0-rc6+ #2
>  Hardware name: Dell Inc. PowerEdge R430/0CN7X8, BIOS 2.12.1 12/07/2020
>  Workqueue: bnxt_re bnxt_re_task [bnxt_re]
>  RIP: 0010:strlen+0x0/0x20
>  Code: 48 89 f9 74 09 48 83 c1 01 80 39 00 75 f7 31 d2 44 0f b6 04 16 44 88 04 11 48 83 c2 01 45 84 c0 75 ee c3 0f 1f 80 00 00 00 00 <80> 3f 00 74 10 48 89 f8 48 83 c0 01 80 31
>  RSP: 0018:ffffb25fc47dfbb0 EFLAGS: 00010246
>  RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000008100
>  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>  RBP: 0000000000000000 R08: 00000000fffffff4 R09: 0000000000000000
>  R10: ffff8a05c71fc028 R11: 0000000000000000 R12: 0000000000000000
>  R13: 0000000000000000 R14: 0000000000000000 R15: ffff8a05c3dee800
>  FS:  0000000000000000(0000) GS:ffff8a092fc40000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000000 CR3: 000000048d3da001 CR4: 00000000001706e0
>  Call Trace:
>   kernfs_name_hash+0x12/0x80
>   kernfs_find_ns+0x35/0xd0
>   kernfs_remove_by_name_ns+0x32/0x90
>   remove_files+0x2b/0x60
>   create_files+0x1d3/0x1f0
>   internal_create_group+0x17b/0x1f0
>   internal_create_groups.part.0+0x3d/0xa0
>   setup_port+0x180/0x3b0 [ib_core]
>   ? __cond_resched+0x16/0x40
>   ? kmem_cache_alloc_trace+0x278/0x3d0
>   ib_setup_port_attrs+0x99/0x240 [ib_core]
>   ib_register_device+0xcc/0x160 [ib_core]
>   bnxt_re_task+0xba/0x170 [bnxt_re]
>   process_one_work+0x1eb/0x390
>   worker_thread+0x53/0x3d0
>   ? process_one_work+0x390/0x390
>   kthread+0x10f/0x130
>   ? set_kthread_struct+0x40/0x40
>   ret_from_fork+0x22/0x30
>  Modules linked in: bnxt_re kvm ib_uverbs dell_wmi_descriptor rfkill video iTCO_wdt iTCO_vendor_support irqbypass dcdbas ib_core ipmi_ssif rapl intel_cstate intel_uncore pcspke
>  CR2: 0000000000000000
>  ---[ end trace b4637e4c4e3001af ]---
>  RIP: 0010:strlen+0x0/0x20
>  Code: 48 89 f9 74 09 48 83 c1 01 80 39 00 75 f7 31 d2 44 0f b6 04 16 44 88 04 11 48 83 c2 01 45 84 c0 75 ee c3 0f 1f 80 00 00 00 00 <80> 3f 00 74 10 48 89 f8 48 83 c0 01 80 31
>  RSP: 0018:ffffb25fc47dfbb0 EFLAGS: 00010246
>  RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000008100
>  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>  RBP: 0000000000000000 R08: 00000000fffffff4 R09: 0000000000000000
>  R10: ffff8a05c71fc028 R11: 0000000000000000 R12: 0000000000000000
>  R13: 0000000000000000 R14: 0000000000000000 R15: ffff8a05c3dee800
>  FS:  0000000000000000(0000) GS:ffff8a092fc40000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000000 CR3: 000000048d3da001 CR4: 00000000001706e0
>  Kernel panic - not syncing: Fatal exception
>  Kernel Offset: 0x400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>  ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> Fixes: 13f30b0fa0a9 ("RDMA/counter: Add a descriptor in struct rdma_hw_stats")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/bnxt_re/hw_counters.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Sorry about that.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
