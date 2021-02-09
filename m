Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284B3314535
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Feb 2021 02:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhBIBDv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Feb 2021 20:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhBIBDu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Feb 2021 20:03:50 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247A4C061786
        for <linux-rdma@vger.kernel.org>; Mon,  8 Feb 2021 17:03:10 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id i3so6846341oif.1
        for <linux-rdma@vger.kernel.org>; Mon, 08 Feb 2021 17:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bAgWGKZc6ZWuADVc7xrYFrpbTjSH7Jgogicrn2KeZwE=;
        b=uQg1Ho830052vUhj3KfUwG05eAKoi9ja6/jhM/Dk0ZGW5RSggQ/hWB8UUFNzRHEu3I
         UUPSt8PMCUQ5/pnA036Jzz2Ae4o0OuzGt5kS8xbfVPB289Ji63saTeHCr0f+gc9qDCW1
         0TlTc7BxwmMO1QKuBwFOkGMwnK+n18MZ9AKRE20ULDedfn4I3rETVE8jQLYMmmXUYYUx
         xU/tuYws+H0OiNISAyZ3RAR2g92AlIgL5pEhzazXI8AgJyJCXEAZYDx7yBcDd7DkWd7R
         P5Gr5JQzZgCt7uQJLTit4ILOuqbpqhRvSF4xzSkK84w1d8LGR1MgyixmzjJiKE6RrhAG
         qpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bAgWGKZc6ZWuADVc7xrYFrpbTjSH7Jgogicrn2KeZwE=;
        b=WrzFHaKPi++ImhOkg46RP8x2dpYfoa8HYcZC+nCbQ01X3hCeVk9p5tQpBuSIsKE8tF
         +LNzAIHvWIBWmbQCVbZ23T9O8TftoF/6eXAu3ARyDt+34EHMXROpdVXEWU/XTXwuUaBi
         4tCd8hizvARnY7SOYz/3s2k3G9Zg7joqlmevZ5ixM+9ZPLRILJdx/t3iRI2zn4UgC5rg
         NF2gcyVTPiYLnJHdGJ9wQn1fBsKJDo6uVl7i0NyLsGMoURqqfsK4zBjqINsk1nlewhDv
         hpzhfaISLqIyB0H999A++/bhs8jGu1DwLSL0xFynYP8Rko8cV7jL602vMHfKUDLfB5Yn
         sYHQ==
X-Gm-Message-State: AOAM532Jj3ul0pyH1Kpgjkbqm/eCOw0xmGUsjQIIvD+vwVmvGaGjr/R1
        Uedlm3vS43SozFNpEqz++RmY782UWpJf7U56jVA=
X-Google-Smtp-Source: ABdhPJzNBhPdbQlek/niR9hkhfFFz8tMMvt08YMfIdSZP+ct4uQXGA5HXiTXy8h/Ee3ARHh1n/Eun+llcOJOJi2AH+k=
X-Received: by 2002:aca:5c54:: with SMTP id q81mr866337oib.163.1612832589612;
 Mon, 08 Feb 2021 17:03:09 -0800 (PST)
MIME-Version: 1.0
References: <20210206002437.2756-1-rpearson@hpe.com> <CAD=hENfXTKfZQ9ip7jWbtSjj8KPq58E5uRbcjieTA=TFXgovkw@mail.gmail.com>
 <CS1PR8401MB08219C191399F7E5A266FFBBBC8F9@CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <CS1PR8401MB08219C191399F7E5A266FFBBBC8F9@CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 9 Feb 2021 09:02:58 +0800
Message-ID: <CAD=hENcEkusa3476kL++OWyx+cKRDMZwVCaJ8YmNvEj1tSjTgA@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Cleanup init_send_wqe
To:     "Pearson, Robert B" <robert.pearson2@hpe.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 9, 2021 at 1:46 AM Pearson, Robert B
<robert.pearson2@hpe.com> wrote:
>
> Sorry for the confusion. There was a previous patch sent the same day that fixed some checkpatch warnings. It has to be installed first. There must be some way to indicate this type of dependency.

It had better make this patch and the pervious patch as a patch
series. So this problem will not occur again.

Thanks.

Zhu Yanjun
>
> bob
>
> -----Original Message-----
> From: Zhu Yanjun <zyjzyj2000@gmail.com>
> Sent: Sunday, February 7, 2021 9:09 PM
> To: Bob Pearson <rpearsonhpe@gmail.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>; RDMA mailing list <linux-rdma@vger.kernel.org>; Pearson, Robert B <robert.pearson2@hpe.com>
> Subject: Re: [PATCH for-next] RDMA/rxe: Cleanup init_send_wqe
>
> On Sat, Feb 6, 2021 at 8:25 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> >
> > This patch changes the type of init_send_wqe in rxe_verbs.c to void
> > since it always returns 0. It also separates out the code that copies
> > inline data into the send wqe as copy_inline_data_to_wqe().
> >
> > Signed-off-by: Bob Pearson <rpearson@hpe.com>
> > ---
> >  drivers/infiniband/sw/rxe/rxe_verbs.c | 42
> > ++++++++++++---------------
> >  1 file changed, 19 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c
> > b/drivers/infiniband/sw/rxe/rxe_verbs.c
> > index 984909e03b35..dee5e0e919d2 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> > @@ -555,14 +555,24 @@ static void init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
> >         }
> >  }
> >
> > -static int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr
> > *ibwr,
> > +static void copy_inline_data_to_wqe(struct rxe_send_wqe *wqe,
> > +                                   const struct ib_send_wr *ibwr) {
> > +       struct ib_sge *sge = ibwr->sg_list;
> > +       u8 *p = wqe->dma.inline_data;
> > +       int i;
> > +
> > +       for (i = 0; i < ibwr->num_sge; i++, sge++) {
> > +               memcpy(p, (void *)(uintptr_t)sge->addr, sge->length);
> > +               p += sge->length;
> > +       }
> > +}
> > +
> > +static void init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr
> > +*ibwr,
> >                          unsigned int mask, unsigned int length,
> >                          struct rxe_send_wqe *wqe)  {
> >         int num_sge = ibwr->num_sge;
> > -       struct ib_sge *sge;
> > -       int i;
> > -       u8 *p;
> >
> >         init_send_wr(qp, &wqe->wr, ibwr);
> >
> > @@ -570,7 +580,7 @@ static int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
> >         if (unlikely(mask & WR_REG_MASK)) {
> >                 wqe->mask = mask;
> >                 wqe->state = wqe_state_posted;
> > -               return 0;
> > +               return;
> >         }
> >
> >         if (qp_type(qp) == IB_QPT_UD || @@ -578,20 +588,11 @@ static
> > int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
> >             qp_type(qp) == IB_QPT_GSI)
> >                 memcpy(&wqe->av, &to_rah(ud_wr(ibwr)->ah)->av,
> > sizeof(wqe->av));
> >
> > -       if (unlikely(ibwr->send_flags & IB_SEND_INLINE)) {
> > -               p = wqe->dma.inline_data;
> > -
> > -               sge = ibwr->sg_list;
> > -               for (i = 0; i < num_sge; i++, sge++) {
> > -                       memcpy(p, (void *)(uintptr_t)sge->addr,
> > -                                       sge->length);
> > -
> > -                       p += sge->length;
> > -               }
> > -       } else {
> > +       if (unlikely(ibwr->send_flags & IB_SEND_INLINE))
> > +               copy_inline_data_to_wqe(wqe, ibwr);
> > +       else
> >                 memcpy(wqe->dma.sge, ibwr->sg_list,
> >                        num_sge * sizeof(struct ib_sge));
> > -       }
>
> I git clone  https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git,
> But this commit can not be applied successfully.
>
> Zhu Yanjun
> >
> >         wqe->iova = mask & WR_ATOMIC_MASK ? atomic_wr(ibwr)->remote_addr :
> >                 mask & WR_READ_OR_WRITE_MASK ?
> > rdma_wr(ibwr)->remote_addr : 0; @@ -603,8 +604,6 @@ static int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
> >         wqe->dma.sge_offset     = 0;
> >         wqe->state              = wqe_state_posted;
> >         wqe->ssn                = atomic_add_return(1, &qp->ssn);
> > -
> > -       return 0;
> >  }
> >
> >  static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr
> > *ibwr, @@ -627,10 +626,7 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
> >         }
> >
> >         send_wqe = producer_addr(sq->queue);
> > -
> > -       err = init_send_wqe(qp, ibwr, mask, length, send_wqe);
> > -       if (unlikely(err))
> > -               goto err1;
> > +       init_send_wqe(qp, ibwr, mask, length, send_wqe);
> >
> >         advance_producer(sq->queue);
> >         spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
> > --
> > 2.27.0
> >
