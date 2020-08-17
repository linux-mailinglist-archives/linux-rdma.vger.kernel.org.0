Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D6424669D
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Aug 2020 14:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgHQMrC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Aug 2020 08:47:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47958 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728284AbgHQMrB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 Aug 2020 08:47:01 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 30892639ED4C3E756B4E;
        Mon, 17 Aug 2020 20:46:52 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 17 Aug 2020 20:46:43 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 4/4] RDMA/hns: Add support for QPC in size of 512 Bytes
Date:   Mon, 17 Aug 2020 20:45:44 +0800
Message-ID: <1597668344-48575-5-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1597668344-48575-1-git-send-email-liweihang@huawei.com>
References: <1597668344-48575-1-git-send-email-liweihang@huawei.com>
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
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  5 ++++-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.h  |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 26 +++++++++++++++++---------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  4 ++--
 drivers/infiniband/hw/hns/hns_roce_main.c   |  2 +-
 6 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index e24d88a..876bcd2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -87,6 +87,9 @@
 #define HNS_ROCE_V2_CQE_SIZE		32
 #define HNS_ROCE_V3_CQE_SIZE		64
 
+#define HNS_ROCE_V2_QPC_SZ			256
+#define HNS_ROCE_V3_QPC_SZ			512
+
 #define HNS_ROCE_SL_SHIFT			28
 #define HNS_ROCE_TCLASS_SHIFT			20
 #define HNS_ROCE_FLOW_LABEL_MASK		0xfffff
@@ -806,7 +809,7 @@ struct hns_roce_caps {
 	u32		page_size_cap;
 	u32		reserved_lkey;
 	int		mtpt_entry_sz;
-	int		qpc_entry_sz;
+	int		qpc_sz;
 	int		irrl_entry_sz;
 	int		trrl_entry_sz;
 	int		cqc_entry_sz;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index ff76bf5..4aaca5e 100644
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
index 52307b2..b0404d9 100644
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
index e0ff87e..76e0a1d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1683,7 +1683,7 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->max_sq_desc_sz	= HNS_ROCE_V2_MAX_SQ_DESC_SZ;
 	caps->max_rq_desc_sz	= HNS_ROCE_V2_MAX_RQ_DESC_SZ;
 	caps->max_srq_desc_sz	= HNS_ROCE_V2_MAX_SRQ_DESC_SZ;
-	caps->qpc_entry_sz	= HNS_ROCE_V2_QPC_ENTRY_SZ;
+	caps->qpc_sz		= HNS_ROCE_V2_QPC_SZ;
 	caps->irrl_entry_sz	= HNS_ROCE_V2_IRRL_ENTRY_SZ;
 	caps->trrl_entry_sz	= HNS_ROCE_V2_EXT_ATOMIC_TRRL_ENTRY_SZ;
 	caps->cqc_entry_sz	= HNS_ROCE_V2_CQC_ENTRY_SZ;
@@ -1772,6 +1772,7 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 		caps->aeqe_size = HNS_ROCE_V3_EQE_SIZE;
 		caps->ceqe_size = HNS_ROCE_V3_EQE_SIZE;
 		caps->cq_entry_sz = HNS_ROCE_V3_CQE_SIZE;
+		caps->qpc_sz = HNS_ROCE_V3_QPC_SZ;
 	}
 }
 
@@ -1874,7 +1875,7 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	caps->idx_entry_sz	     = resp_b->idx_entry_sz;
 	caps->sccc_entry_sz	     = resp_b->scc_ctx_entry_sz;
 	caps->max_mtu		     = resp_b->max_mtu;
-	caps->qpc_entry_sz	     = le16_to_cpu(resp_b->qpc_entry_sz);
+	caps->qpc_sz		     = HNS_ROCE_V2_QPC_SZ;
 	caps->min_cqes		     = resp_b->min_cqes;
 	caps->min_wqes		     = resp_b->min_wqes;
 	caps->page_size_cap	     = le32_to_cpu(resp_b->page_size_cap);
@@ -1996,9 +1997,10 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 		caps->ceqe_size = HNS_ROCE_V3_EQE_SIZE;
 		caps->aeqe_size = HNS_ROCE_V3_EQE_SIZE;
 		caps->cq_entry_sz = HNS_ROCE_V3_CQE_SIZE;
+		caps->qpc_sz = HNS_ROCE_V3_QPC_SZ;
 	}
 
-	calc_pg_sz(caps->num_qps, caps->qpc_entry_sz, caps->qpc_hop_num,
+	calc_pg_sz(caps->num_qps, caps->qpc_sz, caps->qpc_hop_num,
 		   caps->qpc_bt_num, &caps->qpc_buf_pg_sz, &caps->qpc_ba_pg_sz,
 		   HEM_TYPE_QPC);
 	calc_pg_sz(caps->num_mtpts, caps->mtpt_entry_sz, caps->mpt_hop_num,
@@ -3534,16 +3536,21 @@ static int hns_roce_v2_clear_hem(struct hns_roce_dev *hr_dev,
 
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
@@ -4319,7 +4326,7 @@ static int hns_roce_v2_set_abs_fields(struct ib_qp *ibqp,
 	}
 
 	if (cur_state == IB_QPS_RESET && new_state == IB_QPS_INIT) {
-		memset(qpc_mask, 0, sizeof(*qpc_mask));
+		memset(qpc_mask, 0, hr_dev->caps.qpc_sz);
 		modify_qp_reset_to_init(ibqp, attr, attr_mask, context,
 					qpc_mask);
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_INIT) {
@@ -4542,8 +4549,9 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
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
@@ -4593,7 +4601,7 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 		       V2_QPC_BYTE_60_QP_ST_S, 0);
 
 	/* SW pass context to HW */
-	ret = hns_roce_v2_qp_modify(hr_dev, ctx, hr_qp);
+	ret = hns_roce_v2_qp_modify(hr_dev, context, qpc_mask, hr_qp);
 	if (ret) {
 		ibdev_err(ibdev, "failed to modify QP, ret = %d\n", ret);
 		goto out;
@@ -4656,7 +4664,7 @@ static int hns_roce_v2_query_qpc(struct hns_roce_dev *hr_dev,
 	if (ret)
 		goto out;
 
-	memcpy(hr_context, mailbox->buf, sizeof(*hr_context));
+	memcpy(hr_context, mailbox->buf, hr_dev->caps.qpc_sz);
 
 out:
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 059e308..07a74df 100644
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
@@ -516,6 +515,7 @@ struct hns_roce_v2_qp_context {
 	__le32	byte_248_ack_psn;
 	__le32	byte_252_err_txcqn;
 	__le32	byte_256_sqflush_rqcqe;
+	__le32	ext[64];
 };
 
 #define	V2_QPC_BYTE_4_TST_S 0
@@ -1588,7 +1588,7 @@ struct hns_roce_query_pf_caps_b {
 	u8 idx_entry_sz;
 	u8 scc_ctx_entry_sz;
 	u8 max_mtu;
-	__le16 qpc_entry_sz;
+	__le16 qpc_sz;
 	__le16 qpc_timer_entry_sz;
 	__le16 cqc_timer_entry_sz;
 	u8 min_cqes;
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 2213c75..015186a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -590,7 +590,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 	}
 
 	ret = hns_roce_init_hem_table(hr_dev, &hr_dev->qp_table.qp_table,
-				      HEM_TYPE_QPC, hr_dev->caps.qpc_entry_sz,
+				      HEM_TYPE_QPC, hr_dev->caps.qpc_sz,
 				      hr_dev->caps.num_qps, 1);
 	if (ret) {
 		dev_err(dev, "Failed to init QP context memory, aborting.\n");
-- 
2.8.1

