Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA7D1D7E9B
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2019 20:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbfJOSQU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Oct 2019 14:16:20 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44127 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfJOSQT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Oct 2019 14:16:19 -0400
Received: by mail-io1-f66.google.com with SMTP id w12so48124451iol.11
        for <linux-rdma@vger.kernel.org>; Tue, 15 Oct 2019 11:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WfIQH4tk+jUOonGw5eHzSQiiQvMtZVfR6+iWlPPVdkI=;
        b=Gkpgm7IB9R36HOjU9V5xHkyYVZnXK17gB3WuhrLWKOvMJVvWgaNEPUNRRA79lhLrun
         u4cUOqpyKACjKLXAQhAKpjMEzrhgHRDnltmeUMduk7Di6yCu8GeKoJdPZIRao7aQ7/3d
         VdQ6/woDJz9R7+KfpiCnYOPiDVsRvy5gyhU8lQ/Afsr1kofR+cd+x+mLJsAWs3q2Wuhb
         4NwkGQAG/3oglPKjNhiwLXqqcxa56WqECl2fsX78Du3tgzeUFo2eE9yJLd4ybhRA+d3m
         HiXQTHjnTyDLKphGQSUL+6lZdKVzzRox/x1CqlUqK51Rg9t8TkFtWG+YFmwv410Q69IE
         YJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WfIQH4tk+jUOonGw5eHzSQiiQvMtZVfR6+iWlPPVdkI=;
        b=cZx6Yp2zvxM63yob7ukeClgFEanOtZS2lApjoRtl8Nwq2miTzjYKqCcCKlAyEAO+ZF
         mVs/FFmM52RceaqW7Aem6J9gl2GbmROx55FJu+f1ZPfBeOHFyRp6TwukziDjxC6FSGuh
         jdbzrMZ7Z0LlZWWCtSeNotgkPBoFiYwP2+eUUcyLSE/KMvPwZ9Ecb/bKTW4KczaBdIgJ
         b/hlgIJw8smiNTTb5oD3JiH5FjYv4+lcksOnUHBv21ZL2hvUSs9Gn6i/8TbwbYsxYbq+
         UPDg9nIcxd2RNExohTJ/7J1yngSb3rc7gPpRAnBOU6g7j9vvawyhbhj2vTgj55WyEAdd
         m3aw==
X-Gm-Message-State: APjAAAX9IdQga/eUsBHzHh8WKJqddZ1y/52mrwcJWQbaGtaBbpP1lYjI
        b9sEmt/ocyXnlvZR7tdyBqcYlQ==
X-Google-Smtp-Source: APXvYqxEjrp/uDemzyvVkjQc4L3qEF8AW7ZLBXVDwz8QrvvO4wa36cushKl2306+frYUuWXlDw8kNg==
X-Received: by 2002:a92:de02:: with SMTP id x2mr7816727ilm.168.1571163378684;
        Tue, 15 Oct 2019 11:16:18 -0700 (PDT)
Received: from ziepe.ca ([24.114.26.129])
        by smtp.gmail.com with ESMTPSA id f12sm13969106iob.58.2019.10.15.11.16.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Oct 2019 11:16:18 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iKRJT-0002Cp-QA; Tue, 15 Oct 2019 15:12:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>
Subject: [PATCH hmm 14/15] drm/amdgpu: Use mmu_range_notifier instead of hmm_mirror
Date:   Tue, 15 Oct 2019 15:12:41 -0300
Message-Id: <20191015181242.8343-15-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015181242.8343-1-jgg@ziepe.ca>
References: <20191015181242.8343-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Convert the collision-retry lock around hmm_range_fault to use the one now
provided by the mmu_range notifier.

Although this driver does not seem to use the collision retry lock that
hmm provides correctly, it can still be converted over to use the
mmu_range_notifier api instead of hmm_mirror without too much trouble.

This also deletes another place where a driver is associating additional
data (struct amdgpu_mn) with a mmu_struct.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: David (ChunMing) Zhou <David1.Zhou@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c        | 130 ------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h        |  49 -------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  76 +++++-----
 5 files changed, 50 insertions(+), 223 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 47700302a08b7f..1bcedb9b477dce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1738,6 +1738,10 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
 			return ret;
 		}
 
+		/*
+		 * FIXME: Cannot ignore the return code, must hold
+		 * notifier_lock
+		 */
 		amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
 
 		/* Mark the BO as valid unless it was invalidated
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 2e53feed40e230..76771f5f0b60ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -607,8 +607,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		e->tv.num_shared = 2;
 
 	amdgpu_bo_list_get_list(p->bo_list, &p->validated);
-	if (p->bo_list->first_userptr != p->bo_list->num_entries)
-		p->mn = amdgpu_mn_get(p->adev, AMDGPU_MN_TYPE_GFX);
 
 	INIT_LIST_HEAD(&duplicates);
 	amdgpu_vm_get_pd_bo(&fpriv->vm, &p->validated, &p->vm_pd);
@@ -1291,11 +1289,11 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	if (r)
 		goto error_unlock;
 
-	/* No memory allocation is allowed while holding the mn lock.
-	 * p->mn is hold until amdgpu_cs_submit is finished and fence is added
-	 * to BOs.
+	/* No memory allocation is allowed while holding the notifier lock.
+	 * The lock is held until amdgpu_cs_submit is finished and fence is
+	 * added to BOs.
 	 */
-	amdgpu_mn_lock(p->mn);
+	mutex_lock(&p->adev->notifier_lock);
 
 	/* If userptr are invalidated after amdgpu_cs_parser_bos(), return
 	 * -EAGAIN, drmIoctl in libdrm will restart the amdgpu_cs_ioctl.
@@ -1338,13 +1336,13 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
 
 	ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
-	amdgpu_mn_unlock(p->mn);
+	mutex_unlock(&p->adev->notifier_lock);
 
 	return 0;
 
 error_abort:
 	drm_sched_job_cleanup(&job->base);
-	amdgpu_mn_unlock(p->mn);
+	mutex_unlock(&p->adev->notifier_lock);
 
 error_unlock:
 	amdgpu_job_free(job);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
index 4ffd7b90f4d907..cf1efe7ffc3a83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
@@ -50,28 +50,6 @@
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
 
-/**
- * amdgpu_mn_lock - take the write side lock for this notifier
- *
- * @mn: our notifier
- */
-void amdgpu_mn_lock(struct amdgpu_mn *mn)
-{
-	if (mn)
-		down_write(&mn->lock);
-}
-
-/**
- * amdgpu_mn_unlock - drop the write side lock for this notifier
- *
- * @mn: our notifier
- */
-void amdgpu_mn_unlock(struct amdgpu_mn *mn)
-{
-	if (mn)
-		up_write(&mn->lock);
-}
-
 /**
  * amdgpu_mn_invalidate_gfx - callback to notify about mm change
  *
@@ -143,92 +121,6 @@ static const struct mmu_range_notifier_ops amdgpu_mn_hsa_ops = {
 	.invalidate = amdgpu_mn_invalidate_hsa,
 };
 
-static int amdgpu_mn_sync_pagetables(struct hmm_mirror *mirror,
-				     const struct mmu_notifier_range *update)
-{
-	struct amdgpu_mn *amn = container_of(mirror, struct amdgpu_mn, mirror);
-
-	if (!mmu_notifier_range_blockable(update))
-		return false;
-
-	down_read(&amn->lock);
-	up_read(&amn->lock);
-	return 0;
-}
-
-/* Low bits of any reasonable mm pointer will be unused due to struct
- * alignment. Use these bits to make a unique key from the mm pointer
- * and notifier type.
- */
-#define AMDGPU_MN_KEY(mm, type) ((unsigned long)(mm) + (type))
-
-static struct hmm_mirror_ops amdgpu_hmm_mirror_ops[] = {
-	[AMDGPU_MN_TYPE_GFX] = {
-		.sync_cpu_device_pagetables = amdgpu_mn_sync_pagetables,
-	},
-	[AMDGPU_MN_TYPE_HSA] = {
-		.sync_cpu_device_pagetables = amdgpu_mn_sync_pagetables,
-	},
-};
-
-/**
- * amdgpu_mn_get - create HMM mirror context
- *
- * @adev: amdgpu device pointer
- * @type: type of MMU notifier context
- *
- * Creates a HMM mirror context for current->mm.
- */
-struct amdgpu_mn *amdgpu_mn_get(struct amdgpu_device *adev,
-				enum amdgpu_mn_type type)
-{
-	struct mm_struct *mm = current->mm;
-	struct amdgpu_mn *amn;
-	unsigned long key = AMDGPU_MN_KEY(mm, type);
-	int r;
-
-	mutex_lock(&adev->mn_lock);
-	if (down_write_killable(&mm->mmap_sem)) {
-		mutex_unlock(&adev->mn_lock);
-		return ERR_PTR(-EINTR);
-	}
-
-	hash_for_each_possible(adev->mn_hash, amn, node, key)
-		if (AMDGPU_MN_KEY(amn->mirror.hmm->mmu_notifier.mm,
-				  amn->type) == key)
-			goto release_locks;
-
-	amn = kzalloc(sizeof(*amn), GFP_KERNEL);
-	if (!amn) {
-		amn = ERR_PTR(-ENOMEM);
-		goto release_locks;
-	}
-
-	amn->adev = adev;
-	init_rwsem(&amn->lock);
-	amn->type = type;
-
-	amn->mirror.ops = &amdgpu_hmm_mirror_ops[type];
-	r = hmm_mirror_register(&amn->mirror, mm);
-	if (r)
-		goto free_amn;
-
-	hash_add(adev->mn_hash, &amn->node, AMDGPU_MN_KEY(mm, type));
-
-release_locks:
-	up_write(&mm->mmap_sem);
-	mutex_unlock(&adev->mn_lock);
-
-	return amn;
-
-free_amn:
-	up_write(&mm->mmap_sem);
-	mutex_unlock(&adev->mn_lock);
-	kfree(amn);
-
-	return ERR_PTR(r);
-}
-
 /**
  * amdgpu_mn_register - register a BO for notifier updates
  *
@@ -263,25 +155,3 @@ void amdgpu_mn_unregister(struct amdgpu_bo *bo)
 	mmu_range_notifier_remove(&bo->notifier);
 	bo->notifier.mm = NULL;
 }
-
-/* flags used by HMM internal, not related to CPU/GPU PTE flags */
-static const uint64_t hmm_range_flags[HMM_PFN_FLAG_MAX] = {
-		(1 << 0), /* HMM_PFN_VALID */
-		(1 << 1), /* HMM_PFN_WRITE */
-		0 /* HMM_PFN_DEVICE_PRIVATE */
-};
-
-static const uint64_t hmm_range_values[HMM_PFN_VALUE_MAX] = {
-		0xfffffffffffffffeUL, /* HMM_PFN_ERROR */
-		0, /* HMM_PFN_NONE */
-		0xfffffffffffffffcUL /* HMM_PFN_SPECIAL */
-};
-
-void amdgpu_hmm_init_range(struct hmm_range *range)
-{
-	if (range) {
-		range->flags = hmm_range_flags;
-		range->values = hmm_range_values;
-		range->pfn_shift = PAGE_SHIFT;
-	}
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
index d73ab2947b22b2..a292238f75ebae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
@@ -30,59 +30,10 @@
 #include <linux/workqueue.h>
 #include <linux/interval_tree.h>
 
-enum amdgpu_mn_type {
-	AMDGPU_MN_TYPE_GFX,
-	AMDGPU_MN_TYPE_HSA,
-};
-
-/**
- * struct amdgpu_mn
- *
- * @adev: amdgpu device pointer
- * @type: type of MMU notifier
- * @work: destruction work item
- * @node: hash table node to find structure by adev and mn
- * @lock: rw semaphore protecting the notifier nodes
- * @mirror: HMM mirror function support
- *
- * Data for each amdgpu device and process address space.
- */
-struct amdgpu_mn {
-	/* constant after initialisation */
-	struct amdgpu_device	*adev;
-	enum amdgpu_mn_type	type;
-
-	/* only used on destruction */
-	struct work_struct	work;
-
-	/* protected by adev->mn_lock */
-	struct hlist_node	node;
-
-	/* objects protected by lock */
-	struct rw_semaphore	lock;
-
-#ifdef CONFIG_HMM_MIRROR
-	/* HMM mirror */
-	struct hmm_mirror	mirror;
-#endif
-};
-
 #if defined(CONFIG_HMM_MIRROR)
-void amdgpu_mn_lock(struct amdgpu_mn *mn);
-void amdgpu_mn_unlock(struct amdgpu_mn *mn);
-struct amdgpu_mn *amdgpu_mn_get(struct amdgpu_device *adev,
-				enum amdgpu_mn_type type);
 int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr);
 void amdgpu_mn_unregister(struct amdgpu_bo *bo);
-void amdgpu_hmm_init_range(struct hmm_range *range);
 #else
-static inline void amdgpu_mn_lock(struct amdgpu_mn *mn) {}
-static inline void amdgpu_mn_unlock(struct amdgpu_mn *mn) {}
-static inline struct amdgpu_mn *amdgpu_mn_get(struct amdgpu_device *adev,
-					      enum amdgpu_mn_type type)
-{
-	return NULL;
-}
 static inline int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr)
 {
 	DRM_WARN_ONCE("HMM_MIRROR kernel config option is not enabled, "
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index c0e41f1f0c2365..65d9824b54f2a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -773,6 +773,20 @@ struct amdgpu_ttm_tt {
 #endif
 };
 
+#ifdef CONFIG_DRM_AMDGPU_USERPTR
+/* flags used by HMM internal, not related to CPU/GPU PTE flags */
+static const uint64_t hmm_range_flags[HMM_PFN_FLAG_MAX] = {
+	(1 << 0), /* HMM_PFN_VALID */
+	(1 << 1), /* HMM_PFN_WRITE */
+	0 /* HMM_PFN_DEVICE_PRIVATE */
+};
+
+static const uint64_t hmm_range_values[HMM_PFN_VALUE_MAX] = {
+	0xfffffffffffffffeUL, /* HMM_PFN_ERROR */
+	0, /* HMM_PFN_NONE */
+	0xfffffffffffffffcUL /* HMM_PFN_SPECIAL */
+};
+
 /**
  * amdgpu_ttm_tt_get_user_pages - get device accessible pages that back user
  * memory and start HMM tracking CPU page table update
@@ -780,29 +794,27 @@ struct amdgpu_ttm_tt {
  * Calling function must call amdgpu_ttm_tt_userptr_range_done() once and only
  * once afterwards to stop HMM tracking
  */
-#if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
-
-#define MAX_RETRY_HMM_RANGE_FAULT	16
-
 int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 {
-	struct hmm_mirror *mirror = bo->mn ? &bo->mn->mirror : NULL;
 	struct ttm_tt *ttm = bo->tbo.ttm;
 	struct amdgpu_ttm_tt *gtt = (void *)ttm;
 	struct mm_struct *mm;
+	struct hmm_range *range;
 	unsigned long start = gtt->userptr;
 	struct vm_area_struct *vma;
-	struct hmm_range *range;
 	unsigned long i;
-	uint64_t *pfns;
 	int r = 0;
 
-	if (unlikely(!mirror)) {
-		DRM_DEBUG_DRIVER("Failed to get hmm_mirror\n");
+	mm = bo->notifier.mm;
+	if (unlikely(!mm)) {
+		DRM_DEBUG_DRIVER("BO is not registered?\n");
 		return -EFAULT;
 	}
 
-	mm = mirror->hmm->mmu_notifier.mm;
+	/* Another get_user_pages is running at the same time?? */
+	if (WARN_ON(gtt->range))
+		return -EFAULT;
+
 	if (!mmget_not_zero(mm)) /* Happens during process shutdown */
 		return -ESRCH;
 
@@ -811,30 +823,24 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 		r = -ENOMEM;
 		goto out;
 	}
+	range->notifier = &bo->notifier;
+	range->flags = hmm_range_flags;
+	range->values = hmm_range_values;
+	range->pfn_shift = PAGE_SHIFT;
+	range->start = bo->notifier.interval_tree.start;
+	range->end = bo->notifier.interval_tree.last + 1;
+	range->default_flags = hmm_range_flags[HMM_PFN_VALID];
+	if (!amdgpu_ttm_tt_is_readonly(ttm))
+		range->default_flags |= range->flags[HMM_PFN_WRITE];
 
-	pfns = kvmalloc_array(ttm->num_pages, sizeof(*pfns), GFP_KERNEL);
-	if (unlikely(!pfns)) {
+	range->pfns = kvmalloc_array(ttm->num_pages, sizeof(*range->pfns),
+				     GFP_KERNEL);
+	if (unlikely(!range->pfns)) {
 		r = -ENOMEM;
 		goto out_free_ranges;
 	}
 
-	amdgpu_hmm_init_range(range);
-	range->default_flags = range->flags[HMM_PFN_VALID];
-	range->default_flags |= amdgpu_ttm_tt_is_readonly(ttm) ?
-				0 : range->flags[HMM_PFN_WRITE];
-	range->pfn_flags_mask = 0;
-	range->pfns = pfns;
-	range->start = start;
-	range->end = start + ttm->num_pages * PAGE_SIZE;
-
-	hmm_range_register(range, mirror);
-
-	/*
-	 * Just wait for range to be valid, safe to ignore return value as we
-	 * will use the return value of hmm_range_fault() below under the
-	 * mmap_sem to ascertain the validity of the range.
-	 */
-	hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT);
+	range->notifier_seq = mmu_range_read_begin(&bo->notifier);
 
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, start);
@@ -855,10 +861,10 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 		goto out_free_pfns;
 
 	for (i = 0; i < ttm->num_pages; i++) {
-		pages[i] = hmm_device_entry_to_page(range, pfns[i]);
+		pages[i] = hmm_device_entry_to_page(range, range->pfns[i]);
 		if (unlikely(!pages[i])) {
 			pr_err("Page fault failed for pfn[%lu] = 0x%llx\n",
-			       i, pfns[i]);
+			       i, range->pfns[i]);
 			r = -ENOMEM;
 
 			goto out_free_pfns;
@@ -873,8 +879,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 out_unlock:
 	up_read(&mm->mmap_sem);
 out_free_pfns:
-	hmm_range_unregister(range);
-	kvfree(pfns);
+	kvfree(range->pfns);
 out_free_ranges:
 	kfree(range);
 out:
@@ -903,9 +908,8 @@ bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm)
 		"No user pages to check\n");
 
 	if (gtt->range) {
-		r = hmm_range_valid(gtt->range);
-		hmm_range_unregister(gtt->range);
-
+		r = mmu_range_read_retry(gtt->range->notifier,
+					 gtt->range->notifier_seq);
 		kvfree(gtt->range->pfns);
 		kfree(gtt->range);
 		gtt->range = NULL;
-- 
2.23.0

