Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFD91BA888
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 17:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgD0Prk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 11:47:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728286AbgD0Prj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 11:47:39 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F346C2064C;
        Mon, 27 Apr 2020 15:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588002458;
        bh=/OBau5hbhKFMson5J2UaUG+CID0cU/9NbNOi8XYELkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SVQx5AN+bVXj/ldNyt7FESrYJo3nSY1CwHmHm3rlta6TfMmxY4iODKToJfx8YfqkD
         wDCHjltAphTTTeeIaAlvEfdu7L6I12hyF7GphivV3xSze7q+xwqhzPNCyuqAPQbulm
         OrZsD9UR8/ATu3goQHqCF3oGfwozdYuAjJl2lMv4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aharon Landau <aharonl@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1 14/36] RDMA/mlx5: Process create QP flags in one place
Date:   Mon, 27 Apr 2020 18:46:14 +0300
Message-Id: <20200427154636.381474-15-leon@kernel.org>
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

create_flags is checked in too many places and scattered across all
the code, consolidate all the checks inside one function, so we will
be easily see the flow. As part of such change, delete unreachable code,
because IB/core is responsible sanitize the input.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 200 ++++++++++++++++----------------
 1 file changed, 101 insertions(+), 99 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index cdbb837138c9..02eb03484b91 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1097,17 +1097,9 @@ static int create_kernel_qp(struct mlx5_ib_dev *dev,
 	void *qpc;
 	int err;
 
-	if (init_attr->create_flags & ~(IB_QP_CREATE_INTEGRITY_EN |
-					IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK |
-					IB_QP_CREATE_IPOIB_UD_LSO |
-					IB_QP_CREATE_NETIF_QP |
-					MLX5_IB_QP_CREATE_SQPN_QP1 |
-					MLX5_IB_QP_CREATE_WC_TEST))
-		return -EINVAL;
-
 	if (init_attr->qp_type == MLX5_IB_QPT_REG_UMR)
 		qp->bf.bfreg = &dev->fp_bfreg;
-	else if (init_attr->create_flags & MLX5_IB_QP_CREATE_WC_TEST)
+	else if (qp->flags & MLX5_IB_QP_CREATE_WC_TEST)
 		qp->bf.bfreg = &dev->wc_bfreg;
 	else
 		qp->bf.bfreg = &dev->bfreg;
@@ -1167,10 +1159,8 @@ static int create_kernel_qp(struct mlx5_ib_dev *dev,
 	MLX5_SET(qpc, qpc, fre, 1);
 	MLX5_SET(qpc, qpc, rlky, 1);
 
-	if (init_attr->create_flags & MLX5_IB_QP_CREATE_SQPN_QP1) {
+	if (qp->flags & MLX5_IB_QP_CREATE_SQPN_QP1)
 		MLX5_SET(qpc, qpc, deth_sqpn, 1);
-		qp->flags |= MLX5_IB_QP_CREATE_SQPN_QP1;
-	}
 
 	mlx5_fill_page_frag_array(&qp->buf,
 				  (__be64 *)MLX5_ADDR_OF(create_qp_in,
@@ -1657,7 +1647,7 @@ static int create_rss_raw_qp_tir(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 	size_t required_cmd_sz;
 	u8 lb_flag = 0;
 
-	if (init_attr->create_flags || init_attr->send_cq)
+	if (init_attr->send_cq)
 		return -EINVAL;
 
 	min_resp_len = offsetof(typeof(resp), bfreg_index) + sizeof(resp.bfreg_index);
@@ -1996,62 +1986,9 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	if (mlx5_st < 0)
 		return -EINVAL;
 
-	if (init_attr->create_flags & IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK) {
-		if (!MLX5_CAP_GEN(mdev, block_lb_mc)) {
-			mlx5_ib_dbg(dev, "block multicast loopback isn't supported\n");
-			return -EINVAL;
-		} else {
-			qp->flags |= IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK;
-		}
-	}
-
-	if (init_attr->create_flags &
-			(IB_QP_CREATE_CROSS_CHANNEL |
-			 IB_QP_CREATE_MANAGED_SEND |
-			 IB_QP_CREATE_MANAGED_RECV)) {
-		if (!MLX5_CAP_GEN(mdev, cd)) {
-			mlx5_ib_dbg(dev, "cross-channel isn't supported\n");
-			return -EINVAL;
-		}
-		if (init_attr->create_flags & IB_QP_CREATE_CROSS_CHANNEL)
-			qp->flags |= IB_QP_CREATE_CROSS_CHANNEL;
-		if (init_attr->create_flags & IB_QP_CREATE_MANAGED_SEND)
-			qp->flags |= IB_QP_CREATE_MANAGED_SEND;
-		if (init_attr->create_flags & IB_QP_CREATE_MANAGED_RECV)
-			qp->flags |= IB_QP_CREATE_MANAGED_RECV;
-	}
-
-	if (init_attr->qp_type == IB_QPT_UD &&
-	    (init_attr->create_flags & IB_QP_CREATE_IPOIB_UD_LSO))
-		if (!MLX5_CAP_GEN(mdev, ipoib_basic_offloads)) {
-			mlx5_ib_dbg(dev, "ipoib UD lso qp isn't supported\n");
-			return -EOPNOTSUPP;
-		}
-
-	if (init_attr->create_flags & IB_QP_CREATE_SCATTER_FCS) {
-		if (init_attr->qp_type != IB_QPT_RAW_PACKET) {
-			mlx5_ib_dbg(dev, "Scatter FCS is supported only for Raw Packet QPs");
-			return -EOPNOTSUPP;
-		}
-		if (!MLX5_CAP_GEN(dev->mdev, eth_net_offloads) ||
-		    !MLX5_CAP_ETH(dev->mdev, scatter_fcs)) {
-			mlx5_ib_dbg(dev, "Scatter FCS isn't supported\n");
-			return -EOPNOTSUPP;
-		}
-		qp->flags |= IB_QP_CREATE_SCATTER_FCS;
-	}
-
 	if (init_attr->sq_sig_type == IB_SIGNAL_ALL_WR)
 		qp->sq_signal_bits = MLX5_WQE_CTRL_CQ_UPDATE;
 
-	if (init_attr->create_flags & IB_QP_CREATE_CVLAN_STRIPPING) {
-		if (!(MLX5_CAP_GEN(dev->mdev, eth_net_offloads) &&
-		      MLX5_CAP_ETH(dev->mdev, vlan_cap)) ||
-		    (init_attr->qp_type != IB_QPT_RAW_PACKET))
-			return -EOPNOTSUPP;
-		qp->flags |= IB_QP_CREATE_CVLAN_STRIPPING;
-	}
-
 	if (udata) {
 		if (!check_flags_mask(ucmd->flags,
 				      MLX5_QP_FLAG_ALLOW_SCATTER_CQE |
@@ -2108,23 +2045,13 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			}
 			qp->flags_en |= MLX5_QP_FLAG_PACKET_BASED_CREDIT_MODE;
 		}
-
-		if (init_attr->create_flags & IB_QP_CREATE_SOURCE_QPN) {
-			if (init_attr->qp_type != IB_QPT_UD ||
-			    (MLX5_CAP_GEN(dev->mdev, port_type) !=
-			     MLX5_CAP_PORT_TYPE_IB) ||
-			    !mlx5_get_flow_namespace(dev->mdev, MLX5_FLOW_NAMESPACE_BYPASS)) {
-				mlx5_ib_dbg(dev, "Source QP option isn't supported\n");
-				return -EOPNOTSUPP;
-			}
-
-			qp->flags |= IB_QP_CREATE_SOURCE_QPN;
-			qp->underlay_qpn = init_attr->source_qpn;
-		}
 	} else {
 		qp->wq_sig = !!wq_signature;
 	}
 
+	if (qp->flags & IB_QP_CREATE_SOURCE_QPN)
+		qp->underlay_qpn = init_attr->source_qpn;
+
 	base = (init_attr->qp_type == IB_QPT_RAW_PACKET ||
 		qp->flags & IB_QP_CREATE_SOURCE_QPN) ?
 	       &qp->raw_packet_qp.rq.base :
@@ -2153,11 +2080,6 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 					    ucmd->sq_wqe_count, max_wqes);
 				return -EINVAL;
 			}
-			if (init_attr->create_flags &
-			    MLX5_IB_QP_CREATE_SQPN_QP1) {
-				mlx5_ib_dbg(dev, "user-space is not allowed to create UD QPs spoofing as QP1\n");
-				return -EINVAL;
-			}
 			err = create_user_qp(dev, pd, qp, udata, init_attr, &in,
 					     &resp, &inlen, base);
 			if (err)
@@ -2273,23 +2195,15 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		MLX5_SET(qpc, qpc, user_index, uidx);
 
 	/* we use IB_QP_CREATE_IPOIB_UD_LSO to indicates ipoib qp */
-	if (init_attr->qp_type == IB_QPT_UD &&
-	    (init_attr->create_flags & IB_QP_CREATE_IPOIB_UD_LSO)) {
+	if (qp->flags & IB_QP_CREATE_IPOIB_UD_LSO)
 		MLX5_SET(qpc, qpc, ulp_stateless_offload_mode, 1);
-		qp->flags |= IB_QP_CREATE_IPOIB_UD_LSO;
-	}
 
-	if (init_attr->create_flags & IB_QP_CREATE_PCI_WRITE_END_PADDING) {
-		if (!MLX5_CAP_GEN(dev->mdev, end_pad)) {
-			mlx5_ib_dbg(dev, "scatter end padding is not supported\n");
-			err = -EOPNOTSUPP;
-			goto err;
-		} else if (init_attr->qp_type != IB_QPT_RAW_PACKET) {
-			MLX5_SET(qpc, qpc, end_padding_mode,
-				 MLX5_WQ_END_PAD_MODE_ALIGN);
-		} else {
-			qp->flags |= IB_QP_CREATE_PCI_WRITE_END_PADDING;
-		}
+	if (qp->flags & IB_QP_CREATE_PCI_WRITE_END_PADDING &&
+	    init_attr->qp_type != IB_QPT_RAW_PACKET) {
+		MLX5_SET(qpc, qpc, end_padding_mode,
+			 MLX5_WQ_END_PAD_MODE_ALIGN);
+		/* Special case to clean flag */
+		qp->flags &= ~IB_QP_CREATE_PCI_WRITE_END_PADDING;
 	}
 
 	if (inlen < 0) {
@@ -2670,6 +2584,91 @@ static int process_vendor_flags(struct mlx5_ib_qp *qp,
 	return 0;
 }
 
+static void process_create_flag(struct mlx5_ib_dev *dev, int *flags, int flag,
+				bool cond, struct mlx5_ib_qp *qp)
+{
+	if (!(*flags & flag))
+		return;
+
+	if (cond) {
+		qp->flags |= flag;
+		*flags &= ~flag;
+		return;
+	}
+
+	if (flag == MLX5_IB_QP_CREATE_WC_TEST) {
+		/*
+		 * Special case, if condition didn't meet, it won't be error,
+		 * just different in-kernel flow.
+		 */
+		*flags &= ~MLX5_IB_QP_CREATE_WC_TEST;
+		return;
+	}
+	mlx5_ib_dbg(dev, "Verbs create QP flag 0x%X is not supported\n", flag);
+}
+
+static int process_create_flags(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
+				struct ib_qp_init_attr *attr)
+{
+	enum ib_qp_type qp_type = attr->qp_type;
+	struct mlx5_core_dev *mdev = dev->mdev;
+	int create_flags = attr->create_flags;
+	bool cond;
+
+	if (qp->qp_sub_type == MLX5_IB_QPT_DCT)
+		return (create_flags) ? -EINVAL : 0;
+
+	if (qp_type == IB_QPT_RAW_PACKET && attr->rwq_ind_tbl)
+		return (create_flags) ? -EINVAL : 0;
+
+	process_create_flag(dev, &create_flags,
+			    IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK,
+			    MLX5_CAP_GEN(mdev, block_lb_mc), qp);
+	process_create_flag(dev, &create_flags, IB_QP_CREATE_CROSS_CHANNEL,
+			    MLX5_CAP_GEN(mdev, cd), qp);
+	process_create_flag(dev, &create_flags, IB_QP_CREATE_MANAGED_SEND,
+			    MLX5_CAP_GEN(mdev, cd), qp);
+	process_create_flag(dev, &create_flags, IB_QP_CREATE_MANAGED_RECV,
+			    MLX5_CAP_GEN(mdev, cd), qp);
+
+	if (qp_type == IB_QPT_UD) {
+		process_create_flag(dev, &create_flags,
+				    IB_QP_CREATE_IPOIB_UD_LSO,
+				    MLX5_CAP_GEN(mdev, ipoib_basic_offloads),
+				    qp);
+		cond = MLX5_CAP_GEN(mdev, port_type) == MLX5_CAP_PORT_TYPE_IB;
+		process_create_flag(dev, &create_flags, IB_QP_CREATE_SOURCE_QPN,
+				    cond, qp);
+	}
+
+	if (qp_type == IB_QPT_RAW_PACKET) {
+		cond = MLX5_CAP_GEN(mdev, eth_net_offloads) &&
+		       MLX5_CAP_ETH(mdev, scatter_fcs);
+		process_create_flag(dev, &create_flags,
+				    IB_QP_CREATE_SCATTER_FCS, cond, qp);
+
+		cond = MLX5_CAP_GEN(mdev, eth_net_offloads) &&
+		       MLX5_CAP_ETH(mdev, vlan_cap);
+		process_create_flag(dev, &create_flags,
+				    IB_QP_CREATE_CVLAN_STRIPPING, cond, qp);
+	}
+
+	process_create_flag(dev, &create_flags,
+			    IB_QP_CREATE_PCI_WRITE_END_PADDING,
+			    MLX5_CAP_GEN(mdev, end_pad), qp);
+
+	process_create_flag(dev, &create_flags, MLX5_IB_QP_CREATE_WC_TEST,
+			    qp_type != MLX5_IB_QPT_REG_UMR, qp);
+	process_create_flag(dev, &create_flags, MLX5_IB_QP_CREATE_SQPN_QP1,
+			    true, qp);
+
+	if (create_flags)
+		mlx5_ib_dbg(dev, "Create QP has unsupported flags 0x%X\n",
+			    create_flags);
+
+	return (create_flags) ? -EINVAL : 0;
+}
+
 static int create_driver_qp(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 			    struct ib_qp_init_attr *attr,
 			    struct mlx5_ib_create_qp *ucmd,
@@ -2769,6 +2768,9 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 		if (err)
 			goto free_qp;
 	}
+	err = process_create_flags(dev, qp, init_attr);
+	if (err)
+		goto free_qp;
 
 	if (init_attr->qp_type == IB_QPT_XRC_TGT)
 		xrcdn = to_mxrcd(init_attr->xrcd)->xrcdn;
-- 
2.25.3

