Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983FA439EB0
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Oct 2021 20:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhJYSvd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Oct 2021 14:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbhJYSvd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Oct 2021 14:51:33 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98FDC061745
        for <linux-rdma@vger.kernel.org>; Mon, 25 Oct 2021 11:49:10 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id e10so24220092uab.3
        for <linux-rdma@vger.kernel.org>; Mon, 25 Oct 2021 11:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eepvmKgRMWA4TwGLP0vRPHqaoFkIm/wYBhDXczCasu8=;
        b=CpVqoVRmp7nNjxVxPikYBc5Cra8VPddQBYVItWW+YjKcM3gWQxm1jWLUTYYPBv6FRV
         KBmGH/xZoa2Qrnt8CKdKkDfRcCmq2NXxiL0ElkA259u7PdtZ4U5eVswy4utmfB3f+XCb
         71iOkMS5PzjMK43yoJoaOBD3xyt9QHwyVkhkRLB3wQaYfgI3XtJ35bbBNa+HhaKgyOxB
         Oi+HlUgJ3X49rKly44qY7JYesTXzavphwUsY/q40bbQF1aafQ76a3REKlPJJT87tsjNh
         Abay5abi4/tElxm+txKrDyL3JOAbb/GIT0JPWnBYxXi6rhkvlXraCdOH3Tx5jp0sp+Ux
         Pn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eepvmKgRMWA4TwGLP0vRPHqaoFkIm/wYBhDXczCasu8=;
        b=qJVVP7jfHS86MVY2AN5rV2VkgnVrK1kwJJ+5ydGKrYC8om3RV6mInNrlByAKwHQjBO
         K3G8hjXVcrqPaoFEFsqF+GbVW5Zuhc8/LVRLAcNjmg7qRFoFYcxFuvYoeH9Voahf0lzO
         9cO/7xJQNgc0GhmnNnwf+bMzYPUjVeNvWveqiH7lFGgcnreJP4x0EFqFyLK88IOWtGvc
         Ukb5KCzt1sTpCGslYuD4ya7eTlyIlILFevbpHBnPrM4MVUZiKBldQQaIasBlRBK+0ZNS
         G6rp2ey2Q1hWu8+y7SQgEteHikyLtAJusM9U7Pc+RKqGOtDwsw+usfIYUFoak54eVDeB
         Ly6w==
X-Gm-Message-State: AOAM530L2OZqi7brsO04rNuP57ZVXNXoB7tACH1Jxyp9Zd2bWbDWRUTF
        1Ofc6F2JaBNNo39RlDIx0pS5rtidohYr/Vl/1Z4ESdVC
X-Google-Smtp-Source: ABdhPJyQF7xtnZNt+DzOCIyEr7fWxbTxZaDMcnfKBU8hzBYukZb75VU1GxGZyqIUF3wvbL7kH3wFsMj5QYeKi8EtVfU=
X-Received: by 2002:a05:6102:3122:: with SMTP id f2mr5087012vsh.58.1635187749805;
 Mon, 25 Oct 2021 11:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211010235931.24042-1-rpearsonhpe@gmail.com> <20211010235931.24042-2-rpearsonhpe@gmail.com>
 <20211020231653.GA28428@nvidia.com> <21346584-a27f-323b-e932-042fa7cd94b5@gmail.com>
 <20211025124357.GS2744544@nvidia.com>
In-Reply-To: <20211025124357.GS2744544@nvidia.com>
From:   Robert Pearson <rpearsonhpe@gmail.com>
Date:   Mon, 25 Oct 2021 13:48:58 -0500
Message-ID: <CAFc_bgY3e7Zy6kN2PyZN74dvPWda94-tjRorA52yVPBS9gkH7A@mail.gmail.com>
Subject: Re: [PATCH for-next 1/6] RDMA/rxe: Make rxe_alloc() take pool lock
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This looks useful but I had given up using xarrays to hold multicast
groups because the mgids are 128 bits. The ib_attach_mcast() verb just
passes in the QP and MGID and I couldn't think of an efficient way to
reduce the MGID to a 32 bit non-sparse index. The xarray documentation
advises against hashing the object to get an index. If Linux hands out
mcast group IDs sequentially it may be OK to just use the flag and
scope bits concatenated with the low order 24 bits of the group number
but one would have to deal with (maybe never happen) collisions. If
this worked I could get rid of all the RB trees and make everything be
xarrays.

Bob

On Mon, Oct 25, 2021 at 7:43 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Oct 21, 2021 at 12:46:50PM -0500, Bob Pearson wrote:
> > On 10/20/21 6:16 PM, Jason Gunthorpe wrote:
> > > On Sun, Oct 10, 2021 at 06:59:26PM -0500, Bob Pearson wrote:
> > >> In rxe there are two separate pool APIs for creating a new object
> > >> rxe_alloc() and rxe_alloc_locked(). Currently they are identical.
> > >> Make rxe_alloc() take the pool lock which is in line with the other
> > >> APIs in the library.
> > >>
> > >> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> > >>  drivers/infiniband/sw/rxe/rxe_pool.c | 21 ++++-----------------
> > >>  1 file changed, 4 insertions(+), 17 deletions(-)
> > >>
> > >> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> > >> index ffa8420b4765..7a288ebacceb 100644
> > >> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> > >> @@ -352,27 +352,14 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
> > >>
> > >>  void *rxe_alloc(struct rxe_pool *pool)
> > >>  {
> > >> -  struct rxe_type_info *info = &rxe_type_info[pool->type];
> > >> -  struct rxe_pool_entry *elem;
> > >> +  unsigned long flags;
> > >>    u8 *obj;
> > >>
> > >> -  if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
> > >> -          goto out_cnt;
> > >> -
> > >> -  obj = kzalloc(info->size, GFP_KERNEL);
> > >> -  if (!obj)
> > >> -          goto out_cnt;
> > >> -
> > >> -  elem = (struct rxe_pool_entry *)(obj + info->elem_offset);
> > >> -
> > >> -  elem->pool = pool;
> > >> -  kref_init(&elem->ref_cnt);
> > >> +  write_lock_irqsave(&pool->pool_lock, flags);
> > >> +  obj = rxe_alloc_locked(pool);
> > >> +  write_unlock_irqrestore(&pool->pool_lock, flags);
> > >
> > > But why? This just makes a GFP_KERNEL allocation into a GFP_ATOMIC
> > > allocation, which is bad.
> > >
> > > Jason
> > >
> > how bad?
>
> Quite bad..
>
> > It only has to happen once in the driver for mcast group elements
> > where currently I have (to avoid the race when two QPs try to join
> > the same mcast grp on different CPUs at the same time)
> >
> >       spin_lock()
> >       grp = rxe_get_key_locked(pool, mgid)
> >       if !grp
> >               grp = rxe_alloc_locked(pool)
> >       spin_unlock()
>
> When you have xarray the general pattern is:
>
> old = xa_load(mgid)
> if (old
>    return old
>
> new = kzalloc()
> old = xa_cmpxchg(mgid, NULL, new)
> if (old)
>      kfree(new)
>      return old;
> return new;
>
> There are several examples of this with various locking patterns
>
> Jason
