Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CC038F7EC
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 04:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhEYCKe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 May 2021 22:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhEYCKd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 May 2021 22:10:33 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3679C061574
        for <linux-rdma@vger.kernel.org>; Mon, 24 May 2021 19:09:03 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id t22-20020a4ad0b60000b029020fe239e804so4005982oor.4
        for <linux-rdma@vger.kernel.org>; Mon, 24 May 2021 19:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wxX/xxvXwzq/lNzNEWRQ1fBoQedddK0zMS97Mkf6JEA=;
        b=J2qeFm0MWpn+14Hp6pBZ/DrTGkeY52Q7hiijHwh3cJd4cA3/ys6kOmfbe828D+3BdD
         whqQOJZI/slf+ovWfvZeQyaUU1rfB5UC2FzMB4RcqOPb0RjpTvD7uLukKl0IeG8xHEN+
         U8/V4c/wjlsdphwEpNzL2Ooi+f2Aux0v4sdYCC9rvmEAm5uoSghrE8bOosSE/hkyfCg5
         QPA5RxPk0RRGBh7QllSWbH8LXSoIwE6bGG3HyBbDtFZUL3gUw3eztSaHFXqjYBttaeIP
         aDfdlt/OO3Epqgw5Ypl47H7uZzxNSGBUHwe0INNRBcAzWiOXSvumZKkd/ISbTfcleNRT
         cing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wxX/xxvXwzq/lNzNEWRQ1fBoQedddK0zMS97Mkf6JEA=;
        b=hgQ9LQwXWBallKRikPyJXRpEqOrjR0Z8d2CVXIOJh9ciyFwv09MOoh+Pd4gI/IS9Aw
         x/qdTzbqr4d6PvLPb30waMrkywlQCKhWlmxJvo7z++I26zWBKcbqzloNQ2mKdZSRP2sL
         TgPLH7tRKleIZUrOaQUnBXLkdgMLsa+atIakaYDYly0nYW5fGRLvXWIrF7jElPGTkX3l
         D1T+PFQz3fp9ab9LlCp9KHN2iicTup0H+aNdQNPYOR+eEPaKSBkjdTKqVov814dxDJSz
         HMspJbAclFHbY6me3SGlqQvgQkLJFwZUrHFOUs60KBk8/4yMKWqGYV49c23ckZw+6Mr5
         khXQ==
X-Gm-Message-State: AOAM531ZCz0BWOZRt0oYnSiMzd3OdyvRnMwxDbxZ2BeRMYk24aKjbpB+
        y3vEY1GNofJSoGp06lmC/svsOeAJt36U6lBk+0A=
X-Google-Smtp-Source: ABdhPJwtMAiN7FOHh7gomrO0t2WX3PNpARdpLlMvT8zGVQFldUvJnhPwB363+o+ch/Gxm8VoBa8nvf6avehA5WG8Ots=
X-Received: by 2002:a05:6820:54e:: with SMTP id n14mr20367897ooj.49.1621908543065;
 Mon, 24 May 2021 19:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210521201824.659565-1-rpearsonhpe@gmail.com>
 <CAD=hENeKHgwLEOAsZ+2tu7M-+3Pv9QVccbWSwLy+zV-zX2h-bg@mail.gmail.com> <dd81d60d-f4fa-feae-90a0-201ee995e07f@gmail.com>
In-Reply-To: <dd81d60d-f4fa-feae-90a0-201ee995e07f@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 25 May 2021 10:08:52 +0800
Message-ID: <CAD=hENeP=wh2gHAzkyi9KyZrKmDcmQeR3GB46Re-7ufL-CJqXw@mail.gmail.com>
Subject: Re: [PATCH for-next v7 00/10] RDMA/rxe: Implement memory windows
To:     "Pearson, Robert B" <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 25, 2021 at 12:04 AM Pearson, Robert B
<rpearsonhpe@gmail.com> wrote:
>
> On 5/23/2021 10:14 PM, Zhu Yanjun wrote:
> > On Sat, May 22, 2021 at 4:19 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> >> This series of patches implement memory windows for the rdma_rxe
> >> driver. This is a shorter reimplementation of an earlier patch set.
> >> They apply to and depend on the current for-next linux rdma tree.
> >>
> >> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> >> ---
> >> v7:
> >>    Fixed a duplicate INIT_RDMA_OBJ_SIZE(ib_mw, ...) in rxe_verbs.c.
> > With this patch series, there are about 17 errors and 1 failure in rdma-core.
>
> Zhu,
>
> You have to sync the kernel-header file with the kernel.

From the link https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/kbuild/headers_install.rst?h=v5.13-rc3
you mean "make headers_install"?

In fact, after "make headers_install", these patches still cause
errors and failures in rdma-core.

I will delve into these errors of rdma-core. Too many errors.

Zhu Yanjun

>
> Bob
>
> > "
> > ----------------------------------------------------------------------
> > Ran 183 tests in 2.130s
> >
> > FAILED (failures=1, errors=17, skipped=124)
> > "
> >
> > After these patches, not sure if rxe can communicate with the physical
> > NICs correctly because of the
> > above errors and failure.
> >
> > Zhu Yanjun
> >
> >> v6:
> >>    Added rxe_ prefix to subroutine names in lines that changed
> >>    from Zhu's review of v5.
> >> v5:
> >>    Fixed a typo in 10th patch.
> >> v4:
> >>    Added a 10th patch to check when MRs have bound MWs
> >>    and disallow dereg and invalidate operations.
> >> v3:
> >>    cleaned up void return and lower case enums from
> >>    Zhu's review.
> >> v2:
> >>    cleaned up an issue in rdma_user_rxe.h
> >>    cleaned up a collision in rxe_resp.c
> >>
> >> Bob Pearson (9):
> >>    RDMA/rxe: Add bind MW fields to rxe_send_wr
> >>    RDMA/rxe: Return errors for add index and key
> >>    RDMA/rxe: Enable MW object pool
> >>    RDMA/rxe: Add ib_alloc_mw and ib_dealloc_mw verbs
> >>    RDMA/rxe: Replace WR_REG_MASK by WR_LOCAL_OP_MASK
> >>    RDMA/rxe: Move local ops to subroutine
> >>    RDMA/rxe: Add support for bind MW work requests
> >>    RDMA/rxe: Implement invalidate MW operations
> >>    RDMA/rxe: Implement memory access through MWs
> >>
> >>   drivers/infiniband/sw/rxe/Makefile     |   1 +
> >>   drivers/infiniband/sw/rxe/rxe.c        |   1 +
> >>   drivers/infiniband/sw/rxe/rxe_comp.c   |   1 +
> >>   drivers/infiniband/sw/rxe/rxe_loc.h    |  29 +-
> >>   drivers/infiniband/sw/rxe/rxe_mr.c     |  79 ++++--
> >>   drivers/infiniband/sw/rxe/rxe_mw.c     | 356 +++++++++++++++++++++++++
> >>   drivers/infiniband/sw/rxe/rxe_opcode.c |  11 +-
> >>   drivers/infiniband/sw/rxe/rxe_opcode.h |   3 +-
> >>   drivers/infiniband/sw/rxe/rxe_param.h  |  19 +-
> >>   drivers/infiniband/sw/rxe/rxe_pool.c   |  45 ++--
> >>   drivers/infiniband/sw/rxe/rxe_pool.h   |   8 +-
> >>   drivers/infiniband/sw/rxe/rxe_req.c    | 102 ++++---
> >>   drivers/infiniband/sw/rxe/rxe_resp.c   | 110 +++++---
> >>   drivers/infiniband/sw/rxe/rxe_verbs.c  |   5 +-
> >>   drivers/infiniband/sw/rxe/rxe_verbs.h  |  38 ++-
> >>   include/uapi/rdma/rdma_user_rxe.h      |  34 ++-
> >>   16 files changed, 691 insertions(+), 151 deletions(-)
> >>   create mode 100644 drivers/infiniband/sw/rxe/rxe_mw.c
> >> --
> >> 2.27.0
> >>
