Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C455915FDE2
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Feb 2020 10:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgBOJkS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Feb 2020 04:40:18 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38108 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbgBOJkS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 15 Feb 2020 04:40:18 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0459EB6C8D6747CECC8F;
        Sat, 15 Feb 2020 17:40:14 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Sat, 15 Feb 2020 17:40:07 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Initialize all fields of doorbells to zero
Date:   Sat, 15 Feb 2020 17:36:08 +0800
Message-ID: <1581759368-16700-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Prevent uninitialized fields when new fields are added, and make code
look simpler.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 9 ++-------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 5 +----
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index c6e6658..89dac44 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -69,7 +69,7 @@ static int hns_roce_v1_post_send(struct ib_qp *ibqp,
 	struct hns_roce_wqe_data_seg *dseg = NULL;
 	struct hns_roce_qp *qp = to_hr_qp(ibqp);
 	struct device *dev = &hr_dev->pdev->dev;
-	struct hns_roce_sq_db sq_db;
+	struct hns_roce_sq_db sq_db = {};
 	int ps_opcode = 0, i = 0;
 	unsigned long flags = 0;
 	void *wqe = NULL;
@@ -318,8 +318,6 @@ static int hns_roce_v1_post_send(struct ib_qp *ibqp,
 		/* Memory barrier */
 		wmb();
 
-		sq_db.u32_4 = 0;
-		sq_db.u32_8 = 0;
 		roce_set_field(sq_db.u32_4, SQ_DOORBELL_U32_4_SQ_HEAD_M,
 			       SQ_DOORBELL_U32_4_SQ_HEAD_S,
 			      (qp->sq.head & ((qp->sq.wqe_cnt << 1) - 1)));
@@ -351,7 +349,7 @@ static int hns_roce_v1_post_recv(struct ib_qp *ibqp,
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct device *dev = &hr_dev->pdev->dev;
-	struct hns_roce_rq_db rq_db;
+	struct hns_roce_rq_db rq_db = {};
 	__le32 doorbell[2] = {0};
 	unsigned long flags = 0;
 	unsigned int wqe_idx;
@@ -418,9 +416,6 @@ static int hns_roce_v1_post_recv(struct ib_qp *ibqp,
 				   ROCEE_QP1C_CFG3_0_REG +
 				   QP1C_CFGN_OFFSET * hr_qp->phy_port, reg_val);
 		} else {
-			rq_db.u32_4 = 0;
-			rq_db.u32_8 = 0;
-
 			roce_set_field(rq_db.u32_4, RQ_DOORBELL_U32_4_RQ_HEAD_M,
 				       RQ_DOORBELL_U32_4_RQ_HEAD_S,
 				       hr_qp->rq.head);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index f233d26..e46f858 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -260,7 +260,7 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 	struct hns_roce_qp *qp = to_hr_qp(ibqp);
 	struct hns_roce_wqe_frmr_seg *fseg;
 	struct device *dev = hr_dev->dev;
-	struct hns_roce_v2_db sq_db;
+	struct hns_roce_v2_db sq_db = {};
 	struct ib_qp_attr attr;
 	unsigned int owner_bit;
 	unsigned int sge_idx;
@@ -590,9 +590,6 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 		/* Memory barrier */
 		wmb();
 
-		sq_db.byte_4 = 0;
-		sq_db.parameter = 0;
-
 		roce_set_field(sq_db.byte_4, V2_DB_BYTE_4_TAG_M,
 			       V2_DB_BYTE_4_TAG_S, qp->doorbell_qpn);
 		roce_set_field(sq_db.byte_4, V2_DB_BYTE_4_CMD_M,
-- 
2.8.1

