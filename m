Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D3B6CB774
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Mar 2023 08:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjC1GqT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Mar 2023 02:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjC1GqR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Mar 2023 02:46:17 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28A4123
        for <linux-rdma@vger.kernel.org>; Mon, 27 Mar 2023 23:46:16 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h8so45365913ede.8
        for <linux-rdma@vger.kernel.org>; Mon, 27 Mar 2023 23:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679985975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08dGnCLmX5RU9hlR/MYKq2qK6G+9EU6wlqyicfwVdD0=;
        b=Alqu18nQQb55YWlviWAF9xGVHZmhSw9KjACexvSyQ47Tf/QEgH8s1tnVSit/oVmLgM
         K7vJXBMWPSyUgDj/d48qbKGIN7pSLovtV6q10EIP0JvaBxX2MtrgFombTwvEJVh8p4TN
         OhgvO44nG3cbGxVC/C2ZE9odbDmF/I3tSk20WAF01NH1XTYL9OoteiXTZE9qXjnxFZmi
         bGA4rAtkEf48+GSukFewsv3IAi+19VVEKGDUxEziTaVllRHnGk4CV33Ks6lkdN4H5V9Z
         RZ+4TW5hLqAwmYsREN4vzYiCIiolUpsxI6C9PZ2TNQjcvQpswoj2DB0GAEL7ab59GR2n
         wsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679985975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08dGnCLmX5RU9hlR/MYKq2qK6G+9EU6wlqyicfwVdD0=;
        b=rY35wizrXfZCK2dCsuMpcUBf0G/bYy7lVW2TY7KacQS18Gq/369TAQRXrbboExI9Jp
         iWQ/imq8RJCR1ElPEWgo95YxtLZcXFcj1v27lvUnOrnLHFRrfXER3Za7mdzhukF005co
         EAP8bJPPQbZ5TTrFEVAgQpnaiZ7QGbkt3d7n3IOCnCYvZZi9m9O4l4SBWxO0WYqIkjhf
         HHZHjqB8n015uAaR4dclA+oXDJm05mIB2MPvi8Ul0YiiC8ZGfYMIfD0J2ldBbVD+Kxyz
         68z8d/N1MpuDC0iP8DStyHBS88cYi775AdmYD7McUoBzhdVc61jOB2nmpwGTCwNTAxqS
         IWTA==
X-Gm-Message-State: AAQBX9dQvlGnNM5tsEs/H+9/NQraTNnuyoxA+I2KxB8t0eLgFuL3Nxdz
        DUOD5wYI6mUDq42+LzLHkq+P+DdaSUveoQzwY7ycoo/bP84=
X-Google-Smtp-Source: AKy350a7+vwozZD1m2h+xgCWstgXqZS2LzklhbT5h3gk7kNadPIrSEpkDCwAS76E0LzZQR7Wxqhknm550IoO9iVK8/I=
X-Received: by 2002:a17:906:cf89:b0:932:4577:6705 with SMTP id
 um9-20020a170906cf8900b0093245776705mr7584535ejb.6.1679985975131; Mon, 27 Mar
 2023 23:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230327215643.10410-1-rpearsonhpe@gmail.com>
In-Reply-To: <20230327215643.10410-1-rpearsonhpe@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 28 Mar 2023 14:46:02 +0800
Message-ID: <CAD=hENcgpqt1Gj0Zp2t6Ko1r6zAnxLcUsrx4sTZLD+pWp7FuoA@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Remove tasklet call from rxe_cq.c
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, BMT@zurich.ibm.com, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 28, 2023 at 5:58=E2=80=AFAM Bob Pearson <rpearsonhpe@gmail.com>=
 wrote:
>
> Remove the tasklet call in rxe_cq.c and also the is_dying in the
> cq struct. There is no reason for the rxe driver to defer the call
> to the cq completion handler by scheduling a tasklet. rxe_cq_post()
> is not called in a hard irq context.
>
> The rxe driver currently is incorrect because the tasklet call is
> made without protecting the cq pointer with a reference from having
> the underlying memory freed before the deferred routine is called.
> Executing the comp_handler inline fixes this problem.
>
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>

Thanks

Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

> ---
>  drivers/infiniband/sw/rxe/rxe_cq.c    | 32 +++------------------------
>  drivers/infiniband/sw/rxe/rxe_verbs.c |  2 --
>  drivers/infiniband/sw/rxe/rxe_verbs.h |  2 --
>  3 files changed, 3 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/r=
xe/rxe_cq.c
> index 66a13c935d50..20ff0c0c4605 100644
> --- a/drivers/infiniband/sw/rxe/rxe_cq.c
> +++ b/drivers/infiniband/sw/rxe/rxe_cq.c
> @@ -39,21 +39,6 @@ int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq=
 *cq,
>         return -EINVAL;
>  }
>
> -static void rxe_send_complete(struct tasklet_struct *t)
> -{
> -       struct rxe_cq *cq =3D from_tasklet(cq, t, comp_task);
> -       unsigned long flags;
> -
> -       spin_lock_irqsave(&cq->cq_lock, flags);
> -       if (cq->is_dying) {
> -               spin_unlock_irqrestore(&cq->cq_lock, flags);
> -               return;
> -       }
> -       spin_unlock_irqrestore(&cq->cq_lock, flags);
> -
> -       cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
> -}
> -
>  int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
>                      int comp_vector, struct ib_udata *udata,
>                      struct rxe_create_cq_resp __user *uresp)
> @@ -79,10 +64,6 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_c=
q *cq, int cqe,
>
>         cq->is_user =3D uresp;
>
> -       cq->is_dying =3D false;
> -
> -       tasklet_setup(&cq->comp_task, rxe_send_complete);
> -
>         spin_lock_init(&cq->cq_lock);
>         cq->ibcq.cqe =3D cqe;
>         return 0;
> @@ -103,6 +84,7 @@ int rxe_cq_resize_queue(struct rxe_cq *cq, int cqe,
>         return err;
>  }
>
> +/* caller holds reference to cq */
>  int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
>  {
>         struct ib_event ev;
> @@ -136,21 +118,13 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *=
cqe, int solicited)
>         if ((cq->notify =3D=3D IB_CQ_NEXT_COMP) ||
>             (cq->notify =3D=3D IB_CQ_SOLICITED && solicited)) {
>                 cq->notify =3D 0;
> -               tasklet_schedule(&cq->comp_task);
> +
> +               cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
>         }
>
>         return 0;
>  }
>
> -void rxe_cq_disable(struct rxe_cq *cq)
> -{
> -       unsigned long flags;
> -
> -       spin_lock_irqsave(&cq->cq_lock, flags);
> -       cq->is_dying =3D true;
> -       spin_unlock_irqrestore(&cq->cq_lock, flags);
> -}
> -
>  void rxe_cq_cleanup(struct rxe_pool_elem *elem)
>  {
>         struct rxe_cq *cq =3D container_of(elem, typeof(*cq), elem);
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/s=
w/rxe/rxe_verbs.c
> index 84b53c070fc5..090d5bfb1e18 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -1178,8 +1178,6 @@ static int rxe_destroy_cq(struct ib_cq *ibcq, struc=
t ib_udata *udata)
>                 goto err_out;
>         }
>
> -       rxe_cq_disable(cq);
> -
>         err =3D rxe_cleanup(cq);
>         if (err)
>                 rxe_err_cq(cq, "cleanup failed, err =3D %d", err);
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/s=
w/rxe/rxe_verbs.h
> index 84994a474e9a..dab6fa305bf2 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -63,9 +63,7 @@ struct rxe_cq {
>         struct rxe_queue        *queue;
>         spinlock_t              cq_lock;
>         u8                      notify;
> -       bool                    is_dying;
>         bool                    is_user;
> -       struct tasklet_struct   comp_task;
>         atomic_t                num_wq;
>  };
>
> --
> 2.37.2
>
