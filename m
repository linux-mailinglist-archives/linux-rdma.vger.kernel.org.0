Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6CD1E79C0
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 21:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfJ1UKw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 16:10:52 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45728 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbfJ1UKv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 16:10:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id q70so9742885qke.12
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 13:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PQZNLb2n/VZGpEmak/Qy43FMq9i6D/cb88Nb6FZ4HCc=;
        b=JDfbNHty1ny9u0tolzz+R0bxyhO0ollb7F5vPylbs5XjRPew3ElqUgkRpnO1KqyNHJ
         lbmxT+WbuV2iqQKttXAinvJg6mLlpZOBkINKsbyZqgOCdsmgbxz+ymyca8lTAo2EIudp
         RdrM54tOjIVl+x7WKO8GaCpeaojoHs5YLsjcx7foxAOaiA94okZYV8o6vQfQCwuPbxr0
         yggvPWtLeAKJS+9waHFzTuYqiUemPetepD5ewVTHRTeKTa3PYZPmq7T889b0g2RSfWRi
         iL7jN1WDPg49bHl8qlfraAoRYGBU7o23Ymndp/Dt+umlDMRAc3zH7TPYUwjq23HTYvtx
         Z/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQZNLb2n/VZGpEmak/Qy43FMq9i6D/cb88Nb6FZ4HCc=;
        b=VrBI8dnVz5NzzMr68Jmkxtmr79BhYsuezqyGhG+J1oRdilrEd9fSA64LtevoidjfbU
         Z2StEJ9Mga6ijSDvyRtBle8LcWx5BGk23Fn8c3pXqJZdgR/8YZjbqGNoKoCxzPcsTM6Z
         aMG85lU5RMgnKzLoHFBwENiQiNkdBiuaB+vxZ1e6v/9lIa4hNATIYvgPl020NGjaTtNY
         9uxYqpJigD/0SoYGZhs4OrL7tvKb6rS/HwiUbcO4MCfkh/FYbOqaUbXtx7RBAwM4kc9t
         b0tVyR0nUqdeS0HVb7paHvC4pwLTBvqb5f8/1L3CeZPdDAUeJZVADGRh3AXwTlbfiDdZ
         N/mQ==
X-Gm-Message-State: APjAAAVYkUTNuCpMo8ftnnlQqVuwc3uu3gATxu5A1OyltE2I5tHFgyLh
        I0Cc9dFJbU88WN1Kc2/hzqS7OA==
X-Google-Smtp-Source: APXvYqzMU7VQvTju2rb3w6e+2fL+RjV7hRaY2VBwnJrbzaMQL58Q1wBtGQ3o/J/TSiYTcAN3ImKl5A==
X-Received: by 2002:a37:6643:: with SMTP id a64mr18555491qkc.144.1572293450333;
        Mon, 28 Oct 2019 13:10:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id u9sm1501115qke.50.2019.10.28.13.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 13:10:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iPBLf-0001h3-HR; Mon, 28 Oct 2019 17:10:43 -0300
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
Subject: [PATCH v2 11/15] nouveau: use mmu_range_notifier instead of hmm_mirror
Date:   Mon, 28 Oct 2019 17:10:28 -0300
Message-Id: <20191028201032.6352-12-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028201032.6352-1-jgg@ziepe.ca>
References: <20191028201032.6352-1-jgg@ziepe.ca>
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
 drivers/gpu/drm/nouveau/nouveau_svm.c | 180 ++++++++++++++------------
 1 file changed, 100 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 577f8811925a59..f27317fbe36f45 100644
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
@@ -503,43 +482,91 @@ nouveau_svm_fault_cache(struct nouveau_svm *svm,
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
+					 const struct mmu_notifier_range *range,
+					 unsigned long cur_seq)
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
+	mmu_range_set_seq(mrn, cur_seq);
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
@@ -559,7 +586,6 @@ nouveau_svm_fault(struct nvif_notify *notify)
 		} i;
 		u64 phys[16];
 	} args;
-	struct hmm_range range;
 	struct vm_area_struct *vma;
 	u64 inst, start, limit;
 	int fi, fn, pi, fill;
@@ -615,6 +641,7 @@ nouveau_svm_fault(struct nvif_notify *notify)
 	args.i.p.version = 0;
 
 	for (fi = 0; fn = fi + 1, fi < buffer->fault_nr; fi = fn) {
+		struct svm_notifier notifier;
 		struct mm_struct *mm;
 
 		/* Cancel any faults from non-SVM channels. */
@@ -623,7 +650,6 @@ nouveau_svm_fault(struct nvif_notify *notify)
 			continue;
 		}
 		SVMM_DBG(svmm, "addr %016llx", buffer->fault[fi]->addr);
-		mm = svmm->notifier.mm;
 
 		/* We try and group handling of faults within a small
 		 * window into a single update.
@@ -637,6 +663,12 @@ nouveau_svm_fault(struct nvif_notify *notify)
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
@@ -645,16 +677,18 @@ nouveau_svm_fault(struct nvif_notify *notify)
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
@@ -710,33 +744,19 @@ nouveau_svm_fault(struct nvif_notify *notify)
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
@@ -745,10 +765,10 @@ nouveau_svm_fault(struct nvif_notify *notify)
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

