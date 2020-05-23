Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A911DF788
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2020 15:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387865AbgEWNXY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 23 May 2020 09:23:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387763AbgEWNXY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 23 May 2020 09:23:24 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C57D620727;
        Sat, 23 May 2020 13:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590240203;
        bh=F1lEPg0QQmrbA+VxPvxB6bGLMn08GzSm+g3arTqa8+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=geIumvFCSIeaLuxB5WAF08Kkmo/R5eYr6lRE0FvXKf5FIFOHWyJNqgK13rTJZOjcr
         ZiCSDchS/qOf/dlnuDTOldiVqMEbZTeslSCvXGUb9+0/FS0XGJJuqwckN0LCV6xIs2
         SlA9ueoLzonFOFFzlj1tmdALKgrw8VyYtmyrqjAQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next v1 9/9] RDMA/mlx5: Return ECE data after modify QP
Date:   Sat, 23 May 2020 16:22:43 +0300
Message-Id: <20200523132243.817936-10-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523132243.817936-1-leon@kernel.org>
References: <20200523132243.817936-1-leon@kernel.org>
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
 drivers/infiniband/hw/mlx5/qp.c  | 40 +++++++++++++++++++++++++-------
 drivers/infiniband/hw/mlx5/qpc.c | 25 ++++++++++++++++++++
 include/uapi/rdma/mlx5-abi.h     |  2 ++
 3 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index b4a8ab80c2f4..ee56e6913679 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3707,6 +3707,7 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 			       enum ib_qp_state cur_state,
 			       enum ib_qp_state new_state,
 			       const struct mlx5_ib_modify_qp *ucmd,
+			       struct mlx5_ib_modify_qp_resp *resp,
 			       struct ib_udata *udata)
 {
 	static const u16 optab[MLX5_QP_NUM_STATE][MLX5_QP_NUM_STATE] = {
@@ -3977,10 +3978,15 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 
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
@@ -4145,13 +4151,19 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		MLX5_SET(dctc, dctc, counter_set_id, set_id);
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_RTR) {
 		struct mlx5_ib_modify_qp_resp resp = {};
-		u32 out[MLX5_ST_SZ_DW(create_dct_out)] = {0};
-		u32 min_resp_len = offsetof(typeof(resp), dctn) +
-				   sizeof(resp.dctn);
+		u32 out[MLX5_ST_SZ_DW(create_dct_out)] = {};
+		u32 min_resp_len = offsetofend(typeof(resp), dctn);
 
 		if (udata->outlen < min_resp_len)
 			return -EINVAL;
-		resp.response_length = min_resp_len;
+
+		/*
+		 * If we don't have enough space for the ECE options,
+		 * simply indicate it with resp.response_length.
+		 */
+		resp.response_length = (udata->outlen < sizeof(resp)) ?
+					       min_resp_len :
+					       sizeof(resp);
 
 		required |= IB_QP_MIN_RNR_TIMER | IB_QP_AV | IB_QP_PATH_MTU;
 		if (!is_valid_mask(attr_mask, required, 0))
@@ -4169,6 +4181,7 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		if (err)
 			return err;
 		resp.dctn = qp->dct.mdct.mqp.qpn;
+		resp.ece_options = MLX5_GET(create_dct_out, out, ece);
 		err = ib_copy_to_udata(udata, &resp, resp.response_length);
 		if (err) {
 			mlx5_core_destroy_dct(dev, &qp->dct.mdct);
@@ -4189,6 +4202,7 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		      int attr_mask, struct ib_udata *udata)
 {
 	struct mlx5_ib_dev *dev = to_mdev(ibqp->device);
+	struct mlx5_ib_modify_qp_resp resp = {};
 	struct mlx5_ib_qp *qp = to_mqp(ibqp);
 	struct mlx5_ib_modify_qp ucmd = {};
 	enum ib_qp_type qp_type;
@@ -4296,7 +4310,17 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
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

