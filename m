Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 432EC1400E
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2019 16:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfEEOHb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 May 2019 10:07:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfEEOHb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 5 May 2019 10:07:31 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73DF0204FD;
        Sun,  5 May 2019 14:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557065250;
        bh=BARksFkLpirZ6EhDEnjdrJxyuISDoWKw3yUwWjgrIak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VOHJ+zla5CsUYYQQF9+1OXn0fnJ/HFMHGUSYH7z9fi982R2m/G1RVgqPcJYao3T38
         jp+sXzDn2rqZigMLQ3iWsBqV7KEKEMITUR9ErJG0ucCByqNnuPg+dAFZgJM1XdjzPh
         5aHJGRpg0tKnTZ4UwktF1y7/9cH9Yu1UzB1G1ZFU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Ariel Levkovich <lariel@mellanox.com>,
        Eli Cohen <eli@mellanox.com>, Mark Bloch <markb@mellanox.com>
Subject: [PATCH rdma-next 3/4] IB/mlx5: Add steering SW ICM device memory type
Date:   Sun,  5 May 2019 17:07:13 +0300
Message-Id: <20190505140714.8741-4-leon@kernel.org>
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

This patch adds support for allocating, deallocating and registering
a new device memory type, STEERING_SW_ICM.
This memory can be allocated and used by a privileged user for direct
rule insertion and management of the device's steering tables.

The type is provided by the user via the dedicated attribute in
the alloc_dm ioctl command.

Signed-off-by: Ariel Levkovich <lariel@mellanox.com>
Reviewed-by: Eli Cohen <eli@mellanox.com>
Reviewed-by: Mark Bloch <markb@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/cmd.c          | 127 ++++++++++++++++++-
 drivers/infiniband/hw/mlx5/cmd.h          |   6 +-
 drivers/infiniband/hw/mlx5/main.c         | 142 ++++++++++++++++++++--
 drivers/infiniband/hw/mlx5/mlx5_ib.h      |  17 +++
 drivers/infiniband/hw/mlx5/mr.c           |   7 ++
 include/uapi/rdma/mlx5_user_ioctl_verbs.h |   2 +
 6 files changed, 292 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cmd.c b/drivers/infiniband/hw/mlx5/cmd.c
index f0e9c7609083..e3ec79b8f7f5 100644
--- a/drivers/infiniband/hw/mlx5/cmd.c
+++ b/drivers/infiniband/hw/mlx5/cmd.c
@@ -157,7 +157,7 @@ int mlx5_cmd_alloc_memic(struct mlx5_dm *dm, phys_addr_t *addr,
 	return -ENOMEM;
 }
 
-int mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, u64 addr, u64 length)
+int mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, phys_addr_t addr, u64 length)
 {
 	struct mlx5_core_dev *dev = dm->dev;
 	u64 hw_start_addr = MLX5_CAP64_DEV_MEM(dev, memic_bar_start_addr);
@@ -186,6 +186,131 @@ int mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, u64 addr, u64 length)
 	return err;
 }
 
+int mlx5_cmd_alloc_sw_icm(struct mlx5_dm *dm, int type, u64 length,
+			  u16 uid, phys_addr_t *addr, u32 *obj_id)
+{
+	struct mlx5_core_dev *dev = dm->dev;
+	u32 num_blocks = DIV_ROUND_UP(length, MLX5_SW_ICM_BLOCK_SIZE(dev));
+	u32 out[MLX5_ST_SZ_DW(general_obj_out_cmd_hdr)] = {};
+	u32 in[MLX5_ST_SZ_DW(create_sw_icm_in)] = {};
+	unsigned long *block_map;
+	u64 icm_start_addr;
+	u32 log_icm_size;
+	u32 max_blocks;
+	u64 block_idx;
+	void *sw_icm;
+	int ret;
+
+	MLX5_SET(general_obj_in_cmd_hdr, in, opcode,
+		 MLX5_CMD_OP_CREATE_GENERAL_OBJECT);
+	MLX5_SET(general_obj_in_cmd_hdr, in, obj_type, MLX5_OBJ_TYPE_SW_ICM);
+	MLX5_SET(general_obj_in_cmd_hdr, in, uid, uid);
+
+	switch (type) {
+	case MLX5_IB_UAPI_DM_TYPE_STEERING_SW_ICM:
+		icm_start_addr = MLX5_CAP64_DEV_MEM(dev,
+						steering_sw_icm_start_address);
+		log_icm_size = MLX5_CAP_DEV_MEM(dev, log_steering_sw_icm_size);
+		block_map = dm->steering_sw_icm_alloc_blocks;
+		break;
+	case MLX5_IB_UAPI_DM_TYPE_HEADER_MODIFY_SW_ICM:
+		icm_start_addr = MLX5_CAP64_DEV_MEM(dev,
+					header_modify_sw_icm_start_address);
+		log_icm_size = MLX5_CAP_DEV_MEM(dev,
+						log_header_modify_sw_icm_size);
+		block_map = dm->header_modify_sw_icm_alloc_blocks;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	max_blocks = BIT(log_icm_size - MLX5_LOG_SW_ICM_BLOCK_SIZE(dev));
+	spin_lock(&dm->lock);
+	block_idx = bitmap_find_next_zero_area(block_map,
+					       max_blocks,
+					       0,
+					       num_blocks, 0);
+
+	if (block_idx < max_blocks)
+		bitmap_set(block_map,
+			   block_idx, num_blocks);
+
+	spin_unlock(&dm->lock);
+
+	if (block_idx >= max_blocks)
+		return -ENOMEM;
+
+	sw_icm = MLX5_ADDR_OF(create_sw_icm_in, in, sw_icm);
+	icm_start_addr += block_idx << MLX5_LOG_SW_ICM_BLOCK_SIZE(dev);
+	MLX5_SET64(sw_icm, sw_icm, sw_icm_start_addr,
+		   icm_start_addr);
+	MLX5_SET(sw_icm, sw_icm, log_sw_icm_size, ilog2(length));
+
+	ret = mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+	if (ret) {
+		spin_lock(&dm->lock);
+		bitmap_clear(block_map,
+			     block_idx, num_blocks);
+		spin_unlock(&dm->lock);
+
+		return ret;
+	}
+
+	*addr = icm_start_addr;
+	*obj_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
+
+	return 0;
+}
+
+int mlx5_cmd_dealloc_sw_icm(struct mlx5_dm *dm, int type, u64 length,
+			    u16 uid, phys_addr_t addr, u32 obj_id)
+{
+	struct mlx5_core_dev *dev = dm->dev;
+	u32 num_blocks = DIV_ROUND_UP(length, MLX5_SW_ICM_BLOCK_SIZE(dev));
+	u32 out[MLX5_ST_SZ_DW(general_obj_out_cmd_hdr)] = {};
+	u32 in[MLX5_ST_SZ_DW(general_obj_in_cmd_hdr)] = {};
+	unsigned long *block_map;
+	u64 start_idx;
+	int err;
+
+	switch (type) {
+	case MLX5_IB_UAPI_DM_TYPE_STEERING_SW_ICM:
+		start_idx =
+			(addr - MLX5_CAP64_DEV_MEM(
+					dev, steering_sw_icm_start_address)) >>
+			MLX5_LOG_SW_ICM_BLOCK_SIZE(dev);
+		block_map = dm->steering_sw_icm_alloc_blocks;
+		break;
+	case MLX5_IB_UAPI_DM_TYPE_HEADER_MODIFY_SW_ICM:
+		start_idx =
+			(addr -
+			 MLX5_CAP64_DEV_MEM(
+				 dev, header_modify_sw_icm_start_address)) >>
+			MLX5_LOG_SW_ICM_BLOCK_SIZE(dev);
+		block_map = dm->header_modify_sw_icm_alloc_blocks;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	MLX5_SET(general_obj_in_cmd_hdr, in, opcode,
+		 MLX5_CMD_OP_DESTROY_GENERAL_OBJECT);
+	MLX5_SET(general_obj_in_cmd_hdr, in, obj_type, MLX5_OBJ_TYPE_SW_ICM);
+	MLX5_SET(general_obj_in_cmd_hdr, in, obj_id, obj_id);
+	MLX5_SET(general_obj_in_cmd_hdr, in, uid, uid);
+
+	err =  mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+	if (err)
+		return err;
+
+	spin_lock(&dm->lock);
+	bitmap_clear(block_map,
+		     start_idx, num_blocks);
+	spin_unlock(&dm->lock);
+
+	return 0;
+}
+
 int mlx5_cmd_query_ext_ppcnt_counters(struct mlx5_core_dev *dev, void *out)
 {
 	u32 in[MLX5_ST_SZ_DW(ppcnt_reg)] = {};
diff --git a/drivers/infiniband/hw/mlx5/cmd.h b/drivers/infiniband/hw/mlx5/cmd.h
index 80a644bea6c7..0572dcba6eae 100644
--- a/drivers/infiniband/hw/mlx5/cmd.h
+++ b/drivers/infiniband/hw/mlx5/cmd.h
@@ -46,7 +46,7 @@ int mlx5_cmd_modify_cong_params(struct mlx5_core_dev *mdev,
 				void *in, int in_size);
 int mlx5_cmd_alloc_memic(struct mlx5_dm *dm, phys_addr_t *addr,
 			 u64 length, u32 alignment);
-int mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, u64 addr, u64 length);
+int mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, phys_addr_t addr, u64 length);
 void mlx5_cmd_dealloc_pd(struct mlx5_core_dev *dev, u32 pdn, u16 uid);
 void mlx5_cmd_destroy_tir(struct mlx5_core_dev *dev, u32 tirn, u16 uid);
 void mlx5_cmd_destroy_tis(struct mlx5_core_dev *dev, u32 tisn, u16 uid);
@@ -65,4 +65,8 @@ int mlx5_cmd_alloc_q_counter(struct mlx5_core_dev *dev, u16 *counter_id,
 			     u16 uid);
 int mlx5_cmd_mad_ifc(struct mlx5_core_dev *dev, const void *inb, void *outb,
 		     u16 opmod, u8 port);
+int mlx5_cmd_alloc_sw_icm(struct mlx5_dm *dm, int type, u64 length,
+			  u16 uid, phys_addr_t *addr, u32 *obj_id);
+int mlx5_cmd_dealloc_sw_icm(struct mlx5_dm *dm, int type, u64 length,
+			    u16 uid, phys_addr_t addr, u32 obj_id);
 #endif /* MLX5_IB_CMD_H */
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 2c03ea1a9dc3..b49929682dc0 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2294,6 +2294,28 @@ static int mlx5_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_struct *vm
 	return 0;
 }
 
+static inline int check_dm_type_support(struct mlx5_ib_dev *dev,
+					u32 type)
+{
+	switch (type) {
+	case MLX5_IB_UAPI_DM_TYPE_MEMIC:
+		if (!MLX5_CAP_DEV_MEM(dev->mdev, memic))
+			return -EOPNOTSUPP;
+		break;
+	case MLX5_IB_UAPI_DM_TYPE_STEERING_SW_ICM:
+		if (!capable(CAP_SYS_RAWIO) ||
+		    !capable(CAP_NET_RAW))
+			return -EPERM;
+
+		if (!(MLX5_CAP_FLOWTABLE_NIC_RX(dev->mdev, sw_owner) ||
+		      MLX5_CAP_FLOWTABLE_NIC_TX(dev->mdev, sw_owner)))
+			return -EOPNOTSUPP;
+		break;
+	}
+
+	return 0;
+}
+
 static int handle_alloc_dm_memic(struct ib_ucontext *ctx,
 				 struct mlx5_ib_dm *dm,
 				 struct ib_dm_alloc_attr *attr,
@@ -2339,6 +2361,40 @@ static int handle_alloc_dm_memic(struct ib_ucontext *ctx,
 	return err;
 }
 
+static int handle_alloc_dm_sw_icm(struct ib_ucontext *ctx,
+				  struct mlx5_ib_dm *dm,
+				  struct ib_dm_alloc_attr *attr,
+				  struct uverbs_attr_bundle *attrs,
+				  int type)
+{
+	struct mlx5_dm *dm_db = &to_mdev(ctx->device)->dm;
+	u64 act_size;
+	int err;
+
+	/* Allocation size must a multiple of the basic block size
+	 * and a power of 2.
+	 */
+	act_size = roundup(attr->length, MLX5_SW_ICM_BLOCK_SIZE(dm_db->dev));
+	act_size = roundup_pow_of_two(act_size);
+
+	dm->size = act_size;
+	err = mlx5_cmd_alloc_sw_icm(dm_db, type, act_size,
+				    to_mucontext(ctx)->devx_uid, &dm->dev_addr,
+				    &dm->icm_dm.obj_id);
+	if (err)
+		return err;
+
+	err = uverbs_copy_to(attrs,
+			     MLX5_IB_ATTR_ALLOC_DM_RESP_START_OFFSET,
+			     &dm->dev_addr, sizeof(dm->dev_addr));
+	if (err)
+		mlx5_cmd_dealloc_sw_icm(dm_db, type, dm->size,
+					to_mucontext(ctx)->devx_uid,
+					dm->dev_addr, dm->icm_dm.obj_id);
+
+	return err;
+}
+
 struct ib_dm *mlx5_ib_alloc_dm(struct ib_device *ibdev,
 			       struct ib_ucontext *context,
 			       struct ib_dm_alloc_attr *attr,
@@ -2357,6 +2413,10 @@ struct ib_dm *mlx5_ib_alloc_dm(struct ib_device *ibdev,
 	mlx5_ib_dbg(to_mdev(ibdev), "alloc_dm req: dm_type=%d user_length=0x%llx log_alignment=%d\n",
 		    type, attr->length, attr->alignment);
 
+	err = check_dm_type_support(to_mdev(ibdev), type);
+	if (err)
+		return ERR_PTR(err);
+
 	dm = kzalloc(sizeof(*dm), GFP_KERNEL);
 	if (!dm)
 		return ERR_PTR(-ENOMEM);
@@ -2369,6 +2429,10 @@ struct ib_dm *mlx5_ib_alloc_dm(struct ib_device *ibdev,
 					    attr,
 					    attrs);
 		break;
+	case MLX5_IB_UAPI_DM_TYPE_STEERING_SW_ICM:
+	case MLX5_IB_UAPI_DM_TYPE_HEADER_MODIFY_SW_ICM:
+		err = handle_alloc_dm_sw_icm(context, dm, attr, attrs, type);
+		break;
 	default:
 		err = -EOPNOTSUPP;
 	}
@@ -2385,6 +2449,8 @@ struct ib_dm *mlx5_ib_alloc_dm(struct ib_device *ibdev,
 
 int mlx5_ib_dealloc_dm(struct ib_dm *ibdm, struct uverbs_attr_bundle *attrs)
 {
+	struct mlx5_ib_ucontext *ctx = rdma_udata_to_drv_context(
+		&attrs->driver_udata, struct mlx5_ib_ucontext, ibucontext);
 	struct mlx5_dm *dm_db = &to_mdev(ibdm->device)->dm;
 	struct mlx5_ib_dm *dm = to_mdm(ibdm);
 	u32 page_idx;
@@ -2401,11 +2467,16 @@ int mlx5_ib_dealloc_dm(struct ib_dm *ibdm, struct uverbs_attr_bundle *attrs)
 			    MLX5_CAP64_DEV_MEM(dm_db->dev,
 					       memic_bar_start_addr)) >>
 			   PAGE_SHIFT;
-		bitmap_clear(rdma_udata_to_drv_context(&attrs->driver_udata,
-						       struct mlx5_ib_ucontext,
-						       ibucontext)
-				     ->dm_pages,
-			     page_idx, DIV_ROUND_UP(dm->size, PAGE_SIZE));
+		bitmap_clear(ctx->dm_pages, page_idx,
+			     DIV_ROUND_UP(dm->size, PAGE_SIZE));
+		break;
+	case MLX5_IB_UAPI_DM_TYPE_STEERING_SW_ICM:
+	case MLX5_IB_UAPI_DM_TYPE_HEADER_MODIFY_SW_ICM:
+		ret = mlx5_cmd_dealloc_sw_icm(dm_db, dm->type, dm->size,
+					      ctx->devx_uid, dm->dev_addr,
+					      dm->icm_dm.obj_id);
+		if (ret)
+			return ret;
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -6006,6 +6077,8 @@ static struct ib_counters *mlx5_ib_create_counters(struct ib_device *device,
 
 static void mlx5_ib_stage_init_cleanup(struct mlx5_ib_dev *dev)
 {
+	struct mlx5_core_dev *mdev = dev->mdev;
+
 	mlx5_ib_cleanup_multiport_master(dev);
 	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING)) {
 		srcu_barrier(&dev->mr_srcu);
@@ -6013,11 +6086,29 @@ static void mlx5_ib_stage_init_cleanup(struct mlx5_ib_dev *dev)
 	}
 
 	WARN_ON(!bitmap_empty(dev->dm.memic_alloc_pages, MLX5_MAX_MEMIC_PAGES));
+
+	WARN_ON(dev->dm.steering_sw_icm_alloc_blocks &&
+		!bitmap_empty(
+			dev->dm.steering_sw_icm_alloc_blocks,
+			BIT(MLX5_CAP_DEV_MEM(mdev, log_steering_sw_icm_size) -
+			    MLX5_LOG_SW_ICM_BLOCK_SIZE(mdev))));
+
+	kfree(dev->dm.steering_sw_icm_alloc_blocks);
+
+	WARN_ON(dev->dm.header_modify_sw_icm_alloc_blocks &&
+		!bitmap_empty(dev->dm.header_modify_sw_icm_alloc_blocks,
+			      BIT(MLX5_CAP_DEV_MEM(
+					  mdev, log_header_modify_sw_icm_size) -
+				  MLX5_LOG_SW_ICM_BLOCK_SIZE(mdev))));
+
+	kfree(dev->dm.header_modify_sw_icm_alloc_blocks);
 }
 
 static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 {
 	struct mlx5_core_dev *mdev = dev->mdev;
+	u64 header_modify_icm_blocks = 0;
+	u64 steering_icm_blocks = 0;
 	int err;
 	int i;
 
@@ -6063,16 +6154,51 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 	INIT_LIST_HEAD(&dev->qp_list);
 	spin_lock_init(&dev->reset_flow_resource_lock);
 
+	if (MLX5_CAP_GEN_64(mdev, general_obj_types) &
+	    MLX5_GENERAL_OBJ_TYPES_CAP_SW_ICM) {
+		if (MLX5_CAP64_DEV_MEM(mdev, steering_sw_icm_start_address)) {
+			steering_icm_blocks =
+				BIT(MLX5_CAP_DEV_MEM(mdev,
+						     log_steering_sw_icm_size) -
+				    MLX5_LOG_SW_ICM_BLOCK_SIZE(mdev));
+
+			dev->dm.steering_sw_icm_alloc_blocks =
+				kcalloc(BITS_TO_LONGS(steering_icm_blocks),
+					sizeof(unsigned long), GFP_KERNEL);
+			if (!dev->dm.steering_sw_icm_alloc_blocks)
+				goto err_mp;
+		}
+
+		if (MLX5_CAP64_DEV_MEM(mdev,
+				       header_modify_sw_icm_start_address)) {
+			header_modify_icm_blocks = BIT(
+				MLX5_CAP_DEV_MEM(
+					mdev, log_header_modify_sw_icm_size) -
+				MLX5_LOG_SW_ICM_BLOCK_SIZE(mdev));
+
+			dev->dm.header_modify_sw_icm_alloc_blocks =
+				kcalloc(BITS_TO_LONGS(header_modify_icm_blocks),
+					sizeof(unsigned long), GFP_KERNEL);
+			if (!dev->dm.header_modify_sw_icm_alloc_blocks)
+				goto err_dm;
+		}
+	}
+
 	spin_lock_init(&dev->dm.lock);
 	dev->dm.dev = mdev;
 
 	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING)) {
 		err = init_srcu_struct(&dev->mr_srcu);
 		if (err)
-			goto err_mp;
+			goto err_dm;
 	}
 
 	return 0;
+
+err_dm:
+	kfree(dev->dm.steering_sw_icm_alloc_blocks);
+	kfree(dev->dm.header_modify_sw_icm_alloc_blocks);
+
 err_mp:
 	mlx5_ib_cleanup_multiport_master(dev);
 
@@ -6255,7 +6381,9 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
 		ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_xrc_ops);
 	}
 
-	if (MLX5_CAP_DEV_MEM(mdev, memic))
+	if (MLX5_CAP_DEV_MEM(mdev, memic) ||
+	    MLX5_CAP_GEN_64(dev->mdev, general_obj_types) &
+	    MLX5_GENERAL_OBJ_TYPES_CAP_SW_ICM)
 		ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_dm_ops);
 
 	if (mlx5_accel_ipsec_device_caps(dev->mdev) &
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 86f8110bf3ab..228ceac13d4d 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -118,6 +118,10 @@ enum {
 	MLX5_MEMIC_BASE_SIZE	= 1 << MLX5_MEMIC_BASE_ALIGN,
 };
 
+#define MLX5_LOG_SW_ICM_BLOCK_SIZE(dev)                                        \
+	(MLX5_CAP_DEV_MEM(dev, log_sw_icm_alloc_granularity))
+#define MLX5_SW_ICM_BLOCK_SIZE(dev) (1 << MLX5_LOG_SW_ICM_BLOCK_SIZE(dev))
+
 struct mlx5_ib_ucontext {
 	struct ib_ucontext	ibucontext;
 	struct list_head	db_page_list;
@@ -561,6 +565,12 @@ struct mlx5_ib_dm {
 	phys_addr_t		dev_addr;
 	u32			type;
 	size_t			size;
+	union {
+		struct {
+			u32	obj_id;
+		} icm_dm;
+		/* other dm types specific params should be added here */
+	};
 };
 
 #define MLX5_IB_MTT_PRESENT (MLX5_IB_MTT_READ | MLX5_IB_MTT_WRITE)
@@ -571,6 +581,11 @@ struct mlx5_ib_dm {
 					 IB_ACCESS_REMOTE_ATOMIC |\
 					 IB_ZERO_BASED)
 
+#define MLX5_IB_DM_SW_ICM_ALLOWED_ACCESS (IB_ACCESS_LOCAL_WRITE   |\
+					  IB_ACCESS_REMOTE_WRITE  |\
+					  IB_ACCESS_REMOTE_READ   |\
+					  IB_ZERO_BASED)
+
 struct mlx5_ib_mr {
 	struct ib_mr		ibmr;
 	void			*descs;
@@ -858,6 +873,8 @@ struct mlx5_dm {
 	 */
 	spinlock_t lock;
 	DECLARE_BITMAP(memic_alloc_pages, MLX5_MAX_MEMIC_PAGES);
+	unsigned long *steering_sw_icm_alloc_blocks;
+	unsigned long *header_modify_sw_icm_alloc_blocks;
 };
 
 struct mlx5_read_counters_attr {
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index ba35d68e7499..5f09699fab98 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1247,6 +1247,13 @@ struct ib_mr *mlx5_ib_reg_dm_mr(struct ib_pd *pd, struct ib_dm *dm,
 		mode = MLX5_MKC_ACCESS_MODE_MEMIC;
 		start_addr -= pci_resource_start(dev->pdev, 0);
 		break;
+	case MLX5_IB_UAPI_DM_TYPE_STEERING_SW_ICM:
+	case MLX5_IB_UAPI_DM_TYPE_HEADER_MODIFY_SW_ICM:
+		if (attr->access_flags & ~MLX5_IB_DM_SW_ICM_ALLOWED_ACCESS)
+			return ERR_PTR(-EINVAL);
+
+		mode = MLX5_MKC_ACCESS_MODE_SW_ICM;
+		break;
 	default:
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/include/uapi/rdma/mlx5_user_ioctl_verbs.h b/include/uapi/rdma/mlx5_user_ioctl_verbs.h
index c291fb2f8446..a8f34c237458 100644
--- a/include/uapi/rdma/mlx5_user_ioctl_verbs.h
+++ b/include/uapi/rdma/mlx5_user_ioctl_verbs.h
@@ -59,6 +59,8 @@ struct mlx5_ib_uapi_devx_async_cmd_hdr {
 
 enum mlx5_ib_uapi_dm_type {
 	MLX5_IB_UAPI_DM_TYPE_MEMIC,
+	MLX5_IB_UAPI_DM_TYPE_STEERING_SW_ICM,
+	MLX5_IB_UAPI_DM_TYPE_HEADER_MODIFY_SW_ICM,
 };
 
 #endif
-- 
2.20.1

