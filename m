Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42B84102E9
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Sep 2021 04:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239473AbhIRCO6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Sep 2021 22:14:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30504 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236883AbhIRCO5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Sep 2021 22:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631931213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tjitqpwTy38JoaIHBb+NnNSDVnoAnWMVKTXpp/9lEug=;
        b=WmovUBkqK3L++pKJlK6jc6I95Y0ttLsHdcd7cyGNw8VRy+HnlVTGzV/iy59T89xsfOTVm8
        1xb6nCMQwwWSTzw1ze8PSyl3Fbw1UyNidEFhM/QrMWB6PnixvpGamGVdCGTk/kiICbcMVw
        aYVM4JKBr29XqHBj9S/0PX1ykD75RVs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-UwzQtMGMPqSMLEqGBhNdiA-1; Fri, 17 Sep 2021 22:13:32 -0400
X-MC-Unique: UwzQtMGMPqSMLEqGBhNdiA-1
Received: by mail-qv1-f70.google.com with SMTP id l18-20020a056214039200b0037e4da8b408so101967090qvy.6
        for <linux-rdma@vger.kernel.org>; Fri, 17 Sep 2021 19:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjitqpwTy38JoaIHBb+NnNSDVnoAnWMVKTXpp/9lEug=;
        b=rldqM1BCVV9Bq1piYqvbT66CyY4nIUTAjBJRmsv6neqqL1GkEn5XsvfkgdV7CzvmgX
         qfctegzfYOc4TgWSPX+3IhbsPbQs740noD6vkcRywkZuYNNrTiIbQxf+Dveaa7J5bkhQ
         F0NbljbiS1cLkLvMe8ob8KSNfdl2NMnJ9MnKkSgPMBHs+7c6X8q+zkDsgaimS+FoRKDp
         51OgQd+vLGwuGHwcnGvai+eMprglltCJmLD88rkRy0wjmfVbtmDtja5n3Y1G5k2YZAsD
         +Bp0dSedt7fywj5d34mt8UvUVIhcbchRADgevGbrtdZZyzWMi5jQjdx6k4rfQrhut1Ii
         2R4g==
X-Gm-Message-State: AOAM530rpsGlIijM3AuyRNACjK6o37kz/nmlMrJ7vmFQbN2PH1FIXf9l
        AU09rIGpCNIcONuwNlkgq10gUwFDd2LmNLlcEyWvFYpIJH8MC3g1lHzgSOYVDQdzP0zruetNZhh
        +tkp+O4ltdJxSKAvnNikNvqhzG8V1CPYQCopfxg==
X-Received: by 2002:a05:6902:56d:: with SMTP id a13mr17900950ybt.512.1631931211967;
        Fri, 17 Sep 2021 19:13:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwp+4RMPSjX2Qu8VDE5/WGLG6n+nrkO88J0ayjq7ilWiMXqq2My2ElLdlLAowuEr+tc+REKTe7ZK87U8wTHW/I=
X-Received: by 2002:a05:6902:56d:: with SMTP id a13mr17900926ybt.512.1631931211739;
 Fri, 17 Sep 2021 19:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210914164206.19768-1-rpearsonhpe@gmail.com>
In-Reply-To: <20210914164206.19768-1-rpearsonhpe@gmail.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Sat, 18 Sep 2021 10:13:19 +0800
Message-ID: <CAHj4cs_nO40bY0rDo8KB52QRCi4Qz6nVAQCSBJmgm84FtvM-BA@mail.gmail.com>
Subject: Re: [PATCH for-rc v4 0/5] RDMA/rxe: Various bug fixes.
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>, mie@igel.co.jp,
        rao.shoaib@oracle.com, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Bob
With this patch serious, the blktests nvme-rdma still can be failed
with the below error. and the test can be pass with siw.

[ 1702.140090] loop0: detected capacity change from 0 to 2097152
[ 1702.150729] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1702.151425] nvmet_rdma: enabling port 0 (10.16.221.116:4420)
[ 1702.158810] nvmet: creating controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0035-4b10-8044-b9c04f463333.
[ 1702.159037] nvme nvme0: creating 32 I/O queues.
[ 1702.171671] nvme nvme0: failed to initialize MR pool sized 128 for QID 32
[ 1702.178482] nvme nvme0: rdma connection establishment failed (-12)
[ 1702.292261] eno2 speed is unknown, defaulting to 1000
[ 1702.297325] eno3 speed is unknown, defaulting to 1000
[ 1702.302389] eno4 speed is unknown, defaulting to 1000
[ 1702.317991] rdma_rxe: unloaded

Failure from:
        /*
         * Currently we don't use SG_GAPS MR's so if the first entry is
         * misaligned we'll end up using two entries for a single data page,
         * so one additional entry is required.
         */
        pages_per_mr = nvme_rdma_get_max_fr_pages(ibdev, queue->pi_support) + 1;
        ret = ib_mr_pool_init(queue->qp, &queue->qp->rdma_mrs,
                              queue->queue_size,
                              IB_MR_TYPE_MEM_REG,
                              pages_per_mr, 0);
        if (ret) {
                dev_err(queue->ctrl->ctrl.device,
                        "failed to initialize MR pool sized %d for QID %d\n",
                        queue->queue_size, nvme_rdma_queue_idx(queue));
                goto out_destroy_ring;
        }


On Wed, Sep 15, 2021 at 12:43 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> This series of patches implements several bug fixes and minor
> cleanups of the rxe driver. Specifically these fix a bug exposed
> by blktest.
>
> They apply cleanly to both
> commit 1b789bd4dbd48a92f5427d9c37a72a8f6ca17754 (origin/for-rc)
> commit 6a217437f9f5482a3f6f2dc5fcd27cf0f62409ac (origin/for-next)
>
> The first patch is a rewrite of an earlier patch.
> It adds memory barriers to kernel to kernel queues. The logic for this
> is the same as an earlier patch that only treated user to kernel queues.
> Without this patch kernel to kernel queues are expected to intermittently
> fail at low frequency as was seen for the other queues.
>
> The second patch cleans up the state and type enums used by MRs.
>
> The third patch separates the keys in rxe_mr and ib_mr. This allows
> the following sequence seen in the srp driver to work correctly.
>
>         do {
>                 ib_post_send( IB_WR_LOCAL_INV )
>                 ib_update_fast_reg_key()
>                 ib_map_mr_sg()
>                 ib_post_send( IB_WR_REG_MR )
>         } while ( !done )
>
> The fourth patch creates duplicate mapping tables for fast MRs. This
> prevents rkeys referencing fast MRs from accessing data from an updated
> map after the call to ib_map_mr_sg() call by keeping the new and old
> mappings separate and atomically swapping them when a reg mr WR is
> executed.
>
> The fifth patch checks the type of MRs which receive local or remote
> invalidate operations to prevent invalidating user MRs.
>
> v3->v4:
> Two of the patches in v3 were accepted in v5.15 so have been dropped
> here.
>
> The first patch was rewritten to correctly deal with queue operations
> in rxe_verbs.c where the code is the client and not the server.
>
> v2->v3:
> The v2 version had a typo which broke clean application to for-next.
> Additionally in v3 the order of the patches was changed to make
> it a little cleaner.
>
> Bob Pearson (5):
>   RDMA/rxe: Add memory barriers to kernel queues
>   RDMA/rxe: Cleanup MR status and type enums
>   RDMA/rxe: Separate HW and SW l/rkeys
>   RDMA/rxe: Create duplicate mapping tables for FMRs
>   RDMA/rxe: Only allow invalidate for appropriate MRs
>
>  drivers/infiniband/sw/rxe/rxe_comp.c  |  12 +-
>  drivers/infiniband/sw/rxe/rxe_cq.c    |  25 +--
>  drivers/infiniband/sw/rxe/rxe_loc.h   |   2 +
>  drivers/infiniband/sw/rxe/rxe_mr.c    | 267 ++++++++++++++++-------
>  drivers/infiniband/sw/rxe/rxe_mw.c    |  36 ++--
>  drivers/infiniband/sw/rxe/rxe_qp.c    |  12 +-
>  drivers/infiniband/sw/rxe/rxe_queue.c |  30 ++-
>  drivers/infiniband/sw/rxe/rxe_queue.h | 292 +++++++++++---------------
>  drivers/infiniband/sw/rxe/rxe_req.c   |  51 ++---
>  drivers/infiniband/sw/rxe/rxe_resp.c  |  40 +---
>  drivers/infiniband/sw/rxe/rxe_srq.c   |   2 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.c |  92 ++------
>  drivers/infiniband/sw/rxe/rxe_verbs.h |  48 ++---
>  13 files changed, 438 insertions(+), 471 deletions(-)
>
> --
> 2.30.2
>


-- 
Best Regards,
  Yi Zhang

