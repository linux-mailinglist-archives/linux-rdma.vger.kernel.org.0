Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003C138ABBB
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 13:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240796AbhETL10 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 May 2021 07:27:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241725AbhETLZY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 May 2021 07:25:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4A49613EC;
        Thu, 20 May 2021 10:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621505629;
        bh=E5k3Mki0GSXpiDjh5/+/DJ1j/6hvo9UDAi2ErTUj3Is=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rF4K77ca7OoDtq24MYPUD+tfkhqvmxlBnIgSYFb9Ma/Z7vm170QdgIGOGGUFTazn7
         x430+00MwLtiQLcjrd3qrAM43P+GO+bJnyQzlkVXJ0d6tkprY5XLz8M014cytfZzA+
         H0Oz2hPbYirSTxchDApDPNVEfazyKe1zBBh+1OuFrm9uf5Cn6LiU8/DkBeOmPBB0XV
         n4haZcYHuGOxRN4y2tCYiXlBB1V4JIPFAyMVfIPYqYBDjcqCGV1csYAfKfu7R6tL6e
         VM2hDiA+GOA+SE9e1OA5nvkLkiuTPWJ8kgZpl58S4nShmH38jPUthuPKJMhUJGZHwU
         lZIIQXB52jg5Q==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Avihai Horon <avihaih@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 2/2] RDMA/mlx5: Allow modifying Relaxed Ordering via fast registration
Date:   Thu, 20 May 2021 13:13:36 +0300
Message-Id: <9442b0de75f4ee029e7c306fce34b1f6f94a9e34.1621505111.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621505111.git.leonro@nvidia.com>
References: <cover.1621505111.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Avihai Horon <avihaih@nvidia.com>

Relaxed Ordering is enabled by default for kernel ULPs, and is set
during MKey creation, yet it cannot be modified by them afterwards.

Allow modifying Relaxed Ordering via fast registration work request.
This is done by setting the relevant flags in the MKey context mask and
the Relaxed Ordering flags in the MKey context itself.

Only ConnectX-7 supports modifying Relaxed Ordering via fast
registration, and HCA capabilities indicate it. These capabilities are
checked, and if a fast registration work request tries to modify Relaxed
Ordering and the capabilities are not present, the work request will fail.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/wr.c | 66 +++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/wr.c b/drivers/infiniband/hw/mlx5/wr.c
index 54caa6a54451..34d8d59bbff1 100644
--- a/drivers/infiniband/hw/mlx5/wr.c
+++ b/drivers/infiniband/hw/mlx5/wr.c
@@ -171,7 +171,8 @@ static u64 get_xlt_octo(u64 bytes)
 	       MLX5_IB_UMR_OCTOWORD;
 }
 
-static __be64 frwr_mkey_mask(bool atomic)
+static __be64 frwr_mkey_mask(bool atomic, bool relaxed_ordering_write,
+			     bool relaxed_ordering_read)
 {
 	u64 result;
 
@@ -190,10 +191,17 @@ static __be64 frwr_mkey_mask(bool atomic)
 	if (atomic)
 		result |= MLX5_MKEY_MASK_A;
 
+	if (relaxed_ordering_write)
+		result |= MLX5_MKEY_MASK_RELAXED_ORDERING_WRITE;
+
+	if (relaxed_ordering_read)
+		result |= MLX5_MKEY_MASK_RELAXED_ORDERING_READ;
+
 	return cpu_to_be64(result);
 }
 
-static __be64 sig_mkey_mask(void)
+static __be64 sig_mkey_mask(bool relaxed_ordering_write,
+			    bool relaxed_ordering_read)
 {
 	u64 result;
 
@@ -211,10 +219,17 @@ static __be64 sig_mkey_mask(void)
 		MLX5_MKEY_MASK_FREE		|
 		MLX5_MKEY_MASK_BSF_EN;
 
+	if (relaxed_ordering_write)
+		result |= MLX5_MKEY_MASK_RELAXED_ORDERING_WRITE;
+
+	if (relaxed_ordering_read)
+		result |= MLX5_MKEY_MASK_RELAXED_ORDERING_READ;
+
 	return cpu_to_be64(result);
 }
 
-static void set_reg_umr_seg(struct mlx5_wqe_umr_ctrl_seg *umr,
+static void set_reg_umr_seg(struct mlx5_ib_dev *dev,
+			    struct mlx5_wqe_umr_ctrl_seg *umr,
 			    struct mlx5_ib_mr *mr, u8 flags, bool atomic)
 {
 	int size = (mr->ndescs + mr->meta_ndescs) * mr->desc_size;
@@ -223,7 +238,9 @@ static void set_reg_umr_seg(struct mlx5_wqe_umr_ctrl_seg *umr,
 
 	umr->flags = flags;
 	umr->xlt_octowords = cpu_to_be16(get_xlt_octo(size));
-	umr->mkey_mask = frwr_mkey_mask(atomic);
+	umr->mkey_mask = frwr_mkey_mask(
+		atomic, MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write_umr),
+		MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read_umr));
 }
 
 static void set_linv_umr_seg(struct mlx5_wqe_umr_ctrl_seg *umr)
@@ -370,9 +387,8 @@ static u8 get_umr_flags(int acc)
 		MLX5_PERM_LOCAL_READ | MLX5_PERM_UMR_EN;
 }
 
-static void set_reg_mkey_seg(struct mlx5_mkey_seg *seg,
-			     struct mlx5_ib_mr *mr,
-			     u32 key, int access)
+static void set_reg_mkey_seg(struct mlx5_ib_dev *dev, struct mlx5_mkey_seg *seg,
+			     struct mlx5_ib_mr *mr, u32 key, int access)
 {
 	int ndescs = ALIGN(mr->ndescs + mr->meta_ndescs, 8) >> 1;
 
@@ -390,6 +406,13 @@ static void set_reg_mkey_seg(struct mlx5_mkey_seg *seg,
 	seg->start_addr = cpu_to_be64(mr->ibmr.iova);
 	seg->len = cpu_to_be64(mr->ibmr.length);
 	seg->xlt_oct_size = cpu_to_be32(ndescs);
+
+	if (!(access & IB_ACCESS_DISABLE_RELAXED_ORDERING)) {
+		MLX5_SET(mkc, seg, relaxed_ordering_write,
+			 MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write_umr));
+		MLX5_SET(mkc, seg, relaxed_ordering_read,
+			 MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read_umr));
+	}
 }
 
 static void set_linv_mkey_seg(struct mlx5_mkey_seg *seg)
@@ -746,7 +769,8 @@ static int set_sig_data_segment(const struct ib_send_wr *send_wr,
 	return 0;
 }
 
-static void set_sig_mkey_segment(struct mlx5_mkey_seg *seg,
+static void set_sig_mkey_segment(struct mlx5_ib_dev *dev,
+				 struct mlx5_mkey_seg *seg,
 				 struct ib_mr *sig_mr, int access_flags,
 				 u32 size, u32 length, u32 pdn)
 {
@@ -762,23 +786,33 @@ static void set_sig_mkey_segment(struct mlx5_mkey_seg *seg,
 	seg->len = cpu_to_be64(length);
 	seg->xlt_oct_size = cpu_to_be32(get_xlt_octo(size));
 	seg->bsfs_octo_size = cpu_to_be32(MLX5_MKEY_BSF_OCTO_SIZE);
+
+	if (!(access_flags & IB_ACCESS_DISABLE_RELAXED_ORDERING)) {
+		MLX5_SET(mkc, seg, relaxed_ordering_write,
+			 MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write_umr));
+		MLX5_SET(mkc, seg, relaxed_ordering_read,
+			 MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read_umr));
+	}
 }
 
-static void set_sig_umr_segment(struct mlx5_wqe_umr_ctrl_seg *umr,
-				u32 size)
+static void set_sig_umr_segment(struct mlx5_ib_dev *dev,
+				struct mlx5_wqe_umr_ctrl_seg *umr, u32 size)
 {
 	memset(umr, 0, sizeof(*umr));
 
 	umr->flags = MLX5_FLAGS_INLINE | MLX5_FLAGS_CHECK_FREE;
 	umr->xlt_octowords = cpu_to_be16(get_xlt_octo(size));
 	umr->bsf_octowords = cpu_to_be16(MLX5_MKEY_BSF_OCTO_SIZE);
-	umr->mkey_mask = sig_mkey_mask();
+	umr->mkey_mask = sig_mkey_mask(
+		MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write_umr),
+		MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read_umr));
 }
 
 static int set_pi_umr_wr(const struct ib_send_wr *send_wr,
 			 struct mlx5_ib_qp *qp, void **seg, int *size,
 			 void **cur_edge)
 {
+	struct mlx5_ib_dev *dev = to_mdev(qp->ibqp.device);
 	const struct ib_reg_wr *wr = reg_wr(send_wr);
 	struct mlx5_ib_mr *sig_mr = to_mmr(wr->mr);
 	struct mlx5_ib_mr *pi_mr = sig_mr->pi_mr;
@@ -806,13 +840,13 @@ static int set_pi_umr_wr(const struct ib_send_wr *send_wr,
 	else
 		xlt_size = sizeof(struct mlx5_klm);
 
-	set_sig_umr_segment(*seg, xlt_size);
+	set_sig_umr_segment(dev, *seg, xlt_size);
 	*seg += sizeof(struct mlx5_wqe_umr_ctrl_seg);
 	*size += sizeof(struct mlx5_wqe_umr_ctrl_seg) / 16;
 	handle_post_send_edge(&qp->sq, seg, *size, cur_edge);
 
-	set_sig_mkey_segment(*seg, wr->mr, wr->access, xlt_size, region_len,
-			     pdn);
+	set_sig_mkey_segment(dev, *seg, wr->mr, wr->access, xlt_size,
+			     region_len, pdn);
 	*seg += sizeof(struct mlx5_mkey_seg);
 	*size += sizeof(struct mlx5_mkey_seg) / 16;
 	handle_post_send_edge(&qp->sq, seg, *size, cur_edge);
@@ -885,12 +919,12 @@ static int set_reg_wr(struct mlx5_ib_qp *qp,
 	if (umr_inline)
 		flags |= MLX5_UMR_INLINE;
 
-	set_reg_umr_seg(*seg, mr, flags, atomic);
+	set_reg_umr_seg(dev, *seg, mr, flags, atomic);
 	*seg += sizeof(struct mlx5_wqe_umr_ctrl_seg);
 	*size += sizeof(struct mlx5_wqe_umr_ctrl_seg) / 16;
 	handle_post_send_edge(&qp->sq, seg, *size, cur_edge);
 
-	set_reg_mkey_seg(*seg, mr, wr->key, wr->access);
+	set_reg_mkey_seg(dev, *seg, mr, wr->key, wr->access);
 	*seg += sizeof(struct mlx5_mkey_seg);
 	*size += sizeof(struct mlx5_mkey_seg) / 16;
 	handle_post_send_edge(&qp->sq, seg, *size, cur_edge);
-- 
2.31.1

