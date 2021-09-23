Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15D241655E
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Sep 2021 20:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242727AbhIWSvj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Sep 2021 14:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242714AbhIWSvj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Sep 2021 14:51:39 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EFAC061574
        for <linux-rdma@vger.kernel.org>; Thu, 23 Sep 2021 11:50:07 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id eg28so26723049edb.1
        for <linux-rdma@vger.kernel.org>; Thu, 23 Sep 2021 11:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VfyAOW/TjlY6N1+98k6Y0GL9rICXJQFAERBJjkS5rtg=;
        b=hBHjkNy6EBc41bDKMaFoTQ0yQB2WzCIe3eCz6hHrxWjYDSMC+91HExBxDItsvqjLQs
         dWVF72a1pRnoBIAMS7Dk0nspVr3I6HW7pqxty5kZwB3QOh9KvRyivH32odDrw+Gt4gzb
         zP+0XEP66A/M8CAgIkj+mTwIa33AA8hj65xoiIpC0If/icXvV65KBZErAEnib5Lo3cQ7
         Z2225IsQbp1iW8IU0KtqWDmWlejCyMdlDkYXoMLf8QmhoBRewf7aElwnzoQsi9mybzpt
         in3cpgnne0fPoARnYuu1I6RXxoW5kja1i18IVAyRyDW9e9McKPFmX1ND23wMCYij8o/c
         9tBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VfyAOW/TjlY6N1+98k6Y0GL9rICXJQFAERBJjkS5rtg=;
        b=xzafTxlNPfSil3jVqrpzrRiaxZIBRDC48Q+z0rt5tqVXMU5KsojGXLSl427nCRpQc6
         cx73Mf6JiqnvokaWzJgIaoxSgFoxHD7tKtH5ptXFIbR2u7QxUaFbkPDPbf1NbvAF9FZX
         uZHjHWvx1A9M2v+3FDCMB+Ay5r3QMNa2hYz1w/aq094AcPmFQPE0lir8FTKRMJTh38jJ
         OyrTo7P//8qng4hz9Sn2EMLaHhqACXORCzbsm+pEz6FlYE57Xo9UVZKdDUde7oM/htLI
         5tDkpXMnLdgPpbNiGbljWDP61LfCMY4y7ibNmij59kukSWHxTqYLxkTLg18r86QPpvKb
         Gb8A==
X-Gm-Message-State: AOAM530TKfuV4qksWeAOM7agUPeBL2x4SkdZpCBUYxTYVr2x+vSdQ+Lh
        /NMEAhf3sVJ6HoPWq3lIBC/v2nRdNz0A+k/ED5g=
X-Google-Smtp-Source: ABdhPJyyigHUjt8jtfsrBbNtWEotJ2OUI1pN9UcWmfhrWIn5zCO+yYYL7bGDFWGqRlhumCemvgdCxO1+11I2Vj2NRc8=
X-Received: by 2002:a17:906:64a:: with SMTP id t10mr6898146ejb.5.1632423005407;
 Thu, 23 Sep 2021 11:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210914164206.19768-1-rpearsonhpe@gmail.com>
In-Reply-To: <20210914164206.19768-1-rpearsonhpe@gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 23 Sep 2021 14:49:54 -0400
Message-ID: <CAN-5tyF6vJQEK3+FJ44+7T223nMqs_dSXYKOKz-fPJ=3OHK12Q@mail.gmail.com>
Subject: Re: [PATCH for-rc v4 0/5] RDMA/rxe: Various bug fixes.
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        linux-rdma <linux-rdma@vger.kernel.org>, bvanassche@acm.org,
        mie@igel.co.jp, rao.shoaib@oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 14, 2021 at 12:49 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
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

Hi Bob,

After applying these patches only top of 5.15-rc1. rping and mount
NFSoRDMA works.

Thank you.

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
