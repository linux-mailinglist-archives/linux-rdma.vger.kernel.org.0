Return-Path: <linux-rdma+bounces-3836-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BED92F127
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 23:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17BD5B21E81
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 21:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5C91A00DF;
	Thu, 11 Jul 2024 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZnrmDxO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0EF19FA80;
	Thu, 11 Jul 2024 21:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720733519; cv=none; b=LdkRBNQPNjqaBCi08Of9BwpyDlT6HoSfzwVr0VbgiiXmlSwrGGeodk7cl2Jw+tmFyLupjzKztW4/Ap1h1w6HCsVkivicqvYYPw2n2EdYnbPX/+wflZdLKkMaizd2IzyPyeqUUHca0Q33TnEb+ej2qsKp/taKt5VAmpkx79hq1C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720733519; c=relaxed/simple;
	bh=13zXPZG2PiN/ecZtZR97HyOpLOXDFztlEURsC1m8eZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPl+QM/YLHwKgbZAwpoeU3i+13vHlnArG10PHfH22wYdKVwZDQhzOOBat8pDoCHO601TIEFd1N3rOXNC1xMK3vUy9wXqLjAjL7aV5v/xtwZO6VJVxJd0BKU/w/fdYJJbMWSzA5RHxekpGMXqEgnzrxn+P6XgA0eqonDS8SC7REI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZnrmDxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0F0C116B1;
	Thu, 11 Jul 2024 21:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720733518;
	bh=13zXPZG2PiN/ecZtZR97HyOpLOXDFztlEURsC1m8eZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rZnrmDxOI6mEreDi9w89zRwHlmdAtyaMkltDzJphyfsysTyaXQYUGWyJO/lq6I3oB
	 UGn/j1yrUp6LEccL/ByFX/XKxnm0xYOY46gUrRIPZGZKmwq9O0yEEX0Fe81zVQHiqm
	 OVwzL9KANyYQ1pM/zDaOsv3d1OGpZk8qgWfQDr6Y3nBG7H72k3fnEAcQEdjSjHs3oB
	 LzAlD13vqcmjTCv+p03ToM0JwXLXArmox+sjw7KhR65x1l2zF8sLLD1NxuML18pdK4
	 H+yCy7LwuTk6z8h1gpcHSxwgTfZOzMqSDv0faSBzOoB7vCfZlfSSRlhzjljYLbq8mo
	 4DT1ZPMjfirCg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>,
	netdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Parav Pandit <parav@nvidia.com>,
	Shay Drory <shayd@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: [mlx5-next 1/2] driver core: auxiliary bus: show auxiliary device IRQs
Date: Thu, 11 Jul 2024 14:31:39 -0700
Message-ID: <20240711213140.256997-2-saeed@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711213140.256997-1-saeed@kernel.org>
References: <20240711213140.256997-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shay Drory <shayd@nvidia.com>

PCI subfunctions (SF) are anchored on the auxiliary bus. PCI physical
and virtual functions are anchored on the PCI bus. The irq information
of each such function is visible to users via sysfs directory "msi_irqs"
containing files for each irq entry. However, for PCI SFs such
information is unavailable. Due to this users have no visibility on IRQs
used by the SFs.
Secondly, an SF can be multi function device supporting rdma, netdevice
and more. Without irq information at the bus level, the user is unable
to view or use the affinity of the SF IRQs.

Hence to match to the equivalent PCI PFs and VFs, add "irqs" directory,
for supporting auxiliary devices, containing file for each irq entry.

For example:
$ ls /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/
50  51  52  53  54  55  56  57  58

Cc: Simon Horman <horms@kernel.org>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

---
v9-v10:
- remove Przemek RB
- add name field to auxiliary_irq_info (Greg and Przemek)
- handle bogus IRQ in auxiliary_device_sysfs_irq_remove (Greg)
v8-v9:
- add Przemek RB
- use guard() in auxiliary_irq_dir_prepare (Paolo)
v7-v8:
- use cleanup.h for info and name fields (Greg)
- correct error flow in auxiliary_irq_dir_prepare (Przemek)
- add documentation for new fields of auxiliary_device (Simon)
v6-v7:
- dynamically creating irqs directory when first irq file created (Greg)
- removed irqs flag and simplified the dev_add() API (Greg)
- move sysfs related new code to a new auxiliary_sysfs.c file (Greg)
v5-v6:
- removed concept of shared and exclusive and hence global xarray (Greg)
v4-v5:
- restore global mutex and replace refcount_t with simple integer (Greg)
v3->4:
- remove global mutex (Przemek)
v2->v3:
- fix function declaration in case SYSFS isn't defined
v1->v2:
- move #ifdefs from drivers/base/auxiliary.c to
  include/linux/auxiliary_bus.h (Greg)
- use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL (Greg)
- Fix kzalloc(ref) to kzalloc(*ref) (Simon)
- Add return description in auxiliary_device_sysfs_irq_add() kdoc (Simon)
- Fix auxiliary_irq_mode_show doc (kernel test boot)

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 Documentation/ABI/testing/sysfs-bus-auxiliary |   9 ++
 drivers/base/Makefile                         |   1 +
 drivers/base/auxiliary.c                      |   1 +
 drivers/base/auxiliary_sysfs.c                | 113 ++++++++++++++++++
 include/linux/auxiliary_bus.h                 |  24 ++++
 5 files changed, 148 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-auxiliary
 create mode 100644 drivers/base/auxiliary_sysfs.c

diff --git a/Documentation/ABI/testing/sysfs-bus-auxiliary b/Documentation/ABI/testing/sysfs-bus-auxiliary
new file mode 100644
index 000000000000..cc856079690f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-auxiliary
@@ -0,0 +1,9 @@
+What:		/sys/bus/auxiliary/devices/.../irqs/
+Date:		April, 2024
+Contact:	Shay Drory <shayd@nvidia.com>
+Description:
+		The /sys/devices/.../irqs directory contains a variable set of
+		files, with each file is named as irq number similar to PCI PF
+		or VF's irq number located in msi_irqs directory.
+		These irq files are added and removed dynamically when an IRQ
+		is requested and freed respectively for the PCI SF.
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 3079bfe53d04..7fb21768ca36 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_NUMA)	+= node.o
 obj-$(CONFIG_MEMORY_HOTPLUG) += memory.o
 ifeq ($(CONFIG_SYSFS),y)
 obj-$(CONFIG_MODULES)	+= module.o
+obj-$(CONFIG_AUXILIARY_BUS) += auxiliary_sysfs.o
 endif
 obj-$(CONFIG_SYS_HYPERVISOR) += hypervisor.o
 obj-$(CONFIG_REGMAP)	+= regmap/
diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index d3a2c40c2f12..3f01f4ec69e5 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -287,6 +287,7 @@ int auxiliary_device_init(struct auxiliary_device *auxdev)
 
 	dev->bus = &auxiliary_bus_type;
 	device_initialize(&auxdev->dev);
+	mutex_init(&auxdev->sysfs.lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(auxiliary_device_init);
diff --git a/drivers/base/auxiliary_sysfs.c b/drivers/base/auxiliary_sysfs.c
new file mode 100644
index 000000000000..754f21730afd
--- /dev/null
+++ b/drivers/base/auxiliary_sysfs.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/slab.h>
+
+#define AUXILIARY_MAX_IRQ_NAME 11
+
+struct auxiliary_irq_info {
+	struct device_attribute sysfs_attr;
+	char name[AUXILIARY_MAX_IRQ_NAME];
+};
+
+static struct attribute *auxiliary_irq_attrs[] = {
+	NULL
+};
+
+static const struct attribute_group auxiliary_irqs_group = {
+	.name = "irqs",
+	.attrs = auxiliary_irq_attrs,
+};
+
+static int auxiliary_irq_dir_prepare(struct auxiliary_device *auxdev)
+{
+	int ret = 0;
+
+	guard(mutex)(&auxdev->sysfs.lock);
+	if (auxdev->sysfs.irq_dir_exists)
+		return 0;
+
+	ret = devm_device_add_group(&auxdev->dev, &auxiliary_irqs_group);
+	if (ret)
+		return ret;
+
+	auxdev->sysfs.irq_dir_exists = true;
+	xa_init(&auxdev->sysfs.irqs);
+	return 0;
+}
+
+/**
+ * auxiliary_device_sysfs_irq_add - add a sysfs entry for the given IRQ
+ * @auxdev: auxiliary bus device to add the sysfs entry.
+ * @irq: The associated interrupt number.
+ *
+ * This function should be called after auxiliary device have successfully
+ * received the irq.
+ * The driver is responsible to add a unique irq for the auxiliary device. The
+ * driver can invoke this function from multiple thread context safely for
+ * unique irqs of the auxiliary devices. The driver must not invoke this API
+ * multiple times if the irq is already added previously.
+ *
+ * Return: zero on success or an error code on failure.
+ */
+int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
+{
+	struct auxiliary_irq_info *info __free(kfree) = NULL;
+	struct device *dev = &auxdev->dev;
+	int ret;
+
+	ret = auxiliary_irq_dir_prepare(auxdev);
+	if (ret)
+		return ret;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	sysfs_attr_init(&info->sysfs_attr.attr);
+	snprintf(info->name, AUXILIARY_MAX_IRQ_NAME, "%d", irq);
+
+	ret = xa_insert(&auxdev->sysfs.irqs, irq, info, GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	info->sysfs_attr.attr.name = info->name;
+	ret = sysfs_add_file_to_group(&dev->kobj, &info->sysfs_attr.attr,
+				      auxiliary_irqs_group.name);
+	if (ret)
+		goto sysfs_add_err;
+
+	xa_store(&auxdev->sysfs.irqs, irq, no_free_ptr(info), GFP_KERNEL);
+	return 0;
+
+sysfs_add_err:
+	xa_erase(&auxdev->sysfs.irqs, irq);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_add);
+
+/**
+ * auxiliary_device_sysfs_irq_remove - remove a sysfs entry for the given IRQ
+ * @auxdev: auxiliary bus device to add the sysfs entry.
+ * @irq: the IRQ to remove.
+ *
+ * This function should be called to remove an IRQ sysfs entry.
+ * The driver must invoke this API when IRQ is released by the device.
+ */
+void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq)
+{
+	struct auxiliary_irq_info *info __free(kfree) = xa_load(&auxdev->sysfs.irqs, irq);
+	struct device *dev = &auxdev->dev;
+
+	if (!info) {
+		dev_err(&auxdev->dev, "IRQ %d doesn't exist\n", irq);
+		return;
+	}
+	sysfs_remove_file_from_group(&dev->kobj, &info->sysfs_attr.attr,
+				     auxiliary_irqs_group.name);
+	xa_erase(&auxdev->sysfs.irqs, irq);
+}
+EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_remove);
diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
index de21d9d24a95..3ba4487c9cd9 100644
--- a/include/linux/auxiliary_bus.h
+++ b/include/linux/auxiliary_bus.h
@@ -58,6 +58,9 @@
  *       in
  * @name: Match name found by the auxiliary device driver,
  * @id: unique identitier if multiple devices of the same name are exported,
+ * @irqs: irqs xarray contains irq indices which are used by the device,
+ * @lock: Synchronize irq sysfs creation,
+ * @irq_dir_exists: whether "irqs" directory exists,
  *
  * An auxiliary_device represents a part of its parent device's functionality.
  * It is given a name that, combined with the registering drivers
@@ -139,6 +142,11 @@ struct auxiliary_device {
 	struct device dev;
 	const char *name;
 	u32 id;
+	struct {
+		struct xarray irqs;
+		struct mutex lock; /* Synchronize irq sysfs creation */
+		bool irq_dir_exists;
+	} sysfs;
 };
 
 /**
@@ -212,8 +220,24 @@ int auxiliary_device_init(struct auxiliary_device *auxdev);
 int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname);
 #define auxiliary_device_add(auxdev) __auxiliary_device_add(auxdev, KBUILD_MODNAME)
 
+#ifdef CONFIG_SYSFS
+int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq);
+void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev,
+				       int irq);
+#else /* CONFIG_SYSFS */
+static inline int
+auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
+{
+	return 0;
+}
+
+static inline void
+auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq) {}
+#endif
+
 static inline void auxiliary_device_uninit(struct auxiliary_device *auxdev)
 {
+	mutex_destroy(&auxdev->sysfs.lock);
 	put_device(&auxdev->dev);
 }
 
-- 
2.45.2


