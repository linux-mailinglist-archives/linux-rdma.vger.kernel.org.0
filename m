Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E004FD3EC
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 12:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351847AbiDLJ5g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 05:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359452AbiDLHnE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 03:43:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1231DFD2
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 00:24:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68356B81B33
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 07:24:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD77C385A6;
        Tue, 12 Apr 2022 07:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649748262;
        bh=MsZzeVzld+7HZfGrhAHLQRBjzVJlwaqQoLovhMTdhnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I6tBsdgQrQqZpstHzDD/7HLKeiQrO1xhFrDRAc5Qgzo2I4rAe374jdbYcyF4KUpyl
         eDYdM44wmTeSOJM4YzDPOQbagF6/iPX+5nVTVLmOi6MtClv7RKRAwppqK/K2IwcB7O
         NB72+bxCEIAJAVkbxye/Pb5tCdAGQD4EYJzvP6Gtce/OF+PLRAUeaJq9CIeHcNBYB9
         OG+BexVl5nElhWuwnrrA9tRZIwPxi6sz9UIfJ6KI73EHhN0Gsntir/nzDBT+jpv8j1
         3DsGlFPgbbNSndmjcHv8nTVjt6zf9tSmz4oauj2cso9BdQ8Nr/zI3TMd6HhFKeA0tN
         7TP4unZ0vFzPQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 02/12] RDMA/mlx5: Move umr checks to umr.h
Date:   Tue, 12 Apr 2022 10:23:57 +0300
Message-Id: <1b799b0142534a63dfd5bacc5f8ad2256d7777ad.1649747695.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649747695.git.leonro@nvidia.com>
References: <cover.1649747695.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

Move mlx5_ib_can_load_pas_with_umr() and
mlx5_ib_can_reconfig_with_umr() to umr.h and rename them accordingly.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 56 ---------------------------
 drivers/infiniband/hw/mlx5/mr.c      | 19 +++++-----
 drivers/infiniband/hw/mlx5/odp.c     |  7 ++--
 drivers/infiniband/hw/mlx5/umr.h     | 57 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/mlx5/wr.c      |  3 +-
 5 files changed, 72 insertions(+), 70 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 4f04bb55c4c6..18ba11e4e2e6 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1471,9 +1471,6 @@ static inline int is_qp1(enum ib_qp_type qp_type)
 	return qp_type == MLX5_IB_QPT_HW_GSI || qp_type == IB_QPT_GSI;
 }
 
-#define MLX5_MAX_UMR_SHIFT 16
-#define MLX5_MAX_UMR_PAGES (1 << MLX5_MAX_UMR_SHIFT)
-
 static inline u32 check_cq_create_flags(u32 flags)
 {
 	/*
@@ -1545,59 +1542,6 @@ int bfregn_to_uar_index(struct mlx5_ib_dev *dev,
 			struct mlx5_bfreg_info *bfregi, u32 bfregn,
 			bool dyn_bfreg);
 
-static inline bool mlx5_ib_can_load_pas_with_umr(struct mlx5_ib_dev *dev,
-						 size_t length)
-{
-	/*
-	 * umr_check_mkey_mask() rejects MLX5_MKEY_MASK_PAGE_SIZE which is
-	 * always set if MLX5_IB_SEND_UMR_UPDATE_TRANSLATION (aka
-	 * MLX5_IB_UPD_XLT_ADDR and MLX5_IB_UPD_XLT_ENABLE) is set. Thus, a mkey
-	 * can never be enabled without this capability. Simplify this weird
-	 * quirky hardware by just saying it can't use PAS lists with UMR at
-	 * all.
-	 */
-	if (MLX5_CAP_GEN(dev->mdev, umr_modify_entity_size_disabled))
-		return false;
-
-	/*
-	 * length is the size of the MR in bytes when mlx5_ib_update_xlt() is
-	 * used.
-	 */
-	if (!MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset) &&
-	    length >= MLX5_MAX_UMR_PAGES * PAGE_SIZE)
-		return false;
-	return true;
-}
-
-/*
- * true if an existing MR can be reconfigured to new access_flags using UMR.
- * Older HW cannot use UMR to update certain elements of the MKC. See
- * umr_check_mkey_mask(), get_umr_update_access_mask() and umr_check_mkey_mask()
- */
-static inline bool mlx5_ib_can_reconfig_with_umr(struct mlx5_ib_dev *dev,
-						 unsigned int current_access_flags,
-						 unsigned int target_access_flags)
-{
-	unsigned int diffs = current_access_flags ^ target_access_flags;
-
-	if ((diffs & IB_ACCESS_REMOTE_ATOMIC) &&
-	    MLX5_CAP_GEN(dev->mdev, atomic) &&
-	    MLX5_CAP_GEN(dev->mdev, umr_modify_atomic_disabled))
-		return false;
-
-	if ((diffs & IB_ACCESS_RELAXED_ORDERING) &&
-	    MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write) &&
-	    !MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write_umr))
-		return false;
-
-	if ((diffs & IB_ACCESS_RELAXED_ORDERING) &&
-	    MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read) &&
-	    !MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read_umr))
-		return false;
-
-	return true;
-}
-
 static inline int mlx5r_store_odp_mkey(struct mlx5_ib_dev *dev,
 				       struct mlx5_ib_mkey *mmkey)
 {
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 956f8e875daa..6d87a93e03db 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -44,6 +44,7 @@
 #include <rdma/ib_verbs.h>
 #include "dm.h"
 #include "mlx5_ib.h"
+#include "umr.h"
 
 /*
  * We can't use an array for xlt_emergency_page because dma_map_single doesn't
@@ -598,7 +599,7 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 	struct mlx5_ib_mr *mr;
 
 	/* Matches access in alloc_cache_mr() */
-	if (!mlx5_ib_can_reconfig_with_umr(dev, 0, access_flags))
+	if (!mlx5r_umr_can_reconfig(dev, 0, access_flags))
 		return ERR_PTR(-EOPNOTSUPP);
 
 	spin_lock_irq(&ent->lock);
@@ -738,7 +739,7 @@ int mlx5_mr_cache_init(struct mlx5_ib_dev *dev)
 		ent->access_mode = MLX5_MKC_ACCESS_MODE_MTT;
 		if ((dev->mdev->profile.mask & MLX5_PROF_MASK_MR_CACHE) &&
 		    !dev->is_rep && mlx5_core_is_pf(dev->mdev) &&
-		    mlx5_ib_can_load_pas_with_umr(dev, 0))
+		    mlx5r_umr_can_load_pas(dev, 0))
 			ent->limit = dev->mdev->profile.mr_cache[i].limit;
 		else
 			ent->limit = 0;
@@ -946,7 +947,7 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 	 * cache then synchronously create an uncached one.
 	 */
 	if (!ent || ent->limit == 0 ||
-	    !mlx5_ib_can_reconfig_with_umr(dev, 0, access_flags)) {
+	    !mlx5r_umr_can_reconfig(dev, 0, access_flags)) {
 		mutex_lock(&dev->slow_path_mutex);
 		mr = reg_create(pd, umem, iova, access_flags, page_size, false);
 		mutex_unlock(&dev->slow_path_mutex);
@@ -1438,7 +1439,7 @@ static struct ib_mr *create_real_mr(struct ib_pd *pd, struct ib_umem *umem,
 	bool xlt_with_umr;
 	int err;
 
-	xlt_with_umr = mlx5_ib_can_load_pas_with_umr(dev, umem->length);
+	xlt_with_umr = mlx5r_umr_can_load_pas(dev, umem->length);
 	if (xlt_with_umr) {
 		mr = alloc_cacheable_mr(pd, umem, iova, access_flags);
 	} else {
@@ -1501,7 +1502,7 @@ static struct ib_mr *create_user_odp_mr(struct ib_pd *pd, u64 start, u64 length,
 	}
 
 	/* ODP requires xlt update via umr to work. */
-	if (!mlx5_ib_can_load_pas_with_umr(dev, length))
+	if (!mlx5r_umr_can_load_pas(dev, length))
 		return ERR_PTR(-EINVAL);
 
 	odp = ib_umem_odp_get(&dev->ib_dev, start, length, access_flags,
@@ -1591,7 +1592,7 @@ struct ib_mr *mlx5_ib_reg_user_mr_dmabuf(struct ib_pd *pd, u64 offset,
 		    offset, virt_addr, length, fd, access_flags);
 
 	/* dmabuf requires xlt update via umr to work. */
-	if (!mlx5_ib_can_load_pas_with_umr(dev, length))
+	if (!mlx5r_umr_can_load_pas(dev, length))
 		return ERR_PTR(-EINVAL);
 
 	umem_dmabuf = ib_umem_dmabuf_get(&dev->ib_dev, offset, length, fd,
@@ -1666,8 +1667,8 @@ static bool can_use_umr_rereg_access(struct mlx5_ib_dev *dev,
 	if (diffs & ~(IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_WRITE |
 		      IB_ACCESS_REMOTE_READ | IB_ACCESS_RELAXED_ORDERING))
 		return false;
-	return mlx5_ib_can_reconfig_with_umr(dev, current_access_flags,
-					     target_access_flags);
+	return mlx5r_umr_can_reconfig(dev, current_access_flags,
+				      target_access_flags);
 }
 
 static int umr_rereg_pd_access(struct mlx5_ib_mr *mr, struct ib_pd *pd,
@@ -1704,7 +1705,7 @@ static bool can_use_umr_rereg_pas(struct mlx5_ib_mr *mr,
 	/* We only track the allocated sizes of MRs from the cache */
 	if (!mr->cache_ent)
 		return false;
-	if (!mlx5_ib_can_load_pas_with_umr(dev, new_umem->length))
+	if (!mlx5r_umr_can_load_pas(dev, new_umem->length))
 		return false;
 
 	*page_size =
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 41c964a45f89..99dc06f589d4 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -38,6 +38,7 @@
 
 #include "mlx5_ib.h"
 #include "cmd.h"
+#include "umr.h"
 #include "qp.h"
 
 #include <linux/mlx5/eq.h>
@@ -323,8 +324,7 @@ static void internal_fill_odp_caps(struct mlx5_ib_dev *dev)
 
 	memset(caps, 0, sizeof(*caps));
 
-	if (!MLX5_CAP_GEN(dev->mdev, pg) ||
-	    !mlx5_ib_can_load_pas_with_umr(dev, 0))
+	if (!MLX5_CAP_GEN(dev->mdev, pg) || !mlx5r_umr_can_load_pas(dev, 0))
 		return;
 
 	caps->general_caps = IB_ODP_SUPPORT;
@@ -487,8 +487,7 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 	struct mlx5_ib_mr *imr;
 	int err;
 
-	if (!mlx5_ib_can_load_pas_with_umr(dev,
-					   MLX5_IMR_MTT_ENTRIES * PAGE_SIZE))
+	if (!mlx5r_umr_can_load_pas(dev, MLX5_IMR_MTT_ENTRIES * PAGE_SIZE))
 		return ERR_PTR(-EOPNOTSUPP);
 
 	umem_odp = ib_umem_odp_alloc_implicit(&dev->ib_dev, access_flags);
diff --git a/drivers/infiniband/hw/mlx5/umr.h b/drivers/infiniband/hw/mlx5/umr.h
index cb1a2c95aac2..eea9505575f6 100644
--- a/drivers/infiniband/hw/mlx5/umr.h
+++ b/drivers/infiniband/hw/mlx5/umr.h
@@ -6,7 +6,64 @@
 
 #include "mlx5_ib.h"
 
+
+#define MLX5_MAX_UMR_SHIFT 16
+#define MLX5_MAX_UMR_PAGES (1 << MLX5_MAX_UMR_SHIFT)
+
 int mlx5r_umr_resource_init(struct mlx5_ib_dev *dev);
 void mlx5r_umr_resource_cleanup(struct mlx5_ib_dev *dev);
 
+static inline bool mlx5r_umr_can_load_pas(struct mlx5_ib_dev *dev,
+					  size_t length)
+{
+	/*
+	 * umr_check_mkey_mask() rejects MLX5_MKEY_MASK_PAGE_SIZE which is
+	 * always set if MLX5_IB_SEND_UMR_UPDATE_TRANSLATION (aka
+	 * MLX5_IB_UPD_XLT_ADDR and MLX5_IB_UPD_XLT_ENABLE) is set. Thus, a mkey
+	 * can never be enabled without this capability. Simplify this weird
+	 * quirky hardware by just saying it can't use PAS lists with UMR at
+	 * all.
+	 */
+	if (MLX5_CAP_GEN(dev->mdev, umr_modify_entity_size_disabled))
+		return false;
+
+	/*
+	 * length is the size of the MR in bytes when mlx5_ib_update_xlt() is
+	 * used.
+	 */
+	if (!MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset) &&
+	    length >= MLX5_MAX_UMR_PAGES * PAGE_SIZE)
+		return false;
+	return true;
+}
+
+/*
+ * true if an existing MR can be reconfigured to new access_flags using UMR.
+ * Older HW cannot use UMR to update certain elements of the MKC. See
+ * get_umr_update_access_mask() and umr_check_mkey_mask()
+ */
+static inline bool mlx5r_umr_can_reconfig(struct mlx5_ib_dev *dev,
+					  unsigned int current_access_flags,
+					  unsigned int target_access_flags)
+{
+	unsigned int diffs = current_access_flags ^ target_access_flags;
+
+	if ((diffs & IB_ACCESS_REMOTE_ATOMIC) &&
+	    MLX5_CAP_GEN(dev->mdev, atomic) &&
+	    MLX5_CAP_GEN(dev->mdev, umr_modify_atomic_disabled))
+		return false;
+
+	if ((diffs & IB_ACCESS_RELAXED_ORDERING) &&
+	    MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write) &&
+	    !MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write_umr))
+		return false;
+
+	if ((diffs & IB_ACCESS_RELAXED_ORDERING) &&
+	    MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read) &&
+	    !MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read_umr))
+		return false;
+
+	return true;
+}
+
 #endif /* _MLX5_IB_UMR_H */
diff --git a/drivers/infiniband/hw/mlx5/wr.c b/drivers/infiniband/hw/mlx5/wr.c
index 51e48ca9016e..4a0fb10d9de9 100644
--- a/drivers/infiniband/hw/mlx5/wr.c
+++ b/drivers/infiniband/hw/mlx5/wr.c
@@ -7,6 +7,7 @@
 #include <linux/mlx5/qp.h>
 #include <linux/mlx5/driver.h>
 #include "wr.h"
+#include "umr.h"
 
 static const u32 mlx5_ib_opcode[] = {
 	[IB_WR_SEND]				= MLX5_OPCODE_SEND,
@@ -870,7 +871,7 @@ static int set_reg_wr(struct mlx5_ib_qp *qp,
 	 * Relaxed Ordering is set implicitly in mlx5_set_umr_free_mkey() and
 	 * kernel ULPs are not aware of it, so we don't set it here.
 	 */
-	if (!mlx5_ib_can_reconfig_with_umr(dev, 0, wr->access)) {
+	if (!mlx5r_umr_can_reconfig(dev, 0, wr->access)) {
 		mlx5_ib_warn(
 			to_mdev(qp->ibqp.device),
 			"Fast update for MR access flags is not possible\n");
-- 
2.35.1

