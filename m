Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18EC1D0ADF
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 10:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbgEMIab (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 04:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732174AbgEMIab (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 May 2020 04:30:31 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C375C061A0C
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 01:30:31 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id c83so3286277oob.6
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 01:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P/cQOw5xN+TfOYRkXBpG74KgaYsRxjssQU8OCSQs0lw=;
        b=ZYqNT7S96JIC/2QUMWjtKF68s7Mlj31GoqTmd/vNnuROLIyB0kD9KQbJGZzvzwvUbA
         E3luqZwNVfQvG5bGKUij9LW4w7tisfb2ZjPEK2MdxiXprewxdAOya4VpMVU2y0meest4
         Fp2TkQzADhnoZpBxsZgu12qAiKzzJR0VP+umY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P/cQOw5xN+TfOYRkXBpG74KgaYsRxjssQU8OCSQs0lw=;
        b=GkIFFQYWLFjSjsDrKQiAHizpSWHhsyGtCajyQxV3V9oArfvBw/oCI0v+tYIfaydIOX
         4E1HyKlH3Z81V9Z33SWNpOPzl/8RMB1OYPcN4JQe7J1SPLjazVsQiNtuAQ7E2shrpMFk
         8GcinYyiZQzmtRkLU3mU8qPWcdwCgpRoaualY0Qsv5UYBSO6nvBd6SOhPDW96LTMAtcr
         pOOqmBVBUT812uNk3C31yfFogbUI42GpI0ZV9CkwydJjK/ta/0jVz0Bv71lpiX73/soV
         ViqKGdxVP9KG2G87kII5rkHu/qwC7otRB2hp8OBJv68M7E08x4tbcGP/QAhhB+sFe3Xq
         iv1A==
X-Gm-Message-State: AGi0PuYw80j0cQ0SSOVdHVtsWz8jRC87OfwBrJEgWTEzDlGG5zlcaCgg
        tBXQuyeR2uMuC2XIGy+5H6mZs6rksIL9VhW2zfeo9Q==
X-Google-Smtp-Source: APiQypK721eLmXQ6tEOq0sY7098uVZ1/1lnGE6R9IvcYdjA6Ym65merSRHvKBROuVGmkJOSrpR7fmIYoiLovJ+FPnQA=
X-Received: by 2002:a4a:d136:: with SMTP id n22mr21115688oor.85.1589358630346;
 Wed, 13 May 2020 01:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
 <20200512085944.222637-3-daniel.vetter@ffwll.ch> <158927426244.15653.14406159524439944950@build.alporthouse.com>
 <20200512090847.GF206103@phenom.ffwll.local> <158927519651.15653.17392305363363808831@build.alporthouse.com>
In-Reply-To: <158927519651.15653.17392305363363808831@build.alporthouse.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 13 May 2020 10:30:19 +0200
Message-ID: <CAKMK7uGnFhbpuurRsnZ4dvRV9gQ_3-rmSJaoqSFY=+Kvepz_CA@mail.gmail.com>
Subject: Re: [RFC 02/17] dma-fence: basic lockdep annotations
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 12, 2020 at 11:19 AM Chris Wilson <chris@chris-wilson.co.uk> wr=
ote:
> Quoting Daniel Vetter (2020-05-12 10:08:47)
> > On Tue, May 12, 2020 at 10:04:22AM +0100, Chris Wilson wrote:
> > > Quoting Daniel Vetter (2020-05-12 09:59:29)
> > > > Design is similar to the lockdep annotations for workers, but with
> > > > some twists:
> > > >
> > > > - We use a read-lock for the execution/worker/completion side, so t=
hat
> > > >   this explicit annotation can be more liberally sprinkled around.
> > > >   With read locks lockdep isn't going to complain if the read-side
> > > >   isn't nested the same way under all circumstances, so ABBA deadlo=
cks
> > > >   are ok. Which they are, since this is an annotation only.
> > > >
> > > > - We're using non-recursive lockdep read lock mode, since in recurs=
ive
> > > >   read lock mode lockdep does not catch read side hazards. And we
> > > >   _very_ much want read side hazards to be caught. For full details=
 of
> > > >   this limitation see
> > > >
> > > >   commit e91498589746065e3ae95d9a00b068e525eec34f
> > > >   Author: Peter Zijlstra <peterz@infradead.org>
> > > >   Date:   Wed Aug 23 13:13:11 2017 +0200
> > > >
> > > >       locking/lockdep/selftests: Add mixed read-write ABBA tests
> > > >
> > > > - To allow nesting of the read-side explicit annotations we explici=
tly
> > > >   keep track of the nesting. lock_is_held() allows us to do that.
> > > >
> > > > - The wait-side annotation is a write lock, and entirely done withi=
n
> > > >   dma_fence_wait() for everyone by default.
> > > >
> > > > - To be able to freely annotate helper functions I want to make it =
ok
> > > >   to call dma_fence_begin/end_signalling from soft/hardirq context.
> > > >   First attempt was using the hardirq locking context for the write
> > > >   side in lockdep, but this forces all normal spinlocks nested with=
in
> > > >   dma_fence_begin/end_signalling to be spinlocks. That bollocks.
> > > >
> > > >   The approach now is to simple check in_atomic(), and for these ca=
ses
> > > >   entirely rely on the might_sleep() check in dma_fence_wait(). Tha=
t
> > > >   will catch any wrong nesting against spinlocks from soft/hardirq
> > > >   contexts.
> > > >
> > > > The idea here is that every code path that's critical for eventuall=
y
> > > > signalling a dma_fence should be annotated with
> > > > dma_fence_begin/end_signalling. The annotation ideally starts right
> > > > after a dma_fence is published (added to a dma_resv, exposed as a
> > > > sync_file fd, attached to a drm_syncobj fd, or anything else that
> > > > makes the dma_fence visible to other kernel threads), up to and
> > > > including the dma_fence_wait(). Examples are irq handlers, the
> > > > scheduler rt threads, the tail of execbuf (after the corresponding
> > > > fences are visible), any workers that end up signalling dma_fences =
and
> > > > really anything else. Not annotated should be code paths that only
> > > > complete fences opportunistically as the gpu progresses, like e.g.
> > > > shrinker/eviction code.
> > > >
> > > > The main class of deadlocks this is supposed to catch are:
> > > >
> > > > Thread A:
> > > >
> > > >         mutex_lock(A);
> > > >         mutex_unlock(A);
> > > >
> > > >         dma_fence_signal();
> > > >
> > > > Thread B:
> > > >
> > > >         mutex_lock(A);
> > > >         dma_fence_wait();
> > > >         mutex_unlock(A);
> > > >
> > > > Thread B is blocked on A signalling the fence, but A never gets aro=
und
> > > > to that because it cannot acquire the lock A.
> > > >
> > > > Note that dma_fence_wait() is allowed to be nested within
> > > > dma_fence_begin/end_signalling sections. To allow this to happen th=
e
> > > > read lock needs to be upgraded to a write lock, which means that an=
y
> > > > other lock is acquired between the dma_fence_begin_signalling() cal=
l and
> > > > the call to dma_fence_wait(), and still held, this will result in a=
n
> > > > immediate lockdep complaint. The only other option would be to not
> > > > annotate such calls, defeating the point. Therefore these annotatio=
ns
> > > > cannot be sprinkled over the code entirely mindless to avoid false
> > > > positives.
> > > >
> > > > v2: handle soft/hardirq ctx better against write side and dont forg=
et
> > > > EXPORT_SYMBOL, drivers can't use this otherwise.
> > > >
> > > > Cc: linux-media@vger.kernel.org
> > > > Cc: linaro-mm-sig@lists.linaro.org
> > > > Cc: linux-rdma@vger.kernel.org
> > > > Cc: amd-gfx@lists.freedesktop.org
> > > > Cc: intel-gfx@lists.freedesktop.org
> > > > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > > > ---
> > > >  drivers/dma-buf/dma-fence.c | 53 +++++++++++++++++++++++++++++++++=
++++
> > > >  include/linux/dma-fence.h   | 12 +++++++++
> > > >  2 files changed, 65 insertions(+)
> > > >
> > > > diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fenc=
e.c
> > > > index 6802125349fb..d5c0fd2efc70 100644
> > > > --- a/drivers/dma-buf/dma-fence.c
> > > > +++ b/drivers/dma-buf/dma-fence.c
> > > > @@ -110,6 +110,52 @@ u64 dma_fence_context_alloc(unsigned num)
> > > >  }
> > > >  EXPORT_SYMBOL(dma_fence_context_alloc);
> > > >
> > > > +#ifdef CONFIG_LOCKDEP
> > > > +struct lockdep_map     dma_fence_lockdep_map =3D {
> > > > +       .name =3D "dma_fence_map"
> > > > +};
> > >
> > > Not another false global sharing lockmap.
> >
> > It's a global contract, it needs a global lockdep map. And yes a big
> > reason for the motivation here is that i915-gem has a tremendous urge t=
o
> > just redefine all these global locks to fit to some local interpretatio=
n
> > of what's going on.
>
> No, you can build the global contract out of the actual contracts
> between fence drivers. If you introduce a struct lockdep_map *map into
> the fence_ops (so the fence_ops can remain const), you gain correctness
> at the cost of having to run through all possible interactions once.
> You can also then do if ops->lockmap ?: &global_fence_lockmap for
> piecemeal conversion of drivers that do not already use lockmaps for
> contract enforcement of their fence waits.

I'm not quite sure whether you're actually proposing to have locking
contracts per drivers, since that seems rather out of ... I dunno. But
if that's what you want, that just doesn't make any sense at all:

- Locking is rather core to kernel programming, aside from a few other
things like hard/softirq/preempt/... disabled sections and how
recursion works for these, or where and what you're allowed to
allocate memory. Lockdep, might_sleep and a bunch of other such debug
checks help us enforce that. If you instead go with every driver does
what they please yolo, then you don't have an abstraction, all you
have is smashing a rose and rose and Rose into one thing because they
have the same 4 letter name. It's just an interface that can be used
only when understanding every single implementation in detail - really
not something that's an abstraction. Yes I've seen some of these
dubious abstractions in i915, merged fairly recently, that doesn't
make them a good idea.

- You need to test the full NxN matrix (yes you need to test the
driver against itself in this world, since testing against something
fake like vgem doesn't cut it). That's nuts. Strike that, that's
impossible.

- Review is impossible, because the documentation can be summed up as
"yolo". Without clear rules all review can do is check every code
against every other piece of code, on every change. That's impossible,
because we humans are mere mortals, and we're left with push&pray
engineering, which really isn't.

The other issue with this approach is that it's full on platform
problem in extremis. Instead of extending the shared abstraction or
adding new useful functionality, i915-gem has resorted to reinpreting
rules to fix local problems. That leads to stuff like roughly

if (mutex_lock_timeout(HZ*10) =3D=3D -ETIME) {
    /* I guess we deadlocked, try to bail out */
}

except it's for fences. That's neither solid engineering - we don't
generally let the kernel deadlock on itself to test whether maybe it
was a deadlock or not, nor is this solid upstreaming in a open source
project - we fix the problems where they are, not work around them
just in our own driver.
-Daniel
--
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
