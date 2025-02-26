Return-Path: <linux-rdma+bounces-8155-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D620A46251
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 15:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B641217CA0D
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 14:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67CB221726;
	Wed, 26 Feb 2025 14:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATCkGde0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BCA22171D
	for <linux-rdma@vger.kernel.org>; Wed, 26 Feb 2025 14:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579473; cv=none; b=BgnTBcqlEWs2s7+ehcm+9K7jtakq3YwRiOyzwBfH1vrV5SLxjwT+SpbQS1kF2et8+AO1NmDG20tJ53f8wRF01B1O762pm1Uk839jhUZVA8VsX1elpMaO21Sj3LTwPWkI0D855hhaNmlqDfBJ5P9ap+ShwLQdsJPTBGiL0BIe1GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579473; c=relaxed/simple;
	bh=aHe8IYr/kBEGyQ7LM0iqt6dbzdnEOsEwl8WQVXE1cYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRMz80kotiRcMfHuqQaxPUmwebvsAWCCnZGroQkAikJmNTKKhatEiIqWRTF0256KeDtFtmfMA4vV57vW9SWWOLsiYRd2nkW5VuhdLW2IxZIIQbKGnrGxEm5eyRa28/ghVO2DlBvRO8Mnyf61W+8ckA03lzxYGApNtGmddn8SUPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATCkGde0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBD6C4CED6;
	Wed, 26 Feb 2025 14:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740579473;
	bh=aHe8IYr/kBEGyQ7LM0iqt6dbzdnEOsEwl8WQVXE1cYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ATCkGde0z+pKl1/Fl6JzH3P0ZmnpvhznVm7IyAEZPBeISt3SUCyDmwUuOF67VILeh
	 73MkjHxSKu7UQNg/AUm8cK1Pero88Zei8eTyPr6sqr4ZhpPjlafaVRC9zosNH7NIka
	 OuHwRBRAOH1Q0vpdc647zTDDPH4A9Ak+Kq59Kxuw9Fe8MozLvo/wRusZUdMXz/e9Jp
	 OhAg+ohMqTbXFmfFE4b1k2hi9PNk+68oBA8BIXm/3E+l28pkEo4JwPjokn6Fj9eGsj
	 uFmSvRe3oJxfqcN9FYLekN2Ug4vpxm7X14xUe7xGQA8BYJQZU1bayEzD2wtTJ8qZMW
	 0SY2R/129YmVA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next 1/6] RDMA/uverbs: Introduce UCAP (User CAPabilities) API
Date: Wed, 26 Feb 2025 16:17:27 +0200
Message-ID: <558b28bc07d2067478ec638da87e01a551caa367.1740574943.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740574943.git.leon@kernel.org>
References: <cover.1740574943.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chiara Meiohas <cmeiohas@nvidia.com>

Implement a new User CAPabilities (UCAP) API to provide fine-grained
control over specific firmware features.

This approach offers more granular capabilities than the existing Linux
capabilities, which may be too generic for certain FW features.

This mechanism represents each capability as a character device with
root read-write access. Root processes can grant users special
privileges by allowing access to these character devices (e.g., using
chown).

UCAP character devices are located in /dev/infiniband and the class path
is /sys/class/infiniband_ucaps.

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
---
 drivers/infiniband/core/Makefile      |   3 +-
 drivers/infiniband/core/ucaps.c       | 255 ++++++++++++++++++++++++++
 drivers/infiniband/core/uverbs_main.c |   2 +
 include/rdma/ib_ucaps.h               |  25 +++
 4 files changed, 284 insertions(+), 1 deletion(-)
 create mode 100644 drivers/infiniband/core/ucaps.c
 create mode 100644 include/rdma/ib_ucaps.h

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index 8ab4eea5a0a5..d49ded7e95f0 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -39,6 +39,7 @@ ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
 				uverbs_std_types_async_fd.o \
 				uverbs_std_types_srq.o \
 				uverbs_std_types_wq.o \
-				uverbs_std_types_qp.o
+				uverbs_std_types_qp.o \
+				ucaps.o
 ib_uverbs-$(CONFIG_INFINIBAND_USER_MEM) += umem.o umem_dmabuf.o
 ib_uverbs-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += umem_odp.o
diff --git a/drivers/infiniband/core/ucaps.c b/drivers/infiniband/core/ucaps.c
new file mode 100644
index 000000000000..82b1184891ed
--- /dev/null
+++ b/drivers/infiniband/core/ucaps.c
@@ -0,0 +1,255 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ */
+
+#include <linux/cdev.h>
+#include <linux/mutex.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <rdma/ib_ucaps.h>
+
+#define RDMA_UCAP_FIRST RDMA_UCAP_MLX5_CTRL_LOCAL
+
+static DEFINE_MUTEX(ucaps_mutex);
+static struct ib_ucap *ucaps_list[RDMA_UCAP_MAX];
+static bool ucaps_class_is_registered;
+static dev_t ucaps_base_dev;
+
+struct ib_ucap {
+	struct cdev cdev;
+	struct device dev;
+	int refcount;
+};
+
+static const char *ucap_names[RDMA_UCAP_MAX] = {
+	[RDMA_UCAP_MLX5_CTRL_LOCAL] = "mlx5_perm_ctrl_local",
+	[RDMA_UCAP_MLX5_CTRL_OTHER_VHCA] = "mlx5_perm_ctrl_other_vhca"
+};
+
+static char *ucaps_devnode(const struct device *dev, umode_t *mode)
+{
+	if (mode)
+		*mode = 0600;
+
+	return kasprintf(GFP_KERNEL, "infiniband/%s", dev_name(dev));
+}
+
+static const struct class ucaps_class = {
+	.name = "infiniband_ucaps",
+	.devnode = ucaps_devnode,
+};
+
+static const struct file_operations ucaps_cdev_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+};
+
+/**
+ * ib_cleanup_ucaps - cleanup all API resources and class.
+ *
+ * This is called once, when removing the ib_uverbs module.
+ */
+void ib_cleanup_ucaps(void)
+{
+	mutex_lock(&ucaps_mutex);
+	if (!ucaps_class_is_registered) {
+		mutex_unlock(&ucaps_mutex);
+		return;
+	}
+
+	for (int i = RDMA_UCAP_FIRST; i < RDMA_UCAP_MAX; i++)
+		WARN_ON(ucaps_list[i]);
+
+	class_unregister(&ucaps_class);
+	ucaps_class_is_registered = false;
+	unregister_chrdev_region(ucaps_base_dev, RDMA_UCAP_MAX);
+	mutex_unlock(&ucaps_mutex);
+}
+
+static int get_ucap_from_devt(dev_t devt, u64 *idx_mask)
+{
+	for (int type = RDMA_UCAP_FIRST; type < RDMA_UCAP_MAX; type++) {
+		if (ucaps_list[type] && ucaps_list[type]->dev.devt == devt) {
+			*idx_mask |= 1 << type;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int get_devt_from_fd(unsigned int fd, dev_t *ret_dev)
+{
+	struct file *file;
+
+	file = fget(fd);
+	if (!file)
+		return -EBADF;
+
+	*ret_dev = file_inode(file)->i_rdev;
+	fput(file);
+	return 0;
+}
+
+/**
+ * ib_ucaps_init - Initialization required before ucap creation.
+ *
+ * Return: 0 on success, or a negative errno value on failure
+ */
+static int ib_ucaps_init(void)
+{
+	int ret = 0;
+
+	if (ucaps_class_is_registered)
+		return ret;
+
+	ret = class_register(&ucaps_class);
+	if (ret)
+		return ret;
+
+	ret = alloc_chrdev_region(&ucaps_base_dev, 0, RDMA_UCAP_MAX,
+				  ucaps_class.name);
+	if (ret < 0) {
+		class_unregister(&ucaps_class);
+		return ret;
+	}
+
+	ucaps_class_is_registered = true;
+
+	return 0;
+}
+
+static void ucap_dev_release(struct device *device)
+{
+	struct ib_ucap *ucap = container_of(device, struct ib_ucap, dev);
+
+	kfree(ucap);
+}
+
+/**
+ * ib_create_ucap - Add a ucap character device
+ * @type: UCAP type
+ *
+ * Creates a ucap character device in the /dev/infiniband directory. By default,
+ * the device has root-only read-write access.
+ *
+ * A driver may call this multiple times with the same UCAP type. A reference
+ * count tracks creations and deletions.
+ *
+ * Return: 0 on success, or a negative errno value on failure
+ */
+int ib_create_ucap(enum rdma_user_cap type)
+{
+	struct ib_ucap *ucap;
+	int ret;
+
+	if (type >= RDMA_UCAP_MAX)
+		return -EINVAL;
+
+	mutex_lock(&ucaps_mutex);
+	ret = ib_ucaps_init();
+	if (ret)
+		goto unlock;
+
+	ucap = ucaps_list[type];
+	if (ucap) {
+		ucap->refcount++;
+		mutex_unlock(&ucaps_mutex);
+		return 0;
+	}
+
+	ucap = kzalloc(sizeof(*ucap), GFP_KERNEL);
+	if (!ucap) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	device_initialize(&ucap->dev);
+	ucap->dev.class = &ucaps_class;
+	ucap->dev.devt = MKDEV(MAJOR(ucaps_base_dev), type);
+	ucap->dev.release = ucap_dev_release;
+	dev_set_name(&ucap->dev, ucap_names[type]);
+
+	cdev_init(&ucap->cdev, &ucaps_cdev_fops);
+	ucap->cdev.owner = THIS_MODULE;
+
+	ret = cdev_device_add(&ucap->cdev, &ucap->dev);
+	if (ret)
+		goto err_device;
+
+	ucap->refcount = 1;
+	ucaps_list[type] = ucap;
+	mutex_unlock(&ucaps_mutex);
+
+	return 0;
+
+err_device:
+	put_device(&ucap->dev);
+unlock:
+	mutex_unlock(&ucaps_mutex);
+	return ret;
+}
+EXPORT_SYMBOL(ib_create_ucap);
+
+/**
+ * ib_remove_ucap - Remove a ucap character device
+ * @type: User cap type
+ *
+ * Removes the ucap character device according to type. The device is completely
+ * removed from the filesystem when its reference count reaches 0.
+ */
+void ib_remove_ucap(enum rdma_user_cap type)
+{
+	struct ib_ucap *ucap;
+
+	mutex_lock(&ucaps_mutex);
+	ucap = ucaps_list[type];
+	if (WARN_ON(!ucap))
+		goto end;
+
+	ucap->refcount--;
+	if (ucap->refcount)
+		goto end;
+
+	ucaps_list[type] = NULL;
+	cdev_device_del(&ucap->cdev, &ucap->dev);
+	put_device(&ucap->dev);
+
+end:
+	mutex_unlock(&ucaps_mutex);
+}
+EXPORT_SYMBOL(ib_remove_ucap);
+
+/**
+ * ib_get_ucaps - Get bitmask of ucap types from file descriptors
+ * @fds: Array of file descriptors
+ * @fd_count: Number of file descriptors in the array
+ * @idx_mask: Bitmask to be updated based on the ucaps in the fd list
+ *
+ * Given an array of file descriptors, this function returns a bitmask of
+ * the ucaps where a bit is set if an FD for that ucap type was in the array.
+ *
+ * Return: 0 on success, or a negative errno value on failure
+ */
+int ib_get_ucaps(int *fds, int fd_count, uint64_t *idx_mask)
+{
+	int ret = 0;
+	dev_t dev;
+
+	*idx_mask = 0;
+	mutex_lock(&ucaps_mutex);
+	for (int i = 0; i < fd_count; i++) {
+		ret = get_devt_from_fd(fds[i], &dev);
+		if (ret)
+			goto end;
+
+		ret = get_ucap_from_devt(dev, idx_mask);
+		if (ret)
+			goto end;
+	}
+
+end:
+	mutex_unlock(&ucaps_mutex);
+	return ret;
+}
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 85cfc790a7bb..973fe2c7ef53 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -52,6 +52,7 @@
 #include <rdma/ib.h>
 #include <rdma/uverbs_std_types.h>
 #include <rdma/rdma_netlink.h>
+#include <rdma/ib_ucaps.h>
 
 #include "uverbs.h"
 #include "core_priv.h"
@@ -1345,6 +1346,7 @@ static void __exit ib_uverbs_cleanup(void)
 				 IB_UVERBS_NUM_FIXED_MINOR);
 	unregister_chrdev_region(dynamic_uverbs_dev,
 				 IB_UVERBS_NUM_DYNAMIC_MINOR);
+	ib_cleanup_ucaps();
 	mmu_notifier_synchronize();
 }
 
diff --git a/include/rdma/ib_ucaps.h b/include/rdma/ib_ucaps.h
new file mode 100644
index 000000000000..d044d02f087f
--- /dev/null
+++ b/include/rdma/ib_ucaps.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/*
+ * Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ */
+
+#ifndef _IB_UCAPS_H_
+#define _IB_UCAPS_H_
+
+#define UCAP_ENABLED(ucaps, type) (!!((ucaps) & (1U << type)))
+
+enum rdma_user_cap {
+	RDMA_UCAP_MLX5_CTRL_LOCAL,
+	RDMA_UCAP_MLX5_CTRL_OTHER_VHCA,
+	RDMA_UCAP_MAX
+};
+
+void ib_cleanup_ucaps(void);
+
+int ib_create_ucap(enum rdma_user_cap type);
+
+void ib_remove_ucap(enum rdma_user_cap type);
+
+int ib_get_ucaps(int *fds, int fd_count, uint64_t *idx_mask);
+
+#endif /* _IB_UCAPS_H_ */
-- 
2.48.1


