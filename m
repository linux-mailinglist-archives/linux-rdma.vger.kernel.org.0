Return-Path: <linux-rdma+bounces-6060-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D892D9D5D95
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 12:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0F6BB2268A
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 11:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BC61DE8AE;
	Fri, 22 Nov 2024 10:59:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AADF1CC8AA;
	Fri, 22 Nov 2024 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273188; cv=none; b=jssrSknsDmBXaoUWWrK4/P0ehbyKxSTC70Yo8VlcgS6AEqJvGQaditfiJfzxCAQ0+7/HQp488e1zgndrG2pcJ64lg4cOFdjX3og6r9Wxhkdhwu0vEI5aWHSv8W07ueS2SDEp4Cq4Ezccz30nUJoQSikA/sOU9qaWApyMQMmiD2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273188; c=relaxed/simple;
	bh=hXFhrqmBQtAbGowPu3pSviu+hV0X2If9r8cGCVUsvkU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EEKo4cUR4W+NdordoqhiON9AIFH3BDjK03W4/Vwnbz45GaXthbbolkrCRTy/7IesLn+YuTpgjSupLO8FljMC3R7sqmEJd9h9tyIG2wbEp/vbFDUF6nKxTioqQmik+z8NU4j+QcicxrR/4qW1sfZb1V7lUvE4i8nWrxJDo2LIlDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XvsWT0jCYz1T5FX;
	Fri, 22 Nov 2024 18:57:41 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B7EE18002B;
	Fri, 22 Nov 2024 18:59:43 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 Nov 2024 18:59:42 +0800
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
Subject: [PATCH RFC 04/12] RDMA/erdma: Remove deliver net device event
Date: Fri, 22 Nov 2024 18:53:00 +0800
Message-ID: <20241122105308.2150505-5-huangjunxian6@hisilicon.com>
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

Since the netdev events of link status is now handled in ib_core,
remove the related code in drivers.

In addition, remove dev->state as it is only used in erdma_query_port(),
and it can be replaced by ib_get_curr_port_state().

Signed-off-by: Yuyu Li <liyuyu6@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/erdma/erdma.h       | 2 --
 drivers/infiniband/hw/erdma/erdma_main.c  | 8 --------
 drivers/infiniband/hw/erdma/erdma_verbs.c | 8 ++------
 3 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma.h b/drivers/infiniband/hw/erdma/erdma.h
index 3c166359448d..7ba554da992d 100644
--- a/drivers/infiniband/hw/erdma/erdma.h
+++ b/drivers/infiniband/hw/erdma/erdma.h
@@ -192,8 +192,6 @@ struct erdma_dev {
 	u8 __iomem *func_bar;
 
 	struct erdma_devattr attrs;
-	/* physical port state (only one port per device) */
-	enum ib_port_state state;
 	u32 mtu;
 
 	/* cmdq and aeq use the same msix vector */
diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index 62f497a71004..c5cdf7a4aa2d 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -26,14 +26,6 @@ static int erdma_netdev_event(struct notifier_block *nb, unsigned long event,
 		goto done;
 
 	switch (event) {
-	case NETDEV_UP:
-		dev->state = IB_PORT_ACTIVE;
-		erdma_port_event(dev, IB_EVENT_PORT_ACTIVE);
-		break;
-	case NETDEV_DOWN:
-		dev->state = IB_PORT_DOWN;
-		erdma_port_event(dev, IB_EVENT_PORT_ERR);
-		break;
 	case NETDEV_CHANGEMTU:
 		if (dev->mtu != netdev->mtu) {
 			erdma_set_mtu(dev, netdev->mtu);
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 51d619edb6c5..65a65416343c 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -377,14 +377,10 @@ int erdma_query_port(struct ib_device *ibdev, u32 port,
 	ib_get_eth_speed(ibdev, port, &attr->active_speed, &attr->active_width);
 	attr->max_mtu = ib_mtu_int_to_enum(ndev->mtu);
 	attr->active_mtu = ib_mtu_int_to_enum(ndev->mtu);
-	if (netif_running(ndev) && netif_carrier_ok(ndev))
-		dev->state = IB_PORT_ACTIVE;
-	else
-		dev->state = IB_PORT_DOWN;
-	attr->state = dev->state;
+	attr->state = ib_get_curr_port_state(ndev);
 
 out:
-	if (dev->state == IB_PORT_ACTIVE)
+	if (attr->state == IB_PORT_ACTIVE)
 		attr->phys_state = IB_PORT_PHYS_STATE_LINK_UP;
 	else
 		attr->phys_state = IB_PORT_PHYS_STATE_DISABLED;
-- 
2.33.0


