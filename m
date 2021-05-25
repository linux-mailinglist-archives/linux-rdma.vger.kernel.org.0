Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F75B39032D
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 15:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhEYN6F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 09:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbhEYN6A (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 May 2021 09:58:00 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA57CC061574
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 06:56:29 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id d21so30321054oic.11
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 06:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LQWYpB0/ihdy0atFthZ62kCZW3FVUQsr3jDvstGzL9k=;
        b=qC4xOOIur4My/blx0yVTOgigGERfeijpSXj0KwB+Wyje7+7L9OTrpAktabw4pR6tPu
         Ik7zBCrhd/jbDpVcQhqg6cCg+mN2MychUdyH5sW+J4vhoxbMfaMleM7cnYAi6nYb0x0p
         flQ/yH3HWaqWe0Gom+N3xffyzie52a02BLriZD/k78kg6inTwlykxPCramPbDulQGPXn
         V3VJcQ4jTT9eKwi93i220pKvGSEZn4MuT4d8FSc97BT0oqaSsoRzPW2WGKSpsaiM/5hn
         KmALmdrfwZ6TCC1TiQkk6uxepR95dG6ee+Yul9LbfuwBWIWK+9CbHY6pZGPRtjHi1Puh
         9UtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LQWYpB0/ihdy0atFthZ62kCZW3FVUQsr3jDvstGzL9k=;
        b=ownIxhoGUZJsFS8I1UY4JAseXfNhv4vyff0Q+CwkdYGmux1ocq5IjDPkNNDJyqmH4s
         CAxtYl14oP/LRLStkcfZ7wvBvPEA0a0F86W4HkQl3Z+LoyVTrdDjuDPQYEodvxDX9gkF
         UFj3z6djSq5+7a2oVcIYy0rPNqX28SFo+o6v4re9NEZ1MVT1KDXkChQB6mJE9SvoScLx
         B8qBdCK8YCbGOzzU5rjxkdNQ7d3Vo/6qaKg/I9kVLHTlrYrLbmIx1v+hfY3y1/cv39IR
         2tbOvHIEgvayoUWxPDWP1Xv8y5Rmj91QvvBqGZ264q2sqIoyZYjAU18Jo+f0eWUwbwwZ
         L5/A==
X-Gm-Message-State: AOAM5336fqZiJ/dGZs9qzX0Hn+zl7PeQLZ4/GyUSj9qxacn9AiJ87wOe
        VQ0FECVIt6YcFv23pSAZFII6PTVgWz17MDUBRFI=
X-Google-Smtp-Source: ABdhPJztZUbTgWd+T1gUokU/0PYE8VvOKW8ymhZwciGsLkZRLWkImc9tV9BZfqaEE/UPb2LSabX804YfYrplcRyKeLc=
X-Received: by 2002:aca:2404:: with SMTP id n4mr14342448oic.169.1621950989409;
 Tue, 25 May 2021 06:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210525223222.17636-1-yanjun.zhu@intel.com> <20210525131837.GV1002214@nvidia.com>
In-Reply-To: <20210525131837.GV1002214@nvidia.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 25 May 2021 21:56:18 +0800
Message-ID: <CAD=hENcQBGST3VzusRQ4V51PbzLMPgHQj0QCbqMwSUNe_ajrNA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Update kernel headers
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Zhu Yanjun <yanjun.zhu@intel.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 25, 2021 at 9:18 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, May 25, 2021 at 06:32:22PM -0400, Zhu Yanjun wrote:
> > From: Zhu Yanjun <zyjzyj2000@gmail.com>
> >
> > After the patches "RDMA/rxe: Implement memory windows", the kernel headers
> > are changed. This causes about 17 errors and 1 failure when running
> > "run_test.py" with rxe.
> > This commit will fix these errors and failures.
> >
> > Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> > ---
> >  kernel-headers/rdma/rdma_user_rxe.h | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
>
> Huh? Bob? You can't break the rxe uapi??
>
> > diff --git a/kernel-headers/rdma/rdma_user_rxe.h b/kernel-headers/rdma/rdma_user_rxe.h
> > index 068433e2..90ea477f 100644
> > --- a/kernel-headers/rdma/rdma_user_rxe.h
> > +++ b/kernel-headers/rdma/rdma_user_rxe.h
> > @@ -99,7 +99,17 @@ struct rxe_send_wr {
> >                       __u32   remote_qkey;
> >                       __u16   pkey_index;
> >               } ud;
> > +             struct {
> > +                     __aligned_u64   addr;
>
> > +                     __aligned_u64   length;
>
> > +                     __u32           mr_lkey;
> > +                     __u32           mw_rkey;
>
> > +                     __u32           rkey;
> > +                     __u32           access;
>
> > +                     __u32           flags;
> > +             } mw;
>
> There is room for 4 u64's in 'reg' and this has 5, so it is a no-go

What is 'reg'? Where is the definition of this 'reg'? What protocol
has the definition of this 'reg'?

Zhu Yanjun

>
> Jason
