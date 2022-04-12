Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765304FD4A5
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 12:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352038AbiDLJ5k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 05:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359466AbiDLHnE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 03:43:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BAA13DCB
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 00:24:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BB87B81B33
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 07:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B376C385A5;
        Tue, 12 Apr 2022 07:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649748296;
        bh=947lfB0QsXwaXBVDptltc6CpIfTMZkLCai0kpOmVRg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rEx/4cBFJ21mWWAJz1ugd5HiBwLHXW+Gh8b7mDT+AJ24a/fRcAGA81aisFJUf34vk
         djIuMRin+qyvD7H6Pym7eGGHzlBzwE03UnmPt5K9Gb21NBLWIcAfvfZMTJG4/s6xpF
         H8rbFwWQV1RfxUtZSylS2vu2+nRL/WH4JizSkk7tvUW+8DzcLo7+mWQVsXCZyFFPhz
         69GZXU58wGGS19s+1KEz/iixfH8F+QyrayY1MLIPq2/ozYJ94lkVkKOd6n3jssVtrt
         lng/f23ImF6/dyPDqArm5GjiUo8kVb5nQlF2pHbVYPoAcPye3ThdCAMUtbKlyrCF+Q
         1uZtb0eAV67kA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 12/12] RDMA/mlx5: Clean UMR QP type flow from mlx5_ib_post_send()
Date:   Tue, 12 Apr 2022 10:24:07 +0300
Message-Id: <0b2f368f14bc9266ebdf92a601ca4e1e5b1e1188.1649747695.git.leonro@nvidia.com>
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

No internal UMR operation is using mlx5_ib_post_send(), remove the UMR QP
type logic from this function.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 27 +----------
 drivers/infiniband/hw/mlx5/umr.c     | 43 -----------------
 drivers/infiniband/hw/mlx5/umr.h     |  4 --
 drivers/infiniband/hw/mlx5/wr.c      | 72 ----------------------------
 4 files changed, 1 insertion(+), 145 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 10e60c9281b4..df2b566ad73d 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -291,16 +291,9 @@ struct mlx5_ib_flow_db {
 };
 
 /* Use macros here so that don't have to duplicate
- * enum ib_send_flags and enum ib_qp_type for low-level driver
+ * enum ib_qp_type for low-level driver
  */
 
-#define MLX5_IB_SEND_UMR_ENABLE_MR	       (IB_SEND_RESERVED_START << 0)
-#define MLX5_IB_SEND_UMR_DISABLE_MR	       (IB_SEND_RESERVED_START << 1)
-#define MLX5_IB_SEND_UMR_FAIL_IF_FREE	       (IB_SEND_RESERVED_START << 2)
-#define MLX5_IB_SEND_UMR_UPDATE_XLT	       (IB_SEND_RESERVED_START << 3)
-#define MLX5_IB_SEND_UMR_UPDATE_TRANSLATION    (IB_SEND_RESERVED_START << 4)
-#define MLX5_IB_SEND_UMR_UPDATE_PD_ACCESS       IB_SEND_RESERVED_END
-
 #define MLX5_IB_QPT_REG_UMR	IB_QPT_RESERVED1
 /*
  * IB_QPT_GSI creates the software wrapper around GSI, and MLX5_IB_QPT_HW_GSI
@@ -536,24 +529,6 @@ struct mlx5_ib_cq_buf {
 	int			nent;
 };
 
-struct mlx5_umr_wr {
-	struct ib_send_wr		wr;
-	u64				virt_addr;
-	u64				offset;
-	struct ib_pd		       *pd;
-	unsigned int			page_shift;
-	unsigned int			xlt_size;
-	u64				length;
-	int				access_flags;
-	u32				mkey;
-	u8				ignore_free_state:1;
-};
-
-static inline const struct mlx5_umr_wr *umr_wr(const struct ib_send_wr *wr)
-{
-	return container_of(wr, struct mlx5_umr_wr, wr);
-}
-
 enum mlx5_ib_cq_pr_flags {
 	MLX5_IB_CQ_PR_FLAGS_CQE_128_PAD	= 1 << 0,
 	MLX5_IB_CQ_PR_FLAGS_REAL_TIME_TS = 1 << 1,
diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index ad9e31107901..3a48364c0918 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -94,49 +94,6 @@ static int umr_check_mkey_mask(struct mlx5_ib_dev *dev, u64 mask)
 	return 0;
 }
 
-int mlx5r_umr_set_umr_ctrl_seg(struct mlx5_ib_dev *dev,
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
-	umr->xlt_octowords =
-		cpu_to_be16(mlx5r_umr_get_xlt_octo(umrwr->xlt_size));
-	if (wr->send_flags & MLX5_IB_SEND_UMR_UPDATE_XLT) {
-		u64 offset = mlx5r_umr_get_xlt_octo(umrwr->offset);
-
-		umr->xlt_offset = cpu_to_be16(offset & 0xffff);
-		umr->xlt_offset_47_16 = cpu_to_be32(offset >> 16);
-		umr->flags |= MLX5_UMR_TRANSLATION_OFFSET_EN;
-	}
-	if (wr->send_flags & MLX5_IB_SEND_UMR_UPDATE_TRANSLATION)
-		umr->mkey_mask |= get_umr_update_translation_mask();
-	if (wr->send_flags & MLX5_IB_SEND_UMR_UPDATE_PD_ACCESS) {
-		umr->mkey_mask |= get_umr_update_access_mask(dev);
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
 enum {
 	MAX_UMR_WR = 128,
 };
diff --git a/drivers/infiniband/hw/mlx5/umr.h b/drivers/infiniband/hw/mlx5/umr.h
index b42e8c93b385..c9d0021381a2 100644
--- a/drivers/infiniband/hw/mlx5/umr.h
+++ b/drivers/infiniband/hw/mlx5/umr.h
@@ -75,10 +75,6 @@ static inline u64 mlx5r_umr_get_xlt_octo(u64 bytes)
 	       MLX5_IB_UMR_OCTOWORD;
 }
 
-int mlx5r_umr_set_umr_ctrl_seg(struct mlx5_ib_dev *dev,
-			       struct mlx5_wqe_umr_ctrl_seg *umr,
-			       const struct ib_send_wr *wr);
-
 struct mlx5r_umr_context {
 	struct ib_cqe cqe;
 	enum ib_wc_status status;
diff --git a/drivers/infiniband/hw/mlx5/wr.c b/drivers/infiniband/hw/mlx5/wr.c
index 7949f83b2cd2..855f3f4fefad 100644
--- a/drivers/infiniband/hw/mlx5/wr.c
+++ b/drivers/infiniband/hw/mlx5/wr.c
@@ -214,43 +214,6 @@ static void set_linv_mkey_seg(struct mlx5_mkey_seg *seg)
 	seg->status = MLX5_MKEY_STATUS_FREE;
 }
 
-static void set_reg_mkey_segment(struct mlx5_ib_dev *dev,
-				 struct mlx5_mkey_seg *seg,
-				 const struct ib_send_wr *wr)
-{
-	const struct mlx5_umr_wr *umrwr = umr_wr(wr);
-
-	memset(seg, 0, sizeof(*seg));
-	if (wr->send_flags & MLX5_IB_SEND_UMR_DISABLE_MR)
-		MLX5_SET(mkc, seg, free, 1);
-
-	MLX5_SET(mkc, seg, a,
-		 !!(umrwr->access_flags & IB_ACCESS_REMOTE_ATOMIC));
-	MLX5_SET(mkc, seg, rw,
-		 !!(umrwr->access_flags & IB_ACCESS_REMOTE_WRITE));
-	MLX5_SET(mkc, seg, rr, !!(umrwr->access_flags & IB_ACCESS_REMOTE_READ));
-	MLX5_SET(mkc, seg, lw, !!(umrwr->access_flags & IB_ACCESS_LOCAL_WRITE));
-	MLX5_SET(mkc, seg, lr, 1);
-	if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write_umr))
-		MLX5_SET(mkc, seg, relaxed_ordering_write,
-			 !!(umrwr->access_flags & IB_ACCESS_RELAXED_ORDERING));
-	if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read_umr))
-		MLX5_SET(mkc, seg, relaxed_ordering_read,
-			 !!(umrwr->access_flags & IB_ACCESS_RELAXED_ORDERING));
-
-	if (umrwr->pd)
-		MLX5_SET(mkc, seg, pd, to_mpd(umrwr->pd)->pdn);
-	if (wr->send_flags & MLX5_IB_SEND_UMR_UPDATE_TRANSLATION &&
-	    !umrwr->length)
-		MLX5_SET(mkc, seg, length64, 1);
-
-	MLX5_SET64(mkc, seg, start_addr, umrwr->virt_addr);
-	MLX5_SET64(mkc, seg, len, umrwr->length);
-	MLX5_SET(mkc, seg, log_page_size, umrwr->page_shift);
-	MLX5_SET(mkc, seg, qpn, 0xffffff);
-	MLX5_SET(mkc, seg, mkey_7_0, mlx5_mkey_variant(umrwr->mkey));
-}
-
 static void set_reg_data_seg(struct mlx5_wqe_data_seg *dseg,
 			     struct mlx5_ib_mr *mr,
 			     struct mlx5_ib_pd *pd)
@@ -1059,35 +1022,6 @@ static void handle_qpt_ud(struct mlx5_ib_qp *qp, const struct ib_send_wr *wr,
 	}
 }
 
-static int handle_qpt_reg_umr(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
-			      const struct ib_send_wr *wr,
-			      struct mlx5_wqe_ctrl_seg **ctrl, void **seg,
-			      int *size, void **cur_edge, unsigned int idx)
-{
-	int err = 0;
-
-	if (unlikely(wr->opcode != MLX5_IB_WR_UMR)) {
-		err = -EINVAL;
-		mlx5_ib_warn(dev, "bad opcode %d\n", wr->opcode);
-		goto out;
-	}
-
-	qp->sq.wr_data[idx] = MLX5_IB_WR_UMR;
-	(*ctrl)->imm = cpu_to_be32(umr_wr(wr)->mkey);
-	err = mlx5r_umr_set_umr_ctrl_seg(dev, *seg, wr);
-	if (unlikely(err))
-		goto out;
-	*seg += sizeof(struct mlx5_wqe_umr_ctrl_seg);
-	*size += sizeof(struct mlx5_wqe_umr_ctrl_seg) / 16;
-	handle_post_send_edge(&qp->sq, seg, *size, cur_edge);
-	set_reg_mkey_segment(dev, *seg, wr);
-	*seg += sizeof(struct mlx5_mkey_seg);
-	*size += sizeof(struct mlx5_mkey_seg) / 16;
-	handle_post_send_edge(&qp->sq, seg, *size, cur_edge);
-out:
-	return err;
-}
-
 void mlx5r_ring_db(struct mlx5_ib_qp *qp, unsigned int nreq,
 		   struct mlx5_wqe_ctrl_seg *ctrl)
 {
@@ -1220,12 +1154,6 @@ int mlx5_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 		case IB_QPT_UD:
 			handle_qpt_ud(qp, wr, &seg, &size, &cur_edge);
 			break;
-		case MLX5_IB_QPT_REG_UMR:
-			err = handle_qpt_reg_umr(dev, qp, wr, &ctrl, &seg,
-						       &size, &cur_edge, idx);
-			if (unlikely(err))
-				goto out;
-			break;
 
 		default:
 			break;
-- 
2.35.1

