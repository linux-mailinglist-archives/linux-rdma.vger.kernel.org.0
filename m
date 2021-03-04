Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395C832CF70
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Mar 2021 10:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbhCDJPm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Mar 2021 04:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbhCDJPk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Mar 2021 04:15:40 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ACAC061756
        for <linux-rdma@vger.kernel.org>; Thu,  4 Mar 2021 01:14:59 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id z126so29350384oiz.6
        for <linux-rdma@vger.kernel.org>; Thu, 04 Mar 2021 01:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NK6Ip1LmNIJiih9ABz9f3X254FPd4OUZkZANsDP106A=;
        b=m6jXQ7ia61lqOSJm7/Kk/gklweXOJy7i12INJkHMZWMedyVFwQfYc3foeb2MuaOvku
         Nere9MCOS9BkIv59jbJSEOZEMi/yHwcb8X4rPAtQFlWB30l/RjghvZzmmB8DrLLvP4lW
         NLkdy65BqMzlZgbNqapRScsJqd4eGtoviHqeJiIMEGdv3wfxlwMAomV4lJn21ZQZGunC
         KYSBQDlYnKnBhUWmiNvLvMgXahnA5Cnysl82Ij9kbR5Vd12fq2LMf1TTU7K1icp1Zvs3
         /wgoOMdx4PvIBgF3ovr4zgHXwUMORy5Q0bXyZ7JhDgUPF4jrGy0YB9rUKHKg7Mt+2VBo
         6Upw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NK6Ip1LmNIJiih9ABz9f3X254FPd4OUZkZANsDP106A=;
        b=I4f/JDrYFzvggb0QOAzKPJfHeJKQgEfJXxMAE0lDMjgIrGpaInyE+CbvfplRRME/up
         ne/71CjFnuYtE7NT2dO0iXzywhwh0aFoMceCncUjgYJFJNnrXhqoB7P3nVnvThM/NhEv
         Rxf1AY+z8mkkOLLtsdBrMLTYil7VL/JtBCh4Hbn+aR2n5kjcrbA7Y1WhZcgfqMJaxRx0
         IDJVh+VWkUqM89BUVr3SxTdk08w0xj44Nk77U49zVcrWkApj9rFnePgdDtSynjEm8y3B
         UpKdfTfyF64P5Ptj2rHBJLhhrywf6DztMYIYczlpZhcwPQHXqwj55DBi5noGyKE9KChU
         iHYg==
X-Gm-Message-State: AOAM532V5N2cSb+nqqjceCwZTFJdR43vlSBjYj5nyBwJPeI0vqdWZTKt
        7GjRK1W6eCUH3qHHIU8XClqZCODzyefKzxuuq4k=
X-Google-Smtp-Source: ABdhPJwnWhK0AnYwAfENdAV13gmbY1CVRgh8aqYAX+Q7hxfupEd8soz0imAW+4C3F36gbqUW9rJHOy4vaVdYQxU9dFE=
X-Received: by 2002:a05:6808:5cb:: with SMTP id d11mr2268142oij.169.1614849299010;
 Thu, 04 Mar 2021 01:14:59 -0800 (PST)
MIME-Version: 1.0
References: <20210303225628.2836-1-rpearson@hpe.com>
In-Reply-To: <20210303225628.2836-1-rpearson@hpe.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 4 Mar 2021 17:14:47 +0800
Message-ID: <CAD=hENeRc6=FX3K8Vud3ipCgoX4dzMAHck0KDoTwqsN9Q=Ud8w@mail.gmail.com>
Subject: Re: [PATCH for-next v2] RDMA/rxe: Fix ib_device reference counting (again)
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 4, 2021 at 7:02 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> Three errors occurred in the fix referenced below.
>
> 1) rxe_rcv_mcast_pkt() dropped a reference to ib_device when
> no error occured causing an underflow on the reference counter.
> This code is cleaned up to be clearer and easier to read.
>
> 2) Extending the reference taken by rxe_get_dev_from_net() in
> rxe_udp_encap_recv() until each skb is freed was not matched by
> a reference in the loopback path resulting in underflows.
>
> 3) In rxe_comp.c the function free_pkt() did not clear skb which
> triggered a warning at done: and could possibly at exit: in
> rxe_completer(). The WARN_ONCE() calls are not actually needed.
>
> This patch fixes these errors.
>
> Fixes: 899aba891cab ("RDMA/rxe: Fix FIXME in rxe_udp_encap_recv()")
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
> Version 2:
> v1 of this patch incorrectly added a WARN_ON_ONCE in rxe_completer
> where it could be triggered for normal traffic. This version
> replaced that with a pr_warn located correctly.
>
> v1 of this patch placed a call to kfree_skb in an if statement
> that could trigger style warnings. This version cleans that up.
>
>  drivers/infiniband/sw/rxe/rxe_comp.c |  6 +--
>  drivers/infiniband/sw/rxe/rxe_net.c  | 10 ++++-
>  drivers/infiniband/sw/rxe/rxe_recv.c | 60 +++++++++++++++++-----------
>  3 files changed, 48 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
> index a8ac791a1bb9..96e5a73579f8 100644
> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
> @@ -672,8 +672,10 @@ int rxe_completer(void *arg)
>                          */
>
>                         /* there is nothing to retry in this case */
> -                       if (!wqe || (wqe->state == wqe_state_posted))
> +                       if (!wqe || (wqe->state == wqe_state_posted)) {
> +                               pr_warn("Retry attempted without a valid wqe\n");
>                                 goto exit;
> +                       }
>
>                         /* if we've started a retry, don't start another
>                          * retry sequence, unless this is a timeout.
> @@ -750,7 +752,6 @@ int rxe_completer(void *arg)
>         /* we come here if we are done with processing and want the task to
>          * exit from the loop calling us
>          */
> -       WARN_ON_ONCE(skb);

IMHO, the above "WARN_ON_ONCE(skb);" had better be kept.

>         rxe_drop_ref(qp);
>         return -EAGAIN;
>
> @@ -758,7 +759,6 @@ int rxe_completer(void *arg)
>         /* we come here if we have processed a packet we want the task to call
>          * us again to see if there is anything else to do
>          */
> -       WARN_ON_ONCE(skb);

The above "WARN_ON_ONCE(skb);" had better also be kept.

Zhu Yanjun

>         rxe_drop_ref(qp);
>         return 0;
>  }
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 0701bd1ffd1a..01662727dca0 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -407,14 +407,22 @@ int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb)
>         return 0;
>  }
>
> +/* fix up a send packet to match the packets
> + * received from UDP before looping them back
> + */
>  void rxe_loopback(struct sk_buff *skb)
>  {
> +       struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
> +
>         if (skb->protocol == htons(ETH_P_IP))
>                 skb_pull(skb, sizeof(struct iphdr));
>         else
>                 skb_pull(skb, sizeof(struct ipv6hdr));
>
> -       rxe_rcv(skb);
> +       if (WARN_ON(!ib_device_try_get(&pkt->rxe->ib_dev)))
> +               kfree_skb(skb);
> +       else
> +               rxe_rcv(skb);
>  }
>
>  struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
> index 45d2f711bce2..2b2465744896 100644
> --- a/drivers/infiniband/sw/rxe/rxe_recv.c
> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
> @@ -237,8 +237,6 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>         struct rxe_mc_elem *mce;
>         struct rxe_qp *qp;
>         union ib_gid dgid;
> -       struct sk_buff *per_qp_skb;
> -       struct rxe_pkt_info *per_qp_pkt;
>         int err;
>
>         if (skb->protocol == htons(ETH_P_IP))
> @@ -250,10 +248,15 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>         /* lookup mcast group corresponding to mgid, takes a ref */
>         mcg = rxe_pool_get_key(&rxe->mc_grp_pool, &dgid);
>         if (!mcg)
> -               goto err1;      /* mcast group not registered */
> +               goto drop;      /* mcast group not registered */
>
>         spin_lock_bh(&mcg->mcg_lock);
>
> +       /* this is unreliable datagram service so we let
> +        * failures to deliver a multicast packet to a
> +        * single QP happen and just move on and try
> +        * the rest of them on the list
> +        */
>         list_for_each_entry(mce, &mcg->qp_list, qp_list) {
>                 qp = mce->qp;
>
> @@ -266,39 +269,48 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>                 if (err)
>                         continue;
>
> -               /* for all but the last qp create a new clone of the
> -                * skb and pass to the qp. If an error occurs in the
> -                * checks for the last qp in the list we need to
> -                * free the skb since it hasn't been passed on to
> -                * rxe_rcv_pkt() which would free it later.
> +               /* for all but the last QP create a new clone of the
> +                * skb and pass to the QP. Pass the original skb to
> +                * the last QP in the list.
>                  */
>                 if (mce->qp_list.next != &mcg->qp_list) {
> -                       per_qp_skb = skb_clone(skb, GFP_ATOMIC);
> -                       if (WARN_ON(!ib_device_try_get(&rxe->ib_dev))) {
> -                               kfree_skb(per_qp_skb);
> +                       struct sk_buff *cskb;
> +                       struct rxe_pkt_info *cpkt;
> +
> +                       cskb = skb_clone(skb, GFP_ATOMIC);
> +                       if (unlikely(!cskb))
>                                 continue;
> +
> +                       if (WARN_ON(!ib_device_try_get(&rxe->ib_dev))) {
> +                               kfree_skb(cskb);
> +                               break;
>                         }
> +
> +                       cpkt = SKB_TO_PKT(cskb);
> +                       cpkt->qp = qp;
> +                       rxe_add_ref(qp);
> +                       rxe_rcv_pkt(cpkt, cskb);
>                 } else {
> -                       per_qp_skb = skb;
> -                       /* show we have consumed the skb */
> -                       skb = NULL;
> +                       pkt->qp = qp;
> +                       rxe_add_ref(qp);
> +                       rxe_rcv_pkt(pkt, skb);
> +                       skb = NULL;     /* mark consumed */
>                 }
> -
> -               if (unlikely(!per_qp_skb))
> -                       continue;
> -
> -               per_qp_pkt = SKB_TO_PKT(per_qp_skb);
> -               per_qp_pkt->qp = qp;
> -               rxe_add_ref(qp);
> -               rxe_rcv_pkt(per_qp_pkt, per_qp_skb);
>         }
>
>         spin_unlock_bh(&mcg->mcg_lock);
>
>         rxe_drop_ref(mcg);      /* drop ref from rxe_pool_get_key. */
>
> -err1:
> -       /* free skb if not consumed */
> +       if (likely(!skb))
> +               return;
> +
> +       /* Fall through to drop packet
> +        * This only occurs if one of the checks fails on the last
> +        * QP in the list above
> +        */
> +
> +drop:
>         kfree_skb(skb);
>         ib_device_put(&rxe->ib_dev);
>  }
> --
> 2.27.0
>
