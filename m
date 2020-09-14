Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0AF2684FE
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Sep 2020 08:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgINGgK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Sep 2020 02:36:10 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15406 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgINGgH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Sep 2020 02:36:07 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5f0f490002>; Sun, 13 Sep 2020 23:35:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 13 Sep 2020 23:36:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 13 Sep 2020 23:36:06 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Sep
 2020 06:36:06 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 14 Sep 2020 06:36:06 +0000
Received: from mtl-vdi-864.wap.labs.mlnx. (Not Verified[10.228.136.155]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f5f0f540001>; Sun, 13 Sep 2020 23:36:05 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <avihaih@nvidia.com>
Subject: [PATCH rdma-core 5/8] verbs: Optimize ibv_query_gid and ibv_query_gid_type
Date:   Mon, 14 Sep 2020 09:35:00 +0300
Message-ID: <20200914063503.192997-6-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200914063503.192997-1-yishaih@nvidia.com>
References: <20200914063503.192997-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600065353; bh=Gx2K2nLnNkeKLK/HsOVBb23G0jzmcgUw5O4XEwiBsVo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
         Content-Type;
        b=UPvVLbxff2SmUo1hElPvY3/jGzYHXBaVm6yQalzIpNEzj4Z/BWbai7dHNqkDeCN7u
         Vv/ExLG9JsLsEphJX5d0rTOQdtL81DHn0noxGoLDSv98Tm5OFLp2uiGLSBmZK859Eb
         Ao8DSIxVqr9rwvTv0gJEG7B9dZESeXDugjLi7q7DFUkKCZwfPyd5kuCddqoDCE0RBd
         /9f0jQi2O2UhRsSHOWc9whJbCq4sd788EXgmGQgZuEBFGQy7y/8ikPUwgVzIQNUFXe
         8qiY9fwiG3Wzk/AyS9VX6iL2DNVk1NFYifPDcIoFK4Ptla8/UjsLBUAvGH2Zjica0N
         mVY7kYvAA1uLw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Avihai Horon <avihaih@nvidia.com>

ibv_query_gid and ibv_query_gid_type are implemented as ioctl first and
fallback to sysfs. Currently, if the fallback path is taken, all of the
gid entry attributes are retrieved over sysfs.

For example, if ibv_query_gid is called and the fallback path is taken,
the gid type and the gid ndev ifindex will also be read over sysfs, even
though we only need the gid.

In order to eliminate these unnecessary sysfs reads, we add an attribute
mask to ibv_cmd_query_gid_entry that will allow us to mark the specific
gid entry attributes that we would like to query in fallback.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 libibverbs/cmd_device.c | 65 +++++++++++++++++++++++++++++----------------=
----
 libibverbs/driver.h     |  9 ++++++-
 libibverbs/verbs.c      | 10 +++++---
 3 files changed, 53 insertions(+), 31 deletions(-)

diff --git a/libibverbs/cmd_device.c b/libibverbs/cmd_device.c
index fb166bb..9aa9dff 100644
--- a/libibverbs/cmd_device.c
+++ b/libibverbs/cmd_device.c
@@ -232,41 +232,49 @@ static int query_sysfs_gid_ndev_ifindex(struct ibv_co=
ntext *context,
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
-	ret =3D _ibv_query_gid(context, port_num, gid_index, &entry->gid);
-	if (ret)
-		return EINVAL;
-
-	ret =3D _ibv_query_gid_type(context, port_num, gid_index, &gid_type);
-	if (ret)
-		return EINVAL;
-
-	if (gid_type =3D=3D IBV_GID_TYPE_SYSFS_IB_ROCE_V1) {
-		ret =3D ibv_query_port(context, port_num, &port_attr);
+	if (attr_mask & VERBS_QUERY_GID_ATTR_GID) {
+		ret =3D _ibv_query_gid(context, port_num, gid_index, &entry->gid);
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
+		ret =3D _ibv_query_gid_type(context, port_num, gid_index,
+					  &gid_type);
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
@@ -278,7 +286,8 @@ out:
 #define query_gid_kernel_cap async_event
 int ibv_cmd_query_gid_entry(struct ibv_context *context, uint32_t port_num=
,
 			    uint32_t gid_index, struct ibv_gid_entry *entry,
-			    uint32_t flags, size_t entry_size)
+			    uint32_t flags, size_t entry_size,
+			    uint32_t fallback_attr_mask)
 {
 	DECLARE_COMMAND_BUFFER(cmdb, UVERBS_OBJECT_DEVICE,
 			       UVERBS_METHOD_QUERY_GID_ENTRY, 4);
@@ -298,11 +307,15 @@ int ibv_cmd_query_gid_entry(struct ibv_context *conte=
xt, uint32_t port_num,
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
diff --git a/libibverbs/driver.h b/libibverbs/driver.h
index 2ab0a89..c998b5b 100644
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
@@ -635,7 +641,8 @@ int ibv_cmd_reg_dm_mr(struct ibv_pd *pd, struct verbs_d=
m *dm,
=20
 int ibv_cmd_query_gid_entry(struct ibv_context *context, uint32_t port_num=
,
 			    uint32_t gid_index, struct ibv_gid_entry *entry,
-			    uint32_t flags, size_t entry_size);
+			    uint32_t flags, size_t entry_size,
+			    uint32_t fallback_attr_mask);
=20
 /*
  * sysfs helper functions
diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
index 9dec4e6..237c56b 100644
--- a/libibverbs/verbs.c
+++ b/libibverbs/verbs.c
@@ -247,7 +247,7 @@ LATEST_SYMVER_FUNC(ibv_query_gid, 1_1, "IBVERBS_1.1",
 	int ret;
=20
 	ret =3D ibv_cmd_query_gid_entry(context, port_num, index, &entry, 0,
-				      sizeof(entry));
+				      sizeof(entry), VERBS_QUERY_GID_ATTR_GID);
 	/* Preserve API behavior for empty GID */
 	if (ret =3D=3D ENODATA) {
 		memset(gid, 0, sizeof(*gid));
@@ -265,8 +265,10 @@ int _ibv_query_gid_ex(struct ibv_context *context, uin=
t32_t port_num,
 		      uint32_t gid_index, struct ibv_gid_entry *entry,
 		      uint32_t flags, size_t entry_size)
 {
-	return ibv_cmd_query_gid_entry(context, port_num, gid_index, entry,
-				       flags, entry_size);
+	return ibv_cmd_query_gid_entry(
+		context, port_num, gid_index, entry, flags, entry_size,
+		VERBS_QUERY_GID_ATTR_GID | VERBS_QUERY_GID_ATTR_TYPE |
+			VERBS_QUERY_GID_ATTR_NDEV_IFINDEX);
 }
=20
 LATEST_SYMVER_FUNC(ibv_query_pkey, 1_1, "IBVERBS_1.1",
@@ -796,7 +798,7 @@ int ibv_query_gid_type(struct ibv_context *context, uin=
t8_t port_num,
 	int ret;
=20
 	ret =3D ibv_cmd_query_gid_entry(context, port_num, index, &entry, 0,
-				      sizeof(entry));
+				      sizeof(entry), VERBS_QUERY_GID_ATTR_TYPE);
 	/* Preserve API behavior for empty GID */
 	if (ret =3D=3D ENODATA) {
 		*type =3D IBV_GID_TYPE_SYSFS_IB_ROCE_V1;
--=20
1.8.3.1

