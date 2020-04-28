Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D851BBBD9
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2020 13:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgD1LEC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Apr 2020 07:04:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3367 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726458AbgD1LEC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Apr 2020 07:04:02 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 95B9C65763DAAE98523D;
        Tue, 28 Apr 2020 19:03:58 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Apr 2020 19:03:49 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v4 for-next 4/5] RDMA/hns: Move SRQ code to the reasonable place
Date:   Tue, 28 Apr 2020 19:03:42 +0800
Message-ID: <1588071823-40200-5-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1588071823-40200-1-git-send-email-liweihang@huawei.com>
References: <1588071823-40200-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixian Liu <liuyixian@huawei.com>

Just move the SRQ related code to more reasonable place, and unify format
of some prints.

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 795 ++++++++++++++---------------
 1 file changed, 396 insertions(+), 399 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 158b831..0b79daf 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -694,6 +694,129 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 	return ret;
 }
 
+static void *get_srq_wqe(struct hns_roce_srq *srq, int n)
+{
+	return hns_roce_buf_offset(srq->buf_mtr.kmem, n << srq->wqe_shift);
+}
+
+static void hns_roce_free_srq_wqe(struct hns_roce_srq *srq, int wqe_index)
+{
+	/* always called with interrupts disabled. */
+	spin_lock(&srq->lock);
+
+	bitmap_clear(srq->idx_que.bitmap, wqe_index, 1);
+	srq->tail++;
+
+	spin_unlock(&srq->lock);
+}
+
+static int find_empty_entry(struct hns_roce_idx_que *idx_que,
+			    unsigned long size)
+{
+	int wqe_idx;
+
+	if (unlikely(bitmap_full(idx_que->bitmap, size)))
+		return -ENOSPC;
+
+	wqe_idx = find_first_zero_bit(idx_que->bitmap, size);
+
+	bitmap_set(idx_que->bitmap, wqe_idx, 1);
+
+	return wqe_idx;
+}
+
+static void fill_idx_queue(struct hns_roce_idx_que *idx_que,
+			   int cur_idx, int wqe_idx)
+{
+	unsigned int *addr;
+
+	addr = (unsigned int *)hns_roce_buf_offset(idx_que->mtr.kmem,
+						   cur_idx * idx_que->entry_sz);
+	*addr = wqe_idx;
+}
+
+static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
+				     const struct ib_recv_wr *wr,
+				     const struct ib_recv_wr **bad_wr)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibsrq->device);
+	struct hns_roce_srq *srq = to_hr_srq(ibsrq);
+	struct hns_roce_v2_wqe_data_seg *dseg;
+	struct hns_roce_v2_db srq_db;
+	unsigned long flags;
+	int ret = 0;
+	int wqe_idx;
+	void *wqe;
+	int nreq;
+	int ind;
+	int i;
+
+	spin_lock_irqsave(&srq->lock, flags);
+
+	ind = srq->head & (srq->wqe_cnt - 1);
+
+	for (nreq = 0; wr; ++nreq, wr = wr->next) {
+		if (unlikely(wr->num_sge >= srq->max_gs)) {
+			ret = -EINVAL;
+			*bad_wr = wr;
+			break;
+		}
+
+		if (unlikely(srq->head == srq->tail)) {
+			ret = -ENOMEM;
+			*bad_wr = wr;
+			break;
+		}
+
+		wqe_idx = find_empty_entry(&srq->idx_que, srq->wqe_cnt);
+		if (wqe_idx < 0) {
+			ret = -ENOMEM;
+			*bad_wr = wr;
+			break;
+		}
+
+		fill_idx_queue(&srq->idx_que, ind, wqe_idx);
+		wqe = get_srq_wqe(srq, wqe_idx);
+		dseg = (struct hns_roce_v2_wqe_data_seg *)wqe;
+
+		for (i = 0; i < wr->num_sge; ++i) {
+			dseg[i].len = cpu_to_le32(wr->sg_list[i].length);
+			dseg[i].lkey = cpu_to_le32(wr->sg_list[i].lkey);
+			dseg[i].addr = cpu_to_le64(wr->sg_list[i].addr);
+		}
+
+		if (i < srq->max_gs) {
+			dseg[i].len = 0;
+			dseg[i].lkey = cpu_to_le32(0x100);
+			dseg[i].addr = 0;
+		}
+
+		srq->wrid[wqe_idx] = wr->wr_id;
+		ind = (ind + 1) & (srq->wqe_cnt - 1);
+	}
+
+	if (likely(nreq)) {
+		srq->head += nreq;
+
+		/*
+		 * Make sure that descriptors are written before
+		 * doorbell record.
+		 */
+		wmb();
+
+		srq_db.byte_4 =
+			cpu_to_le32(HNS_ROCE_V2_SRQ_DB << V2_DB_BYTE_4_CMD_S |
+				    (srq->srqn & V2_DB_BYTE_4_TAG_M));
+		srq_db.parameter = cpu_to_le32(srq->head);
+
+		hns_roce_write64(hr_dev, (__le32 *)&srq_db, srq->db_reg_l);
+	}
+
+	spin_unlock_irqrestore(&srq->lock, flags);
+
+	return ret;
+}
+
 static int hns_roce_v2_cmd_hw_reseted(struct hns_roce_dev *hr_dev,
 				      unsigned long instance_stage,
 				      unsigned long reset_stage)
@@ -2667,22 +2790,6 @@ static struct hns_roce_v2_cqe *next_cqe_sw_v2(struct hns_roce_cq *hr_cq)
 	return get_sw_cqe_v2(hr_cq, hr_cq->cons_index);
 }
 
-static void *get_srq_wqe(struct hns_roce_srq *srq, int n)
-{
-	return hns_roce_buf_offset(srq->buf_mtr.kmem, n << srq->wqe_shift);
-}
-
-static void hns_roce_free_srq_wqe(struct hns_roce_srq *srq, int wqe_index)
-{
-	/* always called with interrupts disabled. */
-	spin_lock(&srq->lock);
-
-	bitmap_clear(srq->idx_que.bitmap, wqe_index, 1);
-	srq->tail++;
-
-	spin_unlock(&srq->lock);
-}
-
 static void hns_roce_v2_cq_set_ci(struct hns_roce_cq *hr_cq, u32 cons_index)
 {
 	*hr_cq->set_ci_db = cons_index & V2_CQ_DB_PARAMETER_CONS_IDX_M;
@@ -4777,108 +4884,288 @@ static int hns_roce_v2_qp_flow_control_init(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
-static int hns_roce_v2_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period)
+static void hns_roce_v2_write_srqc(struct hns_roce_dev *hr_dev,
+				   struct hns_roce_srq *srq, u32 pdn, u16 xrcd,
+				   u32 cqn, void *mb_buf, u64 *mtts_wqe,
+				   u64 *mtts_idx, dma_addr_t dma_handle_wqe,
+				   dma_addr_t dma_handle_idx)
 {
-	struct hns_roce_dev *hr_dev = to_hr_dev(cq->device);
-	struct hns_roce_v2_cq_context *cq_context;
-	struct hns_roce_cq *hr_cq = to_hr_cq(cq);
-	struct hns_roce_v2_cq_context *cqc_mask;
-	struct hns_roce_cmd_mailbox *mailbox;
-	int ret;
-
-	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
-	if (IS_ERR(mailbox))
-		return PTR_ERR(mailbox);
+	struct hns_roce_srq_context *srq_context;
 
-	cq_context = mailbox->buf;
-	cqc_mask = (struct hns_roce_v2_cq_context *)mailbox->buf + 1;
+	srq_context = mb_buf;
+	memset(srq_context, 0, sizeof(*srq_context));
 
-	memset(cqc_mask, 0xff, sizeof(*cqc_mask));
+	roce_set_field(srq_context->byte_4_srqn_srqst, SRQC_BYTE_4_SRQ_ST_M,
+		       SRQC_BYTE_4_SRQ_ST_S, 1);
 
-	roce_set_field(cq_context->byte_56_cqe_period_maxcnt,
-		       V2_CQC_BYTE_56_CQ_MAX_CNT_M, V2_CQC_BYTE_56_CQ_MAX_CNT_S,
-		       cq_count);
-	roce_set_field(cqc_mask->byte_56_cqe_period_maxcnt,
-		       V2_CQC_BYTE_56_CQ_MAX_CNT_M, V2_CQC_BYTE_56_CQ_MAX_CNT_S,
-		       0);
-	roce_set_field(cq_context->byte_56_cqe_period_maxcnt,
-		       V2_CQC_BYTE_56_CQ_PERIOD_M, V2_CQC_BYTE_56_CQ_PERIOD_S,
-		       cq_period);
-	roce_set_field(cqc_mask->byte_56_cqe_period_maxcnt,
-		       V2_CQC_BYTE_56_CQ_PERIOD_M, V2_CQC_BYTE_56_CQ_PERIOD_S,
-		       0);
+	roce_set_field(srq_context->byte_4_srqn_srqst,
+		       SRQC_BYTE_4_SRQ_WQE_HOP_NUM_M,
+		       SRQC_BYTE_4_SRQ_WQE_HOP_NUM_S,
+		       (hr_dev->caps.srqwqe_hop_num == HNS_ROCE_HOP_NUM_0 ? 0 :
+		       hr_dev->caps.srqwqe_hop_num));
+	roce_set_field(srq_context->byte_4_srqn_srqst,
+		       SRQC_BYTE_4_SRQ_SHIFT_M, SRQC_BYTE_4_SRQ_SHIFT_S,
+		       ilog2(srq->wqe_cnt));
 
-	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, hr_cq->cqn, 1,
-				HNS_ROCE_CMD_MODIFY_CQC,
-				HNS_ROCE_CMD_TIMEOUT_MSECS);
-	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
-	if (ret)
-		ibdev_err(&hr_dev->ib_dev,
-			  "failed to process cmd when modifying CQ, ret = %d\n",
-			  ret);
+	roce_set_field(srq_context->byte_4_srqn_srqst, SRQC_BYTE_4_SRQN_M,
+		       SRQC_BYTE_4_SRQN_S, srq->srqn);
 
-	return ret;
-}
+	roce_set_field(srq_context->byte_8_limit_wl, SRQC_BYTE_8_SRQ_LIMIT_WL_M,
+		       SRQC_BYTE_8_SRQ_LIMIT_WL_S, 0);
 
-static void hns_roce_irq_work_handle(struct work_struct *work)
-{
-	struct hns_roce_work *irq_work =
-				container_of(work, struct hns_roce_work, work);
-	struct ib_device *ibdev = &irq_work->hr_dev->ib_dev;
-	u32 qpn = irq_work->qpn;
-	u32 cqn = irq_work->cqn;
+	roce_set_field(srq_context->byte_12_xrcd, SRQC_BYTE_12_SRQ_XRCD_M,
+		       SRQC_BYTE_12_SRQ_XRCD_S, xrcd);
 
-	switch (irq_work->event_type) {
-	case HNS_ROCE_EVENT_TYPE_PATH_MIG:
-		ibdev_info(ibdev, "Path migrated succeeded.\n");
-		break;
-	case HNS_ROCE_EVENT_TYPE_PATH_MIG_FAILED:
-		ibdev_warn(ibdev, "Path migration failed.\n");
-		break;
-	case HNS_ROCE_EVENT_TYPE_COMM_EST:
-		break;
-	case HNS_ROCE_EVENT_TYPE_SQ_DRAINED:
-		ibdev_warn(ibdev, "Send queue drained.\n");
-		break;
-	case HNS_ROCE_EVENT_TYPE_WQ_CATAS_ERROR:
-		ibdev_err(ibdev, "Local work queue 0x%x catast error, sub_event type is: %d\n",
-			  qpn, irq_work->sub_type);
-		break;
-	case HNS_ROCE_EVENT_TYPE_INV_REQ_LOCAL_WQ_ERROR:
-		ibdev_err(ibdev, "Invalid request local work queue 0x%x error.\n",
-			  qpn);
-		break;
-	case HNS_ROCE_EVENT_TYPE_LOCAL_WQ_ACCESS_ERROR:
-		ibdev_err(ibdev, "Local access violation work queue 0x%x error, sub_event type is: %d\n",
-			  qpn, irq_work->sub_type);
-		break;
-	case HNS_ROCE_EVENT_TYPE_SRQ_LIMIT_REACH:
-		ibdev_warn(ibdev, "SRQ limit reach.\n");
-		break;
-	case HNS_ROCE_EVENT_TYPE_SRQ_LAST_WQE_REACH:
-		ibdev_warn(ibdev, "SRQ last wqe reach.\n");
-		break;
-	case HNS_ROCE_EVENT_TYPE_SRQ_CATAS_ERROR:
-		ibdev_err(ibdev, "SRQ catas error.\n");
-		break;
-	case HNS_ROCE_EVENT_TYPE_CQ_ACCESS_ERROR:
-		ibdev_err(ibdev, "CQ 0x%x access err.\n", cqn);
-		break;
-	case HNS_ROCE_EVENT_TYPE_CQ_OVERFLOW:
-		ibdev_warn(ibdev, "CQ 0x%x overflow\n", cqn);
-		break;
-	case HNS_ROCE_EVENT_TYPE_DB_OVERFLOW:
-		ibdev_warn(ibdev, "DB overflow.\n");
-		break;
-	case HNS_ROCE_EVENT_TYPE_FLR:
-		ibdev_warn(ibdev, "Function level reset.\n");
-		break;
-	default:
-		break;
-	}
+	srq_context->wqe_bt_ba = cpu_to_le32((u32)(dma_handle_wqe >> 3));
 
-	kfree(irq_work);
-}
+	roce_set_field(srq_context->byte_24_wqe_bt_ba,
+		       SRQC_BYTE_24_SRQ_WQE_BT_BA_M,
+		       SRQC_BYTE_24_SRQ_WQE_BT_BA_S,
+		       dma_handle_wqe >> 35);
+
+	roce_set_field(srq_context->byte_28_rqws_pd, SRQC_BYTE_28_PD_M,
+		       SRQC_BYTE_28_PD_S, pdn);
+	roce_set_field(srq_context->byte_28_rqws_pd, SRQC_BYTE_28_RQWS_M,
+		       SRQC_BYTE_28_RQWS_S, srq->max_gs <= 0 ? 0 :
+		       fls(srq->max_gs - 1));
+
+	srq_context->idx_bt_ba = cpu_to_le32(dma_handle_idx >> 3);
+	roce_set_field(srq_context->rsv_idx_bt_ba,
+		       SRQC_BYTE_36_SRQ_IDX_BT_BA_M,
+		       SRQC_BYTE_36_SRQ_IDX_BT_BA_S,
+		       dma_handle_idx >> 35);
+
+	srq_context->idx_cur_blk_addr =
+		cpu_to_le32(to_hr_hw_page_addr(mtts_idx[0]));
+	roce_set_field(srq_context->byte_44_idxbufpgsz_addr,
+		       SRQC_BYTE_44_SRQ_IDX_CUR_BLK_ADDR_M,
+		       SRQC_BYTE_44_SRQ_IDX_CUR_BLK_ADDR_S,
+		       upper_32_bits(to_hr_hw_page_addr(mtts_idx[0])));
+	roce_set_field(srq_context->byte_44_idxbufpgsz_addr,
+		       SRQC_BYTE_44_SRQ_IDX_HOP_NUM_M,
+		       SRQC_BYTE_44_SRQ_IDX_HOP_NUM_S,
+		       hr_dev->caps.idx_hop_num == HNS_ROCE_HOP_NUM_0 ? 0 :
+		       hr_dev->caps.idx_hop_num);
+
+	roce_set_field(srq_context->byte_44_idxbufpgsz_addr,
+		       SRQC_BYTE_44_SRQ_IDX_BA_PG_SZ_M,
+		       SRQC_BYTE_44_SRQ_IDX_BA_PG_SZ_S,
+		to_hr_hw_page_shift(srq->idx_que.mtr.hem_cfg.ba_pg_shift));
+	roce_set_field(srq_context->byte_44_idxbufpgsz_addr,
+		       SRQC_BYTE_44_SRQ_IDX_BUF_PG_SZ_M,
+		       SRQC_BYTE_44_SRQ_IDX_BUF_PG_SZ_S,
+		to_hr_hw_page_shift(srq->idx_que.mtr.hem_cfg.buf_pg_shift));
+
+	srq_context->idx_nxt_blk_addr =
+				cpu_to_le32(to_hr_hw_page_addr(mtts_idx[1]));
+	roce_set_field(srq_context->rsv_idxnxtblkaddr,
+		       SRQC_BYTE_52_SRQ_IDX_NXT_BLK_ADDR_M,
+		       SRQC_BYTE_52_SRQ_IDX_NXT_BLK_ADDR_S,
+		       upper_32_bits(to_hr_hw_page_addr(mtts_idx[1])));
+	roce_set_field(srq_context->byte_56_xrc_cqn,
+		       SRQC_BYTE_56_SRQ_XRC_CQN_M, SRQC_BYTE_56_SRQ_XRC_CQN_S,
+		       cqn);
+	roce_set_field(srq_context->byte_56_xrc_cqn,
+		       SRQC_BYTE_56_SRQ_WQE_BA_PG_SZ_M,
+		       SRQC_BYTE_56_SRQ_WQE_BA_PG_SZ_S,
+		       to_hr_hw_page_shift(srq->buf_mtr.hem_cfg.ba_pg_shift));
+	roce_set_field(srq_context->byte_56_xrc_cqn,
+		       SRQC_BYTE_56_SRQ_WQE_BUF_PG_SZ_M,
+		       SRQC_BYTE_56_SRQ_WQE_BUF_PG_SZ_S,
+		       to_hr_hw_page_shift(srq->buf_mtr.hem_cfg.buf_pg_shift));
+
+	roce_set_bit(srq_context->db_record_addr_record_en,
+		     SRQC_BYTE_60_SRQ_RECORD_EN_S, 0);
+}
+
+static int hns_roce_v2_modify_srq(struct ib_srq *ibsrq,
+				  struct ib_srq_attr *srq_attr,
+				  enum ib_srq_attr_mask srq_attr_mask,
+				  struct ib_udata *udata)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibsrq->device);
+	struct hns_roce_srq *srq = to_hr_srq(ibsrq);
+	struct hns_roce_srq_context *srq_context;
+	struct hns_roce_srq_context *srqc_mask;
+	struct hns_roce_cmd_mailbox *mailbox;
+	int ret;
+
+	if (srq_attr_mask & IB_SRQ_LIMIT) {
+		if (srq_attr->srq_limit >= srq->wqe_cnt)
+			return -EINVAL;
+
+		mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
+		if (IS_ERR(mailbox))
+			return PTR_ERR(mailbox);
+
+		srq_context = mailbox->buf;
+		srqc_mask = (struct hns_roce_srq_context *)mailbox->buf + 1;
+
+		memset(srqc_mask, 0xff, sizeof(*srqc_mask));
+
+		roce_set_field(srq_context->byte_8_limit_wl,
+			       SRQC_BYTE_8_SRQ_LIMIT_WL_M,
+			       SRQC_BYTE_8_SRQ_LIMIT_WL_S, srq_attr->srq_limit);
+		roce_set_field(srqc_mask->byte_8_limit_wl,
+			       SRQC_BYTE_8_SRQ_LIMIT_WL_M,
+			       SRQC_BYTE_8_SRQ_LIMIT_WL_S, 0);
+
+		ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, srq->srqn, 0,
+					HNS_ROCE_CMD_MODIFY_SRQC,
+					HNS_ROCE_CMD_TIMEOUT_MSECS);
+		hns_roce_free_cmd_mailbox(hr_dev, mailbox);
+		if (ret) {
+			ibdev_err(&hr_dev->ib_dev,
+				  "failed to handle cmd of modifying SRQ, ret = %d.\n",
+				  ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int hns_roce_v2_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibsrq->device);
+	struct hns_roce_srq *srq = to_hr_srq(ibsrq);
+	struct hns_roce_srq_context *srq_context;
+	struct hns_roce_cmd_mailbox *mailbox;
+	int limit_wl;
+	int ret;
+
+	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
+	if (IS_ERR(mailbox))
+		return PTR_ERR(mailbox);
+
+	srq_context = mailbox->buf;
+	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, srq->srqn, 0,
+				HNS_ROCE_CMD_QUERY_SRQC,
+				HNS_ROCE_CMD_TIMEOUT_MSECS);
+	if (ret) {
+		ibdev_err(&hr_dev->ib_dev,
+			  "failed to process cmd of querying SRQ, ret = %d.\n",
+			  ret);
+		goto out;
+	}
+
+	limit_wl = roce_get_field(srq_context->byte_8_limit_wl,
+				  SRQC_BYTE_8_SRQ_LIMIT_WL_M,
+				  SRQC_BYTE_8_SRQ_LIMIT_WL_S);
+
+	attr->srq_limit = limit_wl;
+	attr->max_wr    = srq->wqe_cnt;
+	attr->max_sge   = srq->max_gs;
+
+	memcpy(srq_context, mailbox->buf, sizeof(*srq_context));
+
+out:
+	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
+	return ret;
+}
+
+static int hns_roce_v2_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(cq->device);
+	struct hns_roce_v2_cq_context *cq_context;
+	struct hns_roce_cq *hr_cq = to_hr_cq(cq);
+	struct hns_roce_v2_cq_context *cqc_mask;
+	struct hns_roce_cmd_mailbox *mailbox;
+	int ret;
+
+	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
+	if (IS_ERR(mailbox))
+		return PTR_ERR(mailbox);
+
+	cq_context = mailbox->buf;
+	cqc_mask = (struct hns_roce_v2_cq_context *)mailbox->buf + 1;
+
+	memset(cqc_mask, 0xff, sizeof(*cqc_mask));
+
+	roce_set_field(cq_context->byte_56_cqe_period_maxcnt,
+		       V2_CQC_BYTE_56_CQ_MAX_CNT_M, V2_CQC_BYTE_56_CQ_MAX_CNT_S,
+		       cq_count);
+	roce_set_field(cqc_mask->byte_56_cqe_period_maxcnt,
+		       V2_CQC_BYTE_56_CQ_MAX_CNT_M, V2_CQC_BYTE_56_CQ_MAX_CNT_S,
+		       0);
+	roce_set_field(cq_context->byte_56_cqe_period_maxcnt,
+		       V2_CQC_BYTE_56_CQ_PERIOD_M, V2_CQC_BYTE_56_CQ_PERIOD_S,
+		       cq_period);
+	roce_set_field(cqc_mask->byte_56_cqe_period_maxcnt,
+		       V2_CQC_BYTE_56_CQ_PERIOD_M, V2_CQC_BYTE_56_CQ_PERIOD_S,
+		       0);
+
+	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, hr_cq->cqn, 1,
+				HNS_ROCE_CMD_MODIFY_CQC,
+				HNS_ROCE_CMD_TIMEOUT_MSECS);
+	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
+	if (ret)
+		ibdev_err(&hr_dev->ib_dev,
+			  "failed to process cmd when modifying CQ, ret = %d\n",
+			  ret);
+
+	return ret;
+}
+
+static void hns_roce_irq_work_handle(struct work_struct *work)
+{
+	struct hns_roce_work *irq_work =
+				container_of(work, struct hns_roce_work, work);
+	struct ib_device *ibdev = &irq_work->hr_dev->ib_dev;
+	u32 qpn = irq_work->qpn;
+	u32 cqn = irq_work->cqn;
+
+	switch (irq_work->event_type) {
+	case HNS_ROCE_EVENT_TYPE_PATH_MIG:
+		ibdev_info(ibdev, "Path migrated succeeded.\n");
+		break;
+	case HNS_ROCE_EVENT_TYPE_PATH_MIG_FAILED:
+		ibdev_warn(ibdev, "Path migration failed.\n");
+		break;
+	case HNS_ROCE_EVENT_TYPE_COMM_EST:
+		break;
+	case HNS_ROCE_EVENT_TYPE_SQ_DRAINED:
+		ibdev_warn(ibdev, "Send queue drained.\n");
+		break;
+	case HNS_ROCE_EVENT_TYPE_WQ_CATAS_ERROR:
+		ibdev_err(ibdev, "Local work queue 0x%x catast error, sub_event type is: %d\n",
+			  qpn, irq_work->sub_type);
+		break;
+	case HNS_ROCE_EVENT_TYPE_INV_REQ_LOCAL_WQ_ERROR:
+		ibdev_err(ibdev, "Invalid request local work queue 0x%x error.\n",
+			  qpn);
+		break;
+	case HNS_ROCE_EVENT_TYPE_LOCAL_WQ_ACCESS_ERROR:
+		ibdev_err(ibdev, "Local access violation work queue 0x%x error, sub_event type is: %d\n",
+			  qpn, irq_work->sub_type);
+		break;
+	case HNS_ROCE_EVENT_TYPE_SRQ_LIMIT_REACH:
+		ibdev_warn(ibdev, "SRQ limit reach.\n");
+		break;
+	case HNS_ROCE_EVENT_TYPE_SRQ_LAST_WQE_REACH:
+		ibdev_warn(ibdev, "SRQ last wqe reach.\n");
+		break;
+	case HNS_ROCE_EVENT_TYPE_SRQ_CATAS_ERROR:
+		ibdev_err(ibdev, "SRQ catas error.\n");
+		break;
+	case HNS_ROCE_EVENT_TYPE_CQ_ACCESS_ERROR:
+		ibdev_err(ibdev, "CQ 0x%x access err.\n", cqn);
+		break;
+	case HNS_ROCE_EVENT_TYPE_CQ_OVERFLOW:
+		ibdev_warn(ibdev, "CQ 0x%x overflow\n", cqn);
+		break;
+	case HNS_ROCE_EVENT_TYPE_DB_OVERFLOW:
+		ibdev_warn(ibdev, "DB overflow.\n");
+		break;
+	case HNS_ROCE_EVENT_TYPE_FLR:
+		ibdev_warn(ibdev, "Function level reset.\n");
+		break;
+	default:
+		break;
+	}
+
+	kfree(irq_work);
+}
 
 static void hns_roce_v2_init_irq_work(struct hns_roce_dev *hr_dev,
 				      struct hns_roce_eq *eq,
@@ -5588,296 +5875,6 @@ static void hns_roce_v2_cleanup_eq_table(struct hns_roce_dev *hr_dev)
 	destroy_workqueue(hr_dev->irq_workq);
 }
 
-static void hns_roce_v2_write_srqc(struct hns_roce_dev *hr_dev,
-				   struct hns_roce_srq *srq, u32 pdn, u16 xrcd,
-				   u32 cqn, void *mb_buf, u64 *mtts_wqe,
-				   u64 *mtts_idx, dma_addr_t dma_handle_wqe,
-				   dma_addr_t dma_handle_idx)
-{
-	struct hns_roce_srq_context *srq_context;
-
-	srq_context = mb_buf;
-	memset(srq_context, 0, sizeof(*srq_context));
-
-	roce_set_field(srq_context->byte_4_srqn_srqst, SRQC_BYTE_4_SRQ_ST_M,
-		       SRQC_BYTE_4_SRQ_ST_S, 1);
-
-	roce_set_field(srq_context->byte_4_srqn_srqst,
-		       SRQC_BYTE_4_SRQ_WQE_HOP_NUM_M,
-		       SRQC_BYTE_4_SRQ_WQE_HOP_NUM_S,
-		       (hr_dev->caps.srqwqe_hop_num == HNS_ROCE_HOP_NUM_0 ? 0 :
-		       hr_dev->caps.srqwqe_hop_num));
-	roce_set_field(srq_context->byte_4_srqn_srqst,
-		       SRQC_BYTE_4_SRQ_SHIFT_M, SRQC_BYTE_4_SRQ_SHIFT_S,
-		       ilog2(srq->wqe_cnt));
-
-	roce_set_field(srq_context->byte_4_srqn_srqst, SRQC_BYTE_4_SRQN_M,
-		       SRQC_BYTE_4_SRQN_S, srq->srqn);
-
-	roce_set_field(srq_context->byte_8_limit_wl, SRQC_BYTE_8_SRQ_LIMIT_WL_M,
-		       SRQC_BYTE_8_SRQ_LIMIT_WL_S, 0);
-
-	roce_set_field(srq_context->byte_12_xrcd, SRQC_BYTE_12_SRQ_XRCD_M,
-		       SRQC_BYTE_12_SRQ_XRCD_S, xrcd);
-
-	srq_context->wqe_bt_ba = cpu_to_le32((u32)(dma_handle_wqe >> 3));
-
-	roce_set_field(srq_context->byte_24_wqe_bt_ba,
-		       SRQC_BYTE_24_SRQ_WQE_BT_BA_M,
-		       SRQC_BYTE_24_SRQ_WQE_BT_BA_S,
-		       dma_handle_wqe >> 35);
-
-	roce_set_field(srq_context->byte_28_rqws_pd, SRQC_BYTE_28_PD_M,
-		       SRQC_BYTE_28_PD_S, pdn);
-	roce_set_field(srq_context->byte_28_rqws_pd, SRQC_BYTE_28_RQWS_M,
-		       SRQC_BYTE_28_RQWS_S, srq->max_gs <= 0 ? 0 :
-		       fls(srq->max_gs - 1));
-
-	srq_context->idx_bt_ba = cpu_to_le32(dma_handle_idx >> 3);
-	roce_set_field(srq_context->rsv_idx_bt_ba,
-		       SRQC_BYTE_36_SRQ_IDX_BT_BA_M,
-		       SRQC_BYTE_36_SRQ_IDX_BT_BA_S,
-		       dma_handle_idx >> 35);
-
-	srq_context->idx_cur_blk_addr =
-		cpu_to_le32(to_hr_hw_page_addr(mtts_idx[0]));
-	roce_set_field(srq_context->byte_44_idxbufpgsz_addr,
-		       SRQC_BYTE_44_SRQ_IDX_CUR_BLK_ADDR_M,
-		       SRQC_BYTE_44_SRQ_IDX_CUR_BLK_ADDR_S,
-		       upper_32_bits(to_hr_hw_page_addr(mtts_idx[0])));
-	roce_set_field(srq_context->byte_44_idxbufpgsz_addr,
-		       SRQC_BYTE_44_SRQ_IDX_HOP_NUM_M,
-		       SRQC_BYTE_44_SRQ_IDX_HOP_NUM_S,
-		       hr_dev->caps.idx_hop_num == HNS_ROCE_HOP_NUM_0 ? 0 :
-		       hr_dev->caps.idx_hop_num);
-
-	roce_set_field(
-		srq_context->byte_44_idxbufpgsz_addr,
-		SRQC_BYTE_44_SRQ_IDX_BA_PG_SZ_M,
-		SRQC_BYTE_44_SRQ_IDX_BA_PG_SZ_S,
-		to_hr_hw_page_shift(srq->idx_que.mtr.hem_cfg.ba_pg_shift));
-	roce_set_field(
-		srq_context->byte_44_idxbufpgsz_addr,
-		SRQC_BYTE_44_SRQ_IDX_BUF_PG_SZ_M,
-		SRQC_BYTE_44_SRQ_IDX_BUF_PG_SZ_S,
-		to_hr_hw_page_shift(srq->idx_que.mtr.hem_cfg.buf_pg_shift));
-
-	srq_context->idx_nxt_blk_addr =
-		cpu_to_le32(to_hr_hw_page_addr(mtts_idx[1]));
-	roce_set_field(srq_context->rsv_idxnxtblkaddr,
-		       SRQC_BYTE_52_SRQ_IDX_NXT_BLK_ADDR_M,
-		       SRQC_BYTE_52_SRQ_IDX_NXT_BLK_ADDR_S,
-		       upper_32_bits(to_hr_hw_page_addr(mtts_idx[1])));
-	roce_set_field(srq_context->byte_56_xrc_cqn,
-		       SRQC_BYTE_56_SRQ_XRC_CQN_M, SRQC_BYTE_56_SRQ_XRC_CQN_S,
-		       cqn);
-	roce_set_field(srq_context->byte_56_xrc_cqn,
-		       SRQC_BYTE_56_SRQ_WQE_BA_PG_SZ_M,
-		       SRQC_BYTE_56_SRQ_WQE_BA_PG_SZ_S,
-		       to_hr_hw_page_shift(srq->buf_mtr.hem_cfg.ba_pg_shift));
-	roce_set_field(srq_context->byte_56_xrc_cqn,
-		       SRQC_BYTE_56_SRQ_WQE_BUF_PG_SZ_M,
-		       SRQC_BYTE_56_SRQ_WQE_BUF_PG_SZ_S,
-		       to_hr_hw_page_shift(srq->buf_mtr.hem_cfg.buf_pg_shift));
-
-	roce_set_bit(srq_context->db_record_addr_record_en,
-		     SRQC_BYTE_60_SRQ_RECORD_EN_S, 0);
-}
-
-static int hns_roce_v2_modify_srq(struct ib_srq *ibsrq,
-				  struct ib_srq_attr *srq_attr,
-				  enum ib_srq_attr_mask srq_attr_mask,
-				  struct ib_udata *udata)
-{
-	struct hns_roce_dev *hr_dev = to_hr_dev(ibsrq->device);
-	struct hns_roce_srq *srq = to_hr_srq(ibsrq);
-	struct hns_roce_srq_context *srq_context;
-	struct hns_roce_srq_context *srqc_mask;
-	struct hns_roce_cmd_mailbox *mailbox;
-	int ret;
-
-	if (srq_attr_mask & IB_SRQ_LIMIT) {
-		if (srq_attr->srq_limit >= srq->wqe_cnt)
-			return -EINVAL;
-
-		mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
-		if (IS_ERR(mailbox))
-			return PTR_ERR(mailbox);
-
-		srq_context = mailbox->buf;
-		srqc_mask = (struct hns_roce_srq_context *)mailbox->buf + 1;
-
-		memset(srqc_mask, 0xff, sizeof(*srqc_mask));
-
-		roce_set_field(srq_context->byte_8_limit_wl,
-			       SRQC_BYTE_8_SRQ_LIMIT_WL_M,
-			       SRQC_BYTE_8_SRQ_LIMIT_WL_S, srq_attr->srq_limit);
-		roce_set_field(srqc_mask->byte_8_limit_wl,
-			       SRQC_BYTE_8_SRQ_LIMIT_WL_M,
-			       SRQC_BYTE_8_SRQ_LIMIT_WL_S, 0);
-
-		ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, srq->srqn, 0,
-					HNS_ROCE_CMD_MODIFY_SRQC,
-					HNS_ROCE_CMD_TIMEOUT_MSECS);
-		hns_roce_free_cmd_mailbox(hr_dev, mailbox);
-		if (ret) {
-			ibdev_err(&hr_dev->ib_dev,
-				  "failed to process cmd when modifying SRQ, ret = %d\n",
-				  ret);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
-static int hns_roce_v2_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
-{
-	struct hns_roce_dev *hr_dev = to_hr_dev(ibsrq->device);
-	struct hns_roce_srq *srq = to_hr_srq(ibsrq);
-	struct hns_roce_srq_context *srq_context;
-	struct hns_roce_cmd_mailbox *mailbox;
-	int limit_wl;
-	int ret;
-
-	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
-	if (IS_ERR(mailbox))
-		return PTR_ERR(mailbox);
-
-	srq_context = mailbox->buf;
-	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, srq->srqn, 0,
-				HNS_ROCE_CMD_QUERY_SRQC,
-				HNS_ROCE_CMD_TIMEOUT_MSECS);
-	if (ret) {
-		ibdev_err(&hr_dev->ib_dev,
-			  "failed to process cmd when querying SRQ, ret = %d\n",
-			  ret);
-		goto out;
-	}
-
-	limit_wl = roce_get_field(srq_context->byte_8_limit_wl,
-				  SRQC_BYTE_8_SRQ_LIMIT_WL_M,
-				  SRQC_BYTE_8_SRQ_LIMIT_WL_S);
-
-	attr->srq_limit = limit_wl;
-	attr->max_wr    = srq->wqe_cnt - 1;
-	attr->max_sge   = srq->max_gs;
-
-	memcpy(srq_context, mailbox->buf, sizeof(*srq_context));
-
-out:
-	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
-	return ret;
-}
-
-static int find_empty_entry(struct hns_roce_idx_que *idx_que,
-			    unsigned long size)
-{
-	int wqe_idx;
-
-	if (unlikely(bitmap_full(idx_que->bitmap, size)))
-		return -ENOSPC;
-
-	wqe_idx = find_first_zero_bit(idx_que->bitmap, size);
-
-	bitmap_set(idx_que->bitmap, wqe_idx, 1);
-
-	return wqe_idx;
-}
-
-static void fill_idx_queue(struct hns_roce_idx_que *idx_que,
-			   int cur_idx, int wqe_idx)
-{
-	unsigned int *addr;
-
-	addr = (unsigned int *)hns_roce_buf_offset(idx_que->mtr.kmem,
-						   cur_idx * idx_que->entry_sz);
-	*addr = wqe_idx;
-}
-
-static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
-				     const struct ib_recv_wr *wr,
-				     const struct ib_recv_wr **bad_wr)
-{
-	struct hns_roce_dev *hr_dev = to_hr_dev(ibsrq->device);
-	struct hns_roce_srq *srq = to_hr_srq(ibsrq);
-	struct hns_roce_v2_wqe_data_seg *dseg;
-	struct hns_roce_v2_db srq_db;
-	unsigned long flags;
-	int ret = 0;
-	int wqe_idx;
-	void *wqe;
-	int nreq;
-	int ind;
-	int i;
-
-	spin_lock_irqsave(&srq->lock, flags);
-
-	ind = srq->head & (srq->wqe_cnt - 1);
-
-	for (nreq = 0; wr; ++nreq, wr = wr->next) {
-		if (unlikely(wr->num_sge > srq->max_gs)) {
-			ret = -EINVAL;
-			*bad_wr = wr;
-			break;
-		}
-
-		if (unlikely(srq->head == srq->tail)) {
-			ret = -ENOMEM;
-			*bad_wr = wr;
-			break;
-		}
-
-		wqe_idx = find_empty_entry(&srq->idx_que, srq->wqe_cnt);
-		if (wqe_idx < 0) {
-			ret = -ENOMEM;
-			*bad_wr = wr;
-			break;
-		}
-
-		fill_idx_queue(&srq->idx_que, ind, wqe_idx);
-		wqe = get_srq_wqe(srq, wqe_idx);
-		dseg = (struct hns_roce_v2_wqe_data_seg *)wqe;
-
-		for (i = 0; i < wr->num_sge; ++i) {
-			dseg[i].len = cpu_to_le32(wr->sg_list[i].length);
-			dseg[i].lkey = cpu_to_le32(wr->sg_list[i].lkey);
-			dseg[i].addr = cpu_to_le64(wr->sg_list[i].addr);
-		}
-
-		if (i < srq->max_gs) {
-			dseg[i].len = 0;
-			dseg[i].lkey = cpu_to_le32(0x100);
-			dseg[i].addr = 0;
-		}
-
-		srq->wrid[wqe_idx] = wr->wr_id;
-		ind = (ind + 1) & (srq->wqe_cnt - 1);
-	}
-
-	if (likely(nreq)) {
-		srq->head += nreq;
-
-		/*
-		 * Make sure that descriptors are written before
-		 * doorbell record.
-		 */
-		wmb();
-
-		srq_db.byte_4 =
-			cpu_to_le32(HNS_ROCE_V2_SRQ_DB << V2_DB_BYTE_4_CMD_S |
-				    (srq->srqn & V2_DB_BYTE_4_TAG_M));
-		srq_db.parameter = cpu_to_le32(srq->head);
-
-		hns_roce_write64(hr_dev, (__le32 *)&srq_db, srq->db_reg_l);
-
-	}
-
-	spin_unlock_irqrestore(&srq->lock, flags);
-
-	return ret;
-}
-
 static const struct hns_roce_dfx_hw hns_roce_dfx_hw_v2 = {
 	.query_cqc_info = hns_roce_v2_query_cqc_info,
 };
-- 
2.8.1

