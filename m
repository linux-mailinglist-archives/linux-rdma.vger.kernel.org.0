Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14B01BA8EF
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 17:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgD0Pse (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 11:48:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728383AbgD0Psd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 11:48:33 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF12C206D9;
        Mon, 27 Apr 2020 15:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588002512;
        bh=ui42PDc/4+PXYSEXt0YWDLy3nYiU5arWkF+JfHJ2Tzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T+Y9WgjDr4CEla0j3Nsu9bjJogG/oHQCpNOzSY4LO66xx/u2jdtaALjSuQbcEs6/v
         XV7v069zbwiF/DL+lvVU0eiPql8MAOSSSZzxk0aNto/fAzHWQgdlXzRa1SExsRZkDH
         4PZJKDph54U3cPxUbT6gEAk7yIY7Q7dComuWvo3A=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aharon Landau <aharonl@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1 27/36] RDMA/mlx5: Separate XRC_TGT QP creation from common flow
Date:   Mon, 27 Apr 2020 18:46:27 +0300
Message-Id: <20200427154636.381474-28-leon@kernel.org>
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

XRC_TGT QP doesn't fail into kernel or user flow separation. It is
initiated by the user, but is created through in-kernel verbs flow
and doesn't have PD and udata in similar way to kernel QPs.

So let's separate creation of that QP type from the common flow.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 158 +++++++++++++++++++++-----------
 1 file changed, 106 insertions(+), 52 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index b2174e0817f5..8890c172f7e5 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -991,8 +991,7 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		goto err_umem;
 	}
 
-	uid = (attr->qp_type != IB_QPT_XRC_TGT &&
-	       attr->qp_type != IB_QPT_XRC_INI) ? to_mpd(pd)->uid : 0;
+	uid = (attr->qp_type != IB_QPT_XRC_INI) ? to_mpd(pd)->uid : 0;
 	MLX5_SET(create_qp_in, *in, uid, uid);
 	pas = (__be64 *)MLX5_ADDR_OF(create_qp_in, *in, pas);
 	if (ubuffer->umem)
@@ -1913,6 +1912,81 @@ static int get_atomic_mode(struct mlx5_ib_dev *dev,
 	return atomic_mode;
 }
 
+static int create_xrc_tgt_qp(struct mlx5_ib_dev *dev,
+			     struct ib_qp_init_attr *attr,
+			     struct mlx5_ib_qp *qp, struct ib_udata *udata,
+			     u32 uidx)
+{
+	struct mlx5_ib_resources *devr = &dev->devr;
+	int inlen = MLX5_ST_SZ_BYTES(create_qp_in);
+	struct mlx5_core_dev *mdev = dev->mdev;
+	struct mlx5_ib_qp_base *base;
+	unsigned long flags;
+	void *qpc;
+	u32 *in;
+	int err;
+
+	mutex_init(&qp->mutex);
+
+	if (attr->sq_sig_type == IB_SIGNAL_ALL_WR)
+		qp->sq_signal_bits = MLX5_WQE_CTRL_CQ_UPDATE;
+
+	in = kvzalloc(inlen, GFP_KERNEL);
+	if (!in)
+		return -ENOMEM;
+
+	qpc = MLX5_ADDR_OF(create_qp_in, in, qpc);
+
+	MLX5_SET(qpc, qpc, st, MLX5_QP_ST_XRC);
+	MLX5_SET(qpc, qpc, pm_state, MLX5_QP_PM_MIGRATED);
+	MLX5_SET(qpc, qpc, pd, to_mpd(devr->p0)->pdn);
+
+	if (qp->flags & IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK)
+		MLX5_SET(qpc, qpc, block_lb_mc, 1);
+	if (qp->flags & IB_QP_CREATE_CROSS_CHANNEL)
+		MLX5_SET(qpc, qpc, cd_master, 1);
+	if (qp->flags & IB_QP_CREATE_MANAGED_SEND)
+		MLX5_SET(qpc, qpc, cd_slave_send, 1);
+	if (qp->flags & IB_QP_CREATE_MANAGED_RECV)
+		MLX5_SET(qpc, qpc, cd_slave_receive, 1);
+
+	MLX5_SET(qpc, qpc, rq_type, MLX5_SRQ_RQ);
+	MLX5_SET(qpc, qpc, no_sq, 1);
+	MLX5_SET(qpc, qpc, cqn_rcv, to_mcq(devr->c0)->mcq.cqn);
+	MLX5_SET(qpc, qpc, cqn_snd, to_mcq(devr->c0)->mcq.cqn);
+	MLX5_SET(qpc, qpc, srqn_rmpn_xrqn, to_msrq(devr->s0)->msrq.srqn);
+	MLX5_SET(qpc, qpc, xrcd, to_mxrcd(attr->xrcd)->xrcdn);
+	MLX5_SET64(qpc, qpc, dbr_addr, qp->db.dma);
+
+	/* 0xffffff means we ask to work with cqe version 0 */
+	if (MLX5_CAP_GEN(mdev, cqe_version) == MLX5_CQE_VERSION_V1)
+		MLX5_SET(qpc, qpc, user_index, uidx);
+
+	if (qp->flags & IB_QP_CREATE_PCI_WRITE_END_PADDING) {
+		MLX5_SET(qpc, qpc, end_padding_mode,
+			 MLX5_WQ_END_PAD_MODE_ALIGN);
+		/* Special case to clean flag */
+		qp->flags &= ~IB_QP_CREATE_PCI_WRITE_END_PADDING;
+	}
+
+	base = &qp->trans_qp.base;
+	err = mlx5_core_create_qp(dev, &base->mqp, in, inlen);
+	kvfree(in);
+	if (err) {
+		destroy_qp_user(dev, NULL, qp, base, udata);
+		return err;
+	}
+
+	base->container_mibqp = qp;
+	base->mqp.event = mlx5_ib_qp_event;
+
+	spin_lock_irqsave(&dev->reset_flow_resource_lock, flags);
+	list_add_tail(&qp->qps_list, &dev->qp_list);
+	spin_unlock_irqrestore(&dev->reset_flow_resource_lock, flags);
+
+	return 0;
+}
+
 static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			    struct ib_qp_init_attr *init_attr,
 			    struct mlx5_ib_create_qp *ucmd,
@@ -1958,40 +2032,30 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		return err;
 	}
 
-	if (pd) {
-		if (udata) {
-			__u32 max_wqes =
-				1 << MLX5_CAP_GEN(mdev, log_max_qp_sz);
-			mlx5_ib_dbg(dev, "requested sq_wqe_count (%d)\n",
-				    ucmd->sq_wqe_count);
-			if (ucmd->rq_wqe_shift != qp->rq.wqe_shift ||
-			    ucmd->rq_wqe_count != qp->rq.wqe_cnt) {
-				mlx5_ib_dbg(dev, "invalid rq params\n");
-				return -EINVAL;
-			}
-			if (ucmd->sq_wqe_count > max_wqes) {
-				mlx5_ib_dbg(dev, "requested sq_wqe_count (%d) > max allowed (%d)\n",
-					    ucmd->sq_wqe_count, max_wqes);
-				return -EINVAL;
-			}
-			err = create_user_qp(dev, pd, qp, udata, init_attr, &in,
-					     &resp, &inlen, base, ucmd);
-			if (err)
-				mlx5_ib_dbg(dev, "err %d\n", err);
-		} else {
-			err = create_kernel_qp(dev, init_attr, qp, &in, &inlen,
-					       base);
-			if (err)
-				mlx5_ib_dbg(dev, "err %d\n", err);
+	if (udata) {
+		__u32 max_wqes = 1 << MLX5_CAP_GEN(mdev, log_max_qp_sz);
+
+		mlx5_ib_dbg(dev, "requested sq_wqe_count (%d)\n",
+			    ucmd->sq_wqe_count);
+		if (ucmd->rq_wqe_shift != qp->rq.wqe_shift ||
+		    ucmd->rq_wqe_count != qp->rq.wqe_cnt) {
+			mlx5_ib_dbg(dev, "invalid rq params\n");
+			return -EINVAL;
+		}
+		if (ucmd->sq_wqe_count > max_wqes) {
+			mlx5_ib_dbg(
+				dev,
+				"requested sq_wqe_count (%d) > max allowed (%d)\n",
+				ucmd->sq_wqe_count, max_wqes);
+			return -EINVAL;
 		}
+		err = create_user_qp(dev, pd, qp, udata, init_attr, &in, &resp,
+				     &inlen, base, ucmd);
+	} else
+		err = create_kernel_qp(dev, init_attr, qp, &in, &inlen, base);
 
-		if (err)
-			return err;
-	} else {
-		in = kvzalloc(inlen, GFP_KERNEL);
-		if (!in)
-			return -ENOMEM;
-	}
+	if (err)
+		return err;
 
 	if (is_sqp(init_attr->qp_type))
 		qp->port = init_attr->port_num;
@@ -2054,12 +2118,6 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 
 	/* Set default resources */
 	switch (init_attr->qp_type) {
-	case IB_QPT_XRC_TGT:
-		MLX5_SET(qpc, qpc, cqn_rcv, to_mcq(devr->c0)->mcq.cqn);
-		MLX5_SET(qpc, qpc, cqn_snd, to_mcq(devr->c0)->mcq.cqn);
-		MLX5_SET(qpc, qpc, srqn_rmpn_xrqn, to_msrq(devr->s0)->msrq.srqn);
-		MLX5_SET(qpc, qpc, xrcd, to_mxrcd(init_attr->xrcd)->xrcdn);
-		break;
 	case IB_QPT_XRC_INI:
 		MLX5_SET(qpc, qpc, cqn_rcv, to_mcq(devr->c0)->mcq.cqn);
 		MLX5_SET(qpc, qpc, xrcd, to_mxrcd(devr->x1)->xrcdn);
@@ -2105,16 +2163,12 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		raw_packet_qp_copy_info(qp, &qp->raw_packet_qp);
 		err = create_raw_packet_qp(dev, qp, in, inlen, pd, udata,
 					   &resp);
-	} else {
+	} else
 		err = mlx5_core_create_qp(dev, &base->mqp, in, inlen);
-	}
-
-	if (err) {
-		mlx5_ib_dbg(dev, "create qp failed\n");
-		goto err_create;
-	}
 
 	kvfree(in);
+	if (err)
+		goto err_create;
 
 	base->container_mibqp = qp;
 	base->mqp.event = mlx5_ib_qp_event;
@@ -2143,7 +2197,6 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		destroy_qp_user(dev, pd, qp, base, udata);
 	else
 		destroy_qp_kernel(dev, qp);
-	kvfree(in);
 	return err;
 }
 
@@ -2750,9 +2803,6 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 	if (err)
 		goto free_qp;
 
-	if (qp->type == IB_QPT_XRC_TGT)
-		xrcdn = to_mxrcd(init_attr->xrcd)->xrcdn;
-
 	err = check_qp_attr(dev, qp, init_attr);
 	if (err)
 		goto free_qp;
@@ -2764,12 +2814,16 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 	case MLX5_IB_QPT_DCT:
 		err = create_dct(pd, qp, init_attr, ucmd, uidx);
 		break;
+	case IB_QPT_XRC_TGT:
+		xrcdn = to_mxrcd(init_attr->xrcd)->xrcdn;
+		err = create_xrc_tgt_qp(dev, init_attr, qp, udata, uidx);
+		break;
 	default:
 		err = create_qp_common(dev, pd, init_attr, ucmd, udata, qp,
 				       uidx);
 	}
 	if (err) {
-		mlx5_ib_dbg(dev, "create_qp_common failed\n");
+		mlx5_ib_dbg(dev, "create_qp failed %d\n", err);
 		goto free_qp;
 	}
 
-- 
2.25.3

