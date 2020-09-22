Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB5B273D41
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Sep 2020 10:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgIVI0y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 04:26:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgIVI0y (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Sep 2020 04:26:54 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E93B1239E5;
        Tue, 22 Sep 2020 08:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600763213;
        bh=dD13u81hHtLKul0kx89OTsGcfQmcCEmvQR8x0PtmPuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XQxKIoobPc5Q3le4oml4gSBQmdSQ7d4JwkaMyU/EVl4JrcxOk7HNCmzqPvYAb7BBa
         jIs+sLOAlj44QzbQayDgTiG8fGNaPK8NQhQJKGmmAdZ12KvWMZKvwU/TZu4gJ3v8M6
         BfEsOZSmvxh9aB5bPU4entj7dOrUUYNIJRjXSoQc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Avihai Horon <avihaih@nvidia.com>,
        Ariel Elior <aelior@marvell.com>, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>
Subject: [PATCH rdma-next v2 2/4] RDMA/core: Modify enum ib_gid_type and enum rdma_network_type
Date:   Tue, 22 Sep 2020 11:26:39 +0300
Message-Id: <20200922082641.2149549-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200922082641.2149549-1-leon@kernel.org>
References: <20200922082641.2149549-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 drivers/infiniband/core/cma.c          |  4 ++++
 drivers/infiniband/core/cma_configfs.c |  9 +++++----
 drivers/infiniband/core/verbs.c        |  2 +-
 drivers/infiniband/hw/mlx5/cq.c        |  2 +-
 drivers/infiniband/hw/mlx5/main.c      |  4 ++--
 drivers/infiniband/hw/qedr/verbs.c     |  4 +++-
 include/rdma/ib_verbs.h                | 17 ++++++++++-------
 8 files changed, 30 insertions(+), 16 deletions(-)

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
index a3c97b875389..404bd6ea0908 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -304,6 +304,10 @@ int cma_set_default_gid_type(struct cma_device *cma_dev,
 	if (!rdma_is_port_valid(cma_dev->device, port))
 		return -EINVAL;
 
+	if (default_gid_type == IB_GID_TYPE_IB &&
+	    rdma_protocol_roce_eth_encap(cma_dev->device, port))
+		default_gid_type = IB_GID_TYPE_ROCE;
+
 	supported_gids = roce_gid_type_mask_support(cma_dev->device, port);
 
 	if (!(supported_gids & 1 << default_gid_type))
diff --git a/drivers/infiniband/core/cma_configfs.c b/drivers/infiniband/core/cma_configfs.c
index 3c1e2ca564fe..7ec4af2ed87a 100644
--- a/drivers/infiniband/core/cma_configfs.c
+++ b/drivers/infiniband/core/cma_configfs.c
@@ -123,16 +123,17 @@ static ssize_t default_roce_mode_store(struct config_item *item,
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
 	ret = cma_set_default_gid_type(cma_dev, group->port_num, gid_type);
 
 	cma_configfs_params_put(cma_dev);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index f21353f3957d..9fe04bc15e5c 100644
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
index f81040a6626f..3ae681a6ae3b 100644
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
index 23559f1fe96e..a5d9215a0dc0 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1157,7 +1157,7 @@ static inline int get_gid_info_from_table(struct ib_qp *ibqp,
 		SET_FIELD(qp_params->modify_flags,
 			  QED_ROCE_MODIFY_QP_VALID_ROCE_MODE, 1);
 		break;
-	case RDMA_NETWORK_IB:
+	case RDMA_NETWORK_ROCE_V1:
 		memcpy(&qp_params->sgid.bytes[0], &gid_attr->gid.raw[0],
 		       sizeof(qp_params->sgid));
 		memcpy(&qp_params->dgid.bytes[0],
@@ -1177,6 +1177,8 @@ static inline int get_gid_info_from_table(struct ib_qp *ibqp,
 			  QED_ROCE_MODIFY_QP_VALID_ROCE_MODE, 1);
 		qp_params->roce_mode = ROCE_V2_IPV4;
 		break;
+	default:
+		return -EINVAL;
 	}
 
 	for (i = 0; i < 4; i++) {
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 0396c6b979a1..ab104bc2b8e5 100644
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

