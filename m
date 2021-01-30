Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6EA2309351
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Jan 2021 10:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhA3JZG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 30 Jan 2021 04:25:06 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12369 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbhA3JYN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 30 Jan 2021 04:24:13 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DSSnF6QNRz7cVv;
        Sat, 30 Jan 2021 16:59:13 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 30 Jan 2021 17:00:23 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 07/12] RDMA/hns: Refactor code about SRQ Context
Date:   Sat, 30 Jan 2021 16:58:05 +0800
Message-ID: <1611997090-48820-8-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1611997090-48820-1-git-send-email-liweihang@huawei.com>
References: <1611997090-48820-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

Reduce parameter numbers of write_srqc() and move some related code into
it from alloc_srqc().

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  6 +---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 33 ++++++++++++++++++----
 drivers/infiniband/hw/hns/hns_roce_srq.c    | 44 +++++++++--------------------
 3 files changed, 42 insertions(+), 41 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index b325b9c..d51641a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -953,11 +953,7 @@ struct hns_roce_hw {
 	int (*modify_cq)(struct ib_cq *cq, u16 cq_count, u16 cq_period);
 	int (*init_eq)(struct hns_roce_dev *hr_dev);
 	void (*cleanup_eq)(struct hns_roce_dev *hr_dev);
-	void (*write_srqc)(struct hns_roce_dev *hr_dev,
-			   struct hns_roce_srq *srq, void *mb_buf,
-			   u64 *mtts_wqe, u64 *mtts_idx,
-			   dma_addr_t dma_handle_wqe,
-			   dma_addr_t dma_handle_idx);
+	int (*write_srqc)(struct hns_roce_srq *srq, void *mb_buf);
 	int (*modify_srq)(struct ib_srq *ibsrq, struct ib_srq_attr *srq_attr,
 		       enum ib_srq_attr_mask srq_attr_mask,
 		       struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index ec2d64c..dd5f7b5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5227,17 +5227,38 @@ static int hns_roce_v2_qp_flow_control_init(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
-static void hns_roce_v2_write_srqc(struct hns_roce_dev *hr_dev,
-				   struct hns_roce_srq *srq, void *mb_buf,
-				   u64 *mtts_wqe, u64 *mtts_idx,
-				   dma_addr_t dma_handle_wqe,
-				   dma_addr_t dma_handle_idx)
+static int hns_roce_v2_write_srqc(struct hns_roce_srq *srq, void *mb_buf)
 {
+	struct ib_device *ibdev = srq->ibsrq.device;
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibdev);
 	struct hns_roce_srq_context *srq_context;
+	u64 mtts_wqe[MTT_MIN_COUNT] = {};
+	u64 mtts_idx[MTT_MIN_COUNT] = {};
+	dma_addr_t dma_handle_wqe = 0;
+	dma_addr_t dma_handle_idx = 0;
+	int ret;
 
 	srq_context = mb_buf;
 	memset(srq_context, 0, sizeof(*srq_context));
 
+	/* Get the physical address of srq buf */
+	ret = hns_roce_mtr_find(hr_dev, &srq->buf_mtr, 0, mtts_wqe,
+				ARRAY_SIZE(mtts_wqe), &dma_handle_wqe);
+	if (ret < 1) {
+		ibdev_err(ibdev, "failed to find mtr for SRQ WQE, ret = %d.\n",
+			  ret);
+		return -ENOBUFS;
+	}
+
+	/* Get physical address of idx que buf */
+	ret = hns_roce_mtr_find(hr_dev, &srq->idx_que.mtr, 0, mtts_idx,
+				ARRAY_SIZE(mtts_idx), &dma_handle_idx);
+	if (ret < 1) {
+		ibdev_err(ibdev, "failed to find mtr for SRQ idx, ret = %d.\n",
+			  ret);
+		return -ENOBUFS;
+	}
+
 	roce_set_field(srq_context->byte_4_srqn_srqst, SRQC_BYTE_4_SRQ_ST_M,
 		       SRQC_BYTE_4_SRQ_ST_S, 1);
 
@@ -5319,6 +5340,8 @@ static void hns_roce_v2_write_srqc(struct hns_roce_dev *hr_dev,
 
 	roce_set_bit(srq_context->db_record_addr_record_en,
 		     SRQC_BYTE_60_SRQ_RECORD_EN_S, 0);
+
+	return 0;
 }
 
 static int hns_roce_v2_modify_srq(struct ib_srq *ibsrq,
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 5069b81..d5a6de0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -82,34 +82,11 @@ static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 	struct hns_roce_srq_table *srq_table = &hr_dev->srq_table;
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_cmd_mailbox *mailbox;
-	u64 mtts_wqe[MTT_MIN_COUNT] = { 0 };
-	u64 mtts_idx[MTT_MIN_COUNT] = { 0 };
-	dma_addr_t dma_handle_wqe = 0;
-	dma_addr_t dma_handle_idx = 0;
 	int ret;
 
-	/* Get the physical address of srq buf */
-	ret = hns_roce_mtr_find(hr_dev, &srq->buf_mtr, 0, mtts_wqe,
-				ARRAY_SIZE(mtts_wqe), &dma_handle_wqe);
-	if (ret < 1) {
-		ibdev_err(ibdev, "failed to find mtr for SRQ WQE, ret = %d.\n",
-			  ret);
-		return -ENOBUFS;
-	}
-
-	/* Get physical address of idx que buf */
-	ret = hns_roce_mtr_find(hr_dev, &srq->idx_que.mtr, 0, mtts_idx,
-				ARRAY_SIZE(mtts_idx), &dma_handle_idx);
-	if (ret < 1) {
-		ibdev_err(ibdev, "failed to find mtr for SRQ idx, ret = %d.\n",
-			  ret);
-		return -ENOBUFS;
-	}
-
 	ret = hns_roce_bitmap_alloc(&srq_table->bitmap, &srq->srqn);
 	if (ret) {
-		ibdev_err(ibdev,
-			  "failed to alloc SRQ number, ret = %d.\n", ret);
+		ibdev_err(ibdev, "failed to alloc SRQ number.\n");
 		return -ENOMEM;
 	}
 
@@ -127,31 +104,36 @@ static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 
 	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
 	if (IS_ERR_OR_NULL(mailbox)) {
-		ret = -ENOMEM;
 		ibdev_err(ibdev, "failed to alloc mailbox for SRQC.\n");
+		ret = -ENOMEM;
 		goto err_xa;
 	}
 
-	hr_dev->hw->write_srqc(hr_dev, srq, mailbox->buf, mtts_wqe, mtts_idx,
-			       dma_handle_wqe, dma_handle_idx);
+	ret = hr_dev->hw->write_srqc(srq, mailbox->buf);
+	if (ret) {
+		ibdev_err(ibdev, "failed to write SRQC.\n");
+		goto err_mbox;
+	}
 
 	ret = hns_roce_hw_create_srq(hr_dev, mailbox, srq->srqn);
-	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 	if (ret) {
 		ibdev_err(ibdev, "failed to config SRQC, ret = %d.\n", ret);
-		goto err_xa;
+		goto err_mbox;
 	}
 
+	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
+
 	return 0;
 
+err_mbox:
+	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 err_xa:
 	xa_erase(&srq_table->xa, srq->srqn);
-
 err_put:
 	hns_roce_table_put(hr_dev, &srq_table->table, srq->srqn);
-
 err_out:
 	hns_roce_bitmap_free(&srq_table->bitmap, srq->srqn, BITMAP_NO_RR);
+
 	return ret;
 }
 
-- 
2.8.1

