Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9604C4B7C4F
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Feb 2022 02:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbiBPBKv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 20:10:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245513AbiBPBKi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 20:10:38 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C639106B34
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 17:09:23 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id j7so884121lfu.6
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 17:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U5LL5agzgByZGJTECbnzCSe73DvZ6s1nTx3JB1FViCY=;
        b=JazBFsLpdXv93jCjtUfIwCFH8THDj9AqnuBBIRQ5d8N3TsEn8HzYAoEB487R5psEXY
         CX3rOhpj587EblgxAs6UlksOSmWB5mUy9yx1N+ndVuG/q5ErlV2RjKx/XcIYj841+dOm
         NmKSrNmkugk2TpecmGIwhIY1+FxngqHn6HwnEoJ5LFcYk6u7enw1mxfuV8GYkZ7KVBu8
         bcHoTFIuHKInD6nq2kpnFDAdZsMZh4IjI+tPYQEUrR8RHB86z5q00lKWd0JWDV3hi+3m
         DbdktpkHFFjQ0EbhkdHT46dHuxgk/FxTZ4BWAHZKbJmIbJX/oaduQrasL4nkR7W5l3b3
         nyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U5LL5agzgByZGJTECbnzCSe73DvZ6s1nTx3JB1FViCY=;
        b=ey+1GkoLCgQCAgMMQeGdPT983cVAfk2ZkNVNbOI6iGGFq+M1IwInr1r6B0cDlo26nC
         IHWq0g2I/l5mZN6CmGFHkPG7YEraseCqWRi9vO2hiZeDHR/qJPq7EyYQRLJgfrAUplQW
         qGQsd9ZfMqJKcm/KgM4rIZ0fIUPR0tQLpP5fNbUVnYabAblnucymfJiaiBVkv1eh1NKJ
         KbKPBgqiCTvqCJSMWu/tyrorgAiAaPNe4mk2gLLlHMxSGYqgMZc3f05Rt4JB269JItqf
         H/yZnpd2eQrbHdwNrb1L/CPOu8cJJpmrUJX1Az0u2ya++liQLkeSw1gg7Jbma8xfT+65
         urUg==
X-Gm-Message-State: AOAM531cFv0grkmwQIp9KkES3WJUvwhT+0rW8H5OHKRXMfFzXV8q/NTh
        eEB3qeGTLsEr/wm12N3uh/d6IQ1yaW/RnYr2Ebb7AEf3
X-Google-Smtp-Source: ABdhPJxCeF3E89aYuhhPabJfehmigBZEJ5WzkWsKrwOYuF493ylzlU4Cj/CVHakOsgrDzwkmz5rCU4mfQi23R/kek2Y=
X-Received: by 2002:a05:6512:511:b0:443:3f9f:5d5c with SMTP id
 o17-20020a056512051100b004433f9f5d5cmr325109lfb.94.1644973761479; Tue, 15 Feb
 2022 17:09:21 -0800 (PST)
MIME-Version: 1.0
References: <20220215194448.44369-1-rpearsonhpe@gmail.com>
In-Reply-To: <20220215194448.44369-1-rpearsonhpe@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 16 Feb 2022 09:09:09 +0800
Message-ID: <CAD=hENfBZs5NNJzB2-tFYGjBJJ1txMj+jQCw9XAmwwDA3-o06w@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Revert changes from irqsave to bh locks
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>, guoqing.jiang@linux.dev,
        Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 16, 2022 at 3:49 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> A previous patch replaced all irqsave locks in rxe with bh locks.
> This ran into problems because rdmacm has a bad habit of
> calling rdma verbs APIs while disabling irqs. This is not allowed
> during spin_unlock_bh() causing programs that use rdmacm to fail.
> This patch reverts the changes to locks that had this problem or
> got dragged into the same mess. After this patch blktests/check -q srp
> now runs correctly.
>
> This patch applies cleanly to current for-next
>
> commit: 2f1b2820b546 ("Merge branch 'irdma_dscp' into rdma.git for-next")
>
> Reported-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> Reported-by: Bart Van Assche <bvanassche@acm.org>
> Fixes: 21adfa7a3c4e ("RDMA/rxe: Replace irqsave locks with bh locks")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>

Thanks.

Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun
> ---
>  drivers/infiniband/sw/rxe/rxe_cq.c    | 20 +++++++++++-------
>  drivers/infiniband/sw/rxe/rxe_mcast.c | 19 ++++++++++-------
>  drivers/infiniband/sw/rxe/rxe_pool.c  | 30 ++++++++++++++++-----------
>  drivers/infiniband/sw/rxe/rxe_queue.c | 10 +++++----
>  drivers/infiniband/sw/rxe/rxe_resp.c  | 11 +++++-----
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 27 ++++++++++++++----------
>  6 files changed, 69 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
> index 6baaaa34458e..642b52539ac3 100644
> --- a/drivers/infiniband/sw/rxe/rxe_cq.c
> +++ b/drivers/infiniband/sw/rxe/rxe_cq.c
> @@ -42,13 +42,14 @@ int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq *cq,
>  static void rxe_send_complete(struct tasklet_struct *t)
>  {
>         struct rxe_cq *cq = from_tasklet(cq, t, comp_task);
> +       unsigned long flags;
>
> -       spin_lock_bh(&cq->cq_lock);
> +       spin_lock_irqsave(&cq->cq_lock, flags);
>         if (cq->is_dying) {
> -               spin_unlock_bh(&cq->cq_lock);
> +               spin_unlock_irqrestore(&cq->cq_lock, flags);
>                 return;
>         }
> -       spin_unlock_bh(&cq->cq_lock);
> +       spin_unlock_irqrestore(&cq->cq_lock, flags);
>
>         cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
>  }
> @@ -107,12 +108,13 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
>         struct ib_event ev;
>         int full;
>         void *addr;
> +       unsigned long flags;
>
> -       spin_lock_bh(&cq->cq_lock);
> +       spin_lock_irqsave(&cq->cq_lock, flags);
>
>         full = queue_full(cq->queue, QUEUE_TYPE_TO_CLIENT);
>         if (unlikely(full)) {
> -               spin_unlock_bh(&cq->cq_lock);
> +               spin_unlock_irqrestore(&cq->cq_lock, flags);
>                 if (cq->ibcq.event_handler) {
>                         ev.device = cq->ibcq.device;
>                         ev.element.cq = &cq->ibcq;
> @@ -128,7 +130,7 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
>
>         queue_advance_producer(cq->queue, QUEUE_TYPE_TO_CLIENT);
>
> -       spin_unlock_bh(&cq->cq_lock);
> +       spin_unlock_irqrestore(&cq->cq_lock, flags);
>
>         if ((cq->notify == IB_CQ_NEXT_COMP) ||
>             (cq->notify == IB_CQ_SOLICITED && solicited)) {
> @@ -141,9 +143,11 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
>
>  void rxe_cq_disable(struct rxe_cq *cq)
>  {
> -       spin_lock_bh(&cq->cq_lock);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&cq->cq_lock, flags);
>         cq->is_dying = true;
> -       spin_unlock_bh(&cq->cq_lock);
> +       spin_unlock_irqrestore(&cq->cq_lock, flags);
>  }
>
>  void rxe_cq_cleanup(struct rxe_pool_elem *elem)
> diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
> index 9336295c4ee2..2878a56d9994 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mcast.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
> @@ -58,11 +58,12 @@ static int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
>         int err;
>         struct rxe_mcg *grp;
>         struct rxe_pool *pool = &rxe->mc_grp_pool;
> +       unsigned long flags;
>
>         if (rxe->attr.max_mcast_qp_attach == 0)
>                 return -EINVAL;
>
> -       write_lock_bh(&pool->pool_lock);
> +       write_lock_irqsave(&pool->pool_lock, flags);
>
>         grp = rxe_pool_get_key_locked(pool, mgid);
>         if (grp)
> @@ -70,13 +71,13 @@ static int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
>
>         grp = create_grp(rxe, pool, mgid);
>         if (IS_ERR(grp)) {
> -               write_unlock_bh(&pool->pool_lock);
> +               write_unlock_irqrestore(&pool->pool_lock, flags);
>                 err = PTR_ERR(grp);
>                 return err;
>         }
>
>  done:
> -       write_unlock_bh(&pool->pool_lock);
> +       write_unlock_irqrestore(&pool->pool_lock, flags);
>         *grp_p = grp;
>         return 0;
>  }
> @@ -86,9 +87,10 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
>  {
>         int err;
>         struct rxe_mca *elem;
> +       unsigned long flags;
>
>         /* check to see of the qp is already a member of the group */
> -       spin_lock_bh(&grp->mcg_lock);
> +       spin_lock_irqsave(&grp->mcg_lock, flags);
>         list_for_each_entry(elem, &grp->qp_list, qp_list) {
>                 if (elem->qp == qp) {
>                         err = 0;
> @@ -118,7 +120,7 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
>
>         err = 0;
>  out:
> -       spin_unlock_bh(&grp->mcg_lock);
> +       spin_unlock_irqrestore(&grp->mcg_lock, flags);
>         return err;
>  }
>
> @@ -127,12 +129,13 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
>  {
>         struct rxe_mcg *grp;
>         struct rxe_mca *elem, *tmp;
> +       unsigned long flags;
>
>         grp = rxe_pool_get_key(&rxe->mc_grp_pool, mgid);
>         if (!grp)
>                 goto err1;
>
> -       spin_lock_bh(&grp->mcg_lock);
> +       spin_lock_irqsave(&grp->mcg_lock, flags);
>
>         list_for_each_entry_safe(elem, tmp, &grp->qp_list, qp_list) {
>                 if (elem->qp == qp) {
> @@ -140,7 +143,7 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
>                         grp->num_qp--;
>                         atomic_dec(&qp->mcg_num);
>
> -                       spin_unlock_bh(&grp->mcg_lock);
> +                       spin_unlock_irqrestore(&grp->mcg_lock, flags);
>                         rxe_drop_ref(elem);
>                         rxe_drop_ref(grp);      /* ref held by QP */
>                         rxe_drop_ref(grp);      /* ref from get_key */
> @@ -148,7 +151,7 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
>                 }
>         }
>
> -       spin_unlock_bh(&grp->mcg_lock);
> +       spin_unlock_irqrestore(&grp->mcg_lock, flags);
>         rxe_drop_ref(grp);                      /* ref from get_key */
>  err1:
>         return -EINVAL;
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index 63c594173565..a11dab13c192 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -260,11 +260,12 @@ int __rxe_add_key_locked(struct rxe_pool_elem *elem, void *key)
>  int __rxe_add_key(struct rxe_pool_elem *elem, void *key)
>  {
>         struct rxe_pool *pool = elem->pool;
> +       unsigned long flags;
>         int err;
>
> -       write_lock_bh(&pool->pool_lock);
> +       write_lock_irqsave(&pool->pool_lock, flags);
>         err = __rxe_add_key_locked(elem, key);
> -       write_unlock_bh(&pool->pool_lock);
> +       write_unlock_irqrestore(&pool->pool_lock, flags);
>
>         return err;
>  }
> @@ -279,10 +280,11 @@ void __rxe_drop_key_locked(struct rxe_pool_elem *elem)
>  void __rxe_drop_key(struct rxe_pool_elem *elem)
>  {
>         struct rxe_pool *pool = elem->pool;
> +       unsigned long flags;
>
> -       write_lock_bh(&pool->pool_lock);
> +       write_lock_irqsave(&pool->pool_lock, flags);
>         __rxe_drop_key_locked(elem);
> -       write_unlock_bh(&pool->pool_lock);
> +       write_unlock_irqrestore(&pool->pool_lock, flags);
>  }
>
>  int __rxe_add_index_locked(struct rxe_pool_elem *elem)
> @@ -299,11 +301,12 @@ int __rxe_add_index_locked(struct rxe_pool_elem *elem)
>  int __rxe_add_index(struct rxe_pool_elem *elem)
>  {
>         struct rxe_pool *pool = elem->pool;
> +       unsigned long flags;
>         int err;
>
> -       write_lock_bh(&pool->pool_lock);
> +       write_lock_irqsave(&pool->pool_lock, flags);
>         err = __rxe_add_index_locked(elem);
> -       write_unlock_bh(&pool->pool_lock);
> +       write_unlock_irqrestore(&pool->pool_lock, flags);
>
>         return err;
>  }
> @@ -319,10 +322,11 @@ void __rxe_drop_index_locked(struct rxe_pool_elem *elem)
>  void __rxe_drop_index(struct rxe_pool_elem *elem)
>  {
>         struct rxe_pool *pool = elem->pool;
> +       unsigned long flags;
>
> -       write_lock_bh(&pool->pool_lock);
> +       write_lock_irqsave(&pool->pool_lock, flags);
>         __rxe_drop_index_locked(elem);
> -       write_unlock_bh(&pool->pool_lock);
> +       write_unlock_irqrestore(&pool->pool_lock, flags);
>  }
>
>  void *rxe_alloc_locked(struct rxe_pool *pool)
> @@ -440,11 +444,12 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
>
>  void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
>  {
> +       unsigned long flags;
>         void *obj;
>
> -       read_lock_bh(&pool->pool_lock);
> +       read_lock_irqsave(&pool->pool_lock, flags);
>         obj = rxe_pool_get_index_locked(pool, index);
> -       read_unlock_bh(&pool->pool_lock);
> +       read_unlock_irqrestore(&pool->pool_lock, flags);
>
>         return obj;
>  }
> @@ -484,11 +489,12 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
>
>  void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
>  {
> +       unsigned long flags;
>         void *obj;
>
> -       read_lock_bh(&pool->pool_lock);
> +       read_lock_irqsave(&pool->pool_lock, flags);
>         obj = rxe_pool_get_key_locked(pool, key);
> -       read_unlock_bh(&pool->pool_lock);
> +       read_unlock_irqrestore(&pool->pool_lock, flags);
>
>         return obj;
>  }
> diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/rxe/rxe_queue.c
> index a1b283dd2d4c..dbd4971039c0 100644
> --- a/drivers/infiniband/sw/rxe/rxe_queue.c
> +++ b/drivers/infiniband/sw/rxe/rxe_queue.c
> @@ -151,6 +151,8 @@ int rxe_queue_resize(struct rxe_queue *q, unsigned int *num_elem_p,
>         struct rxe_queue *new_q;
>         unsigned int num_elem = *num_elem_p;
>         int err;
> +       unsigned long producer_flags;
> +       unsigned long consumer_flags;
>
>         new_q = rxe_queue_init(q->rxe, &num_elem, elem_size, q->type);
>         if (!new_q)
> @@ -164,17 +166,17 @@ int rxe_queue_resize(struct rxe_queue *q, unsigned int *num_elem_p,
>                 goto err1;
>         }
>
> -       spin_lock_bh(consumer_lock);
> +       spin_lock_irqsave(consumer_lock, consumer_flags);
>
>         if (producer_lock) {
> -               spin_lock_bh(producer_lock);
> +               spin_lock_irqsave(producer_lock, producer_flags);
>                 err = resize_finish(q, new_q, num_elem);
> -               spin_unlock_bh(producer_lock);
> +               spin_unlock_irqrestore(producer_lock, producer_flags);
>         } else {
>                 err = resize_finish(q, new_q, num_elem);
>         }
>
> -       spin_unlock_bh(consumer_lock);
> +       spin_unlock_irqrestore(consumer_lock, consumer_flags);
>
>         rxe_queue_cleanup(new_q);       /* new/old dep on err */
>         if (err)
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index 380934e38923..c369d78fc8e8 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -297,21 +297,22 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
>         struct ib_event ev;
>         unsigned int count;
>         size_t size;
> +       unsigned long flags;
>
>         if (srq->error)
>                 return RESPST_ERR_RNR;
>
> -       spin_lock_bh(&srq->rq.consumer_lock);
> +       spin_lock_irqsave(&srq->rq.consumer_lock, flags);
>
>         wqe = queue_head(q, QUEUE_TYPE_FROM_CLIENT);
>         if (!wqe) {
> -               spin_unlock_bh(&srq->rq.consumer_lock);
> +               spin_unlock_irqrestore(&srq->rq.consumer_lock, flags);
>                 return RESPST_ERR_RNR;
>         }
>
>         /* don't trust user space data */
>         if (unlikely(wqe->dma.num_sge > srq->rq.max_sge)) {
> -               spin_unlock_bh(&srq->rq.consumer_lock);
> +               spin_unlock_irqrestore(&srq->rq.consumer_lock, flags);
>                 pr_warn("%s: invalid num_sge in SRQ entry\n", __func__);
>                 return RESPST_ERR_MALFORMED_WQE;
>         }
> @@ -327,11 +328,11 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
>                 goto event;
>         }
>
> -       spin_unlock_bh(&srq->rq.consumer_lock);
> +       spin_unlock_irqrestore(&srq->rq.consumer_lock, flags);
>         return RESPST_CHK_LENGTH;
>
>  event:
> -       spin_unlock_bh(&srq->rq.consumer_lock);
> +       spin_unlock_irqrestore(&srq->rq.consumer_lock, flags);
>         ev.device = qp->ibqp.device;
>         ev.element.srq = qp->ibqp.srq;
>         ev.event = IB_EVENT_SRQ_LIMIT_REACHED;
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 9f0aef4b649d..80df9a8f71a1 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -384,8 +384,9 @@ static int rxe_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
>  {
>         int err = 0;
>         struct rxe_srq *srq = to_rsrq(ibsrq);
> +       unsigned long flags;
>
> -       spin_lock_bh(&srq->rq.producer_lock);
> +       spin_lock_irqsave(&srq->rq.producer_lock, flags);
>
>         while (wr) {
>                 err = post_one_recv(&srq->rq, wr);
> @@ -394,7 +395,7 @@ static int rxe_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
>                 wr = wr->next;
>         }
>
> -       spin_unlock_bh(&srq->rq.producer_lock);
> +       spin_unlock_irqrestore(&srq->rq.producer_lock, flags);
>
>         if (err)
>                 *bad_wr = wr;
> @@ -643,18 +644,19 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
>         int err;
>         struct rxe_sq *sq = &qp->sq;
>         struct rxe_send_wqe *send_wqe;
> +       unsigned long flags;
>         int full;
>
>         err = validate_send_wr(qp, ibwr, mask, length);
>         if (err)
>                 return err;
>
> -       spin_lock_bh(&qp->sq.sq_lock);
> +       spin_lock_irqsave(&qp->sq.sq_lock, flags);
>
>         full = queue_full(sq->queue, QUEUE_TYPE_TO_DRIVER);
>
>         if (unlikely(full)) {
> -               spin_unlock_bh(&qp->sq.sq_lock);
> +               spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
>                 return -ENOMEM;
>         }
>
> @@ -663,7 +665,7 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
>
>         queue_advance_producer(sq->queue, QUEUE_TYPE_TO_DRIVER);
>
> -       spin_unlock_bh(&qp->sq.sq_lock);
> +       spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
>
>         return 0;
>  }
> @@ -743,6 +745,7 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
>         int err = 0;
>         struct rxe_qp *qp = to_rqp(ibqp);
>         struct rxe_rq *rq = &qp->rq;
> +       unsigned long flags;
>
>         if (unlikely((qp_state(qp) < IB_QPS_INIT) || !qp->valid)) {
>                 *bad_wr = wr;
> @@ -756,7 +759,7 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
>                 goto err1;
>         }
>
> -       spin_lock_bh(&rq->producer_lock);
> +       spin_lock_irqsave(&rq->producer_lock, flags);
>
>         while (wr) {
>                 err = post_one_recv(rq, wr);
> @@ -767,7 +770,7 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
>                 wr = wr->next;
>         }
>
> -       spin_unlock_bh(&rq->producer_lock);
> +       spin_unlock_irqrestore(&rq->producer_lock, flags);
>
>         if (qp->resp.state == QP_STATE_ERROR)
>                 rxe_run_task(&qp->resp.task, 1);
> @@ -848,8 +851,9 @@ static int rxe_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
>         int i;
>         struct rxe_cq *cq = to_rcq(ibcq);
>         struct rxe_cqe *cqe;
> +       unsigned long flags;
>
> -       spin_lock_bh(&cq->cq_lock);
> +       spin_lock_irqsave(&cq->cq_lock, flags);
>         for (i = 0; i < num_entries; i++) {
>                 cqe = queue_head(cq->queue, QUEUE_TYPE_FROM_DRIVER);
>                 if (!cqe)
> @@ -858,7 +862,7 @@ static int rxe_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
>                 memcpy(wc++, &cqe->ibwc, sizeof(*wc));
>                 queue_advance_consumer(cq->queue, QUEUE_TYPE_FROM_DRIVER);
>         }
> -       spin_unlock_bh(&cq->cq_lock);
> +       spin_unlock_irqrestore(&cq->cq_lock, flags);
>
>         return i;
>  }
> @@ -878,8 +882,9 @@ static int rxe_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
>         struct rxe_cq *cq = to_rcq(ibcq);
>         int ret = 0;
>         int empty;
> +       unsigned long irq_flags;
>
> -       spin_lock_bh(&cq->cq_lock);
> +       spin_lock_irqsave(&cq->cq_lock, irq_flags);
>         if (cq->notify != IB_CQ_NEXT_COMP)
>                 cq->notify = flags & IB_CQ_SOLICITED_MASK;
>
> @@ -888,7 +893,7 @@ static int rxe_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
>         if ((flags & IB_CQ_REPORT_MISSED_EVENTS) && !empty)
>                 ret = 1;
>
> -       spin_unlock_bh(&cq->cq_lock);
> +       spin_unlock_irqrestore(&cq->cq_lock, irq_flags);
>
>         return ret;
>  }
> --
> 2.32.0
>
