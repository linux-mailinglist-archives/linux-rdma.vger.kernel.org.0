Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD34A30768B
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 13:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhA1M6K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jan 2021 07:58:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231779AbhA1M6J (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 28 Jan 2021 07:58:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8939764D92;
        Thu, 28 Jan 2021 12:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611838648;
        bh=NittsJ5+9MzDvY6nG9MS5tm7FeRuqDv6Pwkd7sUxaNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sBK3/pgi8ytx0qFDtWKXgOU/lICk6To3jJI0xrofneZXeSjLZBmSvlzDTO38iYYVq
         dnp0MJXuTkh8JhKqQMeSvhwK1WU8s4ywJZILr5lvZ4X3X23Q3rSGv1H4ALke7haNrP
         yYqrUzqh2nsRgHAqGfaoSybJGjTYCM92aH4HWBZ2nl3V4MfvdlJYOO8vmf1gDmkiun
         uwHav6E03Js3c/ITgxwuUXZHeMrrFTNcZeIc6HRaT1bpRbabyQGNMvAwAY9ErM9wqw
         MFtj66K1sezX70ianr53oDaoc22ffHmZJpZMMuYMwLriHFnPCgDmqDODv+N1XGXS/w
         ht6hCVUtKsiSQ==
Date:   Thu, 28 Jan 2021 14:57:24 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix coding error in rxe_rcv_mcast_pkt
Message-ID: <20210128125724.GD5097@unreal>
References: <20210128011226.3096-1-rpearson@hpe.com>
 <CAD=hENeWJKzs03D7x5=wXZ6mhiKJBrB-y3GOBAsWpfnKfX+Q4A@mail.gmail.com>
 <643809c8-7740-7373-2975-cac9aeb4e111@gmail.com>
 <ad2e12fb-9d38-197b-c842-06bb68fe3be3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad2e12fb-9d38-197b-c842-06bb68fe3be3@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 27, 2021 at 10:23:53PM -0600, Bob Pearson wrote:
> On 1/27/21 9:53 PM, Bob Pearson wrote:
> > On 1/27/21 9:50 PM, Zhu Yanjun wrote:
> >> On Thu, Jan 28, 2021 at 9:12 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> >>>
> >>> rxe_rcv_mcast_pkt() in rxe_recv.c can leak SKBs in error path
> >>> code. The loop over the QPs attached to a multicast group
> >>> creates new cloned SKBs for all but the last QP in the list
> >>> and passes the SKB and its clones to rxe_rcv_pkt() for further
> >>> processing. Any QPs that do not pass some checks are skipped.
> >>> If the last QP in the list fails the tests the SKB is leaked.
> >>> This patch checks if the SKB for the last QP was used and if
> >>> not frees it. Also removes a redundant loop invariant assignment.
> >>>
> >>> Fixes: 8700e3e7c4857 ("Soft RoCE driver")
> >>> Fixes: 71abf20b28ff8 ("RDMA/rxe: Handle skb_clone() failure in rxe_recv.c")
> >>> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> >>> ---
> >>>  drivers/infiniband/sw/rxe/rxe_recv.c | 18 +++++++++++-------
> >>>  1 file changed, 11 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
> >>> index c9984a28eecc..57cc25e3b4ad 100644
> >>> --- a/drivers/infiniband/sw/rxe/rxe_recv.c
> >>> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
> >>> @@ -252,7 +252,6 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
> >>>
> >>>         list_for_each_entry(mce, &mcg->qp_list, qp_list) {
> >>>                 qp = mce->qp;
> >>> -               pkt = SKB_TO_PKT(skb);
> >>>
> >>>                 /* validate qp for incoming packet */
> >>>                 err = check_type_state(rxe, pkt, qp);
> >>> @@ -264,12 +263,18 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
> >>>                         continue;
> >>>
> >>>                 /* for all but the last qp create a new clone of the
> >>> -                * skb and pass to the qp.
> >>> +                * skb and pass to the qp. If an error occurs in the
> >>> +                * checks for the last qp in the list we need to
> >>> +                * free the skb since it hasn't been passed on to
> >>> +                * rxe_rcv_pkt() which would free it later.
> >>>                  */
> >>> -               if (mce->qp_list.next != &mcg->qp_list)
> >>> +               if (mce->qp_list.next != &mcg->qp_list) {
> >>>                         per_qp_skb = skb_clone(skb, GFP_ATOMIC);
> >>> -               else
> >>> +               } else {
> >>>                         per_qp_skb = skb;
> >>> +                       /* show we have consumed the skb */
> >>> +                       skb = NULL;
> >>> +               }
> >>>
> >>>                 if (unlikely(!per_qp_skb))
> >>>                         continue;
> >>> @@ -284,10 +289,9 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
> >>>
> >>>         rxe_drop_ref(mcg);      /* drop ref from rxe_pool_get_key. */
> >>>
> >>> -       return;
> >>> -
> >>>  err1:
> >>> -       kfree_skb(skb);
> >>> +       if (skb)
> >>> +               kfree_skb(skb);
> >>
> >> "if (skb)" is not needed here.
> >>
> >> The implemetation of kfree_skb:
> >>
> >> void kfree_skb(struct sk_buff *skb)
> >> {
> >> if (unlikely(!skb))
> >> return;
> >> if (likely(atomic_read(&skb->users) == 1))
> >> smp_rmb();
> >> else if (likely(!atomic_dec_and_test(&skb->users)))
> >> return;
> >> trace_kfree_skb(skb, __builtin_return_address(0));
> >> __kfree_skb(skb);
> >> }
> >>
> >> Zhu Yanjun
> >>>  }
> >>>
> >>>  /**
> >>> --
> >>> 2.27.0
> >>>
> > Agreed but the reason I wrote that was to make it obvious why I set skb to NULL above. But as long as it is clear without it I can remove the test.
> >
> Actually I should have written
>
> if (unlikely(skb))
> 	kfree_skb(skb);

Please don't put "if (a) kfree(a);" constructions unless you want to
deal with daily flux of patches with attempt to remove "if".

Thanks

>
>
