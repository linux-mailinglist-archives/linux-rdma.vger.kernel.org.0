Return-Path: <linux-rdma+bounces-3887-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAC19329CC
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2024 16:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB321F23B6E
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2024 14:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F0719B59D;
	Tue, 16 Jul 2024 14:57:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stargate.chelsio.com (stargate.chelsio.com [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F9819AD6A
	for <linux-rdma@vger.kernel.org>; Tue, 16 Jul 2024 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721141851; cv=none; b=kNFelUWpieBLBzPfBkF7Qt3ca+/ztDagIpRkTle7MBABoWWxslqOw4vXR0xnT+5Crj7Nd0Hg08Zf9uTUokWHtz3seJurJsbTEDf5TkfNkZAK8sg9LNxIV8nLkWMKsEc/y0oVnLu4htwX+rKwY7ekjArw0QBpN968NjSOLVc3F1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721141851; c=relaxed/simple;
	bh=ZHf/XeuN2gvxUB4SXnbp8Kqky0KBDyPx/N5vAMTOSMA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XqCgNu2cjbMcdqGUAPN8rwRp4K+6lDJXkfemHr/RNeVaR+Ebzzt2jNG4UZ15a1enRRWddQ4w+HJ6lEsI3Jkvu5DcGWkkG/2wGJrniC9MX+stFa8VQjNQYcc8Qm8EEHPc38u30wog7N/mj4Fdv2yl5mkrg2lvEdCNNhUB5puAFMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from beagle5.blr.asicdesigners.com (beagle5.blr.asicdesigners.com [10.193.80.119])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 46GEMoug027315;
	Tue, 16 Jul 2024 07:22:51 -0700
From: Anumula Murali Mohan Reddy <anumula@chelsio.com>
To: jgg@nvidia.com, leonro@nvidia.com
Cc: linux-rdma@vger.kernel.org, hch@lst.de,
        Anumula Murali Mohan Reddy <anumula@chelsio.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [PATCH for-next v2] RDMA/cxgb4: use dma_mmap_coherent() for mapping non-contiguous memory
Date: Tue, 16 Jul 2024 19:55:32 +0530
Message-Id: <20240716142532.97423-1-anumula@chelsio.com>
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

Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
Changes since v1:
Addressed previous reveiw comments
Introduced flag to determine the type of memory mapping
Removed fixes line
---
 drivers/infiniband/hw/cxgb4/cq.c       |  8 ++-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h | 35 ++++++++++++++
 drivers/infiniband/hw/cxgb4/provider.c | 67 +++++++++++++-------------
 drivers/infiniband/hw/cxgb4/qp.c       | 27 +++++++++--
 4 files changed, 99 insertions(+), 38 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
index 5111421f9473..14ced7b667fa 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -1126,13 +1126,19 @@ int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 			goto err_free_mm2;
 
 		mm->key = uresp.key;
-		mm->addr = virt_to_phys(chp->cq.queue);
+		mm->addr = 0;
+		mm->vaddr = chp->cq.queue;
+		mm->dma_addr = chp->cq.dma_addr;
 		mm->len = chp->cq.memsize;
+		insert_flag_to_mmap(&rhp->rdev, mm, mm->addr);
 		insert_mmap(ucontext, mm);
 
 		mm2->key = uresp.gts_key;
 		mm2->addr = chp->cq.bar2_pa;
 		mm2->len = PAGE_SIZE;
+		mm2->vaddr = NULL;
+		mm2->dma_addr = 0;
+		insert_flag_to_mmap(&rhp->rdev, mm2, mm2->addr);
 		insert_mmap(ucontext, mm2);
 	}
 
diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index f838bb6718af..82150d28411a 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -532,11 +532,21 @@ static inline struct c4iw_ucontext *to_c4iw_ucontext(struct ib_ucontext *c)
 	return container_of(c, struct c4iw_ucontext, ibucontext);
 }
 
+enum {
+	CXGB4_MMAP_BAR,
+	CXGB4_MMAP_BAR_WC,
+	CXGB4_MMAP_CONTIG,
+	CXGB4_MMAP_NON_CONTIG,
+};
+
 struct c4iw_mm_entry {
 	struct list_head entry;
 	u64 addr;
 	u32 key;
+	void *vaddr;
+	dma_addr_t dma_addr;
 	unsigned len;
+	u8 mmap_flag;
 };
 
 static inline struct c4iw_mm_entry *remove_mmap(struct c4iw_ucontext *ucontext,
@@ -561,6 +571,31 @@ static inline struct c4iw_mm_entry *remove_mmap(struct c4iw_ucontext *ucontext,
 	return NULL;
 }
 
+static inline void insert_flag_to_mmap(struct c4iw_rdev *rdev, struct c4iw_mm_entry *mm, u64 addr)
+{
+	if (addr >= pci_resource_start(rdev->lldi.pdev, 0) &&
+	    (addr < (pci_resource_start(rdev->lldi.pdev, 0) +
+		    pci_resource_len(rdev->lldi.pdev, 0))))
+		mm->mmap_flag = CXGB4_MMAP_BAR;
+	else if (addr >= pci_resource_start(rdev->lldi.pdev, 2) &&
+		 (addr < (pci_resource_start(rdev->lldi.pdev, 2) +
+			 pci_resource_len(rdev->lldi.pdev, 2)))) {
+		if (addr >= rdev->oc_mw_pa) {
+			mm->mmap_flag = CXGB4_MMAP_BAR_WC;
+		} else {
+			if (is_t4(rdev->lldi.adapter_type))
+				mm->mmap_flag = CXGB4_MMAP_BAR;
+			else
+				mm->mmap_flag = CXGB4_MMAP_BAR_WC;
+		}
+	} else {
+		if (addr)
+			mm->mmap_flag = CXGB4_MMAP_CONTIG;
+		else
+			mm->mmap_flag = CXGB4_MMAP_NON_CONTIG;
+	}
+}
+
 static inline void insert_mmap(struct c4iw_ucontext *ucontext,
 			       struct c4iw_mm_entry *mm)
 {
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 246b739ddb2b..79eb1b7aa30d 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -113,6 +113,9 @@ static int c4iw_alloc_ucontext(struct ib_ucontext *ucontext,
 		mm->key = uresp.status_page_key;
 		mm->addr = virt_to_phys(rhp->rdev.status_page);
 		mm->len = PAGE_SIZE;
+		mm->vaddr = NULL;
+		mm->dma_addr = 0;
+		insert_flag_to_mmap(&rhp->rdev, mm, mm->addr);
 		insert_mmap(context, mm);
 	}
 	return 0;
@@ -131,6 +134,11 @@ static int c4iw_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 	struct c4iw_mm_entry *mm;
 	struct c4iw_ucontext *ucontext;
 	u64 addr;
+	u8 mmap_flag;
+	size_t size;
+	void *vaddr;
+	unsigned long vm_pgoff;
+	dma_addr_t dma_addr;
 
 	pr_debug("pgoff 0x%lx key 0x%x len %d\n", vma->vm_pgoff,
 		 key, len);
@@ -145,47 +153,38 @@ static int c4iw_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 	if (!mm)
 		return -EINVAL;
 	addr = mm->addr;
+	vaddr = mm->vaddr;
+	dma_addr = mm->dma_addr;
+	size = mm->len;
+	mmap_flag = mm->mmap_flag;
 	kfree(mm);
 
-	if ((addr >= pci_resource_start(rdev->lldi.pdev, 0)) &&
-	    (addr < (pci_resource_start(rdev->lldi.pdev, 0) +
-		    pci_resource_len(rdev->lldi.pdev, 0)))) {
-
-		/*
-		 * MA_SYNC register...
-		 */
-		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	switch (mmap_flag) {
+	case CXGB4_MMAP_BAR:
+		 ret = io_remap_pfn_range(vma, vma->vm_start,
+					  addr >> PAGE_SHIFT,
+					  len, pgprot_noncached(vma->vm_page_prot));
+		break;
+	case CXGB4_MMAP_BAR_WC:
 		ret = io_remap_pfn_range(vma, vma->vm_start,
 					 addr >> PAGE_SHIFT,
-					 len, vma->vm_page_prot);
-	} else if ((addr >= pci_resource_start(rdev->lldi.pdev, 2)) &&
-		   (addr < (pci_resource_start(rdev->lldi.pdev, 2) +
-		    pci_resource_len(rdev->lldi.pdev, 2)))) {
-
-		/*
-		 * Map user DB or OCQP memory...
-		 */
-		if (addr >= rdev->oc_mw_pa)
-			vma->vm_page_prot = t4_pgprot_wc(vma->vm_page_prot);
-		else {
-			if (!is_t4(rdev->lldi.adapter_type))
-				vma->vm_page_prot =
-					t4_pgprot_wc(vma->vm_page_prot);
-			else
-				vma->vm_page_prot =
-					pgprot_noncached(vma->vm_page_prot);
-		}
+					 len, t4_pgprot_wc(vma->vm_page_prot));
+		break;
+	case CXGB4_MMAP_CONTIG:
 		ret = io_remap_pfn_range(vma, vma->vm_start,
 					 addr >> PAGE_SHIFT,
 					 len, vma->vm_page_prot);
-	} else {
-
-		/*
-		 * Map WQ or CQ contig dma memory...
-		 */
-		ret = remap_pfn_range(vma, vma->vm_start,
-				      addr >> PAGE_SHIFT,
-				      len, vma->vm_page_prot);
+		break;
+	case CXGB4_MMAP_NON_CONTIG:
+		vm_pgoff = vma->vm_pgoff;
+		vma->vm_pgoff = 0;
+		ret = dma_mmap_coherent(&rdev->lldi.pdev->dev, vma,
+					vaddr, dma_addr, size);
+		vma->vm_pgoff = vm_pgoff;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
 	}
 
 	return ret;
diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index d16d8eaa1415..96d01f01749c 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -2281,24 +2281,36 @@ int c4iw_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attrs,
 		if (ret)
 			goto err_free_ma_sync_key;
 		sq_key_mm->key = uresp.sq_key;
-		sq_key_mm->addr = qhp->wq.sq.phys_addr;
+		sq_key_mm->addr = 0;
+		sq_key_mm->vaddr = qhp->wq.sq.queue;
+		sq_key_mm->dma_addr = qhp->wq.sq.dma_addr;
 		sq_key_mm->len = PAGE_ALIGN(qhp->wq.sq.memsize);
+		insert_flag_to_mmap(&rhp->rdev, sq_key_mm, sq_key_mm->addr);
 		insert_mmap(ucontext, sq_key_mm);
 		if (!attrs->srq) {
 			rq_key_mm->key = uresp.rq_key;
-			rq_key_mm->addr = virt_to_phys(qhp->wq.rq.queue);
+			rq_key_mm->addr = 0;
+			rq_key_mm->vaddr = qhp->wq.rq.queue;
+			rq_key_mm->dma_addr = qhp->wq.rq.dma_addr;
 			rq_key_mm->len = PAGE_ALIGN(qhp->wq.rq.memsize);
+			insert_flag_to_mmap(&rhp->rdev, rq_key_mm, rq_key_mm->addr);
 			insert_mmap(ucontext, rq_key_mm);
 		}
 		sq_db_key_mm->key = uresp.sq_db_gts_key;
 		sq_db_key_mm->addr = (u64)(unsigned long)qhp->wq.sq.bar2_pa;
+		sq_db_key_mm->vaddr = NULL;
+		sq_db_key_mm->dma_addr = 0;
 		sq_db_key_mm->len = PAGE_SIZE;
+		insert_flag_to_mmap(&rhp->rdev, sq_db_key_mm, sq_db_key_mm->addr);
 		insert_mmap(ucontext, sq_db_key_mm);
 		if (!attrs->srq) {
 			rq_db_key_mm->key = uresp.rq_db_gts_key;
 			rq_db_key_mm->addr =
 				(u64)(unsigned long)qhp->wq.rq.bar2_pa;
 			rq_db_key_mm->len = PAGE_SIZE;
+			rq_db_key_mm->vaddr = NULL;
+			rq_db_key_mm->dma_addr = 0;
+			insert_flag_to_mmap(&rhp->rdev, rq_db_key_mm, rq_db_key_mm->addr);
 			insert_mmap(ucontext, rq_db_key_mm);
 		}
 		if (ma_sync_key_mm) {
@@ -2307,6 +2319,9 @@ int c4iw_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attrs,
 				(pci_resource_start(rhp->rdev.lldi.pdev, 0) +
 				PCIE_MA_SYNC_A) & PAGE_MASK;
 			ma_sync_key_mm->len = PAGE_SIZE;
+			ma_sync_key_mm->vaddr = NULL;
+			ma_sync_key_mm->dma_addr = 0;
+			insert_flag_to_mmap(&rhp->rdev, ma_sync_key_mm, ma_sync_key_mm->addr);
 			insert_mmap(ucontext, ma_sync_key_mm);
 		}
 
@@ -2761,12 +2776,18 @@ int c4iw_create_srq(struct ib_srq *ib_srq, struct ib_srq_init_attr *attrs,
 		if (ret)
 			goto err_free_srq_db_key_mm;
 		srq_key_mm->key = uresp.srq_key;
-		srq_key_mm->addr = virt_to_phys(srq->wq.queue);
+		srq_key_mm->addr = 0;
 		srq_key_mm->len = PAGE_ALIGN(srq->wq.memsize);
+		srq_key_mm->vaddr = srq->wq.queue;
+		srq_key_mm->dma_addr = srq->wq.dma_addr;
+		insert_flag_to_mmap(&rhp->rdev, srq_key_mm, srq_key_mm->addr);
 		insert_mmap(ucontext, srq_key_mm);
 		srq_db_key_mm->key = uresp.srq_db_gts_key;
 		srq_db_key_mm->addr = (u64)(unsigned long)srq->wq.bar2_pa;
 		srq_db_key_mm->len = PAGE_SIZE;
+		srq_db_key_mm->vaddr = NULL;
+		srq_db_key_mm->dma_addr = 0;
+		insert_flag_to_mmap(&rhp->rdev, srq_db_key_mm, srq_db_key_mm->addr);
 		insert_mmap(ucontext, srq_db_key_mm);
 	}
 
-- 
2.39.3


