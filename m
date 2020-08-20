Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1606524BE88
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Aug 2020 15:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730751AbgHTNX3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 09:23:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9797 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729511AbgHTNTA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Aug 2020 09:19:00 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8179FE49FF142BEDB06C;
        Thu, 20 Aug 2020 21:18:56 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Thu, 20 Aug 2020 21:18:49 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 2/4] RDMA/hns: Add support for EQE in size of 64 Bytes
Date:   Thu, 20 Aug 2020 21:17:47 +0800
Message-ID: <1597929469-22674-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1597929469-22674-1-git-send-email-liweihang@huawei.com>
References: <1597929469-22674-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

The new version of RoCEE supports using CEQE in size of 4B or 64B, AEQE in
size of 16B or 64B. The performance of bus can be improved by using larger
size of EQE.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 14 ++++++++----
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  | 10 ++++-----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 33 ++++++++++++++++++++++-------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  7 ++++--
 4 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index da9888d..d871451 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -37,8 +37,8 @@
 
 #define DRV_NAME "hns_roce"
 
-/* hip08 is a pci device */
 #define PCI_REVISION_ID_HIP08			0x21
+#define PCI_REVISION_ID_HIP09			0x30
 
 #define HNS_ROCE_HW_VER1	('h' << 24 | 'i' << 16 | '0' << 8 | '6')
 
@@ -78,8 +78,10 @@
 #define HNS_ROCE_CEQ				0
 #define HNS_ROCE_AEQ				1
 
-#define HNS_ROCE_CEQ_ENTRY_SIZE			0x4
-#define HNS_ROCE_AEQ_ENTRY_SIZE			0x10
+#define HNS_ROCE_CEQE_SIZE 0x4
+#define HNS_ROCE_AEQE_SIZE 0x10
+
+#define HNS_ROCE_V3_EQE_SIZE 0x40
 
 #define HNS_ROCE_SL_SHIFT			28
 #define HNS_ROCE_TCLASS_SHIFT			20
@@ -680,7 +682,8 @@ enum {
 };
 
 struct hns_roce_ceqe {
-	__le32			comp;
+	__le32	comp;
+	__le32	rsv[15];
 };
 
 struct hns_roce_aeqe {
@@ -717,6 +720,7 @@ struct hns_roce_aeqe {
 			u8	rsv0;
 		} __packed cmd;
 	 } event;
+	__le32 rsv[12];
 };
 
 struct hns_roce_eq {
@@ -811,6 +815,8 @@ struct hns_roce_caps {
 	u32		pbl_hop_num;
 	int		aeqe_depth;
 	int		ceqe_depth;
+	u32		aeqe_size;
+	u32		ceqe_size;
 	enum ib_mtu	max_mtu;
 	u32		qpc_bt_num;
 	u32		qpc_timer_bt_num;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 07b4c85..ae9a0ef 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -3775,8 +3775,7 @@ static void hns_roce_v1_db_overflow_handle(struct hns_roce_dev *hr_dev,
 
 static struct hns_roce_aeqe *get_aeqe_v1(struct hns_roce_eq *eq, u32 entry)
 {
-	unsigned long off = (entry & (eq->entries - 1)) *
-			     HNS_ROCE_AEQ_ENTRY_SIZE;
+	unsigned long off = (entry & (eq->entries - 1)) * HNS_ROCE_AEQE_SIZE;
 
 	return (struct hns_roce_aeqe *)((u8 *)
 		(eq->buf_list[off / HNS_ROCE_BA_SIZE].buf) +
@@ -3881,8 +3880,7 @@ static int hns_roce_v1_aeq_int(struct hns_roce_dev *hr_dev,
 
 static struct hns_roce_ceqe *get_ceqe_v1(struct hns_roce_eq *eq, u32 entry)
 {
-	unsigned long off = (entry & (eq->entries - 1)) *
-			     HNS_ROCE_CEQ_ENTRY_SIZE;
+	unsigned long off = (entry & (eq->entries - 1)) * HNS_ROCE_CEQE_SIZE;
 
 	return (struct hns_roce_ceqe *)((u8 *)
 			(eq->buf_list[off / HNS_ROCE_BA_SIZE].buf) +
@@ -4253,7 +4251,7 @@ static int hns_roce_v1_init_eq_table(struct hns_roce_dev *hr_dev)
 				       CEQ_REG_OFFSET * i;
 			eq->entries = hr_dev->caps.ceqe_depth;
 			eq->log_entries = ilog2(eq->entries);
-			eq->eqe_size = HNS_ROCE_CEQ_ENTRY_SIZE;
+			eq->eqe_size = HNS_ROCE_CEQE_SIZE;
 		} else {
 			/* AEQ */
 			eq_table->eqc_base[i] = hr_dev->reg_base +
@@ -4263,7 +4261,7 @@ static int hns_roce_v1_init_eq_table(struct hns_roce_dev *hr_dev)
 				       ROCEE_CAEP_AEQE_CONS_IDX_REG;
 			eq->entries = hr_dev->caps.aeqe_depth;
 			eq->log_entries = ilog2(eq->entries);
-			eq->eqe_size = HNS_ROCE_AEQ_ENTRY_SIZE;
+			eq->eqe_size = HNS_ROCE_AEQE_SIZE;
 		}
 	}
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d296859..ea007e8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1740,6 +1740,8 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->gid_table_len[0]	= HNS_ROCE_V2_GID_INDEX_NUM;
 	caps->ceqe_depth	= HNS_ROCE_V2_COMP_EQE_NUM;
 	caps->aeqe_depth	= HNS_ROCE_V2_ASYNC_EQE_NUM;
+	caps->aeqe_size		= HNS_ROCE_AEQE_SIZE;
+	caps->ceqe_size		= HNS_ROCE_CEQE_SIZE;
 	caps->local_ca_ack_delay = 0;
 	caps->max_mtu = IB_MTU_4096;
 
@@ -1765,6 +1767,11 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->sccc_ba_pg_sz	  = 0;
 	caps->sccc_buf_pg_sz	  = 0;
 	caps->sccc_hop_num	  = HNS_ROCE_SCCC_HOP_NUM;
+
+	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09) {
+		caps->aeqe_size = HNS_ROCE_V3_EQE_SIZE;
+		caps->ceqe_size = HNS_ROCE_V3_EQE_SIZE;
+	}
 }
 
 static void calc_pg_sz(int obj_num, int obj_size, int hop_num, int ctx_bt_num,
@@ -1959,6 +1966,8 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	caps->cqc_timer_entry_sz = HNS_ROCE_V2_CQC_TIMER_ENTRY_SZ;
 	caps->mtt_entry_sz = HNS_ROCE_V2_MTT_ENTRY_SZ;
 	caps->num_mtt_segs = HNS_ROCE_V2_MAX_MTT_SEGS;
+	caps->ceqe_size = HNS_ROCE_CEQE_SIZE;
+	caps->aeqe_size = HNS_ROCE_AEQE_SIZE;
 	caps->mtt_ba_pg_sz = 0;
 	caps->num_cqe_segs = HNS_ROCE_V2_MAX_CQE_SEGS;
 	caps->num_srqwqe_segs = HNS_ROCE_V2_MAX_SRQWQE_SEGS;
@@ -1982,6 +1991,11 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 					  V2_QUERY_PF_CAPS_D_RQWQE_HOP_NUM_M,
 					  V2_QUERY_PF_CAPS_D_RQWQE_HOP_NUM_S);
 
+	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09) {
+		caps->ceqe_size = HNS_ROCE_V3_EQE_SIZE;
+		caps->aeqe_size = HNS_ROCE_V3_EQE_SIZE;
+	}
+
 	calc_pg_sz(caps->num_qps, caps->qpc_entry_sz, caps->qpc_hop_num,
 		   caps->qpc_bt_num, &caps->qpc_buf_pg_sz, &caps->qpc_ba_pg_sz,
 		   HEM_TYPE_QPC);
@@ -5234,7 +5248,7 @@ static struct hns_roce_aeqe *next_aeqe_sw_v2(struct hns_roce_eq *eq)
 
 	aeqe = hns_roce_buf_offset(eq->mtr.kmem,
 				   (eq->cons_index & (eq->entries - 1)) *
-				   HNS_ROCE_AEQ_ENTRY_SIZE);
+				   eq->eqe_size);
 
 	return (roce_get_bit(aeqe->asyn, HNS_ROCE_V2_AEQ_AEQE_OWNER_S) ^
 		!!(eq->cons_index & eq->entries)) ? aeqe : NULL;
@@ -5334,7 +5348,8 @@ static struct hns_roce_ceqe *next_ceqe_sw_v2(struct hns_roce_eq *eq)
 
 	ceqe = hns_roce_buf_offset(eq->mtr.kmem,
 				   (eq->cons_index & (eq->entries - 1)) *
-				   HNS_ROCE_CEQ_ENTRY_SIZE);
+				   eq->eqe_size);
+
 	return (!!(roce_get_bit(ceqe->comp, HNS_ROCE_V2_CEQ_CEQE_OWNER_S))) ^
 		(!!(eq->cons_index & eq->entries)) ? ceqe : NULL;
 }
@@ -5610,14 +5625,16 @@ static int config_eqc(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq,
 	roce_set_field(eqc->byte_36, HNS_ROCE_EQC_CONS_INDX_M,
 		       HNS_ROCE_EQC_CONS_INDX_S, HNS_ROCE_EQ_INIT_CONS_IDX);
 
-	/* set nex_eqe_ba[43:12] */
-	roce_set_field(eqc->nxt_eqe_ba0, HNS_ROCE_EQC_NXT_EQE_BA_L_M,
+	roce_set_field(eqc->byte_40, HNS_ROCE_EQC_NXT_EQE_BA_L_M,
 		       HNS_ROCE_EQC_NXT_EQE_BA_L_S, eqe_ba[1] >> 12);
 
-	/* set nex_eqe_ba[63:44] */
-	roce_set_field(eqc->nxt_eqe_ba1, HNS_ROCE_EQC_NXT_EQE_BA_H_M,
+	roce_set_field(eqc->byte_44, HNS_ROCE_EQC_NXT_EQE_BA_H_M,
 		       HNS_ROCE_EQC_NXT_EQE_BA_H_S, eqe_ba[1] >> 44);
 
+	roce_set_field(eqc->byte_44, HNS_ROCE_EQC_EQE_SIZE_M,
+		       HNS_ROCE_EQC_EQE_SIZE_S,
+		       eq->eqe_size == HNS_ROCE_V3_EQE_SIZE ? 1 : 0);
+
 	return 0;
 }
 
@@ -5808,7 +5825,7 @@ static int hns_roce_v2_init_eq_table(struct hns_roce_dev *hr_dev)
 			eq_cmd = HNS_ROCE_CMD_CREATE_CEQC;
 			eq->type_flag = HNS_ROCE_CEQ;
 			eq->entries = hr_dev->caps.ceqe_depth;
-			eq->eqe_size = HNS_ROCE_CEQ_ENTRY_SIZE;
+			eq->eqe_size = hr_dev->caps.ceqe_size;
 			eq->irq = hr_dev->irq[i + other_num + aeq_num];
 			eq->eq_max_cnt = HNS_ROCE_CEQ_DEFAULT_BURST_NUM;
 			eq->eq_period = HNS_ROCE_CEQ_DEFAULT_INTERVAL;
@@ -5817,7 +5834,7 @@ static int hns_roce_v2_init_eq_table(struct hns_roce_dev *hr_dev)
 			eq_cmd = HNS_ROCE_CMD_CREATE_AEQC;
 			eq->type_flag = HNS_ROCE_AEQ;
 			eq->entries = hr_dev->caps.aeqe_depth;
-			eq->eqe_size = HNS_ROCE_AEQ_ENTRY_SIZE;
+			eq->eqe_size = hr_dev->caps.aeqe_size;
 			eq->irq = hr_dev->irq[i - comp_num + other_num];
 			eq->eq_max_cnt = HNS_ROCE_AEQ_DEFAULT_BURST_NUM;
 			eq->eq_period = HNS_ROCE_AEQ_DEFAULT_INTERVAL;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 1fb1c58..9ed3339 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1779,8 +1779,8 @@ struct hns_roce_eq_context {
 	__le32	byte_28;
 	__le32	byte_32;
 	__le32	byte_36;
-	__le32	nxt_eqe_ba0;
-	__le32	nxt_eqe_ba1;
+	__le32	byte_40;
+	__le32	byte_44;
 	__le32	rsv[5];
 };
 
@@ -1922,6 +1922,9 @@ struct hns_roce_eq_context {
 #define HNS_ROCE_EQC_NXT_EQE_BA_H_S 0
 #define HNS_ROCE_EQC_NXT_EQE_BA_H_M GENMASK(19, 0)
 
+#define HNS_ROCE_EQC_EQE_SIZE_S 20
+#define HNS_ROCE_EQC_EQE_SIZE_M GENMASK(21, 20)
+
 #define HNS_ROCE_V2_CEQE_COMP_CQN_S 0
 #define HNS_ROCE_V2_CEQE_COMP_CQN_M GENMASK(23, 0)
 
-- 
2.8.1

