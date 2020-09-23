Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37E227564C
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Sep 2020 12:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgIWK1U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Sep 2020 06:27:20 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13512 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIWK1U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Sep 2020 06:27:20 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6b22fa0001>; Wed, 23 Sep 2020 03:27:06 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 23 Sep
 2020 10:27:19 +0000
Received: from dev-l-vrt-092.mtl.labs.mlnx (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 23 Sep 2020 10:27:17 +0000
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <avihaih@nvidia.com>
Subject: [PATCH V1 rdma-core 3/8] verbs: Introduce a new query GID entry API
Date:   Wed, 23 Sep 2020 13:26:57 +0300
Message-ID: <20200923102702.590008-4-yishaih@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200923102702.590008-1-yishaih@nvidia.com>
References: <20200923102702.590008-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600856827; bh=eQ64vH0I2/IndYsvAUD55pOuucaEbARIFbiv2aH9NCc=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        b=fFtZzlok9BGymNnxsX6mEibv2b2Oe4MHQ0GCa08lUTgyact1ci5mD9VLAXVkcmIk9
         7wMCKtHCMzkyQdDUtGpG6MPtEDvYXEasXbSHXeve3hoDpRt0c6rBlkbvty1FoHvAOz
         6srDUGJrA+lSTt9SBpZclhaKdsY3tITFoMtosPZsbbZNP1QdFUAhMvS+FuSVSkkjf/
         2aQ0TNKPidS16oZRm8OY9ue+yvgrbX23NOUjsMdjQ0W2IYmSd3nfCAwJb6Jcn4U/bu
         65V2RvGukn0San9WjFNGPsadoBJgZZwJYPiGYwOQmg8uuKhgqwZU9EVAcc2CEAlYip
         mqpPwqzeaGlPg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Avihai Horon <avihaih@nvidia.com>

Introduce the ibv_query_gid_ex verb which queries a specific
index in the GID table of the given port of the given device.
The queried data is stored in a buffer provided by the user.

If the kernel doesn't support ioctl or the needed uverbs method, the
API will try to query the GID entry via sysfs.

This API provides a faster way to query a GID table entry using a single
call over ioctl, instead of multiple calls to open, close and read
multiple sysfs files for a single GID table entry.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 debian/libibverbs1.symbols           |   2 +
 libibverbs/CMakeLists.txt            |   2 +-
 libibverbs/cmd_device.c              | 105 +++++++++++++++++++++++++++++++=
++++
 libibverbs/libibverbs.map.in         |   5 ++
 libibverbs/man/CMakeLists.txt        |   1 +
 libibverbs/man/ibv_query_gid_ex.3.md |  93 +++++++++++++++++++++++++++++++
 libibverbs/verbs.h                   |  29 ++++++++++
 7 files changed, 236 insertions(+), 1 deletion(-)
 create mode 100644 libibverbs/man/ibv_query_gid_ex.3.md

diff --git a/debian/libibverbs1.symbols b/debian/libibverbs1.symbols
index 2efbe89..536d543 100644
--- a/debian/libibverbs1.symbols
+++ b/debian/libibverbs1.symbols
@@ -8,7 +8,9 @@ libibverbs.so.1 libibverbs1 #MINVER#
  IBVERBS_1.8@IBVERBS_1.8 28
  IBVERBS_1.9@IBVERBS_1.9 30
  IBVERBS_1.10@IBVERBS_1.10 31
+ IBVERBS_1.11@IBVERBS_1.11 32
  (symver)IBVERBS_PRIVATE_25 25
+ _ibv_query_gid_ex@IBVERBS_1.11 32
  ibv_ack_async_event@IBVERBS_1.0 1.1.6
  ibv_ack_async_event@IBVERBS_1.1 1.1.6
  ibv_ack_cq_events@IBVERBS_1.0 1.1.6
diff --git a/libibverbs/CMakeLists.txt b/libibverbs/CMakeLists.txt
index 06a590f..0fe4256 100644
--- a/libibverbs/CMakeLists.txt
+++ b/libibverbs/CMakeLists.txt
@@ -21,7 +21,7 @@ configure_file("libibverbs.map.in"
=20
 rdma_library(ibverbs "${CMAKE_CURRENT_BINARY_DIR}/libibverbs.map"
   # See Documentation/versioning.md
-  1 1.10.${PACKAGE_VERSION}
+  1 1.11.${PACKAGE_VERSION}
   all_providers.c
   cmd.c
   cmd_ah.c
diff --git a/libibverbs/cmd_device.c b/libibverbs/cmd_device.c
index a55fb10..8643cc6 100644
--- a/libibverbs/cmd_device.c
+++ b/libibverbs/cmd_device.c
@@ -32,6 +32,8 @@
=20
 #include <infiniband/cmd_write.h>
=20
+#include <net/if.h>
+
 static void copy_query_port_resp_to_port_attr(struct ibv_port_attr *port_a=
ttr,
 				       struct ib_uverbs_query_port_resp *resp)
 {
@@ -202,3 +204,106 @@ int ibv_cmd_query_context(struct ibv_context *context=
,
=20
 	return 0;
 }
+
+static int is_zero_gid(union ibv_gid *gid)
+{
+	const union ibv_gid zgid =3D {};
+
+	return !memcmp(gid, &zgid, sizeof(*gid));
+}
+
+static int query_sysfs_gid_ndev_ifindex(struct ibv_context *context,
+					uint8_t port_num, uint32_t gid_index,
+					uint32_t *ndev_ifindex)
+{
+	struct verbs_device *verbs_device =3D verbs_get_device(context->device);
+	char buff[IF_NAMESIZE];
+
+	if (ibv_read_ibdev_sysfs_file(buff, sizeof(buff), verbs_device->sysfs,
+				      "ports/%d/gid_attrs/ndevs/%d", port_num,
+				      gid_index) <=3D 0) {
+		*ndev_ifindex =3D 0;
+		return 0;
+	}
+
+	*ndev_ifindex =3D if_nametoindex(buff);
+	return *ndev_ifindex ? 0 : errno;
+}
+
+static int query_sysfs_gid_entry(struct ibv_context *context, uint32_t por=
t_num,
+				 uint32_t gid_index,
+				 struct ibv_gid_entry *entry)
+{
+	enum ibv_gid_type_sysfs gid_type;
+	struct ibv_port_attr port_attr =3D {};
+	int ret;
+
+	entry->gid_index =3D gid_index;
+	entry->port_num =3D port_num;
+	ret =3D ibv_query_gid(context, port_num, gid_index, &entry->gid);
+	if (ret)
+		return EINVAL;
+
+	ret =3D ibv_query_gid_type(context, port_num, gid_index, &gid_type);
+	if (ret)
+		return EINVAL;
+
+	if (gid_type =3D=3D IBV_GID_TYPE_SYSFS_IB_ROCE_V1) {
+		ret =3D ibv_query_port(context, port_num, &port_attr);
+		if (ret)
+			goto out;
+
+		if (port_attr.link_layer =3D=3D IBV_LINK_LAYER_INFINIBAND) {
+			entry->gid_type =3D IBV_GID_TYPE_IB;
+		} else if (port_attr.link_layer =3D=3D IBV_LINK_LAYER_ETHERNET) {
+			entry->gid_type =3D IBV_GID_TYPE_ROCE_V1;
+		} else {
+			ret =3D EINVAL;
+			goto out;
+		}
+	} else {
+		entry->gid_type =3D IBV_GID_TYPE_ROCE_V2;
+	}
+
+	ret =3D query_sysfs_gid_ndev_ifindex(context, port_num, gid_index,
+					   &entry->ndev_ifindex);
+
+out:
+	return ret;
+}
+
+/* Using async_event cmd_name because query_gid_ex is not in
+ * verbs_context_ops while async_event is and doesn't use ioctl.
+ */
+#define query_gid_kernel_cap async_event
+int _ibv_query_gid_ex(struct ibv_context *context, uint32_t port_num,
+			    uint32_t gid_index, struct ibv_gid_entry *entry,
+			    uint32_t flags, size_t entry_size)
+{
+	DECLARE_COMMAND_BUFFER(cmdb, UVERBS_OBJECT_DEVICE,
+			       UVERBS_METHOD_QUERY_GID_ENTRY, 4);
+	int ret;
+
+	fill_attr_const_in(cmdb, UVERBS_ATTR_QUERY_GID_ENTRY_PORT, port_num);
+	fill_attr_const_in(cmdb, UVERBS_ATTR_QUERY_GID_ENTRY_GID_INDEX,
+			   gid_index);
+	fill_attr_in_uint32(cmdb, UVERBS_ATTR_QUERY_GID_ENTRY_FLAGS, flags);
+	fill_attr_out(cmdb, UVERBS_ATTR_QUERY_GID_ENTRY_RESP_ENTRY, entry,
+		      entry_size);
+
+	switch (execute_ioctl_fallback(context, query_gid_kernel_cap, cmdb,
+				       &ret)) {
+	case TRY_WRITE:
+		if (flags)
+			return EOPNOTSUPP;
+
+		ret =3D query_sysfs_gid_entry(context, port_num, gid_index,
+					    entry);
+		if (ret)
+			return ret;
+
+		return is_zero_gid(&entry->gid) ? ENODATA : 0;
+	default:
+		return ret;
+	}
+}
diff --git a/libibverbs/libibverbs.map.in b/libibverbs/libibverbs.map.in
index 3240e00..dae4963 100644
--- a/libibverbs/libibverbs.map.in
+++ b/libibverbs/libibverbs.map.in
@@ -142,6 +142,11 @@ IBVERBS_1.10 {
 		ibv_unimport_pd;
 } IBVERBS_1.9;
=20
+IBVERBS_1.11 {
+	global:
+		_ibv_query_gid_ex;
+} IBVERBS_1.10;
+
 /* If any symbols in this stanza change ABI then the entire staza gets a n=
ew symbol
    version. See the top level CMakeLists.txt for this setting. */
=20
diff --git a/libibverbs/man/CMakeLists.txt b/libibverbs/man/CMakeLists.txt
index b925004..2dea4ff 100644
--- a/libibverbs/man/CMakeLists.txt
+++ b/libibverbs/man/CMakeLists.txt
@@ -57,6 +57,7 @@ rdma_man_pages(
   ibv_query_device_ex.3
   ibv_query_ece.3.md
   ibv_query_gid.3.md
+  ibv_query_gid_ex.3.md
   ibv_query_pkey.3.md
   ibv_query_port.3
   ibv_query_qp.3
diff --git a/libibverbs/man/ibv_query_gid_ex.3.md b/libibverbs/man/ibv_quer=
y_gid_ex.3.md
new file mode 100644
index 0000000..9e14f01
--- /dev/null
+++ b/libibverbs/man/ibv_query_gid_ex.3.md
@@ -0,0 +1,93 @@
+---
+date: 2020-04-24
+footer: libibverbs
+header: "Libibverbs Programmer's Manual"
+layout: page
+license: 'Licensed under the OpenIB.org BSD license (FreeBSD Variant) - Se=
e COPYING.md'
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
+                     struct ibv_gid_entry *entry,
+                     uint32_t flags);
+```
+
+# DESCRIPTION
+
+**ibv_query_gid_ex()** returns the GID entry at *entry* for
+*gid_index* of port *port_num* for device context *context*.
+
+# ARGUMENTS
+
+*context*
+:	The context of the device to query.
+
+*port_num*
+:	The number of port to query its GID table.
+
+*gid_index*
+:	The index of the GID table entry to query.
+
+## *entry* Argument
+:	An ibv_gid_entry struct, as defined in <infiniband/verbs.h>.
+```c
+struct ibv_gid_entry {
+		union ibv_gid gid;
+		uint32_t gid_index;
+		uint32_t port_num;
+		uint32_t gid_type;
+		uint32_t ndev_ifindex;
+};
+```
+
+	*gid*
+:			The GID entry.
+
+	*gid_index*
+:			The GID table index of this entry.
+
+	*port_num*
+:			The port number that this GID belongs to.
+
+	*gid_type*
+:			enum ibv_gid_type, can be one of IBV_GID_TYPE_IB, IBV_GID_TYPE_ROCE_V1=
 or IBV_GID_TYPE_ROCE_V2.
+
+	*ndev_ifindex*
+:			The interface index of the net device associated with this GID.
+			It is 0 if there is no net device associated with it.
+
+*flags*
+:	Extra fields to query post *ndev_ifindex*, for now must be 0.
+
+# RETURN VALUE
+
+**ibv_query_gid_ex()** returns 0 on success or errno value on error.
+
+# ERRORS
+
+ENODATA
+:	*gid_index* is within the GID table size of port *port_num* but there is=
 no data in this index.
+
+# SEE ALSO
+
+**ibv_open_device**(3),
+**ibv_query_device**(3),
+**ibv_query_pkey**(3),
+**ibv_query_port**(3),
+**ibv_query_gid_table**(3)
+
+# AUTHOR
+
+Parav Pandit <parav@nvidia.com>
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index 2e785aa..e5bf900 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -68,6 +68,20 @@ union ibv_gid {
 	} global;
 };
=20
+enum ibv_gid_type {
+	IBV_GID_TYPE_IB,
+	IBV_GID_TYPE_ROCE_V1,
+	IBV_GID_TYPE_ROCE_V2,
+};
+
+struct ibv_gid_entry {
+	union ibv_gid gid;
+	uint32_t gid_index;
+	uint32_t port_num;
+	uint32_t gid_type; /* enum ibv_gid_type */
+	uint32_t ndev_ifindex;
+};
+
 #define vext_field_avail(type, fld, sz) (offsetof(type, fld) < (sz))
=20
 #ifdef __cplusplus
@@ -2330,6 +2344,21 @@ static inline int ___ibv_query_port(struct ibv_conte=
xt *context,
 int ibv_query_gid(struct ibv_context *context, uint8_t port_num,
 		  int index, union ibv_gid *gid);
=20
+int _ibv_query_gid_ex(struct ibv_context *context, uint32_t port_num,
+		     uint32_t gid_index, struct ibv_gid_entry *entry,
+		     uint32_t flags, size_t entry_size);
+
+/**
+ * ibv_query_gid_ex - Read a GID table entry
+ */
+static inline int ibv_query_gid_ex(struct ibv_context *context,
+				   uint32_t port_num, uint32_t gid_index,
+				   struct ibv_gid_entry *entry, uint32_t flags)
+{
+	return _ibv_query_gid_ex(context, port_num, gid_index, entry, flags,
+				 sizeof(*entry));
+}
+
 /**
  * ibv_query_pkey - Get a P_Key table entry
  */
--=20
1.8.3.1

