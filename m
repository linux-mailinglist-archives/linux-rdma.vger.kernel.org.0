Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDBD1CD700
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 13:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgEKLBQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 07:01:16 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:43859 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728574AbgEKLBQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 May 2020 07:01:16 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from parav@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 11 May 2020 14:01:08 +0300
Received: from sw-mtx-036.mtx.labs.mlnx (sw-mtx-036.mtx.labs.mlnx [10.9.150.149])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 04BB16vw023435;
        Mon, 11 May 2020 14:01:06 +0300
From:   Parav Pandit <parav@mellanox.com>
To:     jgg@mellanox.com, yishaih@mellanox.com, leonro@mellanox.com,
        linux-rdma@vger.kernel.org
Cc:     maorg@mellanox.com, parav@mellanox.com
Subject: [RFC PATCH] Query all valid GID table entries of an RDMA device
Date:   Mon, 11 May 2020 06:01:04 -0500
Message-Id: <20200511110104.27126-1-parav@mellanox.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When an application is not using RDMA CM and if it is using multiple
RDMA devices with one or more RoCE ports, finding the right GID
table entry is long process.
For example with two RoCE dual port devices in a system, when IP
failover is used among between two RoCE ports, searching a suitable GID
entry for a given source IP, matching netdevice of given RoCEv1/v2 type
requires iterating over all 4 ports * 256 entry GID table.
Even though best first match GID table for a given criteria is used,
when matching entry is on 4th port, requires reading
3 ports * 256 entries * 3 files (GID, netdev, type) = 2304 files.

GID table needs to be referred on every QP creation during IP failover
on other netdevice of an RDMA device.
In an alternative approach, a GID cache may be maintained and updated
on GID change event reported by kernel. However, it comes with below two
limitations.
(a) Maintain a thread per application process instance to listen and
update cache
(b) Without the thread, on cache miss event, query the GID table. Even
in this approach, if multiple processes are used, a GID cache needs to
be maintained on per process basis. With large number of processes, this
method doesn't scale.

Hence, introduce an API to query complete GID table of an rdma device
that returns all valid GID table entries.
This is done through single ioctl, eliminating 2304 read, 2304
open and 2304 close system calls to just total of 2 calls.

While at it, also introduce a QUERY API to individual GID entry over
ioctl interface which provides all GID attributes information.

This RFC only contains user facing data structures, APIs and user-kernel
interface specification. A full implementation in kernel will be done
once RFC review is completed.

Signed-off-by: Parav Pandit <parav@mellanox.com>
---
 kernel-headers/rdma/ib_user_ioctl_cmds.h  | 11 ++++
 kernel-headers/rdma/ib_user_ioctl_verbs.h | 14 +++++
 libibverbs/man/ibv_query_gid_ex.3.md      | 45 ++++++++++++++++
 libibverbs/man/ibv_query_gid_table.3.md   | 62 +++++++++++++++++++++++
 libibverbs/verbs.h                        | 54 ++++++++++++++++++++
 5 files changed, 186 insertions(+)
 create mode 100644 libibverbs/man/ibv_query_gid_ex.3.md
 create mode 100644 libibverbs/man/ibv_query_gid_table.3.md

diff --git a/kernel-headers/rdma/ib_user_ioctl_cmds.h b/kernel-headers/rdma/ib_user_ioctl_cmds.h
index 4961d5e8..ce33abbe 100644
--- a/kernel-headers/rdma/ib_user_ioctl_cmds.h
+++ b/kernel-headers/rdma/ib_user_ioctl_cmds.h
@@ -69,6 +69,8 @@ enum uverbs_methods_device {
 	UVERBS_METHOD_INFO_HANDLES,
 	UVERBS_METHOD_QUERY_PORT,
 	UVERBS_METHOD_GET_CONTEXT,
+	UVERBS_METHOD_QUERY_GID_ENTRY,
+	UVERBS_METHOD_QUERY_GID_TABLE,
 };
 
 enum uverbs_attrs_invoke_write_cmd_attr_ids {
@@ -337,4 +339,13 @@ enum uverbs_attrs_async_event_create {
 	UVERBS_ATTR_ASYNC_EVENT_ALLOC_FD_HANDLE,
 };
 
+enum uverbs_attrs_query_gid_table_cmd_attr_ids {
+	UVERBS_ATTR_QUERY_GID_TABLE_MAX_ENTRIES,
+};
+
+enum uverbs_attrs_query_gid_entry_cmd_attr_ids {
+	UVERBS_ATTR_QUERY_GID_ENTRY_PORT,
+	UVERBS_ATTR_QUERY_GID_ENTRY_GID_INDEX,
+};
+
 #endif
diff --git a/kernel-headers/rdma/ib_user_ioctl_verbs.h b/kernel-headers/rdma/ib_user_ioctl_verbs.h
index 5debab45..af6542c6 100644
--- a/kernel-headers/rdma/ib_user_ioctl_verbs.h
+++ b/kernel-headers/rdma/ib_user_ioctl_verbs.h
@@ -250,4 +250,18 @@ enum rdma_driver_id {
 	RDMA_DRIVER_SIW,
 };
 
+enum ib_uverbs_gid_entry_type {
+	IB_UVERBS_GID_TYPE_IB,		/* Applicable to IB link layer */
+	IB_UVERBS_GID_TYPE_ROCEV1,	/* RoCEv1 GID of Ethernet link layer */
+	IB_UVERBS_GID_TYPE_ROCEV2,	/* RoCEv2 GID of Ethernet link layer */
+};
+
+struct ib_uverbs_gid_entry {
+	__u8 gid[16];
+	__u32 gid_index;
+	__u32 port_num;
+	__u32 gid_type;
+	int netdev_ifindex;	/* Valid only when its value is >= 0 */
+};
+
 #endif
diff --git a/libibverbs/man/ibv_query_gid_ex.3.md b/libibverbs/man/ibv_query_gid_ex.3.md
new file mode 100644
index 00000000..ba289a87
--- /dev/null
+++ b/libibverbs/man/ibv_query_gid_ex.3.md
@@ -0,0 +1,45 @@
+---
+date: 2020-04-24
+footer: libibverbs
+header: "Libibverbs Programmer's Manual"
+layout: page
+license: 'Licensed under the OpenIB.org BSD license (FreeBSD Variant) - See COPYING.md'
+section: 3
+title: IBV_QUERY_GID_EX
+---
+
+# NAME
+
+ibv_query_gid_ex - Query an InfiniBand port's GID table entry
+
+# SYNOPSIS
+
+```c
+#include <infiniband/verbs.h>
+
+int ibv_query_gid_ex(struct ibv_context *context,
+                     uint32_t port_num,
+                     uint32_t gid_index,
+                     struct ibv_gid_entry *entry);
+```
+
+# DESCRIPTION
+
+**ibv_query_gid_ex()** returns the GID entry at *entry*" for *gid_index*
+of port *port_num* for device context *context*.
+
+# RETURN VALUE
+
+**ibv_query_gid_ex()** returns 0 on success or error code on error.
+
+# SEE ALSO
+
+**ibv_open_device**(3),
+**ibv_query_device**(3),
+**ibv_query_pkey**(3),
+**ibv_query_port**(3)
+**ibv_query_gid_table**(3)
+
+# AUTHOR
+
+Parav Pandit <parav@mellanox.com>
diff --git a/libibverbs/man/ibv_query_gid_table.3.md b/libibverbs/man/ibv_query_gid_table.3.md
new file mode 100644
index 00000000..eb291dd0
--- /dev/null
+++ b/libibverbs/man/ibv_query_gid_table.3.md
@@ -0,0 +1,62 @@
+---
+date: 2020-04-24
+footer: libibverbs
+header: "Libibverbs Programmer's Manual"
+layout: page
+license: 'Licensed under the OpenIB.org BSD license (FreeBSD Variant) - See COPYING.md'
+section: 3
+title: IBV_QUERY_GID_TABLE
+---
+
+# NAME
+
+ibv_query_gid_table - query an InfiniBand device's GID table
+
+# SYNOPSIS
+
+```c
+#include <infiniband/verbs.h>
+
+int ibv_query_gid_table(struct ibv_context *context,
+                        struct ibv_gid_entry *entries,
+                        size_t max_entries,
+                        size_t *read_entries);
+```
+
+# DESCRIPTION
+
+**ibv_query_gid_table()** returns the GID table entries of the
+RDMA device context *context* at the pointer *entries*.
+
+A caller must allocate *entries* array for the GID table entries it
+desires to query. This API returns only valid GID table entries.
+
+A caller must pass non zero number of entries at *max_entries*.
+
+It is desired that caller allocates *entries* array to sum of maximum
+number of GID entries of all the ports of the RDMA device
+context *context*. For example if a RDMA device *context* has two
+ports, with each port's GID table size is 128 entries, caller should
+allocate an array *entries* for 128 * 2 = 256 entries and provide
+*max_entries* = 256. This API fills up only valid GID entries
+of all the ports of the RDMA device *context*.
+
+When API returns success, it updates total number of valid entries read
+in the *entries* array and valid entry count is updated in *read_entries*.
+
+# RETURN VALUE
+
+**ibv_query_gid_table()** returns 0 on success or error code on error.
+It returns number of entries queried at the *entries* array.
+Number of entries returned is <= max_entries.
+
+# SEE ALSO
+
+**ibv_open_device**(3),
+**ibv_query_device**(3),
+**ibv_query_port**(3)
+**ibv_query_gid_ex()**
+
+# AUTHOR
+
+Parav Pandit <parav@mellanox.com>
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index 18bc9b04..e516895b 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -68,6 +68,29 @@ union ibv_gid {
 	} global;
 };
 
+enum ibv_gid_entry_type {
+	IBV_GID_TYPE_IB,
+	IBV_GID_TYPE_IB_ROCEV1,
+	IBV_GID_TYPE_IB_ROCEV2
+};
+
+/*
+ * ibv_gid_entry: GID entry structure
+ * @gid: GID entry
+ * @gid_index: GID table index of this entry.
+ * @port_num: Port number this GID belongs to.
+ * @gid_type: GID entry type as IB/RoCEv1 or RoCEv2 GID.
+ * @ndev_ifindex: ifndex of the netdevice associated with the GID.
+ * 		  It is -ENODEV, if there is no netdev associated with it.
+ */
+struct ibv_gid_entry {
+	union ibv_gid gid;
+	uint32_t gid_index;
+	uint32_t port_num;
+	uint32_t gid_type;	/* enum ibv_gid_entry_type */
+	int ndev_ifindex;
+};
+
 #define vext_field_avail(type, fld, sz) (offsetof(type, fld) < (sz))
 
 #ifdef __cplusplus
@@ -2289,6 +2312,37 @@ static inline int ___ibv_query_port(struct ibv_context *context,
 int ibv_query_gid(struct ibv_context *context, uint8_t port_num,
 		  int index, union ibv_gid *gid);
 
+/**
+ * ibv_query_gid_ex - Read a GID table entry
+ * @entry: Entry where GID entry is returned.
+ *
+ * ibv_query_gid_ex() returns single GID table entry at the index gid_index
+ * of the RDMA device context of port at the port_num.
+ * API returns 0 on success or an error code.
+ */
+int ibv_query_gid_ex(struct ibv_context *context, uint32_t port_num,
+		     uint32_t gid_index,
+                     struct ibv_gid_entry *entry);
+
+/**
+ * ibv_query_gid_table - Get all valid GID table entries
+ * @entries: Entries where GID entries are returned.
+ * @max_entries: Maximum entries an API should return. Entries array
+ *               must be allocated to hold max_entries number of
+ *               entries.
+ * @read_entries: API updates read_entries for the entries successfully read.
+ *
+ * ibv_query_gid_table() returns GID table entries for all the ports
+ * of the RDMA device context. It returns upto maximum number of valid
+ * GID table entries specified by max_entries.
+ * API returns 0 on success or an error code.
+ * If this functionality is not available from the kernel, it returns an error.
+ */
+int ibv_query_gid_table(struct ibv_context *context,
+                        struct ibv_gid_entry *entries,
+                        size_t max_entries,
+                        size_t *read_entries);
+
 /**
  * ibv_query_pkey - Get a P_Key table entry
  */
-- 
2.19.2

