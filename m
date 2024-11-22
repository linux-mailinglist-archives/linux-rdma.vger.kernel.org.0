Return-Path: <linux-rdma+bounces-6067-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 796219D5DA4
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 12:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F113A1F23A73
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 11:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874551DF98D;
	Fri, 22 Nov 2024 10:59:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3502D1DF24A;
	Fri, 22 Nov 2024 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273192; cv=none; b=uLtfLCdFH9dJ8oqzzBINZbtV7rpscd4t8B3MPj5WL71O2VEDvc6BCTvdKQ4LeGaDGunPIBVTEAjuferPLYRmqaY8dPFY8DhDX5wyKhMIGgrpjFQtnrUz/qxvCehcEJHqxhTfjzglhCkcnQ2OrRARbl0TZDZmIhdpNTVPKAmEMz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273192; c=relaxed/simple;
	bh=cCmZ8/aVS2IlbIho/MsWFDOAVcgVroEroABDBpsXfcI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s8nuYHa+iSjMOtJxkRHaxCWFeoLqPNstNVSVzYVSi4VBKPlp6A0F32z+Jy2EUOO9sBAe07nXWEqXDi5srcijFhmo+shCCMCVecoA4Jkz2BT55oxIkP44fk9Q+uJq0RpXyf7zcBTEDVfsq1gJG+66YvWjEQxO/Bbme7YJsr6pSqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XvsWX3Kb7z1T5G5;
	Fri, 22 Nov 2024 18:57:44 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 95E8C1A0188;
	Fri, 22 Nov 2024 18:59:46 +0800 (CST)
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
Subject: [PATCH RFC 09/12] RDMA/mlx4: Support report_port_event() ops
Date: Fri, 22 Nov 2024 18:53:05 +0800
Message-ID: <20241122105308.2150505-10-huangjunxian6@hisilicon.com>
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
 drivers/infiniband/hw/mlx4/main.c | 58 ++++++++++++++++---------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 529db874d67c..8bc390eaa921 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2341,39 +2341,40 @@ static void mlx4_ib_scan_netdev(struct mlx4_ib_dev *ibdev,
 
 	iboe->netdevs[dev->dev_port] = event != NETDEV_UNREGISTER ? dev : NULL;
 
-	if (event == NETDEV_UP || event == NETDEV_DOWN) {
-		enum ib_port_state port_state;
-		struct ib_event ibev = { };
-
-		if (ib_get_cached_port_state(&ibdev->ib_dev, dev->dev_port + 1,
-					     &port_state))
-			goto iboe_out;
-
-		if (event == NETDEV_UP &&
-		    (port_state != IB_PORT_ACTIVE ||
-		     iboe->last_port_state[dev->dev_port] != IB_PORT_DOWN))
-			goto iboe_out;
-		if (event == NETDEV_DOWN &&
-		    (port_state != IB_PORT_DOWN ||
-		     iboe->last_port_state[dev->dev_port] != IB_PORT_ACTIVE))
-			goto iboe_out;
-		iboe->last_port_state[dev->dev_port] = port_state;
-
-		ibev.device = &ibdev->ib_dev;
-		ibev.element.port_num = dev->dev_port + 1;
-		ibev.event = event == NETDEV_UP ? IB_EVENT_PORT_ACTIVE :
-						  IB_EVENT_PORT_ERR;
-		ib_dispatch_event(&ibev);
-	}
-
-iboe_out:
 	spin_unlock_bh(&iboe->lock);
 
-	if (event == NETDEV_CHANGEADDR || event == NETDEV_REGISTER ||
-	    event == NETDEV_UP || event == NETDEV_CHANGE)
+	if (event == NETDEV_CHANGEADDR || event == NETDEV_REGISTER)
 		mlx4_ib_update_qps(ibdev, dev, dev->dev_port + 1);
 }
 
+static void mlx4_ib_port_event(struct ib_device *ibdev, struct net_device *ndev,
+			       unsigned long event)
+{
+	struct mlx4_ib_dev *mlx4_ibdev =
+		container_of(ibdev, struct mlx4_ib_dev, ib_dev);
+	struct mlx4_ib_iboe *iboe = &mlx4_ibdev->iboe;
+
+	if (!net_eq(dev_net(ndev), &init_net))
+		return;
+
+	ASSERT_RTNL();
+
+	if (ndev->dev.parent != mlx4_ibdev->ib_dev.dev.parent)
+		return;
+
+	spin_lock_bh(&iboe->lock);
+
+	iboe->netdevs[ndev->dev_port] = event != NETDEV_UNREGISTER ? ndev : NULL;
+
+	if (event == NETDEV_UP || event == NETDEV_DOWN)
+		ib_dispatch_port_state_event(&mlx4_ibdev->ib_dev, ndev);
+
+	spin_unlock_bh(&iboe->lock);
+
+	if (event == NETDEV_UP || event == NETDEV_CHANGE)
+		mlx4_ib_update_qps(mlx4_ibdev, ndev, ndev->dev_port + 1);
+}
+
 static int mlx4_ib_netdev_event(struct notifier_block *this,
 				unsigned long event, void *ptr)
 {
@@ -2569,6 +2570,7 @@ static const struct ib_device_ops mlx4_ib_dev_ops = {
 	.req_notify_cq = mlx4_ib_arm_cq,
 	.rereg_user_mr = mlx4_ib_rereg_user_mr,
 	.resize_cq = mlx4_ib_resize_cq,
+	.report_port_event = mlx4_ib_port_event,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, mlx4_ib_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, mlx4_ib_cq, ibcq),
-- 
2.33.0


