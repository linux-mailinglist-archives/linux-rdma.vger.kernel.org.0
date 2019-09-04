Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65F16A7932
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2019 05:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfIDDSM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Sep 2019 23:18:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49722 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727374AbfIDDSL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Sep 2019 23:18:11 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 92B7928A52EDFCF5BB2A;
        Wed,  4 Sep 2019 11:18:08 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 4 Sep 2019 11:18:00 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 3/5] RDMA/hns: Modify variable/field name from vlan to vlan_id
Date:   Wed, 4 Sep 2019 11:14:43 +0800
Message-ID: <1567566885-23088-4-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1567566885-23088-1-git-send-email-liweihang@hisilicon.com>
References: <1567566885-23088-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The name of vlan and vlan_tag is not clear enough, it's actually means
vlan id.

Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_ah.c     | 14 +++++++-------
 drivers/infiniband/hw/hns/hns_roce_device.h |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 10 +++++-----
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_ah.c b/drivers/infiniband/hw/hns/hns_roce_ah.c
index 90e08c0..8a522e1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_ah.c
+++ b/drivers/infiniband/hw/hns/hns_roce_ah.c
@@ -46,32 +46,32 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr,
 	const struct ib_gid_attr *gid_attr;
 	struct device *dev = hr_dev->dev;
 	struct hns_roce_ah *ah = to_hr_ah(ibah);
-	u16 vlan_tag = 0xffff;
 	const struct ib_global_route *grh = rdma_ah_read_grh(ah_attr);
+	u16 vlan_id = 0xffff;
 	bool vlan_en = false;
 	int ret;
 
 	gid_attr = ah_attr->grh.sgid_attr;
-	ret = rdma_read_gid_l2_fields(gid_attr, &vlan_tag, NULL);
+	ret = rdma_read_gid_l2_fields(gid_attr, &vlan_id, NULL);
 	if (ret)
 		return ret;
 
 	/* Get mac address */
 	memcpy(ah->av.mac, ah_attr->roce.dmac, ETH_ALEN);
 
-	if (vlan_tag < VLAN_CFI_MASK) {
+	if (vlan_id < VLAN_N_VID) {
 		vlan_en = true;
-		vlan_tag |= (rdma_ah_get_sl(ah_attr) &
+		vlan_id |= (rdma_ah_get_sl(ah_attr) &
 			     HNS_ROCE_VLAN_SL_BIT_MASK) <<
 			     HNS_ROCE_VLAN_SL_SHIFT;
 	}
 
 	ah->av.port = rdma_ah_get_port_num(ah_attr);
 	ah->av.gid_index = grh->sgid_index;
-	ah->av.vlan = vlan_tag;
+	ah->av.vlan_id = vlan_id;
 	ah->av.vlan_en = vlan_en;
-	dev_dbg(dev, "gid_index = 0x%x,vlan = 0x%x\n", ah->av.gid_index,
-		ah->av.vlan);
+	dev_dbg(dev, "gid_index = 0x%x,vlan_id = 0x%x\n", ah->av.gid_index,
+		ah->av.vlan_id);
 
 	if (rdma_ah_get_static_rate(ah_attr))
 		ah->av.stat_rate = IB_RATE_10_GBPS;
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 96d1302..c810898 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -582,7 +582,7 @@ struct hns_roce_av {
 	u8          tclass;
 	u8          dgid[HNS_ROCE_GID_SIZE];
 	u8          mac[ETH_ALEN];
-	u16         vlan;
+	u16         vlan_id;
 	bool	    vlan_en;
 };
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index c5ab8ca..f7c8356 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -389,7 +389,7 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 			roce_set_field(ud_sq_wqe->byte_36,
 				       V2_UD_SEND_WQE_BYTE_36_VLAN_M,
 				       V2_UD_SEND_WQE_BYTE_36_VLAN_S,
-				       ah->av.vlan);
+				       ah->av.vlan_id);
 			roce_set_field(ud_sq_wqe->byte_36,
 				       V2_UD_SEND_WQE_BYTE_36_HOPLIMIT_M,
 				       V2_UD_SEND_WQE_BYTE_36_HOPLIMIT_S,
@@ -4061,8 +4061,8 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
 	const struct ib_gid_attr *gid_attr = NULL;
 	int is_roce_protocol;
+	u16 vlan_id = 0xffff;
 	bool is_udp = false;
-	u16 vlan = 0xffff;
 	u8 ib_port;
 	u8 hr_port;
 	int ret;
@@ -4074,7 +4074,7 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 
 	if (is_roce_protocol) {
 		gid_attr = attr->ah_attr.grh.sgid_attr;
-		ret = rdma_read_gid_l2_fields(gid_attr, &vlan, NULL);
+		ret = rdma_read_gid_l2_fields(gid_attr, &vlan_id, NULL);
 		if (ret)
 			return ret;
 
@@ -4083,7 +4083,7 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 				 IB_GID_TYPE_ROCE_UDP_ENCAP);
 	}
 
-	if (vlan < VLAN_CFI_MASK) {
+	if (vlan_id < VLAN_N_VID) {
 		roce_set_bit(context->byte_76_srqn_op_en,
 			     V2_QPC_BYTE_76_RQ_VLAN_EN_S, 1);
 		roce_set_bit(qpc_mask->byte_76_srqn_op_en,
@@ -4095,7 +4095,7 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 	}
 
 	roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_VLAN_ID_M,
-		       V2_QPC_BYTE_24_VLAN_ID_S, vlan);
+		       V2_QPC_BYTE_24_VLAN_ID_S, vlan_id);
 	roce_set_field(qpc_mask->byte_24_mtu_tc, V2_QPC_BYTE_24_VLAN_ID_M,
 		       V2_QPC_BYTE_24_VLAN_ID_S, 0);
 
-- 
2.8.1

