Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6519C4FD643
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 12:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352477AbiDLJ5z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 05:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359461AbiDLHnE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 03:43:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D551E09D
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 00:24:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE5F7614FA
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 07:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3499C385A1;
        Tue, 12 Apr 2022 07:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649748266;
        bh=8dDVNRIT2F58QasVrEUJCr1te9wkW9saMl1qrhe31iE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FBCp6rAW1bv0DDftLm8Y5bpNf8kpL+K/oslYw3xp0y5zEumekoxJN/iJhhJBl8quB
         7VE+St7uf+FHm+beTrn8hMqhPXnVs1yBoqyD6B8OhIipgo1hpVMs0sRh6oqH0thQ5n
         suk+dMEyJH+K3PYEhk9dQKXEnZ09gc6gB4BycJq81sY3FJbuhPSILtMu0bFwm3ELkw
         scH9fs7z3e8VeW3I6amf4Ke+ABFsaLJw+cIOhRDLpliV2DmQxLYGNlKNJapG8w3C4c
         fH+OT7VbnSqwCCdLHHsJgrU2ygq+RPE3J7s2t710EpKUKNZFrq+F/23bIfMm9UuC+S
         hHN0ebB1bnpFg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 03/12] RDMA/mlx5: Move mkey ctrl segment logic to umr.c
Date:   Tue, 12 Apr 2022 10:23:58 +0300
Message-Id: <5a7fac8ae8543521d19d174663245ae84b910310.1649747695.git.leonro@nvidia.com>
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

Move set_reg_umr_segment() and its helpers to umr.c.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   3 -
 drivers/infiniband/hw/mlx5/qp.c      |   1 +
 drivers/infiniband/hw/mlx5/umr.c     | 129 ++++++++++++++++++++++++
 drivers/infiniband/hw/mlx5/umr.h     |  13 +++
 drivers/infiniband/hw/mlx5/wr.c      | 142 +--------------------------
 5 files changed, 147 insertions(+), 141 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 18ba11e4e2e6..d77a27503488 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -311,9 +311,6 @@ struct mlx5_ib_flow_db {
 #define MLX5_IB_QPT_DCT		IB_QPT_RESERVED4
 #define MLX5_IB_WR_UMR		IB_WR_RESERVED1
 
-#define MLX5_IB_UMR_OCTOWORD	       16
-#define MLX5_IB_UMR_XLT_ALIGNMENT      64
-
 #define MLX5_IB_UPD_XLT_ZAP	      BIT(0)
 #define MLX5_IB_UPD_XLT_ENABLE	      BIT(1)
 #define MLX5_IB_UPD_XLT_ATOMIC	      BIT(2)
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 3f467557d34e..d2f243d3c4e2 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -40,6 +40,7 @@
 #include "ib_rep.h"
 #include "counters.h"
 #include "cmd.h"
+#include "umr.h"
 #include "qp.h"
 #include "wr.h"
 
diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index 46eaf919eb49..d3626a9dc8ab 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -4,6 +4,135 @@
 #include "mlx5_ib.h"
 #include "umr.h"
 
+static __be64 get_umr_enable_mr_mask(void)
+{
+	u64 result;
+
+	result = MLX5_MKEY_MASK_KEY |
+		 MLX5_MKEY_MASK_FREE;
+
+	return cpu_to_be64(result);
+}
+
+static __be64 get_umr_disable_mr_mask(void)
+{
+	u64 result;
+
+	result = MLX5_MKEY_MASK_FREE;
+
+	return cpu_to_be64(result);
+}
+
+static __be64 get_umr_update_translation_mask(void)
+{
+	u64 result;
+
+	result = MLX5_MKEY_MASK_LEN |
+		 MLX5_MKEY_MASK_PAGE_SIZE |
+		 MLX5_MKEY_MASK_START_ADDR;
+
+	return cpu_to_be64(result);
+}
+
+static __be64 get_umr_update_access_mask(int atomic,
+					 int relaxed_ordering_write,
+					 int relaxed_ordering_read)
+{
+	u64 result;
+
+	result = MLX5_MKEY_MASK_LR |
+		 MLX5_MKEY_MASK_LW |
+		 MLX5_MKEY_MASK_RR |
+		 MLX5_MKEY_MASK_RW;
+
+	if (atomic)
+		result |= MLX5_MKEY_MASK_A;
+
+	if (relaxed_ordering_write)
+		result |= MLX5_MKEY_MASK_RELAXED_ORDERING_WRITE;
+
+	if (relaxed_ordering_read)
+		result |= MLX5_MKEY_MASK_RELAXED_ORDERING_READ;
+
+	return cpu_to_be64(result);
+}
+
+static __be64 get_umr_update_pd_mask(void)
+{
+	u64 result;
+
+	result = MLX5_MKEY_MASK_PD;
+
+	return cpu_to_be64(result);
+}
+
+static int umr_check_mkey_mask(struct mlx5_ib_dev *dev, u64 mask)
+{
+	if (mask & MLX5_MKEY_MASK_PAGE_SIZE &&
+	    MLX5_CAP_GEN(dev->mdev, umr_modify_entity_size_disabled))
+		return -EPERM;
+
+	if (mask & MLX5_MKEY_MASK_A &&
+	    MLX5_CAP_GEN(dev->mdev, umr_modify_atomic_disabled))
+		return -EPERM;
+
+	if (mask & MLX5_MKEY_MASK_RELAXED_ORDERING_WRITE &&
+	    !MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write_umr))
+		return -EPERM;
+
+	if (mask & MLX5_MKEY_MASK_RELAXED_ORDERING_READ &&
+	    !MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read_umr))
+		return -EPERM;
+
+	return 0;
+}
+
+int mlx5r_umr_set_umr_ctrl_seg(struct mlx5_ib_dev *dev,
+			       struct mlx5_wqe_umr_ctrl_seg *umr,
+			       const struct ib_send_wr *wr)
+{
+	const struct mlx5_umr_wr *umrwr = umr_wr(wr);
+
+	memset(umr, 0, sizeof(*umr));
+
+	if (!umrwr->ignore_free_state) {
+		if (wr->send_flags & MLX5_IB_SEND_UMR_FAIL_IF_FREE)
+			 /* fail if free */
+			umr->flags = MLX5_UMR_CHECK_FREE;
+		else
+			/* fail if not free */
+			umr->flags = MLX5_UMR_CHECK_NOT_FREE;
+	}
+
+	umr->xlt_octowords =
+		cpu_to_be16(mlx5r_umr_get_xlt_octo(umrwr->xlt_size));
+	if (wr->send_flags & MLX5_IB_SEND_UMR_UPDATE_XLT) {
+		u64 offset = mlx5r_umr_get_xlt_octo(umrwr->offset);
+
+		umr->xlt_offset = cpu_to_be16(offset & 0xffff);
+		umr->xlt_offset_47_16 = cpu_to_be32(offset >> 16);
+		umr->flags |= MLX5_UMR_TRANSLATION_OFFSET_EN;
+	}
+	if (wr->send_flags & MLX5_IB_SEND_UMR_UPDATE_TRANSLATION)
+		umr->mkey_mask |= get_umr_update_translation_mask();
+	if (wr->send_flags & MLX5_IB_SEND_UMR_UPDATE_PD_ACCESS) {
+		umr->mkey_mask |= get_umr_update_access_mask(
+			!!MLX5_CAP_GEN(dev->mdev, atomic),
+			!!MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write_umr),
+			!!MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read_umr));
+		umr->mkey_mask |= get_umr_update_pd_mask();
+	}
+	if (wr->send_flags & MLX5_IB_SEND_UMR_ENABLE_MR)
+		umr->mkey_mask |= get_umr_enable_mr_mask();
+	if (wr->send_flags & MLX5_IB_SEND_UMR_DISABLE_MR)
+		umr->mkey_mask |= get_umr_disable_mr_mask();
+
+	if (!wr->num_sge)
+		umr->flags |= MLX5_UMR_INLINE;
+
+	return umr_check_mkey_mask(dev, be64_to_cpu(umr->mkey_mask));
+}
+
 enum {
 	MAX_UMR_WR = 128,
 };
diff --git a/drivers/infiniband/hw/mlx5/umr.h b/drivers/infiniband/hw/mlx5/umr.h
index eea9505575f6..0fe6cdd633d4 100644
--- a/drivers/infiniband/hw/mlx5/umr.h
+++ b/drivers/infiniband/hw/mlx5/umr.h
@@ -10,6 +10,9 @@
 #define MLX5_MAX_UMR_SHIFT 16
 #define MLX5_MAX_UMR_PAGES (1 << MLX5_MAX_UMR_SHIFT)
 
+#define MLX5_IB_UMR_OCTOWORD	       16
+#define MLX5_IB_UMR_XLT_ALIGNMENT      64
+
 int mlx5r_umr_resource_init(struct mlx5_ib_dev *dev);
 void mlx5r_umr_resource_cleanup(struct mlx5_ib_dev *dev);
 
@@ -66,4 +69,14 @@ static inline bool mlx5r_umr_can_reconfig(struct mlx5_ib_dev *dev,
 	return true;
 }
 
+static inline u64 mlx5r_umr_get_xlt_octo(u64 bytes)
+{
+	return ALIGN(bytes, MLX5_IB_UMR_XLT_ALIGNMENT) /
+	       MLX5_IB_UMR_OCTOWORD;
+}
+
+int mlx5r_umr_set_umr_ctrl_seg(struct mlx5_ib_dev *dev,
+			       struct mlx5_wqe_umr_ctrl_seg *umr,
+			       const struct ib_send_wr *wr);
+
 #endif /* _MLX5_IB_UMR_H */
diff --git a/drivers/infiniband/hw/mlx5/wr.c b/drivers/infiniband/hw/mlx5/wr.c
index 4a0fb10d9de9..24457eb5e4b7 100644
--- a/drivers/infiniband/hw/mlx5/wr.c
+++ b/drivers/infiniband/hw/mlx5/wr.c
@@ -166,12 +166,6 @@ static void set_data_ptr_seg(struct mlx5_wqe_data_seg *dseg, struct ib_sge *sg)
 	dseg->addr       = cpu_to_be64(sg->addr);
 }
 
-static u64 get_xlt_octo(u64 bytes)
-{
-	return ALIGN(bytes, MLX5_IB_UMR_XLT_ALIGNMENT) /
-	       MLX5_IB_UMR_OCTOWORD;
-}
-
 static __be64 frwr_mkey_mask(bool atomic)
 {
 	u64 result;
@@ -223,7 +217,7 @@ static void set_reg_umr_seg(struct mlx5_wqe_umr_ctrl_seg *umr,
 	memset(umr, 0, sizeof(*umr));
 
 	umr->flags = flags;
-	umr->xlt_octowords = cpu_to_be16(get_xlt_octo(size));
+	umr->xlt_octowords = cpu_to_be16(mlx5r_umr_get_xlt_octo(size));
 	umr->mkey_mask = frwr_mkey_mask(atomic);
 }
 
@@ -234,134 +228,6 @@ static void set_linv_umr_seg(struct mlx5_wqe_umr_ctrl_seg *umr)
 	umr->flags = MLX5_UMR_INLINE;
 }
 
-static __be64 get_umr_enable_mr_mask(void)
-{
-	u64 result;
-
-	result = MLX5_MKEY_MASK_KEY |
-		 MLX5_MKEY_MASK_FREE;
-
-	return cpu_to_be64(result);
-}
-
-static __be64 get_umr_disable_mr_mask(void)
-{
-	u64 result;
-
-	result = MLX5_MKEY_MASK_FREE;
-
-	return cpu_to_be64(result);
-}
-
-static __be64 get_umr_update_translation_mask(void)
-{
-	u64 result;
-
-	result = MLX5_MKEY_MASK_LEN |
-		 MLX5_MKEY_MASK_PAGE_SIZE |
-		 MLX5_MKEY_MASK_START_ADDR;
-
-	return cpu_to_be64(result);
-}
-
-static __be64 get_umr_update_access_mask(int atomic,
-					 int relaxed_ordering_write,
-					 int relaxed_ordering_read)
-{
-	u64 result;
-
-	result = MLX5_MKEY_MASK_LR |
-		 MLX5_MKEY_MASK_LW |
-		 MLX5_MKEY_MASK_RR |
-		 MLX5_MKEY_MASK_RW;
-
-	if (atomic)
-		result |= MLX5_MKEY_MASK_A;
-
-	if (relaxed_ordering_write)
-		result |= MLX5_MKEY_MASK_RELAXED_ORDERING_WRITE;
-
-	if (relaxed_ordering_read)
-		result |= MLX5_MKEY_MASK_RELAXED_ORDERING_READ;
-
-	return cpu_to_be64(result);
-}
-
-static __be64 get_umr_update_pd_mask(void)
-{
-	u64 result;
-
-	result = MLX5_MKEY_MASK_PD;
-
-	return cpu_to_be64(result);
-}
-
-static int umr_check_mkey_mask(struct mlx5_ib_dev *dev, u64 mask)
-{
-	if (mask & MLX5_MKEY_MASK_PAGE_SIZE &&
-	    MLX5_CAP_GEN(dev->mdev, umr_modify_entity_size_disabled))
-		return -EPERM;
-
-	if (mask & MLX5_MKEY_MASK_A &&
-	    MLX5_CAP_GEN(dev->mdev, umr_modify_atomic_disabled))
-		return -EPERM;
-
-	if (mask & MLX5_MKEY_MASK_RELAXED_ORDERING_WRITE &&
-	    !MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write_umr))
-		return -EPERM;
-
-	if (mask & MLX5_MKEY_MASK_RELAXED_ORDERING_READ &&
-	    !MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read_umr))
-		return -EPERM;
-
-	return 0;
-}
-
-static int set_reg_umr_segment(struct mlx5_ib_dev *dev,
-			       struct mlx5_wqe_umr_ctrl_seg *umr,
-			       const struct ib_send_wr *wr)
-{
-	const struct mlx5_umr_wr *umrwr = umr_wr(wr);
-
-	memset(umr, 0, sizeof(*umr));
-
-	if (!umrwr->ignore_free_state) {
-		if (wr->send_flags & MLX5_IB_SEND_UMR_FAIL_IF_FREE)
-			 /* fail if free */
-			umr->flags = MLX5_UMR_CHECK_FREE;
-		else
-			/* fail if not free */
-			umr->flags = MLX5_UMR_CHECK_NOT_FREE;
-	}
-
-	umr->xlt_octowords = cpu_to_be16(get_xlt_octo(umrwr->xlt_size));
-	if (wr->send_flags & MLX5_IB_SEND_UMR_UPDATE_XLT) {
-		u64 offset = get_xlt_octo(umrwr->offset);
-
-		umr->xlt_offset = cpu_to_be16(offset & 0xffff);
-		umr->xlt_offset_47_16 = cpu_to_be32(offset >> 16);
-		umr->flags |= MLX5_UMR_TRANSLATION_OFFSET_EN;
-	}
-	if (wr->send_flags & MLX5_IB_SEND_UMR_UPDATE_TRANSLATION)
-		umr->mkey_mask |= get_umr_update_translation_mask();
-	if (wr->send_flags & MLX5_IB_SEND_UMR_UPDATE_PD_ACCESS) {
-		umr->mkey_mask |= get_umr_update_access_mask(
-			!!(MLX5_CAP_GEN(dev->mdev, atomic)),
-			!!(MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write_umr)),
-			!!(MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read_umr)));
-		umr->mkey_mask |= get_umr_update_pd_mask();
-	}
-	if (wr->send_flags & MLX5_IB_SEND_UMR_ENABLE_MR)
-		umr->mkey_mask |= get_umr_enable_mr_mask();
-	if (wr->send_flags & MLX5_IB_SEND_UMR_DISABLE_MR)
-		umr->mkey_mask |= get_umr_disable_mr_mask();
-
-	if (!wr->num_sge)
-		umr->flags |= MLX5_UMR_INLINE;
-
-	return umr_check_mkey_mask(dev, be64_to_cpu(umr->mkey_mask));
-}
-
 static u8 get_umr_flags(int acc)
 {
 	return (acc & IB_ACCESS_REMOTE_ATOMIC ? MLX5_PERM_ATOMIC       : 0) |
@@ -761,7 +627,7 @@ static void set_sig_mkey_segment(struct mlx5_mkey_seg *seg,
 	seg->flags_pd = cpu_to_be32(MLX5_MKEY_REMOTE_INVAL | sigerr << 26 |
 				    MLX5_MKEY_BSF_EN | pdn);
 	seg->len = cpu_to_be64(length);
-	seg->xlt_oct_size = cpu_to_be32(get_xlt_octo(size));
+	seg->xlt_oct_size = cpu_to_be32(mlx5r_umr_get_xlt_octo(size));
 	seg->bsfs_octo_size = cpu_to_be32(MLX5_MKEY_BSF_OCTO_SIZE);
 }
 
@@ -771,7 +637,7 @@ static void set_sig_umr_segment(struct mlx5_wqe_umr_ctrl_seg *umr,
 	memset(umr, 0, sizeof(*umr));
 
 	umr->flags = MLX5_FLAGS_INLINE | MLX5_FLAGS_CHECK_FREE;
-	umr->xlt_octowords = cpu_to_be16(get_xlt_octo(size));
+	umr->xlt_octowords = cpu_to_be16(mlx5r_umr_get_xlt_octo(size));
 	umr->bsf_octowords = cpu_to_be16(MLX5_MKEY_BSF_OCTO_SIZE);
 	umr->mkey_mask = sig_mkey_mask();
 }
@@ -1262,7 +1128,7 @@ static int handle_qpt_reg_umr(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 
 	qp->sq.wr_data[idx] = MLX5_IB_WR_UMR;
 	(*ctrl)->imm = cpu_to_be32(umr_wr(wr)->mkey);
-	err = set_reg_umr_segment(dev, *seg, wr);
+	err = mlx5r_umr_set_umr_ctrl_seg(dev, *seg, wr);
 	if (unlikely(err))
 		goto out;
 	*seg += sizeof(struct mlx5_wqe_umr_ctrl_seg);
-- 
2.35.1

