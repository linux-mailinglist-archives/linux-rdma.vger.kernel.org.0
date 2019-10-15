Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93F6AD7E9C
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2019 20:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbfJOSQW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Oct 2019 14:16:22 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46440 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfJOSQV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Oct 2019 14:16:21 -0400
Received: by mail-io1-f65.google.com with SMTP id c6so48069576ioo.13
        for <linux-rdma@vger.kernel.org>; Tue, 15 Oct 2019 11:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7bGBHV3XKTBYtn+s2VkOV5vFHFWD1VRFqgigxd7ES8s=;
        b=SZTuPs+9wtwF5qdo+T04vL15d88nht4jzLRt2KERwlIlmEXkDIWhnd1ZVIaUcbfUHB
         3lvX6T61iauTPcUGyedFFKgzQKx0qM38ovl5TsQiW8W9MlH3WDIMXXxhwPZA16J+FlJo
         WOMlNrj+nWtDbfr2oeHLqKkqb9xCx0UH8UPZ8bMwWH9gjlfWyysteaZ05Dwrq+hI0Pj4
         1AWgVI9R2WygWt6WGwALuiMdjbs0zn4/tZ+07Y+GvD+YCexEuaNFKnkovhprSZwmdMpJ
         ndfHvsy43KtDTBSWgQzQDBvwJEzLL1K+mBJJ4RmV5O3OucQZuKa1aj5T3C9OZDphUkNa
         QxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7bGBHV3XKTBYtn+s2VkOV5vFHFWD1VRFqgigxd7ES8s=;
        b=bPvZiDCPwAItq6bKncvpQCmwkqy6mVK74B1RefOKDl097mwWjrjVqjwMbTO5yQyboD
         +FnvtgoosTS3jEh5rDmgKwg7xDGAinRbTidpCmVKu5BfRjL1ti6hgZaOwKRaeh8mdadW
         qP3Yxv7Djs53AxtXc2yPRjuCuet4VUq4fl3LAAy7X/llMrTyf0b1z8R1A3EjXobaqK5M
         hx1q7BukwvJZ6Fu7URxrZFFIXSsWX1gqlK+TIZ7iHAm5218vn+KWhaPucSJDLKCkDZTr
         UjhTA7oYZNJHTWmghZ+BpRVNHtFNRtZIwO5Pw8XT6Q5EybEHDoB3LjpyG92n4HZE7Kw+
         eQyQ==
X-Gm-Message-State: APjAAAXa18a6Hzfa2wZvYnHzVbQwy50+L+L0MhXksYyvLj4Z4IUK4RwU
        aViC92T5ZOvWwLuAKsxYKuJ60w==
X-Google-Smtp-Source: APXvYqzXNjh0fKDKQEyiiqzBWh49cM4XsjfhBudT5whPmb8Cc0287ba+L/26Gqkm2bQl2N5jfKT/5w==
X-Received: by 2002:a05:6e02:783:: with SMTP id q3mr7197819ils.33.1571163380758;
        Tue, 15 Oct 2019 11:16:20 -0700 (PDT)
Received: from ziepe.ca ([24.114.26.129])
        by smtp.gmail.com with ESMTPSA id r5sm2178117ill.12.2019.10.15.11.16.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Oct 2019 11:16:20 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iKRJT-0002Ca-M8; Tue, 15 Oct 2019 15:12:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        nouveau@lists.freedesktop.org
Subject: [PATCH hmm 11/15] nouveau: use mmu_range_notifier instead of hmm_mirror
Date:   Tue, 15 Oct 2019 15:12:38 -0300
Message-Id: <20191015181242.8343-12-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015181242.8343-1-jgg@ziepe.ca>
References: <20191015181242.8343-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Remove the hmm_mirror object and use the mmu_range_notifier API instead
for the range, and use the normal mmu_notifier API for the general
invalidation callback.

While here re-organize the pagefault path so the locking pattern is clear.

nouveau is the only driver that uses a temporary range object and instead
forwards nearly every invalidation range directly to the HW. While this is
not how the mmu_range_notifier was intended to be used, the overheads on
the pagefaulting path are similar to the existing hmm_mirror version.
Particularly since the interval tree will be small.

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 178 ++++++++++++++------------
 1 file changed, 98 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 577f8811925a59..712c99918551bc 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -96,8 +96,6 @@ struct nouveau_svmm {
 	} unmanaged;
 
 	struct mutex mutex;
-
-	struct hmm_mirror mirror;
 };
 
 #define SVMM_DBG(s,f,a...)                                                     \
@@ -293,23 +291,11 @@ static const struct mmu_notifier_ops nouveau_mn_ops = {
 	.free_notifier = nouveau_svmm_free_notifier,
 };
 
-static int
-nouveau_svmm_sync_cpu_device_pagetables(struct hmm_mirror *mirror,
-					const struct mmu_notifier_range *update)
-{
-	return 0;
-}
-
-static const struct hmm_mirror_ops nouveau_svmm = {
-	.sync_cpu_device_pagetables = nouveau_svmm_sync_cpu_device_pagetables,
-};
-
 void
 nouveau_svmm_fini(struct nouveau_svmm **psvmm)
 {
 	struct nouveau_svmm *svmm = *psvmm;
 	if (svmm) {
-		hmm_mirror_unregister(&svmm->mirror);
 		mutex_lock(&svmm->mutex);
 		svmm->vmm = NULL;
 		mutex_unlock(&svmm->mutex);
@@ -357,15 +343,10 @@ nouveau_svmm_init(struct drm_device *dev, void *data,
 		goto out_free;
 
 	down_write(&current->mm->mmap_sem);
-	svmm->mirror.ops = &nouveau_svmm;
-	ret = hmm_mirror_register(&svmm->mirror, current->mm);
-	if (ret)
-		goto out_mm_unlock;
-
 	svmm->notifier.ops = &nouveau_mn_ops;
 	ret = __mmu_notifier_register(&svmm->notifier, current->mm);
 	if (ret)
-		goto out_hmm_unregister;
+		goto out_mm_unlock;
 	/* Note, ownership of svmm transfers to mmu_notifier */
 
 	cli->svm.svmm = svmm;
@@ -374,8 +355,6 @@ nouveau_svmm_init(struct drm_device *dev, void *data,
 	mutex_unlock(&cli->mutex);
 	return 0;
 
-out_hmm_unregister:
-	hmm_mirror_unregister(&svmm->mirror);
 out_mm_unlock:
 	up_write(&current->mm->mmap_sem);
 out_free:
@@ -503,43 +482,89 @@ nouveau_svm_fault_cache(struct nouveau_svm *svm,
 		fault->inst, fault->addr, fault->access);
 }
 
-static inline bool
-nouveau_range_done(struct hmm_range *range)
+struct svm_notifier {
+	struct mmu_range_notifier notifier;
+	struct nouveau_svmm *svmm;
+};
+
+static bool nouveau_svm_range_invalidate(struct mmu_range_notifier *mrn,
+					 const struct mmu_notifier_range *range)
 {
-	bool ret = hmm_range_valid(range);
+	struct svm_notifier *sn =
+		container_of(mrn, struct svm_notifier, notifier);
 
-	hmm_range_unregister(range);
-	return ret;
+	/*
+	 * serializes the update to mrn->invalidate_seq done by caller and
+	 * prevents invalidation of the PTE from progressing while HW is being
+	 * programmed. This is very hacky and only works because the normal
+	 * notifier that does invalidation is always called after the range
+	 * notifier.
+	 */
+	if (mmu_notifier_range_blockable(range))
+		mutex_lock(&sn->svmm->mutex);
+	else if (!mutex_trylock(&sn->svmm->mutex))
+		return false;
+	mutex_unlock(&sn->svmm->mutex);
+	return true;
 }
 
-static int
-nouveau_range_fault(struct nouveau_svmm *svmm, struct hmm_range *range)
+static const struct mmu_range_notifier_ops nouveau_svm_mrn_ops = {
+	.invalidate = nouveau_svm_range_invalidate,
+};
+
+static int nouveau_range_fault(struct nouveau_svmm *svmm,
+			       struct nouveau_drm *drm, void *data, u32 size,
+			       u64 *pfns,
+			       struct svm_notifier *notifier)
 {
+	unsigned long timeout =
+		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
+	/* Have HMM fault pages within the fault window to the GPU. */
+	struct hmm_range range = {
+		.notifier = &notifier->notifier,
+		.start = notifier->notifier.interval_tree.start,
+		.end = notifier->notifier.interval_tree.last + 1,
+		.pfns = pfns,
+		.flags = nouveau_svm_pfn_flags,
+		.values = nouveau_svm_pfn_values,
+		.pfn_shift = NVIF_VMM_PFNMAP_V0_ADDR_SHIFT,
+	};
+	struct mm_struct *mm = notifier->notifier.mm;
 	long ret;
 
-	range->default_flags = 0;
-	range->pfn_flags_mask = -1UL;
+	while (true) {
+		if (time_after(jiffies, timeout))
+			return -EBUSY;
 
-	ret = hmm_range_register(range, &svmm->mirror);
-	if (ret) {
-		up_read(&svmm->notifier.mm->mmap_sem);
-		return (int)ret;
-	}
+		range.notifier_seq = mmu_range_read_begin(range.notifier);
+		range.default_flags = 0;
+		range.pfn_flags_mask = -1UL;
+		down_read(&mm->mmap_sem);
+		ret = hmm_range_fault(&range, 0);
+		up_read(&mm->mmap_sem);
+		if (ret <= 0) {
+			if (ret == 0 || ret == -EBUSY)
+				continue;
+			return ret;
+		}
 
-	if (!hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT)) {
-		up_read(&svmm->notifier.mm->mmap_sem);
-		return -EBUSY;
+		mutex_lock(&svmm->mutex);
+		if (mmu_range_read_retry(range.notifier,
+					 range.notifier_seq)) {
+			mutex_unlock(&svmm->mutex);
+			continue;
+		}
+		break;
 	}
 
-	ret = hmm_range_fault(range, 0);
-	if (ret <= 0) {
-		if (ret == 0)
-			ret = -EBUSY;
-		up_read(&svmm->notifier.mm->mmap_sem);
-		hmm_range_unregister(range);
-		return ret;
-	}
-	return 0;
+	nouveau_dmem_convert_pfn(drm, &range);
+
+	svmm->vmm->vmm.object.client->super = true;
+	ret = nvif_object_ioctl(&svmm->vmm->vmm.object, data, size, NULL);
+	svmm->vmm->vmm.object.client->super = false;
+	mutex_unlock(&svmm->mutex);
+
+	return ret;
 }
 
 static int
@@ -559,7 +584,6 @@ nouveau_svm_fault(struct nvif_notify *notify)
 		} i;
 		u64 phys[16];
 	} args;
-	struct hmm_range range;
 	struct vm_area_struct *vma;
 	u64 inst, start, limit;
 	int fi, fn, pi, fill;
@@ -615,6 +639,7 @@ nouveau_svm_fault(struct nvif_notify *notify)
 	args.i.p.version = 0;
 
 	for (fi = 0; fn = fi + 1, fi < buffer->fault_nr; fi = fn) {
+		struct svm_notifier notifier;
 		struct mm_struct *mm;
 
 		/* Cancel any faults from non-SVM channels. */
@@ -623,7 +648,6 @@ nouveau_svm_fault(struct nvif_notify *notify)
 			continue;
 		}
 		SVMM_DBG(svmm, "addr %016llx", buffer->fault[fi]->addr);
-		mm = svmm->notifier.mm;
 
 		/* We try and group handling of faults within a small
 		 * window into a single update.
@@ -637,6 +661,12 @@ nouveau_svm_fault(struct nvif_notify *notify)
 			start = max_t(u64, start, svmm->unmanaged.limit);
 		SVMM_DBG(svmm, "wndw %016llx-%016llx", start, limit);
 
+		mm = svmm->notifier.mm;
+		if (!mmget_not_zero(mm)) {
+			nouveau_svm_fault_cancel_fault(svm, buffer->fault[fi]);
+			continue;
+		}
+
 		/* Intersect fault window with the CPU VMA, cancelling
 		 * the fault if the address is invalid.
 		 */
@@ -645,16 +675,18 @@ nouveau_svm_fault(struct nvif_notify *notify)
 		if (!vma) {
 			SVMM_ERR(svmm, "wndw %016llx-%016llx", start, limit);
 			up_read(&mm->mmap_sem);
+			mmput(mm);
 			nouveau_svm_fault_cancel_fault(svm, buffer->fault[fi]);
 			continue;
 		}
 		start = max_t(u64, start, vma->vm_start);
 		limit = min_t(u64, limit, vma->vm_end);
+		up_read(&mm->mmap_sem);
 		SVMM_DBG(svmm, "wndw %016llx-%016llx", start, limit);
 
 		if (buffer->fault[fi]->addr != start) {
 			SVMM_ERR(svmm, "addr %016llx", buffer->fault[fi]->addr);
-			up_read(&mm->mmap_sem);
+			mmput(mm);
 			nouveau_svm_fault_cancel_fault(svm, buffer->fault[fi]);
 			continue;
 		}
@@ -710,33 +742,19 @@ nouveau_svm_fault(struct nvif_notify *notify)
 			 args.i.p.addr,
 			 args.i.p.addr + args.i.p.size, fn - fi);
 
-		/* Have HMM fault pages within the fault window to the GPU. */
-		range.start = args.i.p.addr;
-		range.end = args.i.p.addr + args.i.p.size;
-		range.pfns = args.phys;
-		range.flags = nouveau_svm_pfn_flags;
-		range.values = nouveau_svm_pfn_values;
-		range.pfn_shift = NVIF_VMM_PFNMAP_V0_ADDR_SHIFT;
-again:
-		ret = nouveau_range_fault(svmm, &range);
-		if (ret == 0) {
-			mutex_lock(&svmm->mutex);
-			if (!nouveau_range_done(&range)) {
-				mutex_unlock(&svmm->mutex);
-				goto again;
-			}
-
-			nouveau_dmem_convert_pfn(svm->drm, &range);
-
-			svmm->vmm->vmm.object.client->super = true;
-			ret = nvif_object_ioctl(&svmm->vmm->vmm.object,
-						&args, sizeof(args.i) +
-						pi * sizeof(args.phys[0]),
-						NULL);
-			svmm->vmm->vmm.object.client->super = false;
-			mutex_unlock(&svmm->mutex);
-			up_read(&mm->mmap_sem);
+		notifier.svmm = svmm;
+		notifier.notifier.ops = &nouveau_svm_mrn_ops;
+		ret = mmu_range_notifier_insert(&notifier.notifier,
+						args.i.p.addr, args.i.p.size,
+						svmm->notifier.mm);
+		if (!ret) {
+			ret = nouveau_range_fault(
+				svmm, svm->drm, &args,
+				sizeof(args.i) + pi * sizeof(args.phys[0]),
+				args.phys, &notifier);
+			mmu_range_notifier_remove(&notifier.notifier);
 		}
+		mmput(mm);
 
 		/* Cancel any faults in the window whose pages didn't manage
 		 * to keep their valid bit, or stay writeable when required.
@@ -745,10 +763,10 @@ nouveau_svm_fault(struct nvif_notify *notify)
 		 */
 		while (fi < fn) {
 			struct nouveau_svm_fault *fault = buffer->fault[fi++];
-			pi = (fault->addr - range.start) >> PAGE_SHIFT;
+			pi = (fault->addr - args.i.p.addr) >> PAGE_SHIFT;
 			if (ret ||
-			     !(range.pfns[pi] & NVIF_VMM_PFNMAP_V0_V) ||
-			    (!(range.pfns[pi] & NVIF_VMM_PFNMAP_V0_W) &&
+			     !(args.phys[pi] & NVIF_VMM_PFNMAP_V0_V) ||
+			    (!(args.phys[pi] & NVIF_VMM_PFNMAP_V0_W) &&
 			     fault->access != 0 && fault->access != 3)) {
 				nouveau_svm_fault_cancel_fault(svm, fault);
 				continue;
-- 
2.23.0

