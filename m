Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493C924D195
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Aug 2020 11:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgHUJco (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Aug 2020 05:32:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10251 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727898AbgHUJcm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 21 Aug 2020 05:32:42 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 61901497F416D0DC1556;
        Fri, 21 Aug 2020 17:32:39 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Fri, 21 Aug 2020 17:32:30 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Get udp sport num dynamically instead of using a fixed value
Date:   Fri, 21 Aug 2020 17:31:29 +0800
Message-ID: <1598002289-8611-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The UDP source port number in RoCE v2 is used to create entropy for network
routers (ECMP), load balancers and 802.3ad link aggregation switching that
are not aware of RoCE IB headers. Considering that the IB core has achieved
a new interface to get a hashed value of it，the fixed value of it in QPC
and UD WQE in hns driver could be fixed and the port number is to be set
dynamically now.

For QPC of RC, the value could be hashed from flow_lable if the user pass
it in or from remote qpn and local qpn. For WQE of UD, it is set according
to fl or as a random value.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_ah.c     | 18 ++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_device.h | 23 ++++++++++++-----------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 13 +++++++++++--
 include/rdma/ib_verbs.h                     |  1 +
 4 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_ah.c b/drivers/infiniband/hw/hns/hns_roce_ah.c
index 5b2f9314..54cadbc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_ah.c
+++ b/drivers/infiniband/hw/hns/hns_roce_ah.c
@@ -39,6 +39,22 @@
 #define HNS_ROCE_VLAN_SL_BIT_MASK	7
 #define HNS_ROCE_VLAN_SL_SHIFT		13
 
+static inline u16 get_ah_udp_sport(const struct rdma_ah_attr *ah_attr)
+{
+	u32 fl = ah_attr->grh.flow_label;
+	u16 sport;
+
+	if (!fl)
+		sport = get_random_u32() %
+			(IB_ROCE_UDP_ENCAP_VALID_PORT_MAX + 1 -
+			 IB_ROCE_UDP_ENCAP_VALID_PORT_MIN) +
+			IB_ROCE_UDP_ENCAP_VALID_PORT_MIN;
+	else
+		sport = rdma_flow_label_to_udp_sport(fl);
+
+	return sport;
+}
+
 int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 		       struct ib_udata *udata)
 {
@@ -79,6 +95,8 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 
 	memcpy(ah->av.dgid, grh->dgid.raw, HNS_ROCE_GID_SIZE);
 	ah->av.sl = rdma_ah_get_sl(ah_attr);
+	ah->av.flowlabel = grh->flow_label;
+	ah->av.udp_sport = get_ah_udp_sport(ah_attr);
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index da9888d..8d92d8d8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -537,17 +537,18 @@ struct hns_roce_raq_table {
 };
 
 struct hns_roce_av {
-	u8          port;
-	u8          gid_index;
-	u8          stat_rate;
-	u8          hop_limit;
-	u32         flowlabel;
-	u8          sl;
-	u8          tclass;
-	u8          dgid[HNS_ROCE_GID_SIZE];
-	u8          mac[ETH_ALEN];
-	u16         vlan_id;
-	bool	    vlan_en;
+	u8 port;
+	u8 gid_index;
+	u8 stat_rate;
+	u8 hop_limit;
+	u32 flowlabel;
+	u16 udp_sport;
+	u8 sl;
+	u8 tclass;
+	u8 dgid[HNS_ROCE_GID_SIZE];
+	u8 mac[ETH_ALEN];
+	u16 vlan_id;
+	bool vlan_en;
 };
 
 struct hns_roce_ah {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d296859..4da553d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -369,7 +369,7 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
 		       curr_idx & (qp->sge.sge_cnt - 1));
 
 	roce_set_field(ud_sq_wqe->byte_24, V2_UD_SEND_WQE_BYTE_24_UDPSPN_M,
-		       V2_UD_SEND_WQE_BYTE_24_UDPSPN_S, 0);
+		       V2_UD_SEND_WQE_BYTE_24_UDPSPN_S, ah->av.udp_sport);
 	ud_sq_wqe->qkey = cpu_to_le32(ud_wr(wr)->remote_qkey & 0x80000000 ?
 			  qp->qkey : ud_wr(wr)->remote_qkey);
 	roce_set_field(ud_sq_wqe->byte_32, V2_UD_SEND_WQE_BYTE_32_DQPN_M,
@@ -4165,6 +4165,14 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
 	return 0;
 }
 
+static inline u16 get_udp_sport(u32 fl, u32 lqpn, u32 rqpn)
+{
+	if (!fl)
+		fl = rdma_calc_flow_label(lqpn, rqpn);
+
+	return rdma_flow_label_to_udp_sport(fl);
+}
+
 static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 				const struct ib_qp_attr *attr,
 				int attr_mask,
@@ -4228,7 +4236,8 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 
 	roce_set_field(context->byte_52_udpspn_dmac, V2_QPC_BYTE_52_UDPSPN_M,
 		       V2_QPC_BYTE_52_UDPSPN_S,
-		       is_udp ? 0x12b7 : 0);
+		       is_udp ? get_udp_sport(grh->flow_label, ibqp->qp_num,
+					      attr->dest_qp_num) : 0);
 
 	roce_set_field(qpc_mask->byte_52_udpspn_dmac, V2_QPC_BYTE_52_UDPSPN_M,
 		       V2_QPC_BYTE_52_UDPSPN_S, 0);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 55dfe0e..c868609 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4706,6 +4706,7 @@ bool rdma_dev_access_netns(const struct ib_device *device,
 			   const struct net *net);
 
 #define IB_ROCE_UDP_ENCAP_VALID_PORT_MIN (0xC000)
+#define IB_ROCE_UDP_ENCAP_VALID_PORT_MAX (0xFFFF)
 #define IB_GRH_FLOWLABEL_MASK (0x000FFFFF)
 
 /**
-- 
2.8.1

