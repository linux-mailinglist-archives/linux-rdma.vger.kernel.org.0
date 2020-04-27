Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055271BA8DB
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 17:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgD0PsZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 11:48:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728361AbgD0PsY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 11:48:24 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F031A206BF;
        Mon, 27 Apr 2020 15:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588002503;
        bh=/Gp6F3EFSoR8QHnBUkGZ5QInQ881ujF9uUIogTZpbaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HD7lyrVFkB+I6hIdgaqwZOV2W+utBoJeAgVdznwY6UXL7iofzHZeZGbqFbvZnm11a
         D/1kX8wn3+P/C3daXeyQbZE7kcLKzMzVIHQD/0NmPyehKyQCvsc4Os+G8c8qK1skTY
         zGcd3YDMOYedUELl6g72DMH7u4DU4gwVwr2Udh5E=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aharon Landau <aharonl@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1 28/36] RDMA/mlx5: Separate to user/kernel create QP flows
Date:   Mon, 27 Apr 2020 18:46:28 +0300
Message-Id: <20200427154636.381474-29-leon@kernel.org>
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

The kernel and user create QP flows have very little common code,
separate them to simplify the future work of creating per-type
create_*_qp() functions.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 205 ++++++++++++++++++++++++--------
 1 file changed, 156 insertions(+), 49 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 8890c172f7e5..d5061001217e 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -911,12 +911,12 @@ static int adjust_bfregn(struct mlx5_ib_dev *dev,
 				bfregn % MLX5_NON_FP_BFREGS_PER_UAR;
 }
 
-static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
-			  struct mlx5_ib_qp *qp, struct ib_udata *udata,
-			  struct ib_qp_init_attr *attr, u32 **in,
-			  struct mlx5_ib_create_qp_resp *resp, int *inlen,
-			  struct mlx5_ib_qp_base *base,
-			  struct mlx5_ib_create_qp *ucmd)
+static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
+			   struct mlx5_ib_qp *qp, struct ib_udata *udata,
+			   struct ib_qp_init_attr *attr, u32 **in,
+			   struct mlx5_ib_create_qp_resp *resp, int *inlen,
+			   struct mlx5_ib_qp_base *base,
+			   struct mlx5_ib_create_qp *ucmd)
 {
 	struct mlx5_ib_ucontext *context;
 	struct mlx5_ib_ubuffer *ubuffer = &base->ubuffer;
@@ -1083,11 +1083,10 @@ static void *get_sq_edge(struct mlx5_ib_wq *sq, u32 idx)
 	return fragment_end + MLX5_SEND_WQE_BB;
 }
 
-static int create_kernel_qp(struct mlx5_ib_dev *dev,
-			    struct ib_qp_init_attr *init_attr,
-			    struct mlx5_ib_qp *qp,
-			    u32 **in, int *inlen,
-			    struct mlx5_ib_qp_base *base)
+static int _create_kernel_qp(struct mlx5_ib_dev *dev,
+			     struct ib_qp_init_attr *init_attr,
+			     struct mlx5_ib_qp *qp, u32 **in, int *inlen,
+			     struct mlx5_ib_qp_base *base)
 {
 	int uar_index;
 	void *qpc;
@@ -1987,11 +1986,11 @@ static int create_xrc_tgt_qp(struct mlx5_ib_dev *dev,
 	return 0;
 }
 
-static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
-			    struct ib_qp_init_attr *init_attr,
-			    struct mlx5_ib_create_qp *ucmd,
-			    struct ib_udata *udata, struct mlx5_ib_qp *qp,
-			    u32 uidx)
+static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
+			  struct ib_qp_init_attr *init_attr,
+			  struct mlx5_ib_create_qp *ucmd,
+			  struct ib_udata *udata, struct mlx5_ib_qp *qp,
+			  u32 uidx)
 {
 	struct mlx5_ib_resources *devr = &dev->devr;
 	int inlen = MLX5_ST_SZ_BYTES(create_qp_in);
@@ -2032,28 +2031,15 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		return err;
 	}
 
-	if (udata) {
-		__u32 max_wqes = 1 << MLX5_CAP_GEN(mdev, log_max_qp_sz);
+	if (ucmd->rq_wqe_shift != qp->rq.wqe_shift ||
+	    ucmd->rq_wqe_count != qp->rq.wqe_cnt)
+		return -EINVAL;
 
-		mlx5_ib_dbg(dev, "requested sq_wqe_count (%d)\n",
-			    ucmd->sq_wqe_count);
-		if (ucmd->rq_wqe_shift != qp->rq.wqe_shift ||
-		    ucmd->rq_wqe_count != qp->rq.wqe_cnt) {
-			mlx5_ib_dbg(dev, "invalid rq params\n");
-			return -EINVAL;
-		}
-		if (ucmd->sq_wqe_count > max_wqes) {
-			mlx5_ib_dbg(
-				dev,
-				"requested sq_wqe_count (%d) > max allowed (%d)\n",
-				ucmd->sq_wqe_count, max_wqes);
-			return -EINVAL;
-		}
-		err = create_user_qp(dev, pd, qp, udata, init_attr, &in, &resp,
-				     &inlen, base, ucmd);
-	} else
-		err = create_kernel_qp(dev, init_attr, qp, &in, &inlen, base);
+	if (ucmd->sq_wqe_count > (1 << MLX5_CAP_GEN(mdev, log_max_qp_sz)))
+		return -EINVAL;
 
+	err = _create_user_qp(dev, pd, qp, udata, init_attr, &in, &resp, &inlen,
+			      base, ucmd);
 	if (err)
 		return err;
 
@@ -2064,12 +2050,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 
 	MLX5_SET(qpc, qpc, st, mlx5_st);
 	MLX5_SET(qpc, qpc, pm_state, MLX5_QP_PM_MIGRATED);
-
-	if (init_attr->qp_type != MLX5_IB_QPT_REG_UMR)
-		MLX5_SET(qpc, qpc, pd, to_mpd(pd ? pd : devr->p0)->pdn);
-	else
-		MLX5_SET(qpc, qpc, latency_sensitive, 1);
-
+	MLX5_SET(qpc, qpc, pd, to_mpd(pd)->pdn);
 
 	if (qp->flags_en & MLX5_QP_FLAG_SIGNATURE)
 		MLX5_SET(qpc, qpc, wq_signature, 1);
@@ -2145,10 +2126,6 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	if (MLX5_CAP_GEN(mdev, cqe_version) == MLX5_CQE_VERSION_V1)
 		MLX5_SET(qpc, qpc, user_index, uidx);
 
-	/* we use IB_QP_CREATE_IPOIB_UD_LSO to indicates ipoib qp */
-	if (qp->flags & IB_QP_CREATE_IPOIB_UD_LSO)
-		MLX5_SET(qpc, qpc, ulp_stateless_offload_mode, 1);
-
 	if (qp->flags & IB_QP_CREATE_PCI_WRITE_END_PADDING &&
 	    init_attr->qp_type != IB_QPT_RAW_PACKET) {
 		MLX5_SET(qpc, qpc, end_padding_mode,
@@ -2200,6 +2177,133 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	return err;
 }
 
+static int create_kernel_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
+			    struct ib_qp_init_attr *attr, struct mlx5_ib_qp *qp,
+			    u32 uidx)
+{
+	struct mlx5_ib_resources *devr = &dev->devr;
+	int inlen = MLX5_ST_SZ_BYTES(create_qp_in);
+	struct mlx5_core_dev *mdev = dev->mdev;
+	struct mlx5_ib_cq *send_cq;
+	struct mlx5_ib_cq *recv_cq;
+	unsigned long flags;
+	struct mlx5_ib_qp_base *base;
+	int mlx5_st;
+	void *qpc;
+	u32 *in;
+	int err;
+
+	mutex_init(&qp->mutex);
+	spin_lock_init(&qp->sq.lock);
+	spin_lock_init(&qp->rq.lock);
+
+	mlx5_st = to_mlx5_st(qp->type);
+	if (mlx5_st < 0)
+		return -EINVAL;
+
+	if (attr->sq_sig_type == IB_SIGNAL_ALL_WR)
+		qp->sq_signal_bits = MLX5_WQE_CTRL_CQ_UPDATE;
+
+	base = &qp->trans_qp.base;
+
+	qp->has_rq = qp_has_rq(attr);
+	err = set_rq_size(dev, &attr->cap, qp->has_rq, qp, NULL);
+	if (err) {
+		mlx5_ib_dbg(dev, "err %d\n", err);
+		return err;
+	}
+
+	err = _create_kernel_qp(dev, attr, qp, &in, &inlen, base);
+	if (err)
+		return err;
+
+	if (is_sqp(attr->qp_type))
+		qp->port = attr->port_num;
+
+	qpc = MLX5_ADDR_OF(create_qp_in, in, qpc);
+
+	MLX5_SET(qpc, qpc, st, mlx5_st);
+	MLX5_SET(qpc, qpc, pm_state, MLX5_QP_PM_MIGRATED);
+
+	if (attr->qp_type != MLX5_IB_QPT_REG_UMR)
+		MLX5_SET(qpc, qpc, pd, to_mpd(pd ? pd : devr->p0)->pdn);
+	else
+		MLX5_SET(qpc, qpc, latency_sensitive, 1);
+
+
+	if (qp->flags & IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK)
+		MLX5_SET(qpc, qpc, block_lb_mc, 1);
+
+	if (qp->rq.wqe_cnt) {
+		MLX5_SET(qpc, qpc, log_rq_stride, qp->rq.wqe_shift - 4);
+		MLX5_SET(qpc, qpc, log_rq_size, ilog2(qp->rq.wqe_cnt));
+	}
+
+	MLX5_SET(qpc, qpc, rq_type, get_rx_type(qp, attr));
+
+	if (qp->sq.wqe_cnt)
+		MLX5_SET(qpc, qpc, log_sq_size, ilog2(qp->sq.wqe_cnt));
+	else
+		MLX5_SET(qpc, qpc, no_sq, 1);
+
+	if (attr->srq) {
+		MLX5_SET(qpc, qpc, xrcd, to_mxrcd(devr->x0)->xrcdn);
+		MLX5_SET(qpc, qpc, srqn_rmpn_xrqn,
+			 to_msrq(attr->srq)->msrq.srqn);
+	} else {
+		MLX5_SET(qpc, qpc, xrcd, to_mxrcd(devr->x1)->xrcdn);
+		MLX5_SET(qpc, qpc, srqn_rmpn_xrqn,
+			 to_msrq(devr->s1)->msrq.srqn);
+	}
+
+	if (attr->send_cq)
+		MLX5_SET(qpc, qpc, cqn_snd, to_mcq(attr->send_cq)->mcq.cqn);
+
+	if (attr->recv_cq)
+		MLX5_SET(qpc, qpc, cqn_rcv, to_mcq(attr->recv_cq)->mcq.cqn);
+
+	MLX5_SET64(qpc, qpc, dbr_addr, qp->db.dma);
+
+	/* 0xffffff means we ask to work with cqe version 0 */
+	if (MLX5_CAP_GEN(mdev, cqe_version) == MLX5_CQE_VERSION_V1)
+		MLX5_SET(qpc, qpc, user_index, uidx);
+
+	/* we use IB_QP_CREATE_IPOIB_UD_LSO to indicates ipoib qp */
+	if (qp->flags & IB_QP_CREATE_IPOIB_UD_LSO)
+		MLX5_SET(qpc, qpc, ulp_stateless_offload_mode, 1);
+
+	err = mlx5_core_create_qp(dev, &base->mqp, in, inlen);
+	kvfree(in);
+	if (err)
+		goto err_create;
+
+	base->container_mibqp = qp;
+	base->mqp.event = mlx5_ib_qp_event;
+
+	get_cqs(qp->type, attr->send_cq, attr->recv_cq,
+		&send_cq, &recv_cq);
+	spin_lock_irqsave(&dev->reset_flow_resource_lock, flags);
+	mlx5_ib_lock_cqs(send_cq, recv_cq);
+	/* Maintain device to QPs access, needed for further handling via reset
+	 * flow
+	 */
+	list_add_tail(&qp->qps_list, &dev->qp_list);
+	/* Maintain CQ to QPs access, needed for further handling via reset flow
+	 */
+	if (send_cq)
+		list_add_tail(&qp->cq_send_list, &send_cq->list_send_qp);
+	if (recv_cq)
+		list_add_tail(&qp->cq_recv_list, &recv_cq->list_recv_qp);
+	mlx5_ib_unlock_cqs(send_cq, recv_cq);
+	spin_unlock_irqrestore(&dev->reset_flow_resource_lock, flags);
+
+	return 0;
+
+err_create:
+	destroy_qp_kernel(dev, qp);
+	return err;
+}
+
 static void mlx5_ib_lock_cqs(struct mlx5_ib_cq *send_cq, struct mlx5_ib_cq *recv_cq)
 	__acquires(&send_cq->lock) __acquires(&recv_cq->lock)
 {
@@ -2695,7 +2799,7 @@ static int create_raw_qp(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 	if (attr->rwq_ind_tbl)
 		return create_rss_raw_qp_tir(pd, qp, attr, ucmd, udata);
 
-	return create_qp_common(dev, pd, attr, ucmd, udata, qp, uidx);
+	return create_user_qp(dev, pd, attr, ucmd, udata, qp, uidx);
 }
 
 static int check_qp_attr(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
@@ -2819,8 +2923,11 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 		err = create_xrc_tgt_qp(dev, init_attr, qp, udata, uidx);
 		break;
 	default:
-		err = create_qp_common(dev, pd, init_attr, ucmd, udata, qp,
-				       uidx);
+		if (udata)
+			err = create_user_qp(dev, pd, init_attr, ucmd, udata,
+					     qp, uidx);
+		else
+			err = create_kernel_qp(dev, pd, init_attr, qp, uidx);
 	}
 	if (err) {
 		mlx5_ib_dbg(dev, "create_qp failed %d\n", err);
-- 
2.25.3

