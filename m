Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA85B2B42E8
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 12:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbgKPLfM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 06:35:12 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7907 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgKPLfM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Nov 2020 06:35:12 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CZRnX6qm1z6wfD;
        Mon, 16 Nov 2020 19:34:56 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Nov 2020 19:35:02 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 1/7] RDMA/hns: Only record vlan info for HIP08
Date:   Mon, 16 Nov 2020 19:33:22 +0800
Message-ID: <1605526408-6936-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1605526408-6936-1-git-send-email-liweihang@huawei.com>
References: <1605526408-6936-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Information about vlan is stored in GMV(GID/MAC/VLAN) table for HIP09, so
there is no need to copy it to address vector.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_ah.c     | 51 +++++++++++++----------------
 drivers/infiniband/hw/hns/hns_roce_device.h |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 13 +++++---
 3 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_ah.c b/drivers/infiniband/hw/hns/hns_roce_ah.c
index 75b06db..3be80d4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_ah.c
+++ b/drivers/infiniband/hw/hns/hns_roce_ah.c
@@ -31,13 +31,13 @@
  */
 
 #include <linux/platform_device.h>
+#include <linux/pci.h>
 #include <rdma/ib_addr.h>
 #include <rdma/ib_cache.h>
 #include "hns_roce_device.h"
 
-#define HNS_ROCE_PORT_NUM_SHIFT		24
-#define HNS_ROCE_VLAN_SL_BIT_MASK	7
-#define HNS_ROCE_VLAN_SL_SHIFT		13
+#define VLAN_SL_MASK 7
+#define VLAN_SL_SHIFT 13
 
 static inline u16 get_ah_udp_sport(const struct rdma_ah_attr *ah_attr)
 {
@@ -58,37 +58,16 @@ static inline u16 get_ah_udp_sport(const struct rdma_ah_attr *ah_attr)
 int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 		       struct ib_udata *udata)
 {
-	struct hns_roce_dev *hr_dev = to_hr_dev(ibah->device);
-	const struct ib_gid_attr *gid_attr;
-	struct device *dev = hr_dev->dev;
-	struct hns_roce_ah *ah = to_hr_ah(ibah);
 	struct rdma_ah_attr *ah_attr = init_attr->ah_attr;
 	const struct ib_global_route *grh = rdma_ah_read_grh(ah_attr);
-	u16 vlan_id = 0xffff;
-	bool vlan_en = false;
-	int ret;
-
-	gid_attr = ah_attr->grh.sgid_attr;
-	ret = rdma_read_gid_l2_fields(gid_attr, &vlan_id, NULL);
-	if (ret)
-		return ret;
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibah->device);
+	struct hns_roce_ah *ah = to_hr_ah(ibah);
+	int ret = 0;
 
-	/* Get mac address */
 	memcpy(ah->av.mac, ah_attr->roce.dmac, ETH_ALEN);
 
-	if (vlan_id < VLAN_N_VID) {
-		vlan_en = true;
-		vlan_id |= (rdma_ah_get_sl(ah_attr) &
-			     HNS_ROCE_VLAN_SL_BIT_MASK) <<
-			     HNS_ROCE_VLAN_SL_SHIFT;
-	}
-
 	ah->av.port = rdma_ah_get_port_num(ah_attr);
 	ah->av.gid_index = grh->sgid_index;
-	ah->av.vlan_id = vlan_id;
-	ah->av.vlan_en = vlan_en;
-	dev_dbg(dev, "gid_index = 0x%x,vlan_id = 0x%x\n", ah->av.gid_index,
-		ah->av.vlan_id);
 
 	if (rdma_ah_get_static_rate(ah_attr))
 		ah->av.stat_rate = IB_RATE_10_GBPS;
@@ -98,7 +77,23 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	ah->av.flowlabel = grh->flow_label;
 	ah->av.udp_sport = get_ah_udp_sport(ah_attr);
 
-	return 0;
+	/* HIP08 needs to record vlan info in Address Vector */
+	if (hr_dev->pci_dev->revision <= PCI_REVISION_ID_HIP08) {
+		ah->av.vlan_en = 0;
+
+		ret = rdma_read_gid_l2_fields(ah_attr->grh.sgid_attr,
+					      &ah->av.vlan_id, NULL);
+		if (ret)
+			return ret;
+
+		if (ah->av.vlan_id < VLAN_N_VID) {
+			ah->av.vlan_en = 1;
+			ah->av.vlan_id |= (rdma_ah_get_sl(ah_attr) & VLAN_SL_MASK) <<
+					  VLAN_SL_SHIFT;
+		}
+	}
+
+	return ret;
 }
 
 int hns_roce_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr)
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 1d99022..9a032d0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -549,7 +549,7 @@ struct hns_roce_av {
 	u8 dgid[HNS_ROCE_GID_SIZE];
 	u8 mac[ETH_ALEN];
 	u16 vlan_id;
-	bool vlan_en;
+	u8 vlan_en;
 };
 
 struct hns_roce_ah {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 4d697e4..3895a2a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -492,8 +492,6 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
 	roce_set_field(ud_sq_wqe->byte_32, V2_UD_SEND_WQE_BYTE_32_DQPN_M,
 		       V2_UD_SEND_WQE_BYTE_32_DQPN_S, ud_wr(wr)->remote_qpn);
 
-	roce_set_field(ud_sq_wqe->byte_36, V2_UD_SEND_WQE_BYTE_36_VLAN_M,
-		       V2_UD_SEND_WQE_BYTE_36_VLAN_S, ah->av.vlan_id);
 	roce_set_field(ud_sq_wqe->byte_36, V2_UD_SEND_WQE_BYTE_36_HOPLIMIT_M,
 		       V2_UD_SEND_WQE_BYTE_36_HOPLIMIT_S, ah->av.hop_limit);
 	roce_set_field(ud_sq_wqe->byte_36, V2_UD_SEND_WQE_BYTE_36_TCLASS_M,
@@ -505,11 +503,18 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
 	roce_set_field(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_PORTN_M,
 		       V2_UD_SEND_WQE_BYTE_40_PORTN_S, qp->port);
 
-	roce_set_bit(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_UD_VLAN_EN_S,
-		     ah->av.vlan_en ? 1 : 0);
 	roce_set_field(ud_sq_wqe->byte_48, V2_UD_SEND_WQE_BYTE_48_SGID_INDX_M,
 		       V2_UD_SEND_WQE_BYTE_48_SGID_INDX_S, ah->av.gid_index);
 
+	if (hr_dev->pci_dev->revision <= PCI_REVISION_ID_HIP08) {
+		roce_set_bit(ud_sq_wqe->byte_40,
+			     V2_UD_SEND_WQE_BYTE_40_UD_VLAN_EN_S,
+			     ah->av.vlan_en);
+		roce_set_field(ud_sq_wqe->byte_36,
+			       V2_UD_SEND_WQE_BYTE_36_VLAN_M,
+			       V2_UD_SEND_WQE_BYTE_36_VLAN_S, ah->av.vlan_id);
+	}
+
 	memcpy(&ud_sq_wqe->dgid[0], &ah->av.dgid[0], GID_LEN_V2);
 
 	set_extend_sge(qp, wr, &curr_idx, valid_num_sge);
-- 
2.8.1

