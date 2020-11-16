Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F414D2B42ED
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 12:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgKPLfP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 06:35:15 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7913 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgKPLfP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Nov 2020 06:35:15 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CZRnY07Glz6wkS;
        Mon, 16 Nov 2020 19:34:57 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Nov 2020 19:35:03 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 5/7] RDMA/hns: Simplify process of filling UD SQ WQE
Date:   Mon, 16 Nov 2020 19:33:26 +0800
Message-ID: <1605526408-6936-6-git-send-email-liweihang@huawei.com>
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

There are some codes can be simplified or encapsulated in set_ud_wqe() to
make them easier to be understand.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 83 ++++++++++++++----------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 29 ++---------
 2 files changed, 43 insertions(+), 69 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index f4358d2..273d968 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -422,16 +422,49 @@ static int set_ud_opcode(struct hns_roce_v2_ud_send_wqe *ud_sq_wqe,
 	return 0;
 }
 
+static int fill_ud_av(struct hns_roce_v2_ud_send_wqe *ud_sq_wqe,
+		      struct hns_roce_ah *ah)
+{
+	struct ib_device *ib_dev = ah->ibah.device;
+	struct hns_roce_dev *hr_dev = to_hr_dev(ib_dev);
+
+	roce_set_field(ud_sq_wqe->byte_24, V2_UD_SEND_WQE_BYTE_24_UDPSPN_M,
+		       V2_UD_SEND_WQE_BYTE_24_UDPSPN_S, ah->av.udp_sport);
+
+	roce_set_field(ud_sq_wqe->byte_36, V2_UD_SEND_WQE_BYTE_36_HOPLIMIT_M,
+		       V2_UD_SEND_WQE_BYTE_36_HOPLIMIT_S, ah->av.hop_limit);
+	roce_set_field(ud_sq_wqe->byte_36, V2_UD_SEND_WQE_BYTE_36_TCLASS_M,
+		       V2_UD_SEND_WQE_BYTE_36_TCLASS_S, ah->av.tclass);
+	roce_set_field(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_M,
+		       V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_S, ah->av.flowlabel);
+	roce_set_field(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_SL_M,
+		       V2_UD_SEND_WQE_BYTE_40_SL_S, ah->av.sl);
+
+	ud_sq_wqe->sgid_index = ah->av.gid_index;
+
+	memcpy(ud_sq_wqe->dmac, ah->av.mac, ETH_ALEN);
+	memcpy(ud_sq_wqe->dgid, ah->av.dgid, GID_LEN_V2);
+
+	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
+		return 0;
+
+	roce_set_bit(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_UD_VLAN_EN_S,
+		     ah->av.vlan_en);
+	roce_set_field(ud_sq_wqe->byte_36, V2_UD_SEND_WQE_BYTE_36_VLAN_M,
+		       V2_UD_SEND_WQE_BYTE_36_VLAN_S, ah->av.vlan_id);
+
+	return 0;
+}
+
 static inline int set_ud_wqe(struct hns_roce_qp *qp,
 			     const struct ib_send_wr *wr,
 			     void *wqe, unsigned int *sge_idx,
 			     unsigned int owner_bit)
 {
-	struct hns_roce_dev *hr_dev = to_hr_dev(qp->ibqp.device);
 	struct hns_roce_ah *ah = to_hr_ah(ud_wr(wr)->ah);
 	struct hns_roce_v2_ud_send_wqe *ud_sq_wqe = wqe;
 	unsigned int curr_idx = *sge_idx;
-	int valid_num_sge;
+	unsigned int valid_num_sge;
 	u32 msg_len = 0;
 	int ret;
 
@@ -442,28 +475,13 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
 	if (WARN_ON(ret))
 		return ret;
 
-	roce_set_field(ud_sq_wqe->dmac, V2_UD_SEND_WQE_DMAC_0_M,
-		       V2_UD_SEND_WQE_DMAC_0_S, ah->av.mac[0]);
-	roce_set_field(ud_sq_wqe->dmac, V2_UD_SEND_WQE_DMAC_1_M,
-		       V2_UD_SEND_WQE_DMAC_1_S, ah->av.mac[1]);
-	roce_set_field(ud_sq_wqe->dmac, V2_UD_SEND_WQE_DMAC_2_M,
-		       V2_UD_SEND_WQE_DMAC_2_S, ah->av.mac[2]);
-	roce_set_field(ud_sq_wqe->dmac, V2_UD_SEND_WQE_DMAC_3_M,
-		       V2_UD_SEND_WQE_DMAC_3_S, ah->av.mac[3]);
-	roce_set_field(ud_sq_wqe->byte_48, V2_UD_SEND_WQE_BYTE_48_DMAC_4_M,
-		       V2_UD_SEND_WQE_BYTE_48_DMAC_4_S, ah->av.mac[4]);
-	roce_set_field(ud_sq_wqe->byte_48, V2_UD_SEND_WQE_BYTE_48_DMAC_5_M,
-		       V2_UD_SEND_WQE_BYTE_48_DMAC_5_S, ah->av.mac[5]);
-
 	ud_sq_wqe->msg_len = cpu_to_le32(msg_len);
 
-	/* Set sig attr */
 	roce_set_bit(ud_sq_wqe->byte_4, V2_UD_SEND_WQE_BYTE_4_CQE_S,
-		     (wr->send_flags & IB_SEND_SIGNALED) ? 1 : 0);
+		     !!(wr->send_flags & IB_SEND_SIGNALED));
 
-	/* Set se attr */
 	roce_set_bit(ud_sq_wqe->byte_4, V2_UD_SEND_WQE_BYTE_4_SE_S,
-		     (wr->send_flags & IB_SEND_SOLICITED) ? 1 : 0);
+		     !!(wr->send_flags & IB_SEND_SOLICITED));
 
 	roce_set_field(ud_sq_wqe->byte_16, V2_UD_SEND_WQE_BYTE_16_PD_M,
 		       V2_UD_SEND_WQE_BYTE_16_PD_S, to_hr_pd(qp->ibqp.pd)->pdn);
@@ -476,35 +494,14 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
 		       V2_UD_SEND_WQE_BYTE_20_MSG_START_SGE_IDX_S,
 		       curr_idx & (qp->sge.sge_cnt - 1));
 
-	roce_set_field(ud_sq_wqe->byte_24, V2_UD_SEND_WQE_BYTE_24_UDPSPN_M,
-		       V2_UD_SEND_WQE_BYTE_24_UDPSPN_S, ah->av.udp_sport);
 	ud_sq_wqe->qkey = cpu_to_le32(ud_wr(wr)->remote_qkey & 0x80000000 ?
 			  qp->qkey : ud_wr(wr)->remote_qkey);
 	roce_set_field(ud_sq_wqe->byte_32, V2_UD_SEND_WQE_BYTE_32_DQPN_M,
 		       V2_UD_SEND_WQE_BYTE_32_DQPN_S, ud_wr(wr)->remote_qpn);
 
-	roce_set_field(ud_sq_wqe->byte_36, V2_UD_SEND_WQE_BYTE_36_HOPLIMIT_M,
-		       V2_UD_SEND_WQE_BYTE_36_HOPLIMIT_S, ah->av.hop_limit);
-	roce_set_field(ud_sq_wqe->byte_36, V2_UD_SEND_WQE_BYTE_36_TCLASS_M,
-		       V2_UD_SEND_WQE_BYTE_36_TCLASS_S, ah->av.tclass);
-	roce_set_field(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_M,
-		       V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_S, ah->av.flowlabel);
-	roce_set_field(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_SL_M,
-		       V2_UD_SEND_WQE_BYTE_40_SL_S, ah->av.sl);
-
-	roce_set_field(ud_sq_wqe->byte_48, V2_UD_SEND_WQE_BYTE_48_SGID_INDX_M,
-		       V2_UD_SEND_WQE_BYTE_48_SGID_INDX_S, ah->av.gid_index);
-
-	if (hr_dev->pci_dev->revision <= PCI_REVISION_ID_HIP08) {
-		roce_set_bit(ud_sq_wqe->byte_40,
-			     V2_UD_SEND_WQE_BYTE_40_UD_VLAN_EN_S,
-			     ah->av.vlan_en);
-		roce_set_field(ud_sq_wqe->byte_36,
-			       V2_UD_SEND_WQE_BYTE_36_VLAN_M,
-			       V2_UD_SEND_WQE_BYTE_36_VLAN_S, ah->av.vlan_id);
-	}
-
-	memcpy(&ud_sq_wqe->dgid[0], &ah->av.dgid[0], GID_LEN_V2);
+	ret = fill_ud_av(ud_sq_wqe, ah);
+	if (ret)
+		return ret;
 
 	set_extend_sge(qp, wr, &curr_idx, valid_num_sge);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 1466888..c068517 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1077,8 +1077,9 @@ struct hns_roce_v2_ud_send_wqe {
 	__le32	byte_32;
 	__le32	byte_36;
 	__le32	byte_40;
-	__le32	dmac;
-	__le32	byte_48;
+	u8	dmac[ETH_ALEN];
+	u8	sgid_index;
+	u8	smac_index;
 	u8	dgid[GID_LEN_V2];
 
 };
@@ -1125,30 +1126,6 @@ struct hns_roce_v2_ud_send_wqe {
 
 #define	V2_UD_SEND_WQE_BYTE_40_LBI_S 31
 
-#define	V2_UD_SEND_WQE_DMAC_0_S 0
-#define V2_UD_SEND_WQE_DMAC_0_M GENMASK(7, 0)
-
-#define	V2_UD_SEND_WQE_DMAC_1_S 8
-#define V2_UD_SEND_WQE_DMAC_1_M GENMASK(15, 8)
-
-#define	V2_UD_SEND_WQE_DMAC_2_S 16
-#define V2_UD_SEND_WQE_DMAC_2_M GENMASK(23, 16)
-
-#define	V2_UD_SEND_WQE_DMAC_3_S 24
-#define V2_UD_SEND_WQE_DMAC_3_M GENMASK(31, 24)
-
-#define	V2_UD_SEND_WQE_BYTE_48_DMAC_4_S 0
-#define V2_UD_SEND_WQE_BYTE_48_DMAC_4_M GENMASK(7, 0)
-
-#define	V2_UD_SEND_WQE_BYTE_48_DMAC_5_S 8
-#define V2_UD_SEND_WQE_BYTE_48_DMAC_5_M GENMASK(15, 8)
-
-#define	V2_UD_SEND_WQE_BYTE_48_SGID_INDX_S 16
-#define V2_UD_SEND_WQE_BYTE_48_SGID_INDX_M GENMASK(23, 16)
-
-#define	V2_UD_SEND_WQE_BYTE_48_SMAC_INDX_S 24
-#define V2_UD_SEND_WQE_BYTE_48_SMAC_INDX_M GENMASK(31, 24)
-
 struct hns_roce_v2_rc_send_wqe {
 	__le32		byte_4;
 	__le32		msg_len;
-- 
2.8.1

