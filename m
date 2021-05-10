Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939D3378136
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 12:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhEJKYs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 06:24:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229684AbhEJKYq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 May 2021 06:24:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9849461139;
        Mon, 10 May 2021 10:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642222;
        bh=UlL3xu8ze1crKuBjtAWfdEX8VnAdio7kZzvezwuJCcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fS4WPTY2oiWmNo5pw9/4kDIE6TSA7/cBUFOXAbNlvJoWO5CMR+8gwZLILWOBj7yc/
         kD6py/lJgCNlQeAs0dtJt0OWkib8aaa4rRhmnujws+NoOASGU4/aTgGeXpsyoF1tTr
         /hIwD6Z7tUPvdu0J1Oy+kHHg5ILG7h1OLp1uZDCjA0X0wX15ZcRocHRTKMHNHaddOw
         XH4nSg+wiihVUod5QuFNvX8V8C5OTw5FyGjyiJ/b60X+pOKNyI56GM8ZOt/xaTbVCq
         xGTRwx7zX1nBeS7VYF1lAdDh828dflmwuHgghKB9Bd4d6mj5andWF6/v7kKweDSAPJ
         SoF7f4DgT/yQA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Sergey Gorenko <sergeygo@nvidia.com>,
        Evgenii Kochetov <evgeniik@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 1/2] RDMA/mlx5: Support SQD2RTS for modify QP
Date:   Mon, 10 May 2021 13:23:32 +0300
Message-Id: <ab4876360bfba0e9d64a5e8599438e32e0cb351e.1620641808.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620641808.git.leonro@nvidia.com>
References: <cover.1620641808.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Sergey Gorenko <sergeygo@nvidia.com>

The transition of the QP state from SQD to RTS is allowed by the IB
specification. The hardware also supports that, but it is not
implemented in mlx5_ib.

This commit adds SQD2RTS command to the modify QP in mlx5_ib to support
the missing feature. The feature is required by the signature pipelining
API that will be added to rdma-core.

Reviewed-by: Evgenii Kochetov <evgeniik@nvidia.com>
Signed-off-by: Sergey Gorenko <sergeygo@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c  | 12 ++++++++++++
 drivers/infiniband/hw/mlx5/qpc.c |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 11887f8bd75c..4f11c6713284 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3455,6 +3455,17 @@ static enum mlx5_qp_optpar opt_mask[MLX5_QP_NUM_STATE][MLX5_QP_NUM_STATE][MLX5_Q
 					   MLX5_QP_OPTPAR_RRE,
 		},
 	},
+	[MLX5_QP_STATE_SQD] = {
+		[MLX5_QP_STATE_RTS] = {
+			[MLX5_QP_ST_UD] = MLX5_QP_OPTPAR_Q_KEY,
+			[MLX5_QP_ST_MLX] = MLX5_QP_OPTPAR_Q_KEY,
+			[MLX5_QP_ST_UC] = MLX5_QP_OPTPAR_RWE,
+			[MLX5_QP_ST_RC] = MLX5_QP_OPTPAR_RNR_TIMEOUT	|
+					  MLX5_QP_OPTPAR_RWE		|
+					  MLX5_QP_OPTPAR_RAE		|
+					  MLX5_QP_OPTPAR_RRE,
+		},
+	},
 };
 
 static int ib_nr_to_mlx5_nr(int ib_mask)
@@ -3850,6 +3861,7 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 		[MLX5_QP_STATE_SQD] = {
 			[MLX5_QP_STATE_RST]	= MLX5_CMD_OP_2RST_QP,
 			[MLX5_QP_STATE_ERR]	= MLX5_CMD_OP_2ERR_QP,
+			[MLX5_QP_STATE_RTS]	= MLX5_CMD_OP_SQD_RTS_QP,
 		},
 		[MLX5_QP_STATE_SQER] = {
 			[MLX5_QP_STATE_RST]	= MLX5_CMD_OP_2RST_QP,
diff --git a/drivers/infiniband/hw/mlx5/qpc.c b/drivers/infiniband/hw/mlx5/qpc.c
index c683d7000168..8844eacf2380 100644
--- a/drivers/infiniband/hw/mlx5/qpc.c
+++ b/drivers/infiniband/hw/mlx5/qpc.c
@@ -441,6 +441,12 @@ static int modify_qp_mbox_alloc(struct mlx5_core_dev *dev, u16 opcode, int qpn,
 		MOD_QP_IN_SET_QPC(sqerr2rts_qp, mbox->in, opcode, qpn,
 				  opt_param_mask, qpc, uid);
 		break;
+	case MLX5_CMD_OP_SQD_RTS_QP:
+		if (MBOX_ALLOC(mbox, sqd2rts_qp))
+			return -ENOMEM;
+		MOD_QP_IN_SET_QPC(sqd2rts_qp, mbox->in, opcode, qpn,
+				  opt_param_mask, qpc, uid);
+		break;
 	case MLX5_CMD_OP_INIT2INIT_QP:
 		if (MBOX_ALLOC(mbox, init2init_qp))
 			return -ENOMEM;
-- 
2.31.1

