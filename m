Return-Path: <linux-rdma+bounces-14431-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B23DCC5162A
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 10:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945FB1882EF3
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 09:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EDB3009F1;
	Wed, 12 Nov 2025 09:35:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B957F301000
	for <linux-rdma@vger.kernel.org>; Wed, 12 Nov 2025 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940123; cv=none; b=HNqrtQvC5FdSWE0+UOdJKhbZMtuBnawMQglJ9dFajRgokoqKULDhIs9BRetMoDKpfb/hZuke2q1ZiFBbf1e/EddSRqn06e8f5XsjSZgC7MCObupZEGVEMBy876MWb7qIwasOnj94/j/Wtmh3W4+fTcf2CRXWFhGdY6OsgQX3g20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940123; c=relaxed/simple;
	bh=6Nwr7ESCyo2k2mF7s+mBmRgUdKhvQfjjSnhNlqjOiSU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMlcIrhUC5CmCLbAo35orQKw7AA6BaDvixwN9xIbSXFC38KnBcV27xlKmjx8btLzsYJzVpF2gpaW2gVUf4fiXq7WMN8+NA3hF+GZZ2aPr1fOSe1kwyJFojz8rsZIqU1lSnG+OsOjZhT5zcNDpuISxQUPxSwFfwViAiLLn7J8syQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4d5yrX3TskzRhRd;
	Wed, 12 Nov 2025 17:33:32 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 7BF0F180B50;
	Wed, 12 Nov 2025 17:35:11 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Nov 2025 17:35:11 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH v3 for-next 1/8] RDMA/hns: Add helpers to obtain netdev and bus_num from hr_dev
Date: Wed, 12 Nov 2025 17:35:03 +0800
Message-ID: <20251112093510.3696363-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251112093510.3696363-1-huangjunxian6@hisilicon.com>
References: <20251112093510.3696363-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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


