Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1455720677C
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2020 00:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388355AbgFWWrm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 18:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388379AbgFWWr2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jun 2020 18:47:28 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B719C061260
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jun 2020 15:36:30 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id d4so82182otk.2
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jun 2020 15:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xlhH26wg9ZGqvZX4SsItfHEpKhp6TU8NjkKPjZVi7dM=;
        b=cq6eukdP9i43W25in3jOVQL/Rh6YqCJudgz63PRXIcpiyjXdYadDGIVAvDtcZes4/9
         s4CZdktSYgbhNgC72a2mAW4N8hML0A/MmIipg4XJOKr2osYTgZMBnfvyxbXOKjJ4EuTM
         Gy3OAq85wO0Bl0ZpfYaesjQijNuCO2Y808qTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xlhH26wg9ZGqvZX4SsItfHEpKhp6TU8NjkKPjZVi7dM=;
        b=DtJ8sA7x+ru3J1kJ6J765ZjU4Mr6iQYhrDQc0Esrrfq3TtbrimtBE27HjsD6MZgGJ+
         c1jGWSapDutHE74OuyPvhePlq4WsW2TY3DhRQWxW6aqMJp9he7yZRWydmSCAUeeA2yaT
         VlIvAan2KNanTo1dao1AcAKZXoxU083RNfKwtd3/1nPTuj3NhZk5r3YeCHZhEsJZZ22D
         INuYPnn+3Vq4PwJ75Cse8IO0p2O/PerSIroXiLcrP+knCzgOBi4w7O3ha3jPENUZXgc4
         R8LE+eq5SJetp/mkAO9Waw0yjvYn//Bo7Uj4FuTPOSMUCLE3T/N13MLlco8oQBte4nRZ
         n5sg==
X-Gm-Message-State: AOAM530QpdhhuUni8s4qg8azA3n27L8Zue/ZNpwWci4k/A9jtMDeqCtU
        40wAjIksfajmpAzmzAEyvDfVpm163kmcmSLiEWDKOw==
X-Google-Smtp-Source: ABdhPJynJByw3qjza9aSaCWuruLjjJaTz6a/edqsdeAh4jWVsWvD+/9TBgrYezsnqUfbPYFHEHBWcHoh1sEG/Na3q0M=
X-Received: by 2002:a05:6830:2017:: with SMTP id e23mr13025528otp.303.1592951789516;
 Tue, 23 Jun 2020 15:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200604081224.863494-2-daniel.vetter@ffwll.ch>
 <20200610194101.1668038-1-daniel.vetter@ffwll.ch> <20200621174205.GB1398@lca.pw>
 <20200623223134.GC2005@dread.disaster.area>
In-Reply-To: <20200623223134.GC2005@dread.disaster.area>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 24 Jun 2020 00:36:18 +0200
Message-ID: <CAKMK7uGMJPf8p8sa=9N1hibqSTnXn3SfMzWy3+VC-pwkZENfpA@mail.gmail.com>
Subject: Re: [PATCH] mm: Track mmu notifiers in fs_reclaim_acquire/release
To:     Dave Chinner <david@fromorbit.com>
Cc:     Qian Cai <cai@lca.pw>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 24, 2020 at 12:31 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Sun, Jun 21, 2020 at 01:42:05PM -0400, Qian Cai wrote:
> > On Wed, Jun 10, 2020 at 09:41:01PM +0200, Daniel Vetter wrote:
> > > fs_reclaim_acquire/release nicely catch recursion issues when
> > > allocating GFP_KERNEL memory against shrinkers (which gpu drivers ten=
d
> > > to use to keep the excessive caches in check). For mmu notifier
> > > recursions we do have lockdep annotations since 23b68395c7c7
> > > ("mm/mmu_notifiers: add a lockdep map for invalidate_range_start/end"=
).
> > >
> > > But these only fire if a path actually results in some pte
> > > invalidation - for most small allocations that's very rarely the case=
.
> > > The other trouble is that pte invalidation can happen any time when
> > > __GFP_RECLAIM is set. Which means only really GFP_ATOMIC is a safe
> > > choice, GFP_NOIO isn't good enough to avoid potential mmu notifier
> > > recursion.
> > >
> > > I was pondering whether we should just do the general annotation, but
> > > there's always the risk for false positives. Plus I'm assuming that
> > > the core fs and io code is a lot better reviewed and tested than
> > > random mmu notifier code in drivers. Hence why I decide to only
> > > annotate for that specific case.
> > >
> > > Furthermore even if we'd create a lockdep map for direct reclaim, we'=
d
> > > still need to explicit pull in the mmu notifier map - there's a lot
> > > more places that do pte invalidation than just direct reclaim, these
> > > two contexts arent the same.
> > >
> > > Note that the mmu notifiers needing their own independent lockdep map
> > > is also the reason we can't hold them from fs_reclaim_acquire to
> > > fs_reclaim_release - it would nest with the acquistion in the pte
> > > invalidation code, causing a lockdep splat. And we can't remove the
> > > annotations from pte invalidation and all the other places since
> > > they're called from many other places than page reclaim. Hence we can
> > > only do the equivalent of might_lock, but on the raw lockdep map.
> > >
> > > With this we can also remove the lockdep priming added in 66204f1d2d1=
b
> > > ("mm/mmu_notifiers: prime lockdep") since the new annotations are
> > > strictly more powerful.
> > >
> > > v2: Review from Thomas Hellstrom:
> > > - unbotch the fs_reclaim context check, I accidentally inverted it,
> > >   but it didn't blow up because I inverted it immediately
> > > - fix compiling for !CONFIG_MMU_NOTIFIER
> > >
> > > Cc: Thomas Hellstr=C3=B6m (Intel) <thomas_os@shipmail.org>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > > Cc: linux-mm@kvack.org
> > > Cc: linux-rdma@vger.kernel.org
> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> >
> > Replying the right patch here...
> >
> > Reverting this commit [1] fixed the lockdep warning below while applyin=
g
> > some memory pressure.
> >
> > [1] linux-next cbf7c9d86d75 ("mm: track mmu notifiers in fs_reclaim_acq=
uire/release")
> >
> > [  190.455003][  T369] WARNING: possible circular locking dependency de=
tected
> > [  190.487291][  T369] 5.8.0-rc1-next-20200621 #1 Not tainted
> > [  190.512363][  T369] ------------------------------------------------=
------
> > [  190.543354][  T369] kswapd3/369 is trying to acquire lock:
> > [  190.568523][  T369] ffff889fcf694528 (&xfs_nondir_ilock_class){++++}=
-{3:3}, at: xfs_reclaim_inode+0xdf/0x860
> > spin_lock at include/linux/spinlock.h:353
> > (inlined by) xfs_iflags_test_and_set at fs/xfs/xfs_inode.h:166
> > (inlined by) xfs_iflock_nowait at fs/xfs/xfs_inode.h:249
> > (inlined by) xfs_reclaim_inode at fs/xfs/xfs_icache.c:1127
> > [  190.614359][  T369]
> > [  190.614359][  T369] but task is already holding lock:
> > [  190.647763][  T369] ffffffffb50ced00 (fs_reclaim){+.+.}-{0:0}, at: _=
_fs_reclaim_acquire+0x0/0x30
> > __fs_reclaim_acquire at mm/page_alloc.c:4200
> > [  190.687845][  T369]
> > [  190.687845][  T369] which lock already depends on the new lock.
> > [  190.687845][  T369]
> > [  190.734890][  T369]
> > [  190.734890][  T369] the existing dependency chain (in reverse order)=
 is:
> > [  190.775991][  T369]
> > [  190.775991][  T369] -> #1 (fs_reclaim){+.+.}-{0:0}:
> > [  190.808150][  T369]        fs_reclaim_acquire+0x77/0x80
> > [  190.832152][  T369]        slab_pre_alloc_hook.constprop.52+0x20/0x1=
20
> > slab_pre_alloc_hook at mm/slab.h:507
> > [  190.862173][  T369]        kmem_cache_alloc+0x43/0x2a0
> > [  190.885602][  T369]        kmem_zone_alloc+0x113/0x3ef
> > kmem_zone_alloc at fs/xfs/kmem.c:129
> > [  190.908702][  T369]        xfs_inode_item_init+0x1d/0xa0
> > xfs_inode_item_init at fs/xfs/xfs_inode_item.c:639
> > [  190.934461][  T369]        xfs_trans_ijoin+0x96/0x100
> > xfs_trans_ijoin at fs/xfs/libxfs/xfs_trans_inode.c:34
> > [  190.961530][  T369]        xfs_setattr_nonsize+0x1a6/0xcd0
>
> OK, this patch has royally screwed something up if this path thinks
> it can enter memory reclaim. This path is inside a transaction, so
> it is running under PF_MEMALLOC_NOFS context, so should *never*
> enter memory reclaim.
>
> I'd suggest that whatever mods were made to fs_reclaim_acquire by
> this patch broke it's basic functionality....
>
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 13cc653122b7..7536faaaa0fd 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -57,6 +57,7 @@
> > >  #include <trace/events/oom.h>
> > >  #include <linux/prefetch.h>
> > >  #include <linux/mm_inline.h>
> > > +#include <linux/mmu_notifier.h>
> > >  #include <linux/migrate.h>
> > >  #include <linux/hugetlb.h>
> > >  #include <linux/sched/rt.h>
> > > @@ -4124,7 +4125,7 @@ should_compact_retry(struct alloc_context *ac, =
unsigned int order, int alloc_fla
> > >  static struct lockdep_map __fs_reclaim_map =3D
> > >     STATIC_LOCKDEP_MAP_INIT("fs_reclaim", &__fs_reclaim_map);
> > >
> > > -static bool __need_fs_reclaim(gfp_t gfp_mask)
> > > +static bool __need_reclaim(gfp_t gfp_mask)
> > >  {
> > >     gfp_mask =3D current_gfp_context(gfp_mask);
>
> This is applies the per-task memory allocation context flags to the
> mask that is checked here.
>
> > > @@ -4136,10 +4137,6 @@ static bool __need_fs_reclaim(gfp_t gfp_mask)
> > >     if (current->flags & PF_MEMALLOC)
> > >             return false;
> > >
> > > -   /* We're only interested __GFP_FS allocations for now */
> > > -   if (!(gfp_mask & __GFP_FS))
> > > -           return false;
> > > -
> > >     if (gfp_mask & __GFP_NOLOCKDEP)
> > >             return false;
> > >
> > > @@ -4158,15 +4155,25 @@ void __fs_reclaim_release(void)
> > >
> > >  void fs_reclaim_acquire(gfp_t gfp_mask)
> > >  {
> > > -   if (__need_fs_reclaim(gfp_mask))
> > > -           __fs_reclaim_acquire();
> > > +   if (__need_reclaim(gfp_mask)) {
> > > +           if (gfp_mask & __GFP_FS)
> > > +                   __fs_reclaim_acquire();
>
> .... and they have not been applied in this path. There's your
> breakage.
>
> For future reference, please post anything that changes NOFS
> allocation contexts or behaviours to linux-fsdevel, as filesystem
> developers need to know about proposed changes to infrastructure
> that is critical to the correct functioning of filesystems...

Uh crap I totally missed that. Apologies for wasting everyone's time here.

Andrew, please drop for now, I respin this thing.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
