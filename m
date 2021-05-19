Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4EB3889AD
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 10:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343737AbhESIsw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 04:48:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343696AbhESIsw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 04:48:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 150DA6108D;
        Wed, 19 May 2021 08:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621414052;
        bh=2j2hIyUoP74sXthg7WGZh4jxakLphjBmcIcydtC8How=;
        h=From:To:Cc:Subject:Date:From;
        b=d4m41YyamzfDM8NpUtzif54Q6EBaNFQ52az2VJ0wdfmGvCA41QIzL2bWLkfimcbtH
         Q0hcl9DpDE33LMDgc9WaozFTAZpfKvEcyqMKkUlSk+jlhPba8K0OX8yAvkW5jAxq2V
         V0oEH3/2Moiue+6/QGWSIAy+qAA77NNGBvZ4TDo6ea50Xs5JHTe2s5VGGIH7YtsGGi
         lzP3DwrAYDOcMiwImhLnt3xjQAvdBxNr/1jniEbsHMlmInLL46Q/jpt6xYG2ZDf8HT
         s14R8xMGto7Yr8Z6a1HFmIx65k5A8lJHKMGTSXVH2cYypOoolQHV5D1aKq0BjdMK7G
         eLsB0/RPHHwLQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/mlx5: Take qp type from mlx5_ib_qp
Date:   Wed, 19 May 2021 11:47:27 +0300
Message-Id: <b2e16cd65b59cd24fa81c01c7989248da44e58ea.1621413899.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

Change all the places in the mlx5_ib driver to take the
qp type from the mlx5_ib_qp struct, except the QP initialization
flow. It will ensure that we check the right QP type also for vendor
specific QPs.

Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Followup to 
https://lore.kernel.org/lkml/6eee15d63f09bb70787488e0cf96216e2957f5aa.1621413654.git.leonro@nvidia.com
---
 drivers/infiniband/hw/mlx5/cq.c      |  2 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 -
 drivers/infiniband/hw/mlx5/odp.c     |  2 +-
 drivers/infiniband/hw/mlx5/qp.c      | 53 +++++++++++++---------------
 drivers/infiniband/hw/mlx5/wr.c      |  9 +++--
 5 files changed, 31 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 40f091a523b6..46908a9ab3a9 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -227,7 +227,7 @@ static void handle_responder(struct ib_wc *wc, struct mlx5_cqe64 *cqe,
 	wc->dlid_path_bits = cqe->ml_path;
 	g = (be32_to_cpu(cqe->flags_rqpn) >> 28) & 3;
 	wc->wc_flags |= g ? IB_WC_GRH : 0;
-	if (unlikely(is_qp1(qp->ibqp.qp_type))) {
+	if (is_qp1(qp->type)) {
 		u16 pkey = be32_to_cpu(cqe->pkey) & 0xffff;
 
 		ib_find_cached_pkey(&dev->ib_dev, qp->port, pkey,
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index bbfed67e6fc9..1db04775bcb6 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -512,7 +512,6 @@ struct mlx5_ib_qp {
 	/*
 	 * IB/core doesn't store low-level QP types, so
 	 * store both MLX and IBTA types in the field below.
-	 * IB_QPT_DRIVER will be break to DCI/DCT subtypes.
 	 */
 	enum ib_qp_type		type;
 	/* A flag to indicate if there's a new counter is configured
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 87fa0b21d28f..3b5ab0051ea1 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1096,7 +1096,7 @@ static int mlx5_ib_mr_initiator_pfault_handler(
 	opcode = be32_to_cpu(ctrl->opmod_idx_opcode) &
 		 MLX5_WQE_CTRL_OPCODE_MASK;
 
-	if (qp->ibqp.qp_type == IB_QPT_XRC_INI)
+	if (qp->type == IB_QPT_XRC_INI)
 		*wqe += sizeof(struct mlx5_wqe_xrc_seg);
 
 	if (qp->type == IB_QPT_UD || qp->type == MLX5_IB_QPT_DCI) {
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index becd250388af..af2d717ce5f2 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3251,7 +3251,7 @@ int mlx5_ib_destroy_qp(struct ib_qp *qp, struct ib_udata *udata)
 	struct mlx5_ib_dev *dev = to_mdev(qp->device);
 	struct mlx5_ib_qp *mqp = to_mqp(qp);
 
-	if (unlikely(qp->qp_type == IB_QPT_GSI))
+	if (mqp->type == IB_QPT_GSI)
 		return mlx5_ib_destroy_gsi(mqp);
 
 	if (mqp->type == MLX5_IB_QPT_DCT)
@@ -3290,7 +3290,7 @@ static int set_qpc_atomic_flags(struct mlx5_ib_qp *qp,
 	if (access_flags & IB_ACCESS_REMOTE_ATOMIC) {
 		int atomic_mode;
 
-		atomic_mode = get_atomic_mode(dev, qp->ibqp.qp_type);
+		atomic_mode = get_atomic_mode(dev, qp->type);
 		if (atomic_mode < 0)
 			return -EOPNOTSUPP;
 
@@ -3462,10 +3462,10 @@ static int mlx5_set_path(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 
 		ether_addr_copy(MLX5_ADDR_OF(ads, path, rmac_47_32),
 				ah->roce.dmac);
-		if ((qp->ibqp.qp_type == IB_QPT_RC ||
-		     qp->ibqp.qp_type == IB_QPT_UC ||
-		     qp->ibqp.qp_type == IB_QPT_XRC_INI ||
-		     qp->ibqp.qp_type == IB_QPT_XRC_TGT) &&
+		if ((qp->type == IB_QPT_RC ||
+		     qp->type == IB_QPT_UC ||
+		     qp->type == IB_QPT_XRC_INI ||
+		     qp->type == IB_QPT_XRC_TGT) &&
 		    (grh->sgid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP) &&
 		    (attr_mask & IB_QP_DEST_QPN))
 			mlx5_set_path_udp_sport(path, ah,
@@ -3504,7 +3504,7 @@ static int mlx5_set_path(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 		MLX5_SET(ads, path, ack_timeout,
 			 alt ? attr->alt_timeout : attr->timeout);
 
-	if ((qp->ibqp.qp_type == IB_QPT_RAW_PACKET) && qp->sq.wqe_cnt)
+	if ((qp->type == IB_QPT_RAW_PACKET) && qp->sq.wqe_cnt)
 		return modify_raw_packet_eth_prio(dev->mdev,
 						  &qp->raw_packet_qp.sq,
 						  sl & 0xf, qp->ibqp.pd);
@@ -4084,12 +4084,12 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 	    MLX5_CAP_GEN(dev->mdev, init2_lag_tx_port_affinity))
 		optpar |= MLX5_QP_OPTPAR_LAG_TX_AFF;
 
-	if (is_sqp(ibqp->qp_type)) {
+	if (is_sqp(qp->type)) {
 		MLX5_SET(qpc, qpc, mtu, IB_MTU_256);
 		MLX5_SET(qpc, qpc, log_msg_max, 8);
-	} else if ((ibqp->qp_type == IB_QPT_UD &&
+	} else if ((qp->type == IB_QPT_UD &&
 		    !(qp->flags & IB_QP_CREATE_SOURCE_QPN)) ||
-		   ibqp->qp_type == MLX5_IB_QPT_REG_UMR) {
+		   qp->type == MLX5_IB_QPT_REG_UMR) {
 		MLX5_SET(qpc, qpc, mtu, IB_MTU_4096);
 		MLX5_SET(qpc, qpc, log_msg_max, 12);
 	} else if (attr_mask & IB_QP_PATH_MTU) {
@@ -4115,7 +4115,7 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 
 	/* todo implement counter_index functionality */
 
-	if (is_sqp(ibqp->qp_type))
+	if (is_sqp(qp->type))
 		MLX5_SET(ads, pri_path, vhca_port_num, qp->port);
 
 	if (attr_mask & IB_QP_PORT)
@@ -4143,7 +4143,7 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 			goto out;
 	}
 
-	get_cqs(qp->ibqp.qp_type, qp->ibqp.send_cq, qp->ibqp.recv_cq,
+	get_cqs(qp->type, qp->ibqp.send_cq, qp->ibqp.recv_cq,
 		&send_cq, &recv_cq);
 
 	MLX5_SET(qpc, qpc, pd, pd ? pd->pdn : to_mpd(dev->devr.p0)->pdn);
@@ -4222,7 +4222,7 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 	optpar |= ib_mask_to_mlx5_opt(attr_mask);
 	optpar &= opt_mask[mlx5_cur][mlx5_new][mlx5_st];
 
-	if (qp->ibqp.qp_type == IB_QPT_RAW_PACKET ||
+	if (qp->type == IB_QPT_RAW_PACKET ||
 	    qp->flags & IB_QP_CREATE_SOURCE_QPN) {
 		struct mlx5_modify_raw_qp_param raw_qp_param = {};
 
@@ -4295,7 +4295,7 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 	 * entries and reinitialize the QP.
 	 */
 	if (new_state == IB_QPS_RESET &&
-	    !ibqp->uobject && ibqp->qp_type != IB_QPT_XRC_TGT) {
+	    !ibqp->uobject && qp->type != IB_QPT_XRC_TGT) {
 		mlx5_ib_cq_clean(recv_cq, base->mqp.qpn,
 				 ibqp->srq ? to_msrq(ibqp->srq) : NULL);
 		if (send_cq != recv_cq)
@@ -4488,13 +4488,12 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 }
 
 static bool mlx5_ib_modify_qp_allowed(struct mlx5_ib_dev *dev,
-				      struct mlx5_ib_qp *qp,
-				      enum ib_qp_type qp_type)
+				      struct mlx5_ib_qp *qp)
 {
 	if (dev->profile != &raw_eth_profile)
 		return true;
 
-	if (qp_type == IB_QPT_RAW_PACKET || qp_type == MLX5_IB_QPT_REG_UMR)
+	if (qp->type == IB_QPT_RAW_PACKET || qp->type == MLX5_IB_QPT_REG_UMR)
 		return true;
 
 	/* Internal QP used for wc testing, with NOPs in wq */
@@ -4515,7 +4514,7 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	enum ib_qp_state cur_state, new_state;
 	int err = -EINVAL;
 
-	if (!mlx5_ib_modify_qp_allowed(dev, qp, ibqp->qp_type))
+	if (!mlx5_ib_modify_qp_allowed(dev, qp))
 		return -EOPNOTSUPP;
 
 	if (attr_mask & ~(IB_QP_ATTR_STANDARD_BITS | IB_QP_RATE_LIMIT))
@@ -4544,11 +4543,10 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
 	}
 
-	if (unlikely(ibqp->qp_type == IB_QPT_GSI))
+	if (qp->type == IB_QPT_GSI)
 		return mlx5_ib_gsi_modify_qp(ibqp, attr, attr_mask);
 
-	qp_type = (unlikely(ibqp->qp_type == MLX5_IB_QPT_HW_GSI)) ? IB_QPT_GSI :
-								    qp->type;
+	qp_type = (qp->type == MLX5_IB_QPT_HW_GSI) ? IB_QPT_GSI : qp->type;
 
 	if (qp_type == MLX5_IB_QPT_DCT)
 		return mlx5_ib_modify_dct(ibqp, attr, attr_mask, &ucmd, udata);
@@ -4569,7 +4567,7 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		   !ib_modify_qp_is_ok(cur_state, new_state, qp_type,
 				       attr_mask)) {
 		mlx5_ib_dbg(dev, "invalid QP state transition from %d to %d, qp_type %d, attr_mask 0x%x\n",
-			    cur_state, new_state, ibqp->qp_type, attr_mask);
+			    cur_state, new_state, qp->type, attr_mask);
 		goto out;
 	} else if (qp_type == MLX5_IB_QPT_DCI &&
 		   !modify_dci_qp_is_ok(cur_state, new_state, attr_mask)) {
@@ -4842,9 +4840,8 @@ static int query_qp_attr(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	pri_path = MLX5_ADDR_OF(qpc, qpc, primary_address_path);
 	alt_path = MLX5_ADDR_OF(qpc, qpc, secondary_address_path);
 
-	if (qp->ibqp.qp_type == IB_QPT_RC || qp->ibqp.qp_type == IB_QPT_UC ||
-	    qp->ibqp.qp_type == IB_QPT_XRC_INI ||
-	    qp->ibqp.qp_type == IB_QPT_XRC_TGT) {
+	if (qp->type == IB_QPT_RC || qp->type == IB_QPT_UC ||
+	    qp->type == IB_QPT_XRC_INI || qp->type == IB_QPT_XRC_TGT) {
 		to_rdma_ah_attr(dev, &qp_attr->ah_attr, pri_path);
 		to_rdma_ah_attr(dev, &qp_attr->alt_ah_attr, alt_path);
 		qp_attr->alt_pkey_index = MLX5_GET(ads, alt_path, pkey_index);
@@ -4937,7 +4934,7 @@ int mlx5_ib_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	if (ibqp->rwq_ind_tbl)
 		return -ENOSYS;
 
-	if (unlikely(ibqp->qp_type == IB_QPT_GSI))
+	if (qp->type == IB_QPT_GSI)
 		return mlx5_ib_gsi_query_qp(ibqp, qp_attr, qp_attr_mask,
 					    qp_init_attr);
 
@@ -4951,7 +4948,7 @@ int mlx5_ib_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 
 	mutex_lock(&qp->mutex);
 
-	if (qp->ibqp.qp_type == IB_QPT_RAW_PACKET ||
+	if (qp->type == IB_QPT_RAW_PACKET ||
 	    qp->flags & IB_QP_CREATE_SOURCE_QPN) {
 		err = query_raw_packet_qp_state(dev, qp, &raw_packet_qp_state);
 		if (err)
@@ -4978,7 +4975,7 @@ int mlx5_ib_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 		qp_attr->cap.max_send_sge = 0;
 	}
 
-	qp_init_attr->qp_type = ibqp->qp_type;
+	qp_init_attr->qp_type = qp->type;
 	qp_init_attr->recv_cq = ibqp->recv_cq;
 	qp_init_attr->send_cq = ibqp->send_cq;
 	qp_init_attr->srq = ibqp->srq;
diff --git a/drivers/infiniband/hw/mlx5/wr.c b/drivers/infiniband/hw/mlx5/wr.c
index 34d8d59bbff1..8ea4532c2ed1 100644
--- a/drivers/infiniband/hw/mlx5/wr.c
+++ b/drivers/infiniband/hw/mlx5/wr.c
@@ -1312,7 +1312,7 @@ int mlx5_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 	struct mlx5_wqe_ctrl_seg *ctrl = NULL;  /* compiler warning */
 	struct mlx5_ib_dev *dev = to_mdev(ibqp->device);
 	struct mlx5_core_dev *mdev = dev->mdev;
-	struct mlx5_ib_qp *qp;
+	struct mlx5_ib_qp *qp = to_mqp(ibqp);
 	struct mlx5_wqe_xrc_seg *xrc;
 	struct mlx5_bf *bf;
 	void *cur_edge;
@@ -1333,10 +1333,9 @@ int mlx5_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 		return -EIO;
 	}
 
-	if (unlikely(ibqp->qp_type == IB_QPT_GSI))
+	if (qp->type == IB_QPT_GSI)
 		return mlx5_ib_gsi_post_send(ibqp, wr, bad_wr);
 
-	qp = to_mqp(ibqp);
 	bf = &qp->bf;
 
 	spin_lock_irqsave(&qp->sq.lock, flags);
@@ -1381,7 +1380,7 @@ int mlx5_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 			}
 		}
 
-		switch (ibqp->qp_type) {
+		switch (qp->type) {
 		case IB_QPT_XRC_INI:
 			xrc = seg;
 			seg += sizeof(*xrc);
@@ -1510,7 +1509,7 @@ int mlx5_ib_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 		return -EIO;
 	}
 
-	if (unlikely(ibqp->qp_type == IB_QPT_GSI))
+	if (qp->type == IB_QPT_GSI)
 		return mlx5_ib_gsi_post_recv(ibqp, wr, bad_wr);
 
 	spin_lock_irqsave(&qp->rq.lock, flags);
-- 
2.31.1

