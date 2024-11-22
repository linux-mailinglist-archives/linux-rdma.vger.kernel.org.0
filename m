Return-Path: <linux-rdma+bounces-6058-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D84239D5D93
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 12:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B47DB2276B
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 11:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDD61DE2AB;
	Fri, 22 Nov 2024 10:59:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D0D1C4A3F;
	Fri, 22 Nov 2024 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273188; cv=none; b=WaACYrCUvfV7CqNZcMBxc3Y5FwlCw7Rvk5/8o7bHJLcpxd0HWOfx/z2GM8btUOSVxBPZ29jmC2hxdtVAp2Nv4rn+lhpvmPNDycWmCapSNaqy0Pm11nAYA2TQ5EPeKjoB4iXwWg+kDWRaJITF45rg7L4G3biAUSxsi2GgOogkrlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273188; c=relaxed/simple;
	bh=qT4tYrFkMfe7kfTchGNmvNv//LVumLq2SW4nrNpzDuQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eu0xG17jSIMTQwGiOY258UnfuJ2sT8DVxY2Q//31GDsA0hxi9hk/KMQ+iGqD90o/HqDRCgcxrkYLs4ThAMJprJPeMKJeFht2b+NKL2xAGeW33jsxsnnSc5PKASLFLIzWe960C9uKIDyLEPCsvCYsFvKFDtkHFrX5KjkKxwrVTc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XvsS90SKtz1JCls;
	Fri, 22 Nov 2024 18:54:49 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B72A1A016C;
	Fri, 22 Nov 2024 18:59:42 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 Nov 2024 18:59:41 +0800
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
Subject: [PATCH RFC 03/12] RDMA/bnxt_re: Remove deliver net device event
Date: Fri, 22 Nov 2024 18:52:59 +0800
Message-ID: <20241122105308.2150505-4-huangjunxian6@hisilicon.com>
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

Signed-off-by: Yuyu Li <liyuyu6@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 59 ----------------------------
 1 file changed, 59 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 298c848f3a4d..973c1ecde4cf 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -81,8 +81,6 @@ static DEFINE_MUTEX(bnxt_re_mutex);
 
 static void bnxt_re_stop_irq(void *handle);
 static void bnxt_re_dev_stop(struct bnxt_re_dev *rdev);
-static int bnxt_re_netdev_event(struct notifier_block *notifier,
-				unsigned long event, void *ptr);
 static struct bnxt_re_dev *bnxt_re_from_netdev(struct net_device *netdev);
 static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type);
 static int bnxt_re_hwrm_qcaps(struct bnxt_re_dev *rdev);
@@ -2169,14 +2167,6 @@ static int bnxt_re_add_device(struct auxiliary_device *adev, u8 op_type)
 		goto re_dev_uninit;
 	}
 
-	rdev->nb.notifier_call = bnxt_re_netdev_event;
-	rc = register_netdevice_notifier(&rdev->nb);
-	if (rc) {
-		rdev->nb.notifier_call = NULL;
-		pr_err("%s: Cannot register to netdevice_notifier",
-		       ROCE_DRV_MODULE_NAME);
-		return rc;
-	}
 	bnxt_re_setup_cc(rdev, true);
 
 	return 0;
@@ -2214,55 +2204,6 @@ static void bnxt_re_setup_cc(struct bnxt_re_dev *rdev, bool enable)
 		ibdev_err(&rdev->ibdev, "Failed to setup CC enable = %d\n", enable);
 }
 
-/*
- * "Notifier chain callback can be invoked for the same chain from
- * different CPUs at the same time".
- *
- * For cases when the netdev is already present, our call to the
- * register_netdevice_notifier() will actually get the rtnl_lock()
- * before sending NETDEV_REGISTER and (if up) NETDEV_UP
- * events.
- *
- * But for cases when the netdev is not already present, the notifier
- * chain is subjected to be invoked from different CPUs simultaneously.
- *
- * This is protected by the netdev_mutex.
- */
-static int bnxt_re_netdev_event(struct notifier_block *notifier,
-				unsigned long event, void *ptr)
-{
-	struct net_device *real_dev, *netdev = netdev_notifier_info_to_dev(ptr);
-	struct bnxt_re_dev *rdev;
-
-	real_dev = rdma_vlan_dev_real_dev(netdev);
-	if (!real_dev)
-		real_dev = netdev;
-
-	if (real_dev != netdev)
-		goto exit;
-
-	rdev = bnxt_re_from_netdev(real_dev);
-	if (!rdev)
-		return NOTIFY_DONE;
-
-
-	switch (event) {
-	case NETDEV_UP:
-	case NETDEV_DOWN:
-	case NETDEV_CHANGE:
-		bnxt_re_dispatch_event(&rdev->ibdev, NULL, 1,
-					netif_carrier_ok(real_dev) ?
-					IB_EVENT_PORT_ACTIVE :
-					IB_EVENT_PORT_ERR);
-		break;
-	default:
-		break;
-	}
-	ib_device_put(&rdev->ibdev);
-exit:
-	return NOTIFY_DONE;
-}
-
 #define BNXT_ADEV_NAME "bnxt_en"
 
 static void bnxt_re_remove_device(struct bnxt_re_dev *rdev, u8 op_type,
-- 
2.33.0


