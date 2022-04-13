Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDA84FEEE2
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Apr 2022 07:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbiDMGA4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Apr 2022 02:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiDMGAx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Apr 2022 02:00:53 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EA05045A
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 22:58:29 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id r2so884076ljd.10
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 22:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9wH8mzMzEdsUmH2g4nYix+b7HKLn2NJRXyYbJRN2Tnk=;
        b=e0PEaQesoS/jT2FBuAFHYafrdtIrSIsWhWgsd3pQQPVVAcoxCnB7rM7KdzaH4ZEV6M
         cJZKAYikMIXOX5BZaFxXF5ilhvO2rtfoPIRiCoxNyWQs4T9Y0RMBqtLGwf5o7I4c7Cx3
         2jx9or4d9FpKJgTWCuNQ6CjpgxOGhdJug7SQWnjQGHw5WX2aCbXxFBQyyTSv8Q5lyLvr
         kuGr4EFwupOtsVPq1MmIx+pzEfTOyRdBwG7g3lmpz29C6DS424uXN5TW2rUyUHFcux/z
         2e69QaZ2J7zttcO6wvYAX20Q+2ORPaep3zpHjFiP2/+275WrZEcdh687dZhlj2D0pZNg
         F6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9wH8mzMzEdsUmH2g4nYix+b7HKLn2NJRXyYbJRN2Tnk=;
        b=ezuyaAlOAJ69g8pw90xidOBgH/onosxaFJS+1sOPNvUC1FFA1SUvqSR7n+p6cRhGCl
         +35zVVj4iO/EuZij9x/6AP3a0MBKwkmEgZ7uRZvuhU0oTChqQu3flIFYKYINxY77RMFj
         lT5hS6J3anA51vjIcrRqCtzJUaXAtUJVOADc9yX2sjj/OECHbY8dy2/S5usNBjqPMHH0
         bnN+rjuQD4ZXkXYDO0GjUP6kCrLJxmKzlbqDwlI4Eht5WiBCkDIsjnoIyXjYyEFM32T+
         oLQBlw0pXhVhtfcdlK8uPjKImzTIJr/9ARZEd59tA/tnAWyvk4hmK8fDuPGEbL9Jgsso
         Opsg==
X-Gm-Message-State: AOAM533iqdY2nXHGa888saIuUsfoGBLrrnor/Kc5voZvnAwINdkGHTu1
        OsX05OmL8v060p8G9Qo6AEt+i9Ey45HlsBijLEY=
X-Google-Smtp-Source: ABdhPJxzsGFMKYyIT6SLLIapwF/zWEqAa7WYK1m+hL5woIQTb97W54LZ7vr5WiMkdQbb4ZYVJz3ELWMPwsJc0EAB1GQ=
X-Received: by 2002:a2e:7c16:0:b0:244:be33:9718 with SMTP id
 x22-20020a2e7c16000000b00244be339718mr25127959ljc.467.1649829507568; Tue, 12
 Apr 2022 22:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220413052937.92713-1-rpearsonhpe@gmail.com>
In-Reply-To: <20220413052937.92713-1-rpearsonhpe@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 13 Apr 2022 13:58:15 +0800
Message-ID: <CAD=hENfro+0=Euk=Ja6uUxVXcOhCdT9vbeubm4=VehHa5tgF5A@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix "RDMA/rxe: Cleanup rxe_mcast.c"
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
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

On Wed, Apr 13, 2022 at 1:31 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> rxe_mcast.c currently uses _irqsave spinlocks for rxe->mcg_lock
> while rxe_recv.c uses _bh spinlocks for the same lock. Adding
> tracing shows that the code in rxe_mcast.c is all executed in_task()
> context while the code in rxe_recv.c that refers to the lock
> executes in softirq context. This causes a lockdep warning in code
> that executes multicast I/O including blktests check srp.
>
> Change the locking of rxe->mcg_lock in rxe_mcast.c to use
> spin_(un)lock_bh().

Now RXE is not stable. We should focus on the problem of RXE.

Zhu Yanjun

>
> With this change the following locks in rdma_rxe which are all _bh
> show no lockdep warnings.
>
>         atomic_ops_lock
>         mw->lock
>         port->port_lock
>         qp->state_lock
>         rxe->mcg_lock
>         rxe->mmap_offset_lock
>         rxe->pending_lock
>         task->state_lock
>
> The only other remaining lock is pool->xa.xa_lock which
> must either be some combination of _bh and _irq types depending
> on the object type (== ah or not) or plain spin_lock if
> the read side operations are converted to use rcu_read_lock().
>
> Fixes: 6090a0c4c7c6 ("RDMA/rxe: Cleanup rxe_mcast.c")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_mcast.c | 36 +++++++++++----------------
>  1 file changed, 15 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
> index ae8f11cb704a..7f50566b8d89 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mcast.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
> @@ -143,11 +143,10 @@ static struct rxe_mcg *__rxe_lookup_mcg(struct rxe_dev *rxe,
>  struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
>  {
>         struct rxe_mcg *mcg;
> -       unsigned long flags;
>
> -       spin_lock_irqsave(&rxe->mcg_lock, flags);
> +       spin_lock_bh(&rxe->mcg_lock);
>         mcg = __rxe_lookup_mcg(rxe, mgid);
> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> +       spin_unlock_bh(&rxe->mcg_lock);
>
>         return mcg;
>  }
> @@ -198,7 +197,6 @@ static int __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
>  static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
>  {
>         struct rxe_mcg *mcg, *tmp;
> -       unsigned long flags;
>         int err;
>
>         if (rxe->attr.max_mcast_grp == 0)
> @@ -214,7 +212,7 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
>         if (!mcg)
>                 return ERR_PTR(-ENOMEM);
>
> -       spin_lock_irqsave(&rxe->mcg_lock, flags);
> +       spin_lock_bh(&rxe->mcg_lock);
>         /* re-check to see if someone else just added it */
>         tmp = __rxe_lookup_mcg(rxe, mgid);
>         if (tmp) {
> @@ -232,12 +230,12 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
>         if (err)
>                 goto err_dec;
>  out:
> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> +       spin_unlock_bh(&rxe->mcg_lock);
>         return mcg;
>
>  err_dec:
>         atomic_dec(&rxe->mcg_num);
> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> +       spin_unlock_bh(&rxe->mcg_lock);
>         kfree(mcg);
>         return ERR_PTR(err);
>  }
> @@ -280,11 +278,9 @@ static void __rxe_destroy_mcg(struct rxe_mcg *mcg)
>   */
>  static void rxe_destroy_mcg(struct rxe_mcg *mcg)
>  {
> -       unsigned long flags;
> -
> -       spin_lock_irqsave(&mcg->rxe->mcg_lock, flags);
> +       spin_lock_bh(&mcg->rxe->mcg_lock);
>         __rxe_destroy_mcg(mcg);
> -       spin_unlock_irqrestore(&mcg->rxe->mcg_lock, flags);
> +       spin_unlock_bh(&mcg->rxe->mcg_lock);
>  }
>
>  /**
> @@ -339,25 +335,24 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
>  {
>         struct rxe_dev *rxe = mcg->rxe;
>         struct rxe_mca *mca, *tmp;
> -       unsigned long flags;
>         int err;
>
>         /* check to see if the qp is already a member of the group */
> -       spin_lock_irqsave(&rxe->mcg_lock, flags);
> +       spin_lock_bh(&rxe->mcg_lock);
>         list_for_each_entry(mca, &mcg->qp_list, qp_list) {
>                 if (mca->qp == qp) {
> -                       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> +                       spin_unlock_bh(&rxe->mcg_lock);
>                         return 0;
>                 }
>         }
> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> +       spin_unlock_bh(&rxe->mcg_lock);
>
>         /* speculative alloc new mca without using GFP_ATOMIC */
>         mca = kzalloc(sizeof(*mca), GFP_KERNEL);
>         if (!mca)
>                 return -ENOMEM;
>
> -       spin_lock_irqsave(&rxe->mcg_lock, flags);
> +       spin_lock_bh(&rxe->mcg_lock);
>         /* re-check to see if someone else just attached qp */
>         list_for_each_entry(tmp, &mcg->qp_list, qp_list) {
>                 if (tmp->qp == qp) {
> @@ -371,7 +366,7 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
>         if (err)
>                 kfree(mca);
>  out:
> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> +       spin_unlock_bh(&rxe->mcg_lock);
>         return err;
>  }
>
> @@ -405,9 +400,8 @@ static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
>  {
>         struct rxe_dev *rxe = mcg->rxe;
>         struct rxe_mca *mca, *tmp;
> -       unsigned long flags;
>
> -       spin_lock_irqsave(&rxe->mcg_lock, flags);
> +       spin_lock_bh(&rxe->mcg_lock);
>         list_for_each_entry_safe(mca, tmp, &mcg->qp_list, qp_list) {
>                 if (mca->qp == qp) {
>                         __rxe_cleanup_mca(mca, mcg);
> @@ -421,13 +415,13 @@ static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
>                         if (atomic_read(&mcg->qp_num) <= 0)
>                                 __rxe_destroy_mcg(mcg);
>
> -                       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> +                       spin_unlock_bh(&rxe->mcg_lock);
>                         return 0;
>                 }
>         }
>
>         /* we didn't find the qp on the list */
> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> +       spin_unlock_bh(&rxe->mcg_lock);
>         return -EINVAL;
>  }
>
> --
> 2.32.0
>
