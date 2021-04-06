Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B5435550F
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 15:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344449AbhDFN2E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 09:28:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15562 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243893AbhDFN2D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 09:28:03 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FF7Yd1TrYzPnpD;
        Tue,  6 Apr 2021 21:25:09 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 21:27:47 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, "Xi Wang" <wangxi11@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH v2 for-next 1/6] RDMA/hns: Simplify function's resource related command
Date:   Tue, 6 Apr 2021 21:25:09 +0800
Message-ID: <1617715514-29039-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617715514-29039-1-git-send-email-liweihang@huawei.com>
References: <1617715514-29039-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Use hr_reg_write/read() to simplify codes about configuring function's
resource. And because the design of PF/VF fields is same, they can be
defined only once.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_common.h |  10 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 161 ++++++--------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 223 +++++-----------------------
 3 files changed, 89 insertions(+), 305 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_common.h b/drivers/infiniband/hw/hns/hns_roce_common.h
index 23c438c..27df969 100644
--- a/drivers/infiniband/hw/hns/hns_roce_common.h
+++ b/drivers/infiniband/hw/hns/hns_roce_common.h
@@ -87,6 +87,16 @@
 
 #define hr_reg_write(ptr, field, val) _hr_reg_write(ptr, field, val)
 
+#define _hr_reg_read(ptr, field_type, field_h, field_l)                        \
+	({                                                                     \
+		const field_type *_ptr = ptr;                                  \
+		BUILD_BUG_ON(((field_h) / 32) != ((field_l) / 32));            \
+		FIELD_GET(GENMASK((field_h) % 32, (field_l) % 32),             \
+			  le32_to_cpu(*((__le32 *)_ptr + (field_h) / 32)));    \
+	})
+
+#define hr_reg_read(ptr, field) _hr_reg_read(ptr, field)
+
 #define ROCEE_GLB_CFG_ROCEE_DB_SQ_MODE_S 3
 #define ROCEE_GLB_CFG_ROCEE_DB_OTH_MODE_S 4
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index cc334d5c..0695c2c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1623,21 +1623,14 @@ static int hns_roce_query_func_info(struct hns_roce_dev *hr_dev)
 
 static int hns_roce_config_global_param(struct hns_roce_dev *hr_dev)
 {
-	struct hns_roce_cfg_global_param *req;
 	struct hns_roce_cmq_desc desc;
+	struct hns_roce_cmq_req *req = (struct hns_roce_cmq_req *)desc.data;
 
 	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_CFG_GLOBAL_PARAM,
 				      false);
 
-	req = (struct hns_roce_cfg_global_param *)desc.data;
-	memset(req, 0, sizeof(*req));
-	roce_set_field(req->time_cfg_udp_port,
-		       CFG_GLOBAL_PARAM_DATA_0_ROCEE_TIME_1US_CFG_M,
-		       CFG_GLOBAL_PARAM_DATA_0_ROCEE_TIME_1US_CFG_S, 0x3e8);
-	roce_set_field(req->time_cfg_udp_port,
-		       CFG_GLOBAL_PARAM_DATA_0_ROCEE_UDP_PORT_M,
-		       CFG_GLOBAL_PARAM_DATA_0_ROCEE_UDP_PORT_S,
-		       ROCE_V2_UDP_DPORT);
+	hr_reg_write(req, CFG_GLOBAL_PARAM_1US_CYCLES, 0x3e8);
+	hr_reg_write(req, CFG_GLOBAL_PARAM_UDP_PORT, ROCE_V2_UDP_DPORT);
 
 	return hns_roce_cmq_send(hr_dev, &desc, 1);
 }
@@ -1645,55 +1638,36 @@ static int hns_roce_config_global_param(struct hns_roce_dev *hr_dev)
 static int hns_roce_query_pf_resource(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_cmq_desc desc[2];
-	struct hns_roce_pf_res_a *req_a;
-	struct hns_roce_pf_res_b *req_b;
+	struct hns_roce_cmq_req *r_a = (struct hns_roce_cmq_req *)desc[0].data;
+	struct hns_roce_cmq_req *r_b = (struct hns_roce_cmq_req *)desc[1].data;
+	enum hns_roce_opcode_type opcode = HNS_ROCE_OPC_QUERY_PF_RES;
+	struct hns_roce_caps *caps = &hr_dev->caps;
 	int ret;
 
-	hns_roce_cmq_setup_basic_desc(&desc[0], HNS_ROCE_OPC_QUERY_PF_RES,
-				      true);
+	hns_roce_cmq_setup_basic_desc(&desc[0], opcode, true);
 	desc[0].flag |= cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
-
-	hns_roce_cmq_setup_basic_desc(&desc[1], HNS_ROCE_OPC_QUERY_PF_RES,
-				      true);
+	hns_roce_cmq_setup_basic_desc(&desc[1], opcode, true);
 
 	ret = hns_roce_cmq_send(hr_dev, desc, 2);
 	if (ret)
 		return ret;
 
-	req_a = (struct hns_roce_pf_res_a *)desc[0].data;
-	req_b = (struct hns_roce_pf_res_b *)desc[1].data;
-
-	hr_dev->caps.qpc_bt_num = roce_get_field(req_a->qpc_bt_idx_num,
-						 PF_RES_DATA_1_PF_QPC_BT_NUM_M,
-						 PF_RES_DATA_1_PF_QPC_BT_NUM_S);
-	hr_dev->caps.srqc_bt_num = roce_get_field(req_a->srqc_bt_idx_num,
-						PF_RES_DATA_2_PF_SRQC_BT_NUM_M,
-						PF_RES_DATA_2_PF_SRQC_BT_NUM_S);
-	hr_dev->caps.cqc_bt_num = roce_get_field(req_a->cqc_bt_idx_num,
-						 PF_RES_DATA_3_PF_CQC_BT_NUM_M,
-						 PF_RES_DATA_3_PF_CQC_BT_NUM_S);
-	hr_dev->caps.mpt_bt_num = roce_get_field(req_a->mpt_bt_idx_num,
-						 PF_RES_DATA_4_PF_MPT_BT_NUM_M,
-						 PF_RES_DATA_4_PF_MPT_BT_NUM_S);
-
-	hr_dev->caps.sl_num = roce_get_field(req_b->qid_idx_sl_num,
-					     PF_RES_DATA_3_PF_SL_NUM_M,
-					     PF_RES_DATA_3_PF_SL_NUM_S);
-	hr_dev->caps.sccc_bt_num = roce_get_field(req_b->sccc_bt_idx_num,
-					     PF_RES_DATA_4_PF_SCCC_BT_NUM_M,
-					     PF_RES_DATA_4_PF_SCCC_BT_NUM_S);
-
-	hr_dev->caps.gmv_bt_num = roce_get_field(req_b->gmv_idx_num,
-						 PF_RES_DATA_5_PF_GMV_BT_NUM_M,
-						 PF_RES_DATA_5_PF_GMV_BT_NUM_S);
+	caps->qpc_bt_num = hr_reg_read(r_a, FUNC_RES_A_QPC_BT_NUM);
+	caps->srqc_bt_num = hr_reg_read(r_a, FUNC_RES_A_SRQC_BT_NUM);
+	caps->cqc_bt_num = hr_reg_read(r_a, FUNC_RES_A_CQC_BT_NUM);
+	caps->mpt_bt_num = hr_reg_read(r_a, FUNC_RES_A_MPT_BT_NUM);
+	caps->sccc_bt_num = hr_reg_read(r_b, FUNC_RES_B_SCCC_BT_NUM);
+	caps->sl_num = hr_reg_read(r_b, FUNC_RES_B_QID_NUM);
+	caps->gmv_bt_num = hr_reg_read(r_b, FUNC_RES_B_GMV_BT_NUM);
 
 	return 0;
 }
 
 static int hns_roce_query_pf_timer_resource(struct hns_roce_dev *hr_dev)
 {
-	struct hns_roce_pf_timer_res_a *req_a;
 	struct hns_roce_cmq_desc desc;
+	struct hns_roce_cmq_req *req = (struct hns_roce_cmq_req *)desc.data;
+	struct hns_roce_caps *caps = &hr_dev->caps;
 	int ret;
 
 	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_QUERY_PF_TIMER_RES,
@@ -1703,16 +1677,8 @@ static int hns_roce_query_pf_timer_resource(struct hns_roce_dev *hr_dev)
 	if (ret)
 		return ret;
 
-	req_a = (struct hns_roce_pf_timer_res_a *)desc.data;
-
-	hr_dev->caps.qpc_timer_bt_num =
-		roce_get_field(req_a->qpc_timer_bt_idx_num,
-			       PF_RES_DATA_1_PF_QPC_TIMER_BT_NUM_M,
-			       PF_RES_DATA_1_PF_QPC_TIMER_BT_NUM_S);
-	hr_dev->caps.cqc_timer_bt_num =
-		roce_get_field(req_a->cqc_timer_bt_idx_num,
-			       PF_RES_DATA_2_PF_CQC_TIMER_BT_NUM_M,
-			       PF_RES_DATA_2_PF_CQC_TIMER_BT_NUM_S);
+	caps->qpc_timer_bt_num = hr_reg_read(req, PF_TIMER_RES_QPC_ITEM_NUM);
+	caps->cqc_timer_bt_num = hr_reg_read(req, PF_TIMER_RES_CQC_ITEM_NUM);
 
 	return 0;
 }
@@ -1745,73 +1711,32 @@ static int hns_roce_set_vf_switch_param(struct hns_roce_dev *hr_dev, int vf_id)
 static int hns_roce_alloc_vf_resource(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_cmq_desc desc[2];
-	struct hns_roce_vf_res_a *req_a;
-	struct hns_roce_vf_res_b *req_b;
-
-	req_a = (struct hns_roce_vf_res_a *)desc[0].data;
-	req_b = (struct hns_roce_vf_res_b *)desc[1].data;
+	struct hns_roce_cmq_req *r_a = (struct hns_roce_cmq_req *)desc[0].data;
+	struct hns_roce_cmq_req *r_b = (struct hns_roce_cmq_req *)desc[1].data;
+	enum hns_roce_opcode_type opcode = HNS_ROCE_OPC_ALLOC_VF_RES;
 
-	hns_roce_cmq_setup_basic_desc(&desc[0], HNS_ROCE_OPC_ALLOC_VF_RES,
-				      false);
+	hns_roce_cmq_setup_basic_desc(&desc[0], opcode, false);
 	desc[0].flag |= cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
+	hns_roce_cmq_setup_basic_desc(&desc[1], opcode, false);
 
-	hns_roce_cmq_setup_basic_desc(&desc[1], HNS_ROCE_OPC_ALLOC_VF_RES,
-				      false);
-
-	roce_set_field(req_a->vf_qpc_bt_idx_num,
-		       VF_RES_A_DATA_1_VF_QPC_BT_IDX_M,
-		       VF_RES_A_DATA_1_VF_QPC_BT_IDX_S, 0);
-	roce_set_field(req_a->vf_qpc_bt_idx_num,
-		       VF_RES_A_DATA_1_VF_QPC_BT_NUM_M,
-		       VF_RES_A_DATA_1_VF_QPC_BT_NUM_S, HNS_ROCE_VF_QPC_BT_NUM);
-
-	roce_set_field(req_a->vf_srqc_bt_idx_num,
-		       VF_RES_A_DATA_2_VF_SRQC_BT_IDX_M,
-		       VF_RES_A_DATA_2_VF_SRQC_BT_IDX_S, 0);
-	roce_set_field(req_a->vf_srqc_bt_idx_num,
-		       VF_RES_A_DATA_2_VF_SRQC_BT_NUM_M,
-		       VF_RES_A_DATA_2_VF_SRQC_BT_NUM_S,
-		       HNS_ROCE_VF_SRQC_BT_NUM);
-
-	roce_set_field(req_a->vf_cqc_bt_idx_num,
-		       VF_RES_A_DATA_3_VF_CQC_BT_IDX_M,
-		       VF_RES_A_DATA_3_VF_CQC_BT_IDX_S, 0);
-	roce_set_field(req_a->vf_cqc_bt_idx_num,
-		       VF_RES_A_DATA_3_VF_CQC_BT_NUM_M,
-		       VF_RES_A_DATA_3_VF_CQC_BT_NUM_S, HNS_ROCE_VF_CQC_BT_NUM);
-
-	roce_set_field(req_a->vf_mpt_bt_idx_num,
-		       VF_RES_A_DATA_4_VF_MPT_BT_IDX_M,
-		       VF_RES_A_DATA_4_VF_MPT_BT_IDX_S, 0);
-	roce_set_field(req_a->vf_mpt_bt_idx_num,
-		       VF_RES_A_DATA_4_VF_MPT_BT_NUM_M,
-		       VF_RES_A_DATA_4_VF_MPT_BT_NUM_S, HNS_ROCE_VF_MPT_BT_NUM);
-
-	roce_set_field(req_a->vf_eqc_bt_idx_num, VF_RES_A_DATA_5_VF_EQC_IDX_M,
-		       VF_RES_A_DATA_5_VF_EQC_IDX_S, 0);
-	roce_set_field(req_a->vf_eqc_bt_idx_num, VF_RES_A_DATA_5_VF_EQC_NUM_M,
-		       VF_RES_A_DATA_5_VF_EQC_NUM_S, HNS_ROCE_VF_EQC_NUM);
-
-	roce_set_field(req_b->vf_smac_idx_num, VF_RES_B_DATA_1_VF_SMAC_IDX_M,
-		       VF_RES_B_DATA_1_VF_SMAC_IDX_S, 0);
-	roce_set_field(req_b->vf_smac_idx_num, VF_RES_B_DATA_1_VF_SMAC_NUM_M,
-		       VF_RES_B_DATA_1_VF_SMAC_NUM_S, HNS_ROCE_VF_SMAC_NUM);
-
-	roce_set_field(req_b->vf_sgid_idx_num, VF_RES_B_DATA_2_VF_SGID_IDX_M,
-		       VF_RES_B_DATA_2_VF_SGID_IDX_S, 0);
-	roce_set_field(req_b->vf_sgid_idx_num, VF_RES_B_DATA_2_VF_SGID_NUM_M,
-		       VF_RES_B_DATA_2_VF_SGID_NUM_S, HNS_ROCE_VF_SGID_NUM);
-
-	roce_set_field(req_b->vf_qid_idx_sl_num, VF_RES_B_DATA_3_VF_QID_IDX_M,
-		       VF_RES_B_DATA_3_VF_QID_IDX_S, 0);
-	roce_set_field(req_b->vf_qid_idx_sl_num, VF_RES_B_DATA_3_VF_SL_NUM_M,
-		       VF_RES_B_DATA_3_VF_SL_NUM_S, HNS_ROCE_VF_SL_NUM);
-
-	roce_set_field(req_b->vf_sccc_idx_num, VF_RES_B_DATA_4_VF_SCCC_BT_IDX_M,
-		       VF_RES_B_DATA_4_VF_SCCC_BT_IDX_S, 0);
-	roce_set_field(req_b->vf_sccc_idx_num, VF_RES_B_DATA_4_VF_SCCC_BT_NUM_M,
-		       VF_RES_B_DATA_4_VF_SCCC_BT_NUM_S,
-		       HNS_ROCE_VF_SCCC_BT_NUM);
+	hr_reg_write(r_a, FUNC_RES_A_QPC_BT_NUM, HNS_ROCE_VF_QPC_BT_NUM);
+	hr_reg_write(r_a, FUNC_RES_A_QPC_BT_IDX, 0);
+	hr_reg_write(r_a, FUNC_RES_A_SRQC_BT_NUM, HNS_ROCE_VF_SRQC_BT_NUM);
+	hr_reg_write(r_a, FUNC_RES_A_SRQC_BT_IDX, 0);
+	hr_reg_write(r_a, FUNC_RES_A_CQC_BT_NUM, HNS_ROCE_VF_CQC_BT_NUM);
+	hr_reg_write(r_a, FUNC_RES_A_CQC_BT_IDX, 0);
+	hr_reg_write(r_a, FUNC_RES_A_MPT_BT_NUM, HNS_ROCE_VF_MPT_BT_NUM);
+	hr_reg_write(r_a, FUNC_RES_A_MPT_BT_IDX, 0);
+	hr_reg_write(r_a, FUNC_RES_A_EQC_BT_NUM, HNS_ROCE_VF_EQC_NUM);
+	hr_reg_write(r_a, FUNC_RES_A_EQC_BT_IDX, 0);
+	hr_reg_write(r_b, FUNC_RES_B_SMAC_NUM, HNS_ROCE_VF_SMAC_NUM);
+	hr_reg_write(r_b, FUNC_RES_B_SMAC_IDX, 0);
+	hr_reg_write(r_b, FUNC_RES_B_SGID_NUM, HNS_ROCE_VF_SGID_NUM);
+	hr_reg_write(r_b, FUNC_RES_B_SGID_IDX, 0);
+	hr_reg_write(r_b, FUNC_RES_V_QID_NUM, HNS_ROCE_VF_SL_NUM);
+	hr_reg_write(r_b, FUNC_RES_B_QID_IDX, 0);
+	hr_reg_write(r_b, FUNC_RES_B_SCCC_BT_NUM, HNS_ROCE_VF_SCCC_BT_NUM);
+	hr_reg_write(r_b, FUNC_RES_B_SCCC_BT_IDX, 0);
 
 	return hns_roce_cmq_send(hr_dev, desc, 2);
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 44a3abdd..44be39a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1363,194 +1363,43 @@ struct hns_roce_cfg_llm_b {
 #define CFG_LLM_TAIL_PTR_S 0
 #define CFG_LLM_TAIL_PTR_M GENMASK(11, 0)
 
-struct hns_roce_cfg_global_param {
-	__le32 time_cfg_udp_port;
-	__le32 rsv[5];
-};
-
-#define CFG_GLOBAL_PARAM_DATA_0_ROCEE_TIME_1US_CFG_S 0
-#define CFG_GLOBAL_PARAM_DATA_0_ROCEE_TIME_1US_CFG_M GENMASK(9, 0)
-
-#define CFG_GLOBAL_PARAM_DATA_0_ROCEE_UDP_PORT_S 16
-#define CFG_GLOBAL_PARAM_DATA_0_ROCEE_UDP_PORT_M GENMASK(31, 16)
-
-struct hns_roce_pf_res_a {
-	__le32	rsv;
-	__le32	qpc_bt_idx_num;
-	__le32	srqc_bt_idx_num;
-	__le32	cqc_bt_idx_num;
-	__le32	mpt_bt_idx_num;
-	__le32	eqc_bt_idx_num;
-};
-
-#define PF_RES_DATA_1_PF_QPC_BT_IDX_S 0
-#define PF_RES_DATA_1_PF_QPC_BT_IDX_M GENMASK(10, 0)
-
-#define PF_RES_DATA_1_PF_QPC_BT_NUM_S 16
-#define PF_RES_DATA_1_PF_QPC_BT_NUM_M GENMASK(27, 16)
-
-#define PF_RES_DATA_2_PF_SRQC_BT_IDX_S 0
-#define PF_RES_DATA_2_PF_SRQC_BT_IDX_M GENMASK(8, 0)
-
-#define PF_RES_DATA_2_PF_SRQC_BT_NUM_S 16
-#define PF_RES_DATA_2_PF_SRQC_BT_NUM_M GENMASK(25, 16)
-
-#define PF_RES_DATA_3_PF_CQC_BT_IDX_S 0
-#define PF_RES_DATA_3_PF_CQC_BT_IDX_M GENMASK(8, 0)
-
-#define PF_RES_DATA_3_PF_CQC_BT_NUM_S 16
-#define PF_RES_DATA_3_PF_CQC_BT_NUM_M GENMASK(25, 16)
-
-#define PF_RES_DATA_4_PF_MPT_BT_IDX_S 0
-#define PF_RES_DATA_4_PF_MPT_BT_IDX_M GENMASK(8, 0)
-
-#define PF_RES_DATA_4_PF_MPT_BT_NUM_S 16
-#define PF_RES_DATA_4_PF_MPT_BT_NUM_M GENMASK(25, 16)
-
-#define PF_RES_DATA_5_PF_EQC_BT_IDX_S 0
-#define PF_RES_DATA_5_PF_EQC_BT_IDX_M GENMASK(8, 0)
-
-#define PF_RES_DATA_5_PF_EQC_BT_NUM_S 16
-#define PF_RES_DATA_5_PF_EQC_BT_NUM_M GENMASK(25, 16)
-
-struct hns_roce_pf_res_b {
-	__le32	rsv0;
-	__le32	smac_idx_num;
-	__le32	sgid_idx_num;
-	__le32	qid_idx_sl_num;
-	__le32	sccc_bt_idx_num;
-	__le32	gmv_idx_num;
-};
-
-#define PF_RES_DATA_1_PF_SMAC_IDX_S 0
-#define PF_RES_DATA_1_PF_SMAC_IDX_M GENMASK(7, 0)
-
-#define PF_RES_DATA_1_PF_SMAC_NUM_S 8
-#define PF_RES_DATA_1_PF_SMAC_NUM_M GENMASK(16, 8)
-
-#define PF_RES_DATA_2_PF_SGID_IDX_S 0
-#define PF_RES_DATA_2_PF_SGID_IDX_M GENMASK(7, 0)
-
-#define PF_RES_DATA_2_PF_SGID_NUM_S 8
-#define PF_RES_DATA_2_PF_SGID_NUM_M GENMASK(16, 8)
-
-#define PF_RES_DATA_3_PF_QID_IDX_S 0
-#define PF_RES_DATA_3_PF_QID_IDX_M GENMASK(9, 0)
-
-#define PF_RES_DATA_3_PF_SL_NUM_S 16
-#define PF_RES_DATA_3_PF_SL_NUM_M GENMASK(26, 16)
-
-#define PF_RES_DATA_4_PF_SCCC_BT_IDX_S 0
-#define PF_RES_DATA_4_PF_SCCC_BT_IDX_M GENMASK(8, 0)
-
-#define PF_RES_DATA_4_PF_SCCC_BT_NUM_S 9
-#define PF_RES_DATA_4_PF_SCCC_BT_NUM_M GENMASK(17, 9)
-
-#define PF_RES_DATA_5_PF_GMV_BT_IDX_S 0
-#define PF_RES_DATA_5_PF_GMV_BT_IDX_M GENMASK(7, 0)
-
-#define PF_RES_DATA_5_PF_GMV_BT_NUM_S 8
-#define PF_RES_DATA_5_PF_GMV_BT_NUM_M GENMASK(16, 8)
-
-struct hns_roce_pf_timer_res_a {
-	__le32	rsv0;
-	__le32	qpc_timer_bt_idx_num;
-	__le32	cqc_timer_bt_idx_num;
-	__le32	rsv[3];
-};
+/* Fields of HNS_ROCE_OPC_CFG_GLOBAL_PARAM */
+#define CFG_GLOBAL_PARAM_1US_CYCLES CMQ_REQ_FIELD_LOC(9, 0)
+#define CFG_GLOBAL_PARAM_UDP_PORT CMQ_REQ_FIELD_LOC(31, 16)
 
-#define PF_RES_DATA_1_PF_QPC_TIMER_BT_IDX_S 0
-#define PF_RES_DATA_1_PF_QPC_TIMER_BT_IDX_M GENMASK(11, 0)
-
-#define PF_RES_DATA_1_PF_QPC_TIMER_BT_NUM_S 16
-#define PF_RES_DATA_1_PF_QPC_TIMER_BT_NUM_M GENMASK(28, 16)
-
-#define PF_RES_DATA_2_PF_CQC_TIMER_BT_IDX_S 0
-#define PF_RES_DATA_2_PF_CQC_TIMER_BT_IDX_M GENMASK(10, 0)
-
-#define PF_RES_DATA_2_PF_CQC_TIMER_BT_NUM_S 16
-#define PF_RES_DATA_2_PF_CQC_TIMER_BT_NUM_M GENMASK(27, 16)
-
-struct hns_roce_vf_res_a {
-	__le32 vf_id;
-	__le32 vf_qpc_bt_idx_num;
-	__le32 vf_srqc_bt_idx_num;
-	__le32 vf_cqc_bt_idx_num;
-	__le32 vf_mpt_bt_idx_num;
-	__le32 vf_eqc_bt_idx_num;
-};
-
-#define VF_RES_A_DATA_1_VF_QPC_BT_IDX_S 0
-#define VF_RES_A_DATA_1_VF_QPC_BT_IDX_M GENMASK(10, 0)
-
-#define VF_RES_A_DATA_1_VF_QPC_BT_NUM_S 16
-#define VF_RES_A_DATA_1_VF_QPC_BT_NUM_M GENMASK(27, 16)
-
-#define VF_RES_A_DATA_2_VF_SRQC_BT_IDX_S 0
-#define VF_RES_A_DATA_2_VF_SRQC_BT_IDX_M GENMASK(8, 0)
-
-#define VF_RES_A_DATA_2_VF_SRQC_BT_NUM_S 16
-#define VF_RES_A_DATA_2_VF_SRQC_BT_NUM_M GENMASK(25, 16)
-
-#define VF_RES_A_DATA_3_VF_CQC_BT_IDX_S 0
-#define VF_RES_A_DATA_3_VF_CQC_BT_IDX_M GENMASK(8, 0)
-
-#define VF_RES_A_DATA_3_VF_CQC_BT_NUM_S 16
-#define VF_RES_A_DATA_3_VF_CQC_BT_NUM_M GENMASK(25, 16)
-
-#define VF_RES_A_DATA_4_VF_MPT_BT_IDX_S 0
-#define VF_RES_A_DATA_4_VF_MPT_BT_IDX_M GENMASK(8, 0)
-
-#define VF_RES_A_DATA_4_VF_MPT_BT_NUM_S 16
-#define VF_RES_A_DATA_4_VF_MPT_BT_NUM_M GENMASK(25, 16)
-
-#define VF_RES_A_DATA_5_VF_EQC_IDX_S 0
-#define VF_RES_A_DATA_5_VF_EQC_IDX_M GENMASK(8, 0)
-
-#define VF_RES_A_DATA_5_VF_EQC_NUM_S 16
-#define VF_RES_A_DATA_5_VF_EQC_NUM_M GENMASK(25, 16)
-
-struct hns_roce_vf_res_b {
-	__le32 rsv0;
-	__le32 vf_smac_idx_num;
-	__le32 vf_sgid_idx_num;
-	__le32 vf_qid_idx_sl_num;
-	__le32 vf_sccc_idx_num;
-	__le32 vf_gmv_idx_num;
-};
-
-#define VF_RES_B_DATA_0_VF_ID_S 0
-#define VF_RES_B_DATA_0_VF_ID_M GENMASK(7, 0)
-
-#define VF_RES_B_DATA_1_VF_SMAC_IDX_S 0
-#define VF_RES_B_DATA_1_VF_SMAC_IDX_M GENMASK(7, 0)
-
-#define VF_RES_B_DATA_1_VF_SMAC_NUM_S 8
-#define VF_RES_B_DATA_1_VF_SMAC_NUM_M GENMASK(16, 8)
-
-#define VF_RES_B_DATA_2_VF_SGID_IDX_S 0
-#define VF_RES_B_DATA_2_VF_SGID_IDX_M GENMASK(7, 0)
-
-#define VF_RES_B_DATA_2_VF_SGID_NUM_S 8
-#define VF_RES_B_DATA_2_VF_SGID_NUM_M GENMASK(16, 8)
-
-#define VF_RES_B_DATA_3_VF_QID_IDX_S 0
-#define VF_RES_B_DATA_3_VF_QID_IDX_M GENMASK(9, 0)
-
-#define VF_RES_B_DATA_3_VF_SL_NUM_S 16
-#define VF_RES_B_DATA_3_VF_SL_NUM_M GENMASK(19, 16)
-
-#define VF_RES_B_DATA_4_VF_SCCC_BT_IDX_S 0
-#define VF_RES_B_DATA_4_VF_SCCC_BT_IDX_M GENMASK(8, 0)
-
-#define VF_RES_B_DATA_4_VF_SCCC_BT_NUM_S 9
-#define VF_RES_B_DATA_4_VF_SCCC_BT_NUM_M GENMASK(17, 9)
-
-#define VF_RES_B_DATA_5_VF_GMV_BT_IDX_S 0
-#define VF_RES_B_DATA_5_VF_GMV_BT_IDX_M GENMASK(7, 0)
-
-#define VF_RES_B_DATA_5_VF_GMV_BT_NUM_S 16
-#define VF_RES_B_DATA_5_VF_GMV_BT_NUM_M GENMASK(24, 16)
+/*
+ * Fields of HNS_ROCE_OPC_QUERY_PF_RES and HNS_ROCE_OPC_ALLOC_VF_RES
+ */
+#define FUNC_RES_A_VF_ID CMQ_REQ_FIELD_LOC(7, 0)
+#define FUNC_RES_A_QPC_BT_IDX CMQ_REQ_FIELD_LOC(42, 32)
+#define FUNC_RES_A_QPC_BT_NUM CMQ_REQ_FIELD_LOC(59, 48)
+#define FUNC_RES_A_SRQC_BT_IDX CMQ_REQ_FIELD_LOC(72, 64)
+#define FUNC_RES_A_SRQC_BT_NUM CMQ_REQ_FIELD_LOC(89, 80)
+#define FUNC_RES_A_CQC_BT_IDX CMQ_REQ_FIELD_LOC(104, 96)
+#define FUNC_RES_A_CQC_BT_NUM CMQ_REQ_FIELD_LOC(121, 112)
+#define FUNC_RES_A_MPT_BT_IDX CMQ_REQ_FIELD_LOC(136, 128)
+#define FUNC_RES_A_MPT_BT_NUM CMQ_REQ_FIELD_LOC(153, 144)
+#define FUNC_RES_A_EQC_BT_IDX CMQ_REQ_FIELD_LOC(168, 160)
+#define FUNC_RES_A_EQC_BT_NUM CMQ_REQ_FIELD_LOC(185, 176)
+#define FUNC_RES_B_SMAC_IDX CMQ_REQ_FIELD_LOC(39, 32)
+#define FUNC_RES_B_SMAC_NUM CMQ_REQ_FIELD_LOC(48, 40)
+#define FUNC_RES_B_SGID_IDX CMQ_REQ_FIELD_LOC(71, 64)
+#define FUNC_RES_B_SGID_NUM CMQ_REQ_FIELD_LOC(80, 72)
+#define FUNC_RES_B_QID_IDX CMQ_REQ_FIELD_LOC(105, 96)
+#define FUNC_RES_B_QID_NUM CMQ_REQ_FIELD_LOC(122, 112)
+#define FUNC_RES_V_QID_NUM CMQ_REQ_FIELD_LOC(115, 112)
+
+#define FUNC_RES_B_SCCC_BT_IDX CMQ_REQ_FIELD_LOC(136, 128)
+#define FUNC_RES_B_SCCC_BT_NUM CMQ_REQ_FIELD_LOC(145, 137)
+#define FUNC_RES_B_GMV_BT_IDX CMQ_REQ_FIELD_LOC(167, 160)
+#define FUNC_RES_B_GMV_BT_NUM CMQ_REQ_FIELD_LOC(176, 168)
+#define FUNC_RES_V_GMV_BT_NUM CMQ_REQ_FIELD_LOC(184, 176)
+
+/* Fields of HNS_ROCE_OPC_QUERY_PF_TIMER_RES */
+#define PF_TIMER_RES_QPC_ITEM_IDX CMQ_REQ_FIELD_LOC(43, 32)
+#define PF_TIMER_RES_QPC_ITEM_NUM CMQ_REQ_FIELD_LOC(60, 48)
+#define PF_TIMER_RES_CQC_ITEM_IDX CMQ_REQ_FIELD_LOC(74, 64)
+#define PF_TIMER_RES_CQC_ITEM_NUM CMQ_REQ_FIELD_LOC(91, 80)
 
 struct hns_roce_vf_switch {
 	__le32 rocee_sel;
-- 
2.8.1

