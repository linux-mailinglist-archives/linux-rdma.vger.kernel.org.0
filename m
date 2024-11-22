Return-Path: <linux-rdma+bounces-6065-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DC59D5DA0
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 12:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6135B22C70
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 11:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B471DED53;
	Fri, 22 Nov 2024 10:59:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4101D1DED6D;
	Fri, 22 Nov 2024 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273191; cv=none; b=kCGJK9yYTFGIRVzPJCo5z4HI7X4DfhrF/VFtdNzZeG/M3jAW7KHmmsRspVd+DfaOiTb3RsuJ+mFeI/uM+936gTeGzihGKazqccfai5Pgj2+f4WqFWCPglqbMFXyziGyhFvVxHkDKITmpDD8/nwSOsrxlJwJPP3J/RBjoO8TqPNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273191; c=relaxed/simple;
	bh=G8Eot4p3DQpSCqYcpocwVH08lCFhMK7sNDTgHt7LRO4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UcqrZP9quZDZ2kjDRTivEAx8zv3zYZeB/z+j1FprZ80Ot5hvnpmfC5cRvqSPPx14UAzOxcZbDEwdcxrq00fPVZ3j47ykepauyBvW6IWlvXbXeaVhqZU+1YKY5WHE8KAWfmOh3KuFSGKvHuO0ODy4Igwi6/ap50HZ6ZLSYNbbu/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XvsWf261WzqSXf;
	Fri, 22 Nov 2024 18:57:50 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 375D9180106;
	Fri, 22 Nov 2024 18:59:41 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 Nov 2024 18:59:40 +0800
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
Subject: [PATCH RFC 01/12] RDMA/core: Add ib_query_netdev_port() to query netdev port by IB device.
Date: Fri, 22 Nov 2024 18:52:57 +0800
Message-ID: <20241122105308.2150505-2-huangjunxian6@hisilicon.com>
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

Query the port number of a netdev associated with an ibdev.

Signed-off-by: Yuyu Li <liyuyu6@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/core/device.c | 39 ++++++++++++++++++++++++++------
 include/rdma/ib_verbs.h          |  2 ++
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index ca9b956c034d..c60dd50d434f 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2295,6 +2295,33 @@ struct net_device *ib_device_get_netdev(struct ib_device *ib_dev,
 }
 EXPORT_SYMBOL(ib_device_get_netdev);
 
+/**
+ * ib_query_netdev_port - Query the port number of a net_device
+ * associated with an ibdev
+ * @ibdev: IB device
+ * @ndev: Network device
+ * @port: IB port the net_device is connected to
+ */
+int ib_query_netdev_port(struct ib_device *ibdev, struct net_device *ndev,
+			 u32 *port)
+{
+	struct net_device *ib_ndev;
+	u32 port_num;
+
+	rdma_for_each_port(ibdev, port_num) {
+		ib_ndev = ib_device_get_netdev(ibdev, port_num);
+		if (ndev == ib_ndev) {
+			*port = port_num;
+			dev_put(ib_ndev);
+			return 0;
+		}
+		dev_put(ib_ndev);
+	}
+
+	return -ENOENT;
+}
+EXPORT_SYMBOL(ib_query_netdev_port);
+
 /**
  * ib_device_get_by_netdev - Find an IB device associated with a netdev
  * @ndev: netdev to locate
@@ -2858,7 +2885,6 @@ static int ib_netdevice_event(struct notifier_block *this,
 			      unsigned long event, void *ptr)
 {
 	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
-	struct net_device *ib_ndev;
 	struct ib_device *ibdev;
 	u32 port;
 
@@ -2868,13 +2894,12 @@ static int ib_netdevice_event(struct notifier_block *this,
 		if (!ibdev)
 			return NOTIFY_DONE;
 
-		rdma_for_each_port(ibdev, port) {
-			ib_ndev = ib_device_get_netdev(ibdev, port);
-			if (ndev == ib_ndev)
-				rdma_nl_notify_event(ibdev, port,
-						     RDMA_NETDEV_RENAME_EVENT);
-			dev_put(ib_ndev);
+		if (ib_query_netdev_port(ibdev, ndev, &port)) {
+			ib_device_put(ibdev);
+			break;
 		}
+
+		rdma_nl_notify_event(ibdev, port, RDMA_NETDEV_RENAME_EVENT);
 		ib_device_put(ibdev);
 		break;
 	default:
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 3417636da960..b5ee5e748a47 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4469,6 +4469,8 @@ int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
 			 unsigned int port);
 struct net_device *ib_device_get_netdev(struct ib_device *ib_dev,
 					u32 port);
+int ib_query_netdev_port(struct ib_device *ibdev, struct net_device *ndev,
+			 u32 *port);
 struct ib_wq *ib_create_wq(struct ib_pd *pd,
 			   struct ib_wq_init_attr *init_attr);
 int ib_destroy_wq_user(struct ib_wq *wq, struct ib_udata *udata);
-- 
2.33.0


