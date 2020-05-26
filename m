Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8AE11E2172
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2020 13:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388975AbgEZLzK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 May 2020 07:55:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388967AbgEZLzJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 May 2020 07:55:09 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 066FE20663;
        Tue, 26 May 2020 11:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590494108;
        bh=oS1Hmo6HPF8YEcsU8WkKky2AFD1+rf+mXi1vgx/6kHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rURfsRzgh5uTacMladY6ByrMTZUQMYr2FC7SJRq5RRHt1f+mIrLOXHoM1vVtNseIr
         wHoXeawz0GGpivXdf0gIBcTR3mug32x2yS7LHEqKh1ZkMqmr8OKqLEaLeoJ8pUz89Z
         hd2hbpv1A4kEO7h3yhgGnOCaCj648aHmtROuOFFg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next v3 8/8] RDMA/mlx5: Return ECE data after modify QP
Date:   Tue, 26 May 2020 14:54:40 +0300
Message-Id: <20200526115440.205922-9-leon@kernel.org>
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

After users sets the ECE option, FW will return the
agreed/supported bits through an output structures of
modify QP stages for regular QPs or through create QP
for the DCT.

Reviewed-by: Mark Zhang <markz@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c  | 25 +++++++++++++++++++++----
 drivers/infiniband/hw/mlx5/qpc.c | 25 +++++++++++++++++++++++++
 include/uapi/rdma/mlx5-abi.h     |  2 ++
 3 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index bfa0f7e43e3b..1988a0375696 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3708,6 +3708,7 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 			       enum ib_qp_state cur_state,
 			       enum ib_qp_state new_state,
 			       const struct mlx5_ib_modify_qp *ucmd,
+			       struct mlx5_ib_modify_qp_resp *resp,
 			       struct ib_udata *udata)
 {
 	static const u16 optab[MLX5_QP_NUM_STATE][MLX5_QP_NUM_STATE] = {
@@ -3978,10 +3979,15 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 
 		err = modify_raw_packet_qp(dev, qp, &raw_qp_param, tx_affinity);
 	} else {
-		u32 ece = MLX5_CAP_GEN(dev->mdev, ece_support) ?
-				  ucmd->ece_options : 0;
+		if (udata) {
+			/* For the kernel flows, the resp will stay zero */
+			resp->ece_options =
+				MLX5_CAP_GEN(dev->mdev, ece_support) ?
+					ucmd->ece_options : 0;
+			resp->response_length = sizeof(*resp);
+		}
 		err = mlx5_core_qp_modify(dev, op, optpar, qpc, &base->mqp,
-					  &ece);
+					  &resp->ece_options);
 	}
 
 	if (err)
@@ -4180,6 +4186,7 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		      int attr_mask, struct ib_udata *udata)
 {
 	struct mlx5_ib_dev *dev = to_mdev(ibqp->device);
+	struct mlx5_ib_modify_qp_resp resp = {};
 	struct mlx5_ib_qp *qp = to_mqp(ibqp);
 	struct mlx5_ib_modify_qp ucmd = {};
 	enum ib_qp_type qp_type;
@@ -4292,7 +4299,17 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	}
 
 	err = __mlx5_ib_modify_qp(ibqp, attr, attr_mask, cur_state,
-				  new_state, &ucmd, udata);
+				  new_state, &ucmd, &resp, udata);
+
+	/* resp.response_length is set in ECE supported flows only */
+	if (!err && resp.response_length &&
+	    udata->outlen >= resp.response_length)
+		/*
+		 * We don't check return value of the function below
+		 * on purpose, because it is unclear how to unwind the
+		 * error flow after QP was modified to the new state.
+		 */
+		ib_copy_to_udata(udata, &resp, resp.response_length);
 
 out:
 	mutex_unlock(&qp->mutex);
diff --git a/drivers/infiniband/hw/mlx5/qpc.c b/drivers/infiniband/hw/mlx5/qpc.c
index d61bc1a88925..c19d91d6dce8 100644
--- a/drivers/infiniband/hw/mlx5/qpc.c
+++ b/drivers/infiniband/hw/mlx5/qpc.c
@@ -341,6 +341,27 @@ static void mbox_free(struct mbox_info *mbox)
 	kfree(mbox->out);
 }
 
+static int get_ece_from_mbox(void *out, u16 opcode)
+{
+	int ece = 0;
+
+	switch (opcode) {
+	case MLX5_CMD_OP_INIT2RTR_QP:
+		ece = MLX5_GET(init2rtr_qp_out, out, ece);
+		break;
+	case MLX5_CMD_OP_RTR2RTS_QP:
+		ece = MLX5_GET(rtr2rts_qp_out, out, ece);
+		break;
+	case MLX5_CMD_OP_RTS2RTS_QP:
+		ece = MLX5_GET(rts2rts_qp_out, out, ece);
+		break;
+	default:
+		break;
+	}
+
+	return ece;
+}
+
 static int modify_qp_mbox_alloc(struct mlx5_core_dev *dev, u16 opcode, int qpn,
 				u32 opt_param_mask, void *qpc,
 				struct mbox_info *mbox, u16 uid, u32 ece)
@@ -438,6 +459,10 @@ int mlx5_core_qp_modify(struct mlx5_ib_dev *dev, u16 opcode, u32 opt_param_mask,
 
 	err = mlx5_cmd_exec(dev->mdev, mbox.in, mbox.inlen, mbox.out,
 			    mbox.outlen);
+
+	if (ece)
+		*ece = get_ece_from_mbox(mbox.out, opcode);
+
 	mbox_free(&mbox);
 	return err;
 }
diff --git a/include/uapi/rdma/mlx5-abi.h b/include/uapi/rdma/mlx5-abi.h
index 24e29a678177..27905a0268c9 100644
--- a/include/uapi/rdma/mlx5-abi.h
+++ b/include/uapi/rdma/mlx5-abi.h
@@ -429,6 +429,8 @@ struct mlx5_ib_modify_qp {
 struct mlx5_ib_modify_qp_resp {
 	__u32	response_length;
 	__u32	dctn;
+	__u32   ece_options;
+	__u32   reserved;
 };
 
 struct mlx5_ib_create_wq_resp {
-- 
2.26.2

