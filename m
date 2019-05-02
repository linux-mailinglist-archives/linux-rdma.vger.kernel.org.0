Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9314B11486
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 09:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfEBHs0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 03:48:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfEBHsZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 May 2019 03:48:25 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A87F20873;
        Thu,  2 May 2019 07:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556783304;
        bh=17fKSkkNMoXO07hlTk7ueY0GFse0ROv2KK7peHE4k1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DqV24HEIt6D8COLdl4wEg7+XSce6LaXDpb+sEmGkrSum/xPY5PJC6h8ijEBAAYueM
         vLUxVcW+4+hdH0fIOfT0cChXLbvvqVB6d6ez01+/GB1bxKGjZgw6veS6aQG7SyiJoc
         AZPjbZ2yRVdGaR5Am2Sz86Y2UGl6ApQ1moECd/qo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Huy Nguyen <huyn@mellanox.com>, Martin Wilck <mwilck@suse.com>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next v2 3/7] RDMA: Introduce and use GID attr helper to read RoCE L2 fields
Date:   Thu,  2 May 2019 10:48:03 +0300
Message-Id: <20190502074807.26566-4-leon@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502074807.26566-1-leon@kernel.org>
References: <20190502074807.26566-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

Instead of RoCE drivers figuring out vlan, smac fields while working on
QP/AH, provide a helper routine to read the L2 fields such as vlan_id
and source mac address.

This moves logic from mlx5 driver to core for wider usage for RoCE
ports.

This is a preparation patch to allow detaching netdev in subsequent
patch.

Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cache.c            | 55 ++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c   | 18 ++++---
 drivers/infiniband/hw/hns/hns_roce_ah.c    | 14 +++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  7 ++-
 drivers/infiniband/hw/mlx4/ah.c            |  8 ++--
 drivers/infiniband/hw/mlx4/qp.c            |  6 ++-
 drivers/infiniband/hw/mlx5/main.c          | 42 +++--------------
 drivers/infiniband/hw/ocrdma/ocrdma_ah.c   |  9 ++--
 drivers/infiniband/hw/ocrdma/ocrdma_hw.c   |  7 +--
 drivers/infiniband/hw/qedr/qedr_roce_cm.c  | 11 +++--
 drivers/infiniband/hw/qedr/verbs.c         |  5 +-
 include/rdma/ib_cache.h                    |  3 ++
 12 files changed, 118 insertions(+), 67 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 7499e7016e38..c164e377e563 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1250,6 +1250,61 @@ struct net_device *rdma_read_gid_attr_ndev_rcu(const struct ib_gid_attr *attr)
 	return ndev;
 }
 
+static int get_lower_dev_vlan(struct net_device *lower_dev, void *data)
+{
+	u16 *vlan_id = data;
+
+	if (is_vlan_dev(lower_dev))
+		*vlan_id = vlan_dev_vlan_id(lower_dev);
+
+	/* We are interested only in first level vlan device, so
+	 * always return 1 to stop iterating over next level devices.
+	 */
+	return 1;
+}
+
+/**
+ * rdma_read_gid_l2_fields - Read the vlan ID and source MAC address
+ *			     of a GID entry.
+ *
+ * @attr:	GID attribute pointer whose L2 fields to be read
+ * @vlan_id:	Pointer to vlan id to fill up if the GID entry has
+ *		vlan id. It is optional.
+ * @smac:	Pointer to smac to fill up for a GID entry. It is optional.
+ *
+ * rdma_read_gid_l2_fields() returns 0 on success and returns vlan id
+ * (if gid entry has vlan) and source MAC, or returns error.
+ */
+int rdma_read_gid_l2_fields(const struct ib_gid_attr *attr,
+			    u16 *vlan_id, u8 *smac)
+{
+	struct net_device *ndev;
+
+	ndev = attr->ndev;
+	if (!ndev)
+		return -EINVAL;
+
+	if (smac)
+		ether_addr_copy(smac, ndev->dev_addr);
+	if (vlan_id) {
+		*vlan_id = 0xffff;
+		if (is_vlan_dev(ndev)) {
+			*vlan_id = vlan_dev_vlan_id(ndev);
+		} else {
+			/* If the netdev is upper device and if it's lower
+			 * device is vlan device, consider vlan id of the
+			 * the lower vlan device for this gid entry.
+			 */
+			rcu_read_lock();
+			netdev_walk_all_lower_dev_rcu(attr->ndev,
+					get_lower_dev_vlan, vlan_id);
+			rcu_read_unlock();
+		}
+	}
+	return 0;
+}
+EXPORT_SYMBOL(rdma_read_gid_l2_fields);
+
 static int config_non_roce_gid_cache(struct ib_device *device,
 				     u8 port, int gid_tbl_len)
 {
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 3fcc77c03903..cde789cb691b 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -360,8 +360,9 @@ int bnxt_re_add_gid(const struct ib_gid_attr *attr, void **context)
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(attr->device, ibdev);
 	struct bnxt_qplib_sgid_tbl *sgid_tbl = &rdev->qplib_res.sgid_tbl;
 
-	if ((attr->ndev) && is_vlan_dev(attr->ndev))
-		vlan_id = vlan_dev_vlan_id(attr->ndev);
+	rc = rdma_read_gid_l2_fields(attr, &vlan_id, NULL);
+	if (rc)
+		return rc;
 
 	rc = bnxt_qplib_add_sgid(sgid_tbl, (struct bnxt_qplib_gid *)&attr->gid,
 				 rdev->qplib_res.netdev->dev_addr,
@@ -1637,8 +1638,11 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 				qp_attr->ah_attr.roce.dmac);
 
 		sgid_attr = qp_attr->ah_attr.grh.sgid_attr;
-		memcpy(qp->qplib_qp.smac, sgid_attr->ndev->dev_addr,
-		       ETH_ALEN);
+		rc = rdma_read_gid_l2_fields(sgid_attr, NULL,
+					     &qp->qplib_qp.smac[0]);
+		if (rc)
+			return rc;
+
 		nw_type = rdma_gid_attr_network_type(sgid_attr);
 		switch (nw_type) {
 		case RDMA_NETWORK_IPV4:
@@ -1857,8 +1861,10 @@ static int bnxt_re_build_qp1_send_v2(struct bnxt_re_qp *qp,
 
 	memset(&qp->qp1_hdr, 0, sizeof(qp->qp1_hdr));
 
-	if (is_vlan_dev(sgid_attr->ndev))
-		vlan_id = vlan_dev_vlan_id(sgid_attr->ndev);
+	rc = rdma_read_gid_l2_fields(sgid_attr, &vlan_id, NULL);
+	if (rc)
+		return rc;
+
 	/* Get network header type for this GID */
 	nw_type = rdma_gid_attr_network_type(sgid_attr);
 	switch (nw_type) {
diff --git a/drivers/infiniband/hw/hns/hns_roce_ah.c b/drivers/infiniband/hw/hns/hns_roce_ah.c
index d9498313ea46..cdd2ac24fc2a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_ah.c
+++ b/drivers/infiniband/hw/hns/hns_roce_ah.c
@@ -49,20 +49,22 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr,
 	u16 vlan_tag = 0xffff;
 	const struct ib_global_route *grh = rdma_ah_read_grh(ah_attr);
 	bool vlan_en = false;
+	int ret;
+
+	gid_attr = ah_attr->grh.sgid_attr;
+	ret = rdma_read_gid_l2_fields(gid_attr, &vlan_tag, NULL);
+	if (ret)
+		return ret;
 
 	/* Get mac address */
 	memcpy(ah->av.mac, ah_attr->roce.dmac, ETH_ALEN);
 
-	gid_attr = ah_attr->grh.sgid_attr;
-	if (is_vlan_dev(gid_attr->ndev)) {
-		vlan_tag = vlan_dev_vlan_id(gid_attr->ndev);
+	if (vlan_tag < VLAN_CFI_MASK) {
 		vlan_en = true;
-	}
-
-	if (vlan_tag < 0x1000)
 		vlan_tag |= (rdma_ah_get_sl(ah_attr) &
 			     HNS_ROCE_VLAN_SL_BIT_MASK) <<
 			     HNS_ROCE_VLAN_SL_SHIFT;
+	}
 
 	ah->av.port_pd = cpu_to_le32(to_hr_pd(ibah->pd)->pdn |
 				     (rdma_ah_get_port_num(ah_attr) <<
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index f155d2d0b8cd..b5392cb5b20f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -37,6 +37,7 @@
 #include <linux/types.h>
 #include <net/addrconf.h>
 #include <rdma/ib_addr.h>
+#include <rdma/ib_cache.h>
 #include <rdma/ib_umem.h>
 #include <rdma/uverbs_ioctl.h>
 
@@ -3984,10 +3985,12 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 
 		if (is_roce_protocol) {
 			gid_attr = attr->ah_attr.grh.sgid_attr;
-			vlan = rdma_vlan_dev_vlan_id(gid_attr->ndev);
+			ret = rdma_read_gid_l2_fields(gid_attr, &vlan, NULL);
+			if (ret)
+				goto out;
 		}
 
-		if (is_vlan_dev(gid_attr->ndev)) {
+		if (vlan < VLAN_CFI_MASK) {
 			roce_set_bit(context->byte_76_srqn_op_en,
 				     V2_QPC_BYTE_76_RQ_VLAN_EN_S, 1);
 			roce_set_bit(qpc_mask->byte_76_srqn_op_en,
diff --git a/drivers/infiniband/hw/mlx4/ah.c b/drivers/infiniband/hw/mlx4/ah.c
index b53772ab2401..02a169f8027b 100644
--- a/drivers/infiniband/hw/mlx4/ah.c
+++ b/drivers/infiniband/hw/mlx4/ah.c
@@ -99,9 +99,11 @@ static int create_iboe_ah(struct ib_ah *ib_ah, struct rdma_ah_attr *ah_attr)
 	 */
 	gid_attr = ah_attr->grh.sgid_attr;
 	if (gid_attr) {
-		if (is_vlan_dev(gid_attr->ndev))
-			vlan_tag = vlan_dev_vlan_id(gid_attr->ndev);
-		memcpy(ah->av.eth.s_mac, gid_attr->ndev->dev_addr, ETH_ALEN);
+		ret = rdma_read_gid_l2_fields(gid_attr, &vlan_tag,
+					      &ah->av.eth.s_mac[0]);
+		if (ret)
+			return ret;
+
 		ret = mlx4_ib_gid_index_to_real_index(ibdev, gid_attr);
 		if (ret < 0)
 			return ret;
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 364e16b5f8e1..bb1c6eb31b32 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -2248,8 +2248,10 @@ static int __mlx4_ib_modify_qp(void *src, enum mlx4_ib_source_type src_type,
 
 		if (is_eth) {
 			gid_attr = attr->ah_attr.grh.sgid_attr;
-			vlan = rdma_vlan_dev_vlan_id(gid_attr->ndev);
-			memcpy(smac, gid_attr->ndev->dev_addr, ETH_ALEN);
+			err = rdma_read_gid_l2_fields(gid_attr, &vlan,
+						      &smac[0]);
+			if (err)
+				goto out;
 		}
 
 		if (mlx4_set_path(dev, attr, attr_mask, qp, &context->pri_path,
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index b49929682dc0..692759914d20 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -574,52 +574,22 @@ static int mlx5_query_port_roce(struct ib_device *device, u8 port_num,
 	return err;
 }
 
-struct mlx5_ib_vlan_info {
-	u16 vlan_id;
-	bool vlan;
-};
-
-static int get_lower_dev_vlan(struct net_device *lower_dev, void *data)
-{
-	struct mlx5_ib_vlan_info *vlan_info = data;
-
-	if (is_vlan_dev(lower_dev)) {
-		vlan_info->vlan = true;
-		vlan_info->vlan_id = vlan_dev_vlan_id(lower_dev);
-	}
-	/* We are interested only in first level vlan device, so
-	 * always return 1 to stop iterating over next level devices.
-	 */
-	return 1;
-}
-
 static int set_roce_addr(struct mlx5_ib_dev *dev, u8 port_num,
 			 unsigned int index, const union ib_gid *gid,
 			 const struct ib_gid_attr *attr)
 {
 	enum ib_gid_type gid_type = IB_GID_TYPE_IB;
-	struct mlx5_ib_vlan_info vlan_info = { };
+	u16 vlan_id = 0xffff;
 	u8 roce_version = 0;
 	u8 roce_l3_type = 0;
 	u8 mac[ETH_ALEN];
+	int ret;
 
 	if (gid) {
 		gid_type = attr->gid_type;
-		ether_addr_copy(mac, attr->ndev->dev_addr);
-
-		if (is_vlan_dev(attr->ndev)) {
-			vlan_info.vlan = true;
-			vlan_info.vlan_id = vlan_dev_vlan_id(attr->ndev);
-		} else {
-			/* If the netdev is upper device and if it's lower
-			 * lower device is vlan device, consider vlan id of
-			 * the lower vlan device for this gid entry.
-			 */
-			rcu_read_lock();
-			netdev_walk_all_lower_dev_rcu(attr->ndev,
-					get_lower_dev_vlan, &vlan_info);
-			rcu_read_unlock();
-		}
+		ret = rdma_read_gid_l2_fields(attr, &vlan_id, &mac[0]);
+		if (ret)
+			return ret;
 	}
 
 	switch (gid_type) {
@@ -640,7 +610,7 @@ static int set_roce_addr(struct mlx5_ib_dev *dev, u8 port_num,
 
 	return mlx5_core_roce_gid_set(dev->mdev, index, roce_version,
 				      roce_l3_type, gid->raw, mac,
-				      vlan_info.vlan, vlan_info.vlan_id,
+				      vlan_id < VLAN_CFI_MASK, vlan_id,
 				      port_num);
 }
 
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_ah.c b/drivers/infiniband/hw/ocrdma/ocrdma_ah.c
index a17747cb086a..1d4ea135c28f 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_ah.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_ah.c
@@ -175,14 +175,15 @@ int ocrdma_create_ah(struct ib_ah *ibah, struct rdma_ah_attr *attr, u32 flags,
 	if (atomic_cmpxchg(&dev->update_sl, 1, 0))
 		ocrdma_init_service_level(dev);
 
+	sgid_attr = attr->grh.sgid_attr;
+	status = rdma_read_gid_l2_fields(sgid_attr, &vlan_tag, NULL);
+	if (status)
+		return status;
+
 	status = ocrdma_alloc_av(dev, ah);
 	if (status)
 		goto av_err;
 
-	sgid_attr = attr->grh.sgid_attr;
-	if (is_vlan_dev(sgid_attr->ndev))
-		vlan_tag = vlan_dev_vlan_id(sgid_attr->ndev);
-
 	/* Get network header type for this GID */
 	ah->hdr_type = rdma_gid_attr_network_type(sgid_attr);
 
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_hw.c b/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
index 5d96b5a94583..32674b291f60 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
@@ -2496,7 +2496,7 @@ static int ocrdma_set_av_params(struct ocrdma_qp *qp,
 	int status;
 	struct rdma_ah_attr *ah_attr = &attrs->ah_attr;
 	const struct ib_gid_attr *sgid_attr;
-	u32 vlan_id = 0xFFFF;
+	u16 vlan_id = 0xFFFF;
 	u8 mac_addr[6], hdr_type;
 	union {
 		struct sockaddr     _sockaddr;
@@ -2526,8 +2526,9 @@ static int ocrdma_set_av_params(struct ocrdma_qp *qp,
 	       sizeof(cmd->params.dgid));
 
 	sgid_attr = ah_attr->grh.sgid_attr;
-	vlan_id = rdma_vlan_dev_vlan_id(sgid_attr->ndev);
-	memcpy(mac_addr, sgid_attr->ndev->dev_addr, ETH_ALEN);
+	status = rdma_read_gid_l2_fields(sgid_attr, &vlan_id, &mac_addr[0]);
+	if (status)
+		return status;
 
 	qp->sgid_idx = grh->sgid_index;
 	memcpy(&cmd->params.sgid[0], &sgid_attr->gid.raw[0],
diff --git a/drivers/infiniband/hw/qedr/qedr_roce_cm.c b/drivers/infiniband/hw/qedr/qedr_roce_cm.c
index e1ac2fd60bb1..f5542d703ef9 100644
--- a/drivers/infiniband/hw/qedr/qedr_roce_cm.c
+++ b/drivers/infiniband/hw/qedr/qedr_roce_cm.c
@@ -397,14 +397,17 @@ static inline int qedr_gsi_build_header(struct qedr_dev *dev,
 	bool has_udp = false;
 	int i;
 
-	send_size = 0;
-	for (i = 0; i < swr->num_sge; ++i)
-		send_size += swr->sg_list[i].length;
+	rc = rdma_read_gid_l2_fields(sgid_attr, &vlan_id, NULL);
+	if (rc)
+		return rc;
 
-	vlan_id = rdma_vlan_dev_vlan_id(sgid_attr->ndev);
 	if (vlan_id < VLAN_CFI_MASK)
 		has_vlan = true;
 
+	send_size = 0;
+	for (i = 0; i < swr->num_sge; ++i)
+		send_size += swr->sg_list[i].length;
+
 	has_udp = (sgid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP);
 	if (!has_udp) {
 		/* RoCE v1 */
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 5e92b6229da2..e52d8761d681 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1050,10 +1050,13 @@ static inline int get_gid_info_from_table(struct ib_qp *ibqp,
 	enum rdma_network_type nw_type;
 	const struct ib_global_route *grh = rdma_ah_read_grh(&attr->ah_attr);
 	u32 ipv4_addr;
+	int ret;
 	int i;
 
 	gid_attr = grh->sgid_attr;
-	qp_params->vlan_id = rdma_vlan_dev_vlan_id(gid_attr->ndev);
+	ret = rdma_read_gid_l2_fields(gid_attr, &qp_params->vlan_id, NULL);
+	if (ret)
+		return ret;
 
 	nw_type = rdma_gid_attr_network_type(gid_attr);
 	switch (nw_type) {
diff --git a/include/rdma/ib_cache.h b/include/rdma/ib_cache.h
index 62e990b620aa..730a65ad8c74 100644
--- a/include/rdma/ib_cache.h
+++ b/include/rdma/ib_cache.h
@@ -54,6 +54,9 @@ const struct ib_gid_attr *rdma_find_gid_by_filter(
 		       void *),
 	void *context);
 
+int rdma_read_gid_l2_fields(const struct ib_gid_attr *attr,
+			    u16 *vlan_id, u8 *smac);
+
 /**
  * ib_get_cached_pkey - Returns a cached PKey table entry
  * @device: The device to query.
-- 
2.20.1

