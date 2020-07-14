Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A8321EF83
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 13:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgGNLkX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 07:40:23 -0400
Received: from mail-eopbgr700053.outbound.protection.outlook.com ([40.107.70.53]:38509
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726332AbgGNLkW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Jul 2020 07:40:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSeIc3z/NY4eYsU9X9g9Wh/2JQy3q/HJeBf8BnO6GAIknbT2ggGw3ro7u9DLZfuk9T1oa+D7N8dR+KBxQDEY4dyAaLOF12I6lxyqth1+oryT8DQWxccJhgRQ+wp9bC/bVWT410XPT9/nKYF2DlkSfOXi4qrJHoz8AwQrNM5Ab1kGH6jP97Y3wvaQEOvoJCEQLxgIQPN7W6XGJJGU1ORgM4N8y8Ih/695yRNa96lS3tlH4nIA41AVW5vcLZ+kSRF5QESETSI9TGnwrpvvv5wWuzR7rEnYUEFmVkdGK59QXM1yszuyaX3bU5b4zMNHwx7yarq9tJDpiy+d96tQ82SLaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hzMVLOPut+jJ7MKav9e4O+GJOdFo4l7xEOk6tjx0Ok=;
 b=OphCxHhvfQ4DhQj69lL8zqjJACWlj/9BI/iNsPiE10NMqeWjfgZ/pCKdb6XnA/ovhvKdEblFAU8BrYEg3GnjHJAdQiP4QklIiqOnsYm7vdt0ESY2Ajoa+HXwCRvW3F//9RxNcWTNP9SU+5gHnPLyik+07GuXF7Rt3IBom3E4CcGaDMd+qfn7gS1QPtfY19h0GSzi9ndPYSrGWdE5ekSqAKkF0+yAF0+S9JF7FBCN1T8YScYK/NBZwwW/R4YGQdwj94T6UNeONaAk2hD5/IxsGc4HoXcTbtkQf8FGjNPhWgSNLIYDpSubldHKycFfr46VVaotBc/hfTjo6/p/lKUwJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hzMVLOPut+jJ7MKav9e4O+GJOdFo4l7xEOk6tjx0Ok=;
 b=Br/TZGo//3EGVr8szeBcvydEkJrm5qP6PQYL+OBWctciiyari37GMm+0I4hNW5ma2AcTMolgu6/7ztIo2aEx/uE8kKEI/iPC2DlUqtloS6ppFvkLAesE+nu7pcC0NZfEtyDTXMqsRn9u5R04tfhSfP+FPjNIPcsVacIhVQZaiho=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4518.namprd12.prod.outlook.com (2603:10b6:208:266::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 14 Jul
 2020 11:40:17 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3195.017; Tue, 14 Jul 2020
 11:40:17 +0000
Subject: Re: [PATCH 19/25] drm/amdgpu: s/GFP_KERNEL/GFP_ATOMIC in scheduler
 code
To:     Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        amd-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-20-daniel.vetter@ffwll.ch>
 <20200714104910.GC3278063@phenom.ffwll.local>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d3e85f62-e427-7f1c-0ff4-842ffe57172e@amd.com>
Date:   Tue, 14 Jul 2020 13:40:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200714104910.GC3278063@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::19) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by FR2P281CA0032.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.9 via Frontend Transport; Tue, 14 Jul 2020 11:40:15 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 53a416dd-bee2-4dd5-2076-08d827eaae41
X-MS-TrafficTypeDiagnostic: MN2PR12MB4518:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4518AAE6DE82510F0DA318EE83610@MN2PR12MB4518.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LxlP2AKtDWUvPfOb1A9XDfeXzN+QercWnh0F73Mojx2whoJIkPaSoydmypFOwKutBs7Ma6D7Ue1Rz+gb0P6cufs19pU3X7ztjnqkmgoklsdky+swd4DV2PZGtJNs5651I0Ekf6AntxP0pS7rxMureMgWK4+PWZx6SE1LN4Bkl8fKnmbs5kT5Xd8gAvbxxkQiu1srTJCjphFp/XxJKVZnKcRt1fjypwVfc8FeBtXi5om1eURuF5bs8W32isK54pZM0tigcIwypiJHRlw4lg+1ccpuHvlnC5QdAUWuxVUFxRe/G6MPNb6SNH8lBf5C4j31UD+SqPnS/UZybOF3TsoAQVb64k1udAKZKxKHhopHY4ikv7feupikrWgcqC8LlSIY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(6666004)(66574015)(54906003)(110136005)(86362001)(8676002)(4326008)(66946007)(66556008)(186003)(316002)(16526019)(478600001)(2616005)(52116002)(7416002)(36756003)(66476007)(2906002)(5660300002)(83380400001)(31686004)(6486002)(31696002)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: tCJjKSQoGgm/m9kDXpSTgyRwePM9ia7dDj+MbziyemCJZwGBDPKH0buFORfhdIxvP5a3OhoRbCGK+wcUgND2IGtccYAbVrkfvuPQIdlpAgmp3eFQjY7UCsmvLG77mWhoE++16gAV7XCVGHkddz0th5gqL9k0I1Re0OgJY1ovt1gthpHyoGE1fXj7dcFg5L7SCkw9A30/csBm4asWgrZYtkPCzGtKAHoZPAayBeIRWx07MEP5Mtzh1QAY+vUUfqS5ie4j1Na5YDsghhvyyTbvaoZVHjvEagccwWQ4OWo7vDy0LHk3lmBmzUZVlUYvpEtzNgvTRm3UKJXyxv7zOIBbLFLju4T5TViA70o0CO8WljkKJZTW4gjQEwlpDxmBDixWJK51PqV2xvTlY+sjnos1iYOil/BPk1RcRgAS0pPX7/3cMcU4VGfx/pyZeHelBym7j9N4cH+s7HLNb2XgrgYZ8tAngCMAdZTVuLxKm0wg9MC9Aaqgd3qHAbgHHWAOqsOLdDgwcN7ZxtQ/iWEXb1bdIjawczupIv/1V1fWIMwXczBP6RN5KpizJyOewOLqECi8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a416dd-bee2-4dd5-2076-08d827eaae41
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 11:40:17.5107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6YkWmVy/DVmQUeeihKCzdZ0nQ1w2msoKg2S7nr1fuIdXVdOk03eSzJb5WduQtcX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4518
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 14.07.20 um 12:49 schrieb Daniel Vetter:
> On Tue, Jul 07, 2020 at 10:12:23PM +0200, Daniel Vetter wrote:
>> My dma-fence lockdep annotations caught an inversion because we
>> allocate memory where we really shouldn't:
>>
>> 	kmem_cache_alloc+0x2b/0x6d0
>> 	amdgpu_fence_emit+0x30/0x330 [amdgpu]
>> 	amdgpu_ib_schedule+0x306/0x550 [amdgpu]
>> 	amdgpu_job_run+0x10f/0x260 [amdgpu]
>> 	drm_sched_main+0x1b9/0x490 [gpu_sched]
>> 	kthread+0x12e/0x150
>>
>> Trouble right now is that lockdep only validates against GFP_FS, which
>> would be good enough for shrinkers. But for mmu_notifiers we actually
>> need !GFP_ATOMIC, since they can be called from any page laundering,
>> even if GFP_NOFS or GFP_NOIO are set.
>>
>> I guess we should improve the lockdep annotations for
>> fs_reclaim_acquire/release.
>>
>> Ofc real fix is to properly preallocate this fence and stuff it into
>> the amdgpu job structure. But GFP_ATOMIC gets the lockdep splat out of
>> the way.
>>
>> v2: Two more allocations in scheduler paths.
>>
>> Frist one:
>>
>> 	__kmalloc+0x58/0x720
>> 	amdgpu_vmid_grab+0x100/0xca0 [amdgpu]
>> 	amdgpu_job_dependency+0xf9/0x120 [amdgpu]
>> 	drm_sched_entity_pop_job+0x3f/0x440 [gpu_sched]
>> 	drm_sched_main+0xf9/0x490 [gpu_sched]
>>
>> Second one:
>>
>> 	kmem_cache_alloc+0x2b/0x6d0
>> 	amdgpu_sync_fence+0x7e/0x110 [amdgpu]
>> 	amdgpu_vmid_grab+0x86b/0xca0 [amdgpu]
>> 	amdgpu_job_dependency+0xf9/0x120 [amdgpu]
>> 	drm_sched_entity_pop_job+0x3f/0x440 [gpu_sched]
>> 	drm_sched_main+0xf9/0x490 [gpu_sched]
>>
>> Cc: linux-media@vger.kernel.org
>> Cc: linaro-mm-sig@lists.linaro.org
>> Cc: linux-rdma@vger.kernel.org
>> Cc: amd-gfx@lists.freedesktop.org
>> Cc: intel-gfx@lists.freedesktop.org
>> Cc: Chris Wilson <chris@chris-wilson.co.uk>
>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Has anyone from amd side started looking into how to fix this properly?

Yeah I checked both and neither are any real problem.

> I looked a bit into fixing this with mempool, and the big guarantee we
> need is that
> - there's a hard upper limit on how many allocations we minimally need to
>    guarantee forward progress. And the entire vmid allocation and
>    amdgpu_sync_fence stuff kinda makes me question that's a valid
>    assumption.

We do have hard upper limits for those.

The VMID allocation could as well just return the fence instead of 
putting it into the sync object IIRC. So that just needs some cleanup 
and can avoid the allocation entirely.

The hardware fence is limited by the number of submissions we can have 
concurrently on the ring buffers, so also not a problem at all.

Regards,
Christian.

>
> - mempool_free must be called without any locks in the way which are held
>    while we call mempool_alloc. Otherwise we again have a nice deadlock
>    with no forward progress. I tried auditing that, but got lost in amdgpu
>    and scheduler code. Some lockdep annotations for mempool.c might help,
>    but they're not going to catch everything. Plus it would be again manual
>    annotations because this is yet another cross-release issue. So not sure
>    that helps at all.
>
> iow, not sure what to do here. Ideas?
>
> Cheers, Daniel
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c   | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c  | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> index 8d84975885cd..a089a827fdfe 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> @@ -143,7 +143,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>>   	uint32_t seq;
>>   	int r;
>>   
>> -	fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_KERNEL);
>> +	fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_ATOMIC);
>>   	if (fence == NULL)
>>   		return -ENOMEM;
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> index 267fa45ddb66..a333ca2d4ddd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> @@ -208,7 +208,7 @@ static int amdgpu_vmid_grab_idle(struct amdgpu_vm *vm,
>>   	if (ring->vmid_wait && !dma_fence_is_signaled(ring->vmid_wait))
>>   		return amdgpu_sync_fence(sync, ring->vmid_wait);
>>   
>> -	fences = kmalloc_array(sizeof(void *), id_mgr->num_ids, GFP_KERNEL);
>> +	fences = kmalloc_array(sizeof(void *), id_mgr->num_ids, GFP_ATOMIC);
>>   	if (!fences)
>>   		return -ENOMEM;
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>> index 8ea6c49529e7..af22b526cec9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>> @@ -160,7 +160,7 @@ int amdgpu_sync_fence(struct amdgpu_sync *sync, struct dma_fence *f)
>>   	if (amdgpu_sync_add_later(sync, f))
>>   		return 0;
>>   
>> -	e = kmem_cache_alloc(amdgpu_sync_slab, GFP_KERNEL);
>> +	e = kmem_cache_alloc(amdgpu_sync_slab, GFP_ATOMIC);
>>   	if (!e)
>>   		return -ENOMEM;
>>   
>> -- 
>> 2.27.0
>>

