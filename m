Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373F732DFF2
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Mar 2021 04:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhCEDKk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Mar 2021 22:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhCEDKj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Mar 2021 22:10:39 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666D0C061574
        for <linux-rdma@vger.kernel.org>; Thu,  4 Mar 2021 19:10:39 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id z126so949865oiz.6
        for <linux-rdma@vger.kernel.org>; Thu, 04 Mar 2021 19:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZQcZjjNORAK3+MyFrKZAcIyES1GQ3gP72mYGdGahog8=;
        b=uJ/CkENBJzIoDdHWulY/WBf2UMZQ3dVNsiLCQAQLEdLOnzRSpQn2bRKlc6w31ecc1o
         JjXCSHhUy2Te9AvWdew7zmw1XhGA5U4XuNqkbW/csRbck5CutSlLos2RCqeLtkaGc4hb
         jRpz7VRO3ZYTMBSKGll0Ws70PZA9Sl2aLz2GAM4YZICoUnh0IOAMbFM7w5KUHRF3hNlF
         NOb/zuB3LHsbLy3ec75nETNtbtu+N5XBHrJq8p+iiEWYSpJDPh75y0JimvzvbfjkdpUd
         SzeSPEqcfBFEvfEK5ZBeIZXtThfJrMW57JjCiz4DYSOiB9y+gZnoU2qqVkz7GxPdb1pF
         /DOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZQcZjjNORAK3+MyFrKZAcIyES1GQ3gP72mYGdGahog8=;
        b=cD2oHGKdfDQ+0Li/Isj8bEx4degO04jztTd4dqHQdqnTZOFZaMJvlWQCRgTg6J0GsA
         iLFlIMWZgS/ncD5prdAaNJoF+m0gJxT14qNcF+Ox9g/YUdbUa5IVa9JNI9KK1BPMNDLx
         6CWvH6emIgh2hWl1/u40hcL92BRenuKlJ6hoiG+L9TLQbzRy9L5Vc7H2IASgmoQMwqd7
         UgdWkpat8UgHievasIR+lNEep9O2EswtGXArW1nOS3N8FvlA1nmlpxyUYTHtbzz2Lsoz
         8P8mKKOjtmqCSViFzrDDZganhns95wB6D2ySus+NLhpvLimxgsd9mN0OYi0ia3GFz8Zk
         r7wA==
X-Gm-Message-State: AOAM533mPIQb7oiFHTNNmtnaNl19fMetaxcrspPREXpsW9lU1WN2XXmP
        8R6cC9nsxjHmkE3VBM92l6FAtujQl0exCucjJRI=
X-Google-Smtp-Source: ABdhPJxznbxDn1/AQ/e+TR5K0WmWQWfzA3sjX2kK6FusiuPDwkz/dfRP5/NPaW2Kw17RWFQdVvw8fmS2mk8d2nK7lOo=
X-Received: by 2002:a05:6808:656:: with SMTP id z22mr5241637oih.163.1614913838732;
 Thu, 04 Mar 2021 19:10:38 -0800 (PST)
MIME-Version: 1.0
References: <20210304192048.2958-1-rpearson@hpe.com>
In-Reply-To: <20210304192048.2958-1-rpearson@hpe.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Fri, 5 Mar 2021 11:10:27 +0800
Message-ID: <CAD=hENfsiX23GSLGJ6xhfE19BTaeYfpfgH2O7Qg0Q24kztyUjg@mail.gmail.com>
Subject: Re: [PATCH for-next v3] RDMA/rxe: Fix ib_device reference counting (again)
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 5, 2021 at 3:23 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> From: Bob Pearson <rpearsonhpe@gmail.com>
>
> Three errors occurred in the fix referenced below.
>
> 1) rxe_rcv_mcast_pkt() dropped a reference to ib_device when
> no error occurred causing an underflow on the reference counter.
> This code is cleaned up to be clearer and easier to read.
>
> 2) Extending the reference taken by rxe_get_dev_from_net() in
> rxe_udp_encap_recv() until each skb is freed was not matched by
> a reference in the loopback path resulting in underflows.
>
> 3) In rxe_comp.c in rxe_completer() the function free_pkt() did
> not clear skb which triggered a warning at done: and could possibly
> at exit: . The WARN_ONCE() calls are not actually needed.
> The call to free_pkt() is moved to the end to clearly show that
> all skbs are freed.

Where do these not-freed skb come from? Except these skb, are other
resources freed correctly?

IMHO, the root cause should be found and other resources should be also handled.
WARN_ON_ONCE() should be kept on exit and done.

So if some skb are not freed incorrectly, we can find these skb in the loop end.

Zhu Yanjun

>
> This patch fixes these errors.
>
> Fixes: 899aba891cab ("RDMA/rxe: Fix FIXME in rxe_udp_encap_recv()")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
> Version 3:
> V2 of this patch had spelling errors and style issues which are
> fixed in this version.
>
> Version 2:
> v1 of this patch incorrectly added a WARN_ON_ONCE in rxe_completer
> where it could be triggered for normal traffic. This version
> replaced that with a pr_warn located correctly.
>
> v1 of this patch placed a call to kfree_skb in an if statement
> that could trigger style warnings. This version cleans that up.
>
>  drivers/infiniband/sw/rxe/rxe_comp.c | 55 +++++++++++---------------
>  drivers/infiniband/sw/rxe/rxe_net.c  | 10 ++++-
>  drivers/infiniband/sw/rxe/rxe_recv.c | 59 +++++++++++++++++-----------
>  3 files changed, 67 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
> index a8ac791a1bb9..17a361b8dbb1 100644
> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
> @@ -547,6 +547,7 @@ int rxe_completer(void *arg)
>         struct sk_buff *skb = NULL;
>         struct rxe_pkt_info *pkt = NULL;
>         enum comp_state state;
> +       int ret = 0;
>
>         rxe_add_ref(qp);
>
> @@ -554,7 +555,8 @@ int rxe_completer(void *arg)
>             qp->req.state == QP_STATE_RESET) {
>                 rxe_drain_resp_pkts(qp, qp->valid &&
>                                     qp->req.state == QP_STATE_ERROR);
> -               goto exit;
> +               ret = -EAGAIN;
> +               goto done;
>         }
>
>         if (qp->comp.timeout) {
> @@ -564,8 +566,10 @@ int rxe_completer(void *arg)
>                 qp->comp.timeout_retry = 0;
>         }
>
> -       if (qp->req.need_retry)
> -               goto exit;
> +       if (qp->req.need_retry) {
> +               ret = -EAGAIN;
> +               goto done;
> +       }
>
>         state = COMPST_GET_ACK;
>
> @@ -636,8 +640,6 @@ int rxe_completer(void *arg)
>                         break;
>
>                 case COMPST_DONE:
> -                       if (pkt)
> -                               free_pkt(pkt);
>                         goto done;
>
>                 case COMPST_EXIT:
> @@ -660,7 +662,8 @@ int rxe_completer(void *arg)
>                             qp->qp_timeout_jiffies)
>                                 mod_timer(&qp->retrans_timer,
>                                           jiffies + qp->qp_timeout_jiffies);
> -                       goto exit;
> +                       ret = -EAGAIN;
> +                       goto done;
>
>                 case COMPST_ERROR_RETRY:
>                         /* we come here if the retry timer fired and we did
> @@ -672,18 +675,18 @@ int rxe_completer(void *arg)
>                          */
>
>                         /* there is nothing to retry in this case */
> -                       if (!wqe || (wqe->state == wqe_state_posted))
> -                               goto exit;
> +                       if (!wqe || (wqe->state == wqe_state_posted)) {
> +                               pr_warn("Retry attempted without a valid wqe\n");
> +                               ret = -EAGAIN;
> +                               goto done;
> +                       }
>
>                         /* if we've started a retry, don't start another
>                          * retry sequence, unless this is a timeout.
>                          */
>                         if (qp->comp.started_retry &&
> -                           !qp->comp.timeout_retry) {
> -                               if (pkt)
> -                                       free_pkt(pkt);
> +                           !qp->comp.timeout_retry)
>                                 goto done;
> -                       }
>
>                         if (qp->comp.retry_cnt > 0) {
>                                 if (qp->comp.retry_cnt != 7)
> @@ -704,8 +707,6 @@ int rxe_completer(void *arg)
>                                         qp->comp.started_retry = 1;
>                                         rxe_run_task(&qp->req.task, 0);
>                                 }
> -                               if (pkt)
> -                                       free_pkt(pkt);
>                                 goto done;
>
>                         } else {
> @@ -726,8 +727,8 @@ int rxe_completer(void *arg)
>                                 mod_timer(&qp->rnr_nak_timer,
>                                           jiffies + rnrnak_jiffies(aeth_syn(pkt)
>                                                 & ~AETH_TYPE_MASK));
> -                               free_pkt(pkt);
> -                               goto exit;
> +                               ret = -EAGAIN;
> +                               goto done;
>                         } else {
>                                 rxe_counter_inc(rxe,
>                                                 RXE_CNT_RNR_RETRY_EXCEEDED);
> @@ -740,25 +741,15 @@ int rxe_completer(void *arg)
>                         WARN_ON_ONCE(wqe->status == IB_WC_SUCCESS);
>                         do_complete(qp, wqe);
>                         rxe_qp_error(qp);
> -                       if (pkt)
> -                               free_pkt(pkt);
> -                       goto exit;
> +                       ret = -EAGAIN;
> +                       goto done;
>                 }
>         }
>
> -exit:
> -       /* we come here if we are done with processing and want the task to
> -        * exit from the loop calling us
> -        */
> -       WARN_ON_ONCE(skb);
> -       rxe_drop_ref(qp);
> -       return -EAGAIN;
> -
>  done:
> -       /* we come here if we have processed a packet we want the task to call
> -        * us again to see if there is anything else to do
> -        */
> -       WARN_ON_ONCE(skb);
> +       if (pkt)
> +               free_pkt(pkt);
>         rxe_drop_ref(qp);
> -       return 0;
> +
> +       return ret;
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
> index 45d2f711bce2..7a49e27da23a 100644
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
> @@ -266,39 +269,47 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
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
> +       /* This only occurs if one of the checks fails on the last
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
