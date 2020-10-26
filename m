Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598E2298DBF
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 14:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421589AbgJZNXb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 09:23:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1421387AbgJZNXb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Oct 2020 09:23:31 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE16A20809;
        Mon, 26 Oct 2020 13:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603718609;
        bh=PYwZLC8/yT5tBFbeK+OTDL8BpEkl6S0LlpQryvu0wao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k4nRv4ZevMPrAepJKnA8xEQb4CGqMxTZXrwcodT1M0Vji9q4/6r6sc20OXTT7FwX+
         het14AsPdEovl5LMjN5UA0h2F3K4EGeJVLseSnyrDBqlC/i8W6PSbDlirnqQl9/niZ
         QZJhCcGebyrrgk60szrIJgWVs18Gv5Wl1CnPiqNI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 3/5] RDMA/mlx5: Split the WR setup out of mlx5_ib_update_xlt()
Date:   Mon, 26 Oct 2020 15:23:12 +0200
Message-Id: <20201026132314.1336717-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026132314.1336717-1-leon@kernel.org>
References: <20201026132314.1336717-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

The memory allocation is quite complicated, and makes this function hard
to understand. Refactor things so that a function call sets up the WR, SG,
DMA mapping and buffer, further splitting that into buffer and DMA/wr.

This also slightly changes the buffer allocation logic to try an order 0
page allocation (with OOM warnings on) before going to the emergency page.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c    |   6 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   2 +-
 drivers/infiniband/hw/mlx5/mr.c      | 189 ++++++++++++++++++---------
 3 files changed, 128 insertions(+), 69 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index b7eb977eb869..32ec59315f39 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4875,13 +4875,13 @@ static int __init mlx5_ib_init(void)
 {
 	int err;
 
-	xlt_emergency_page = __get_free_page(GFP_KERNEL);
+	xlt_emergency_page = (void *)__get_free_page(GFP_KERNEL);
 	if (!xlt_emergency_page)
 		return -ENOMEM;
 
 	mlx5_ib_event_wq = alloc_ordered_workqueue("mlx5_ib_event_wq", 0);
 	if (!mlx5_ib_event_wq) {
-		free_page(xlt_emergency_page);
+		free_page((unsigned long)xlt_emergency_page);
 		return -ENOMEM;
 	}
 
@@ -4896,7 +4896,7 @@ static void __exit mlx5_ib_cleanup(void)
 {
 	mlx5_unregister_interface(&mlx5_ib_interface);
 	destroy_workqueue(mlx5_ib_event_wq);
-	free_page(xlt_emergency_page);
+	free_page((unsigned long)xlt_emergency_page);
 }
 
 module_init(mlx5_ib_init);
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 8f728b98f9a6..d92afbd26aa5 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1454,7 +1454,7 @@ static inline int get_num_static_uars(struct mlx5_ib_dev *dev,
 	return get_uars_per_sys_page(dev, bfregi->lib_uar_4k) * bfregi->num_static_sys_pages;
 }
 
-extern unsigned long xlt_emergency_page;
+extern void *xlt_emergency_page;
 
 int bfregn_to_uar_index(struct mlx5_ib_dev *dev,
 			struct mlx5_bfreg_info *bfregi, u32 bfregn,
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 2971e7f48d40..b2ec4abc5639 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -45,7 +45,7 @@
  * We can't use an array for xlt_emergency_page because dma_map_single doesn't
  * work on kernel modules memory
  */
-unsigned long xlt_emergency_page;
+void *xlt_emergency_page;
 static DEFINE_MUTEX(xlt_emergency_page_mutex);
 
 enum {
@@ -999,15 +999,121 @@ static struct mlx5_ib_mr *alloc_mr_from_cache(struct ib_pd *pd,
 			    MLX5_UMR_MTT_ALIGNMENT)
 #define MLX5_SPARE_UMR_CHUNK 0x10000
 
-static unsigned long mlx5_ib_get_xlt_emergency_page(void)
+/*
+ * Allocate a temporary buffer to hold the per-page information to transfer to
+ * HW. For efficiency this should be as large as it can be, but buffer
+ * allocation failure is not allowed, so try smaller sizes.
+ */
+static void *mlx5_ib_alloc_xlt(size_t *nents, size_t ent_size, gfp_t gfp_mask)
 {
+	const size_t xlt_chunk_align =
+		MLX5_UMR_MTT_ALIGNMENT / sizeof(ent_size);
+	size_t size;
+	void *res = NULL;
+
+	static_assert(PAGE_SIZE % MLX5_UMR_MTT_ALIGNMENT == 0);
+
+	/*
+	 * MLX5_IB_UPD_XLT_ATOMIC doesn't signal an atomic context just that the
+	 * allocation can't trigger any kind of reclaim.
+	 */
+	might_sleep();
+
+	gfp_mask |= __GFP_ZERO;
+
+	/*
+	 * If the system already has a suitable high order page then just use
+	 * that, but don't try hard to create one. This max is about 1M, so a
+	 * free x86 huge page will satisfy it.
+	 */
+	size = min_t(size_t, ent_size * ALIGN(*nents, xlt_chunk_align),
+		     MLX5_MAX_UMR_CHUNK);
+	*nents = size / ent_size;
+	res = (void *)__get_free_pages(gfp_mask | __GFP_NOWARN,
+				       get_order(size));
+	if (res)
+		return res;
+
+	if (size > MLX5_SPARE_UMR_CHUNK) {
+		size = MLX5_SPARE_UMR_CHUNK;
+		*nents = get_order(size) / ent_size;
+		res = (void *)__get_free_pages(gfp_mask | __GFP_NOWARN,
+					       get_order(size));
+		if (res)
+			return res;
+	}
+
+	*nents = PAGE_SIZE / ent_size;
+	res = (void *)__get_free_page(gfp_mask);
+	if (res)
+		return res;
+
 	mutex_lock(&xlt_emergency_page_mutex);
+	memset(xlt_emergency_page, 0, PAGE_SIZE);
 	return xlt_emergency_page;
 }
 
-static void mlx5_ib_put_xlt_emergency_page(void)
+static void mlx5_ib_free_xlt(void *xlt, size_t length)
+{
+	if (xlt == xlt_emergency_page) {
+		mutex_unlock(&xlt_emergency_page_mutex);
+		return;
+	}
+
+	free_pages((unsigned long)xlt, get_order(length));
+}
+
+/*
+ * Create a MLX5_IB_SEND_UMR_UPDATE_XLT work request and XLT buffer ready for
+ * submission.
+ */
+static void *mlx5_ib_create_xlt_wr(struct mlx5_ib_mr *mr,
+				   struct mlx5_umr_wr *wr, struct ib_sge *sg,
+				   size_t nents, size_t ent_size,
+				   unsigned int flags)
+{
+	struct mlx5_ib_dev *dev = mr->dev;
+	struct device *ddev = dev->ib_dev.dev.parent;
+	dma_addr_t dma;
+	void *xlt;
+
+	xlt = mlx5_ib_alloc_xlt(&nents, ent_size,
+				flags & MLX5_IB_UPD_XLT_ATOMIC ? GFP_ATOMIC :
+								 GFP_KERNEL);
+	sg->length = nents * ent_size;
+	dma = dma_map_single(ddev, xlt, sg->length, DMA_TO_DEVICE);
+	if (dma_mapping_error(ddev, dma)) {
+		mlx5_ib_err(dev, "unable to map DMA during XLT update.\n");
+		mlx5_ib_free_xlt(xlt, sg->length);
+		return NULL;
+	}
+	sg->addr = dma;
+	sg->lkey = dev->umrc.pd->local_dma_lkey;
+
+	memset(wr, 0, sizeof(*wr));
+	wr->wr.send_flags = MLX5_IB_SEND_UMR_UPDATE_XLT;
+	if (!(flags & MLX5_IB_UPD_XLT_ENABLE))
+		wr->wr.send_flags |= MLX5_IB_SEND_UMR_FAIL_IF_FREE;
+	wr->wr.sg_list = sg;
+	wr->wr.num_sge = 1;
+	wr->wr.opcode = MLX5_IB_WR_UMR;
+	wr->pd = mr->ibmr.pd;
+	wr->mkey = mr->mmkey.key;
+	wr->length = mr->mmkey.size;
+	wr->virt_addr = mr->mmkey.iova;
+	wr->access_flags = mr->access_flags;
+	wr->page_shift = mr->page_shift;
+	wr->xlt_size = sg->length;
+	return xlt;
+}
+
+static void mlx5_ib_unmap_free_xlt(struct mlx5_ib_dev *dev, void *xlt,
+				   struct ib_sge *sg)
 {
-	mutex_unlock(&xlt_emergency_page_mutex);
+	struct device *ddev = dev->ib_dev.dev.parent;
+
+	dma_unmap_single(ddev, sg->addr, sg->length, DMA_TO_DEVICE);
+	mlx5_ib_free_xlt(xlt, sg->length);
 }
 
 int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
@@ -1015,9 +1121,7 @@ int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 {
 	struct mlx5_ib_dev *dev = mr->dev;
 	struct device *ddev = dev->ib_dev.dev.parent;
-	int size;
 	void *xlt;
-	dma_addr_t dma;
 	struct mlx5_umr_wr wr;
 	struct ib_sge sg;
 	int err = 0;
@@ -1028,10 +1132,9 @@ int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 	const int page_mask = page_align - 1;
 	size_t pages_mapped = 0;
 	size_t pages_to_map = 0;
-	size_t pages_iter = 0;
+	size_t pages_iter;
 	size_t size_to_map = 0;
-	gfp_t gfp;
-	bool use_emergency_page = false;
+	size_t orig_sg_length;
 
 	if ((flags & MLX5_IB_UPD_XLT_INDIRECT) &&
 	    !umr_can_use_indirect_mkey(dev))
@@ -1044,37 +1147,13 @@ int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 		npages += idx & page_mask;
 		idx &= ~page_mask;
 	}
-
-	gfp = flags & MLX5_IB_UPD_XLT_ATOMIC ? GFP_ATOMIC : GFP_KERNEL;
-	gfp |= __GFP_ZERO | __GFP_NOWARN;
-
 	pages_to_map = ALIGN(npages, page_align);
-	size = desc_size * pages_to_map;
-	size = min_t(int, size, MLX5_MAX_UMR_CHUNK);
-
-	xlt = (void *)__get_free_pages(gfp, get_order(size));
-	if (!xlt && size > MLX5_SPARE_UMR_CHUNK) {
-		mlx5_ib_dbg(dev, "Failed to allocate %d bytes of order %d. fallback to spare UMR allocation od %d bytes\n",
-			    size, get_order(size), MLX5_SPARE_UMR_CHUNK);
 
-		size = MLX5_SPARE_UMR_CHUNK;
-		xlt = (void *)__get_free_pages(gfp, get_order(size));
-	}
-
-	if (!xlt) {
-		mlx5_ib_warn(dev, "Using XLT emergency buffer\n");
-		xlt = (void *)mlx5_ib_get_xlt_emergency_page();
-		size = PAGE_SIZE;
-		memset(xlt, 0, size);
-		use_emergency_page = true;
-	}
-	pages_iter = size / desc_size;
-	dma = dma_map_single(ddev, xlt, size, DMA_TO_DEVICE);
-	if (dma_mapping_error(ddev, dma)) {
-		mlx5_ib_err(dev, "unable to map DMA during XLT update.\n");
-		err = -ENOMEM;
-		goto free_xlt;
-	}
+	xlt = mlx5_ib_create_xlt_wr(mr, &wr, &sg, npages, desc_size, flags);
+	if (!xlt)
+		return -ENOMEM;
+	pages_iter = sg.length / desc_size;
+	orig_sg_length = sg.length;
 
 	if (mr->umem->is_odp) {
 		if (!(flags & MLX5_IB_UPD_XLT_INDIRECT)) {
@@ -1085,22 +1164,6 @@ int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 		}
 	}
 
-	sg.addr = dma;
-	sg.lkey = dev->umrc.pd->local_dma_lkey;
-
-	memset(&wr, 0, sizeof(wr));
-	wr.wr.send_flags = MLX5_IB_SEND_UMR_UPDATE_XLT;
-	if (!(flags & MLX5_IB_UPD_XLT_ENABLE))
-		wr.wr.send_flags |= MLX5_IB_SEND_UMR_FAIL_IF_FREE;
-	wr.wr.sg_list = &sg;
-	wr.wr.num_sge = 1;
-	wr.wr.opcode = MLX5_IB_WR_UMR;
-
-	wr.pd = mr->ibmr.pd;
-	wr.mkey = mr->mmkey.key;
-	wr.length = mr->mmkey.size;
-	wr.virt_addr = mr->mmkey.iova;
-	wr.access_flags = mr->access_flags;
 	wr.page_shift = page_shift;
 
 	for (pages_mapped = 0;
@@ -1108,7 +1171,8 @@ int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 	     pages_mapped += pages_iter, idx += pages_iter) {
 		npages = min_t(int, pages_iter, pages_to_map - pages_mapped);
 		size_to_map = npages * desc_size;
-		dma_sync_single_for_cpu(ddev, dma, size, DMA_TO_DEVICE);
+		dma_sync_single_for_cpu(ddev, sg.addr, sg.length,
+					DMA_TO_DEVICE);
 		if (mr->umem->is_odp) {
 			mlx5_odp_populate_xlt(xlt, idx, npages, mr, flags);
 		} else {
@@ -1118,9 +1182,10 @@ int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 			/* Clear padding after the pages
 			 * brought from the umem.
 			 */
-			memset(xlt + size_to_map, 0, size - size_to_map);
+			memset(xlt + size_to_map, 0, sg.length - size_to_map);
 		}
-		dma_sync_single_for_device(ddev, dma, size, DMA_TO_DEVICE);
+		dma_sync_single_for_device(ddev, sg.addr, sg.length,
+					   DMA_TO_DEVICE);
 
 		sg.length = ALIGN(size_to_map, MLX5_UMR_MTT_ALIGNMENT);
 
@@ -1144,14 +1209,8 @@ int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 
 		err = mlx5_ib_post_send_wait(dev, &wr);
 	}
-	dma_unmap_single(ddev, dma, size, DMA_TO_DEVICE);
-
-free_xlt:
-	if (use_emergency_page)
-		mlx5_ib_put_xlt_emergency_page();
-	else
-		free_pages((unsigned long)xlt, get_order(size));
-
+	sg.length = orig_sg_length;
+	mlx5_ib_unmap_free_xlt(dev, xlt, &sg);
 	return err;
 }
 
-- 
2.26.2

