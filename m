Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9FE21BA894
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 17:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgD0Prr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 11:47:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728295AbgD0Prq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 11:47:46 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0498C2064C;
        Mon, 27 Apr 2020 15:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588002465;
        bh=qQ3B9PI8KcD+DpICrCNPpWmbe01bX05UzrPuoNqsxLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x5CbQJkqL9QnrcL3rFOb8pZwb5WelYIs51hQiG5XAMIkVdlkYeXgUF6hTf0phZF/C
         sXEJYZFXSXGdW5PYBL/EfvkSHrIQ4DvzXiCBWy8gO5dFYrOcvktaF2jyIhC1uni3qV
         0SQsX4ru46kw2VKGlTGFux9M9lyn2ZFWQvITngeI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aharon Landau <aharonl@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1 18/36] RDMA/mlx5: Process all vendor flags in one place
Date:   Mon, 27 Apr 2020 18:46:18 +0300
Message-Id: <20200427154636.381474-19-leon@kernel.org>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200427154636.381474-1-leon@kernel.org>
References: <20200427154636.381474-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Check that vendor flags provided through ucmd are valid.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 156 +++++++++++++++-----------------
 1 file changed, 71 insertions(+), 85 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index f0385965a694..2673678f1899 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1430,13 +1430,6 @@ static void destroy_raw_packet_qp_rq(struct mlx5_ib_dev *dev,
 	mlx5_core_destroy_rq_tracked(dev, &rq->base.mqp);
 }
 
-static bool tunnel_offload_supported(struct mlx5_core_dev *dev)
-{
-	return  (MLX5_CAP_ETH(dev, tunnel_stateless_vxlan) ||
-		 MLX5_CAP_ETH(dev, tunnel_stateless_gre) ||
-		 MLX5_CAP_ETH(dev, tunnel_stateless_geneve_rx));
-}
-
 static void destroy_raw_packet_qp_tir(struct mlx5_ib_dev *dev,
 				      struct mlx5_ib_rq *rq,
 				      u32 qp_flags_en,
@@ -1693,27 +1686,20 @@ static int create_rss_raw_qp_tir(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 		return -EOPNOTSUPP;
 	}
 
-	if (ucmd.flags & MLX5_QP_FLAG_TUNNEL_OFFLOADS &&
-	    !tunnel_offload_supported(dev->mdev)) {
-		mlx5_ib_dbg(dev, "tunnel offloads isn't supported\n");
-		return -EOPNOTSUPP;
-	}
-
 	if (ucmd.rx_hash_fields_mask & MLX5_RX_HASH_INNER &&
 	    !(ucmd.flags & MLX5_QP_FLAG_TUNNEL_OFFLOADS)) {
 		mlx5_ib_dbg(dev, "Tunnel offloads must be set for inner RSS\n");
 		return -EOPNOTSUPP;
 	}
 
-	if (ucmd.flags & MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_UC || dev->is_rep) {
-		lb_flag |= MLX5_TIRC_SELF_LB_BLOCK_BLOCK_UNICAST;
+	if (dev->is_rep)
 		qp->flags_en |= MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_UC;
-	}
 
-	if (ucmd.flags & MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_MC) {
+	if (qp->flags_en & MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_UC)
+		lb_flag |= MLX5_TIRC_SELF_LB_BLOCK_BLOCK_UNICAST;
+
+	if (qp->flags_en & MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_MC)
 		lb_flag |= MLX5_TIRC_SELF_LB_BLOCK_BLOCK_MULTICAST;
-		qp->flags_en |= MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_MC;
-	}
 
 	err = ib_copy_to_udata(udata, &resp, min(udata->outlen, sizeof(resp)));
 	if (err) {
@@ -1959,11 +1945,6 @@ static int get_atomic_mode(struct mlx5_ib_dev *dev,
 	return atomic_mode;
 }
 
-static inline bool check_flags_mask(uint64_t input, uint64_t supported)
-{
-	return (input & ~supported) == 0;
-}
-
 static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			    struct ib_qp_init_attr *init_attr,
 			    struct mlx5_ib_create_qp *ucmd,
@@ -1999,63 +1980,9 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		qp->sq_signal_bits = MLX5_WQE_CTRL_CQ_UPDATE;
 
 	if (udata) {
-		if (!check_flags_mask(ucmd->flags,
-				      MLX5_QP_FLAG_ALLOW_SCATTER_CQE |
-				      MLX5_QP_FLAG_BFREG_INDEX |
-				      MLX5_QP_FLAG_PACKET_BASED_CREDIT_MODE |
-				      MLX5_QP_FLAG_SCATTER_CQE |
-				      MLX5_QP_FLAG_SIGNATURE |
-				      MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_MC |
-				      MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_UC |
-				      MLX5_QP_FLAG_TUNNEL_OFFLOADS |
-				      MLX5_QP_FLAG_UAR_PAGE_INDEX |
-				      MLX5_QP_FLAG_TYPE_DCI |
-				      MLX5_QP_FLAG_TYPE_DCT))
-			return -EINVAL;
-
 		err = get_qp_user_index(ucontext, ucmd, udata->inlen, &uidx);
 		if (err)
 			return err;
-
-		if (ucmd->flags & MLX5_QP_FLAG_SIGNATURE)
-			qp->flags_en |= MLX5_QP_FLAG_SIGNATURE;
-		if (ucmd->flags & MLX5_QP_FLAG_SCATTER_CQE &&
-		    MLX5_CAP_GEN(dev->mdev, sctr_data_cqe))
-			qp->flags_en |= MLX5_QP_FLAG_SCATTER_CQE;
-
-		if (ucmd->flags & MLX5_QP_FLAG_TUNNEL_OFFLOADS) {
-			if (init_attr->qp_type != IB_QPT_RAW_PACKET ||
-			    !tunnel_offload_supported(mdev)) {
-				mlx5_ib_dbg(dev, "Tunnel offload isn't supported\n");
-				return -EOPNOTSUPP;
-			}
-			qp->flags_en |= MLX5_QP_FLAG_TUNNEL_OFFLOADS;
-		}
-
-		if (ucmd->flags & MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_UC) {
-			if (init_attr->qp_type != IB_QPT_RAW_PACKET) {
-				mlx5_ib_dbg(dev, "Self-LB UC isn't supported\n");
-				return -EOPNOTSUPP;
-			}
-			qp->flags_en |= MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_UC;
-		}
-
-		if (ucmd->flags & MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_MC) {
-			if (init_attr->qp_type != IB_QPT_RAW_PACKET) {
-				mlx5_ib_dbg(dev, "Self-LB UM isn't supported\n");
-				return -EOPNOTSUPP;
-			}
-			qp->flags_en |= MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_MC;
-		}
-
-		if (ucmd->flags & MLX5_QP_FLAG_PACKET_BASED_CREDIT_MODE) {
-			if (init_attr->qp_type != IB_QPT_RC ||
-				!MLX5_CAP_GEN(dev->mdev, qp_packet_based)) {
-				mlx5_ib_dbg(dev, "packet based credit mode isn't supported\n");
-				return -EOPNOTSUPP;
-			}
-			qp->flags_en |= MLX5_QP_FLAG_PACKET_BASED_CREDIT_MODE;
-		}
 	}
 
 	if (qp->flags & IB_QP_CREATE_SOURCE_QPN)
@@ -2474,7 +2401,7 @@ static int create_dct(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 	MLX5_SET64(dctc, dctc, dc_access_key, ucmd->access_key);
 	MLX5_SET(dctc, dctc, user_index, uidx);
 
-	if (ucmd->flags & MLX5_QP_FLAG_SCATTER_CQE) {
+	if (qp->flags_en & MLX5_QP_FLAG_SCATTER_CQE) {
 		int rcqe_sz = mlx5_ib_get_cqe_size(attr->recv_cq);
 
 		if (rcqe_sz == 128)
@@ -2577,22 +2504,81 @@ static int check_valid_flow(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	return 0;
 }
 
-static int process_vendor_flags(struct mlx5_ib_qp *qp,
+static void process_vendor_flag(struct mlx5_ib_dev *dev, int *flags, int flag,
+				bool cond, struct mlx5_ib_qp *qp)
+{
+	if (!(*flags & flag))
+		return;
+
+	if (cond) {
+		qp->flags_en |= flag;
+		*flags &= ~flag;
+		return;
+	}
+
+	if (flag == MLX5_QP_FLAG_SCATTER_CQE) {
+		/*
+		 * We don't return error if this flag was provided,
+		 * and mlx5 doesn't have right capability.
+		 */
+		*flags &= ~MLX5_QP_FLAG_SCATTER_CQE;
+		return;
+	}
+	mlx5_ib_dbg(dev, "Vendor create QP flag 0x%X is not supported\n", flag);
+}
+
+static int process_vendor_flags(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 				struct ib_qp_init_attr *attr,
 				struct mlx5_ib_create_qp *ucmd)
 {
-	switch (ucmd->flags & (MLX5_QP_FLAG_TYPE_DCT | MLX5_QP_FLAG_TYPE_DCI)) {
+	struct mlx5_core_dev *mdev = dev->mdev;
+	int flags = ucmd->flags;
+	bool cond;
+
+	switch (flags & (MLX5_QP_FLAG_TYPE_DCT | MLX5_QP_FLAG_TYPE_DCI)) {
 	case MLX5_QP_FLAG_TYPE_DCI:
 		qp->qp_sub_type = MLX5_IB_QPT_DCI;
 		break;
 	case MLX5_QP_FLAG_TYPE_DCT:
 		qp->qp_sub_type = MLX5_IB_QPT_DCT;
-		break;
+		fallthrough;
 	default:
+		break;
+	}
+
+	if (attr->qp_type == IB_QPT_DRIVER && !qp->qp_sub_type)
 		return -EINVAL;
+
+	process_vendor_flag(dev, &flags, MLX5_QP_FLAG_TYPE_DCI, true, qp);
+	process_vendor_flag(dev, &flags, MLX5_QP_FLAG_TYPE_DCT, true, qp);
+
+	process_vendor_flag(dev, &flags, MLX5_QP_FLAG_SIGNATURE, true, qp);
+	process_vendor_flag(dev, &flags, MLX5_QP_FLAG_SCATTER_CQE,
+			    MLX5_CAP_GEN(mdev, sctr_data_cqe), qp);
+
+	if (attr->qp_type == IB_QPT_RAW_PACKET) {
+		cond = MLX5_CAP_ETH(mdev, tunnel_stateless_vxlan) ||
+		       MLX5_CAP_ETH(mdev, tunnel_stateless_gre) ||
+		       MLX5_CAP_ETH(mdev, tunnel_stateless_geneve_rx);
+		process_vendor_flag(dev, &flags, MLX5_QP_FLAG_TUNNEL_OFFLOADS,
+				    cond, qp);
+		process_vendor_flag(dev, &flags,
+				    MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_UC, true,
+				    qp);
+		process_vendor_flag(dev, &flags,
+				    MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_MC, true,
+				    qp);
 	}
 
-	return 0;
+	if (attr->qp_type == IB_QPT_RC)
+		process_vendor_flag(dev, &flags,
+				    MLX5_QP_FLAG_PACKET_BASED_CREDIT_MODE,
+				    MLX5_CAP_GEN(mdev, qp_packet_based), qp);
+
+	if (flags)
+		mlx5_ib_dbg(dev, "udata has unsupported flags 0x%X\n", flags);
+
+	return (flags) ? -EINVAL : 0;
 }
 
 static void process_create_flag(struct mlx5_ib_dev *dev, int *flags, int flag,
@@ -2774,8 +2760,8 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 	if (!qp)
 		return ERR_PTR(-ENOMEM);
 
-	if (init_attr->qp_type == IB_QPT_DRIVER) {
-		err = process_vendor_flags(qp, init_attr, &ucmd);
+	if (udata) {
+		err = process_vendor_flags(dev, qp, init_attr, &ucmd);
 		if (err)
 			goto free_qp;
 	}
-- 
2.25.3

