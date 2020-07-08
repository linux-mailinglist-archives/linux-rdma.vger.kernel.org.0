Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20048218B6E
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2020 17:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgGHPhc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jul 2020 11:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730144AbgGHPhc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jul 2020 11:37:32 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E8CC08C5C1
        for <linux-rdma@vger.kernel.org>; Wed,  8 Jul 2020 08:37:32 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 5so35225074oty.11
        for <linux-rdma@vger.kernel.org>; Wed, 08 Jul 2020 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ON0pZjR7zqopX2oOyfp3wHLdGXSAlg8QuZXW+2SPrWA=;
        b=RLVajux7NPBRgq/CEWKAs1ZOFdwJRfzbZW49xTZotBAEZRLRbz2IfiOm6rQAFgocSt
         WPmDZSdy/EYaRLDWuQeJj0DGNh/+QLjstczXLNPBGkyR7OsQmQqxHMXKLptqq8AERAnu
         pfrib27Z8mSMo9TCatzDD4WOlw8rtCd/7CjfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ON0pZjR7zqopX2oOyfp3wHLdGXSAlg8QuZXW+2SPrWA=;
        b=NejWHGg71/8v6Y2PTesTDMDYdq9uFTnBBB7ddp2zmSksCq6VkFkbDtK0yiYfymvJOk
         GEq0aM2dglSsTOS3mEP7Q9/bjpwchd9P0xB3KkmG2HYk3UH/Y1yE0o29s63xqc98tOPW
         4Vq0EStAN7kpU2Dp/aHwXU2HJRpTDAFn3qD8pmzoBXbxL3UIrVscAIkaHCUQREl+pNkW
         URJI+tSSsRH5Bt/sBow9rfxSai1lv8Ke4l7D8bLZJ/jw4u9xFua1WpRgV5yo/eR8UYYU
         //vB+LSr8ozIwjiqmaoJffuEUzqE03ATYbitEIm0QQVYYtrXKyennKmN3WpTrP68w6nG
         5TYg==
X-Gm-Message-State: AOAM533lRs+ayZCuhjFtAEV86YZbR3jBdM4bNqw2AAbyo3Cb56zI8PG9
        s2rShFusbkrb/ypJ36xyjCyeyOaudd2XEmOzLllwuA==
X-Google-Smtp-Source: ABdhPJySm/nojfvcmZUnvqQCYgUbZc7W3ZA+HAfuqslN/zLMHts4zSYbFccnlsxJIPFXQC3nYqn3uUo/A/Aa1+V742A=
X-Received: by 2002:a05:6830:1613:: with SMTP id g19mr36809613otr.303.1594222651032;
 Wed, 08 Jul 2020 08:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-2-daniel.vetter@ffwll.ch> <20c0a95b-8367-4f26-d058-1cb265255283@amd.com>
 <CAKMK7uFe7Pz4=UUkkunBms8vUrzwEpWJmScOMLO4KdADM43vnw@mail.gmail.com> <CADnq5_NcaU_mJpYUvi7DywbOfkb9+AceQ9JCbV-+tO1jVBVBFQ@mail.gmail.com>
In-Reply-To: <CADnq5_NcaU_mJpYUvi7DywbOfkb9+AceQ9JCbV-+tO1jVBVBFQ@mail.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 8 Jul 2020 17:37:19 +0200
Message-ID: <CAKMK7uHbS8-jXDhGnKaK_65Hs4EUrcfBUe-wcvfPt18weCN0hQ@mail.gmail.com>
Subject: Re: [PATCH 01/25] dma-fence: basic lockdep annotations
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@intel.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 8, 2020 at 5:19 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Wed, Jul 8, 2020 at 11:13 AM Daniel Vetter <daniel.vetter@ffwll.ch> wr=
ote:
> >
> > On Wed, Jul 8, 2020 at 4:57 PM Christian K=C3=B6nig <christian.koenig@a=
md.com> wrote:
> > >
> > > Could we merge this controlled by a separate config option?
> > >
> > > This way we could have the checks upstream without having to fix all =
the
> > > stuff before we do this?
> >
> > Since it's fully opt-in annotations nothing blows up if we don't merge
> > any annotations. So we could start merging the first 3 patches. After
> > that the fun starts ...
> >
> > My rough idea was that first I'd try to tackle display, thus far
> > there's 2 actual issues in drivers:
> > - amdgpu has some dma_resv_lock in commit_tail, plus a kmalloc. I
> > think those should be fairly easy to fix (I'd try a stab at them even)
> > - vmwgfx has a full on locking inversion with dma_resv_lock in
> > commit_tail, and that one is functional. Not just reading something
> > which we can safely assume to be invariant anyway (like the tmz flag
> > for amdgpu, or whatever it was).
> >
> > I've done a pile more annotations patches for other atomic drivers
> > now, so hopefully that flushes out any remaining offenders here. Since
> > some of the annotations are in helper code worst case we might need a
> > dev->mode_config.broken_atomic_commit flag to disable them. At least
> > for now I have 0 plans to merge any of these while there's known
> > unsolved issues. Maybe if some drivers take forever to get fixed we
> > can then apply some duct-tape for the atomic helper annotation patch.
> > Instead of a flag we can also copypasta the atomic_commit_tail hook,
> > leaving the annotations out and adding a huge warning about that.
> >
> > Next big chunk is the drm/scheduler annotations:
> > - amdgpu needs a full rework of display reset (but apparently in the wo=
rks)
>
> I think the display deadlock issues should be fixed in:
> https://cgit.freedesktop.org/drm/drm/commit/?id=3Dcdaae8371aa9d4ea1648a29=
9b1a75946b9556944

That's the reset/tdr inversion, there's two more:
- kmalloc, see https://cgit.freedesktop.org/~danvet/drm/commit/?id=3Dd9353c=
c3bf6111430a24188b92412dc49e7ead79
- ttm_bo_reserve in the wrong place
https://cgit.freedesktop.org/~danvet/drm/commit/?id=3Da6c03176152625a2f9cf1=
e499aceb8b2217dc2a2
- console_lock in the wrong spot
https://cgit.freedesktop.org/~danvet/drm/commit/?id=3Da6c03176152625a2f9cf1=
e499aceb8b2217dc2a2

Especially the last one I have no idea how to address really.
-Daniel


>
> Alex
>
> > - I read all the drivers, they all have the fairly cosmetic issue of
> > doing small allocations in their callbacks.
> >
> > I might end up typing the mempool we need for the latter issue, but
> > first still hoping for some actual test feedback from other drivers
> > using drm/scheduler. Again no intentions of merging these annotations
> > without the drivers being fixed first, or at least some duct-atpe
> > applied.
> >
> > Another option I've been thinking about, if there's cases where fixing
> > things properly is a lot of effort: We could do annotations for broken
> > sections (just the broken part, so we still catch bugs everywhere
> > else). They'd simply drop&reacquire the lock. We could then e.g. use
> > that in the amdgpu display reset code, and so still make sure that
> > everything else in reset doesn't get worse. But I think adding that
> > shouldn't be our first option.
> >
> > I'm not personally a big fan of the Kconfig or runtime option, only
> > upsets people since it breaks lockdep for them. Or they ignore it, and
> > we don't catch bugs, making it fairly pointless to merge.
> >
> > Cheers, Daniel
> >
> >
> > >
> > > Thanks,
> > > Christian.
> > >
> > > Am 07.07.20 um 22:12 schrieb Daniel Vetter:
> > > > Design is similar to the lockdep annotations for workers, but with
> > > > some twists:
> > > >
> > > > - We use a read-lock for the execution/worker/completion side, so t=
hat
> > > >    this explicit annotation can be more liberally sprinkled around.
> > > >    With read locks lockdep isn't going to complain if the read-side
> > > >    isn't nested the same way under all circumstances, so ABBA deadl=
ocks
> > > >    are ok. Which they are, since this is an annotation only.
> > > >
> > > > - We're using non-recursive lockdep read lock mode, since in recurs=
ive
> > > >    read lock mode lockdep does not catch read side hazards. And we
> > > >    _very_ much want read side hazards to be caught. For full detail=
s of
> > > >    this limitation see
> > > >
> > > >    commit e91498589746065e3ae95d9a00b068e525eec34f
> > > >    Author: Peter Zijlstra <peterz@infradead.org>
> > > >    Date:   Wed Aug 23 13:13:11 2017 +0200
> > > >
> > > >        locking/lockdep/selftests: Add mixed read-write ABBA tests
> > > >
> > > > - To allow nesting of the read-side explicit annotations we explici=
tly
> > > >    keep track of the nesting. lock_is_held() allows us to do that.
> > > >
> > > > - The wait-side annotation is a write lock, and entirely done withi=
n
> > > >    dma_fence_wait() for everyone by default.
> > > >
> > > > - To be able to freely annotate helper functions I want to make it =
ok
> > > >    to call dma_fence_begin/end_signalling from soft/hardirq context=
.
> > > >    First attempt was using the hardirq locking context for the writ=
e
> > > >    side in lockdep, but this forces all normal spinlocks nested wit=
hin
> > > >    dma_fence_begin/end_signalling to be spinlocks. That bollocks.
> > > >
> > > >    The approach now is to simple check in_atomic(), and for these c=
ases
> > > >    entirely rely on the might_sleep() check in dma_fence_wait(). Th=
at
> > > >    will catch any wrong nesting against spinlocks from soft/hardirq
> > > >    contexts.
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
> > > >       mutex_lock(A);
> > > >       mutex_unlock(A);
> > > >
> > > >       dma_fence_signal();
> > > >
> > > > Thread B:
> > > >
> > > >       mutex_lock(A);
> > > >       dma_fence_wait();
> > > >       mutex_unlock(A);
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
> > > > Originally I hope that the cross-release lockdep extensions would
> > > > alleviate the need for explicit annotations:
> > > >
> > > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Flwn.net%2FArticles%2F709849%2F&amp;data=3D02%7C01%7Cchristian.koenig%40amd=
.com%7Cff1a9dd17c544534eeb808d822b21ba2%7C3dd8961fe4884e608e11a82d994e183d%=
7C0%7C0%7C637297495649621566&amp;sdata=3DpbDwf%2BAG1UZ5bLZeep7VeGVQMnlQhX0T=
KG1d6Ok8GfQ%3D&amp;reserved=3D0
> > > >
> > > > But there's a few reasons why that's not an option:
> > > >
> > > > - It's not happening in upstream, since it got reverted due to too
> > > >    many false positives:
> > > >
> > > >       commit e966eaeeb623f09975ef362c2866fae6f86844f9
> > > >       Author: Ingo Molnar <mingo@kernel.org>
> > > >       Date:   Tue Dec 12 12:31:16 2017 +0100
> > > >
> > > >           locking/lockdep: Remove the cross-release locking checks
> > > >
> > > >           This code (CONFIG_LOCKDEP_CROSSRELEASE=3Dy and CONFIG_LOC=
KDEP_COMPLETIONS=3Dy),
> > > >           while it found a number of old bugs initially, was also c=
ausing too many
> > > >           false positives that caused people to disable lockdep - w=
hich is arguably
> > > >           a worse overall outcome.
> > > >
> > > > - cross-release uses the complete() call to annotate the end of
> > > >    critical sections, for dma_fence that would be dma_fence_signal(=
).
> > > >    But we do not want all dma_fence_signal() calls to be treated as
> > > >    critical, since many are opportunistic cleanup of gpu requests. =
If
> > > >    these get stuck there's still the main completion interrupt and
> > > >    workers who can unblock everyone. Automatically annotating all
> > > >    dma_fence_signal() calls would hence cause false positives.
> > > >
> > > > - cross-release had some educated guesses for when a critical secti=
on
> > > >    starts, like fresh syscall or fresh work callback. This would ag=
ain
> > > >    cause false positives without explicit annotations, since for
> > > >    dma_fence the critical sections only starts when we publish a fe=
nce.
> > > >
> > > > - Furthermore there can be cases where a thread never does a
> > > >    dma_fence_signal, but is still critical for reaching completion =
of
> > > >    fences. One example would be a scheduler kthread which picks up =
jobs
> > > >    and pushes them into hardware, where the interrupt handler or
> > > >    another completion thread calls dma_fence_signal(). But if the
> > > >    scheduler thread hangs, then all the fences hang, hence we need =
to
> > > >    manually annotate it. cross-release aimed to solve this by chain=
ing
> > > >    cross-release dependencies, but the dependency from scheduler th=
read
> > > >    to the completion interrupt handler goes through hw where
> > > >    cross-release code can't observe it.
> > > >
> > > > In short, without manual annotations and careful review of the star=
t
> > > > and end of critical sections, cross-relese dependency tracking does=
n't
> > > > work. We need explicit annotations.
> > > >
> > > > v2: handle soft/hardirq ctx better against write side and dont forg=
et
> > > > EXPORT_SYMBOL, drivers can't use this otherwise.
> > > >
> > > > v3: Kerneldoc.
> > > >
> > > > v4: Some spelling fixes from Mika
> > > >
> > > > v5: Amend commit message to explain in detail why cross-release isn=
't
> > > > the solution.
> > > >
> > > > v6: Pull out misplaced .rst hunk.
> > > >
> > > > Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> > > > Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@intel.com>
> > > > Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > > Cc: Mika Kuoppala <mika.kuoppala@intel.com>
> > > > Cc: Thomas Hellstrom <thomas.hellstrom@intel.com>
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
> > > >   Documentation/driver-api/dma-buf.rst |   6 +
> > > >   drivers/dma-buf/dma-fence.c          | 161 ++++++++++++++++++++++=
+++++
> > > >   include/linux/dma-fence.h            |  12 ++
> > > >   3 files changed, 179 insertions(+)
> > > >
> > > > diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/d=
river-api/dma-buf.rst
> > > > index 7fb7b661febd..05d856131140 100644
> > > > --- a/Documentation/driver-api/dma-buf.rst
> > > > +++ b/Documentation/driver-api/dma-buf.rst
> > > > @@ -133,6 +133,12 @@ DMA Fences
> > > >   .. kernel-doc:: drivers/dma-buf/dma-fence.c
> > > >      :doc: DMA fences overview
> > > >
> > > > +DMA Fence Signalling Annotations
> > > > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > +
> > > > +.. kernel-doc:: drivers/dma-buf/dma-fence.c
> > > > +   :doc: fence signalling annotation
> > > > +
> > > >   DMA Fences Functions Reference
> > > >   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > >
> > > > diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fenc=
e.c
> > > > index 656e9ac2d028..0005bc002529 100644
> > > > --- a/drivers/dma-buf/dma-fence.c
> > > > +++ b/drivers/dma-buf/dma-fence.c
> > > > @@ -110,6 +110,160 @@ u64 dma_fence_context_alloc(unsigned num)
> > > >   }
> > > >   EXPORT_SYMBOL(dma_fence_context_alloc);
> > > >
> > > > +/**
> > > > + * DOC: fence signalling annotation
> > > > + *
> > > > + * Proving correctness of all the kernel code around &dma_fence th=
rough code
> > > > + * review and testing is tricky for a few reasons:
> > > > + *
> > > > + * * It is a cross-driver contract, and therefore all drivers must=
 follow the
> > > > + *   same rules for lock nesting order, calling contexts for vario=
us functions
> > > > + *   and anything else significant for in-kernel interfaces. But i=
t is also
> > > > + *   impossible to test all drivers in a single machine, hence bru=
te-force N vs.
> > > > + *   N testing of all combinations is impossible. Even just limiti=
ng to the
> > > > + *   possible combinations is infeasible.
> > > > + *
> > > > + * * There is an enormous amount of driver code involved. For rend=
er drivers
> > > > + *   there's the tail of command submission, after fences are publ=
ished,
> > > > + *   scheduler code, interrupt and workers to process job completi=
on,
> > > > + *   and timeout, gpu reset and gpu hang recovery code. Plus for i=
ntegration
> > > > + *   with core mm with have &mmu_notifier, respectively &mmu_inter=
val_notifier,
> > > > + *   and &shrinker. For modesetting drivers there's the commit tai=
l functions
> > > > + *   between when fences for an atomic modeset are published, and =
when the
> > > > + *   corresponding vblank completes, including any interrupt proce=
ssing and
> > > > + *   related workers. Auditing all that code, across all drivers, =
is not
> > > > + *   feasible.
> > > > + *
> > > > + * * Due to how many other subsystems are involved and the locking=
 hierarchies
> > > > + *   this pulls in there is extremely thin wiggle-room for driver-=
specific
> > > > + *   differences. &dma_fence interacts with almost all of the core=
 memory
> > > > + *   handling through page fault handlers via &dma_resv, dma_resv_=
lock() and
> > > > + *   dma_resv_unlock(). On the other side it also interacts throug=
h all
> > > > + *   allocation sites through &mmu_notifier and &shrinker.
> > > > + *
> > > > + * Furthermore lockdep does not handle cross-release dependencies,=
 which means
> > > > + * any deadlocks between dma_fence_wait() and dma_fence_signal() c=
an't be caught
> > > > + * at runtime with some quick testing. The simplest example is one=
 thread
> > > > + * waiting on a &dma_fence while holding a lock::
> > > > + *
> > > > + *     lock(A);
> > > > + *     dma_fence_wait(B);
> > > > + *     unlock(A);
> > > > + *
> > > > + * while the other thread is stuck trying to acquire the same lock=
, which
> > > > + * prevents it from signalling the fence the previous thread is st=
uck waiting
> > > > + * on::
> > > > + *
> > > > + *     lock(A);
> > > > + *     unlock(A);
> > > > + *     dma_fence_signal(B);
> > > > + *
> > > > + * By manually annotating all code relevant to signalling a &dma_f=
ence we can
> > > > + * teach lockdep about these dependencies, which also helps with t=
he validation
> > > > + * headache since now lockdep can check all the rules for us::
> > > > + *
> > > > + *    cookie =3D dma_fence_begin_signalling();
> > > > + *    lock(A);
> > > > + *    unlock(A);
> > > > + *    dma_fence_signal(B);
> > > > + *    dma_fence_end_signalling(cookie);
> > > > + *
> > > > + * For using dma_fence_begin_signalling() and dma_fence_end_signal=
ling() to
> > > > + * annotate critical sections the following rules need to be obser=
ved:
> > > > + *
> > > > + * * All code necessary to complete a &dma_fence must be annotated=
, from the
> > > > + *   point where a fence is accessible to other threads, to the po=
int where
> > > > + *   dma_fence_signal() is called. Un-annotated code can contain d=
eadlock issues,
> > > > + *   and due to the very strict rules and many corner cases it is =
infeasible to
> > > > + *   catch these just with review or normal stress testing.
> > > > + *
> > > > + * * &struct dma_resv deserves a special note, since the readers a=
re only
> > > > + *   protected by rcu. This means the signalling critical section =
starts as soon
> > > > + *   as the new fences are installed, even before dma_resv_unlock(=
) is called.
> > > > + *
> > > > + * * The only exception are fast paths and opportunistic signallin=
g code, which
> > > > + *   calls dma_fence_signal() purely as an optimization, but is no=
t required to
> > > > + *   guarantee completion of a &dma_fence. The usual example is a =
wait IOCTL
> > > > + *   which calls dma_fence_signal(), while the mandatory completio=
n path goes
> > > > + *   through a hardware interrupt and possible job completion work=
er.
> > > > + *
> > > > + * * To aid composability of code, the annotations can be freely n=
ested, as long
> > > > + *   as the overall locking hierarchy is consistent. The annotatio=
ns also work
> > > > + *   both in interrupt and process context. Due to implementation =
details this
> > > > + *   requires that callers pass an opaque cookie from
> > > > + *   dma_fence_begin_signalling() to dma_fence_end_signalling().
> > > > + *
> > > > + * * Validation against the cross driver contract is implemented b=
y priming
> > > > + *   lockdep with the relevant hierarchy at boot-up. This means ev=
en just
> > > > + *   testing with a single device is enough to validate a driver, =
at least as
> > > > + *   far as deadlocks with dma_fence_wait() against dma_fence_sign=
al() are
> > > > + *   concerned.
> > > > + */
> > > > +#ifdef CONFIG_LOCKDEP
> > > > +struct lockdep_map   dma_fence_lockdep_map =3D {
> > > > +     .name =3D "dma_fence_map"
> > > > +};
> > > > +
> > > > +/**
> > > > + * dma_fence_begin_signalling - begin a critical DMA fence signall=
ing section
> > > > + *
> > > > + * Drivers should use this to annotate the beginning of any code s=
ection
> > > > + * required to eventually complete &dma_fence by calling dma_fence=
_signal().
> > > > + *
> > > > + * The end of these critical sections are annotated with
> > > > + * dma_fence_end_signalling().
> > > > + *
> > > > + * Returns:
> > > > + *
> > > > + * Opaque cookie needed by the implementation, which needs to be p=
assed to
> > > > + * dma_fence_end_signalling().
> > > > + */
> > > > +bool dma_fence_begin_signalling(void)
> > > > +{
> > > > +     /* explicitly nesting ... */
> > > > +     if (lock_is_held_type(&dma_fence_lockdep_map, 1))
> > > > +             return true;
> > > > +
> > > > +     /* rely on might_sleep check for soft/hardirq locks */
> > > > +     if (in_atomic())
> > > > +             return true;
> > > > +
> > > > +     /* ... and non-recursive readlock */
> > > > +     lock_acquire(&dma_fence_lockdep_map, 0, 0, 1, 1, NULL, _RET_I=
P_);
> > > > +
> > > > +     return false;
> > > > +}
> > > > +EXPORT_SYMBOL(dma_fence_begin_signalling);
> > > > +
> > > > +/**
> > > > + * dma_fence_end_signalling - end a critical DMA fence signalling =
section
> > > > + *
> > > > + * Closes a critical section annotation opened by dma_fence_begin_=
signalling().
> > > > + */
> > > > +void dma_fence_end_signalling(bool cookie)
> > > > +{
> > > > +     if (cookie)
> > > > +             return;
> > > > +
> > > > +     lock_release(&dma_fence_lockdep_map, _RET_IP_);
> > > > +}
> > > > +EXPORT_SYMBOL(dma_fence_end_signalling);
> > > > +
> > > > +void __dma_fence_might_wait(void)
> > > > +{
> > > > +     bool tmp;
> > > > +
> > > > +     tmp =3D lock_is_held_type(&dma_fence_lockdep_map, 1);
> > > > +     if (tmp)
> > > > +             lock_release(&dma_fence_lockdep_map, _THIS_IP_);
> > > > +     lock_map_acquire(&dma_fence_lockdep_map);
> > > > +     lock_map_release(&dma_fence_lockdep_map);
> > > > +     if (tmp)
> > > > +             lock_acquire(&dma_fence_lockdep_map, 0, 0, 1, 1, NULL=
, _THIS_IP_);
> > > > +}
> > > > +#endif
> > > > +
> > > > +
> > > >   /**
> > > >    * dma_fence_signal_locked - signal completion of a fence
> > > >    * @fence: the fence to signal
> > > > @@ -170,14 +324,19 @@ int dma_fence_signal(struct dma_fence *fence)
> > > >   {
> > > >       unsigned long flags;
> > > >       int ret;
> > > > +     bool tmp;
> > > >
> > > >       if (!fence)
> > > >               return -EINVAL;
> > > >
> > > > +     tmp =3D dma_fence_begin_signalling();
> > > > +
> > > >       spin_lock_irqsave(fence->lock, flags);
> > > >       ret =3D dma_fence_signal_locked(fence);
> > > >       spin_unlock_irqrestore(fence->lock, flags);
> > > >
> > > > +     dma_fence_end_signalling(tmp);
> > > > +
> > > >       return ret;
> > > >   }
> > > >   EXPORT_SYMBOL(dma_fence_signal);
> > > > @@ -210,6 +369,8 @@ dma_fence_wait_timeout(struct dma_fence *fence,=
 bool intr, signed long timeout)
> > > >
> > > >       might_sleep();
> > > >
> > > > +     __dma_fence_might_wait();
> > > > +
> > > >       trace_dma_fence_wait_start(fence);
> > > >       if (fence->ops->wait)
> > > >               ret =3D fence->ops->wait(fence, intr, timeout);
> > > > diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> > > > index 3347c54f3a87..3f288f7db2ef 100644
> > > > --- a/include/linux/dma-fence.h
> > > > +++ b/include/linux/dma-fence.h
> > > > @@ -357,6 +357,18 @@ dma_fence_get_rcu_safe(struct dma_fence __rcu =
**fencep)
> > > >       } while (1);
> > > >   }
> > > >
> > > > +#ifdef CONFIG_LOCKDEP
> > > > +bool dma_fence_begin_signalling(void);
> > > > +void dma_fence_end_signalling(bool cookie);
> > > > +#else
> > > > +static inline bool dma_fence_begin_signalling(void)
> > > > +{
> > > > +     return true;
> > > > +}
> > > > +static inline void dma_fence_end_signalling(bool cookie) {}
> > > > +static inline void __dma_fence_might_wait(void) {}
> > > > +#endif
> > > > +
> > > >   int dma_fence_signal(struct dma_fence *fence);
> > > >   int dma_fence_signal_locked(struct dma_fence *fence);
> > > >   signed long dma_fence_default_wait(struct dma_fence *fence,
> > >
> >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
