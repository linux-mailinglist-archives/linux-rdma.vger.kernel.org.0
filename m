Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0841CFC39
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 19:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgELRb7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 13:31:59 -0400
Received: from mail-bn8nam11on2079.outbound.protection.outlook.com ([40.107.236.79]:6036
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725554AbgELRb6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 13:31:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYYdZI5PvtDvhSQpcislTe+X+SzPO6eIyoDtPHwhFg8E9fGKuQOI7tBZKSaRF5ITiqW35MtYgJzuFmD/9ORlQxv1E0xkF4hXl+ePgFtly1cbb+CqYJj9LVgzozbC+tjQzk0YJy7pZVZqmNLsbvk3imVqpWvqe2leFqhKRVGSH0o13utj4VcnN+XXVYXw0pMy2/Yxk/UmgJdvZGw+VWubqjFk4cnZ/ot78wM1mAHjkBq6z/6Ng0v/Ebns/Hcml+2CMrTumcFbVy+LkogRPZcPUJgoe0FU41aw5ZoaSNnfSvZG7BKLiHKMnJkTpPdEfuJI+nuBvOfulhTgXuH5UAmxsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Paf9aSP7l/UqZPzzc1mm6HCpErMY7jmUg5ejYsLvZ9g=;
 b=hSqRePuF1IPACsPNcD5rnkJPSAidSI42x6ZVnKU2bQ8wtaDtLGDR0kGJPzkyAQtt91LHjqhQaZ8ht52CF183fgVTHwlByAIma5scblps5Yj+mgXdimwvNxf0t5DfctVVmFYQB44EtS64F1adz4CN25ahhySRnIL2t99rjDaAtyjnp28LUAuTPWRYC3cqO/FGtyvGEh794PaQATFoksFNyZ0ymHwMhQ50qc2CGDZirNE3eyELJpvWg/0ivMivgywEKqx3zy6xxr7LDPjNYHZsM92OkBc0iMSTqB+Sy3ybdphQfJ1lfkoZmhgZkYUJNffjzhrQsRHrMh1w3usWNcpWKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Paf9aSP7l/UqZPzzc1mm6HCpErMY7jmUg5ejYsLvZ9g=;
 b=Xmpsvm/ToIQPyA7egpSjfV3jEwW59BGNzE+seQ6HznLa1uuXxoEL0gRxD3NtYbT11w59WpHX7QNDjhzCJyp0Hea1QHTnXqF0dPt930U8lc6QlgLcDG+toOZNJZYH7dGV9EuYpMKJ3VYMxouhApuT24qHU0CF+JqTv28OKuxmeec=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.30; Tue, 12 May
 2020 17:31:55 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 17:31:55 +0000
Subject: Re: [RFC 10/17] drm/amdgpu: s/GFP_KERNEL/GFP_ATOMIC in scheduler code
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
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
References: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
 <20200512085944.222637-11-daniel.vetter@ffwll.ch>
 <879b127e-2180-bc59-f522-252416a7ac01@amd.com>
 <CAKMK7uF1c3R7DTsvRaBfzRVAx03Z+AiUnqdAzP=mt4d=KsoEgg@mail.gmail.com>
 <CAKMK7uGUBqcwo56p3f+8B=ntvuYZ8WtKaFxAPJ_D=H7qdDsGqQ@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5e087376-1c71-ae98-fe91-0d9334e8e6bb@amd.com>
Date:   Tue, 12 May 2020 19:31:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <CAKMK7uGUBqcwo56p3f+8B=ntvuYZ8WtKaFxAPJ_D=H7qdDsGqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0111.eurprd07.prod.outlook.com
 (2603:10a6:207:7::21) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM3PR07CA0111.eurprd07.prod.outlook.com (2603:10a6:207:7::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.12 via Frontend Transport; Tue, 12 May 2020 17:31:52 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ff748cbe-ae9a-490c-2016-08d7f69a5d50
X-MS-TrafficTypeDiagnostic: DM6PR12MB4251:
X-Microsoft-Antispam-PRVS: <DM6PR12MB425115830FDFC46148C8283683BE0@DM6PR12MB4251.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MAhOIic4in8ak5weawcqmIdaPl26nmiK218DxdbBj0iBx3KVX65DT7kHGFD/+7EIIulN9DzwMtmHGy3tToUSM8RAhtPRW+oBIi2Vdux+LUgujj/wJt1rSV1VpXNAm2IWUab1nZncfFDND9TawKbkLx37ugw7H+1Uw2B3hrXOWLKGSBFCNZwbpsSrMDsw2u19jXLpCHHeAiPpx1PROznnv6KzjROcuWfdkIoGCecBrqB18hx5C0xzWNoo6m3JITZriIcAfucKeUiVIchWrM/VA6zhfrv8fTEVIkPlg+EGJDstC6/kY7TMss1bTcVzzrgjP81JU0GHTvfVAF0Cum5+AdaLmqDxoOeDecegwFEgJIOHAtynqzo3qy9iYmwJV1nA+6BDJP0gCZhk3hSNfkVp5HlZaVNSTAiJIK/3xH2siWQDlqIsocBiPJk5alyu2dnvDdy2GeVrllGO8ZH1rwZTfeFv+L9MF9FMswpxv327mWq4+YIa1WXd9+YuaYq5UlZPdZLeKKMzyZRoufPYwdgsKsoVVXmyAejzwna/3MVL5tGmhcuHckEqrkP+gKBUei+9ubC8Z/NxDvz/ryRZBUagjXBwjMJ3ldTaVgASe0ipXDmLgiJFksW3KM+Httz96+KS0xrcpOORB+TmB4yUSC9gZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(33430700001)(66574014)(36756003)(316002)(33440700001)(31696002)(54906003)(86362001)(2906002)(6666004)(45080400002)(2616005)(31686004)(83080400001)(66476007)(6916009)(478600001)(52116002)(66946007)(8676002)(5660300002)(966005)(66556008)(8936002)(16526019)(186003)(53546011)(4326008)(6486002)(7416002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: SdhZQQ6mhCPvi4c+Fpxk8+JoE2Ww9yUdCzyn1GPC9kDEXh3MTeRTvspiotd+COtDpyd+EJlTi5+pKl+Zm4A3KTfLiB1rCw741K4yhzkwKO2QnXl+DIOEAyWMmLxmXIzkYNHEnI9hpg5nSlXy2DzrYcvKsty+EjQ9huTuzwh+GCRqIo8qfgKteEnUSKsBHI9QNbufQeFuOcrFCNLDqifiA8iniG6envi3oe6BuzbKUHc+qvTA/IFoAucRr9bK76ytcnfWTzXSa9PcJxEVEAk2bsXzobfc5kN3gNN8hvrzSX9kBuoaPo7+uDj+TFdhJHw/0+FtWF6fgT2vKTHKhPDV07dg4xaHiIK54JRQcj/Qa/49t3AoD6wqBhxvV8tKN6IoRNfwf0Ertrh3VLM6KzuEB33CM/1GLXUQnHAqdDCRXhHRGavQYfcWaWjYcPzO8mC8GCX33gv7prKy1Ek8MFIC4lZNNeU2ysV6Bz9P5TqH4hryKFjI4iogbmvTl5xiVOp3ZURM32veqlir4B7tnb8Bw6W3ONfnVD0GhYyRUj0x4nrpwg06+CPWeEMEwsvEAf2b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff748cbe-ae9a-490c-2016-08d7f69a5d50
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 17:31:54.9891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: me42JpesL+B6lOnOYOp30oi347I8a3Z4AdfuKOpW9DQNtgwrjJPAVtCD61V1MVbv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Ah!

So we can't allocate memory while scheduling anything because it could 
be that memory reclaim is waiting for the scheduler to finish pushing 
things to the hardware, right?

Indeed a nice problem, haven't noticed that one.

Christian.

Am 12.05.20 um 18:27 schrieb Daniel Vetter:
> On Tue, May 12, 2020 at 6:20 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>> On Tue, May 12, 2020 at 5:56 PM Christian König
>> <christian.koenig@amd.com> wrote:
>>> Hui what? Of hand that doesn't looks correct to me.
>> It's not GFP_ATOMIC, it's just that GFP_ATOMIC is the only shotgun we
>> have to avoid direct reclaim. And direct reclaim might need to call
>> into your mmu notifier, which might need to wait on a fence, which is
>> never going to happen because your scheduler is stuck.
>>
>> Note that all the explanations for the deadlocks and stuff I'm trying
>> to hunt here are in the other patches, the driver ones are more
>> informational, so I left these here rather bare-bones to shut up
>> lockdep so I can get through the entire driver and all major areas
>> (scheduler, reset, modeset code).
>>
>> Now you can do something like GFP_NOFS, but the only reasons that
>> works is because the direct reclaim annotations
>> (fs_reclaim_acquire/release) only validates against __GFP_FS, and not
>> against any of the other flags. We should probably add some lockdep
>> annotations so that __GFP_RECLAIM is annotated against the
>> __mmu_notifier_invalidate_range_start_map lockdep map I've recently
>> added for mmu notifiers. End result (assuming I'm not mixing anything
>> up here, this is all rather tricky stuff): GFP_ATOMIC is the only kind
>> of memory allocation you can do.
>>
>>> Why the heck should this be an atomic context? If that's correct
>>> allocating memory is the least of the problems we have.
>> It's not about atomic, it's !__GFP_RECLAIM. Which more or less is
>> GFP_ATOMIC. Correct fix is probably GFP_ATOMIC + a mempool for the
>> scheduler fixes so that if you can't allocate them for some reason,
>> you at least know that your scheduler should eventually retire retire
>> some of them, which you can then pick up from the mempool to guarantee
>> forward progress.
>>
>> But I really didn't dig into details of the code, this was just a quick hack.
>>
>> So sleeping and taking all kinds of locks (but not all, e.g.
>> dma_resv_lock and drm_modeset_lock are no-go) is still totally ok.
>> Just think
>>
>> #define GFP_NO_DIRECT_RECLAIM GFP_ATOMIC
> Maybe slightly different take that's easier to understand: You've
> already made the observation that anything holding adev->notifier_lock
> isn't allowed to allocate memory (well GFP_ATOMIC is ok, like here).
>
> Only thing I'm adding is that the situation is a lot worse. Plus the
> lockdep annotations to help us catch these issues.
> -Daniel
>
>> Cheers, Daniel
>>
>>> Regards,
>>> Christian.
>>>
>>> Am 12.05.20 um 10:59 schrieb Daniel Vetter:
>>>> My dma-fence lockdep annotations caught an inversion because we
>>>> allocate memory where we really shouldn't:
>>>>
>>>>        kmem_cache_alloc+0x2b/0x6d0
>>>>        amdgpu_fence_emit+0x30/0x330 [amdgpu]
>>>>        amdgpu_ib_schedule+0x306/0x550 [amdgpu]
>>>>        amdgpu_job_run+0x10f/0x260 [amdgpu]
>>>>        drm_sched_main+0x1b9/0x490 [gpu_sched]
>>>>        kthread+0x12e/0x150
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
>>>>        __kmalloc+0x58/0x720
>>>>        amdgpu_vmid_grab+0x100/0xca0 [amdgpu]
>>>>        amdgpu_job_dependency+0xf9/0x120 [amdgpu]
>>>>        drm_sched_entity_pop_job+0x3f/0x440 [gpu_sched]
>>>>        drm_sched_main+0xf9/0x490 [gpu_sched]
>>>>
>>>> Second one:
>>>>
>>>>        kmem_cache_alloc+0x2b/0x6d0
>>>>        amdgpu_sync_fence+0x7e/0x110 [amdgpu]
>>>>        amdgpu_vmid_grab+0x86b/0xca0 [amdgpu]
>>>>        amdgpu_job_dependency+0xf9/0x120 [amdgpu]
>>>>        drm_sched_entity_pop_job+0x3f/0x440 [gpu_sched]
>>>>        drm_sched_main+0xf9/0x490 [gpu_sched]
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
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 2 +-
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c   | 2 +-
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c  | 2 +-
>>>>    3 files changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>> index d878fe7fee51..055b47241bb1 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>> @@ -143,7 +143,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>>>>        uint32_t seq;
>>>>        int r;
>>>>
>>>> -     fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_KERNEL);
>>>> +     fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_ATOMIC);
>>>>        if (fence == NULL)
>>>>                return -ENOMEM;
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>>> index fe92dcd94d4a..fdcd6659f5ad 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>>> @@ -208,7 +208,7 @@ static int amdgpu_vmid_grab_idle(struct amdgpu_vm *vm,
>>>>        if (ring->vmid_wait && !dma_fence_is_signaled(ring->vmid_wait))
>>>>                return amdgpu_sync_fence(sync, ring->vmid_wait, false);
>>>>
>>>> -     fences = kmalloc_array(sizeof(void *), id_mgr->num_ids, GFP_KERNEL);
>>>> +     fences = kmalloc_array(sizeof(void *), id_mgr->num_ids, GFP_ATOMIC);
>>>>        if (!fences)
>>>>                return -ENOMEM;
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>> index b87ca171986a..330476cc0c86 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>> @@ -168,7 +168,7 @@ int amdgpu_sync_fence(struct amdgpu_sync *sync, struct dma_fence *f,
>>>>        if (amdgpu_sync_add_later(sync, f, explicit))
>>>>                return 0;
>>>>
>>>> -     e = kmem_cache_alloc(amdgpu_sync_slab, GFP_KERNEL);
>>>> +     e = kmem_cache_alloc(amdgpu_sync_slab, GFP_ATOMIC);
>>>>        if (!e)
>>>>                return -ENOMEM;
>>>>
>>
>> --
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> +41 (0) 79 365 57 48 - https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fblog.ffwll.ch%2F&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C38b330b8aab946f388e908d7f691553b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637248976369551581&amp;sdata=6rrCvEYVug95QXc3yYLbQ8ZN4wyYelfUUGWiyitVpuc%3D&amp;reserved=0
>
>

