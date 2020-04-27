Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07591BA8A9
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 17:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgD0Pr5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 11:47:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728316AbgD0Pr4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 11:47:56 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41F3F206D4;
        Mon, 27 Apr 2020 15:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588002475;
        bh=KWLMBO1OuCx2nK7O2rZOuApGr/m+swMgHymFn5/Cke8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y1gkT52dhHj09FkoD1OrITAlky3bmIpVEiRyYy1g3UriLO2gcUMR0uLWno36HBowg
         bZhCb0plzvmGr8DmPqhXkJ0JsZbgobT4sHB6GwLd6GwCDgS6bm7kNS7qaL5oXk6HhF
         o+fSwIEkpZZfhEPvTTHjQ/ZR2uq57vymqzoRA5HA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aharon Landau <aharonl@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1 20/36] RDMA/mlx5: Store QP type in the vendor QP structure
Date:   Mon, 27 Apr 2020 18:46:20 +0300
Message-Id: <20200427154636.381474-21-leon@kernel.org>
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

QP type is stored in the IB/core QP struct, but it doesn't have all the
needed information, like internal QP type used in the driver itself.
Update mlx5_ib to have cached QP type which includes both IBTA and
Mellanox specific one.

Such change allows us to make even further cleanup of QP creation flow.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   8 +-
 drivers/infiniband/hw/mlx5/odp.c     |   3 +-
 drivers/infiniband/hw/mlx5/qp.c      | 136 +++++++++++++--------------
 3 files changed, 74 insertions(+), 73 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 9b2baf119823..82ea01a211dd 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -465,8 +465,12 @@ struct mlx5_ib_qp {
 	struct mlx5_rate_limit	rl;
 	u32                     underlay_qpn;
 	u32			flags_en;
-	/* storage for qp sub type when core qp type is IB_QPT_DRIVER */
-	enum ib_qp_type		qp_sub_type;
+	/*
+	 * IB/core doesn't store low-level QP types, so
+	 * store both MLX and IBTA types in the field below.
+	 * IB_QPT_DRIVER will be break to DCI/DCT subtypes.
+	 */
+	enum ib_qp_type		type;
 	/* A flag to indicate if there's a new counter is configured
 	 * but not take effective
 	 */
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index e4759310c0e2..70577d546567 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1136,8 +1136,7 @@ static int mlx5_ib_mr_initiator_pfault_handler(
 	if (qp->ibqp.qp_type == IB_QPT_XRC_INI)
 		*wqe += sizeof(struct mlx5_wqe_xrc_seg);
 
-	if (qp->ibqp.qp_type == IB_QPT_UD ||
-	    qp->qp_sub_type == MLX5_IB_QPT_DCI) {
+	if (qp->type == IB_QPT_UD || qp->type == MLX5_IB_QPT_DCI) {
 		av = *wqe;
 		if (av->dqp_dct & cpu_to_be32(MLX5_EXTENDED_UD_AV))
 			*wqe += sizeof(struct mlx5_av);
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 5e156b02816a..0d3f4bafe448 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1227,14 +1227,13 @@ static void destroy_qp_kernel(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp)
 
 static u32 get_rx_type(struct mlx5_ib_qp *qp, struct ib_qp_init_attr *attr)
 {
-	if (attr->srq || (attr->qp_type == IB_QPT_XRC_TGT) ||
-	    (qp->qp_sub_type == MLX5_IB_QPT_DCI) ||
-	    (attr->qp_type == IB_QPT_XRC_INI))
+	if (attr->srq || (qp->type == IB_QPT_XRC_TGT) ||
+	    (qp->type == MLX5_IB_QPT_DCI) || (qp->type == IB_QPT_XRC_INI))
 		return MLX5_SRQ_RQ;
 	else if (!qp->has_rq)
 		return MLX5_ZERO_LEN_RQ;
-	else
-		return MLX5_NON_ZERO_RQ;
+
+	return MLX5_NON_ZERO_RQ;
 }
 
 static int create_raw_packet_qp_tis(struct mlx5_ib_dev *dev,
@@ -1967,9 +1966,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	spin_lock_init(&qp->sq.lock);
 	spin_lock_init(&qp->rq.lock);
 
-	mlx5_st = to_mlx5_st((init_attr->qp_type != IB_QPT_DRIVER) ?
-				     init_attr->qp_type :
-				     qp->qp_sub_type);
+	mlx5_st = to_mlx5_st(qp->type);
 	if (mlx5_st < 0)
 		return -EINVAL;
 
@@ -2073,8 +2070,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 					  MLX5_RES_SCAT_DATA32_CQE);
 	}
 	if ((qp->flags_en & MLX5_QP_FLAG_SCATTER_CQE) &&
-	    (qp->qp_sub_type == MLX5_IB_QPT_DCI ||
-	     init_attr->qp_type == IB_QPT_RC))
+	    (qp->type == MLX5_IB_QPT_DCI || qp->type == IB_QPT_RC))
 		configure_requester_scat_cqe(dev, init_attr, ucmd, qpc);
 
 	if (qp->rq.wqe_cnt) {
@@ -2166,7 +2162,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	base->container_mibqp = qp;
 	base->mqp.event = mlx5_ib_qp_event;
 
-	get_cqs(init_attr->qp_type, init_attr->send_cq, init_attr->recv_cq,
+	get_cqs(qp->type, init_attr->send_cq, init_attr->recv_cq,
 		&send_cq, &recv_cq);
 	spin_lock_irqsave(&dev->reset_flow_resource_lock, flags);
 	mlx5_ib_lock_cqs(send_cq, recv_cq);
@@ -2406,7 +2402,8 @@ static int create_dct(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 	return 0;
 }
 
-static int check_qp_type(struct mlx5_ib_dev *dev, struct ib_qp_init_attr *attr)
+static int check_qp_type(struct mlx5_ib_dev *dev, struct ib_qp_init_attr *attr,
+			 enum ib_qp_type *type)
 {
 	if (attr->qp_type == IB_QPT_DRIVER && !MLX5_CAP_GEN(dev->mdev, dct))
 		goto out;
@@ -2426,11 +2423,12 @@ static int check_qp_type(struct mlx5_ib_dev *dev, struct ib_qp_init_attr *attr)
 	case MLX5_IB_QPT_REG_UMR:
 	case IB_QPT_DRIVER:
 	case IB_QPT_GSI:
-		return 0;
+		break;
 	default:
 		goto out;
 	}
 
+	*type = attr->qp_type;
 	return 0;
 
 out:
@@ -2518,7 +2516,6 @@ static void process_vendor_flag(struct mlx5_ib_dev *dev, int *flags, int flag,
 }
 
 static int process_vendor_flags(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
-				struct ib_qp_init_attr *attr,
 				struct mlx5_ib_create_qp *ucmd)
 {
 	struct mlx5_core_dev *mdev = dev->mdev;
@@ -2527,17 +2524,20 @@ static int process_vendor_flags(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 
 	switch (flags & (MLX5_QP_FLAG_TYPE_DCT | MLX5_QP_FLAG_TYPE_DCI)) {
 	case MLX5_QP_FLAG_TYPE_DCI:
-		qp->qp_sub_type = MLX5_IB_QPT_DCI;
+		qp->type = MLX5_IB_QPT_DCI;
 		break;
 	case MLX5_QP_FLAG_TYPE_DCT:
-		qp->qp_sub_type = MLX5_IB_QPT_DCT;
-		fallthrough;
-	default:
+		qp->type = MLX5_IB_QPT_DCT;
 		break;
-	}
-
-	if (attr->qp_type == IB_QPT_DRIVER && !qp->qp_sub_type)
+	default:
+		if (qp->type != IB_QPT_DRIVER)
+			break;
+		/*
+		 * It is IB_QPT_DRIVER and or no subtype or
+		 * wrong subtype were provided.
+		 */
 		return -EINVAL;
+	}
 
 	process_vendor_flag(dev, &flags, MLX5_QP_FLAG_TYPE_DCI, true, qp);
 	process_vendor_flag(dev, &flags, MLX5_QP_FLAG_TYPE_DCT, true, qp);
@@ -2546,7 +2546,7 @@ static int process_vendor_flags(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	process_vendor_flag(dev, &flags, MLX5_QP_FLAG_SCATTER_CQE,
 			    MLX5_CAP_GEN(mdev, sctr_data_cqe), qp);
 
-	if (attr->qp_type == IB_QPT_RAW_PACKET) {
+	if (qp->type == IB_QPT_RAW_PACKET) {
 		cond = MLX5_CAP_ETH(mdev, tunnel_stateless_vxlan) ||
 		       MLX5_CAP_ETH(mdev, tunnel_stateless_gre) ||
 		       MLX5_CAP_ETH(mdev, tunnel_stateless_geneve_rx);
@@ -2560,7 +2560,7 @@ static int process_vendor_flags(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 				    qp);
 	}
 
-	if (attr->qp_type == IB_QPT_RC)
+	if (qp->type == IB_QPT_RC)
 		process_vendor_flag(dev, &flags,
 				    MLX5_QP_FLAG_PACKET_BASED_CREDIT_MODE,
 				    MLX5_CAP_GEN(mdev, qp_packet_based), qp);
@@ -2597,12 +2597,12 @@ static void process_create_flag(struct mlx5_ib_dev *dev, int *flags, int flag,
 static int process_create_flags(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 				struct ib_qp_init_attr *attr)
 {
-	enum ib_qp_type qp_type = attr->qp_type;
+	enum ib_qp_type qp_type = qp->type;
 	struct mlx5_core_dev *mdev = dev->mdev;
 	int create_flags = attr->create_flags;
 	bool cond;
 
-	if (qp->qp_sub_type == MLX5_IB_QPT_DCT)
+	if (qp_type == MLX5_IB_QPT_DCT)
 		return (create_flags) ? -EINVAL : 0;
 
 	if (qp_type == IB_QPT_RAW_PACKET && attr->rwq_ind_tbl)
@@ -2656,34 +2656,6 @@ static int process_create_flags(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	return (create_flags) ? -EINVAL : 0;
 }
 
-static int create_driver_qp(struct ib_pd *pd, struct mlx5_ib_qp *qp,
-			    struct ib_qp_init_attr *attr,
-			    struct mlx5_ib_create_qp *ucmd,
-			    struct ib_udata *udata)
-{
-	struct mlx5_ib_dev *mdev = to_mdev(pd->device);
-	int ret = -EINVAL;
-
-	switch (qp->qp_sub_type) {
-	case MLX5_IB_QPT_DCT:
-		if (!attr->srq || !attr->recv_cq)
-			goto out;
-
-		ret = create_dct(pd, qp, attr, ucmd, udata);
-		break;
-	case MLX5_IB_QPT_DCI:
-		if (attr->cap.max_recv_wr || attr->cap.max_recv_sge)
-			goto out;
-
-		ret = create_qp_common(mdev, pd, attr, ucmd, udata, qp);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-out:	return ret;
-}
-
 static size_t process_udata_size(struct ib_qp_init_attr *attr,
 				 struct ib_udata *udata)
 {
@@ -2707,6 +2679,30 @@ static int create_raw_qp(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 	return create_qp_common(dev, pd, attr, ucmd, udata, qp);
 }
 
+static int check_qp_attr(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
+			 struct ib_qp_init_attr *attr)
+{
+	int ret = 0;
+
+	switch (qp->type) {
+	case MLX5_IB_QPT_DCT:
+		ret = (!attr->srq || !attr->recv_cq) ? -EINVAL : 0;
+		break;
+	case MLX5_IB_QPT_DCI:
+		ret = (attr->cap.max_recv_wr || attr->cap.max_recv_sge) ?
+			      -EINVAL :
+			      0;
+		break;
+	default:
+		break;
+	}
+
+	if (ret)
+		mlx5_ib_dbg(dev, "QP type %d has wrong attributes\n", qp->type);
+
+	return ret;
+}
+
 struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 				struct ib_qp_init_attr *init_attr,
 				struct ib_udata *udata)
@@ -2714,13 +2710,14 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 	struct mlx5_ib_create_qp ucmd = {};
 	struct mlx5_ib_dev *dev;
 	struct mlx5_ib_qp *qp;
+	enum ib_qp_type type;
 	u16 xrcdn = 0;
 	int err;
 
 	dev = pd ? to_mdev(pd->device) :
 		   to_mdev(to_mxrcd(init_attr->xrcd)->ibxrcd.device);
 
-	err = check_qp_type(dev, init_attr);
+	err = check_qp_type(dev, init_attr, &type);
 	if (err) {
 		mlx5_ib_dbg(dev, "Unsupported QP type %d\n",
 			    init_attr->qp_type);
@@ -2750,8 +2747,9 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 	if (!qp)
 		return ERR_PTR(-ENOMEM);
 
+	qp->type = type;
 	if (udata) {
-		err = process_vendor_flags(dev, qp, init_attr, &ucmd);
+		err = process_vendor_flags(dev, qp, &ucmd);
 		if (err)
 			goto free_qp;
 	}
@@ -2759,16 +2757,20 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 	if (err)
 		goto free_qp;
 
-	if (init_attr->qp_type == IB_QPT_XRC_TGT)
+	if (qp->type == IB_QPT_XRC_TGT)
 		xrcdn = to_mxrcd(init_attr->xrcd)->xrcdn;
 
-	switch (init_attr->qp_type) {
-	case IB_QPT_DRIVER:
-		err = create_driver_qp(pd, qp, init_attr, &ucmd, udata);
-		break;
+	err = check_qp_attr(dev, qp, init_attr);
+	if (err)
+		goto free_qp;
+
+	switch (qp->type) {
 	case IB_QPT_RAW_PACKET:
 		err = create_raw_qp(pd, qp, init_attr, &ucmd, udata);
 		break;
+	case MLX5_IB_QPT_DCT:
+		err = create_dct(pd, qp, init_attr, &ucmd, udata);
+		break;
 	default:
 		err = create_qp_common(dev, pd, init_attr,
 				       (udata) ? &ucmd : NULL, udata, qp);
@@ -2821,7 +2823,7 @@ int mlx5_ib_destroy_qp(struct ib_qp *qp, struct ib_udata *udata)
 	if (unlikely(qp->qp_type == IB_QPT_GSI))
 		return mlx5_ib_gsi_destroy_qp(qp);
 
-	if (mqp->qp_sub_type == MLX5_IB_QPT_DCT)
+	if (mqp->type == MLX5_IB_QPT_DCT)
 		return mlx5_ib_destroy_dct(mqp);
 
 	destroy_qp_common(dev, mqp, udata);
@@ -3508,8 +3510,7 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 	u16 op;
 	u8 tx_affinity = 0;
 
-	mlx5_st = to_mlx5_st(ibqp->qp_type == IB_QPT_DRIVER ?
-			     qp->qp_sub_type : ibqp->qp_type);
+	mlx5_st = to_mlx5_st(qp->type);
 	if (mlx5_st < 0)
 		return -EINVAL;
 
@@ -3970,11 +3971,8 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	if (unlikely(ibqp->qp_type == IB_QPT_GSI))
 		return mlx5_ib_gsi_modify_qp(ibqp, attr, attr_mask);
 
-	if (ibqp->qp_type == IB_QPT_DRIVER)
-		qp_type = qp->qp_sub_type;
-	else
-		qp_type = (unlikely(ibqp->qp_type == MLX5_IB_QPT_HW_GSI)) ?
-			IB_QPT_GSI : ibqp->qp_type;
+	qp_type = (unlikely(ibqp->qp_type == MLX5_IB_QPT_HW_GSI)) ? IB_QPT_GSI :
+								    qp->type;
 
 	if (qp_type == MLX5_IB_QPT_DCT)
 		return mlx5_ib_modify_dct(ibqp, attr, attr_mask, udata);
@@ -5813,7 +5811,7 @@ int mlx5_ib_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	memset(qp_init_attr, 0, sizeof(*qp_init_attr));
 	memset(qp_attr, 0, sizeof(*qp_attr));
 
-	if (unlikely(qp->qp_sub_type == MLX5_IB_QPT_DCT))
+	if (unlikely(qp->type == MLX5_IB_QPT_DCT))
 		return mlx5_ib_dct_query_qp(dev, qp, qp_attr,
 					    qp_attr_mask, qp_init_attr);
 
-- 
2.25.3

