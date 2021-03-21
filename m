Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CFE34330C
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Mar 2021 15:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhCUOi7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Mar 2021 10:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhCUOi6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Mar 2021 10:38:58 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D1CC061574
        for <linux-rdma@vger.kernel.org>; Sun, 21 Mar 2021 07:38:57 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id d12so10368619oiw.12
        for <linux-rdma@vger.kernel.org>; Sun, 21 Mar 2021 07:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lpa0c5URlCX6q8oHwT2q/NyeR6Fdx1PcXDUBAzHV4ms=;
        b=qiaDQKl+QWX4TAMfHEt7Q5CeigLtNg0MXvYIfuGOYBCcL9SrO8vNFDRO0MGq5U0EAh
         pCH54k+gndskXGJWEGtJ1Xrj9Z0GH1z5SAMZ9VhndZTNTpBLQM+9maYaaYu+Qi6Gp7Vm
         e90UamRQDoKQ8g9E8xjjh7/KkcbRv6S7sxTkMLPXkdWLmlGbHRChLXMno8HLkS7ZQZQK
         ofla0ul/mfkx7IW6X1rMvXZN/YOE+rVelfGHU3LnxfSqMKOVRP2qrtw+I2hO4XRnYX7+
         XityYl1nq4EMT1TvCPml16CF8oDSNf8K10EBi4BS7oe/fltzixmlRxyMZJIwUxYPTWmz
         LRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lpa0c5URlCX6q8oHwT2q/NyeR6Fdx1PcXDUBAzHV4ms=;
        b=WjrJGIXnv5SiCaN24/+hhWHaX+FTMYn0E/dHSK/2zWeI5odPvjc15Wg7ek/keV3yDg
         d7r3ED3p/IbSFHwDUIEQuWHk4COLCwn9XyxEouyjTbV4mRovxb7WpHUCFard5S1H1+gH
         Io+xafInvctc89pqwaRnljkv/rhXDVFezDMCKqOnWqQbdXr6w9aU+gBLDZr5A5JNfeLN
         T8t+/1UHQy0cK+ux+Vuen6s2a3kwSl2hFYnwt+Rm3hC4p70IkAXDRJKLVyBL90hYRgcy
         RvsC/nKBX61JGqg/HeW10h9rhxVKnORlC2pBiqHjrKFcKJWXXTDPOGn5UxHPHso8YT0v
         wApQ==
X-Gm-Message-State: AOAM531rzk39N8CrQD7SFDYPF/fJKb2Kq19FO+1dY/rDc6GtYmjIKXw8
        8xJXmtFqclfB6R6wgfEQcNUv3crFIkG/DvWrqME=
X-Google-Smtp-Source: ABdhPJx1DKc5QWe43JQNn+bw+fT+u/37DKgOYcHUBT0Jh5ZNNuYK5XjU3vuGQ5U8WIa6Xaf7Z4Xx4vFeH/1nDkS/m64=
X-Received: by 2002:a05:6808:5cb:: with SMTP id d11mr7023260oij.169.1616337537186;
 Sun, 21 Mar 2021 07:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210312140104.GX2356281@nvidia.com> <CAD=hENcNLNvX1isjUYutfsDrXzjpJZWBMaB4EkeBMTz7F4x=pw@mail.gmail.com>
 <20210319130059.GQ2356281@nvidia.com> <CAD=hENfH6CZ5AFZ4jVTguA75eLFk0w1JVMzu0od_XGQPfxHTtw@mail.gmail.com>
 <20210319134845.GR2356281@nvidia.com> <CAD=hENcN8dfD9ZGQ-2in2dUeJ9Wzd2+WFWFbhUgovxwCrETL1A@mail.gmail.com>
 <20210320203832.GJ2356281@nvidia.com> <CAD=hENf2mcmCk+22dt8H_O1FRFUQzcLqiknEzoOma=_VR0fz+g@mail.gmail.com>
 <20210321120725.GK2356281@nvidia.com> <CAD=hENeP0LNGgZdQ6sc+xVN9OAh2C3RQJFVRcmxKJfKdFoOvPQ@mail.gmail.com>
 <20210321130315.GN2356281@nvidia.com>
In-Reply-To: <20210321130315.GN2356281@nvidia.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sun, 21 Mar 2021 22:38:45 +0800
Message-ID: <CAD=hENeekUYEGZszMGs5bOHZ9fb4sahkv5Jy4QW1kWzUBLfYSQ@mail.gmail.com>
Subject: Re: Fwd: [PATCH 1/1] RDMA/umem: add back hugepage sg list
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        maorg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 21, 2021 at 9:03 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Sun, Mar 21, 2021 at 08:54:31PM +0800, Zhu Yanjun wrote:
> > On Sun, Mar 21, 2021 at 8:07 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Sun, Mar 21, 2021 at 04:06:07PM +0800, Zhu Yanjun wrote:
> > > > > > > You are reporting 4k pages, if max_segment is larger than 4k there is
> > > > > > > no such thing as "too big"
> > > > > > >
> > > > > > > I assume it is "too small" because of some maths overflow.
> > > > > >
> > > > > >  459                 while (n_pages && page_to_pfn(pages[0]) == paddr) {
> > > > > >  460                         if (prv->length + PAGE_SIZE >
> > > > > > max_segment)  <--it max_segment is big, n_pages is zero.
> > > > >
> > > > > What does n_pages have to do with max_segment?
> > > >
> > > > With the following snippet
> > > > "
> > > >         struct ib_umem *region;
> > > >         region = ib_umem_get(pd->device, start, len, access);
> > > >
> > > >         page_size = ib_umem_find_best_pgsz(region,
> > > >                                            SZ_4K | SZ_2M | SZ_1G,
> > > >                                            virt);
> > > > "
> > >
> > > Can you please stop posting random bits of code that do nothing to
> > > answer the question?
> > >
> > > > IMHO, you can reproduce this problem in your local host.
> > >
> > > Uh, no, you need to communicate effectively or stop posting please.
> >
> > can you read the following link again
> >
> > https://patchwork.kernel.org/project/linux-rdma/patch/CAD=hENeqTTmpS5V+G646V0QvJFLVSd3Sq11ffQFcDXU-OSsQEg@mail.gmail.com/#24031643
> >
> > In this link, I explained it in details.
>
> No, this is all nonsense
>
> > Since the max_segment is very big, so normally the prv->length +
> > PAGE_SIZE is less than max_segment, it will loop over and over again,
> > until n_pages is zero,
>
> And each iteration increases
>
>                         prv->length += PAGE_SIZE;
>                         n_pages--;
>
> Where prv is the last sgl entry, so decreasing n_pages cannot also
> yield a 4k sgl entry like you are reporting.

No. You suppose n_pages is very big, then prv->length will increase to
reach max_segment.
If n_pages is very small, for example, we suppose n_pages is 1, then
prv->length will
not reach max_segment.

In fact, in my test case, n_pages is very small.

Zhu Yanjun

>
> You get 4k sgl entries if max_segment is *too small* not too big!
>
> Jason
