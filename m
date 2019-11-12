Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E613F9A78
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2019 21:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfKLUWy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Nov 2019 15:22:54 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39883 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfKLUWx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Nov 2019 15:22:53 -0500
Received: by mail-qt1-f196.google.com with SMTP id t8so21258889qtc.6
        for <linux-rdma@vger.kernel.org>; Tue, 12 Nov 2019 12:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BSFUg/W9A6HnwsbPbuDzq/9L6ti4sGNMmL25wGbaBxI=;
        b=U5tMGzDohM88Dhb5OT+KNGasGrxJPURV3VJCgcEbLNaNLggNPtNvaJWNxh0oGCxd+G
         e1TTaZrAQm6MtqEffeVMDJceNyB8NHz11Rhj2PRrGCd72azzt1/3JDGtzA2cy4YX6/0u
         mAW2VzEiinIlE+wrNwjawDIV7wV6QvRGUW8Ksp2RYkql90eX+Syq6crGDA8ezIa/znBG
         nlMhQqdyxhN7pb6Jafd7qjYQ0G5GzVjTbGXchwZj6vkoj/p7ny/lKxLlNyJPBZEnc930
         TG5K5USOVXpcnWbR/x/G0Wx3Ef54r2hr8Dpu4fajLIw10HvmTDAD5WQT4pVIm1hLNM6F
         P6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BSFUg/W9A6HnwsbPbuDzq/9L6ti4sGNMmL25wGbaBxI=;
        b=SBOFhr4hx8hokjmLzN1b7nyPhvRtTvFd9Hg0DEKPuaVk8K8R/20N/znVlmw/tkwoSu
         TmSQ7hrRWQmKsXF6LeYaS7r5XXl6UCE5by5YrenMZuKwTrJjmz4uCOUJZuXKJZLsZ3Kg
         qPgcAeeFsZOOBBC6Vuy/3s9h49V3by7QDrnWb9NM5Mcoo6gS0trGgtp5DpN4d3RBjWry
         EMQ3OHR2XnSt35aClNnQ4b97VjnfTZDSX143zeDpGQv2zIdWuBKTvnec+svOTitKgZ9U
         EsbGxdKy2BKcEXsLJnr7p+uW+HlPXSQHtahwGUf/uiR9vjhWTDGCY4i1XD/G0xMusz6o
         hjKw==
X-Gm-Message-State: APjAAAUG644K2XVG8PjWJs8XahmWpA/5Xg1mNr9QZX8m/p+UYuUdtVWq
        iCb4L3PJ6j5/AuToepAYOtrdPg==
X-Google-Smtp-Source: APXvYqyh7GmjUHdAPkfQnL2h1rs4I1Aq/QuqAEqebx0t7FVTldSAgXXVkrqtZm6Vk74H36QsCmVYvg==
X-Received: by 2002:ac8:f88:: with SMTP id b8mr33625110qtk.382.1573590172345;
        Tue, 12 Nov 2019 12:22:52 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id q16sm7487987qkm.27.2019.11.12.12.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Nov 2019 12:22:48 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iUcgZ-0003k4-DE; Tue, 12 Nov 2019 16:22:47 -0400
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
Subject: [PATCH v3 06/14] RDMA/hfi1: Use mmu_interval_notifier_insert for user_exp_rcv
Date:   Tue, 12 Nov 2019 16:22:23 -0400
Message-Id: <20191112202231.3856-7-jgg@ziepe.ca>
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

This converts one of the two users of mmu_notifiers to use the new API.
The conversion is fairly straightforward, however the existing use of
notifiers here seems to be racey.

Tested-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/hw/hfi1/file_ops.c     |   2 +-
 drivers/infiniband/hw/hfi1/hfi.h          |   2 +-
 drivers/infiniband/hw/hfi1/user_exp_rcv.c | 146 +++++++++-------------
 drivers/infiniband/hw/hfi1/user_exp_rcv.h |   3 +-
 4 files changed, 60 insertions(+), 93 deletions(-)

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
index 3592a9ec155e85..75a378162162d3 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
@@ -59,11 +59,11 @@ static int set_rcvarray_entry(struct hfi1_filedata *fd,
 			      struct tid_user_buf *tbuf,
 			      u32 rcventry, struct tid_group *grp,
 			      u16 pageidx, unsigned int npages);
-static int tid_rb_insert(void *arg, struct mmu_rb_node *node);
 static void cacheless_tid_rb_remove(struct hfi1_filedata *fdata,
 				    struct tid_rb_node *tnode);
-static void tid_rb_remove(void *arg, struct mmu_rb_node *node);
-static int tid_rb_invalidate(void *arg, struct mmu_rb_node *mnode);
+static bool tid_rb_invalidate(struct mmu_interval_notifier *mni,
+			      const struct mmu_notifier_range *range,
+			      unsigned long cur_seq);
 static int program_rcvarray(struct hfi1_filedata *fd, struct tid_user_buf *,
 			    struct tid_group *grp,
 			    unsigned int start, u16 count,
@@ -73,10 +73,8 @@ static int unprogram_rcvarray(struct hfi1_filedata *fd, u32 tidinfo,
 			      struct tid_group **grp);
 static void clear_tid_node(struct hfi1_filedata *fd, struct tid_rb_node *node);
 
-static struct mmu_rb_ops tid_rb_ops = {
-	.insert = tid_rb_insert,
-	.remove = tid_rb_remove,
-	.invalidate = tid_rb_invalidate
+static const struct mmu_interval_notifier_ops tid_mn_ops = {
+	.invalidate = tid_rb_invalidate,
 };
 
 /*
@@ -87,7 +85,6 @@ static struct mmu_rb_ops tid_rb_ops = {
 int hfi1_user_exp_rcv_init(struct hfi1_filedata *fd,
 			   struct hfi1_ctxtdata *uctxt)
 {
-	struct hfi1_devdata *dd = uctxt->dd;
 	int ret = 0;
 
 	spin_lock_init(&fd->tid_lock);
@@ -109,20 +106,7 @@ int hfi1_user_exp_rcv_init(struct hfi1_filedata *fd,
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
@@ -139,7 +123,7 @@ int hfi1_user_exp_rcv_init(struct hfi1_filedata *fd,
 	 * init.
 	 */
 	spin_lock(&fd->tid_lock);
-	if (uctxt->subctxt_cnt && fd->handler) {
+	if (uctxt->subctxt_cnt && fd->use_mn) {
 		u16 remainder;
 
 		fd->tid_limit = uctxt->expected_count / uctxt->subctxt_cnt;
@@ -158,18 +142,10 @@ void hfi1_user_exp_rcv_free(struct hfi1_filedata *fd)
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
@@ -201,7 +177,7 @@ static void unpin_rcv_pages(struct hfi1_filedata *fd,
 
 	if (mapped) {
 		pci_unmap_single(dd->pcidev, node->dma_addr,
-				 node->mmu.len, PCI_DMA_FROMDEVICE);
+				 node->npages * PAGE_SIZE, PCI_DMA_FROMDEVICE);
 		pages = &node->pages[idx];
 	} else {
 		pages = &tidbuf->pages[idx];
@@ -777,8 +753,8 @@ static int set_rcvarray_entry(struct hfi1_filedata *fd,
 		return -EFAULT;
 	}
 
-	node->mmu.addr = tbuf->vaddr + (pageidx * PAGE_SIZE);
-	node->mmu.len = npages * PAGE_SIZE;
+	node->notifier.ops = &tid_mn_ops;
+	node->fdata = fd;
 	node->phys = page_to_phys(pages[0]);
 	node->npages = npages;
 	node->rcventry = rcventry;
@@ -787,23 +763,34 @@ static int set_rcvarray_entry(struct hfi1_filedata *fd,
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
+		ret = mmu_interval_notifier_insert(
+			&node->notifier, tbuf->vaddr + (pageidx * PAGE_SIZE),
+			npages * PAGE_SIZE, fd->mm);
+		if (ret)
+			goto out_unmap;
+		/*
+		 * FIXME: This is in the wrong order, the notifier should be
+		 * established before the pages are pinned by pin_rcv_pages.
+		 */
+		mmu_interval_read_begin(&node->notifier);
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
@@ -833,10 +820,9 @@ static int unprogram_rcvarray(struct hfi1_filedata *fd, u32 tidinfo,
 	if (grp)
 		*grp = node->grp;
 
-	if (!fd->handler)
-		cacheless_tid_rb_remove(fd, node);
-	else
-		hfi1_mmu_rb_remove(fd->handler, &node->mmu);
+	if (fd->use_mn)
+		mmu_interval_notifier_remove(&node->notifier);
+	cacheless_tid_rb_remove(fd, node);
 
 	return 0;
 }
@@ -847,7 +833,8 @@ static void clear_tid_node(struct hfi1_filedata *fd, struct tid_rb_node *node)
 	struct hfi1_devdata *dd = uctxt->dd;
 
 	trace_hfi1_exp_tid_unreg(uctxt->ctxt, fd->subctxt, node->rcventry,
-				 node->npages, node->mmu.addr, node->phys,
+				 node->npages,
+				 node->notifier.interval_tree.start, node->phys,
 				 node->dma_addr);
 
 	/*
@@ -894,30 +881,29 @@ static void unlock_exp_tids(struct hfi1_ctxtdata *uctxt,
 				if (!node || node->rcventry != rcventry)
 					continue;
 
+				if (fd->use_mn)
+					mmu_interval_notifier_remove(
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
+static bool tid_rb_invalidate(struct mmu_interval_notifier *mni,
+			      const struct mmu_notifier_range *range,
+			      unsigned long cur_seq)
 {
-	struct hfi1_filedata *fdata = arg;
-	struct hfi1_ctxtdata *uctxt = fdata->uctxt;
 	struct tid_rb_node *node =
-		container_of(mnode, struct tid_rb_node, mmu);
+		container_of(mni, struct tid_rb_node, notifier);
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
 
@@ -946,18 +932,7 @@ static int tid_rb_invalidate(void *arg, struct mmu_rb_node *mnode)
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
@@ -968,12 +943,3 @@ static void cacheless_tid_rb_remove(struct hfi1_filedata *fdata,
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
index 43b105de1d5427..6257eee083a1a3 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.h
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.h
@@ -65,7 +65,8 @@ struct tid_user_buf {
 };
 
 struct tid_rb_node {
-	struct mmu_rb_node mmu;
+	struct mmu_interval_notifier notifier;
+	struct hfi1_filedata *fdata;
 	unsigned long phys;
 	struct tid_group *grp;
 	u32 rcventry;
-- 
2.24.0

