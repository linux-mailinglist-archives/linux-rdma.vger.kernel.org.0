Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC95220877
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2020 11:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbgGOJRK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jul 2020 05:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729592AbgGOJRK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jul 2020 05:17:10 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9C2C08C5C1;
        Wed, 15 Jul 2020 02:17:09 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 22so4636898wmg.1;
        Wed, 15 Jul 2020 02:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+IDiZwZg3Trea4s9dhZySAzIZU6G8+yBgvykdO0kvyc=;
        b=i1qPit3G86IA+Fm4rScawTmqjQv0feT66G4h4A8panYBxY1j6KUsDMj2Y/hMUrcnOB
         zXjfMjhSp59MFsac4vxXcWxEr9qt+yFZ8WaafBzuU/unwfWKxbxMQC35WmJsew4wCt8E
         044mE6URD0nr7bLsobjQGY/OgLhRTqz0VcMRia0iNrbY+cU+Cly+CL5xXJdKROcERHLo
         aNGR78PMS743EIdC2pE+uCASk05KlRrOet1KMUV8hl4OQW5qScNF7dBOearnqtdlosxm
         ZIWvZaDrrMLWF9C3jeBucpgqsbQwd1n+7ubBODu14scr2PDWeWBKunoBavVpZ6DnAEA+
         oi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=+IDiZwZg3Trea4s9dhZySAzIZU6G8+yBgvykdO0kvyc=;
        b=n1j+CMRkXNE7RDmH76ZAQK/MJHsOmOuUar9F9uslxQ0zkyj7ILxRcm+q7W3N9ZpXdb
         LT6vS+akHokQAMiya+d2t8NuUL7dqGMBeisY2pKs3r1TnU8RbkeDI7jYZIj9UWbCB2f1
         /0Wym/qqsEeYpmv3eoUJdz7exyg3vt1tXZykZknmfelHRrpaJX4pIX68jLQWPNTvjsug
         0wIh5VvFgjoTW8pfUUx4FWtwvyjAxkBmZ+Wjo9upkNVKcXq9p7oHYsxRKtHk22W/vERu
         jIGN2firXf7KbkR5KDiW2/P2WvOT45Di4G0mjBoA0yMzm1tLzkp6PLywE1vtCc1dnuvJ
         NbpA==
X-Gm-Message-State: AOAM533YnCIa6fsgDyC0PKGUqRl6Y3OAT3OG5SQyLOEDVWFGXKQlx5A5
        ecJDxDhDUSNNRyC+bMozIYHomVtM
X-Google-Smtp-Source: ABdhPJxPJhr5EaZDklw7cjhxnI0V03dWlYgghBh6hKC25TCD7+xLp6A1H/zXDD9g69GxbcSsI3Hqww==
X-Received: by 2002:a1c:1bc4:: with SMTP id b187mr8164707wmb.105.1594804628116;
        Wed, 15 Jul 2020 02:17:08 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:68f0:d4d3:d7ff:52d6? ([2a02:908:1252:fb60:68f0:d4d3:d7ff:52d6])
        by smtp.gmail.com with ESMTPSA id r11sm2415287wmh.1.2020.07.15.02.17.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 02:17:07 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 19/25] drm/amdgpu: s/GFP_KERNEL/GFP_ATOMIC in scheduler
 code
To:     Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        linux-media@vger.kernel.org
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-20-daniel.vetter@ffwll.ch>
 <20200714104910.GC3278063@phenom.ffwll.local>
 <d3e85f62-e427-7f1c-0ff4-842ffe57172e@amd.com>
 <20200714143124.GG3278063@phenom.ffwll.local>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <ab593d2b-051f-4d34-26d1-596351a50630@gmail.com>
Date:   Wed, 15 Jul 2020 11:17:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200714143124.GG3278063@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 14.07.20 um 16:31 schrieb Daniel Vetter:
> On Tue, Jul 14, 2020 at 01:40:11PM +0200, Christian König wrote:
>> Am 14.07.20 um 12:49 schrieb Daniel Vetter:
>>> On Tue, Jul 07, 2020 at 10:12:23PM +0200, Daniel Vetter wrote:
>>>> My dma-fence lockdep annotations caught an inversion because we
>>>> allocate memory where we really shouldn't:
>>>>
>>>> 	kmem_cache_alloc+0x2b/0x6d0
>>>> 	amdgpu_fence_emit+0x30/0x330 [amdgpu]
>>>> 	amdgpu_ib_schedule+0x306/0x550 [amdgpu]
>>>> 	amdgpu_job_run+0x10f/0x260 [amdgpu]
>>>> 	drm_sched_main+0x1b9/0x490 [gpu_sched]
>>>> 	kthread+0x12e/0x150
>>>>
>>>> Trouble right now is that lockdep only validates against GFP_FS, which
>>>> would be good enough for shrinkers. But for mmu_notifiers we actually
>>>> need !GFP_ATOMIC, since they can be called from any page laundering,
>>>> even if GFP_NOFS or GFP_NOIO are set.
>>>>
>>>> I guess we should improve the lockdep annotations for
>>>> fs_reclaim_acquire/release.
>>>>
>>>> Ofc real fix is to properly preallocate this fence and stuff it into
>>>> the amdgpu job structure. But GFP_ATOMIC gets the lockdep splat out of
>>>> the way.
>>>>
>>>> v2: Two more allocations in scheduler paths.
>>>>
>>>> Frist one:
>>>>
>>>> 	__kmalloc+0x58/0x720
>>>> 	amdgpu_vmid_grab+0x100/0xca0 [amdgpu]
>>>> 	amdgpu_job_dependency+0xf9/0x120 [amdgpu]
>>>> 	drm_sched_entity_pop_job+0x3f/0x440 [gpu_sched]
>>>> 	drm_sched_main+0xf9/0x490 [gpu_sched]
>>>>
>>>> Second one:
>>>>
>>>> 	kmem_cache_alloc+0x2b/0x6d0
>>>> 	amdgpu_sync_fence+0x7e/0x110 [amdgpu]
>>>> 	amdgpu_vmid_grab+0x86b/0xca0 [amdgpu]
>>>> 	amdgpu_job_dependency+0xf9/0x120 [amdgpu]
>>>> 	drm_sched_entity_pop_job+0x3f/0x440 [gpu_sched]
>>>> 	drm_sched_main+0xf9/0x490 [gpu_sched]
>>>>
>>>> Cc: linux-media@vger.kernel.org
>>>> Cc: linaro-mm-sig@lists.linaro.org
>>>> Cc: linux-rdma@vger.kernel.org
>>>> Cc: amd-gfx@lists.freedesktop.org
>>>> Cc: intel-gfx@lists.freedesktop.org
>>>> Cc: Chris Wilson <chris@chris-wilson.co.uk>
>>>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>>>> Cc: Christian König <christian.koenig@amd.com>
>>>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>>> Has anyone from amd side started looking into how to fix this properly?
>> Yeah I checked both and neither are any real problem.
> I'm confused ... do you mean "no real problem fixing them" or "not
> actually a real problem"?

Both, at least the VMID stuff is trivial to avoid.

And the fence allocation is extremely unlikely. E.g. when we allocate a 
new one we previously most likely just freed one already.

>
>>> I looked a bit into fixing this with mempool, and the big guarantee we
>>> need is that
>>> - there's a hard upper limit on how many allocations we minimally need to
>>>     guarantee forward progress. And the entire vmid allocation and
>>>     amdgpu_sync_fence stuff kinda makes me question that's a valid
>>>     assumption.
>> We do have hard upper limits for those.
>>
>> The VMID allocation could as well just return the fence instead of putting
>> it into the sync object IIRC. So that just needs some cleanup and can avoid
>> the allocation entirely.
> Yeah embedding should be simplest solution of all.
>
>> The hardware fence is limited by the number of submissions we can have
>> concurrently on the ring buffers, so also not a problem at all.
> Ok that sounds good. Wrt releasing the memory again, is that also done
> without any of the allocation-side locks held? I've seen some vmid manager
> somewhere ...

Well that's the issue. We can't guarantee that for the hardware fence 
memory since it could be that we hold another reference during debugging 
IIRC.

Still looking if and how we could fix this. But as I said this problem 
is so extremely unlikely.

Christian.

> -Daniel
>
>> Regards,
>> Christian.
>>
>>> - mempool_free must be called without any locks in the way which are held
>>>     while we call mempool_alloc. Otherwise we again have a nice deadlock
>>>     with no forward progress. I tried auditing that, but got lost in amdgpu
>>>     and scheduler code. Some lockdep annotations for mempool.c might help,
>>>     but they're not going to catch everything. Plus it would be again manual
>>>     annotations because this is yet another cross-release issue. So not sure
>>>     that helps at all.
>>>
>>> iow, not sure what to do here. Ideas?
>>>
>>> Cheers, Daniel
>>>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 2 +-
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c   | 2 +-
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c  | 2 +-
>>>>    3 files changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>> index 8d84975885cd..a089a827fdfe 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>> @@ -143,7 +143,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>>>>    	uint32_t seq;
>>>>    	int r;
>>>> -	fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_KERNEL);
>>>> +	fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_ATOMIC);
>>>>    	if (fence == NULL)
>>>>    		return -ENOMEM;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>>> index 267fa45ddb66..a333ca2d4ddd 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>>> @@ -208,7 +208,7 @@ static int amdgpu_vmid_grab_idle(struct amdgpu_vm *vm,
>>>>    	if (ring->vmid_wait && !dma_fence_is_signaled(ring->vmid_wait))
>>>>    		return amdgpu_sync_fence(sync, ring->vmid_wait);
>>>> -	fences = kmalloc_array(sizeof(void *), id_mgr->num_ids, GFP_KERNEL);
>>>> +	fences = kmalloc_array(sizeof(void *), id_mgr->num_ids, GFP_ATOMIC);
>>>>    	if (!fences)
>>>>    		return -ENOMEM;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>> index 8ea6c49529e7..af22b526cec9 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>> @@ -160,7 +160,7 @@ int amdgpu_sync_fence(struct amdgpu_sync *sync, struct dma_fence *f)
>>>>    	if (amdgpu_sync_add_later(sync, f))
>>>>    		return 0;
>>>> -	e = kmem_cache_alloc(amdgpu_sync_slab, GFP_KERNEL);
>>>> +	e = kmem_cache_alloc(amdgpu_sync_slab, GFP_ATOMIC);
>>>>    	if (!e)
>>>>    		return -ENOMEM;
>>>> -- 
>>>> 2.27.0
>>>>

