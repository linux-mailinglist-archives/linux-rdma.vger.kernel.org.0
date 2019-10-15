Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7A75D7EA7
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2019 20:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731867AbfJOSQj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Oct 2019 14:16:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34752 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfJOSQj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Oct 2019 14:16:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id b128so13011285pfa.1
        for <linux-rdma@vger.kernel.org>; Tue, 15 Oct 2019 11:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iRW3sh+/KRUt0IvjdYFL27lKQnR6JopWyEWGX3mhAm8=;
        b=Eiv4i3FnS+9AnZt+YbZ7uwkDRfoZtzmZHlf/1T6Dd+TGZm+IlbQdUSdoEknCGSJT74
         NHOt1fJW8ppGprWjV+ZQYPbBf7qZUYJYFU/w5OBCKL2lFeXoF1HITZnMmdZ/5bENAh0C
         M9xiGwCNGfBNjqdoby7Du4vQTGl7Oj1wVRWwQlOdxEGgEaI66pUpPU5ImgkRbRKHUUIQ
         CsqQpVj6VqeG3eZMk7whUQDFdm9J3A2/g0W8IVTEMk/STm80nkPFwQcSWD6AHgwlBcB2
         BbORyq+gZSHLYOXtikwSUIdzMNaGUecdS1CkW+jHUBTn7GcMhoxOBSDp2/E01qI0evFI
         PtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iRW3sh+/KRUt0IvjdYFL27lKQnR6JopWyEWGX3mhAm8=;
        b=l6OopHNx1r5hWms0N7ba95ztjnoTQO3jCBETQUNYRYWCAAh+o6npYsOlhFC68pBYTV
         fdLuh+ap3kPjt99fF0i5hEoCPSXaWZdhPbLReqOrnBaIrolJCVsVYLyVfI42Suv1mJEN
         DsjqW8XD+JhXjwZj9wm7mfVBU3+YaBiPaSXiUlJyzJI8o6thoWmTB8oHBdMD3IHM4Udc
         ZX2yXyRBJN121Y1Ok6RFfaX4wRNQ8MdeaisgkWsmrCtrjwYeHBolLGfdDOQykhvDCeWO
         +M7SQyq/46wH98ETPzsvXxwGhd3QZBiqfUBs8zNRYPJkC4BFu6UJUYdywlK0cNvRXhc9
         FRRw==
X-Gm-Message-State: APjAAAU6kJQJYLu+1fSg+VEkhTlVyvIbphdw32dq1ODCC8daPCRyq37f
        Ph4bA7gOwqMaAXOt7iEJgPa6AQ==
X-Google-Smtp-Source: APXvYqxn5GyOR9bQAeLu3rv5akSVrWu3Kb3RnrvMd5wFUn6mPQxIDLOICpAwdvPqp2qaflwt2NAGog==
X-Received: by 2002:a63:cc4a:: with SMTP id q10mr40292268pgi.221.1571163397873;
        Tue, 15 Oct 2019 11:16:37 -0700 (PDT)
Received: from ziepe.ca ([24.114.26.129])
        by smtp.gmail.com with ESMTPSA id e3sm12863pjs.15.2019.10.15.11.16.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Oct 2019 11:16:37 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iKRJT-0002CB-F7; Tue, 15 Oct 2019 15:12:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: [PATCH hmm 06/15] RDMA/hfi1: Use mmu_range_notifier_inset for user_exp_rcv
Date:   Tue, 15 Oct 2019 15:12:33 -0300
Message-Id: <20191015181242.8343-7-jgg@ziepe.ca>
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

This converts one of the two users of mmu_notifiers to use the new API.
The conversion is fairly straightforward, however the existing use of
notifiers here seems to be racey.

Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/hw/hfi1/file_ops.c     |   2 +-
 drivers/infiniband/hw/hfi1/hfi.h          |   2 +-
 drivers/infiniband/hw/hfi1/user_exp_rcv.c | 144 ++++++++--------------
 drivers/infiniband/hw/hfi1/user_exp_rcv.h |   3 +-
 4 files changed, 58 insertions(+), 93 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index f9a7e9d29c8ba2..7c5e3fb224139a 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -1138,7 +1138,7 @@ static int get_ctxt_info(struct hfi1_filedata *fd, unsigned long arg, u32 len)
 			HFI1_CAP_UGET_MASK(uctxt->flags, MASK) |
 			HFI1_CAP_KGET_MASK(uctxt->flags, K2U);
 	/* adjust flag if this fd is not able to cache */
-	if (!fd->handler)
+	if (!fd->use_mn)
 		cinfo.runtime_flags |= HFI1_CAP_TID_UNMAP; /* no caching */
 
 	cinfo.num_active = hfi1_count_active_units();
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index fa45350a9a1d32..fc10d65fc3e13c 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -1444,7 +1444,7 @@ struct hfi1_filedata {
 	/* for cpu affinity; -1 if none */
 	int rec_cpu_num;
 	u32 tid_n_pinned;
-	struct mmu_rb_handler *handler;
+	bool use_mn;
 	struct tid_rb_node **entry_to_rb;
 	spinlock_t tid_lock; /* protect tid_[limit,used] counters */
 	u32 tid_limit;
diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
index 3592a9ec155e85..2aca28a0b3ca47 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
@@ -59,11 +59,10 @@ static int set_rcvarray_entry(struct hfi1_filedata *fd,
 			      struct tid_user_buf *tbuf,
 			      u32 rcventry, struct tid_group *grp,
 			      u16 pageidx, unsigned int npages);
-static int tid_rb_insert(void *arg, struct mmu_rb_node *node);
 static void cacheless_tid_rb_remove(struct hfi1_filedata *fdata,
 				    struct tid_rb_node *tnode);
-static void tid_rb_remove(void *arg, struct mmu_rb_node *node);
-static int tid_rb_invalidate(void *arg, struct mmu_rb_node *mnode);
+static bool tid_rb_invalidate(struct mmu_range_notifier *mrn,
+			      const struct mmu_notifier_range *range);
 static int program_rcvarray(struct hfi1_filedata *fd, struct tid_user_buf *,
 			    struct tid_group *grp,
 			    unsigned int start, u16 count,
@@ -73,10 +72,8 @@ static int unprogram_rcvarray(struct hfi1_filedata *fd, u32 tidinfo,
 			      struct tid_group **grp);
 static void clear_tid_node(struct hfi1_filedata *fd, struct tid_rb_node *node);
 
-static struct mmu_rb_ops tid_rb_ops = {
-	.insert = tid_rb_insert,
-	.remove = tid_rb_remove,
-	.invalidate = tid_rb_invalidate
+static const struct mmu_range_notifier_ops tid_mn_ops = {
+	.invalidate = tid_rb_invalidate,
 };
 
 /*
@@ -87,7 +84,6 @@ static struct mmu_rb_ops tid_rb_ops = {
 int hfi1_user_exp_rcv_init(struct hfi1_filedata *fd,
 			   struct hfi1_ctxtdata *uctxt)
 {
-	struct hfi1_devdata *dd = uctxt->dd;
 	int ret = 0;
 
 	spin_lock_init(&fd->tid_lock);
@@ -109,20 +105,7 @@ int hfi1_user_exp_rcv_init(struct hfi1_filedata *fd,
 			fd->entry_to_rb = NULL;
 			return -ENOMEM;
 		}
-
-		/*
-		 * Register MMU notifier callbacks. If the registration
-		 * fails, continue without TID caching for this context.
-		 */
-		ret = hfi1_mmu_rb_register(fd, fd->mm, &tid_rb_ops,
-					   dd->pport->hfi1_wq,
-					   &fd->handler);
-		if (ret) {
-			dd_dev_info(dd,
-				    "Failed MMU notifier registration %d\n",
-				    ret);
-			ret = 0;
-		}
+		fd->use_mn = true;
 	}
 
 	/*
@@ -139,7 +122,7 @@ int hfi1_user_exp_rcv_init(struct hfi1_filedata *fd,
 	 * init.
 	 */
 	spin_lock(&fd->tid_lock);
-	if (uctxt->subctxt_cnt && fd->handler) {
+	if (uctxt->subctxt_cnt && fd->use_mn) {
 		u16 remainder;
 
 		fd->tid_limit = uctxt->expected_count / uctxt->subctxt_cnt;
@@ -158,18 +141,10 @@ void hfi1_user_exp_rcv_free(struct hfi1_filedata *fd)
 {
 	struct hfi1_ctxtdata *uctxt = fd->uctxt;
 
-	/*
-	 * The notifier would have been removed when the process'es mm
-	 * was freed.
-	 */
-	if (fd->handler) {
-		hfi1_mmu_rb_unregister(fd->handler);
-	} else {
-		if (!EXP_TID_SET_EMPTY(uctxt->tid_full_list))
-			unlock_exp_tids(uctxt, &uctxt->tid_full_list, fd);
-		if (!EXP_TID_SET_EMPTY(uctxt->tid_used_list))
-			unlock_exp_tids(uctxt, &uctxt->tid_used_list, fd);
-	}
+	if (!EXP_TID_SET_EMPTY(uctxt->tid_full_list))
+		unlock_exp_tids(uctxt, &uctxt->tid_full_list, fd);
+	if (!EXP_TID_SET_EMPTY(uctxt->tid_used_list))
+		unlock_exp_tids(uctxt, &uctxt->tid_used_list, fd);
 
 	kfree(fd->invalid_tids);
 	fd->invalid_tids = NULL;
@@ -201,7 +176,7 @@ static void unpin_rcv_pages(struct hfi1_filedata *fd,
 
 	if (mapped) {
 		pci_unmap_single(dd->pcidev, node->dma_addr,
-				 node->mmu.len, PCI_DMA_FROMDEVICE);
+				 node->npages * PAGE_SIZE, PCI_DMA_FROMDEVICE);
 		pages = &node->pages[idx];
 	} else {
 		pages = &tidbuf->pages[idx];
@@ -777,8 +752,8 @@ static int set_rcvarray_entry(struct hfi1_filedata *fd,
 		return -EFAULT;
 	}
 
-	node->mmu.addr = tbuf->vaddr + (pageidx * PAGE_SIZE);
-	node->mmu.len = npages * PAGE_SIZE;
+	node->notifier.ops = &tid_mn_ops;
+	node->fdata = fd;
 	node->phys = page_to_phys(pages[0]);
 	node->npages = npages;
 	node->rcventry = rcventry;
@@ -787,23 +762,34 @@ static int set_rcvarray_entry(struct hfi1_filedata *fd,
 	node->freed = false;
 	memcpy(node->pages, pages, sizeof(struct page *) * npages);
 
-	if (!fd->handler)
-		ret = tid_rb_insert(fd, &node->mmu);
-	else
-		ret = hfi1_mmu_rb_insert(fd->handler, &node->mmu);
-
-	if (ret) {
-		hfi1_cdbg(TID, "Failed to insert RB node %u 0x%lx, 0x%lx %d",
-			  node->rcventry, node->mmu.addr, node->phys, ret);
-		pci_unmap_single(dd->pcidev, phys, npages * PAGE_SIZE,
-				 PCI_DMA_FROMDEVICE);
-		kfree(node);
-		return -EFAULT;
+	if (fd->use_mn) {
+		ret = mmu_range_notifier_insert(
+			&node->notifier, tbuf->vaddr + (pageidx * PAGE_SIZE),
+			npages * PAGE_SIZE, fd->mm);
+		if (ret)
+			goto out_unmap;
+		/*
+		 * FIXME: This is in the wrong order, the notifier should be
+		 * established before the pages are pinned by pin_rcv_pages.
+		 */
+		mmu_range_read_begin(&node->notifier);
 	}
+	fd->entry_to_rb[node->rcventry - uctxt->expected_base] = node;
+
 	hfi1_put_tid(dd, rcventry, PT_EXPECTED, phys, ilog2(npages) + 1);
 	trace_hfi1_exp_tid_reg(uctxt->ctxt, fd->subctxt, rcventry, npages,
-			       node->mmu.addr, node->phys, phys);
+			       node->notifier.interval_tree.start, node->phys,
+			       phys);
 	return 0;
+
+out_unmap:
+	hfi1_cdbg(TID, "Failed to insert RB node %u 0x%lx, 0x%lx %d",
+		  node->rcventry, node->notifier.interval_tree.start,
+		  node->phys, ret);
+	pci_unmap_single(dd->pcidev, phys, npages * PAGE_SIZE,
+			 PCI_DMA_FROMDEVICE);
+	kfree(node);
+	return -EFAULT;
 }
 
 static int unprogram_rcvarray(struct hfi1_filedata *fd, u32 tidinfo,
@@ -833,10 +819,9 @@ static int unprogram_rcvarray(struct hfi1_filedata *fd, u32 tidinfo,
 	if (grp)
 		*grp = node->grp;
 
-	if (!fd->handler)
-		cacheless_tid_rb_remove(fd, node);
-	else
-		hfi1_mmu_rb_remove(fd->handler, &node->mmu);
+	if (fd->use_mn)
+		mmu_range_notifier_remove(&node->notifier);
+	cacheless_tid_rb_remove(fd, node);
 
 	return 0;
 }
@@ -847,7 +832,8 @@ static void clear_tid_node(struct hfi1_filedata *fd, struct tid_rb_node *node)
 	struct hfi1_devdata *dd = uctxt->dd;
 
 	trace_hfi1_exp_tid_unreg(uctxt->ctxt, fd->subctxt, node->rcventry,
-				 node->npages, node->mmu.addr, node->phys,
+				 node->npages,
+				 node->notifier.interval_tree.start, node->phys,
 				 node->dma_addr);
 
 	/*
@@ -894,30 +880,28 @@ static void unlock_exp_tids(struct hfi1_ctxtdata *uctxt,
 				if (!node || node->rcventry != rcventry)
 					continue;
 
+				if (fd->use_mn)
+					mmu_range_notifier_remove(
+						&node->notifier);
 				cacheless_tid_rb_remove(fd, node);
 			}
 		}
 	}
 }
 
-/*
- * Always return 0 from this function.  A non-zero return indicates that the
- * remove operation will be called and that memory should be unpinned.
- * However, the driver cannot unpin out from under PSM.  Instead, retain the
- * memory (by returning 0) and inform PSM that the memory is going away.  PSM
- * will call back later when it has removed the memory from its list.
- */
-static int tid_rb_invalidate(void *arg, struct mmu_rb_node *mnode)
+static bool tid_rb_invalidate(struct mmu_range_notifier *mrn,
+			      const struct mmu_notifier_range *range)
 {
-	struct hfi1_filedata *fdata = arg;
-	struct hfi1_ctxtdata *uctxt = fdata->uctxt;
 	struct tid_rb_node *node =
-		container_of(mnode, struct tid_rb_node, mmu);
+		container_of(mrn, struct tid_rb_node, notifier);
+	struct hfi1_filedata *fdata = node->fdata;
+	struct hfi1_ctxtdata *uctxt = fdata->uctxt;
 
 	if (node->freed)
-		return 0;
+		return true;
 
-	trace_hfi1_exp_tid_inval(uctxt->ctxt, fdata->subctxt, node->mmu.addr,
+	trace_hfi1_exp_tid_inval(uctxt->ctxt, fdata->subctxt,
+				 node->notifier.interval_tree.start,
 				 node->rcventry, node->npages, node->dma_addr);
 	node->freed = true;
 
@@ -946,18 +930,7 @@ static int tid_rb_invalidate(void *arg, struct mmu_rb_node *mnode)
 		fdata->invalid_tid_idx++;
 	}
 	spin_unlock(&fdata->invalid_lock);
-	return 0;
-}
-
-static int tid_rb_insert(void *arg, struct mmu_rb_node *node)
-{
-	struct hfi1_filedata *fdata = arg;
-	struct tid_rb_node *tnode =
-		container_of(node, struct tid_rb_node, mmu);
-	u32 base = fdata->uctxt->expected_base;
-
-	fdata->entry_to_rb[tnode->rcventry - base] = tnode;
-	return 0;
+	return true;
 }
 
 static void cacheless_tid_rb_remove(struct hfi1_filedata *fdata,
@@ -968,12 +941,3 @@ static void cacheless_tid_rb_remove(struct hfi1_filedata *fdata,
 	fdata->entry_to_rb[tnode->rcventry - base] = NULL;
 	clear_tid_node(fdata, tnode);
 }
-
-static void tid_rb_remove(void *arg, struct mmu_rb_node *node)
-{
-	struct hfi1_filedata *fdata = arg;
-	struct tid_rb_node *tnode =
-		container_of(node, struct tid_rb_node, mmu);
-
-	cacheless_tid_rb_remove(fdata, tnode);
-}
diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.h b/drivers/infiniband/hw/hfi1/user_exp_rcv.h
index 43b105de1d5427..b5314db083b125 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.h
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.h
@@ -65,7 +65,8 @@ struct tid_user_buf {
 };
 
 struct tid_rb_node {
-	struct mmu_rb_node mmu;
+	struct mmu_range_notifier notifier;
+	struct hfi1_filedata *fdata;
 	unsigned long phys;
 	struct tid_group *grp;
 	u32 rcventry;
-- 
2.23.0

