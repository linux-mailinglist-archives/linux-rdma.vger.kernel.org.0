Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46C1A151700
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2020 09:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgBDIYr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Feb 2020 03:24:47 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10150 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727097AbgBDIYq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Feb 2020 03:24:46 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 98451599706DB2841E24;
        Tue,  4 Feb 2020 16:24:39 +0800 (CST)
Received: from SZA160416817.china.huawei.com (10.46.14.205) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Tue, 4 Feb 2020 16:24:30 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH RFC v2 for-next 1/7] RDMA/core: add inactive attribute of ib_port_cache
Date:   Tue, 4 Feb 2020 16:24:02 +0800
Message-ID: <20200204082408.18728-2-liweihang@huawei.com>
X-Mailer: git-send-email 2.10.0.windows.1
In-Reply-To: <20200204082408.18728-1-liweihang@huawei.com>
References: <20200204082408.18728-1-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.46.14.205]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Add attribute inactive to mark bonding backup port.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
---
 drivers/infiniband/core/cache.c | 16 +++++++++++++++-
 include/rdma/ib_cache.h         | 10 ++++++++++
 include/rdma/ib_verbs.h         |  2 ++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index d535995..7a7ef0e 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1175,6 +1175,19 @@ int ib_get_cached_port_state(struct ib_device   *device,
 }
 EXPORT_SYMBOL(ib_get_cached_port_state);
 
+u8 ib_get_cached_port_inactive_status(struct ib_device *device, u8 port_num)
+{
+	unsigned long flags;
+	u8 inactive;
+
+	read_lock_irqsave(&device->cache.lock, flags);
+	inactive = device->port_data[port_num].cache.inactive;
+	read_unlock_irqrestore(&device->cache.lock, flags);
+
+	return inactive;
+}
+EXPORT_SYMBOL(ib_get_cached_port_inactive_status);
+
 /**
  * rdma_get_gid_attr - Returns GID attributes for a port of a device
  * at a requested gid_index, if a valid GID entry exists.
@@ -1393,7 +1406,7 @@ static void ib_cache_update(struct ib_device *device,
 	if (!rdma_is_port_valid(device, port))
 		return;
 
-	tprops = kmalloc(sizeof *tprops, GFP_KERNEL);
+	tprops = kzalloc(sizeof *tprops, GFP_KERNEL);
 	if (!tprops)
 		return;
 
@@ -1435,6 +1448,7 @@ static void ib_cache_update(struct ib_device *device,
 	device->port_data[port].cache.pkey = pkey_cache;
 	device->port_data[port].cache.lmc = tprops->lmc;
 	device->port_data[port].cache.port_state = tprops->state;
+	device->port_data[port].cache.inactive = tprops->inactive;
 
 	device->port_data[port].cache.subnet_prefix = tprops->subnet_prefix;
 	write_unlock_irq(&device->cache.lock);
diff --git a/include/rdma/ib_cache.h b/include/rdma/ib_cache.h
index 870b5e6..63b2dd6 100644
--- a/include/rdma/ib_cache.h
+++ b/include/rdma/ib_cache.h
@@ -131,6 +131,16 @@ int ib_get_cached_port_state(struct ib_device *device,
 			      u8                port_num,
 			      enum ib_port_state *port_active);
 
+/**
+ * ib_get_cached_port_inactive_status - Returns a cached port inactive status
+ * @device: The device to query.
+ * @port_num: The port number of the device to query.
+ *
+ * ib_get_cached_port_inactive_status() fetches the specified event inactive
+ * status stored in the local software cache.
+ */
+u8 ib_get_cached_port_inactive_status(struct ib_device *device, u8 port_num);
+
 bool rdma_is_zero_gid(const union ib_gid *gid);
 const struct ib_gid_attr *rdma_get_gid_attr(struct ib_device *device,
 					    u8 port_num, int index);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 5608e14..e17d846 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -665,6 +665,7 @@ struct ib_port_attr {
 	u8			active_speed;
 	u8                      phys_state;
 	u16			port_cap_flags2;
+	u8 			inactive;
 };
 
 enum ib_device_modify_flags {
@@ -2145,6 +2146,7 @@ struct ib_port_cache {
 	struct ib_gid_table   *gid;
 	u8                     lmc;
 	enum ib_port_state     port_state;
+	u8                     inactive;
 };
 
 struct ib_cache {
-- 
2.8.1


