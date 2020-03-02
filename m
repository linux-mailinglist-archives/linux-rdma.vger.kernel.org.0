Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED7CE175A2E
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 13:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgCBMP0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 07:15:26 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:48824 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727708AbgCBMP0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Mar 2020 07:15:26 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 98BA1C52815283607290;
        Mon,  2 Mar 2020 20:15:16 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Mon, 2 Mar 2020 20:15:08 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 1/5] RDMA/hns: Rename wqe buffer related functions
Date:   Mon, 2 Mar 2020 20:11:29 +0800
Message-ID: <1583151093-30402-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1583151093-30402-1-git-send-email-liweihang@huawei.com>
References: <1583151093-30402-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

There are serval global functions related to wqe buffer in the hns driver
and are called in different files. These symbols cannot directly represent
the namespace they belong to. So add prefix 'hns_roce_' to 3 wqe buffer
related global functions: get_recv_wqe(), get_send_wqe(), and
get_send_extend_sge().

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  6 +++---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  9 +++++----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 10 +++++-----
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  6 +++---
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index d7dcf6e..b6ae12d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1238,9 +1238,9 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *ib_pd,
 int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		       int attr_mask, struct ib_udata *udata);
 void init_flush_work(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp);
-void *get_recv_wqe(struct hns_roce_qp *hr_qp, int n);
-void *get_send_wqe(struct hns_roce_qp *hr_qp, int n);
-void *get_send_extend_sge(struct hns_roce_qp *hr_qp, int n);
+void *hns_roce_get_recv_wqe(struct hns_roce_qp *hr_qp, int n);
+void *hns_roce_get_send_wqe(struct hns_roce_qp *hr_qp, int n);
+void *hns_roce_get_extend_sge(struct hns_roce_qp *hr_qp, int n);
 bool hns_roce_wq_overflow(struct hns_roce_wq *hr_wq, int nreq,
 			  struct ib_cq *ib_cq);
 enum hns_roce_qp_state to_hns_roce_state(enum ib_qp_state state);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index c05a905..2e53045 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -106,7 +106,7 @@ static int hns_roce_v1_post_send(struct ib_qp *ibqp,
 			goto out;
 		}
 
-		wqe = get_send_wqe(qp, wqe_idx);
+		wqe = hns_roce_get_send_wqe(qp, wqe_idx);
 		qp->sq.wrid[wqe_idx] = wr->wr_id;
 
 		/* Corresponding to the RC and RD type wqe process separately */
@@ -378,7 +378,7 @@ static int hns_roce_v1_post_recv(struct ib_qp *ibqp,
 			goto out;
 		}
 
-		ctrl = get_recv_wqe(hr_qp, wqe_idx);
+		ctrl = hns_roce_get_recv_wqe(hr_qp, wqe_idx);
 
 		roce_set_field(ctrl->rwqe_byte_12,
 			       RQ_WQE_CTRL_RWQE_BYTE_12_RWQE_SGE_NUM_M,
@@ -2284,9 +2284,10 @@ static int hns_roce_v1_poll_one(struct hns_roce_cq *hr_cq,
 
 	if (is_send) {
 		/* SQ conrespond to CQE */
-		sq_wqe = get_send_wqe(*cur_qp, roce_get_field(cqe->cqe_byte_4,
+		sq_wqe = hns_roce_get_send_wqe(*cur_qp,
+						roce_get_field(cqe->cqe_byte_4,
 						CQE_BYTE_4_WQE_INDEX_M,
-						CQE_BYTE_4_WQE_INDEX_S)&
+						CQE_BYTE_4_WQE_INDEX_S) &
 						((*cur_qp)->sq.wqe_cnt-1));
 		switch (le32_to_cpu(sq_wqe->flag) & HNS_ROCE_WQE_OPCODE_MASK) {
 		case HNS_ROCE_WQE_OPCODE_SEND:
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 82021fa..88d671a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -127,7 +127,7 @@ static void set_extend_sge(struct hns_roce_qp *qp, const struct ib_send_wr *wr,
 	 * should calculate how many sges in the first page and the second
 	 * page.
 	 */
-	dseg = get_send_extend_sge(qp, (*sge_ind) & (qp->sge.sge_cnt - 1));
+	dseg = hns_roce_get_extend_sge(qp, (*sge_ind) & (qp->sge.sge_cnt - 1));
 	fi_sge_num = (round_up((uintptr_t)dseg, 1 << shift) -
 		      (uintptr_t)dseg) /
 		      sizeof(struct hns_roce_v2_wqe_data_seg);
@@ -137,7 +137,7 @@ static void set_extend_sge(struct hns_roce_qp *qp, const struct ib_send_wr *wr,
 			set_data_seg_v2(dseg++, sg + i);
 			(*sge_ind)++;
 		}
-		dseg = get_send_extend_sge(qp,
+		dseg = hns_roce_get_extend_sge(qp,
 					   (*sge_ind) & (qp->sge.sge_cnt - 1));
 		for (i = 0; i < se_sge_num; i++) {
 			set_data_seg_v2(dseg++, sg + fi_sge_num + i);
@@ -329,7 +329,7 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 			goto out;
 		}
 
-		wqe = get_send_wqe(qp, wqe_idx);
+		wqe = hns_roce_get_send_wqe(qp, wqe_idx);
 		qp->sq.wrid[wqe_idx] = wr->wr_id;
 		owner_bit =
 		       ~(((qp->sq.head + nreq) >> ilog2(qp->sq.wqe_cnt)) & 0x1);
@@ -676,7 +676,7 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 			goto out;
 		}
 
-		wqe = get_recv_wqe(hr_qp, wqe_idx);
+		wqe = hns_roce_get_recv_wqe(hr_qp, wqe_idx);
 		dseg = (struct hns_roce_v2_wqe_data_seg *)wqe;
 		for (i = 0; i < wr->num_sge; i++) {
 			if (!wr->sg_list[i].length)
@@ -2935,7 +2935,7 @@ static int hns_roce_handle_recv_inl_wqe(struct hns_roce_v2_cqe *cqe,
 
 	sge_list = (*cur_qp)->rq_inl_buf.wqe_list[wr_cnt].sg_list;
 	sge_num = (*cur_qp)->rq_inl_buf.wqe_list[wr_cnt].sge_cnt;
-	wqe_buf = get_recv_wqe(*cur_qp, wr_cnt);
+	wqe_buf = hns_roce_get_recv_wqe(*cur_qp, wr_cnt);
 	data_len = wc->byte_len;
 
 	for (sge_cnt = 0; (sge_cnt < sge_num) && (data_len); sge_cnt++) {
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 10c4354..cdc8b19 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1469,17 +1469,17 @@ static void *get_wqe(struct hns_roce_qp *hr_qp, int offset)
 	return hns_roce_buf_offset(&hr_qp->hr_buf, offset);
 }
 
-void *get_recv_wqe(struct hns_roce_qp *hr_qp, int n)
+void *hns_roce_get_recv_wqe(struct hns_roce_qp *hr_qp, int n)
 {
 	return get_wqe(hr_qp, hr_qp->rq.offset + (n << hr_qp->rq.wqe_shift));
 }
 
-void *get_send_wqe(struct hns_roce_qp *hr_qp, int n)
+void *hns_roce_get_send_wqe(struct hns_roce_qp *hr_qp, int n)
 {
 	return get_wqe(hr_qp, hr_qp->sq.offset + (n << hr_qp->sq.wqe_shift));
 }
 
-void *get_send_extend_sge(struct hns_roce_qp *hr_qp, int n)
+void *hns_roce_get_extend_sge(struct hns_roce_qp *hr_qp, int n)
 {
 	return hns_roce_buf_offset(&hr_qp->hr_buf, hr_qp->sge.offset +
 					(n << hr_qp->sge.sge_shift));
-- 
2.8.1

