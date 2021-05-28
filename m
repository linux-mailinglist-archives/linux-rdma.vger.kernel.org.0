Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F3A393EC8
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 10:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhE1IdV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 04:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhE1IdU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 04:33:20 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750A4C061574
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 01:31:46 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id v22so3535522oic.2
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 01:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HSpHp39erPBtCVSa8Hz0tSyRxK23lkTV3StYRwfTF2Y=;
        b=vBkVgv4XPKKlsl/QHhvqbj22GoKAlPUII+7yOY3lLwfI8HYRQ1WeghScNGcmEBKhce
         kC0gTDq/UvAAifcvEVM+eleoVlsOcLgfQkSNH0Gf0z+NGeYxKXxb3Ba9DR8C3wk5aQ7P
         ugS4NnrFg1nJ7bpHASZ3SJz4jipWdmrFjSHPsUAYjU4BJNmcHail64PcsCl54ViYWBc6
         FXzH26Cv5rwfCoc/czz5dgSQpQ87PryNdyndepNok4c1A6ZOGObayGl9Uw8Gg0ZSTuRy
         8MAFlTJHzsiNEgx6lrkuR+9ib72B886e+dGRLd2uiyjk8urEhg17NXmzEs/uI9kZqSF8
         CpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HSpHp39erPBtCVSa8Hz0tSyRxK23lkTV3StYRwfTF2Y=;
        b=Bp0Pstr8eW+6Zc4WmO1PwmjivjadWPPuu9rgFDhBshmOhnQtcgBgnk8XBO5bqTMI0h
         VnpTtNn7fSTyxKx5boALS1tzEvNY2kMwCUgPMleRRVX0mivjR0bocrnKukO6eY/XhsYg
         LNnfgmO6Gl0a/Pz7LZrTolXxvgbbBKYDcjD46fc+TFtGVQC/IWR/IDPN95Sb0sz486hc
         uYm43gHWH7jjsrGhqWB3cGkDN3HMSgvxHTM6L4v+Ox+wJXmDxLfyEN68UJz3U6xH30UM
         XthWOfPP9PblVIkmkn4OcsRFVUTPWnNcFHKGEhVXlF43+4qHwavO3dsKF7bnEl7M0i96
         rWVQ==
X-Gm-Message-State: AOAM530J0tpv/pVlJhpxRR/IPdctd3NGJ7K6NxH0woERmdeNmoxnmvVE
        CMUMg2EsTJXK6zcy45NjXegTIgNANAnJdPEpjtLkEfiMUtc=
X-Google-Smtp-Source: ABdhPJzVr5/dG9tUoCLMyzmu32BUmjNhqn9Pte0Q8wvHa/i0l6FS4aUC8jwrSsXm+eybK5XpobRvNebW6KNAbd+/6p0=
X-Received: by 2002:aca:220b:: with SMTP id b11mr8305988oic.89.1622190705857;
 Fri, 28 May 2021 01:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210527194748.662636-1-rpearsonhpe@gmail.com> <20210527194748.662636-2-rpearsonhpe@gmail.com>
In-Reply-To: <20210527194748.662636-2-rpearsonhpe@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Fri, 28 May 2021 16:31:34 +0800
Message-ID: <CAD=hENfX_N-pDgLXzYMTfi1=Qa+W6beGDrsvcVDiNRb0Tm-idA@mail.gmail.com>
Subject: Re: [PATCH for-next v3 1/3] RDMA/rxe: Add a type flag to rxe_queue structs
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 28, 2021 at 3:47 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> To create optimal code only want to use smp_load_acquire() and
> smp_store_release() for user indices in rxe_queue APIs since
> kernel indices are protected by locks which also act as memory
> barriers. By adding a type to the queues we can determine which
> indices need to be protected.
>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_cq.c    |  4 +++-
>  drivers/infiniband/sw/rxe/rxe_qp.c    | 12 ++++++++----
>  drivers/infiniband/sw/rxe/rxe_queue.c |  8 ++++----
>  drivers/infiniband/sw/rxe/rxe_queue.h | 13 ++++++++++---
>  drivers/infiniband/sw/rxe/rxe_srq.c   |  4 +++-
>  5 files changed, 28 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
> index b315ebf041ac..1d4d8a31bc12 100644
> --- a/drivers/infiniband/sw/rxe/rxe_cq.c
> +++ b/drivers/infiniband/sw/rxe/rxe_cq.c
> @@ -59,9 +59,11 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
>                      struct rxe_create_cq_resp __user *uresp)
>  {
>         int err;
> +       enum queue_type type;
>
> +       type = uresp ? QUEUE_TYPE_TO_USER : QUEUE_TYPE_KERNEL;

When is QUEUE_TYPE_TO_USER used? and when is QUEUE_TYPE_FROM_USER is used?

Zhu Yanjun

>         cq->queue = rxe_queue_init(rxe, &cqe,
> -                                  sizeof(struct rxe_cqe));
> +                       sizeof(struct rxe_cqe), type);
>         if (!cq->queue) {
>                 pr_warn("unable to create cq\n");
>                 return -ENOMEM;
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index 34ae957a315c..9bd6bf8f9bd9 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -206,6 +206,7 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>  {
>         int err;
>         int wqe_size;
> +       enum queue_type type;
>
>         err = sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->sk);
>         if (err < 0)
> @@ -231,7 +232,9 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>         qp->sq.max_inline = init->cap.max_inline_data = wqe_size;
>         wqe_size += sizeof(struct rxe_send_wqe);
>
> -       qp->sq.queue = rxe_queue_init(rxe, &qp->sq.max_wr, wqe_size);
> +       type = uresp ? QUEUE_TYPE_FROM_USER : QUEUE_TYPE_KERNEL;
> +       qp->sq.queue = rxe_queue_init(rxe, &qp->sq.max_wr,
> +                               wqe_size, type);
>         if (!qp->sq.queue)
>                 return -ENOMEM;
>
> @@ -273,6 +276,7 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
>  {
>         int err;
>         int wqe_size;
> +       enum queue_type type;
>
>         if (!qp->srq) {
>                 qp->rq.max_wr           = init->cap.max_recv_wr;
> @@ -283,9 +287,9 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
>                 pr_debug("qp#%d max_wr = %d, max_sge = %d, wqe_size = %d\n",
>                          qp_num(qp), qp->rq.max_wr, qp->rq.max_sge, wqe_size);
>
> -               qp->rq.queue = rxe_queue_init(rxe,
> -                                             &qp->rq.max_wr,
> -                                             wqe_size);
> +               type = uresp ? QUEUE_TYPE_FROM_USER : QUEUE_TYPE_KERNEL;
> +               qp->rq.queue = rxe_queue_init(rxe, &qp->rq.max_wr,
> +                                       wqe_size, type);
>                 if (!qp->rq.queue)
>                         return -ENOMEM;
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/rxe/rxe_queue.c
> index fa69241b1187..8f844d0b9e77 100644
> --- a/drivers/infiniband/sw/rxe/rxe_queue.c
> +++ b/drivers/infiniband/sw/rxe/rxe_queue.c
> @@ -52,9 +52,8 @@ inline void rxe_queue_reset(struct rxe_queue *q)
>         memset(q->buf->data, 0, q->buf_size - sizeof(struct rxe_queue_buf));
>  }
>
> -struct rxe_queue *rxe_queue_init(struct rxe_dev *rxe,
> -                                int *num_elem,
> -                                unsigned int elem_size)
> +struct rxe_queue *rxe_queue_init(struct rxe_dev *rxe, int *num_elem,
> +                       unsigned int elem_size, enum queue_type type)
>  {
>         struct rxe_queue *q;
>         size_t buf_size;
> @@ -69,6 +68,7 @@ struct rxe_queue *rxe_queue_init(struct rxe_dev *rxe,
>                 goto err1;
>
>         q->rxe = rxe;
> +       q->type = type;
>
>         /* used in resize, only need to copy used part of queue */
>         q->elem_size = elem_size;
> @@ -136,7 +136,7 @@ int rxe_queue_resize(struct rxe_queue *q, unsigned int *num_elem_p,
>         int err;
>         unsigned long flags = 0, flags1;
>
> -       new_q = rxe_queue_init(q->rxe, &num_elem, elem_size);
> +       new_q = rxe_queue_init(q->rxe, &num_elem, elem_size, q->type);
>         if (!new_q)
>                 return -ENOMEM;
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_queue.h b/drivers/infiniband/sw/rxe/rxe_queue.h
> index 2902ca7b288c..4512745419f8 100644
> --- a/drivers/infiniband/sw/rxe/rxe_queue.h
> +++ b/drivers/infiniband/sw/rxe/rxe_queue.h
> @@ -19,6 +19,13 @@
>   * of the queue is one less than the number of element slots
>   */
>
> +/* type of queue */
> +enum queue_type {
> +       QUEUE_TYPE_KERNEL,
> +       QUEUE_TYPE_TO_USER,
> +       QUEUE_TYPE_FROM_USER,
> +};
> +
>  struct rxe_queue {
>         struct rxe_dev          *rxe;
>         struct rxe_queue_buf    *buf;
> @@ -27,6 +34,7 @@ struct rxe_queue {
>         size_t                  elem_size;
>         unsigned int            log2_elem_size;
>         u32                     index_mask;
> +       enum queue_type         type;
>  };
>
>  int do_mmap_info(struct rxe_dev *rxe, struct mminfo __user *outbuf,
> @@ -35,9 +43,8 @@ int do_mmap_info(struct rxe_dev *rxe, struct mminfo __user *outbuf,
>
>  void rxe_queue_reset(struct rxe_queue *q);
>
> -struct rxe_queue *rxe_queue_init(struct rxe_dev *rxe,
> -                                int *num_elem,
> -                                unsigned int elem_size);
> +struct rxe_queue *rxe_queue_init(struct rxe_dev *rxe, int *num_elem,
> +                       unsigned int elem_size, enum queue_type type);
>
>  int rxe_queue_resize(struct rxe_queue *q, unsigned int *num_elem_p,
>                      unsigned int elem_size, struct ib_udata *udata,
> diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
> index 41b0d1e11baf..52c5593741ec 100644
> --- a/drivers/infiniband/sw/rxe/rxe_srq.c
> +++ b/drivers/infiniband/sw/rxe/rxe_srq.c
> @@ -78,6 +78,7 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
>         int err;
>         int srq_wqe_size;
>         struct rxe_queue *q;
> +       enum queue_type type;
>
>         srq->ibsrq.event_handler        = init->event_handler;
>         srq->ibsrq.srq_context          = init->srq_context;
> @@ -91,8 +92,9 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
>         spin_lock_init(&srq->rq.producer_lock);
>         spin_lock_init(&srq->rq.consumer_lock);
>
> +       type = uresp ? QUEUE_TYPE_FROM_USER : QUEUE_TYPE_KERNEL;
>         q = rxe_queue_init(rxe, &srq->rq.max_wr,
> -                          srq_wqe_size);
> +                       srq_wqe_size, type);
>         if (!q) {
>                 pr_warn("unable to allocate queue for srq\n");
>                 return -ENOMEM;
> --
> 2.30.2
>
