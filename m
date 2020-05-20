Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DEA1DB5A9
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 15:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgETNxr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 May 2020 09:53:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56372 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726801AbgETNxr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 May 2020 09:53:47 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E3AEA9958A4A6F9104CB;
        Wed, 20 May 2020 21:53:41 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Wed, 20 May 2020 21:53:35 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 2/9] RDMA/hns: Add CQ flag instead of independent enable flag
Date:   Wed, 20 May 2020 21:53:12 +0800
Message-ID: <1589982799-28728-3-git-send-email-liweihang@huawei.com>
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

It's easier to understand and maintain enable flags of cq using a single
field in type of u32 than defining a field for every flags in the structure
hns_roce_cq, and we can add new flags for features more conveniently in the
future.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c     | 10 +++++-----
 drivers/infiniband/hw/hns/hns_roce_device.h |  6 +++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index d2d7074..925fb77 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -186,8 +186,8 @@ static int alloc_cq_db(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
 						   &hr_cq->db);
 			if (err)
 				return err;
-			hr_cq->db_en = 1;
-			resp->cap_flags |= HNS_ROCE_SUPPORT_CQ_RECORD_DB;
+			hr_cq->flags |= HNS_ROCE_CQ_FLAG_RECORD_DB;
+			resp->cap_flags |= HNS_ROCE_CQ_FLAG_RECORD_DB;
 		}
 	} else {
 		if (has_db) {
@@ -196,7 +196,7 @@ static int alloc_cq_db(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
 				return err;
 			hr_cq->set_ci_db = hr_cq->db.db_record;
 			*hr_cq->set_ci_db = 0;
-			hr_cq->db_en = 1;
+			hr_cq->flags |= HNS_ROCE_CQ_FLAG_RECORD_DB;
 		}
 		hr_cq->cq_db_l = hr_dev->reg_base + hr_dev->odb_offset +
 				 DB_REG_OFFSET * hr_dev->priv_uar.index;
@@ -210,10 +210,10 @@ static void free_cq_db(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
 {
 	struct hns_roce_ucontext *uctx;
 
-	if (!hr_cq->db_en)
+	if (!(hr_cq->flags & HNS_ROCE_CQ_FLAG_RECORD_DB))
 		return;
 
-	hr_cq->db_en = 0;
+	hr_cq->flags &= ~HNS_ROCE_CQ_FLAG_RECORD_DB;
 	if (udata) {
 		uctx = rdma_udata_to_drv_context(udata,
 						 struct hns_roce_ucontext,
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 4fcd608e..06bafa1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -135,8 +135,8 @@ enum {
 	HNS_ROCE_QP_CAP_SQ_RECORD_DB = BIT(1),
 };
 
-enum {
-	HNS_ROCE_SUPPORT_CQ_RECORD_DB = 1 << 0,
+enum hns_roce_cq_flags {
+	HNS_ROCE_CQ_FLAG_RECORD_DB = BIT(0),
 };
 
 enum hns_roce_qp_state {
@@ -454,7 +454,7 @@ struct hns_roce_cq {
 	struct ib_cq			ib_cq;
 	struct hns_roce_mtr		mtr;
 	struct hns_roce_db		db;
-	u8				db_en;
+	u32				flags;
 	spinlock_t			lock;
 	u32				cq_depth;
 	u32				cons_index;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 7d0556ef..36a9871 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2905,9 +2905,9 @@ static void hns_roce_v2_write_cqc(struct hns_roce_dev *hr_dev,
 	roce_set_field(cq_context->byte_40_cqe_ba, V2_CQC_BYTE_40_CQE_BA_M,
 		       V2_CQC_BYTE_40_CQE_BA_S, (dma_handle >> (32 + 3)));
 
-	if (hr_cq->db_en)
-		roce_set_bit(cq_context->byte_44_db_record,
-			     V2_CQC_BYTE_44_DB_RECORD_EN_S, 1);
+	roce_set_bit(cq_context->byte_44_db_record,
+		     V2_CQC_BYTE_44_DB_RECORD_EN_S,
+		     (hr_cq->flags & HNS_ROCE_CQ_FLAG_RECORD_DB) ? 1 : 0);
 
 	roce_set_field(cq_context->byte_44_db_record,
 		       V2_CQC_BYTE_44_DB_RECORD_ADDR_M,
-- 
2.8.1

