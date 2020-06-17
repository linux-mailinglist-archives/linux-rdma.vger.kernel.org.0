Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2D71FC7CE
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 09:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgFQHqd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 03:46:33 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:37712 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726542AbgFQHqb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jun 2020 03:46:31 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with SMTP; 17 Jun 2020 10:46:28 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 05H7kSBc017634;
        Wed, 17 Jun 2020 10:46:28 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 05H7kSof007169;
        Wed, 17 Jun 2020 10:46:28 +0300
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 05H7kSHZ007168;
        Wed, 17 Jun 2020 10:46:28 +0300
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, yishaih@mellanox.com, maorg@mellanox.com
Subject: [PATCH rdma-core 03/13] verbs: Introduce ibv_import_device() verb
Date:   Wed, 17 Jun 2020 10:45:46 +0300
Message-Id: <1592379956-7043-4-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
References: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
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
 debian/libibverbs1.symbols            |  2 ++
 libibverbs/CMakeLists.txt             |  2 +-
 libibverbs/device.c                   | 55 +++++++++++++++++++++++++++++++++++
 libibverbs/driver.h                   |  2 ++
 libibverbs/libibverbs.map.in          |  5 ++++
 libibverbs/man/CMakeLists.txt         |  1 +
 libibverbs/man/ibv_import_device.3.md | 48 ++++++++++++++++++++++++++++++
 libibverbs/verbs.h                    |  5 ++++
 8 files changed, 119 insertions(+), 1 deletion(-)
 create mode 100644 libibverbs/man/ibv_import_device.3.md

diff --git a/debian/libibverbs1.symbols b/debian/libibverbs1.symbols
index 10ca9bf..e636c1d 100644
--- a/debian/libibverbs1.symbols
+++ b/debian/libibverbs1.symbols
@@ -7,6 +7,7 @@ libibverbs.so.1 libibverbs1 #MINVER#
  IBVERBS_1.7@IBVERBS_1.7 25
  IBVERBS_1.8@IBVERBS_1.8 28
  IBVERBS_1.9@IBVERBS_1.9 30
+ IBVERBS_1.10@IBVERBS_1.10 31
  (symver)IBVERBS_PRIVATE_25 25
  ibv_ack_async_event@IBVERBS_1.0 1.1.6
  ibv_ack_async_event@IBVERBS_1.1 1.1.6
@@ -66,6 +67,7 @@ libibverbs.so.1 libibverbs1 #MINVER#
  ibv_get_device_name@IBVERBS_1.1 1.1.6
  ibv_get_pkey_index@IBVERBS_1.5 20
  ibv_get_sysfs_path@IBVERBS_1.0 1.1.6
+ ibv_import_device@IBVERBS_1.10 31
  ibv_init_ah_from_wc@IBVERBS_1.1 1.1.6
  ibv_modify_qp@IBVERBS_1.0 1.1.6
  ibv_modify_qp@IBVERBS_1.1 1.1.6
diff --git a/libibverbs/CMakeLists.txt b/libibverbs/CMakeLists.txt
index 7e4668e..06a590f 100644
--- a/libibverbs/CMakeLists.txt
+++ b/libibverbs/CMakeLists.txt
@@ -21,7 +21,7 @@ configure_file("libibverbs.map.in"
 
 rdma_library(ibverbs "${CMAKE_CURRENT_BINARY_DIR}/libibverbs.map"
   # See Documentation/versioning.md
-  1 1.9.${PACKAGE_VERSION}
+  1 1.10.${PACKAGE_VERSION}
   all_providers.c
   cmd.c
   cmd_ah.c
diff --git a/libibverbs/device.c b/libibverbs/device.c
index 629832e..0a8403d 100644
--- a/libibverbs/device.c
+++ b/libibverbs/device.c
@@ -374,6 +374,61 @@ LATEST_SYMVER_FUNC(ibv_open_device, 1_1, "IBVERBS_1.1",
 	return verbs_open_device(device, NULL);
 }
 
+static struct ibv_context *verbs_import_device(int cmd_fd)
+{
+	struct verbs_device *verbs_device = NULL;
+	struct verbs_context *context_ex;
+	struct ibv_device **dev_list;
+	struct ibv_context *ctx = NULL;
+	struct stat st;
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
+	context_ex = verbs_device->ops->import_context(&verbs_device->device, cmd_fd);
+	if (!context_ex)
+		goto out;
+
+	set_lib_ops(context_ex);
+
+	ctx = &context_ex->context;
+out:
+	ibv_free_device_list(dev_list);
+	return ctx;
+}
+
+struct ibv_context *ibv_import_device(int cmd_fd)
+{
+	return verbs_import_device(cmd_fd);
+}
+
 void verbs_uninit_context(struct verbs_context *context_ex)
 {
 	free(context_ex->priv);
diff --git a/libibverbs/driver.h b/libibverbs/driver.h
index de81955..52ecbfe 100644
--- a/libibverbs/driver.h
+++ b/libibverbs/driver.h
@@ -209,6 +209,8 @@ struct verbs_device_ops {
 	struct verbs_context *(*alloc_context)(struct ibv_device *device,
 					       int cmd_fd,
 					       void *private_data);
+	struct verbs_context *(*import_context)(struct ibv_device *device,
+						int cmd_fd);
 
 	struct verbs_device *(*alloc_device)(struct verbs_sysfs_dev *sysfs_dev);
 	void (*uninit_device)(struct verbs_device *device);
diff --git a/libibverbs/libibverbs.map.in b/libibverbs/libibverbs.map.in
index f0d79c7..a60991e 100644
--- a/libibverbs/libibverbs.map.in
+++ b/libibverbs/libibverbs.map.in
@@ -131,6 +131,11 @@ IBVERBS_1.9 {
 		ibv_get_device_index;
 } IBVERBS_1.8;
 
+IBVERBS_1.10 {
+	global:
+		ibv_import_device;
+} IBVERBS_1.9;
+
 /* If any symbols in this stanza change ABI then the entire staza gets a new symbol
    version. See the top level CMakeLists.txt for this setting. */
 
diff --git a/libibverbs/man/CMakeLists.txt b/libibverbs/man/CMakeLists.txt
index 87f0018..58ad832 100644
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
index 18bc9b0..67ec946 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -2227,6 +2227,11 @@ struct ibv_context *ibv_open_device(struct ibv_device *device);
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

