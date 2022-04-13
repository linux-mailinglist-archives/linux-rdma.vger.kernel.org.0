Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2C24FEF8B
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Apr 2022 08:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiDMGN6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Apr 2022 02:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiDMGN5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Apr 2022 02:13:57 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8863A193
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 23:11:36 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x33so1707667lfu.1
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 23:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zT8XL/OQW8AwkLXJtXQCqu+RwTXBdZrQ3UcNtXHZuE8=;
        b=Q73VEFm0JmYVRpc/FY0r0m8LwdVb9aP9bsS5ODHpQq1cgvh7+3x7e4Z15CCgcMOnz1
         CNMMCaj+ha96/fsmN42B9cJ+fFqxgvlOw50mLZvuxyoNJKLkt6dNGa+5pqPVxpxyVLTZ
         eUYkFBGT3uwwdIwpOwNC2wmlRVxcx/6xANkvOMxq/4EmgHn2bdoZMNR+yxOvvX+lj7Af
         AArWVGiAz5Z6lpCp0uPDal4I9oecQzrqfj4sQaa140TIhNm/3J5wSOCt49RrVo7w/orY
         y2WHiGz2FBOEmtqyTlTUgBrbejQY+HaWgeYbXXome3Ji4lf+PiKu0X4GjRzU800psfgQ
         BVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zT8XL/OQW8AwkLXJtXQCqu+RwTXBdZrQ3UcNtXHZuE8=;
        b=Rm7ZONoP69xIvFp6wHKULCoxL+cLtMSSkVPD/q19ahKRkOc96etNdTgVJTarPq9y6A
         H/ShQcDHTqLJb+YT3G6vrnajqlsxPKtlTQCDOvobp2TjN+K9s3DvvLvWl8caHUVoqtU+
         IFg1mmrjQhwhilmMs4RRzxzwkzcclZwBY8WVLm+DBShOuhknbiWOipEGFWuaj6bzzn+z
         yPTlukvXlH58RJLnOEDX26RnaerVzCbCMHYwVHefGeew05YOZsqdhynCb9hrTpos0E3V
         ya5DMD1y8dQurfZrhBcWCcF3IruLspx/ZdOJxoZMGfy+ezQ1nfU4Wh1JPlbkRWrqJ7w6
         7hsQ==
X-Gm-Message-State: AOAM531iERej06pxqcbv7gEXfGoepm8RhjarOwmGW5jEUh3MsM/moZ+j
        lnUmAwBLRROZOgefZwJjwbku0kZWp0E+g834VCoyB2vP
X-Google-Smtp-Source: ABdhPJy8tQ/lKYAlfRg+xS5cBjYxj7g8vBzIQ9C9286pqQVRqFJy5SGjjP4MxvqICohyfjSIJz13EQ02GaL3SUjLi1A=
X-Received: by 2002:a05:6512:3f8b:b0:46b:8913:9546 with SMTP id
 x11-20020a0565123f8b00b0046b89139546mr16235690lfa.571.1649830295201; Tue, 12
 Apr 2022 23:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220413052937.92713-1-rpearsonhpe@gmail.com> <CAD=hENfro+0=Euk=Ja6uUxVXcOhCdT9vbeubm4=VehHa5tgF5A@mail.gmail.com>
 <c465659d-66df-12da-05ea-45ac04b3d4e3@gmail.com>
In-Reply-To: <c465659d-66df-12da-05ea-45ac04b3d4e3@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 13 Apr 2022 14:11:23 +0800
Message-ID: <CAD=hENdeGGHmdGoziDz6z5mGMY=0S-v19i+wrbwzE1f8eEvhcA@mail.gmail.com>
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

On Wed, Apr 13, 2022 at 2:03 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> On 4/13/22 00:58, Zhu Yanjun wrote:
> > On Wed, Apr 13, 2022 at 1:31 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> >>
> >> rxe_mcast.c currently uses _irqsave spinlocks for rxe->mcg_lock
> >> while rxe_recv.c uses _bh spinlocks for the same lock. Adding
> >> tracing shows that the code in rxe_mcast.c is all executed in_task()
> >> context while the code in rxe_recv.c that refers to the lock
> >> executes in softirq context. This causes a lockdep warning in code
> >> that executes multicast I/O including blktests check srp.
> >>
> >> Change the locking of rxe->mcg_lock in rxe_mcast.c to use
> >> spin_(un)lock_bh().
> >
> > Now RXE is not stable. We should focus on the problem of RXE.
> >
> > Zhu Yanjun
>
> This a real bug and triggers lockdep warnings when I run blktests srp.
> The blktests test suite apparently uses multicast. It is obviously wrong
> you can't use both _bh and _irqsave locks and pass lockdep checking.
>
> What tests are not running correctly for you?

The crash related with mr is resolved?

Zhu Yanjun

>
> Bob
> >
> >>
> >> With this change the following locks in rdma_rxe which are all _bh
> >> show no lockdep warnings.
> >>
> >>         atomic_ops_lock
> >>         mw->lock
> >>         port->port_lock
> >>         qp->state_lock
> >>         rxe->mcg_lock
> >>         rxe->mmap_offset_lock
> >>         rxe->pending_lock
> >>         task->state_lock
> >>
> >> The only other remaining lock is pool->xa.xa_lock which
> >> must either be some combination of _bh and _irq types depending
> >> on the object type (== ah or not) or plain spin_lock if
> >> the read side operations are converted to use rcu_read_lock().
> >>
> >> Fixes: 6090a0c4c7c6 ("RDMA/rxe: Cleanup rxe_mcast.c")
> >> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> >> ---
> >>  drivers/infiniband/sw/rxe/rxe_mcast.c | 36 +++++++++++----------------
> >>  1 file changed, 15 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
> >> index ae8f11cb704a..7f50566b8d89 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_mcast.c
> >> +++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
> >> @@ -143,11 +143,10 @@ static struct rxe_mcg *__rxe_lookup_mcg(struct rxe_dev *rxe,
> >>  struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
> >>  {
> >>         struct rxe_mcg *mcg;
> >> -       unsigned long flags;
> >>
> >> -       spin_lock_irqsave(&rxe->mcg_lock, flags);
> >> +       spin_lock_bh(&rxe->mcg_lock);
> >>         mcg = __rxe_lookup_mcg(rxe, mgid);
> >> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> >> +       spin_unlock_bh(&rxe->mcg_lock);
> >>
> >>         return mcg;
> >>  }
> >> @@ -198,7 +197,6 @@ static int __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
> >>  static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
> >>  {
> >>         struct rxe_mcg *mcg, *tmp;
> >> -       unsigned long flags;
> >>         int err;
> >>
> >>         if (rxe->attr.max_mcast_grp == 0)
> >> @@ -214,7 +212,7 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
> >>         if (!mcg)
> >>                 return ERR_PTR(-ENOMEM);
> >>
> >> -       spin_lock_irqsave(&rxe->mcg_lock, flags);
> >> +       spin_lock_bh(&rxe->mcg_lock);
> >>         /* re-check to see if someone else just added it */
> >>         tmp = __rxe_lookup_mcg(rxe, mgid);
> >>         if (tmp) {
> >> @@ -232,12 +230,12 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
> >>         if (err)
> >>                 goto err_dec;
> >>  out:
> >> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> >> +       spin_unlock_bh(&rxe->mcg_lock);
> >>         return mcg;
> >>
> >>  err_dec:
> >>         atomic_dec(&rxe->mcg_num);
> >> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> >> +       spin_unlock_bh(&rxe->mcg_lock);
> >>         kfree(mcg);
> >>         return ERR_PTR(err);
> >>  }
> >> @@ -280,11 +278,9 @@ static void __rxe_destroy_mcg(struct rxe_mcg *mcg)
> >>   */
> >>  static void rxe_destroy_mcg(struct rxe_mcg *mcg)
> >>  {
> >> -       unsigned long flags;
> >> -
> >> -       spin_lock_irqsave(&mcg->rxe->mcg_lock, flags);
> >> +       spin_lock_bh(&mcg->rxe->mcg_lock);
> >>         __rxe_destroy_mcg(mcg);
> >> -       spin_unlock_irqrestore(&mcg->rxe->mcg_lock, flags);
> >> +       spin_unlock_bh(&mcg->rxe->mcg_lock);
> >>  }
> >>
> >>  /**
> >> @@ -339,25 +335,24 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
> >>  {
> >>         struct rxe_dev *rxe = mcg->rxe;
> >>         struct rxe_mca *mca, *tmp;
> >> -       unsigned long flags;
> >>         int err;
> >>
> >>         /* check to see if the qp is already a member of the group */
> >> -       spin_lock_irqsave(&rxe->mcg_lock, flags);
> >> +       spin_lock_bh(&rxe->mcg_lock);
> >>         list_for_each_entry(mca, &mcg->qp_list, qp_list) {
> >>                 if (mca->qp == qp) {
> >> -                       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> >> +                       spin_unlock_bh(&rxe->mcg_lock);
> >>                         return 0;
> >>                 }
> >>         }
> >> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> >> +       spin_unlock_bh(&rxe->mcg_lock);
> >>
> >>         /* speculative alloc new mca without using GFP_ATOMIC */
> >>         mca = kzalloc(sizeof(*mca), GFP_KERNEL);
> >>         if (!mca)
> >>                 return -ENOMEM;
> >>
> >> -       spin_lock_irqsave(&rxe->mcg_lock, flags);
> >> +       spin_lock_bh(&rxe->mcg_lock);
> >>         /* re-check to see if someone else just attached qp */
> >>         list_for_each_entry(tmp, &mcg->qp_list, qp_list) {
> >>                 if (tmp->qp == qp) {
> >> @@ -371,7 +366,7 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
> >>         if (err)
> >>                 kfree(mca);
> >>  out:
> >> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> >> +       spin_unlock_bh(&rxe->mcg_lock);
> >>         return err;
> >>  }
> >>
> >> @@ -405,9 +400,8 @@ static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
> >>  {
> >>         struct rxe_dev *rxe = mcg->rxe;
> >>         struct rxe_mca *mca, *tmp;
> >> -       unsigned long flags;
> >>
> >> -       spin_lock_irqsave(&rxe->mcg_lock, flags);
> >> +       spin_lock_bh(&rxe->mcg_lock);
> >>         list_for_each_entry_safe(mca, tmp, &mcg->qp_list, qp_list) {
> >>                 if (mca->qp == qp) {
> >>                         __rxe_cleanup_mca(mca, mcg);
> >> @@ -421,13 +415,13 @@ static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
> >>                         if (atomic_read(&mcg->qp_num) <= 0)
> >>                                 __rxe_destroy_mcg(mcg);
> >>
> >> -                       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> >> +                       spin_unlock_bh(&rxe->mcg_lock);
> >>                         return 0;
> >>                 }
> >>         }
> >>
> >>         /* we didn't find the qp on the list */
> >> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> >> +       spin_unlock_bh(&rxe->mcg_lock);
> >>         return -EINVAL;
> >>  }
> >>
> >> --
> >> 2.32.0
> >>
>
