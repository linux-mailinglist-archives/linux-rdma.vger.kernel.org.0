Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA823D7E9F
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2019 20:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731768AbfJOSQ0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Oct 2019 14:16:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46235 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfJOSQ0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Oct 2019 14:16:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id e15so4613569pgu.13
        for <linux-rdma@vger.kernel.org>; Tue, 15 Oct 2019 11:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jB/ndDNYI+4jh+CyWUF8UUfKQRLegAjGY1TRhiwKQXc=;
        b=N4xJngJrShT1OxrKZbQG9x6/yIb5+79QBiXMj1lpmIcL+BJccHYhAJs9kTMIr+CtlM
         wX90Z46B912pvyDptdl0AatmwpW5GMmcel8Labgi3qBpGf96/w/VoFYav9X0152CyVpb
         5Tzuj4SUI/KJEjr/d+92doYCmzSDxQWYQ24Ez5JQGlY08HObkSo4R2WD86x6YtlIEFLw
         jLMbUrbdK4SZKnAbYeaMSBA9CiTskJ0B2jxrt15tzXpQ0p1n+sHjuQQK/PhfEJOBE+W2
         y+BkaJmtSv766ZBaY+cXiywFTwg+yrL4Ct6ojugqh5NLwR0mBvk37pN31PrbMjFdwGPv
         Qc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jB/ndDNYI+4jh+CyWUF8UUfKQRLegAjGY1TRhiwKQXc=;
        b=j/8Fl9Td/qDQku5hOaMSZWsIJ500LpCOsmCVxXquHKxt+da/QpmZGBJwk0cBpCwWdW
         rpdE6PHeXXeZ54uU3ARYCJ1rTs7Vj53bWVkvx/eldKsmWXJIoZi1xXoFb3LqpIrMj9El
         tOou0FYmQbzKqPw/iQsV8v2QtxCMW2FsO514iT//IxqUArzW1vmO4ZecvHpZDrJ7NhaD
         PSPpi+uESIjhs+68ZVhupn8+zOmSk+f1KtEEd6PewBKRPrZsKp0a913mCb5biiLCrhxD
         nYtaPgM8ZtjYztb2f9ozRbXcsJu0ZDYrjBz6U6aLhjvATUuION1zMZz7arNkbVQAACNJ
         izJg==
X-Gm-Message-State: APjAAAWo/DW79HSe5UfIk8XZsvgFxRJzGf6ZAH5gO0E/DRqLU3ewrhMX
        BXlTLcNrtJQCTpie8fkVLreCYA==
X-Google-Smtp-Source: APXvYqzLw7qtOZsBkXKaKR/Fb8zQC8nnhEWIaTLX6At+LhdX97lMepUUiy2XZX4q9vCtVxZ/O5lS6Q==
X-Received: by 2002:a63:df42:: with SMTP id h2mr37595089pgj.405.1571163384987;
        Tue, 15 Oct 2019 11:16:24 -0700 (PDT)
Received: from ziepe.ca ([24.114.26.129])
        by smtp.gmail.com with ESMTPSA id z23sm20143091pgu.16.2019.10.15.11.16.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Oct 2019 11:16:24 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iKRJT-0002CV-Kz; Tue, 15 Oct 2019 15:12:51 -0300
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
Subject: [PATCH hmm 10/15] nouveau: use mmu_notifier directly for invalidate_range_start
Date:   Tue, 15 Oct 2019 15:12:37 -0300
Message-Id: <20191015181242.8343-11-jgg@ziepe.ca>
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

There is no reason to get the invalidate_range_start() callback via an
indirection through hmm_mirror, just register a normal notifier directly.

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 95 ++++++++++++++++++---------
 1 file changed, 63 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 668d4bd0c118f1..577f8811925a59 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -88,6 +88,7 @@ nouveau_ivmm_find(struct nouveau_svm *svm, u64 inst)
 }
 
 struct nouveau_svmm {
+	struct mmu_notifier notifier;
 	struct nouveau_vmm *vmm;
 	struct {
 		unsigned long start;
@@ -96,7 +97,6 @@ struct nouveau_svmm {
 
 	struct mutex mutex;
 
-	struct mm_struct *mm;
 	struct hmm_mirror mirror;
 };
 
@@ -251,10 +251,11 @@ nouveau_svmm_invalidate(struct nouveau_svmm *svmm, u64 start, u64 limit)
 }
 
 static int
-nouveau_svmm_sync_cpu_device_pagetables(struct hmm_mirror *mirror,
-					const struct mmu_notifier_range *update)
+nouveau_svmm_invalidate_range_start(struct mmu_notifier *mn,
+				    const struct mmu_notifier_range *update)
 {
-	struct nouveau_svmm *svmm = container_of(mirror, typeof(*svmm), mirror);
+	struct nouveau_svmm *svmm =
+		container_of(mn, struct nouveau_svmm, notifier);
 	unsigned long start = update->start;
 	unsigned long limit = update->end;
 
@@ -264,6 +265,9 @@ nouveau_svmm_sync_cpu_device_pagetables(struct hmm_mirror *mirror,
 	SVMM_DBG(svmm, "invalidate %016lx-%016lx", start, limit);
 
 	mutex_lock(&svmm->mutex);
+	if (unlikely(!svmm->vmm))
+		goto out;
+
 	if (limit > svmm->unmanaged.start && start < svmm->unmanaged.limit) {
 		if (start < svmm->unmanaged.start) {
 			nouveau_svmm_invalidate(svmm, start,
@@ -273,19 +277,31 @@ nouveau_svmm_sync_cpu_device_pagetables(struct hmm_mirror *mirror,
 	}
 
 	nouveau_svmm_invalidate(svmm, start, limit);
+
+out:
 	mutex_unlock(&svmm->mutex);
 	return 0;
 }
 
-static void
-nouveau_svmm_release(struct hmm_mirror *mirror)
+static void nouveau_svmm_free_notifier(struct mmu_notifier *mn)
+{
+	kfree(container_of(mn, struct nouveau_svmm, notifier));
+}
+
+static const struct mmu_notifier_ops nouveau_mn_ops = {
+	.invalidate_range_start = nouveau_svmm_invalidate_range_start,
+	.free_notifier = nouveau_svmm_free_notifier,
+};
+
+static int
+nouveau_svmm_sync_cpu_device_pagetables(struct hmm_mirror *mirror,
+					const struct mmu_notifier_range *update)
 {
+	return 0;
 }
 
-static const struct hmm_mirror_ops
-nouveau_svmm = {
+static const struct hmm_mirror_ops nouveau_svmm = {
 	.sync_cpu_device_pagetables = nouveau_svmm_sync_cpu_device_pagetables,
-	.release = nouveau_svmm_release,
 };
 
 void
@@ -294,7 +310,10 @@ nouveau_svmm_fini(struct nouveau_svmm **psvmm)
 	struct nouveau_svmm *svmm = *psvmm;
 	if (svmm) {
 		hmm_mirror_unregister(&svmm->mirror);
-		kfree(*psvmm);
+		mutex_lock(&svmm->mutex);
+		svmm->vmm = NULL;
+		mutex_unlock(&svmm->mutex);
+		mmu_notifier_put(&svmm->notifier);
 		*psvmm = NULL;
 	}
 }
@@ -320,7 +339,7 @@ nouveau_svmm_init(struct drm_device *dev, void *data,
 	mutex_lock(&cli->mutex);
 	if (cli->svm.cli) {
 		ret = -EBUSY;
-		goto done;
+		goto out_free;
 	}
 
 	/* Allocate a new GPU VMM that can support SVM (managed by the
@@ -335,24 +354,33 @@ nouveau_svmm_init(struct drm_device *dev, void *data,
 				.fault_replay = true,
 			    }, sizeof(struct gp100_vmm_v0), &cli->svm.vmm);
 	if (ret)
-		goto done;
+		goto out_free;
 
-	/* Enable HMM mirroring of CPU address-space to VMM. */
-	svmm->mm = get_task_mm(current);
-	down_write(&svmm->mm->mmap_sem);
+	down_write(&current->mm->mmap_sem);
 	svmm->mirror.ops = &nouveau_svmm;
-	ret = hmm_mirror_register(&svmm->mirror, svmm->mm);
-	if (ret == 0) {
-		cli->svm.svmm = svmm;
-		cli->svm.cli = cli;
-	}
-	up_write(&svmm->mm->mmap_sem);
-	mmput(svmm->mm);
+	ret = hmm_mirror_register(&svmm->mirror, current->mm);
+	if (ret)
+		goto out_mm_unlock;
 
-done:
+	svmm->notifier.ops = &nouveau_mn_ops;
+	ret = __mmu_notifier_register(&svmm->notifier, current->mm);
 	if (ret)
-		nouveau_svmm_fini(&svmm);
+		goto out_hmm_unregister;
+	/* Note, ownership of svmm transfers to mmu_notifier */
+
+	cli->svm.svmm = svmm;
+	cli->svm.cli = cli;
+	up_write(&current->mm->mmap_sem);
 	mutex_unlock(&cli->mutex);
+	return 0;
+
+out_hmm_unregister:
+	hmm_mirror_unregister(&svmm->mirror);
+out_mm_unlock:
+	up_write(&current->mm->mmap_sem);
+out_free:
+	mutex_unlock(&cli->mutex);
+	kfree(svmm);
 	return ret;
 }
 
@@ -494,12 +522,12 @@ nouveau_range_fault(struct nouveau_svmm *svmm, struct hmm_range *range)
 
 	ret = hmm_range_register(range, &svmm->mirror);
 	if (ret) {
-		up_read(&svmm->mm->mmap_sem);
+		up_read(&svmm->notifier.mm->mmap_sem);
 		return (int)ret;
 	}
 
 	if (!hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT)) {
-		up_read(&svmm->mm->mmap_sem);
+		up_read(&svmm->notifier.mm->mmap_sem);
 		return -EBUSY;
 	}
 
@@ -507,7 +535,7 @@ nouveau_range_fault(struct nouveau_svmm *svmm, struct hmm_range *range)
 	if (ret <= 0) {
 		if (ret == 0)
 			ret = -EBUSY;
-		up_read(&svmm->mm->mmap_sem);
+		up_read(&svmm->notifier.mm->mmap_sem);
 		hmm_range_unregister(range);
 		return ret;
 	}
@@ -587,12 +615,15 @@ nouveau_svm_fault(struct nvif_notify *notify)
 	args.i.p.version = 0;
 
 	for (fi = 0; fn = fi + 1, fi < buffer->fault_nr; fi = fn) {
+		struct mm_struct *mm;
+
 		/* Cancel any faults from non-SVM channels. */
 		if (!(svmm = buffer->fault[fi]->svmm)) {
 			nouveau_svm_fault_cancel_fault(svm, buffer->fault[fi]);
 			continue;
 		}
 		SVMM_DBG(svmm, "addr %016llx", buffer->fault[fi]->addr);
+		mm = svmm->notifier.mm;
 
 		/* We try and group handling of faults within a small
 		 * window into a single update.
@@ -609,11 +640,11 @@ nouveau_svm_fault(struct nvif_notify *notify)
 		/* Intersect fault window with the CPU VMA, cancelling
 		 * the fault if the address is invalid.
 		 */
-		down_read(&svmm->mm->mmap_sem);
-		vma = find_vma_intersection(svmm->mm, start, limit);
+		down_read(&mm->mmap_sem);
+		vma = find_vma_intersection(mm, start, limit);
 		if (!vma) {
 			SVMM_ERR(svmm, "wndw %016llx-%016llx", start, limit);
-			up_read(&svmm->mm->mmap_sem);
+			up_read(&mm->mmap_sem);
 			nouveau_svm_fault_cancel_fault(svm, buffer->fault[fi]);
 			continue;
 		}
@@ -623,7 +654,7 @@ nouveau_svm_fault(struct nvif_notify *notify)
 
 		if (buffer->fault[fi]->addr != start) {
 			SVMM_ERR(svmm, "addr %016llx", buffer->fault[fi]->addr);
-			up_read(&svmm->mm->mmap_sem);
+			up_read(&mm->mmap_sem);
 			nouveau_svm_fault_cancel_fault(svm, buffer->fault[fi]);
 			continue;
 		}
@@ -704,7 +735,7 @@ nouveau_svm_fault(struct nvif_notify *notify)
 						NULL);
 			svmm->vmm->vmm.object.client->super = false;
 			mutex_unlock(&svmm->mutex);
-			up_read(&svmm->mm->mmap_sem);
+			up_read(&mm->mmap_sem);
 		}
 
 		/* Cancel any faults in the window whose pages didn't manage
-- 
2.23.0

