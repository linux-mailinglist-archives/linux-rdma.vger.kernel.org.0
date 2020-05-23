Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74DAC1DF783
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2020 15:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387806AbgEWNXE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 23 May 2020 09:23:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387763AbgEWNXE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 23 May 2020 09:23:04 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91F9B20727;
        Sat, 23 May 2020 13:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590240184;
        bh=St/hdVoyOkC4l3v3xsllyd4aIWWzBVw0y8wisVRrzXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vi8MMJzDe4UTLfmhHUAD4mgNeUZLGNl3vAUb6tPBF6mK1qf+pgwHJQyErustnn8o8
         zIpCxXDMVmGMBs/c+/+o+5wbqDjfzwOsp+0EFx77NG4UfvhAnHrKnwVxR4JVph3uQ/
         yd4uZpoNAv5R8LrKVpr4cxecuLGGMmaAGFDacGXY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next v1 4/9] RDMA/mlx5: Use direct modify QP implementation
Date:   Sat, 23 May 2020 16:22:38 +0300
Message-Id: <20200523132243.817936-5-leon@kernel.org>
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

As a preparation to removal hand crafted mlx5_qp_context, convert
counter code to use mlx5_cmd_exec_in() directly.

Reviewed-by: Mark Zhang <markz@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 390efaeb49bc..7cbf83b423f5 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3687,10 +3687,11 @@ static int __mlx5_ib_qp_set_counter(struct ib_qp *qp,
 				    struct rdma_counter *counter)
 {
 	struct mlx5_ib_dev *dev = to_mdev(qp->device);
+	u32 in[MLX5_ST_SZ_DW(rts2rts_qp_in)] = {};
 	struct mlx5_ib_qp *mqp = to_mqp(qp);
-	struct mlx5_qp_context context = {};
 	struct mlx5_ib_qp_base *base;
 	u32 set_id;
+	u32 *qpc;
 
 	if (counter)
 		set_id = counter->id;
@@ -3698,11 +3699,15 @@ static int __mlx5_ib_qp_set_counter(struct ib_qp *qp,
 		set_id = mlx5_ib_get_counters_id(dev, mqp->port - 1);
 
 	base = &mqp->trans_qp.base;
-	context.qp_counter_set_usr_page &= cpu_to_be32(0xffffff);
-	context.qp_counter_set_usr_page |= cpu_to_be32(set_id << 24);
-	return mlx5_core_qp_modify(dev, MLX5_CMD_OP_RTS2RTS_QP,
-				   MLX5_QP_OPTPAR_COUNTER_SET_ID, &context,
-				   &base->mqp);
+	MLX5_SET(rts2rts_qp_in, in, opcode, MLX5_CMD_OP_RTS2RTS_QP);
+	MLX5_SET(rts2rts_qp_in, in, qpn, base->mqp.qpn);
+	MLX5_SET(rts2rts_qp_in, in, uid, base->mqp.uid);
+	MLX5_SET(rts2rts_qp_in, in, opt_param_mask,
+		 MLX5_QP_OPTPAR_COUNTER_SET_ID);
+
+	qpc = MLX5_ADDR_OF(rts2rts_qp_in, in, qpc);
+	MLX5_SET(qpc, qpc, counter_set_id, set_id);
+	return mlx5_cmd_exec_in(dev->mdev, rts2rts_qp, in);
 }
 
 static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
-- 
2.26.2

