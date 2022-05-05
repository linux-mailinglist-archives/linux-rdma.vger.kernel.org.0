Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB93451B55A
	for <lists+linux-rdma@lfdr.de>; Thu,  5 May 2022 03:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbiEEBso (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 May 2022 21:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbiEEBso (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 May 2022 21:48:44 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981DF4CD4C
        for <linux-rdma@vger.kernel.org>; Wed,  4 May 2022 18:45:05 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id v4so3825376ljd.10
        for <linux-rdma@vger.kernel.org>; Wed, 04 May 2022 18:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tLTUtpoJGpE1GWKS+RgYFGbf/CpkISmx9KMxr4SLu8E=;
        b=FMS+wTsur3ox/+T0QU1zDa2pjF+9YxDR7q1mICi6vWyDgnT6S1odSDI75grJPmleRU
         3A2CIATdlM0CfxIIokBBoIuPckLB8+prwPvEPGP6vH/IVUorBI5y94kLeCqo+ik3f007
         7QToMy/ukLTgXVnMHqMWrAus+Jvq9pGZb+Ixcn5c2e2FUKZVWfqj9yporZq+BdQLWoCe
         Z4rF5zj/QxnUOg5b9ad2vv5RFKChc3dMZayCULs6I1KjjHiV9s6tuxGM3xOH1CPKsn7H
         nZHBt0VjVmp0+ZzH4XDNvZoGOB39nydP3FBL0h0E0N9yFoFi/h4B8KnCXr6r9+vX/wyx
         oTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tLTUtpoJGpE1GWKS+RgYFGbf/CpkISmx9KMxr4SLu8E=;
        b=V40uG2qfWcy7n4dqg6AbA1zp3g9Ap2Mr+wNsHnuCXLI9DebToR93yySLO85bG/1yb+
         SmgXlGToW4SFcUhGItgJjPsgJNS7cJi4xTIXBSfhmUgXCk8eXnUFPmzU2aik0EsiXsjK
         U+/9aPAJELXcwym5ItC4yQCU1XdH6pienEP0XZRxKDwH5/ryHQ1PbpHIZlbaU7d4NgeH
         DSKK8/iVwfxkU8Qiyrju221vrtaNl6fyShQTSfyXXMQIxOUVDw4ADNZaZwrQwLehaacM
         EHSocBWrz3Kg5Cn/yUffoVB735WSjPZCWNbSARpFvMD0i4FiRBN/vqiGsskHaEf/9f93
         w8qg==
X-Gm-Message-State: AOAM530Q6Bp5ClI0yt0m8zFNTUuj8aBWiICZYEZpFHO2r/JiFGAxe60n
        KfmqRQntYnfg+qq7t7dafzFglWAOU8kS+36ARmUWHZ1A
X-Google-Smtp-Source: ABdhPJyoeiAVyZq53ZI33ZtznVBBUeMnmzQzG5g3vykwd0irxeje5bk6OmIiQAEkpXE58KAzTS6I98YMw7aTmhPnMqQ=
X-Received: by 2002:a05:651c:1542:b0:249:a87f:8a34 with SMTP id
 y2-20020a05651c154200b00249a87f8a34mr14790773ljp.442.1651715103753; Wed, 04
 May 2022 18:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220504202817.98247-1-rpearsonhpe@gmail.com>
In-Reply-To: <20220504202817.98247-1-rpearsonhpe@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 5 May 2022 09:44:52 +0800
Message-ID: <CAD=hENfh_iZ+8pyrwvJnZgQmAm90sRVAOHkG=R8Xd3jkRnuLJQ@mail.gmail.com>
Subject: Re: [PATCH for-next v2] RDMA/rxe: Fix "RDMA/rxe: Cleanup rxe_mcast.c"
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

On Thu, May 5, 2022 at 4:28 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> rxe_mcast.c currently uses _irqsave spinlocks for rxe->mcg_lock
> while rxe_recv.c uses _bh spinlocks for the same lock.
>
> Additionally the current code issues a warning that _irqrestore
> is restoring hardware interrupts while some interrupts are
> enabled. This is traced to calls to the calls to dev_mc_add/del().

Hi, Bob

As Jason commented, can you show us the warning? And how to reproduce
this problem?
Thanks,

Zhu Yanjun
>
> Change the locking of rxe->mcg_lock in rxe_mcast.c to use
> spin_(un)lock_bh() which matches that in rxe_recv.c. Also move
> the calls to dev_mc_add and dev_mc_del outside of spinlocks.
>
> Fixes: 6090a0c4c7c6 ("RDMA/rxe: Cleanup rxe_mcast.c")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
> v2
>   Addressed comments from Jason re not placing calls to dev_mc_add/del
>   inside of spinlocks.
>
>  drivers/infiniband/sw/rxe/rxe_mcast.c | 81 ++++++++++++---------------
>  1 file changed, 35 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
> index ae8f11cb704a..873a9b10307c 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mcast.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
> @@ -38,13 +38,13 @@ static int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
>  }
>
>  /**
> - * rxe_mcast_delete - delete multicast address from rxe device
> + * rxe_mcast_del - delete multicast address from rxe device
>   * @rxe: rxe device object
>   * @mgid: multicast address as a gid
>   *
>   * Returns 0 on success else an error
>   */
> -static int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)
> +static int rxe_mcast_del(struct rxe_dev *rxe, union ib_gid *mgid)
>  {
>         unsigned char ll_addr[ETH_ALEN];
>
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
> @@ -159,17 +158,10 @@ struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
>   * @mcg: new mcg object
>   *
>   * Context: caller should hold rxe->mcg lock
> - * Returns: 0 on success else an error
>   */
> -static int __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
> -                         struct rxe_mcg *mcg)
> +static void __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
> +                          struct rxe_mcg *mcg)
>  {
> -       int err;
> -
> -       err = rxe_mcast_add(rxe, mgid);
> -       if (unlikely(err))
> -               return err;
> -
>         kref_init(&mcg->ref_cnt);
>         memcpy(&mcg->mgid, mgid, sizeof(mcg->mgid));
>         INIT_LIST_HEAD(&mcg->qp_list);
> @@ -184,8 +176,6 @@ static int __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
>          */
>         kref_get(&mcg->ref_cnt);
>         __rxe_insert_mcg(mcg);
> -
> -       return 0;
>  }
>
>  /**
> @@ -198,7 +188,6 @@ static int __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
>  static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
>  {
>         struct rxe_mcg *mcg, *tmp;
> -       unsigned long flags;
>         int err;
>
>         if (rxe->attr.max_mcast_grp == 0)
> @@ -209,36 +198,38 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
>         if (mcg)
>                 return mcg;
>
> +       /* check to see if we have reached limit */
> +       if (atomic_inc_return(&rxe->mcg_num) > rxe->attr.max_mcast_grp) {
> +               err = -ENOMEM;
> +               goto err_dec;
> +       }
> +
>         /* speculative alloc of new mcg */
>         mcg = kzalloc(sizeof(*mcg), GFP_KERNEL);
>         if (!mcg)
>                 return ERR_PTR(-ENOMEM);
>
> -       spin_lock_irqsave(&rxe->mcg_lock, flags);
> +       spin_lock_bh(&rxe->mcg_lock);
>         /* re-check to see if someone else just added it */
>         tmp = __rxe_lookup_mcg(rxe, mgid);
>         if (tmp) {
> +               spin_unlock_bh(&rxe->mcg_lock);
> +               atomic_dec(&rxe->mcg_num);
>                 kfree(mcg);
> -               mcg = tmp;
> -               goto out;
> +               return tmp;
>         }
>
> -       if (atomic_inc_return(&rxe->mcg_num) > rxe->attr.max_mcast_grp) {
> -               err = -ENOMEM;
> -               goto err_dec;
> -       }
> +       __rxe_init_mcg(rxe, mgid, mcg);
> +       spin_unlock_bh(&rxe->mcg_lock);
>
> -       err = __rxe_init_mcg(rxe, mgid, mcg);
> -       if (err)
> -               goto err_dec;
> -out:
> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> -       return mcg;
> +       /* add mcast address outside of lock */
> +       err = rxe_mcast_add(rxe, mgid);
> +       if (!err)
> +               return mcg;
>
> +       kfree(mcg);
>  err_dec:
>         atomic_dec(&rxe->mcg_num);
> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> -       kfree(mcg);
>         return ERR_PTR(err);
>  }
>
> @@ -268,7 +259,6 @@ static void __rxe_destroy_mcg(struct rxe_mcg *mcg)
>         __rxe_remove_mcg(mcg);
>         kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
>
> -       rxe_mcast_delete(mcg->rxe, &mcg->mgid);
>         atomic_dec(&rxe->mcg_num);
>  }
>
> @@ -280,11 +270,12 @@ static void __rxe_destroy_mcg(struct rxe_mcg *mcg)
>   */
>  static void rxe_destroy_mcg(struct rxe_mcg *mcg)
>  {
> -       unsigned long flags;
> +       /* delete mcast address outside of lock */
> +       rxe_mcast_del(mcg->rxe, &mcg->mgid);
>
> -       spin_lock_irqsave(&mcg->rxe->mcg_lock, flags);
> +       spin_lock_bh(&mcg->rxe->mcg_lock);
>         __rxe_destroy_mcg(mcg);
> -       spin_unlock_irqrestore(&mcg->rxe->mcg_lock, flags);
> +       spin_unlock_bh(&mcg->rxe->mcg_lock);
>  }
>
>  /**
> @@ -339,25 +330,24 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
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
> @@ -371,7 +361,7 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
>         if (err)
>                 kfree(mca);
>  out:
> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> +       spin_unlock_bh(&rxe->mcg_lock);
>         return err;
>  }
>
> @@ -405,9 +395,8 @@ static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
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
> @@ -421,13 +410,13 @@ static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
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
> 2.34.1
>
