Return-Path: <linux-rdma+bounces-3675-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF11928A4E
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2024 15:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3412A1C2415E
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2024 13:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2948315B98F;
	Fri,  5 Jul 2024 13:57:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stargate.chelsio.com (stargate.chelsio.com [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2FA15B980
	for <linux-rdma@vger.kernel.org>; Fri,  5 Jul 2024 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187851; cv=none; b=UF5oE7/YzHMuaSoZzSQ5rlwnJzUXya9EpgliVx/uo6A/l1K5/Nrpsu6OInm+vg+mrcg//ZLQi1fdDjN+7bzGcH4fJhcH5T8xE8B6gkY+nzBXs4uutPpFePGPWTIhLe7GECIxfKI6QRSVTSRBEHzqQZ5iFZP/moFb8TfgmWIGhZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187851; c=relaxed/simple;
	bh=WYBDXrg+MIMbuOEJ3LHYDqg3wlWbivkJuTurwYdHuns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UuXPd39Q/YI6YNOVh5OVkKOeLLFuG96iK5u1HUuR782xBf8tJf0J9/KvdtncOk7xUctBROBsPGrVYzOdvHuLuBMpDkgoDeoWG3bjv3dyIaiMlBe+/lGOPVWHAwea6Uqf2A984UbLPNE0jKhPcHXRv8foiIb8KA1rN2pSsAZNqdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from beagle5.blr.asicdesigners.com (beagle5.blr.asicdesigners.com [10.193.80.119])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 465DFhbJ017029;
	Fri, 5 Jul 2024 06:15:44 -0700
From: Anumula Murali Mohan Reddy <anumula@chelsio.com>
To: jgg@nvidia.com, leonro@nvidia.com
Cc: linux-rdma@vger.kernel.org,
        Anumula Murali Mohan Reddy <anumula@chelsio.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [PATCH for-next] RDMA/cxgb4: use dma_mmap_coherent() for mapping non-contiguous memory
Date: Fri,  5 Jul 2024 18:47:53 +0530
Message-Id: <20240705131753.15550-1-anumula@chelsio.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma_alloc_coherent() allocates contiguous memory irrespective of
iommu mode, but after commit f5ff79fddf0e ("dma-mapping: remove
CONFIG_DMA_REMAP") if iommu is enabled in translate mode,
dma_alloc_coherent() may allocate non-contiguous memory.
Attempt to map this memory results in panic.
This patch fixes the issue by using dma_mmap_coherent() to map each page
to user space.

Fixes: f5ff79fddf0e ("dma-mapping: remove CONFIG_DMA_REMAP")
Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 drivers/infiniband/hw/cxgb4/cq.c       |  4 +++
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h |  2 ++
 drivers/infiniband/hw/cxgb4/provider.c | 48 +++++++++++++++++++++-----
 drivers/infiniband/hw/cxgb4/qp.c       | 14 ++++++++
 4 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
index 5111421f9473..81cfc876fa89 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -1127,12 +1127,16 @@ int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 		mm->key = uresp.key;
 		mm->addr = virt_to_phys(chp->cq.queue);
+		mm->vaddr = chp->cq.queue;
+		mm->dma_addr = chp->cq.dma_addr;
 		mm->len = chp->cq.memsize;
 		insert_mmap(ucontext, mm);
 
 		mm2->key = uresp.gts_key;
 		mm2->addr = chp->cq.bar2_pa;
 		mm2->len = PAGE_SIZE;
+		mm2->vaddr = NULL;
+		mm2->dma_addr = 0;
 		insert_mmap(ucontext, mm2);
 	}
 
diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index f838bb6718af..5eedc6cf0f8c 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -536,6 +536,8 @@ struct c4iw_mm_entry {
 	struct list_head entry;
 	u64 addr;
 	u32 key;
+	void *vaddr;
+	dma_addr_t dma_addr;
 	unsigned len;
 };
 
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 246b739ddb2b..6227775970c9 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -131,6 +131,10 @@ static int c4iw_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 	struct c4iw_mm_entry *mm;
 	struct c4iw_ucontext *ucontext;
 	u64 addr;
+	size_t size;
+	void *vaddr;
+	unsigned long vm_pgoff;
+	dma_addr_t dma_addr;
 
 	pr_debug("pgoff 0x%lx key 0x%x len %d\n", vma->vm_pgoff,
 		 key, len);
@@ -145,6 +149,9 @@ static int c4iw_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 	if (!mm)
 		return -EINVAL;
 	addr = mm->addr;
+	vaddr = mm->vaddr;
+	dma_addr = mm->dma_addr;
+	size = mm->len;
 	kfree(mm);
 
 	if ((addr >= pci_resource_start(rdev->lldi.pdev, 0)) &&
@@ -155,9 +162,17 @@ static int c4iw_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 		 * MA_SYNC register...
 		 */
 		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-		ret = io_remap_pfn_range(vma, vma->vm_start,
-					 addr >> PAGE_SHIFT,
-					 len, vma->vm_page_prot);
+		if (vaddr && is_vmalloc_addr(vaddr)) {
+			vm_pgoff = vma->vm_pgoff;
+			vma->vm_pgoff = 0;
+			ret = dma_mmap_coherent(&rdev->lldi.pdev->dev, vma,
+						vaddr, dma_addr, size);
+			vma->vm_pgoff = vm_pgoff;
+		} else {
+			ret = io_remap_pfn_range(vma, vma->vm_start,
+						 addr >> PAGE_SHIFT,
+						 len, vma->vm_page_prot);
+		}
 	} else if ((addr >= pci_resource_start(rdev->lldi.pdev, 2)) &&
 		   (addr < (pci_resource_start(rdev->lldi.pdev, 2) +
 		    pci_resource_len(rdev->lldi.pdev, 2)))) {
@@ -175,17 +190,32 @@ static int c4iw_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 				vma->vm_page_prot =
 					pgprot_noncached(vma->vm_page_prot);
 		}
-		ret = io_remap_pfn_range(vma, vma->vm_start,
-					 addr >> PAGE_SHIFT,
-					 len, vma->vm_page_prot);
+		if (vaddr && is_vmalloc_addr(vaddr)) {
+			vm_pgoff = vma->vm_pgoff;
+			vma->vm_pgoff = 0;
+			ret = dma_mmap_coherent(&rdev->lldi.pdev->dev, vma,
+						vaddr, dma_addr, size);
+			vma->vm_pgoff = vm_pgoff;
+		} else {
+			ret = io_remap_pfn_range(vma, vma->vm_start,
+						 addr >> PAGE_SHIFT,
+						 len, vma->vm_page_prot);
+		}
 	} else {
 
 		/*
 		 * Map WQ or CQ contig dma memory...
 		 */
-		ret = remap_pfn_range(vma, vma->vm_start,
-				      addr >> PAGE_SHIFT,
-				      len, vma->vm_page_prot);
+		if (vaddr && is_vmalloc_addr(vaddr)) {
+			vm_pgoff = vma->vm_pgoff;
+			vma->vm_pgoff = 0;
+			ret = dma_mmap_coherent(&rdev->lldi.pdev->dev, vma,
+						vaddr, dma_addr, size);
+		} else {
+			ret = remap_pfn_range(vma, vma->vm_start,
+					      addr >> PAGE_SHIFT,
+					      len, vma->vm_page_prot);
+		}
 	}
 
 	return ret;
diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index d16d8eaa1415..3f6fb4b34d5a 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -2282,16 +2282,22 @@ int c4iw_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attrs,
 			goto err_free_ma_sync_key;
 		sq_key_mm->key = uresp.sq_key;
 		sq_key_mm->addr = qhp->wq.sq.phys_addr;
+		sq_key_mm->vaddr = qhp->wq.sq.queue;
+		sq_key_mm->dma_addr = qhp->wq.sq.dma_addr;
 		sq_key_mm->len = PAGE_ALIGN(qhp->wq.sq.memsize);
 		insert_mmap(ucontext, sq_key_mm);
 		if (!attrs->srq) {
 			rq_key_mm->key = uresp.rq_key;
 			rq_key_mm->addr = virt_to_phys(qhp->wq.rq.queue);
+			rq_key_mm->vaddr = qhp->wq.rq.queue;
+			rq_key_mm->dma_addr = qhp->wq.rq.dma_addr;
 			rq_key_mm->len = PAGE_ALIGN(qhp->wq.rq.memsize);
 			insert_mmap(ucontext, rq_key_mm);
 		}
 		sq_db_key_mm->key = uresp.sq_db_gts_key;
 		sq_db_key_mm->addr = (u64)(unsigned long)qhp->wq.sq.bar2_pa;
+		sq_db_key_mm->vaddr = NULL;
+		sq_db_key_mm->dma_addr = 0;
 		sq_db_key_mm->len = PAGE_SIZE;
 		insert_mmap(ucontext, sq_db_key_mm);
 		if (!attrs->srq) {
@@ -2299,6 +2305,8 @@ int c4iw_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attrs,
 			rq_db_key_mm->addr =
 				(u64)(unsigned long)qhp->wq.rq.bar2_pa;
 			rq_db_key_mm->len = PAGE_SIZE;
+			rq_db_key_mm->vaddr = NULL;
+			rq_db_key_mm->dma_addr = 0;
 			insert_mmap(ucontext, rq_db_key_mm);
 		}
 		if (ma_sync_key_mm) {
@@ -2307,6 +2315,8 @@ int c4iw_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attrs,
 				(pci_resource_start(rhp->rdev.lldi.pdev, 0) +
 				PCIE_MA_SYNC_A) & PAGE_MASK;
 			ma_sync_key_mm->len = PAGE_SIZE;
+			ma_sync_key_mm->vaddr = NULL;
+			ma_sync_key_mm->dma_addr = 0;
 			insert_mmap(ucontext, ma_sync_key_mm);
 		}
 
@@ -2763,10 +2773,14 @@ int c4iw_create_srq(struct ib_srq *ib_srq, struct ib_srq_init_attr *attrs,
 		srq_key_mm->key = uresp.srq_key;
 		srq_key_mm->addr = virt_to_phys(srq->wq.queue);
 		srq_key_mm->len = PAGE_ALIGN(srq->wq.memsize);
+		srq_key_mm->vaddr = srq->wq.queue;
+		srq_key_mm->dma_addr = srq->wq.dma_addr;
 		insert_mmap(ucontext, srq_key_mm);
 		srq_db_key_mm->key = uresp.srq_db_gts_key;
 		srq_db_key_mm->addr = (u64)(unsigned long)srq->wq.bar2_pa;
 		srq_db_key_mm->len = PAGE_SIZE;
+		srq_db_key_mm->vaddr = NULL;
+		srq_db_key_mm->dma_addr = 0;
 		insert_mmap(ucontext, srq_db_key_mm);
 	}
 
-- 
2.39.3


