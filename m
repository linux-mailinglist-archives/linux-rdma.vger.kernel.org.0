Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BA5312931
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Feb 2021 04:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhBHDJ3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 7 Feb 2021 22:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBHDJ0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 7 Feb 2021 22:09:26 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2551BC061756
        for <linux-rdma@vger.kernel.org>; Sun,  7 Feb 2021 19:08:46 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id g84so426527oib.0
        for <linux-rdma@vger.kernel.org>; Sun, 07 Feb 2021 19:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yc+pdKJGceHoUsDqIBnOhJ4Y/lSdSiFCQZGmJcD4Jf8=;
        b=N+ShpGG4IsXenDnNbpJnFAESHZR4y/wz9VJ2cmHp3TaJM+OwvmwKfAVPmr0BEYR5IU
         CcA2W9kNFaXr+44BvqTRvzI6jLuC8wOeMg/kNuwLwEmeSqvPwiQo/vb7Uxc+hJfn8+zi
         eIQXav4Xf5W7T7VC7Jd12bJukLc8pFLcA7a/e+rHjDI39t/XxEmZYLreb5+oY6fui8ld
         cTs2NN06GBAHMWSih4puymGbyoAb1UHiurylERJftAq2PzKNjMAX1LVDmVn+SpVoXP3l
         TjHwRR0OFLwJWEfBebLz3UaFJ74/nbG5wF5w6jucj1A0qARo1YouCsiyeWxbG8drV+q8
         t8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yc+pdKJGceHoUsDqIBnOhJ4Y/lSdSiFCQZGmJcD4Jf8=;
        b=S1lQDtW1osdd3/7LQVmMgZojsxfFI6bYuRcdovYyLWWVuAqW1Rj056fB1mYlUQO/4d
         N77f08TriyXYEicjZkwPTmAe5255cn9uwaEEmgCD3ejigaOZu2LiwJZEhv1g1i+98Np4
         SmTfGDTD9HbuWKlsEoxK/DByTr9WVAZbXsM4fVaA3voYNk1VjMQPVONck19kZ0NWT1yE
         0fdxlT+YdSkN/8D9B9DqIt+tycmVfPggpdbfZOLZ+47L9w/4c6T5ZlrSAZnS4M8nU8tP
         lNTmETT54GeqbBC8oov9CRfEooygVxxZSyNA61/RPQNa2/nDE+/dnSVyR/yfiVGZ0vEf
         afTQ==
X-Gm-Message-State: AOAM533GG9fxfMdsXWVMehFbprnZsOgKKVHpCgB6LAUoWNRnJbXIRp/w
        Srw1Ydu/ppZAAmYHPcK8HU+fRlF+xnp9KyyskiU=
X-Google-Smtp-Source: ABdhPJz/vhAZrr9A1YPGv8VWRW7MXnTGBTgZ5GS/VHKwGS05mOsnp8fik27ejqX1Y8TTKHk3KiS7oG59JQi/HhkurNM=
X-Received: by 2002:aca:3906:: with SMTP id g6mr9926823oia.169.1612753725612;
 Sun, 07 Feb 2021 19:08:45 -0800 (PST)
MIME-Version: 1.0
References: <20210206002437.2756-1-rpearson@hpe.com>
In-Reply-To: <20210206002437.2756-1-rpearson@hpe.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 8 Feb 2021 11:08:34 +0800
Message-ID: <CAD=hENfXTKfZQ9ip7jWbtSjj8KPq58E5uRbcjieTA=TFXgovkw@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Cleanup init_send_wqe
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Feb 6, 2021 at 8:25 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> This patch changes the type of init_send_wqe in rxe_verbs.c to void
> since it always returns 0. It also separates out the code that copies
> inline data into the send wqe as copy_inline_data_to_wqe().
>
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 42 ++++++++++++---------------
>  1 file changed, 19 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 984909e03b35..dee5e0e919d2 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -555,14 +555,24 @@ static void init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
>         }
>  }
>
> -static int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
> +static void copy_inline_data_to_wqe(struct rxe_send_wqe *wqe,
> +                                   const struct ib_send_wr *ibwr)
> +{
> +       struct ib_sge *sge = ibwr->sg_list;
> +       u8 *p = wqe->dma.inline_data;
> +       int i;
> +
> +       for (i = 0; i < ibwr->num_sge; i++, sge++) {
> +               memcpy(p, (void *)(uintptr_t)sge->addr, sge->length);
> +               p += sge->length;
> +       }
> +}
> +
> +static void init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
>                          unsigned int mask, unsigned int length,
>                          struct rxe_send_wqe *wqe)
>  {
>         int num_sge = ibwr->num_sge;
> -       struct ib_sge *sge;
> -       int i;
> -       u8 *p;
>
>         init_send_wr(qp, &wqe->wr, ibwr);
>
> @@ -570,7 +580,7 @@ static int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
>         if (unlikely(mask & WR_REG_MASK)) {
>                 wqe->mask = mask;
>                 wqe->state = wqe_state_posted;
> -               return 0;
> +               return;
>         }
>
>         if (qp_type(qp) == IB_QPT_UD ||
> @@ -578,20 +588,11 @@ static int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
>             qp_type(qp) == IB_QPT_GSI)
>                 memcpy(&wqe->av, &to_rah(ud_wr(ibwr)->ah)->av, sizeof(wqe->av));
>
> -       if (unlikely(ibwr->send_flags & IB_SEND_INLINE)) {
> -               p = wqe->dma.inline_data;
> -
> -               sge = ibwr->sg_list;
> -               for (i = 0; i < num_sge; i++, sge++) {
> -                       memcpy(p, (void *)(uintptr_t)sge->addr,
> -                                       sge->length);
> -
> -                       p += sge->length;
> -               }
> -       } else {
> +       if (unlikely(ibwr->send_flags & IB_SEND_INLINE))
> +               copy_inline_data_to_wqe(wqe, ibwr);
> +       else
>                 memcpy(wqe->dma.sge, ibwr->sg_list,
>                        num_sge * sizeof(struct ib_sge));
> -       }

I git clone  https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git,
But this commit can not be applied successfully.

Zhu Yanjun
>
>         wqe->iova = mask & WR_ATOMIC_MASK ? atomic_wr(ibwr)->remote_addr :
>                 mask & WR_READ_OR_WRITE_MASK ? rdma_wr(ibwr)->remote_addr : 0;
> @@ -603,8 +604,6 @@ static int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
>         wqe->dma.sge_offset     = 0;
>         wqe->state              = wqe_state_posted;
>         wqe->ssn                = atomic_add_return(1, &qp->ssn);
> -
> -       return 0;
>  }
>
>  static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
> @@ -627,10 +626,7 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
>         }
>
>         send_wqe = producer_addr(sq->queue);
> -
> -       err = init_send_wqe(qp, ibwr, mask, length, send_wqe);
> -       if (unlikely(err))
> -               goto err1;
> +       init_send_wqe(qp, ibwr, mask, length, send_wqe);
>
>         advance_producer(sq->queue);
>         spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
> --
> 2.27.0
>
