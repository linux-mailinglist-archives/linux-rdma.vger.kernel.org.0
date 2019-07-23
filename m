Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E05AA712E8
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 09:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbfGWHb0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 03:31:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731234AbfGWHb0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jul 2019 03:31:26 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0B27227B6;
        Tue, 23 Jul 2019 07:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563867085;
        bh=Bksa5GkcnyeN4S+DjSlQjEbSIXNwz4d1frdcILi6+Es=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lf5tEqThPMCRnkP7LJt/DSlfMT7GV4tP9qJwmrd1BnWLIySj2Pq73wQ50PSc9Y3vg
         vtTYiPfQXoFrO7WcmEuTCzkwx915LsNJNixyhGK2WnmCTApaM3ph1Wc27Nj6D1ioq/
         GxkNhlxnPh/qccVo0rRtC8PCASNe4dkEy0c+prA0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next 1/2] IB/mlx5: Refactor code for counters allocation
Date:   Tue, 23 Jul 2019 10:31:16 +0300
Message-Id: <20190723073117.7175-2-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190723073117.7175-1-leon@kernel.org>
References: <20190723073117.7175-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

To support per device counters in switchdev mode (instead of
per port counter), refactor query routines to work on mlx5_ib_counter
structure instead of mlx5_ib_port structure.

Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c | 60 +++++++++++++++----------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 6cdd98ec9c1e..4cfb55ac0ed7 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -5466,21 +5466,21 @@ static struct rdma_hw_stats *mlx5_ib_alloc_hw_stats(struct ib_device *ibdev,
 						    u8 port_num)
 {
 	struct mlx5_ib_dev *dev = to_mdev(ibdev);
-	struct mlx5_ib_port *port = &dev->port[port_num - 1];
+	const struct mlx5_ib_counters *cnts = &dev->port[port_num - 1].cnts;
 
 	/* We support only per port stats */
 	if (port_num == 0)
 		return NULL;
 
-	return rdma_alloc_hw_stats_struct(port->cnts.names,
-					  port->cnts.num_q_counters +
-					  port->cnts.num_cong_counters +
-					  port->cnts.num_ext_ppcnt_counters,
+	return rdma_alloc_hw_stats_struct(cnts->names,
+					  cnts->num_q_counters +
+					  cnts->num_cong_counters +
+					  cnts->num_ext_ppcnt_counters,
 					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
 }
 
 static int mlx5_ib_query_q_counters(struct mlx5_core_dev *mdev,
-				    struct mlx5_ib_port *port,
+				    const struct mlx5_ib_counters *cnts,
 				    struct rdma_hw_stats *stats,
 				    u16 set_id)
 {
@@ -5497,8 +5497,8 @@ static int mlx5_ib_query_q_counters(struct mlx5_core_dev *mdev,
 	if (ret)
 		goto free;
 
-	for (i = 0; i < port->cnts.num_q_counters; i++) {
-		val = *(__be32 *)(out + port->cnts.offsets[i]);
+	for (i = 0; i < cnts->num_q_counters; i++) {
+		val = *(__be32 *)(out + cnts->offsets[i]);
 		stats->value[i] = (u64)be32_to_cpu(val);
 	}
 
@@ -5508,10 +5508,10 @@ static int mlx5_ib_query_q_counters(struct mlx5_core_dev *mdev,
 }
 
 static int mlx5_ib_query_ext_ppcnt_counters(struct mlx5_ib_dev *dev,
-					  struct mlx5_ib_port *port,
-					  struct rdma_hw_stats *stats)
+					    const struct mlx5_ib_counters *cnts,
+					    struct rdma_hw_stats *stats)
 {
-	int offset = port->cnts.num_q_counters + port->cnts.num_cong_counters;
+	int offset = cnts->num_q_counters + cnts->num_cong_counters;
 	int sz = MLX5_ST_SZ_BYTES(ppcnt_reg);
 	int ret, i;
 	void *out;
@@ -5524,12 +5524,10 @@ static int mlx5_ib_query_ext_ppcnt_counters(struct mlx5_ib_dev *dev,
 	if (ret)
 		goto free;
 
-	for (i = 0; i < port->cnts.num_ext_ppcnt_counters; i++) {
+	for (i = 0; i < cnts->num_ext_ppcnt_counters; i++)
 		stats->value[i + offset] =
 			be64_to_cpup((__be64 *)(out +
-				    port->cnts.offsets[i + offset]));
-	}
-
+				    cnts->offsets[i + offset]));
 free:
 	kvfree(out);
 	return ret;
@@ -5540,7 +5538,7 @@ static int mlx5_ib_get_hw_stats(struct ib_device *ibdev,
 				u8 port_num, int index)
 {
 	struct mlx5_ib_dev *dev = to_mdev(ibdev);
-	struct mlx5_ib_port *port = &dev->port[port_num - 1];
+	struct mlx5_ib_counters *cnts = &dev->port[port_num - 1].cnts;
 	struct mlx5_core_dev *mdev;
 	int ret, num_counters;
 	u8 mdev_port_num;
@@ -5548,18 +5546,17 @@ static int mlx5_ib_get_hw_stats(struct ib_device *ibdev,
 	if (!stats)
 		return -EINVAL;
 
-	num_counters = port->cnts.num_q_counters +
-		       port->cnts.num_cong_counters +
-		       port->cnts.num_ext_ppcnt_counters;
+	num_counters = cnts->num_q_counters +
+		       cnts->num_cong_counters +
+		       cnts->num_ext_ppcnt_counters;
 
 	/* q_counters are per IB device, query the master mdev */
-	ret = mlx5_ib_query_q_counters(dev->mdev, port, stats,
-				       port->cnts.set_id);
+	ret = mlx5_ib_query_q_counters(dev->mdev, cnts, stats, cnts->set_id);
 	if (ret)
 		return ret;
 
 	if (MLX5_CAP_PCAM_FEATURE(dev->mdev, rx_icrc_encapsulated_counter)) {
-		ret =  mlx5_ib_query_ext_ppcnt_counters(dev, port, stats);
+		ret =  mlx5_ib_query_ext_ppcnt_counters(dev, cnts, stats);
 		if (ret)
 			return ret;
 	}
@@ -5576,10 +5573,10 @@ static int mlx5_ib_get_hw_stats(struct ib_device *ibdev,
 		}
 		ret = mlx5_lag_query_cong_counters(dev->mdev,
 						   stats->value +
-						   port->cnts.num_q_counters,
-						   port->cnts.num_cong_counters,
-						   port->cnts.offsets +
-						   port->cnts.num_q_counters);
+						   cnts->num_q_counters,
+						   cnts->num_cong_counters,
+						   cnts->offsets +
+						   cnts->num_q_counters);
 
 		mlx5_ib_put_native_port_mdev(dev, port_num);
 		if (ret)
@@ -5594,20 +5591,21 @@ static struct rdma_hw_stats *
 mlx5_ib_counter_alloc_stats(struct rdma_counter *counter)
 {
 	struct mlx5_ib_dev *dev = to_mdev(counter->device);
-	struct mlx5_ib_port *port = &dev->port[counter->port - 1];
+	const struct mlx5_ib_counters *cnts =
+			&dev->port[counter->port - 1].cnts;
 
 	/* Q counters are in the beginning of all counters */
-	return rdma_alloc_hw_stats_struct(port->cnts.names,
-					  port->cnts.num_q_counters,
+	return rdma_alloc_hw_stats_struct(cnts->names,
+					  cnts->num_q_counters,
 					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
 }
 
 static int mlx5_ib_counter_update_stats(struct rdma_counter *counter)
 {
 	struct mlx5_ib_dev *dev = to_mdev(counter->device);
-	struct mlx5_ib_port *port = &dev->port[counter->port - 1];
+	struct mlx5_ib_counters *cnts = &dev->port[counter->port - 1].cnts;
 
-	return mlx5_ib_query_q_counters(dev->mdev, port,
+	return mlx5_ib_query_q_counters(dev->mdev, cnts,
 					counter->stats, counter->id);
 }
 
-- 
2.20.1

