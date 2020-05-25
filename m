Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE111E1390
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 19:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389633AbgEYRoO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 13:44:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389401AbgEYRoN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 May 2020 13:44:13 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2BF62078B;
        Mon, 25 May 2020 17:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590428652;
        bh=3w9EHrWnwxGPmckA1/aq/NId8EtHAO8uHrW2bDoh4Ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bEnLOvl5cJ2m/0WsgoM6kfpe5gUq4484busp0Pe/SRDiMV3PF2V7vI0UAa761jExJ
         tj7x2OhFaMRV8cC63HI/J6c5kXisXjm3ztwhl0FfRfP8WZ/got6+CpOtTxHwe67Zn6
         8YzhcLxSlR97ax09EizHm8DmltJ75V+YT6xHZBm8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next v2 2/9] RDMA/mlx5: Get ECE options from FW during create QP
Date:   Mon, 25 May 2020 20:43:54 +0300
Message-Id: <20200525174401.71152-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525174401.71152-1-leon@kernel.org>
References: <20200525174401.71152-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Supported ECE options are returned from FW in the create_qp phase
and zero means that field is not valid. Such default value allows
us to reuse reserved field without worries about comp_mask.

Update create QP API to return ECE options.

Reviewed-by: Mark Zhang <markz@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c  | 16 +++++++++++-----
 drivers/infiniband/hw/mlx5/qp.h  |  4 ++--
 drivers/infiniband/hw/mlx5/qpc.c |  8 ++++----
 include/uapi/rdma/mlx5-abi.h     |  2 +-
 4 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 2e28752e8cd2..be7289c480f7 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1842,6 +1842,7 @@ static int create_xrc_tgt_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	struct ib_qp_init_attr *attr = params->attr;
 	u32 uidx = params->uidx;
 	struct mlx5_ib_resources *devr = &dev->devr;
+	u32 out[MLX5_ST_SZ_DW(create_qp_out)] = {};
 	int inlen = MLX5_ST_SZ_BYTES(create_qp_in);
 	struct mlx5_core_dev *mdev = dev->mdev;
 	struct mlx5_ib_qp_base *base;
@@ -1894,13 +1895,14 @@ static int create_xrc_tgt_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	}
 
 	base = &qp->trans_qp.base;
-	err = mlx5_core_create_qp(dev, &base->mqp, in, inlen);
+	err = mlx5_qpc_create_qp(dev, &base->mqp, in, inlen, out);
 	kvfree(in);
 	if (err)
 		return err;
 
 	base->container_mibqp = qp;
 	base->mqp.event = mlx5_ib_qp_event;
+	params->resp.ece_options = MLX5_GET(create_qp_out, out, ece);
 
 	spin_lock_irqsave(&dev->reset_flow_resource_lock, flags);
 	list_add_tail(&qp->qps_list, &dev->qp_list);
@@ -1916,6 +1918,7 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 {
 	struct ib_qp_init_attr *init_attr = params->attr;
 	struct mlx5_ib_create_qp *ucmd = params->ucmd;
+	u32 out[MLX5_ST_SZ_DW(create_qp_out)] = {};
 	struct ib_udata *udata = params->udata;
 	u32 uidx = params->uidx;
 	struct mlx5_ib_resources *devr = &dev->devr;
@@ -2065,7 +2068,7 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		err = create_raw_packet_qp(dev, qp, in, inlen, pd, udata,
 					   &params->resp);
 	} else
-		err = mlx5_core_create_qp(dev, &base->mqp, in, inlen);
+		err = mlx5_qpc_create_qp(dev, &base->mqp, in, inlen, out);
 
 	kvfree(in);
 	if (err)
@@ -2073,6 +2076,7 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 
 	base->container_mibqp = qp;
 	base->mqp.event = mlx5_ib_qp_event;
+	params->resp.ece_options = MLX5_GET(create_qp_out, out, ece);
 
 	get_cqs(qp->type, init_attr->send_cq, init_attr->recv_cq,
 		&send_cq, &recv_cq);
@@ -2105,6 +2109,7 @@ static int create_kernel_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	struct ib_qp_init_attr *attr = params->attr;
 	u32 uidx = params->uidx;
 	struct mlx5_ib_resources *devr = &dev->devr;
+	u32 out[MLX5_ST_SZ_DW(create_qp_out)] = {};
 	int inlen = MLX5_ST_SZ_BYTES(create_qp_in);
 	struct mlx5_core_dev *mdev = dev->mdev;
 	struct mlx5_ib_cq *send_cq;
@@ -2195,7 +2200,7 @@ static int create_kernel_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	if (qp->flags & IB_QP_CREATE_IPOIB_UD_LSO)
 		MLX5_SET(qpc, qpc, ulp_stateless_offload_mode, 1);
 
-	err = mlx5_core_create_qp(dev, &base->mqp, in, inlen);
+	err = mlx5_qpc_create_qp(dev, &base->mqp, in, inlen, out);
 	kvfree(in);
 	if (err)
 		goto err_create;
@@ -2779,12 +2784,13 @@ static int create_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		qp->ibqp.qp_num = qp->trans_qp.base.mqp.qpn;
 
 	mlx5_ib_dbg(dev,
-		"QP type %d, ib qpn 0x%X, mlx qpn 0x%x, rcqn 0x%x, scqn 0x%x\n",
+		"QP type %d, ib qpn 0x%X, mlx qpn 0x%x, rcqn 0x%x, scqn 0x%x, ece 0x%x\n",
 		qp->type, qp->ibqp.qp_num, qp->trans_qp.base.mqp.qpn,
 		params->attr->recv_cq ? to_mcq(params->attr->recv_cq)->mcq.cqn :
 					-1,
 		params->attr->send_cq ? to_mcq(params->attr->send_cq)->mcq.cqn :
-					-1);
+					-1,
+		params->resp.ece_options);
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/mlx5/qp.h b/drivers/infiniband/hw/mlx5/qp.h
index ad9d76e3e18a..795c21f88962 100644
--- a/drivers/infiniband/hw/mlx5/qp.h
+++ b/drivers/infiniband/hw/mlx5/qp.h
@@ -13,8 +13,8 @@ void mlx5_cleanup_qp_table(struct mlx5_ib_dev *dev);
 
 int mlx5_core_create_dct(struct mlx5_ib_dev *dev, struct mlx5_core_dct *qp,
 			 u32 *in, int inlen, u32 *out, int outlen);
-int mlx5_core_create_qp(struct mlx5_ib_dev *dev, struct mlx5_core_qp *qp,
-			u32 *in, int inlen);
+int mlx5_qpc_create_qp(struct mlx5_ib_dev *dev, struct mlx5_core_qp *qp,
+		       u32 *in, int inlen, u32 *out);
 int mlx5_core_qp_modify(struct mlx5_ib_dev *dev, u16 opcode, u32 opt_param_mask,
 			void *qpc, struct mlx5_core_qp *qp);
 int mlx5_core_destroy_qp(struct mlx5_ib_dev *dev, struct mlx5_core_qp *qp);
diff --git a/drivers/infiniband/hw/mlx5/qpc.c b/drivers/infiniband/hw/mlx5/qpc.c
index ea62735042f0..69c80859a6ee 100644
--- a/drivers/infiniband/hw/mlx5/qpc.c
+++ b/drivers/infiniband/hw/mlx5/qpc.c
@@ -236,16 +236,16 @@ int mlx5_core_create_dct(struct mlx5_ib_dev *dev, struct mlx5_core_dct *dct,
 	return err;
 }
 
-int mlx5_core_create_qp(struct mlx5_ib_dev *dev, struct mlx5_core_qp *qp,
-			u32 *in, int inlen)
+int mlx5_qpc_create_qp(struct mlx5_ib_dev *dev, struct mlx5_core_qp *qp,
+		       u32 *in, int inlen, u32 *out)
 {
-	u32 out[MLX5_ST_SZ_DW(create_qp_out)] = {};
 	u32 din[MLX5_ST_SZ_DW(destroy_qp_in)] = {};
 	int err;
 
 	MLX5_SET(create_qp_in, in, opcode, MLX5_CMD_OP_CREATE_QP);
 
-	err = mlx5_cmd_exec(dev->mdev, in, inlen, out, sizeof(out));
+	err = mlx5_cmd_exec(dev->mdev, in, inlen, out,
+			    MLX5_ST_SZ_BYTES(create_qp_out));
 	if (err)
 		return err;
 
diff --git a/include/uapi/rdma/mlx5-abi.h b/include/uapi/rdma/mlx5-abi.h
index df1cc3641bda..106fbb3bec6a 100644
--- a/include/uapi/rdma/mlx5-abi.h
+++ b/include/uapi/rdma/mlx5-abi.h
@@ -371,7 +371,7 @@ enum mlx5_ib_create_qp_resp_mask {
 
 struct mlx5_ib_create_qp_resp {
 	__u32	bfreg_index;
-	__u32   reserved;
+	__u32   ece_options;
 	__u32	comp_mask;
 	__u32	tirn;
 	__u32	tisn;
-- 
2.26.2

