Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC9B2D5BB1
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Dec 2020 14:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389271AbgLJN0N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Dec 2020 08:26:13 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9587 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732768AbgLJN0M (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Dec 2020 08:26:12 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CsF4L4dn1zM32R;
        Thu, 10 Dec 2020 21:24:02 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Dec 2020 21:24:38 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v3 for-next 07/11] RDMA/hns: Fix coding style issues
Date:   Thu, 10 Dec 2020 21:22:48 +0800
Message-ID: <1607606572-11968-8-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1607606572-11968-1-git-send-email-liweihang@huawei.com>
References: <1607606572-11968-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Just format the code without modifying anything, including fixing some
redundant and missing blanks and spaces and changing the variable
definition order.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cmd.c   | 27 +++++++++++++--------------
 drivers/infiniband/hw/hns/hns_roce_cmd.h   |  4 ++--
 drivers/infiniband/hw/hns/hns_roce_cq.c    |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c   | 20 ++++++++++----------
 drivers/infiniband/hw/hns/hns_roce_hem.h   |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c |  9 +++------
 drivers/infiniband/hw/hns/hns_roce_hw_v1.h |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  9 +++------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  6 +++---
 drivers/infiniband/hw/hns/hns_roce_main.c  |  6 +++---
 drivers/infiniband/hw/hns/hns_roce_mr.c    |  4 ++--
 drivers/infiniband/hw/hns/hns_roce_qp.c    |  2 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c   |  1 -
 13 files changed, 43 insertions(+), 51 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c b/drivers/infiniband/hw/hns/hns_roce_cmd.c
index 455d533..c493d76 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
@@ -36,9 +36,9 @@
 #include "hns_roce_device.h"
 #include "hns_roce_cmd.h"
 
-#define CMD_POLL_TOKEN		0xffff
-#define CMD_MAX_NUM		32
-#define CMD_TOKEN_MASK		0x1f
+#define CMD_POLL_TOKEN 0xffff
+#define CMD_MAX_NUM 32
+#define CMD_TOKEN_MASK 0x1f
 
 static int hns_roce_cmd_mbox_post_hw(struct hns_roce_dev *hr_dev, u64 in_param,
 				     u64 out_param, u32 in_modifier,
@@ -93,8 +93,8 @@ static int hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev, u64 in_param,
 void hns_roce_cmd_event(struct hns_roce_dev *hr_dev, u16 token, u8 status,
 			u64 out_param)
 {
-	struct hns_roce_cmd_context
-		*context = &hr_dev->cmd.context[token & hr_dev->cmd.token_mask];
+	struct hns_roce_cmd_context *context =
+		&hr_dev->cmd.context[token % hr_dev->cmd.max_cmds];
 
 	if (token != context->token)
 		return;
@@ -164,8 +164,8 @@ static int hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 	int ret;
 
 	down(&hr_dev->cmd.event_sem);
-	ret = __hns_roce_cmd_mbox_wait(hr_dev, in_param, out_param,
-				       in_modifier, op_modifier, op, timeout);
+	ret = __hns_roce_cmd_mbox_wait(hr_dev, in_param, out_param, in_modifier,
+				       op_modifier, op, timeout);
 	up(&hr_dev->cmd.event_sem);
 
 	return ret;
@@ -231,9 +231,8 @@ int hns_roce_cmd_use_events(struct hns_roce_dev *hr_dev)
 	struct hns_roce_cmdq *hr_cmd = &hr_dev->cmd;
 	int i;
 
-	hr_cmd->context = kmalloc_array(hr_cmd->max_cmds,
-					sizeof(*hr_cmd->context),
-					GFP_KERNEL);
+	hr_cmd->context =
+		kcalloc(hr_cmd->max_cmds, sizeof(*hr_cmd->context), GFP_KERNEL);
 	if (!hr_cmd->context)
 		return -ENOMEM;
 
@@ -262,8 +261,8 @@ void hns_roce_cmd_use_polling(struct hns_roce_dev *hr_dev)
 	hr_cmd->use_events = 0;
 }
 
-struct hns_roce_cmd_mailbox
-	*hns_roce_alloc_cmd_mailbox(struct hns_roce_dev *hr_dev)
+struct hns_roce_cmd_mailbox *
+hns_roce_alloc_cmd_mailbox(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_cmd_mailbox *mailbox;
 
@@ -271,8 +270,8 @@ struct hns_roce_cmd_mailbox
 	if (!mailbox)
 		return ERR_PTR(-ENOMEM);
 
-	mailbox->buf = dma_pool_alloc(hr_dev->cmd.pool, GFP_KERNEL,
-				      &mailbox->dma);
+	mailbox->buf =
+		dma_pool_alloc(hr_dev->cmd.pool, GFP_KERNEL, &mailbox->dma);
 	if (!mailbox->buf) {
 		kfree(mailbox);
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.h b/drivers/infiniband/hw/hns/hns_roce_cmd.h
index 1915bac..8e63b82 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.h
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.h
@@ -143,8 +143,8 @@ int hns_roce_cmd_mbox(struct hns_roce_dev *hr_dev, u64 in_param, u64 out_param,
 		      unsigned long in_modifier, u8 op_modifier, u16 op,
 		      unsigned long timeout);
 
-struct hns_roce_cmd_mailbox
-	*hns_roce_alloc_cmd_mailbox(struct hns_roce_dev *hr_dev);
+struct hns_roce_cmd_mailbox *
+hns_roce_alloc_cmd_mailbox(struct hns_roce_dev *hr_dev);
 void hns_roce_free_cmd_mailbox(struct hns_roce_dev *hr_dev,
 			       struct hns_roce_cmd_mailbox *mailbox);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index e67c2b9..f25e535 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -40,9 +40,9 @@
 
 static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 {
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_cmd_mailbox *mailbox;
 	struct hns_roce_cq_table *cq_table;
-	struct ib_device *ibdev = &hr_dev->ib_dev;
 	u64 mtts[MTT_MIN_COUNT] = { 0 };
 	dma_addr_t dma_handle;
 	int ret;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index 359e5dd..303c8dd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -209,9 +209,9 @@ int hns_roce_calc_hem_mhop(struct hns_roce_dev *hr_dev,
 {
 	struct device *dev = hr_dev->dev;
 	u32 chunk_ba_num;
+	u32 chunk_size;
 	u32 table_idx;
 	u32 bt_num;
-	u32 chunk_size;
 
 	if (get_hem_table_config(hr_dev, mhop, table->type))
 		return -EINVAL;
@@ -343,15 +343,15 @@ static int hns_roce_set_hem(struct hns_roce_dev *hr_dev,
 {
 	spinlock_t *lock = &hr_dev->bt_cmd_lock;
 	struct device *dev = hr_dev->dev;
-	long end;
-	unsigned long flags;
 	struct hns_roce_hem_iter iter;
 	void __iomem *bt_cmd;
 	__le32 bt_cmd_val[2];
 	__le32 bt_cmd_h = 0;
+	unsigned long flags;
 	__le32 bt_cmd_l;
-	u64 bt_ba;
 	int ret = 0;
+	u64 bt_ba;
+	long end;
 
 	/* Find the HEM(Hardware Entry Memory) entry */
 	unsigned long i = (obj & (table->num_obj - 1)) /
@@ -651,8 +651,8 @@ int hns_roce_table_get(struct hns_roce_dev *hr_dev,
 		       struct hns_roce_hem_table *table, unsigned long obj)
 {
 	struct device *dev = hr_dev->dev;
-	int ret = 0;
 	unsigned long i;
+	int ret = 0;
 
 	if (hns_roce_check_whether_mhop(hr_dev, table->type))
 		return hns_roce_table_mhop_get(hr_dev, table, obj);
@@ -800,14 +800,14 @@ void *hns_roce_table_find(struct hns_roce_dev *hr_dev,
 	struct hns_roce_hem_chunk *chunk;
 	struct hns_roce_hem_mhop mhop;
 	struct hns_roce_hem *hem;
-	void *addr = NULL;
 	unsigned long mhop_obj = obj;
 	unsigned long obj_per_chunk;
 	unsigned long idx_offset;
 	int offset, dma_offset;
+	void *addr = NULL;
+	u32 hem_idx = 0;
 	int length;
 	int i, j;
-	u32 hem_idx = 0;
 
 	if (!table->lowmem)
 		return NULL;
@@ -977,8 +977,8 @@ static void hns_roce_cleanup_mhop_hem_table(struct hns_roce_dev *hr_dev,
 {
 	struct hns_roce_hem_mhop mhop;
 	u32 buf_chunk_size;
-	int i;
 	u64 obj;
+	int i;
 
 	if (hns_roce_calc_hem_mhop(hr_dev, table, NULL, &mhop))
 		return;
@@ -1313,8 +1313,8 @@ static int hem_list_alloc_root_bt(struct hns_roce_dev *hr_dev,
 				  const struct hns_roce_buf_region *regions,
 				  int region_cnt)
 {
-	struct roce_hem_item *hem, *temp_hem, *root_hem;
 	struct list_head temp_list[HNS_ROCE_MAX_BT_REGION];
+	struct roce_hem_item *hem, *temp_hem, *root_hem;
 	const struct hns_roce_buf_region *r;
 	struct list_head temp_root;
 	struct list_head temp_btm;
@@ -1419,8 +1419,8 @@ int hns_roce_hem_list_request(struct hns_roce_dev *hr_dev,
 {
 	const struct hns_roce_buf_region *r;
 	int ofs, end;
-	int ret;
 	int unit;
+	int ret;
 	int i;
 
 	if (region_cnt > HNS_ROCE_MAX_BT_REGION) {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.h b/drivers/infiniband/hw/hns/hns_roce_hem.h
index c6bd982..13fdeb3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.h
@@ -175,4 +175,4 @@ static inline dma_addr_t hns_roce_hem_addr(struct hns_roce_hem_iter *iter)
 	return sg_dma_address(&iter->chunk->mem[iter->page_idx]);
 }
 
-#endif /*_HNS_ROCE_HEM_H*/
+#endif /* _HNS_ROCE_HEM_H */
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index f18380f..eb0fd72 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -239,7 +239,7 @@ static int hns_roce_v1_post_send(struct ib_qp *ibqp,
 				break;
 			}
 
-			/*Ctrl field, ctrl set type: sig, solic, imm, fence */
+			/* Ctrl field, ctrl set type: sig, solic, imm, fence */
 			/* SO wait for conforming application scenarios */
 			ctrl->flag |= (wr->send_flags & IB_SEND_SIGNALED ?
 				      cpu_to_le32(HNS_ROCE_WQE_CQ_NOTIFY) : 0) |
@@ -300,7 +300,7 @@ static int hns_roce_v1_post_send(struct ib_qp *ibqp,
 				}
 				ctrl->flag |= cpu_to_le32(HNS_ROCE_WQE_INLINE);
 			} else {
-				/*sqe num is two */
+				/* sqe num is two */
 				for (i = 0; i < wr->num_sge; i++)
 					set_data_seg(dseg + i, wr->sg_list + i);
 
@@ -1165,7 +1165,7 @@ static int hns_roce_raq_init(struct hns_roce_dev *hr_dev)
 	}
 	raq->e_raq_buf->map = addr;
 
-	/* Configure raq extended address. 48bit 4K align*/
+	/* Configure raq extended address. 48bit 4K align */
 	roce_write(hr_dev, ROCEE_EXT_RAQ_REG, raq->e_raq_buf->map >> 12);
 
 	/* Configure raq_shift */
@@ -2760,7 +2760,6 @@ static int hns_roce_v1_m_qp(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 		roce_set_field(context->qpc_bytes_16,
 			       QP_CONTEXT_QPC_BYTES_16_QP_NUM_M,
 			       QP_CONTEXT_QPC_BYTES_16_QP_NUM_S, hr_qp->qpn);
-
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_INIT) {
 		roce_set_field(context->qpc_bytes_4,
 			       QP_CONTEXT_QPC_BYTES_4_TRANSPORT_SERVICE_TYPE_M,
@@ -3795,7 +3794,6 @@ static int hns_roce_v1_aeq_int(struct hns_roce_dev *hr_dev,
 	int event_type;
 
 	while ((aeqe = next_aeqe_sw_v1(eq))) {
-
 		/* Make sure we read the AEQ entry after we have checked the
 		 * ownership bit
 		 */
@@ -3900,7 +3898,6 @@ static int hns_roce_v1_ceq_int(struct hns_roce_dev *hr_dev,
 	u32 cqn;
 
 	while ((ceqe = next_ceqe_sw_v1(eq))) {
-
 		/* Make sure we read CEQ entry after we have checked the
 		 * ownership bit
 		 */
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.h b/drivers/infiniband/hw/hns/hns_roce_hw_v1.h
index ffd0156..46ab0a3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.h
@@ -419,7 +419,7 @@ struct hns_roce_wqe_data_seg {
 
 struct hns_roce_wqe_raddr_seg {
 	__le32 rkey;
-	__le32 len;/* reserved */
+	__le32 len; /* reserved */
 	__le64 raddr;
 };
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 6d80cda..941a70b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1025,8 +1025,8 @@ static int hns_roce_v2_rst_process_cmd(struct hns_roce_dev *hr_dev)
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hnae3_handle *handle = priv->handle;
 	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
-	unsigned long instance_stage;	/* the current instance stage */
-	unsigned long reset_stage;	/* the current reset stage */
+	unsigned long instance_stage; /* the current instance stage */
+	unsigned long reset_stage; /* the current reset stage */
 	unsigned long reset_cnt;
 	bool sw_resetting;
 	bool hw_resetting;
@@ -2451,7 +2451,6 @@ static int hns_roce_init_link_table(struct hns_roce_dev *hr_dev,
 		if (i < (pg_num - 1))
 			entry[i].blk_ba1_nxt_ptr |=
 				(i + 1) << HNS_ROCE_LINK_TABLE_NXT_PTR_S;
-
 	}
 	link_tbl->npages = pg_num;
 	link_tbl->pg_sz = buf_chk_sz;
@@ -5619,16 +5618,14 @@ static int hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 		case HNS_ROCE_EVENT_TYPE_CQ_OVERFLOW:
 			hns_roce_cq_event(hr_dev, cqn, event_type);
 			break;
-		case HNS_ROCE_EVENT_TYPE_DB_OVERFLOW:
-			break;
 		case HNS_ROCE_EVENT_TYPE_MB:
 			hns_roce_cmd_event(hr_dev,
 					le16_to_cpu(aeqe->event.cmd.token),
 					aeqe->event.cmd.status,
 					le64_to_cpu(aeqe->event.cmd.out_param));
 			break;
+		case HNS_ROCE_EVENT_TYPE_DB_OVERFLOW:
 		case HNS_ROCE_EVENT_TYPE_CEQ_OVERFLOW:
-			break;
 		case HNS_ROCE_EVENT_TYPE_FLR:
 			break;
 		default:
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index fac8536..bdaccf8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -449,7 +449,7 @@ struct hns_roce_srq_context {
 #define SRQC_BYTE_60_SRQ_DB_RECORD_ADDR_S 1
 #define SRQC_BYTE_60_SRQ_DB_RECORD_ADDR_M GENMASK(31, 1)
 
-enum{
+enum {
 	V2_MPT_ST_VALID = 0x1,
 	V2_MPT_ST_FREE	= 0x2,
 };
@@ -1094,9 +1094,9 @@ struct hns_roce_v2_ud_send_wqe {
 	u8	sgid_index;
 	u8	smac_index;
 	u8	dgid[GID_LEN_V2];
-
 };
-#define	V2_UD_SEND_WQE_BYTE_4_OPCODE_S 0
+
+#define V2_UD_SEND_WQE_BYTE_4_OPCODE_S 0
 #define V2_UD_SEND_WQE_BYTE_4_OPCODE_M GENMASK(4, 0)
 
 #define	V2_UD_SEND_WQE_BYTE_4_OWNER_S 7
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index dbb1af1..3f3de32 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -555,8 +555,8 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 
 static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 {
-	int ret;
 	struct device *dev = hr_dev->dev;
+	int ret;
 
 	ret = hns_roce_init_hem_table(hr_dev, &hr_dev->mr_table.mtpt_table,
 				      HEM_TYPE_MTPT, hr_dev->caps.mtpt_entry_sz,
@@ -713,8 +713,8 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
  */
 static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 {
-	int ret;
 	struct device *dev = hr_dev->dev;
+	int ret;
 
 	spin_lock_init(&hr_dev->sm_lock);
 	spin_lock_init(&hr_dev->bt_cmd_lock);
@@ -838,8 +838,8 @@ void hns_roce_handle_device_err(struct hns_roce_dev *hr_dev)
 
 int hns_roce_init(struct hns_roce_dev *hr_dev)
 {
-	int ret;
 	struct device *dev = hr_dev->dev;
+	int ret;
 
 	if (hr_dev->hw->reset) {
 		ret = hr_dev->hw->reset(hr_dev, true);
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 9867192..b9a7e73 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -167,10 +167,10 @@ static void hns_roce_mr_free(struct hns_roce_dev *hr_dev,
 static int hns_roce_mr_enable(struct hns_roce_dev *hr_dev,
 			      struct hns_roce_mr *mr)
 {
-	int ret;
 	unsigned long mtpt_idx = key_to_hw_index(mr->key);
-	struct device *dev = hr_dev->dev;
 	struct hns_roce_cmd_mailbox *mailbox;
+	struct device *dev = hr_dev->dev;
+	int ret;
 
 	/* Allocate mailbox memory */
 	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 76a7c95..f89c52b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -113,8 +113,8 @@ void hns_roce_qp_event(struct hns_roce_dev *hr_dev, u32 qpn, int event_type)
 static void hns_roce_ib_qp_event(struct hns_roce_qp *hr_qp,
 				 enum hns_roce_event type)
 {
-	struct ib_event event;
 	struct ib_qp *ibqp = &hr_qp->ibqp;
+	struct ib_event event;
 
 	if (ibqp->event_handler) {
 		event.device = ibqp->device;
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 6a3ebb3..e2e77873 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -239,7 +239,6 @@ static int alloc_srq_idx(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 			err = -ENOMEM;
 			goto err_idx_mtr;
 		}
-
 	}
 
 	return 0;
-- 
2.8.1

