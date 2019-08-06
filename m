Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D390E83DA9
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 01:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfHFXQS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Aug 2019 19:16:18 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45409 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfHFXQS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Aug 2019 19:16:18 -0400
Received: by mail-qt1-f193.google.com with SMTP id x22so13035578qtp.12
        for <linux-rdma@vger.kernel.org>; Tue, 06 Aug 2019 16:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dzzOeMTojFZzc4SDmpKjinKIrvNC9sVRWsnQeUnBSlc=;
        b=iT2jZ5QEHCnRmwj3Fy7Flix3yuM6JMZfZlMd66YumfXZFQGPbYnOuPrN2Nfkw15MlA
         AIO8aK6lBmEInROdH9Of3/332lc2HB5S42qr/W/2UIUKnnEndBMdeXDMUMGuGmW1p/5X
         2V9fSmgrxz5r4ozB8rfrhYVEEKHdIhsoNUQQsTCfq9bfSXzc1vCmzCjIC9mqI2MdlycL
         losCEg5d1lwwYehJqUjfY/pnKpJgJIYYu7a4Y2tCpde7gotzr2SCMXURkOCZhZ1LHzu9
         LGt3R9vq4t3nIrE8fpnUEuW7OeTfeGz53wQSaHM3MZcXljasEHmfZblbVGzG8efyMB8t
         WlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dzzOeMTojFZzc4SDmpKjinKIrvNC9sVRWsnQeUnBSlc=;
        b=sSbolTRKxjdan3JI5xH97izUgYG1fz+ys5benWREr5KpVKhf3muqAE2xZFpQu0pSix
         UhoTm8cYh449yZA2UHpqKMQcfFyX/MiFiyoMzyldjR4JlLIJtZ4RPmtMMBtZAi7bj9l+
         RZ1X2JGbvD7AAec6XhZp8E7e5q0n40r+sMSbC4bBVIQhh/xhQAa132NqWcSXUWtCOcvX
         mjlnlObPOs0HsbHRhxIQtmlrAm3xxbrvA5oZcLPic/JRhvuZc/l/UhTyb0j+VhbLxX6I
         zIfTqCDDPQhyb458tjGzUrRWjccOgowJWZn9TQxtVMmXuD3I9Fevm5jn0nfn2JP1eAar
         iZAw==
X-Gm-Message-State: APjAAAWFElUsFRBKoejM5sy7j+q8a3+fVRMU/UmqjffL8M6/4V14h1MJ
        pIijzUeTxaN7n7ycdQ9yNsrsQg==
X-Google-Smtp-Source: APXvYqzZwoBudgHBaayJbkJ+GNCYTi4q4UlbCBCz8/DGe/Mgsz0vD7Z3MTdLgeaTsGPYtDKzYwIczQ==
X-Received: by 2002:a0c:9932:: with SMTP id h47mr5359549qvd.147.1565133376933;
        Tue, 06 Aug 2019 16:16:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id p23sm39124569qke.44.2019.08.06.16.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 16:16:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hv8gg-0006eg-7x; Tue, 06 Aug 2019 20:16:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org,
        Gavin Shan <shangw@linux.vnet.ibm.com>,
        Andrea Righi <andrea@betterlinux.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v3 hmm 05/11] hmm: use mmu_notifier_get/put for 'struct hmm'
Date:   Tue,  6 Aug 2019 20:15:42 -0300
Message-Id: <20190806231548.25242-6-jgg@ziepe.ca>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190806231548.25242-1-jgg@ziepe.ca>
References: <20190806231548.25242-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

This is a significant simplification, it eliminates all the remaining
'hmm' stuff in mm_struct, eliminates krefing along the critical notifier
paths, and takes away all the ugly locking and abuse of page_table_lock.

mmu_notifier_get() provides the single struct hmm per struct mm which
eliminates mm->hmm.

It also directly guarantees that no mmu_notifier op callback is callable
while concurrent free is possible, this eliminates all the krefs inside
the mmu_notifier callbacks.

The remaining krefs in the range code were overly cautious, drivers are
already not permitted to free the mirror while a range exists.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   1 +
 drivers/gpu/drm/nouveau/nouveau_drm.c   |   3 +
 include/linux/hmm.h                     |  12 +--
 include/linux/mm_types.h                |   6 --
 kernel/fork.c                           |   1 -
 mm/hmm.c                                | 121 ++++++------------------
 6 files changed, 33 insertions(+), 111 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f2e8b4238efd49..d50774a5f98ef7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1464,6 +1464,7 @@ static void __exit amdgpu_exit(void)
 	amdgpu_unregister_atpx_handler();
 	amdgpu_sync_fini();
 	amdgpu_fence_slab_fini();
+	mmu_notifier_synchronize();
 }
 
 module_init(amdgpu_init);
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 7c2fcaba42d6c3..a0e48a482452d7 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -28,6 +28,7 @@
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/vga_switcheroo.h>
+#include <linux/mmu_notifier.h>
 
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
@@ -1292,6 +1293,8 @@ nouveau_drm_exit(void)
 #ifdef CONFIG_NOUVEAU_PLATFORM_DRIVER
 	platform_driver_unregister(&nouveau_platform_driver);
 #endif
+	if (IS_ENABLED(CONFIG_DRM_NOUVEAU_SVM))
+		mmu_notifier_synchronize();
 }
 
 module_init(nouveau_drm_init);
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 82265118d94abd..c3902449db6412 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -84,15 +84,12 @@
  * @notifiers: count of active mmu notifiers
  */
 struct hmm {
-	struct mm_struct	*mm;
-	struct kref		kref;
+	struct mmu_notifier	mmu_notifier;
 	spinlock_t		ranges_lock;
 	struct list_head	ranges;
 	struct list_head	mirrors;
-	struct mmu_notifier	mmu_notifier;
 	struct rw_semaphore	mirrors_sem;
 	wait_queue_head_t	wq;
-	struct rcu_head		rcu;
 	long			notifiers;
 };
 
@@ -436,13 +433,6 @@ long hmm_range_dma_unmap(struct hmm_range *range,
  */
 #define HMM_RANGE_DEFAULT_TIMEOUT 1000
 
-/* Below are for HMM internal use only! Not to be used by device driver! */
-static inline void hmm_mm_init(struct mm_struct *mm)
-{
-	mm->hmm = NULL;
-}
-#else /* IS_ENABLED(CONFIG_HMM_MIRROR) */
-static inline void hmm_mm_init(struct mm_struct *mm) {}
 #endif /* IS_ENABLED(CONFIG_HMM_MIRROR) */
 
 #endif /* LINUX_HMM_H */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3a37a89eb7a7c3..525d25d93330f2 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -25,7 +25,6 @@
 
 struct address_space;
 struct mem_cgroup;
-struct hmm;
 
 /*
  * Each physical page in the system has a struct page associated with
@@ -502,11 +501,6 @@ struct mm_struct {
 		atomic_long_t hugetlb_usage;
 #endif
 		struct work_struct async_put_work;
-
-#ifdef CONFIG_HMM_MIRROR
-		/* HMM needs to track a few things per mm */
-		struct hmm *hmm;
-#endif
 	} __randomize_layout;
 
 	/*
diff --git a/kernel/fork.c b/kernel/fork.c
index d8ae0f1b414802..bd4a0762f12f3e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1007,7 +1007,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm_init_owner(mm, p);
 	RCU_INIT_POINTER(mm->exe_file, NULL);
 	mmu_notifier_mm_init(mm);
-	hmm_mm_init(mm);
 	init_tlb_flush_pending(mm);
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
 	mm->pmd_huge_pte = NULL;
diff --git a/mm/hmm.c b/mm/hmm.c
index 9a908902e4cc38..00f94f94906afc 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -26,101 +26,37 @@
 #include <linux/mmu_notifier.h>
 #include <linux/memory_hotplug.h>
 
-static const struct mmu_notifier_ops hmm_mmu_notifier_ops;
-
-/**
- * hmm_get_or_create - register HMM against an mm (HMM internal)
- *
- * @mm: mm struct to attach to
- * Return: an HMM object, either by referencing the existing
- *          (per-process) object, or by creating a new one.
- *
- * This is not intended to be used directly by device drivers. If mm already
- * has an HMM struct then it get a reference on it and returns it. Otherwise
- * it allocates an HMM struct, initializes it, associate it with the mm and
- * returns it.
- */
-static struct hmm *hmm_get_or_create(struct mm_struct *mm)
+static struct mmu_notifier *hmm_alloc_notifier(struct mm_struct *mm)
 {
 	struct hmm *hmm;
 
-	lockdep_assert_held_write(&mm->mmap_sem);
-
-	/* Abuse the page_table_lock to also protect mm->hmm. */
-	spin_lock(&mm->page_table_lock);
-	hmm = mm->hmm;
-	if (mm->hmm && kref_get_unless_zero(&mm->hmm->kref))
-		goto out_unlock;
-	spin_unlock(&mm->page_table_lock);
-
-	hmm = kmalloc(sizeof(*hmm), GFP_KERNEL);
+	hmm = kzalloc(sizeof(*hmm), GFP_KERNEL);
 	if (!hmm)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
+
 	init_waitqueue_head(&hmm->wq);
 	INIT_LIST_HEAD(&hmm->mirrors);
 	init_rwsem(&hmm->mirrors_sem);
-	hmm->mmu_notifier.ops = NULL;
 	INIT_LIST_HEAD(&hmm->ranges);
 	spin_lock_init(&hmm->ranges_lock);
-	kref_init(&hmm->kref);
 	hmm->notifiers = 0;
-	hmm->mm = mm;
-
-	hmm->mmu_notifier.ops = &hmm_mmu_notifier_ops;
-	if (__mmu_notifier_register(&hmm->mmu_notifier, mm)) {
-		kfree(hmm);
-		return NULL;
-	}
-
-	mmgrab(hmm->mm);
-
-	/*
-	 * We hold the exclusive mmap_sem here so we know that mm->hmm is
-	 * still NULL or 0 kref, and is safe to update.
-	 */
-	spin_lock(&mm->page_table_lock);
-	mm->hmm = hmm;
-
-out_unlock:
-	spin_unlock(&mm->page_table_lock);
-	return hmm;
+	return &hmm->mmu_notifier;
 }
 
-static void hmm_free_rcu(struct rcu_head *rcu)
+static void hmm_free_notifier(struct mmu_notifier *mn)
 {
-	struct hmm *hmm = container_of(rcu, struct hmm, rcu);
+	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
 
-	mmdrop(hmm->mm);
+	WARN_ON(!list_empty(&hmm->ranges));
+	WARN_ON(!list_empty(&hmm->mirrors));
 	kfree(hmm);
 }
 
-static void hmm_free(struct kref *kref)
-{
-	struct hmm *hmm = container_of(kref, struct hmm, kref);
-
-	spin_lock(&hmm->mm->page_table_lock);
-	if (hmm->mm->hmm == hmm)
-		hmm->mm->hmm = NULL;
-	spin_unlock(&hmm->mm->page_table_lock);
-
-	mmu_notifier_unregister_no_release(&hmm->mmu_notifier, hmm->mm);
-	mmu_notifier_call_srcu(&hmm->rcu, hmm_free_rcu);
-}
-
-static inline void hmm_put(struct hmm *hmm)
-{
-	kref_put(&hmm->kref, hmm_free);
-}
-
 static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
 	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
 	struct hmm_mirror *mirror;
 
-	/* Bail out if hmm is in the process of being freed */
-	if (!kref_get_unless_zero(&hmm->kref))
-		return;
-
 	/*
 	 * Since hmm_range_register() holds the mmget() lock hmm_release() is
 	 * prevented as long as a range exists.
@@ -137,8 +73,6 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 			mirror->ops->release(mirror);
 	}
 	up_read(&hmm->mirrors_sem);
-
-	hmm_put(hmm);
 }
 
 static void notifiers_decrement(struct hmm *hmm)
@@ -169,9 +103,6 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
 	unsigned long flags;
 	int ret = 0;
 
-	if (!kref_get_unless_zero(&hmm->kref))
-		return 0;
-
 	spin_lock_irqsave(&hmm->ranges_lock, flags);
 	hmm->notifiers++;
 	list_for_each_entry(range, &hmm->ranges, list) {
@@ -206,7 +137,6 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
 out:
 	if (ret)
 		notifiers_decrement(hmm);
-	hmm_put(hmm);
 	return ret;
 }
 
@@ -215,17 +145,15 @@ static void hmm_invalidate_range_end(struct mmu_notifier *mn,
 {
 	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
 
-	if (!kref_get_unless_zero(&hmm->kref))
-		return;
-
 	notifiers_decrement(hmm);
-	hmm_put(hmm);
 }
 
 static const struct mmu_notifier_ops hmm_mmu_notifier_ops = {
 	.release		= hmm_release,
 	.invalidate_range_start	= hmm_invalidate_range_start,
 	.invalidate_range_end	= hmm_invalidate_range_end,
+	.alloc_notifier		= hmm_alloc_notifier,
+	.free_notifier		= hmm_free_notifier,
 };
 
 /*
@@ -237,18 +165,27 @@ static const struct mmu_notifier_ops hmm_mmu_notifier_ops = {
  *
  * To start mirroring a process address space, the device driver must register
  * an HMM mirror struct.
+ *
+ * The caller cannot unregister the hmm_mirror while any ranges are
+ * registered.
+ *
+ * Callers using this function must put a call to mmu_notifier_synchronize()
+ * in their module exit functions.
  */
 int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm)
 {
+	struct mmu_notifier *mn;
+
 	lockdep_assert_held_write(&mm->mmap_sem);
 
 	/* Sanity check */
 	if (!mm || !mirror || !mirror->ops)
 		return -EINVAL;
 
-	mirror->hmm = hmm_get_or_create(mm);
-	if (!mirror->hmm)
-		return -ENOMEM;
+	mn = mmu_notifier_get_locked(&hmm_mmu_notifier_ops, mm);
+	if (IS_ERR(mn))
+		return PTR_ERR(mn);
+	mirror->hmm = container_of(mn, struct hmm, mmu_notifier);
 
 	down_write(&mirror->hmm->mirrors_sem);
 	list_add(&mirror->list, &mirror->hmm->mirrors);
@@ -272,7 +209,7 @@ void hmm_mirror_unregister(struct hmm_mirror *mirror)
 	down_write(&hmm->mirrors_sem);
 	list_del(&mirror->list);
 	up_write(&hmm->mirrors_sem);
-	hmm_put(hmm);
+	mmu_notifier_put(&hmm->mmu_notifier);
 }
 EXPORT_SYMBOL(hmm_mirror_unregister);
 
@@ -880,14 +817,13 @@ int hmm_range_register(struct hmm_range *range,
 	range->end = end;
 
 	/* Prevent hmm_release() from running while the range is valid */
-	if (!mmget_not_zero(hmm->mm))
+	if (!mmget_not_zero(hmm->mmu_notifier.mm))
 		return -EFAULT;
 
 	/* Initialize range to track CPU page table updates. */
 	spin_lock_irqsave(&hmm->ranges_lock, flags);
 
 	range->hmm = hmm;
-	kref_get(&hmm->kref);
 	list_add(&range->list, &hmm->ranges);
 
 	/*
@@ -919,8 +855,7 @@ void hmm_range_unregister(struct hmm_range *range)
 	spin_unlock_irqrestore(&hmm->ranges_lock, flags);
 
 	/* Drop reference taken by hmm_range_register() */
-	mmput(hmm->mm);
-	hmm_put(hmm);
+	mmput(hmm->mmu_notifier.mm);
 
 	/*
 	 * The range is now invalid and the ref on the hmm is dropped, so
@@ -970,14 +905,14 @@ long hmm_range_fault(struct hmm_range *range, unsigned int flags)
 	struct mm_walk mm_walk;
 	int ret;
 
-	lockdep_assert_held(&hmm->mm->mmap_sem);
+	lockdep_assert_held(&hmm->mmu_notifier.mm->mmap_sem);
 
 	do {
 		/* If range is no longer valid force retry. */
 		if (!range->valid)
 			return -EBUSY;
 
-		vma = find_vma(hmm->mm, start);
+		vma = find_vma(hmm->mmu_notifier.mm, start);
 		if (vma == NULL || (vma->vm_flags & device_vma))
 			return -EFAULT;
 
-- 
2.22.0

