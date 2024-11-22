Return-Path: <linux-rdma+bounces-6062-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B658A9D5D9C
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 12:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A34EA283D2E
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 11:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D576E1DF269;
	Fri, 22 Nov 2024 10:59:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D30D1DDC29;
	Fri, 22 Nov 2024 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273190; cv=none; b=TaOx1kO5cSJEborOTQ7bbEaj1XaiiX8VEUzIEfBmLafj9eAVpSAbw2Sop5bmz86fORdu/aRRZVLXmR1XH5E8qsDq+YzCyIkCY2UgUTT8UXFb9WeLZBSP13dll71dq/hT0lRvJTrICADRgGMbLo2G6xNB/iCuKFoHt3yEj969Tew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273190; c=relaxed/simple;
	bh=2p2EV4qsK6lkoD6wGBAO3pu2TTsO1cxiOfgfVXFOmgk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKqDWtIEwh/xjIOiOaRmhqySpsv7brgU0sRwEhO5B3yDXDwRjEIRmIGCmW8k/xS7nhar99xSchXAggg+POmzmsVMbOK7VAFmVddIt/bo2pJr3uKCcS2+QFTVfI4nPRlvPmW4BOUVatmY+T/VFfkqP1ARtw5BRqEWyNcX3eOZYo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XvsXF4BMRz21ldV;
	Fri, 22 Nov 2024 18:58:21 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id DD4D81A0188;
	Fri, 22 Nov 2024 18:59:45 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 Nov 2024 18:59:45 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <selvin.xavier@broadcom.com>,
	<chengyou@linux.alibaba.com>, <kaishen@linux.alibaba.com>,
	<mustafa.ismail@intel.com>, <tatyana.e.nikolova@intel.com>,
	<yishaih@nvidia.com>, <benve@cisco.com>, <neescoba@cisco.com>,
	<bryan-bt.tan@broadcom.com>, <vishnu.dasa@broadcom.com>,
	<zyjzyj2000@gmail.com>, <bmt@zurich.ibm.com>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
	<tangchengchang@huawei.com>, <liyuyu6@huawei.com>
Subject: [PATCH RFC 08/12] RDMA/usnic: Support report_port_event() ops
Date: Fri, 22 Nov 2024 18:53:04 +0800
Message-ID: <20241122105308.2150505-9-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241122105308.2150505-1-huangjunxian6@hisilicon.com>
References: <20241122105308.2150505-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: Yuyu Li <liyuyu6@huawei.com>

In addition to dispatching event, some private stuffs need to be
done in this driver's link status event handler. Implement the new
report_port_event() ops with the link status event codes.

Signed-off-by: Yuyu Li <liyuyu6@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/usnic/usnic_ib_main.c | 71 +++++++++++++--------
 1 file changed, 43 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_ib_main.c b/drivers/infiniband/hw/usnic/usnic_ib_main.c
index 13b654ddd3cc..5ad7fe7e662f 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_main.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_main.c
@@ -151,34 +151,6 @@ static void usnic_ib_handle_usdev_event(struct usnic_ib_dev *us_ibdev,
 		ib_event.element.port_num = 1;
 		ib_dispatch_event(&ib_event);
 		break;
-	case NETDEV_UP:
-	case NETDEV_DOWN:
-	case NETDEV_CHANGE:
-		if (!us_ibdev->ufdev->link_up &&
-				netif_carrier_ok(netdev)) {
-			usnic_fwd_carrier_up(us_ibdev->ufdev);
-			usnic_info("Link UP on %s\n",
-				   dev_name(&us_ibdev->ib_dev.dev));
-			ib_event.event = IB_EVENT_PORT_ACTIVE;
-			ib_event.device = &us_ibdev->ib_dev;
-			ib_event.element.port_num = 1;
-			ib_dispatch_event(&ib_event);
-		} else if (us_ibdev->ufdev->link_up &&
-				!netif_carrier_ok(netdev)) {
-			usnic_fwd_carrier_down(us_ibdev->ufdev);
-			usnic_info("Link DOWN on %s\n",
-				   dev_name(&us_ibdev->ib_dev.dev));
-			usnic_ib_qp_grp_modify_active_to_err(us_ibdev);
-			ib_event.event = IB_EVENT_PORT_ERR;
-			ib_event.device = &us_ibdev->ib_dev;
-			ib_event.element.port_num = 1;
-			ib_dispatch_event(&ib_event);
-		} else {
-			usnic_dbg("Ignoring %s on %s\n",
-					netdev_cmd_to_name(event),
-					dev_name(&us_ibdev->ib_dev.dev));
-		}
-		break;
 	case NETDEV_CHANGEADDR:
 		if (!memcmp(us_ibdev->ufdev->mac, netdev->dev_addr,
 				sizeof(us_ibdev->ufdev->mac))) {
@@ -218,6 +190,48 @@ static void usnic_ib_handle_usdev_event(struct usnic_ib_dev *us_ibdev,
 	mutex_unlock(&us_ibdev->usdev_lock);
 }
 
+static void usnic_ib_handle_port_event(struct ib_device *ibdev,
+				       struct net_device *netdev,
+				       unsigned long event);
+{
+	struct usnic_ib_dev *us_ibdev =
+			container_of(ibdev, struct usnic_ib_dev, ib_dev);
+	mutex_lock(&us_ibdev->usdev_lock);
+	switch (event) {
+	case NETDEV_UP:
+	case NETDEV_DOWN:
+	case NETDEV_CHANGE:
+		if (!us_ibdev->ufdev->link_up &&
+		    netif_carrier_ok(netdev)) {
+			usnic_fwd_carrier_up(us_ibdev->ufdev);
+			usnic_info("Link UP on %s\n",
+				   dev_name(&us_ibdev->ib_dev.dev));
+			ib_event.event = IB_EVENT_PORT_ACTIVE;
+			ib_event.device = &us_ibdev->ib_dev;
+			ib_event.element.port_num = 1;
+			ib_dispatch_event(&ib_event);
+		} else if (us_ibdev->ufdev->link_up &&
+			   !netif_carrier_ok(netdev)) {
+			usnic_fwd_carrier_down(us_ibdev->ufdev);
+			usnic_info("Link DOWN on %s\n",
+				   dev_name(&us_ibdev->ib_dev.dev));
+			usnic_ib_qp_grp_modify_active_to_err(us_ibdev);
+			ib_event.event = IB_EVENT_PORT_ERR;
+			ib_event.device = &us_ibdev->ib_dev;
+			ib_event.element.port_num = 1;
+			ib_dispatch_event(&ib_event);
+		} else {
+			usnic_dbg("Ignoring %s on %s\n",
+				  netdev_cmd_to_name(event),
+				  dev_name(&us_ibdev->ib_dev.dev));
+		}
+		break;
+	default:
+		break;
+	}
+	mutex_unlock(&us_ibdev->usdev_lock);
+}
+
 static int usnic_ib_netdevice_event(struct notifier_block *notifier,
 					unsigned long event, void *ptr)
 {
@@ -358,6 +372,7 @@ static const struct ib_device_ops usnic_dev_ops = {
 	.query_port = usnic_ib_query_port,
 	.query_qp = usnic_ib_query_qp,
 	.reg_user_mr = usnic_ib_reg_mr,
+	.report_port_event = usnic_ib_handle_port_event,
 	INIT_RDMA_OBJ_SIZE(ib_pd, usnic_ib_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_cq, usnic_ib_cq, ibcq),
 	INIT_RDMA_OBJ_SIZE(ib_qp, usnic_ib_qp_grp, ibqp),
-- 
2.33.0


