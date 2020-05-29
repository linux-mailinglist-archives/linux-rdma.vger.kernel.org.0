Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CC91E7594
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2020 07:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgE2FtQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 May 2020 01:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgE2FtP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 May 2020 01:49:15 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BD0C08C5C8
        for <linux-rdma@vger.kernel.org>; Thu, 28 May 2020 22:49:14 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 23so1575124oiq.8
        for <linux-rdma@vger.kernel.org>; Thu, 28 May 2020 22:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GwPTcodFrxyo6ma4eVz3wTAE48j9kX0xKI9NPcHg3+Y=;
        b=g7c8phrQOHUbjmhEiH1WaiZ1ynwv7l8bGG0INitQ4WPavylOnmjSOorKtp00skaFkC
         OznTnDNw77kWfXlyzgGTJy7zf94suVZrOnm3RVNMArQ0jgcN/N11ZPOz4POFpT2QoIIf
         GCXS4yH+9IzvvLeppOxZjpO4kWcwbINiDyDo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GwPTcodFrxyo6ma4eVz3wTAE48j9kX0xKI9NPcHg3+Y=;
        b=eeNNBh9OpT3/mVb06hkUhqaBbjPUgazNzslPHPVO+PbolvMaqOpq3Qb9VPgHm/MwUG
         alwjJ4OwfH6yDaTH/7S9FJ8X/ltCgslOHTcR62XrVPB1sEQb85/2iujAzNU9I5lHVYcb
         TFQx4gsQeHuFPrIYiciDN6lNQ3wJHXt8rKQosyrSAX8U74Nz70enRgRmZUwJp4FzrSlS
         TpMOF1dtjS40uU8+NwhVIiLfp+UJti/Gy9MqWn72BM4WD1dB5oOZx6ibxD+xajAXT6iN
         ICNu8Ce0HM9jZlT3aWc5QUd/jzEiCvAcoekicn0DD44eF9eBOpb845eA/Kye5OAuMTIM
         HMhQ==
X-Gm-Message-State: AOAM531TeXy/W/8ceDjIKQbd487tkcGdqZaBm/HhRMWM7jD0xdqkNdRe
        CKNzXRTXVWpI+BS2RPABQD4esnehFJ0+yMsmp5/WuQ==
X-Google-Smtp-Source: ABdhPJzpgZX/J2XciC692mAlVJg1GyBwp0rDuY4jUgXHZHfgFIx4R9W4uWgMuhUonjr74hDaQmZX+gO4Vj23YZD/mGg=
X-Received: by 2002:a05:6808:282:: with SMTP id z2mr4257884oic.101.1590731353651;
 Thu, 28 May 2020 22:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
 <20200512085944.222637-3-daniel.vetter@ffwll.ch> <190e5572-fc29-612d-87e0-a4f0151abcc6@amd.com>
In-Reply-To: <190e5572-fc29-612d-87e0-a4f0151abcc6@amd.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 29 May 2020 07:49:02 +0200
Message-ID: <CAKMK7uH7WM_FMHkn4+yBhDCqLRg2Hak6YXup1twRwky_5TmiGw@mail.gmail.com>
Subject: Re: [RFC 02/17] dma-fence: basic lockdep annotations
To:     Luben Tuikov <luben.tuikov@amd.com>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 28, 2020 at 11:54 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> On 2020-05-12 4:59 a.m., Daniel Vetter wrote:
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
> >       mutex_lock(A);
> >       mutex_unlock(A);
> >
> >       dma_fence_signal();
> >
> > Thread B:
> >
> >       mutex_lock(A);
> >       dma_fence_wait();
> >       mutex_unlock(A);
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
> > +struct lockdep_map   dma_fence_lockdep_map =3D {
> > +     .name =3D "dma_fence_map"
> > +};
> > +
> > +bool dma_fence_begin_signalling(void)
> > +{
> > +     /* explicitly nesting ... */
> > +     if (lock_is_held_type(&dma_fence_lockdep_map, 1))
> > +             return true;
> > +
> > +     /* rely on might_sleep check for soft/hardirq locks */
> > +     if (in_atomic())
> > +             return true;
> > +
> > +     /* ... and non-recursive readlock */
> > +     lock_acquire(&dma_fence_lockdep_map, 0, 0, 1, 1, NULL, _RET_IP_);
> > +
> > +     return false;
> > +}
> > +EXPORT_SYMBOL(dma_fence_begin_signalling);
>
> Hi Daniel,
>
> This is great work and could help a lot.
>
> If you invert the result of dma_fence_begin_signalling()
> then it would naturally mean "locked", i.e. whether we need to
> later release "dma_fence_lockedep_map". Then,
> in dma_fence_end_signalling(), you can call the "cookie"
> argument "locked" and simply do:
>
> void dma_fence_end_signalling(bool locked)
> {
>         if (locked)
>                 lock_release(&dma_fence_lockdep_map, _RET_IP_);
> }
> EXPORT_SYMBOL(dma_fence_end_signalling);
>
> It'll be more natural to understand as well.

It's intentionally called cookie so callers don't start doing funny
stuff with it. The thing is, after begin_signalling you are _always_
in the locked state. It's just that because of limitations with
lockdep we need to play a few tricks, and in some cases we do not take
the lockdep map. There's 2 cases:
- lockdep map already taken - we want recursive readlock semantics for
this, but lockdep does not correctly check recursive read locks. Hence
we only use readlock, and make sure we do not actually nest upon
ourselves with this explicit check.
- when we're in atomic sections - lockdep gets pissed at us if we take
the read lock in hard/softirq sections because of hard/softirq ctx
mismatch (lockdep thinks it's a real lock, but we don't treat it as
one). Simplest fix was to rely on the might_sleep check in patch 1
(already merged)

The commit message mentions this already a bit, but I'll try to
explain this implementation detail tersely in the kerneldoc too in the
next round.

Thanks, Daniel

>
> Regards,
> Luben
>
> > +
> > +void dma_fence_end_signalling(bool cookie)
> > +{
> > +     if (cookie)
> > +             return;
> > +
> > +     lock_release(&dma_fence_lockdep_map, _RET_IP_);
> > +}
> > +EXPORT_SYMBOL(dma_fence_end_signalling);
> > +
> > +void __dma_fence_might_wait(void)
> > +{
> > +     bool tmp;
> > +
> > +     tmp =3D lock_is_held_type(&dma_fence_lockdep_map, 1);
> > +     if (tmp)
> > +             lock_release(&dma_fence_lockdep_map, _THIS_IP_);
> > +     lock_map_acquire(&dma_fence_lockdep_map);
> > +     lock_map_release(&dma_fence_lockdep_map);
> > +     if (tmp)
> > +             lock_acquire(&dma_fence_lockdep_map, 0, 0, 1, 1, NULL, _T=
HIS_IP_);
> > +}
> > +#endif
> > +
> > +
> >  /**
> >   * dma_fence_signal_locked - signal completion of a fence
> >   * @fence: the fence to signal
> > @@ -170,14 +216,19 @@ int dma_fence_signal(struct dma_fence *fence)
> >  {
> >       unsigned long flags;
> >       int ret;
> > +     bool tmp;
> >
> >       if (!fence)
> >               return -EINVAL;
> >
> > +     tmp =3D dma_fence_begin_signalling();
> > +
> >       spin_lock_irqsave(fence->lock, flags);
> >       ret =3D dma_fence_signal_locked(fence);
> >       spin_unlock_irqrestore(fence->lock, flags);
> >
> > +     dma_fence_end_signalling(tmp);
> > +
> >       return ret;
> >  }
> >  EXPORT_SYMBOL(dma_fence_signal);
> > @@ -211,6 +262,8 @@ dma_fence_wait_timeout(struct dma_fence *fence, boo=
l intr, signed long timeout)
> >       if (timeout > 0)
> >               might_sleep();
> >
> > +     __dma_fence_might_wait();
> > +
> >       trace_dma_fence_wait_start(fence);
> >       if (fence->ops->wait)
> >               ret =3D fence->ops->wait(fence, intr, timeout);
> > diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> > index 3347c54f3a87..3f288f7db2ef 100644
> > --- a/include/linux/dma-fence.h
> > +++ b/include/linux/dma-fence.h
> > @@ -357,6 +357,18 @@ dma_fence_get_rcu_safe(struct dma_fence __rcu **fe=
ncep)
> >       } while (1);
> >  }
> >
> > +#ifdef CONFIG_LOCKDEP
> > +bool dma_fence_begin_signalling(void);
> > +void dma_fence_end_signalling(bool cookie);
> > +#else
> > +static inline bool dma_fence_begin_signalling(void)
> > +{
> > +     return true;
> > +}
> > +static inline void dma_fence_end_signalling(bool cookie) {}
> > +static inline void __dma_fence_might_wait(void) {}
> > +#endif
> > +
> >  int dma_fence_signal(struct dma_fence *fence);
> >  int dma_fence_signal_locked(struct dma_fence *fence);
> >  signed long dma_fence_default_wait(struct dma_fence *fence,
> >
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
