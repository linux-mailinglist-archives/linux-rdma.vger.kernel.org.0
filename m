Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6753F3F3F
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Aug 2021 14:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhHVMZa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Aug 2021 08:25:30 -0400
Received: from out02.smtpout.orange.fr ([193.252.22.211]:56794 "EHLO
        out.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbhHVMZa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 22 Aug 2021 08:25:30 -0400
Received: from pop-os.home ([90.126.253.178])
        by mwinf5d04 with ME
        id kcQm250013riaq203cQmk9; Sun, 22 Aug 2021 14:24:47 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 22 Aug 2021 14:24:47 +0200
X-ME-IP: 90.126.253.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca, aditr@vmware.com, pv-drivers@vmware.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] RDMA: switch from 'pci_' to 'dma_' API
Date:   Sun, 22 Aug 2021 14:24:44 +0200
Message-Id: <259e53b7a00f64bf081d41da8761b171b2ad8f5c.1629634798.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The wrappers in include/linux/pci-dma-compat.h should go away.

The patch has been generated with the coccinelle script below.

It has been hand modified to use 'dma_set_mask_and_coherent()' instead of
'pci_set_dma_mask()/pci_set_consistent_dma_mask()' when applicable.
This is less verbose.

It has been compile tested.


@@
@@
-    PCI_DMA_BIDIRECTIONAL
+    DMA_BIDIRECTIONAL

@@
@@
-    PCI_DMA_TODEVICE
+    DMA_TO_DEVICE

@@
@@
-    PCI_DMA_FROMDEVICE
+    DMA_FROM_DEVICE

@@
@@
-    PCI_DMA_NONE
+    DMA_NONE

@@
expression e1, e2, e3;
@@
-    pci_alloc_consistent(e1, e2, e3)
+    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)

@@
expression e1, e2, e3;
@@
-    pci_zalloc_consistent(e1, e2, e3)
+    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)

@@
expression e1, e2, e3, e4;
@@
-    pci_free_consistent(e1, e2, e3, e4)
+    dma_free_coherent(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_map_single(e1, e2, e3, e4)
+    dma_map_single(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_unmap_single(e1, e2, e3, e4)
+    dma_unmap_single(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4, e5;
@@
-    pci_map_page(e1, e2, e3, e4, e5)
+    dma_map_page(&e1->dev, e2, e3, e4, e5)

@@
expression e1, e2, e3, e4;
@@
-    pci_unmap_page(e1, e2, e3, e4)
+    dma_unmap_page(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_map_sg(e1, e2, e3, e4)
+    dma_map_sg(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_unmap_sg(e1, e2, e3, e4)
+    dma_unmap_sg(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_single_for_cpu(e1, e2, e3, e4)
+    dma_sync_single_for_cpu(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_single_for_device(e1, e2, e3, e4)
+    dma_sync_single_for_device(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_sg_for_cpu(e1, e2, e3, e4)
+    dma_sync_sg_for_cpu(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_sg_for_device(e1, e2, e3, e4)
+    dma_sync_sg_for_device(&e1->dev, e2, e3, e4)

@@
expression e1, e2;
@@
-    pci_dma_mapping_error(e1, e2)
+    dma_mapping_error(&e1->dev, e2)

@@
expression e1, e2;
@@
-    pci_set_dma_mask(e1, e2)
+    dma_set_mask(&e1->dev, e2)

@@
expression e1, e2;
@@
-    pci_set_consistent_dma_mask(e1, e2)
+    dma_set_coherent_mask(&e1->dev, e2)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
If needed, see post from Christoph Hellwig on the kernel-janitors ML:
   https://marc.info/?l=kernel-janitors&m=158745678307186&w=4

This patch is mostly mechanical and compile tested. I hope it is ok to
update the "drivers/infiniband/hw/" directory all at once.
---
 drivers/infiniband/hw/hfi1/pcie.c             | 11 ++-------
 drivers/infiniband/hw/hfi1/user_exp_rcv.c     | 13 +++++------
 drivers/infiniband/hw/mthca/mthca_eq.c        | 21 +++++++++--------
 drivers/infiniband/hw/mthca/mthca_main.c      | 15 ++----------
 drivers/infiniband/hw/mthca/mthca_memfree.c   | 23 +++++++++++--------
 drivers/infiniband/hw/qib/qib_file_ops.c      | 12 +++++-----
 drivers/infiniband/hw/qib/qib_init.c          |  4 ++--
 drivers/infiniband/hw/qib/qib_user_pages.c    | 12 +++++-----
 .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    | 14 +++--------
 9 files changed, 51 insertions(+), 74 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index 6f06e9920503..b29242abedd1 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -92,25 +92,18 @@ int hfi1_pcie_init(struct hfi1_devdata *dd)
 		goto bail;
 	}
 
-	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (ret) {
 		/*
 		 * If the 64 bit setup fails, try 32 bit.  Some systems
 		 * do not setup 64 bit maps on systems with 2GB or less
 		 * memory installed.
 		 */
-		ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 		if (ret) {
 			dd_dev_err(dd, "Unable to set DMA mask: %d\n", ret);
 			goto bail;
 		}
-		ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
-	} else {
-		ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
-	}
-	if (ret) {
-		dd_dev_err(dd, "Unable to set DMA consistent mask: %d\n", ret);
-		goto bail;
 	}
 
 	pci_set_master(pdev);
diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
index 58dcab2679d9..e9e8239397a3 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
@@ -177,8 +177,8 @@ static void unpin_rcv_pages(struct hfi1_filedata *fd,
 	struct mm_struct *mm;
 
 	if (mapped) {
-		pci_unmap_single(dd->pcidev, node->dma_addr,
-				 node->npages * PAGE_SIZE, PCI_DMA_FROMDEVICE);
+		dma_unmap_single(&dd->pcidev->dev, node->dma_addr,
+				 node->npages * PAGE_SIZE, DMA_FROM_DEVICE);
 		pages = &node->pages[idx];
 		mm = mm_from_tid_node(node);
 	} else {
@@ -739,9 +739,8 @@ static int set_rcvarray_entry(struct hfi1_filedata *fd,
 	if (!node)
 		return -ENOMEM;
 
-	phys = pci_map_single(dd->pcidev,
-			      __va(page_to_phys(pages[0])),
-			      npages * PAGE_SIZE, PCI_DMA_FROMDEVICE);
+	phys = dma_map_single(&dd->pcidev->dev, __va(page_to_phys(pages[0])),
+			      npages * PAGE_SIZE, DMA_FROM_DEVICE);
 	if (dma_mapping_error(&dd->pcidev->dev, phys)) {
 		dd_dev_err(dd, "Failed to DMA map Exp Rcv pages 0x%llx\n",
 			   phys);
@@ -783,8 +782,8 @@ static int set_rcvarray_entry(struct hfi1_filedata *fd,
 	hfi1_cdbg(TID, "Failed to insert RB node %u 0x%lx, 0x%lx %d",
 		  node->rcventry, node->notifier.interval_tree.start,
 		  node->phys, ret);
-	pci_unmap_single(dd->pcidev, phys, npages * PAGE_SIZE,
-			 PCI_DMA_FROMDEVICE);
+	dma_unmap_single(&dd->pcidev->dev, phys, npages * PAGE_SIZE,
+			 DMA_FROM_DEVICE);
 	kfree(node);
 	return -EFAULT;
 }
diff --git a/drivers/infiniband/hw/mthca/mthca_eq.c b/drivers/infiniband/hw/mthca/mthca_eq.c
index 2cdf686203c1..9f311bd22f72 100644
--- a/drivers/infiniband/hw/mthca/mthca_eq.c
+++ b/drivers/infiniband/hw/mthca/mthca_eq.c
@@ -617,9 +617,9 @@ static void mthca_free_eq(struct mthca_dev *dev,
 
 	mthca_free_mr(dev, &eq->mr);
 	for (i = 0; i < npages; ++i)
-		pci_free_consistent(dev->pdev, PAGE_SIZE,
-				    eq->page_list[i].buf,
-				    dma_unmap_addr(&eq->page_list[i], mapping));
+		dma_free_coherent(&dev->pdev->dev, PAGE_SIZE,
+				  eq->page_list[i].buf,
+				  dma_unmap_addr(&eq->page_list[i], mapping));
 
 	kfree(eq->page_list);
 	mthca_free_mailbox(dev, mailbox);
@@ -739,17 +739,18 @@ int mthca_map_eq_icm(struct mthca_dev *dev, u64 icm_virt)
 	dev->eq_table.icm_page = alloc_page(GFP_HIGHUSER);
 	if (!dev->eq_table.icm_page)
 		return -ENOMEM;
-	dev->eq_table.icm_dma  = pci_map_page(dev->pdev, dev->eq_table.icm_page, 0,
-					      PAGE_SIZE, PCI_DMA_BIDIRECTIONAL);
-	if (pci_dma_mapping_error(dev->pdev, dev->eq_table.icm_dma)) {
+	dev->eq_table.icm_dma  = dma_map_page(&dev->pdev->dev,
+					      dev->eq_table.icm_page, 0,
+					      PAGE_SIZE, DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(&dev->pdev->dev, dev->eq_table.icm_dma)) {
 		__free_page(dev->eq_table.icm_page);
 		return -ENOMEM;
 	}
 
 	ret = mthca_MAP_ICM_page(dev, dev->eq_table.icm_dma, icm_virt);
 	if (ret) {
-		pci_unmap_page(dev->pdev, dev->eq_table.icm_dma, PAGE_SIZE,
-			       PCI_DMA_BIDIRECTIONAL);
+		dma_unmap_page(&dev->pdev->dev, dev->eq_table.icm_dma,
+			       PAGE_SIZE, DMA_BIDIRECTIONAL);
 		__free_page(dev->eq_table.icm_page);
 	}
 
@@ -759,8 +760,8 @@ int mthca_map_eq_icm(struct mthca_dev *dev, u64 icm_virt)
 void mthca_unmap_eq_icm(struct mthca_dev *dev)
 {
 	mthca_UNMAP_ICM(dev, dev->eq_table.icm_virt, 1);
-	pci_unmap_page(dev->pdev, dev->eq_table.icm_dma, PAGE_SIZE,
-		       PCI_DMA_BIDIRECTIONAL);
+	dma_unmap_page(&dev->pdev->dev, dev->eq_table.icm_dma, PAGE_SIZE,
+		       DMA_BIDIRECTIONAL);
 	__free_page(dev->eq_table.icm_page);
 }
 
diff --git a/drivers/infiniband/hw/mthca/mthca_main.c b/drivers/infiniband/hw/mthca/mthca_main.c
index fe9654a7af71..f507c4cd46d3 100644
--- a/drivers/infiniband/hw/mthca/mthca_main.c
+++ b/drivers/infiniband/hw/mthca/mthca_main.c
@@ -937,26 +937,15 @@ static int __mthca_init_one(struct pci_dev *pdev, int hca_type)
 
 	pci_set_master(pdev);
 
-	err = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (err) {
 		dev_warn(&pdev->dev, "Warning: couldn't set 64-bit PCI DMA mask.\n");
-		err = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 		if (err) {
 			dev_err(&pdev->dev, "Can't set PCI DMA mask, aborting.\n");
 			goto err_free_res;
 		}
 	}
-	err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
-	if (err) {
-		dev_warn(&pdev->dev, "Warning: couldn't set 64-bit "
-			 "consistent PCI DMA mask.\n");
-		err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
-		if (err) {
-			dev_err(&pdev->dev, "Can't set consistent PCI DMA mask, "
-				"aborting.\n");
-			goto err_free_res;
-		}
-	}
 
 	/* We can handle large RDMA requests, so allow larger segments. */
 	dma_set_max_seg_size(&pdev->dev, 1024 * 1024 * 1024);
diff --git a/drivers/infiniband/hw/mthca/mthca_memfree.c b/drivers/infiniband/hw/mthca/mthca_memfree.c
index fa808582b08b..215a01b24258 100644
--- a/drivers/infiniband/hw/mthca/mthca_memfree.c
+++ b/drivers/infiniband/hw/mthca/mthca_memfree.c
@@ -66,8 +66,8 @@ static void mthca_free_icm_pages(struct mthca_dev *dev, struct mthca_icm_chunk *
 	int i;
 
 	if (chunk->nsg > 0)
-		pci_unmap_sg(dev->pdev, chunk->mem, chunk->npages,
-			     PCI_DMA_BIDIRECTIONAL);
+		dma_unmap_sg(&dev->pdev->dev, chunk->mem, chunk->npages,
+			     DMA_BIDIRECTIONAL);
 
 	for (i = 0; i < chunk->npages; ++i)
 		__free_pages(sg_page(&chunk->mem[i]),
@@ -184,9 +184,10 @@ struct mthca_icm *mthca_alloc_icm(struct mthca_dev *dev, int npages,
 			if (coherent)
 				++chunk->nsg;
 			else if (chunk->npages == MTHCA_ICM_CHUNK_LEN) {
-				chunk->nsg = pci_map_sg(dev->pdev, chunk->mem,
+				chunk->nsg = dma_map_sg(&dev->pdev->dev,
+							chunk->mem,
 							chunk->npages,
-							PCI_DMA_BIDIRECTIONAL);
+							DMA_BIDIRECTIONAL);
 
 				if (chunk->nsg <= 0)
 					goto fail;
@@ -204,9 +205,8 @@ struct mthca_icm *mthca_alloc_icm(struct mthca_dev *dev, int npages,
 	}
 
 	if (!coherent && chunk) {
-		chunk->nsg = pci_map_sg(dev->pdev, chunk->mem,
-					chunk->npages,
-					PCI_DMA_BIDIRECTIONAL);
+		chunk->nsg = dma_map_sg(&dev->pdev->dev, chunk->mem,
+					chunk->npages, DMA_BIDIRECTIONAL);
 
 		if (chunk->nsg <= 0)
 			goto fail;
@@ -480,7 +480,8 @@ int mthca_map_user_db(struct mthca_dev *dev, struct mthca_uar *uar,
 	sg_set_page(&db_tab->page[i].mem, pages[0], MTHCA_ICM_PAGE_SIZE,
 			uaddr & ~PAGE_MASK);
 
-	ret = pci_map_sg(dev->pdev, &db_tab->page[i].mem, 1, PCI_DMA_TODEVICE);
+	ret = dma_map_sg(&dev->pdev->dev, &db_tab->page[i].mem, 1,
+			 DMA_TO_DEVICE);
 	if (ret < 0) {
 		unpin_user_page(pages[0]);
 		goto out;
@@ -489,7 +490,8 @@ int mthca_map_user_db(struct mthca_dev *dev, struct mthca_uar *uar,
 	ret = mthca_MAP_ICM_page(dev, sg_dma_address(&db_tab->page[i].mem),
 				 mthca_uarc_virt(dev, uar, i));
 	if (ret) {
-		pci_unmap_sg(dev->pdev, &db_tab->page[i].mem, 1, PCI_DMA_TODEVICE);
+		dma_unmap_sg(&dev->pdev->dev, &db_tab->page[i].mem, 1,
+			     DMA_TO_DEVICE);
 		unpin_user_page(sg_page(&db_tab->page[i].mem));
 		goto out;
 	}
@@ -555,7 +557,8 @@ void mthca_cleanup_user_db_tab(struct mthca_dev *dev, struct mthca_uar *uar,
 	for (i = 0; i < dev->uar_table.uarc_size / MTHCA_ICM_PAGE_SIZE; ++i) {
 		if (db_tab->page[i].uvirt) {
 			mthca_UNMAP_ICM(dev, mthca_uarc_virt(dev, uar, i), 1);
-			pci_unmap_sg(dev->pdev, &db_tab->page[i].mem, 1, PCI_DMA_TODEVICE);
+			dma_unmap_sg(&dev->pdev->dev, &db_tab->page[i].mem, 1,
+				     DMA_TO_DEVICE);
 			unpin_user_page(sg_page(&db_tab->page[i].mem));
 		}
 	}
diff --git a/drivers/infiniband/hw/qib/qib_file_ops.c b/drivers/infiniband/hw/qib/qib_file_ops.c
index c60e79d214a1..63854f4b6524 100644
--- a/drivers/infiniband/hw/qib/qib_file_ops.c
+++ b/drivers/infiniband/hw/qib/qib_file_ops.c
@@ -429,8 +429,8 @@ static int qib_tid_update(struct qib_ctxtdata *rcd, struct file *fp,
 				dd->f_put_tid(dd, &tidbase[tid],
 					      RCVHQ_RCV_TYPE_EXPECTED,
 					      dd->tidinvalid);
-				pci_unmap_page(dd->pcidev, phys, PAGE_SIZE,
-					       PCI_DMA_FROMDEVICE);
+				dma_unmap_page(&dd->pcidev->dev, phys,
+					       PAGE_SIZE, DMA_FROM_DEVICE);
 				dd->pageshadow[ctxttid + tid] = NULL;
 			}
 		}
@@ -544,8 +544,8 @@ static int qib_tid_free(struct qib_ctxtdata *rcd, unsigned subctxt,
 			 */
 			dd->f_put_tid(dd, &tidbase[tid],
 				      RCVHQ_RCV_TYPE_EXPECTED, dd->tidinvalid);
-			pci_unmap_page(dd->pcidev, phys, PAGE_SIZE,
-				       PCI_DMA_FROMDEVICE);
+			dma_unmap_page(&dd->pcidev->dev, phys, PAGE_SIZE,
+				       DMA_FROM_DEVICE);
 			qib_release_user_pages(&p, 1);
 		}
 	}
@@ -1781,8 +1781,8 @@ static void unlock_expected_tids(struct qib_ctxtdata *rcd)
 		phys = dd->physshadow[i];
 		dd->physshadow[i] = dd->tidinvalid;
 		dd->pageshadow[i] = NULL;
-		pci_unmap_page(dd->pcidev, phys, PAGE_SIZE,
-			       PCI_DMA_FROMDEVICE);
+		dma_unmap_page(&dd->pcidev->dev, phys, PAGE_SIZE,
+			       DMA_FROM_DEVICE);
 		qib_release_user_pages(&p, 1);
 		cnt++;
 	}
diff --git a/drivers/infiniband/hw/qib/qib_init.c b/drivers/infiniband/hw/qib/qib_init.c
index b5a78576c48b..d1a72e89e297 100644
--- a/drivers/infiniband/hw/qib/qib_init.c
+++ b/drivers/infiniband/hw/qib/qib_init.c
@@ -1335,8 +1335,8 @@ static void cleanup_device_data(struct qib_devdata *dd)
 			for (i = ctxt_tidbase; i < maxtid; i++) {
 				if (!tmpp[i])
 					continue;
-				pci_unmap_page(dd->pcidev, tmpd[i],
-					       PAGE_SIZE, PCI_DMA_FROMDEVICE);
+				dma_unmap_page(&dd->pcidev->dev, tmpd[i],
+					       PAGE_SIZE, DMA_FROM_DEVICE);
 				qib_release_user_pages(&tmpp[i], 1);
 				tmpp[i] = NULL;
 			}
diff --git a/drivers/infiniband/hw/qib/qib_user_pages.c b/drivers/infiniband/hw/qib/qib_user_pages.c
index 5d6cf7427431..f4b5f05058e4 100644
--- a/drivers/infiniband/hw/qib/qib_user_pages.c
+++ b/drivers/infiniband/hw/qib/qib_user_pages.c
@@ -60,15 +60,15 @@ int qib_map_page(struct pci_dev *hwdev, struct page *page, dma_addr_t *daddr)
 {
 	dma_addr_t phys;
 
-	phys = pci_map_page(hwdev, page, 0, PAGE_SIZE, PCI_DMA_FROMDEVICE);
-	if (pci_dma_mapping_error(hwdev, phys))
+	phys = dma_map_page(&hwdev->dev, page, 0, PAGE_SIZE, DMA_FROM_DEVICE);
+	if (dma_mapping_error(&hwdev->dev, phys))
 		return -ENOMEM;
 
 	if (!phys) {
-		pci_unmap_page(hwdev, phys, PAGE_SIZE, PCI_DMA_FROMDEVICE);
-		phys = pci_map_page(hwdev, page, 0, PAGE_SIZE,
-				    PCI_DMA_FROMDEVICE);
-		if (pci_dma_mapping_error(hwdev, phys))
+		dma_unmap_page(&hwdev->dev, phys, PAGE_SIZE, DMA_FROM_DEVICE);
+		phys = dma_map_page(&hwdev->dev, page, 0, PAGE_SIZE,
+				    DMA_FROM_DEVICE);
+		if (dma_mapping_error(&hwdev->dev, phys))
 			return -ENOMEM;
 		/*
 		 * FIXME: If we get 0 again, we should keep this page,
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
index b39175837d58..105f3a155939 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -811,18 +811,10 @@ static int pvrdma_pci_probe(struct pci_dev *pdev,
 	}
 
 	/* Enable 64-Bit DMA */
-	if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64)) == 0) {
-		ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)) != 0) {
+		ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
 		if (ret != 0) {
-			dev_err(&pdev->dev,
-				"pci_set_consistent_dma_mask failed\n");
-			goto err_free_resource;
-		}
-	} else {
-		ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
-		if (ret != 0) {
-			dev_err(&pdev->dev,
-				"pci_set_dma_mask failed\n");
+			dev_err(&pdev->dev, "dma_set_mask failed\n");
 			goto err_free_resource;
 		}
 	}
-- 
2.30.2

