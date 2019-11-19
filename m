Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 216A6102D1F
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 20:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfKST75 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 14:59:57 -0500
Received: from mail-eopbgr820080.outbound.protection.outlook.com ([40.107.82.80]:41339
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726792AbfKST74 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Nov 2019 14:59:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdHKf1n6AA9fKDKdMY+ZpcHfOW9c5okOVsVstIO7j1Cn3ej+xp7rJldSgHBMForwXpsMNAjcW8Wh9ilVvuea9bVRzjRhG8isBXKgaR36CMwQVyAhtuOU7DIYxygTu2eBiOZYuwQq9ADUn+4iUmQ9AVEtiOiRmRBxIHl8blNmp8Y0s1KdphUkunI0r9HaYK96zihECC3D1bsXkSuOpHVtSKJ2Lq15i/grYitrV7/dQ3XmG8hDVdECiedkqPooS401ze+ek1Le15FOkq/NyVXCFj03pSABpfcxKFjAA8M53wKV+nfWpjoHoWApJPBZYdVC5rjRRN0J6kRjZnx2QOScwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSYXDeMAN05psprQO41iWZ2GrM0UOoxGgU0DoZIN7Hk=;
 b=MrYEf+pOeIKc2Sa9GfL89/H0EwbDxAYFayvQG3YWQGs7R/KC/6V/4w2dVZYBCFnoaOEyp3RauwZg0mh4Psv5nGwo7tFAQWr1vOvkeMFzLGGPI9W1SsiapRrN72+/FCr6SXeW2sTHGsnAfyDTQ4gmf6VU/nE0GJJuFZpirCKlKJeHbztVaIHi/Qrhqc2nRLfhj5ImDzVazQlxbNQ98uC7KanUVAAd2Af9KYU4IkG3ppLad0UsmpYR7RaEB0nHO3IPnouJwe91typBd+th+AuibL4kb/DlDCz/R34i/arAgdls0ZvLlNG/3GfOcB6jg4BTCZJZR4Yc+O7XHykZI7DtTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSYXDeMAN05psprQO41iWZ2GrM0UOoxGgU0DoZIN7Hk=;
 b=oUhw6Ft0Os6VotvTuoMsrkZO4buKsU4VPP59ZCG2T4h+3iRmGxE+psdCdL8Ic50eqFnSBfvAB85rvYUirJq4QpGpcXd902W9w6QIl0VlXCBx8K5eBsaZes95ewKHZs2Q8wslsFXyDaBLa6FTQvK/fUdF3s+d426kFld4TKziot0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Philip.Yang@amd.com; 
Received: from MN2PR12MB4030.namprd12.prod.outlook.com (10.255.86.25) by
 MN2PR12MB4174.namprd12.prod.outlook.com (10.255.224.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 19 Nov 2019 19:59:47 +0000
Received: from MN2PR12MB4030.namprd12.prod.outlook.com
 ([fe80::b9e3:2087:df4d:1e0a]) by MN2PR12MB4030.namprd12.prod.outlook.com
 ([fe80::b9e3:2087:df4d:1e0a%6]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 19:59:47 +0000
Subject: Re: [PATCH v3 12/14] drm/amdgpu: Use mmu_interval_notifier instead of
 hmm_mirror
To:     Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        nouveau@lists.freedesktop.org, xen-devel@lists.xenproject.org,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@mellanox.com>
References: <20191112202231.3856-1-jgg@ziepe.ca>
 <20191112202231.3856-13-jgg@ziepe.ca>
From:   Philip Yang <philip.yang@amd.com>
Message-ID: <34d0a0d6-9800-be3f-c1f0-4d87b1b4cbdb@amd.com>
Date:   Tue, 19 Nov 2019 14:59:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
In-Reply-To: <20191112202231.3856-13-jgg@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::49)
 To MN2PR12MB4030.namprd12.prod.outlook.com (2603:10b6:208:159::25)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6fbe2520-1a7c-4eee-cbda-08d76d2b077d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4174:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB417438D013404B150B256E6BE64C0@MN2PR12MB4174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 022649CC2C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(189003)(199004)(6486002)(316002)(6436002)(30864003)(229853002)(5660300002)(14444005)(6512007)(31696002)(8936002)(76176011)(4326008)(54906003)(110136005)(58126008)(52116002)(86362001)(23676004)(2486003)(8676002)(81156014)(81166006)(99286004)(6246003)(186003)(36756003)(31686004)(4001150100001)(478600001)(386003)(7416002)(26005)(66946007)(446003)(66556008)(66476007)(6636002)(6506007)(53546011)(305945005)(25786009)(47776003)(6666004)(7736002)(230700001)(486006)(3846002)(2616005)(476003)(6116002)(14454004)(65806001)(65956001)(66066001)(44832011)(2906002)(50466002)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4174;H:MN2PR12MB4030.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cq0PTmd2uTnCej6+cYyMY2/tqp+k2CbRZxPw4YGXc6sufNVJcz8vWxvh2fHbdOT6+io3V2R3UYaXQ553WC03zX5TAs6e2yG8BICHdmTqfsKbzZMj8UDQM5YTnvM2Zr31m/qfnzLj55Jo5OHeytiyFP1srL5pc8Ht8PsxRYmaiKdfIX4+PmjJQFvnkubjzsG85AlvaUZLufHJ4Ew9zmGXMx+I1yvhKa/9nahsQbK2VKaxzOP+IOHW8lUOlIOvoz2OfyGz+3s+V4i4VnI1lSbHUobYpx3eOuJX8qfPSsuIxQqZHwKvxNUIfXkKf9ogemesq58TwcSuADzPWEZibv49XK3PmJ7Snfq7wD69cjGr++9mMF4A11iz7x3drJo493g+NvPQmgPFGOIjXgtbXgZr7aFJdFtrKtkVYynm+sktbsX1AuAXCr5RNQgHX04mdUKr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbe2520-1a7c-4eee-cbda-08d76d2b077d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2019 19:59:47.6968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ij3w6ScInDA8Ei9N9WcygQqTAagFF/062xPkSG+Mrl//z9mKl/1nsYwhEivC5daa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4174
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I test v3 and it works fine.

Regards,
Philip

On 2019-11-12 3:22 p.m., Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> Convert the collision-retry lock around hmm_range_fault to use the one now
> provided by the mmu_interval notifier.
> 
> Although this driver does not seem to use the collision retry lock that
> hmm provides correctly, it can still be converted over to use the
> mmu_interval_notifier api instead of hmm_mirror without too much trouble.
> 
> This also deletes another place where a driver is associating additional
> data (struct amdgpu_mn) with a mmu_struct.
> 
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> Reviewed-by: Philip Yang <Philip.Yang@amd.com>
> Tested-by: Philip Yang <Philip.Yang@amd.com>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  14 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c        | 148 ++----------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h        |  49 ------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 116 ++++++++------
>   5 files changed, 94 insertions(+), 237 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 47700302a08b7f..1bcedb9b477dce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1738,6 +1738,10 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>   			return ret;
>   		}
>   
> +		/*
> +		 * FIXME: Cannot ignore the return code, must hold
> +		 * notifier_lock
> +		 */
>   		amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
>   
>   		/* Mark the BO as valid unless it was invalidated
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 82823d9a8ba887..22c989bca7514c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -603,8 +603,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   		e->tv.num_shared = 2;
>   
>   	amdgpu_bo_list_get_list(p->bo_list, &p->validated);
> -	if (p->bo_list->first_userptr != p->bo_list->num_entries)
> -		p->mn = amdgpu_mn_get(p->adev, AMDGPU_MN_TYPE_GFX);
>   
>   	INIT_LIST_HEAD(&duplicates);
>   	amdgpu_vm_get_pd_bo(&fpriv->vm, &p->validated, &p->vm_pd);
> @@ -1287,11 +1285,11 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   	if (r)
>   		goto error_unlock;
>   
> -	/* No memory allocation is allowed while holding the mn lock.
> -	 * p->mn is hold until amdgpu_cs_submit is finished and fence is added
> -	 * to BOs.
> +	/* No memory allocation is allowed while holding the notifier lock.
> +	 * The lock is held until amdgpu_cs_submit is finished and fence is
> +	 * added to BOs.
>   	 */
> -	amdgpu_mn_lock(p->mn);
> +	mutex_lock(&p->adev->notifier_lock);
>   
>   	/* If userptr are invalidated after amdgpu_cs_parser_bos(), return
>   	 * -EAGAIN, drmIoctl in libdrm will restart the amdgpu_cs_ioctl.
> @@ -1334,13 +1332,13 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   	amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
>   
>   	ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
> -	amdgpu_mn_unlock(p->mn);
> +	mutex_unlock(&p->adev->notifier_lock);
>   
>   	return 0;
>   
>   error_abort:
>   	drm_sched_job_cleanup(&job->base);
> -	amdgpu_mn_unlock(p->mn);
> +	mutex_unlock(&p->adev->notifier_lock);
>   
>   error_unlock:
>   	amdgpu_job_free(job);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> index 9fe1c31ce17a30..828b5167ff128f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> @@ -50,28 +50,6 @@
>   #include "amdgpu.h"
>   #include "amdgpu_amdkfd.h"
>   
> -/**
> - * amdgpu_mn_lock - take the write side lock for this notifier
> - *
> - * @mn: our notifier
> - */
> -void amdgpu_mn_lock(struct amdgpu_mn *mn)
> -{
> -	if (mn)
> -		down_write(&mn->lock);
> -}
> -
> -/**
> - * amdgpu_mn_unlock - drop the write side lock for this notifier
> - *
> - * @mn: our notifier
> - */
> -void amdgpu_mn_unlock(struct amdgpu_mn *mn)
> -{
> -	if (mn)
> -		up_write(&mn->lock);
> -}
> -
>   /**
>    * amdgpu_mn_invalidate_gfx - callback to notify about mm change
>    *
> @@ -94,6 +72,9 @@ static bool amdgpu_mn_invalidate_gfx(struct mmu_interval_notifier *mni,
>   		return false;
>   
>   	mutex_lock(&adev->notifier_lock);
> +
> +	mmu_interval_set_seq(mni, cur_seq);
> +
>   	r = dma_resv_wait_timeout_rcu(bo->tbo.base.resv, true, false,
>   				      MAX_SCHEDULE_TIMEOUT);
>   	mutex_unlock(&adev->notifier_lock);
> @@ -127,6 +108,9 @@ static bool amdgpu_mn_invalidate_hsa(struct mmu_interval_notifier *mni,
>   		return false;
>   
>   	mutex_lock(&adev->notifier_lock);
> +
> +	mmu_interval_set_seq(mni, cur_seq);
> +
>   	amdgpu_amdkfd_evict_userptr(bo->kfd_bo, bo->notifier.mm);
>   	mutex_unlock(&adev->notifier_lock);
>   
> @@ -137,92 +121,6 @@ static const struct mmu_interval_notifier_ops amdgpu_mn_hsa_ops = {
>   	.invalidate = amdgpu_mn_invalidate_hsa,
>   };
>   
> -static int amdgpu_mn_sync_pagetables(struct hmm_mirror *mirror,
> -				     const struct mmu_notifier_range *update)
> -{
> -	struct amdgpu_mn *amn = container_of(mirror, struct amdgpu_mn, mirror);
> -
> -	if (!mmu_notifier_range_blockable(update))
> -		return -EAGAIN;
> -
> -	down_read(&amn->lock);
> -	up_read(&amn->lock);
> -	return 0;
> -}
> -
> -/* Low bits of any reasonable mm pointer will be unused due to struct
> - * alignment. Use these bits to make a unique key from the mm pointer
> - * and notifier type.
> - */
> -#define AMDGPU_MN_KEY(mm, type) ((unsigned long)(mm) + (type))
> -
> -static struct hmm_mirror_ops amdgpu_hmm_mirror_ops[] = {
> -	[AMDGPU_MN_TYPE_GFX] = {
> -		.sync_cpu_device_pagetables = amdgpu_mn_sync_pagetables,
> -	},
> -	[AMDGPU_MN_TYPE_HSA] = {
> -		.sync_cpu_device_pagetables = amdgpu_mn_sync_pagetables,
> -	},
> -};
> -
> -/**
> - * amdgpu_mn_get - create HMM mirror context
> - *
> - * @adev: amdgpu device pointer
> - * @type: type of MMU notifier context
> - *
> - * Creates a HMM mirror context for current->mm.
> - */
> -struct amdgpu_mn *amdgpu_mn_get(struct amdgpu_device *adev,
> -				enum amdgpu_mn_type type)
> -{
> -	struct mm_struct *mm = current->mm;
> -	struct amdgpu_mn *amn;
> -	unsigned long key = AMDGPU_MN_KEY(mm, type);
> -	int r;
> -
> -	mutex_lock(&adev->mn_lock);
> -	if (down_write_killable(&mm->mmap_sem)) {
> -		mutex_unlock(&adev->mn_lock);
> -		return ERR_PTR(-EINTR);
> -	}
> -
> -	hash_for_each_possible(adev->mn_hash, amn, node, key)
> -		if (AMDGPU_MN_KEY(amn->mirror.hmm->mmu_notifier.mm,
> -				  amn->type) == key)
> -			goto release_locks;
> -
> -	amn = kzalloc(sizeof(*amn), GFP_KERNEL);
> -	if (!amn) {
> -		amn = ERR_PTR(-ENOMEM);
> -		goto release_locks;
> -	}
> -
> -	amn->adev = adev;
> -	init_rwsem(&amn->lock);
> -	amn->type = type;
> -
> -	amn->mirror.ops = &amdgpu_hmm_mirror_ops[type];
> -	r = hmm_mirror_register(&amn->mirror, mm);
> -	if (r)
> -		goto free_amn;
> -
> -	hash_add(adev->mn_hash, &amn->node, AMDGPU_MN_KEY(mm, type));
> -
> -release_locks:
> -	up_write(&mm->mmap_sem);
> -	mutex_unlock(&adev->mn_lock);
> -
> -	return amn;
> -
> -free_amn:
> -	up_write(&mm->mmap_sem);
> -	mutex_unlock(&adev->mn_lock);
> -	kfree(amn);
> -
> -	return ERR_PTR(r);
> -}
> -
>   /**
>    * amdgpu_mn_register - register a BO for notifier updates
>    *
> @@ -235,12 +133,12 @@ struct amdgpu_mn *amdgpu_mn_get(struct amdgpu_device *adev,
>   int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr)
>   {
>   	if (bo->kfd_bo)
> -		bo->notifier.ops = &amdgpu_mn_hsa_ops;
> -	else
> -		bo->notifier.ops = &amdgpu_mn_gfx_ops;
> -
> -	return mmu_interval_notifier_insert(&bo->notifier, addr,
> -					    amdgpu_bo_size(bo), current->mm);
> +		return mmu_interval_notifier_insert(&bo->notifier, current->mm,
> +						    addr, amdgpu_bo_size(bo),
> +						    &amdgpu_mn_hsa_ops);
> +	return mmu_interval_notifier_insert(&bo->notifier, current->mm, addr,
> +					    amdgpu_bo_size(bo),
> +					    &amdgpu_mn_gfx_ops);
>   }
>   
>   /**
> @@ -257,25 +155,3 @@ void amdgpu_mn_unregister(struct amdgpu_bo *bo)
>   	mmu_interval_notifier_remove(&bo->notifier);
>   	bo->notifier.mm = NULL;
>   }
> -
> -/* flags used by HMM internal, not related to CPU/GPU PTE flags */
> -static const uint64_t hmm_range_flags[HMM_PFN_FLAG_MAX] = {
> -		(1 << 0), /* HMM_PFN_VALID */
> -		(1 << 1), /* HMM_PFN_WRITE */
> -		0 /* HMM_PFN_DEVICE_PRIVATE */
> -};
> -
> -static const uint64_t hmm_range_values[HMM_PFN_VALUE_MAX] = {
> -		0xfffffffffffffffeUL, /* HMM_PFN_ERROR */
> -		0, /* HMM_PFN_NONE */
> -		0xfffffffffffffffcUL /* HMM_PFN_SPECIAL */
> -};
> -
> -void amdgpu_hmm_init_range(struct hmm_range *range)
> -{
> -	if (range) {
> -		range->flags = hmm_range_flags;
> -		range->values = hmm_range_values;
> -		range->pfn_shift = PAGE_SHIFT;
> -	}
> -}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
> index d73ab2947b22b2..a292238f75ebae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
> @@ -30,59 +30,10 @@
>   #include <linux/workqueue.h>
>   #include <linux/interval_tree.h>
>   
> -enum amdgpu_mn_type {
> -	AMDGPU_MN_TYPE_GFX,
> -	AMDGPU_MN_TYPE_HSA,
> -};
> -
> -/**
> - * struct amdgpu_mn
> - *
> - * @adev: amdgpu device pointer
> - * @type: type of MMU notifier
> - * @work: destruction work item
> - * @node: hash table node to find structure by adev and mn
> - * @lock: rw semaphore protecting the notifier nodes
> - * @mirror: HMM mirror function support
> - *
> - * Data for each amdgpu device and process address space.
> - */
> -struct amdgpu_mn {
> -	/* constant after initialisation */
> -	struct amdgpu_device	*adev;
> -	enum amdgpu_mn_type	type;
> -
> -	/* only used on destruction */
> -	struct work_struct	work;
> -
> -	/* protected by adev->mn_lock */
> -	struct hlist_node	node;
> -
> -	/* objects protected by lock */
> -	struct rw_semaphore	lock;
> -
> -#ifdef CONFIG_HMM_MIRROR
> -	/* HMM mirror */
> -	struct hmm_mirror	mirror;
> -#endif
> -};
> -
>   #if defined(CONFIG_HMM_MIRROR)
> -void amdgpu_mn_lock(struct amdgpu_mn *mn);
> -void amdgpu_mn_unlock(struct amdgpu_mn *mn);
> -struct amdgpu_mn *amdgpu_mn_get(struct amdgpu_device *adev,
> -				enum amdgpu_mn_type type);
>   int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr);
>   void amdgpu_mn_unregister(struct amdgpu_bo *bo);
> -void amdgpu_hmm_init_range(struct hmm_range *range);
>   #else
> -static inline void amdgpu_mn_lock(struct amdgpu_mn *mn) {}
> -static inline void amdgpu_mn_unlock(struct amdgpu_mn *mn) {}
> -static inline struct amdgpu_mn *amdgpu_mn_get(struct amdgpu_device *adev,
> -					      enum amdgpu_mn_type type)
> -{
> -	return NULL;
> -}
>   static inline int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr)
>   {
>   	DRM_WARN_ONCE("HMM_MIRROR kernel config option is not enabled, "
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index c0e41f1f0c2365..c41a26bde852e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -773,6 +773,20 @@ struct amdgpu_ttm_tt {
>   #endif
>   };
>   
> +#ifdef CONFIG_DRM_AMDGPU_USERPTR
> +/* flags used by HMM internal, not related to CPU/GPU PTE flags */
> +static const uint64_t hmm_range_flags[HMM_PFN_FLAG_MAX] = {
> +	(1 << 0), /* HMM_PFN_VALID */
> +	(1 << 1), /* HMM_PFN_WRITE */
> +	0 /* HMM_PFN_DEVICE_PRIVATE */
> +};
> +
> +static const uint64_t hmm_range_values[HMM_PFN_VALUE_MAX] = {
> +	0xfffffffffffffffeUL, /* HMM_PFN_ERROR */
> +	0, /* HMM_PFN_NONE */
> +	0xfffffffffffffffcUL /* HMM_PFN_SPECIAL */
> +};
> +
>   /**
>    * amdgpu_ttm_tt_get_user_pages - get device accessible pages that back user
>    * memory and start HMM tracking CPU page table update
> @@ -780,29 +794,28 @@ struct amdgpu_ttm_tt {
>    * Calling function must call amdgpu_ttm_tt_userptr_range_done() once and only
>    * once afterwards to stop HMM tracking
>    */
> -#if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
> -
> -#define MAX_RETRY_HMM_RANGE_FAULT	16
> -
>   int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
>   {
> -	struct hmm_mirror *mirror = bo->mn ? &bo->mn->mirror : NULL;
>   	struct ttm_tt *ttm = bo->tbo.ttm;
>   	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> -	struct mm_struct *mm;
>   	unsigned long start = gtt->userptr;
>   	struct vm_area_struct *vma;
>   	struct hmm_range *range;
> +	unsigned long timeout;
> +	struct mm_struct *mm;
>   	unsigned long i;
> -	uint64_t *pfns;
>   	int r = 0;
>   
> -	if (unlikely(!mirror)) {
> -		DRM_DEBUG_DRIVER("Failed to get hmm_mirror\n");
> +	mm = bo->notifier.mm;
> +	if (unlikely(!mm)) {
> +		DRM_DEBUG_DRIVER("BO is not registered?\n");
>   		return -EFAULT;
>   	}
>   
> -	mm = mirror->hmm->mmu_notifier.mm;
> +	/* Another get_user_pages is running at the same time?? */
> +	if (WARN_ON(gtt->range))
> +		return -EFAULT;
> +
>   	if (!mmget_not_zero(mm)) /* Happens during process shutdown */
>   		return -ESRCH;
>   
> @@ -811,31 +824,23 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
>   		r = -ENOMEM;
>   		goto out;
>   	}
> +	range->notifier = &bo->notifier;
> +	range->flags = hmm_range_flags;
> +	range->values = hmm_range_values;
> +	range->pfn_shift = PAGE_SHIFT;
> +	range->start = bo->notifier.interval_tree.start;
> +	range->end = bo->notifier.interval_tree.last + 1;
> +	range->default_flags = hmm_range_flags[HMM_PFN_VALID];
> +	if (!amdgpu_ttm_tt_is_readonly(ttm))
> +		range->default_flags |= range->flags[HMM_PFN_WRITE];
>   
> -	pfns = kvmalloc_array(ttm->num_pages, sizeof(*pfns), GFP_KERNEL);
> -	if (unlikely(!pfns)) {
> +	range->pfns = kvmalloc_array(ttm->num_pages, sizeof(*range->pfns),
> +				     GFP_KERNEL);
> +	if (unlikely(!range->pfns)) {
>   		r = -ENOMEM;
>   		goto out_free_ranges;
>   	}
>   
> -	amdgpu_hmm_init_range(range);
> -	range->default_flags = range->flags[HMM_PFN_VALID];
> -	range->default_flags |= amdgpu_ttm_tt_is_readonly(ttm) ?
> -				0 : range->flags[HMM_PFN_WRITE];
> -	range->pfn_flags_mask = 0;
> -	range->pfns = pfns;
> -	range->start = start;
> -	range->end = start + ttm->num_pages * PAGE_SIZE;
> -
> -	hmm_range_register(range, mirror);
> -
> -	/*
> -	 * Just wait for range to be valid, safe to ignore return value as we
> -	 * will use the return value of hmm_range_fault() below under the
> -	 * mmap_sem to ascertain the validity of the range.
> -	 */
> -	hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT);
> -
>   	down_read(&mm->mmap_sem);
>   	vma = find_vma(mm, start);
>   	if (unlikely(!vma || start < vma->vm_start)) {
> @@ -847,18 +852,31 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
>   		r = -EPERM;
>   		goto out_unlock;
>   	}
> +	up_read(&mm->mmap_sem);
> +	timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
>   
> +retry:
> +	range->notifier_seq = mmu_interval_read_begin(&bo->notifier);
> +
> +	down_read(&mm->mmap_sem);
>   	r = hmm_range_fault(range, 0);
>   	up_read(&mm->mmap_sem);
> -
> -	if (unlikely(r < 0))
> +	if (unlikely(r <= 0)) {
> +		/*
> +		 * FIXME: This timeout should encompass the retry from
> +		 * mmu_interval_read_retry() as well.
> +		 */
> +		if ((r == 0 || r == -EBUSY) && !time_after(jiffies, timeout))
> +			goto retry;
>   		goto out_free_pfns;
> +	}
>   
>   	for (i = 0; i < ttm->num_pages; i++) {
> -		pages[i] = hmm_device_entry_to_page(range, pfns[i]);
> +		/* FIXME: The pages cannot be touched outside the notifier_lock */
> +		pages[i] = hmm_device_entry_to_page(range, range->pfns[i]);
>   		if (unlikely(!pages[i])) {
>   			pr_err("Page fault failed for pfn[%lu] = 0x%llx\n",
> -			       i, pfns[i]);
> +			       i, range->pfns[i]);
>   			r = -ENOMEM;
>   
>   			goto out_free_pfns;
> @@ -873,8 +891,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
>   out_unlock:
>   	up_read(&mm->mmap_sem);
>   out_free_pfns:
> -	hmm_range_unregister(range);
> -	kvfree(pfns);
> +	kvfree(range->pfns);
>   out_free_ranges:
>   	kfree(range);
>   out:
> @@ -903,15 +920,18 @@ bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm)
>   		"No user pages to check\n");
>   
>   	if (gtt->range) {
> -		r = hmm_range_valid(gtt->range);
> -		hmm_range_unregister(gtt->range);
> -
> +		/*
> +		 * FIXME: Must always hold notifier_lock for this, and must
> +		 * not ignore the return code.
> +		 */
> +		r = mmu_interval_read_retry(gtt->range->notifier,
> +					 gtt->range->notifier_seq);
>   		kvfree(gtt->range->pfns);
>   		kfree(gtt->range);
>   		gtt->range = NULL;
>   	}
>   
> -	return r;
> +	return !r;
>   }
>   #endif
>   
> @@ -992,10 +1012,18 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm_tt *ttm)
>   	sg_free_table(ttm->sg);
>   
>   #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
> -	if (gtt->range &&
> -	    ttm->pages[0] == hmm_device_entry_to_page(gtt->range,
> -						      gtt->range->pfns[0]))
> -		WARN_ONCE(1, "Missing get_user_page_done\n");
> +	if (gtt->range) {
> +		unsigned long i;
> +
> +		for (i = 0; i < ttm->num_pages; i++) {
> +			if (ttm->pages[i] !=
> +				hmm_device_entry_to_page(gtt->range,
> +					      gtt->range->pfns[i]))
> +				break;
> +		}
> +
> +		WARN((i == ttm->num_pages), "Missing get_user_page_done\n");
> +	}
>   #endif
>   }
>   
> 
