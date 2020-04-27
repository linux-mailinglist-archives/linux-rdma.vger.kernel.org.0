Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79191BA886
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 17:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgD0Pri (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 11:47:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgD0Prb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 11:47:31 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36FCF20661;
        Mon, 27 Apr 2020 15:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588002450;
        bh=jVjEZIHRkOK+m5aRBUG+4IsxtxOucVdDkHy1Ox5lKmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v9eyJobid71duR6ndoWw2wJQyMCYRAdRhyF6PkbkZdITcCjB2tP2VDv+Is+Pz//6R
         FWtp31uuLnnEj5DHik3FZ6x+hNo56xH6e7vC1EETcTa8E+F8PeFPnr15bMiRkyXz97
         2qVluI8wzPbv5uCLu1kKlRd3YtDtmZPk98oMoOjs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aharon Landau <aharonl@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1 11/36] RDMA/mlx5: Remove second copy from user for non RSS RAW QPs
Date:   Mon, 27 Apr 2020 18:46:11 +0300
Message-Id: <20200427154636.381474-12-leon@kernel.org>
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

Change the common code to use already copied user command buffer.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 56 ++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 5e4c73c4a7b4..91a2c9994b59 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1967,6 +1967,7 @@ static inline bool check_flags_mask(uint64_t input, uint64_t supported)
 
 static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			    struct ib_qp_init_attr *init_attr,
+			    struct mlx5_ib_create_qp *ucmd,
 			    struct ib_udata *udata, struct mlx5_ib_qp *qp)
 {
 	struct mlx5_ib_resources *devr = &dev->devr;
@@ -1979,7 +1980,6 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	struct mlx5_ib_cq *recv_cq;
 	unsigned long flags;
 	u32 uidx = MLX5_IB_DEFAULT_UIDX;
-	struct mlx5_ib_create_qp ucmd;
 	struct mlx5_ib_qp_base *base;
 	int mlx5_st;
 	void *qpc;
@@ -2056,12 +2056,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	}
 
 	if (udata) {
-		if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd))) {
-			mlx5_ib_dbg(dev, "copy failed\n");
-			return -EFAULT;
-		}
-
-		if (!check_flags_mask(ucmd.flags,
+		if (!check_flags_mask(ucmd->flags,
 				      MLX5_QP_FLAG_ALLOW_SCATTER_CQE |
 				      MLX5_QP_FLAG_BFREG_INDEX |
 				      MLX5_QP_FLAG_PACKET_BASED_CREDIT_MODE |
@@ -2075,14 +2070,15 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 				      MLX5_QP_FLAG_TYPE_DCT))
 			return -EINVAL;
 
-		err = get_qp_user_index(ucontext, &ucmd, udata->inlen, &uidx);
+		err = get_qp_user_index(ucontext, ucmd, udata->inlen, &uidx);
 		if (err)
 			return err;
 
-		qp->wq_sig = !!(ucmd.flags & MLX5_QP_FLAG_SIGNATURE);
+		qp->wq_sig = !!(ucmd->flags & MLX5_QP_FLAG_SIGNATURE);
 		if (MLX5_CAP_GEN(dev->mdev, sctr_data_cqe))
-			qp->scat_cqe = !!(ucmd.flags & MLX5_QP_FLAG_SCATTER_CQE);
-		if (ucmd.flags & MLX5_QP_FLAG_TUNNEL_OFFLOADS) {
+			qp->scat_cqe =
+				!!(ucmd->flags & MLX5_QP_FLAG_SCATTER_CQE);
+		if (ucmd->flags & MLX5_QP_FLAG_TUNNEL_OFFLOADS) {
 			if (init_attr->qp_type != IB_QPT_RAW_PACKET ||
 			    !tunnel_offload_supported(mdev)) {
 				mlx5_ib_dbg(dev, "Tunnel offload isn't supported\n");
@@ -2091,7 +2087,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			qp->flags_en |= MLX5_QP_FLAG_TUNNEL_OFFLOADS;
 		}
 
-		if (ucmd.flags & MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_UC) {
+		if (ucmd->flags & MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_UC) {
 			if (init_attr->qp_type != IB_QPT_RAW_PACKET) {
 				mlx5_ib_dbg(dev, "Self-LB UC isn't supported\n");
 				return -EOPNOTSUPP;
@@ -2099,7 +2095,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			qp->flags_en |= MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_UC;
 		}
 
-		if (ucmd.flags & MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_MC) {
+		if (ucmd->flags & MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_MC) {
 			if (init_attr->qp_type != IB_QPT_RAW_PACKET) {
 				mlx5_ib_dbg(dev, "Self-LB UM isn't supported\n");
 				return -EOPNOTSUPP;
@@ -2107,7 +2103,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			qp->flags_en |= MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_MC;
 		}
 
-		if (ucmd.flags & MLX5_QP_FLAG_PACKET_BASED_CREDIT_MODE) {
+		if (ucmd->flags & MLX5_QP_FLAG_PACKET_BASED_CREDIT_MODE) {
 			if (init_attr->qp_type != IB_QPT_RC ||
 				!MLX5_CAP_GEN(dev->mdev, qp_packet_based)) {
 				mlx5_ib_dbg(dev, "packet based credit mode isn't supported\n");
@@ -2138,8 +2134,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	       &qp->trans_qp.base;
 
 	qp->has_rq = qp_has_rq(init_attr);
-	err = set_rq_size(dev, &init_attr->cap, qp->has_rq,
-			  qp, udata ? &ucmd : NULL);
+	err = set_rq_size(dev, &init_attr->cap, qp->has_rq, qp, ucmd);
 	if (err) {
 		mlx5_ib_dbg(dev, "err %d\n", err);
 		return err;
@@ -2149,15 +2144,16 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		if (udata) {
 			__u32 max_wqes =
 				1 << MLX5_CAP_GEN(mdev, log_max_qp_sz);
-			mlx5_ib_dbg(dev, "requested sq_wqe_count (%d)\n", ucmd.sq_wqe_count);
-			if (ucmd.rq_wqe_shift != qp->rq.wqe_shift ||
-			    ucmd.rq_wqe_count != qp->rq.wqe_cnt) {
+			mlx5_ib_dbg(dev, "requested sq_wqe_count (%d)\n",
+				    ucmd->sq_wqe_count);
+			if (ucmd->rq_wqe_shift != qp->rq.wqe_shift ||
+			    ucmd->rq_wqe_count != qp->rq.wqe_cnt) {
 				mlx5_ib_dbg(dev, "invalid rq params\n");
 				return -EINVAL;
 			}
-			if (ucmd.sq_wqe_count > max_wqes) {
+			if (ucmd->sq_wqe_count > max_wqes) {
 				mlx5_ib_dbg(dev, "requested sq_wqe_count (%d) > max allowed (%d)\n",
-					    ucmd.sq_wqe_count, max_wqes);
+					    ucmd->sq_wqe_count, max_wqes);
 				return -EINVAL;
 			}
 			if (init_attr->create_flags &
@@ -2225,9 +2221,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	}
 	if (qp->scat_cqe && (qp->qp_sub_type == MLX5_IB_QPT_DCI ||
 			     init_attr->qp_type == IB_QPT_RC))
-		configure_requester_scat_cqe(dev, init_attr,
-					     udata ? &ucmd : NULL,
-					     qpc);
+		configure_requester_scat_cqe(dev, init_attr, ucmd, qpc);
 
 	if (qp->rq.wqe_cnt) {
 		MLX5_SET(qpc, qpc, log_rq_stride, qp->rq.wqe_shift - 4);
@@ -2308,7 +2302,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 
 	if (init_attr->qp_type == IB_QPT_RAW_PACKET ||
 	    qp->flags & MLX5_IB_QP_UNDERLAY) {
-		qp->raw_packet_qp.sq.ubuffer.buf_addr = ucmd.sq_buf_addr;
+		qp->raw_packet_qp.sq.ubuffer.buf_addr = ucmd->sq_buf_addr;
 		raw_packet_qp_copy_info(qp, &qp->raw_packet_qp);
 		err = create_raw_packet_qp(dev, qp, in, inlen, pd, udata,
 					   &resp);
@@ -2698,7 +2692,7 @@ static int create_driver_qp(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 		if (attr->cap.max_recv_wr || attr->cap.max_recv_sge)
 			goto out;
 
-		ret = create_qp_common(mdev, pd, attr, udata, qp);
+		ret = create_qp_common(mdev, pd, attr, ucmd, udata, qp);
 		break;
 	default:
 		return -EINVAL;
@@ -2712,7 +2706,10 @@ static size_t process_udata_size(struct ib_qp_init_attr *attr,
 {
 	size_t ucmd = sizeof(struct mlx5_ib_create_qp);
 
-	return (udata->inlen < ucmd) ? 0 : ucmd;
+	if (attr->qp_type == IB_QPT_DRIVER)
+		return (udata->inlen < ucmd) ? 0 : ucmd;
+
+	return ucmd;
 }
 
 struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
@@ -2742,7 +2739,7 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 	if (init_attr->qp_type == IB_QPT_GSI)
 		return mlx5_ib_gsi_create_qp(pd, init_attr);
 
-	if (udata && init_attr->qp_type == IB_QPT_DRIVER) {
+	if (udata && !init_attr->rwq_ind_tbl) {
 		size_t inlen =
 			process_udata_size(init_attr, udata);
 
@@ -2772,7 +2769,8 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 		err = create_driver_qp(pd, qp, init_attr, &ucmd, udata);
 		break;
 	default:
-		err = create_qp_common(dev, pd, init_attr, udata, qp);
+		err = create_qp_common(dev, pd, init_attr,
+				       (udata) ? &ucmd : NULL, udata, qp);
 	}
 	if (err) {
 		mlx5_ib_dbg(dev, "create_qp_common failed\n");
-- 
2.25.3

