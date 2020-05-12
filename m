Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EDC1CFD63
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 20:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgELSfG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 14:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgELSfF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 May 2020 14:35:05 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B3BC061A0C
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 11:35:05 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id r66so19128033oie.5
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 11:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xPEcG5tyv4NfED5rgmUhlYBsF0T/ByMgNELO5kcCd1E=;
        b=Fcgn+hdojoW9QJKOWiRWxDn6fiai7TI61j3oRhOf74dl0tXOv22tQ/EjJFis89+36R
         1c7vNAMLPxacTKfLl/kMwgMafZtRpfzRr3LcNwukHEgM+QpqfpjGVhZDLiPXYDx43/Tp
         f6JdnNI7fzYRDZPHWykHX1kDuX/+6FmYJbX0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xPEcG5tyv4NfED5rgmUhlYBsF0T/ByMgNELO5kcCd1E=;
        b=XsQFf58EkWgq/t9wUhzc6DL0MdSUurX33lZUnfxyezqWtvo2dhmEqssLT/ECBVOJXO
         g/+sFq4Vg0zv2UPlNLRyOEMsaq+8x+bD7pTzvbIcbu8vfOvVt9JNKEreFibBAuJfQC+5
         HUNi/4r3qCOete4KVxS/1Cqu+iRTt5CFBdbP/D0YSw3DFYyNmOCL2IIDAY0yvMv7dxLs
         FEk7x9d4UE+3p1hjsuQdde+MgIaOxYIbdw76OHCr3PBsjWU9iLmPTuUhS4WOCK+4qHWh
         wmVj5flxlj6tyh46Un5Nye6iiVedevhHIq17gjO8/kWUYH0e3GbLoB8xKC+VFVIuhkfu
         S4vw==
X-Gm-Message-State: AGi0PuZRKiS+y9FvkhXJR57JLvQvugM/Ib3egFdTvUZRRybwATn4I9mY
        I1gZJgAb1R5YPrVCgukfHyqTvS/XpSsSIK/Zzc67pg==
X-Google-Smtp-Source: APiQypKO9qjZwysgsVJpN+b96veZe9VX8h0LqghTpJ6EmZmuzGxykcW1G5oXp8rZUEFCfxP+wMfkR3xQI8g9yOwBRmw=
X-Received: by 2002:aca:2113:: with SMTP id 19mr15847631oiz.128.1589308504776;
 Tue, 12 May 2020 11:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
 <20200512085944.222637-11-daniel.vetter@ffwll.ch> <879b127e-2180-bc59-f522-252416a7ac01@amd.com>
 <CAKMK7uF1c3R7DTsvRaBfzRVAx03Z+AiUnqdAzP=mt4d=KsoEgg@mail.gmail.com>
 <CAKMK7uGUBqcwo56p3f+8B=ntvuYZ8WtKaFxAPJ_D=H7qdDsGqQ@mail.gmail.com> <5e087376-1c71-ae98-fe91-0d9334e8e6bb@amd.com>
In-Reply-To: <5e087376-1c71-ae98-fe91-0d9334e8e6bb@amd.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue, 12 May 2020 20:34:53 +0200
Message-ID: <CAKMK7uG0mwqqeNd-kG8Heu5e_7LwpVGADCqZPzb9wEJNxYU+pQ@mail.gmail.com>
Subject: Re: [RFC 10/17] drm/amdgpu: s/GFP_KERNEL/GFP_ATOMIC in scheduler code
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 12, 2020 at 7:31 PM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Ah!
>
> So we can't allocate memory while scheduling anything because it could
> be that memory reclaim is waiting for the scheduler to finish pushing
> things to the hardware, right?

Yup, that's my understanding. But like with all things kernel, I'm not
sure, so I tried to come up with some annotations. One of them is the
memory allocation stuff, but it also did find the modeset/dc related
issues in tdr/gpu recovery, so I think overall it's fairly sound. But
the memory side definitely needs more discussion (like really the
entire thing I'm proposing here, hence rfc).

My rough hope here is that first we figure out the exact current
semantics and nail them down in lockdep annotations and kerneldoc. And
then we need to figure out how to step-by-step land this, since lots
of drivers will have smaller and bigger issues all over.

I tried to backsearch our CI for the memory allocation issue
specifically, but unfortunately we're not retaining a whole lot of the
full logs because it's so much. But the more general issue of taking
locks somewhere in the path towards completing a fence (tail end of CS
ioctl, scheduler, tdr, modeset code since that generates fences too
for at least android, ...) that are also held while waiting for said
fences to complete is fairly common. I've seen those way too often,
and up to now lockdep is simply silent about them.

> Indeed a nice problem, haven't noticed that one.

It's pretty glorious indeed :-)

Cheers, Daniel

>
> Christian.
>
> Am 12.05.20 um 18:27 schrieb Daniel Vetter:
> > On Tue, May 12, 2020 at 6:20 PM Daniel Vetter <daniel.vetter@ffwll.ch> =
wrote:
> >> On Tue, May 12, 2020 at 5:56 PM Christian K=C3=B6nig
> >> <christian.koenig@amd.com> wrote:
> >>> Hui what? Of hand that doesn't looks correct to me.
> >> It's not GFP_ATOMIC, it's just that GFP_ATOMIC is the only shotgun we
> >> have to avoid direct reclaim. And direct reclaim might need to call
> >> into your mmu notifier, which might need to wait on a fence, which is
> >> never going to happen because your scheduler is stuck.
> >>
> >> Note that all the explanations for the deadlocks and stuff I'm trying
> >> to hunt here are in the other patches, the driver ones are more
> >> informational, so I left these here rather bare-bones to shut up
> >> lockdep so I can get through the entire driver and all major areas
> >> (scheduler, reset, modeset code).
> >>
> >> Now you can do something like GFP_NOFS, but the only reasons that
> >> works is because the direct reclaim annotations
> >> (fs_reclaim_acquire/release) only validates against __GFP_FS, and not
> >> against any of the other flags. We should probably add some lockdep
> >> annotations so that __GFP_RECLAIM is annotated against the
> >> __mmu_notifier_invalidate_range_start_map lockdep map I've recently
> >> added for mmu notifiers. End result (assuming I'm not mixing anything
> >> up here, this is all rather tricky stuff): GFP_ATOMIC is the only kind
> >> of memory allocation you can do.
> >>
> >>> Why the heck should this be an atomic context? If that's correct
> >>> allocating memory is the least of the problems we have.
> >> It's not about atomic, it's !__GFP_RECLAIM. Which more or less is
> >> GFP_ATOMIC. Correct fix is probably GFP_ATOMIC + a mempool for the
> >> scheduler fixes so that if you can't allocate them for some reason,
> >> you at least know that your scheduler should eventually retire retire
> >> some of them, which you can then pick up from the mempool to guarantee
> >> forward progress.
> >>
> >> But I really didn't dig into details of the code, this was just a quic=
k hack.
> >>
> >> So sleeping and taking all kinds of locks (but not all, e.g.
> >> dma_resv_lock and drm_modeset_lock are no-go) is still totally ok.
> >> Just think
> >>
> >> #define GFP_NO_DIRECT_RECLAIM GFP_ATOMIC
> > Maybe slightly different take that's easier to understand: You've
> > already made the observation that anything holding adev->notifier_lock
> > isn't allowed to allocate memory (well GFP_ATOMIC is ok, like here).
> >
> > Only thing I'm adding is that the situation is a lot worse. Plus the
> > lockdep annotations to help us catch these issues.
> > -Daniel
> >
> >> Cheers, Daniel
> >>
> >>> Regards,
> >>> Christian.
> >>>
> >>> Am 12.05.20 um 10:59 schrieb Daniel Vetter:
> >>>> My dma-fence lockdep annotations caught an inversion because we
> >>>> allocate memory where we really shouldn't:
> >>>>
> >>>>        kmem_cache_alloc+0x2b/0x6d0
> >>>>        amdgpu_fence_emit+0x30/0x330 [amdgpu]
> >>>>        amdgpu_ib_schedule+0x306/0x550 [amdgpu]
> >>>>        amdgpu_job_run+0x10f/0x260 [amdgpu]
> >>>>        drm_sched_main+0x1b9/0x490 [gpu_sched]
> >>>>        kthread+0x12e/0x150
> >>>>
> >>>> Trouble right now is that lockdep only validates against GFP_FS, whi=
ch
> >>>> would be good enough for shrinkers. But for mmu_notifiers we actuall=
y
> >>>> need !GFP_ATOMIC, since they can be called from any page laundering,
> >>>> even if GFP_NOFS or GFP_NOIO are set.
> >>>>
> >>>> I guess we should improve the lockdep annotations for
> >>>> fs_reclaim_acquire/release.
> >>>>
> >>>> Ofc real fix is to properly preallocate this fence and stuff it into
> >>>> the amdgpu job structure. But GFP_ATOMIC gets the lockdep splat out =
of
> >>>> the way.
> >>>>
> >>>> v2: Two more allocations in scheduler paths.
> >>>>
> >>>> Frist one:
> >>>>
> >>>>        __kmalloc+0x58/0x720
> >>>>        amdgpu_vmid_grab+0x100/0xca0 [amdgpu]
> >>>>        amdgpu_job_dependency+0xf9/0x120 [amdgpu]
> >>>>        drm_sched_entity_pop_job+0x3f/0x440 [gpu_sched]
> >>>>        drm_sched_main+0xf9/0x490 [gpu_sched]
> >>>>
> >>>> Second one:
> >>>>
> >>>>        kmem_cache_alloc+0x2b/0x6d0
> >>>>        amdgpu_sync_fence+0x7e/0x110 [amdgpu]
> >>>>        amdgpu_vmid_grab+0x86b/0xca0 [amdgpu]
> >>>>        amdgpu_job_dependency+0xf9/0x120 [amdgpu]
> >>>>        drm_sched_entity_pop_job+0x3f/0x440 [gpu_sched]
> >>>>        drm_sched_main+0xf9/0x490 [gpu_sched]
> >>>>
> >>>> Cc: linux-media@vger.kernel.org
> >>>> Cc: linaro-mm-sig@lists.linaro.org
> >>>> Cc: linux-rdma@vger.kernel.org
> >>>> Cc: amd-gfx@lists.freedesktop.org
> >>>> Cc: intel-gfx@lists.freedesktop.org
> >>>> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> >>>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> >>>> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> >>>> ---
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 2 +-
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c   | 2 +-
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c  | 2 +-
> >>>>    3 files changed, 3 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_fence.c
> >>>> index d878fe7fee51..055b47241bb1 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> >>>> @@ -143,7 +143,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, =
struct dma_fence **f,
> >>>>        uint32_t seq;
> >>>>        int r;
> >>>>
> >>>> -     fence =3D kmem_cache_alloc(amdgpu_fence_slab, GFP_KERNEL);
> >>>> +     fence =3D kmem_cache_alloc(amdgpu_fence_slab, GFP_ATOMIC);
> >>>>        if (fence =3D=3D NULL)
> >>>>                return -ENOMEM;
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ids.c
> >>>> index fe92dcd94d4a..fdcd6659f5ad 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> >>>> @@ -208,7 +208,7 @@ static int amdgpu_vmid_grab_idle(struct amdgpu_v=
m *vm,
> >>>>        if (ring->vmid_wait && !dma_fence_is_signaled(ring->vmid_wait=
))
> >>>>                return amdgpu_sync_fence(sync, ring->vmid_wait, false=
);
> >>>>
> >>>> -     fences =3D kmalloc_array(sizeof(void *), id_mgr->num_ids, GFP_=
KERNEL);
> >>>> +     fences =3D kmalloc_array(sizeof(void *), id_mgr->num_ids, GFP_=
ATOMIC);
> >>>>        if (!fences)
> >>>>                return -ENOMEM;
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_sync.c
> >>>> index b87ca171986a..330476cc0c86 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> >>>> @@ -168,7 +168,7 @@ int amdgpu_sync_fence(struct amdgpu_sync *sync, =
struct dma_fence *f,
> >>>>        if (amdgpu_sync_add_later(sync, f, explicit))
> >>>>                return 0;
> >>>>
> >>>> -     e =3D kmem_cache_alloc(amdgpu_sync_slab, GFP_KERNEL);
> >>>> +     e =3D kmem_cache_alloc(amdgpu_sync_slab, GFP_ATOMIC);
> >>>>        if (!e)
> >>>>                return -ENOMEM;
> >>>>
> >>
> >> --
> >> Daniel Vetter
> >> Software Engineer, Intel Corporation
> >> +41 (0) 79 365 57 48 - https://nam11.safelinks.protection.outlook.com/=
?url=3Dhttp%3A%2F%2Fblog.ffwll.ch%2F&amp;data=3D02%7C01%7Cchristian.koenig%=
40amd.com%7C38b330b8aab946f388e908d7f691553b%7C3dd8961fe4884e608e11a82d994e=
183d%7C0%7C0%7C637248976369551581&amp;sdata=3D6rrCvEYVug95QXc3yYLbQ8ZN4wyYe=
lfUUGWiyitVpuc%3D&amp;reserved=3D0
> >
> >
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
