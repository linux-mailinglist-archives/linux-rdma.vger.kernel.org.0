Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA12D75C2FC
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jul 2023 11:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjGUJX7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jul 2023 05:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjGUJX6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jul 2023 05:23:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3225B30E3;
        Fri, 21 Jul 2023 02:23:27 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R6kbB3BTtzVjlx;
        Fri, 21 Jul 2023 17:21:58 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 17:23:24 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v4 for-next] RDMA/core: Get IB width and speed from netdev
Date:   Fri, 21 Jul 2023 17:20:52 +0800
Message-ID: <20230721092052.2090449-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Haoyue Xu <xuhaoyue1@hisilicon.com>

Previously, there was no way to query the number of lanes for a network
card, so the same netdev_speed would result in a fixed pair of width and
speed. As network card specifications become more diverse, such fixed
mode is no longer suitable, so a method is needed to obtain the correct
width and speed based on the number of lanes.

This patch retrieves netdev lanes and speed from net_device and
translates them to IB width and speed.

Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
Signed-off-by: Luoyouming <luoyouming@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/core/verbs.c | 100 +++++++++++++++++++++++++-------
 1 file changed, 79 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index b99b3cc283b6..25367bd6dd97 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1880,6 +1880,80 @@ int ib_modify_qp_with_udata(struct ib_qp *ib_qp, struct ib_qp_attr *attr,
 }
 EXPORT_SYMBOL(ib_modify_qp_with_udata);
 
+static void ib_get_width_and_speed(u32 netdev_speed, u32 lanes,
+				   u16 *speed, u8 *width)
+{
+	if (!lanes) {
+		if (netdev_speed <= SPEED_1000) {
+			*width = IB_WIDTH_1X;
+			*speed = IB_SPEED_SDR;
+		} else if (netdev_speed <= SPEED_10000) {
+			*width = IB_WIDTH_1X;
+			*speed = IB_SPEED_FDR10;
+		} else if (netdev_speed <= SPEED_20000) {
+			*width = IB_WIDTH_4X;
+			*speed = IB_SPEED_DDR;
+		} else if (netdev_speed <= SPEED_25000) {
+			*width = IB_WIDTH_1X;
+			*speed = IB_SPEED_EDR;
+		} else if (netdev_speed <= SPEED_40000) {
+			*width = IB_WIDTH_4X;
+			*speed = IB_SPEED_FDR10;
+		} else {
+			*width = IB_WIDTH_4X;
+			*speed = IB_SPEED_EDR;
+		}
+
+		return;
+	}
+
+	switch (lanes) {
+	case 1:
+		*width = IB_WIDTH_1X;
+		break;
+	case 2:
+		*width = IB_WIDTH_2X;
+		break;
+	case 4:
+		*width = IB_WIDTH_4X;
+		break;
+	case 8:
+		*width = IB_WIDTH_8X;
+		break;
+	case 12:
+		*width = IB_WIDTH_12X;
+		break;
+	default:
+		*width = IB_WIDTH_1X;
+	}
+
+	switch (netdev_speed / lanes) {
+	case SPEED_2500:
+		*speed = IB_SPEED_SDR;
+		break;
+	case SPEED_5000:
+		*speed = IB_SPEED_DDR;
+		break;
+	case SPEED_10000:
+		*speed = IB_SPEED_FDR10;
+		break;
+	case SPEED_14000:
+		*speed = IB_SPEED_FDR;
+		break;
+	case SPEED_25000:
+		*speed = IB_SPEED_EDR;
+		break;
+	case SPEED_50000:
+		*speed = IB_SPEED_HDR;
+		break;
+	case SPEED_100000:
+		*speed = IB_SPEED_NDR;
+		break;
+	default:
+		*speed = IB_SPEED_SDR;
+	}
+}
+
 int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
 {
 	int rc;
@@ -1904,29 +1978,13 @@ int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
 		netdev_speed = lksettings.base.speed;
 	} else {
 		netdev_speed = SPEED_1000;
-		pr_warn("%s speed is unknown, defaulting to %u\n", netdev->name,
-			netdev_speed);
+		if (rc)
+			pr_warn("%s speed is unknown, defaulting to %u\n",
+				netdev->name, netdev_speed);
 	}
 
-	if (netdev_speed <= SPEED_1000) {
-		*width = IB_WIDTH_1X;
-		*speed = IB_SPEED_SDR;
-	} else if (netdev_speed <= SPEED_10000) {
-		*width = IB_WIDTH_1X;
-		*speed = IB_SPEED_FDR10;
-	} else if (netdev_speed <= SPEED_20000) {
-		*width = IB_WIDTH_4X;
-		*speed = IB_SPEED_DDR;
-	} else if (netdev_speed <= SPEED_25000) {
-		*width = IB_WIDTH_1X;
-		*speed = IB_SPEED_EDR;
-	} else if (netdev_speed <= SPEED_40000) {
-		*width = IB_WIDTH_4X;
-		*speed = IB_SPEED_FDR10;
-	} else {
-		*width = IB_WIDTH_4X;
-		*speed = IB_SPEED_EDR;
-	}
+	ib_get_width_and_speed(netdev_speed, lksettings.lanes,
+			       speed, width);
 
 	return 0;
 }
-- 
2.30.0

