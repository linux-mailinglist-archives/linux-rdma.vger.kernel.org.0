Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3DD2220FC
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jul 2020 12:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgGPKyW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jul 2020 06:54:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgGPKyW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Jul 2020 06:54:22 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAAB3206C1;
        Thu, 16 Jul 2020 10:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594896861;
        bh=bdOmK4llfax58iUuUfff1A0bxOonWiOW2w4BYUmokSw=;
        h=From:To:Cc:Subject:Date:From;
        b=KjgA7oH3n1G1FPkun0RBSO8AAOaUBD3/yohBGsYYF73/jHXGvsvr8FBPpeMKiTPcW
         d0cOCnk7OR1wJeq44Znj29fJ9cwm9gWHUL1nX9Ciip+ZQcGJaNLttaqqD5EUxfBtLT
         qfBPSF/Tbb2qmdce4L4TezBIyQzEKkbktEkJ+7Fc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next] RDMA/mlx5: Allow SQ modification
Date:   Thu, 16 Jul 2020 13:54:16 +0300
Message-Id: <20200716105416.1423826-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

Currently SQ is set to ready state when the RAW QP is modified to init.
When TIS is modified, e.g. to change the lag_tx_affinity, then SQs which
are already in ready state will not be affected.

Open window to modify the SQ behavior by set the SQ as ready only when
QP was modified to RTS.

Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Reviewed-by: Mark Zhang <markz@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index ef1587d01bfb..b3ed6fd9a4f0 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3552,7 +3552,7 @@ static int modify_raw_packet_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	switch (raw_qp_param->operation) {
 	case MLX5_CMD_OP_RST2INIT_QP:
 		rq_state = MLX5_RQC_STATE_RDY;
-		sq_state = MLX5_SQC_STATE_RDY;
+		sq_state = MLX5_SQC_STATE_RST;
 		break;
 	case MLX5_CMD_OP_2ERR_QP:
 		rq_state = MLX5_RQC_STATE_ERR;
@@ -3564,13 +3564,11 @@ static int modify_raw_packet_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 		break;
 	case MLX5_CMD_OP_RTR2RTS_QP:
 	case MLX5_CMD_OP_RTS2RTS_QP:
-		if (raw_qp_param->set_mask ==
-		    MLX5_RAW_QP_RATE_LIMIT) {
-			modify_rq = 0;
-			sq_state = sq->state;
-		} else {
-			return raw_qp_param->set_mask ? -EINVAL : 0;
-		}
+		if (raw_qp_param->set_mask & ~MLX5_RAW_QP_RATE_LIMIT)
+			return -EINVAL;
+
+		modify_rq = 0;
+		sq_state = MLX5_SQC_STATE_RDY;
 		break;
 	case MLX5_CMD_OP_INIT2INIT_QP:
 	case MLX5_CMD_OP_INIT2RTR_QP:
@@ -4448,7 +4446,7 @@ static int sqrq_state_to_qp_state(u8 sq_state, u8 rq_state,
 			[MLX5_SQ_STATE_NA]	= IB_QPS_RESET,
 		},
 		[MLX5_RQC_STATE_RDY] = {
-			[MLX5_SQC_STATE_RST]	= MLX5_QP_STATE_BAD,
+			[MLX5_SQC_STATE_RST]	= MLX5_QP_STATE,
 			[MLX5_SQC_STATE_RDY]	= MLX5_QP_STATE,
 			[MLX5_SQC_STATE_ERR]	= IB_QPS_SQE,
 			[MLX5_SQ_STATE_NA]	= MLX5_QP_STATE,
@@ -4460,7 +4458,7 @@ static int sqrq_state_to_qp_state(u8 sq_state, u8 rq_state,
 			[MLX5_SQ_STATE_NA]	= IB_QPS_ERR,
 		},
 		[MLX5_RQ_STATE_NA] = {
-			[MLX5_SQC_STATE_RST]    = IB_QPS_RESET,
+			[MLX5_SQC_STATE_RST]    = MLX5_QP_STATE,
 			[MLX5_SQC_STATE_RDY]	= MLX5_QP_STATE,
 			[MLX5_SQC_STATE_ERR]	= MLX5_QP_STATE,
 			[MLX5_SQ_STATE_NA]	= MLX5_QP_STATE_BAD,
-- 
2.26.2

