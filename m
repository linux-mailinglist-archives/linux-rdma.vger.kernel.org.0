Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24AE57E4D9
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jul 2022 18:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbiGVQve (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jul 2022 12:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbiGVQv1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jul 2022 12:51:27 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0372656A
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jul 2022 09:51:17 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p10so1009869lfd.9
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jul 2022 09:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iphZzX7m7AgyTr4kCsjA9hhr8fbo9NURU1D0Hv9W+UU=;
        b=hZLPN2ixQrrxrtwc45KNRqydEQNoQUET0hrsQ+1WxhTyYmLW5ygftq4yVsQZFC0ehz
         O+OKQLXjwDWsdR+TFWyFJ0cWR+g7TmR7SMmCZ4Ot5VyHn6hP9AMu2kXPeIn1QHPZG0jQ
         kySfto+pw3Eil3Msvwaf1QQrUKSWNCReD7o24HKk8WZVo2YEmDjNjsrPMKoWTjOOJmZj
         6v6lIGrTACC3NaXsdzowRa9C6UwY5F0vyCntgPFP2bbJeLypjgEY5YZ6prZVmkUV/UIf
         0HnMVFrDrJ45E8LAwWbSd5uqsCgdrtBP+iaedNzCKwOhPid/goV/H0uC2/0HtoSJ6nZ6
         4F7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iphZzX7m7AgyTr4kCsjA9hhr8fbo9NURU1D0Hv9W+UU=;
        b=bzvzwl2PlMsjMcAfRSqqOaKbCfyIBsXBJbthGdPp5sQDPlgTP8jsWCzedduWxpff/j
         xx9hZidmlD4WyJrjcq3yFR3zhHnX5q/4UtAkAgN3FQtfalG62/SA0RtGu/xAapJH1/UM
         JYHM2T1Wf2H1ReyVGwNqeecsnE7iUDQjGJ/g65DX3WpV6eQB5bbDGOcLTqL2TNdNx0nI
         mCzAUgwaGpUBhDh7hDAUADSq6j5uygM9eklgwoMki7hT49MQMw0QmX4AfSVvqfPVHxpC
         DexyWu2Nz0XyWeKqYcjDU6luvRxUQUPdvilWAtCsBf8KcgpRhuC8LNushS924y5AiE15
         RNuA==
X-Gm-Message-State: AJIora//GhF2kAD0a/X5N+U3+qu18tZotFXDh5gXXJumK+7YT+6G5Qt0
        sKlUad24XZsNv/y7oT+r/gJFj8Wj/xtDBD0nu1XIocyiCJ9+pXob
X-Google-Smtp-Source: AGRyM1sQK55R4hxhfODsVmhG1Jj+EGEWdU40Wz6teVpFtKtPeWSPMLOGhUSTG+rfocZ6zEFMLVgU+85jq98kJ7ZOTeY=
X-Received: by 2002:ac2:54a2:0:b0:489:57b0:7adc with SMTP id
 w2-20020ac254a2000000b0048957b07adcmr359157lfk.271.1658508674944; Fri, 22 Jul
 2022 09:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220707073006.328737-1-haris.phnx@gmail.com> <CAE_WKMzj3i6bKrHN_GuBpjoEzuQBXLoEZrXpsqKjtkxvM+ZbfA@mail.gmail.com>
 <CAE_WKMz9G8BYVA=pbNyZv7RdM0gvjDo15EzdgtgEAXcRpjjOmA@mail.gmail.com> <20220722151416.GB55077@ziepe.ca>
In-Reply-To: <20220722151416.GB55077@ziepe.ca>
From:   haris iqbal <haris.phnx@gmail.com>
Date:   Fri, 22 Jul 2022 18:50:48 +0200
Message-ID: <CAE_WKMxqyB7_d-x5AFFqfN00K85cjWRex9LNxXiEKCgNuC=+eg@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: For invalidate compare according to set keys in mr
To:     Jason Gunthorpe <jgg@ziepe.ca>, Bob Pearson <rpearsonhpe@gmail.com>
Cc:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com,
        Leon Romanovsky <leon@kernel.org>, haris.iqbal@ionos.com,
        Jinpu Wang <jinpu.wang@ionos.com>, aleksei.marov@ionos.com
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

On Fri, Jul 22, 2022 at 5:14 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Fri, Jul 22, 2022 at 05:10:46PM +0200, haris iqbal wrote:
> > On Fri, Jul 15, 2022 at 11:21 AM haris iqbal <haris.phnx@gmail.com> wrote:
> > >
> > > On Thu, Jul 7, 2022 at 9:30 AM Md Haris Iqbal <haris.phnx@gmail.com> wrote:
> > > >
> > > > The 'rkey' input can be an lkey or rkey, and in rxe the lkey or rkey have
> > > > the same value, including the variant bits.
> > > >
> > > > So, if mr->rkey is set, compare the invalidate key with it, otherwise
> > > > compare with the mr->lkey.
> > > >
> > > > Since we already did a lookup on the non-varient bits to get this far,
> > > > the check's only purpose is to confirm that the wqe has the correct
> > > > variant bits.
> > > >
> > > > Fixes: 001345339f4c ("RDMA/rxe: Separate HW and SW l/rkeys")
> > > > Cc: rpearsonhpe@gmail.com
> > > > Signed-off-by: Md Haris Iqbal <haris.phnx@gmail.com>
> > > > ---
> > > >  drivers/infiniband/sw/rxe/rxe_loc.h |  2 +-
> > > >  drivers/infiniband/sw/rxe/rxe_mr.c  | 12 ++++++------
> > > >  2 files changed, 7 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> > > > index 0e022ae1b8a5..37484a559d20 100644
> > > > --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> > > > +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> > > > @@ -77,7 +77,7 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
> > > >                          enum rxe_mr_lookup_type type);
> > > >  int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
> > > >  int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
> > > > -int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
> > > > +int rxe_invalidate_mr(struct rxe_qp *qp, u32 key);
> > > >  int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
> > > >  int rxe_mr_set_page(struct ib_mr *ibmr, u64 addr);
> > > >  int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
> > > > diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> > > > index fc3942e04a1f..3add52129006 100644
> > > > --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> > > > +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> > > > @@ -576,22 +576,22 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
> > > >         return mr;
> > > >  }
> > > >
> > > > -int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
> > > > +int rxe_invalidate_mr(struct rxe_qp *qp, u32 key)
> > > >  {
> > > >         struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
> > > >         struct rxe_mr *mr;
> > > >         int ret;
> > > >
> > > > -       mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
> > > > +       mr = rxe_pool_get_index(&rxe->mr_pool, key >> 8);
> > > >         if (!mr) {
> > > > -               pr_err("%s: No MR for rkey %#x\n", __func__, rkey);
> > > > +               pr_err("%s: No MR for key %#x\n", __func__, key);
> > > >                 ret = -EINVAL;
> > > >                 goto err;
> > > >         }
> > > >
> > > > -       if (rkey != mr->rkey) {
> > > > -               pr_err("%s: rkey (%#x) doesn't match mr->rkey (%#x)\n",
> > > > -                       __func__, rkey, mr->rkey);
> > > > +       if (mr->rkey ? (key != mr->rkey) : (key != mr->lkey)) {
> > > > +               pr_err("%s: wr key (%#x) doesn't match mr key (%#x)\n",
> > > > +                       __func__, key, (mr->rkey ? mr->rkey : mr->lkey));
> > > >                 ret = -EINVAL;
> > > >                 goto err_drop_ref;
> > > >         }
> > >
> > > Ping.
> >
> > Ping.
> >
> > Does this need more discussions or changes?
>
> I was hoping Bob would say something but I am happy with it..

Thanks Jason for the response.
We can wait for Bob to share his thoughts.

>
> Jason
