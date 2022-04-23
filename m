Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A202E50C5FA
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Apr 2022 03:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiDWBV5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Apr 2022 21:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiDWBV4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Apr 2022 21:21:56 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D70B1344DA
        for <linux-rdma@vger.kernel.org>; Fri, 22 Apr 2022 18:19:01 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x33so17091830lfu.1
        for <linux-rdma@vger.kernel.org>; Fri, 22 Apr 2022 18:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8d3wNrw8WGOMa20x7PhYD/FHArQ12k6AYGNhgCPteTY=;
        b=pl8mxjzTNAXatFMaJUoMpu51JFOze2mrcn2zJuSunvr4t5vMbWSwQCBnfcBKnf9jTo
         RBUf7fi8Vu+wtPnkXM+KRdm8Bwts15XrGZ6senNhEQAY9vaML7ZGGE8Try7Pm2nlfLUl
         vlGDVQdpc8Ebs62YXHwLgzBeAcLmuC7BupnmmkatcAqcLNTBspfiAIUGKi9I6FWeQAuc
         Y5LVpj/sUUi3GE12IZ1T2P2ZCwN1Rh+hxNp1Rpy9k9YbiCFisV43v5c6B8jUm7MFPrxz
         ZD5/qLvFOpUlbB5CQ5lhc/IJooUCdsW6SP5wUKwV+1eAdleIHQ5NWlgZ7fqEmkv/X9sr
         nuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8d3wNrw8WGOMa20x7PhYD/FHArQ12k6AYGNhgCPteTY=;
        b=E0VRowSHh4Rip4oGtTHHcF34ReAtJ136/gi0xGW1usfzlXx/6WxJI9oMxeamOsbWHk
         GdZX5pQAjPP9YFRbqb9HT0F2wH5IuBsY9NLY17fLWHE7/T+zpqiWbzi1foH9pwx3BtTI
         7XxIHtAez/u3Ca2rOfVj/1xpuIg4sOPb/s3XsRPv5MA6tDjj3KMm4CBF5iy4UcWB3OYN
         ez6WaFNZpLrUiDlfZy/SLXUb1Kwa9MrAQnbKHBtU4La9c1itt10c8D1Axgi/hytADKrf
         XD+5bBWzC5O00Y55rZrmbWIFrcku5JW2FexHjHv8ume/ZPU4q0PvOoXzPUyHt21DkuN0
         Uh0g==
X-Gm-Message-State: AOAM532PeIzKU8yOYIzXVM6r3Q3UwUpRwkBGD3dDPJldKeouPjiyZ+ol
        qgnmnRjJsAwMiRJvTTXzwlib+7cIdVcdEFrrXuk=
X-Google-Smtp-Source: ABdhPJzp2r/4cN4Z151f1sOp9Tl7dQi9YmxQDbismk+HNg+sqaxRsj9cWMjmZ4lTTHsEbD4Ad1ruFN1THn68s/pV9kc=
X-Received: by 2002:a05:6512:3334:b0:471:f727:7e20 with SMTP id
 l20-20020a056512333400b00471f7277e20mr309869lfe.281.1650676739348; Fri, 22
 Apr 2022 18:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <983bec37-4765-b45e-0f73-c474976d2dfc@gmail.com>
 <20220422210025.GL2120790@nvidia.com> <387a0976-9f6f-29d3-347f-0ae551821b34@gmail.com>
In-Reply-To: <387a0976-9f6f-29d3-347f-0ae551821b34@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sat, 23 Apr 2022 09:18:47 +0800
Message-ID: <CAD=hENe6mQhOEp976UX+cR9Yf74gABcSnt7iXmitVV3sGcVzfA@mail.gmail.com>
Subject: Re: much about ah objects in rxe
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Apr 23, 2022 at 6:11 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> On 4/22/22 16:00, Jason Gunthorpe wrote:
> > On Fri, Apr 22, 2022 at 01:32:24PM -0500, Bob Pearson wrote:
> >> Jason,
> >>
> >> I am confused a little.
> >>
> >>  - xa_alloc_xxx internally takes xa->xa_lock with a spinlock but
> >>    has a gfp_t parameter which is normally GFP_KERNEL. So I trust them when they say
> >>    that it releases the lock around kmalloc's by 'magic' as you say.
> >>
> >>  - The only read side operation on the rxe pool xarrays is in rxe_pool_get_index() but
> >>    that will be protected by a rcu_read_lock so it can't deadlock with the write
> >>    side spinlocks regardless of type (plain, _bh, _saveirq)
> >>
> >>  - Apparently CM is calling ib_create_ah while holding spin locks. This would
> >>    call xa_alloc_xxx which would unlock xa_lock and call kmalloc(..., GFP_KERNEL)
> >>    which should cause a warning for AH. You say it does not because xarray doesn't
> >>    call might_sleep().
> >>
> >> I am not sure how might_sleep() works. When I add might_sleep() just ahead of
> >> xa_alloc_xxx() it does not cause warnings for CM test cases (e.g. rping.)
> >> Another way to study this would be to test for in_atomic() but
> >
> > might_sleep should work, it definately triggers from inside a
> > spinlock. Perhaps you don't have all the right debug kconfig enabled?
> >
> >> that seems to be discouraged and may not work as assumed. It's hard to reproduce
> >> evidence that ib_create_ah really has spinlocks held by the caller. I think it
> >> was seen in lockdep traces but I have a hard time reading them.
> >
> > There is a call to create_ah inside RDMA CM that is under a spinlock
> >
> >>  - There is a lot of effort trying to make 'deadlocks' go away. But the read side
> >>    is going to end as up rcu_read_lock so there soon will be no deadlocks with
> >>    rxe_pool_get_index() possible. xarrays were designed to work well with rcu
> >>    so it would better to just go ahead and do it. Verbs objects tend to be long
> >>    lived with lots of IO on each instance. This is a perfect use case for rcu.
> >
> > Yes
> >
> >> I think this means there is no reason for anything but a plain spinlock in rxe_alloc
> >> and rxe_add_to_pool.
> >
> > Maybe, are you sure there are no other xa spinlocks held from an IRQ?
> >
> > And you still have to deal with the create AH called in an atomic
> > region.
>
> There are only 3 references to the xarrays:
>
>         1. When an object is allocated. Either from rxe_alloc() which is called
>            an MR is registered or from rxe_add_to_pool() when the other
>            objects are created.
>         2. When an object is looked up from rxe_pool_get_index()
>         3. When an object is cleaned up from rxe_xxx_destroy() and similar.
>
> For non AH objects the create and destroy verbs are always called in process
> context and non-atomic and the lookup routine is normally called in soft IRQ
> context but doesn't take a lock when rcu is used so can't deadlock.

Are you sure about this? There are about several non AH objects.
You can make sure that all in process context?

And you can ensure it in the future?

>
> For AH objects the create call is always called in process context but may

How to ensure it?

> or may not hold an irq spinlock so hard interrupts are disabled to prevent
> deadlocking CMs locks. The cleanup call is also in process context but also
> may or may not hold an irq spinlock (not sure if it happens). These calls
> can't deadlock each other for the xa_lock because there either won't be an
> interrupt or because the process context calls don't cause reentering the
> rxe code. They also can't deadlock with the lookup call when it is using rcu.

From you, all the operations including create, destroy and lookup are
in process context or soft IRQ context.
How to ensure it? I mean that all operations are always in process or
soft IRQ context, and will not violate?
Even though in different calls ?

Zhu Yanjun

>
> >
> >> To sum up once we have rcu enabled the only required change is to use GFP_ATOMIC
> >> or find a way to pre-allocate for AH objects (assuming that I can convince myself
> >> that ib_create_ah really comes with spinlocks held).
> >
> > Possibly yes
> >
> > Jason
>
