Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB6D1EBC26
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2020 14:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgFBM4D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jun 2020 08:56:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgFBM4C (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 2 Jun 2020 08:56:02 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DAE820663;
        Tue,  2 Jun 2020 12:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591102562;
        bh=VsV4SNR7MJiPkDiayTCgN8C4JSDRlQ3ItGt3f9saf0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E0ViGWlEzMpz1GYnej0HHgl+PKOReJOb14a7ybH+xY6ZUkE4SUej6MsvqHRJcL/cM
         mxxDr7q83cAx+On2NRoJnDyhp+Me0TO8oyx+jyDW8PwBFFJOhkVCRyeB62vv3AMZdQ
         njTtYnyIulBLJTy0YR3EvlKX/1WyGvfsj1V06F/U=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH mlx5-next 3/3] RDMA/mlx5: Return ECE DC support
Date:   Tue,  2 Jun 2020 15:55:48 +0300
Message-Id: <20200602125548.172654-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200602125548.172654-1-leon@kernel.org>
References: <20200602125548.172654-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The DC QPs are many-to-one QP types that means that first connection
will establish ECE options that coming connections should follow.
Due to this property, the ECE code was removed between first [1] and
second [2] ECE submissions.

This patch returns the dropped code, because ECE is a property of a
connection and like any other connection users are needed to manage
this data. Allow them to set ECE parameter for DC too and avoid need
of having compatibility flag for the DC ECE.

[1]
https://lore.kernel.org/linux-rdma/20200523132243.817936-1-leon@kernel.org/
[2]
https://lore.kernel.org/linux-rdma/20200525174401.71152-1-leon@kernel.org/

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 45 +++++++++++++++++++++++----------
 include/linux/mlx5/mlx5_ifc.h   |  5 ++--
 2 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 494e305cf761..d74c664bedc9 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2404,7 +2404,8 @@ static void destroy_qp_common(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	destroy_qp(dev, qp, base, udata);
 }

-static int create_dct(struct ib_pd *pd, struct mlx5_ib_qp *qp,
+static int create_dct(struct mlx5_ib_dev *dev, struct ib_pd *pd,
+		      struct mlx5_ib_qp *qp,
 		      struct mlx5_create_qp_params *params)
 {
 	struct ib_qp_init_attr *attr = params->attr;
@@ -2423,6 +2424,8 @@ static int create_dct(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 	MLX5_SET(dctc, dctc, cqn, to_mcq(attr->recv_cq)->mcq.cqn);
 	MLX5_SET64(dctc, dctc, dc_access_key, ucmd->access_key);
 	MLX5_SET(dctc, dctc, user_index, uidx);
+	if (MLX5_CAP_GEN(dev->mdev, ece_support))
+		MLX5_SET(dctc, dctc, ece, ucmd->ece_options);

 	if (qp->flags_en & MLX5_QP_FLAG_SCATTER_CQE) {
 		int rcqe_sz = mlx5_ib_get_cqe_size(attr->recv_cq);
@@ -2768,7 +2771,7 @@ static int create_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	}

 	if (qp->type == MLX5_IB_QPT_DCT) {
-		err = create_dct(pd, qp, params);
+		err = create_dct(dev, pd, qp, params);
 		goto out;
 	}

@@ -2882,9 +2885,8 @@ static int check_ucmd_data(struct mlx5_ib_dev *dev,
 		 */
 		last = sizeof(struct mlx5_ib_create_qp_rss);
 	else
-		/* IB_QPT_RAW_PACKET and IB_QPT_DRIVER don't have ECE data */
+		/* IB_QPT_RAW_PACKET doesn't have ECE data */
 		switch (attr->qp_type) {
-		case IB_QPT_DRIVER:
 		case IB_QPT_RAW_PACKET:
 			last = offsetof(struct mlx5_ib_create_qp, ece_options);
 			break;
@@ -4095,7 +4097,8 @@ static bool modify_dci_qp_is_ok(enum ib_qp_state cur_state, enum ib_qp_state new
  * Other transitions and attributes are illegal
  */
 static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
-			      int attr_mask, struct ib_udata *udata)
+			      int attr_mask, struct mlx5_ib_modify_qp *ucmd,
+			      struct ib_udata *udata)
 {
 	struct mlx5_ib_qp *qp = to_mqp(ibqp);
 	struct mlx5_ib_dev *dev = to_mdev(ibqp->device);
@@ -4111,6 +4114,15 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
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

@@ -4145,14 +4157,21 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
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
 		resp.response_length = min_resp_len;

+		/*
+		 * If we don't have enough space for the ECE options,
+		 * simply indicate it with resp.response_length.
+		 */
+		resp.response_length = (udata->outlen < sizeof(resp)) ?
+					       min_resp_len :
+					       sizeof(resp);
+
 		required |= IB_QP_MIN_RNR_TIMER | IB_QP_AV | IB_QP_PATH_MTU;
 		if (!is_valid_mask(attr_mask, required, 0))
 			return -EINVAL;
@@ -4169,6 +4188,8 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		if (err)
 			return err;
 		resp.dctn = qp->dct.mdct.mqp.qpn;
+		if (MLX5_CAP_GEN(dev->mdev, ece_support))
+			resp.ece_options = MLX5_GET(create_dct_out, out, ece);
 		err = ib_copy_to_udata(udata, &resp, resp.response_length);
 		if (err) {
 			mlx5_core_destroy_dct(dev, &qp->dct.mdct);
@@ -4226,12 +4247,8 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	qp_type = (unlikely(ibqp->qp_type == MLX5_IB_QPT_HW_GSI)) ? IB_QPT_GSI :
 								    qp->type;

-	if (qp_type == MLX5_IB_QPT_DCT) {
-		if (memchr_inv(&ucmd.ece_options, 0, sizeof(ucmd.ece_options)))
-			return -EOPNOTSUPP;
-
-		return mlx5_ib_modify_dct(ibqp, attr, attr_mask, udata);
-	}
+	if (qp_type == MLX5_IB_QPT_DCT)
+		return mlx5_ib_modify_dct(ibqp, attr, attr_mask, &ucmd, udata);

 	mutex_lock(&qp->mutex);

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 87e2aba5e504..66aeaf113995 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -3693,7 +3693,8 @@ struct mlx5_ifc_dctc_bits {
 	u8         ecn[0x2];
 	u8         dscp[0x6];

-	u8         reserved_at_1c0[0x40];
+	u8         reserved_at_1c0[0x20];
+	u8         ece[0x20];
 };

 enum {
@@ -7945,7 +7946,7 @@ struct mlx5_ifc_create_dct_out_bits {
 	u8         reserved_at_40[0x8];
 	u8         dctn[0x18];

-	u8         reserved_at_60[0x20];
+	u8         ece[0x20];
 };

 struct mlx5_ifc_create_dct_in_bits {
--
2.26.2

