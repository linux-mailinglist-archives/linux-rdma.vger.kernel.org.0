Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B533BF658
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jul 2021 09:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhGHHjF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Jul 2021 03:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbhGHHjF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Jul 2021 03:39:05 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347FAC061574
        for <linux-rdma@vger.kernel.org>; Thu,  8 Jul 2021 00:36:23 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id u66so946321oif.13
        for <linux-rdma@vger.kernel.org>; Thu, 08 Jul 2021 00:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A5TUs/fAfjoe1UQauBo2ECabL0LUxkEiPDppLc1f+FY=;
        b=ZkER+42ARbqgKPrHrzmWR9os1sHEODckYqnK7R7GPPuGY42GixIskKC6k9opIuKNG3
         joQD6nvdXme7jEjEUvOdBN3+C4I3NobXrUGVYqdK/1sZLom75mZISSf7sqBqw/q0yeIZ
         qceUBLbMa4wR/L/3yZFCQ0G7LlrHlHfaVEj6/wo6NlTmSJ92XdUyBRB/W20kCyYa9E2t
         IY7SWyjsgvmUmHKMUrFS1pE6wx/h23DhONULOgT3cRrhSCM/ZgsPVxxa6g7bP8UAALj8
         n1ObAyrF8HQwmHTJFpvl3YGAqPRfn+nZjgYreWFl/eNh9woUXLs3HofZ7SX/IhNpG6p6
         Z8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A5TUs/fAfjoe1UQauBo2ECabL0LUxkEiPDppLc1f+FY=;
        b=O9Xctzi4notfcSY0rFa3+01hcK80iJDK0YMXKqNG9LVXu7MBQryMpWeUys6l0m64YI
         Cdx7XphaATMtAsdASLtf6mv3eVphOYnusCxbL1N0Kw2PuJuJr4/kZmRmp/fA/7FdiwU2
         t0Y8wOm/AY/oXgtPgcvwajAiWC7U9+vilm8oskj8v81vFXoSwz+tQMtVtk8vheBPg8/X
         MoUYqCmjOirWMPoRw0ZQo1UiFYGk2D2a7IIj56WHi+Kc6R8g/KwksK7gfmZa/UY1BAwt
         +/kIBNxIl7mUM96JNNG9juzV4OAssXopMkGYmXXJ7nF5kjITXOdtbtsZLzVTTZ9SaCAu
         pIlw==
X-Gm-Message-State: AOAM5338PLSoAVX5b9YWIe7G2wefc+ZNuRfcv1zO4tuDMDiFaDTtkBBh
        tasA8CwTMeD33GRfBIDRgEseNY8W3VucIaIe6AI=
X-Google-Smtp-Source: ABdhPJwV9jh39d3jGFRscLLwh/4Q9TrHj7V9vlfyQPHr4Zvn4uvMvE4brOVWzCl7gxlw7Wf7Hb4DGW6+dMFxcWYPsxI=
X-Received: by 2002:a05:6808:10ca:: with SMTP id s10mr2470474ois.163.1625729782564;
 Thu, 08 Jul 2021 00:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210707040040.15434-1-rpearsonhpe@gmail.com>
In-Reply-To: <20210707040040.15434-1-rpearsonhpe@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 8 Jul 2021 15:36:11 +0800
Message-ID: <CAD=hENct-wExG8C+uyH37DbPqU_1+6NXCwHH3y5KVcUKwWNxkA@mail.gmail.com>
Subject: Re: [PATCH for-next v2 0/9] ICRC cleanup
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 7, 2021 at 12:01 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> This series of patches is a cleanup of the ICRC code in the rxe driver.
> The end result is to collect all the ICRC focused code into rxe_icrc.c
> with three APIs that are used by the rest of the driver. One to initialize
> the crypto engine used to compute crc32, and one each to generate and
> check the ICRC in a packet.
>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
> v2:
>   Split up the 5 patches in the first version into 9 patches which are
>   each focused on a single change.
>   Fixed sparse warnings in the first version.
>
> Bob Pearson (9):
>   RDMA/rxe: Move ICRC checking to a subroutine
>   RDMA/rxe: Move rxe_xmit_packet to a subroutine
>   RDMA/rxe: Fixup rxe_send and rxe_loopback
>   RDMA/rxe: Move ICRC generation to a subroutine
>   RDMA/rxe: Move rxe_crc32 to a subroutine
>   RDMA/rxe: Fixup rxe_icrc_hdr
>   RDMA/rxe: Move crc32 init code to rxe_icrc.c
>   RDMA/rxe: Add kernel-doc comments to rxe_icrc.c
>   RDMA/rxe: Fix types in rxe_icrc.c

Thanks. It seems that these patches can pass rdma-core tests.
I will delve into these patches soon.

Zhu Yanjun

>
>  drivers/infiniband/sw/rxe/rxe.h       |  22 -----
>  drivers/infiniband/sw/rxe/rxe_comp.c  |   4 +-
>  drivers/infiniband/sw/rxe/rxe_icrc.c  | 124 +++++++++++++++++++++++++-
>  drivers/infiniband/sw/rxe/rxe_loc.h   |  61 +++----------
>  drivers/infiniband/sw/rxe/rxe_mr.c    |  22 +----
>  drivers/infiniband/sw/rxe/rxe_net.c   |  59 ++++++++++--
>  drivers/infiniband/sw/rxe/rxe_recv.c  |  23 +----
>  drivers/infiniband/sw/rxe/rxe_req.c   |  13 +--
>  drivers/infiniband/sw/rxe/rxe_resp.c  |  33 ++-----
>  drivers/infiniband/sw/rxe/rxe_verbs.c |  11 +--
>  10 files changed, 202 insertions(+), 170 deletions(-)
>
> --
> 2.30.2
>
