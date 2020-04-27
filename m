Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55ABF1BA874
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 17:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgD0Pra (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 11:47:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbgD0Pr3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 11:47:29 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5CF220735;
        Mon, 27 Apr 2020 15:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588002447;
        bh=MCUbtL/GKkZR0fCn/oV/6pfZpVtKc3MjZUGVaDeEkCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0gvfxkZanl6ZeRn+mtNFTQBcpad7oqG7w9hFByAbn/o6wZnEGm4fhImFlwBKCCaKI
         9czKWNQrA5zOXXzVhKTXAZ0rBe7r7bgvCrbSEVLYkzzlKl7iupGx+MtquA7VTuudi4
         UCuyywefAjy8XnpqGFkJIONHh0fgfQA+QbIDuF0k=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aharon Landau <aharonl@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1 13/36] RDMA/mlx5: Delete create QP flags obfuscation
Date:   Mon, 27 Apr 2020 18:46:13 +0300
Message-Id: <20200427154636.381474-14-leon@kernel.org>
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

There is no point in redefinition of stable and exposed to users create
flags. Their values won't be changed and it is equal to used by the
mlx5. Delete the mlx5 definitions and use IB/core fields.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/devx.c    |  2 +-
 drivers/infiniband/hw/mlx5/flow.c    |  2 +-
 drivers/infiniband/hw/mlx5/main.c    |  6 +--
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 21 +-------
 drivers/infiniband/hw/mlx5/qp.c      | 80 ++++++++++++++--------------
 5 files changed, 47 insertions(+), 64 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 35b98c2d64d5..1d7feed6d3cb 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -615,7 +615,7 @@ static bool devx_is_valid_obj_id(struct uverbs_attr_bundle *attrs,
 		enum ib_qp_type	qp_type = qp->ibqp.qp_type;
 
 		if (qp_type == IB_QPT_RAW_PACKET ||
-		    (qp->flags & MLX5_IB_QP_UNDERLAY)) {
+		    (qp->flags & IB_QP_CREATE_SOURCE_QPN)) {
 			struct mlx5_ib_raw_packet_qp *raw_packet_qp =
 							 &qp->raw_packet_qp;
 			struct mlx5_ib_rq *rq = &raw_packet_qp->rq;
diff --git a/drivers/infiniband/hw/mlx5/flow.c b/drivers/infiniband/hw/mlx5/flow.c
index 862b7bf3e646..1b44f691b571 100644
--- a/drivers/infiniband/hw/mlx5/flow.c
+++ b/drivers/infiniband/hw/mlx5/flow.c
@@ -142,7 +142,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
 			return -EINVAL;
 
 		mqp = to_mqp(qp);
-		if (mqp->flags & MLX5_IB_QP_RSS)
+		if (mqp->is_rss)
 			dest_id = mqp->rss_qp.tirn;
 		else
 			dest_id = mqp->raw_packet_qp.rq.tirn;
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index f10675213115..f8d752ca92f7 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3967,7 +3967,7 @@ static struct ib_flow *mlx5_ib_create_flow(struct ib_qp *qp,
 		dst->type = MLX5_FLOW_DESTINATION_TYPE_PORT;
 	} else {
 		dst->type = MLX5_FLOW_DESTINATION_TYPE_TIR;
-		if (mqp->flags & MLX5_IB_QP_RSS)
+		if (mqp->is_rss)
 			dst->tir_num = mqp->rss_qp.tirn;
 		else
 			dst->tir_num = mqp->raw_packet_qp.rq.tirn;
@@ -3978,7 +3978,7 @@ static struct ib_flow *mlx5_ib_create_flow(struct ib_qp *qp,
 			handler = create_dont_trap_rule(dev, ft_prio,
 							flow_attr, dst);
 		} else {
-			underlay_qpn = (mqp->flags & MLX5_IB_QP_UNDERLAY) ?
+			underlay_qpn = (mqp->flags & IB_QP_CREATE_SOURCE_QPN) ?
 					mqp->underlay_qpn : 0;
 			handler = _create_flow_rule(dev, ft_prio, flow_attr,
 						    dst, underlay_qpn, ucmd);
@@ -4447,7 +4447,7 @@ static int mlx5_ib_mcg_attach(struct ib_qp *ibqp, union ib_gid *gid, u16 lid)
 	uid = ibqp->pd ?
 		to_mpd(ibqp->pd)->uid : 0;
 
-	if (mqp->flags & MLX5_IB_QP_UNDERLAY) {
+	if (mqp->flags & IB_QP_CREATE_SOURCE_QPN) {
 		mlx5_ib_dbg(dev, "Attaching a multi cast group to underlay QP is not supported\n");
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index aaabb8a98eed..b144660a47e1 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -450,7 +450,8 @@ struct mlx5_ib_qp {
 	int			scat_cqe;
 	int			max_inline_data;
 	struct mlx5_bf	        bf;
-	int			has_rq;
+	u8			has_rq:1;
+	u8			is_rss:1;
 
 	/* only for user space QPs. For kernel
 	 * we have it from the bf object
@@ -481,24 +482,6 @@ struct mlx5_ib_cq_buf {
 	int			nent;
 };
 
-enum mlx5_ib_qp_flags {
-	MLX5_IB_QP_LSO                          = IB_QP_CREATE_IPOIB_UD_LSO,
-	MLX5_IB_QP_BLOCK_MULTICAST_LOOPBACK     = IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK,
-	MLX5_IB_QP_CROSS_CHANNEL            = IB_QP_CREATE_CROSS_CHANNEL,
-	MLX5_IB_QP_MANAGED_SEND             = IB_QP_CREATE_MANAGED_SEND,
-	MLX5_IB_QP_MANAGED_RECV             = IB_QP_CREATE_MANAGED_RECV,
-	MLX5_IB_QP_SIGNATURE_HANDLING           = 1 << 5,
-	/* QP uses 1 as its source QP number */
-	MLX5_IB_QP_SQPN_QP1			= 1 << 6,
-	MLX5_IB_QP_CAP_SCATTER_FCS		= 1 << 7,
-	MLX5_IB_QP_RSS				= 1 << 8,
-	MLX5_IB_QP_CVLAN_STRIPPING		= 1 << 9,
-	MLX5_IB_QP_UNDERLAY			= 1 << 10,
-	MLX5_IB_QP_PCI_WRITE_END_PADDING	= 1 << 11,
-	MLX5_IB_QP_TUNNEL_OFFLOAD		= 1 << 12,
-	MLX5_IB_QP_PACKET_BASED_CREDIT		= 1 << 13,
-};
-
 struct mlx5_umr_wr {
 	struct ib_send_wr		wr;
 	u64				virt_addr;
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index a514b4eca06e..cdbb837138c9 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -596,7 +596,7 @@ static int set_user_buf_size(struct mlx5_ib_dev *dev,
 	}
 
 	if (attr->qp_type == IB_QPT_RAW_PACKET ||
-	    qp->flags & MLX5_IB_QP_UNDERLAY) {
+	    qp->flags & IB_QP_CREATE_SOURCE_QPN) {
 		base->ubuffer.buf_size = qp->rq.wqe_cnt << qp->rq.wqe_shift;
 		qp->raw_packet_qp.sq.ubuffer.buf_size = qp->sq.wqe_cnt << 6;
 	} else {
@@ -951,7 +951,7 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		bfregn = MLX5_IB_INVALID_BFREG;
 		break;
 	case 0:
-		if (qp->flags & MLX5_IB_QP_CROSS_CHANNEL)
+		if (qp->flags & IB_QP_CREATE_CROSS_CHANNEL)
 			return -EINVAL;
 		bfregn = alloc_bfreg(dev, &context->bfregi);
 		if (bfregn < 0)
@@ -1169,7 +1169,7 @@ static int create_kernel_qp(struct mlx5_ib_dev *dev,
 
 	if (init_attr->create_flags & MLX5_IB_QP_CREATE_SQPN_QP1) {
 		MLX5_SET(qpc, qpc, deth_sqpn, 1);
-		qp->flags |= MLX5_IB_QP_SQPN_QP1;
+		qp->flags |= MLX5_IB_QP_CREATE_SQPN_QP1;
 	}
 
 	mlx5_fill_page_frag_array(&qp->buf,
@@ -1251,7 +1251,7 @@ static int create_raw_packet_qp_tis(struct mlx5_ib_dev *dev,
 
 	MLX5_SET(create_tis_in, in, uid, to_mpd(pd)->uid);
 	MLX5_SET(tisc, tisc, transport_domain, tdn);
-	if (qp->flags & MLX5_IB_QP_UNDERLAY)
+	if (qp->flags & IB_QP_CREATE_SOURCE_QPN)
 		MLX5_SET(tisc, tisc, underlay_qpn, qp->underlay_qpn);
 
 	return mlx5_core_create_tis(dev->mdev, in, &sq->tisn);
@@ -1400,7 +1400,7 @@ static int create_raw_packet_qp_rq(struct mlx5_ib_dev *dev,
 	MLX5_SET(rqc, rqc, user_index, MLX5_GET(qpc, qpc, user_index));
 	MLX5_SET(rqc, rqc, cqn, MLX5_GET(qpc, qpc, cqn_rcv));
 
-	if (mqp->flags & MLX5_IB_QP_CAP_SCATTER_FCS)
+	if (mqp->flags & IB_QP_CREATE_SCATTER_FCS)
 		MLX5_SET(rqc, rqc, scatter_fcs, 1);
 
 	wq = MLX5_ADDR_OF(rqc, rqc, wq);
@@ -1538,9 +1538,9 @@ static int create_raw_packet_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	if (qp->rq.wqe_cnt) {
 		rq->base.container_mibqp = qp;
 
-		if (qp->flags & MLX5_IB_QP_CVLAN_STRIPPING)
+		if (qp->flags & IB_QP_CREATE_CVLAN_STRIPPING)
 			rq->flags |= MLX5_IB_RQ_CVLAN_STRIPPING;
-		if (qp->flags & MLX5_IB_QP_PCI_WRITE_END_PADDING)
+		if (qp->flags & IB_QP_CREATE_PCI_WRITE_END_PADDING)
 			rq->flags |= MLX5_IB_RQ_PCI_WRITE_END_PADDING;
 		err = create_raw_packet_qp_rq(dev, rq, in, inlen, pd);
 		if (err)
@@ -1878,7 +1878,7 @@ static int create_rss_raw_qp_tir(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 	kvfree(in);
 	/* qpn is reserved for that QP */
 	qp->trans_qp.base.mqp.qpn = 0;
-	qp->flags |= MLX5_IB_QP_RSS;
+	qp->is_rss = true;
 	return 0;
 
 err_copy:
@@ -2001,7 +2001,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			mlx5_ib_dbg(dev, "block multicast loopback isn't supported\n");
 			return -EINVAL;
 		} else {
-			qp->flags |= MLX5_IB_QP_BLOCK_MULTICAST_LOOPBACK;
+			qp->flags |= IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK;
 		}
 	}
 
@@ -2014,11 +2014,11 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			return -EINVAL;
 		}
 		if (init_attr->create_flags & IB_QP_CREATE_CROSS_CHANNEL)
-			qp->flags |= MLX5_IB_QP_CROSS_CHANNEL;
+			qp->flags |= IB_QP_CREATE_CROSS_CHANNEL;
 		if (init_attr->create_flags & IB_QP_CREATE_MANAGED_SEND)
-			qp->flags |= MLX5_IB_QP_MANAGED_SEND;
+			qp->flags |= IB_QP_CREATE_MANAGED_SEND;
 		if (init_attr->create_flags & IB_QP_CREATE_MANAGED_RECV)
-			qp->flags |= MLX5_IB_QP_MANAGED_RECV;
+			qp->flags |= IB_QP_CREATE_MANAGED_RECV;
 	}
 
 	if (init_attr->qp_type == IB_QPT_UD &&
@@ -2038,7 +2038,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			mlx5_ib_dbg(dev, "Scatter FCS isn't supported\n");
 			return -EOPNOTSUPP;
 		}
-		qp->flags |= MLX5_IB_QP_CAP_SCATTER_FCS;
+		qp->flags |= IB_QP_CREATE_SCATTER_FCS;
 	}
 
 	if (init_attr->sq_sig_type == IB_SIGNAL_ALL_WR)
@@ -2049,7 +2049,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		      MLX5_CAP_ETH(dev->mdev, vlan_cap)) ||
 		    (init_attr->qp_type != IB_QPT_RAW_PACKET))
 			return -EOPNOTSUPP;
-		qp->flags |= MLX5_IB_QP_CVLAN_STRIPPING;
+		qp->flags |= IB_QP_CREATE_CVLAN_STRIPPING;
 	}
 
 	if (udata) {
@@ -2106,7 +2106,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 				mlx5_ib_dbg(dev, "packet based credit mode isn't supported\n");
 				return -EOPNOTSUPP;
 			}
-			qp->flags |= MLX5_IB_QP_PACKET_BASED_CREDIT;
+			qp->flags_en |= MLX5_QP_FLAG_PACKET_BASED_CREDIT_MODE;
 		}
 
 		if (init_attr->create_flags & IB_QP_CREATE_SOURCE_QPN) {
@@ -2118,7 +2118,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 				return -EOPNOTSUPP;
 			}
 
-			qp->flags |= MLX5_IB_QP_UNDERLAY;
+			qp->flags |= IB_QP_CREATE_SOURCE_QPN;
 			qp->underlay_qpn = init_attr->source_qpn;
 		}
 	} else {
@@ -2126,7 +2126,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	}
 
 	base = (init_attr->qp_type == IB_QPT_RAW_PACKET ||
-		qp->flags & MLX5_IB_QP_UNDERLAY) ?
+		qp->flags & IB_QP_CREATE_SOURCE_QPN) ?
 	       &qp->raw_packet_qp.rq.base :
 	       &qp->trans_qp.base;
 
@@ -2196,16 +2196,16 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	if (qp->wq_sig)
 		MLX5_SET(qpc, qpc, wq_signature, 1);
 
-	if (qp->flags & MLX5_IB_QP_BLOCK_MULTICAST_LOOPBACK)
+	if (qp->flags & IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK)
 		MLX5_SET(qpc, qpc, block_lb_mc, 1);
 
-	if (qp->flags & MLX5_IB_QP_CROSS_CHANNEL)
+	if (qp->flags & IB_QP_CREATE_CROSS_CHANNEL)
 		MLX5_SET(qpc, qpc, cd_master, 1);
-	if (qp->flags & MLX5_IB_QP_MANAGED_SEND)
+	if (qp->flags & IB_QP_CREATE_MANAGED_SEND)
 		MLX5_SET(qpc, qpc, cd_slave_send, 1);
-	if (qp->flags & MLX5_IB_QP_MANAGED_RECV)
+	if (qp->flags & IB_QP_CREATE_MANAGED_RECV)
 		MLX5_SET(qpc, qpc, cd_slave_receive, 1);
-	if (qp->flags & MLX5_IB_QP_PACKET_BASED_CREDIT)
+	if (qp->flags_en & MLX5_QP_FLAG_PACKET_BASED_CREDIT_MODE)
 		MLX5_SET(qpc, qpc, req_e2e_credit_mode, 1);
 	if (qp->scat_cqe && (init_attr->qp_type == IB_QPT_RC ||
 			     init_attr->qp_type == IB_QPT_UC)) {
@@ -2276,7 +2276,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	if (init_attr->qp_type == IB_QPT_UD &&
 	    (init_attr->create_flags & IB_QP_CREATE_IPOIB_UD_LSO)) {
 		MLX5_SET(qpc, qpc, ulp_stateless_offload_mode, 1);
-		qp->flags |= MLX5_IB_QP_LSO;
+		qp->flags |= IB_QP_CREATE_IPOIB_UD_LSO;
 	}
 
 	if (init_attr->create_flags & IB_QP_CREATE_PCI_WRITE_END_PADDING) {
@@ -2288,7 +2288,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			MLX5_SET(qpc, qpc, end_padding_mode,
 				 MLX5_WQ_END_PAD_MODE_ALIGN);
 		} else {
-			qp->flags |= MLX5_IB_QP_PCI_WRITE_END_PADDING;
+			qp->flags |= IB_QP_CREATE_PCI_WRITE_END_PADDING;
 		}
 	}
 
@@ -2298,7 +2298,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	}
 
 	if (init_attr->qp_type == IB_QPT_RAW_PACKET ||
-	    qp->flags & MLX5_IB_QP_UNDERLAY) {
+	    qp->flags & IB_QP_CREATE_SOURCE_QPN) {
 		qp->raw_packet_qp.sq.ubuffer.buf_addr = ucmd->sq_buf_addr;
 		raw_packet_qp_copy_info(qp, &qp->raw_packet_qp);
 		err = create_raw_packet_qp(dev, qp, in, inlen, pd, udata,
@@ -2463,13 +2463,13 @@ static void destroy_qp_common(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	}
 
 	base = (qp->ibqp.qp_type == IB_QPT_RAW_PACKET ||
-		qp->flags & MLX5_IB_QP_UNDERLAY) ?
+		qp->flags & IB_QP_CREATE_SOURCE_QPN) ?
 	       &qp->raw_packet_qp.rq.base :
 	       &qp->trans_qp.base;
 
 	if (qp->state != IB_QPS_RESET) {
 		if (qp->ibqp.qp_type != IB_QPT_RAW_PACKET &&
-		    !(qp->flags & MLX5_IB_QP_UNDERLAY)) {
+		    !(qp->flags & IB_QP_CREATE_SOURCE_QPN)) {
 			err = mlx5_core_qp_modify(dev, MLX5_CMD_OP_2RST_QP, 0,
 						  NULL, &base->mqp);
 		} else {
@@ -2508,7 +2508,7 @@ static void destroy_qp_common(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	spin_unlock_irqrestore(&dev->reset_flow_resource_lock, flags);
 
 	if (qp->ibqp.qp_type == IB_QPT_RAW_PACKET ||
-	    qp->flags & MLX5_IB_QP_UNDERLAY) {
+	    qp->flags & IB_QP_CREATE_SOURCE_QPN) {
 		destroy_raw_packet_qp(dev, qp);
 	} else {
 		err = mlx5_core_destroy_qp(dev, &base->mqp);
@@ -3550,7 +3550,7 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 	if ((cur_state == IB_QPS_RESET) && (new_state == IB_QPS_INIT)) {
 		if ((ibqp->qp_type == IB_QPT_RC) ||
 		    (ibqp->qp_type == IB_QPT_UD &&
-		     !(qp->flags & MLX5_IB_QP_SQPN_QP1)) ||
+		     !(qp->flags & MLX5_IB_QP_CREATE_SQPN_QP1)) ||
 		    (ibqp->qp_type == IB_QPT_UC) ||
 		    (ibqp->qp_type == IB_QPT_RAW_PACKET) ||
 		    (ibqp->qp_type == IB_QPT_XRC_INI) ||
@@ -3567,7 +3567,7 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 	if (is_sqp(ibqp->qp_type)) {
 		context->mtu_msgmax = (IB_MTU_256 << 5) | 8;
 	} else if ((ibqp->qp_type == IB_QPT_UD &&
-		    !(qp->flags & MLX5_IB_QP_UNDERLAY)) ||
+		    !(qp->flags & IB_QP_CREATE_SOURCE_QPN)) ||
 		   ibqp->qp_type == MLX5_IB_QPT_REG_UMR) {
 		context->mtu_msgmax = (IB_MTU_4096 << 5) | 12;
 	} else if (attr_mask & IB_QP_PATH_MTU) {
@@ -3672,7 +3672,7 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 			       qp->port) - 1;
 
 		/* Underlay port should be used - index 0 function per port */
-		if (qp->flags & MLX5_IB_QP_UNDERLAY)
+		if (qp->flags & IB_QP_CREATE_SOURCE_QPN)
 			port_num = 0;
 
 		if (ibqp->counter)
@@ -3686,7 +3686,7 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 	if (!ibqp->uobject && cur_state == IB_QPS_RESET && new_state == IB_QPS_INIT)
 		context->sq_crq_size |= cpu_to_be16(1 << 4);
 
-	if (qp->flags & MLX5_IB_QP_SQPN_QP1)
+	if (qp->flags & MLX5_IB_QP_CREATE_SQPN_QP1)
 		context->deth_sqpn = cpu_to_be32(1);
 
 	mlx5_cur = to_mlx5_state(cur_state);
@@ -3703,7 +3703,7 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 	optpar &= opt_mask[mlx5_cur][mlx5_new][mlx5_st];
 
 	if (qp->ibqp.qp_type == IB_QPT_RAW_PACKET ||
-	    qp->flags & MLX5_IB_QP_UNDERLAY) {
+	    qp->flags & IB_QP_CREATE_SOURCE_QPN) {
 		struct mlx5_modify_raw_qp_param raw_qp_param = {};
 
 		raw_qp_param.operation = op;
@@ -3999,7 +3999,7 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		port = attr_mask & IB_QP_PORT ? attr->port_num : qp->port;
 	}
 
-	if (qp->flags & MLX5_IB_QP_UNDERLAY) {
+	if (qp->flags & IB_QP_CREATE_SOURCE_QPN) {
 		if (attr_mask & ~(IB_QP_STATE | IB_QP_CUR_STATE)) {
 			mlx5_ib_dbg(dev, "invalid attr_mask 0x%x when underlay QP is used\n",
 				    attr_mask);
@@ -5831,7 +5831,7 @@ int mlx5_ib_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	mutex_lock(&qp->mutex);
 
 	if (qp->ibqp.qp_type == IB_QPT_RAW_PACKET ||
-	    qp->flags & MLX5_IB_QP_UNDERLAY) {
+	    qp->flags & IB_QP_CREATE_SOURCE_QPN) {
 		err = query_raw_packet_qp_state(dev, qp, &raw_packet_qp_state);
 		if (err)
 			goto out;
@@ -5866,16 +5866,16 @@ int mlx5_ib_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	qp_init_attr->cap	     = qp_attr->cap;
 
 	qp_init_attr->create_flags = 0;
-	if (qp->flags & MLX5_IB_QP_BLOCK_MULTICAST_LOOPBACK)
+	if (qp->flags & IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK)
 		qp_init_attr->create_flags |= IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK;
 
-	if (qp->flags & MLX5_IB_QP_CROSS_CHANNEL)
+	if (qp->flags & IB_QP_CREATE_CROSS_CHANNEL)
 		qp_init_attr->create_flags |= IB_QP_CREATE_CROSS_CHANNEL;
-	if (qp->flags & MLX5_IB_QP_MANAGED_SEND)
+	if (qp->flags & IB_QP_CREATE_MANAGED_SEND)
 		qp_init_attr->create_flags |= IB_QP_CREATE_MANAGED_SEND;
-	if (qp->flags & MLX5_IB_QP_MANAGED_RECV)
+	if (qp->flags & IB_QP_CREATE_MANAGED_RECV)
 		qp_init_attr->create_flags |= IB_QP_CREATE_MANAGED_RECV;
-	if (qp->flags & MLX5_IB_QP_SQPN_QP1)
+	if (qp->flags & MLX5_IB_QP_CREATE_SQPN_QP1)
 		qp_init_attr->create_flags |= MLX5_IB_QP_CREATE_SQPN_QP1;
 
 	qp_init_attr->sq_sig_type = qp->sq_signal_bits & MLX5_WQE_CTRL_CQ_UPDATE ?
-- 
2.25.3

