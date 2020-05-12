Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504271CF9EF
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 17:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbgELP4y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 11:56:54 -0400
Received: from mail-bn8nam12on2063.outbound.protection.outlook.com ([40.107.237.63]:53793
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727099AbgELP4x (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 11:56:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLxkldQbAZ3OquT1j3BO0CJUKn/TEa4ruA7GCeMHXorAXzBcHgXY8IwxFg5+jxz+Pi8u5MEbG3tXFPXEqdQWw/W2hgrsW6qH1Bk7e6GDW6/Q40+G3tfY4S1HoNSOCk/B1kXR4Oe+3085Qfvz8LesvbmBPJ4rvZS7daotg9p1loWStvqMx+gE0VJhOaDzOk7Yr/Mvzrpk4cdPDlK12N7x0BwrW832he52moC9XvlqurU1ayGcwb7y5F6PKx9lOAdycAEvRyrBs3FRScsncBOuQIYoCobIYCQHeu3rHBP8IL30QVG9SKnQFTcWi5MvcQFF0vur/sPGIcxsyEQ+n3wlPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m76jCPLZqvFAvjX95FNc4uGTJgpMuzxOLhlUpWFTdOY=;
 b=CVD50e/fSaBmrquaawf9gSmzHavUqBcd9/+tNXNFYgblrUcKyeE87izCU7rYFJ+MObBGyzoMwVekbZJdNZ3I3cALgQdY/rh8duPKpu4ucA/1Va2fTWMOfAprEzDfB5WP5gMbnvl+nN4OPy6STcxvh4ociCP+vYtqlVQMcv5h9sLqhBjqm01pNpoM3P53u2GQkkw69NWUB6wMt2CO16Oah5GIrJ+2DgDAZpRBw9oLYt0/uuX8SAn8ibtc5y0n56gu3FoAk3nTo3QqrJZJWt2BdKDL73QgG5EE+0+JYdEsLQG9nylDUGA/XQ0MNr3Zga0PUMYK31Pbd8m9MNrQg88Rvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m76jCPLZqvFAvjX95FNc4uGTJgpMuzxOLhlUpWFTdOY=;
 b=tUNXG2RxqmlFMlEvnh+YZ4dIQWDDvgqHNCF4HrPqsbkxVjQUJgz+8KOfdQGUVCf7W7NhXIaRyCqxKLGpX12kXlN7s0Dg7uHQ72R5otRFXoB3u/u/xnnhceEk2d2jILBT8Np6CGru1pXtagj8y6Pv9VndWAMlbK55Ce9Q9aZL/oQ=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3081.namprd12.prod.outlook.com (2603:10b6:5:38::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Tue, 12 May
 2020 15:56:50 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 15:56:50 +0000
Subject: Re: [RFC 10/17] drm/amdgpu: s/GFP_KERNEL/GFP_ATOMIC in scheduler code
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
 <20200512085944.222637-11-daniel.vetter@ffwll.ch>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <879b127e-2180-bc59-f522-252416a7ac01@amd.com>
Date:   Tue, 12 May 2020 17:56:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200512085944.222637-11-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::21) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Tue, 12 May 2020 15:56:47 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 99439c64-eb47-4a93-8c70-08d7f68d14be
X-MS-TrafficTypeDiagnostic: DM6PR12MB3081:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3081CA6BC4F5CAE7736BDB4B83BE0@DM6PR12MB3081.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ydIa+oJHoAiqPNjZr4kFe48iSUaYv5Lb7i8g4kn7vN/38nqf+vQzmrcIC05J32iMFPbFMscxvbjLlWhl/QVI7lhP1z6oDLWF/OFu7YoRrJYYW78i8YYAXcn9NR74Jc+MAYY0uILe5PwyzmMAp3zdUEd614fXTXafoDsK4UpCzLdzkOOiyHXkFl99GizfzjP9REwz+GgALlVqQZ2lchetP9GyPACHubiAxYeRamqPxMT6Plw7tWpPoSBPoFQsF3EFEKgA8W/FKNSbSYKystoFe0FzTvazOFrfbQmoPBdhrArClPwCefCGl2kYS+uTADP4vf+p5yUQn95qaqpb7XtuJ0c3ssCRthdcU/tz9xT9J78BXFxYEm+zrjbaxdjSw3s1vmI9eNdsPJ8VO0OcJHRwGHVTSg5Dl6mB/9+DIdQXZP+5EvVCmp87cPEjY9LvqVXH8k3dcnXFw02X9hHD1WCq/orkNMX32c/0EyNtBRpYLrfeq3cWdMFukgTNFCG4hhllt2G8QzT9X9fTteiqoqHDONMKv0MWc5jiRy2OUC2DQYjUVlyZ+rYRMnaJtTar9bOt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(33430700001)(86362001)(66556008)(16526019)(5660300002)(66476007)(31696002)(54906003)(52116002)(316002)(66946007)(478600001)(6666004)(33440700001)(110136005)(2906002)(31686004)(36756003)(8676002)(186003)(7416002)(2616005)(6486002)(8936002)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: LrxnlV7hPQUPawhqdOBYuAHH/w0GjYZGu7iUKxEQVcWRaBJbL9TxZou1Qrkl54X9iDl3pFofC7wuoMfaEYJ6YdCJepbu21BLLugsyJ4FO4INwBTTh8ZlKR9osWo5PS9+Kxy1yDBTLOXCtQ2MpaJYY7M9K2wRRfJcU8tc7Va7tftol7LZ88EN8pz8ZEc4jprEi3ucu9iGZM3IXB4XbJoutO0fFid4iyDli0egucfRqc+MxYvBynSKE1tfOhfKlcKrMkAR5kGoR6GFexvINGRVXoGdgiqbm8oinXpR9Fl0DFU1w4797rTuwZmxH33Pj0MaHrtilgWq0fUR2TizpaEhyYmqEImxd5vH1kOk74eWrqDoj/UYl3ssOxec+dKGJdpAkaaKkhfeup+ZElNCI5rmTw3nTm5dAOObH91+uyanuUq/WN+JA3MpFD8t84b/rUA7gx/46KB70Jgq7AxylH7YvgQpOcDfkglylXFIRtSqjARv4wnxBHfYgnlKkPvNrgUAKlMs1jCdm1G5uvkClnFERxaSD/k4G/wAEq8qIJ75czX9JR/wGwO09ctApqbYkhOA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99439c64-eb47-4a93-8c70-08d7f68d14be
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 15:56:49.9439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lz5PA8s8e2i6SsSo4/rCGGe+q05HFhHV+zyK1nEBKpRRtm0qtWQaRFuK4ceKTC83
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3081
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hui what? Of hand that doesn't looks correct to me.

Why the heck should this be an atomic context? If that's correct 
allocating memory is the least of the problems we have.

Regards,
Christian.

Am 12.05.20 um 10:59 schrieb Daniel Vetter:
> My dma-fence lockdep annotations caught an inversion because we
> allocate memory where we really shouldn't:
>
> 	kmem_cache_alloc+0x2b/0x6d0
> 	amdgpu_fence_emit+0x30/0x330 [amdgpu]
> 	amdgpu_ib_schedule+0x306/0x550 [amdgpu]
> 	amdgpu_job_run+0x10f/0x260 [amdgpu]
> 	drm_sched_main+0x1b9/0x490 [gpu_sched]
> 	kthread+0x12e/0x150
>
> Trouble right now is that lockdep only validates against GFP_FS, which
> would be good enough for shrinkers. But for mmu_notifiers we actually
> need !GFP_ATOMIC, since they can be called from any page laundering,
> even if GFP_NOFS or GFP_NOIO are set.
>
> I guess we should improve the lockdep annotations for
> fs_reclaim_acquire/release.
>
> Ofc real fix is to properly preallocate this fence and stuff it into
> the amdgpu job structure. But GFP_ATOMIC gets the lockdep splat out of
> the way.
>
> v2: Two more allocations in scheduler paths.
>
> Frist one:
>
> 	__kmalloc+0x58/0x720
> 	amdgpu_vmid_grab+0x100/0xca0 [amdgpu]
> 	amdgpu_job_dependency+0xf9/0x120 [amdgpu]
> 	drm_sched_entity_pop_job+0x3f/0x440 [gpu_sched]
> 	drm_sched_main+0xf9/0x490 [gpu_sched]
>
> Second one:
>
> 	kmem_cache_alloc+0x2b/0x6d0
> 	amdgpu_sync_fence+0x7e/0x110 [amdgpu]
> 	amdgpu_vmid_grab+0x86b/0xca0 [amdgpu]
> 	amdgpu_job_dependency+0xf9/0x120 [amdgpu]
> 	drm_sched_entity_pop_job+0x3f/0x440 [gpu_sched]
> 	drm_sched_main+0xf9/0x490 [gpu_sched]
>
> Cc: linux-media@vger.kernel.org
> Cc: linaro-mm-sig@lists.linaro.org
> Cc: linux-rdma@vger.kernel.org
> Cc: amd-gfx@lists.freedesktop.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c   | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c  | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index d878fe7fee51..055b47241bb1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -143,7 +143,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>   	uint32_t seq;
>   	int r;
>   
> -	fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_KERNEL);
> +	fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_ATOMIC);
>   	if (fence == NULL)
>   		return -ENOMEM;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index fe92dcd94d4a..fdcd6659f5ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -208,7 +208,7 @@ static int amdgpu_vmid_grab_idle(struct amdgpu_vm *vm,
>   	if (ring->vmid_wait && !dma_fence_is_signaled(ring->vmid_wait))
>   		return amdgpu_sync_fence(sync, ring->vmid_wait, false);
>   
> -	fences = kmalloc_array(sizeof(void *), id_mgr->num_ids, GFP_KERNEL);
> +	fences = kmalloc_array(sizeof(void *), id_mgr->num_ids, GFP_ATOMIC);
>   	if (!fences)
>   		return -ENOMEM;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> index b87ca171986a..330476cc0c86 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> @@ -168,7 +168,7 @@ int amdgpu_sync_fence(struct amdgpu_sync *sync, struct dma_fence *f,
>   	if (amdgpu_sync_add_later(sync, f, explicit))
>   		return 0;
>   
> -	e = kmem_cache_alloc(amdgpu_sync_slab, GFP_KERNEL);
> +	e = kmem_cache_alloc(amdgpu_sync_slab, GFP_ATOMIC);
>   	if (!e)
>   		return -ENOMEM;
>   

