Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C1F341D81
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 13:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhCSM4n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 08:56:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:4853 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229914AbhCSM4l (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 08:56:41 -0400
IronPort-SDR: xJo1EpMlxN3Amr46FuKnyF55jHYXR3SR4XZT48R2zfJvX2G4cxdpFouXiDznRor/X4flLUhlRn
 L8Mg/YBIC5qw==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="209910281"
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; 
   d="scan'208";a="209910281"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 05:56:40 -0700
IronPort-SDR: KZfsu8nNZlAkshOAZKMSIOJ+EEa+XY7wYIZkNVVsF5ELSNwSlfoxICRUxUwVdq5axDS6z+Z7/0
 PBJVdvoM3E2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; 
   d="scan'208";a="450851723"
Received: from phwfstl014.hd.intel.com ([10.127.241.142])
  by orsmga001.jf.intel.com with ESMTP; 19 Mar 2021 05:56:39 -0700
From:   kaike.wan@intel.com
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org, todd.rimmer@intel.com,
        Kaike Wan <kaike.wan@intel.com>
Subject: [PATCH RFC 3/9] RDMA/rv: Add the rv module
Date:   Fri, 19 Mar 2021 08:56:29 -0400
Message-Id: <20210319125635.34492-4-kaike.wan@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20210319125635.34492-1-kaike.wan@intel.com>
References: <20210319125635.34492-1-kaike.wan@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Kaike Wan <kaike.wan@intel.com>

Add the rv module, the Makefile, and Kconfig file.

Also add the functions to manage IB devices.

Signed-off-by: Todd Rimmer <todd.rimmer@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
---
 MAINTAINERS                           |   6 +
 drivers/infiniband/Kconfig            |   1 +
 drivers/infiniband/ulp/Makefile       |   1 +
 drivers/infiniband/ulp/rv/Kconfig     |  11 ++
 drivers/infiniband/ulp/rv/Makefile    |   9 +
 drivers/infiniband/ulp/rv/rv_main.c   | 266 ++++++++++++++++++++++++++
 drivers/infiniband/ulp/rv/trace.c     |   7 +
 drivers/infiniband/ulp/rv/trace.h     |   5 +
 drivers/infiniband/ulp/rv/trace_dev.h |  82 ++++++++
 9 files changed, 388 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rv/Kconfig
 create mode 100644 drivers/infiniband/ulp/rv/Makefile
 create mode 100644 drivers/infiniband/ulp/rv/rv_main.c
 create mode 100644 drivers/infiniband/ulp/rv/trace.c
 create mode 100644 drivers/infiniband/ulp/rv/trace.h
 create mode 100644 drivers/infiniband/ulp/rv/trace_dev.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85ca831d..ba50affec9bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15547,6 +15547,12 @@ L:	linux-rdma@vger.kernel.org
 S:	Maintained
 F:	drivers/infiniband/ulp/rtrs/
 
+RV DRIVER
+M:	Kaike Wan <kaike.wan@intel.com>
+L:	linux-rdma@vger.kernel.org
+S:	Supported
+F:	drivers/infiniband/ulp/rv
+
 RXRPC SOCKETS (AF_RXRPC)
 M:	David Howells <dhowells@redhat.com>
 L:	linux-afs@lists.infradead.org
diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index 04a78d9f8fe3..5086164c836f 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -107,5 +107,6 @@ source "drivers/infiniband/ulp/isert/Kconfig"
 source "drivers/infiniband/ulp/rtrs/Kconfig"
 
 source "drivers/infiniband/ulp/opa_vnic/Kconfig"
+source "drivers/infiniband/ulp/rv/Kconfig"
 
 endif # INFINIBAND
diff --git a/drivers/infiniband/ulp/Makefile b/drivers/infiniband/ulp/Makefile
index 4d0004b58377..f925deb9241c 100644
--- a/drivers/infiniband/ulp/Makefile
+++ b/drivers/infiniband/ulp/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_INFINIBAND_ISER)		+= iser/
 obj-$(CONFIG_INFINIBAND_ISERT)		+= isert/
 obj-$(CONFIG_INFINIBAND_OPA_VNIC)	+= opa_vnic/
 obj-$(CONFIG_INFINIBAND_RTRS)		+= rtrs/
+obj-$(CONFIG_INFINIBAND_RV)		+= rv/
diff --git a/drivers/infiniband/ulp/rv/Kconfig b/drivers/infiniband/ulp/rv/Kconfig
new file mode 100644
index 000000000000..32a0523ff8ce
--- /dev/null
+++ b/drivers/infiniband/ulp/rv/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+#
+# Copyright(c) 2020 - 2021 Intel Corporation.
+#
+config INFINIBAND_RV
+	tristate "InfiniBand Rendezvous Module"
+	depends on X86_64 && INFINIBAND
+	help
+	  The rendezvous module provides mechanisms for HPC middlewares
+	  to cache memory region registration, to manage connections
+	  between nodes, and improve the scability of RDMA transactions.
diff --git a/drivers/infiniband/ulp/rv/Makefile b/drivers/infiniband/ulp/rv/Makefile
new file mode 100644
index 000000000000..07a7a7dd9c3b
--- /dev/null
+++ b/drivers/infiniband/ulp/rv/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+#
+# Copyright(c) 2020 - 2021 Intel Corporation.
+#
+obj-$(CONFIG_INFINIBAND_RV) += rv.o
+
+rv-y := rv_main.o trace.o
+
+CFLAGS_trace.o = -I$(src)
diff --git a/drivers/infiniband/ulp/rv/rv_main.c b/drivers/infiniband/ulp/rv/rv_main.c
new file mode 100644
index 000000000000..7f81f97a01f0
--- /dev/null
+++ b/drivers/infiniband/ulp/rv/rv_main.c
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright(c) 2020 - 2021 Intel Corporation.
+ */
+
+/* This file contains the base of the rendezvous RDMA driver */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/parser.h>
+
+#include <rdma/ib_user_sa.h>
+
+#include "rv.h"
+#include "trace.h"
+
+MODULE_AUTHOR("Kaike Wan");
+MODULE_DESCRIPTION("Rendezvous Module");
+MODULE_LICENSE("Dual BSD/GPL");
+
+static int rv_add_one(struct ib_device *device);
+static void rv_remove_one(struct ib_device *device, void *client_data);
+static void rv_rename_dev(struct ib_device *device, void *client_data);
+
+static struct ib_client rv_client = {
+	.name = "rv",
+	.add = rv_add_one,
+	.remove = rv_remove_one,
+	.rename = rv_rename_dev
+};
+
+static struct list_head rv_dev_list;	/* list of rv_device */
+static spinlock_t rv_dev_list_lock;
+
+/* get a device reference and add an rv_user to rv_device.user_list */
+struct rv_device *rv_device_get_add_user(char *dev_name, struct rv_user *rv)
+{
+	struct rv_device *dev;
+	unsigned long flags;
+
+	spin_lock_irqsave(&rv_dev_list_lock, flags);
+	list_for_each_entry(dev, &rv_dev_list, dev_entry) {
+		if (strcmp(dev->ib_dev->name, dev_name) == 0) {
+			if (!kref_get_unless_zero(&dev->kref))
+				continue; /* skip, going away */
+			list_add_tail(&rv->user_entry, &dev->user_list);
+			spin_unlock_irqrestore(&rv_dev_list_lock, flags);
+			trace_rv_dev_get(dev_name, kref_read(&dev->kref));
+			return dev;
+		}
+	}
+	spin_unlock_irqrestore(&rv_dev_list_lock, flags);
+	rv_err(RV_INVALID, "Could not find IB dev %s\n", dev_name);
+	return NULL;
+}
+
+static void rv_device_release(struct kref *kref)
+{
+	struct rv_device *dev = container_of(kref, struct rv_device, kref);
+
+	ib_unregister_event_handler(&dev->event_handler); /* may need sooner */
+	kfree(dev);
+}
+
+void rv_device_get(struct rv_device *dev)
+{
+	kref_get(&dev->kref);
+}
+
+void rv_device_put(struct rv_device *dev)
+{
+	trace_rv_dev_put(dev->ib_dev ? dev->ib_dev->name : "nil",
+			 kref_read(&dev->kref));
+	kref_put(&dev->kref, rv_device_release);
+}
+
+/*
+ * Remove a rv_user from rv_device.user_list
+ *
+ * @rv - The rv_user to remove
+ *
+ * Return:
+ *   0 - The rv_user is in rv_device.user_list and removed;
+ *   1 - The rv_user is already not in rv_device.user_list.
+ */
+int rv_device_del_user(struct rv_user *rv)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&rv_dev_list_lock, flags);
+	if (list_empty(&rv->user_entry))
+		ret = 1;
+	else
+		list_del_init(&rv->user_entry);
+	spin_unlock_irqrestore(&rv_dev_list_lock, flags);
+
+	return ret;
+}
+
+/* verbs device level async events */
+static void rv_device_event_handler(struct ib_event_handler *handler,
+				    struct ib_event *event)
+{
+	struct rv_device *dev;
+
+	dev = ib_get_client_data(event->device, &rv_client);
+	if (!dev || dev->ib_dev != event->device)
+		return;
+
+	trace_rv_device_event(dev->ib_dev->name, ib_event_msg(event->event));
+	switch (event->event) {
+	case IB_EVENT_DEVICE_FATAL:
+	case IB_EVENT_PORT_ERR:
+	case IB_EVENT_PORT_ACTIVE:
+	case IB_EVENT_LID_CHANGE:
+	case IB_EVENT_PKEY_CHANGE:
+	case IB_EVENT_SM_CHANGE:
+	case IB_EVENT_CLIENT_REREGISTER:
+	case IB_EVENT_GID_CHANGE:
+	default:
+		break;
+	}
+}
+
+static int rv_add_one(struct ib_device *device)
+{
+	struct rv_device *dev;
+	unsigned long flags;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+	dev->ib_dev = device;
+	kref_init(&dev->kref);
+	mutex_init(&dev->listener_mutex);
+	spin_lock_init(&dev->listener_lock);
+	INIT_LIST_HEAD(&dev->listener_list);
+	INIT_LIST_HEAD(&dev->user_list);
+	spin_lock_irqsave(&rv_dev_list_lock, flags);
+	list_add(&dev->dev_entry, &rv_dev_list);
+	spin_unlock_irqrestore(&rv_dev_list_lock, flags);
+	trace_rv_dev_add(device->name, kref_read(&dev->kref));
+	ib_set_client_data(device, &rv_client, dev);
+
+	INIT_IB_EVENT_HANDLER(&dev->event_handler, device,
+			      rv_device_event_handler);
+	ib_register_event_handler(&dev->event_handler);
+
+	return 0;
+}
+
+/*
+ * Called on device removal, gets users off the device
+ *
+ * At the same time, applications will get device async events which should
+ * trigger them to start user space cleanup and close.
+ *
+ * We remove the rv_user from the user_list so that the user application knows
+ * that the remove_one handler is cleaning up this rv_user. After this,
+ * the rv->user_entry itself is an empty list, an indicator that the
+ * remove_one handler owns this rv_user.
+ *
+ * To comply with lock heirarchy, we must release rv_dev_list_lock so
+ * rv_detach_user can get rv->mutex.  The empty rv->user_entry will prevent
+ * a race with rv_user starting its own detach.
+ */
+static void rv_device_detach_users(struct rv_device *dev)
+{
+	unsigned long flags;
+	struct rv_user *rv;
+
+	spin_lock_irqsave(&rv_dev_list_lock, flags);
+	while (!list_empty(&dev->user_list)) {
+		rv = list_first_entry(&dev->user_list, struct rv_user,
+				      user_entry);
+		list_del_init(&rv->user_entry);
+
+		spin_unlock_irqrestore(&rv_dev_list_lock, flags);
+		/* Detach user here */
+		spin_lock_irqsave(&rv_dev_list_lock, flags);
+	}
+	spin_unlock_irqrestore(&rv_dev_list_lock, flags);
+}
+
+/*
+ * device removal handler
+ *
+ * we allow a wait_time of 2 seconds for applications to cleanup themselves
+ * and close.  Typically they will get an async event and react quickly.
+ * After which we begin forcibly removing the remaining users and
+ * then wait for the internal references to get releaseed by their callbacks
+ */
+static void rv_remove_one(struct ib_device *device, void *client_data)
+{
+	struct rv_device *dev = client_data;
+	unsigned long flags;
+	unsigned long wait_time = 2000; /* 2 seconds */
+	unsigned long sleep_time = msecs_to_jiffies(100);
+	unsigned long end;
+
+	trace_rv_dev_remove(device->name, kref_read(&dev->kref));
+	spin_lock_irqsave(&rv_dev_list_lock, flags);
+	list_del(&dev->dev_entry);
+	spin_unlock_irqrestore(&rv_dev_list_lock, flags);
+
+	end = jiffies + msecs_to_jiffies(wait_time);
+	while (time_before(jiffies, end) && !list_empty(&dev->user_list))
+		schedule_timeout_interruptible(sleep_time);
+
+	rv_device_detach_users(dev);
+
+	while (kref_read(&dev->kref) > 1)
+		schedule_timeout_interruptible(sleep_time);
+
+	rv_device_put(dev);
+}
+
+static void rv_rename_dev(struct ib_device *device, void *client_data)
+{
+}
+
+static void rv_init_devices(void)
+{
+	spin_lock_init(&rv_dev_list_lock);
+	INIT_LIST_HEAD(&rv_dev_list);
+}
+
+/* uses syncrhnoize_rcu to ensure previous kfree_rcu of references are done */
+static void rv_deinit_devices(void)
+{
+	struct rv_device *dev, *temp;
+	unsigned long flags;
+
+	synchronize_rcu();
+	spin_lock_irqsave(&rv_dev_list_lock, flags);
+	list_for_each_entry_safe(dev, temp, &rv_dev_list, dev_entry) {
+		list_del(&dev->dev_entry);
+		rv_device_put(dev);
+	}
+	spin_unlock_irqrestore(&rv_dev_list_lock, flags);
+}
+
+static int __init rv_init_module(void)
+{
+	pr_info("Loading rendezvous module");
+
+	rv_init_devices();
+
+	if (ib_register_client(&rv_client)) {
+		rv_err(RV_INVALID, "Failed to register with the IB core\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void __exit rv_cleanup_module(void)
+{
+	ib_unregister_client(&rv_client);
+	rv_deinit_devices();
+}
+
+module_init(rv_init_module);
+module_exit(rv_cleanup_module);
diff --git a/drivers/infiniband/ulp/rv/trace.c b/drivers/infiniband/ulp/rv/trace.c
new file mode 100644
index 000000000000..b27536056c60
--- /dev/null
+++ b/drivers/infiniband/ulp/rv/trace.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright(c) 2020 - 2021 Intel Corporation.
+ */
+#define CREATE_TRACE_POINTS
+#include <rdma/rv_user_ioctls.h>
+#include "trace.h"
diff --git a/drivers/infiniband/ulp/rv/trace.h b/drivers/infiniband/ulp/rv/trace.h
new file mode 100644
index 000000000000..cb1d1d087e16
--- /dev/null
+++ b/drivers/infiniband/ulp/rv/trace.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Copyright(c) 2020 - 2021 Intel Corporation.
+ */
+#include "trace_dev.h"
diff --git a/drivers/infiniband/ulp/rv/trace_dev.h b/drivers/infiniband/ulp/rv/trace_dev.h
new file mode 100644
index 000000000000..2bfc6b07d518
--- /dev/null
+++ b/drivers/infiniband/ulp/rv/trace_dev.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Copyright(c) 2020 - 2021 Intel Corporation.
+ */
+#if !defined(__RV_TRACE_DEV_H) || defined(TRACE_HEADER_MULTI_READ)
+#define __RV_TRACE_DEV_H
+
+#include <linux/tracepoint.h>
+#include <linux/trace_seq.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rv_dev
+
+DECLARE_EVENT_CLASS(/* dev */
+	rv_dev_template,
+	TP_PROTO(const char *dev_name, u32 refcount),
+	TP_ARGS(dev_name, refcount),
+	TP_STRUCT__entry(/* entry */
+		__string(name, dev_name)
+		__field(u32, refcount)
+	),
+	TP_fast_assign(/* assign */
+		__assign_str(name, dev_name);
+		__entry->refcount = refcount;
+	),
+	TP_printk(/* print */
+		"name %s, refcount %u",
+		__get_str(name),
+		__entry->refcount
+	)
+);
+
+DEFINE_EVENT(/* event */
+	rv_dev_template, rv_dev_add,
+	TP_PROTO(const char *dev_name, u32 refcount),
+	TP_ARGS(dev_name, refcount)
+);
+
+DEFINE_EVENT(/* event */
+	rv_dev_template, rv_dev_remove,
+	TP_PROTO(const char *dev_name, u32 refcount),
+	TP_ARGS(dev_name, refcount)
+);
+
+DEFINE_EVENT(/* event */
+	rv_dev_template, rv_dev_get,
+	TP_PROTO(const char *dev_name, u32 refcount),
+	TP_ARGS(dev_name, refcount)
+);
+
+DEFINE_EVENT(/* event */
+	rv_dev_template, rv_dev_put,
+	TP_PROTO(const char *dev_name, u32 refcount),
+	TP_ARGS(dev_name, refcount)
+);
+
+TRACE_EVENT(/* event */
+	rv_device_event,
+	TP_PROTO(const char *dev_name, const char *evt_name),
+	TP_ARGS(dev_name, evt_name),
+	TP_STRUCT__entry(/* entry */
+		__string(device, dev_name)
+		__string(event, evt_name)
+	),
+	TP_fast_assign(/* assign */
+		__assign_str(device, dev_name);
+		__assign_str(event, evt_name);
+	),
+	TP_printk(/* print */
+		"Device %s Event %s",
+		__get_str(device),
+		__get_str(event)
+	)
+);
+
+#endif /* __RV_TRACE_DEV_H */
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace_dev
+#include <trace/define_trace.h>
-- 
2.18.1

