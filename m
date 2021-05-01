Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA193705C9
	for <lists+linux-rdma@lfdr.de>; Sat,  1 May 2021 07:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhEAFzQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 1 May 2021 01:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhEAFzQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 1 May 2021 01:55:16 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA00BC06174A
        for <linux-rdma@vger.kernel.org>; Fri, 30 Apr 2021 22:54:26 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id g7-20020a9d5f870000b02902a5831ad705so475712oti.10
        for <linux-rdma@vger.kernel.org>; Fri, 30 Apr 2021 22:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BdrdkG2buR98/XsoY0bg8+4HID966W4iA6FNgoKxPq8=;
        b=fSRM/QZtIzA1NX4oyOPqlDZ1ToD89nbqwisu0tpVmtXfBgXw43JL+fEarG3YqPBbi5
         LkRERWYRF/Y37b/Q7h/qWLo5ToScaeDWqBtu8iMRR2zptVxG7Sy+JWxzGqmVTAOa6pWR
         6hC7SBiOKq4IJcB00dc0Jfb+Q9Sn1av9ZNT3tp4CJPSpxwKO4w9hvzkMa1Wk7rjGbNhH
         J3518E3tjGntEeOWc9p1WChGo2c2nv64aD/VQaQTBpA40gHSu+hd+TLjAbSDnrocJWKx
         /cpfFbWGbxl8AuGve8zIcmgAy1FivOQJS9dqutArkr25ialIjwDkJszP/7fvx01EnBvq
         rQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BdrdkG2buR98/XsoY0bg8+4HID966W4iA6FNgoKxPq8=;
        b=lNPjhYCmaS2oS8SrRJOAGzOht2qbwGy9WuI0Y1QlGvDdfFHsMds7ZZ3DBZhaqv7Iol
         Fj47mxrVxqR/iKkXo6i7WW3lrn2LvtuOqJ2+tqr5sfGURW1y9gB6Jxv2G20ykR/KO05B
         WclPmu3kO14gKbr+rmN7krL+IBfB38abpS72nY435dS/pxs9YbwZKckaqTY74nNrtlaX
         odpuxpliLKIK8ut0Ffl/TMClh33j+YeG0aBUT1USNeQXYnzSXhpHHp5UkXIl0T/eEGRe
         QFQsY+RCvhe6qtZleUAKq/jl5aGrtZY2ANR6sV/jlkYvQ2oOGFbYbtYe7035cjRZYu2u
         YIog==
X-Gm-Message-State: AOAM530N8dReeH2qwgnTmhOve/lCMpvFQ6GkWBPhgQe1eM53VPO5Wyfs
        igPdj7Y2UrsfuoqohQZBRX8XLFsJb8WOwEJNBKY=
X-Google-Smtp-Source: ABdhPJzxHB59eaqIBe0/xNWZjnp+L73hUls/T/0za7A9Ckp18Vukbgcq9NnZm3zlOJ7cwym5Kq3POBL3RDqeIO7Joc4=
X-Received: by 2002:a05:6830:3495:: with SMTP id c21mr4713872otu.53.1619848466213;
 Fri, 30 Apr 2021 22:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210429184855.54939-1-rpearson@hpe.com>
In-Reply-To: <20210429184855.54939-1-rpearson@hpe.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sat, 1 May 2021 13:54:15 +0800
Message-ID: <CAD=hENdMrVOvm6u4CQ_x2p5rZy8TZijEOy8T29Fg_vt_+QrFeA@mail.gmail.com>
Subject: Re: [PATCH for-next v6 00/10] RDMA/rxe: Implement memory windows
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 30, 2021 at 2:49 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> This series of patches implement memory windows for the rdma_rxe
> driver. This is a shorter reimplementation of an earlier patch
> set. They apply to and depend on the current for-next linux rdma
> tree.
>
> Signed-off-by: Bob Pearson <rpearson@hpe.com>

Thanks, I am fine with it.

 Reviewed-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

> ---
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
