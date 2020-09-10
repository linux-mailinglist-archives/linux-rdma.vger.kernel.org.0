Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B27E2652E8
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Sep 2020 23:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgIJV0D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Sep 2020 17:26:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729298AbgIJOXH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Sep 2020 10:23:07 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90AA421D6C;
        Thu, 10 Sep 2020 14:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599747737;
        bh=4Tjrv2FpSL6W9SzmFU8Dz0tGdDxt6J/BMHUvkkLW8uc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N+qb0/A+V1nrOnxIfAtEJ2M5SQT+3LWsOKeUqrThU4C8gX3kmY+yEBjXmiN5VZZEb
         6HVTldg+Fi1j+OU5a6AXVdnNohBItaVBsT6uT2Fm2oSVI0NwowbCxtDRLA0Ht4tvjo
         BL07qtJRKBHOz1cq6+ViAd37qms2dmXjDMhUq/vc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Avihai Horon <avihaih@nvidia.com>,
        Ariel Elior <aelior@marvell.com>, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>
Subject: [PATCH rdma-next 2/4] RDMA/core: Modify enum ib_gid_type and enum rdma_network_type
Date:   Thu, 10 Sep 2020 17:22:02 +0300
Message-Id: <20200910142204.1309061-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910142204.1309061-1-leon@kernel.org>
References: <20200910142204.1309061-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Avihai Horon <avihaih@nvidia.com>

Separate IB_GID_TYPE_IB and IB_GID_TYPE_ROCE to two different values,
so enum ib_gid_type will match the gid types of the new query GID table
API which will be introduced in the following patches.

This change in enum ib_gid_type requires to change also enum
rdma_network_type by separating RDMA_NETWORK_IB and RDMA_NETWORK_ROCE_V1
values.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cache.c        |  4 ++++
 drivers/infiniband/core/cma.c          | 10 ----------
 drivers/infiniband/core/cma_configfs.c | 13 +++++++++----
 drivers/infiniband/core/cma_priv.h     | 10 ++++++++++
 drivers/infiniband/core/verbs.c        |  2 +-
 drivers/infiniband/hw/mlx5/cq.c        |  2 +-
 drivers/infiniband/hw/mlx5/main.c      |  4 ++--
 drivers/infiniband/hw/qedr/verbs.c     |  4 +++-
 include/rdma/ib_verbs.h                | 17 ++++++++++-------
 9 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 6079f1f7e678..cf49ac0b0aa6 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -133,7 +133,11 @@ static void dispatch_gid_change_event(struct ib_device *ib_dev, u8 port)
 }
 
 static const char * const gid_type_str[] = {
+	/* IB/RoCE v1 value is set for IB_GID_TYPE_IB and IB_GID_TYPE_ROCE for
+	 * user space compatibility reasons.
+	 */
 	[IB_GID_TYPE_IB]	= "IB/RoCE v1",
+	[IB_GID_TYPE_ROCE]	= "IB/RoCE v1",
 	[IB_GID_TYPE_ROCE_UDP_ENCAP]	= "RoCE v2",
 };
 
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 82338099ba09..0bb4e3212158 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -203,16 +203,6 @@ struct xarray *cma_pernet_xa(struct net *net, enum rdma_ucm_port_space ps)
 	}
 }
 
-struct cma_device {
-	struct list_head	list;
-	struct ib_device	*device;
-	struct completion	comp;
-	refcount_t refcount;
-	struct list_head	id_list;
-	enum ib_gid_type	*default_gid_type;
-	u8			*default_roce_tos;
-};
-
 struct rdma_bind_list {
 	enum rdma_ucm_port_space ps;
 	struct hlist_head	owners;
diff --git a/drivers/infiniband/core/cma_configfs.c b/drivers/infiniband/core/cma_configfs.c
index 3c1e2ca564fe..f1b277793980 100644
--- a/drivers/infiniband/core/cma_configfs.c
+++ b/drivers/infiniband/core/cma_configfs.c
@@ -123,16 +123,21 @@ static ssize_t default_roce_mode_store(struct config_item *item,
 {
 	struct cma_device *cma_dev;
 	struct cma_dev_port_group *group;
-	int gid_type = ib_cache_gid_parse_type_str(buf);
+	int gid_type;
 	ssize_t ret;
 
-	if (gid_type < 0)
-		return -EINVAL;
-
 	ret = cma_configfs_params_get(item, &cma_dev, &group);
 	if (ret)
 		return ret;
 
+	gid_type = ib_cache_gid_parse_type_str(buf);
+	if (gid_type < 0)
+		return -EINVAL;
+
+	if (gid_type == IB_GID_TYPE_IB &&
+	    rdma_protocol_roce_eth_encap(cma_dev->device, group->port_num))
+		gid_type = IB_GID_TYPE_ROCE;
+
 	ret = cma_set_default_gid_type(cma_dev, group->port_num, gid_type);
 
 	cma_configfs_params_put(cma_dev);
diff --git a/drivers/infiniband/core/cma_priv.h b/drivers/infiniband/core/cma_priv.h
index caece96ebcf5..5c99f6a53cd3 100644
--- a/drivers/infiniband/core/cma_priv.h
+++ b/drivers/infiniband/core/cma_priv.h
@@ -50,6 +50,16 @@ enum rdma_cm_state {
 	RDMA_CM_DESTROYING
 };
 
+struct cma_device {
+	struct list_head	list;
+	struct ib_device	*device;
+	struct completion	comp;
+	refcount_t refcount;
+	struct list_head	id_list;
+	enum ib_gid_type	*default_gid_type;
+	u8			*default_roce_tos;
+};
+
 struct rdma_id_private {
 	struct rdma_cm_id	id;
 
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 6e02f26a30a0..ac4b02f5ae68 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -740,7 +740,7 @@ int ib_get_gids_from_rdma_hdr(const union rdma_network_hdr *hdr,
 				       (struct in6_addr *)dgid);
 		return 0;
 	} else if (net_type == RDMA_NETWORK_IPV6 ||
-		   net_type == RDMA_NETWORK_IB) {
+		   net_type == RDMA_NETWORK_IB || RDMA_NETWORK_ROCE_V1) {
 		*dgid = hdr->ibgrh.dgid;
 		*sgid = hdr->ibgrh.sgid;
 		return 0;
diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 0748a5daa2dd..3d4e02ae6628 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -255,7 +255,7 @@ static void handle_responder(struct ib_wc *wc, struct mlx5_cqe64 *cqe,
 
 	switch (roce_packet_type) {
 	case MLX5_CQE_ROCE_L3_HEADER_TYPE_GRH:
-		wc->network_hdr_type = RDMA_NETWORK_IB;
+		wc->network_hdr_type = RDMA_NETWORK_ROCE_V1;
 		break;
 	case MLX5_CQE_ROCE_L3_HEADER_TYPE_IPV6:
 		wc->network_hdr_type = RDMA_NETWORK_IPV6;
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 8696ad50d8fb..5cf5266936de 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -546,7 +546,7 @@ static int set_roce_addr(struct mlx5_ib_dev *dev, u8 port_num,
 			 unsigned int index, const union ib_gid *gid,
 			 const struct ib_gid_attr *attr)
 {
-	enum ib_gid_type gid_type = IB_GID_TYPE_IB;
+	enum ib_gid_type gid_type = IB_GID_TYPE_ROCE;
 	u16 vlan_id = 0xffff;
 	u8 roce_version = 0;
 	u8 roce_l3_type = 0;
@@ -561,7 +561,7 @@ static int set_roce_addr(struct mlx5_ib_dev *dev, u8 port_num,
 	}
 
 	switch (gid_type) {
-	case IB_GID_TYPE_IB:
+	case IB_GID_TYPE_ROCE:
 		roce_version = MLX5_ROCE_VERSION_1;
 		break;
 	case IB_GID_TYPE_ROCE_UDP_ENCAP:
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 3337d4b6a841..0395523958da 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1138,7 +1138,7 @@ static inline int get_gid_info_from_table(struct ib_qp *ibqp,
 		SET_FIELD(qp_params->modify_flags,
 			  QED_ROCE_MODIFY_QP_VALID_ROCE_MODE, 1);
 		break;
-	case RDMA_NETWORK_IB:
+	case RDMA_NETWORK_ROCE_V1:
 		memcpy(&qp_params->sgid.bytes[0], &gid_attr->gid.raw[0],
 		       sizeof(qp_params->sgid));
 		memcpy(&qp_params->dgid.bytes[0],
@@ -1158,6 +1158,8 @@ static inline int get_gid_info_from_table(struct ib_qp *ibqp,
 			  QED_ROCE_MODIFY_QP_VALID_ROCE_MODE, 1);
 		qp_params->roce_mode = ROCE_V2_IPV4;
 		break;
+	default:
+		return -EINVAL;
 	}
 
 	for (i = 0; i < 4; i++) {
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index bde17507f3ea..80cc0f5de5c3 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -138,10 +138,9 @@ union ib_gid {
 extern union ib_gid zgid;
 
 enum ib_gid_type {
-	/* If link layer is Ethernet, this is RoCE V1 */
 	IB_GID_TYPE_IB        = 0,
-	IB_GID_TYPE_ROCE      = 0,
-	IB_GID_TYPE_ROCE_UDP_ENCAP = 1,
+	IB_GID_TYPE_ROCE      = 1,
+	IB_GID_TYPE_ROCE_UDP_ENCAP = 2,
 	IB_GID_TYPE_SIZE
 };
 
@@ -180,7 +179,7 @@ rdma_node_get_transport(unsigned int node_type);
 
 enum rdma_network_type {
 	RDMA_NETWORK_IB,
-	RDMA_NETWORK_ROCE_V1 = RDMA_NETWORK_IB,
+	RDMA_NETWORK_ROCE_V1,
 	RDMA_NETWORK_IPV4,
 	RDMA_NETWORK_IPV6
 };
@@ -190,9 +189,10 @@ static inline enum ib_gid_type ib_network_to_gid_type(enum rdma_network_type net
 	if (network_type == RDMA_NETWORK_IPV4 ||
 	    network_type == RDMA_NETWORK_IPV6)
 		return IB_GID_TYPE_ROCE_UDP_ENCAP;
-
-	/* IB_GID_TYPE_IB same as RDMA_NETWORK_ROCE_V1 */
-	return IB_GID_TYPE_IB;
+	else if (network_type == RDMA_NETWORK_ROCE_V1)
+		return IB_GID_TYPE_ROCE;
+	else
+		return IB_GID_TYPE_IB;
 }
 
 static inline enum rdma_network_type
@@ -201,6 +201,9 @@ rdma_gid_attr_network_type(const struct ib_gid_attr *attr)
 	if (attr->gid_type == IB_GID_TYPE_IB)
 		return RDMA_NETWORK_IB;
 
+	if (attr->gid_type == IB_GID_TYPE_ROCE)
+		return RDMA_NETWORK_ROCE_V1;
+
 	if (ipv6_addr_v4mapped((struct in6_addr *)&attr->gid))
 		return RDMA_NETWORK_IPV4;
 	else
-- 
2.26.2

