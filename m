Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9F6220C71
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2020 13:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbgGOLx3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jul 2020 07:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbgGOLx2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jul 2020 07:53:28 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8DDC061755
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2020 04:53:28 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id r8so1975761oij.5
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2020 04:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4FinrZlSydscGLD2XsWVO6ma8sgzxkNosmE+MO8lKig=;
        b=EuIfKI6Bn90Pi6oY4F2zofoOTzeGYqVMf+4Hl3ChqJRLun57M5MH9Itz9/q9Na8Rdc
         3h8d43G5mJFidQR/uT6wg+ZN0zp46F4bNgoXw+zvdR/GApCyHO9VI5zbGEa5Aek9L2cL
         XHemHmKdlyehq57zo12xitk+g0hXVmgANpaE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4FinrZlSydscGLD2XsWVO6ma8sgzxkNosmE+MO8lKig=;
        b=mHQUg1lVRmd3FFcTAZ+vff4ngmjInxG5Ovbthnnjmz0svl+WdkR12aWdYgvhCPcuDa
         7IRcuIH8xF2jLoTmzFLOBcNuepN9ONtV06wCcxhwk/SJjR/vq801OReRQS+t0d1IMnka
         DfykAjDOMu32MBcBX/xxkoD4ObAdL4D8bgh0TwBAEK8+dCGWvqGijQAblo008A+Vwx9X
         GrV4t94SyBPsGZB/mry6h/v+Pmt8gNTJVa8yMXcG8YXNIUPPzXjIirv8m3loZYlMLVbM
         GbDEhwB5YlFBGLQuPaoiKs8ESBiyA22PmXimui+sDL/EkHlh8RmH2mVrJubE93KhbVfy
         aR9g==
X-Gm-Message-State: AOAM532LkS1v++7Cs3eNSyZ9l3/lmWB26JapM+4TcxCi19ChR57ki44W
        VGo5qQeY7LAs0VudKVU7l8ooqWW8viFInL2kObVUs12I
X-Google-Smtp-Source: ABdhPJxUL5GYS/lkJdhIPXoYwZ5RFdtdz0fp2dGsnvxTUfeb+KRTouxT1ct6MX8VZM0M2ALQCn8JC6faol/ocWZzBrk=
X-Received: by 2002:aca:cc8e:: with SMTP id c136mr7447522oig.128.1594814007622;
 Wed, 15 Jul 2020 04:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-20-daniel.vetter@ffwll.ch> <20200714104910.GC3278063@phenom.ffwll.local>
 <d3e85f62-e427-7f1c-0ff4-842ffe57172e@amd.com> <20200714143124.GG3278063@phenom.ffwll.local>
 <ab593d2b-051f-4d34-26d1-596351a50630@gmail.com>
In-Reply-To: <ab593d2b-051f-4d34-26d1-596351a50630@gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 15 Jul 2020 13:53:16 +0200
Message-ID: <CAKMK7uFjG9LjJ_bAqZ=_1tO=iEnhMpJBbzxG-OEWzXujf8jnGw@mail.gmail.com>
Subject: Re: [PATCH 19/25] drm/amdgpu: s/GFP_KERNEL/GFP_ATOMIC in scheduler code
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 15, 2020 at 11:17 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 14.07.20 um 16:31 schrieb Daniel Vetter:
> > On Tue, Jul 14, 2020 at 01:40:11PM +0200, Christian K=C3=B6nig wrote:
> >> Am 14.07.20 um 12:49 schrieb Daniel Vetter:
> >>> On Tue, Jul 07, 2020 at 10:12:23PM +0200, Daniel Vetter wrote:
> >>>> My dma-fence lockdep annotations caught an inversion because we
> >>>> allocate memory where we really shouldn't:
> >>>>
> >>>>    kmem_cache_alloc+0x2b/0x6d0
> >>>>    amdgpu_fence_emit+0x30/0x330 [amdgpu]
> >>>>    amdgpu_ib_schedule+0x306/0x550 [amdgpu]
> >>>>    amdgpu_job_run+0x10f/0x260 [amdgpu]
> >>>>    drm_sched_main+0x1b9/0x490 [gpu_sched]
> >>>>    kthread+0x12e/0x150
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
> >>>>    __kmalloc+0x58/0x720
> >>>>    amdgpu_vmid_grab+0x100/0xca0 [amdgpu]
> >>>>    amdgpu_job_dependency+0xf9/0x120 [amdgpu]
> >>>>    drm_sched_entity_pop_job+0x3f/0x440 [gpu_sched]
> >>>>    drm_sched_main+0xf9/0x490 [gpu_sched]
> >>>>
> >>>> Second one:
> >>>>
> >>>>    kmem_cache_alloc+0x2b/0x6d0
> >>>>    amdgpu_sync_fence+0x7e/0x110 [amdgpu]
> >>>>    amdgpu_vmid_grab+0x86b/0xca0 [amdgpu]
> >>>>    amdgpu_job_dependency+0xf9/0x120 [amdgpu]
> >>>>    drm_sched_entity_pop_job+0x3f/0x440 [gpu_sched]
> >>>>    drm_sched_main+0xf9/0x490 [gpu_sched]
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
> >>> Has anyone from amd side started looking into how to fix this properl=
y?
> >> Yeah I checked both and neither are any real problem.
> > I'm confused ... do you mean "no real problem fixing them" or "not
> > actually a real problem"?
>
> Both, at least the VMID stuff is trivial to avoid.
>
> And the fence allocation is extremely unlikely. E.g. when we allocate a
> new one we previously most likely just freed one already.

Yeah I think debugging we can avoid, just stop debugging if things get
hung up like that. So mempool for the hw fences should be perfectly
fine.

The vmid stuff I don't really understand enough, but the hw fence
stuff I think I grok, plus other scheduler users need that too from a
quick look. I might be tackling that one (maybe put the mempool
outright into drm_scheduler code as a helper), except if you have
patches already in the works. vmid I'll leave to you guys :-)

-Daniel

>
> >
> >>> I looked a bit into fixing this with mempool, and the big guarantee w=
e
> >>> need is that
> >>> - there's a hard upper limit on how many allocations we minimally nee=
d to
> >>>     guarantee forward progress. And the entire vmid allocation and
> >>>     amdgpu_sync_fence stuff kinda makes me question that's a valid
> >>>     assumption.
> >> We do have hard upper limits for those.
> >>
> >> The VMID allocation could as well just return the fence instead of put=
ting
> >> it into the sync object IIRC. So that just needs some cleanup and can =
avoid
> >> the allocation entirely.
> > Yeah embedding should be simplest solution of all.
> >
> >> The hardware fence is limited by the number of submissions we can have
> >> concurrently on the ring buffers, so also not a problem at all.
> > Ok that sounds good. Wrt releasing the memory again, is that also done
> > without any of the allocation-side locks held? I've seen some vmid mana=
ger
> > somewhere ...
>
> Well that's the issue. We can't guarantee that for the hardware fence
> memory since it could be that we hold another reference during debugging
> IIRC.
>
> Still looking if and how we could fix this. But as I said this problem
> is so extremely unlikely.
>
> Christian.
>
> > -Daniel
> >
> >> Regards,
> >> Christian.
> >>
> >>> - mempool_free must be called without any locks in the way which are =
held
> >>>     while we call mempool_alloc. Otherwise we again have a nice deadl=
ock
> >>>     with no forward progress. I tried auditing that, but got lost in =
amdgpu
> >>>     and scheduler code. Some lockdep annotations for mempool.c might =
help,
> >>>     but they're not going to catch everything. Plus it would be again=
 manual
> >>>     annotations because this is yet another cross-release issue. So n=
ot sure
> >>>     that helps at all.
> >>>
> >>> iow, not sure what to do here. Ideas?
> >>>
> >>> Cheers, Daniel
> >>>
> >>>> ---
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 2 +-
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c   | 2 +-
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c  | 2 +-
> >>>>    3 files changed, 3 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_fence.c
> >>>> index 8d84975885cd..a089a827fdfe 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> >>>> @@ -143,7 +143,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, =
struct dma_fence **f,
> >>>>            uint32_t seq;
> >>>>            int r;
> >>>> -  fence =3D kmem_cache_alloc(amdgpu_fence_slab, GFP_KERNEL);
> >>>> +  fence =3D kmem_cache_alloc(amdgpu_fence_slab, GFP_ATOMIC);
> >>>>            if (fence =3D=3D NULL)
> >>>>                    return -ENOMEM;
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ids.c
> >>>> index 267fa45ddb66..a333ca2d4ddd 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> >>>> @@ -208,7 +208,7 @@ static int amdgpu_vmid_grab_idle(struct amdgpu_v=
m *vm,
> >>>>            if (ring->vmid_wait && !dma_fence_is_signaled(ring->vmid_=
wait))
> >>>>                    return amdgpu_sync_fence(sync, ring->vmid_wait);
> >>>> -  fences =3D kmalloc_array(sizeof(void *), id_mgr->num_ids, GFP_KER=
NEL);
> >>>> +  fences =3D kmalloc_array(sizeof(void *), id_mgr->num_ids, GFP_ATO=
MIC);
> >>>>            if (!fences)
> >>>>                    return -ENOMEM;
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_sync.c
> >>>> index 8ea6c49529e7..af22b526cec9 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> >>>> @@ -160,7 +160,7 @@ int amdgpu_sync_fence(struct amdgpu_sync *sync, =
struct dma_fence *f)
> >>>>            if (amdgpu_sync_add_later(sync, f))
> >>>>                    return 0;
> >>>> -  e =3D kmem_cache_alloc(amdgpu_sync_slab, GFP_KERNEL);
> >>>> +  e =3D kmem_cache_alloc(amdgpu_sync_slab, GFP_ATOMIC);
> >>>>            if (!e)
> >>>>                    return -ENOMEM;
> >>>> --
> >>>> 2.27.0
> >>>>
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
