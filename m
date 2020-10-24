Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE153297A76
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Oct 2020 05:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759253AbgJXDIv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Oct 2020 23:08:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2172 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1759231AbgJXDIv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 23 Oct 2020 23:08:51 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0809FEC99A265292CFF3;
        Sat, 24 Oct 2020 11:08:48 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Sat, 24 Oct 2020 11:08:37 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 1/2] RDMA/hns: Add support for configuring GMV table
Date:   Sat, 24 Oct 2020 11:07:15 +0800
Message-ID: <1603508836-33054-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1603508836-33054-1-git-send-email-liweihang@huawei.com>
References: <1603508836-33054-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

HIP09 supports to store SGID/SMAC/VLAN together in a table named GMV. The
driver needs to allocate memory for it and tell the information about this
region to hardware.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  10 +++
 drivers/infiniband/hw/hns/hns_roce_hem.c    |  15 ++++
 drivers/infiniband/hw/hns/hns_roce_hem.h    |   1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 115 +++++++++++++++++++++-------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  29 ++++++-
 drivers/infiniband/hw/hns/hns_roce_main.c   |  17 ++++
 6 files changed, 159 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 6d2acff..ab126b4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -825,6 +825,7 @@ struct hns_roce_caps {
 	u32		cqc_timer_bt_num;
 	u32		mpt_bt_num;
 	u32		sccc_bt_num;
+	u32		gmv_bt_num;
 	u32		qpc_ba_pg_sz;
 	u32		qpc_buf_pg_sz;
 	u32		qpc_hop_num;
@@ -864,6 +865,11 @@ struct hns_roce_caps {
 	u32		eqe_ba_pg_sz;
 	u32		eqe_buf_pg_sz;
 	u32		eqe_hop_num;
+	u32		gmv_entry_num;
+	u32		gmv_entry_sz;
+	u32		gmv_ba_pg_sz;
+	u32		gmv_buf_pg_sz;
+	u32		gmv_hop_num;
 	u32		sl_num;
 	u32		tsq_buf_pg_sz;
 	u32		tpq_buf_pg_sz;
@@ -999,6 +1005,10 @@ struct hns_roce_dev {
 	struct hns_roce_eq_table  eq_table;
 	struct hns_roce_hem_table  qpc_timer_table;
 	struct hns_roce_hem_table  cqc_timer_table;
+	/* GMV is the memory area that the driver allocates for the hardware
+	 * to store SGID, SMAC and VLAN information.
+	 */
+	struct hns_roce_hem_table  gmv_table;
 
 	int			cmd_mod;
 	int			loop_idc;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index 7487cf3..5c302ae 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -75,6 +75,9 @@ bool hns_roce_check_whether_mhop(struct hns_roce_dev *hr_dev, u32 type)
 	case HEM_TYPE_CQC_TIMER:
 		hop_num = hr_dev->caps.cqc_timer_hop_num;
 		break;
+	case HEM_TYPE_GMV:
+		hop_num = hr_dev->caps.gmv_hop_num;
+		break;
 	default:
 		return false;
 	}
@@ -183,6 +186,14 @@ static int get_hem_table_config(struct hns_roce_dev *hr_dev,
 		mhop->ba_l0_num = hr_dev->caps.srqc_bt_num;
 		mhop->hop_num = hr_dev->caps.srqc_hop_num;
 		break;
+	case HEM_TYPE_GMV:
+		mhop->buf_chunk_size = 1 << (hr_dev->caps.gmv_buf_pg_sz +
+					     PAGE_SHIFT);
+		mhop->bt_chunk_size = 1 << (hr_dev->caps.gmv_ba_pg_sz +
+					    PAGE_SHIFT);
+		mhop->ba_l0_num = hr_dev->caps.gmv_bt_num;
+		mhop->hop_num = hr_dev->caps.gmv_hop_num;
+		break;
 	default:
 		dev_err(dev, "Table %d not support multi-hop addressing!\n",
 			type);
@@ -1033,6 +1044,10 @@ void hns_roce_cleanup_hem(struct hns_roce_dev *hr_dev)
 	if (hr_dev->caps.trrl_entry_sz)
 		hns_roce_cleanup_hem_table(hr_dev,
 					   &hr_dev->qp_table.trrl_table);
+
+	if (hr_dev->caps.gmv_entry_sz)
+		hns_roce_cleanup_hem_table(hr_dev, &hr_dev->gmv_table);
+
 	hns_roce_cleanup_hem_table(hr_dev, &hr_dev->qp_table.irrl_table);
 	hns_roce_cleanup_hem_table(hr_dev, &hr_dev->qp_table.qp_table);
 	hns_roce_cleanup_hem_table(hr_dev, &hr_dev->mr_table.mtpt_table);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.h b/drivers/infiniband/hw/hns/hns_roce_hem.h
index b34c940..c6bd982 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.h
@@ -47,6 +47,7 @@ enum {
 	HEM_TYPE_SCCC,
 	HEM_TYPE_QPC_TIMER,
 	HEM_TYPE_CQC_TIMER,
+	HEM_TYPE_GMV,
 
 	 /* UNMAP HEM */
 	HEM_TYPE_MTT,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 6d30850..d6b04fd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1573,6 +1573,10 @@ static int hns_roce_query_pf_resource(struct hns_roce_dev *hr_dev)
 					     PF_RES_DATA_4_PF_SCCC_BT_NUM_M,
 					     PF_RES_DATA_4_PF_SCCC_BT_NUM_S);
 
+	hr_dev->caps.gmv_bt_num = roce_get_field(req_b->gmv_idx_num,
+						 PF_RES_DATA_5_PF_GMV_BT_NUM_M,
+						 PF_RES_DATA_5_PF_GMV_BT_NUM_S);
+
 	return 0;
 }
 
@@ -1896,6 +1900,15 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 		caps->ceqe_size = HNS_ROCE_V3_EQE_SIZE;
 		caps->cqe_sz = HNS_ROCE_V3_CQE_SIZE;
 		caps->qpc_sz = HNS_ROCE_V3_QPC_SZ;
+		caps->sccc_sz = HNS_ROCE_V3_SCCC_SZ;
+		caps->gmv_entry_sz = HNS_ROCE_V3_GMV_ENTRY_SZ;
+		caps->gmv_entry_num = caps->gmv_bt_num * (PAGE_SIZE /
+							  caps->gmv_entry_sz);
+		caps->gmv_hop_num = HNS_ROCE_HOP_NUM_0;
+		caps->gmv_ba_pg_sz = 0;
+		caps->gmv_buf_pg_sz = 0;
+		caps->gid_table_len[0] = caps->gmv_bt_num * (HNS_HW_PAGE_SIZE /
+					 caps->gmv_entry_sz);
 	}
 }
 
@@ -2122,6 +2135,14 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 		caps->cqe_sz = HNS_ROCE_V3_CQE_SIZE;
 		caps->qpc_sz = HNS_ROCE_V3_QPC_SZ;
 		caps->sccc_sz = HNS_ROCE_V3_SCCC_SZ;
+		caps->gmv_entry_sz = HNS_ROCE_V3_GMV_ENTRY_SZ;
+		caps->gmv_entry_num = caps->gmv_bt_num * (PAGE_SIZE /
+						    caps->gmv_entry_sz);
+		caps->gmv_hop_num = HNS_ROCE_HOP_NUM_0;
+		caps->gmv_ba_pg_sz = 0;
+		caps->gmv_buf_pg_sz = 0;
+		caps->gid_table_len[0] = caps->gmv_bt_num *
+				(HNS_HW_PAGE_SIZE / caps->gmv_entry_sz);
 	}
 
 	calc_pg_sz(caps->num_qps, caps->qpc_sz, caps->qpc_hop_num,
@@ -2465,24 +2486,13 @@ static void hns_roce_free_link_table(struct hns_roce_dev *hr_dev,
 			  link_tbl->table.map);
 }
 
-static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
+static int get_hem_table(struct hns_roce_dev *hr_dev)
 {
-	struct hns_roce_v2_priv *priv = hr_dev->priv;
-	int qpc_count, cqc_count;
-	int ret, i;
-
-	/* TSQ includes SQ doorbell and ack doorbell */
-	ret = hns_roce_init_link_table(hr_dev, TSQ_LINK_TABLE);
-	if (ret) {
-		dev_err(hr_dev->dev, "TSQ init failed, ret = %d.\n", ret);
-		return ret;
-	}
-
-	ret = hns_roce_init_link_table(hr_dev, TPQ_LINK_TABLE);
-	if (ret) {
-		dev_err(hr_dev->dev, "TPQ init failed, ret = %d.\n", ret);
-		goto err_tpq_init_failed;
-	}
+	unsigned int qpc_count;
+	unsigned int cqc_count;
+	unsigned int gmv_count;
+	int ret;
+	int i;
 
 	/* Alloc memory for QPC Timer buffer space chunk */
 	for (qpc_count = 0; qpc_count < hr_dev->caps.qpc_timer_bt_num;
@@ -2506,8 +2516,23 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
 		}
 	}
 
+	/* Alloc memory for GMV(GID/MAC/VLAN) table buffer space chunk */
+	for (gmv_count = 0; gmv_count < hr_dev->caps.gmv_entry_num;
+	     gmv_count++) {
+		ret = hns_roce_table_get(hr_dev, &hr_dev->gmv_table, gmv_count);
+		if (ret) {
+			dev_err(hr_dev->dev,
+				"failed to get gmv table, ret = %d.\n", ret);
+			goto err_gmv_failed;
+		}
+	}
+
 	return 0;
 
+err_gmv_failed:
+	for (i = 0; i < gmv_count; i++)
+		hns_roce_table_put(hr_dev, &hr_dev->gmv_table, i);
+
 err_cqc_timer_failed:
 	for (i = 0; i < cqc_count; i++)
 		hns_roce_table_put(hr_dev, &hr_dev->cqc_timer_table, i);
@@ -2516,6 +2541,32 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
 	for (i = 0; i < qpc_count; i++)
 		hns_roce_table_put(hr_dev, &hr_dev->qpc_timer_table, i);
 
+	return ret;
+}
+
+static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
+	int ret;
+
+	/* TSQ includes SQ doorbell and ack doorbell */
+	ret = hns_roce_init_link_table(hr_dev, TSQ_LINK_TABLE);
+	if (ret) {
+		dev_err(hr_dev->dev, "failed to init TSQ, ret = %d.\n", ret);
+		return ret;
+	}
+
+	ret = hns_roce_init_link_table(hr_dev, TPQ_LINK_TABLE);
+	if (ret) {
+		dev_err(hr_dev->dev, "failed to init TPQ, ret = %d.\n", ret);
+		goto err_tpq_init_failed;
+	}
+
+	ret = get_hem_table(hr_dev);
+	if (ret)
+		goto err_get_hem_table_failed;
+
+err_get_hem_table_failed:
 	hns_roce_free_link_table(hr_dev, &priv->tpq);
 
 err_tpq_init_failed:
@@ -3582,9 +3633,25 @@ static int set_hem_to_hw(struct hns_roce_dev *hr_dev, int obj, u64 bt_ba,
 			 u32 hem_type, int step_idx)
 {
 	struct hns_roce_cmd_mailbox *mailbox;
+	struct hns_roce_cmq_desc desc;
+	struct hns_roce_cfg_gmv_bt *gmv_bt =
+				(struct hns_roce_cfg_gmv_bt *)desc.data;
 	int ret;
 	int op;
 
+	if (hem_type == HEM_TYPE_GMV) {
+		hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_CFG_GMV_BT,
+					      false);
+
+		gmv_bt->gmv_ba_l = cpu_to_le32(bt_ba >> HNS_HW_PAGE_SHIFT);
+		gmv_bt->gmv_ba_h = cpu_to_le32(bt_ba >> (HNS_HW_PAGE_SHIFT +
+							 32));
+		gmv_bt->gmv_bt_idx = cpu_to_le32(obj /
+			(HNS_HW_PAGE_SIZE / hr_dev->caps.gmv_entry_sz));
+
+		return hns_roce_cmq_send(hr_dev, &desc, 1);
+	}
+
 	op = get_op_for_set_hem(hr_dev, hem_type, step_idx);
 	if (op < 0)
 		return 0;
@@ -3682,24 +3749,20 @@ static int hns_roce_v2_clear_hem(struct hns_roce_dev *hr_dev,
 	case HEM_TYPE_CQC:
 		op = HNS_ROCE_CMD_DESTROY_CQC_BT0;
 		break;
-	case HEM_TYPE_SCCC:
-	case HEM_TYPE_QPC_TIMER:
-	case HEM_TYPE_CQC_TIMER:
-		break;
 	case HEM_TYPE_SRQC:
 		op = HNS_ROCE_CMD_DESTROY_SRQC_BT0;
 		break;
+	case HEM_TYPE_SCCC:
+	case HEM_TYPE_QPC_TIMER:
+	case HEM_TYPE_CQC_TIMER:
+	case HEM_TYPE_GMV:
+		return 0;
 	default:
 		dev_warn(dev, "Table %d not to be destroyed by mailbox!\n",
 			 table->type);
 		return 0;
 	}
 
-	if (table->type == HEM_TYPE_SCCC ||
-	    table->type == HEM_TYPE_QPC_TIMER ||
-	    table->type == HEM_TYPE_CQC_TIMER)
-		return 0;
-
 	op += step_idx;
 
 	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 29c9dd4..65204e7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -44,6 +44,7 @@
 #define HNS_ROCE_VF_SMAC_NUM			32
 #define HNS_ROCE_VF_SGID_NUM			32
 #define HNS_ROCE_VF_SL_NUM			8
+#define HNS_ROCE_VF_GMV_BT_NUM			256
 
 #define HNS_ROCE_V2_MAX_QP_NUM			0x100000
 #define HNS_ROCE_V2_MAX_QPC_TIMER_NUM		0x200
@@ -89,6 +90,7 @@
 
 #define HNS_ROCE_V2_SCCC_SZ			32
 #define HNS_ROCE_V3_SCCC_SZ			64
+#define HNS_ROCE_V3_GMV_ENTRY_SZ		32
 
 #define HNS_ROCE_V2_QPC_TIMER_ENTRY_SZ		PAGE_SIZE
 #define HNS_ROCE_V2_CQC_TIMER_ENTRY_SZ		PAGE_SIZE
@@ -241,6 +243,7 @@ enum hns_roce_opcode_type {
 	HNS_ROCE_OPC_CLR_SCCC				= 0x8509,
 	HNS_ROCE_OPC_QUERY_SCCC				= 0x850a,
 	HNS_ROCE_OPC_RESET_SCCC				= 0x850b,
+	HNS_ROCE_OPC_CFG_GMV_BT				= 0x8510,
 	HNS_SWITCH_PARAMETER_CFG			= 0x1033,
 };
 
@@ -1334,7 +1337,7 @@ struct hns_roce_pf_res_b {
 	__le32	sgid_idx_num;
 	__le32	qid_idx_sl_num;
 	__le32	sccc_bt_idx_num;
-	__le32	rsv;
+	__le32	gmv_idx_num;
 };
 
 #define PF_RES_DATA_1_PF_SMAC_IDX_S 0
@@ -1361,6 +1364,12 @@ struct hns_roce_pf_res_b {
 #define PF_RES_DATA_4_PF_SCCC_BT_NUM_S 9
 #define PF_RES_DATA_4_PF_SCCC_BT_NUM_M GENMASK(17, 9)
 
+#define PF_RES_DATA_5_PF_GMV_BT_IDX_S 0
+#define PF_RES_DATA_5_PF_GMV_BT_IDX_M GENMASK(7, 0)
+
+#define PF_RES_DATA_5_PF_GMV_BT_NUM_S 8
+#define PF_RES_DATA_5_PF_GMV_BT_NUM_M GENMASK(16, 8)
+
 struct hns_roce_pf_timer_res_a {
 	__le32	rsv0;
 	__le32	qpc_timer_bt_idx_num;
@@ -1425,7 +1434,7 @@ struct hns_roce_vf_res_b {
 	__le32 vf_sgid_idx_num;
 	__le32 vf_qid_idx_sl_num;
 	__le32 vf_sccc_idx_num;
-	__le32 rsv1;
+	__le32 vf_gmv_idx_num;
 };
 
 #define VF_RES_B_DATA_0_VF_ID_S 0
@@ -1455,6 +1464,12 @@ struct hns_roce_vf_res_b {
 #define VF_RES_B_DATA_4_VF_SCCC_BT_NUM_S 9
 #define VF_RES_B_DATA_4_VF_SCCC_BT_NUM_M GENMASK(17, 9)
 
+#define VF_RES_B_DATA_5_VF_GMV_BT_IDX_S 0
+#define VF_RES_B_DATA_5_VF_GMV_BT_IDX_M GENMASK(7, 0)
+
+#define VF_RES_B_DATA_5_VF_GMV_BT_NUM_S 16
+#define VF_RES_B_DATA_5_VF_GMV_BT_NUM_M GENMASK(24, 16)
+
 struct hns_roce_vf_switch {
 	__le32 rocee_sel;
 	__le32 fun_id;
@@ -1577,6 +1592,16 @@ struct hns_roce_cfg_smac_tb {
 #define CFG_SMAC_TB_VF_SMAC_H_S 0
 #define CFG_SMAC_TB_VF_SMAC_H_M GENMASK(15, 0)
 
+struct hns_roce_cfg_gmv_bt {
+	__le32 gmv_ba_l;
+	__le32 gmv_ba_h;
+	__le32 gmv_bt_idx;
+	__le32 rsv[3];
+};
+
+#define CFG_GMV_BA_H_S 0
+#define CFG_GMV_BA_H_M GENMASK(19, 0)
+
 #define HNS_ROCE_QUERY_PF_CAPS_CMD_NUM 5
 struct hns_roce_query_pf_caps_a {
 	u8 number_ports;
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index afeffaf..78112fa 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -680,8 +680,25 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 		}
 	}
 
+	if (hr_dev->caps.gmv_entry_sz) {
+		ret = hns_roce_init_hem_table(hr_dev, &hr_dev->gmv_table,
+					      HEM_TYPE_GMV,
+					      hr_dev->caps.gmv_entry_sz,
+					      hr_dev->caps.gmv_entry_num, 1);
+		if (ret) {
+			dev_err(dev,
+				"failed to init gmv table memory, ret = %d\n",
+				ret);
+			goto err_unmap_cqc_timer;
+		}
+	}
+
 	return 0;
 
+err_unmap_cqc_timer:
+	if (hr_dev->caps.cqc_timer_entry_sz)
+		hns_roce_cleanup_hem_table(hr_dev, &hr_dev->cqc_timer_table);
+
 err_unmap_qpc_timer:
 	if (hr_dev->caps.qpc_timer_entry_sz)
 		hns_roce_cleanup_hem_table(hr_dev, &hr_dev->qpc_timer_table);
-- 
2.8.1

