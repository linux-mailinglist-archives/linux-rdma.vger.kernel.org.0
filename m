Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364751F54B6
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2020 14:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgFJM0O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jun 2020 08:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729132AbgFJM0M (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Jun 2020 08:26:12 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82286C03E96F
        for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2020 05:26:11 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id j189so1829596oih.10
        for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2020 05:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yzNpoBVUIzGM0jWy4CzYzFZyv4ZMyRLgTHGzYAF0h/4=;
        b=Udr1IYqvi6qIHAbHY4mma1jfM4+F8fyym+UpFudEP3iOPClfc79jh7mYuxD9geSyBW
         wqF0X2roOIO7E1PuOFkp9HcvutoataC22Lucpcih42JnSXmiJ0UJvcRJhs8u1RxWzaGF
         hNLrk0c4XJr4c/c699xf6oxhxTfydvg3VIfss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yzNpoBVUIzGM0jWy4CzYzFZyv4ZMyRLgTHGzYAF0h/4=;
        b=RXBPW20Es2KIiI75N9LXGBKFGyMpY/1JThTzdLf04Ckzs3T/dJTB5TGxoxzjVlJxbY
         U1tJzsuGXBn4h36odu1xqCLXp0Ev7zpyFfkpgauwP2z8+mwO52XPLb7Ychsy0sbuVasF
         I6sXS5JsSzp44160v9yuMgmYFHVHVj3/kQw8VXvCpa7WUlnOKtZKYRMs/rpgEs+6he19
         1VeogJh31H+sdrxDEcU3Pt70MabseHrb7oQzG257SOX8iuX2bI7Lc5n5mHfkQjaILpHb
         f7UApLm5mgb9bmU3fUC5o5EK8XBZyHPaQdmiavSieFsY0bTtGOq+aQTGc8dRYBS5tWjj
         0SvA==
X-Gm-Message-State: AOAM533u5fRQBu5N/zm9YVKpABWsn84GTEc2tJhl41QWIZOV2+tFBN3J
        oYKkt0Hbe0fQ9TmEUk6hfhUFfLRkLBaJWzn17433lQ==
X-Google-Smtp-Source: ABdhPJy7HqpB75fD6Jg4sB9zMPwjBriAsngvkdaN1meJQNljLuj1e/WyfJpcpBT3SMXWs6iH6T+oCNJGmM4lYUXZKX4=
X-Received: by 2002:aca:4b91:: with SMTP id y139mr2202871oia.128.1591791970590;
 Wed, 10 Jun 2020 05:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-2-daniel.vetter@ffwll.ch> <15bcdddd-b560-e98b-eaec-62277b5ab4af@shipmail.org>
In-Reply-To: <15bcdddd-b560-e98b-eaec-62277b5ab4af@shipmail.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 10 Jun 2020 14:25:59 +0200
Message-ID: <CAKMK7uGF_ghH-3hT5QMKHuzToP50xj3OaDzAtdjO-d8H9svdjQ@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH 01/18] mm: Track mmu notifiers in fs_reclaim_acquire/release
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 10, 2020 at 2:01 PM Thomas Hellstr=C3=B6m (Intel)
<thomas_os@shipmail.org> wrote:
>
> Hi, Daniel,
>
> Please see below.
>
> On 6/4/20 10:12 AM, Daniel Vetter wrote:
> > fs_reclaim_acquire/release nicely catch recursion issues when
> > allocating GFP_KERNEL memory against shrinkers (which gpu drivers tend
> > to use to keep the excessive caches in check). For mmu notifier
> > recursions we do have lockdep annotations since 23b68395c7c7
> > ("mm/mmu_notifiers: add a lockdep map for invalidate_range_start/end").
> >
> > But these only fire if a path actually results in some pte
> > invalidation - for most small allocations that's very rarely the case.
> > The other trouble is that pte invalidation can happen any time when
> > __GFP_RECLAIM is set. Which means only really GFP_ATOMIC is a safe
> > choice, GFP_NOIO isn't good enough to avoid potential mmu notifier
> > recursion.
> >
> > I was pondering whether we should just do the general annotation, but
> > there's always the risk for false positives. Plus I'm assuming that
> > the core fs and io code is a lot better reviewed and tested than
> > random mmu notifier code in drivers. Hence why I decide to only
> > annotate for that specific case.
> >
> > Furthermore even if we'd create a lockdep map for direct reclaim, we'd
> > still need to explicit pull in the mmu notifier map - there's a lot
> > more places that do pte invalidation than just direct reclaim, these
> > two contexts arent the same.
> >
> > Note that the mmu notifiers needing their own independent lockdep map
> > is also the reason we can't hold them from fs_reclaim_acquire to
> > fs_reclaim_release - it would nest with the acquistion in the pte
> > invalidation code, causing a lockdep splat. And we can't remove the
> > annotations from pte invalidation and all the other places since
> > they're called from many other places than page reclaim. Hence we can
> > only do the equivalent of might_lock, but on the raw lockdep map.
> >
> > With this we can also remove the lockdep priming added in 66204f1d2d1b
> > ("mm/mmu_notifiers: prime lockdep") since the new annotations are
> > strictly more powerful.
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > Cc: linux-mm@kvack.org
> > Cc: linux-rdma@vger.kernel.org
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > ---
> > This is part of a gpu lockdep annotation series simply because it
> > really helps to catch issues where gpu subsystem locks and primitives
> > can deadlock with themselves through allocations and mmu notifiers.
> > But aside from that motivation it should be completely free-standing,
> > and can land through -mm/-rdma/-hmm or any other tree really whenever.
> > -Daniel
> > ---
> >   mm/mmu_notifier.c |  7 -------
> >   mm/page_alloc.c   | 23 ++++++++++++++---------
> >   2 files changed, 14 insertions(+), 16 deletions(-)
> >
> > diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> > index 06852b896fa6..5d578b9122f8 100644
> > --- a/mm/mmu_notifier.c
> > +++ b/mm/mmu_notifier.c
> > @@ -612,13 +612,6 @@ int __mmu_notifier_register(struct mmu_notifier *s=
ubscription,
> >       lockdep_assert_held_write(&mm->mmap_sem);
> >       BUG_ON(atomic_read(&mm->mm_users) <=3D 0);
> >
> > -     if (IS_ENABLED(CONFIG_LOCKDEP)) {
> > -             fs_reclaim_acquire(GFP_KERNEL);
> > -             lock_map_acquire(&__mmu_notifier_invalidate_range_start_m=
ap);
> > -             lock_map_release(&__mmu_notifier_invalidate_range_start_m=
ap);
> > -             fs_reclaim_release(GFP_KERNEL);
> > -     }
> > -
> >       if (!mm->notifier_subscriptions) {
> >               /*
> >                * kmalloc cannot be called under mm_take_all_locks(), bu=
t we
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 13cc653122b7..f8a222db4a53 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -57,6 +57,7 @@
> >   #include <trace/events/oom.h>
> >   #include <linux/prefetch.h>
> >   #include <linux/mm_inline.h>
> > +#include <linux/mmu_notifier.h>
> >   #include <linux/migrate.h>
> >   #include <linux/hugetlb.h>
> >   #include <linux/sched/rt.h>
> > @@ -4124,7 +4125,7 @@ should_compact_retry(struct alloc_context *ac, un=
signed int order, int alloc_fla
> >   static struct lockdep_map __fs_reclaim_map =3D
> >       STATIC_LOCKDEP_MAP_INIT("fs_reclaim", &__fs_reclaim_map);
> >
> > -static bool __need_fs_reclaim(gfp_t gfp_mask)
> > +static bool __need_reclaim(gfp_t gfp_mask)
> >   {
> >       gfp_mask =3D current_gfp_context(gfp_mask);
> >
> > @@ -4136,10 +4137,6 @@ static bool __need_fs_reclaim(gfp_t gfp_mask)
> >       if (current->flags & PF_MEMALLOC)
> >               return false;
> >
> > -     /* We're only interested __GFP_FS allocations for now */
> > -     if (!(gfp_mask & __GFP_FS))
> > -             return false;
> > -
> >       if (gfp_mask & __GFP_NOLOCKDEP)
> >               return false;
> >
> > @@ -4158,15 +4155,23 @@ void __fs_reclaim_release(void)
> >
> >   void fs_reclaim_acquire(gfp_t gfp_mask)
> >   {
> > -     if (__need_fs_reclaim(gfp_mask))
> > -             __fs_reclaim_acquire();
> > +     if (__need_reclaim(gfp_mask)) {
> > +             if (!(gfp_mask & __GFP_FS))
> Hmm. Shouldn't this be "if (gfp_mask & __GFP_FS)" or am I misunderstandin=
g?

Uh yes :-( I guess what saved me is that I immediately went for the
lockdep splat in drivers/gpu. And I guess there's not any obvious
inversions for GFP_NOFS/GFP_NOIO, and since I made the mistake
consintely the GFP_FS annotation was still consistent, but simply for
GFP_NOFS. Oops.

Will fix in the next version.

> > +                     __fs_reclaim_acquire();
>
>
> #ifdef CONFIG_MMU_NOTIFIER?

Hm indeed. Will fix too.

Thanks for your review.

>
> > +
> > +             lock_map_acquire(&__mmu_notifier_invalidate_range_start_m=
ap);
> > +             lock_map_release(&__mmu_notifier_invalidate_range_start_m=
ap);
> > +
> > +     }
> >   }
> >   EXPORT_SYMBOL_GPL(fs_reclaim_acquire);
> >
> >   void fs_reclaim_release(gfp_t gfp_mask)
> >   {
> > -     if (__need_fs_reclaim(gfp_mask))
> > -             __fs_reclaim_release();
> > +     if (__need_reclaim(gfp_mask)) {
> > +             if (!(gfp_mask & __GFP_FS))
> Same here?
> > +                     __fs_reclaim_release();
> > +     }
> >   }
> >   EXPORT_SYMBOL_GPL(fs_reclaim_release);
> >   #endif
>
> One suggested test case would perhaps be to call madvise(madv_dontneed)
> on a subpart of a transhuge page. That would IIRC trigger a page split
> and interesting mmu notifier calls....

The neat thing about the mmu notifier lockdep key is that we take it
whether there's notifiers or not - it's called outside of any of these
paths. So as long as you have ever hit a hugepage split somewhen since
boot, and you've hit your driver's mmu_notifier paths, lockdep will
connect the dots. Explicit testcases for all combinations not needed
anymore. This patch here just makes sure that the same holds for
memory allocations and direct reclaim (which is a lot harder to
trigger intentionally in testcases).

That was at least the idea, seems to have caught a few things already.
-Daniel

>
> Thanks,
> Thomas
>
>
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
