Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49851E2171
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2020 13:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388971AbgEZLzG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 May 2020 07:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388967AbgEZLzG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 May 2020 07:55:06 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A34B2073B;
        Tue, 26 May 2020 11:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590494105;
        bh=EW5iSgOdcdKB1vDJadp8D9KlbwicYuj8DCUdZ8fwPW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tHq4zFHO4W76eAd65/oWxke1ExyNouIqCiVFizLtTB3nFo4CG2j+03NMqNzzcbgir
         WLZXJQXNwETrRXio1iVQRM/aHBzZ9y+LsHXsM836jocg5OTtNPQwXtb0HHPGriLEIA
         AdFH1av3Li9gS2z3wYvaq4RPxBmvExX9bqq++J6M=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next v3 7/8] RDMA/mlx5: Set ECE options during modify QP
Date:   Tue, 26 May 2020 14:54:39 +0300
Message-Id: <20200526115440.205922-8-leon@kernel.org>
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

The most common way to set ECE option will be during
modify QP command in INIT2RTR, RTR2RTS and RTS2RTS stages,
so update mlx5 to support it.

The new bit in the comp_mask is needed to mark that kernel supports
ECE and can receive data instead of "reserved" field in the
struct mlx5_ib_modify_qp.

Reviewed-by: Mark Zhang <markz@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c |  3 +++
 drivers/infiniband/hw/mlx5/qp.c   | 21 ++++++++++++---------
 drivers/infiniband/hw/mlx5/qp.h   |  2 +-
 drivers/infiniband/hw/mlx5/qpc.c  | 11 +++++++----
 include/uapi/rdma/mlx5-abi.h      |  3 ++-
 5 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 6094ab2f4cd7..570c519ca530 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1971,6 +1971,9 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 		resp.response_length += sizeof(resp.dump_fill_mkey);
 	}
 
+	if (MLX5_CAP_GEN(dev->mdev, ece_support))
+		resp.comp_mask |= MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_ECE;
+
 	err = ib_copy_to_udata(udata, &resp, resp.response_length);
 	if (err)
 		goto out_mdev;
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index a24176a8ec83..bfa0f7e43e3b 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2353,7 +2353,7 @@ static void destroy_qp_common(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 		if (qp->ibqp.qp_type != IB_QPT_RAW_PACKET &&
 		    !(qp->flags & IB_QP_CREATE_SOURCE_QPN)) {
 			err = mlx5_core_qp_modify(dev, MLX5_CMD_OP_2RST_QP, 0,
-						  NULL, &base->mqp);
+						  NULL, &base->mqp, NULL);
 		} else {
 			struct mlx5_modify_raw_qp_param raw_qp_param = {
 				.operation = MLX5_CMD_OP_2RST_QP
@@ -3978,7 +3978,10 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 
 		err = modify_raw_packet_qp(dev, qp, &raw_qp_param, tx_affinity);
 	} else {
-		err = mlx5_core_qp_modify(dev, op, optpar, qpc, &base->mqp);
+		u32 ece = MLX5_CAP_GEN(dev->mdev, ece_support) ?
+				  ucmd->ece_options : 0;
+		err = mlx5_core_qp_modify(dev, op, optpar, qpc, &base->mqp,
+					  &ece);
 	}
 
 	if (err)
@@ -4131,7 +4134,6 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
 		set_id = mlx5_ib_get_counters_id(dev, attr->port_num - 1);
 		MLX5_SET(dctc, dctc, counter_set_id, set_id);
-
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_RTR) {
 		struct mlx5_ib_modify_qp_resp resp = {};
 		u32 out[MLX5_ST_SZ_DW(create_dct_out)] = {0};
@@ -4182,7 +4184,6 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	struct mlx5_ib_modify_qp ucmd = {};
 	enum ib_qp_type qp_type;
 	enum ib_qp_state cur_state, new_state;
-	size_t required_cmd_sz;
 	int err = -EINVAL;
 	int port;
 
@@ -4190,9 +4191,7 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		return -ENOSYS;
 
 	if (udata && udata->inlen) {
-		required_cmd_sz = offsetof(typeof(ucmd), reserved) +
-			sizeof(ucmd.reserved);
-		if (udata->inlen < required_cmd_sz)
+		if (udata->inlen < offsetofend(typeof(ucmd), ece_options))
 			return -EINVAL;
 
 		if (udata->inlen > sizeof(ucmd) &&
@@ -4205,10 +4204,10 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 			return -EFAULT;
 
 		if (ucmd.comp_mask ||
-		    memchr_inv(&ucmd.reserved, 0, sizeof(ucmd.reserved)) ||
 		    memchr_inv(&ucmd.burst_info.reserved, 0,
 			       sizeof(ucmd.burst_info.reserved)))
 			return -EOPNOTSUPP;
+
 	}
 
 	if (unlikely(ibqp->qp_type == IB_QPT_GSI))
@@ -4217,8 +4216,12 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	qp_type = (unlikely(ibqp->qp_type == MLX5_IB_QPT_HW_GSI)) ? IB_QPT_GSI :
 								    qp->type;
 
-	if (qp_type == MLX5_IB_QPT_DCT)
+	if (qp_type == MLX5_IB_QPT_DCT) {
+		if (memchr_inv(&ucmd.ece_options, 0, sizeof(ucmd.ece_options)))
+			return -EOPNOTSUPP;
+
 		return mlx5_ib_modify_dct(ibqp, attr, attr_mask, udata);
+	}
 
 	mutex_lock(&qp->mutex);
 
diff --git a/drivers/infiniband/hw/mlx5/qp.h b/drivers/infiniband/hw/mlx5/qp.h
index 795c21f88962..82ea2b94dfa6 100644
--- a/drivers/infiniband/hw/mlx5/qp.h
+++ b/drivers/infiniband/hw/mlx5/qp.h
@@ -16,7 +16,7 @@ int mlx5_core_create_dct(struct mlx5_ib_dev *dev, struct mlx5_core_dct *qp,
 int mlx5_qpc_create_qp(struct mlx5_ib_dev *dev, struct mlx5_core_qp *qp,
 		       u32 *in, int inlen, u32 *out);
 int mlx5_core_qp_modify(struct mlx5_ib_dev *dev, u16 opcode, u32 opt_param_mask,
-			void *qpc, struct mlx5_core_qp *qp);
+			void *qpc, struct mlx5_core_qp *qp, u32 *ece);
 int mlx5_core_destroy_qp(struct mlx5_ib_dev *dev, struct mlx5_core_qp *qp);
 int mlx5_core_destroy_dct(struct mlx5_ib_dev *dev, struct mlx5_core_dct *dct);
 int mlx5_core_qp_query(struct mlx5_ib_dev *dev, struct mlx5_core_qp *qp,
diff --git a/drivers/infiniband/hw/mlx5/qpc.c b/drivers/infiniband/hw/mlx5/qpc.c
index 69c80859a6ee..d61bc1a88925 100644
--- a/drivers/infiniband/hw/mlx5/qpc.c
+++ b/drivers/infiniband/hw/mlx5/qpc.c
@@ -343,7 +343,7 @@ static void mbox_free(struct mbox_info *mbox)
 
 static int modify_qp_mbox_alloc(struct mlx5_core_dev *dev, u16 opcode, int qpn,
 				u32 opt_param_mask, void *qpc,
-				struct mbox_info *mbox, u16 uid)
+				struct mbox_info *mbox, u16 uid, u32 ece)
 {
 	mbox->out = NULL;
 	mbox->in = NULL;
@@ -391,18 +391,21 @@ static int modify_qp_mbox_alloc(struct mlx5_core_dev *dev, u16 opcode, int qpn,
 			return -ENOMEM;
 		MOD_QP_IN_SET_QPC(init2rtr_qp, mbox->in, opcode, qpn,
 				  opt_param_mask, qpc, uid);
+		MLX5_SET(init2rtr_qp_in, mbox->in, ece, ece);
 		break;
 	case MLX5_CMD_OP_RTR2RTS_QP:
 		if (MBOX_ALLOC(mbox, rtr2rts_qp))
 			return -ENOMEM;
 		MOD_QP_IN_SET_QPC(rtr2rts_qp, mbox->in, opcode, qpn,
 				  opt_param_mask, qpc, uid);
+		MLX5_SET(rtr2rts_qp_in, mbox->in, ece, ece);
 		break;
 	case MLX5_CMD_OP_RTS2RTS_QP:
 		if (MBOX_ALLOC(mbox, rts2rts_qp))
 			return -ENOMEM;
 		MOD_QP_IN_SET_QPC(rts2rts_qp, mbox->in, opcode, qpn,
 				  opt_param_mask, qpc, uid);
+		MLX5_SET(rts2rts_qp_in, mbox->in, ece, ece);
 		break;
 	case MLX5_CMD_OP_SQERR2RTS_QP:
 		if (MBOX_ALLOC(mbox, sqerr2rts_qp))
@@ -423,13 +426,13 @@ static int modify_qp_mbox_alloc(struct mlx5_core_dev *dev, u16 opcode, int qpn,
 }
 
 int mlx5_core_qp_modify(struct mlx5_ib_dev *dev, u16 opcode, u32 opt_param_mask,
-			void *qpc, struct mlx5_core_qp *qp)
+			void *qpc, struct mlx5_core_qp *qp, u32 *ece)
 {
 	struct mbox_info mbox;
 	int err;
 
-	err = modify_qp_mbox_alloc(dev->mdev, opcode, qp->qpn,
-				   opt_param_mask, qpc, &mbox, qp->uid);
+	err = modify_qp_mbox_alloc(dev->mdev, opcode, qp->qpn, opt_param_mask,
+				   qpc, &mbox, qp->uid, (ece) ? *ece : 0);
 	if (err)
 		return err;
 
diff --git a/include/uapi/rdma/mlx5-abi.h b/include/uapi/rdma/mlx5-abi.h
index bc9d9e3cb369..24e29a678177 100644
--- a/include/uapi/rdma/mlx5-abi.h
+++ b/include/uapi/rdma/mlx5-abi.h
@@ -100,6 +100,7 @@ struct mlx5_ib_alloc_ucontext_req_v2 {
 enum mlx5_ib_alloc_ucontext_resp_mask {
 	MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_CORE_CLOCK_OFFSET = 1UL << 0,
 	MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_DUMP_FILL_MKEY    = 1UL << 1,
+	MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_ECE               = 1UL << 2,
 };
 
 enum mlx5_user_cmds_supp_uhw {
@@ -422,7 +423,7 @@ struct mlx5_ib_burst_info {
 struct mlx5_ib_modify_qp {
 	__u32			   comp_mask;
 	struct mlx5_ib_burst_info  burst_info;
-	__u32			   reserved;
+	__u32			   ece_options;
 };
 
 struct mlx5_ib_modify_qp_resp {
-- 
2.26.2

