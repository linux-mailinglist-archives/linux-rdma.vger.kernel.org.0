Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1E7214B21
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2020 10:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgGEIUO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Jul 2020 04:20:14 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33105 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726303AbgGEIUN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Jul 2020 04:20:13 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with SMTP; 5 Jul 2020 11:20:05 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0658K5xD001675;
        Sun, 5 Jul 2020 11:20:05 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 0658K5ri009283;
        Sun, 5 Jul 2020 11:20:05 +0300
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 0658K5EM009282;
        Sun, 5 Jul 2020 11:20:05 +0300
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, yishaih@mellanox.com, maorg@mellanox.com
Subject: [PATCH V1 rdma-core 04/13] verbs: Introduce ibv_import_device() verb
Date:   Sun,  5 Jul 2020 11:19:40 +0300
Message-Id: <1593937189-8744-5-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1593937189-8744-1-git-send-email-yishaih@mellanox.com>
References: <1593937189-8744-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Introduce ibv_import_device(), it enable a process to get an ibv_context
that is associated with a given command FD that it owns.

A process is creating a device and then uses some of the Linux systems
calls to dup its 'cmd_fd' member and lets other process to obtain owning
on.

Once other process obtains the 'cmd_fd' it can call ibv_import_device()
which returns an ibv_contxet on the original RDMA device.

A detailed man page as part of this patch describes the expected usage
and flow.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 debian/libibverbs1.symbols            |  1 +
 libibverbs/device.c                   | 62 +++++++++++++++++++++++++++++++++++
 libibverbs/driver.h                   |  2 ++
 libibverbs/libibverbs.map.in          |  1 +
 libibverbs/man/CMakeLists.txt         |  1 +
 libibverbs/man/ibv_import_device.3.md | 48 +++++++++++++++++++++++++++
 libibverbs/verbs.h                    |  5 +++
 7 files changed, 120 insertions(+)
 create mode 100644 libibverbs/man/ibv_import_device.3.md

diff --git a/debian/libibverbs1.symbols b/debian/libibverbs1.symbols
index bb7eac9..1ba5453 100644
--- a/debian/libibverbs1.symbols
+++ b/debian/libibverbs1.symbols
@@ -67,6 +67,7 @@ libibverbs.so.1 libibverbs1 #MINVER#
  ibv_get_device_name@IBVERBS_1.1 1.1.6
  ibv_get_pkey_index@IBVERBS_1.5 20
  ibv_get_sysfs_path@IBVERBS_1.0 1.1.6
+ ibv_import_device@IBVERBS_1.10 31
  ibv_init_ah_from_wc@IBVERBS_1.1 1.1.6
  ibv_modify_qp@IBVERBS_1.0 1.1.6
  ibv_modify_qp@IBVERBS_1.1 1.1.6
diff --git a/libibverbs/device.c b/libibverbs/device.c
index 4ef2a6a..e9c429a 100644
--- a/libibverbs/device.c
+++ b/libibverbs/device.c
@@ -382,6 +382,68 @@ LATEST_SYMVER_FUNC(ibv_open_device, 1_1, "IBVERBS_1.1",
 	return verbs_open_device(device, NULL);
 }
 
+struct ibv_context *ibv_import_device(int cmd_fd)
+{
+	struct verbs_device *verbs_device = NULL;
+	struct verbs_context *context_ex;
+	struct ibv_device **dev_list;
+	struct ibv_context *ctx = NULL;
+	struct stat st;
+	int ret;
+	int i;
+
+	if (fstat(cmd_fd, &st) || !S_ISCHR(st.st_mode)) {
+		errno = EINVAL;
+		return NULL;
+	}
+
+	dev_list = ibv_get_device_list(NULL);
+	if (!dev_list) {
+		errno = ENODEV;
+		return NULL;
+	}
+
+	for (i = 0; dev_list[i]; ++i) {
+		if (verbs_get_device(dev_list[i])->sysfs->sysfs_cdev ==
+					st.st_rdev) {
+			verbs_device = verbs_get_device(dev_list[i]);
+			break;
+		}
+	}
+
+	if (!verbs_device) {
+		errno = ENODEV;
+		goto out;
+	}
+
+	if (!verbs_device->ops->import_context) {
+		errno = EOPNOTSUPP;
+		goto out;
+	}
+
+	/* In case the underlay cdev number was assigned in the meantime to
+	 * other device as of some disassociate flow, the next call on the
+	 * FD will end up with EIO (i.e. query_context command) and we should
+	 * be safe from using the wrong device.
+	 */
+	context_ex = verbs_device->ops->import_context(&verbs_device->device, cmd_fd);
+	if (!context_ex)
+		goto out;
+
+	set_lib_ops(context_ex);
+
+	context_ex->priv->imported = true;
+	ctx = &context_ex->context;
+	ret = ibv_cmd_alloc_async_fd(ctx);
+	if (ret) {
+		ibv_close_device(ctx);
+		ctx = NULL;
+	}
+out:
+	ibv_free_device_list(dev_list);
+	return ctx;
+}
+
 void verbs_uninit_context(struct verbs_context *context_ex)
 {
 	free(context_ex->priv);
diff --git a/libibverbs/driver.h b/libibverbs/driver.h
index a1b241b..48eace4 100644
--- a/libibverbs/driver.h
+++ b/libibverbs/driver.h
@@ -216,6 +216,8 @@ struct verbs_device_ops {
 	struct verbs_context *(*alloc_context)(struct ibv_device *device,
 					       int cmd_fd,
 					       void *private_data);
+	struct verbs_context *(*import_context)(struct ibv_device *device,
+						int cmd_fd);
 
 	struct verbs_device *(*alloc_device)(struct verbs_sysfs_dev *sysfs_dev);
 	void (*uninit_device)(struct verbs_device *device);
diff --git a/libibverbs/libibverbs.map.in b/libibverbs/libibverbs.map.in
index 61b6a80..be75717 100644
--- a/libibverbs/libibverbs.map.in
+++ b/libibverbs/libibverbs.map.in
@@ -133,6 +133,7 @@ IBVERBS_1.9 {
 
 IBVERBS_1.10 {
 	global:
+		ibv_import_device;
 		ibv_query_ece;
 		ibv_set_ece;
 } IBVERBS_1.9;
diff --git a/libibverbs/man/CMakeLists.txt b/libibverbs/man/CMakeLists.txt
index a9cf61e..06b5b49 100644
--- a/libibverbs/man/CMakeLists.txt
+++ b/libibverbs/man/CMakeLists.txt
@@ -37,6 +37,7 @@ rdma_man_pages(
   ibv_get_device_name.3.md
   ibv_get_pkey_index.3.md
   ibv_get_srq_num.3.md
+  ibv_import_device.3.md
   ibv_inc_rkey.3.md
   ibv_modify_qp.3
   ibv_modify_qp_rate_limit.3
diff --git a/libibverbs/man/ibv_import_device.3.md b/libibverbs/man/ibv_import_device.3.md
new file mode 100644
index 0000000..601b50a
--- /dev/null
+++ b/libibverbs/man/ibv_import_device.3.md
@@ -0,0 +1,48 @@
+---
+date: 2020-5-3
+footer: libibverbs
+header: "Libibverbs Programmer's Manual"
+layout: page
+license: 'Licensed under the OpenIB.org BSD license (FreeBSD Variant) - See COPYING.md'
+section: 3
+title: ibv_import_device
+---
+
+# NAME
+
+ibv_import_device - import a device from a given comamnd FD
+
+# SYNOPSIS
+
+```c
+#include <infiniband/verbs.h>
+
+struct ibv_context *ibv_import_device(int cmd_fd);
+
+```
+
+
+# DESCRIPTION
+
+**ibv_import_device()** returns an *ibv_context* pointer that is associated with the given
+*cmd_fd*.
+
+The *cmd_fd* is obtained from the ibv_context cmd_fd member, which must be dup'd (eg by dup(), SCM_RIGHTS, etc)
+before being passed to ibv_import_device().
+
+Once the *ibv_context* usage has been ended *ibv_close_device()* should be called.
+This call may cleanup whatever is needed/opposite of the import including closing the command FD.
+
+# RETURN VALUE
+
+**ibv_import_device()** returns a pointer to the allocated RDMA context, or NULL if the request fails.
+
+# SEE ALSO
+
+**ibv_open_device**(3),
+**ibv_close_device**(3),
+
+# AUTHOR
+
+Yishai Hadas <yishaih@mellanox.com>
+
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index f72c1ab..e1247b8 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -2242,6 +2242,11 @@ struct ibv_context *ibv_open_device(struct ibv_device *device);
 int ibv_close_device(struct ibv_context *context);
 
 /**
+ * ibv_import_device - Import device
+ */
+struct ibv_context *ibv_import_device(int cmd_fd);
+
+/**
  * ibv_get_async_event - Get next async event
  * @event: Pointer to use to return async event
  *
-- 
1.8.3.1

