Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC101DB5B0
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 15:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgETNx6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 May 2020 09:53:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56380 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726436AbgETNx6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 May 2020 09:53:58 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F1CB9BD4D83B06BECC4E;
        Wed, 20 May 2020 21:53:41 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Wed, 20 May 2020 21:53:35 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 3/9] RDMA/hns: Optimize post and poll process
Date:   Wed, 20 May 2020 21:53:13 +0800
Message-ID: <1589982799-28728-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1589982799-28728-1-git-send-email-liweihang@huawei.com>
References: <1589982799-28728-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Add unlikely() and likely() to optimize main I/O process code.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 36a9871..1d5fdf6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -187,15 +187,15 @@ static int set_rwqe_data_seg(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 	int i;
 
 	if (wr->send_flags & IB_SEND_INLINE && valid_num_sge) {
-		if (le32_to_cpu(rc_sq_wqe->msg_len) >
-		    hr_dev->caps.max_sq_inline) {
+		if (unlikely(le32_to_cpu(rc_sq_wqe->msg_len) >
+			     hr_dev->caps.max_sq_inline)) {
 			ibdev_err(ibdev, "inline len(1-%d)=%d, illegal",
 				  rc_sq_wqe->msg_len,
 				  hr_dev->caps.max_sq_inline);
 			return -EINVAL;
 		}
 
-		if (wr->opcode == IB_WR_RDMA_READ) {
+		if (unlikely(wr->opcode == IB_WR_RDMA_READ)) {
 			ibdev_err(ibdev, "Not support inline data!\n");
 			return -EINVAL;
 		}
@@ -526,7 +526,7 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 	spin_lock_irqsave(&qp->sq.lock, flags);
 
 	ret = check_send_valid(hr_dev, qp);
-	if (ret) {
+	if (unlikely(ret)) {
 		*bad_wr = wr;
 		nreq = 0;
 		goto out;
@@ -562,7 +562,7 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 		else if (ibqp->qp_type == IB_QPT_RC)
 			ret = set_rc_wqe(qp, wr, wqe, &sge_idx, owner_bit);
 
-		if (ret) {
+		if (unlikely(ret)) {
 			*bad_wr = wr;
 			goto out;
 		}
@@ -612,15 +612,15 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 	spin_lock_irqsave(&hr_qp->rq.lock, flags);
 
 	ret = check_recv_valid(hr_dev, hr_qp);
-	if (ret) {
+	if (unlikely(ret)) {
 		*bad_wr = wr;
 		nreq = 0;
 		goto out;
 	}
 
 	for (nreq = 0; wr; ++nreq, wr = wr->next) {
-		if (hns_roce_wq_overflow(&hr_qp->rq, nreq,
-			hr_qp->ibqp.recv_cq)) {
+		if (unlikely(hns_roce_wq_overflow(&hr_qp->rq, nreq,
+						  hr_qp->ibqp.recv_cq))) {
 			ret = -ENOMEM;
 			*bad_wr = wr;
 			goto out;
@@ -765,7 +765,7 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 		}
 
 		wqe_idx = find_empty_entry(&srq->idx_que, srq->wqe_cnt);
-		if (wqe_idx < 0) {
+		if (unlikely(wqe_idx < 0)) {
 			ret = -ENOMEM;
 			*bad_wr = wr;
 			break;
@@ -2984,7 +2984,7 @@ static int hns_roce_handle_recv_inl_wqe(struct hns_roce_v2_cqe *cqe,
 		wqe_buf += size;
 	}
 
-	if (data_len) {
+	if (unlikely(data_len)) {
 		wc->status = IB_WC_LOC_LEN_ERR;
 		return -EAGAIN;
 	}
@@ -3076,7 +3076,8 @@ static void get_cqe_status(struct hns_roce_dev *hr_dev, struct hns_roce_qp *qp,
 			break;
 		}
 
-	if (wc->status == IB_WC_SUCCESS || wc->status == IB_WC_WR_FLUSH_ERR)
+	if (likely(wc->status == IB_WC_SUCCESS ||
+		   wc->status == IB_WC_WR_FLUSH_ERR))
 		return;
 
 	ibdev_err(&hr_dev->ib_dev, "error cqe status 0x%x:\n", cqe_status);
@@ -3171,7 +3172,7 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 	}
 
 	get_cqe_status(hr_dev, *cur_qp, cqe, wc);
-	if (wc->status != IB_WC_SUCCESS)
+	if (unlikely(wc->status != IB_WC_SUCCESS))
 		return 0;
 
 	if (is_send) {
@@ -3270,7 +3271,7 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 		    opcode == HNS_ROCE_V2_OPCODE_SEND_WITH_INV) &&
 		    (roce_get_bit(cqe->byte_4, V2_CQE_BYTE_4_RQ_INLINE_S))) {
 			ret = hns_roce_handle_recv_inl_wqe(cqe, cur_qp, wc);
-			if (ret)
+			if (unlikely(ret))
 				return -EAGAIN;
 		}
 
-- 
2.8.1

