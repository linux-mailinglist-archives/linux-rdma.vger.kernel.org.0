Return-Path: <linux-rdma+bounces-6064-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A43479D5D9F
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 12:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35E6EB22CDC
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 11:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02871DF74F;
	Fri, 22 Nov 2024 10:59:51 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BA31DEFC7;
	Fri, 22 Nov 2024 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273191; cv=none; b=U0H8fNAjpR8FJK9mUoLXlUT88TlnaNGwKcIKiMcvZJdfLhRcKxlaWRIpXKXPFfAfzf/UJKpLqbGo5tyUlvn4cRkn5oYhNjPvFvyPM0CSIR3zQatSvsC/WS0uWc0mFL2TG4B6APINRpVm1ISxR7CBE/wLLErQeddlr3IbAzGsUaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273191; c=relaxed/simple;
	bh=XF/yJgQsWd5nS4twAMCFtfza8m+kJeN+0vHgtkL573o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7hA1dFPxHj0fI26veUWFegxHDRgaRdhvpjVsfGUdQITtaLXxm3cAUa7wnXjJ1WTTk5oRpEOF3qSKW5+qW0RXuDvC3cQ7l0KWpqkCAAHWWHvHX57GdS6YXS7WRp+4Jp5KeMi8XiXddG2dEZ/7koDeLLMA0eFyAN9gRFmfczQtXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XvsXG6bQ4z21ldb;
	Fri, 22 Nov 2024 18:58:22 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B5EB140158;
	Fri, 22 Nov 2024 18:59:47 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 Nov 2024 18:59:46 +0800
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
Subject: [PATCH RFC 10/12] RDMA/pvrdma: Support report_port_event() ops
Date: Fri, 22 Nov 2024 18:53:06 +0800
Message-ID: <20241122105308.2150505-11-huangjunxian6@hisilicon.com>
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
 .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    | 42 +++++++++++++------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
index 768aad364c89..4bf6c7b682b5 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -181,6 +181,7 @@ static const struct ib_device_ops pvrdma_dev_ops = {
 	.query_qp = pvrdma_query_qp,
 	.reg_user_mr = pvrdma_reg_user_mr,
 	.req_notify_cq = pvrdma_req_notify_cq,
+	.report_port_event = pvrdma_report_event_handle,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, pvrdma_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, pvrdma_cq, ibcq),
@@ -666,21 +667,8 @@ static void pvrdma_netdevice_event_handle(struct pvrdma_dev *dev,
 
 	switch (event) {
 	case NETDEV_REBOOT:
-	case NETDEV_DOWN:
 		pvrdma_dispatch_event(dev, 1, IB_EVENT_PORT_ERR);
 		break;
-	case NETDEV_UP:
-		pvrdma_write_reg(dev, PVRDMA_REG_CTL,
-				 PVRDMA_DEVICE_CTL_UNQUIESCE);
-
-		mb();
-
-		if (pvrdma_read_reg(dev, PVRDMA_REG_ERR))
-			dev_err(&dev->pdev->dev,
-				"failed to activate device during link up\n");
-		else
-			pvrdma_dispatch_event(dev, 1, IB_EVENT_PORT_ACTIVE);
-		break;
 	case NETDEV_UNREGISTER:
 		ib_device_set_netdev(&dev->ib_dev, NULL, 1);
 		dev_put(dev->netdev);
@@ -708,6 +696,34 @@ static void pvrdma_netdevice_event_handle(struct pvrdma_dev *dev,
 	}
 }
 
+static void pvrdma_report_event_handle(struct ib_device *ibdev,
+				       struct net_device *ndev,
+				       unsigned long event)
+{
+	struct pvrdma_dev *dev = container_of(ibdev, struct pvrdma_dev, ib_dev);
+
+	switch (event) {
+	case NETDEV_DOWN:
+		pvrdma_dispatch_event(dev, 1, IB_EVENT_PORT_ERR);
+		break;
+	case NETDEV_UP:
+		pvrdma_write_reg(dev, PVRDMA_REG_CTL,
+				 PVRDMA_DEVICE_CTL_UNQUIESCE);
+
+		mb();
+
+		if (pvrdma_read_reg(dev, PVRDMA_REG_ERR))
+			dev_err(&dev->pdev->dev,
+				"failed to activate device during link up\n");
+		else
+			pvrdma_dispatch_event(dev, 1, IB_EVENT_PORT_ACTIVE);
+		break;
+
+	default:
+		break;
+	}
+}
+
 static void pvrdma_netdevice_event_work(struct work_struct *work)
 {
 	struct pvrdma_netdevice_work *netdev_work;
-- 
2.33.0


