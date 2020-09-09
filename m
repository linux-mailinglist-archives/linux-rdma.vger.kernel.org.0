Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49809262B62
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Sep 2020 11:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgIIJKo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Sep 2020 05:10:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11292 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726005AbgIIJKn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Sep 2020 05:10:43 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 413E9A4C976BA38EB05B;
        Wed,  9 Sep 2020 17:10:40 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Sep 2020 17:10:29 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Create QP/CQ with selected QPN/CQN for bank load balance
Date:   Wed, 9 Sep 2020 17:09:23 +0800
Message-ID: <1599642563-10264-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

In order to improve performance by balancing the load between different
banks of cache, the QPC cache is desigend to choose one of 8 banks
according to lower 3 bits of QPN, and the CQC cache uses the lower 2 bits
to choose one from 4 banks. The hns driver needs to count the number of
QP/CQ on each bank and then assigns the QP/CQ being created to the bank
with the minimum load first.

Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_alloc.c  | 46 +++++++++++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_cq.c     | 38 +++++++++++++++++++++++-
 drivers/infiniband/hw/hns/hns_roce_device.h |  8 +++++
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 39 ++++++++++++++++++++++--
 4 files changed, 128 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index a522cb2..cbe955c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -36,6 +36,52 @@
 #include "hns_roce_device.h"
 #include <rdma/ib_umem.h>
 
+static int get_bit(struct hns_roce_bitmap *bitmap, u8 bankid,
+		   u8 mod, unsigned long *obj)
+{
+	unsigned long offset_bak = bitmap->last;
+	bool one_circle_flag = false;
+
+	do {
+		*obj = find_next_zero_bit(bitmap->table, bitmap->max,
+					  bitmap->last);
+		if (*obj >= bitmap->max) {
+			*obj = find_first_zero_bit(bitmap->table, bitmap->max);
+			one_circle_flag = true;
+		}
+
+		bitmap->last = (*obj + 1);
+		if (bitmap->last == bitmap->max) {
+			bitmap->last = 0;
+			one_circle_flag = true;
+		}
+
+		/* Not found after a round of search */
+		if (bitmap->last >= offset_bak && one_circle_flag)
+			return -EINVAL;
+
+	} while (*obj % mod != bankid);
+
+	return 0;
+}
+
+int hns_roce_bitmap_alloc_with_bankid(struct hns_roce_bitmap *bitmap,
+				      u8 bankid, u8 mod,
+				      unsigned long *obj)
+{
+	int ret;
+
+	spin_lock(&bitmap->lock);
+
+	ret = get_bit(bitmap, bankid, mod, obj);
+	if (!ret)
+		set_bit(*obj, bitmap->table);
+
+	spin_unlock(&bitmap->lock);
+
+	return ret;
+}
+
 int hns_roce_bitmap_alloc(struct hns_roce_bitmap *bitmap, unsigned long *obj)
 {
 	int ret = 0;
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index e87d616..8abd6ac 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -39,6 +39,25 @@
 #include <rdma/hns-abi.h>
 #include "hns_roce_common.h"
 
+static u8 get_least_load_bankid_for_cq(struct hns_roce_dev *hr_dev)
+{
+	u32 least_load = atomic_read(&hr_dev->bank_cq_cnt[0]);
+	u8 bankid = 0;
+	u32 bankcnt;
+	u8 i;
+
+	/* Get the least used bank id. */
+	for (i = 1; i < HNS_ROCE_CQ_BANK_NUM; i++) {
+		bankcnt = atomic_read(&hr_dev->bank_cq_cnt[i]);
+		if (bankcnt < least_load) {
+			least_load = bankcnt;
+			bankid = i;
+		}
+	}
+
+	return bankid;
+}
+
 static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 {
 	struct hns_roce_cmd_mailbox *mailbox;
@@ -46,6 +65,7 @@ static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	u64 mtts[MTT_MIN_COUNT] = { 0 };
 	dma_addr_t dma_handle;
+	u8 bankid;
 	int ret;
 
 	ret = hns_roce_mtr_find(hr_dev, &hr_cq->mtr, 0, mtts, ARRAY_SIZE(mtts),
@@ -56,12 +76,17 @@ static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	}
 
 	cq_table = &hr_dev->cq_table;
-	ret = hns_roce_bitmap_alloc(&cq_table->bitmap, &hr_cq->cqn);
+	bankid = get_least_load_bankid_for_cq(hr_dev);
+	ret = hns_roce_bitmap_alloc_with_bankid(&cq_table->bitmap, bankid,
+						HNS_ROCE_CQ_BANK_NUM,
+						&hr_cq->cqn);
 	if (ret) {
 		ibdev_err(ibdev, "Failed to alloc CQ bitmap, err %d\n", ret);
 		return ret;
 	}
 
+	atomic_inc(&hr_dev->bank_cq_cnt[bankid]);
+
 	/* Get CQC memory HEM(Hardware Entry Memory) table */
 	ret = hns_roce_table_get(hr_dev, &cq_table->table, hr_cq->cqn);
 	if (ret) {
@@ -111,14 +136,22 @@ static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	hns_roce_table_put(hr_dev, &cq_table->table, hr_cq->cqn);
 
 err_out:
+	atomic_dec(&hr_dev->bank_cq_cnt[bankid]);
 	hns_roce_bitmap_free(&cq_table->bitmap, hr_cq->cqn, BITMAP_NO_RR);
 	return ret;
 }
 
+static inline u8 get_cq_bankid(unsigned long cqn)
+{
+	/* The lower 2 bits of CQN are used to hash to different banks */
+	return (u8)(cqn & GENMASK(1, 0));
+}
+
 static void free_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 {
 	struct hns_roce_cq_table *cq_table = &hr_dev->cq_table;
 	struct device *dev = hr_dev->dev;
+	u8 bankid;
 	int ret;
 
 	ret = hns_roce_cmd_mbox(hr_dev, 0, 0, hr_cq->cqn, 1,
@@ -140,6 +173,9 @@ static void free_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 
 	hns_roce_table_put(hr_dev, &cq_table->table, hr_cq->cqn);
 	hns_roce_bitmap_free(&cq_table->bitmap, hr_cq->cqn, BITMAP_NO_RR);
+
+	bankid = get_cq_bankid(hr_cq->cqn);
+	atomic_dec(&hr_dev->bank_cq_cnt[bankid]);
 }
 
 static int alloc_cq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 4f1dd91..c543440 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -117,6 +117,9 @@
 #define HNS_ROCE_IDX_QUE_ENTRY_SZ		4
 #define SRQ_DB_REG				0x230
 
+#define HNS_ROCE_QP_BANK_NUM 8
+#define HNS_ROCE_CQ_BANK_NUM 4
+
 /* The chip implementation of the consumer index is calculated
  * according to twice the actual EQ depth
  */
@@ -1003,6 +1006,8 @@ struct hns_roce_dev {
 	void			*priv;
 	struct workqueue_struct *irq_workq;
 	const struct hns_roce_dfx_hw *dfx;
+	atomic_t bank_qp_cnt[HNS_ROCE_QP_BANK_NUM];
+	atomic_t bank_cq_cnt[HNS_ROCE_CQ_BANK_NUM];
 };
 
 static inline struct hns_roce_dev *to_hr_dev(struct ib_device *ib_dev)
@@ -1163,6 +1168,9 @@ void hns_roce_cleanup_cq_table(struct hns_roce_dev *hr_dev);
 void hns_roce_cleanup_qp_table(struct hns_roce_dev *hr_dev);
 void hns_roce_cleanup_srq_table(struct hns_roce_dev *hr_dev);
 
+int hns_roce_bitmap_alloc_with_bankid(struct hns_roce_bitmap *bitmap,
+				      u8 bankid, u8 mod,
+				      unsigned long *obj);
 int hns_roce_bitmap_alloc(struct hns_roce_bitmap *bitmap, unsigned long *obj);
 void hns_roce_bitmap_free(struct hns_roce_bitmap *bitmap, unsigned long obj,
 			 int rr);
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 975281f..42d3080 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -156,9 +156,29 @@ static void hns_roce_ib_qp_event(struct hns_roce_qp *hr_qp,
 	}
 }
 
+static u8 get_least_load_bankid_for_qp(struct hns_roce_dev *hr_dev)
+{
+	u32 least_load = atomic_read(&hr_dev->bank_qp_cnt[0]);
+	u8 bankid = 0;
+	u32 bankcnt;
+	u8 i;
+
+	/* Get the least used bank id. */
+	for (i = 1; i < HNS_ROCE_QP_BANK_NUM; i++) {
+		bankcnt = atomic_read(&hr_dev->bank_qp_cnt[i]);
+		if (bankcnt < least_load) {
+			least_load = bankcnt;
+			bankid = i;
+		}
+	}
+
+	return bankid;
+}
+
 static int alloc_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 {
 	unsigned long num = 0;
+	u8 bankid;
 	int ret;
 
 	if (hr_qp->ibqp.qp_type == IB_QPT_GSI) {
@@ -171,12 +191,16 @@ static int alloc_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 
 		hr_qp->doorbell_qpn = 1;
 	} else {
-		ret = hns_roce_bitmap_alloc_range(&hr_dev->qp_table.bitmap,
-						  1, 1, &num);
+		bankid = get_least_load_bankid_for_qp(hr_dev);
+		ret = hns_roce_bitmap_alloc_with_bankid(&hr_dev->qp_table.bitmap,
+							bankid,
+							HNS_ROCE_QP_BANK_NUM,
+							&num);
 		if (ret) {
 			ibdev_err(&hr_dev->ib_dev, "Failed to alloc bitmap\n");
 			return -ENOMEM;
 		}
+		atomic_inc(&hr_dev->bank_qp_cnt[bankid]);
 
 		hr_qp->doorbell_qpn = (u32)num;
 	}
@@ -342,9 +366,16 @@ static void free_qpc(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 	hns_roce_table_put(hr_dev, &qp_table->irrl_table, hr_qp->qpn);
 }
 
+static inline u8 get_qp_bankid(unsigned long qpn)
+{
+	/* The lower 3 bits of cqn are used to hash to different banks */
+	return (u8)(qpn & GENMASK(2, 0));
+}
+
 static void free_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 {
 	struct hns_roce_qp_table *qp_table = &hr_dev->qp_table;
+	u8 bankid;
 
 	if (hr_qp->ibqp.qp_type == IB_QPT_GSI)
 		return;
@@ -353,6 +384,10 @@ static void free_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 		return;
 
 	hns_roce_bitmap_free_range(&qp_table->bitmap, hr_qp->qpn, 1, BITMAP_RR);
+
+	bankid = get_qp_bankid(hr_qp->qpn);
+	atomic_dec(&hr_dev->bank_qp_cnt[bankid]);
+
 }
 
 static int set_rq_size(struct hns_roce_dev *hr_dev, struct ib_qp_cap *cap,
-- 
2.8.1

