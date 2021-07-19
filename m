Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59FC3CD05C
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jul 2021 11:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbhGSIfi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jul 2021 04:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbhGSIfh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Jul 2021 04:35:37 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD99DC061762
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jul 2021 01:17:20 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id g5so26719282ybu.10
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jul 2021 02:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9H725gTwp0BND/C8PI7cvg69hBKwv6+Fwil4AH1yEWo=;
        b=DMKzO38HXjd4wYap0hZmGvEC8O4Pq5W1hUNx+RAI/tSjSCvyYiGPo284/MOc4yygIx
         ooNDTPMJC7uSaROEILkK1quFHN5mc5ffkOE0Xs3t9QKNhmN3s6F5UYm8pgLyH+4gXcgl
         QhFazbz9cjGGi+HBiMzb9rRRi/fMMO+xMXfbdI09TpFsvT7Fd1hBr4Uf5XaiqJb2HMHY
         k2t6mOhxrXU97QLv0q9S2TL/sq+QYT48yXDxwoJsY8frXpEwGK+0F8xc4RJ+DHVmEJZB
         A6rlhLr8kPEGqSDvk0d3X2dBhFAeGwHugGJxLdaVJHaWTWLM0QiB5RGkycy6klXwWl2t
         +7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9H725gTwp0BND/C8PI7cvg69hBKwv6+Fwil4AH1yEWo=;
        b=AyBaURbPfC+QHxik+GbOnqIryyy51ZziPRBP2MXEpv9kqpTevEL7qSm6Jv4fRjE+lx
         qawQ1+SMEv57BNoDa+slFNbx602hLjSS7ucCf+l6m4jinVj1CLZ/RtHfst2qZGmuGOzR
         7s1mn43t+LizU4Nw2OKNo8iA1FzlbyAsMNnLW7+eG5oxUDDWDibW93txUj2XWp5ShN0C
         6t6CtWlLQAGHf7K7wuk2HQQoMNrWwNwjRBsD+guLlODNiV/6Ag2jpG08IXgesjf0WlO7
         OPukWV9MjX8scV7I8mUmM8y6q/2+Tk5yaQtdCeMYNN0KQyt1DuMD0pFrd5VBlAyl43X+
         RL7g==
X-Gm-Message-State: AOAM531Vw+zs18nRrlGBWrMR/E1nR1Tm+tobJYBb9u8HFkvYPddXxs7N
        bY79dDe6egacatARuYE3dfWtp2jsk/PPzUnq3Q8dO8ymnJg=
X-Google-Smtp-Source: ABdhPJz68sd5FZ9r3ukKSBciHECgM1K+JknPNiY8BuVqpVQ4oURL+lcQXpe/oZl9bd/RgBFUgNh8S8fPHfE5t7su4a8=
X-Received: by 2002:a05:6830:4188:: with SMTP id r8mr5522424otu.53.1626684170575;
 Mon, 19 Jul 2021 01:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210707040040.15434-1-rpearsonhpe@gmail.com> <20210716173804.GA767510@nvidia.com>
In-Reply-To: <20210716173804.GA767510@nvidia.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 19 Jul 2021 16:42:39 +0800
Message-ID: <CAD=hENfj2vkNV1uKK7hgfDLqN9xY2fwjiFS536tM9oknMuZ4Fg@mail.gmail.com>
Subject: Re: [PATCH for-next v2 0/9] ICRC cleanup
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jul 17, 2021 at 1:38 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Jul 06, 2021 at 11:00:32PM -0500, Bob Pearson wrote:
> > This series of patches is a cleanup of the ICRC code in the rxe driver.
> > The end result is to collect all the ICRC focused code into rxe_icrc.c
> > with three APIs that are used by the rest of the driver. One to initialize
> > the crypto engine used to compute crc32, and one each to generate and
> > check the ICRC in a packet.
> >
> > Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> > ---
> > v2:
> >   Split up the 5 patches in the first version into 9 patches which are
> >   each focused on a single change.
> >   Fixed sparse warnings in the first version.
> >
> > Bob Pearson (9):
> >   RDMA/rxe: Move ICRC checking to a subroutine
> >   RDMA/rxe: Move rxe_xmit_packet to a subroutine
> >   RDMA/rxe: Fixup rxe_send and rxe_loopback
> >   RDMA/rxe: Move ICRC generation to a subroutine
> >   RDMA/rxe: Move rxe_crc32 to a subroutine
> >   RDMA/rxe: Fixup rxe_icrc_hdr
> >   RDMA/rxe: Move crc32 init code to rxe_icrc.c
> >   RDMA/rxe: Add kernel-doc comments to rxe_icrc.c
> >   RDMA/rxe: Fix types in rxe_icrc.c
>
> Applied to for-next, thanks

Hi, Jason && Bob

I confronted a problem.
One hosts with this patch series, A
other hosts, without this patch series, B

I run rping between A <-------> B.

I confronted the following errors, and rping can not succeed.
"
...
[ 1848.251273] rdma_rxe: bad ICRC from 172.16.1.61
[ 1971.750691] rdma_rxe: bad ICRC from 172.16.1.61
...
"
It seems that this patch series breaks the Backward compatibility of RXE.

Not sure if it is a problem. Please comment.

Thanks a lot.
Zhu Yanjun

>
> Jason
