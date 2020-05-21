Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0BF1DDB62
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2020 01:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgEUXzW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 May 2020 19:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbgEUXzW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 May 2020 19:55:22 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2974DC061A0E
        for <linux-rdma@vger.kernel.org>; Thu, 21 May 2020 16:55:22 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id d7so6973936qtn.11
        for <linux-rdma@vger.kernel.org>; Thu, 21 May 2020 16:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K/C0vjc3terL6n3Ei1DWSKIxNY9tt+CLZlNErUeJfFk=;
        b=ibcKd42nrWnZEmwoXG65wIuLg9+45r3Oc6ywQOcEVyrOzouHXiy3tSm0oEUc40rV3T
         cAeuVOkDPg9Q5j48RRn08Q5yhzMYPdayWakK2s3FBj+/cIHjIwNkMch/Zfs11BFeJbef
         PiQNtu71veLpgolw5x/dw0FfMdVALPLe7ooRhDv7Is5Y5CYnDYxtFcNO/4wF8cuJKNRa
         7LNUdH4gD+JxjXFc93u33N7a96aHEgko0uqmFYBxoB0KvTTHggT29T3T5vyRrPCSxvY1
         0e1Y27bR2SPX/kjUUbEm+Sezci/V6/TzXEH0hv9tPdzj3mRPN5szVcn6yswqPdqFXQAK
         tQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K/C0vjc3terL6n3Ei1DWSKIxNY9tt+CLZlNErUeJfFk=;
        b=CUTOjcPAvZwvJ7EUv13Cjy2WowP+Q86hN4Ie0E8iQ4kezH0QqG2PnWeE4Ueb0yKX5t
         S0lwhcgnK+zzdsPi/WU+VHhyru/QqlxViQ2N/lO/wCuBgxeQ4KVImc1rJncGErehlzf3
         GBi5T/D99MCEIynovfm6/7iDx5jcyxbMF6rJakaMUWryWKU9RnVWme8gW2BSUKmrU1gc
         +oRrJr5MJrgdoDagIjunFIypYGQQf7TFDi79zFtTGZPXx/IuodnxUQcUWNos+GKnGilj
         +eRVKZdIn1MiM56y3gOotgCfy3rEBzwfSIiLQ0Pl9BLvF5h2AokXLnhzq/VCBfsr46m5
         ynEA==
X-Gm-Message-State: AOAM5331xUBfLJg1ukhUJSBbZudjIereVqlTg3jTbkFvCBe5I5E5FqGK
        IzZ875VQahKnNI+b6m5/KWsz2w==
X-Google-Smtp-Source: ABdhPJzB1Ip8CIGaZ2j9+2MZG4ZQXdwXdRKc51wTFlKKAOKTozr3vmkz5iML1giUpw3Ph2Gahfyp6Q==
X-Received: by 2002:ac8:1418:: with SMTP id k24mr13516511qtj.344.1590105321341;
        Thu, 21 May 2020 16:55:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id t130sm5938365qka.14.2020.05.21.16.55.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 May 2020 16:55:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jbv20-0004Me-GV; Thu, 21 May 2020 20:55:20 -0300
Date:   Thu, 21 May 2020 20:55:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix NULL pointer dereference in
 destroy_prefetch_work
Message-ID: <20200521235520.GA16710@ziepe.ca>
References: <20200521072504.567406-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521072504.567406-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 21, 2020 at 10:25:04AM +0300, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@mellanox.com>
> 
> q_deferred_work isn't initialized when user create an explicit ODP
> memory region. It could lead to NULL pointer dereference when user
> performs asynchronous prefetch MR.
> Fix it by initialize q_deferred_work for explicit ODP.
> 
> [ 2360.844536] BUG: kernel NULL pointer dereference, address:
> 0000000000000000
> [ 2360.855944] #PF: supervisor read access in kernel mode
> [ 2360.858276] #PF: error_code(0x0000) - not-present page
> [ 2360.860600] PGD 0 P4D 0
> [ 2360.861636] Oops: 0000 [#1] SMP PTI
> [ 2360.862781] CPU: 4 PID: 6074 Comm: kworker/u16:6 Not tainted
> 5.7.0-rc1-for-upstream-perf-2020-04-17_07-03-39-64 #1
> [ 2360.865369] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> [ 2360.868090] Workqueue: events_unbound mlx5_ib_prefetch_mr_work
> [mlx5_ib]
> [ 2360.869641] RIP: 0010:__wake_up_common+0x49/0x120
> [ 2360.870906] Code: 04 89 54 24 0c 89 4c 24 08 74 0a 41 f6 01 04 0f 85
> 8e 00 00 00 48 8b 47 08 48 83 e8 18 4c 8d 67 08 48 8d 50 18 49 39 d4 74
> 66 <48> 8b 70 18 31 db 4c 8d 7e e8 eb 17 49 8b 47 18 48 8d 50 e8 49 8d
> [ 2360.875211] RSP: 0000:ffffc9000097bd88 EFLAGS: 00010082
> [ 2360.876594] RAX: ffffffffffffffe8 RBX: ffff888454cd9f90 RCX:
> 0000000000000000
> [ 2360.878261] RDX: 0000000000000000 RSI: 0000000000000003 RDI:
> ffff888454cd9f90
> [ 2360.879930] RBP: ffffc9000097bdd0 R08: 0000000000000000 R09:
> ffffc9000097bdd0
> [ 2360.881593] R10: 0000000000000000 R11: 0000000000000001 R12:
> ffff888454cd9f98
> [ 2360.883291] R13: 0000000000000000 R14: 0000000000000000 R15:
> 0000000000000003
> [ 2360.884970] FS:  0000000000000000(0000) GS:ffff88846fd00000(0000)
> knlGS:0000000000000000
> [ 2360.887231] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2360.888656] CR2: 0000000000000000 CR3: 000000044c19e002 CR4:
> 0000000000760ee0
> [ 2360.890269] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [ 2360.891881] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400

Do not word wrap oops dumps, and please omit the valueless timestamps
as well.

> [ 2360.893489] PKRU: 55555554
> [ 2360.894504] Call Trace:
> [ 2360.895484]  __wake_up_common_lock+0x7a/0xc0
> [ 2360.896728]  destroy_prefetch_work+0x5a/0x60 [mlx5_ib]
> [ 2360.898106]  mlx5_ib_prefetch_mr_work+0x64/0x80 [mlx5_ib]
> [ 2360.899525]  process_one_work+0x15b/0x360
> [ 2360.900726]  worker_thread+0x49/0x3d0
> [ 2360.901879]  kthread+0xf5/0x130
> [ 2360.902961]  ? rescuer_thread+0x310/0x310
> [ 2360.904172]  ? kthread_bind+0x10/0x10
> [ 2360.905334]  ret_from_fork+0x1f/0x30
> 
> Fixes: de5ed007a03d ("IB/mlx5: Fix implicit ODP race")
> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/hw/mlx5/mr.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-rc, thanks

I added a cc stable

Jason
