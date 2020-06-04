Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00F71EE127
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2020 11:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgFDJV7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jun 2020 05:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgFDJV7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Jun 2020 05:21:59 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B19DC03E96D
        for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2020 02:21:59 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 25so3556396oiy.13
        for <linux-rdma@vger.kernel.org>; Thu, 04 Jun 2020 02:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/zn3+1eUt7P4zXrLZgWAPDfuqNS1zeHDgm3HDMu7bSk=;
        b=WHiiDTvRE6HEJIiJb2eauqr87pJ39PgtqEptbmXu3oQQ9q5RCSel3Z6Lz5aTqqgoKD
         Py/xd1uYzu/900VWnJvz7yZzc7+IHdTS+U6hyUfhnx1BXRJQr79m9uguSvjOFHPAJhQD
         dtG1M4WYuC8+fyRuRdqZd5CAlVupafWO9GLyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/zn3+1eUt7P4zXrLZgWAPDfuqNS1zeHDgm3HDMu7bSk=;
        b=mwce41tozvAIWQEBRh4SNaxUwpixCY4jYLbjkyqtDblhsz8NXl41i95+bpJMq1qFf9
         kyE1eH5S2ciNQJz/4bHpxqiRmEM6Y2g7b6mX9+ya/r/FhoB4Ce8f4h8Jptrm99kriqtl
         hZPtJTtxEyOdd9sO5HY5eY8bFAyYYnylGue/n2qwG0abalsr/vmQG+TBssfOpdPsDaIG
         nKlhWsMBVJeXuJxv3byyBTASBT2uO/JZFI8Jh5cYn/Qy69jL/Fl2txR113JVHqzNQnas
         cebwakCEaEuXlQonB8YCe2hVBZWdRwNJ1m7IYO2Y+SZpGaCC3kVHRUl/Uq5uYhyJj+yC
         yInA==
X-Gm-Message-State: AOAM531KAHhpiRaTvcA/2TWRbWXI1g5Hva8VRlSPBm/N6A3gHq0DTPIs
        ZtKDb1qsPiqpbHWY1iHZSVGBj8suQ6/qtyQIvaHaUA==
X-Google-Smtp-Source: ABdhPJzRiPeKbR6tHL8bFogQ3rc88/jyyGZ+kX32yJV5dNSssjqSNcxyFlvjYx4PjsaZCPbUAi/hVS/hOX6Fp4wXhCo=
X-Received: by 2002:aca:a811:: with SMTP id r17mr2487418oie.14.1591262518661;
 Thu, 04 Jun 2020 02:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-4-daniel.vetter@ffwll.ch> <edbfc1aa-9297-8202-cef8-1facafaa0dfe@shipmail.org>
In-Reply-To: <edbfc1aa-9297-8202-cef8-1facafaa0dfe@shipmail.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 4 Jun 2020 11:21:46 +0200
Message-ID: <CAKMK7uGLAPvvgHCCZhg0cea3Fz=Zqhf-GKS2OC3mZudYe3mKhw@mail.gmail.com>
Subject: Re: [PATCH 03/18] dma-fence: basic lockdep annotations
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 4, 2020 at 10:57 AM Thomas Hellstr=C3=B6m (Intel)
<thomas_os@shipmail.org> wrote:
>
>
> On 6/4/20 10:12 AM, Daniel Vetter wrote:
> ...
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
>
> Just realized, isn't that example actually a true positive, or at least
> a great candidate for a true positive, since if another thread reenters
> that signaling path, it will block on that mutex, and the fence would
> never be signaled unless there is another signaling path?

Not sure I understand fully, but I think the answer is "it's complicated".

dma_fence are meant to be a DAG (directed acyclic graph). Now it would
be nice to enforce that, and i915 has some attempts to that effect,
but these annotations here don't try to pull off that miracle. I'm
assuming that all the dependencies between dma_fence don't create a
loop, and instead I'm only focusing on deadlocks between dma_fences
and other locks. Usually an async work looks like this:

1. wait for a bunch of dma_fence that we have as dependencies
2. do work (e.g. atomic commit)
3. signal the dma_fence that represents our work

This can happen on the cpu in a kthread or worker, or on the gpu. Now
for reasons you might want to have a per-work mutex or something and
hold that while going through all this, and this is the false positive
I'm thinking off. Of course, if your fences aren't a DAG, or if you're
holding a mutex that's shared with some other work which is part of
your dependency chain, then this goes boom. But it doesn't have to.

I think in general it's best to purely rely on ordering, and remove as
much locking as possible. This is the design behind the atomic modeset
commit code, which is does not take any mutexes in the commit path, at
least not in the helpers. Drivers can still do stuff of course. Then
the only locks you're left with are spinlocks (maybe irq safe ones) to
coordinate with interrupt handlers, workers, handle the wait/wake
queues, manage work/scheduler run queues and all that stuff, and no
spinlocks.

Now for the case where you have something like the below:

thread 1:

dma_fence_begin_signalling()
mutex_lock(a);
dma_fence_wait(b1);
mutex_unlock(a);

dma_fence_signal(b2);
dma_fence_end_signalling();

That's indeed a bit problematic, assuming you're annotating stuff
correctly, and the locking is actually required. I've seen a few of
these, and annotating the properly needs care:

- often the mutex_lock/unlock is not needed, and just gets in the way.
This was the case for the original atomic modeset commit work patches,
which again locked all the modeset locks. But strict ordering of
commit work was all that was needed to make this work, plus making
sure data structure lifetimes are handled correctly too. I think the
tendency to abuse locking to handle lifetime and ordering problems is
fairly common, but it can lead to lots of trouble. Ime all async work
items with the above problematic pattern can be fixed like this.

- other often case is that the dma_fence_begin_signalling() can&should
be pushed down past the mutex_lock, and maybe even past the
dma_fence_wait, depending upon when/how the dma_fence is published.
The fence signalling critical section can still extend past the
mutex_unlock, lockdep and semantics are fine with that (I think at
least). This is more the case for execbuf tails, where you take locks,
set up some async work, publish the fences and then begin to process
these fences (which could just be pushing the work to the job
scheduler, but could also involve running it directly in the userspace
process thread context, but with locks already dropped).

So I wouldn't go out and say these are true positives, just maybe
unecessary locking and over-eager annotations, without any real bugs
in the code.

Or am I completely off the track and you're thinking of something else?

> Although I agree the conclusion is sound: These annotations cannot be
> sprinkled mindlessly over the code.

Yup, that much is for sure.
-Daniel


>
> /Thomas
>
>
>
>
>
>
> >
> > v2: handle soft/hardirq ctx better against write side and dont forget
> > EXPORT_SYMBOL, drivers can't use this otherwise.
> >
> > v3: Kerneldoc.
> >
> > v4: Some spelling fixes from Mika
> >
> > Cc: Mika Kuoppala <mika.kuoppala@intel.com>
> > Cc: Thomas Hellstrom <thomas.hellstrom@intel.com>
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
> >   Documentation/driver-api/dma-buf.rst |  12 +-
> >   drivers/dma-buf/dma-fence.c          | 161 ++++++++++++++++++++++++++=
+
> >   include/linux/dma-fence.h            |  12 ++
> >   3 files changed, 182 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/drive=
r-api/dma-buf.rst
> > index 63dec76d1d8d..05d856131140 100644
> > --- a/Documentation/driver-api/dma-buf.rst
> > +++ b/Documentation/driver-api/dma-buf.rst
> > @@ -100,11 +100,11 @@ CPU Access to DMA Buffer Objects
> >   .. kernel-doc:: drivers/dma-buf/dma-buf.c
> >      :doc: cpu access
> >
> > -Fence Poll Support
> > -~~~~~~~~~~~~~~~~~~
> > +Implicit Fence Poll Support
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> >   .. kernel-doc:: drivers/dma-buf/dma-buf.c
> > -   :doc: fence polling
> > +   :doc: implicit fence polling
> >
> >   Kernel Functions and Structures Reference
> >   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > @@ -133,6 +133,12 @@ DMA Fences
> >   .. kernel-doc:: drivers/dma-buf/dma-fence.c
> >      :doc: DMA fences overview
> >
> > +DMA Fence Signalling Annotations
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +.. kernel-doc:: drivers/dma-buf/dma-fence.c
> > +   :doc: fence signalling annotation
> > +
> >   DMA Fences Functions Reference
> >   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> > index 656e9ac2d028..0005bc002529 100644
> > --- a/drivers/dma-buf/dma-fence.c
> > +++ b/drivers/dma-buf/dma-fence.c
> > @@ -110,6 +110,160 @@ u64 dma_fence_context_alloc(unsigned num)
> >   }
> >   EXPORT_SYMBOL(dma_fence_context_alloc);
> >
> > +/**
> > + * DOC: fence signalling annotation
> > + *
> > + * Proving correctness of all the kernel code around &dma_fence throug=
h code
> > + * review and testing is tricky for a few reasons:
> > + *
> > + * * It is a cross-driver contract, and therefore all drivers must fol=
low the
> > + *   same rules for lock nesting order, calling contexts for various f=
unctions
> > + *   and anything else significant for in-kernel interfaces. But it is=
 also
> > + *   impossible to test all drivers in a single machine, hence brute-f=
orce N vs.
> > + *   N testing of all combinations is impossible. Even just limiting t=
o the
> > + *   possible combinations is infeasible.
> > + *
> > + * * There is an enormous amount of driver code involved. For render d=
rivers
> > + *   there's the tail of command submission, after fences are publishe=
d,
> > + *   scheduler code, interrupt and workers to process job completion,
> > + *   and timeout, gpu reset and gpu hang recovery code. Plus for integ=
ration
> > + *   with core mm with have &mmu_notifier, respectively &mmu_interval_=
notifier,
> > + *   and &shrinker. For modesetting drivers there's the commit tail fu=
nctions
> > + *   between when fences for an atomic modeset are published, and when=
 the
> > + *   corresponding vblank completes, including any interrupt processin=
g and
> > + *   related workers. Auditing all that code, across all drivers, is n=
ot
> > + *   feasible.
> > + *
> > + * * Due to how many other subsystems are involved and the locking hie=
rarchies
> > + *   this pulls in there is extremely thin wiggle-room for driver-spec=
ific
> > + *   differences. &dma_fence interacts with almost all of the core mem=
ory
> > + *   handling through page fault handlers via &dma_resv, dma_resv_lock=
() and
> > + *   dma_resv_unlock(). On the other side it also interacts through al=
l
> > + *   allocation sites through &mmu_notifier and &shrinker.
> > + *
> > + * Furthermore lockdep does not handle cross-release dependencies, whi=
ch means
> > + * any deadlocks between dma_fence_wait() and dma_fence_signal() can't=
 be caught
> > + * at runtime with some quick testing. The simplest example is one thr=
ead
> > + * waiting on a &dma_fence while holding a lock::
> > + *
> > + *     lock(A);
> > + *     dma_fence_wait(B);
> > + *     unlock(A);
> > + *
> > + * while the other thread is stuck trying to acquire the same lock, wh=
ich
> > + * prevents it from signalling the fence the previous thread is stuck =
waiting
> > + * on::
> > + *
> > + *     lock(A);
> > + *     unlock(A);
> > + *     dma_fence_signal(B);
> > + *
> > + * By manually annotating all code relevant to signalling a &dma_fence=
 we can
> > + * teach lockdep about these dependencies, which also helps with the v=
alidation
> > + * headache since now lockdep can check all the rules for us::
> > + *
> > + *    cookie =3D dma_fence_begin_signalling();
> > + *    lock(A);
> > + *    unlock(A);
> > + *    dma_fence_signal(B);
> > + *    dma_fence_end_signalling(cookie);
> > + *
> > + * For using dma_fence_begin_signalling() and dma_fence_end_signalling=
() to
> > + * annotate critical sections the following rules need to be observed:
> > + *
> > + * * All code necessary to complete a &dma_fence must be annotated, fr=
om the
> > + *   point where a fence is accessible to other threads, to the point =
where
> > + *   dma_fence_signal() is called. Un-annotated code can contain deadl=
ock issues,
> > + *   and due to the very strict rules and many corner cases it is infe=
asible to
> > + *   catch these just with review or normal stress testing.
> > + *
> > + * * &struct dma_resv deserves a special note, since the readers are o=
nly
> > + *   protected by rcu. This means the signalling critical section star=
ts as soon
> > + *   as the new fences are installed, even before dma_resv_unlock() is=
 called.
> > + *
> > + * * The only exception are fast paths and opportunistic signalling co=
de, which
> > + *   calls dma_fence_signal() purely as an optimization, but is not re=
quired to
> > + *   guarantee completion of a &dma_fence. The usual example is a wait=
 IOCTL
> > + *   which calls dma_fence_signal(), while the mandatory completion pa=
th goes
> > + *   through a hardware interrupt and possible job completion worker.
> > + *
> > + * * To aid composability of code, the annotations can be freely neste=
d, as long
> > + *   as the overall locking hierarchy is consistent. The annotations a=
lso work
> > + *   both in interrupt and process context. Due to implementation deta=
ils this
> > + *   requires that callers pass an opaque cookie from
> > + *   dma_fence_begin_signalling() to dma_fence_end_signalling().
> > + *
> > + * * Validation against the cross driver contract is implemented by pr=
iming
> > + *   lockdep with the relevant hierarchy at boot-up. This means even j=
ust
> > + *   testing with a single device is enough to validate a driver, at l=
east as
> > + *   far as deadlocks with dma_fence_wait() against dma_fence_signal()=
 are
> > + *   concerned.
> > + */
> > +#ifdef CONFIG_LOCKDEP
> > +struct lockdep_map   dma_fence_lockdep_map =3D {
> > +     .name =3D "dma_fence_map"
> > +};
> > +
> > +/**
> > + * dma_fence_begin_signalling - begin a critical DMA fence signalling =
section
> > + *
> > + * Drivers should use this to annotate the beginning of any code secti=
on
> > + * required to eventually complete &dma_fence by calling dma_fence_sig=
nal().
> > + *
> > + * The end of these critical sections are annotated with
> > + * dma_fence_end_signalling().
> > + *
> > + * Returns:
> > + *
> > + * Opaque cookie needed by the implementation, which needs to be passe=
d to
> > + * dma_fence_end_signalling().
> > + */
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
> > +
> > +/**
> > + * dma_fence_end_signalling - end a critical DMA fence signalling sect=
ion
> > + *
> > + * Closes a critical section annotation opened by dma_fence_begin_sign=
alling().
> > + */
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
> >   /**
> >    * dma_fence_signal_locked - signal completion of a fence
> >    * @fence: the fence to signal
> > @@ -170,14 +324,19 @@ int dma_fence_signal(struct dma_fence *fence)
> >   {
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
> >   }
> >   EXPORT_SYMBOL(dma_fence_signal);
> > @@ -210,6 +369,8 @@ dma_fence_wait_timeout(struct dma_fence *fence, boo=
l intr, signed long timeout)
> >
> >       might_sleep();
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
> >   }
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
> >   int dma_fence_signal(struct dma_fence *fence);
> >   int dma_fence_signal_locked(struct dma_fence *fence);
> >   signed long dma_fence_default_wait(struct dma_fence *fence,



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
