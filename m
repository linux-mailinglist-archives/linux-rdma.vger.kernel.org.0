Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF306DC72B
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Apr 2023 15:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjDJNM1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Apr 2023 09:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjDJNM0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Apr 2023 09:12:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80BB977B
        for <linux-rdma@vger.kernel.org>; Mon, 10 Apr 2023 06:12:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 430FC61BF8
        for <linux-rdma@vger.kernel.org>; Mon, 10 Apr 2023 13:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5ACC433EF;
        Mon, 10 Apr 2023 13:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681132341;
        bh=ZfJxELvsi8mySqT9wfbFSae1jPRBH5uMY6dY+FIoN4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cgJ4If7cSimP5XbrBjr0Y0Snyo9EsVeO5BfiKAQswHLIJSH0dlrOKQ8xOkAb75XJm
         iLaZILPfXPGsoksVhJeoe47MBi8HBw4iWsvw6Xa3ZaIU5obMmP/I1PKQSJ3UOXXiS3
         VkUrmF0VkJZcIx5Xuz5TF6OD05UDuVN2Uqj+S9DTyLUx6FM9ULRInD7D3Ok1jPOnyI
         r2UJ5E6xhev91bFfT4/eN/HAb+zE+yyzFDkjR2flJYTOeKm/oX/S1wRUh4fRrX6LnX
         e/MS2j4HmURUCQUyzxH5GO6b75Sh8O2PO+pYrs35XVQvUhgHs/yMXHN2X5ECCBPEqv
         6EzMGNtLnQI0w==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 2/2] IB/mlx5: Implement query_iboe_speed driver API
Date:   Mon, 10 Apr 2023 16:12:07 +0300
Message-Id: <4fbb30ce37154465308c6004debf68807e52c6fb.1681132096.git.leon@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681132096.git.leon@kernel.org>
References: <cover.1681132096.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

Implement this API for RoCE, get the link speed by querying PTYS
register.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c            | 41 ++++++++++++++++++++
 drivers/infiniband/ulp/ipoib/ipoib_ethtool.c | 24 ------------
 include/rdma/ib_verbs.h                      | 23 +++++++++++
 3 files changed, 64 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 5e5ed1c8299d..2f108006b7e6 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3912,6 +3912,46 @@ static int mlx5_ib_stage_raw_eth_non_default_cb(struct mlx5_ib_dev *dev)
 	return 0;
 }
 
+static int mlx5_ib_query_iboe_speed(struct ib_device *ibdev, u32 port_num,
+				    int *speed)
+{
+	struct mlx5_ib_dev *dev = to_mdev(ibdev);
+	u32 out[MLX5_ST_SZ_DW(ptys_reg)] = {};
+	u32 eth_prot_oper, mdev_port_num;
+	struct mlx5_core_dev *mdev;
+	u16 active_speed;
+	u8 active_width;
+	bool ext;
+	int err;
+
+	mdev = mlx5_ib_get_native_port_mdev(dev, port_num, &mdev_port_num);
+	if (!mdev)
+		return -EINVAL;
+
+	if (dev->is_rep)
+		mdev_port_num = 1;
+
+	err = mlx5_query_port_ptys(mdev, out, sizeof(out), MLX5_PTYS_EN,
+				   mdev_port_num);
+	if (err)
+		goto out;
+
+	ext = !!MLX5_GET_ETH_PROTO(ptys_reg, out, true, eth_proto_capability);
+	eth_prot_oper = MLX5_GET_ETH_PROTO(ptys_reg, out, ext, eth_proto_oper);
+
+	active_width = IB_WIDTH_4X;
+	active_speed = IB_SPEED_QDR;
+
+	translate_eth_proto_oper(eth_prot_oper, &active_speed,
+				 &active_width, ext);
+	*speed = ib_speed_enum_to_int(active_speed) *
+		ib_width_enum_to_int(active_width);
+
+out:
+	mlx5_ib_put_native_port_mdev(dev, port_num);
+	return err;
+}
+
 static const struct ib_device_ops mlx5_ib_dev_common_roce_ops = {
 	.create_rwq_ind_table = mlx5_ib_create_rwq_ind_table,
 	.create_wq = mlx5_ib_create_wq,
@@ -3919,6 +3959,7 @@ static const struct ib_device_ops mlx5_ib_dev_common_roce_ops = {
 	.destroy_wq = mlx5_ib_destroy_wq,
 	.get_netdev = mlx5_ib_get_netdev,
 	.modify_wq = mlx5_ib_modify_wq,
+	.query_iboe_speed = mlx5_ib_query_iboe_speed,
 
 	INIT_RDMA_OBJ_SIZE(ib_rwq_ind_table, mlx5_ib_rwq_ind_table,
 			   ib_rwq_ind_tbl),
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c b/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
index 8af99b18d361..8ece31078558 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
@@ -155,30 +155,6 @@ static int ipoib_get_sset_count(struct net_device __always_unused *dev,
 	return -EOPNOTSUPP;
 }
 
-/* Return lane speed in unit of 1e6 bit/sec */
-static inline int ib_speed_enum_to_int(int speed)
-{
-	switch (speed) {
-	case IB_SPEED_SDR:
-		return SPEED_2500;
-	case IB_SPEED_DDR:
-		return SPEED_5000;
-	case IB_SPEED_QDR:
-	case IB_SPEED_FDR10:
-		return SPEED_10000;
-	case IB_SPEED_FDR:
-		return SPEED_14000;
-	case IB_SPEED_EDR:
-		return SPEED_25000;
-	case IB_SPEED_HDR:
-		return SPEED_50000;
-	case IB_SPEED_NDR:
-		return SPEED_100000;
-	}
-
-	return SPEED_UNKNOWN;
-}
-
 static int ipoib_get_link_ksettings(struct net_device *netdev,
 				    struct ethtool_link_ksettings *cmd)
 {
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index b143258b847f..4a7a62c7e3e8 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -563,6 +563,29 @@ enum ib_port_speed {
 	IB_SPEED_NDR	= 128,
 };
 
+static inline int ib_speed_enum_to_int(int speed)
+{
+	switch (speed) {
+	case IB_SPEED_SDR:
+		return SPEED_2500;
+	case IB_SPEED_DDR:
+		return SPEED_5000;
+	case IB_SPEED_QDR:
+	case IB_SPEED_FDR10:
+		return SPEED_10000;
+	case IB_SPEED_FDR:
+		return SPEED_14000;
+	case IB_SPEED_EDR:
+		return SPEED_25000;
+	case IB_SPEED_HDR:
+		return SPEED_50000;
+	case IB_SPEED_NDR:
+		return SPEED_100000;
+	}
+
+	return SPEED_UNKNOWN;
+}
+
 enum ib_stat_flag {
 	IB_STAT_FLAG_OPTIONAL = 1 << 0,
 };
-- 
2.39.2

