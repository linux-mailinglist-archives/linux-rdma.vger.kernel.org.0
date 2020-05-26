Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DB41E2173
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2020 13:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388982AbgEZLzN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 May 2020 07:55:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388967AbgEZLzN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 May 2020 07:55:13 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8888F20663;
        Tue, 26 May 2020 11:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590494112;
        bh=G8PNIqQcf7DvRn4lIYcoexs4nWDEOu87RFjcXMg9t/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dFT790w4cO8TTruBPcgEmDDqdjN2L8y81crJzNRdjmWgPUbuq+2JsIRe48v0gy4Go
         tvOMTdha4VSmj/NxQt8S5G0ubKEpcrDK6oMPHm712gwBXrkFEBuCm2eX5chTqV1vxL
         EYoWFtycOKiQJJiqCZ5AksdO36fKM/QVrYg+o82s=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH rdma-next v3 6/8] RDMA/mlx5: Convert modify QP to use MLX5_SET macros
Date:   Tue, 26 May 2020 14:54:38 +0300
Message-Id: <20200526115440.205922-7-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526115440.205922-1-leon@kernel.org>
References: <20200526115440.205922-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Instead of hand crafted mlx5_qp_context and mlx5_qp_path
use common MLX5_SET() macros.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Reviewed-by: Mark Zhang <markz@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 203 +++++++++++++++-----------------
 include/linux/mlx5/qp.h         |  66 -----------
 2 files changed, 97 insertions(+), 172 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 5099866533dd..a24176a8ec83 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3028,14 +3028,13 @@ int mlx5_ib_destroy_qp(struct ib_qp *qp, struct ib_udata *udata)
 	return 0;
 }

-static int to_mlx5_access_flags(struct mlx5_ib_qp *qp,
-				const struct ib_qp_attr *attr,
-				int attr_mask, __be32 *hw_access_flags_be)
+static int set_qpc_atomic_flags(struct mlx5_ib_qp *qp,
+				const struct ib_qp_attr *attr, int attr_mask,
+				void *qpc)
 {
-	u8 dest_rd_atomic;
-	u32 access_flags, hw_access_flags = 0;
-
 	struct mlx5_ib_dev *dev = to_mdev(qp->ibqp.device);
+	u8 dest_rd_atomic;
+	u32 access_flags;

 	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC)
 		dest_rd_atomic = attr->max_dest_rd_atomic;
@@ -3050,8 +3049,8 @@ static int to_mlx5_access_flags(struct mlx5_ib_qp *qp,
 	if (!dest_rd_atomic)
 		access_flags &= IB_ACCESS_REMOTE_WRITE;

-	if (access_flags & IB_ACCESS_REMOTE_READ)
-		hw_access_flags |= MLX5_QP_BIT_RRE;
+	MLX5_SET(qpc, qpc, rre, !!(access_flags & IB_ACCESS_REMOTE_READ));
+
 	if (access_flags & IB_ACCESS_REMOTE_ATOMIC) {
 		int atomic_mode;

@@ -3059,15 +3058,11 @@ static int to_mlx5_access_flags(struct mlx5_ib_qp *qp,
 		if (atomic_mode < 0)
 			return -EOPNOTSUPP;

-		hw_access_flags |= MLX5_QP_BIT_RAE;
-		hw_access_flags |= atomic_mode << MLX5_ATOMIC_MODE_OFFSET;
+		MLX5_SET(qpc, qpc, rae, 1);
+		MLX5_SET(qpc, qpc, atomic_mode, atomic_mode);
 	}

-	if (access_flags & IB_ACCESS_REMOTE_WRITE)
-		hw_access_flags |= MLX5_QP_BIT_RWE;
-
-	*hw_access_flags_be = cpu_to_be32(hw_access_flags);
-
+	MLX5_SET(qpc, qpc, rwe, !!(access_flags & IB_ACCESS_REMOTE_WRITE));
 	return 0;
 }

@@ -3147,26 +3142,22 @@ static int modify_raw_packet_tx_affinity(struct mlx5_core_dev *dev,
 	return err;
 }

-static void mlx5_set_path_udp_sport(struct mlx5_qp_path *path,
-				    const struct rdma_ah_attr *ah,
+static void mlx5_set_path_udp_sport(void *path, const struct rdma_ah_attr *ah,
 				    u32 lqpn, u32 rqpn)

 {
 	u32 fl = ah->grh.flow_label;
-	u16 sport;

 	if (!fl)
 		fl = rdma_calc_flow_label(lqpn, rqpn);

-	sport = rdma_flow_label_to_udp_sport(fl);
-	path->udp_sport = cpu_to_be16(sport);
+	MLX5_SET(ads, path, udp_sport, rdma_flow_label_to_udp_sport(fl));
 }

 static int mlx5_set_path(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
-			 const struct rdma_ah_attr *ah,
-			 struct mlx5_qp_path *path, u8 port, int attr_mask,
-			 u32 path_flags, const struct ib_qp_attr *attr,
-			 bool alt)
+			 const struct rdma_ah_attr *ah, void *path, u8 port,
+			 int attr_mask, u32 path_flags,
+			 const struct ib_qp_attr *attr, bool alt)
 {
 	const struct ib_global_route *grh = rdma_ah_read_grh(ah);
 	int err;
@@ -3175,8 +3166,8 @@ static int mlx5_set_path(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	u8 sl = rdma_ah_get_sl(ah);

 	if (attr_mask & IB_QP_PKEY_INDEX)
-		path->pkey_index = cpu_to_be16(alt ? attr->alt_pkey_index :
-						     attr->pkey_index);
+		MLX5_SET(ads, path, pkey_index,
+			 alt ? attr->alt_pkey_index : attr->pkey_index);

 	if (ah_flags & IB_AH_GRH) {
 		if (grh->sgid_index >=
@@ -3192,7 +3183,8 @@ static int mlx5_set_path(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 		if (!(ah_flags & IB_AH_GRH))
 			return -EINVAL;

-		memcpy(path->rmac, ah->roce.dmac, sizeof(ah->roce.dmac));
+		ether_addr_copy(MLX5_ADDR_OF(ads, path, rmac_47_32),
+				ah->roce.dmac);
 		if ((qp->ibqp.qp_type == IB_QPT_RC ||
 		     qp->ibqp.qp_type == IB_QPT_UC ||
 		     qp->ibqp.qp_type == IB_QPT_XRC_INI ||
@@ -3202,38 +3194,38 @@ static int mlx5_set_path(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 			mlx5_set_path_udp_sport(path, ah,
 						qp->ibqp.qp_num,
 						attr->dest_qp_num);
-		path->dci_cfi_prio_sl = (sl & 0x7) << 4;
+		MLX5_SET(ads, path, eth_prio, sl & 0x7);
 		gid_type = ah->grh.sgid_attr->gid_type;
 		if (gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP)
-			path->ecn_dscp = (grh->traffic_class >> 2) & 0x3f;
+			MLX5_SET(ads, path, dscp, grh->traffic_class >> 2);
 	} else {
-		path->fl_free_ar = (path_flags & MLX5_PATH_FLAG_FL) ? 0x80 : 0;
-		path->fl_free_ar |=
-			(path_flags & MLX5_PATH_FLAG_FREE_AR) ? 0x40 : 0;
-		path->rlid = cpu_to_be16(rdma_ah_get_dlid(ah));
-		path->grh_mlid = rdma_ah_get_path_bits(ah) & 0x7f;
-		if (ah_flags & IB_AH_GRH)
-			path->grh_mlid	|= 1 << 7;
-		path->dci_cfi_prio_sl = sl & 0xf;
+		MLX5_SET(ads, path, fl, !!(path_flags & MLX5_PATH_FLAG_FL));
+		MLX5_SET(ads, path, free_ar,
+			 !!(path_flags & MLX5_PATH_FLAG_FREE_AR));
+		MLX5_SET(ads, path, rlid, rdma_ah_get_dlid(ah));
+		MLX5_SET(ads, path, mlid, rdma_ah_get_path_bits(ah));
+		MLX5_SET(ads, path, grh, !!(ah_flags & IB_AH_GRH));
+		MLX5_SET(ads, path, sl, sl);
 	}

 	if (ah_flags & IB_AH_GRH) {
-		path->mgid_index = grh->sgid_index;
-		path->hop_limit  = grh->hop_limit;
-		path->tclass_flowlabel =
-			cpu_to_be32((grh->traffic_class << 20) |
-				    (grh->flow_label));
-		memcpy(path->rgid, grh->dgid.raw, 16);
+		MLX5_SET(ads, path, src_addr_index, grh->sgid_index);
+		MLX5_SET(ads, path, hop_limit, grh->hop_limit);
+		MLX5_SET(ads, path, tclass, grh->traffic_class);
+		MLX5_SET(ads, path, flow_label, grh->flow_label);
+		memcpy(MLX5_ADDR_OF(ads, path, rgid_rip), grh->dgid.raw,
+		       sizeof(grh->dgid.raw));
 	}

 	err = ib_rate_to_mlx5(dev, rdma_ah_get_static_rate(ah));
 	if (err < 0)
 		return err;
-	path->static_rate = err;
-	path->port = port;
+	MLX5_SET(ads, path, stat_rate, err);
+	MLX5_SET(ads, path, vhca_port_num, port);

 	if (attr_mask & IB_QP_TIMEOUT)
-		path->ackto_lt = (alt ? attr->alt_timeout : attr->timeout) << 3;
+		MLX5_SET(ads, path, ack_timeout,
+			 alt ? attr->alt_timeout : attr->timeout);

 	if ((qp->ibqp.qp_type == IB_QPT_RAW_PACKET) && qp->sq.wqe_cnt)
 		return modify_raw_packet_eth_prio(dev->mdev,
@@ -3759,9 +3751,9 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 	struct mlx5_ib_qp *qp = to_mqp(ibqp);
 	struct mlx5_ib_qp_base *base = &qp->trans_qp.base;
 	struct mlx5_ib_cq *send_cq, *recv_cq;
-	struct mlx5_qp_context *context;
 	struct mlx5_ib_pd *pd;
 	enum mlx5_qp_state mlx5_cur, mlx5_new;
+	void *qpc, *pri_path, *alt_path;
 	enum mlx5_qp_optpar optpar = 0;
 	u32 set_id = 0;
 	int mlx5_st;
@@ -3773,25 +3765,25 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 	if (mlx5_st < 0)
 		return -EINVAL;

-	context = kzalloc(sizeof(*context), GFP_KERNEL);
-	if (!context)
+	qpc = kzalloc(MLX5_ST_SZ_BYTES(qpc), GFP_KERNEL);
+	if (!qpc)
 		return -ENOMEM;

 	pd = to_mpd(qp->ibqp.pd);
-	context->flags = cpu_to_be32(mlx5_st << 16);
+	MLX5_SET(qpc, qpc, st, mlx5_st);

 	if (!(attr_mask & IB_QP_PATH_MIG_STATE)) {
-		context->flags |= cpu_to_be32(MLX5_QP_PM_MIGRATED << 11);
+		MLX5_SET(qpc, qpc, pm_state, MLX5_QP_PM_MIGRATED);
 	} else {
 		switch (attr->path_mig_state) {
 		case IB_MIG_MIGRATED:
-			context->flags |= cpu_to_be32(MLX5_QP_PM_MIGRATED << 11);
+			MLX5_SET(qpc, qpc, pm_state, MLX5_QP_PM_MIGRATED);
 			break;
 		case IB_MIG_REARM:
-			context->flags |= cpu_to_be32(MLX5_QP_PM_REARM << 11);
+			MLX5_SET(qpc, qpc, pm_state, MLX5_QP_PM_REARM);
 			break;
 		case IB_MIG_ARMED:
-			context->flags |= cpu_to_be32(MLX5_QP_PM_ARMED << 11);
+			MLX5_SET(qpc, qpc, pm_state, MLX5_QP_PM_ARMED);
 			break;
 		}
 	}
@@ -3799,19 +3791,20 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 	tx_affinity = get_tx_affinity(ibqp, attr, attr_mask,
 				      cur_state == IB_QPS_RESET &&
 				      new_state == IB_QPS_INIT, udata);
-	if (tx_affinity) {
-		context->flags |= cpu_to_be32(tx_affinity << 24);
-		if (new_state == IB_QPS_RTR &&
-		    MLX5_CAP_GEN(dev->mdev, init2_lag_tx_port_affinity))
-			optpar |= MLX5_QP_OPTPAR_LAG_TX_AFF;
-	}
+
+	MLX5_SET(qpc, qpc, lag_tx_port_affinity, tx_affinity);
+	if (tx_affinity && new_state == IB_QPS_RTR &&
+	    MLX5_CAP_GEN(dev->mdev, init2_lag_tx_port_affinity))
+		optpar |= MLX5_QP_OPTPAR_LAG_TX_AFF;

 	if (is_sqp(ibqp->qp_type)) {
-		context->mtu_msgmax = (IB_MTU_256 << 5) | 8;
+		MLX5_SET(qpc, qpc, mtu, IB_MTU_256);
+		MLX5_SET(qpc, qpc, log_msg_max, 8);
 	} else if ((ibqp->qp_type == IB_QPT_UD &&
 		    !(qp->flags & IB_QP_CREATE_SOURCE_QPN)) ||
 		   ibqp->qp_type == MLX5_IB_QPT_REG_UMR) {
-		context->mtu_msgmax = (IB_MTU_4096 << 5) | 12;
+		MLX5_SET(qpc, qpc, mtu, IB_MTU_4096);
+		MLX5_SET(qpc, qpc, log_msg_max, 12);
 	} else if (attr_mask & IB_QP_PATH_MTU) {
 		if (attr->path_mtu < IB_MTU_256 ||
 		    attr->path_mtu > IB_MTU_4096) {
@@ -3819,40 +3812,45 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 			err = -EINVAL;
 			goto out;
 		}
-		context->mtu_msgmax = (attr->path_mtu << 5) |
-				      (u8)MLX5_CAP_GEN(dev->mdev, log_max_msg);
+		MLX5_SET(qpc, qpc, mtu, attr->path_mtu);
+		MLX5_SET(qpc, qpc, log_msg_max,
+			 MLX5_CAP_GEN(dev->mdev, log_max_msg));
 	}

 	if (attr_mask & IB_QP_DEST_QPN)
-		context->log_pg_sz_remote_qpn = cpu_to_be32(attr->dest_qp_num);
+		MLX5_SET(qpc, qpc, remote_qpn, attr->dest_qp_num);
+
+	pri_path = MLX5_ADDR_OF(qpc, qpc, primary_address_path);
+	alt_path = MLX5_ADDR_OF(qpc, qpc, secondary_address_path);

 	if (attr_mask & IB_QP_PKEY_INDEX)
-		context->pri_path.pkey_index = cpu_to_be16(attr->pkey_index);
+		MLX5_SET(ads, pri_path, pkey_index, attr->pkey_index);

 	/* todo implement counter_index functionality */

 	if (is_sqp(ibqp->qp_type))
-		context->pri_path.port = qp->port;
+		MLX5_SET(ads, pri_path, vhca_port_num, qp->port);

 	if (attr_mask & IB_QP_PORT)
-		context->pri_path.port = attr->port_num;
+		MLX5_SET(ads, pri_path, vhca_port_num, attr->port_num);

 	if (attr_mask & IB_QP_AV) {
-		err = mlx5_set_path(dev, qp, &attr->ah_attr, &context->pri_path,
-				    attr_mask & IB_QP_PORT ? attr->port_num : qp->port,
+		err = mlx5_set_path(dev, qp, &attr->ah_attr, pri_path,
+				    attr_mask & IB_QP_PORT ? attr->port_num :
+							     qp->port,
 				    attr_mask, 0, attr, false);
 		if (err)
 			goto out;
 	}

 	if (attr_mask & IB_QP_TIMEOUT)
-		context->pri_path.ackto_lt |= attr->timeout << 3;
+		MLX5_SET(ads, pri_path, ack_timeout, attr->timeout);

 	if (attr_mask & IB_QP_ALT_PATH) {
-		err = mlx5_set_path(dev, qp, &attr->alt_ah_attr,
-				    &context->alt_path,
+		err = mlx5_set_path(dev, qp, &attr->alt_ah_attr, alt_path,
 				    attr->alt_port_num,
-				    attr_mask | IB_QP_PKEY_INDEX | IB_QP_TIMEOUT,
+				    attr_mask | IB_QP_PKEY_INDEX |
+					    IB_QP_TIMEOUT,
 				    0, attr, true);
 		if (err)
 			goto out;
@@ -3861,53 +3859,47 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 	get_cqs(qp->ibqp.qp_type, qp->ibqp.send_cq, qp->ibqp.recv_cq,
 		&send_cq, &recv_cq);

-	context->flags_pd = cpu_to_be32(pd ? pd->pdn : to_mpd(dev->devr.p0)->pdn);
-	context->cqn_send = send_cq ? cpu_to_be32(send_cq->mcq.cqn) : 0;
-	context->cqn_recv = recv_cq ? cpu_to_be32(recv_cq->mcq.cqn) : 0;
-	context->params1  = cpu_to_be32(MLX5_IB_ACK_REQ_FREQ << 28);
+	MLX5_SET(qpc, qpc, pd, pd ? pd->pdn : to_mpd(dev->devr.p0)->pdn);
+	if (send_cq)
+		MLX5_SET(qpc, qpc, cqn_snd, send_cq->mcq.cqn);
+	if (recv_cq)
+		MLX5_SET(qpc, qpc, cqn_rcv, recv_cq->mcq.cqn);
+
+	MLX5_SET(qpc, qpc, log_ack_req_freq, MLX5_IB_ACK_REQ_FREQ);

 	if (attr_mask & IB_QP_RNR_RETRY)
-		context->params1 |= cpu_to_be32(attr->rnr_retry << 13);
+		MLX5_SET(qpc, qpc, rnr_retry, attr->rnr_retry);

 	if (attr_mask & IB_QP_RETRY_CNT)
-		context->params1 |= cpu_to_be32(attr->retry_cnt << 16);
+		MLX5_SET(qpc, qpc, retry_count, attr->retry_cnt);

-	if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC) {
-		if (attr->max_rd_atomic)
-			context->params1 |=
-				cpu_to_be32(fls(attr->max_rd_atomic - 1) << 21);
-	}
+	if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC && attr->max_rd_atomic)
+		MLX5_SET(qpc, qpc, log_sra_max, ilog2(attr->max_rd_atomic));

 	if (attr_mask & IB_QP_SQ_PSN)
-		context->next_send_psn = cpu_to_be32(attr->sq_psn);
+		MLX5_SET(qpc, qpc, next_send_psn, attr->sq_psn);

-	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC) {
-		if (attr->max_dest_rd_atomic)
-			context->params2 |=
-				cpu_to_be32(fls(attr->max_dest_rd_atomic - 1) << 21);
-	}
+	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC && attr->max_dest_rd_atomic)
+		MLX5_SET(qpc, qpc, log_rra_max,
+			 ilog2(attr->max_dest_rd_atomic));

 	if (attr_mask & (IB_QP_ACCESS_FLAGS | IB_QP_MAX_DEST_RD_ATOMIC)) {
-		__be32 access_flags;
-
-		err = to_mlx5_access_flags(qp, attr, attr_mask, &access_flags);
+		err = set_qpc_atomic_flags(qp, attr, attr_mask, qpc);
 		if (err)
 			goto out;
-
-		context->params2 |= access_flags;
 	}

 	if (attr_mask & IB_QP_MIN_RNR_TIMER)
-		context->rnr_nextrecvpsn |= cpu_to_be32(attr->min_rnr_timer << 24);
+		MLX5_SET(qpc, qpc, min_rnr_nak, attr->min_rnr_timer);

 	if (attr_mask & IB_QP_RQ_PSN)
-		context->rnr_nextrecvpsn |= cpu_to_be32(attr->rq_psn);
+		MLX5_SET(qpc, qpc, next_rcv_psn, attr->rq_psn);

 	if (attr_mask & IB_QP_QKEY)
-		context->qkey = cpu_to_be32(attr->qkey);
+		MLX5_SET(qpc, qpc, q_key, attr->qkey);

 	if (qp->rq.wqe_cnt && cur_state == IB_QPS_RESET && new_state == IB_QPS_INIT)
-		context->db_rec_addr = cpu_to_be64(qp->db.dma);
+		MLX5_SET64(qpc, qpc, dbr_addr, qp->db.dma);

 	if (cur_state == IB_QPS_RESET && new_state == IB_QPS_INIT) {
 		u8 port_num = (attr_mask & IB_QP_PORT ? attr->port_num :
@@ -3921,15 +3913,14 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 			set_id = ibqp->counter->id;
 		else
 			set_id = mlx5_ib_get_counters_id(dev, port_num);
-		context->qp_counter_set_usr_page |=
-			cpu_to_be32(set_id << 24);
+		MLX5_SET(qpc, qpc, counter_set_id, set_id);
 	}

 	if (!ibqp->uobject && cur_state == IB_QPS_RESET && new_state == IB_QPS_INIT)
-		context->sq_crq_size |= cpu_to_be16(1 << 4);
+		MLX5_SET(qpc, qpc, rlky, 1);

 	if (qp->flags & MLX5_IB_QP_CREATE_SQPN_QP1)
-		context->deth_sqpn = cpu_to_be32(1);
+		MLX5_SET(qpc, qpc, deth_sqpn, 1);

 	mlx5_cur = to_mlx5_state(cur_state);
 	mlx5_new = to_mlx5_state(new_state);
@@ -3987,7 +3978,7 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,

 		err = modify_raw_packet_qp(dev, qp, &raw_qp_param, tx_affinity);
 	} else {
-		err = mlx5_core_qp_modify(dev, op, optpar, context, &base->mqp);
+		err = mlx5_core_qp_modify(dev, op, optpar, qpc, &base->mqp);
 	}

 	if (err)
@@ -4034,7 +4025,7 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 	}

 out:
-	kfree(context);
+	kfree(qpc);
 	return err;
 }

diff --git a/include/linux/mlx5/qp.h b/include/linux/mlx5/qp.h
index def601199a1a..b8992b861ae6 100644
--- a/include/linux/mlx5/qp.h
+++ b/include/linux/mlx5/qp.h
@@ -495,72 +495,6 @@ struct mlx5_core_dct {
 	struct completion	drained;
 };

-struct mlx5_qp_path {
-	u8			fl_free_ar;
-	u8			rsvd3;
-	__be16			pkey_index;
-	u8			rsvd0;
-	u8			grh_mlid;
-	__be16			rlid;
-	u8			ackto_lt;
-	u8			mgid_index;
-	u8			static_rate;
-	u8			hop_limit;
-	__be32			tclass_flowlabel;
-	union {
-		u8		rgid[16];
-		u8		rip[16];
-	};
-	u8			f_dscp_ecn_prio;
-	u8			ecn_dscp;
-	__be16			udp_sport;
-	u8			dci_cfi_prio_sl;
-	u8			port;
-	u8			rmac[6];
-};
-
-/* FIXME: use mlx5_ifc.h qpc */
-struct mlx5_qp_context {
-	__be32			flags;
-	__be32			flags_pd;
-	u8			mtu_msgmax;
-	u8			rq_size_stride;
-	__be16			sq_crq_size;
-	__be32			qp_counter_set_usr_page;
-	__be32			wire_qpn;
-	__be32			log_pg_sz_remote_qpn;
-	struct			mlx5_qp_path pri_path;
-	struct			mlx5_qp_path alt_path;
-	__be32			params1;
-	u8			reserved2[4];
-	__be32			next_send_psn;
-	__be32			cqn_send;
-	__be32			deth_sqpn;
-	u8			reserved3[4];
-	__be32			last_acked_psn;
-	__be32			ssn;
-	__be32			params2;
-	__be32			rnr_nextrecvpsn;
-	__be32			xrcd;
-	__be32			cqn_recv;
-	__be64			db_rec_addr;
-	__be32			qkey;
-	__be32			rq_type_srqn;
-	__be32			rmsn;
-	__be16			hw_sq_wqe_counter;
-	__be16			sw_sq_wqe_counter;
-	__be16			hw_rcyclic_byte_counter;
-	__be16			hw_rq_counter;
-	__be16			sw_rcyclic_byte_counter;
-	__be16			sw_rq_counter;
-	u8			rsvd0[5];
-	u8			cgs;
-	u8			cs_req;
-	u8			cs_res;
-	__be64			dc_access_key;
-	u8			rsvd1[24];
-};
-
 int mlx5_debug_qp_add(struct mlx5_core_dev *dev, struct mlx5_core_qp *qp);
 void mlx5_debug_qp_remove(struct mlx5_core_dev *dev, struct mlx5_core_qp *qp);

--
2.26.2

