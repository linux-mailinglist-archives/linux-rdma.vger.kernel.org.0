Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5198D1A681C
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 16:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbgDMOYf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Apr 2020 10:24:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730677AbgDMOXq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Apr 2020 10:23:46 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6A4F2075E;
        Mon, 13 Apr 2020 14:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586787825;
        bh=IXvfIC8jr7fHePn5Wov/cHC+5jBWLdLPJ00Dz0v+LIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jFUwzvtikPaRn3MB+8CkJ1h5kIv2mKsFX1/oTg3/8XzdFMEgpqxX/Qtwl06nU2GeU
         SJWgOIBjuzQ0lgIoSj+pjZT2sCUf7/ogw2Dr9WYaJudrMmopYy6+C6/KLm5GxUA9Vh
         QFltGtr/tUVMqAkBzC2ZBo9ibYz6v6TpKXq43Eak=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH rdma-next 10/13] RDMA/mlx5: Delete Q counter allocations command
Date:   Mon, 13 Apr 2020 17:23:05 +0300
Message-Id: <20200413142308.936946-11-leon@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200413142308.936946-1-leon@kernel.org>
References: <20200413142308.936946-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Remove mlx5_ib implementation of Q counter allocation logic
together with cleaning boolean which controlled validity of the
counter. It is not needed, because counter_id == 0 means that
counter is not valid.

Reviewed-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/cmd.c     | 17 ---------------
 drivers/infiniband/hw/mlx5/cmd.h     |  2 --
 drivers/infiniband/hw/mlx5/main.c    | 31 ++++++++++++++++++----------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 -
 4 files changed, 20 insertions(+), 31 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cmd.c b/drivers/infiniband/hw/mlx5/cmd.c
index 4c26492ab8a3..a2fcbc49131e 100644
--- a/drivers/infiniband/hw/mlx5/cmd.c
+++ b/drivers/infiniband/hw/mlx5/cmd.c
@@ -327,23 +327,6 @@ int mlx5_cmd_xrcd_dealloc(struct mlx5_core_dev *dev, u32 xrcdn, u16 uid)
 	return mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
 }
 
-int mlx5_cmd_alloc_q_counter(struct mlx5_core_dev *dev, u16 *counter_id,
-			     u16 uid)
-{
-	u32 in[MLX5_ST_SZ_DW(alloc_q_counter_in)]   = {0};
-	u32 out[MLX5_ST_SZ_DW(alloc_q_counter_out)] = {0};
-	int err;
-
-	MLX5_SET(alloc_q_counter_in, in, opcode, MLX5_CMD_OP_ALLOC_Q_COUNTER);
-	MLX5_SET(alloc_q_counter_in, in, uid, uid);
-
-	err = mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
-	if (!err)
-		*counter_id = MLX5_GET(alloc_q_counter_out, out,
-				       counter_set_id);
-	return err;
-}
-
 int mlx5_cmd_mad_ifc(struct mlx5_core_dev *dev, const void *inb, void *outb,
 		     u16 opmod, u8 port)
 {
diff --git a/drivers/infiniband/hw/mlx5/cmd.h b/drivers/infiniband/hw/mlx5/cmd.h
index 945ebce73613..43079b18d9b4 100644
--- a/drivers/infiniband/hw/mlx5/cmd.h
+++ b/drivers/infiniband/hw/mlx5/cmd.h
@@ -61,8 +61,6 @@ int mlx5_cmd_detach_mcg(struct mlx5_core_dev *dev, union ib_gid *mgid,
 			u32 qpn, u16 uid);
 int mlx5_cmd_xrcd_alloc(struct mlx5_core_dev *dev, u32 *xrcdn, u16 uid);
 int mlx5_cmd_xrcd_dealloc(struct mlx5_core_dev *dev, u32 xrcdn, u16 uid);
-int mlx5_cmd_alloc_q_counter(struct mlx5_core_dev *dev, u16 *counter_id,
-			     u16 uid);
 int mlx5_cmd_mad_ifc(struct mlx5_core_dev *dev, const void *inb, void *outb,
 		     u16 opmod, u8 port);
 #endif /* MLX5_IB_CMD_H */
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 58e3b1d5d7b2..ea1fe4f9e0c3 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -5421,7 +5421,7 @@ static void mlx5_ib_dealloc_counters(struct mlx5_ib_dev *dev)
 		 MLX5_CMD_OP_DEALLOC_Q_COUNTER);
 
 	for (i = 0; i < num_cnt_ports; i++) {
-		if (dev->port[i].cnts.set_id_valid) {
+		if (dev->port[i].cnts.set_id) {
 			MLX5_SET(dealloc_q_counter_in, in, counter_set_id,
 				 dev->port[i].cnts.set_id);
 			mlx5_cmd_exec_in(dev->mdev, dealloc_q_counter, in);
@@ -5534,11 +5534,14 @@ static void mlx5_ib_fill_counters(struct mlx5_ib_dev *dev,
 
 static int mlx5_ib_alloc_counters(struct mlx5_ib_dev *dev)
 {
+	u32 out[MLX5_ST_SZ_DW(alloc_q_counter_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(alloc_q_counter_in)] = {};
 	int num_cnt_ports;
 	int err = 0;
 	int i;
 	bool is_shared;
 
+	MLX5_SET(alloc_q_counter_in, in, opcode, MLX5_CMD_OP_ALLOC_Q_COUNTER);
 	is_shared = MLX5_CAP_GEN(dev->mdev, log_max_uctx) != 0;
 	num_cnt_ports = is_mdev_switchdev_mode(dev->mdev) ? 1 : dev->num_ports;
 
@@ -5550,17 +5553,19 @@ static int mlx5_ib_alloc_counters(struct mlx5_ib_dev *dev)
 		mlx5_ib_fill_counters(dev, dev->port[i].cnts.names,
 				      dev->port[i].cnts.offsets);
 
-		err = mlx5_cmd_alloc_q_counter(dev->mdev,
-					       &dev->port[i].cnts.set_id,
-					       is_shared ?
-					       MLX5_SHARED_RESOURCE_UID : 0);
+		MLX5_SET(alloc_q_counter_in, in, uid,
+			 is_shared ? MLX5_SHARED_RESOURCE_UID : 0);
+
+		err = mlx5_cmd_exec_inout(dev->mdev, alloc_q_counter, in, out);
 		if (err) {
 			mlx5_ib_warn(dev,
 				     "couldn't allocate queue counter for port %d, err %d\n",
 				     i + 1, err);
 			goto err_alloc;
 		}
-		dev->port[i].cnts.set_id_valid = true;
+
+		dev->port[i].cnts.set_id =
+			MLX5_GET(alloc_q_counter_out, out, counter_set_id);
 	}
 	return 0;
 
@@ -5757,16 +5762,20 @@ static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
 				   struct ib_qp *qp)
 {
 	struct mlx5_ib_dev *dev = to_mdev(qp->device);
-	u16 cnt_set_id = 0;
 	int err;
 
 	if (!counter->id) {
-		err = mlx5_cmd_alloc_q_counter(dev->mdev,
-					       &cnt_set_id,
-					       MLX5_SHARED_RESOURCE_UID);
+		u32 out[MLX5_ST_SZ_DW(alloc_q_counter_out)] = {};
+		u32 in[MLX5_ST_SZ_DW(alloc_q_counter_in)] = {};
+
+		MLX5_SET(alloc_q_counter_in, in, opcode,
+			 MLX5_CMD_OP_ALLOC_Q_COUNTER);
+		MLX5_SET(alloc_q_counter_in, in, uid, MLX5_SHARED_RESOURCE_UID);
+		err = mlx5_cmd_exec_inout(dev->mdev, alloc_q_counter, in, out);
 		if (err)
 			return err;
-		counter->id = cnt_set_id;
+		counter->id =
+			MLX5_GET(alloc_q_counter_out, out, counter_set_id);
 	}
 
 	err = mlx5_ib_qp_set_counter(qp, counter);
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 61ea8fc70787..897a7ff06880 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -781,7 +781,6 @@ struct mlx5_ib_counters {
 	u32 num_cong_counters;
 	u32 num_ext_ppcnt_counters;
 	u16 set_id;
-	bool set_id_valid;
 };
 
 struct mlx5_ib_multiport_info;
-- 
2.25.2

