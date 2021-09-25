Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC37C418053
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Sep 2021 10:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbhIYI2s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Sep 2021 04:28:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51958 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233126AbhIYI2s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 25 Sep 2021 04:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632558433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+GFjPHwO3IRceH9Q9kgti7i+99XJHC+0zBpJB0043aI=;
        b=CBZJC7+TwftW7BBqdWhR/5Y2K86RQJsMtkxq7M7Rw1yPDR+DIvps+BKWm2l/5rnY29tGa6
        EXOuRgO8R+52M4RbdoGAk/fV3lqnQZd4JM8Li9U4F3iMgx/n0R3bwd33bYhKy2s1HTvMyM
        nziJeJipyuu4ZmPsoRe/gf9l7n+BXDk=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-ckO1G-n2Pwyga3eJdEBBYQ-1; Sat, 25 Sep 2021 03:55:53 -0400
X-MC-Unique: ckO1G-n2Pwyga3eJdEBBYQ-1
Received: by mail-yb1-f197.google.com with SMTP id 81-20020a251254000000b005b6220d81efso5342570ybs.12
        for <linux-rdma@vger.kernel.org>; Sat, 25 Sep 2021 00:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+GFjPHwO3IRceH9Q9kgti7i+99XJHC+0zBpJB0043aI=;
        b=s9smMsbmfEHghejbTsIkn6H1L7jNN0E2v4RzKeuV6mLaUvs6hm/q9o+JHJWm8PLvUw
         YwIiivf+dZdtLCt2sjr8oaeF6ZfaQWFx28vtH6T+ZBfaTuZFoeb8Nm7EBaGeAKM8rhvQ
         WogYtzMCqNED9yXMts77qee/1sqC6HL8QzdWbwqqWeDKEwdsonxWaNoCq41xUhVT+IvY
         Fy2YjDjNzISzwITcbajidMkGBCmqj/ZNynkd3Kkz/yiq3aOalR8h0gUF3vh/YVey1ByM
         Zddjy/CCRp3EgppdMci3L2KGwuojTE3lKKDF/tH5mSJ2moQMbuRzGGUULog77tkK7TQe
         IYbA==
X-Gm-Message-State: AOAM531v84Lt6GJqbNlFTbLK640ppazaOLRp9NWhAbHWzZPD4RxxLnnc
        Ja3bg/mR/hV+FiNkCBRiuHikjZw2Nv8OlHZ/poP3I1/Yc++2RoiXVUsjqD4Aycn3yGVkEijR5xv
        1PdyJfPP6rMqloYWTuvGla7zDF3eJFGUHifvBdA==
X-Received: by 2002:a25:ce51:: with SMTP id x78mr1114523ybe.138.1632556552591;
        Sat, 25 Sep 2021 00:55:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0p/S9zyUem64FFcQbJJTdDohF3pB7zutMLvZe7bz2C6wZAkMhyVjfhp7AvptLbtIVBO0EEt//8VpWJ+K1JUk=
X-Received: by 2002:a25:ce51:: with SMTP id x78mr1114508ybe.138.1632556552323;
 Sat, 25 Sep 2021 00:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210914164206.19768-1-rpearsonhpe@gmail.com> <CAHj4cs_nO40bY0rDo8KB52QRCi4Qz6nVAQCSBJmgm84FtvM-BA@mail.gmail.com>
In-Reply-To: <CAHj4cs_nO40bY0rDo8KB52QRCi4Qz6nVAQCSBJmgm84FtvM-BA@mail.gmail.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Sat, 25 Sep 2021 15:55:40 +0800
Message-ID: <CAHj4cs9FL-RNR3NqEQ=mRNokU0D0+0xFHTghmzOp13J6MCZQ2A@mail.gmail.com>
Subject: Re: [PATCH for-rc v4 0/5] RDMA/rxe: Various bug fixes.
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>, mie@igel.co.jp,
        rao.shoaib@oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Bob/Sagi

Regarding the blktests nvme-rdma failure with rdma_rxe, I found the
patch[3] reduce the number of MRs and MWs to 4K from 256K, which lead
the nvme connect failed[1], if I change the "number of io queues to
use" to 31, it will works[2],
and the default io queues num is the CPU core count(mine is 48),
that's why it failed on my environment.

I also have tried revert patch[2], and the blktests run successfully
on my server, could we change back to 256K again?

[1]
# nvme connect -t rdma -a 10.16.221.74 -s 4420 -n testnqn  -i 32
Failed to write to /dev/nvme-fabrics: Cannot allocate memory
# dmesg
[  857.546927] nvmet: creating controller 1 for subsystem testnqn for
NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0030-4310-8058-b9c04f325732.
[  857.547640] nvme nvme0: creating 32 I/O queues.
[  857.595285] nvme nvme0: failed to initialize MR pool sized 128 for QID 32
[  857.602141] nvme nvme0: rdma connection establishment failed (-12)
[2]
# nvme connect -t rdma -a 10.16.221.74 -s 4420 -n testnqn  -i 31
# dmesg
[  863.792874] nvmet: creating controller 1 for subsystem testnqn for
NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0030-4310-8058-b9c04f325732.
[  863.793638] nvme nvme0: creating 31 I/O queues.
[  863.845594] nvme nvme0: mapped 31/0/0 default/read/poll queues.
[  863.853633] nvme nvme0: new ctrl: NQN "testnqn", addr 10.16.221.74:4420

[3]
commit af732adfacb2c6d886713624af2ff8e555c32aa4
Author: Bob Pearson <rpearsonhpe@gmail.com>
Date:   Mon Jun 7 23:25:46 2021 -0500

    RDMA/rxe: Enable MW object pool

    Currently the rxe driver has a rxe_mw struct object but nothing about
    memory windows is enabled. This patch turns on memory windows and some
    minor cleanup.

    Set device attribute in rxe.c so max_mw = MAX_MW.  Change parameters in
    rxe_param.h so that MAX_MW is the same as MAX_MR.  Reduce the number of
    MRs and MWs to 4K from 256K.  Add device capability bits for 2a and 2b
    memory windows.  Removed RXE_MR_TYPE_MW from the rxe_mr_type enum.



On Sat, Sep 18, 2021 at 10:13 AM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> Hi Bob
> With this patch serious, the blktests nvme-rdma still can be failed
> with the below error. and the test can be pass with siw.
>
> [ 1702.140090] loop0: detected capacity change from 0 to 2097152
> [ 1702.150729] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [ 1702.151425] nvmet_rdma: enabling port 0 (10.16.221.116:4420)
> [ 1702.158810] nvmet: creating controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0035-4b10-8044-b9c04f463333.
> [ 1702.159037] nvme nvme0: creating 32 I/O queues.
> [ 1702.171671] nvme nvme0: failed to initialize MR pool sized 128 for QID 32
> [ 1702.178482] nvme nvme0: rdma connection establishment failed (-12)
> [ 1702.292261] eno2 speed is unknown, defaulting to 1000
> [ 1702.297325] eno3 speed is unknown, defaulting to 1000
> [ 1702.302389] eno4 speed is unknown, defaulting to 1000
> [ 1702.317991] rdma_rxe: unloaded
>
> Failure from:
>         /*
>          * Currently we don't use SG_GAPS MR's so if the first entry is
>          * misaligned we'll end up using two entries for a single data page,
>          * so one additional entry is required.
>          */
>         pages_per_mr = nvme_rdma_get_max_fr_pages(ibdev, queue->pi_support) + 1;
>         ret = ib_mr_pool_init(queue->qp, &queue->qp->rdma_mrs,
>                               queue->queue_size,
>                               IB_MR_TYPE_MEM_REG,
>                               pages_per_mr, 0);
>         if (ret) {
>                 dev_err(queue->ctrl->ctrl.device,
>                         "failed to initialize MR pool sized %d for QID %d\n",
>                         queue->queue_size, nvme_rdma_queue_idx(queue));
>                 goto out_destroy_ring;
>         }
>
>
> On Wed, Sep 15, 2021 at 12:43 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> >
> > This series of patches implements several bug fixes and minor
> > cleanups of the rxe driver. Specifically these fix a bug exposed
> > by blktest.
> >
> > They apply cleanly to both
> > commit 1b789bd4dbd48a92f5427d9c37a72a8f6ca17754 (origin/for-rc)
> > commit 6a217437f9f5482a3f6f2dc5fcd27cf0f62409ac (origin/for-next)
> >
> > The first patch is a rewrite of an earlier patch.
> > It adds memory barriers to kernel to kernel queues. The logic for this
> > is the same as an earlier patch that only treated user to kernel queues.
> > Without this patch kernel to kernel queues are expected to intermittently
> > fail at low frequency as was seen for the other queues.
> >
> > The second patch cleans up the state and type enums used by MRs.
> >
> > The third patch separates the keys in rxe_mr and ib_mr. This allows
> > the following sequence seen in the srp driver to work correctly.
> >
> >         do {
> >                 ib_post_send( IB_WR_LOCAL_INV )
> >                 ib_update_fast_reg_key()
> >                 ib_map_mr_sg()
> >                 ib_post_send( IB_WR_REG_MR )
> >         } while ( !done )
> >
> > The fourth patch creates duplicate mapping tables for fast MRs. This
> > prevents rkeys referencing fast MRs from accessing data from an updated
> > map after the call to ib_map_mr_sg() call by keeping the new and old
> > mappings separate and atomically swapping them when a reg mr WR is
> > executed.
> >
> > The fifth patch checks the type of MRs which receive local or remote
> > invalidate operations to prevent invalidating user MRs.
> >
> > v3->v4:
> > Two of the patches in v3 were accepted in v5.15 so have been dropped
> > here.
> >
> > The first patch was rewritten to correctly deal with queue operations
> > in rxe_verbs.c where the code is the client and not the server.
> >
> > v2->v3:
> > The v2 version had a typo which broke clean application to for-next.
> > Additionally in v3 the order of the patches was changed to make
> > it a little cleaner.
> >
> > Bob Pearson (5):
> >   RDMA/rxe: Add memory barriers to kernel queues
> >   RDMA/rxe: Cleanup MR status and type enums
> >   RDMA/rxe: Separate HW and SW l/rkeys
> >   RDMA/rxe: Create duplicate mapping tables for FMRs
> >   RDMA/rxe: Only allow invalidate for appropriate MRs
> >
> >  drivers/infiniband/sw/rxe/rxe_comp.c  |  12 +-
> >  drivers/infiniband/sw/rxe/rxe_cq.c    |  25 +--
> >  drivers/infiniband/sw/rxe/rxe_loc.h   |   2 +
> >  drivers/infiniband/sw/rxe/rxe_mr.c    | 267 ++++++++++++++++-------
> >  drivers/infiniband/sw/rxe/rxe_mw.c    |  36 ++--
> >  drivers/infiniband/sw/rxe/rxe_qp.c    |  12 +-
> >  drivers/infiniband/sw/rxe/rxe_queue.c |  30 ++-
> >  drivers/infiniband/sw/rxe/rxe_queue.h | 292 +++++++++++---------------
> >  drivers/infiniband/sw/rxe/rxe_req.c   |  51 ++---
> >  drivers/infiniband/sw/rxe/rxe_resp.c  |  40 +---
> >  drivers/infiniband/sw/rxe/rxe_srq.c   |   2 +-
> >  drivers/infiniband/sw/rxe/rxe_verbs.c |  92 ++------
> >  drivers/infiniband/sw/rxe/rxe_verbs.h |  48 ++---
> >  13 files changed, 438 insertions(+), 471 deletions(-)
> >
> > --
> > 2.30.2
> >
>
>
> --
> Best Regards,
>   Yi Zhang



-- 
Best Regards,
  Yi Zhang

