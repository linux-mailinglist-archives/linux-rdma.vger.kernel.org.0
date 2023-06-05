Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D5172239A
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jun 2023 12:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjFEKeY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jun 2023 06:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjFEKeR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jun 2023 06:34:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CFC130
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 03:34:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3C266121E
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 10:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF52C433EF;
        Mon,  5 Jun 2023 10:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685961244;
        bh=xf1SuXnNMTP/UlB2X8LQfYbQXiQ3GHRJqJed9+/s9h4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QXsloKmZ4rlUFGeRotHPmOhbuNlqP2B5bPPXRWLLXOVeZfEkspXVzXN1xYioGYCeV
         KIfiMU51y2abKnGSHRv5QbzXJ4LaESWHlZtfBCfW64OGE7keRsIR/MVB6/ahUa2oRJ
         9avXFLr/77t/J4O/5yE3AMvXcUHBDMa4Q7IX1O9nY85LeAZTdVmEQH55j+4kyHjd0V
         XQoY0ORUWlYld2p2A2dVagu5R/x02/mPxhiEHSihfyYJslu89KZ8411HfCQ8J0zHlQ
         x4YLsj/ZBcnNk5UIPvNvs7yTbDUbEPKVmEYhWBVRDs7Tk0NIJftjTtJkaP6bEPhTVv
         t65pT7jh1nI3w==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Bloch <mbloch@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-rc 10/10] RDMA/mlx5: Fix affinity assignment
Date:   Mon,  5 Jun 2023 13:33:26 +0300
Message-Id: <425b05f4da840bc684b0f7e8ebf61aeb5cef09b0.1685960567.git.leon@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685960567.git.leon@kernel.org>
References: <cover.1685960567.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Bloch <mbloch@nvidia.com>

The cited commit aimed to ensure that Virtual Functions (VFs) assign a
queue affinity to a Queue Pair (QP) to distribute traffic when
the LAG master creates a hardware LAG. If the affinity was set while
the hardware was not in LAG, the firmware would ignore the affinity value.

However, this commit unintentionally assigned an affinity to QPs on the LAG
master's VPORT even if the RDMA device was not marked as LAG-enabled.
In most cases, this was not an issue because when the hardware entered
hardware LAG configuration, the RDMA device of the LAG master would be
destroyed and a new one would be created, marked as LAG-enabled.

The problem arises when a user configures Equal-Cost Multipath (ECMP).
In ECMP mode, traffic can be directed to different physical ports based on
the queue affinity, which is intended for use by VPORTS other than the
E-Switch manager. ECMP mode is supported only if both E-Switch managers are
in switchdev mode and the appropriate route is configured via IP. In this
configuration, the RDMA device is not destroyed, and we retain the RDMA
device that is not marked as LAG-enabled.

To ensure correct behavior, Send Queues (SQs) opened by the E-Switch
manager through verbs should be assigned strict affinity. This means they
will only be able to communicate through the native physical port
associated with the E-Switch manager. This will prevent the firmware from
assigning affinity and will not allow the SQs to be remapped in case of
failover.

Fixes: 802dcc7fc5ec ("RDMA/mlx5: Support TX port affinity for VF drivers in LAG mode")
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h                |  3 +++
 drivers/infiniband/hw/mlx5/qp.c                     |  3 +++
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h | 12 ------------
 include/linux/mlx5/driver.h                         | 12 ++++++++++++
 4 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 2a2d2a356c41..e0ad75f7026f 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1599,6 +1599,9 @@ static inline bool mlx5_ib_lag_should_assign_affinity(struct mlx5_ib_dev *dev)
 	    MLX5_CAP_PORT_SELECTION(dev->mdev, port_select_flow_table_bypass))
 		return 0;
 
+	if (mlx5_lag_is_lacp_owner(dev->mdev) && !dev->lag_active)
+		return 0;
+
 	return dev->lag_active ||
 		(MLX5_CAP_GEN(dev->mdev, num_lag_ports) > 1 &&
 		 MLX5_CAP_GEN(dev->mdev, lag_tx_port_affinity));
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index c4d04c05546a..f99e49499529 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1239,6 +1239,9 @@ static int create_raw_packet_qp_tis(struct mlx5_ib_dev *dev,
 
 	MLX5_SET(create_tis_in, in, uid, to_mpd(pd)->uid);
 	MLX5_SET(tisc, tisc, transport_domain, tdn);
+	if (!mlx5_ib_lag_should_assign_affinity(dev) &&
+	    mlx5_lag_is_lacp_owner(dev->mdev))
+		MLX5_SET(tisc, tisc, strict_lag_tx_port_affinity, 1);
 	if (qp->flags & IB_QP_CREATE_SOURCE_QPN)
 		MLX5_SET(tisc, tisc, underlay_qpn, qp->underlay_qpn);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 1d879374acaa..229520405d4a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -276,18 +276,6 @@ static inline bool mlx5_sriov_is_enabled(struct mlx5_core_dev *dev)
 	return pci_num_vf(dev->pdev) ? true : false;
 }
 
-static inline int mlx5_lag_is_lacp_owner(struct mlx5_core_dev *dev)
-{
-	/* LACP owner conditions:
-	 * 1) Function is physical.
-	 * 2) LAG is supported by FW.
-	 * 3) LAG is managed by driver (currently the only option).
-	 */
-	return  MLX5_CAP_GEN(dev, vport_group_manager) &&
-		   (MLX5_CAP_GEN(dev, num_lag_ports) > 1) &&
-		    MLX5_CAP_GEN(dev, lag_master);
-}
-
 int mlx5_rescan_drivers_locked(struct mlx5_core_dev *dev);
 static inline int mlx5_rescan_drivers(struct mlx5_core_dev *dev)
 {
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index e67c603d507b..1e9f5bb4882b 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1227,6 +1227,18 @@ static inline u16 mlx5_core_max_vfs(const struct mlx5_core_dev *dev)
 	return dev->priv.sriov.max_vfs;
 }
 
+static inline int mlx5_lag_is_lacp_owner(struct mlx5_core_dev *dev)
+{
+	/* LACP owner conditions:
+	 * 1) Function is physical.
+	 * 2) LAG is supported by FW.
+	 * 3) LAG is managed by driver (currently the only option).
+	 */
+	return  MLX5_CAP_GEN(dev, vport_group_manager) &&
+		   (MLX5_CAP_GEN(dev, num_lag_ports) > 1) &&
+		    MLX5_CAP_GEN(dev, lag_master);
+}
+
 static inline int mlx5_get_gid_table_len(u16 param)
 {
 	if (param > 4) {
-- 
2.40.1

