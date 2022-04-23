Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8A150C6A8
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Apr 2022 04:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiDWCiO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Apr 2022 22:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiDWCiL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Apr 2022 22:38:11 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9986AFE5E6
        for <linux-rdma@vger.kernel.org>; Fri, 22 Apr 2022 19:35:15 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id y32so17256052lfa.6
        for <linux-rdma@vger.kernel.org>; Fri, 22 Apr 2022 19:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mAjj7vb+jpEdxehtsXvQsPoaerEpLTK6GpbJNfOA29I=;
        b=IPhu2+B9gFs7F+/BCAjlc1B4vlr0Cv1DB8xs7/Z/6Y4iFvKdUtoFwUPCzGqsFlrDmK
         qD9t3JvsF3BjDLT8wf6lc59eaCJx7U5eP1ei+aGYrf0XjH7EByp0oH9yWaAWVyw5X8zf
         wFWQulIMf7yYpV/w3kDQApahLmO2KP5K3EfKH1fDnAheVyrGIuEyEYKnDqPoIvLgO004
         2Mrhk4lbVjaPfcTka7czRq9dcpNSaFJQ/40LGqcbg6N4CKPSUYGyWfK6u0M6I6atHEbM
         uM9sd1svKsVXXcBEvlMmDhVd5Y9JW3Tr2VZ3Zx18mBQNnMvegwUiP8fEJMglUIHQLuNd
         ipaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mAjj7vb+jpEdxehtsXvQsPoaerEpLTK6GpbJNfOA29I=;
        b=IomgSfGOJARkEMohzkbF1w4cS7WkoWb+wpG99FnUgzipGNN5oxyxDdyVOIMxmqdWB2
         gzTDlvJKLHa+WpW0mrQDyQAPvkG1JoACsNc/68PIYg2rBFr3/Tq52/j0u28W/zAis3+p
         GHXJpPHyWB/fm0+KFGndOziipClu8yIKyxMe4SuueN2OjxVx59LzCNT/m8DuThLfqMnf
         V4PmkCRruMKubIx9sh3yXXcqpFZiU6WeM6jPueW0UqzF5kKxlq8fxkc3O7Eir6SUghw8
         5W4uH23N1O1JU/panXZHUH8KJmtckne/LU/BlPsmhc9Xo4LkzrBiKBca58OS2gOK6j7u
         dKcw==
X-Gm-Message-State: AOAM530On2ceIzTmctSmeU/Kh7zyzPNPGMSqT5ldXJ3UmzLodDh4mIG4
        TIdvUcUu2Y4pVbrd5udXmy+4yTsWrhQROKuk4mf71r6k
X-Google-Smtp-Source: ABdhPJygtK+d9qcnOPh4k88yNY4dEqg44UYIQkqnYUkf2+QOimbjSAsXQYvZxK77B6FSH/yXL3JJ9u9eUIs2B38Pt9E=
X-Received: by 2002:a05:6512:1526:b0:471:44fa:c367 with SMTP id
 bq38-20020a056512152600b0047144fac367mr5145918lfb.376.1650681313725; Fri, 22
 Apr 2022 19:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <983bec37-4765-b45e-0f73-c474976d2dfc@gmail.com>
 <20220422210025.GL2120790@nvidia.com> <387a0976-9f6f-29d3-347f-0ae551821b34@gmail.com>
 <CAD=hENe6mQhOEp976UX+cR9Yf74gABcSnt7iXmitVV3sGcVzfA@mail.gmail.com> <5fc18e8e-25f9-5398-f0c8-e546466e08f3@gmail.com>
In-Reply-To: <5fc18e8e-25f9-5398-f0c8-e546466e08f3@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sat, 23 Apr 2022 10:35:02 +0800
Message-ID: <CAD=hENetRAy359Gj7-prCRjKkovz3_+xQT-Dt26Rr9YD0uGGFA@mail.gmail.com>
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

On Sat, Apr 23, 2022 at 9:48 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> On 4/22/22 20:18, Zhu Yanjun wrote:
> > On Sat, Apr 23, 2022 at 6:11 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> >>
> >> On 4/22/22 16:00, Jason Gunthorpe wrote:
> >>> On Fri, Apr 22, 2022 at 01:32:24PM -0500, Bob Pearson wrote:
> >>>> Jason,
> >>>>
> >>>> I am confused a little.
> >>>>
> >>>>  - xa_alloc_xxx internally takes xa->xa_lock with a spinlock but
> >>>>    has a gfp_t parameter which is normally GFP_KERNEL. So I trust them when they say
> >>>>    that it releases the lock around kmalloc's by 'magic' as you say.
> >>>>
> >>>>  - The only read side operation on the rxe pool xarrays is in rxe_pool_get_index() but
> >>>>    that will be protected by a rcu_read_lock so it can't deadlock with the write
> >>>>    side spinlocks regardless of type (plain, _bh, _saveirq)
> >>>>
> >>>>  - Apparently CM is calling ib_create_ah while holding spin locks. This would
> >>>>    call xa_alloc_xxx which would unlock xa_lock and call kmalloc(..., GFP_KERNEL)
> >>>>    which should cause a warning for AH. You say it does not because xarray doesn't
> >>>>    call might_sleep().
> >>>>
> >>>> I am not sure how might_sleep() works. When I add might_sleep() just ahead of
> >>>> xa_alloc_xxx() it does not cause warnings for CM test cases (e.g. rping.)
> >>>> Another way to study this would be to test for in_atomic() but
> >>>
> >>> might_sleep should work, it definately triggers from inside a
> >>> spinlock. Perhaps you don't have all the right debug kconfig enabled?
> >>>
> >>>> that seems to be discouraged and may not work as assumed. It's hard to reproduce
> >>>> evidence that ib_create_ah really has spinlocks held by the caller. I think it
> >>>> was seen in lockdep traces but I have a hard time reading them.
> >>>
> >>> There is a call to create_ah inside RDMA CM that is under a spinlock
> >>>
> >>>>  - There is a lot of effort trying to make 'deadlocks' go away. But the read side
> >>>>    is going to end as up rcu_read_lock so there soon will be no deadlocks with
> >>>>    rxe_pool_get_index() possible. xarrays were designed to work well with rcu
> >>>>    so it would better to just go ahead and do it. Verbs objects tend to be long
> >>>>    lived with lots of IO on each instance. This is a perfect use case for rcu.
> >>>
> >>> Yes
> >>>
> >>>> I think this means there is no reason for anything but a plain spinlock in rxe_alloc
> >>>> and rxe_add_to_pool.
> >>>
> >>> Maybe, are you sure there are no other xa spinlocks held from an IRQ?
> >>>
> >>> And you still have to deal with the create AH called in an atomic
> >>> region.
> >>
> >> There are only 3 references to the xarrays:
> >>
> >>         1. When an object is allocated. Either from rxe_alloc() which is called
> >>            an MR is registered or from rxe_add_to_pool() when the other
> >>            objects are created.
> >>         2. When an object is looked up from rxe_pool_get_index()
> >>         3. When an object is cleaned up from rxe_xxx_destroy() and similar.
> >>
> >> For non AH objects the create and destroy verbs are always called in process
> >> context and non-atomic and the lookup routine is normally called in soft IRQ
> >> context but doesn't take a lock when rcu is used so can't deadlock.
> >
> > Are you sure about this? There are about several non AH objects.
> > You can make sure that all in process context?
> >
> > And you can ensure it in the future?
>
> I added the line
>
>         WARN_ON(!in_task());
>
> to rxe_alloc and rxe_add_to_pool
>
> and it never triggered. I would be theoretically possible for someone to try

Your test environment does not mean that all the test environments
will not trigger this.

> to write a module that responds to an interrupt in some wigit and then
> tries to start a verbs session. But it would be very strange. It is reasonable
> to just declare that the verbs APIs are not callable in interrupt (soft or hard)

This will limit verbs APIs use.

> context. I believe this is tacitly understood and currently is true. It is a
> separate issue whether or not the caller is in 'atomic context' which includes
> holding a spinlock and implies that the thread cannot sleep. the xarray code
> if you look at the code for xa_alloc_cyclic() does take the xa_lock spinlock around
> _xa_alloc_cyclic() but they also say in the comments that they release that lock
> internally before calling kmalloc() and friends if the gfp_t parameter is
> GFP_KERNEL so that it is safe to sleep.  However cma.c calls ib_create_ah() while
> holding spinlocks (happens to be spin_lock_saveirq() but that doesn't matter here
> since any spinlock makes it bad to call kmalloc()). So we have to use GFP_ATOMIC
> for AH objects.
>
> It is clear that the assumption of the verbs APIs is that they are always called
> in process context.

How to ensure that they are not called in interrupt context? And some
kernel modules
also use the rdma.

> >
> >>
> >> For AH objects the create call is always called in process context but may
> >
> > How to ensure it?
>
> Same way. It is true now see the WARN_ON above.
> >
> >> or may not hold an irq spinlock so hard interrupts are disabled to prevent
> >> deadlocking CMs locks. The cleanup call is also in process context but also
> >> may or may not hold an irq spinlock (not sure if it happens). These calls
> >> can't deadlock each other for the xa_lock because there either won't be an
> >> interrupt or because the process context calls don't cause reentering the
> >> rxe code. They also can't deadlock with the lookup call when it is using rcu.
> >
> > From you, all the operations including create, destroy and lookup are
> > in process context or soft IRQ context.
> > How to ensure it? I mean that all operations are always in process or
> > soft IRQ context, and will not violate?
> > Even though in different calls ?
>
> We have no way to get into interrupt context. We get called from above through
> the verbs APIs in process context and from below by NAPI passing network packets
> to us in softirq context. We also internally defer work to tasklets which are
> always soft IRQs. Unless someone outside of the rdma-core subsystem called into
> verbs calls from interrupt context (weird) it can never happen. And has never
> happened. Again don't get confused with irqsave spinlocks. They are used in
> process or soft irq context sometimes and disable hardware interrupts to prevent
> a deadlock with another spinlock in a hardware interrupt handler. But we don't
> have any code that runs in hardware interrupt context to worry about. I doubt
> cma does either but many people use irqsave spinlocks when they are not needed.

How to verify that many people use unnecessary irqsave spinlock?

Zhu Yanjun

> >
> > Zhu Yanjun
> >
> >>
> >>>
> >>>> To sum up once we have rcu enabled the only required change is to use GFP_ATOMIC
> >>>> or find a way to pre-allocate for AH objects (assuming that I can convince myself
> >>>> that ib_create_ah really comes with spinlocks held).
> >>>
> >>> Possibly yes
> >>>
> >>> Jason
> >>
>
