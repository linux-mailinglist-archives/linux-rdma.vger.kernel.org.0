Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E17B37228
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 12:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfFFKyW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 06:54:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfFFKyW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 Jun 2019 06:54:22 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32A4720883;
        Thu,  6 Jun 2019 10:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559818460;
        bh=zRI73Qo6ntoVUV/AuQtUAPdDTRgAkq5WrQKoGUgzX40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2qxIa5KVBOELSMt0zneR1tSo1PaEUyS7CGWOt40prmja/D7snkpdQkx+PXcm/FQEx
         mj72fHDOHs2qCvRRRh+YH5XPBv/K9Tbeg26nOaT2y8RNrabKYsF2ovOm7SNE6qjqrz
         vYplss0NFU5oWyTc1oNGL7bnSfb45KHxXnqqEUqU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH rdma-next v3 05/17] RDMA/counter: Add set/clear per-port auto mode support
Date:   Thu,  6 Jun 2019 13:53:33 +0300
Message-Id: <20190606105345.8546-6-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606105345.8546-1-leon@kernel.org>
References: <20190606105345.8546-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markz@mellanox.com>

Add an API to support set/clear per-port auto mode.

Signed-off-by: Mark Zhang <markz@mellanox.com>
Reviewed-by: Majd Dibbiny <majd@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/Makefile   |  2 +-
 drivers/infiniband/core/counters.c | 74 ++++++++++++++++++++++++++++++
 drivers/infiniband/core/device.c   |  7 ++-
 include/rdma/ib_verbs.h            |  2 +
 include/rdma/rdma_counter.h        | 24 ++++++++++
 include/uapi/rdma/rdma_netlink.h   | 26 +++++++++++
 6 files changed, 133 insertions(+), 2 deletions(-)
 create mode 100644 drivers/infiniband/core/counters.c

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index 313f2349b518..cddf748c15c9 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -12,7 +12,7 @@ ib_core-y :=			packer.o ud_header.o verbs.o cq.o rw.o sysfs.o \
 				device.o fmr_pool.o cache.o netlink.o \
 				roce_gid_mgmt.o mr_pool.o addr.o sa_query.o \
 				multicast.o mad.o smi.o agent.o mad_rmpp.o \
-				nldev.o restrack.o
+				nldev.o restrack.o counters.o
 
 ib_core-$(CONFIG_SECURITY_INFINIBAND) += security.o
 ib_core-$(CONFIG_CGROUP_RDMA) += cgroup.o
diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
new file mode 100644
index 000000000000..6cae8bf14997
--- /dev/null
+++ b/drivers/infiniband/core/counters.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2019 Mellanox Technologies. All rights reserved.
+ */
+#include <rdma/ib_verbs.h>
+#include <rdma/rdma_counter.h>
+
+#include "core_priv.h"
+#include "restrack.h"
+
+#define ALL_AUTO_MODE_MASKS (RDMA_COUNTER_MASK_QP_TYPE)
+
+static int __counter_set_mode(struct rdma_counter_mode *curr,
+			      enum rdma_nl_counter_mode new_mode,
+			      enum rdma_nl_counter_mask new_mask)
+{
+	if ((new_mode == RDMA_COUNTER_MODE_AUTO) &&
+	    ((new_mask & (~ALL_AUTO_MODE_MASKS)) ||
+	     (curr->mode != RDMA_COUNTER_MODE_NONE)))
+		return -EINVAL;
+
+	curr->mode = new_mode;
+	curr->mask = new_mask;
+	return 0;
+}
+
+/**
+ * rdma_counter_set_auto_mode() - Turn on/off per-port auto mode
+ *
+ * When @on is true, the @mask must be set
+ */
+int rdma_counter_set_auto_mode(struct ib_device *dev, u8 port,
+			       bool on, enum rdma_nl_counter_mask mask)
+{
+	struct rdma_port_counter *port_counter;
+	int ret;
+
+	port_counter = &dev->port_data[port].port_counter;
+	mutex_lock(&port_counter->lock);
+	if (on) {
+		ret = __counter_set_mode(&port_counter->mode,
+					 RDMA_COUNTER_MODE_AUTO, mask);
+	} else {
+		if (port_counter->mode.mode != RDMA_COUNTER_MODE_AUTO) {
+			ret = -EINVAL;
+			goto out;
+		}
+		ret = __counter_set_mode(&port_counter->mode,
+					 RDMA_COUNTER_MODE_NONE, 0);
+	}
+
+out:
+	mutex_unlock(&port_counter->lock);
+	return ret;
+}
+
+void rdma_counter_init(struct ib_device *dev)
+{
+	struct rdma_port_counter *port_counter;
+	u32 port;
+
+	if (!dev->port_data)
+		return;
+
+	rdma_for_each_port(dev, port) {
+		port_counter = &dev->port_data[port].port_counter;
+		port_counter->mode.mode = RDMA_COUNTER_MODE_NONE;
+		mutex_init(&port_counter->lock);
+	}
+}
+
+void rdma_counter_release(struct ib_device *dev)
+{
+}
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index a6ec46c85867..4563c838d865 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -46,6 +46,7 @@
 #include <rdma/rdma_netlink.h>
 #include <rdma/ib_addr.h>
 #include <rdma/ib_cache.h>
+#include <rdma/rdma_counter.h>
 
 #include "core_priv.h"
 #include "restrack.h"
@@ -493,10 +494,12 @@ static void ib_device_release(struct device *device)
 	ib_security_release_port_pkey_list(dev);
 	xa_destroy(&dev->compat_devs);
 	xa_destroy(&dev->client_data);
-	if (dev->port_data)
+	if (dev->port_data) {
+		rdma_counter_release(dev);
 		kfree_rcu(container_of(dev->port_data, struct ib_port_data_rcu,
 				       pdata[0]),
 			  rcu_head);
+	}
 	kfree_rcu(dev, rcu_head);
 }
 
@@ -1315,6 +1318,8 @@ int ib_register_device(struct ib_device *device, const char *name)
 
 	ib_device_register_rdmacg(device);
 
+	rdma_counter_init(device);
+
 	/*
 	 * Ensure that ADD uevent is not fired because it
 	 * is too early amd device is not initialized yet.
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index a8ad012e8eaf..8754873d01c9 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -62,6 +62,7 @@
 #include <linux/irqflags.h>
 #include <linux/preempt.h>
 #include <uapi/rdma/ib_user_verbs.h>
+#include <rdma/rdma_counter.h>
 #include <rdma/restrack.h>
 #include <uapi/rdma/rdma_user_ioctl.h>
 #include <uapi/rdma/ib_user_ioctl_verbs.h>
@@ -2243,6 +2244,7 @@ struct ib_port_data {
 	spinlock_t netdev_lock;
 	struct net_device __rcu *netdev;
 	struct hlist_node ndev_hash_link;
+	struct rdma_port_counter port_counter;
 };
 
 /* rdma netdev type - specifies protocol type */
diff --git a/include/rdma/rdma_counter.h b/include/rdma/rdma_counter.h
index 283ac1a0cdb7..8dd2619c015d 100644
--- a/include/rdma/rdma_counter.h
+++ b/include/rdma/rdma_counter.h
@@ -6,8 +6,26 @@
 #ifndef _RDMA_COUNTER_H_
 #define _RDMA_COUNTER_H_
 
+#include <linux/mutex.h>
+
 #include <rdma/ib_verbs.h>
 #include <rdma/restrack.h>
+#include <rdma/rdma_netlink.h>
+
+struct auto_mode_param {
+	int qp_type;
+};
+
+struct rdma_counter_mode {
+	enum rdma_nl_counter_mode mode;
+	enum rdma_nl_counter_mask mask;
+	struct auto_mode_param param;
+};
+
+struct rdma_port_counter {
+	struct rdma_counter_mode mode;
+	struct mutex lock;
+};
 
 struct rdma_counter {
 	struct rdma_restrack_entry	res;
@@ -15,4 +33,10 @@ struct rdma_counter {
 	uint32_t			id;
 	u8				port;
 };
+
+void rdma_counter_init(struct ib_device *dev);
+void rdma_counter_release(struct ib_device *dev);
+int rdma_counter_set_auto_mode(struct ib_device *dev, u8 port,
+			       bool on, enum rdma_nl_counter_mask mask);
+
 #endif /* _RDMA_COUNTER_H_ */
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 41db51367efa..14f26b06155f 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -484,4 +484,30 @@ enum rdma_nldev_attr {
 	 */
 	RDMA_NLDEV_ATTR_MAX
 };
+
+/*
+ * Supported counter bind modes. All modes are mutual-exclusive.
+ */
+enum rdma_nl_counter_mode {
+	RDMA_COUNTER_MODE_NONE,
+
+	/*
+	 * A qp is bound with a counter automatically during initialization
+	 * based on the auto mode (e.g., qp type, ...)
+	 */
+	RDMA_COUNTER_MODE_AUTO,
+
+	/*
+	 * Always the end
+	 */
+	RDMA_COUNTER_MODE_MAX,
+};
+
+/*
+ * Supported criteria in counter auto mode.
+ * Currently only "qp type" is supported
+ */
+enum rdma_nl_counter_mask {
+	RDMA_COUNTER_MASK_QP_TYPE = 1,
+};
 #endif /* _UAPI_RDMA_NETLINK_H */
-- 
2.20.1

