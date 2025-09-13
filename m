Return-Path: <linux-rdma+bounces-13333-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB816B55FB8
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Sep 2025 11:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9184958440E
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Sep 2025 09:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1F12EA72E;
	Sat, 13 Sep 2025 09:06:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7988A3D81
	for <linux-rdma@vger.kernel.org>; Sat, 13 Sep 2025 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757754388; cv=none; b=QrCQQg/tU+klXQsI6udMI/f0TSXPe2s0A/2uiP1waBmWtEir4HXXi9BGh3gzHuNp+A82o2y5J8RzkodEK3bA9/aCTp9oE3jWhnSJgDaidQyGaxK8qz7Vz//j9oWQcMOIY78tTEdqXXjAg2zAxeYrIP0TL0NKk+9NQWyMdUF4HVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757754388; c=relaxed/simple;
	bh=6Nwr7ESCyo2k2mF7s+mBmRgUdKhvQfjjSnhNlqjOiSU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLn0Ri2mDzeo9R61ojTC/VvXBu1mw3OIFmUqviN1DZ0m4NVzzoO6YQ9auzf/+YbexQBa13o5eE9+HcAs9loYG1NkJBS77YIFyhDHUY4W7rEB1ihle4ABsE8ALJ5rY29GplxS08WipnSC1ne5OvneRyLq72xl4U64prXTB05jjQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cP51D4KDRz1R9Bq;
	Sat, 13 Sep 2025 17:03:12 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 79FD11A0188;
	Sat, 13 Sep 2025 17:06:16 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 13 Sep 2025 17:06:15 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next 1/8] RDMA/hns: Add helpers to obtain netdev and bus_num from hr_dev
Date: Sat, 13 Sep 2025 17:06:08 +0800
Message-ID: <20250913090615.212720-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250913090615.212720-1-huangjunxian6@hisilicon.com>
References: <20250913090615.212720-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Add helpers to obtain netdev and bus_num from hr_dev.

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_ah.c     |  1 -
 drivers/infiniband/hw/hns/hns_roce_device.h | 12 ++++++++++++
 drivers/infiniband/hw/hns/hns_roce_main.c   | 19 ++++++++++---------
 drivers/infiniband/hw/hns/hns_roce_pd.c     |  1 -
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  5 +++--
 drivers/infiniband/hw/hns/hns_roce_srq.c    |  1 -
 6 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_ah.c b/drivers/infiniband/hw/hns/hns_roce_ah.c
index 307c35888b30..0c1c32d23c88 100644
--- a/drivers/infiniband/hw/hns/hns_roce_ah.c
+++ b/drivers/infiniband/hw/hns/hns_roce_ah.c
@@ -30,7 +30,6 @@
  * SOFTWARE.
  */
 
-#include <linux/pci.h>
 #include <rdma/ib_addr.h>
 #include <rdma/ib_cache.h>
 #include "hns_roce_device.h"
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 78ee04a48a74..5ae37832059f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -33,6 +33,7 @@
 #ifndef _HNS_ROCE_DEVICE_H
 #define _HNS_ROCE_DEVICE_H
 
+#include <linux/pci.h>
 #include <rdma/ib_verbs.h>
 #include <rdma/hns-abi.h>
 #include "hns_roce_debugfs.h"
@@ -1165,6 +1166,17 @@ static inline u8 get_tclass(const struct ib_global_route *grh)
 	       grh->traffic_class >> DSCP_SHIFT : grh->traffic_class;
 }
 
+static inline struct net_device *get_hr_netdev(struct hns_roce_dev *hr_dev,
+					       u8 port)
+{
+	return hr_dev->iboe.netdevs[port];
+}
+
+static inline u8 get_hr_bus_num(struct hns_roce_dev *hr_dev)
+{
+	return hr_dev->pci_dev->bus->number;
+}
+
 void hns_roce_init_uar_table(struct hns_roce_dev *dev);
 int hns_roce_uar_alloc(struct hns_roce_dev *dev, struct hns_roce_uar *uar);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index d50f36f8a110..8bca0b10c69e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -32,7 +32,6 @@
  */
 #include <linux/acpi.h>
 #include <linux/module.h>
-#include <linux/pci.h>
 #include <rdma/ib_addr.h>
 #include <rdma/ib_smi.h>
 #include <rdma/ib_user_verbs.h>
@@ -148,12 +147,13 @@ static int hns_roce_netdev_event(struct notifier_block *self,
 
 static int hns_roce_setup_mtu_mac(struct hns_roce_dev *hr_dev)
 {
+	struct net_device *net_dev;
 	int ret;
 	u8 i;
 
 	for (i = 0; i < hr_dev->caps.num_ports; i++) {
-		ret = hns_roce_set_mac(hr_dev, i,
-				       hr_dev->iboe.netdevs[i]->dev_addr);
+		net_dev = get_hr_netdev(hr_dev, i);
+		ret = hns_roce_set_mac(hr_dev, i, net_dev->dev_addr);
 		if (ret)
 			return ret;
 	}
@@ -246,7 +246,7 @@ static int hns_roce_query_port(struct ib_device *ib_dev, u32 port_num,
 
 	spin_lock_irqsave(&hr_dev->iboe.lock, flags);
 
-	net_dev = hr_dev->iboe.netdevs[port];
+	net_dev = get_hr_netdev(hr_dev, port);
 	if (!net_dev) {
 		spin_unlock_irqrestore(&hr_dev->iboe.lock, flags);
 		dev_err(dev, "find netdev %u failed!\n", port);
@@ -704,11 +704,12 @@ static const struct ib_device_ops hns_roce_dev_restrack_ops = {
 
 static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 {
-	int ret;
 	struct hns_roce_ib_iboe *iboe = NULL;
-	struct ib_device *ib_dev = NULL;
 	struct device *dev = hr_dev->dev;
+	struct ib_device *ib_dev = NULL;
+	struct net_device *net_dev;
 	unsigned int i;
+	int ret;
 
 	iboe = &hr_dev->iboe;
 	spin_lock_init(&iboe->lock);
@@ -744,11 +745,11 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 	ib_set_device_ops(ib_dev, &hns_roce_dev_ops);
 	ib_set_device_ops(ib_dev, &hns_roce_dev_restrack_ops);
 	for (i = 0; i < hr_dev->caps.num_ports; i++) {
-		if (!hr_dev->iboe.netdevs[i])
+		net_dev = get_hr_netdev(hr_dev, i);
+		if (!net_dev)
 			continue;
 
-		ret = ib_device_set_netdev(ib_dev, hr_dev->iboe.netdevs[i],
-					   i + 1);
+		ret = ib_device_set_netdev(ib_dev, net_dev, i + 1);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/infiniband/hw/hns/hns_roce_pd.c b/drivers/infiniband/hw/hns/hns_roce_pd.c
index d35cf59d0f43..225c3e328e0e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_pd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_pd.c
@@ -30,7 +30,6 @@
  * SOFTWARE.
  */
 
-#include <linux/pci.h>
 #include "hns_roce_device.h"
 
 void hns_roce_init_pd_table(struct hns_roce_dev *hr_dev)
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 6ff1b8ce580c..e0e28c4ff1ca 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -31,7 +31,6 @@
  * SOFTWARE.
  */
 
-#include <linux/pci.h>
 #include <rdma/ib_addr.h>
 #include <rdma/ib_umem.h>
 #include <rdma/uverbs_ioctl.h>
@@ -1350,11 +1349,13 @@ static int check_mtu_validate(struct hns_roce_dev *hr_dev,
 			      struct hns_roce_qp *hr_qp,
 			      struct ib_qp_attr *attr, int attr_mask)
 {
+	struct net_device *net_dev;
 	enum ib_mtu active_mtu;
 	int p;
 
 	p = attr_mask & IB_QP_PORT ? (attr->port_num - 1) : hr_qp->port;
-	active_mtu = iboe_get_mtu(hr_dev->iboe.netdevs[p]->mtu);
+	net_dev = get_hr_netdev(hr_dev, p);
+	active_mtu = iboe_get_mtu(net_dev->mtu);
 
 	if ((hr_dev->caps.max_mtu >= IB_MTU_2048 &&
 	    attr->path_mtu > hr_dev->caps.max_mtu) ||
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 1090051f493b..8a6efb6b9c9e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2018 Hisilicon Limited.
  */
 
-#include <linux/pci.h>
 #include <rdma/ib_umem.h>
 #include <rdma/uverbs_ioctl.h>
 #include "hns_roce_device.h"
-- 
2.33.0


