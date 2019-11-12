Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0501F9A74
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2019 21:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfKLUWw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Nov 2019 15:22:52 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35957 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfKLUWw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Nov 2019 15:22:52 -0500
Received: by mail-qk1-f194.google.com with SMTP id d13so15696200qko.3
        for <linux-rdma@vger.kernel.org>; Tue, 12 Nov 2019 12:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vqvN4B+GZDHJfLAROKnQtObwYcG8NnWCYaeQr/r4Yjg=;
        b=i4FIIV1i6W5YGmBKiivnhgSWn7eyQivhbmggGezQ1djWPpk+dSxp4UPWSbxX8yNZIF
         bgYyGPFz71/fPKWkTVutZ4CbeB+KhFw+4GIMak7HwQvDMnRpsTzv8rjTFlw20BMZ1x1+
         fcHS+VrPml4IoTKhndxWOk4Ww2cMeEJjs+EnpZwz5rAJKDPj4CiUjaOL6ZykOdsHkQmw
         U7deZJScunIlf/k9Pwk7lDnBwqtQx3mPakMBr19FjvFEaErQzKw7cagTQpFRY15G4lOx
         NqjtWrp6HazQ5Z8uTZzHt8aZ7hCUm35K2JauHR7vB0jwOrcAyNPuBHOL6IxqQ47IHVo6
         Ivjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vqvN4B+GZDHJfLAROKnQtObwYcG8NnWCYaeQr/r4Yjg=;
        b=tSC0NNdDL9v/+Z+Qp2z0rstT5DUDAoiwT87+83HDjQRtoFUat2UuFxkkvfPEPPH497
         eDsZ92IQWf5XatTzXGa2ueA1k3rz2foZgbE4jWLTv+M5ok2Rw9vndH4o76/Dd5hSfi7a
         A1YunIjn6/k/2UHgiXI4zujSvA19l4zjHyq41dDX7xIqoXiCnf0Il9vpwnqCFC8gIsKT
         Y2ECtot1t23wTWM+8rjjaGplm2VIKB5E4E38srh3QyXzwlbANqFjjwtt7VFYep4SSg/h
         wh1CvyRvc0r75tGpFKs3h9rtu+KXTmoYPXcsZO0awXqetsz9hrIULlDj+uFBUax/pIRq
         gaJw==
X-Gm-Message-State: APjAAAUs+6V1hZeXauub4pD62aqgHVCBX7754j+slmZ55MGaPshtLyXB
        7rRqAaxsXNIslO+DfsEn6KHsiA==
X-Google-Smtp-Source: APXvYqzFu20HWA4PgtAhJHB+bLJq8aqbJo1eqsXCE4xmuI4E5wY3L+M+VCzEsjkRVcXxyC6V5RzbGA==
X-Received: by 2002:a37:4f10:: with SMTP id d16mr17145608qkb.80.1573590168615;
        Tue, 12 Nov 2019 12:22:48 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id x11sm11977678qtk.93.2019.11.12.12.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Nov 2019 12:22:48 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iUcgZ-0003kM-HA; Tue, 12 Nov 2019 16:22:47 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
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
Subject: [PATCH v3 09/14] nouveau: use mmu_interval_notifier instead of hmm_mirror
Date:   Tue, 12 Nov 2019 16:22:26 -0400
Message-Id: <20191112202231.3856-10-jgg@ziepe.ca>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112202231.3856-1-jgg@ziepe.ca>
References: <20191112202231.3856-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Remove the hmm_mirror object and use the mmu_interval_notifier API instead
for the range, and use the normal mmu_notifier API for the general
invalidation callback.

While here re-organize the pagefault path so the locking pattern is clear.

nouveau is the only driver that uses a temporary range object and instead
forwards nearly every invalidation range directly to the HW. While this is
not how the mmu_interval_notifier was intended to be used, the overheads on
the pagefaulting path are similar to the existing hmm_mirror version.
Particularly since the interval tree will be small.

Tested-by: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 179 ++++++++++++++------------
 1 file changed, 99 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 577f8811925a59..df9bf1fd1bc0be 100644
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
@@ -503,43 +482,90 @@ nouveau_svm_fault_cache(struct nouveau_svm *svm,
 		fault->inst, fault->addr, fault->access);
 }
 
-static inline bool
-nouveau_range_done(struct hmm_range *range)
+struct svm_notifier {
+	struct mmu_interval_notifier notifier;
+	struct nouveau_svmm *svmm;
+};
+
+static bool nouveau_svm_range_invalidate(struct mmu_interval_notifier *mni,
+					 const struct mmu_notifier_range *range,
+					 unsigned long cur_seq)
 {
-	bool ret = hmm_range_valid(range);
+	struct svm_notifier *sn =
+		container_of(mni, struct svm_notifier, notifier);
 
-	hmm_range_unregister(range);
-	return ret;
+	/*
+	 * serializes the update to mni->invalidate_seq done by caller and
+	 * prevents invalidation of the PTE from progressing while HW is being
+	 * programmed. This is very hacky and only works because the normal
+	 * notifier that does invalidation is always called after the range
+	 * notifier.
+	 */
+	if (mmu_notifier_range_blockable(range))
+		mutex_lock(&sn->svmm->mutex);
+	else if (!mutex_trylock(&sn->svmm->mutex))
+		return false;
+	mmu_interval_set_seq(mni, cur_seq);
+	mutex_unlock(&sn->svmm->mutex);
+	return true;
 }
 
-static int
-nouveau_range_fault(struct nouveau_svmm *svmm, struct hmm_range *range)
+static const struct mmu_interval_notifier_ops nouveau_svm_mni_ops = {
+	.invalidate = nouveau_svm_range_invalidate,
+};
+
+static int nouveau_range_fault(struct nouveau_svmm *svmm,
+			       struct nouveau_drm *drm, void *data, u32 size,
+			       u64 *pfns, struct svm_notifier *notifier)
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
+		range.notifier_seq = mmu_interval_read_begin(range.notifier);
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
+		if (mmu_interval_read_retry(range.notifier,
+					    range.notifier_seq)) {
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
@@ -559,7 +585,6 @@ nouveau_svm_fault(struct nvif_notify *notify)
 		} i;
 		u64 phys[16];
 	} args;
-	struct hmm_range range;
 	struct vm_area_struct *vma;
 	u64 inst, start, limit;
 	int fi, fn, pi, fill;
@@ -615,6 +640,7 @@ nouveau_svm_fault(struct nvif_notify *notify)
 	args.i.p.version = 0;
 
 	for (fi = 0; fn = fi + 1, fi < buffer->fault_nr; fi = fn) {
+		struct svm_notifier notifier;
 		struct mm_struct *mm;
 
 		/* Cancel any faults from non-SVM channels. */
@@ -623,7 +649,6 @@ nouveau_svm_fault(struct nvif_notify *notify)
 			continue;
 		}
 		SVMM_DBG(svmm, "addr %016llx", buffer->fault[fi]->addr);
-		mm = svmm->notifier.mm;
 
 		/* We try and group handling of faults within a small
 		 * window into a single update.
@@ -637,6 +662,12 @@ nouveau_svm_fault(struct nvif_notify *notify)
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
@@ -645,16 +676,18 @@ nouveau_svm_fault(struct nvif_notify *notify)
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
@@ -710,33 +743,19 @@ nouveau_svm_fault(struct nvif_notify *notify)
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
+		ret = mmu_interval_notifier_insert(&notifier.notifier,
+						   svmm->notifier.mm,
+						   args.i.p.addr, args.i.p.size,
+						   &nouveau_svm_mni_ops);
+		if (!ret) {
+			ret = nouveau_range_fault(
+				svmm, svm->drm, &args,
+				sizeof(args.i) + pi * sizeof(args.phys[0]),
+				args.phys, &notifier);
+			mmu_interval_notifier_remove(&notifier.notifier);
 		}
+		mmput(mm);
 
 		/* Cancel any faults in the window whose pages didn't manage
 		 * to keep their valid bit, or stay writeable when required.
@@ -745,10 +764,10 @@ nouveau_svm_fault(struct nvif_notify *notify)
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
2.24.0

