Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699A82684FA
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Sep 2020 08:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgINGgE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Sep 2020 02:36:04 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15391 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgINGgC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Sep 2020 02:36:02 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5f0f430003>; Sun, 13 Sep 2020 23:35:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 13 Sep 2020 23:36:00 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 13 Sep 2020 23:36:00 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Sep
 2020 06:36:00 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 14 Sep 2020 06:36:00 +0000
Received: from mtl-vdi-864.wap.labs.mlnx. (Not Verified[10.228.136.155]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f5f0f4e0001>; Sun, 13 Sep 2020 23:35:59 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <avihaih@nvidia.com>
Subject: [PATCH rdma-core 2/8] verbs: Change the name of enum ibv_gid_type
Date:   Mon, 14 Sep 2020 09:34:57 +0300
Message-ID: <20200914063503.192997-3-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200914063503.192997-1-yishaih@nvidia.com>
References: <20200914063503.192997-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600065347; bh=aW3Y5fXb6NAIX+eQNkb/lgVBBrt2kZ9HspHdqnFEBVE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
         Content-Type;
        b=Tu0eoV3zr7D1vC6Yd3zW7hNxENt49QBv6xcTii83BVQIm8x1FznnQt/Z6CeoIi6FA
         0M4JofLfQyHq4y7fZhZ5uPBCJ7neHEZE/tjAoCVdt53OixAgcnOihkn1i4cqZkwpOI
         LioXaV0xg7pLDSqMdzqDku2CSD7o9rPdDAJNRJ4aToI9+0lKUqcRDT8wR5TfbmWP0r
         oe7FzgunUCum6db3RbsAgfrrf4KPzKKkOPFRO6NlaaGoyBc4kUy/IqSNmxfD97yrnb
         YY8vTMDUNZjrpWcff9KEc+LbClz8nTn8ncXiRuNsOUtXE35II0jTbXW4IKuy9Uz7N7
         J/ssfhPTbah3w==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Avihai Horon <avihaih@nvidia.com>

Change the name of enum ibv_gid_type in order to introduce a new enum
ibv_gid_type in verbs.h in the next commits, which will provide a more
accurate gid type info by separating IB and RoCEv1 types.

This is a preliminary step before introducing a new query GID API.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 libibverbs/driver.h           |  8 ++++----
 libibverbs/examples/devinfo.c | 14 +++++++-------
 libibverbs/verbs.c            | 21 +++++++++++----------
 providers/mlx5/verbs.c        |  2 +-
 pyverbs/device.pyx            |  2 +-
 pyverbs/libibverbs.pxd        |  2 +-
 pyverbs/libibverbs_enums.pxd  |  6 +++---
 tests/base.py                 |  3 ++-
 8 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/libibverbs/driver.h b/libibverbs/driver.h
index 4436363..046c07d 100644
--- a/libibverbs/driver.h
+++ b/libibverbs/driver.h
@@ -72,9 +72,9 @@ enum verbs_qp_mask {
 	VERBS_QP_EX		=3D 1 << 1,
 };
=20
-enum ibv_gid_type {
-	IBV_GID_TYPE_IB_ROCE_V1,
-	IBV_GID_TYPE_ROCE_V2,
+enum ibv_gid_type_sysfs {
+	IBV_GID_TYPE_SYSFS_IB_ROCE_V1,
+	IBV_GID_TYPE_SYSFS_ROCE_V2,
 };
=20
 enum ibv_mr_type {
@@ -653,7 +653,7 @@ static inline bool check_comp_mask(uint64_t input, uint=
64_t supported)
 }
=20
 int ibv_query_gid_type(struct ibv_context *context, uint8_t port_num,
-		       unsigned int index, enum ibv_gid_type *type);
+		       unsigned int index, enum ibv_gid_type_sysfs *type);
=20
 static inline int
 ibv_check_alloc_parent_domain(struct ibv_parent_domain_init_attr *attr)
diff --git a/libibverbs/examples/devinfo.c b/libibverbs/examples/devinfo.c
index 00ed3f9..c245217 100644
--- a/libibverbs/examples/devinfo.c
+++ b/libibverbs/examples/devinfo.c
@@ -164,17 +164,17 @@ static const char *vl_str(uint8_t vl_num)
 }
=20
 #define DEVINFO_INVALID_GID_TYPE	2
-static const char *gid_type_str(enum ibv_gid_type type)
+static const char *gid_type_str(enum ibv_gid_type_sysfs type)
 {
 	switch (type) {
-	case IBV_GID_TYPE_IB_ROCE_V1: return "RoCE v1";
-	case IBV_GID_TYPE_ROCE_V2: return "RoCE v2";
+	case IBV_GID_TYPE_SYSFS_IB_ROCE_V1: return "RoCE v1";
+	case IBV_GID_TYPE_SYSFS_ROCE_V2: return "RoCE v2";
 	default: return "Invalid gid type";
 	}
 }
=20
 static void print_formated_gid(union ibv_gid *gid, int i,
-			       enum ibv_gid_type type, int ll)
+			       enum ibv_gid_type_sysfs type, int ll)
 {
 	char gid_str[INET6_ADDRSTRLEN] =3D {};
 	char str[20] =3D {};
@@ -182,7 +182,7 @@ static void print_formated_gid(union ibv_gid *gid, int =
i,
 	if (ll =3D=3D IBV_LINK_LAYER_ETHERNET)
 		sprintf(str, ", %s", gid_type_str(type));
=20
-	if (type =3D=3D IBV_GID_TYPE_IB_ROCE_V1)
+	if (type =3D=3D IBV_GID_TYPE_SYSFS_IB_ROCE_V1)
 		printf("\t\t\tGID[%3d]:\t\t%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:=
%02x%02x:%02x%02x:%02x%02x%s\n",
 		       i, gid->raw[0], gid->raw[1], gid->raw[2],
 		       gid->raw[3], gid->raw[4], gid->raw[5], gid->raw[6],
@@ -190,7 +190,7 @@ static void print_formated_gid(union ibv_gid *gid, int =
i,
 		       gid->raw[11], gid->raw[12], gid->raw[13], gid->raw[14],
 		       gid->raw[15], str);
=20
-	if (type =3D=3D IBV_GID_TYPE_ROCE_V2) {
+	if (type =3D=3D IBV_GID_TYPE_SYSFS_ROCE_V2) {
 		inet_ntop(AF_INET6, gid->raw, gid_str, sizeof(gid_str));
 		printf("\t\t\tGID[%3d]:\t\t%s%s\n", i, gid_str, str);
 	}
@@ -200,7 +200,7 @@ static int print_all_port_gids(struct ibv_context *ctx,
 			       struct ibv_port_attr *port_attr,
 			       uint8_t port_num)
 {
-	enum ibv_gid_type type;
+	enum ibv_gid_type_sysfs type;
 	union ibv_gid gid;
 	int tbl_len;
 	int rc =3D 0;
diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
index b54e2b8..9507ffd 100644
--- a/libibverbs/verbs.c
+++ b/libibverbs/verbs.c
@@ -704,7 +704,7 @@ LATEST_SYMVER_FUNC(ibv_create_ah, 1_1, "IBVERBS_1.1",
 #define V1_TYPE "IB/RoCE v1"
 #define V2_TYPE "RoCE v2"
 int ibv_query_gid_type(struct ibv_context *context, uint8_t port_num,
-		       unsigned int index, enum ibv_gid_type *type)
+		       unsigned int index, enum ibv_gid_type_sysfs *type)
 {
 	struct verbs_device *verbs_device =3D verbs_get_device(context->device);
 	char buff[11];
@@ -723,7 +723,7 @@ int ibv_query_gid_type(struct ibv_context *context, uin=
t8_t port_num,
 			/* In IB, this file doesn't exist and the kernel sets
 			 * errno to -EINVAL.
 			 */
-			*type =3D IBV_GID_TYPE_IB_ROCE_V1;
+			*type =3D IBV_GID_TYPE_SYSFS_IB_ROCE_V1;
 			return 0;
 		}
 		if (asprintf(&dir_path, "%s/%s/%d/%s/",
@@ -738,7 +738,7 @@ int ibv_query_gid_type(struct ibv_context *context, uin=
t8_t port_num,
 				 * we have an old kernel and all GIDs are
 				 * IB/RoCE v1
 				 */
-				*type =3D IBV_GID_TYPE_IB_ROCE_V1;
+				*type =3D IBV_GID_TYPE_SYSFS_IB_ROCE_V1;
 			else
 				return -1;
 		} else {
@@ -748,9 +748,9 @@ int ibv_query_gid_type(struct ibv_context *context, uin=
t8_t port_num,
 		}
 	} else {
 		if (!strcmp(buff, V1_TYPE)) {
-			*type =3D IBV_GID_TYPE_IB_ROCE_V1;
+			*type =3D IBV_GID_TYPE_SYSFS_IB_ROCE_V1;
 		} else if (!strcmp(buff, V2_TYPE)) {
-			*type =3D IBV_GID_TYPE_ROCE_V2;
+			*type =3D IBV_GID_TYPE_SYSFS_ROCE_V2;
 		} else {
 			errno =3D ENOTSUP;
 			return -1;
@@ -761,9 +761,10 @@ int ibv_query_gid_type(struct ibv_context *context, ui=
nt8_t port_num,
 }
=20
 static int ibv_find_gid_index(struct ibv_context *context, uint8_t port_nu=
m,
-			      union ibv_gid *gid, enum ibv_gid_type gid_type)
+			      union ibv_gid *gid,
+			      enum ibv_gid_type_sysfs gid_type)
 {
-	enum ibv_gid_type sgid_type =3D 0;
+	enum ibv_gid_type_sysfs sgid_type =3D 0;
 	union ibv_gid sgid;
 	int i =3D 0, ret;
=20
@@ -863,7 +864,7 @@ static inline int set_ah_attr_by_ipv4(struct ibv_contex=
t *context,
=20
 	map_ipv4_addr_to_ipv6(ip4h->daddr, (struct in6_addr *)&sgid);
 	ret =3D ibv_find_gid_index(context, port_num, &sgid,
-				 IBV_GID_TYPE_ROCE_V2);
+				 IBV_GID_TYPE_SYSFS_ROCE_V2);
 	if (ret < 0)
 		return ret;
=20
@@ -893,9 +894,9 @@ static inline int set_ah_attr_by_ipv6(struct ibv_contex=
t *context,
=20
 	ah_attr->grh.dgid =3D grh->sgid;
 	if (grh->next_hdr =3D=3D IPPROTO_UDP) {
-		sgid_type =3D IBV_GID_TYPE_ROCE_V2;
+		sgid_type =3D IBV_GID_TYPE_SYSFS_ROCE_V2;
 	} else if (grh->next_hdr =3D=3D IB_NEXT_HDR) {
-		sgid_type =3D IBV_GID_TYPE_IB_ROCE_V1;
+		sgid_type =3D IBV_GID_TYPE_SYSFS_IB_ROCE_V1;
 	} else {
 		errno =3D EPROTONOSUPPORT;
 		return -1;
diff --git a/providers/mlx5/verbs.c b/providers/mlx5/verbs.c
index 4650250..917d057 100644
--- a/providers/mlx5/verbs.c
+++ b/providers/mlx5/verbs.c
@@ -2955,7 +2955,7 @@ struct ibv_ah *mlx5_create_ah(struct ibv_pd *pd, stru=
ct ibv_ah_attr *attr)
 				       attr->grh.sgid_index, &gid_type))
 			goto err;
=20
-		if (gid_type =3D=3D IBV_GID_TYPE_ROCE_V2)
+		if (gid_type =3D=3D IBV_GID_TYPE_SYSFS_ROCE_V2)
 			mlx5_ah_set_udp_sport(ah, attr);
=20
 		/* Since RoCE packets must contain GRH, this bit is reserved
diff --git a/pyverbs/device.pyx b/pyverbs/device.pyx
index b75fcd0..c1323cd 100755
--- a/pyverbs/device.pyx
+++ b/pyverbs/device.pyx
@@ -220,7 +220,7 @@ cdef class Context(PyverbsCM):
         return gid
=20
     def query_gid_type(self, unsigned int port_num, unsigned int index):
-        cdef v.ibv_gid_type gid_type
+        cdef v.ibv_gid_type_sysfs gid_type
         rc =3D v.ibv_query_gid_type(self.context, port_num, index, &gid_ty=
pe)
         if rc !=3D 0:
             raise PyverbsRDMAErrno('Failed to query gid type of port {p} a=
nd gid index {g}'
diff --git a/pyverbs/libibverbs.pxd b/pyverbs/libibverbs.pxd
index dda33e7..c84b9fc 100755
--- a/pyverbs/libibverbs.pxd
+++ b/pyverbs/libibverbs.pxd
@@ -617,6 +617,6 @@ cdef extern from 'infiniband/verbs.h':
=20
 cdef extern from 'infiniband/driver.h':
     int ibv_query_gid_type(ibv_context *context, uint8_t port_num,
-                           unsigned int index, ibv_gid_type *type)
+                           unsigned int index, ibv_gid_type_sysfs *type)
     int ibv_set_ece(ibv_qp *qp, ibv_ece *ece)
     int ibv_query_ece(ibv_qp *qp, ibv_ece *ece)
diff --git a/pyverbs/libibverbs_enums.pxd b/pyverbs/libibverbs_enums.pxd
index 7c1a120..83ca516 100755
--- a/pyverbs/libibverbs_enums.pxd
+++ b/pyverbs/libibverbs_enums.pxd
@@ -443,6 +443,6 @@ _IBV_ADVISE_MR_FLAG_FLUSH =3D IBV_ADVISE_MR_FLAG_FLUSH
=20
=20
 cdef extern from '<infiniband/driver.h>':
-    cpdef enum ibv_gid_type:
-        IBV_GID_TYPE_IB_ROCE_V1
-        IBV_GID_TYPE_ROCE_V2
+    cpdef enum ibv_gid_type_sysfs:
+        IBV_GID_TYPE_SYSFS_IB_ROCE_V1
+        IBV_GID_TYPE_SYSFS_ROCE_V2
diff --git a/tests/base.py b/tests/base.py
index b6c389d..0ebd728 100755
--- a/tests/base.py
+++ b/tests/base.py
@@ -176,7 +176,8 @@ class RDMATestCase(unittest.TestCase):
                 continue
             # Avoid RoCEv2 GIDs on unsupported devices
             if port_attrs.link_layer =3D=3D e.IBV_LINK_LAYER_ETHERNET and =
\
-                    ctx.query_gid_type(port, idx) =3D=3D e.IBV_GID_TYPE_RO=
CE_V2 and \
+                    ctx.query_gid_type(port, idx) =3D=3D \
+                    e.IBV_GID_TYPE_SYSFS_ROCE_V2 and \
                     has_roce_hw_bug(vendor_id, vendor_pid):
                 continue
             if not os.path.exists('/sys/class/infiniband/{}/device/net/'.f=
ormat(dev)):
--=20
1.8.3.1

