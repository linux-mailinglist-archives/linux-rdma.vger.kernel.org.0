Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3836E57E374
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jul 2022 17:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbiGVPLS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jul 2022 11:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbiGVPLP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jul 2022 11:11:15 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A638195C0E
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jul 2022 08:11:14 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id r14so5789380ljp.2
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jul 2022 08:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kSqaujUViOrWuFhFBHI0T04Lr9oxlVyXUo5N805uKKE=;
        b=I6kx9U6UoJt1nlEIGU84+gofBB2krTdSbnCkcJlBVgxxLQT2qFid+wuCTWFUSzR47J
         z7Zdi0H1iCH4ovCJSE0RVMEgGXv2up6T6Ylx8hWGJwYWYVCgR2FjVcH5huDG0b9RIenU
         /7wyvA7u+/CCtKjvptrcOpqNy9vf9BGwQkBVILYMUa3qMPFBOQZH/d8YqZLO37kuyyeX
         h7WD9mx2PgUTrkbW3b82uXbIk3bQ9gVZ+y0WGvrcG7E8oS7rcDweTOfWJoWyevyi4bvy
         7lBKiqh37UnOVx4/LOLiJUDxPZSxdIl4iOXrrGlbdZ1+q/uoDd22MMVZSijM9HpY9v8a
         hjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kSqaujUViOrWuFhFBHI0T04Lr9oxlVyXUo5N805uKKE=;
        b=sotheOS3+CMdbcZJ4kR8QiSlUPXd7N9IKfXAYb4CENBKNakm4qqmVhT3Lx+ft/FoC0
         Cvs21mml7/4n45LBMtJ6T6l8tDimvUXg49A7BPwVsOeCVPvW4/TCiIFNdXCi0I+VkCIJ
         EXvXRbH35boiyJsjfTRKsysR4FjmMt6ENq/5vTlJsHIfGxvlpNEjdyuakOZPG4BtTIVE
         Ie0iNJXzSFX1pTOvnWHLtgTQ6hhYkTBQL7eNhixWKQmthAEW0/09XNiYWRss3Vph6yvC
         e03e8UWZxK0mihSmHcMx955UXhOKT+BKNSfGwhIamsv1dKQvbB9bCnmAFDt79fr4BcvI
         DRSA==
X-Gm-Message-State: AJIora8s9WCCYwe5A+hSaHBHLZELNNxohTAceLwWHTXVaGH89Q6QwN9g
        PjTuwpj91908F9zPR7pf5W9lqwuab+oyDhIV93g4XYQidIsDig==
X-Google-Smtp-Source: AGRyM1uLpkxig22ApuW2txTP3yzRceV7wxJmYUzx+eM9IDlERTDaPlpi+K9F+h155awLaQfKXsIvlQGgkmZFOqxu6oQ=
X-Received: by 2002:a05:651c:1587:b0:25d:7844:5910 with SMTP id
 h7-20020a05651c158700b0025d78445910mr180628ljq.325.1658502672704; Fri, 22 Jul
 2022 08:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220707073006.328737-1-haris.phnx@gmail.com> <CAE_WKMzj3i6bKrHN_GuBpjoEzuQBXLoEZrXpsqKjtkxvM+ZbfA@mail.gmail.com>
In-Reply-To: <CAE_WKMzj3i6bKrHN_GuBpjoEzuQBXLoEZrXpsqKjtkxvM+ZbfA@mail.gmail.com>
From:   haris iqbal <haris.phnx@gmail.com>
Date:   Fri, 22 Jul 2022 17:10:46 +0200
Message-ID: <CAE_WKMz9G8BYVA=pbNyZv7RdM0gvjDo15EzdgtgEAXcRpjjOmA@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: For invalidate compare according to set keys in mr
To:     linux-rdma@vger.kernel.org
Cc:     zyjzyj2000@gmail.com, Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, haris.iqbal@ionos.com,
        Jinpu Wang <jinpu.wang@ionos.com>, aleksei.marov@ionos.com,
        Bob Pearson <rpearsonhpe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 15, 2022 at 11:21 AM haris iqbal <haris.phnx@gmail.com> wrote:
>
> On Thu, Jul 7, 2022 at 9:30 AM Md Haris Iqbal <haris.phnx@gmail.com> wrote:
> >
> > The 'rkey' input can be an lkey or rkey, and in rxe the lkey or rkey have
> > the same value, including the variant bits.
> >
> > So, if mr->rkey is set, compare the invalidate key with it, otherwise
> > compare with the mr->lkey.
> >
> > Since we already did a lookup on the non-varient bits to get this far,
> > the check's only purpose is to confirm that the wqe has the correct
> > variant bits.
> >
> > Fixes: 001345339f4c ("RDMA/rxe: Separate HW and SW l/rkeys")
> > Cc: rpearsonhpe@gmail.com
> > Signed-off-by: Md Haris Iqbal <haris.phnx@gmail.com>
> > ---
> >  drivers/infiniband/sw/rxe/rxe_loc.h |  2 +-
> >  drivers/infiniband/sw/rxe/rxe_mr.c  | 12 ++++++------
> >  2 files changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> > index 0e022ae1b8a5..37484a559d20 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> > +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> > @@ -77,7 +77,7 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
> >                          enum rxe_mr_lookup_type type);
> >  int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
> >  int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
> > -int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
> > +int rxe_invalidate_mr(struct rxe_qp *qp, u32 key);
> >  int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
> >  int rxe_mr_set_page(struct ib_mr *ibmr, u64 addr);
> >  int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
> > diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> > index fc3942e04a1f..3add52129006 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> > @@ -576,22 +576,22 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
> >         return mr;
> >  }
> >
> > -int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
> > +int rxe_invalidate_mr(struct rxe_qp *qp, u32 key)
> >  {
> >         struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
> >         struct rxe_mr *mr;
> >         int ret;
> >
> > -       mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
> > +       mr = rxe_pool_get_index(&rxe->mr_pool, key >> 8);
> >         if (!mr) {
> > -               pr_err("%s: No MR for rkey %#x\n", __func__, rkey);
> > +               pr_err("%s: No MR for key %#x\n", __func__, key);
> >                 ret = -EINVAL;
> >                 goto err;
> >         }
> >
> > -       if (rkey != mr->rkey) {
> > -               pr_err("%s: rkey (%#x) doesn't match mr->rkey (%#x)\n",
> > -                       __func__, rkey, mr->rkey);
> > +       if (mr->rkey ? (key != mr->rkey) : (key != mr->lkey)) {
> > +               pr_err("%s: wr key (%#x) doesn't match mr key (%#x)\n",
> > +                       __func__, key, (mr->rkey ? mr->rkey : mr->lkey));
> >                 ret = -EINVAL;
> >                 goto err_drop_ref;
> >         }
> > --
> > 2.25.1
>
> Ping.

Ping.

Does this need more discussions or changes?

>
> >
