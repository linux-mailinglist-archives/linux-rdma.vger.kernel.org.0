Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA921DAD74
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 10:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgETI3s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 May 2020 04:29:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgETI3s (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 May 2020 04:29:48 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0296D206C3;
        Wed, 20 May 2020 08:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589963387;
        bh=7Q81X9m8aE13vkoXtZ+4qMr/5rTAmqp70E1VoCpJrVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UNsUZ0MqmXBGaJjLxAKfRh5yXbY8tJccCF4tW9JEoaQYo/Yq/7GPnBnxSXNqzlY6L
         2xsnBotD01nuaQPUZ/Ssd3XYpuUkRqZuKeSDJt4lhww72RADH4l9IkHT4Ak18fSG8o
         ChiWFqyJrIEMxRUEpG4+KcDnKnCGZ5Qh1RYEDugA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 7/8] RDMA/mlx5: Set ECE options during modify QP
Date:   Wed, 20 May 2020 11:29:18 +0300
Message-Id: <20200520082919.440939-8-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520082919.440939-1-leon@kernel.org>
References: <20200520082919.440939-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The most common way to set ECE option will be during
modify QP command in INIT2RTR, RTR2RTSi and RTS2RTS stages,
so update mlx5 to support it.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c  | 29 +++++++++++++++++++----------
 drivers/infiniband/hw/mlx5/qp.h  |  2 +-
 drivers/infiniband/hw/mlx5/qpc.c | 11 +++++++----
 include/uapi/rdma/mlx5-abi.h     |  2 +-
 4 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 7d974d9c03d3..ad7d31a82423 100644
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
@@ -3982,7 +3982,11 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 
 		err = modify_raw_packet_qp(dev, qp, &raw_qp_param, tx_affinity);
 	} else {
-		err = mlx5_core_qp_modify(dev, op, optpar, qpc, &base->mqp);
+		u32 ece = MLX5_CAP_GEN(dev->mdev, ece_support) ?
+				  ucmd->ece_options :
+				  0;
+		err = mlx5_core_qp_modify(dev, op, optpar, qpc, &base->mqp,
+					  &ece);
 	}
 
 	if (err)
@@ -4087,7 +4091,8 @@ static bool modify_dci_qp_is_ok(enum ib_qp_state cur_state, enum ib_qp_state new
  * Other transitions and attributes are illegal
  */
 static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
-			      int attr_mask, struct ib_udata *udata)
+			      int attr_mask, struct mlx5_ib_modify_qp *ucmd,
+			      struct ib_udata *udata)
 {
 	struct mlx5_ib_qp *qp = to_mqp(ibqp);
 	struct mlx5_ib_dev *dev = to_mdev(ibqp->device);
@@ -4103,6 +4108,15 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	new_state = attr->qp_state;
 
 	dctc = MLX5_ADDR_OF(create_dct_in, qp->dct.in, dct_context_entry);
+	if (MLX5_CAP_GEN(dev->mdev, ece_support) && ucmd->ece_options)
+		/*
+		 * DCT doesn't initialize QP till modify command is executed,
+		 * so we need to overwrite previously set ECE field if user
+		 * provided any value except zero, which means not set/not
+		 * valid.
+		 */
+		MLX5_SET(dctc, dctc, ece, ucmd->ece_options);
+
 	if (cur_state == IB_QPS_RESET && new_state == IB_QPS_INIT) {
 		u16 set_id;
 
@@ -4135,7 +4149,6 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
 		set_id = mlx5_ib_get_counters_id(dev, attr->port_num - 1);
 		MLX5_SET(dctc, dctc, counter_set_id, set_id);
-
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_RTR) {
 		struct mlx5_ib_modify_qp_resp resp = {};
 		u32 out[MLX5_ST_SZ_DW(create_dct_out)] = {0};
@@ -4186,7 +4199,6 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	struct mlx5_ib_modify_qp ucmd = {};
 	enum ib_qp_type qp_type;
 	enum ib_qp_state cur_state, new_state;
-	size_t required_cmd_sz;
 	int err = -EINVAL;
 	int port;
 
@@ -4194,9 +4206,7 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		return -ENOSYS;
 
 	if (udata && udata->inlen) {
-		required_cmd_sz = offsetof(typeof(ucmd), reserved) +
-			sizeof(ucmd.reserved);
-		if (udata->inlen < required_cmd_sz)
+		if (udata->inlen < sizeof(ucmd))
 			return -EINVAL;
 
 		if (udata->inlen > sizeof(ucmd) &&
@@ -4209,7 +4219,6 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 			return -EFAULT;
 
 		if (ucmd.comp_mask ||
-		    memchr_inv(&ucmd.reserved, 0, sizeof(ucmd.reserved)) ||
 		    memchr_inv(&ucmd.burst_info.reserved, 0,
 			       sizeof(ucmd.burst_info.reserved)))
 			return -EOPNOTSUPP;
@@ -4222,7 +4231,7 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 								    qp->type;
 
 	if (qp_type == MLX5_IB_QPT_DCT)
-		return mlx5_ib_modify_dct(ibqp, attr, attr_mask, udata);
+		return mlx5_ib_modify_dct(ibqp, attr, attr_mask, &ucmd, udata);
 
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
index bc9d9e3cb369..df40e831029b 100644
--- a/include/uapi/rdma/mlx5-abi.h
+++ b/include/uapi/rdma/mlx5-abi.h
@@ -422,7 +422,7 @@ struct mlx5_ib_burst_info {
 struct mlx5_ib_modify_qp {
 	__u32			   comp_mask;
 	struct mlx5_ib_burst_info  burst_info;
-	__u32			   reserved;
+	__u32			   ece_options;
 };
 
 struct mlx5_ib_modify_qp_resp {
-- 
2.26.2

