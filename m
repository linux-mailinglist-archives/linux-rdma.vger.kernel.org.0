Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A8E2684FD
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Sep 2020 08:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbgINGgF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Sep 2020 02:36:05 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6861 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgINGgE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Sep 2020 02:36:04 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5f0f250006>; Sun, 13 Sep 2020 23:35:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 13 Sep 2020 23:36:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 13 Sep 2020 23:36:04 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Sep
 2020 06:36:04 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 14 Sep 2020 06:36:04 +0000
Received: from mtl-vdi-864.wap.labs.mlnx. (Not Verified[10.228.136.155]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f5f0f520002>; Sun, 13 Sep 2020 23:36:03 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <avihaih@nvidia.com>
Subject: [PATCH rdma-core 4/8] verbs: Implement ibv_query_gid and ibv_query_gid_type over ioctl
Date:   Mon, 14 Sep 2020 09:34:59 +0300
Message-ID: <20200914063503.192997-5-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200914063503.192997-1-yishaih@nvidia.com>
References: <20200914063503.192997-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600065317; bh=EcLXT3/dReq8v/S0bDJTuLY1VHBie4T8YOwO9q22UWA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
         Content-Type;
        b=KOQi5I/vyQCBkvgDLSnhyW62LbWp2gCYLey9824ID/Rygj/2G4i5FFPeWtaPKzbLI
         zRpA4monCDmP6Wa7PzhrnwdIz24KXR2Z1JfjLIXemJZpiSKaG9oeKJ5yvQWben3LxK
         vRAtN3cBcVkZwdD76qPWotvhMwzgRDfTXq2/vnhoFGZKv1cNMUVorPcf8UykVI5+Tt
         Uedt6ulQQNkQh/E6EMRpGL2ZUx5oKhJXO9aodjQwm/toFq2COffm9qRrUL/jLL4uEQ
         JfYdUwYds2aESClLn6VYGaJjrBvsBTZYaKHPzOdnXQArl5D9PlUHQ8SN1j5YoFmBF6
         sSJz2pWipv0fQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Avihai Horon <avihaih@nvidia.com>

Currently ibv_query_gid and ibv_query_gid_type are implemented over
sysfs. In order to improve their performance we implement them using the
new query GID entry API, so now they will use ioctl and fallback to
sysfs.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 libibverbs/cmd_device.c |  4 ++--
 libibverbs/driver.h     |  6 +++++
 libibverbs/verbs.c      | 58 ++++++++++++++++++++++++++++++++++++++++++++-=
----
 3 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/libibverbs/cmd_device.c b/libibverbs/cmd_device.c
index 06e6c5a..fb166bb 100644
--- a/libibverbs/cmd_device.c
+++ b/libibverbs/cmd_device.c
@@ -240,11 +240,11 @@ static int query_sysfs_gid_entry(struct ibv_context *=
context, uint32_t port_num,
=20
 	entry->gid_index =3D gid_index;
 	entry->port_num =3D port_num;
-	ret =3D ibv_query_gid(context, port_num, gid_index, &entry->gid);
+	ret =3D _ibv_query_gid(context, port_num, gid_index, &entry->gid);
 	if (ret)
 		return EINVAL;
=20
-	ret =3D ibv_query_gid_type(context, port_num, gid_index, &gid_type);
+	ret =3D _ibv_query_gid_type(context, port_num, gid_index, &gid_type);
 	if (ret)
 		return EINVAL;
=20
diff --git a/libibverbs/driver.h b/libibverbs/driver.h
index 13b5219..2ab0a89 100644
--- a/libibverbs/driver.h
+++ b/libibverbs/driver.h
@@ -659,6 +659,12 @@ static inline bool check_comp_mask(uint64_t input, uin=
t64_t supported)
 int ibv_query_gid_type(struct ibv_context *context, uint8_t port_num,
 		       unsigned int index, enum ibv_gid_type_sysfs *type);
=20
+int _ibv_query_gid_type(struct ibv_context *context, uint8_t port_num,
+			unsigned int index, enum ibv_gid_type_sysfs *type);
+
+int _ibv_query_gid(struct ibv_context *context, uint8_t port_num, int inde=
x,
+		   union ibv_gid *gid);
+
 static inline int
 ibv_check_alloc_parent_domain(struct ibv_parent_domain_init_attr *attr)
 {
diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
index 9427aba..9dec4e6 100644
--- a/libibverbs/verbs.c
+++ b/libibverbs/verbs.c
@@ -216,10 +216,8 @@ LATEST_SYMVER_FUNC(ibv_query_port, 1_1, "IBVERBS_1.1",
 				sizeof(*port_attr));
 }
=20
-LATEST_SYMVER_FUNC(ibv_query_gid, 1_1, "IBVERBS_1.1",
-		   int,
-		   struct ibv_context *context, uint8_t port_num,
-		   int index, union ibv_gid *gid)
+int _ibv_query_gid(struct ibv_context *context, uint8_t port_num, int inde=
x,
+		   union ibv_gid *gid)
 {
 	struct verbs_device *verbs_device =3D verbs_get_device(context->device);
 	char attr[41];
@@ -240,6 +238,29 @@ LATEST_SYMVER_FUNC(ibv_query_gid, 1_1, "IBVERBS_1.1",
 	return 0;
 }
=20
+LATEST_SYMVER_FUNC(ibv_query_gid, 1_1, "IBVERBS_1.1",
+		   int,
+		   struct ibv_context *context, uint8_t port_num,
+		   int index, union ibv_gid *gid)
+{
+	struct ibv_gid_entry entry =3D {};
+	int ret;
+
+	ret =3D ibv_cmd_query_gid_entry(context, port_num, index, &entry, 0,
+				      sizeof(entry));
+	/* Preserve API behavior for empty GID */
+	if (ret =3D=3D ENODATA) {
+		memset(gid, 0, sizeof(*gid));
+		return 0;
+	}
+	if (ret)
+		return -1;
+
+	memcpy(gid, &entry.gid, sizeof(entry.gid));
+
+	return 0;
+}
+
 int _ibv_query_gid_ex(struct ibv_context *context, uint32_t port_num,
 		      uint32_t gid_index, struct ibv_gid_entry *entry,
 		      uint32_t flags, size_t entry_size)
@@ -711,8 +732,8 @@ LATEST_SYMVER_FUNC(ibv_create_ah, 1_1, "IBVERBS_1.1",
  */
 #define V1_TYPE "IB/RoCE v1"
 #define V2_TYPE "RoCE v2"
-int ibv_query_gid_type(struct ibv_context *context, uint8_t port_num,
-		       unsigned int index, enum ibv_gid_type_sysfs *type)
+int _ibv_query_gid_type(struct ibv_context *context, uint8_t port_num,
+			unsigned int index, enum ibv_gid_type_sysfs *type)
 {
 	struct verbs_device *verbs_device =3D verbs_get_device(context->device);
 	char buff[11];
@@ -768,6 +789,31 @@ int ibv_query_gid_type(struct ibv_context *context, ui=
nt8_t port_num,
 	return 0;
 }
=20
+int ibv_query_gid_type(struct ibv_context *context, uint8_t port_num,
+		       unsigned int index, enum ibv_gid_type_sysfs *type)
+{
+	struct ibv_gid_entry entry =3D {};
+	int ret;
+
+	ret =3D ibv_cmd_query_gid_entry(context, port_num, index, &entry, 0,
+				      sizeof(entry));
+	/* Preserve API behavior for empty GID */
+	if (ret =3D=3D ENODATA) {
+		*type =3D IBV_GID_TYPE_SYSFS_IB_ROCE_V1;
+		return 0;
+	}
+	if (ret)
+		return -1;
+
+	if (entry.gid_type =3D=3D IBV_GID_TYPE_IB ||
+	    entry.gid_type =3D=3D IBV_GID_TYPE_ROCE_V1)
+		*type =3D IBV_GID_TYPE_SYSFS_IB_ROCE_V1;
+	else
+		*type =3D IBV_GID_TYPE_SYSFS_ROCE_V2;
+
+	return 0;
+}
+
 static int ibv_find_gid_index(struct ibv_context *context, uint8_t port_nu=
m,
 			      union ibv_gid *gid,
 			      enum ibv_gid_type_sysfs gid_type)
--=20
1.8.3.1

