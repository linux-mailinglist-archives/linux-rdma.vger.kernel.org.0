Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D88827564E
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Sep 2020 12:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIWK1Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Sep 2020 06:27:24 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4531 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIWK1Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Sep 2020 06:27:24 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6b22dd0001>; Wed, 23 Sep 2020 03:26:37 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 23 Sep
 2020 10:27:23 +0000
Received: from dev-l-vrt-092.mtl.labs.mlnx (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 23 Sep 2020 10:27:21 +0000
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <avihaih@nvidia.com>
Subject: [PATCH V1 rdma-core 5/8] verbs: Optimize ibv_query_gid and ibv_query_gid_type
Date:   Wed, 23 Sep 2020 13:26:59 +0300
Message-ID: <20200923102702.590008-6-yishaih@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200923102702.590008-1-yishaih@nvidia.com>
References: <20200923102702.590008-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600856797; bh=hNEHyZ+DPFvy3HP+kpONa64aaQu+yKzPzsueaDx4Gx0=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        b=kj0WgZrlcSsr1I8pQ+pv8NWLVSp0aXy/UDRI3p4WOXTkYidQnw15JD5whoQIY4bS1
         Ff/BJ9SDk9xv34Y/MGzft7dpniTWCbaDza1KjZXE0mWnl5/NLZlntvmexsjLyY/lqd
         0gpHOisb2sCPekyn8031jTCFS1doE0Ay08zuOvhNcu9uz/EvMMHIeF/kRiwDyi8Mhv
         Da3UTNXu2yWoD9c9HjuuNuiAg58daIkmi2O1+8KUNTAoUTY1T5O5cjbxfcMEE21c8K
         GmkU1rIZpzZDbHxVN+6RJFT1lDP4UaCMUW2+XeAgSv5ED7kFnx4h3VVxTh4sPA49x6
         WSMi19vEYXZYQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Avihai Horon <avihaih@nvidia.com>

ibv_query_gid and ibv_query_gid_type are implemented as ioctl first and
fallback to sysfs. Currently, if the fallback path is taken, all of the
gid entry attributes are retrieved over sysfs.

For example, if ibv_query_gid is called and the fallback path is taken,
the gid type and the gid ndev ifindex will also be read over sysfs,
even though we only need the gid.

In order to eliminate these unnecessary sysfs reads, we add an attribute
mask to ibv_cmd_query_gid_entry that will allow us to mark the specific
gid entry attributes that we would like to query in fallback.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 libibverbs/cmd_device.c | 76 ++++++++++++++++++++++++++++++++-------------=
----
 libibverbs/driver.h     | 11 +++++++
 libibverbs/verbs.c      |  8 +++---
 3 files changed, 65 insertions(+), 30 deletions(-)

diff --git a/libibverbs/cmd_device.c b/libibverbs/cmd_device.c
index f707273..4f85010 100644
--- a/libibverbs/cmd_device.c
+++ b/libibverbs/cmd_device.c
@@ -320,41 +320,49 @@ static int query_sysfs_gid_type(struct ibv_context *c=
ontext, uint8_t port_num,
=20
 static int query_sysfs_gid_entry(struct ibv_context *context, uint32_t por=
t_num,
 				 uint32_t gid_index,
-				 struct ibv_gid_entry *entry)
+				 struct ibv_gid_entry *entry,
+				 uint32_t attr_mask)
 {
 	enum ibv_gid_type_sysfs gid_type;
 	struct ibv_port_attr port_attr =3D {};
-	int ret;
+	int ret =3D 0;
=20
 	entry->gid_index =3D gid_index;
 	entry->port_num =3D port_num;
-	ret =3D query_sysfs_gid(context, port_num, gid_index, &entry->gid);
-	if (ret)
-		return EINVAL;
-
-	ret =3D query_sysfs_gid_type(context, port_num, gid_index, &gid_type);
-	if (ret)
-		return EINVAL;
=20
-	if (gid_type =3D=3D IBV_GID_TYPE_SYSFS_IB_ROCE_V1) {
-		ret =3D ibv_query_port(context, port_num, &port_attr);
+	if (attr_mask & VERBS_QUERY_GID_ATTR_GID) {
+		ret =3D query_sysfs_gid(context, port_num, gid_index, &entry->gid);
 		if (ret)
-			goto out;
+			return EINVAL;
+	}
=20
-		if (port_attr.link_layer =3D=3D IBV_LINK_LAYER_INFINIBAND) {
-			entry->gid_type =3D IBV_GID_TYPE_IB;
-		} else if (port_attr.link_layer =3D=3D IBV_LINK_LAYER_ETHERNET) {
-			entry->gid_type =3D IBV_GID_TYPE_ROCE_V1;
+	if (attr_mask & VERBS_QUERY_GID_ATTR_TYPE) {
+		ret =3D query_sysfs_gid_type(context, port_num, gid_index, &gid_type);
+		if (ret)
+			return EINVAL;
+
+		if (gid_type =3D=3D IBV_GID_TYPE_SYSFS_IB_ROCE_V1) {
+			ret =3D ibv_query_port(context, port_num, &port_attr);
+			if (ret)
+				goto out;
+
+			if (port_attr.link_layer =3D=3D IBV_LINK_LAYER_INFINIBAND) {
+				entry->gid_type =3D IBV_GID_TYPE_IB;
+			} else if (port_attr.link_layer =3D=3D
+				   IBV_LINK_LAYER_ETHERNET) {
+				entry->gid_type =3D IBV_GID_TYPE_ROCE_V1;
+			} else {
+				ret =3D EINVAL;
+				goto out;
+			}
 		} else {
-			ret =3D EINVAL;
-			goto out;
+			entry->gid_type =3D IBV_GID_TYPE_ROCE_V2;
 		}
-	} else {
-		entry->gid_type =3D IBV_GID_TYPE_ROCE_V2;
 	}
=20
-	ret =3D query_sysfs_gid_ndev_ifindex(context, port_num, gid_index,
-					   &entry->ndev_ifindex);
+	if (attr_mask & VERBS_QUERY_GID_ATTR_NDEV_IFINDEX)
+		ret =3D query_sysfs_gid_ndev_ifindex(context, port_num, gid_index,
+						   &entry->ndev_ifindex);
=20
 out:
 	return ret;
@@ -364,9 +372,10 @@ out:
  * verbs_context_ops while async_event is and doesn't use ioctl.
  */
 #define query_gid_kernel_cap async_event
-int _ibv_query_gid_ex(struct ibv_context *context, uint32_t port_num,
+int __ibv_query_gid_ex(struct ibv_context *context, uint32_t port_num,
 			    uint32_t gid_index, struct ibv_gid_entry *entry,
-			    uint32_t flags, size_t entry_size)
+			    uint32_t flags, size_t entry_size,
+			    uint32_t fallback_attr_mask)
 {
 	DECLARE_COMMAND_BUFFER(cmdb, UVERBS_OBJECT_DEVICE,
 			       UVERBS_METHOD_QUERY_GID_ENTRY, 4);
@@ -386,12 +395,27 @@ int _ibv_query_gid_ex(struct ibv_context *context, ui=
nt32_t port_num,
 			return EOPNOTSUPP;
=20
 		ret =3D query_sysfs_gid_entry(context, port_num, gid_index,
-					    entry);
+					    entry, fallback_attr_mask);
 		if (ret)
 			return ret;
=20
-		return is_zero_gid(&entry->gid) ? ENODATA : 0;
+		if (fallback_attr_mask & VERBS_QUERY_GID_ATTR_GID &&
+		    is_zero_gid(&entry->gid))
+			return ENODATA;
+
+		return 0;
 	default:
 		return ret;
 	}
 }
+
+int _ibv_query_gid_ex(struct ibv_context *context, uint32_t port_num,
+		      uint32_t gid_index, struct ibv_gid_entry *entry,
+		      uint32_t flags, size_t entry_size)
+{
+	return __ibv_query_gid_ex(context, port_num, gid_index, entry,
+				  flags, entry_size,
+				  VERBS_QUERY_GID_ATTR_GID |
+				  VERBS_QUERY_GID_ATTR_TYPE |
+				  VERBS_QUERY_GID_ATTR_NDEV_IFINDEX);
+}
diff --git a/libibverbs/driver.h b/libibverbs/driver.h
index 046c07d..479e16e 100644
--- a/libibverbs/driver.h
+++ b/libibverbs/driver.h
@@ -77,6 +77,12 @@ enum ibv_gid_type_sysfs {
 	IBV_GID_TYPE_SYSFS_ROCE_V2,
 };
=20
+enum verbs_query_gid_attr_mask {
+	VERBS_QUERY_GID_ATTR_GID		=3D 1 << 0,
+	VERBS_QUERY_GID_ATTR_TYPE		=3D 1 << 1,
+	VERBS_QUERY_GID_ATTR_NDEV_IFINDEX	=3D 1 << 2,
+};
+
 enum ibv_mr_type {
 	IBV_MR_TYPE_MR,
 	IBV_MR_TYPE_NULL_MR,
@@ -633,6 +639,11 @@ int ibv_cmd_reg_dm_mr(struct ibv_pd *pd, struct verbs_=
dm *dm,
 		      unsigned int access, struct verbs_mr *vmr,
 		      struct ibv_command_buffer *link);
=20
+int __ibv_query_gid_ex(struct ibv_context *context, uint32_t port_num,
+			    uint32_t gid_index, struct ibv_gid_entry *entry,
+			    uint32_t flags, size_t entry_size,
+			    uint32_t fallback_attr_mask);
+
 /*
  * sysfs helper functions
  */
diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
index 99a48d5..e50ad94 100644
--- a/libibverbs/verbs.c
+++ b/libibverbs/verbs.c
@@ -224,8 +224,8 @@ LATEST_SYMVER_FUNC(ibv_query_gid, 1_1, "IBVERBS_1.1",
 	struct ibv_gid_entry entry =3D {};
 	int ret;
=20
-	ret =3D _ibv_query_gid_ex(context, port_num, index, &entry, 0,
-				sizeof(entry));
+	ret =3D __ibv_query_gid_ex(context, port_num, index, &entry, 0,
+				 sizeof(entry), VERBS_QUERY_GID_ATTR_GID);
 	/* Preserve API behavior for empty GID */
 	if (ret =3D=3D ENODATA) {
 		memset(gid, 0, sizeof(*gid));
@@ -703,8 +703,8 @@ int ibv_query_gid_type(struct ibv_context *context, uin=
t8_t port_num,
 	struct ibv_gid_entry entry =3D {};
 	int ret;
=20
-	ret =3D _ibv_query_gid_ex(context, port_num, index, &entry, 0,
-				sizeof(entry));
+	ret =3D __ibv_query_gid_ex(context, port_num, index, &entry, 0,
+				 sizeof(entry), VERBS_QUERY_GID_ATTR_TYPE);
 	/* Preserve API behavior for empty GID */
 	if (ret =3D=3D ENODATA) {
 		*type =3D IBV_GID_TYPE_SYSFS_IB_ROCE_V1;
--=20
1.8.3.1

