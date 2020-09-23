Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCF727564F
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Sep 2020 12:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIWK10 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Sep 2020 06:27:26 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5323 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIWK10 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Sep 2020 06:27:26 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6b22af0000>; Wed, 23 Sep 2020 03:25:51 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 23 Sep
 2020 10:27:25 +0000
Received: from dev-l-vrt-092.mtl.labs.mlnx (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 23 Sep 2020 10:27:23 +0000
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <avihaih@nvidia.com>
Subject: [PATCH V1 rdma-core 6/8] verbs: Introduce a new query GID table API
Date:   Wed, 23 Sep 2020 13:27:00 +0300
Message-ID: <20200923102702.590008-7-yishaih@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200923102702.590008-1-yishaih@nvidia.com>
References: <20200923102702.590008-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600856751; bh=tHrlyLreSNEJiYj3+FcfNpxzdA+DO14aIUP2gw1zfTg=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        b=iFB4sv36ZElhfSYYYk2E+LStJvVaCxYPMJgmOhN5QRSVpgf/1sIGQ9oAImd2zRop1
         uD9xL2rby0EUspcozCJmazVRpt04z7iCi0H4/UR3bK0lmptv9TtkxJBddjlBbZa1q2
         5cDftswuULY3joEVucwZligLRRIxmfZnPuLdAXdMAM3bpsvy+p79+Rl/NTMjr0usbk
         U4FhRRGoZDAgmUcxLgM6rHdNptaZOxV2ozVVK9xTiwSrYb9epAO179d3f7/u2Wo0UH
         +fH3T06Q3AX7hKnHn1+oiHaNaMpwQKT9VE4ZwQaDwrkO/rSvCmzIAnM057/VodGrvO
         b91Wix0ZxNsWQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Avihai Horon <avihaih@nvidia.com>

Introduce the ibv_query_gid_table verb which queries the GID tables of
the given device and stores the queried data in a buffer provided by the
user.

If the kernel doesn't support ioctl or the needed uverbs method, the
API will try to query the GID tables via sysfs.

This API provides a faster way to query the GID tables of a device using
a single call over ioctl, instead of multiple calls to open, close and
read multiple sysfs files for a single GID table entry.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 debian/libibverbs1.symbols              |   1 +
 libibverbs/cmd_device.c                 | 117 ++++++++++++++++++++++++++++=
+---
 libibverbs/libibverbs.map.in            |   1 +
 libibverbs/man/CMakeLists.txt           |   1 +
 libibverbs/man/ibv_query_gid_table.3.md |  73 ++++++++++++++++++++
 libibverbs/verbs.h                      |  16 +++++
 6 files changed, 199 insertions(+), 10 deletions(-)
 create mode 100644 libibverbs/man/ibv_query_gid_table.3.md

diff --git a/debian/libibverbs1.symbols b/debian/libibverbs1.symbols
index 536d543..99257de 100644
--- a/debian/libibverbs1.symbols
+++ b/debian/libibverbs1.symbols
@@ -11,6 +11,7 @@ libibverbs.so.1 libibverbs1 #MINVER#
  IBVERBS_1.11@IBVERBS_1.11 32
  (symver)IBVERBS_PRIVATE_25 25
  _ibv_query_gid_ex@IBVERBS_1.11 32
+ _ibv_query_gid_table@IBVERBS_1.11 32
  ibv_ack_async_event@IBVERBS_1.0 1.1.6
  ibv_ack_async_event@IBVERBS_1.1 1.1.6
  ibv_ack_cq_events@IBVERBS_1.0 1.1.6
diff --git a/libibverbs/cmd_device.c b/libibverbs/cmd_device.c
index 4f85010..8bcfbb4 100644
--- a/libibverbs/cmd_device.c
+++ b/libibverbs/cmd_device.c
@@ -321,7 +321,7 @@ static int query_sysfs_gid_type(struct ibv_context *con=
text, uint8_t port_num,
 static int query_sysfs_gid_entry(struct ibv_context *context, uint32_t por=
t_num,
 				 uint32_t gid_index,
 				 struct ibv_gid_entry *entry,
-				 uint32_t attr_mask)
+				 uint32_t attr_mask, int link_layer)
 {
 	enum ibv_gid_type_sysfs gid_type;
 	struct ibv_port_attr port_attr =3D {};
@@ -342,14 +342,18 @@ static int query_sysfs_gid_entry(struct ibv_context *=
context, uint32_t port_num,
 			return EINVAL;
=20
 		if (gid_type =3D=3D IBV_GID_TYPE_SYSFS_IB_ROCE_V1) {
-			ret =3D ibv_query_port(context, port_num, &port_attr);
-			if (ret)
-				goto out;
+			if (link_layer < 0) {
+				ret =3D ibv_query_port(context, port_num,
+						     &port_attr);
+				if (ret)
+					goto out;
+
+				link_layer =3D port_attr.link_layer;
+			}
=20
-			if (port_attr.link_layer =3D=3D IBV_LINK_LAYER_INFINIBAND) {
+			if (link_layer =3D=3D IBV_LINK_LAYER_INFINIBAND) {
 				entry->gid_type =3D IBV_GID_TYPE_IB;
-			} else if (port_attr.link_layer =3D=3D
-				   IBV_LINK_LAYER_ETHERNET) {
+			} else if (link_layer =3D=3D IBV_LINK_LAYER_ETHERNET) {
 				entry->gid_type =3D IBV_GID_TYPE_ROCE_V1;
 			} else {
 				ret =3D EINVAL;
@@ -368,8 +372,64 @@ out:
 	return ret;
 }
=20
-/* Using async_event cmd_name because query_gid_ex is not in
- * verbs_context_ops while async_event is and doesn't use ioctl.
+static int query_gid_table_fb(struct ibv_context *context,
+			      struct ibv_gid_entry *entries, size_t max_entries,
+			      uint64_t *num_entries, size_t entry_size)
+{
+	struct ibv_device_attr dev_attr =3D {};
+	struct ibv_port_attr port_attr =3D {};
+	struct ibv_gid_entry entry =3D {};
+	int attr_mask;
+	void *tmp;
+	int i, j;
+	int ret;
+
+	ret =3D ibv_query_device(context, &dev_attr);
+	if (ret)
+		goto out;
+
+	tmp =3D entries;
+	*num_entries =3D 0;
+	attr_mask =3D VERBS_QUERY_GID_ATTR_GID | VERBS_QUERY_GID_ATTR_TYPE |
+		    VERBS_QUERY_GID_ATTR_NDEV_IFINDEX;
+	for (i =3D 0; i < dev_attr.phys_port_cnt; i++) {
+		ret =3D ibv_query_port(context, i + 1, &port_attr);
+		if (ret)
+			goto out;
+
+		for (j =3D 0; j < port_attr.gid_tbl_len; j++) {
+			/* In case we already reached max_entries, query to some
+			 * temp entry, in case all other entries are zeros the
+			 * API should succceed.
+			 */
+			if (*num_entries =3D=3D max_entries)
+				tmp =3D &entry;
+			ret =3D query_sysfs_gid_entry(context, i + 1, j,
+						    tmp,
+						    attr_mask,
+						    port_attr.link_layer);
+			if (ret)
+				goto out;
+			if (is_zero_gid(&((struct ibv_gid_entry *)tmp)->gid))
+				continue;
+			if (*num_entries =3D=3D max_entries) {
+				ret =3D EINVAL;
+				goto out;
+			}
+
+			(*num_entries)++;
+			tmp +=3D entry_size;
+		}
+	}
+
+out:
+	return ret;
+}
+
+/* Using async_event cmd_name because query_gid_ex and query_gid_table are=
 not
+ * in verbs_context_ops while async_event is and doesn't use ioctl.
+ * If one of them is not supported, so is the other. Hence, we can use a s=
ingle
+ * cmd_name for both of them.
  */
 #define query_gid_kernel_cap async_event
 int __ibv_query_gid_ex(struct ibv_context *context, uint32_t port_num,
@@ -395,7 +455,7 @@ int __ibv_query_gid_ex(struct ibv_context *context, uin=
t32_t port_num,
 			return EOPNOTSUPP;
=20
 		ret =3D query_sysfs_gid_entry(context, port_num, gid_index,
-					    entry, fallback_attr_mask);
+					    entry, fallback_attr_mask, -1);
 		if (ret)
 			return ret;
=20
@@ -419,3 +479,40 @@ int _ibv_query_gid_ex(struct ibv_context *context, uin=
t32_t port_num,
 				  VERBS_QUERY_GID_ATTR_TYPE |
 				  VERBS_QUERY_GID_ATTR_NDEV_IFINDEX);
 }
+
+ssize_t _ibv_query_gid_table(struct ibv_context *context,
+				struct ibv_gid_entry *entries,
+				size_t max_entries, uint32_t flags,
+				size_t entry_size)
+{
+	DECLARE_COMMAND_BUFFER(cmdb, UVERBS_OBJECT_DEVICE,
+			       UVERBS_METHOD_QUERY_GID_TABLE, 4);
+	uint64_t num_entries;
+	int ret;
+
+	fill_attr_const_in(cmdb, UVERBS_ATTR_QUERY_GID_TABLE_ENTRY_SIZE,
+			   entry_size);
+	fill_attr_in_uint32(cmdb, UVERBS_ATTR_QUERY_GID_TABLE_FLAGS, flags);
+	fill_attr_out(cmdb, UVERBS_ATTR_QUERY_GID_TABLE_RESP_ENTRIES, entries,
+		      _array_len(entry_size, max_entries));
+	fill_attr_out_ptr(cmdb, UVERBS_ATTR_QUERY_GID_TABLE_RESP_NUM_ENTRIES,
+			  &num_entries);
+
+	switch (execute_ioctl_fallback(context, query_gid_kernel_cap, cmdb,
+				       &ret)) {
+	case TRY_WRITE:
+		if (flags)
+			return -EOPNOTSUPP;
+
+		ret =3D query_gid_table_fb(context, entries, max_entries,
+					 &num_entries, entry_size);
+		break;
+	default:
+		break;
+	}
+
+	if (ret)
+		return -ret;
+
+	return num_entries;
+}
diff --git a/libibverbs/libibverbs.map.in b/libibverbs/libibverbs.map.in
index dae4963..7429016 100644
--- a/libibverbs/libibverbs.map.in
+++ b/libibverbs/libibverbs.map.in
@@ -145,6 +145,7 @@ IBVERBS_1.10 {
 IBVERBS_1.11 {
 	global:
 		_ibv_query_gid_ex;
+		_ibv_query_gid_table;
 } IBVERBS_1.10;
=20
 /* If any symbols in this stanza change ABI then the entire staza gets a n=
ew symbol
diff --git a/libibverbs/man/CMakeLists.txt b/libibverbs/man/CMakeLists.txt
index 2dea4ff..1fb5ac1 100644
--- a/libibverbs/man/CMakeLists.txt
+++ b/libibverbs/man/CMakeLists.txt
@@ -58,6 +58,7 @@ rdma_man_pages(
   ibv_query_ece.3.md
   ibv_query_gid.3.md
   ibv_query_gid_ex.3.md
+  ibv_query_gid_table.3.md
   ibv_query_pkey.3.md
   ibv_query_port.3
   ibv_query_qp.3
diff --git a/libibverbs/man/ibv_query_gid_table.3.md b/libibverbs/man/ibv_q=
uery_gid_table.3.md
new file mode 100644
index 0000000..e10f51c
--- /dev/null
+++ b/libibverbs/man/ibv_query_gid_table.3.md
@@ -0,0 +1,73 @@
+---
+date: 2020-04-24
+footer: libibverbs
+header: "Libibverbs Programmer's Manual"
+layout: page
+license: 'Licensed under the OpenIB.org BSD license (FreeBSD Variant) - Se=
e COPYING.md'
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
+ssize_t ibv_query_gid_table(struct ibv_context *context,
+                            struct ibv_gid_entry *entries,
+                            size_t max_entries,
+                            uint32_t flags);
+```
+
+# DESCRIPTION
+
+**ibv_query_gid_table()** returns the valid GID table entries of the RDMA
+device context *context* at the pointer *entries*.
+
+A caller must allocate *entries* array for the GID table entries it
+desires to query. This API returns only valid GID table entries.
+
+A caller must pass non zero number of entries at *max_entries* that corres=
ponds
+to the size of *entries* array.
+
+*entries* array must be allocated such that it can contain all the valid
+GID table entries of the device. If there are more valid GID entries than
+the provided value of *max_entries* and *entries* array, the call will fai=
l.
+For example, if a RDMA device *context* has a total of 10 valid
+GID entries, *entries* should be allocated for at least 10 entries, and
+*max_entries* should be set appropriately.
+
+# ARGUMENTS
+
+*context*
+:	The context of the device to query.
+
+*entries*
+:	Array of ibv_gid_entry structs where the GID entries are returned.
+	Please see **ibv_query_gid_ex**(3) man page for *ibv_gid_entry*.
+
+*max_entries*
+:	Maximum number of entries that can be returned.
+
+*flags*
+:	Extra fields to query post *entries->ndev_ifindex*, for now must be 0.
+
+# RETURN VALUE
+
+**ibv_query_gid_table()** returns the number of entries that were read on =
success or negative errno value on error.
+Number of entries returned is <=3D max_entries.
+
+# SEE ALSO
+
+**ibv_open_device**(3),
+**ibv_query_device**(3),
+**ibv_query_port**(3),
+**ibv_query_gid_ex**(3)
+
+# AUTHOR
+
+Parav Pandit <parav@nvidia.com>
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index e5bf900..caf626c 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -43,6 +43,7 @@
 #include <string.h>
 #include <linux/types.h>
 #include <stdint.h>
+#include <sys/types.h>
 #include <infiniband/verbs_api.h>
=20
 #ifdef __cplusplus
@@ -2359,6 +2360,21 @@ static inline int ibv_query_gid_ex(struct ibv_contex=
t *context,
 				 sizeof(*entry));
 }
=20
+ssize_t _ibv_query_gid_table(struct ibv_context *context,
+			     struct ibv_gid_entry *entries, size_t max_entries,
+			     uint32_t flags, size_t entry_size);
+
+/*
+ * ibv_query_gid_table - Get all valid GID table entries
+ */
+static inline ssize_t ibv_query_gid_table(struct ibv_context *context,
+					  struct ibv_gid_entry *entries,
+					  size_t max_entries, uint32_t flags)
+{
+	return _ibv_query_gid_table(context, entries, max_entries, flags,
+				    sizeof(*entries));
+}
+
 /**
  * ibv_query_pkey - Get a P_Key table entry
  */
--=20
1.8.3.1

