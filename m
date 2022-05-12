Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B853E524789
	for <lists+linux-rdma@lfdr.de>; Thu, 12 May 2022 10:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351302AbiELIBW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 May 2022 04:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351297AbiELIBT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 May 2022 04:01:19 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651D157B03
        for <linux-rdma@vger.kernel.org>; Thu, 12 May 2022 01:01:17 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KzPHH1GKgzCscW;
        Thu, 12 May 2022 15:56:27 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 16:01:15 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 16:01:15 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 2/2] RDMA/hns: Use hr_reg_read() instead of remaining roce_get_xxx()
Date:   Thu, 12 May 2022 16:00:12 +0800
Message-ID: <20220512080012.38728-3-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220512080012.38728-1-liangwenpeng@huawei.com>
References: <20220512080012.38728-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To reduce the code size and make the code clearer, replace all
roce_get_xxx() with hr_reg_read() to read the data fields.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h   |  14 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 137 +++++----------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h    | 158 +++++-------------
 drivers/infiniband/hw/hns/hns_roce_restrack.c |  49 ++----
 4 files changed, 104 insertions(+), 254 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index eb40fb795aaf..2855e9ad4b32 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -129,8 +129,6 @@ enum hns_roce_event {
 	HNS_ROCE_EVENT_TYPE_INVALID_XRCETH	      = 0x17,
 };
 
-#define HNS_ROCE_CAP_FLAGS_EX_SHIFT 12
-
 enum {
 	HNS_ROCE_CAP_FLAG_REREG_MR		= BIT(0),
 	HNS_ROCE_CAP_FLAG_ROCE_V1_V2		= BIT(1),
@@ -653,6 +651,11 @@ struct hns_roce_ceqe {
 	__le32	rsv[15];
 };
 
+#define CEQE_FIELD_LOC(h, l) FIELD_LOC(struct hns_roce_ceqe, h, l)
+
+#define CEQE_CQN CEQE_FIELD_LOC(23, 0)
+#define CEQE_OWNER CEQE_FIELD_LOC(31, 31)
+
 struct hns_roce_aeqe {
 	__le32 asyn;
 	union {
@@ -672,6 +675,13 @@ struct hns_roce_aeqe {
 	__le32 rsv[12];
 };
 
+#define AEQE_FIELD_LOC(h, l) FIELD_LOC(struct hns_roce_aeqe, h, l)
+
+#define AEQE_EVENT_TYPE AEQE_FIELD_LOC(7, 0)
+#define AEQE_SUB_TYPE AEQE_FIELD_LOC(15, 8)
+#define AEQE_OWNER AEQE_FIELD_LOC(31, 31)
+#define AEQE_EVENT_QUEUE_NUM AEQE_FIELD_LOC(55, 32)
+
 struct hns_roce_eq {
 	struct hns_roce_dev		*hr_dev;
 	void __iomem			*db_reg;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index ff66e44f0614..ba3c742258ef 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1483,7 +1483,7 @@ static void __hns_roce_function_clear(struct hns_roce_dev *hr_dev, int vf_id)
 		if (ret)
 			continue;
 
-		if (roce_get_bit(resp->func_done, FUNC_CLEAR_RST_FUN_DONE_S)) {
+		if (hr_reg_read(resp, FUNC_CLEAR_RST_FUN_DONE)) {
 			if (vf_id == 0)
 				hr_dev->is_reset = true;
 			return;
@@ -2264,87 +2264,39 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	ctx_hop_num		     = resp_b->ctx_hop_num;
 	pbl_hop_num		     = resp_b->pbl_hop_num;
 
-	caps->num_pds = 1 << roce_get_field(resp_c->cap_flags_num_pds,
-					    V2_QUERY_PF_CAPS_C_NUM_PDS_M,
-					    V2_QUERY_PF_CAPS_C_NUM_PDS_S);
-	caps->flags = roce_get_field(resp_c->cap_flags_num_pds,
-				     V2_QUERY_PF_CAPS_C_CAP_FLAGS_M,
-				     V2_QUERY_PF_CAPS_C_CAP_FLAGS_S);
+	caps->num_pds = 1 << hr_reg_read(resp_c, PF_CAPS_C_NUM_PDS);
+
+	caps->flags = hr_reg_read(resp_c, PF_CAPS_C_CAP_FLAGS);
 	caps->flags |= le16_to_cpu(resp_d->cap_flags_ex) <<
 		       HNS_ROCE_CAP_FLAGS_EX_SHIFT;
 
-	caps->num_cqs = 1 << roce_get_field(resp_c->max_gid_num_cqs,
-					    V2_QUERY_PF_CAPS_C_NUM_CQS_M,
-					    V2_QUERY_PF_CAPS_C_NUM_CQS_S);
-	caps->gid_table_len[0] = roce_get_field(resp_c->max_gid_num_cqs,
-						V2_QUERY_PF_CAPS_C_MAX_GID_M,
-						V2_QUERY_PF_CAPS_C_MAX_GID_S);
-
-	caps->max_cqes = 1 << roce_get_field(resp_c->cq_depth,
-					     V2_QUERY_PF_CAPS_C_CQ_DEPTH_M,
-					     V2_QUERY_PF_CAPS_C_CQ_DEPTH_S);
-	caps->num_mtpts = 1 << roce_get_field(resp_c->num_mrws,
-					      V2_QUERY_PF_CAPS_C_NUM_MRWS_M,
-					      V2_QUERY_PF_CAPS_C_NUM_MRWS_S);
-	caps->num_qps = 1 << roce_get_field(resp_c->ord_num_qps,
-					    V2_QUERY_PF_CAPS_C_NUM_QPS_M,
-					    V2_QUERY_PF_CAPS_C_NUM_QPS_S);
-	caps->max_qp_init_rdma = roce_get_field(resp_c->ord_num_qps,
-						V2_QUERY_PF_CAPS_C_MAX_ORD_M,
-						V2_QUERY_PF_CAPS_C_MAX_ORD_S);
+	caps->num_cqs = 1 << hr_reg_read(resp_c, PF_CAPS_C_NUM_CQS);
+	caps->gid_table_len[0] = hr_reg_read(resp_c, PF_CAPS_C_MAX_GID);
+	caps->max_cqes = 1 << hr_reg_read(resp_c, PF_CAPS_C_CQ_DEPTH);
+	caps->num_mtpts = 1 << hr_reg_read(resp_c, PF_CAPS_C_NUM_MRWS);
+	caps->num_qps = 1 << hr_reg_read(resp_c, PF_CAPS_C_NUM_QPS);
+	caps->max_qp_init_rdma = hr_reg_read(resp_c, PF_CAPS_C_MAX_ORD);
 	caps->max_qp_dest_rdma = caps->max_qp_init_rdma;
 	caps->max_wqes = 1 << le16_to_cpu(resp_c->sq_depth);
-	caps->num_srqs = 1 << roce_get_field(resp_d->wq_hop_num_max_srqs,
-					     V2_QUERY_PF_CAPS_D_NUM_SRQS_M,
-					     V2_QUERY_PF_CAPS_D_NUM_SRQS_S);
-	caps->cong_type = roce_get_field(resp_d->wq_hop_num_max_srqs,
-					 V2_QUERY_PF_CAPS_D_CONG_TYPE_M,
-					 V2_QUERY_PF_CAPS_D_CONG_TYPE_S);
-	caps->max_srq_wrs = 1 << le16_to_cpu(resp_d->srq_depth);
 
-	caps->ceqe_depth = 1 << roce_get_field(resp_d->num_ceqs_ceq_depth,
-					       V2_QUERY_PF_CAPS_D_CEQ_DEPTH_M,
-					       V2_QUERY_PF_CAPS_D_CEQ_DEPTH_S);
-	caps->num_comp_vectors = roce_get_field(resp_d->num_ceqs_ceq_depth,
-						V2_QUERY_PF_CAPS_D_NUM_CEQS_M,
-						V2_QUERY_PF_CAPS_D_NUM_CEQS_S);
-
-	caps->aeqe_depth = 1 << roce_get_field(resp_d->arm_st_aeq_depth,
-					       V2_QUERY_PF_CAPS_D_AEQ_DEPTH_M,
-					       V2_QUERY_PF_CAPS_D_AEQ_DEPTH_S);
-	caps->default_aeq_arm_st = roce_get_field(resp_d->arm_st_aeq_depth,
-					    V2_QUERY_PF_CAPS_D_AEQ_ARM_ST_M,
-					    V2_QUERY_PF_CAPS_D_AEQ_ARM_ST_S);
-	caps->default_ceq_arm_st = roce_get_field(resp_d->arm_st_aeq_depth,
-					    V2_QUERY_PF_CAPS_D_CEQ_ARM_ST_M,
-					    V2_QUERY_PF_CAPS_D_CEQ_ARM_ST_S);
-	caps->reserved_pds = roce_get_field(resp_d->num_uars_rsv_pds,
-					    V2_QUERY_PF_CAPS_D_RSV_PDS_M,
-					    V2_QUERY_PF_CAPS_D_RSV_PDS_S);
-	caps->num_uars = 1 << roce_get_field(resp_d->num_uars_rsv_pds,
-					     V2_QUERY_PF_CAPS_D_NUM_UARS_M,
-					     V2_QUERY_PF_CAPS_D_NUM_UARS_S);
-	caps->reserved_qps = roce_get_field(resp_d->rsv_uars_rsv_qps,
-					    V2_QUERY_PF_CAPS_D_RSV_QPS_M,
-					    V2_QUERY_PF_CAPS_D_RSV_QPS_S);
-	caps->reserved_uars = roce_get_field(resp_d->rsv_uars_rsv_qps,
-					     V2_QUERY_PF_CAPS_D_RSV_UARS_M,
-					     V2_QUERY_PF_CAPS_D_RSV_UARS_S);
-	caps->reserved_mrws = roce_get_field(resp_e->chunk_size_shift_rsv_mrws,
-					     V2_QUERY_PF_CAPS_E_RSV_MRWS_M,
-					     V2_QUERY_PF_CAPS_E_RSV_MRWS_S);
-	caps->chunk_sz = 1 << roce_get_field(resp_e->chunk_size_shift_rsv_mrws,
-					 V2_QUERY_PF_CAPS_E_CHUNK_SIZE_SHIFT_M,
-					 V2_QUERY_PF_CAPS_E_CHUNK_SIZE_SHIFT_S);
-	caps->reserved_cqs = roce_get_field(resp_e->rsv_cqs,
-					    V2_QUERY_PF_CAPS_E_RSV_CQS_M,
-					    V2_QUERY_PF_CAPS_E_RSV_CQS_S);
-	caps->reserved_srqs = roce_get_field(resp_e->rsv_srqs,
-					     V2_QUERY_PF_CAPS_E_RSV_SRQS_M,
-					     V2_QUERY_PF_CAPS_E_RSV_SRQS_S);
-	caps->reserved_lkey = roce_get_field(resp_e->rsv_lkey,
-					     V2_QUERY_PF_CAPS_E_RSV_LKEYS_M,
-					     V2_QUERY_PF_CAPS_E_RSV_LKEYS_S);
+	caps->num_srqs = 1 << hr_reg_read(resp_d, PF_CAPS_D_NUM_SRQS);
+	caps->cong_type = hr_reg_read(resp_d, PF_CAPS_D_CONG_TYPE);
+	caps->max_srq_wrs = 1 << le16_to_cpu(resp_d->srq_depth);
+	caps->ceqe_depth = 1 << hr_reg_read(resp_d, PF_CAPS_D_CEQ_DEPTH);
+	caps->num_comp_vectors = hr_reg_read(resp_d, PF_CAPS_D_NUM_CEQS);
+	caps->aeqe_depth = 1 << hr_reg_read(resp_d, PF_CAPS_D_AEQ_DEPTH);
+	caps->default_aeq_arm_st = hr_reg_read(resp_d, PF_CAPS_D_AEQ_ARM_ST);
+	caps->default_ceq_arm_st = hr_reg_read(resp_d, PF_CAPS_D_CEQ_ARM_ST);
+	caps->reserved_pds = hr_reg_read(resp_d, PF_CAPS_D_RSV_PDS);
+	caps->num_uars = 1 << hr_reg_read(resp_d, PF_CAPS_D_NUM_UARS);
+	caps->reserved_qps = hr_reg_read(resp_d, PF_CAPS_D_RSV_QPS);
+	caps->reserved_uars = hr_reg_read(resp_d, PF_CAPS_D_RSV_UARS);
+
+	caps->reserved_mrws = hr_reg_read(resp_e, PF_CAPS_E_RSV_MRWS);
+	caps->chunk_sz = 1 << hr_reg_read(resp_e, PF_CAPS_E_CHUNK_SIZE_SHIFT);
+	caps->reserved_cqs = hr_reg_read(resp_e, PF_CAPS_E_RSV_CQS);
+	caps->reserved_srqs = hr_reg_read(resp_e, PF_CAPS_E_RSV_SRQS);
+	caps->reserved_lkey = hr_reg_read(resp_e, PF_CAPS_E_RSV_LKEYS);
 	caps->default_ceq_max_cnt = le16_to_cpu(resp_e->ceq_max_cnt);
 	caps->default_ceq_period = le16_to_cpu(resp_e->ceq_period);
 	caps->default_aeq_max_cnt = le16_to_cpu(resp_e->aeq_max_cnt);
@@ -2359,15 +2311,9 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	caps->cqe_hop_num = pbl_hop_num;
 	caps->srqwqe_hop_num = pbl_hop_num;
 	caps->idx_hop_num = pbl_hop_num;
-	caps->wqe_sq_hop_num = roce_get_field(resp_d->wq_hop_num_max_srqs,
-					  V2_QUERY_PF_CAPS_D_SQWQE_HOP_NUM_M,
-					  V2_QUERY_PF_CAPS_D_SQWQE_HOP_NUM_S);
-	caps->wqe_sge_hop_num = roce_get_field(resp_d->wq_hop_num_max_srqs,
-					  V2_QUERY_PF_CAPS_D_EX_SGE_HOP_NUM_M,
-					  V2_QUERY_PF_CAPS_D_EX_SGE_HOP_NUM_S);
-	caps->wqe_rq_hop_num = roce_get_field(resp_d->wq_hop_num_max_srqs,
-					  V2_QUERY_PF_CAPS_D_RQWQE_HOP_NUM_M,
-					  V2_QUERY_PF_CAPS_D_RQWQE_HOP_NUM_S);
+	caps->wqe_sq_hop_num = hr_reg_read(resp_d, PF_CAPS_D_SQWQE_HOP_NUM);
+	caps->wqe_sge_hop_num = hr_reg_read(resp_d, PF_CAPS_D_EX_SGE_HOP_NUM);
+	caps->wqe_rq_hop_num = hr_reg_read(resp_d, PF_CAPS_D_RQWQE_HOP_NUM);
 
 	return 0;
 }
@@ -5905,7 +5851,7 @@ static struct hns_roce_aeqe *next_aeqe_sw_v2(struct hns_roce_eq *eq)
 				   (eq->cons_index & (eq->entries - 1)) *
 				   eq->eqe_size);
 
-	return (roce_get_bit(aeqe->asyn, HNS_ROCE_V2_AEQ_AEQE_OWNER_S) ^
+	return (hr_reg_read(aeqe, AEQE_OWNER) ^
 		!!(eq->cons_index & eq->entries)) ? aeqe : NULL;
 }
 
@@ -5925,15 +5871,9 @@ static int hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 		 */
 		dma_rmb();
 
-		event_type = roce_get_field(aeqe->asyn,
-					    HNS_ROCE_V2_AEQE_EVENT_TYPE_M,
-					    HNS_ROCE_V2_AEQE_EVENT_TYPE_S);
-		sub_type = roce_get_field(aeqe->asyn,
-					  HNS_ROCE_V2_AEQE_SUB_TYPE_M,
-					  HNS_ROCE_V2_AEQE_SUB_TYPE_S);
-		queue_num = roce_get_field(aeqe->event.queue_event.num,
-					   HNS_ROCE_V2_AEQE_EVENT_QUEUE_NUM_M,
-					   HNS_ROCE_V2_AEQE_EVENT_QUEUE_NUM_S);
+		event_type = hr_reg_read(aeqe, AEQE_EVENT_TYPE);
+		sub_type = hr_reg_read(aeqe, AEQE_SUB_TYPE);
+		queue_num = hr_reg_read(aeqe, AEQE_EVENT_QUEUE_NUM);
 
 		switch (event_type) {
 		case HNS_ROCE_EVENT_TYPE_PATH_MIG:
@@ -5993,8 +5933,8 @@ static struct hns_roce_ceqe *next_ceqe_sw_v2(struct hns_roce_eq *eq)
 				   (eq->cons_index & (eq->entries - 1)) *
 				   eq->eqe_size);
 
-	return (!!(roce_get_bit(ceqe->comp, HNS_ROCE_V2_CEQ_CEQE_OWNER_S))) ^
-		(!!(eq->cons_index & eq->entries)) ? ceqe : NULL;
+	return (hr_reg_read(ceqe, CEQE_OWNER) ^
+		!!(eq->cons_index & eq->entries)) ? ceqe : NULL;
 }
 
 static int hns_roce_v2_ceq_int(struct hns_roce_dev *hr_dev,
@@ -6010,8 +5950,7 @@ static int hns_roce_v2_ceq_int(struct hns_roce_dev *hr_dev,
 		 */
 		dma_rmb();
 
-		cqn = roce_get_field(ceqe->comp, HNS_ROCE_V2_CEQE_COMP_CQN_M,
-				     HNS_ROCE_V2_CEQE_COMP_CQN_S);
+		cqn = hr_reg_read(ceqe, CEQE_CQN);
 
 		hns_roce_cq_completion(hr_dev, cqn);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 5ad094df4d78..7ffb7824d268 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -303,33 +303,6 @@ struct hns_roce_v2_cq_context {
 #define HNS_ROCE_V2_CQ_DEFAULT_BURST_NUM 0x0
 #define HNS_ROCE_V2_CQ_DEFAULT_INTERVAL	0x0
 
-#define	V2_CQC_BYTE_4_ARM_ST_S 6
-#define V2_CQC_BYTE_4_ARM_ST_M GENMASK(7, 6)
-
-#define	V2_CQC_BYTE_4_CEQN_S 15
-#define V2_CQC_BYTE_4_CEQN_M GENMASK(23, 15)
-
-#define	V2_CQC_BYTE_8_CQN_S 0
-#define V2_CQC_BYTE_8_CQN_M GENMASK(23, 0)
-
-#define	V2_CQC_BYTE_16_CQE_HOP_NUM_S 30
-#define V2_CQC_BYTE_16_CQE_HOP_NUM_M GENMASK(31, 30)
-
-#define	V2_CQC_BYTE_28_CQ_PRODUCER_IDX_S 0
-#define V2_CQC_BYTE_28_CQ_PRODUCER_IDX_M GENMASK(23, 0)
-
-#define	V2_CQC_BYTE_32_CQ_CONSUMER_IDX_S 0
-#define V2_CQC_BYTE_32_CQ_CONSUMER_IDX_M GENMASK(23, 0)
-
-#define	V2_CQC_BYTE_52_CQE_CNT_S 0
-#define	V2_CQC_BYTE_52_CQE_CNT_M GENMASK(23, 0)
-
-#define	V2_CQC_BYTE_56_CQ_MAX_CNT_S 0
-#define V2_CQC_BYTE_56_CQ_MAX_CNT_M GENMASK(15, 0)
-
-#define	V2_CQC_BYTE_56_CQ_PERIOD_S 16
-#define V2_CQC_BYTE_56_CQ_PERIOD_M GENMASK(31, 16)
-
 #define CQC_FIELD_LOC(h, l) FIELD_LOC(struct hns_roce_v2_cq_context, h, l)
 
 #define CQC_CQ_ST CQC_FIELD_LOC(1, 0)
@@ -993,7 +966,10 @@ struct hns_roce_func_clear {
 	__le32 rsv[4];
 };
 
-#define FUNC_CLEAR_RST_FUN_DONE_S 0
+#define FUNC_CLEAR_FIELD_LOC(h, l) FIELD_LOC(struct hns_roce_func_clear, h, l)
+
+#define FUNC_CLEAR_RST_FUN_DONE FUNC_CLEAR_FIELD_LOC(32, 32)
+
 /* Each physical function manages up to 248 virtual functions, it takes up to
  * 100ms for each function to execute clear. If an abnormal reset occurs, it is
  * executed twice at most, so it takes up to 249 * 2 * 100ms.
@@ -1234,29 +1210,17 @@ struct hns_roce_query_pf_caps_c {
 	__le16 rq_depth;
 };
 
-#define V2_QUERY_PF_CAPS_C_NUM_PDS_S 0
-#define V2_QUERY_PF_CAPS_C_NUM_PDS_M GENMASK(19, 0)
-
-#define V2_QUERY_PF_CAPS_C_CAP_FLAGS_S 20
-#define V2_QUERY_PF_CAPS_C_CAP_FLAGS_M GENMASK(31, 20)
-
-#define V2_QUERY_PF_CAPS_C_NUM_CQS_S 0
-#define V2_QUERY_PF_CAPS_C_NUM_CQS_M GENMASK(19, 0)
-
-#define V2_QUERY_PF_CAPS_C_MAX_GID_S 20
-#define V2_QUERY_PF_CAPS_C_MAX_GID_M GENMASK(28, 20)
-
-#define V2_QUERY_PF_CAPS_C_CQ_DEPTH_S 0
-#define V2_QUERY_PF_CAPS_C_CQ_DEPTH_M GENMASK(22, 0)
+#define PF_CAPS_C_FIELD_LOC(h, l) \
+	FIELD_LOC(struct hns_roce_query_pf_caps_c, h, l)
 
-#define V2_QUERY_PF_CAPS_C_NUM_MRWS_S 0
-#define V2_QUERY_PF_CAPS_C_NUM_MRWS_M GENMASK(19, 0)
-
-#define V2_QUERY_PF_CAPS_C_NUM_QPS_S 0
-#define V2_QUERY_PF_CAPS_C_NUM_QPS_M GENMASK(19, 0)
-
-#define V2_QUERY_PF_CAPS_C_MAX_ORD_S 20
-#define V2_QUERY_PF_CAPS_C_MAX_ORD_M GENMASK(27, 20)
+#define PF_CAPS_C_NUM_PDS PF_CAPS_C_FIELD_LOC(19, 0)
+#define PF_CAPS_C_CAP_FLAGS PF_CAPS_C_FIELD_LOC(31, 20)
+#define PF_CAPS_C_NUM_CQS PF_CAPS_C_FIELD_LOC(51, 32)
+#define PF_CAPS_C_MAX_GID PF_CAPS_C_FIELD_LOC(60, 52)
+#define PF_CAPS_C_CQ_DEPTH PF_CAPS_C_FIELD_LOC(86, 64)
+#define PF_CAPS_C_NUM_MRWS PF_CAPS_C_FIELD_LOC(115, 96)
+#define PF_CAPS_C_NUM_QPS PF_CAPS_C_FIELD_LOC(147, 128)
+#define PF_CAPS_C_MAX_ORD PF_CAPS_C_FIELD_LOC(155, 148)
 
 struct hns_roce_query_pf_caps_d {
 	__le32 wq_hop_num_max_srqs;
@@ -1267,20 +1231,26 @@ struct hns_roce_query_pf_caps_d {
 	__le32 num_uars_rsv_pds;
 	__le32 rsv_uars_rsv_qps;
 };
-#define V2_QUERY_PF_CAPS_D_NUM_SRQS_S 0
-#define V2_QUERY_PF_CAPS_D_NUM_SRQS_M GENMASK(19, 0)
-
-#define V2_QUERY_PF_CAPS_D_RQWQE_HOP_NUM_S 20
-#define V2_QUERY_PF_CAPS_D_RQWQE_HOP_NUM_M GENMASK(21, 20)
-
-#define V2_QUERY_PF_CAPS_D_EX_SGE_HOP_NUM_S 22
-#define V2_QUERY_PF_CAPS_D_EX_SGE_HOP_NUM_M GENMASK(23, 22)
 
-#define V2_QUERY_PF_CAPS_D_SQWQE_HOP_NUM_S 24
-#define V2_QUERY_PF_CAPS_D_SQWQE_HOP_NUM_M GENMASK(25, 24)
-
-#define V2_QUERY_PF_CAPS_D_CONG_TYPE_S 26
-#define V2_QUERY_PF_CAPS_D_CONG_TYPE_M GENMASK(29, 26)
+#define PF_CAPS_D_FIELD_LOC(h, l) \
+	FIELD_LOC(struct hns_roce_query_pf_caps_d, h, l)
+
+#define PF_CAPS_D_NUM_SRQS PF_CAPS_D_FIELD_LOC(19, 0)
+#define PF_CAPS_D_RQWQE_HOP_NUM PF_CAPS_D_FIELD_LOC(21, 20)
+#define PF_CAPS_D_EX_SGE_HOP_NUM PF_CAPS_D_FIELD_LOC(23, 22)
+#define PF_CAPS_D_SQWQE_HOP_NUM PF_CAPS_D_FIELD_LOC(25, 24)
+#define PF_CAPS_D_CONG_TYPE PF_CAPS_D_FIELD_LOC(29, 26)
+#define PF_CAPS_D_CEQ_DEPTH PF_CAPS_D_FIELD_LOC(85, 64)
+#define PF_CAPS_D_NUM_CEQS PF_CAPS_D_FIELD_LOC(95, 86)
+#define PF_CAPS_D_AEQ_DEPTH PF_CAPS_D_FIELD_LOC(117, 96)
+#define PF_CAPS_D_AEQ_ARM_ST PF_CAPS_D_FIELD_LOC(119, 118)
+#define PF_CAPS_D_CEQ_ARM_ST PF_CAPS_D_FIELD_LOC(121, 120)
+#define PF_CAPS_D_RSV_PDS PF_CAPS_D_FIELD_LOC(147, 128)
+#define PF_CAPS_D_NUM_UARS PF_CAPS_D_FIELD_LOC(155, 148)
+#define PF_CAPS_D_RSV_QPS PF_CAPS_D_FIELD_LOC(179, 160)
+#define PF_CAPS_D_RSV_UARS PF_CAPS_D_FIELD_LOC(187, 180)
+
+#define HNS_ROCE_CAP_FLAGS_EX_SHIFT 12
 
 struct hns_roce_congestion_algorithm {
 	u8 alg_sel;
@@ -1289,33 +1259,6 @@ struct hns_roce_congestion_algorithm {
 	u8 wnd_mode_sel;
 };
 
-#define V2_QUERY_PF_CAPS_D_CEQ_DEPTH_S 0
-#define V2_QUERY_PF_CAPS_D_CEQ_DEPTH_M GENMASK(21, 0)
-
-#define V2_QUERY_PF_CAPS_D_NUM_CEQS_S 22
-#define V2_QUERY_PF_CAPS_D_NUM_CEQS_M GENMASK(31, 22)
-
-#define V2_QUERY_PF_CAPS_D_AEQ_DEPTH_S 0
-#define V2_QUERY_PF_CAPS_D_AEQ_DEPTH_M GENMASK(21, 0)
-
-#define V2_QUERY_PF_CAPS_D_AEQ_ARM_ST_S 22
-#define V2_QUERY_PF_CAPS_D_AEQ_ARM_ST_M GENMASK(23, 22)
-
-#define V2_QUERY_PF_CAPS_D_CEQ_ARM_ST_S 24
-#define V2_QUERY_PF_CAPS_D_CEQ_ARM_ST_M GENMASK(25, 24)
-
-#define V2_QUERY_PF_CAPS_D_RSV_PDS_S 0
-#define V2_QUERY_PF_CAPS_D_RSV_PDS_M GENMASK(19, 0)
-
-#define V2_QUERY_PF_CAPS_D_NUM_UARS_S 20
-#define V2_QUERY_PF_CAPS_D_NUM_UARS_M GENMASK(27, 20)
-
-#define V2_QUERY_PF_CAPS_D_RSV_QPS_S 0
-#define V2_QUERY_PF_CAPS_D_RSV_QPS_M GENMASK(19, 0)
-
-#define V2_QUERY_PF_CAPS_D_RSV_UARS_S 20
-#define V2_QUERY_PF_CAPS_D_RSV_UARS_M GENMASK(27, 20)
-
 struct hns_roce_query_pf_caps_e {
 	__le32 chunk_size_shift_rsv_mrws;
 	__le32 rsv_cqs;
@@ -1327,20 +1270,14 @@ struct hns_roce_query_pf_caps_e {
 	__le16 aeq_period;
 };
 
-#define V2_QUERY_PF_CAPS_E_RSV_MRWS_S 0
-#define V2_QUERY_PF_CAPS_E_RSV_MRWS_M GENMASK(19, 0)
-
-#define V2_QUERY_PF_CAPS_E_CHUNK_SIZE_SHIFT_S 20
-#define V2_QUERY_PF_CAPS_E_CHUNK_SIZE_SHIFT_M GENMASK(31, 20)
-
-#define V2_QUERY_PF_CAPS_E_RSV_CQS_S 0
-#define V2_QUERY_PF_CAPS_E_RSV_CQS_M GENMASK(19, 0)
+#define PF_CAPS_E_FIELD_LOC(h, l) \
+	FIELD_LOC(struct hns_roce_query_pf_caps_e, h, l)
 
-#define V2_QUERY_PF_CAPS_E_RSV_SRQS_S 0
-#define V2_QUERY_PF_CAPS_E_RSV_SRQS_M GENMASK(19, 0)
-
-#define V2_QUERY_PF_CAPS_E_RSV_LKEYS_S 0
-#define V2_QUERY_PF_CAPS_E_RSV_LKEYS_M GENMASK(19, 0)
+#define PF_CAPS_E_RSV_MRWS PF_CAPS_E_FIELD_LOC(19, 0)
+#define PF_CAPS_E_CHUNK_SIZE_SHIFT PF_CAPS_E_FIELD_LOC(31, 20)
+#define PF_CAPS_E_RSV_CQS PF_CAPS_E_FIELD_LOC(51, 32)
+#define PF_CAPS_E_RSV_SRQS PF_CAPS_E_FIELD_LOC(83, 64)
+#define PF_CAPS_E_RSV_LKEYS PF_CAPS_E_FIELD_LOC(115, 96)
 
 struct hns_roce_cmq_req {
 	__le32 data[6];
@@ -1441,9 +1378,6 @@ struct hns_roce_dip {
 #define HNS_ROCE_EQ_INIT_CONS_IDX		0
 #define HNS_ROCE_EQ_INIT_NXT_EQE_BA		0
 
-#define HNS_ROCE_V2_CEQ_CEQE_OWNER_S		31
-#define HNS_ROCE_V2_AEQ_AEQE_OWNER_S		31
-
 #define HNS_ROCE_V2_COMP_EQE_NUM		0x1000
 #define HNS_ROCE_V2_ASYNC_EQE_NUM		0x1000
 
@@ -1500,18 +1434,6 @@ struct hns_roce_eq_context {
 #define EQC_NEX_EQE_BA_H EQC_FIELD_LOC(339, 320)
 #define EQC_EQE_SIZE EQC_FIELD_LOC(341, 340)
 
-#define HNS_ROCE_V2_CEQE_COMP_CQN_S 0
-#define HNS_ROCE_V2_CEQE_COMP_CQN_M GENMASK(23, 0)
-
-#define HNS_ROCE_V2_AEQE_EVENT_TYPE_S 0
-#define HNS_ROCE_V2_AEQE_EVENT_TYPE_M GENMASK(7, 0)
-
-#define HNS_ROCE_V2_AEQE_SUB_TYPE_S 8
-#define HNS_ROCE_V2_AEQE_SUB_TYPE_M GENMASK(15, 8)
-
-#define HNS_ROCE_V2_AEQE_EVENT_QUEUE_NUM_S 0
-#define HNS_ROCE_V2_AEQE_EVENT_QUEUE_NUM_M GENMASK(23, 0)
-
 #define MAX_SERVICE_LEVEL 0x7
 
 struct hns_roce_wqe_atomic_seg {
diff --git a/drivers/infiniband/hw/hns/hns_roce_restrack.c b/drivers/infiniband/hw/hns/hns_roce_restrack.c
index 259444c0a630..24a154d64630 100644
--- a/drivers/infiniband/hw/hns/hns_roce_restrack.c
+++ b/drivers/infiniband/hw/hns/hns_roce_restrack.c
@@ -13,61 +13,40 @@ static int hns_roce_fill_cq(struct sk_buff *msg,
 			    struct hns_roce_v2_cq_context *context)
 {
 	if (rdma_nl_put_driver_u32(msg, "state",
-				   roce_get_field(context->byte_4_pg_ceqn,
-						  V2_CQC_BYTE_4_ARM_ST_M,
-						  V2_CQC_BYTE_4_ARM_ST_S)))
+				   hr_reg_read(context, CQC_ARM_ST)))
+
 		goto err;
 
 	if (rdma_nl_put_driver_u32(msg, "ceqn",
-				   roce_get_field(context->byte_4_pg_ceqn,
-						  V2_CQC_BYTE_4_CEQN_M,
-						  V2_CQC_BYTE_4_CEQN_S)))
+				   hr_reg_read(context, CQC_CEQN)))
 		goto err;
 
 	if (rdma_nl_put_driver_u32(msg, "cqn",
-				   roce_get_field(context->byte_8_cqn,
-						  V2_CQC_BYTE_8_CQN_M,
-						  V2_CQC_BYTE_8_CQN_S)))
+				   hr_reg_read(context, CQC_CQN)))
 		goto err;
 
 	if (rdma_nl_put_driver_u32(msg, "hopnum",
-				   roce_get_field(context->byte_16_hop_addr,
-						  V2_CQC_BYTE_16_CQE_HOP_NUM_M,
-						  V2_CQC_BYTE_16_CQE_HOP_NUM_S)))
+				   hr_reg_read(context, CQC_CQE_HOP_NUM)))
 		goto err;
 
-	if (rdma_nl_put_driver_u32(
-		    msg, "pi",
-		    roce_get_field(context->byte_28_cq_pi,
-				   V2_CQC_BYTE_28_CQ_PRODUCER_IDX_M,
-				   V2_CQC_BYTE_28_CQ_PRODUCER_IDX_S)))
+	if (rdma_nl_put_driver_u32(msg, "pi",
+				   hr_reg_read(context, CQC_CQ_PRODUCER_IDX)))
 		goto err;
 
-	if (rdma_nl_put_driver_u32(
-		    msg, "ci",
-		    roce_get_field(context->byte_32_cq_ci,
-				   V2_CQC_BYTE_32_CQ_CONSUMER_IDX_M,
-				   V2_CQC_BYTE_32_CQ_CONSUMER_IDX_S)))
+	if (rdma_nl_put_driver_u32(msg, "ci",
+				   hr_reg_read(context, CQC_CQ_CONSUMER_IDX)))
 		goto err;
 
-	if (rdma_nl_put_driver_u32(
-		    msg, "coalesce",
-		    roce_get_field(context->byte_56_cqe_period_maxcnt,
-				   V2_CQC_BYTE_56_CQ_MAX_CNT_M,
-				   V2_CQC_BYTE_56_CQ_MAX_CNT_S)))
+	if (rdma_nl_put_driver_u32(msg, "coalesce",
+				   hr_reg_read(context, CQC_CQ_MAX_CNT)))
 		goto err;
 
-	if (rdma_nl_put_driver_u32(
-		    msg, "period",
-		    roce_get_field(context->byte_56_cqe_period_maxcnt,
-				   V2_CQC_BYTE_56_CQ_PERIOD_M,
-				   V2_CQC_BYTE_56_CQ_PERIOD_S)))
+	if (rdma_nl_put_driver_u32(msg, "period",
+				   hr_reg_read(context, CQC_CQ_PERIOD)))
 		goto err;
 
 	if (rdma_nl_put_driver_u32(msg, "cnt",
-				   roce_get_field(context->byte_52_cqe_cnt,
-						  V2_CQC_BYTE_52_CQE_CNT_M,
-						  V2_CQC_BYTE_52_CQE_CNT_S)))
+				   hr_reg_read(context, CQC_CQE_CNT)))
 		goto err;
 
 	return 0;
-- 
2.33.0

