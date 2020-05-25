Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6886B1E11EC
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 17:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404190AbgEYPl2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 11:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404176AbgEYPl1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 May 2020 11:41:27 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17272C05BD43
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 08:41:27 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id a68so14059413otb.10
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 08:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zYUPEElB6SHPIaR83Q3Yt5fFzV13Ip0LESvRbzBJyIQ=;
        b=bL7fka2OmqIPNvU4eqRQTo9buZO/2uzYTO/WEQHUiFIlOHj0ScnlII8JKkIfpEOBUP
         ANZ2qitDJNYbm86W6AucL7Tke1jYd5bmNQevH3Lf6sYo3RUgU/CsBFv8BF7chkhP9uZX
         wwlfFu/ZBNk0/2rhifTsTwP+VzFdxa6x3y7H0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zYUPEElB6SHPIaR83Q3Yt5fFzV13Ip0LESvRbzBJyIQ=;
        b=O+72wfhJa0DV7VXm757YlhFOYk+sxArpEWjZmXkaZ05J34iDaswyvrjLu2Y6Wr+Bjy
         lY3EwfKA11xNhAqj5rOx/7EKLG4WK3pHE1s32lOD1IWRT3uPZjT7q2WI4nHqydCYXWMQ
         ln5i7gfoq6H1bv0PkDLSE/wz9LelnqYIIsJ3TiG4P0oDWC0/YskDkcFnwnL3IHmOZVtN
         Jqj09gjfERosIziNdN2C/gmliYOvcfuoCGmB3ot1vl/UY44TQnVgVht98RAdo86ZvrOZ
         OCeKAQ5vOzn3/xftmf65OInSs4f6SC6vcFhkteMjOP3uDJAq3PDQSO01FOWx8Sd/49FE
         9x+g==
X-Gm-Message-State: AOAM531SMZ4qMlHsnLDQhg3tIguYCphN0vySvAe5kW/oRxP2jBW63kVO
        D9Lh/HwUgzNEKpb0cbD+80khopp3nKi172v4XyUZHw==
X-Google-Smtp-Source: ABdhPJxDeg6x5my5LKn+9Ue8mEioUs+sBVpXbgJDwHT0bo6qoMHMxf0oluqUVBmzdrIqQ6r5PPEDajJlyy1R+oTFe/A=
X-Received: by 2002:a9d:768a:: with SMTP id j10mr5100612otl.188.1590421286362;
 Mon, 25 May 2020 08:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
 <20200512085944.222637-3-daniel.vetter@ffwll.ch> <158927426244.15653.14406159524439944950@build.alporthouse.com>
In-Reply-To: <158927426244.15653.14406159524439944950@build.alporthouse.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 25 May 2020 17:41:15 +0200
Message-ID: <CAKMK7uHzH-H_QmVt3zgHF3pBz3y7QLYC_c3znr7gp5ZkRp8Dkg@mail.gmail.com>
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
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 12, 2020 at 11:04 AM Chris Wilson <chris@chris-wilson.co.uk> wr=
ote:
>
> Quoting Daniel Vetter (2020-05-12 09:59:29)
> > Design is similar to the lockdep annotations for workers, but with
> > some twists:
> >
> > - We use a read-lock for the execution/worker/completion side, so that
> >   this explicit annotation can be more liberally sprinkled around.
> >   With read locks lockdep isn't going to complain if the read-side
> >   isn't nested the same way under all circumstances, so ABBA deadlocks
> >   are ok. Which they are, since this is an annotation only.
> >
> > - We're using non-recursive lockdep read lock mode, since in recursive
> >   read lock mode lockdep does not catch read side hazards. And we
> >   _very_ much want read side hazards to be caught. For full details of
> >   this limitation see
> >
> >   commit e91498589746065e3ae95d9a00b068e525eec34f
> >   Author: Peter Zijlstra <peterz@infradead.org>
> >   Date:   Wed Aug 23 13:13:11 2017 +0200
> >
> >       locking/lockdep/selftests: Add mixed read-write ABBA tests
> >
> > - To allow nesting of the read-side explicit annotations we explicitly
> >   keep track of the nesting. lock_is_held() allows us to do that.
> >
> > - The wait-side annotation is a write lock, and entirely done within
> >   dma_fence_wait() for everyone by default.
> >
> > - To be able to freely annotate helper functions I want to make it ok
> >   to call dma_fence_begin/end_signalling from soft/hardirq context.
> >   First attempt was using the hardirq locking context for the write
> >   side in lockdep, but this forces all normal spinlocks nested within
> >   dma_fence_begin/end_signalling to be spinlocks. That bollocks.
> >
> >   The approach now is to simple check in_atomic(), and for these cases
> >   entirely rely on the might_sleep() check in dma_fence_wait(). That
> >   will catch any wrong nesting against spinlocks from soft/hardirq
> >   contexts.
> >
> > The idea here is that every code path that's critical for eventually
> > signalling a dma_fence should be annotated with
> > dma_fence_begin/end_signalling. The annotation ideally starts right
> > after a dma_fence is published (added to a dma_resv, exposed as a
> > sync_file fd, attached to a drm_syncobj fd, or anything else that
> > makes the dma_fence visible to other kernel threads), up to and
> > including the dma_fence_wait(). Examples are irq handlers, the
> > scheduler rt threads, the tail of execbuf (after the corresponding
> > fences are visible), any workers that end up signalling dma_fences and
> > really anything else. Not annotated should be code paths that only
> > complete fences opportunistically as the gpu progresses, like e.g.
> > shrinker/eviction code.
> >
> > The main class of deadlocks this is supposed to catch are:
> >
> > Thread A:
> >
> >         mutex_lock(A);
> >         mutex_unlock(A);
> >
> >         dma_fence_signal();
> >
> > Thread B:
> >
> >         mutex_lock(A);
> >         dma_fence_wait();
> >         mutex_unlock(A);
> >
> > Thread B is blocked on A signalling the fence, but A never gets around
> > to that because it cannot acquire the lock A.
> >
> > Note that dma_fence_wait() is allowed to be nested within
> > dma_fence_begin/end_signalling sections. To allow this to happen the
> > read lock needs to be upgraded to a write lock, which means that any
> > other lock is acquired between the dma_fence_begin_signalling() call an=
d
> > the call to dma_fence_wait(), and still held, this will result in an
> > immediate lockdep complaint. The only other option would be to not
> > annotate such calls, defeating the point. Therefore these annotations
> > cannot be sprinkled over the code entirely mindless to avoid false
> > positives.
> >
> > v2: handle soft/hardirq ctx better against write side and dont forget
> > EXPORT_SYMBOL, drivers can't use this otherwise.
> >
> > Cc: linux-media@vger.kernel.org
> > Cc: linaro-mm-sig@lists.linaro.org
> > Cc: linux-rdma@vger.kernel.org
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: intel-gfx@lists.freedesktop.org
> > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > ---
> >  drivers/dma-buf/dma-fence.c | 53 +++++++++++++++++++++++++++++++++++++
> >  include/linux/dma-fence.h   | 12 +++++++++
> >  2 files changed, 65 insertions(+)
> >
> > diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> > index 6802125349fb..d5c0fd2efc70 100644
> > --- a/drivers/dma-buf/dma-fence.c
> > +++ b/drivers/dma-buf/dma-fence.c
> > @@ -110,6 +110,52 @@ u64 dma_fence_context_alloc(unsigned num)
> >  }
> >  EXPORT_SYMBOL(dma_fence_context_alloc);
> >
> > +#ifdef CONFIG_LOCKDEP
> > +struct lockdep_map     dma_fence_lockdep_map =3D {
> > +       .name =3D "dma_fence_map"
> > +};
>
> Not another false global sharing lockmap.

So in some meetings you also mentioned nesting is going to be a
problem here. I see about three different kinds of nesting here, but
none should be a fundamental problem:

- nesting of fence drivers, specifically the syncobj timeline fences
but there's others around dma_fence->lock. This series is about
blocking deadlocks, it doesn't care about irqsave spinlocks at all. So
all the nesting going on there is entirely unchanged. Validation
against atomic section relies on the might_sleep annotation in the
first patch.

- nesting of callers, for better code composability. The annotations
are recursive, I've tested it with amdgpu, works.

- nesting of timelines, where e.g. you have some scheduler completion
events that drive the scheduler logic, which eventually will also
result in userspace visible fences on some context getting completed.
Works for amdgpu, that's why I annotated the scheduler. Also, not a
problem for two reasons:

1. uapi relevant fences are the relevant fences for the cross-driver
contract. Building something outside of them few fewer constraints
doesn't make sense, that would just mean we make the dma_fence
cross-driver contract less strict (but then for everyone, not just for
one driver, cause that asymmetric doesn't really work)

2. fences entirely hidden in drivers, which driver something
underneath the uapi visible fences (like scheduler or whatever). Those
can be more constraint, but as long as they're driving the public
fences, can't be less constrained. So cross-driver annotations don't
give you any limitations, you still can do your own driver-internal
annotations to track this more strict constraints.

So really not seeing the fence nesting issue here, either it's a
totally different one, or I'm misunderstood something.

I guess the other issue is that there's a ton of code that's broken
all around in various drivers, but that's why the RFC part. I
specifically highlighted that the priming patch needs some serious
discussion, but "nope I don't want a cross driver contract" really
isn't that.

Cheers, Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
