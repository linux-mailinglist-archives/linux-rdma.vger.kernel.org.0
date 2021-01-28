Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE59306C17
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 05:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhA1EPg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jan 2021 23:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhA1EPR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Jan 2021 23:15:17 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0561DC06178A
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jan 2021 19:50:36 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id k25so4625664oik.13
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jan 2021 19:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GEU5F1OOHpBKSOLlDUFaVge68RwyHDG7D57BU5M9jsg=;
        b=n/I9YWd1vQzPOAeHtaZumtllDXLxpuHd6vkd5j8vcaSMdWcb6TDJprcITZNhlgrEnI
         Q6gfP4ogfKUP9qo76//MfxEMVZmyg0zTLJIOQjpGskmlKj0QBLvCiB7ICdz7NKEDZDj5
         IPanQZmqciW37RaHZY43EMkseiSA5VsYTGWQvorEv3DmsW2veKo39vTQeSlV/T/yJaFE
         XgsfMVC4lidN+g6UEdZHwLLDKCOL16NC1ao6Zhl76inwnTbxV9Tu3iHlV+pxC8uyKtJI
         J9Z8nov4uyFB2u4DFhECEETYcXKoO67beGgkSapmog8FzwKB8mERp+ZNLgdy8h/9ELI7
         D76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEU5F1OOHpBKSOLlDUFaVge68RwyHDG7D57BU5M9jsg=;
        b=AoRb2m12scXEcPOzRO6rHFOHLEVnijIhHhFcvBVzhjJ93RTSJA7NeBQbjhre8FQgXv
         5qmByxrOXubeBE04S6uNmKGCP27o2mq06W3BNjsWmVKTkKN+//qJpTiqEvsKFh5YhYhV
         0N+gPp66IRL9PalLsz7nUFl1/+ZsCY66dqeaN3zIID/sVszMtXSjtaNkFxtFMdpt8p0w
         KZtfrMRaSxiomVsgoNX7yXOmM3txhyD4xrBaU8c4jWrgK4yAJfh3XPkGolWzxviP1otE
         aiAh4lCV3AT5n5M/i/glmLSJCI6LCGwyd52XhIg+7agl2nXzdwA3ItEauHVCsXOb+95d
         OjCg==
X-Gm-Message-State: AOAM532ECESUmVzrvAn2nEeCpJO5TRV6RPnEbOTmWGVlibxvXLsMRHAx
        50xHFF2rf8sJj8xsz/db5NfU3uAcqskb0m96VpI=
X-Google-Smtp-Source: ABdhPJxCpIGJs/9/bMUisS7kGHv5pQn9aT0DluwOplJSXBLgnvaC9tdaa6KZBEoqWv7KiZIPwu/LF+U6TmWZRU088X4=
X-Received: by 2002:aca:fc07:: with SMTP id a7mr5377227oii.89.1611805835367;
 Wed, 27 Jan 2021 19:50:35 -0800 (PST)
MIME-Version: 1.0
References: <20210128011226.3096-1-rpearson@hpe.com>
In-Reply-To: <20210128011226.3096-1-rpearson@hpe.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 28 Jan 2021 11:50:23 +0800
Message-ID: <CAD=hENeWJKzs03D7x5=wXZ6mhiKJBrB-y3GOBAsWpfnKfX+Q4A@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix coding error in rxe_rcv_mcast_pkt
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 28, 2021 at 9:12 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> rxe_rcv_mcast_pkt() in rxe_recv.c can leak SKBs in error path
> code. The loop over the QPs attached to a multicast group
> creates new cloned SKBs for all but the last QP in the list
> and passes the SKB and its clones to rxe_rcv_pkt() for further
> processing. Any QPs that do not pass some checks are skipped.
> If the last QP in the list fails the tests the SKB is leaked.
> This patch checks if the SKB for the last QP was used and if
> not frees it. Also removes a redundant loop invariant assignment.
>
> Fixes: 8700e3e7c4857 ("Soft RoCE driver")
> Fixes: 71abf20b28ff8 ("RDMA/rxe: Handle skb_clone() failure in rxe_recv.c")
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_recv.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
> index c9984a28eecc..57cc25e3b4ad 100644
> --- a/drivers/infiniband/sw/rxe/rxe_recv.c
> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
> @@ -252,7 +252,6 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>
>         list_for_each_entry(mce, &mcg->qp_list, qp_list) {
>                 qp = mce->qp;
> -               pkt = SKB_TO_PKT(skb);
>
>                 /* validate qp for incoming packet */
>                 err = check_type_state(rxe, pkt, qp);
> @@ -264,12 +263,18 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>                         continue;
>
>                 /* for all but the last qp create a new clone of the
> -                * skb and pass to the qp.
> +                * skb and pass to the qp. If an error occurs in the
> +                * checks for the last qp in the list we need to
> +                * free the skb since it hasn't been passed on to
> +                * rxe_rcv_pkt() which would free it later.
>                  */
> -               if (mce->qp_list.next != &mcg->qp_list)
> +               if (mce->qp_list.next != &mcg->qp_list) {
>                         per_qp_skb = skb_clone(skb, GFP_ATOMIC);
> -               else
> +               } else {
>                         per_qp_skb = skb;
> +                       /* show we have consumed the skb */
> +                       skb = NULL;
> +               }
>
>                 if (unlikely(!per_qp_skb))
>                         continue;
> @@ -284,10 +289,9 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>
>         rxe_drop_ref(mcg);      /* drop ref from rxe_pool_get_key. */
>
> -       return;
> -
>  err1:
> -       kfree_skb(skb);
> +       if (skb)
> +               kfree_skb(skb);

"if (skb)" is not needed here.

The implemetation of kfree_skb:

void kfree_skb(struct sk_buff *skb)
{
if (unlikely(!skb))
return;
if (likely(atomic_read(&skb->users) == 1))
smp_rmb();
else if (likely(!atomic_dec_and_test(&skb->users)))
return;
trace_kfree_skb(skb, __builtin_return_address(0));
__kfree_skb(skb);
}

Zhu Yanjun
>  }
>
>  /**
> --
> 2.27.0
>
