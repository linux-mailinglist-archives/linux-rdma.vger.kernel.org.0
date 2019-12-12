Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9768F11CA1E
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 11:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfLLKCq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 05:02:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:52964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728349AbfLLKCp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 05:02:45 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C38662464B;
        Thu, 12 Dec 2019 10:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576144964;
        bh=kYMY7gGK1wN2xgLg75GQ3mswV8grlwda7MyIxpok1Xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P5XzLEclWE+jjpnOsXofE8kSfKCUh/3gkowHWxj1riTnfqmqi+8loM3sCqfhtRVSr
         IGq5n4bWpsNR2GLS35gLMeSZUX98A78s/FFr5jIRsASm6wZcnjQ+wdsMCk71Sq5+NH
         PfwughhIOokIn7hNmwf4l449tuBqecffS8NzmMj4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Ariel Levkovich <lariel@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-rc 2/2] IB/mlx5: Fix device memory flows
Date:   Thu, 12 Dec 2019 12:02:37 +0200
Message-Id: <20191212100237.330654-3-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212100237.330654-1-leon@kernel.org>
References: <20191212100237.330654-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

Fix device memory flows so that only once there will be no live mmaped
VA to a given allocation the matching object will be destroyed.

This prevents a potential scenario that existing VA that was mmaped by
one process might still be used post its deallocation despite that it's
owned now by other process.

The above is achieved by integrating with IB core APIs to manage
mmap/munmap. Only once the refcount will become 0 the DM object and its
underlay area will be freed.

Fixes: 3b113a1ec3d4 ("IB/mlx5: Support device memory type attribute")
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/cmd.c     |  16 ++--
 drivers/infiniband/hw/mlx5/cmd.h     |   2 +-
 drivers/infiniband/hw/mlx5/main.c    | 120 ++++++++++++++++++---------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  19 ++++-
 4 files changed, 105 insertions(+), 52 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cmd.c b/drivers/infiniband/hw/mlx5/cmd.c
index 4937947400cd..4c26492ab8a3 100644
--- a/drivers/infiniband/hw/mlx5/cmd.c
+++ b/drivers/infiniband/hw/mlx5/cmd.c
@@ -157,7 +157,7 @@ int mlx5_cmd_alloc_memic(struct mlx5_dm *dm, phys_addr_t *addr,
 	return -ENOMEM;
 }
 
-int mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, phys_addr_t addr, u64 length)
+void mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, phys_addr_t addr, u64 length)
 {
 	struct mlx5_core_dev *dev = dm->dev;
 	u64 hw_start_addr = MLX5_CAP64_DEV_MEM(dev, memic_bar_start_addr);
@@ -175,15 +175,13 @@ int mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, phys_addr_t addr, u64 length)
 	MLX5_SET(dealloc_memic_in, in, memic_size, length);
 
 	err =  mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+	if (err)
+		return;
 
-	if (!err) {
-		spin_lock(&dm->lock);
-		bitmap_clear(dm->memic_alloc_pages,
-			     start_page_idx, num_pages);
-		spin_unlock(&dm->lock);
-	}
-
-	return err;
+	spin_lock(&dm->lock);
+	bitmap_clear(dm->memic_alloc_pages,
+		     start_page_idx, num_pages);
+	spin_unlock(&dm->lock);
 }
 
 int mlx5_cmd_query_ext_ppcnt_counters(struct mlx5_core_dev *dev, void *out)
diff --git a/drivers/infiniband/hw/mlx5/cmd.h b/drivers/infiniband/hw/mlx5/cmd.h
index 169cab4915e3..945ebce73613 100644
--- a/drivers/infiniband/hw/mlx5/cmd.h
+++ b/drivers/infiniband/hw/mlx5/cmd.h
@@ -46,7 +46,7 @@ int mlx5_cmd_modify_cong_params(struct mlx5_core_dev *mdev,
 				void *in, int in_size);
 int mlx5_cmd_alloc_memic(struct mlx5_dm *dm, phys_addr_t *addr,
 			 u64 length, u32 alignment);
-int mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, phys_addr_t addr, u64 length);
+void mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, phys_addr_t addr, u64 length);
 void mlx5_cmd_dealloc_pd(struct mlx5_core_dev *dev, u32 pdn, u16 uid);
 void mlx5_cmd_destroy_tir(struct mlx5_core_dev *dev, u32 tirn, u16 uid);
 void mlx5_cmd_destroy_tis(struct mlx5_core_dev *dev, u32 tisn, u16 uid);
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 2f5a159cbe1c..4d89d85226c2 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2074,6 +2074,24 @@ static int mlx5_ib_mmap_clock_info_page(struct mlx5_ib_dev *dev,
 			      virt_to_page(dev->mdev->clock_info));
 }
 
+static void mlx5_ib_mmap_free(struct rdma_user_mmap_entry *entry)
+{
+	struct mlx5_user_mmap_entry *mentry = to_mmmap(entry);
+	struct mlx5_ib_dev *dev = to_mdev(entry->ucontext->device);
+	struct mlx5_ib_dm *mdm;
+
+	switch (mentry->mmap_flag) {
+	case MLX5_IB_MMAP_TYPE_MEMIC:
+		mdm = container_of(mentry, struct mlx5_ib_dm, mentry);
+		mlx5_cmd_dealloc_memic(&dev->dm, mdm->dev_addr,
+				       mdm->size);
+		kfree(mdm);
+		break;
+	default:
+		WARN_ON(true);
+	}
+}
+
 static int uar_mmap(struct mlx5_ib_dev *dev, enum mlx5_ib_mmap_cmd cmd,
 		    struct vm_area_struct *vma,
 		    struct mlx5_ib_ucontext *context)
@@ -2186,26 +2204,55 @@ static int uar_mmap(struct mlx5_ib_dev *dev, enum mlx5_ib_mmap_cmd cmd,
 	return err;
 }
 
-static int dm_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
+static int add_dm_mmap_entry(struct ib_ucontext *context,
+			     struct mlx5_ib_dm *mdm,
+			     u64 address)
+{
+	mdm->mentry.mmap_flag = MLX5_IB_MMAP_TYPE_MEMIC;
+	mdm->mentry.address = address;
+	return rdma_user_mmap_entry_insert_range(
+			context, &mdm->mentry.rdma_entry,
+			mdm->size,
+			MLX5_IB_MMAP_DEVICE_MEM << 16,
+			(MLX5_IB_MMAP_DEVICE_MEM << 16) + (1UL << 16) - 1);
+}
+
+static unsigned long mlx5_vma_to_pgoff(struct vm_area_struct *vma)
+{
+	unsigned long idx;
+	u8 command;
+
+	command = get_command(vma->vm_pgoff);
+	idx = get_extended_index(vma->vm_pgoff);
+
+	return (command << 16 | idx);
+}
+
+static int mlx5_ib_mmap_offset(struct mlx5_ib_dev *dev,
+			       struct vm_area_struct *vma,
+			       struct ib_ucontext *ucontext)
 {
-	struct mlx5_ib_ucontext *mctx = to_mucontext(context);
-	struct mlx5_ib_dev *dev = to_mdev(context->device);
-	u16 page_idx = get_extended_index(vma->vm_pgoff);
-	size_t map_size = vma->vm_end - vma->vm_start;
-	u32 npages = map_size >> PAGE_SHIFT;
+	struct mlx5_user_mmap_entry *mentry;
+	struct rdma_user_mmap_entry *entry;
+	unsigned long pgoff;
+	pgprot_t prot;
 	phys_addr_t pfn;
+	int ret;
 
-	if (find_next_zero_bit(mctx->dm_pages, page_idx + npages, page_idx) !=
-	    page_idx + npages)
+	pgoff = mlx5_vma_to_pgoff(vma);
+	entry = rdma_user_mmap_entry_get_pgoff(ucontext, pgoff);
+	if (!entry)
 		return -EINVAL;
 
-	pfn = ((dev->mdev->bar_addr +
-	      MLX5_CAP64_DEV_MEM(dev->mdev, memic_bar_start_addr)) >>
-	      PAGE_SHIFT) +
-	      page_idx;
-	return rdma_user_mmap_io(context, vma, pfn, map_size,
-				 pgprot_writecombine(vma->vm_page_prot),
-				 NULL);
+	mentry = to_mmmap(entry);
+	pfn = (mentry->address >> PAGE_SHIFT);
+	prot = pgprot_writecombine(vma->vm_page_prot);
+	ret = rdma_user_mmap_io(ucontext, vma, pfn,
+				entry->npages * PAGE_SIZE,
+				prot,
+				entry);
+	rdma_user_mmap_entry_put(&mentry->rdma_entry);
+	return ret;
 }
 
 static int mlx5_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_struct *vma)
@@ -2248,11 +2295,8 @@ static int mlx5_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_struct *vm
 	case MLX5_IB_MMAP_CLOCK_INFO:
 		return mlx5_ib_mmap_clock_info_page(dev, vma, context);
 
-	case MLX5_IB_MMAP_DEVICE_MEM:
-		return dm_mmap(ibcontext, vma);
-
 	default:
-		return -EINVAL;
+		return mlx5_ib_mmap_offset(dev, vma, ibcontext);
 	}
 
 	return 0;
@@ -2288,8 +2332,9 @@ static int handle_alloc_dm_memic(struct ib_ucontext *ctx,
 {
 	struct mlx5_dm *dm_db = &to_mdev(ctx->device)->dm;
 	u64 start_offset;
-	u32 page_idx;
+	u16 page_idx = 0;
 	int err;
+	u64 address;
 
 	dm->size = roundup(attr->length, MLX5_MEMIC_BASE_SIZE);
 
@@ -2298,28 +2343,30 @@ static int handle_alloc_dm_memic(struct ib_ucontext *ctx,
 	if (err)
 		return err;
 
-	page_idx = (dm->dev_addr - pci_resource_start(dm_db->dev->pdev, 0) -
-		    MLX5_CAP64_DEV_MEM(dm_db->dev, memic_bar_start_addr)) >>
-		    PAGE_SHIFT;
+	address = dm->dev_addr & PAGE_MASK;
+	err = add_dm_mmap_entry(ctx, dm, address);
+	if (err)
+		goto err_dealloc;
 
+	page_idx = dm->mentry.rdma_entry.start_pgoff & 0xFFFF;
 	err = uverbs_copy_to(attrs,
 			     MLX5_IB_ATTR_ALLOC_DM_RESP_PAGE_INDEX,
-			     &page_idx, sizeof(page_idx));
+			     &page_idx,
+			     sizeof(page_idx));
 	if (err)
-		goto err_dealloc;
+		goto err_copy;
 
 	start_offset = dm->dev_addr & ~PAGE_MASK;
 	err = uverbs_copy_to(attrs,
 			     MLX5_IB_ATTR_ALLOC_DM_RESP_START_OFFSET,
 			     &start_offset, sizeof(start_offset));
 	if (err)
-		goto err_dealloc;
-
-	bitmap_set(to_mucontext(ctx)->dm_pages, page_idx,
-		   DIV_ROUND_UP(dm->size, PAGE_SIZE));
+		goto err_copy;
 
 	return 0;
 
+err_copy:
+	rdma_user_mmap_entry_remove(&dm->mentry.rdma_entry);
 err_dealloc:
 	mlx5_cmd_dealloc_memic(dm_db, dm->dev_addr, dm->size);
 
@@ -2423,23 +2470,13 @@ int mlx5_ib_dealloc_dm(struct ib_dm *ibdm, struct uverbs_attr_bundle *attrs)
 	struct mlx5_ib_ucontext *ctx = rdma_udata_to_drv_context(
 		&attrs->driver_udata, struct mlx5_ib_ucontext, ibucontext);
 	struct mlx5_core_dev *dev = to_mdev(ibdm->device)->mdev;
-	struct mlx5_dm *dm_db = &to_mdev(ibdm->device)->dm;
 	struct mlx5_ib_dm *dm = to_mdm(ibdm);
-	u32 page_idx;
 	int ret;
 
 	switch (dm->type) {
 	case MLX5_IB_UAPI_DM_TYPE_MEMIC:
-		ret = mlx5_cmd_dealloc_memic(dm_db, dm->dev_addr, dm->size);
-		if (ret)
-			return ret;
-
-		page_idx = (dm->dev_addr - pci_resource_start(dev->pdev, 0) -
-			    MLX5_CAP64_DEV_MEM(dev, memic_bar_start_addr)) >>
-			    PAGE_SHIFT;
-		bitmap_clear(ctx->dm_pages, page_idx,
-			     DIV_ROUND_UP(dm->size, PAGE_SIZE));
-		break;
+		rdma_user_mmap_entry_remove(&dm->mentry.rdma_entry);
+		return 0;
 	case MLX5_IB_UAPI_DM_TYPE_STEERING_SW_ICM:
 		ret = mlx5_dm_sw_icm_dealloc(dev, MLX5_SW_ICM_TYPE_STEERING,
 					     dm->size, ctx->devx_uid, dm->dev_addr,
@@ -6235,6 +6272,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.map_mr_sg = mlx5_ib_map_mr_sg,
 	.map_mr_sg_pi = mlx5_ib_map_mr_sg_pi,
 	.mmap = mlx5_ib_mmap,
+	.mmap_free = mlx5_ib_mmap_free,
 	.modify_cq = mlx5_ib_modify_cq,
 	.modify_device = mlx5_ib_modify_device,
 	.modify_port = mlx5_ib_modify_port,
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 5986953ec2fa..b06f32ff5748 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -118,6 +118,10 @@ enum {
 	MLX5_MEMIC_BASE_SIZE	= 1 << MLX5_MEMIC_BASE_ALIGN,
 };
 
+enum mlx5_ib_mmap_type {
+	MLX5_IB_MMAP_TYPE_MEMIC = 1,
+};
+
 #define MLX5_LOG_SW_ICM_BLOCK_SIZE(dev)                                        \
 	(MLX5_CAP_DEV_MEM(dev, log_sw_icm_alloc_granularity))
 #define MLX5_SW_ICM_BLOCK_SIZE(dev) (1 << MLX5_LOG_SW_ICM_BLOCK_SIZE(dev))
@@ -135,7 +139,6 @@ struct mlx5_ib_ucontext {
 	u32			tdn;
 
 	u64			lib_caps;
-	DECLARE_BITMAP(dm_pages, MLX5_MAX_MEMIC_PAGES);
 	u16			devx_uid;
 	/* For RoCE LAG TX affinity */
 	atomic_t		tx_port_affinity;
@@ -556,6 +559,12 @@ enum mlx5_ib_mtt_access_flags {
 	MLX5_IB_MTT_WRITE = (1 << 1),
 };
 
+struct mlx5_user_mmap_entry {
+	struct rdma_user_mmap_entry rdma_entry;
+	u8 mmap_flag;
+	u64 address;
+};
+
 struct mlx5_ib_dm {
 	struct ib_dm		ibdm;
 	phys_addr_t		dev_addr;
@@ -567,6 +576,7 @@ struct mlx5_ib_dm {
 		} icm_dm;
 		/* other dm types specific params should be added here */
 	};
+	struct mlx5_user_mmap_entry mentry;
 };
 
 #define MLX5_IB_MTT_PRESENT (MLX5_IB_MTT_READ | MLX5_IB_MTT_WRITE)
@@ -1101,6 +1111,13 @@ to_mflow_act(struct ib_flow_action *ibact)
 	return container_of(ibact, struct mlx5_ib_flow_action, ib_action);
 }
 
+static inline struct mlx5_user_mmap_entry *
+to_mmmap(struct rdma_user_mmap_entry *rdma_entry)
+{
+	return container_of(rdma_entry,
+		struct mlx5_user_mmap_entry, rdma_entry);
+}
+
 int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context,
 			struct ib_udata *udata, unsigned long virt,
 			struct mlx5_db *db);
-- 
2.20.1

