Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122054FEFD9
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Apr 2022 08:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiDMGdb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Apr 2022 02:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiDMGda (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Apr 2022 02:33:30 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F913A8
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 23:31:09 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u19so947201ljd.11
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 23:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z2iiRnEEVzx2waEwbum9AefeBTvUl3A/hT2qNN//ijc=;
        b=miyFm29IPlnQQ2mICWMglOYyu6smzEtiYVe91KvyyIdgpuotIaehjqF5OgyUciqBnA
         Rt837K2QYKuyDFizRhMLSLiS9R5aI25gEvVcjF8WzFEW8xyGQz/yLxwL2e5qSXk7TroL
         ZN+tSBxX8/3dboAd11FIgLKM4l6jYhvpuP3lZbQDEIX5Rck+LkTxj0c8p1shiOQof8Fj
         3wZmL3fNGeaRt9io9HCZb5OYgqyOetL3wJWLqR1BWqe/dLDC5J1ej/nAPtpWk9PyyyiF
         9efHg8mzgaPqnQ6KBtGGEtEYbVBl5bP3HHTrBbcx+NBvPWudalo+2MI/vlnHN34mFlTV
         AMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z2iiRnEEVzx2waEwbum9AefeBTvUl3A/hT2qNN//ijc=;
        b=xhdYwn5FIUFRwH9MXuFuBi7InxZDinbhjd/knyL+h+NXndeTHVJod3iLa88xZvy5aH
         ZUVw1oMxQFotledJ16vjz2++HfIi/xkLxD5Cv/QZPhCZs39LE64pCuj+KsHKmXMo+58d
         BTLfpUKMmg79ce2ybht68IlimEe8MV6jPy7tnug13fPivsEfIWpU3ImDzgcChTDRqCGN
         /vaYcte7EeP7GOJ5ufNY2T5iJz9F7DQ5+v19Hg+MeGh9iNM5Wy11Q3CQXVSC9oYGEvFK
         9b82L522KcwSyHfb0VFh8ulrMd6Nt4TtITlQMAWmv0fFMdHjx/8S+zmF7OTZknXl3Iit
         3xzw==
X-Gm-Message-State: AOAM531sXCtxD1GnClQmMCD90JhhMtJ7NOr5W07CtpAJk+wMy5T+Wmxs
        OASKhQOnlbCmIG+Z4Qud0pJBRBtX0Md1ueQvBOw5qFPN
X-Google-Smtp-Source: ABdhPJysebheINkXYZNz1qH82N2H5dCePOs7fzd5wVf6/WyI5iY88delCALP3Csvq3NWxXp77h0U4184eGmmSZN4VlE=
X-Received: by 2002:a2e:6814:0:b0:24a:f422:e953 with SMTP id
 c20-20020a2e6814000000b0024af422e953mr25432445lja.527.1649831467232; Tue, 12
 Apr 2022 23:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220413052937.92713-1-rpearsonhpe@gmail.com> <CAD=hENfro+0=Euk=Ja6uUxVXcOhCdT9vbeubm4=VehHa5tgF5A@mail.gmail.com>
 <c465659d-66df-12da-05ea-45ac04b3d4e3@gmail.com> <CAD=hENdeGGHmdGoziDz6z5mGMY=0S-v19i+wrbwzE1f8eEvhcA@mail.gmail.com>
 <2c558990-c39d-6a52-eede-9e0a920f4a6e@gmail.com>
In-Reply-To: <2c558990-c39d-6a52-eede-9e0a920f4a6e@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 13 Apr 2022 14:30:55 +0800
Message-ID: <CAD=hENd8EvQoqEx-BJDKSDimccQwDhX=pUa95xg8QW4W8JnUew@mail.gmail.com>
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

On Wed, Apr 13, 2022 at 2:18 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> On 4/13/22 01:11, Zhu Yanjun wrote:
> > On Wed, Apr 13, 2022 at 2:03 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> >>
> >> On 4/13/22 00:58, Zhu Yanjun wrote:
> >>> On Wed, Apr 13, 2022 at 1:31 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> >>>>
> >>>> rxe_mcast.c currently uses _irqsave spinlocks for rxe->mcg_lock
> >>>> while rxe_recv.c uses _bh spinlocks for the same lock. Adding
> >>>> tracing shows that the code in rxe_mcast.c is all executed in_task()
> >>>> context while the code in rxe_recv.c that refers to the lock
> >>>> executes in softirq context. This causes a lockdep warning in code
> >>>> that executes multicast I/O including blktests check srp.
> >>>>
> >>>> Change the locking of rxe->mcg_lock in rxe_mcast.c to use
> >>>> spin_(un)lock_bh().
> >>>
> >>> Now RXE is not stable. We should focus on the problem of RXE.
> >>>
> >>> Zhu Yanjun
> >>
> >> This a real bug and triggers lockdep warnings when I run blktests srp.
> >> The blktests test suite apparently uses multicast. It is obviously wrong
> >> you can't use both _bh and _irqsave locks and pass lockdep checking.
> >>
> >> What tests are not running correctly for you?
> >
> > The crash related with mr is resolved?
>
> I am pursuing getting everything to pass with the rcu_read_lock() patch.
> Currently I have blktests, perftests and pyverbs tests all passing.
> I have rping running but it hangs. I have WARN_ON's for mr = 0 but I
> am not seeing them show up so there absolutely no trace output from rping.
> It just hangs after a few minutes with no dmesg. I have lockdep turned on and
> as just mentioned WARN_ON's for mr = 0. My suspicion is that this is
> related to a race during shutdown but I haven't traced it to the root cause

Please focus on this mr crash. I have made tests with reverting the
related commit with
the xarray. This mr crash disappeared.

It seems that this rping mr crash is related with xarray.

I am still working on it.

Zhu Yanjun

> yet. I don't trust the responder resources code at all.
>
> I am done for today here though.
>
> Bob
> >
> > Zhu Yanjun
> >
> >>
> >> Bob
> >>>
> >>>>
> >>>> With this change the following locks in rdma_rxe which are all _bh
> >>>> show no lockdep warnings.
> >>>>
> >>>>         atomic_ops_lock
> >>>>         mw->lock
> >>>>         port->port_lock
> >>>>         qp->state_lock
> >>>>         rxe->mcg_lock
> >>>>         rxe->mmap_offset_lock
> >>>>         rxe->pending_lock
> >>>>         task->state_lock
> >>>>
> >>>> The only other remaining lock is pool->xa.xa_lock which
> >>>> must either be some combination of _bh and _irq types depending
> >>>> on the object type (== ah or not) or plain spin_lock if
> >>>> the read side operations are converted to use rcu_read_lock().
> >>>>
> >>>> Fixes: 6090a0c4c7c6 ("RDMA/rxe: Cleanup rxe_mcast.c")
> >>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> >>>> ---
> >>>>  drivers/infiniband/sw/rxe/rxe_mcast.c | 36 +++++++++++----------------
> >>>>  1 file changed, 15 insertions(+), 21 deletions(-)
> >>>>
> >>>> diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
> >>>> index ae8f11cb704a..7f50566b8d89 100644
> >>>> --- a/drivers/infiniband/sw/rxe/rxe_mcast.c
> >>>> +++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
> >>>> @@ -143,11 +143,10 @@ static struct rxe_mcg *__rxe_lookup_mcg(struct rxe_dev *rxe,
> >>>>  struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
> >>>>  {
> >>>>         struct rxe_mcg *mcg;
> >>>> -       unsigned long flags;
> >>>>
> >>>> -       spin_lock_irqsave(&rxe->mcg_lock, flags);
> >>>> +       spin_lock_bh(&rxe->mcg_lock);
> >>>>         mcg = __rxe_lookup_mcg(rxe, mgid);
> >>>> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> >>>> +       spin_unlock_bh(&rxe->mcg_lock);
> >>>>
> >>>>         return mcg;
> >>>>  }
> >>>> @@ -198,7 +197,6 @@ static int __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
> >>>>  static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
> >>>>  {
> >>>>         struct rxe_mcg *mcg, *tmp;
> >>>> -       unsigned long flags;
> >>>>         int err;
> >>>>
> >>>>         if (rxe->attr.max_mcast_grp == 0)
> >>>> @@ -214,7 +212,7 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
> >>>>         if (!mcg)
> >>>>                 return ERR_PTR(-ENOMEM);
> >>>>
> >>>> -       spin_lock_irqsave(&rxe->mcg_lock, flags);
> >>>> +       spin_lock_bh(&rxe->mcg_lock);
> >>>>         /* re-check to see if someone else just added it */
> >>>>         tmp = __rxe_lookup_mcg(rxe, mgid);
> >>>>         if (tmp) {
> >>>> @@ -232,12 +230,12 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
> >>>>         if (err)
> >>>>                 goto err_dec;
> >>>>  out:
> >>>> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> >>>> +       spin_unlock_bh(&rxe->mcg_lock);
> >>>>         return mcg;
> >>>>
> >>>>  err_dec:
> >>>>         atomic_dec(&rxe->mcg_num);
> >>>> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> >>>> +       spin_unlock_bh(&rxe->mcg_lock);
> >>>>         kfree(mcg);
> >>>>         return ERR_PTR(err);
> >>>>  }
> >>>> @@ -280,11 +278,9 @@ static void __rxe_destroy_mcg(struct rxe_mcg *mcg)
> >>>>   */
> >>>>  static void rxe_destroy_mcg(struct rxe_mcg *mcg)
> >>>>  {
> >>>> -       unsigned long flags;
> >>>> -
> >>>> -       spin_lock_irqsave(&mcg->rxe->mcg_lock, flags);
> >>>> +       spin_lock_bh(&mcg->rxe->mcg_lock);
> >>>>         __rxe_destroy_mcg(mcg);
> >>>> -       spin_unlock_irqrestore(&mcg->rxe->mcg_lock, flags);
> >>>> +       spin_unlock_bh(&mcg->rxe->mcg_lock);
> >>>>  }
> >>>>
> >>>>  /**
> >>>> @@ -339,25 +335,24 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
> >>>>  {
> >>>>         struct rxe_dev *rxe = mcg->rxe;
> >>>>         struct rxe_mca *mca, *tmp;
> >>>> -       unsigned long flags;
> >>>>         int err;
> >>>>
> >>>>         /* check to see if the qp is already a member of the group */
> >>>> -       spin_lock_irqsave(&rxe->mcg_lock, flags);
> >>>> +       spin_lock_bh(&rxe->mcg_lock);
> >>>>         list_for_each_entry(mca, &mcg->qp_list, qp_list) {
> >>>>                 if (mca->qp == qp) {
> >>>> -                       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> >>>> +                       spin_unlock_bh(&rxe->mcg_lock);
> >>>>                         return 0;
> >>>>                 }
> >>>>         }
> >>>> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> >>>> +       spin_unlock_bh(&rxe->mcg_lock);
> >>>>
> >>>>         /* speculative alloc new mca without using GFP_ATOMIC */
> >>>>         mca = kzalloc(sizeof(*mca), GFP_KERNEL);
> >>>>         if (!mca)
> >>>>                 return -ENOMEM;
> >>>>
> >>>> -       spin_lock_irqsave(&rxe->mcg_lock, flags);
> >>>> +       spin_lock_bh(&rxe->mcg_lock);
> >>>>         /* re-check to see if someone else just attached qp */
> >>>>         list_for_each_entry(tmp, &mcg->qp_list, qp_list) {
> >>>>                 if (tmp->qp == qp) {
> >>>> @@ -371,7 +366,7 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
> >>>>         if (err)
> >>>>                 kfree(mca);
> >>>>  out:
> >>>> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> >>>> +       spin_unlock_bh(&rxe->mcg_lock);
> >>>>         return err;
> >>>>  }
> >>>>
> >>>> @@ -405,9 +400,8 @@ static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
> >>>>  {
> >>>>         struct rxe_dev *rxe = mcg->rxe;
> >>>>         struct rxe_mca *mca, *tmp;
> >>>> -       unsigned long flags;
> >>>>
> >>>> -       spin_lock_irqsave(&rxe->mcg_lock, flags);
> >>>> +       spin_lock_bh(&rxe->mcg_lock);
> >>>>         list_for_each_entry_safe(mca, tmp, &mcg->qp_list, qp_list) {
> >>>>                 if (mca->qp == qp) {
> >>>>                         __rxe_cleanup_mca(mca, mcg);
> >>>> @@ -421,13 +415,13 @@ static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
> >>>>                         if (atomic_read(&mcg->qp_num) <= 0)
> >>>>                                 __rxe_destroy_mcg(mcg);
> >>>>
> >>>> -                       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> >>>> +                       spin_unlock_bh(&rxe->mcg_lock);
> >>>>                         return 0;
> >>>>                 }
> >>>>         }
> >>>>
> >>>>         /* we didn't find the qp on the list */
> >>>> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> >>>> +       spin_unlock_bh(&rxe->mcg_lock);
> >>>>         return -EINVAL;
> >>>>  }
> >>>>
> >>>> --
> >>>> 2.32.0
> >>>>
> >>
>
