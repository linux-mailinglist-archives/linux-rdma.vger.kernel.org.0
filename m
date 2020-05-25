Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4D01E1394
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 19:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388797AbgEYRoU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 13:44:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388621AbgEYRoU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 May 2020 13:44:20 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 446A92078B;
        Mon, 25 May 2020 17:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590428660;
        bh=XB8hItuJCyAOCYYQttxSiS8G2SnLhqGN8kIGa/7odn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vKbX728juY4wdo7owJUQiY92QxzHU+ihLrnyX+275YY/s6pL6qybbiBVmbjAcd7wd
         O3m7+IFdQBgqT1kFMWSGfQUtYL1SY0ZzqQc+q3uAb/byeYOY3sBzGV/M7eE1Frvxqa
         5/wHACHUHKdc3G7+lLjdRKj7R6Lv6I0Fh6tAX61Q=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next v2 4/9] RDMA/mlx5: Use direct modify QP implementation
Date:   Mon, 25 May 2020 20:43:56 +0300
Message-Id: <20200525174401.71152-5-leon@kernel.org>
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

As a preparation to removal hand crafted mlx5_qp_context, convert
counter code to use mlx5_cmd_exec_in() directly.

Reviewed-by: Mark Zhang <markz@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index eb70eb371b4b..8a3aee57a196 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3688,10 +3688,11 @@ static int __mlx5_ib_qp_set_counter(struct ib_qp *qp,
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
@@ -3699,11 +3700,15 @@ static int __mlx5_ib_qp_set_counter(struct ib_qp *qp,
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

