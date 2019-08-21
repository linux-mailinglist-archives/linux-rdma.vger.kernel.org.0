Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C885B97A8A
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 15:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfHUNR7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 09:17:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38320 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728219AbfHUNR6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 09:17:58 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D45C26A7AEFEFF65B26B;
        Wed, 21 Aug 2019 21:17:53 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Wed, 21 Aug 2019 21:17:46 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 3/9] RDMA/hns: Modify the data structure of hns_roce_av
Date:   Wed, 21 Aug 2019 21:14:30 +0800
Message-ID: <1566393276-42555-4-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1566393276-42555-1-git-send-email-oulijun@huawei.com>
References: <1566393276-42555-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

we change type of some members to u32/u8 from __le32 as well as
split sl_tclass_flowlabel into three variables in hns_roce_av.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_ah.c     | 23 +++++++----------------
 drivers/infiniband/hw/hns/hns_roce_device.h |  8 +++++---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  9 +++------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  9 +++------
 4 files changed, 18 insertions(+), 31 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_ah.c b/drivers/infiniband/hw/hns/hns_roce_ah.c
index cdd2ac2..90e08c0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_ah.c
+++ b/drivers/infiniband/hw/hns/hns_roce_ah.c
@@ -66,11 +66,9 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr,
 			     HNS_ROCE_VLAN_SL_SHIFT;
 	}
 
-	ah->av.port_pd = cpu_to_le32(to_hr_pd(ibah->pd)->pdn |
-				     (rdma_ah_get_port_num(ah_attr) <<
-				     HNS_ROCE_PORT_NUM_SHIFT));
+	ah->av.port = rdma_ah_get_port_num(ah_attr);
 	ah->av.gid_index = grh->sgid_index;
-	ah->av.vlan = cpu_to_le16(vlan_tag);
+	ah->av.vlan = vlan_tag;
 	ah->av.vlan_en = vlan_en;
 	dev_dbg(dev, "gid_index = 0x%x,vlan = 0x%x\n", ah->av.gid_index,
 		ah->av.vlan);
@@ -79,8 +77,7 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr,
 		ah->av.stat_rate = IB_RATE_10_GBPS;
 
 	memcpy(ah->av.dgid, grh->dgid.raw, HNS_ROCE_GID_SIZE);
-	ah->av.sl_tclass_flowlabel = cpu_to_le32(rdma_ah_get_sl(ah_attr) <<
-						 HNS_ROCE_SL_SHIFT);
+	ah->av.sl = rdma_ah_get_sl(ah_attr);
 
 	return 0;
 }
@@ -91,17 +88,11 @@ int hns_roce_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr)
 
 	memset(ah_attr, 0, sizeof(*ah_attr));
 
-	rdma_ah_set_sl(ah_attr, (le32_to_cpu(ah->av.sl_tclass_flowlabel) >>
-				 HNS_ROCE_SL_SHIFT));
-	rdma_ah_set_port_num(ah_attr, (le32_to_cpu(ah->av.port_pd) >>
-				       HNS_ROCE_PORT_NUM_SHIFT));
+	rdma_ah_set_sl(ah_attr, ah->av.sl);
+	rdma_ah_set_port_num(ah_attr, ah->av.port);
 	rdma_ah_set_static_rate(ah_attr, ah->av.stat_rate);
-	rdma_ah_set_grh(ah_attr, NULL,
-			(le32_to_cpu(ah->av.sl_tclass_flowlabel) &
-			 HNS_ROCE_FLOW_LABEL_MASK), ah->av.gid_index,
-			ah->av.hop_limit,
-			(le32_to_cpu(ah->av.sl_tclass_flowlabel) >>
-			 HNS_ROCE_TCLASS_SHIFT));
+	rdma_ah_set_grh(ah_attr, NULL, ah->av.flowlabel,
+			ah->av.gid_index, ah->av.hop_limit, ah->av.tclass);
 	rdma_ah_set_dgid_raw(ah_attr, ah->av.dgid);
 
 	return 0;
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index c7bf738..011e038 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -568,14 +568,16 @@ struct hns_roce_raq_table {
 };
 
 struct hns_roce_av {
-	__le32      port_pd;
+	u8          port;
 	u8          gid_index;
 	u8          stat_rate;
 	u8          hop_limit;
-	__le32      sl_tclass_flowlabel;
+	u32         flowlabel;
+	u8          sl;
+	u8          tclass;
 	u8          dgid[HNS_ROCE_GID_SIZE];
 	u8          mac[ETH_ALEN];
-	__le16      vlan;
+	u16         vlan;
 	bool	    vlan_en;
 };
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 0ff5f96..d5be11a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -175,13 +175,11 @@ static int hns_roce_v1_post_send(struct ib_qp *ibqp,
 			roce_set_field(ud_sq_wqe->u32_36,
 				       UD_SEND_WQE_U32_36_FLOW_LABEL_M,
 				       UD_SEND_WQE_U32_36_FLOW_LABEL_S,
-				       ah->av.sl_tclass_flowlabel &
-				       HNS_ROCE_FLOW_LABEL_MASK);
+				       ah->av.flowlabel);
 			roce_set_field(ud_sq_wqe->u32_36,
 				      UD_SEND_WQE_U32_36_PRIORITY_M,
 				      UD_SEND_WQE_U32_36_PRIORITY_S,
-				      le32_to_cpu(ah->av.sl_tclass_flowlabel) >>
-				      HNS_ROCE_SL_SHIFT);
+				      ah->av.sl);
 			roce_set_field(ud_sq_wqe->u32_36,
 				       UD_SEND_WQE_U32_36_SGID_INDEX_M,
 				       UD_SEND_WQE_U32_36_SGID_INDEX_S,
@@ -195,8 +193,7 @@ static int hns_roce_v1_post_send(struct ib_qp *ibqp,
 			roce_set_field(ud_sq_wqe->u32_40,
 				       UD_SEND_WQE_U32_40_TRAFFIC_CLASS_M,
 				       UD_SEND_WQE_U32_40_TRAFFIC_CLASS_S,
-				       ah->av.sl_tclass_flowlabel >>
-				       HNS_ROCE_TCLASS_SHIFT);
+				       ah->av.tclass);
 
 			memcpy(&ud_sq_wqe->dgid[0], &ah->av.dgid[0], GID_LEN);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 206dfdb..67e56b8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -397,18 +397,15 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 			roce_set_field(ud_sq_wqe->byte_36,
 				       V2_UD_SEND_WQE_BYTE_36_TCLASS_M,
 				       V2_UD_SEND_WQE_BYTE_36_TCLASS_S,
-				       ah->av.sl_tclass_flowlabel >>
-				       HNS_ROCE_TCLASS_SHIFT);
+				       ah->av.tclass);
 			roce_set_field(ud_sq_wqe->byte_40,
 				       V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_M,
 				       V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_S,
-				       ah->av.sl_tclass_flowlabel &
-				       HNS_ROCE_FLOW_LABEL_MASK);
+				       ah->av.flowlabel);
 			roce_set_field(ud_sq_wqe->byte_40,
 				       V2_UD_SEND_WQE_BYTE_40_SL_M,
 				       V2_UD_SEND_WQE_BYTE_40_SL_S,
-				      le32_to_cpu(ah->av.sl_tclass_flowlabel) >>
-				      HNS_ROCE_SL_SHIFT);
+				       ah->av.sl);
 			roce_set_field(ud_sq_wqe->byte_40,
 				       V2_UD_SEND_WQE_BYTE_40_PORTN_M,
 				       V2_UD_SEND_WQE_BYTE_40_PORTN_S,
-- 
2.8.1

