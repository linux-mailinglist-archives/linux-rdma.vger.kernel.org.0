Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016882E308C
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Dec 2020 10:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgL0JCE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Dec 2020 04:02:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:52832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgL0JCE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Dec 2020 04:02:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F69020796;
        Sun, 27 Dec 2020 09:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609059683;
        bh=TwQp8oH/h/s/E+lcIEL5+GMtgnFtE6sgYCpHGAB3jTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MZ3SwFHRogGbNJLsjSd83vzXpRc9ma4w2+MT/txyu5tqt5AfC7ApcNnASMYoQkpg1
         n2qqGq3tc3vrrWVE4m3fIO+hXrC51WaFnoGAsKuRqesxX2ceu17jFg670ElBP7v8Oa
         l0FhwOv88nBqCDprQFKWcp4w9SPN4YAzqJM+CSpnNpra22V86rGepdatFo3tot/2MU
         J0Ix+jUeLfibgqZzDEAC0pZZS2Wr2eW5XVTTJC8dQDpiM0N5dwdXKDqH2kWRhrGD9q
         SkxPD49BYDsqevcvpevmWVZetb3NCfVFTBDiyhNnk+E8oXplgAlcsc3tl/ByOmVpoQ
         HM3unkDxZ244w==
Date:   Sun, 27 Dec 2020 11:01:18 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Jack Wang <xjtuwjp@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Doug Ledford <dledford@redhat.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 02/18] RMDA/rtrs-srv: Occasionally flush ongoing
 session closing
Message-ID: <20201227090118.GG4457@unreal>
References: <CAMGffE=_axtHU=pAV3qx5FVY2pB786z3kffQwDzinOaH=yS5Ag@mail.gmail.com>
 <e841a2c3-2774-ca8f-302a-cd43c3b3161e@cloud.ionos.com>
 <CAMGffEmKAzy3dXVKhoZDAqLpZ6DiQiaYNQn8_0Fd+MQUXbn_eA@mail.gmail.com>
 <20201211072600.GA192848@unreal>
 <CAMGffEn4fbTud3qrrwnrS6bqxcpF6sueKb=Qke8N9yLvDeEWpA@mail.gmail.com>
 <CAMGffEnuNHacxqqdZsF0JMk3kTUqT9KdzNK_QzBF_FWjPWLN8Q@mail.gmail.com>
 <20201211134543.GB5487@ziepe.ca>
 <CAD+HZHXso=S5c=MqgrmDMZpWi10FbPTinWPfLMTkMCCiosihCQ@mail.gmail.com>
 <20201211162900.GC5487@ziepe.ca>
 <CAMGffEm22sP-oKK0D9=vOw77nbS05iwG7MC3DTVB0CyzVFhtXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMGffEm22sP-oKK0D9=vOw77nbS05iwG7MC3DTVB0CyzVFhtXg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 16, 2020 at 05:42:17PM +0100, Jinpu Wang wrote:
> On Fri, Dec 11, 2020 at 5:29 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Fri, Dec 11, 2020 at 05:17:36PM +0100, Jack Wang wrote:
> > >    En, the lockdep was complaining about the new conn_id, I will
> > >    post the full log if needed next week.  let’s skip this patch for
> > >    now, will double check!
> >
> > That is even more worrysome as the new conn_id already has a different
> > lock class.
> >
> > Jason
> This is the dmesg of the LOCKDEP warning, it's on kernel 5.4.77, but
> the latest 5.10 behaves the same.
>
> [  500.071552] ======================================================
> [  500.071648] WARNING: possible circular locking dependency detected
> [  500.071869] 5.4.77-storage+ #35 Tainted: G           O
> [  500.071959] ------------------------------------------------------
> [  500.072054] kworker/1:1/28 is trying to acquire lock:
> [  500.072200] ffff99653a624390 (&id_priv->handler_mutex){+.+.}, at:
> rdma_destroy_id+0x55/0x230 [rdma_cm]
> [  500.072837]
>                but task is already holding lock:
> [  500.072938] ffff9d18800f7e80
> ((work_completion)(&sess->close_work)){+.+.}, at:
> process_one_work+0x223/0x600
> [  500.075642]
>                which lock already depends on the new lock.
>
> [  500.075759]
>                the existing dependency chain (in reverse order) is:
> [  500.075880]
>                -> #3 ((work_completion)(&sess->close_work)){+.+.}:
> [  500.076062]        process_one_work+0x278/0x600
> [  500.076154]        worker_thread+0x2d/0x3d0
> [  500.076225]        kthread+0x111/0x130
> [  500.076290]        ret_from_fork+0x24/0x30
> [  500.076370]
>                -> #2 ((wq_completion)rtrs_server_wq){+.+.}:
> [  500.076482]        flush_workqueue+0xab/0x4b0
> [  500.076565]        rtrs_srv_rdma_cm_handler+0x71d/0x1500 [rtrs_server]
> [  500.076674]        cma_ib_req_handler+0x8c4/0x14f0 [rdma_cm]
> [  500.076770]        cm_process_work+0x22/0x140 [ib_cm]
> [  500.076857]        cm_req_handler+0x900/0xde0 [ib_cm]
> [  500.076944]        cm_work_handler+0x136/0x1af2 [ib_cm]
> [  500.077025]        process_one_work+0x29f/0x600
> [  500.077097]        worker_thread+0x2d/0x3d0
> [  500.077164]        kthread+0x111/0x130
> [  500.077224]        ret_from_fork+0x24/0x30
> [  500.077294]
>                -> #1 (&id_priv->handler_mutex/1){+.+.}:
> [  500.077409]        __mutex_lock+0x7e/0x950
> [  500.077488]        cma_ib_req_handler+0x787/0x14f0 [rdma_cm]
> [  500.077582]        cm_process_work+0x22/0x140 [ib_cm]
> [  500.077669]        cm_req_handler+0x900/0xde0 [ib_cm]
> [  500.077755]        cm_work_handler+0x136/0x1af2 [ib_cm]
> [  500.077835]        process_one_work+0x29f/0x600
> [  500.077907]        worker_thread+0x2d/0x3d0
> [  500.077973]        kthread+0x111/0x130
> [  500.078034]        ret_from_fork+0x24/0x30
> [  500.078095]
>                -> #0 (&id_priv->handler_mutex){+.+.}:
> [  500.078196]        __lock_acquire+0x1166/0x1440
> [  500.078267]        lock_acquire+0x90/0x170
> [  500.078335]        __mutex_lock+0x7e/0x950
> [  500.078410]        rdma_destroy_id+0x55/0x230 [rdma_cm]
> [  500.078498]        rtrs_srv_close_work+0xf2/0x2d0 [rtrs_server]
> [  500.078586]        process_one_work+0x29f/0x600
> [  500.078662]        worker_thread+0x2d/0x3d0
> [  500.078732]        kthread+0x111/0x130
> [  500.078793]        ret_from_fork+0x24/0x30
> [  500.078859]
>                other info that might help us debug this:
>
> [  500.078984] Chain exists of:
>                  &id_priv->handler_mutex -->
> (wq_completion)rtrs_server_wq --> (work_completion)(&sess->close_work)
>
> [  500.079207]  Possible unsafe locking scenario:
>
> [  500.079293]        CPU0                    CPU1
> [  500.079358]        ----                    ----
> [  500.079358]   lock((work_completion)(&sess->close_work));
> [  500.079358]
> lock((wq_completion)rtrs_server_wq);
> [  500.079358]
> lock((work_completion)(&sess->close_work));
> [  500.079358]   lock(&id_priv->handler_mutex);
> [  500.079358]
>                 *** DEADLOCK ***
>
> [  500.079358] 2 locks held by kworker/1:1/28:
> [  500.079358]  #0: ffff99652d281f28
> ((wq_completion)rtrs_server_wq){+.+.}, at:
> process_one_work+0x223/0x600
> [  500.079358]  #1: ffff9d18800f7e80
> ((work_completion)(&sess->close_work)){+.+.}, at:
> process_one_work+0x223/0x600
> [  500.079358]
>                stack backtrace:
> [  500.079358] CPU: 1 PID: 28 Comm: kworker/1:1 Tainted: G           O
>      5.4.77-storage+ #35
> [  500.079358] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.10.2-1ubuntu1 04/01/2014
> [  500.079358] Workqueue: rtrs_server_wq rtrs_srv_close_work [rtrs_server]
> [  500.079358] Call Trace:
> [  500.079358]  dump_stack+0x71/0x9b
> [  500.079358]  check_noncircular+0x17d/0x1a0
> [  500.079358]  ? __lock_acquire+0x1166/0x1440
> [  500.079358]  __lock_acquire+0x1166/0x1440
> [  500.079358]  lock_acquire+0x90/0x170
> [  500.079358]  ? rdma_destroy_id+0x55/0x230 [rdma_cm]
> [  500.079358]  ? rdma_destroy_id+0x55/0x230 [rdma_cm]
> [  500.079358]  __mutex_lock+0x7e/0x950
> [  500.079358]  ? rdma_destroy_id+0x55/0x230 [rdma_cm]
> [  500.079358]  ? find_held_lock+0x2d/0x90
> [  500.079358]  ? mark_held_locks+0x49/0x70
> [  500.079358]  ? rdma_destroy_id+0x55/0x230 [rdma_cm]
> [  500.079358]  rdma_destroy_id+0x55/0x230 [rdma_cm]
> [  500.079358]  rtrs_srv_close_work+0xf2/0x2d0 [rtrs_server]
> [  500.079358]  process_one_work+0x29f/0x600
> [  500.079358]  worker_thread+0x2d/0x3d0
> [  500.079358]  ? process_one_work+0x600/0x600
> [  500.079358]  kthread+0x111/0x130
> [  500.079358]  ? kthread_park+0x90/0x90
> [  500.079358]  ret_from_fork+0x24/0x30
>
> According to my understanding
> in cma_ib_req_handler, the conn_id is newly created in
> https://elixir.bootlin.com/linux/latest/source/drivers/infiniband/core/cma.c#L2222.
> And the rdma_cm_id associated with conn_id is passed to
> rtrs_srv_rdma_cm_handler->rtrs_rdma_connect.
>
> In rtrs_rdma_connect, we do flush_workqueue will only flush close_work
> for any other cm_id, but
> not the newly created one conn_id, it has not associated with anything yet.

How did you come to this conclusion that rtrs handler was called before
cma_cm_event_handler()? I'm not so sure about that and it will explain
the lockdep.

Thanks

>
> The same applies to nvme-rdma. so it's a false alarm by lockdep.
>
> Regards!
