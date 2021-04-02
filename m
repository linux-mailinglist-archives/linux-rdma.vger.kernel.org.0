Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF76D3527BB
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Apr 2021 11:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhDBJBA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Apr 2021 05:01:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16330 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbhDBJBA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Apr 2021 05:01:00 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FBYr85jpKz9vsX;
        Fri,  2 Apr 2021 16:58:48 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Fri, 2 Apr 2021 17:00:48 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Wei Xu <xuwei5@hisilicon.com>,
        Shengming Shu <shushengming1@huawei.com>,
        "Xi Wang" <wangxi11@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 5/6] RDMA/hns: Enable RoCE on virtual functions
Date:   Fri, 2 Apr 2021 16:58:15 +0800
Message-ID: <1617353896-40727-6-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617353896-40727-1-git-send-email-liweihang@huawei.com>
References: <1617353896-40727-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wei Xu <xuwei5@hisilicon.com>

Introduce the VF support by adding code changes to allow VF PCI device
initialization, assgining the reserved resource of the PF to the active
VFs, setting the default abilities, applying the interruptions, resetting
and reducing the default QP/GID number to aovid exceeding the hardware
limitation.

Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Shengming Shu <shushengming1@huawei.com>
Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |   1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 232 +++++++++++++++++++++++-----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   8 +-
 3 files changed, 202 insertions(+), 39 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 37d6f01..e631914 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1010,6 +1010,7 @@ struct hns_roce_dev {
 	struct workqueue_struct *irq_workq;
 	const struct hns_roce_dfx_hw *dfx;
 	u32 func_num;
+	u32 is_vf;
 	u32 cong_algo_tmpl_id;
 };
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 860e74b..0c6bc84 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -54,6 +54,9 @@ enum {
 	CMD_RST_PRC_EBUSY,
 };
 
+static void calc_pg_sz(u32 obj_num, u32 obj_size, u32 hop_num, u32 ctx_bt_num,
+		       u32 *buf_page_size, u32 *bt_page_size, u32 hem_type);
+
 static inline void set_data_seg_v2(struct hns_roce_v2_wqe_data_seg *dseg,
 				   struct ib_sge *sg)
 {
@@ -1538,7 +1541,7 @@ static void hns_roce_func_clr_rst_proc(struct hns_roce_dev *hr_dev, int retval,
 	dev_warn(hr_dev->dev, "Func clear failed.\n");
 }
 
-static void hns_roce_function_clear(struct hns_roce_dev *hr_dev)
+static void __hns_roce_function_clear(struct hns_roce_dev *hr_dev, int vf_id)
 {
 	bool fclr_write_fail_flag = false;
 	struct hns_roce_func_clear *resp;
@@ -1551,6 +1554,7 @@ static void hns_roce_function_clear(struct hns_roce_dev *hr_dev)
 
 	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_FUNC_CLEAR, false);
 	resp = (struct hns_roce_func_clear *)desc.data;
+	resp->rst_funcid_en = cpu_to_le32(vf_id);
 
 	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
 	if (ret) {
@@ -1571,12 +1575,14 @@ static void hns_roce_function_clear(struct hns_roce_dev *hr_dev)
 		hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_FUNC_CLEAR,
 					      true);
 
+		resp->rst_funcid_en = cpu_to_le32(vf_id);
 		ret = hns_roce_cmq_send(hr_dev, &desc, 1);
 		if (ret)
 			continue;
 
 		if (roce_get_bit(resp->func_done, FUNC_CLEAR_RST_FUN_DONE_S)) {
-			hr_dev->is_reset = true;
+			if (vf_id == 0)
+				hr_dev->is_reset = true;
 			return;
 		}
 	}
@@ -1585,6 +1591,31 @@ static void hns_roce_function_clear(struct hns_roce_dev *hr_dev)
 	hns_roce_func_clr_rst_proc(hr_dev, ret, fclr_write_fail_flag);
 }
 
+static void hns_roce_free_vf_resource(struct hns_roce_dev *hr_dev, int vf_id)
+{
+	enum hns_roce_opcode_type opcode = HNS_ROCE_OPC_ALLOC_VF_RES;
+	struct hns_roce_cmq_desc desc[2];
+	struct hns_roce_cmq_req *req_a;
+
+	req_a = (struct hns_roce_cmq_req *)desc[0].data;
+	hns_roce_cmq_setup_basic_desc(&desc[0], opcode, false);
+	desc[0].flag |= cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
+	hns_roce_cmq_setup_basic_desc(&desc[1], opcode, false);
+	hr_reg_write(req_a, FUNC_RES_A_VF_ID, vf_id);
+	hns_roce_cmq_send(hr_dev, desc, 2);
+}
+
+static void hns_roce_function_clear(struct hns_roce_dev *hr_dev)
+{
+	int i;
+
+	for (i = hr_dev->func_num - 1; i >= 0; i--) {
+		__hns_roce_function_clear(hr_dev, i);
+		if (i != 0)
+			hns_roce_free_vf_resource(hr_dev, i);
+	}
+}
+
 static int hns_roce_query_fw_ver(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_query_fw_info *resp;
@@ -1640,17 +1671,24 @@ static int hns_roce_config_global_param(struct hns_roce_dev *hr_dev)
 	return hns_roce_cmq_send(hr_dev, &desc, 1);
 }
 
-static int hns_roce_query_pf_resource(struct hns_roce_dev *hr_dev)
+static int load_func_res_caps(struct hns_roce_dev *hr_dev, bool is_vf)
 {
 	struct hns_roce_cmq_desc desc[2];
 	struct hns_roce_cmq_req *r_a = (struct hns_roce_cmq_req *)desc[0].data;
 	struct hns_roce_cmq_req *r_b = (struct hns_roce_cmq_req *)desc[1].data;
-	enum hns_roce_opcode_type opcode = HNS_ROCE_OPC_QUERY_PF_RES;
 	struct hns_roce_caps *caps = &hr_dev->caps;
+	enum hns_roce_opcode_type opcode;
 	u32 func_num;
 	int ret;
 
-	func_num = hr_dev->func_num ? hr_dev->func_num : 1;
+	if (is_vf) {
+		opcode = HNS_ROCE_OPC_QUERY_VF_RES;
+		func_num = 1;
+	} else {
+		opcode = HNS_ROCE_OPC_QUERY_PF_RES;
+		func_num = hr_dev->func_num;
+	}
+
 	hns_roce_cmq_setup_basic_desc(&desc[0], opcode, true);
 	desc[0].flag |= cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
 	hns_roce_cmq_setup_basic_desc(&desc[1], opcode, true);
@@ -1667,12 +1705,30 @@ static int hns_roce_query_pf_resource(struct hns_roce_dev *hr_dev)
 	caps->smac_bt_num = hr_reg_read(r_b, FUNC_RES_B_SMAC_NUM) / func_num;
 	caps->sgid_bt_num = hr_reg_read(r_b, FUNC_RES_B_SGID_NUM) / func_num;
 	caps->sccc_bt_num = hr_reg_read(r_b, FUNC_RES_B_SCCC_BT_NUM) / func_num;
-	caps->sl_num = hr_reg_read(r_b, FUNC_RES_B_QID_NUM) / func_num;
-	caps->gmv_bt_num = hr_reg_read(r_b, FUNC_RES_B_GMV_BT_NUM) / func_num;
+
+	if (is_vf) {
+		caps->sl_num = hr_reg_read(r_b, FUNC_RES_V_QID_NUM) / func_num;
+		caps->gmv_bt_num = hr_reg_read(r_b, FUNC_RES_V_GMV_BT_NUM) /
+					       func_num;
+	} else {
+		caps->sl_num = hr_reg_read(r_b, FUNC_RES_B_QID_NUM) / func_num;
+		caps->gmv_bt_num = hr_reg_read(r_b, FUNC_RES_B_GMV_BT_NUM) /
+					       func_num;
+	}
 
 	return 0;
 }
 
+static int hns_roce_query_pf_resource(struct hns_roce_dev *hr_dev)
+{
+	return load_func_res_caps(hr_dev, false);
+}
+
+static int hns_roce_query_vf_resource(struct hns_roce_dev *hr_dev)
+{
+	return load_func_res_caps(hr_dev, true);
+}
+
 static int hns_roce_query_pf_timer_resource(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_cmq_desc desc;
@@ -1696,8 +1752,8 @@ static int hns_roce_query_pf_timer_resource(struct hns_roce_dev *hr_dev)
 static int __hns_roce_set_vf_switch_param(struct hns_roce_dev *hr_dev,
 					  u32 vf_id)
 {
-	struct hns_roce_cmq_desc desc;
 	struct hns_roce_vf_switch *swt;
+	struct hns_roce_cmq_desc desc;
 	int ret;
 
 	swt = (struct hns_roce_vf_switch *)desc.data;
@@ -1839,6 +1895,7 @@ static int hns_roce_v2_set_bt(struct hns_roce_dev *hr_dev)
 
 static void set_default_caps(struct hns_roce_dev *hr_dev)
 {
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hns_roce_caps *caps = &hr_dev->caps;
 
 	caps->num_qps		= HNS_ROCE_V2_MAX_QP_NUM;
@@ -1854,7 +1911,9 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->num_uars		= HNS_ROCE_V2_UAR_NUM;
 	caps->phy_num_uars	= HNS_ROCE_V2_PHY_UAR_NUM;
 	caps->num_aeq_vectors	= HNS_ROCE_V2_AEQE_VEC_NUM;
-	caps->num_comp_vectors	= HNS_ROCE_V2_COMP_VEC_NUM;
+	caps->num_comp_vectors	=
+			min_t(u32, caps->eqc_bt_num - 1,
+			      (u32)priv->handle->rinfo.num_vectors - 2);
 	caps->num_other_vectors = HNS_ROCE_V2_ABNORMAL_VEC_NUM;
 	caps->num_mtpts		= HNS_ROCE_V2_MAX_MTPT_NUM;
 	caps->num_mtt_segs	= HNS_ROCE_V2_MAX_MTT_SEGS;
@@ -1902,6 +1961,9 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->mtt_ba_pg_sz	= 0;
 	caps->mtt_buf_pg_sz	= 0;
 	caps->mtt_hop_num	= HNS_ROCE_MTT_HOP_NUM;
+	caps->pbl_ba_pg_sz      = HNS_ROCE_BA_PG_SZ_SUPPORTED_16K;
+	caps->pbl_buf_pg_sz     = 0;
+	caps->pbl_hop_num       = HNS_ROCE_PBL_HOP_NUM;
 	caps->wqe_sq_hop_num	= HNS_ROCE_SQWQE_HOP_NUM;
 	caps->wqe_sge_hop_num	= HNS_ROCE_EXT_SGE_HOP_NUM;
 	caps->wqe_rq_hop_num	= HNS_ROCE_RQWQE_HOP_NUM;
@@ -1914,7 +1976,11 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->idx_ba_pg_sz	= 0;
 	caps->idx_buf_pg_sz	= 0;
 	caps->idx_hop_num	= HNS_ROCE_IDX_HOP_NUM;
-	caps->chunk_sz		= HNS_ROCE_V2_TABLE_CHUNK_SIZE;
+	caps->eqe_ba_pg_sz      = 0;
+	caps->eqe_buf_pg_sz     = 0;
+	caps->eqe_hop_num       = HNS_ROCE_EQE_HOP_NUM;
+	caps->tsq_buf_pg_sz     = 0;
+	caps->chunk_sz          = HNS_ROCE_V2_TABLE_CHUNK_SIZE;
 
 	caps->flags		= HNS_ROCE_CAP_FLAG_REREG_MR |
 				  HNS_ROCE_CAP_FLAG_ROCE_V1_V2 |
@@ -1968,6 +2034,35 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 		caps->gid_table_len[0] = caps->gmv_bt_num * (HNS_HW_PAGE_SIZE /
 					 caps->gmv_entry_sz);
 	}
+
+	calc_pg_sz(caps->num_qps, caps->qpc_sz, caps->qpc_hop_num,
+		   caps->qpc_bt_num, &caps->qpc_buf_pg_sz, &caps->qpc_ba_pg_sz,
+		   HEM_TYPE_QPC);
+	calc_pg_sz(caps->num_mtpts, caps->mtpt_entry_sz, caps->mpt_hop_num,
+		   caps->mpt_bt_num, &caps->mpt_buf_pg_sz, &caps->mpt_ba_pg_sz,
+		   HEM_TYPE_MTPT);
+	calc_pg_sz(caps->num_cqs, caps->cqc_entry_sz, caps->cqc_hop_num,
+		   caps->cqc_bt_num, &caps->cqc_buf_pg_sz, &caps->cqc_ba_pg_sz,
+		   HEM_TYPE_CQC);
+
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL)
+		calc_pg_sz(caps->num_qps, caps->sccc_sz,
+			   caps->sccc_hop_num, caps->sccc_bt_num,
+			   &caps->sccc_buf_pg_sz, &caps->sccc_ba_pg_sz,
+			   HEM_TYPE_SCCC);
+
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SRQ) {
+		calc_pg_sz(caps->num_srqs, caps->srqc_entry_sz,
+			   caps->srqc_hop_num, caps->srqc_bt_num,
+			   &caps->srqc_buf_pg_sz, &caps->srqc_ba_pg_sz,
+			   HEM_TYPE_SRQC);
+		calc_pg_sz(caps->num_srqwqe_segs, caps->mtt_entry_sz,
+			   caps->srqwqe_hop_num, 1, &caps->srqwqe_buf_pg_sz,
+			   &caps->srqwqe_ba_pg_sz, HEM_TYPE_SRQWQE);
+		calc_pg_sz(caps->num_idx_segs, caps->idx_entry_sz,
+			   caps->idx_hop_num, 1, &caps->idx_buf_pg_sz,
+			   &caps->idx_ba_pg_sz, HEM_TYPE_IDX);
+	}
 }
 
 static void calc_pg_sz(u32 obj_num, u32 obj_size, u32 hop_num, u32 ctx_bt_num,
@@ -2095,6 +2190,9 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	caps->gid_table_len[0] = roce_get_field(resp_c->max_gid_num_cqs,
 						V2_QUERY_PF_CAPS_C_MAX_GID_M,
 						V2_QUERY_PF_CAPS_C_MAX_GID_S);
+
+	caps->gid_table_len[0] /= hr_dev->func_num;
+
 	caps->max_cqes = 1 << roce_get_field(resp_c->cq_depth,
 					     V2_QUERY_PF_CAPS_C_CQ_DEPTH_M,
 					     V2_QUERY_PF_CAPS_C_CQ_DEPTH_S);
@@ -2123,6 +2221,7 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	caps->num_comp_vectors = roce_get_field(resp_d->num_ceqs_ceq_depth,
 						V2_QUERY_PF_CAPS_D_NUM_CEQS_M,
 						V2_QUERY_PF_CAPS_D_NUM_CEQS_S);
+
 	caps->aeqe_depth = 1 << roce_get_field(resp_d->arm_st_aeq_depth,
 					       V2_QUERY_PF_CAPS_D_AEQ_DEPTH_M,
 					       V2_QUERY_PF_CAPS_D_AEQ_DEPTH_S);
@@ -2285,6 +2384,34 @@ static int hns_roce_config_entry_size(struct hns_roce_dev *hr_dev)
 	return ret;
 }
 
+static int hns_roce_v2_vf_profile(struct hns_roce_dev *hr_dev)
+{
+	int ret;
+
+	hr_dev->vendor_part_id = hr_dev->pci_dev->device;
+	hr_dev->sys_image_guid = be64_to_cpu(hr_dev->ib_dev.node_guid);
+	hr_dev->func_num = 1;
+
+	ret = hns_roce_query_vf_resource(hr_dev);
+	if (ret) {
+		dev_err(hr_dev->dev,
+			"Query the VF resource fail, ret = %d.\n", ret);
+		return ret;
+	}
+
+	set_default_caps(hr_dev);
+
+	ret = hns_roce_v2_set_bt(hr_dev);
+	if (ret) {
+		dev_err(hr_dev->dev,
+			"Configure the VF bt attribute fail, ret = %d.\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_caps *caps = &hr_dev->caps;
@@ -2304,6 +2431,9 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
 		return ret;
 	}
 
+	if (hr_dev->is_vf)
+		return hns_roce_v2_vf_profile(hr_dev);
+
 	ret = hns_roce_query_func_info(hr_dev);
 	if (ret) {
 		dev_err(hr_dev->dev, "Query function info fail, ret = %d.\n",
@@ -2564,6 +2694,17 @@ static int get_hem_table(struct hns_roce_dev *hr_dev)
 	int ret;
 	int i;
 
+	/* Alloc memory for source address table buffer space chunk */
+	for (gmv_count = 0; gmv_count < hr_dev->caps.gmv_entry_num;
+	     gmv_count++) {
+		ret = hns_roce_table_get(hr_dev, &hr_dev->gmv_table, gmv_count);
+		if (ret)
+			goto err_gmv_failed;
+	}
+
+	if (hr_dev->is_vf)
+		return 0;
+
 	/* Alloc memory for QPC Timer buffer space chunk */
 	for (qpc_count = 0; qpc_count < hr_dev->caps.qpc_timer_bt_num;
 	     qpc_count++) {
@@ -2586,23 +2727,8 @@ static int get_hem_table(struct hns_roce_dev *hr_dev)
 		}
 	}
 
-	/* Alloc memory for GMV(GID/MAC/VLAN) table buffer space chunk */
-	for (gmv_count = 0; gmv_count < hr_dev->caps.gmv_entry_num;
-	     gmv_count++) {
-		ret = hns_roce_table_get(hr_dev, &hr_dev->gmv_table, gmv_count);
-		if (ret) {
-			dev_err(hr_dev->dev,
-				"failed to get gmv table, ret = %d.\n", ret);
-			goto err_gmv_failed;
-		}
-	}
-
 	return 0;
 
-err_gmv_failed:
-	for (i = 0; i < gmv_count; i++)
-		hns_roce_table_put(hr_dev, &hr_dev->gmv_table, i);
-
 err_cqc_timer_failed:
 	for (i = 0; i < cqc_count; i++)
 		hns_roce_table_put(hr_dev, &hr_dev->cqc_timer_table, i);
@@ -2611,19 +2737,47 @@ static int get_hem_table(struct hns_roce_dev *hr_dev)
 	for (i = 0; i < qpc_count; i++)
 		hns_roce_table_put(hr_dev, &hr_dev->qpc_timer_table, i);
 
+err_gmv_failed:
+	for (i = 0; i < gmv_count; i++)
+		hns_roce_table_put(hr_dev, &hr_dev->gmv_table, i);
+
 	return ret;
 }
 
+static void put_hem_table(struct hns_roce_dev *hr_dev)
+{
+	int i;
+
+	for (i = 0; i < hr_dev->caps.gmv_entry_num; i++)
+		hns_roce_table_put(hr_dev, &hr_dev->gmv_table, i);
+
+	if (hr_dev->is_vf)
+		return;
+
+	for (i = 0; i < hr_dev->caps.qpc_timer_bt_num; i++)
+		hns_roce_table_put(hr_dev, &hr_dev->qpc_timer_table, i);
+
+	for (i = 0; i < hr_dev->caps.cqc_timer_bt_num; i++)
+		hns_roce_table_put(hr_dev, &hr_dev->cqc_timer_table, i);
+}
+
 static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	int ret;
 
+	ret = get_hem_table(hr_dev);
+	if (ret)
+		return ret;
+
+	if (hr_dev->is_vf)
+		return 0;
+
 	/* TSQ includes SQ doorbell and ack doorbell */
 	ret = hns_roce_init_link_table(hr_dev, TSQ_LINK_TABLE);
 	if (ret) {
 		dev_err(hr_dev->dev, "failed to init TSQ, ret = %d.\n", ret);
-		return ret;
+		goto err_tsq_init_failed;
 	}
 
 	ret = hns_roce_init_link_table(hr_dev, TPQ_LINK_TABLE);
@@ -2632,17 +2786,13 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
 		goto err_tpq_init_failed;
 	}
 
-	ret = get_hem_table(hr_dev);
-	if (ret)
-		goto err_get_hem_table_failed;
-
 	return 0;
 
-err_get_hem_table_failed:
-	hns_roce_free_link_table(hr_dev, &priv->tpq);
+err_tsq_init_failed:
+	put_hem_table(hr_dev);
 
 err_tpq_init_failed:
-	hns_roce_free_link_table(hr_dev, &priv->tsq);
+	hns_roce_free_link_table(hr_dev, &priv->tpq);
 
 	return ret;
 }
@@ -2653,8 +2803,10 @@ static void hns_roce_v2_exit(struct hns_roce_dev *hr_dev)
 
 	hns_roce_function_clear(hr_dev);
 
-	hns_roce_free_link_table(hr_dev, &priv->tpq);
-	hns_roce_free_link_table(hr_dev, &priv->tsq);
+	if (!hr_dev->is_vf) {
+		hns_roce_free_link_table(hr_dev, &priv->tpq);
+		hns_roce_free_link_table(hr_dev, &priv->tsq);
+	}
 
 	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP09)
 		free_dip_list(hr_dev);
@@ -6534,6 +6686,8 @@ static const struct pci_device_id hns_roce_hw_v2_pci_tbl[] = {
 	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_50GE_RDMA_MACSEC), 0},
 	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_100G_RDMA_MACSEC), 0},
 	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_200G_RDMA), 0},
+	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_RDMA_DCB_PFC_VF),
+	 HNAE3_DEV_SUPPORT_ROCE_DCB_BITS},
 	/* required last entry */
 	{0, }
 };
@@ -6544,9 +6698,12 @@ static void hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
 				  struct hnae3_handle *handle)
 {
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
+	const struct pci_device_id *id;
 	int i;
 
 	hr_dev->pci_dev = handle->pdev;
+	id = pci_match_id(hns_roce_hw_v2_pci_tbl, hr_dev->pci_dev);
+	hr_dev->is_vf = id->driver_data;
 	hr_dev->dev = &handle->pdev->dev;
 	hr_dev->hw = &hns_roce_hw_v2;
 	hr_dev->dfx = &hns_roce_dfx_hw_v2;
@@ -6563,7 +6720,7 @@ static void hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
 	addrconf_addr_eui48((u8 *)&hr_dev->ib_dev.node_guid,
 			    hr_dev->iboe.netdevs[0]->dev_addr);
 
-	for (i = 0; i < HNS_ROCE_V2_MAX_IRQ_NUM; i++)
+	for (i = 0; i < handle->rinfo.num_vectors; i++)
 		hr_dev->irq[i] = pci_irq_vector(handle->pdev,
 						i + handle->rinfo.base_vector);
 
@@ -6647,6 +6804,9 @@ static int hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
 	if (!id)
 		return 0;
 
+	if (id->driver_data && handle->pdev->revision < PCI_REVISION_ID_HIP09)
+		return 0;
+
 	ret = __hns_roce_hw_v2_init_instance(handle);
 	if (ret) {
 		handle->rinfo.instance_state = HNS_ROCE_STATE_NON_INIT;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index efd33ae..7a25ffd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -44,7 +44,7 @@
 #define HNS_ROCE_VF_SL_NUM			8
 #define HNS_ROCE_VF_GMV_BT_NUM			256
 
-#define HNS_ROCE_V2_MAX_QP_NUM			0x100000
+#define HNS_ROCE_V2_MAX_QP_NUM			0x1000
 #define HNS_ROCE_V2_MAX_QPC_TIMER_NUM		0x200
 #define HNS_ROCE_V2_MAX_WQE_NUM			0x8000
 #define	HNS_ROCE_V2_MAX_SRQ			0x100000
@@ -121,7 +121,7 @@
 
 #define HNS_ROCE_BA_PG_SZ_SUPPORTED_256K	6
 #define HNS_ROCE_BA_PG_SZ_SUPPORTED_16K		2
-#define HNS_ROCE_V2_GID_INDEX_NUM		256
+#define HNS_ROCE_V2_GID_INDEX_NUM		16
 
 #define HNS_ROCE_V2_TABLE_CHUNK_SIZE		(1 << 18)
 
@@ -247,6 +247,7 @@ enum hns_roce_opcode_type {
 	HNS_ROCE_OPC_CLR_SCCC				= 0x8509,
 	HNS_ROCE_OPC_QUERY_SCCC				= 0x850a,
 	HNS_ROCE_OPC_RESET_SCCC				= 0x850b,
+	HNS_ROCE_OPC_QUERY_VF_RES			= 0x850e,
 	HNS_ROCE_OPC_CFG_GMV_TBL			= 0x850f,
 	HNS_ROCE_OPC_CFG_GMV_BT				= 0x8510,
 	HNS_SWITCH_PARAMETER_CFG			= 0x1033,
@@ -1366,7 +1367,8 @@ struct hns_roce_cfg_llm_b {
 #define CFG_GLOBAL_PARAM_UDP_PORT CMQ_REQ_FIELD_LOC(31, 16)
 
 /*
- * Fields of HNS_ROCE_OPC_QUERY_PF_RES and HNS_ROCE_OPC_ALLOC_VF_RES
+ * Fields of HNS_ROCE_OPC_QUERY_PF_RES, HNS_ROCE_OPC_QUERY_VF_RES
+ * and HNS_ROCE_OPC_ALLOC_VF_RES
  */
 #define FUNC_RES_A_VF_ID CMQ_REQ_FIELD_LOC(7, 0)
 #define FUNC_RES_A_QPC_BT_IDX CMQ_REQ_FIELD_LOC(42, 32)
-- 
2.8.1

