Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79A52F0D15
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Jan 2021 08:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbhAKHFN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Jan 2021 02:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbhAKHFM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Jan 2021 02:05:12 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A811C061786
        for <linux-rdma@vger.kernel.org>; Sun, 10 Jan 2021 23:04:32 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id h16so17638357edt.7
        for <linux-rdma@vger.kernel.org>; Sun, 10 Jan 2021 23:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nd7RBr7nP50a5LSR+6S1jtsrRTvPj53l5Hws2Dj6pyA=;
        b=efcSWcfiezUvbN4WfjTlnZobo2X+l2c95Pt9TodN8YeTZ9a4d/pZOCZr88F1pLCZOz
         us3ITFfBKHdSHGYPYLulBWdf81JNmmC06iU+qcfb4ibDFSsyDFhCr+hQMWYq6aJXT1XE
         Gy4J7qzUB8kStSYmoM+nmTGBjnpxCKBmsPZ6Wv0MzdFN23h6Ucz7xNP6SJ+KFv6B5AOb
         /ODHb0UTIQddO7CkMY0BVi+knfjvO6hDtwfRq3oLrUlbsb1pcKKi0Ait+nc3utDZf+VD
         Pt/Tum1agWXsWWqLH/YDO623fO3ZbQhKmhovo7Tt9OEUT1NjCfsoRVijpqfPluDUFoTw
         /Jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nd7RBr7nP50a5LSR+6S1jtsrRTvPj53l5Hws2Dj6pyA=;
        b=O5c0PhuF9j+ZkE5dPTa9DhtXMVNKh81kqwYSgh+LN8yEyxwGIUJML8/eBgKET+2ztv
         rmss4BDbaCNpoozBBh1zHKW27vD0OJzBDE8kP8Dizu/ASCdxewrb1DRz43o2+/WjCo0N
         zYw4F5Ap1/sxcPNYRo0xZvKJpfxGna+8ekkolMX8TxrAsBTLAip6Y8XxV0G2SiYnEFxx
         aDGW53B+nlNYmC3rahw4dOqZye+0IRYxI/3DNXZLlVWjd81nC2vOErOrXOV6nv8ernF2
         dGOp/A7e/fdKzHFlNo9fNhf+QHnF8ME9UGJqNSD0NJU0fmroxxO+z0fBk/aKYwNpFgbo
         zmLw==
X-Gm-Message-State: AOAM5319qqg6+CbEuhwCUEhPDAHkKlx1yuLyFZZJLbBX9zqyegP4F3tO
        KojDKLho9aJa7/qvpDBhYiueaIwF2BLoKXrACKARcW32xi8=
X-Google-Smtp-Source: ABdhPJzE9qfvPoTUaXQu/UVlyHWha9qbKIxwJhgRGf5ce5tmO7yeuUkHbDyfAwiAKerwjS3FwAIQQPj32N009FAdlv4=
X-Received: by 2002:a05:6402:22b4:: with SMTP id cx20mr13171402edb.262.1610348670748;
 Sun, 10 Jan 2021 23:04:30 -0800 (PST)
MIME-Version: 1.0
References: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
In-Reply-To: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 11 Jan 2021 08:04:20 +0100
Message-ID: <CAMGffEnw3RLQWUP9uZ0P6-Yb0d6_S1ir7KEXF6xaQfTePdfEDg@mail.gmail.com>
Subject: Re: [PATCHv2 for-next 00/19] Misc update for rtrs
To:     linux-rdma@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 17, 2020 at 3:19 PM Jack Wang <jinpu.wang@cloud.ionos.com> wrote:
>
> Hi Jason, hi Doug,
>
> Please consider to include following changes to the next merge window.
>
> It contains a few bugfix and cleanup:
> - Fix memory leak incase of failure in kobj_init_and_add in both clt/srv
> - reduce memory footprint by set proper limit when create QP
> - fix missing wr_cqe in a few cases on srv, it could lead to crash in error
>   case.
> - remove the SIGNAL flag for heartbeat, otherwise it could mess around
> the send_wr_awail accouting.
> - flush on going session closing to release the memory presure on server.
> - other misc fix and cleanup.
>
> The patches are created based on rdma/for-next.
Hi Jason,

ping, any comments or do you need a resend/rebase?

Thanks!

>
> V2->V1
> * more descprition for the patches above as requested by Jason, also include
> Fixes tag for bugfix.
> * suppress the lockdep warning for PATCH 2 `Occasionally flush ongoing session closing`
> with comment.
> * new bugfix PATCH 19 RDMA/rtrs: Fix KASAN: stack-out-of-bounds bug
>
> Thanks!
>
> Guoqing Jiang (8):
>   RDMA/rtrs-srv: Jump to dereg_mr label if allocate iu fails
>   RDMA/rtrs: Call kobject_put in the failure path
>   RDMA/rtrs-clt: Consolidate rtrs_clt_destroy_sysfs_root_{folder,files}
>   RDMA/rtrs-clt: Kill wait_for_inflight_permits
>   RDMA/rtrs-clt: Remove unnecessary 'goto out'
>   RDMA/rtrs-clt: Kill rtrs_clt_change_state
>   RDMA/rtrs-clt: Rename __rtrs_clt_change_state to rtrs_clt_change_state
>   RDMA/rtrs-clt: Refactor the failure cases in alloc_clt
>
> Jack Wang (11):
>   RDMA/rtrs: Extend ibtrs_cq_qp_create
>   RMDA/rtrs-srv: Occasionally flush ongoing session closing
>   RDMA/rtrs-srv: Release lock before call into close_sess
>   RDMA/rtrs-srv: Use sysfs_remove_file_self for disconnect
>   RDMA/rtrs-clt: Set mininum limit when create QP
>   RDMA/rtrs-srv: Fix missing wr_cqe
>   RDMA/rtrs: Do not signal for heatbeat
>   RDMA/rtrs-clt: Use bitmask to check sess->flags
>   RDMA/rtrs-srv: Do not signal REG_MR
>   RDMA/rtrs-srv: Init wr_cnt as 1
>   RDMA/rtrs: Fix KASAN: stack-out-of-bounds bug
>
>  drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c |  11 +-
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 120 +++++++++----------
>  drivers/infiniband/ulp/rtrs/rtrs-clt.h       |   3 +-
>  drivers/infiniband/ulp/rtrs/rtrs-pri.h       |   5 +-
>  drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |   5 +-
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c       |  34 ++++--
>  drivers/infiniband/ulp/rtrs/rtrs.c           |  32 ++---
>  7 files changed, 110 insertions(+), 100 deletions(-)
>
> --
> 2.25.1
>
