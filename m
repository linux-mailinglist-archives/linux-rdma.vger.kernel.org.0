Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD2B70B2C7
	for <lists+linux-rdma@lfdr.de>; Mon, 22 May 2023 03:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjEVB1L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 May 2023 21:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjEVB1L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 May 2023 21:27:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03189EB;
        Sun, 21 May 2023 18:27:07 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QPfqZ4SpmzLpXM;
        Mon, 22 May 2023 09:24:10 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 09:27:05 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next] RDMA/core: Get IB width and speed from netdev
Date:   Mon, 22 May 2023 09:25:02 +0800
Message-ID: <20230522012502.1529035-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Haoyue Xu <xuhaoyue1@hisilicon.com>

Logic of retrieving netdev lanes and speed from net_device and
translating it to IB width and speed. Also, add a generic function
to translating netdev speed to IB speed.

Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
Signed-off-by: Luoyouming <luoyouming@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/core/verbs.c | 19 +++++++++++++++++--
 include/rdma/ib_verbs.h         | 26 ++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index b99b3cc283b6..35f1b670600a 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1880,11 +1880,19 @@ int ib_modify_qp_with_udata(struct ib_qp *ib_qp, struct ib_qp_attr *attr,
 }
 EXPORT_SYMBOL(ib_modify_qp_with_udata);
 
+static void ib_get_width_and_speed(u32 netdev_speed, u32 lanes,
+				   u16 *speed, u8 *width)
+{
+	*width = ib_int_to_ib_width(lanes);
+	*speed = ib_eth_to_ib_speed(netdev_speed / lanes);
+}
+
 int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
 {
 	int rc;
 	u32 netdev_speed;
 	struct net_device *netdev;
+	bool cap_link_lanes_supported;
 	struct ethtool_link_ksettings lksettings;
 
 	if (rdma_port_get_link_layer(dev, port_num) != IB_LINK_LAYER_ETHERNET)
@@ -1896,16 +1904,23 @@ int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
 
 	rtnl_lock();
 	rc = __ethtool_get_link_ksettings(netdev, &lksettings);
+	cap_link_lanes_supported = netdev->ethtool_ops->cap_link_lanes_supported;
 	rtnl_unlock();
 
 	dev_put(netdev);
 
 	if (!rc && lksettings.base.speed != (u32)SPEED_UNKNOWN) {
 		netdev_speed = lksettings.base.speed;
+		if (cap_link_lanes_supported && lksettings.lanes) {
+			ib_get_width_and_speed(netdev_speed, lksettings.lanes,
+					       speed, width);
+			return 0;
+		}
 	} else {
 		netdev_speed = SPEED_1000;
-		pr_warn("%s speed is unknown, defaulting to %u\n", netdev->name,
-			netdev_speed);
+		if (rc)
+			pr_warn("%s speed is unknown, defaulting to %u\n",
+				netdev->name, netdev_speed);
 	}
 
 	if (netdev_speed <= SPEED_1000) {
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 1e7774ac808f..7dc926ec7fee 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -552,6 +552,18 @@ static inline int ib_width_enum_to_int(enum ib_port_width width)
 	}
 }
 
+static inline int ib_int_to_ib_width(u32 lanes)
+{
+	switch (lanes) {
+	case 1: return IB_WIDTH_1X;
+	case 2: return IB_WIDTH_2X;
+	case 4: return IB_WIDTH_4X;
+	case 8: return IB_WIDTH_8X;
+	case 12: return IB_WIDTH_12X;
+	default: return IB_WIDTH_1X;
+	}
+}
+
 enum ib_port_speed {
 	IB_SPEED_SDR	= 1,
 	IB_SPEED_DDR	= 2,
@@ -563,6 +575,20 @@ enum ib_port_speed {
 	IB_SPEED_NDR	= 128,
 };
 
+static inline int ib_eth_to_ib_speed(u32 speed)
+{
+	switch (speed) {
+	case SPEED_2500: return IB_SPEED_SDR;
+	case SPEED_5000: return IB_SPEED_DDR;
+	case SPEED_10000: return IB_SPEED_FDR10;
+	case SPEED_14000: return IB_SPEED_FDR;
+	case SPEED_25000: return IB_SPEED_EDR;
+	case SPEED_50000: return IB_SPEED_HDR;
+	case SPEED_100000: return IB_SPEED_NDR;
+	default: return IB_SPEED_SDR;
+	}
+}
+
 enum ib_stat_flag {
 	IB_STAT_FLAG_OPTIONAL = 1 << 0,
 };
-- 
2.30.0

