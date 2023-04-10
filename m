Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF276DC72A
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Apr 2023 15:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjDJNMU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Apr 2023 09:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjDJNMT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Apr 2023 09:12:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FC330C3
        for <linux-rdma@vger.kernel.org>; Mon, 10 Apr 2023 06:12:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DCB260F9A
        for <linux-rdma@vger.kernel.org>; Mon, 10 Apr 2023 13:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298F7C433EF;
        Mon, 10 Apr 2023 13:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681132337;
        bh=dIwkFPtPs0kUHneDNFh1chzkvYepmVIpXFc1JVqWSuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pONVNZxmsjZ4MlCmMmKp1iYvLZE37wA2gW5/gFtVwbwG0tq5ygZQ08wYg2peT+VO1
         AFIrw3nA3Qn3aVjEgJgNWlbkBTQAYe8ojb7gzHk3hNj/pPNmxfC7H8H9MOTiJi886Q
         QkHZ6ECUDmiZBDnkSOwmOv4+KceEIUTm+27Y+PbPbbeu6g7oIhRpJ/VyvoQ5Vz5BF3
         CMatq5M800gCO/V1X7ul/adX6lhJpmfE5eSsqthQQ90w6/0bb8Ekm9pzRJ8V4AL7FS
         Dwb/Ub6iLqo2sFOX5ZF5ocXZHHGLzxyrZjS5+49xwJIVGbM/UgFaV1XGIbWyDd+6sa
         27rVbiNZQsyCw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 1/2] IB/core: Query IBoE link speed with a new driver API
Date:   Mon, 10 Apr 2023 16:12:06 +0300
Message-Id: <67b6ea0621b22b77db4cd637a4f9b48a2f447898.1681132096.git.leon@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681132096.git.leon@kernel.org>
References: <cover.1681132096.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

Currently the ethtool API is used to get IBoE link speed, which must be
protected with the rtnl lock. This becomes a bottleneck when try to setup
many rdma-cm connections at the same time, especially with multiple
processes.

In order to avoid it, a new driver API is introduced to query the IBoE
rate. It will be used firstly, and back to ethtool way if it fails.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c    |  6 ++++--
 drivers/infiniband/core/device.c |  1 +
 include/rdma/ib_addr.h           | 31 ++++++++++++++++++++-----------
 include/rdma/ib_verbs.h          |  3 +++
 4 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 9c7d26a7d243..ff706d2e39c6 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3296,7 +3296,8 @@ static int cma_resolve_iboe_route(struct rdma_id_private *id_priv)
 	route->path_rec->traffic_class = tos;
 	route->path_rec->mtu = iboe_get_mtu(ndev->mtu);
 	route->path_rec->rate_selector = IB_SA_EQ;
-	route->path_rec->rate = iboe_get_rate(ndev);
+	route->path_rec->rate = iboe_get_rate(ndev, id_priv->id.device,
+					      id_priv->id.port_num);
 	dev_put(ndev);
 	route->path_rec->packet_life_time_selector = IB_SA_EQ;
 	/* In case ACK timeout is set, use this value to calculate
@@ -4962,7 +4963,8 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
 	if (!ndev)
 		return -ENODEV;
 
-	ib.rec.rate = iboe_get_rate(ndev);
+	ib.rec.rate = iboe_get_rate(ndev, id_priv->id.device,
+				    id_priv->id.port_num);
 	ib.rec.hop_limit = 1;
 	ib.rec.mtu = iboe_get_mtu(ndev->mtu);
 
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index a666847bd714..ba06a08c6497 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2693,6 +2693,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, query_ah);
 	SET_DEVICE_OP(dev_ops, query_device);
 	SET_DEVICE_OP(dev_ops, query_gid);
+	SET_DEVICE_OP(dev_ops, query_iboe_speed);
 	SET_DEVICE_OP(dev_ops, query_pkey);
 	SET_DEVICE_OP(dev_ops, query_port);
 	SET_DEVICE_OP(dev_ops, query_qp);
diff --git a/include/rdma/ib_addr.h b/include/rdma/ib_addr.h
index d808dc3d239e..de762210ebd1 100644
--- a/include/rdma/ib_addr.h
+++ b/include/rdma/ib_addr.h
@@ -194,24 +194,33 @@ static inline enum ib_mtu iboe_get_mtu(int mtu)
 		return 0;
 }
 
-static inline int iboe_get_rate(struct net_device *dev)
+static inline int iboe_get_rate(struct net_device *ndev,
+				struct ib_device *ibdev, u32 port_num)
 {
 	struct ethtool_link_ksettings cmd;
-	int err;
+	int speed, err;
 
-	rtnl_lock();
-	err = __ethtool_get_link_ksettings(dev, &cmd);
-	rtnl_unlock();
-	if (err)
-		return IB_RATE_PORT_CURRENT;
+	if (ibdev->ops.query_iboe_speed) {
+		err = ibdev->ops.query_iboe_speed(ibdev, port_num, &speed);
+		if (err)
+			return IB_RATE_PORT_CURRENT;
+	} else {
+		rtnl_lock();
+		err = __ethtool_get_link_ksettings(ndev, &cmd);
+		rtnl_unlock();
+		if (err)
+			return IB_RATE_PORT_CURRENT;
+
+		speed = cmd.base.speed;
+	}
 
-	if (cmd.base.speed >= 40000)
+	if (speed >= 40000)
 		return IB_RATE_40_GBPS;
-	else if (cmd.base.speed >= 30000)
+	else if (speed >= 30000)
 		return IB_RATE_30_GBPS;
-	else if (cmd.base.speed >= 20000)
+	else if (speed >= 20000)
 		return IB_RATE_20_GBPS;
-	else if (cmd.base.speed >= 10000)
+	else if (speed >= 10000)
 		return IB_RATE_10_GBPS;
 	else
 		return IB_RATE_PORT_CURRENT;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index cc2ddd4e6c12..b143258b847f 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2678,6 +2678,9 @@ struct ib_device_ops {
 	int (*query_ucontext)(struct ib_ucontext *context,
 			      struct uverbs_attr_bundle *attrs);
 
+	/* Query driver for IBoE link speed */
+	int (*query_iboe_speed)(struct ib_device *device, u32 port_num,
+				int *speed);
 	/*
 	 * Provide NUMA node. This API exists for rdmavt/hfi1 only.
 	 * Everyone else relies on Linux memory management model.
-- 
2.39.2

