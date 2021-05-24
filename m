Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA1B38DFCB
	for <lists+linux-rdma@lfdr.de>; Mon, 24 May 2021 05:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbhEXDQF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 May 2021 23:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbhEXDQF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 May 2021 23:16:05 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B16BC061574
        for <linux-rdma@vger.kernel.org>; Sun, 23 May 2021 20:14:37 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id z3so25862576oib.5
        for <linux-rdma@vger.kernel.org>; Sun, 23 May 2021 20:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fz4eiHpwcovbdUBMNu2GCt5zdgCLR5MCnROsFLysKW4=;
        b=V1Og/hEHrvnMyVAj3fin7elXgoEe3DNFi7TgrpT0zZbva8dfIhGFTOc8Ew2X2NYOno
         fbwkwxXjITOhBgtqUYON2f7M6xUb/YVzR6HGVabET6DLtSQ3VUoi5cUzR9gUvJUuETpS
         t/obGGlU6Yf8bvhWHu7glfXbbYrOhEZgf988wB/utP32fIbJwqxBn/7IA0HZOFtnwQdi
         pmo+iQWhiwsp1rkynT7MQbvYbZl3yTp84WCRfOhx0vIuRxiworCAxLKt+05OZRpu8hFr
         RawcHoip8eiGOZEN6ByxuPiW/nz1YxbdkwfeR7i9dFfu9CD4FgLnNuq16RWL+Dy6WUs5
         EqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fz4eiHpwcovbdUBMNu2GCt5zdgCLR5MCnROsFLysKW4=;
        b=mn+ULiD8iPxLe8hr1DBfDOAZ0kbc0yYn4G+raTylzkBVH0H/GrtAVIWfJ0ijjMrFHE
         562A0zytVqbW8NShYJUan554Mq96MmJYLmMtQwizggyXllWiXd0fIuXL7r/PkVpFrUbA
         plupM28UXQU+QQWWqHeDGgRzMpGHTP5czEJpTM9wDehb7F3g85Mg0LZvFWguH06uyYls
         NKC/pqqio9CgchdE3zH//BXPLWGGofMEBVwbPsJM0qQYP62mQxs61x0SgPLGG2rXj6hm
         erud+VhnqAIsLPHxlljqcpkVNjVDJY3RxSY7+vrYucG3kM8xi0layU0qxxysX4Mlb6kG
         OWww==
X-Gm-Message-State: AOAM532b1bPj/2e69vyF52x2FO+PXNSRtaYJNwYquyCqKz4nhEJtEWYR
        UIbEq/2TT0ULGxQG6htngV/9SR6ZN2vAEXDBdHnYoXBSZU8=
X-Google-Smtp-Source: ABdhPJylyLfx5eymiHcUg4bqhYUQKZ2Re0E00n/krn5qHVwmzPSRLBDRV6ke57azPqd9GMIQeqFFs0j+rdae+uDRsHQ=
X-Received: by 2002:aca:220b:: with SMTP id b11mr9371122oic.89.1621826076989;
 Sun, 23 May 2021 20:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210521201824.659565-1-rpearsonhpe@gmail.com>
In-Reply-To: <20210521201824.659565-1-rpearsonhpe@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 24 May 2021 11:14:26 +0800
Message-ID: <CAD=hENeKHgwLEOAsZ+2tu7M-+3Pv9QVccbWSwLy+zV-zX2h-bg@mail.gmail.com>
Subject: Re: [PATCH for-next v7 00/10] RDMA/rxe: Implement memory windows
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, May 22, 2021 at 4:19 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> This series of patches implement memory windows for the rdma_rxe
> driver. This is a shorter reimplementation of an earlier patch set.
> They apply to and depend on the current for-next linux rdma tree.
>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
> v7:
>   Fixed a duplicate INIT_RDMA_OBJ_SIZE(ib_mw, ...) in rxe_verbs.c.

With this patch series, there are about 17 errors and 1 failure in rdma-core.
"
----------------------------------------------------------------------
Ran 183 tests in 2.130s

FAILED (failures=1, errors=17, skipped=124)
"

After these patches, not sure if rxe can communicate with the physical
NICs correctly because of the
above errors and failure.

Zhu Yanjun

> v6:
>   Added rxe_ prefix to subroutine names in lines that changed
>   from Zhu's review of v5.
> v5:
>   Fixed a typo in 10th patch.
> v4:
>   Added a 10th patch to check when MRs have bound MWs
>   and disallow dereg and invalidate operations.
> v3:
>   cleaned up void return and lower case enums from
>   Zhu's review.
> v2:
>   cleaned up an issue in rdma_user_rxe.h
>   cleaned up a collision in rxe_resp.c
>
> Bob Pearson (9):
>   RDMA/rxe: Add bind MW fields to rxe_send_wr
>   RDMA/rxe: Return errors for add index and key
>   RDMA/rxe: Enable MW object pool
>   RDMA/rxe: Add ib_alloc_mw and ib_dealloc_mw verbs
>   RDMA/rxe: Replace WR_REG_MASK by WR_LOCAL_OP_MASK
>   RDMA/rxe: Move local ops to subroutine
>   RDMA/rxe: Add support for bind MW work requests
>   RDMA/rxe: Implement invalidate MW operations
>   RDMA/rxe: Implement memory access through MWs
>
>  drivers/infiniband/sw/rxe/Makefile     |   1 +
>  drivers/infiniband/sw/rxe/rxe.c        |   1 +
>  drivers/infiniband/sw/rxe/rxe_comp.c   |   1 +
>  drivers/infiniband/sw/rxe/rxe_loc.h    |  29 +-
>  drivers/infiniband/sw/rxe/rxe_mr.c     |  79 ++++--
>  drivers/infiniband/sw/rxe/rxe_mw.c     | 356 +++++++++++++++++++++++++
>  drivers/infiniband/sw/rxe/rxe_opcode.c |  11 +-
>  drivers/infiniband/sw/rxe/rxe_opcode.h |   3 +-
>  drivers/infiniband/sw/rxe/rxe_param.h  |  19 +-
>  drivers/infiniband/sw/rxe/rxe_pool.c   |  45 ++--
>  drivers/infiniband/sw/rxe/rxe_pool.h   |   8 +-
>  drivers/infiniband/sw/rxe/rxe_req.c    | 102 ++++---
>  drivers/infiniband/sw/rxe/rxe_resp.c   | 110 +++++---
>  drivers/infiniband/sw/rxe/rxe_verbs.c  |   5 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.h  |  38 ++-
>  include/uapi/rdma/rdma_user_rxe.h      |  34 ++-
>  16 files changed, 691 insertions(+), 151 deletions(-)
>  create mode 100644 drivers/infiniband/sw/rxe/rxe_mw.c
> --
> 2.27.0
>
