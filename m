Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592D7736F1B
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jun 2023 16:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjFTOuC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jun 2023 10:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjFTOuB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jun 2023 10:50:01 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812C61709
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 07:49:58 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-985b04c47c3so657327766b.1
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 07:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687272597; x=1689864597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5C68Tc98/950KklwkwEjEMlxHLAau1GWbw0jDiVzCA=;
        b=ExsMe8xJIGckO5hF/EMYANYO2jryQcHOOXOXF/ETIM9NGL41TrDsO/ytJMnHCBqgn2
         SW4hFANIJkJIWLDxJYmPIAyyzmAG50KFsdNmNxdWDrkv1qFjpM2v+YI5IUI7J8iZ2sw8
         zVbN4KK5Gdn6SistSZFVlALiflSgftVFiNvdYSeFXAbJQPGyG1enuuQjTLo468mo7A85
         WN4tVhF/qsGMSco6pAimp6CA1cJ2s/l+uDH4LHun4qxj4tC9nJe8fBwLIUyCb3+Sb2mb
         bMGyOajrmCU51dHRKZ4HB55odf1C0nBT4XrN9wNwqmqOyF1xtYUtsp/Ut6l63Y7W/+6o
         8CHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687272597; x=1689864597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5C68Tc98/950KklwkwEjEMlxHLAau1GWbw0jDiVzCA=;
        b=DrArmYF0B6zbElZ9JOIQm34RXJYX5G0nF6xm4o2ZB/0LQ7Zr/A91as3YM4fjf4E3Fq
         IKUpHEF7+lOgiNW/Onm/3pCeUFmkVXv6/TLGYwfZlgxHf7ATNFx9o/Xpwq2obXn9/aob
         uoKO7SnTeAru1X/NNZRe1HSfsyFF4siO9NVQQJoVecZ326lD1V/iDr+ITjaQuFnsawX1
         CDUJM0qqDpmU+FYS7UQieQv1wwO+BFepcMxy/zB32YAofb0wvUgLNJ7QfTDyMUmus+YD
         VloybrcbJNLBeRE090u1frVHzbDEwhODuJOzVemGMH+BHiDmDI5sFcr0AWLhV7xix5pv
         X6/Q==
X-Gm-Message-State: AC+VfDxK54NsgvcA6tN9PU4v2bjLl3/N1pH77aaEfUmB0b29maigWZeZ
        CocD+CRFs7qgLMCSBsjzIgn0X4Z+z8fFdLHeHcw=
X-Google-Smtp-Source: ACHHUZ6lPmZrPIgWIWIxxuEnxQj/01iq6UY2MtPH3192kY2njY7fHWN4rtaAETJStlsc+jFerFyoWcGapbTtudlgr5U=
X-Received: by 2002:a17:907:9728:b0:973:daa0:315 with SMTP id
 jg40-20020a170907972800b00973daa00315mr10913588ejc.1.1687272596637; Tue, 20
 Jun 2023 07:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230620135519.9365-1-rpearsonhpe@gmail.com> <20230620135519.9365-2-rpearsonhpe@gmail.com>
In-Reply-To: <20230620135519.9365-2-rpearsonhpe@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 20 Jun 2023 22:49:40 +0800
Message-ID: <CAD=hENcibyPP9e8BAotUVqc1TcgD1Yym2KA3a9k4V3BWTFn6bw@mail.gmail.com>
Subject: Re: [PATCH for-next v2 1/3] RDMA/rxe: Move work queue code to subroutines
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 20, 2023 at 9:55=E2=80=AFPM Bob Pearson <rpearsonhpe@gmail.com>=
 wrote:
>
> This patch:
>         - Moves code to initialize a qp send work queue to a
>           subroutine named rxe_init_sq.
>         - Moves code to initialize a qp recv work queue to a
>           subroutine named rxe_init_rq.

This is a use-before-initialization problem. It is better to
initialize the sq/rq queues before the queues are used.
These 3 commits are complicated. It is easy to introduce some risks
just like in the first version. A compact fix is preferred.
But these commits seems to fix the problem.

Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>



>         - Moves initialization of qp request and response packet
>           queues ahead of work queue initialization so that cleanup
>           of a qp if it is not fully completed can successfully
>           attempt to drain the packet queues without a seg fault.
>         - Makes minor whitespace cleanups.
>
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c | 163 +++++++++++++++++++----------
>  1 file changed, 108 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/r=
xe/rxe_qp.c
> index 95d4a6760c33..9dbb16699c36 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -180,13 +180,63 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, s=
truct rxe_qp *qp,
>         atomic_set(&qp->skb_out, 0);
>  }
>
> +static int rxe_init_sq(struct rxe_qp *qp, struct ib_qp_init_attr *init,
> +                      struct ib_udata *udata,
> +                      struct rxe_create_qp_resp __user *uresp)
> +{
> +       struct rxe_dev *rxe =3D to_rdev(qp->ibqp.device);
> +       int wqe_size;
> +       int err;
> +
> +       qp->sq.max_wr =3D init->cap.max_send_wr;
> +       wqe_size =3D max_t(int, init->cap.max_send_sge * sizeof(struct ib=
_sge),
> +                        init->cap.max_inline_data);
> +       qp->sq.max_sge =3D wqe_size / sizeof(struct ib_sge);
> +       qp->sq.max_inline =3D wqe_size;
> +       wqe_size +=3D sizeof(struct rxe_send_wqe);
> +
> +       qp->sq.queue =3D rxe_queue_init(rxe, &qp->sq.max_wr, wqe_size,
> +                                     QUEUE_TYPE_FROM_CLIENT);
> +       if (!qp->sq.queue) {
> +               rxe_err_qp(qp, "Unable to allocate send queue");
> +               err =3D -ENOMEM;
> +               goto err_out;
> +       }
> +
> +       /* prepare info for caller to mmap send queue if user space qp */
> +       err =3D do_mmap_info(rxe, uresp ? &uresp->sq_mi : NULL, udata,
> +                          qp->sq.queue->buf, qp->sq.queue->buf_size,
> +                          &qp->sq.queue->ip);
> +       if (err) {
> +               rxe_err_qp(qp, "do_mmap_info failed, err =3D %d", err);
> +               goto err_free;
> +       }
> +
> +       /* return actual capabilities to caller which may be larger
> +        * than requested
> +        */
> +       init->cap.max_send_wr =3D qp->sq.max_wr;
> +       init->cap.max_send_sge =3D qp->sq.max_sge;
> +       init->cap.max_inline_data =3D qp->sq.max_inline;
> +
> +       return 0;
> +
> +err_free:
> +       vfree(qp->sq.queue->buf);
> +       kfree(qp->sq.queue);
> +       qp->sq.queue =3D NULL;
> +err_out:
> +       return err;
> +}
> +
>  static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>                            struct ib_qp_init_attr *init, struct ib_udata =
*udata,
>                            struct rxe_create_qp_resp __user *uresp)
>  {
>         int err;
> -       int wqe_size;
> -       enum queue_type type;
> +
> +       /* if we don't finish qp create make sure queue is valid */
> +       skb_queue_head_init(&qp->req_pkts);
>
>         err =3D sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->=
sk);
>         if (err < 0)
> @@ -201,32 +251,10 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, str=
uct rxe_qp *qp,
>          * (0xc000 - 0xffff).
>          */
>         qp->src_port =3D RXE_ROCE_V2_SPORT + (hash_32(qp_num(qp), 14) & 0=
x3fff);
> -       qp->sq.max_wr           =3D init->cap.max_send_wr;
> -
> -       /* These caps are limited by rxe_qp_chk_cap() done by the caller =
*/
> -       wqe_size =3D max_t(int, init->cap.max_send_sge * sizeof(struct ib=
_sge),
> -                        init->cap.max_inline_data);
> -       qp->sq.max_sge =3D init->cap.max_send_sge =3D
> -               wqe_size / sizeof(struct ib_sge);
> -       qp->sq.max_inline =3D init->cap.max_inline_data =3D wqe_size;
> -       wqe_size +=3D sizeof(struct rxe_send_wqe);
> -
> -       type =3D QUEUE_TYPE_FROM_CLIENT;
> -       qp->sq.queue =3D rxe_queue_init(rxe, &qp->sq.max_wr,
> -                               wqe_size, type);
> -       if (!qp->sq.queue)
> -               return -ENOMEM;
>
> -       err =3D do_mmap_info(rxe, uresp ? &uresp->sq_mi : NULL, udata,
> -                          qp->sq.queue->buf, qp->sq.queue->buf_size,
> -                          &qp->sq.queue->ip);
> -
> -       if (err) {
> -               vfree(qp->sq.queue->buf);
> -               kfree(qp->sq.queue);
> -               qp->sq.queue =3D NULL;
> +       err =3D rxe_init_sq(qp, init, udata, uresp);
> +       if (err)
>                 return err;
> -       }
>
>         qp->req.wqe_index =3D queue_get_producer(qp->sq.queue,
>                                                QUEUE_TYPE_FROM_CLIENT);
> @@ -234,8 +262,6 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struc=
t rxe_qp *qp,
>         qp->req.opcode          =3D -1;
>         qp->comp.opcode         =3D -1;
>
> -       skb_queue_head_init(&qp->req_pkts);
> -
>         rxe_init_task(&qp->req.task, qp, rxe_requester);
>         rxe_init_task(&qp->comp.task, qp, rxe_completer);
>
> @@ -247,40 +273,67 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, str=
uct rxe_qp *qp,
>         return 0;
>  }
>
> +static int rxe_init_rq(struct rxe_qp *qp, struct ib_qp_init_attr *init,
> +                      struct ib_udata *udata,
> +                      struct rxe_create_qp_resp __user *uresp)
> +{
> +       struct rxe_dev *rxe =3D to_rdev(qp->ibqp.device);
> +       int wqe_size;
> +       int err;
> +
> +       qp->rq.max_wr =3D init->cap.max_recv_wr;
> +       qp->rq.max_sge =3D init->cap.max_recv_sge;
> +       wqe_size =3D sizeof(struct rxe_recv_wqe) +
> +                               qp->rq.max_sge*sizeof(struct ib_sge);
> +
> +       qp->rq.queue =3D rxe_queue_init(rxe, &qp->rq.max_wr, wqe_size,
> +                                     QUEUE_TYPE_FROM_CLIENT);
> +       if (!qp->rq.queue) {
> +               rxe_err_qp(qp, "Unable to allocate recv queue");
> +               err =3D -ENOMEM;
> +               goto err_out;
> +       }
> +
> +       /* prepare info for caller to mmap recv queue if user space qp */
> +       err =3D do_mmap_info(rxe, uresp ? &uresp->rq_mi : NULL, udata,
> +                          qp->rq.queue->buf, qp->rq.queue->buf_size,
> +                          &qp->rq.queue->ip);
> +       if (err) {
> +               rxe_err_qp(qp, "do_mmap_info failed, err =3D %d", err);
> +               goto err_free;
> +       }
> +
> +       /* return actual capabilities to caller which may be larger
> +        * than requested
> +        */
> +       init->cap.max_recv_wr =3D qp->rq.max_wr;
> +
> +       return 0;
> +
> +err_free:
> +       vfree(qp->rq.queue->buf);
> +       kfree(qp->rq.queue);
> +       qp->rq.queue =3D NULL;
> +err_out:
> +       return err;
> +}
> +
>  static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
>                             struct ib_qp_init_attr *init,
>                             struct ib_udata *udata,
>                             struct rxe_create_qp_resp __user *uresp)
>  {
>         int err;
> -       int wqe_size;
> -       enum queue_type type;
> +
> +       /* if we don't finish qp create make sure queue is valid */
> +       skb_queue_head_init(&qp->resp_pkts);
>
>         if (!qp->srq) {
> -               qp->rq.max_wr           =3D init->cap.max_recv_wr;
> -               qp->rq.max_sge          =3D init->cap.max_recv_sge;
> -
> -               wqe_size =3D rcv_wqe_size(qp->rq.max_sge);
> -
> -               type =3D QUEUE_TYPE_FROM_CLIENT;
> -               qp->rq.queue =3D rxe_queue_init(rxe, &qp->rq.max_wr,
> -                                       wqe_size, type);
> -               if (!qp->rq.queue)
> -                       return -ENOMEM;
> -
> -               err =3D do_mmap_info(rxe, uresp ? &uresp->rq_mi : NULL, u=
data,
> -                                  qp->rq.queue->buf, qp->rq.queue->buf_s=
ize,
> -                                  &qp->rq.queue->ip);
> -               if (err) {
> -                       vfree(qp->rq.queue->buf);
> -                       kfree(qp->rq.queue);
> -                       qp->rq.queue =3D NULL;
> +               err =3D rxe_init_rq(qp, init, udata, uresp);
> +               if (err)
>                         return err;
> -               }
>         }
>
> -       skb_queue_head_init(&qp->resp_pkts);
> -
>         rxe_init_task(&qp->resp.task, qp, rxe_responder);
>
>         qp->resp.opcode         =3D OPCODE_NONE;
> @@ -307,10 +360,10 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rx=
e_qp *qp, struct rxe_pd *pd,
>         if (srq)
>                 rxe_get(srq);
>
> -       qp->pd                  =3D pd;
> -       qp->rcq                 =3D rcq;
> -       qp->scq                 =3D scq;
> -       qp->srq                 =3D srq;
> +       qp->pd =3D pd;
> +       qp->rcq =3D rcq;
> +       qp->scq =3D scq;
> +       qp->srq =3D srq;
>
>         atomic_inc(&rcq->num_wq);
>         atomic_inc(&scq->num_wq);
> --
> 2.39.2
>
