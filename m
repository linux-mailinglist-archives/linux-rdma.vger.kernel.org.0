Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA772C0985
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Nov 2020 14:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388731AbgKWNIs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Nov 2020 08:08:48 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8387 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388395AbgKWNIr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Nov 2020 08:08:47 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CfnWw3dVxz72NQ;
        Mon, 23 Nov 2020 21:08:12 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Mon, 23 Nov 2020 21:08:24 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next] RDMA/hns: Create QP with selected QPN for bank load balance
Date:   Mon, 23 Nov 2020 21:06:48 +0800
Message-ID: <1606136808-32136-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

In order to improve performance by balancing the load between different
banks of cache, the QPC cache is desigend to choose one of 8 banks
according to lower 3 bits of QPN. The hns driver needs to count the number
of QP on each bank and then assigns the QP being created to the bank with
the minimum load first.

Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
Changes since v1:
- Use ida instead of bitmap to allocate QPN.
- Remove CQ parts, which will be reorganized in a separate patch.
Link: https://patchwork.kernel.org/project/linux-rdma/patch/1599642563-10264-1-git-send-email-liweihang@huawei.com/

 drivers/infiniband/hw/hns/hns_roce_device.h |  15 ++++-
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 100 +++++++++++++++++++++++-----
 2 files changed, 96 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 1d99022..e9783cc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -117,6 +117,8 @@
 #define HNS_ROCE_IDX_QUE_ENTRY_SZ		4
 #define SRQ_DB_REG				0x230
 
+#define HNS_ROCE_QP_BANK_NUM 8
+
 /* The chip implementation of the consumer index is calculated
  * according to twice the actual EQ depth
  */
@@ -512,13 +514,22 @@ struct hns_roce_uar_table {
 	struct hns_roce_bitmap bitmap;
 };
 
+struct hns_roce_bank {
+	struct ida ida;
+	u32 inuse; /* Number of IDs allocated */
+	u32 min; /* Lowest ID to allocate.  */
+	u32 max; /* Highest ID to allocate. */
+	u32 rsv_bot; /* Reserved bottom ids */
+};
+
 struct hns_roce_qp_table {
-	struct hns_roce_bitmap		bitmap;
 	struct hns_roce_hem_table	qp_table;
 	struct hns_roce_hem_table	irrl_table;
 	struct hns_roce_hem_table	trrl_table;
 	struct hns_roce_hem_table	sccc_table;
 	struct mutex			scc_mutex;
+	struct hns_roce_bank bank[HNS_ROCE_QP_BANK_NUM];
+	spinlock_t bank_lock;
 };
 
 struct hns_roce_cq_table {
@@ -768,7 +779,7 @@ struct hns_roce_caps {
 	u32		max_rq_sg;
 	u32		max_extend_sg;
 	int		num_qps;
-	int             reserved_qps;
+	u32             reserved_qps;
 	int		num_qpc_timer;
 	int		num_cqc_timer;
 	int		num_srqs;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index e288946..73de6e5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -154,9 +154,50 @@ static void hns_roce_ib_qp_event(struct hns_roce_qp *hr_qp,
 	}
 }
 
+static u8 get_least_load_bankid_for_qp(struct hns_roce_bank *bank)
+{
+	u32 least_load = bank[0].inuse;
+	u8 bankid = 0;
+	u32 bankcnt;
+	u8 i;
+
+	for (i = 1; i < HNS_ROCE_QP_BANK_NUM; i++) {
+		bankcnt = bank[i].inuse;
+		if (bankcnt < least_load) {
+			least_load = bankcnt;
+			bankid = i;
+		}
+	}
+
+	return bankid;
+}
+
+static int alloc_qpn_with_bankid(struct hns_roce_bank *bank, u8 bankid,
+				 unsigned long *qpn)
+{
+	int id;
+
+	id = ida_alloc_range(&bank->ida, bank->min, bank->max, GFP_KERNEL);
+	if (id < 0) {
+		id = ida_alloc_range(&bank->ida, bank->rsv_bot, bank->min,
+				     GFP_KERNEL);
+		if (id < 0)
+			return id;
+	}
+
+	/* the QPN should keep increasing until the max value is reached. */
+	bank->min = (id + 1) > bank->max ? bank->rsv_bot : id + 1;
+
+	/* the lower 3 bits is bankid */
+	*qpn = (id << 3) | bankid;
+
+	return 0;
+}
 static int alloc_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 {
+	struct hns_roce_qp_table *qp_table = &hr_dev->qp_table;
 	unsigned long num = 0;
+	u8 bankid;
 	int ret;
 
 	if (hr_qp->ibqp.qp_type == IB_QPT_GSI) {
@@ -169,13 +210,21 @@ static int alloc_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 
 		hr_qp->doorbell_qpn = 1;
 	} else {
-		ret = hns_roce_bitmap_alloc_range(&hr_dev->qp_table.bitmap,
-						  1, 1, &num);
+		spin_lock(&qp_table->bank_lock);
+		bankid = get_least_load_bankid_for_qp(qp_table->bank);
+
+		ret = alloc_qpn_with_bankid(&qp_table->bank[bankid], bankid,
+					    &num);
 		if (ret) {
-			ibdev_err(&hr_dev->ib_dev, "Failed to alloc bitmap\n");
-			return -ENOMEM;
+			ibdev_err(&hr_dev->ib_dev,
+				  "failed to alloc QPN, ret = %d\n", ret);
+			spin_unlock(&qp_table->bank_lock);
+			return ret;
 		}
 
+		qp_table->bank[bankid].inuse++;
+		spin_unlock(&qp_table->bank_lock);
+
 		hr_qp->doorbell_qpn = (u32)num;
 	}
 
@@ -340,9 +389,15 @@ static void free_qpc(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 	hns_roce_table_put(hr_dev, &qp_table->irrl_table, hr_qp->qpn);
 }
 
+static inline u8 get_qp_bankid(unsigned long qpn)
+{
+	/* The lower 3 bits of QPN are used to hash to different banks */
+	return (u8)(qpn & GENMASK(2, 0));
+}
+
 static void free_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 {
-	struct hns_roce_qp_table *qp_table = &hr_dev->qp_table;
+	u8 bankid;
 
 	if (hr_qp->ibqp.qp_type == IB_QPT_GSI)
 		return;
@@ -350,7 +405,13 @@ static void free_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 	if (hr_qp->qpn < hr_dev->caps.reserved_qps)
 		return;
 
-	hns_roce_bitmap_free_range(&qp_table->bitmap, hr_qp->qpn, 1, BITMAP_RR);
+	bankid = get_qp_bankid(hr_qp->qpn);
+
+	ida_free(&hr_dev->qp_table.bank[bankid].ida, hr_qp->qpn >> 3);
+
+	spin_lock(&hr_dev->qp_table.bank_lock);
+	hr_dev->qp_table.bank[bankid].inuse--;
+	spin_unlock(&hr_dev->qp_table.bank_lock);
 }
 
 static int set_rq_size(struct hns_roce_dev *hr_dev, struct ib_qp_cap *cap,
@@ -1275,22 +1336,24 @@ bool hns_roce_wq_overflow(struct hns_roce_wq *hr_wq, int nreq,
 int hns_roce_init_qp_table(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_qp_table *qp_table = &hr_dev->qp_table;
-	int reserved_from_top = 0;
-	int reserved_from_bot;
-	int ret;
+	unsigned int reserved_from_bot;
+	unsigned int i;
 
 	mutex_init(&qp_table->scc_mutex);
 	xa_init(&hr_dev->qp_table_xa);
 
 	reserved_from_bot = hr_dev->caps.reserved_qps;
 
-	ret = hns_roce_bitmap_init(&qp_table->bitmap, hr_dev->caps.num_qps,
-				   hr_dev->caps.num_qps - 1, reserved_from_bot,
-				   reserved_from_top);
-	if (ret) {
-		dev_err(hr_dev->dev, "qp bitmap init failed!error=%d\n",
-			ret);
-		return ret;
+	for (i = 0; i < reserved_from_bot; i++) {
+		hr_dev->qp_table.bank[get_qp_bankid(i)].inuse++;
+		hr_dev->qp_table.bank[get_qp_bankid(i)].rsv_bot++;
+	}
+
+	for (i = 0; i < HNS_ROCE_QP_BANK_NUM; i++) {
+		ida_init(&hr_dev->qp_table.bank[i].ida);
+		hr_dev->qp_table.bank[i].max = hr_dev->caps.num_qps /
+					       HNS_ROCE_QP_BANK_NUM - 1;
+		hr_dev->qp_table.bank[i].min = hr_dev->qp_table.bank[i].rsv_bot;
 	}
 
 	return 0;
@@ -1298,5 +1361,8 @@ int hns_roce_init_qp_table(struct hns_roce_dev *hr_dev)
 
 void hns_roce_cleanup_qp_table(struct hns_roce_dev *hr_dev)
 {
-	hns_roce_bitmap_cleanup(&hr_dev->qp_table.bitmap);
+	int i;
+
+	for (i = 0; i < HNS_ROCE_QP_BANK_NUM; i++)
+		ida_destroy(&hr_dev->qp_table.bank[i].ida);
 }
-- 
2.8.1

