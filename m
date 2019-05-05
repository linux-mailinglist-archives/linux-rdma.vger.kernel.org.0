Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 344071400C
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2019 16:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfEEOHZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 May 2019 10:07:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfEEOHZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 5 May 2019 10:07:25 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDBAE204FD;
        Sun,  5 May 2019 14:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557065243;
        bh=S5tG9irxYyXP2f8+SbgzXsZulQnxSPQ4sWdGxSFUGC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=goaNNotW6I/7kXyRw8oXvL8m/eidNZ8+pUmlIuDmI464ddpvfU48iERitdtf2nRXP
         Xf7PsPwnSG+UYj2WS6a2ZBQi0IImpbI6j4RVJwC2U5em6be8tb7WMyio81jZY1VXKN
         FyH3g0t/kfxBBQGYnpJj3oNo0wGMTAU8dAyi5N9Q=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Ariel Levkovich <lariel@mellanox.com>,
        Eli Cohen <eli@mellanox.com>, Mark Bloch <markb@mellanox.com>
Subject: [PATCH rdma-next 1/4] IB/mlx5: Support device memory type attribute
Date:   Sun,  5 May 2019 17:07:11 +0300
Message-Id: <20190505140714.8741-2-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190505140714.8741-1-leon@kernel.org>
References: <20190505140714.8741-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Ariel Levkovich <lariel@mellanox.com>

This patch intoruduces a new mlx5_ib driver attribute
to the DM allocation method - the DM type.

In order to allow addition of new types in downstream patches
this patch also refactors the allocation, deallocation and
registration handlers to consider the requested type and
perform the necessary actions according to it.

Since not all future device memory types will be such that are mapped
to user memory, the mandatory page index output attribute is modified
to be optional.

Signed-off-by: Ariel Levkovich <lariel@mellanox.com>
Reviewed-by: Eli Cohen <eli@mellanox.com>
Reviewed-by: Mark Bloch <markb@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/cmd.c          |  30 ++---
 drivers/infiniband/hw/mlx5/cmd.h          |   4 +-
 drivers/infiniband/hw/mlx5/main.c         | 135 ++++++++++++++--------
 drivers/infiniband/hw/mlx5/mlx5_ib.h      |  23 ++--
 drivers/infiniband/hw/mlx5/mr.c           |  32 +++--
 include/uapi/rdma/mlx5_user_ioctl_cmds.h  |   1 +
 include/uapi/rdma/mlx5_user_ioctl_verbs.h |   4 +
 7 files changed, 145 insertions(+), 84 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cmd.c b/drivers/infiniband/hw/mlx5/cmd.c
index be95ac5aeb30..f0e9c7609083 100644
--- a/drivers/infiniband/hw/mlx5/cmd.c
+++ b/drivers/infiniband/hw/mlx5/cmd.c
@@ -82,10 +82,10 @@ int mlx5_cmd_modify_cong_params(struct mlx5_core_dev *dev,
 	return mlx5_cmd_exec(dev, in, in_size, out, sizeof(out));
 }
 
-int mlx5_cmd_alloc_memic(struct mlx5_memic *memic, phys_addr_t *addr,
-			  u64 length, u32 alignment)
+int mlx5_cmd_alloc_memic(struct mlx5_dm *dm, phys_addr_t *addr,
+			 u64 length, u32 alignment)
 {
-	struct mlx5_core_dev *dev = memic->dev;
+	struct mlx5_core_dev *dev = dm->dev;
 	u64 num_memic_hw_pages = MLX5_CAP_DEV_MEM(dev, memic_bar_size)
 					>> PAGE_SHIFT;
 	u64 hw_start_addr = MLX5_CAP64_DEV_MEM(dev, memic_bar_start_addr);
@@ -115,17 +115,17 @@ int mlx5_cmd_alloc_memic(struct mlx5_memic *memic, phys_addr_t *addr,
 		 mlx5_alignment);
 
 	while (page_idx < num_memic_hw_pages) {
-		spin_lock(&memic->memic_lock);
-		page_idx = bitmap_find_next_zero_area(memic->memic_alloc_pages,
+		spin_lock(&dm->lock);
+		page_idx = bitmap_find_next_zero_area(dm->memic_alloc_pages,
 						      num_memic_hw_pages,
 						      page_idx,
 						      num_pages, 0);
 
 		if (page_idx < num_memic_hw_pages)
-			bitmap_set(memic->memic_alloc_pages,
+			bitmap_set(dm->memic_alloc_pages,
 				   page_idx, num_pages);
 
-		spin_unlock(&memic->memic_lock);
+		spin_unlock(&dm->lock);
 
 		if (page_idx >= num_memic_hw_pages)
 			break;
@@ -135,10 +135,10 @@ int mlx5_cmd_alloc_memic(struct mlx5_memic *memic, phys_addr_t *addr,
 
 		ret = mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
 		if (ret) {
-			spin_lock(&memic->memic_lock);
-			bitmap_clear(memic->memic_alloc_pages,
+			spin_lock(&dm->lock);
+			bitmap_clear(dm->memic_alloc_pages,
 				     page_idx, num_pages);
-			spin_unlock(&memic->memic_lock);
+			spin_unlock(&dm->lock);
 
 			if (ret == -EAGAIN) {
 				page_idx++;
@@ -157,9 +157,9 @@ int mlx5_cmd_alloc_memic(struct mlx5_memic *memic, phys_addr_t *addr,
 	return -ENOMEM;
 }
 
-int mlx5_cmd_dealloc_memic(struct mlx5_memic *memic, u64 addr, u64 length)
+int mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, u64 addr, u64 length)
 {
-	struct mlx5_core_dev *dev = memic->dev;
+	struct mlx5_core_dev *dev = dm->dev;
 	u64 hw_start_addr = MLX5_CAP64_DEV_MEM(dev, memic_bar_start_addr);
 	u32 num_pages = DIV_ROUND_UP(length, PAGE_SIZE);
 	u32 out[MLX5_ST_SZ_DW(dealloc_memic_out)] = {0};
@@ -177,10 +177,10 @@ int mlx5_cmd_dealloc_memic(struct mlx5_memic *memic, u64 addr, u64 length)
 	err =  mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
 
 	if (!err) {
-		spin_lock(&memic->memic_lock);
-		bitmap_clear(memic->memic_alloc_pages,
+		spin_lock(&dm->lock);
+		bitmap_clear(dm->memic_alloc_pages,
 			     start_page_idx, num_pages);
-		spin_unlock(&memic->memic_lock);
+		spin_unlock(&dm->lock);
 	}
 
 	return err;
diff --git a/drivers/infiniband/hw/mlx5/cmd.h b/drivers/infiniband/hw/mlx5/cmd.h
index 923a7b93f507..80a644bea6c7 100644
--- a/drivers/infiniband/hw/mlx5/cmd.h
+++ b/drivers/infiniband/hw/mlx5/cmd.h
@@ -44,9 +44,9 @@ int mlx5_cmd_query_cong_params(struct mlx5_core_dev *dev, int cong_point,
 int mlx5_cmd_query_ext_ppcnt_counters(struct mlx5_core_dev *dev, void *out);
 int mlx5_cmd_modify_cong_params(struct mlx5_core_dev *mdev,
 				void *in, int in_size);
-int mlx5_cmd_alloc_memic(struct mlx5_memic *memic, phys_addr_t *addr,
+int mlx5_cmd_alloc_memic(struct mlx5_dm *dm, phys_addr_t *addr,
 			 u64 length, u32 alignment);
-int mlx5_cmd_dealloc_memic(struct mlx5_memic *memic, u64 addr, u64 length);
+int mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, u64 addr, u64 length);
 void mlx5_cmd_dealloc_pd(struct mlx5_core_dev *dev, u32 pdn, u16 uid);
 void mlx5_cmd_destroy_tir(struct mlx5_core_dev *dev, u32 tirn, u16 uid);
 void mlx5_cmd_destroy_tis(struct mlx5_core_dev *dev, u32 tisn, u16 uid);
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index d69cfe511c37..06c4bb9e13db 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2294,58 +2294,90 @@ static int mlx5_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_struct *vm
 	return 0;
 }
 
-struct ib_dm *mlx5_ib_alloc_dm(struct ib_device *ibdev,
-			       struct ib_ucontext *context,
-			       struct ib_dm_alloc_attr *attr,
-			       struct uverbs_attr_bundle *attrs)
+static int handle_alloc_dm_memic(struct ib_ucontext *ctx,
+				 struct mlx5_ib_dm *dm,
+				 struct ib_dm_alloc_attr *attr,
+				 struct uverbs_attr_bundle *attrs)
 {
-	u64 act_size = roundup(attr->length, MLX5_MEMIC_BASE_SIZE);
-	struct mlx5_memic *memic = &to_mdev(ibdev)->memic;
-	phys_addr_t memic_addr;
-	struct mlx5_ib_dm *dm;
+	struct mlx5_dm *dm_db = &to_mdev(ctx->device)->dm;
 	u64 start_offset;
 	u32 page_idx;
 	int err;
 
-	dm = kzalloc(sizeof(*dm), GFP_KERNEL);
-	if (!dm)
-		return ERR_PTR(-ENOMEM);
-
-	mlx5_ib_dbg(to_mdev(ibdev), "alloc_memic req: user_length=0x%llx act_length=0x%llx log_alignment=%d\n",
-		    attr->length, act_size, attr->alignment);
+	dm->size = roundup(attr->length, MLX5_MEMIC_BASE_SIZE);
 
-	err = mlx5_cmd_alloc_memic(memic, &memic_addr,
-				   act_size, attr->alignment);
+	err = mlx5_cmd_alloc_memic(dm_db, &dm->dev_addr,
+				   dm->size, attr->alignment);
 	if (err)
-		goto err_free;
+		return err;
 
-	start_offset = memic_addr & ~PAGE_MASK;
-	page_idx = (memic_addr - memic->dev->bar_addr -
-		    MLX5_CAP64_DEV_MEM(memic->dev, memic_bar_start_addr)) >>
+	page_idx = (dm->dev_addr - pci_resource_start(dm_db->dev->pdev, 0) -
+		    MLX5_CAP64_DEV_MEM(dm_db->dev, memic_bar_start_addr)) >>
 		    PAGE_SHIFT;
 
 	err = uverbs_copy_to(attrs,
-			     MLX5_IB_ATTR_ALLOC_DM_RESP_START_OFFSET,
-			     &start_offset, sizeof(start_offset));
+			     MLX5_IB_ATTR_ALLOC_DM_RESP_PAGE_INDEX,
+			     &page_idx, sizeof(page_idx));
 	if (err)
 		goto err_dealloc;
 
+	start_offset = dm->dev_addr & ~PAGE_MASK;
 	err = uverbs_copy_to(attrs,
-			     MLX5_IB_ATTR_ALLOC_DM_RESP_PAGE_INDEX,
-			     &page_idx, sizeof(page_idx));
+			     MLX5_IB_ATTR_ALLOC_DM_RESP_START_OFFSET,
+			     &start_offset, sizeof(start_offset));
 	if (err)
 		goto err_dealloc;
 
-	bitmap_set(to_mucontext(context)->dm_pages, page_idx,
-		   DIV_ROUND_UP(act_size, PAGE_SIZE));
+	bitmap_set(to_mucontext(ctx)->dm_pages, page_idx,
+		   DIV_ROUND_UP(dm->size, PAGE_SIZE));
+
+	return 0;
+
+err_dealloc:
+	mlx5_cmd_dealloc_memic(dm_db, dm->dev_addr, dm->size);
+
+	return err;
+}
+
+struct ib_dm *mlx5_ib_alloc_dm(struct ib_device *ibdev,
+			       struct ib_ucontext *context,
+			       struct ib_dm_alloc_attr *attr,
+			       struct uverbs_attr_bundle *attrs)
+{
+	struct mlx5_ib_dm *dm;
+	enum mlx5_ib_uapi_dm_type type;
+	int err;
+
+	err = uverbs_get_const_default(&type, attrs,
+				       MLX5_IB_ATTR_ALLOC_DM_REQ_TYPE,
+				       MLX5_IB_UAPI_DM_TYPE_MEMIC);
+	if (err)
+		return ERR_PTR(err);
+
+	mlx5_ib_dbg(to_mdev(ibdev), "alloc_dm req: dm_type=%d user_length=0x%llx log_alignment=%d\n",
+		    type, attr->length, attr->alignment);
+
+	dm = kzalloc(sizeof(*dm), GFP_KERNEL);
+	if (!dm)
+		return ERR_PTR(-ENOMEM);
+
+	dm->type = type;
+
+	switch (type) {
+	case MLX5_IB_UAPI_DM_TYPE_MEMIC:
+		err = handle_alloc_dm_memic(context, dm,
+					    attr,
+					    attrs);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+	}
 
-	dm->dev_addr = memic_addr;
+	if (err)
+		goto err_free;
 
 	return &dm->ibdm;
 
-err_dealloc:
-	mlx5_cmd_dealloc_memic(memic, memic_addr,
-			       act_size);
 err_free:
 	kfree(dm);
 	return ERR_PTR(err);
@@ -2353,25 +2385,31 @@ struct ib_dm *mlx5_ib_alloc_dm(struct ib_device *ibdev,
 
 int mlx5_ib_dealloc_dm(struct ib_dm *ibdm, struct uverbs_attr_bundle *attrs)
 {
-	struct mlx5_memic *memic = &to_mdev(ibdm->device)->memic;
+	struct mlx5_dm *dm_db = &to_mdev(ibdm->device)->dm;
 	struct mlx5_ib_dm *dm = to_mdm(ibdm);
-	u64 act_size = roundup(dm->ibdm.length, MLX5_MEMIC_BASE_SIZE);
 	u32 page_idx;
 	int ret;
 
-	ret = mlx5_cmd_dealloc_memic(memic, dm->dev_addr, act_size);
-	if (ret)
-		return ret;
+	switch (dm->type) {
+	case MLX5_IB_UAPI_DM_TYPE_MEMIC:
+		ret = mlx5_cmd_dealloc_memic(dm_db, dm->dev_addr, dm->size);
+		if (ret)
+			return ret;
 
-	page_idx = (dm->dev_addr - memic->dev->bar_addr -
-		    MLX5_CAP64_DEV_MEM(memic->dev, memic_bar_start_addr)) >>
-		    PAGE_SHIFT;
-	bitmap_clear(rdma_udata_to_drv_context(
-			&attrs->driver_udata,
-			struct mlx5_ib_ucontext,
-			ibucontext)->dm_pages,
-		     page_idx,
-		     DIV_ROUND_UP(act_size, PAGE_SIZE));
+		page_idx = (dm->dev_addr -
+			    pci_resource_start(dm_db->dev->pdev, 0) -
+			    MLX5_CAP64_DEV_MEM(dm_db->dev,
+					       memic_bar_start_addr)) >>
+			   PAGE_SHIFT;
+		bitmap_clear(rdma_udata_to_drv_context(&attrs->driver_udata,
+						       struct mlx5_ib_ucontext,
+						       ibucontext)
+				     ->dm_pages,
+			     page_idx, DIV_ROUND_UP(dm->size, PAGE_SIZE));
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
 
 	kfree(dm);
 
@@ -5872,7 +5910,10 @@ ADD_UVERBS_ATTRIBUTES_SIMPLE(
 			    UA_MANDATORY),
 	UVERBS_ATTR_PTR_OUT(MLX5_IB_ATTR_ALLOC_DM_RESP_PAGE_INDEX,
 			    UVERBS_ATTR_TYPE(u16),
-			    UA_MANDATORY));
+			    UA_OPTIONAL),
+	UVERBS_ATTR_CONST_IN(MLX5_IB_ATTR_ALLOC_DM_REQ_TYPE,
+			     enum mlx5_ib_uapi_dm_type,
+			     UA_OPTIONAL));
 
 ADD_UVERBS_ATTRIBUTES_SIMPLE(
 	mlx5_ib_flow_action,
@@ -6020,8 +6061,8 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 	INIT_LIST_HEAD(&dev->qp_list);
 	spin_lock_init(&dev->reset_flow_resource_lock);
 
-	spin_lock_init(&dev->memic.memic_lock);
-	dev->memic.dev = mdev;
+	spin_lock_init(&dev->dm.lock);
+	dev->dm.dev = mdev;
 
 	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING)) {
 		err = init_srcu_struct(&dev->mr_srcu);
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 447f8ad5abbd..86f8110bf3ab 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -48,6 +48,7 @@
 #include <rdma/mlx5-abi.h>
 #include <rdma/uverbs_ioctl.h>
 #include <rdma/mlx5_user_ioctl_cmds.h>
+#include <rdma/mlx5_user_ioctl_verbs.h>
 
 #include "srq.h"
 
@@ -558,15 +559,17 @@ enum mlx5_ib_mtt_access_flags {
 struct mlx5_ib_dm {
 	struct ib_dm		ibdm;
 	phys_addr_t		dev_addr;
+	u32			type;
+	size_t			size;
 };
 
 #define MLX5_IB_MTT_PRESENT (MLX5_IB_MTT_READ | MLX5_IB_MTT_WRITE)
 
-#define MLX5_IB_DM_ALLOWED_ACCESS (IB_ACCESS_LOCAL_WRITE   |\
-				   IB_ACCESS_REMOTE_WRITE  |\
-				   IB_ACCESS_REMOTE_READ   |\
-				   IB_ACCESS_REMOTE_ATOMIC |\
-				   IB_ZERO_BASED)
+#define MLX5_IB_DM_MEMIC_ALLOWED_ACCESS (IB_ACCESS_LOCAL_WRITE   |\
+					 IB_ACCESS_REMOTE_WRITE  |\
+					 IB_ACCESS_REMOTE_READ   |\
+					 IB_ACCESS_REMOTE_ATOMIC |\
+					 IB_ZERO_BASED)
 
 struct mlx5_ib_mr {
 	struct ib_mr		ibmr;
@@ -847,9 +850,13 @@ struct mlx5_ib_flow_action {
 	};
 };
 
-struct mlx5_memic {
+struct mlx5_dm {
 	struct mlx5_core_dev *dev;
-	spinlock_t		memic_lock;
+	/* This lock is used to protect the access to the shared
+	 * allocation map when concurrent requests by different
+	 * processes are handled.
+	 */
+	spinlock_t lock;
 	DECLARE_BITMAP(memic_alloc_pages, MLX5_MAX_MEMIC_PAGES);
 };
 
@@ -953,7 +960,7 @@ struct mlx5_ib_dev {
 	u8			umr_fence;
 	struct list_head	ib_dev_list;
 	u64			sys_image_guid;
-	struct mlx5_memic	memic;
+	struct mlx5_dm		dm;
 	u16			devx_whitelist_uid;
 	struct mlx5_srq_table   srq_table;
 	struct mlx5_async_ctx   async_ctx;
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 4381cddab97b..ba35d68e7499 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1159,8 +1159,8 @@ static void set_mr_fields(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
 	mr->access_flags = access_flags;
 }
 
-static struct ib_mr *mlx5_ib_get_memic_mr(struct ib_pd *pd, u64 memic_addr,
-					  u64 length, int acc)
+static struct ib_mr *mlx5_ib_get_dm_mr(struct ib_pd *pd, u64 start_addr,
+				       u64 length, int acc, int mode)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	int inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
@@ -1182,9 +1182,8 @@ static struct ib_mr *mlx5_ib_get_memic_mr(struct ib_pd *pd, u64 memic_addr,
 
 	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
 
-	MLX5_SET(mkc, mkc, access_mode_1_0, MLX5_MKC_ACCESS_MODE_MEMIC & 0x3);
-	MLX5_SET(mkc, mkc, access_mode_4_2,
-		 (MLX5_MKC_ACCESS_MODE_MEMIC >> 2) & 0x7);
+	MLX5_SET(mkc, mkc, access_mode_1_0, mode & 0x3);
+	MLX5_SET(mkc, mkc, access_mode_4_2, (mode >> 2) & 0x7);
 	MLX5_SET(mkc, mkc, a, !!(acc & IB_ACCESS_REMOTE_ATOMIC));
 	MLX5_SET(mkc, mkc, rw, !!(acc & IB_ACCESS_REMOTE_WRITE));
 	MLX5_SET(mkc, mkc, rr, !!(acc & IB_ACCESS_REMOTE_READ));
@@ -1194,7 +1193,7 @@ static struct ib_mr *mlx5_ib_get_memic_mr(struct ib_pd *pd, u64 memic_addr,
 	MLX5_SET64(mkc, mkc, len, length);
 	MLX5_SET(mkc, mkc, pd, to_mpd(pd)->pdn);
 	MLX5_SET(mkc, mkc, qpn, 0xffffff);
-	MLX5_SET64(mkc, mkc, start_addr, memic_addr - dev->mdev->bar_addr);
+	MLX5_SET64(mkc, mkc, start_addr, start_addr);
 
 	err = mlx5_core_create_mkey(mdev, &mr->mmkey, in, inlen);
 	if (err)
@@ -1236,15 +1235,24 @@ struct ib_mr *mlx5_ib_reg_dm_mr(struct ib_pd *pd, struct ib_dm *dm,
 				struct uverbs_attr_bundle *attrs)
 {
 	struct mlx5_ib_dm *mdm = to_mdm(dm);
-	u64 memic_addr;
+	struct mlx5_core_dev *dev = to_mdev(dm->device)->mdev;
+	u64 start_addr = mdm->dev_addr + attr->offset;
+	int mode;
 
-	if (attr->access_flags & ~MLX5_IB_DM_ALLOWED_ACCESS)
-		return ERR_PTR(-EINVAL);
+	switch (mdm->type) {
+	case MLX5_IB_UAPI_DM_TYPE_MEMIC:
+		if (attr->access_flags & ~MLX5_IB_DM_MEMIC_ALLOWED_ACCESS)
+			return ERR_PTR(-EINVAL);
 
-	memic_addr = mdm->dev_addr + attr->offset;
+		mode = MLX5_MKC_ACCESS_MODE_MEMIC;
+		start_addr -= pci_resource_start(dev->pdev, 0);
+		break;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
 
-	return mlx5_ib_get_memic_mr(pd, memic_addr, attr->length,
-				    attr->access_flags);
+	return mlx5_ib_get_dm_mr(pd, start_addr, attr->length,
+				 attr->access_flags, mode);
 }
 
 struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
diff --git a/include/uapi/rdma/mlx5_user_ioctl_cmds.h b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
index 0d8f564ce60b..d404c951954c 100644
--- a/include/uapi/rdma/mlx5_user_ioctl_cmds.h
+++ b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
@@ -44,6 +44,7 @@ enum mlx5_ib_create_flow_action_attrs {
 enum mlx5_ib_alloc_dm_attrs {
 	MLX5_IB_ATTR_ALLOC_DM_RESP_START_OFFSET = (1U << UVERBS_ID_NS_SHIFT),
 	MLX5_IB_ATTR_ALLOC_DM_RESP_PAGE_INDEX,
+	MLX5_IB_ATTR_ALLOC_DM_REQ_TYPE,
 };
 
 enum mlx5_ib_devx_methods {
diff --git a/include/uapi/rdma/mlx5_user_ioctl_verbs.h b/include/uapi/rdma/mlx5_user_ioctl_verbs.h
index 0a126a6b9337..c291fb2f8446 100644
--- a/include/uapi/rdma/mlx5_user_ioctl_verbs.h
+++ b/include/uapi/rdma/mlx5_user_ioctl_verbs.h
@@ -57,5 +57,9 @@ struct mlx5_ib_uapi_devx_async_cmd_hdr {
 	__u8		out_data[];
 };
 
+enum mlx5_ib_uapi_dm_type {
+	MLX5_IB_UAPI_DM_TYPE_MEMIC,
+};
+
 #endif
 
-- 
2.20.1

