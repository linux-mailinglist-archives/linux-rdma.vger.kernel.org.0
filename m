Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C98D98530A
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 20:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389057AbfHGShj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 14:37:39 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41652 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388207AbfHGShj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Aug 2019 14:37:39 -0400
Received: by mail-qt1-f196.google.com with SMTP id d17so10461448qtj.8
        for <linux-rdma@vger.kernel.org>; Wed, 07 Aug 2019 11:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EbcTVFfWVN5hMoX2cB+lmCWTOr0QKDPwewrmtAAyc1g=;
        b=HMIqsvoj5lOtm+MozeYLkfla12t0AvWWipoMnkIiQVDrTwAFJ2wE96Nku2XEwMQpix
         pLiED1iWLr74b94DuSkqtNZzOD8TiLa3+dWz+CWwn9LuLR/SV8BNd/0HTRFuw/LLP+DT
         iRWv31GQr1p6w6IUpwOYbGv+Rkbny1Mx/2ni5ri7Cli/dCduMghQk17OupQFbF/1V2BF
         owKLeOhHfOc7iNmgUbhm+82hBHz+kBKWe83mdIlVVQ8M+7FBTbuq4lJg8Opp8WejIRed
         AbhgZcZSB9ne7fiDQ6oK6dN296kiuWo0tW8SOam+L6M2FCA+YPC74GphAfv0gFWNy5vw
         Ab0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EbcTVFfWVN5hMoX2cB+lmCWTOr0QKDPwewrmtAAyc1g=;
        b=XWLsAGC1W3mLBIDn177uffzCO9g3CZTHPbm2uM2+YOGPP+PlmKZ2ttHPDNVT9/49So
         HVG7euFdj5Huq2CpUOmzhtEN74VK4+4Yw6QdsR0koI76J380rG+7XyhKClEpYCQ9MnoS
         z7B1g61/LozmflqTm88oyD0KxDhfz+6MhLL8DTNlbcnXlamDxqcdjLMvG02ivHB/2mQo
         aRMbXdR8zj5dqLptk23+bclbq+MTrn06htRwXyLdQlhkgfnHiZNaHDkvRTGaQ37Cs9cM
         b6EAu/mzfkmrzEqq4FEKIyEY9jr4uBawYRJDPKGjNyCXGl4uNGtg86HJoXMIuJUDynbN
         txEg==
X-Gm-Message-State: APjAAAVkbJ29snBAWvZVHwFq+G+0SSRs9i6/aPuMNT9mPOXFZmoK6zWK
        wBHd7M/pGiYSfK2hA+WuQKAyOA==
X-Google-Smtp-Source: APXvYqw/dhtLcMyMrYnvdYRpAL8RjYc3PY0kSKUVQMUoVRxZ/tFi0pzKpPxT3U8swv9J1R5FILDQaw==
X-Received: by 2002:ac8:4a9a:: with SMTP id l26mr9447109qtq.67.1565203058033;
        Wed, 07 Aug 2019 11:37:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 6sm43355291qkp.82.2019.08.07.11.37.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Aug 2019 11:37:37 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hvQoa-0006qa-Se; Wed, 07 Aug 2019 15:37:36 -0300
Date:   Wed, 7 Aug 2019 15:37:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-rc] IB/mlx5: Fix implicit MR release flow
Message-ID: <20190807183736.GA26235@ziepe.ca>
References: <20190805083010.21777-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805083010.21777-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 05, 2019 at 11:30:10AM +0300, Leon Romanovsky wrote:
> From: Yishai Hadas <yishaih@mellanox.com>
> 
> Once implicit MR is being called to be released by
> ib_umem_notifier_release() its leaves were marked as "dying".
> 
> However, when dereg_mr()->mlx5_ib_free_implicit_mr()->mr_leaf_free() is
> called, it skips running the mr_leaf_free_action (i.e. umem_odp->work)
> when those leaves were marked as "dying".
> 
> As such ib_umem_release() for the leaves won't be called and their MRs
> will be leaked as well.
> 
> When an application exits/killed without calling dereg_mr we might hit
> the above flow.
> 
> This fatal scenario is reported by WARN_ON() upon
> mlx5_ib_dealloc_ucontext() as ibcontext->per_mm_list is not empty, the
> call trace can be seen below.
> 
> Originally the "dying" mark as part of ib_umem_notifier_release() was
> introduced to prevent pagefault_mr() from returning a success response
> once this happened. However, we already have today the completion
> mechanism so no need for that in those flows any more.  Even in case a
> success response will be returned the firmware will not find the pages
> and an error will be returned in the following call as a released mm
> will cause ib_umem_odp_map_dma_pages() to permanently fail
> mmget_not_zero().
> 
> Fix the above issue by dropping the "dying" from the above flows.  The
> other flows that are using "dying" are still needed it for their
> synchronization purposes.
> 
> WARNING: CPU: 1 PID: 7218 at
> drivers/infiniband/hw/mlx5/main.c:2004
>                mlx5_ib_dealloc_ucontext+0x84/0x90 [mlx5_ib]
> CPU: 1 PID: 7218 Comm: ibv_rc_pingpong Tainted: G     E
>             5.2.0-rc6+ #13
> Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> RIP: 0010:mlx5_ib_dealloc_ucontext+0x84/0x90 [mlx5_ib]
> Code: 8d bd e8 09 00 00 48 89 de e8 58 a1 ff ff 48 8b bb
>       c8 00 00 00 e8 ec 8b 3a c9 48 8b bb d8 00 00 00 5b 5d 41
>       5c e9 dc 8b 3a c9 <0f> 0b eb a0 0f 1f 84 00 00 00 00 00
>       66 66 66 66 90 41 57 b9 09 00
> RSP: 0018:ffffb8e4c0adbc48 EFLAGS: 00010297
> RAX: ffff9e1a791a65b8 RBX: ffff9e1a643c1e00 RCX:
>      0000000000000000
> RDX: ffff9e1a643c1e40 RSI: 0000000000000246 RDI:
>      ffff9e1a643c1e20
> RBP: ffff9e1a75b70000 R08: 0000000000000000 R09:
>      ffff9e1a643c1e50
> R10: 0000000000000000 R11: 0000000000000001 R12:
>      ffff9e1a643c1e20
> R13: ffff9e1a5da6bc10 R14: ffff9e1a5da6bc70 R15:
>      ffff9e1a75b70000
> FS:  00007ff61835d740(0000) GS:ffff9e1a7bb00000(0000)
>      knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f9e6ac34000 CR3: 000000011e41e000 CR4:
>      00000000000006e0
> Call Trace:
> uverbs_destroy_ufile_hw+0xb5/0x120 [ib_uverbs]
> ib_uverbs_close+0x1f/0x80 [ib_uverbs]
> __fput+0xbe/0x250
> task_work_run+0x88/0xa0
> do_exit+0x2cb/0xc30
> ? __fput+0x14b/0x250
> do_group_exit+0x39/0xb0
> get_signal+0x191/0x920
> ? _raw_spin_unlock_bh+0xa/0x20
> ? inet_csk_accept+0x229/0x2f0
> do_signal+0x36/0x5e0
> ? put_unused_fd+0x5b/0x70
> ? __sys_accept4+0x1a6/0x1e0
> ? inet_hash+0x35/0x40
> ? release_sock+0x43/0x90
> ? _raw_spin_unlock_bh+0xa/0x20
> ? inet_listen+0x9f/0x120
> exit_to_usermode_loop+0x5c/0xc6
> do_syscall_64+0x182/0x1b0
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7ff617c807d0
> Code: Bad RIP value.
> RSP: 002b:00007ffd1f4f7c68 EFLAGS: 00000246 ORIG_RAX:
>      000000000000002b
> RAX: fffffffffffffe00 RBX: 00007ffd1f4f7dd0 RCX:
>      00007ff617c807d0
> RDX: 0000000000000000 RSI: 0000000000000000 RDI:
>      0000000000000005
> RBP: 00007ffd1f4f7fd0 R08: 0000000000000000 R09:
>      0000000001327f50
> R10: 00007ffd1f4f7830 R11: 0000000000000246 R12:
>      0000000001327600
> R13: 00007ffd1f4f7e10 R14: 0000000001327fb0 R15:
>      0000000000000005
> [ end trace 4fa29cb158fefa46 ]
> 
> Fixes: 81713d3788d2 ("IB/mlx5: Add implicit MR support")
> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
> Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/umem_odp.c |  4 ----
>  drivers/infiniband/hw/mlx5/odp.c   | 23 ++++++++---------------
>  2 files changed, 8 insertions(+), 19 deletions(-)

Applied to for-rc

Thanks,
Jason
