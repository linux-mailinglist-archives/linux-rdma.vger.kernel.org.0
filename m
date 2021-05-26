Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10223918CA
	for <lists+linux-rdma@lfdr.de>; Wed, 26 May 2021 15:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhEZN3b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 May 2021 09:29:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3952 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbhEZN3b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 May 2021 09:29:31 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FqsBS2wf9zCxKg;
        Wed, 26 May 2021 21:25:04 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 26 May 2021 21:27:56 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 26
 May 2021 21:27:56 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>, <yuehaibing@huawei.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] IB/ipoib: use DEVICE_ATTR_*() macro
Date:   Wed, 26 May 2021 21:27:53 +0800
Message-ID: <20210526132753.3092-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use DEVICE_ATTR_*() helper instead of plain DEVICE_ATTR,
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_cm.c   | 10 ++++----
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 28 +++++++++++------------
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c |  6 ++---
 3 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
index 9dbc85a6b702..64c4f78cfa4a 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
@@ -1503,8 +1503,8 @@ static void ipoib_cm_stale_task(struct work_struct *work)
 	spin_unlock_irq(&priv->lock);
 }
 
-static ssize_t show_mode(struct device *d, struct device_attribute *attr,
-			 char *buf)
+static ssize_t mode_show(struct device *d,
+			 struct device_attribute *attr, char *buf)
 {
 	struct net_device *dev = to_net_dev(d);
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
@@ -1515,8 +1515,8 @@ static ssize_t show_mode(struct device *d, struct device_attribute *attr,
 		return sysfs_emit(buf, "datagram\n");
 }
 
-static ssize_t set_mode(struct device *d, struct device_attribute *attr,
-			const char *buf, size_t count)
+static ssize_t mode_store(struct device *d, struct device_attribute *attr,
+			  const char *buf, size_t count)
 {
 	struct net_device *dev = to_net_dev(d);
 	int ret;
@@ -1542,7 +1542,7 @@ static ssize_t set_mode(struct device *d, struct device_attribute *attr,
 	return (!ret || ret == -EBUSY) ? count : ret;
 }
 
-static DEVICE_ATTR(mode, S_IWUSR | S_IRUGO, show_mode, set_mode);
+static DEVICE_ATTR_RW(mode);
 
 int ipoib_cm_add_mode_attr(struct net_device *dev)
 {
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index bbb18087fdab..0104e267f0a8 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -2268,7 +2268,7 @@ void ipoib_intf_free(struct net_device *dev)
 	kfree(priv);
 }
 
-static ssize_t show_pkey(struct device *dev,
+static ssize_t pkey_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
 	struct net_device *ndev = to_net_dev(dev);
@@ -2276,9 +2276,9 @@ static ssize_t show_pkey(struct device *dev,
 
 	return sysfs_emit(buf, "0x%04x\n", priv->pkey);
 }
-static DEVICE_ATTR(pkey, S_IRUGO, show_pkey, NULL);
+static DEVICE_ATTR_RO(pkey);
 
-static ssize_t show_umcast(struct device *dev,
+static ssize_t umcast_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
 	struct net_device *ndev = to_net_dev(dev);
@@ -2300,9 +2300,8 @@ void ipoib_set_umcast(struct net_device *ndev, int umcast_val)
 		clear_bit(IPOIB_FLAG_UMCAST, &priv->flags);
 }
 
-static ssize_t set_umcast(struct device *dev,
-			  struct device_attribute *attr,
-			  const char *buf, size_t count)
+static ssize_t umcast_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	unsigned long umcast_val = simple_strtoul(buf, NULL, 0);
 
@@ -2310,7 +2309,7 @@ static ssize_t set_umcast(struct device *dev,
 
 	return count;
 }
-static DEVICE_ATTR(umcast, S_IWUSR | S_IRUGO, show_umcast, set_umcast);
+static DEVICE_ATTR_RW(umcast);
 
 int ipoib_add_umcast_attr(struct net_device *dev)
 {
@@ -2381,9 +2380,8 @@ static int ipoib_set_mac(struct net_device *dev, void *addr)
 	return 0;
 }
 
-static ssize_t create_child(struct device *dev,
-			    struct device_attribute *attr,
-			    const char *buf, size_t count)
+static ssize_t create_child_store(struct device *dev, struct device_attribute *attr,
+				  const char *buf, size_t count)
 {
 	int pkey;
 	int ret;
@@ -2398,11 +2396,11 @@ static ssize_t create_child(struct device *dev,
 
 	return ret ? ret : count;
 }
-static DEVICE_ATTR(create_child, S_IWUSR, NULL, create_child);
+static DEVICE_ATTR_WO(create_child);
 
-static ssize_t delete_child(struct device *dev,
-			    struct device_attribute *attr,
-			    const char *buf, size_t count)
+static ssize_t delete_child_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
 {
 	int pkey;
 	int ret;
@@ -2418,7 +2416,7 @@ static ssize_t delete_child(struct device *dev,
 	return ret ? ret : count;
 
 }
-static DEVICE_ATTR(delete_child, S_IWUSR, NULL, delete_child);
+static DEVICE_ATTR_WO(delete_child);
 
 int ipoib_add_pkey_attr(struct net_device *dev)
 {
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
index 5958840dbeed..3923c3b1fd93 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
@@ -40,15 +40,15 @@
 
 #include "ipoib.h"
 
-static ssize_t show_parent(struct device *d, struct device_attribute *attr,
-			   char *buf)
+static ssize_t parent_show(struct device *d,
+			   struct device_attribute *attr, char *buf)
 {
 	struct net_device *dev = to_net_dev(d);
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
 
 	return sysfs_emit(buf, "%s\n", priv->parent->name);
 }
-static DEVICE_ATTR(parent, S_IRUGO, show_parent, NULL);
+static DEVICE_ATTR_RO(parent);
 
 static bool is_child_unique(struct ipoib_dev_priv *ppriv,
 			    struct ipoib_dev_priv *priv)
-- 
2.17.1

