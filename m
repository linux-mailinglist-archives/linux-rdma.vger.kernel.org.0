Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4186B27564D
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Sep 2020 12:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgIWK1W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Sep 2020 06:27:22 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5315 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIWK1W (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Sep 2020 06:27:22 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6b22ab0001>; Wed, 23 Sep 2020 03:25:47 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 23 Sep
 2020 10:27:21 +0000
Received: from dev-l-vrt-092.mtl.labs.mlnx (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 23 Sep 2020 10:27:19 +0000
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <avihaih@nvidia.com>
Subject: [PATCH V1 rdma-core 4/8] verbs: Implement ibv_query_gid and ibv_query_gid_type over ioctl
Date:   Wed, 23 Sep 2020 13:26:58 +0300
Message-ID: <20200923102702.590008-5-yishaih@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200923102702.590008-1-yishaih@nvidia.com>
References: <20200923102702.590008-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600856747; bh=XoN0rGrnqW2rx1uPx47ThQh34P4/ie4LKX1Ya78NsB8=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        b=rZ6Yqg4J9HmeCyIcuzm2S8DF3kBBYVEN5qJNRMTb0aOHMxsDHnm3jhJ9jaIzquZj5
         Rzmv5nDt8s213A+0wRkQfQn45zG+eCsi8tlkaqk0nQfUCqfOOij9VkPqWZo+Ej3XML
         iTvtDfevZQ6UiGjR6G2UTOnXY9pffarF0lxjuoS2wVc0IhtBkjad/ERCdvKtWIuKFD
         1z8n7fUZ3Lsu1mGvvxplMOCzZm5yhHCgEOBya/wKs2c527eDf6s0k4dsInods/w/nx
         839KWcfBY2ZAzlbQ9zpInx4Rnj/M+2h0RArOWILt+tME8I5wGK+ywhU0DMS00FaPRB
         qG6DEtQHE8lPA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Avihai Horon <avihaih@nvidia.com>

Currently ibv_query_gid and ibv_query_gid_type are implemented over
sysfs. In order to improve their performance we implement them using
the new query GID entry API, so now they will use ioctl and fallback
to sysfs.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 libibverbs/cmd_device.c | 92 +++++++++++++++++++++++++++++++++++++++++++++=
++--
 libibverbs/verbs.c      | 92 +++++++++++++++------------------------------=
----
 2 files changed, 117 insertions(+), 67 deletions(-)

diff --git a/libibverbs/cmd_device.c b/libibverbs/cmd_device.c
index 8643cc6..f707273 100644
--- a/libibverbs/cmd_device.c
+++ b/libibverbs/cmd_device.c
@@ -30,6 +30,10 @@
  * SOFTWARE.
  */
=20
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <dirent.h>
 #include <infiniband/cmd_write.h>
=20
 #include <net/if.h>
@@ -230,6 +234,90 @@ static int query_sysfs_gid_ndev_ifindex(struct ibv_con=
text *context,
 	return *ndev_ifindex ? 0 : errno;
 }
=20
+static int query_sysfs_gid(struct ibv_context *context, uint8_t port_num, =
int index,
+			   union ibv_gid *gid)
+{
+	struct verbs_device *verbs_device =3D verbs_get_device(context->device);
+	char attr[41];
+	uint16_t val;
+	int i;
+
+	if (ibv_read_ibdev_sysfs_file(attr, sizeof(attr), verbs_device->sysfs,
+				      "ports/%d/gids/%d", port_num, index) < 0)
+		return -1;
+
+	for (i =3D 0; i < 8; ++i) {
+		if (sscanf(attr + i * 5, "%hx", &val) !=3D 1)
+			return -1;
+		gid->raw[i * 2] =3D val >> 8;
+		gid->raw[i * 2 + 1] =3D val & 0xff;
+	}
+
+	return 0;
+}
+
+/* GID types as appear in sysfs, no change is expected as of ABI
+ * compatibility.
+ */
+#define V1_TYPE "IB/RoCE v1"
+#define V2_TYPE "RoCE v2"
+static int query_sysfs_gid_type(struct ibv_context *context, uint8_t port_=
num,
+				unsigned int index, enum ibv_gid_type_sysfs *type)
+{
+	struct verbs_device *verbs_device =3D verbs_get_device(context->device);
+	char buff[11];
+
+	/* Reset errno so that we can rely on its value upon any error flow in
+	 * ibv_read_sysfs_file.
+	 */
+	errno =3D 0;
+	if (ibv_read_ibdev_sysfs_file(buff, sizeof(buff), verbs_device->sysfs,
+				      "ports/%d/gid_attrs/types/%d", port_num,
+				      index) <=3D 0) {
+		char *dir_path;
+		DIR *dir;
+
+		if (errno =3D=3D EINVAL) {
+			/* In IB, this file doesn't exist and the kernel sets
+			 * errno to -EINVAL.
+			 */
+			*type =3D IBV_GID_TYPE_SYSFS_IB_ROCE_V1;
+			return 0;
+		}
+		if (asprintf(&dir_path, "%s/%s/%d/%s/",
+			     verbs_device->sysfs->ibdev_path, "ports", port_num,
+			     "gid_attrs") < 0)
+			return -1;
+		dir =3D opendir(dir_path);
+		free(dir_path);
+		if (!dir) {
+			if (errno =3D=3D ENOENT)
+				/* Assuming that if gid_attrs doesn't exist,
+				 * we have an old kernel and all GIDs are
+				 * IB/RoCE v1
+				 */
+				*type =3D IBV_GID_TYPE_SYSFS_IB_ROCE_V1;
+			else
+				return -1;
+		} else {
+			closedir(dir);
+			errno =3D EFAULT;
+			return -1;
+		}
+	} else {
+		if (!strcmp(buff, V1_TYPE)) {
+			*type =3D IBV_GID_TYPE_SYSFS_IB_ROCE_V1;
+		} else if (!strcmp(buff, V2_TYPE)) {
+			*type =3D IBV_GID_TYPE_SYSFS_ROCE_V2;
+		} else {
+			errno =3D ENOTSUP;
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
 static int query_sysfs_gid_entry(struct ibv_context *context, uint32_t por=
t_num,
 				 uint32_t gid_index,
 				 struct ibv_gid_entry *entry)
@@ -240,11 +328,11 @@ static int query_sysfs_gid_entry(struct ibv_context *=
context, uint32_t port_num,
=20
 	entry->gid_index =3D gid_index;
 	entry->port_num =3D port_num;
-	ret =3D ibv_query_gid(context, port_num, gid_index, &entry->gid);
+	ret =3D query_sysfs_gid(context, port_num, gid_index, &entry->gid);
 	if (ret)
 		return EINVAL;
=20
-	ret =3D ibv_query_gid_type(context, port_num, gid_index, &gid_type);
+	ret =3D query_sysfs_gid_type(context, port_num, gid_index, &gid_type);
 	if (ret)
 		return EINVAL;
=20
diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
index 9507ffd..99a48d5 100644
--- a/libibverbs/verbs.c
+++ b/libibverbs/verbs.c
@@ -221,21 +221,20 @@ LATEST_SYMVER_FUNC(ibv_query_gid, 1_1, "IBVERBS_1.1",
 		   struct ibv_context *context, uint8_t port_num,
 		   int index, union ibv_gid *gid)
 {
-	struct verbs_device *verbs_device =3D verbs_get_device(context->device);
-	char attr[41];
-	uint16_t val;
-	int i;
+	struct ibv_gid_entry entry =3D {};
+	int ret;
=20
-	if (ibv_read_ibdev_sysfs_file(attr, sizeof(attr), verbs_device->sysfs,
-				      "ports/%d/gids/%d", port_num, index) < 0)
+	ret =3D _ibv_query_gid_ex(context, port_num, index, &entry, 0,
+				sizeof(entry));
+	/* Preserve API behavior for empty GID */
+	if (ret =3D=3D ENODATA) {
+		memset(gid, 0, sizeof(*gid));
+		return 0;
+	}
+	if (ret)
 		return -1;
=20
-	for (i =3D 0; i < 8; ++i) {
-		if (sscanf(attr + i * 5, "%hx", &val) !=3D 1)
-			return -1;
-		gid->raw[i * 2    ] =3D val >> 8;
-		gid->raw[i * 2 + 1] =3D val & 0xff;
-	}
+	memcpy(gid, &entry.gid, sizeof(entry.gid));
=20
 	return 0;
 }
@@ -698,64 +697,27 @@ LATEST_SYMVER_FUNC(ibv_create_ah, 1_1, "IBVERBS_1.1",
 	return ah;
 }
=20
-/* GID types as appear in sysfs, no change is expected as of ABI
- * compatibility.
- */
-#define V1_TYPE "IB/RoCE v1"
-#define V2_TYPE "RoCE v2"
 int ibv_query_gid_type(struct ibv_context *context, uint8_t port_num,
 		       unsigned int index, enum ibv_gid_type_sysfs *type)
 {
-	struct verbs_device *verbs_device =3D verbs_get_device(context->device);
-	char buff[11];
+	struct ibv_gid_entry entry =3D {};
+	int ret;
=20
-	/* Reset errno so that we can rely on its value upon any error flow in
-	 * ibv_read_sysfs_file.
-	 */
-	errno =3D 0;
-	if (ibv_read_ibdev_sysfs_file(buff, sizeof(buff), verbs_device->sysfs,
-				      "ports/%d/gid_attrs/types/%d", port_num,
-				      index) <=3D 0) {
-		char *dir_path;
-		DIR *dir;
-
-		if (errno =3D=3D EINVAL) {
-			/* In IB, this file doesn't exist and the kernel sets
-			 * errno to -EINVAL.
-			 */
-			*type =3D IBV_GID_TYPE_SYSFS_IB_ROCE_V1;
-			return 0;
-		}
-		if (asprintf(&dir_path, "%s/%s/%d/%s/",
-			     verbs_device->sysfs->ibdev_path, "ports", port_num,
-			     "gid_attrs") < 0)
-			return -1;
-		dir =3D opendir(dir_path);
-		free(dir_path);
-		if (!dir) {
-			if (errno =3D=3D ENOENT)
-				/* Assuming that if gid_attrs doesn't exist,
-				 * we have an old kernel and all GIDs are
-				 * IB/RoCE v1
-				 */
-				*type =3D IBV_GID_TYPE_SYSFS_IB_ROCE_V1;
-			else
-				return -1;
-		} else {
-			closedir(dir);
-			errno =3D EFAULT;
-			return -1;
-		}
-	} else {
-		if (!strcmp(buff, V1_TYPE)) {
-			*type =3D IBV_GID_TYPE_SYSFS_IB_ROCE_V1;
-		} else if (!strcmp(buff, V2_TYPE)) {
-			*type =3D IBV_GID_TYPE_SYSFS_ROCE_V2;
-		} else {
-			errno =3D ENOTSUP;
-			return -1;
-		}
+	ret =3D _ibv_query_gid_ex(context, port_num, index, &entry, 0,
+				sizeof(entry));
+	/* Preserve API behavior for empty GID */
+	if (ret =3D=3D ENODATA) {
+		*type =3D IBV_GID_TYPE_SYSFS_IB_ROCE_V1;
+		return 0;
 	}
+	if (ret)
+		return -1;
+
+	if (entry.gid_type =3D=3D IBV_GID_TYPE_IB ||
+	    entry.gid_type =3D=3D IBV_GID_TYPE_ROCE_V1)
+		*type =3D IBV_GID_TYPE_SYSFS_IB_ROCE_V1;
+	else
+		*type =3D IBV_GID_TYPE_SYSFS_ROCE_V2;
=20
 	return 0;
 }
--=20
1.8.3.1

