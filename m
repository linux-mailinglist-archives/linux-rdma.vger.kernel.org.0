Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC2B306C8A
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 06:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbhA1FBr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jan 2021 00:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhA1FBp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jan 2021 00:01:45 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F69C061573
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jan 2021 21:01:04 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id k8so4054890otr.8
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jan 2021 21:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/M2gZKLNztFdAWwGGh77olgGMj5JXWhnsg3Wq02atVc=;
        b=uquGazj4a02/JqAPiGz/H/su2HuD67gY5INmPPRo4t3SiZ8ie2Vdu4JFyq6G782APL
         dCdglYXrqahw7ZEDVD4UjZDDmf2fvyLe8Nlxzl9WwBCpbbGYrz9Y8nKfvRau685prD+z
         O9rFahrQVlI8QZz72iJvAt/dlSH0qlJQnhTz110VOVJjrXX0fiwolaV9c6YYPFl+0z2S
         vVRt1mB0427wcGw5DUXuLLpFjRH2GM8myYxGd/wDdIDkMiKiqJ7KWkT+iAJ3WEVubj3C
         J6OPn4FlhOUNfcuUSMAIczLNviTYw41UKHiPdpuBxQBfm9ob947twAuqTL6MRNTn/0vK
         cMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/M2gZKLNztFdAWwGGh77olgGMj5JXWhnsg3Wq02atVc=;
        b=mnBCJgMrdKsPjRrIuWCsb7J60kSd7y5tlnE2ap76KXZdDAsw9/n7GxLDJ85ZiLGwlg
         dYIza4tI0iAGtILN1pmKCzc/211O5YqVqjWywo4973oQA4KQOTOxP9W0qt9awACdI33y
         M+Tc65JxhkN01gIodvu4ea5BPOD5Jx8kVYbNr91iAU7u6YuZDmtZ1Xd/nJ2AovYUieTA
         845ESPFb1A9BYxCI7TCKUL7CzC3++UUGgj9JBtG7B1XjMEjyrLhITjkB+t05pnQ49Ra5
         oNCYxgrNEr4CeP6uCAhIe8ILoSOAMk3ydRltbk/6SBJl9dt7ryw9nA5KHIQNqvMMdHO0
         Nsqg==
X-Gm-Message-State: AOAM53372vwzWAuAuv3CWyrL6c2Z4Ds9/z0SS/88/UKzgTuIBzkHxjm8
        LiwTYT5yOuiu4jVqiTzfr8KPL9Ov8cjEGe8krO4=
X-Google-Smtp-Source: ABdhPJxhXxjMAGcmKMebAcNq7et7Y47UVcbq0wNi8ZKO8OPGrFt06HVtP5coUbfvvgfUz63k3g6PCERoshBNw8lchPA=
X-Received: by 2002:a05:6830:3482:: with SMTP id c2mr10200327otu.59.1611810064004;
 Wed, 27 Jan 2021 21:01:04 -0800 (PST)
MIME-Version: 1.0
References: <20210128011226.3096-1-rpearson@hpe.com> <CAD=hENeWJKzs03D7x5=wXZ6mhiKJBrB-y3GOBAsWpfnKfX+Q4A@mail.gmail.com>
 <643809c8-7740-7373-2975-cac9aeb4e111@gmail.com> <ad2e12fb-9d38-197b-c842-06bb68fe3be3@gmail.com>
In-Reply-To: <ad2e12fb-9d38-197b-c842-06bb68fe3be3@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 28 Jan 2021 13:00:51 +0800
Message-ID: <CAD=hENfF0-O1+tkuD5FPQCPROuq7oDKvH9PN0FP2t72jfbmK6g@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix coding error in rxe_rcv_mcast_pkt
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 28, 2021 at 12:23 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
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
>         kfree_skb(skb);

This is not in fast path. It is in error handling. Not sure if this
can make big optimizations.

Zhu Yanjun
>
>
