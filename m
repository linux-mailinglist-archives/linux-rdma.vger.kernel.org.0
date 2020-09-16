Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C8726BF9B
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 10:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgIPIo4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Sep 2020 04:44:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42494 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726381AbgIPIow (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Sep 2020 04:44:52 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 32CDF513321418FF99FC;
        Wed, 16 Sep 2020 16:44:46 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Wed, 16 Sep 2020 16:44:35 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v4 for-next 3/4] RDMA/hns: Add support for QPC in size of 512 Bytes
Date:   Wed, 16 Sep 2020 16:43:25 +0800
Message-ID: <1600245806-56321-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1600245806-56321-1-git-send-email-liweihang@huawei.com>
References: <1600245806-56321-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

The new version of RoCEE supports using QPC in size of 256B or 512B, so
that HIP09 can supports new congestion control algorithms by using QPC in
larger size.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  5 ++-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.h  |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 66 +++++++++++++++++++++++------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 16 ++++++-
 drivers/infiniband/hw/hns/hns_roce_main.c   |  2 +-
 6 files changed, 75 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index ad341f7..ef17499 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -84,6 +84,9 @@
 #define HNS_ROCE_V2_CQE_SIZE 32
 #define HNS_ROCE_V3_CQE_SIZE 64
 
+#define HNS_ROCE_V2_QPC_SZ 256
+#define HNS_ROCE_V3_QPC_SZ 512
+
 #define HNS_ROCE_SL_SHIFT			28
 #define HNS_ROCE_TCLASS_SHIFT			20
 #define HNS_ROCE_FLOW_LABEL_MASK		0xfffff
@@ -804,7 +807,7 @@ struct hns_roce_caps {
 	u32		page_size_cap;
 	u32		reserved_lkey;
 	int		mtpt_entry_sz;
-	int		qpc_entry_sz;
+	int		qpc_sz;
 	int		irrl_entry_sz;
 	int		trrl_entry_sz;
 	int		cqc_entry_sz;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index eb463de..093ff52 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -1471,7 +1471,7 @@ static int hns_roce_v1_profile(struct hns_roce_dev *hr_dev)
 	caps->max_qp_dest_rdma	= HNS_ROCE_V1_MAX_QP_DEST_RDMA;
 	caps->max_sq_desc_sz	= HNS_ROCE_V1_MAX_SQ_DESC_SZ;
 	caps->max_rq_desc_sz	= HNS_ROCE_V1_MAX_RQ_DESC_SZ;
-	caps->qpc_entry_sz	= HNS_ROCE_V1_QPC_ENTRY_SIZE;
+	caps->qpc_sz		= HNS_ROCE_V1_QPC_SIZE;
 	caps->irrl_entry_sz	= HNS_ROCE_V1_IRRL_ENTRY_SIZE;
 	caps->cqc_entry_sz	= HNS_ROCE_V1_CQC_ENTRY_SIZE;
 	caps->mtpt_entry_sz	= HNS_ROCE_V1_MTPT_ENTRY_SIZE;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.h b/drivers/infiniband/hw/hns/hns_roce_hw_v1.h
index 5996892..ffd0156 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.h
@@ -68,7 +68,7 @@
 #define HNS_ROCE_V1_COMP_EQE_NUM			0x8000
 #define HNS_ROCE_V1_ASYNC_EQE_NUM			0x400
 
-#define HNS_ROCE_V1_QPC_ENTRY_SIZE			256
+#define HNS_ROCE_V1_QPC_SIZE				256
 #define HNS_ROCE_V1_IRRL_ENTRY_SIZE			8
 #define HNS_ROCE_V1_CQC_ENTRY_SIZE			64
 #define HNS_ROCE_V1_MTPT_ENTRY_SIZE			64
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 835fbd7..170bb6c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1682,7 +1682,7 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->max_sq_desc_sz	= HNS_ROCE_V2_MAX_SQ_DESC_SZ;
 	caps->max_rq_desc_sz	= HNS_ROCE_V2_MAX_RQ_DESC_SZ;
 	caps->max_srq_desc_sz	= HNS_ROCE_V2_MAX_SRQ_DESC_SZ;
-	caps->qpc_entry_sz	= HNS_ROCE_V2_QPC_ENTRY_SZ;
+	caps->qpc_sz		= HNS_ROCE_V2_QPC_SZ;
 	caps->irrl_entry_sz	= HNS_ROCE_V2_IRRL_ENTRY_SZ;
 	caps->trrl_entry_sz	= HNS_ROCE_V2_EXT_ATOMIC_TRRL_ENTRY_SZ;
 	caps->cqc_entry_sz	= HNS_ROCE_V2_CQC_ENTRY_SZ;
@@ -1771,6 +1771,7 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 		caps->aeqe_size = HNS_ROCE_V3_EQE_SIZE;
 		caps->ceqe_size = HNS_ROCE_V3_EQE_SIZE;
 		caps->cqe_sz = HNS_ROCE_V3_CQE_SIZE;
+		caps->qpc_sz = HNS_ROCE_V3_QPC_SZ;
 	}
 }
 
@@ -1873,7 +1874,7 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	caps->idx_entry_sz	     = resp_b->idx_entry_sz;
 	caps->sccc_entry_sz	     = resp_b->scc_ctx_entry_sz;
 	caps->max_mtu		     = resp_b->max_mtu;
-	caps->qpc_entry_sz	     = le16_to_cpu(resp_b->qpc_entry_sz);
+	caps->qpc_sz		     = HNS_ROCE_V2_QPC_SZ;
 	caps->min_cqes		     = resp_b->min_cqes;
 	caps->min_wqes		     = resp_b->min_wqes;
 	caps->page_size_cap	     = le32_to_cpu(resp_b->page_size_cap);
@@ -1995,9 +1996,10 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 		caps->ceqe_size = HNS_ROCE_V3_EQE_SIZE;
 		caps->aeqe_size = HNS_ROCE_V3_EQE_SIZE;
 		caps->cqe_sz = HNS_ROCE_V3_CQE_SIZE;
+		caps->qpc_sz = HNS_ROCE_V3_QPC_SZ;
 	}
 
-	calc_pg_sz(caps->num_qps, caps->qpc_entry_sz, caps->qpc_hop_num,
+	calc_pg_sz(caps->num_qps, caps->qpc_sz, caps->qpc_hop_num,
 		   caps->qpc_bt_num, &caps->qpc_buf_pg_sz, &caps->qpc_ba_pg_sz,
 		   HEM_TYPE_QPC);
 	calc_pg_sz(caps->num_mtpts, caps->mtpt_entry_sz, caps->mpt_hop_num,
@@ -2034,6 +2036,35 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	return 0;
 }
 
+static int hns_roce_config_qpc_size(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_cmq_desc desc;
+	struct hns_roce_cfg_entry_size *cfg_size =
+				  (struct hns_roce_cfg_entry_size *)desc.data;
+
+	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_CFG_ENTRY_SIZE,
+				      false);
+
+	cfg_size->type = cpu_to_le32(HNS_ROCE_CFG_QPC_SIZE);
+	cfg_size->size = cpu_to_le32(hr_dev->caps.qpc_sz);
+
+	return hns_roce_cmq_send(hr_dev, &desc, 1);
+}
+
+static int hns_roce_config_entry_size(struct hns_roce_dev *hr_dev)
+{
+	int ret;
+
+	if (hr_dev->pci_dev->revision < PCI_REVISION_ID_HIP09)
+		return 0;
+
+	ret = hns_roce_config_qpc_size(hr_dev);
+	if (ret)
+		dev_err(hr_dev->dev, "failed to cfg qpc sz, ret = %d.\n", ret);
+
+	return ret;
+}
+
 static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_caps *caps = &hr_dev->caps;
@@ -2106,9 +2137,14 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
 	}
 
 	ret = hns_roce_v2_set_bt(hr_dev);
-	if (ret)
-		dev_err(hr_dev->dev, "Configure bt attribute fail, ret = %d.\n",
-			ret);
+	if (ret) {
+		dev_err(hr_dev->dev,
+			"Configure bt attribute fail, ret = %d.\n", ret);
+		return ret;
+	}
+
+	/* Configure the size of QPC, SCCC, etc. */
+	ret = hns_roce_config_entry_size(hr_dev);
 
 	return ret;
 }
@@ -3534,16 +3570,21 @@ static int hns_roce_v2_clear_hem(struct hns_roce_dev *hr_dev,
 
 static int hns_roce_v2_qp_modify(struct hns_roce_dev *hr_dev,
 				 struct hns_roce_v2_qp_context *context,
+				 struct hns_roce_v2_qp_context *qpc_mask,
 				 struct hns_roce_qp *hr_qp)
 {
 	struct hns_roce_cmd_mailbox *mailbox;
+	int qpc_size;
 	int ret;
 
 	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
 	if (IS_ERR(mailbox))
 		return PTR_ERR(mailbox);
 
-	memcpy(mailbox->buf, context, sizeof(*context) * 2);
+	/* The qpc size of HIP08 is only 256B, which is half of HIP09 */
+	qpc_size = hr_dev->caps.qpc_sz;
+	memcpy(mailbox->buf, context, qpc_size);
+	memcpy(mailbox->buf + qpc_size, qpc_mask, qpc_size);
 
 	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, hr_qp->qpn, 0,
 				HNS_ROCE_CMD_MODIFY_QPC,
@@ -4338,7 +4379,7 @@ static int hns_roce_v2_set_abs_fields(struct ib_qp *ibqp,
 	}
 
 	if (cur_state == IB_QPS_RESET && new_state == IB_QPS_INIT) {
-		memset(qpc_mask, 0, sizeof(*qpc_mask));
+		memset(qpc_mask, 0, hr_dev->caps.qpc_sz);
 		modify_qp_reset_to_init(ibqp, attr, attr_mask, context,
 					qpc_mask);
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_INIT) {
@@ -4561,8 +4602,9 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 	 * we should set all bits of the relevant fields in context mask to
 	 * 0 at the same time, else set them to 0x1.
 	 */
-	memset(context, 0, sizeof(*context));
-	memset(qpc_mask, 0xff, sizeof(*qpc_mask));
+	memset(context, 0, hr_dev->caps.qpc_sz);
+	memset(qpc_mask, 0xff, hr_dev->caps.qpc_sz);
+
 	ret = hns_roce_v2_set_abs_fields(ibqp, attr, attr_mask, cur_state,
 					 new_state, context, qpc_mask);
 	if (ret)
@@ -4612,7 +4654,7 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 		       V2_QPC_BYTE_60_QP_ST_S, 0);
 
 	/* SW pass context to HW */
-	ret = hns_roce_v2_qp_modify(hr_dev, ctx, hr_qp);
+	ret = hns_roce_v2_qp_modify(hr_dev, context, qpc_mask, hr_qp);
 	if (ret) {
 		ibdev_err(ibdev, "failed to modify QP, ret = %d\n", ret);
 		goto out;
@@ -4675,7 +4717,7 @@ static int hns_roce_v2_query_qpc(struct hns_roce_dev *hr_dev,
 	if (ret)
 		goto out;
 
-	memcpy(hr_context, mailbox->buf, sizeof(*hr_context));
+	memcpy(hr_context, mailbox->buf, hr_dev->caps.qpc_sz);
 
 out:
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index ca6b055..32c5ddc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -77,7 +77,6 @@
 #define HNS_ROCE_V2_MAX_SQ_DESC_SZ		64
 #define HNS_ROCE_V2_MAX_RQ_DESC_SZ		16
 #define HNS_ROCE_V2_MAX_SRQ_DESC_SZ		64
-#define HNS_ROCE_V2_QPC_ENTRY_SZ		256
 #define HNS_ROCE_V2_IRRL_ENTRY_SZ		64
 #define HNS_ROCE_V2_TRRL_ENTRY_SZ		48
 #define HNS_ROCE_V2_EXT_ATOMIC_TRRL_ENTRY_SZ	100
@@ -228,6 +227,7 @@ enum hns_roce_opcode_type {
 	HNS_ROCE_OPC_CFG_TMOUT_LLM			= 0x8404,
 	HNS_ROCE_OPC_QUERY_PF_TIMER_RES			= 0x8406,
 	HNS_ROCE_OPC_QUERY_PF_CAPS_NUM                  = 0x8408,
+	HNS_ROCE_OPC_CFG_ENTRY_SIZE			= 0x8409,
 	HNS_ROCE_OPC_CFG_SGID_TB			= 0x8500,
 	HNS_ROCE_OPC_CFG_SMAC_TB			= 0x8501,
 	HNS_ROCE_OPC_POST_MB				= 0x8504,
@@ -514,6 +514,7 @@ struct hns_roce_v2_qp_context {
 	__le32	byte_248_ack_psn;
 	__le32	byte_252_err_txcqn;
 	__le32	byte_256_sqflush_rqcqe;
+	__le32	ext[64];
 };
 
 #define	V2_QPC_BYTE_4_TST_S 0
@@ -1540,6 +1541,17 @@ struct hns_roce_cfg_sgid_tb {
 	__le32	vf_sgid_h;
 	__le32	vf_sgid_type_rsv;
 };
+
+enum {
+	HNS_ROCE_CFG_QPC_SIZE = BIT(0),
+};
+
+struct hns_roce_cfg_entry_size {
+	__le32	type;
+	__le32	rsv[4];
+	__le32	size;
+};
+
 #define CFG_SGID_TB_TABLE_IDX_S 0
 #define CFG_SGID_TB_TABLE_IDX_M GENMASK(7, 0)
 
@@ -1586,7 +1598,7 @@ struct hns_roce_query_pf_caps_b {
 	u8 idx_entry_sz;
 	u8 scc_ctx_entry_sz;
 	u8 max_mtu;
-	__le16 qpc_entry_sz;
+	__le16 qpc_sz;
 	__le16 qpc_timer_entry_sz;
 	__le16 cqc_timer_entry_sz;
 	u8 min_cqes;
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 7d90ec5..6f9715a0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -589,7 +589,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 	}
 
 	ret = hns_roce_init_hem_table(hr_dev, &hr_dev->qp_table.qp_table,
-				      HEM_TYPE_QPC, hr_dev->caps.qpc_entry_sz,
+				      HEM_TYPE_QPC, hr_dev->caps.qpc_sz,
 				      hr_dev->caps.num_qps, 1);
 	if (ret) {
 		dev_err(dev, "Failed to init QP context memory, aborting.\n");
-- 
2.8.1

