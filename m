Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB7B43DDEE
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Oct 2021 11:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhJ1Jpu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Oct 2021 05:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhJ1Jpt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Oct 2021 05:45:49 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9EFC061570
        for <linux-rdma@vger.kernel.org>; Thu, 28 Oct 2021 02:43:22 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w15so22342655edc.9
        for <linux-rdma@vger.kernel.org>; Thu, 28 Oct 2021 02:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l/0caq6KPNtSQRMuHM1eQnEPyktaXAXkEDQm8eWlGOg=;
        b=KENIjg9u8W4t3apwQdmj8L5L4hbJ77w8/0XPvBFy8K+mKh9GxznDd8AfvyJMA1eLzX
         crUYuquiUJ7v9OFcyuKK6nuWrYr2XQKgcpfQ0o6NE/GEY6mW48bp6tzsgBFfMdSv3uMt
         ZozbuiXUJ7hKkh6p1VtgheAXK84CFY37H5LlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l/0caq6KPNtSQRMuHM1eQnEPyktaXAXkEDQm8eWlGOg=;
        b=NqHMa2t9Im8apT1pdC9Y9wdkzsqGlIJrKOFRCYcmhPju1OwOHf4hqYsdnzZJfUeo2+
         jvy4CjgOCNl533JWydJ35CpOwbSZLlT7U2KXtpGhl/LXXItVgkjML7Nrz86phJv9yfmU
         ouoJr6exAu0zdkOAV4C1y4MCRURJ7SO+XVYaVk/vKtoqy9202pm+GNNLy1pBYpS57fN2
         oJ06zzBe7uWBBkRCzlGmxw3DcoyD/lyC0hLeHwYK6L1J5LCKBnp8rD427XGIc3mdwleD
         w7opyx/P2twAoVNVETi4gl5mR1yONmhlaAyDHkdVPIQYAla79pKRlbsN4Gk2xX7JXE4N
         dlsg==
X-Gm-Message-State: AOAM5320EGRNEmaO3MTXK+IzKoIIEoGHrsnyI7x4R/ks+meVt++wi/aC
        7scaeIgR0O2OvVEXfaZ96+0f+v5MdTYZMMqEFNM+RA==
X-Google-Smtp-Source: ABdhPJwKPs1+F21hPypLm3rni3ZgL0FD0lST/Y1ZiyV6oZkGOZeCIbrc4KqftcSFmTYfhMh6uTAq3ueSfjyz/B0a0tY=
X-Received: by 2002:aa7:cd88:: with SMTP id x8mr4582960edv.203.1635414201312;
 Thu, 28 Oct 2021 02:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211027205448.127821-1-kamalheib1@gmail.com>
In-Reply-To: <20211027205448.127821-1-kamalheib1@gmail.com>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Thu, 28 Oct 2021 15:13:10 +0530
Message-ID: <CA+sbYW3MymtycTVQXorA=Y16znkKWRv+t6Pa2BrfYrU3yBrUqQ@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/bnxt_re: Fix kernel panic when trying to
 access bnxt_re_stat_descs
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Aharon Landau <aharonl@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 28, 2021 at 2:25 AM Kamal Heib <kamalheib1@gmail.com> wrote:
>
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

Thanks Kamal.

Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>


>  drivers/infiniband/hw/bnxt_re/hw_counters.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.c b/drivers/infiniband/hw/bnxt_re/hw_counters.c
> index 78ca6dfd182b..825d512799d9 100644
> --- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
> +++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
> @@ -58,6 +58,8 @@
>  #include "hw_counters.h"
>
>  static const struct rdma_stat_desc bnxt_re_stat_descs[] = {
> +       [BNXT_RE_ACTIVE_PD].name                =  "active_pds",
> +       [BNXT_RE_ACTIVE_AH].name                =  "active_ahs",
>         [BNXT_RE_ACTIVE_QP].name                =  "active_qps",
>         [BNXT_RE_ACTIVE_SRQ].name               =  "active_srqs",
>         [BNXT_RE_ACTIVE_CQ].name                =  "active_cqs",
> --
> 2.31.1
>
