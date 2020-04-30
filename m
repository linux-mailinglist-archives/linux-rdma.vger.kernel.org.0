Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F0A1C00A0
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2020 17:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgD3Pmy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Apr 2020 11:42:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgD3Pmy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Apr 2020 11:42:54 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8FB720661;
        Thu, 30 Apr 2020 15:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588261373;
        bh=UBGsGMojVSJQd4VwAxI34VFl77HA+TkT0mTtbQb5JYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SqJieov9rzdSI/pwAd1Y7GnWCBctLBBzEowVncP25wD0Wn38GxdAT9VnYRxl7gKgG
         iMaQtBlxvb7Foft+YYyDpDJtw8cELfyKF+O8IzIMPlykVXxcUThwRc+URwPOg+MgCl
         LACeQcmjR5lEC/2vB7yjgXQQycJzdW1E3TLe7xxA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-core 3/4] libibverbs: Get stable IB device index
Date:   Thu, 30 Apr 2020 18:42:36 +0300
Message-Id: <20200430154237.78838-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430154237.78838-1-leon@kernel.org>
References: <20200430154237.78838-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The kernel which supports query over netlink interface returns stable IB
device index as part of it. This index much better identifier than sysfs
name that can be renamed and/or disappear. Up till now, this index was
used internally by libibverbs, but the next patch will rely on this API
in the librdmacm code.

The -1 as returned value means that kernel doesn't support indexes.

Change-Id: I9cc8837496ef04abdf6e490ad29e0632a91d7e5f
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 debian/libibverbs1.symbols               |  2 ++
 libibverbs/CMakeLists.txt                |  2 +-
 libibverbs/device.c                      |  7 +++++
 libibverbs/libibverbs.map.in             |  5 +++
 libibverbs/man/CMakeLists.txt            |  1 +
 libibverbs/man/ibv_get_device_guid.3.md  |  2 +-
 libibverbs/man/ibv_get_device_index.3.md | 40 ++++++++++++++++++++++++
 libibverbs/man/ibv_get_device_list.3.md  |  1 +
 libibverbs/verbs.h                       |  9 ++++++
 9 files changed, 67 insertions(+), 2 deletions(-)
 create mode 100644 libibverbs/man/ibv_get_device_index.3.md

diff --git a/debian/libibverbs1.symbols b/debian/libibverbs1.symbols
index ec40b29b..10ca9bf3 100644
--- a/debian/libibverbs1.symbols
+++ b/debian/libibverbs1.symbols
@@ -6,6 +6,7 @@ libibverbs.so.1 libibverbs1 #MINVER#
  IBVERBS_1.6@IBVERBS_1.6 24
  IBVERBS_1.7@IBVERBS_1.7 25
  IBVERBS_1.8@IBVERBS_1.8 28
+ IBVERBS_1.9@IBVERBS_1.9 30
  (symver)IBVERBS_PRIVATE_25 25
  ibv_ack_async_event@IBVERBS_1.0 1.1.6
  ibv_ack_async_event@IBVERBS_1.1 1.1.6
@@ -58,6 +59,7 @@ libibverbs.so.1 libibverbs1 #MINVER#
  ibv_get_cq_event@IBVERBS_1.1 1.1.6
  ibv_get_device_guid@IBVERBS_1.0 1.1.6
  ibv_get_device_guid@IBVERBS_1.1 1.1.6
+ ibv_get_device_index@IBVERBS_1.9 30
  ibv_get_device_list@IBVERBS_1.0 1.1.6
  ibv_get_device_list@IBVERBS_1.1 1.1.6
  ibv_get_device_name@IBVERBS_1.0 1.1.6
diff --git a/libibverbs/CMakeLists.txt b/libibverbs/CMakeLists.txt
index 43285489..a10bf103 100644
--- a/libibverbs/CMakeLists.txt
+++ b/libibverbs/CMakeLists.txt
@@ -21,7 +21,7 @@ configure_file("libibverbs.map.in"

 rdma_library(ibverbs "${CMAKE_CURRENT_BINARY_DIR}/libibverbs.map"
   # See Documentation/versioning.md
-  1 1.8.${PACKAGE_VERSION}
+  1 1.9.${PACKAGE_VERSION}
   all_providers.c
   cmd.c
   cmd_ah.c
diff --git a/libibverbs/device.c b/libibverbs/device.c
index bc7df1b0..0427c74e 100644
--- a/libibverbs/device.c
+++ b/libibverbs/device.c
@@ -150,6 +150,13 @@ LATEST_SYMVER_FUNC(ibv_get_device_guid, 1_1, "IBVERBS_1.1",
 	return htobe64(guid);
 }

+int ibv_get_device_index(struct ibv_device *device)
+{
+	struct verbs_sysfs_dev *sysfs_dev = verbs_get_device(device)->sysfs;
+
+	return sysfs_dev->ibdev_idx;
+}
+
 int ibv_get_fw_ver(char *value, size_t len, struct verbs_sysfs_dev *sysfs_dev)
 {
 	/*
diff --git a/libibverbs/libibverbs.map.in b/libibverbs/libibverbs.map.in
index 5280cfe6..f0d79c78 100644
--- a/libibverbs/libibverbs.map.in
+++ b/libibverbs/libibverbs.map.in
@@ -126,6 +126,11 @@ IBVERBS_1.8 {
 		ibv_reg_mr_iova2;
 } IBVERBS_1.7;

+IBVERBS_1.9 {
+	global:
+		ibv_get_device_index;
+} IBVERBS_1.8;
+
 /* If any symbols in this stanza change ABI then the entire staza gets a new symbol
    version. See the top level CMakeLists.txt for this setting. */

diff --git a/libibverbs/man/CMakeLists.txt b/libibverbs/man/CMakeLists.txt
index e1d5edf8..87f00185 100644
--- a/libibverbs/man/CMakeLists.txt
+++ b/libibverbs/man/CMakeLists.txt
@@ -32,6 +32,7 @@ rdma_man_pages(
   ibv_get_async_event.3
   ibv_get_cq_event.3
   ibv_get_device_guid.3.md
+  ibv_get_device_index.3.md
   ibv_get_device_list.3.md
   ibv_get_device_name.3.md
   ibv_get_pkey_index.3.md
diff --git a/libibverbs/man/ibv_get_device_guid.3.md b/libibverbs/man/ibv_get_device_guid.3.md
index 6dc96001..376c7871 100644
--- a/libibverbs/man/ibv_get_device_guid.3.md
+++ b/libibverbs/man/ibv_get_device_guid.3.md
@@ -31,7 +31,7 @@ RDMA device *device*.
 order.

 # SEE ALSO
-
+**ibv_get_device_index**(3),
 **ibv_get_device_list**(3),
 **ibv_get_device_name**(3),
 **ibv_open_device**(3)
diff --git a/libibverbs/man/ibv_get_device_index.3.md b/libibverbs/man/ibv_get_device_index.3.md
new file mode 100644
index 00000000..69f00c4f
--- /dev/null
+++ b/libibverbs/man/ibv_get_device_index.3.md
@@ -0,0 +1,40 @@
+---
+date: ' 2020-04-22'
+footer: libibverbs
+header: "Libibverbs Programmer's Manual"
+layout: page
+license: 'Licensed under the OpenIB.org BSD license (FreeBSD Variant) - See COPYING.md'
+section: 3
+title: IBV_GET_DEVICE_INDEX
+---
+
+# NAME
+
+ibv_get_device_index - get an RDMA device index
+
+# SYNOPSIS
+
+```c
+#include <infiniband/verbs.h>
+
+int ibv_get_device_index(struct ibv_device *device);
+```
+
+# DESCRIPTION
+
+**ibv_get_device_index()** returns stable IB device index as it is assigned by the kernel.
+
+# RETURN VALUE
+
+**ibv_get_device_index()** returns an index, or -1 if the kernel doesn't support device indexes.
+
+# SEE ALSO
+
+**ibv_get_device_name**(3),
+**ibv_get_device_guid**(3),
+**ibv_get_device_list**(3),
+**ibv_open_device**(3)
+
+# AUTHOR
+
+Leon Romanovsky <leonro@mellanox.com>
diff --git a/libibverbs/man/ibv_get_device_list.3.md b/libibverbs/man/ibv_get_device_list.3.md
index 3d222f66..8f3995e4 100644
--- a/libibverbs/man/ibv_get_device_list.3.md
+++ b/libibverbs/man/ibv_get_device_list.3.md
@@ -88,6 +88,7 @@ recommended.
 **ibv_fork_init**(3),
 **ibv_get_device_guid**(3),
 **ibv_get_device_name**(3),
+**ibv_get_device_index**(3),
 **ibv_open_device**(3)

 # AUTHOR
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index 288985d5..b08b4c20 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -2202,6 +2202,15 @@ void ibv_free_device_list(struct ibv_device **list);
  */
 const char *ibv_get_device_name(struct ibv_device *device);

+/**
+ * ibv_get_device_index - Return kernel device index
+ *
+ * Available for the kernel with support of IB device query
+ * over netlink interface. For the unsupported kernels, the
+ * relevant -1 will be returned.
+ */
+int ibv_get_device_index(struct ibv_device *device);
+
 /**
  * ibv_get_device_guid - Return device's node GUID
  */
--
2.26.2

