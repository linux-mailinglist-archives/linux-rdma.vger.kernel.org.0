Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E215F1F6A8B
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2020 17:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgFKPDi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jun 2020 11:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgFKPDi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Jun 2020 11:03:38 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D36AC08C5C1
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2020 08:03:37 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id s21so5653205oic.9
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2020 08:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HVLihZKcA2+FpRmDi/jta3TIiJGSdxyQDbmKSQjMvP4=;
        b=afrx543kDjcxtavchw5vm7XAC1srbQuB65sgep0FVGoJmO7JoK7PYp7bqtWzUfjFMX
         RgSuj6y8eqr5FpeXSgQxB0AtW32Bmj7OsYWa2tIOlydTx9UV2QxuUVVIckPDFhgKXOSl
         CHj2Iv9vCaW8aA56ozF8QYWtS0TNXMvE1aYeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HVLihZKcA2+FpRmDi/jta3TIiJGSdxyQDbmKSQjMvP4=;
        b=Gewf4oOVaipnovEh2ZSuqm9BWtdtrnOQikNJ8CaN4owpe/ipBW48PSaQuky+0wseMx
         IyGo8O94cJUBcq+24ij+WxaeqcNeFQs83a9QXJdNP/lngqAk05eZeXLC66W72M95YrnI
         YMXtvtsgNF69ga/9wuTEWNJKXftVp2tgYDNFucVGKp6zv64bdk+4fl8khyyGpmh6J/Kh
         xYIw7zAb+a6HFW1xbeCRrLowzwGnIzfxk1BYKtTxutGDJ7abypGkkaitkMEskGjj1qGC
         TLP/cepH8qJbwpREwoo7giSdBBUuoAknIDhJcsZ/1mxmgv0Yoxf1oijPMH9fOsGcVLau
         VzGw==
X-Gm-Message-State: AOAM532RmNPJDVDExBcpyrUAwjTwDlLYIeugadgJKTUGdIrGKJfWG2XV
        G60Gf+Go34DShJJTzTCUEa5DjFrdZTzaFKATWNX62g==
X-Google-Smtp-Source: ABdhPJyK6uN3vMmzRCzC2+PtRMcydL25jCGufkipsxba7xORIXl2y/0q2IXDBooDr9RaJiGmuMqZG9woS8Z3jkkvKZI=
X-Received: by 2002:aca:4b91:: with SMTP id y139mr6552673oia.128.1591887816432;
 Thu, 11 Jun 2020 08:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-4-daniel.vetter@ffwll.ch> <be3526aa-07db-adc0-9291-1b5aeb0d1613@linux.intel.com>
 <CAKMK7uE4ak=gaKNJziaLg1qN1mE1FKLW1MGFkmUz2tR2y0ArAA@mail.gmail.com>
 <19c6fe47-50ff-869e-d3f0-703b8165d577@linux.intel.com> <CAKMK7uEKYJ1kPrB01yw9A3ZHHZ4jDmzwxMjymn7pxOgs9hpKBA@mail.gmail.com>
 <28c18eed-6d03-aeb2-9e0f-39bae84dfb8c@linux.intel.com>
In-Reply-To: <28c18eed-6d03-aeb2-9e0f-39bae84dfb8c@linux.intel.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 11 Jun 2020 17:03:23 +0200
Message-ID: <CAKMK7uFkwe8uSsC3DwvyqirdHQkMpF1rLssjDU=oL0OxK01UDw@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH 03/18] dma-fence: basic lockdep annotations
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
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

On Thu, Jun 11, 2020 at 4:29 PM Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
>
>
> On 11/06/2020 12:29, Daniel Vetter wrote:
> > On Thu, Jun 11, 2020 at 12:36 PM Tvrtko Ursulin
> > <tvrtko.ursulin@linux.intel.com> wrote:
> >> On 10/06/2020 16:17, Daniel Vetter wrote:
> >>> On Wed, Jun 10, 2020 at 4:22 PM Tvrtko Ursulin
> >>> <tvrtko.ursulin@linux.intel.com> wrote:
> >>>>
> >>>>
> >>>> On 04/06/2020 09:12, Daniel Vetter wrote:
> >>>>> Design is similar to the lockdep annotations for workers, but with
> >>>>> some twists:
> >>>>>
> >>>>> - We use a read-lock for the execution/worker/completion side, so t=
hat
> >>>>>      this explicit annotation can be more liberally sprinkled aroun=
d.
> >>>>>      With read locks lockdep isn't going to complain if the read-si=
de
> >>>>>      isn't nested the same way under all circumstances, so ABBA dea=
dlocks
> >>>>>      are ok. Which they are, since this is an annotation only.
> >>>>>
> >>>>> - We're using non-recursive lockdep read lock mode, since in recurs=
ive
> >>>>>      read lock mode lockdep does not catch read side hazards. And w=
e
> >>>>>      _very_ much want read side hazards to be caught. For full deta=
ils of
> >>>>>      this limitation see
> >>>>>
> >>>>>      commit e91498589746065e3ae95d9a00b068e525eec34f
> >>>>>      Author: Peter Zijlstra <peterz@infradead.org>
> >>>>>      Date:   Wed Aug 23 13:13:11 2017 +0200
> >>>>>
> >>>>>          locking/lockdep/selftests: Add mixed read-write ABBA tests
> >>>>>
> >>>>> - To allow nesting of the read-side explicit annotations we explici=
tly
> >>>>>      keep track of the nesting. lock_is_held() allows us to do that=
.
> >>>>>
> >>>>> - The wait-side annotation is a write lock, and entirely done withi=
n
> >>>>>      dma_fence_wait() for everyone by default.
> >>>>>
> >>>>> - To be able to freely annotate helper functions I want to make it =
ok
> >>>>>      to call dma_fence_begin/end_signalling from soft/hardirq conte=
xt.
> >>>>>      First attempt was using the hardirq locking context for the wr=
ite
> >>>>>      side in lockdep, but this forces all normal spinlocks nested w=
ithin
> >>>>>      dma_fence_begin/end_signalling to be spinlocks. That bollocks.
> >>>>>
> >>>>>      The approach now is to simple check in_atomic(), and for these=
 cases
> >>>>>      entirely rely on the might_sleep() check in dma_fence_wait(). =
That
> >>>>>      will catch any wrong nesting against spinlocks from soft/hardi=
rq
> >>>>>      contexts.
> >>>>>
> >>>>> The idea here is that every code path that's critical for eventuall=
y
> >>>>> signalling a dma_fence should be annotated with
> >>>>> dma_fence_begin/end_signalling. The annotation ideally starts right
> >>>>> after a dma_fence is published (added to a dma_resv, exposed as a
> >>>>> sync_file fd, attached to a drm_syncobj fd, or anything else that
> >>>>> makes the dma_fence visible to other kernel threads), up to and
> >>>>> including the dma_fence_wait(). Examples are irq handlers, the
> >>>>> scheduler rt threads, the tail of execbuf (after the corresponding
> >>>>> fences are visible), any workers that end up signalling dma_fences =
and
> >>>>> really anything else. Not annotated should be code paths that only
> >>>>> complete fences opportunistically as the gpu progresses, like e.g.
> >>>>> shrinker/eviction code.
> >>>>>
> >>>>> The main class of deadlocks this is supposed to catch are:
> >>>>>
> >>>>> Thread A:
> >>>>>
> >>>>>         mutex_lock(A);
> >>>>>         mutex_unlock(A);
> >>>>>
> >>>>>         dma_fence_signal();
> >>>>>
> >>>>> Thread B:
> >>>>>
> >>>>>         mutex_lock(A);
> >>>>>         dma_fence_wait();
> >>>>>         mutex_unlock(A);
> >>>>>
> >>>>> Thread B is blocked on A signalling the fence, but A never gets aro=
und
> >>>>> to that because it cannot acquire the lock A.
> >>>>>
> >>>>> Note that dma_fence_wait() is allowed to be nested within
> >>>>> dma_fence_begin/end_signalling sections. To allow this to happen th=
e
> >>>>> read lock needs to be upgraded to a write lock, which means that an=
y
> >>>>> other lock is acquired between the dma_fence_begin_signalling() cal=
l and
> >>>>> the call to dma_fence_wait(), and still held, this will result in a=
n
> >>>>> immediate lockdep complaint. The only other option would be to not
> >>>>> annotate such calls, defeating the point. Therefore these annotatio=
ns
> >>>>> cannot be sprinkled over the code entirely mindless to avoid false
> >>>>> positives.
> >>>>>
> >>>>> v2: handle soft/hardirq ctx better against write side and dont forg=
et
> >>>>> EXPORT_SYMBOL, drivers can't use this otherwise.
> >>>>>
> >>>>> v3: Kerneldoc.
> >>>>>
> >>>>> v4: Some spelling fixes from Mika
> >>>>>
> >>>>> Cc: Mika Kuoppala <mika.kuoppala@intel.com>
> >>>>> Cc: Thomas Hellstrom <thomas.hellstrom@intel.com>
> >>>>> Cc: linux-media@vger.kernel.org
> >>>>> Cc: linaro-mm-sig@lists.linaro.org
> >>>>> Cc: linux-rdma@vger.kernel.org
> >>>>> Cc: amd-gfx@lists.freedesktop.org
> >>>>> Cc: intel-gfx@lists.freedesktop.org
> >>>>> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> >>>>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> >>>>> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>>>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> >>>>> ---
> >>>>>     Documentation/driver-api/dma-buf.rst |  12 +-
> >>>>>     drivers/dma-buf/dma-fence.c          | 161 ++++++++++++++++++++=
+++++++
> >>>>>     include/linux/dma-fence.h            |  12 ++
> >>>>>     3 files changed, 182 insertions(+), 3 deletions(-)
> >>>>>
> >>>>> diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/d=
river-api/dma-buf.rst
> >>>>> index 63dec76d1d8d..05d856131140 100644
> >>>>> --- a/Documentation/driver-api/dma-buf.rst
> >>>>> +++ b/Documentation/driver-api/dma-buf.rst
> >>>>> @@ -100,11 +100,11 @@ CPU Access to DMA Buffer Objects
> >>>>>     .. kernel-doc:: drivers/dma-buf/dma-buf.c
> >>>>>        :doc: cpu access
> >>>>>
> >>>>> -Fence Poll Support
> >>>>> -~~~~~~~~~~~~~~~~~~
> >>>>> +Implicit Fence Poll Support
> >>>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>>>
> >>>>>     .. kernel-doc:: drivers/dma-buf/dma-buf.c
> >>>>> -   :doc: fence polling
> >>>>> +   :doc: implicit fence polling
> >>>>>
> >>>>>     Kernel Functions and Structures Reference
> >>>>>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>>> @@ -133,6 +133,12 @@ DMA Fences
> >>>>>     .. kernel-doc:: drivers/dma-buf/dma-fence.c
> >>>>>        :doc: DMA fences overview
> >>>>>
> >>>>> +DMA Fence Signalling Annotations
> >>>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>>> +
> >>>>> +.. kernel-doc:: drivers/dma-buf/dma-fence.c
> >>>>> +   :doc: fence signalling annotation
> >>>>> +
> >>>>>     DMA Fences Functions Reference
> >>>>>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>>>
> >>>>> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fenc=
e.c
> >>>>> index 656e9ac2d028..0005bc002529 100644
> >>>>> --- a/drivers/dma-buf/dma-fence.c
> >>>>> +++ b/drivers/dma-buf/dma-fence.c
> >>>>> @@ -110,6 +110,160 @@ u64 dma_fence_context_alloc(unsigned num)
> >>>>>     }
> >>>>>     EXPORT_SYMBOL(dma_fence_context_alloc);
> >>>>>
> >>>>> +/**
> >>>>> + * DOC: fence signalling annotation
> >>>>> + *
> >>>>> + * Proving correctness of all the kernel code around &dma_fence th=
rough code
> >>>>> + * review and testing is tricky for a few reasons:
> >>>>> + *
> >>>>> + * * It is a cross-driver contract, and therefore all drivers must=
 follow the
> >>>>> + *   same rules for lock nesting order, calling contexts for vario=
us functions
> >>>>> + *   and anything else significant for in-kernel interfaces. But i=
t is also
> >>>>> + *   impossible to test all drivers in a single machine, hence bru=
te-force N vs.
> >>>>> + *   N testing of all combinations is impossible. Even just limiti=
ng to the
> >>>>> + *   possible combinations is infeasible.
> >>>>> + *
> >>>>> + * * There is an enormous amount of driver code involved. For rend=
er drivers
> >>>>> + *   there's the tail of command submission, after fences are publ=
ished,
> >>>>> + *   scheduler code, interrupt and workers to process job completi=
on,
> >>>>> + *   and timeout, gpu reset and gpu hang recovery code. Plus for i=
ntegration
> >>>>> + *   with core mm with have &mmu_notifier, respectively &mmu_inter=
val_notifier,
> >>>>> + *   and &shrinker. For modesetting drivers there's the commit tai=
l functions
> >>>>> + *   between when fences for an atomic modeset are published, and =
when the
> >>>>> + *   corresponding vblank completes, including any interrupt proce=
ssing and
> >>>>> + *   related workers. Auditing all that code, across all drivers, =
is not
> >>>>> + *   feasible.
> >>>>> + *
> >>>>> + * * Due to how many other subsystems are involved and the locking=
 hierarchies
> >>>>> + *   this pulls in there is extremely thin wiggle-room for driver-=
specific
> >>>>> + *   differences. &dma_fence interacts with almost all of the core=
 memory
> >>>>> + *   handling through page fault handlers via &dma_resv, dma_resv_=
lock() and
> >>>>> + *   dma_resv_unlock(). On the other side it also interacts throug=
h all
> >>>>> + *   allocation sites through &mmu_notifier and &shrinker.
> >>>>> + *
> >>>>> + * Furthermore lockdep does not handle cross-release dependencies,=
 which means
> >>>>> + * any deadlocks between dma_fence_wait() and dma_fence_signal() c=
an't be caught
> >>>>> + * at runtime with some quick testing. The simplest example is one=
 thread
> >>>>> + * waiting on a &dma_fence while holding a lock::
> >>>>> + *
> >>>>> + *     lock(A);
> >>>>> + *     dma_fence_wait(B);
> >>>>> + *     unlock(A);
> >>>>> + *
> >>>>> + * while the other thread is stuck trying to acquire the same lock=
, which
> >>>>> + * prevents it from signalling the fence the previous thread is st=
uck waiting
> >>>>> + * on::
> >>>>> + *
> >>>>> + *     lock(A);
> >>>>> + *     unlock(A);
> >>>>> + *     dma_fence_signal(B);
> >>>>> + *
> >>>>> + * By manually annotating all code relevant to signalling a &dma_f=
ence we can
> >>>>> + * teach lockdep about these dependencies, which also helps with t=
he validation
> >>>>> + * headache since now lockdep can check all the rules for us::
> >>>>> + *
> >>>>> + *    cookie =3D dma_fence_begin_signalling();
> >>>>> + *    lock(A);
> >>>>> + *    unlock(A);
> >>>>> + *    dma_fence_signal(B);
> >>>>> + *    dma_fence_end_signalling(cookie);
> >>>>> + *
> >>>>> + * For using dma_fence_begin_signalling() and dma_fence_end_signal=
ling() to
> >>>>> + * annotate critical sections the following rules need to be obser=
ved:
> >>>>> + *
> >>>>> + * * All code necessary to complete a &dma_fence must be annotated=
, from the
> >>>>> + *   point where a fence is accessible to other threads, to the po=
int where
> >>>>> + *   dma_fence_signal() is called. Un-annotated code can contain d=
eadlock issues,
> >>>>> + *   and due to the very strict rules and many corner cases it is =
infeasible to
> >>>>> + *   catch these just with review or normal stress testing.
> >>>>> + *
> >>>>> + * * &struct dma_resv deserves a special note, since the readers a=
re only
> >>>>> + *   protected by rcu. This means the signalling critical section =
starts as soon
> >>>>> + *   as the new fences are installed, even before dma_resv_unlock(=
) is called.
> >>>>> + *
> >>>>> + * * The only exception are fast paths and opportunistic signallin=
g code, which
> >>>>> + *   calls dma_fence_signal() purely as an optimization, but is no=
t required to
> >>>>> + *   guarantee completion of a &dma_fence. The usual example is a =
wait IOCTL
> >>>>> + *   which calls dma_fence_signal(), while the mandatory completio=
n path goes
> >>>>> + *   through a hardware interrupt and possible job completion work=
er.
> >>>>> + *
> >>>>> + * * To aid composability of code, the annotations can be freely n=
ested, as long
> >>>>> + *   as the overall locking hierarchy is consistent. The annotatio=
ns also work
> >>>>> + *   both in interrupt and process context. Due to implementation =
details this
> >>>>> + *   requires that callers pass an opaque cookie from
> >>>>> + *   dma_fence_begin_signalling() to dma_fence_end_signalling().
> >>>>> + *
> >>>>> + * * Validation against the cross driver contract is implemented b=
y priming
> >>>>> + *   lockdep with the relevant hierarchy at boot-up. This means ev=
en just
> >>>>> + *   testing with a single device is enough to validate a driver, =
at least as
> >>>>> + *   far as deadlocks with dma_fence_wait() against dma_fence_sign=
al() are
> >>>>> + *   concerned.
> >>>>> + */
> >>>>> +#ifdef CONFIG_LOCKDEP
> >>>>> +struct lockdep_map   dma_fence_lockdep_map =3D {
> >>>>> +     .name =3D "dma_fence_map"
> >>>>> +};
> >>>>
> >>>> Maybe a stupid question because this is definitely complicated, but.=
. If
> >>>> you have a single/static/global lockdep map, doesn't this mean _all_
> >>>> locks, from _all_ drivers happening to use dma-fences will get recor=
ded
> >>>> in it. Will this work and not cause false positives?
> >>>>
> >>>> Sounds like it could create a common link between two completely
> >>>> unconnected usages. Because below you do add annotations to generic
> >>>> dma_fence_signal and dma_fence_wait.
> >>>
> >>> This is fully intentional. dma-fence is a cross-driver interface, if
> >>> every driver invents its own rules about how this should work we have
> >>> an unmaintainable and unreviewable mess.
> >>>
> >>> I've typed up the full length rant already here:
> >>>
> >>> https://lore.kernel.org/dri-devel/CAKMK7uGnFhbpuurRsnZ4dvRV9gQ_3-rmSJ=
aoqSFY=3D+Kvepz_CA@mail.gmail.com/
> >>
> >> But "perfect storm" of:
> >>
> >>   + global fence lockmap
> >>   + mmu notifiers
> >>   + fs reclaim
> >>   + default annotations in dma_fence_signal / dma_fence_wait
> >>
> >> Equals to anything ever using dma_fence will be in impossible chains w=
ith random other drivers, even if neither driver has code to export/share t=
hat fence.
> >>
> >> Example from the CI run:
> >>
> >>   [25.918788] Chain exists of:
> >>    fs_reclaim --> mmu_notifier_invalidate_range_start --> dma_fence_ma=
p
> >>   [25.918794]  Possible unsafe locking scenario:
> >>   [25.918797]        CPU0                    CPU1
> >>   [25.918799]        ----                    ----
> >>   [25.918801]   lock(dma_fence_map);
> >>   [25.918803]                                lock(mmu_notifier_invalid=
ate_range_start);
> >>   [25.918807]                                lock(dma_fence_map);
> >>   [25.918809]   lock(fs_reclaim);
> >>
> >> What about a dma_fence_export helper which would "arm" the annotations=
? It would be called as soon as the fence is exported. Maybe when added to =
dma_resv, or exported via sync_file, etc. Before that point begin/end_signa=
ling and so would be no-ops.
> >
> > Run CI without the i915 annotation patch, nothing breaks.
>
> I think some parts of i915 would still break with my idea to only apply a=
nnotations on exported fences. What do you dislike about that idea? I thoug=
ht the point is to enforce rules for _exported_ fences.

dma_fence is a shared concept, this is upstream, drivers are expected
to a) use shared concepts and b) use them in a consistent way. If
drivers do whatever they feel like then they're no maintainable in the
upstream sense of "maintainable even if the vendor walks away". This
was the reason why amd had to spend 2 refactoring from DAL (which used
all the helpers they shared with their firmware/windows driver) to DC
(which uses all the upstream kms helpers and datastructures directly).

> How you have annotated dma_fence_work you can't say, maybe it is exported=
 maybe it isn't. I think it is btw, so splats would still be there, but I a=
m not sure it is conceptually correct.
>
> At least my understanding is GFP_KERNEL allocations are only disallowed b=
y the virtue of the global dma-fence contract. If you want to enforce they =
are never used for anything but exporting, then that would be a bit harsh, =
no?
>
> Another example from the CI run:
>
>  [26.585357]        CPU0                    CPU1
>  [26.585359]        ----                    ----
>  [26.585360]   lock(dma_fence_map);
>  [26.585362]                                lock(mmu_notifier_invalidate_=
range_start);
>  [26.585365]                                lock(dma_fence_map);
>  [26.585367]   lock(i915_gem_object_internal/1);
>  [26.585369]
>  *** DEADLOCK ***

So ime the above deadlock summaries tend to be wrong as soon as you
have more than 2 locks involved. Which we have here - they only ever
show at most 2 threads, with each thread only taking 2 locks in total,
which isn't going to deadlock if you have  more than 2 locks involved.
Which is the case above.

Personally I just ignore the above deadlock scenario and just always
look at all the locks and backtraces lockdep gives me, and then
reconstruct the dependency graph by hand myself, including deadlock
scenario.

> Lets say someone submitted an execbuf using userptr as a batch and then u=
nmapped it immediately. That would explain CPU1 getting into the mmu notifi=
er and waiting on this batch to unbind the object.
>
> Meanwhile CPU0 is the async command parser for this request trying to loc=
k the shadow batch buffer. Because it uses the dma_fence_work this is betwe=
en the begin/end signalling markers.
>
> It can be the same dma-fence I think, since we install the async parser f=
ence on the real batch dma-resv, but dma_fence_map is not a real lock, so w=
hat is actually preventing progress in this case?
>
> CPU1 is waiting on a fence, but CPU0 can obtain the lock(i915_gem_object_=
internal/1), proceed to parse the batch, and exit the signalling section. A=
t which point CPU1 is still blocked, waiting until the execbuf finishes and=
 then mmu notifier can finish and invalidate the pages.
>
> Maybe I am missing something but I don't see how this one is real.

The above doesn't deadlock, and it also shouldn't result in a lockdep
splat. The trouble is when the signalling thread also grabs
i915_gem_object_internal/1 somewhere. Which if you go through full CI
results you see there's more involved (and at least one of the splats
is all just lockdep priming and might_lock, so could be an annotation
bug on top), and there is indeed a path where we lock the driver
private lock in more places, and the wrong way round. That's the thing
lockdep is complaining about, it's just not making that clear in the
summary because the summary is only ever correct for 2 locks. Not if
more is involved.

> > So we can gradually fix up existing code that doesn't quite get it
> > right and move on.
> >
> >>>>> +
> >>>>> +/**
> >>>>> + * dma_fence_begin_signalling - begin a critical DMA fence signall=
ing section
> >>>>> + *
> >>>>> + * Drivers should use this to annotate the beginning of any code s=
ection
> >>>>> + * required to eventually complete &dma_fence by calling dma_fence=
_signal().
> >>>>> + *
> >>>>> + * The end of these critical sections are annotated with
> >>>>> + * dma_fence_end_signalling().
> >>>>> + *
> >>>>> + * Returns:
> >>>>> + *
> >>>>> + * Opaque cookie needed by the implementation, which needs to be p=
assed to
> >>>>> + * dma_fence_end_signalling().
> >>>>> + */
> >>>>> +bool dma_fence_begin_signalling(void)
> >>>>> +{
> >>>>> +     /* explicitly nesting ... */
> >>>>> +     if (lock_is_held_type(&dma_fence_lockdep_map, 1))
> >>>>> +             return true;
> >>>>> +
> >>>>> +     /* rely on might_sleep check for soft/hardirq locks */
> >>>>> +     if (in_atomic())
> >>>>> +             return true;
> >>>>> +
> >>>>> +     /* ... and non-recursive readlock */
> >>>>> +     lock_acquire(&dma_fence_lockdep_map, 0, 0, 1, 1, NULL, _RET_I=
P_);
> >>>>
> >>>> Would it work if signalling path would mark itself as a write lock? =
I am
> >>>> thinking it would be nice to see in lockdep splats what are signals =
and
> >>>> what are waits.
> >>>
> >>> Yeah it'd be nice to have a read vs write name for the lock. But we
> >>> already have this problem for e.g. flush_work(), from which I've
> >>> stolen this idea. So it's not really new. Essentially look at the
> >>> backtraces lockdep gives you, and reconstruct the deadlock. I'm hopin=
g
> >>> that people will notice the special functions on the backtrace, e.g.
> >>> dma_fence_begin_signalling will be listed as offending function/lock
> >>> holder, and then read the kerneldoc.
> >>>
> >>>> The recursive usage wouldn't work then right? Would write annotation=
 on
> >>>> the wait path work?
> >>>
> >>> Wait path is write annotations already, but yeah annotating the
> >>> signalling side as write would cause endless amounts of alse
> >>> positives. Also it makes composability of these e.g. what I've done i=
n
> >>> amdgpu with annotations in tdr work in drm/scheduler, annotations in
> >>> the amdgpu gpu reset code and then also annotations in atomic code,
> >>> which all nest within each other in some call chains, but not others.
> >>> Dropping the recursion would break that and make it really awkward to
> >>> annotate such cases correctly.
> >>>
> >>> And the recursion only works if it's read locks, otherwise lockdep
> >>> complains if you have inconsistent annotations on the signalling side
> >>> (which again would make it more or less impossible to annotate the
> >>> above case fully).
> >>
> >> How do I see in lockdep splats if it was a read or write user? Your pa=
tch appears to have:
> >>
> >> dma_fence_signal:
> >> +       lock_acquire(&dma_fence_lockdep_map, 0, 0, 1, 1, NULL, _RET_IP=
_);
> >>
> >> __dma_fence_might_wait:
> >> +       lock_acquire(&dma_fence_lockdep_map, 0, 0, 1, 1, NULL, _THIS_I=
P_);
> >>
> >> Which both seem like read lock. I don't fully understand the lockdep A=
PI so I might be wrong, not sure. But neither I see a difference in splats =
telling me which path is which.
> >
> > I think you got tricked by the implementation, this isn't quite what's
> > going on. There's two things which make the annotations special:
> >
> > - we want a recursive read lock on the signalling critical section.
> > The problem is that lockdep doesn't implement full validation for
> > recursive read locks, only non-recursive read/write locks fully
> > validated. There's some checks for recursive read locks, but exactly
> > the checks we need to catch common dma_fence_wait deadlocks aren't
> > done. That's why we need to implement manual lock recursion on the
> > reader side
> >
> > - now on the write side we additionally need to implement an
> > read2write upgrade, and a write2read downgrade. Lockdep doesn't
> > implement that, so again we have to hand-roll this.
> >
> > Let's go through the code line-by-line:
> >
> >      bool tmp;
> >
> >      tmp =3D lock_is_held_type(&dma_fence_lockdep_map, 1);
> >
> > We check whether someone is holding the non-recursive read lock already=
.
> >
> >      if (tmp)
> >          lock_release(&dma_fence_lockdep_map, _THIS_IP_);
> >
> > If that's the case, we drop that read lock.
> >
> >      lock_map_acquire(&dma_fence_lockdep_map);
> >
> > Then we do the actual might_wait annotation, the above takes the full
> > write lock ...
> >
> >      lock_map_release(&dma_fence_lockdep_map);
> >
> > ... and now we release the write lock again.
> >
> >
> >      if (tmp)
> >          lock_acquire(&dma_fence_lockdep_map, 0, 0, 1, 1, NULL, _THIS_I=
P_);
> >
> > Finally we need to re-acquire the read lock, if we've held that when
> > entering this function. This annotation naturally has to exactly match
> > what begin_signalling would do, otherwise the hand-rolled nesting
> > would fall apart.
> >
> > I hope that explains what's going on here, and assures you that
> > might_wait() is indeed a write lock annotation, but with a big pile of
> > complications.
>
> I am certainly confused by the difference between lock_map_acquire/releas=
e and lock_acquire/release. What is the difference between the two?

lock_acquire/release is a wrapper around lock_map_acquire/release.
This is all lockdep internal, it's a completely undocumented maze, so
unfortunately only option is to really careful follow all the
definitions from various locking primitives. And then compare with
lockdep self-test (which use the locking primitives, not the lockdep
internals) to see which flag controls which kind of behaviour.

That's at least what I do, and it's horrible. But yeah lockdep doesn't
have documentation for this.

If you think it's better to open code the lock_map/acquire, I guess I
can do that. But it's a mess, so I need to carefully retest everything
and make sure I've set the right flags and bits - for added fun they
also change ordering in some of the wrappers!
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
