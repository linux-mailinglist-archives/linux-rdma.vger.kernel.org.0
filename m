Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C922E9073
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Jan 2021 07:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbhADGiA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Jan 2021 01:38:00 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9710 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbhADGiA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Jan 2021 01:38:00 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D8Qr85yz0zl0xM;
        Mon,  4 Jan 2021 14:36:08 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Mon, 4 Jan 2021 14:37:12 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next] RDMA/hns: Create CQ with selected CQN for bank load balance
Date:   Mon, 4 Jan 2021 14:35:15 +0800
Message-ID: <1609742115-47270-1-git-send-email-liweihang@huawei.com>
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
banks of cache, the CQC cache is desigend to choose one of 4 banks
according to lower 2 bits of CQN. The hns driver needs to count the number
of CQ on each bank and then assigns the CQ being created to the bank with
the minimum load first.

Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c     | 114 +++++++++++++++++++++++-----
 drivers/infiniband/hw/hns/hns_roce_device.h |  10 ++-
 drivers/infiniband/hw/hns/hns_roce_main.c   |   8 +-
 3 files changed, 104 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 8533fc2..00350a3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -38,11 +38,74 @@
 #include "hns_roce_hem.h"
 #include "hns_roce_common.h"
 
+static u8 get_least_load_bankid_for_cq(struct hns_roce_bank *bank)
+{
+	u32 least_load = bank[0].inuse;
+	u8 bankid = 0;
+	u32 bankcnt;
+	u8 i;
+
+	for (i = 1; i < HNS_ROCE_CQ_BANK_NUM; i++) {
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
+static int alloc_cqn(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
+{
+	struct hns_roce_cq_table *cq_table = &hr_dev->cq_table;
+	struct hns_roce_bank *bank;
+	u8 bankid;
+	int id;
+
+	spin_lock(&cq_table->bank_lock);
+	bankid = get_least_load_bankid_for_cq(cq_table->bank);
+	bank = &cq_table->bank[bankid];
+
+	id = ida_alloc_range(&bank->ida, bank->min, bank->max, GFP_ATOMIC);
+	if (id < 0) {
+		spin_unlock(&cq_table->bank_lock);
+		return id;
+	}
+
+	/* the lower 2 bits is bankid */
+	hr_cq->cqn = (id << CQ_BANKID_SHIFT) | bankid;
+	bank->inuse++;
+	spin_unlock(&cq_table->bank_lock);
+
+	return 0;
+}
+
+static inline u8 get_cq_bankid(unsigned long cqn)
+{
+	/* The lower 2 bits of CQN are used to hash to different banks */
+	return (u8)(cqn & GENMASK(1, 0));
+}
+
+static void free_cqn(struct hns_roce_dev *hr_dev, unsigned long cqn)
+{
+	struct hns_roce_cq_table *cq_table = &hr_dev->cq_table;
+	struct hns_roce_bank *bank;
+
+	bank = &cq_table->bank[get_cq_bankid(cqn)];
+
+	ida_free(&bank->ida, cqn >> CQ_BANKID_SHIFT);
+
+	spin_lock(&cq_table->bank_lock);
+	bank->inuse--;
+	spin_unlock(&cq_table->bank_lock);
+}
+
 static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 {
+	struct hns_roce_cq_table *cq_table = &hr_dev->cq_table;
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_cmd_mailbox *mailbox;
-	struct hns_roce_cq_table *cq_table;
 	u64 mtts[MTT_MIN_COUNT] = { 0 };
 	dma_addr_t dma_handle;
 	int ret;
@@ -54,13 +117,6 @@ static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 		return -EINVAL;
 	}
 
-	cq_table = &hr_dev->cq_table;
-	ret = hns_roce_bitmap_alloc(&cq_table->bitmap, &hr_cq->cqn);
-	if (ret) {
-		ibdev_err(ibdev, "failed to alloc CQ bitmap, ret = %d.\n", ret);
-		return ret;
-	}
-
 	/* Get CQC memory HEM(Hardware Entry Memory) table */
 	ret = hns_roce_table_get(hr_dev, &cq_table->table, hr_cq->cqn);
 	if (ret) {
@@ -110,7 +166,6 @@ static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	hns_roce_table_put(hr_dev, &cq_table->table, hr_cq->cqn);
 
 err_out:
-	hns_roce_bitmap_free(&cq_table->bitmap, hr_cq->cqn, BITMAP_NO_RR);
 	return ret;
 }
 
@@ -138,7 +193,6 @@ static void free_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	wait_for_completion(&hr_cq->free);
 
 	hns_roce_table_put(hr_dev, &cq_table->table, hr_cq->cqn);
-	hns_roce_bitmap_free(&cq_table->bitmap, hr_cq->cqn, BITMAP_NO_RR);
 }
 
 static int alloc_cq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
@@ -298,11 +352,17 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 		goto err_cq_buf;
 	}
 
+	ret = alloc_cqn(hr_dev, hr_cq);
+	if (ret) {
+		ibdev_err(ibdev, "Failed to alloc CQN, err %d\n", ret);
+		goto err_cq_db;
+	}
+
 	ret = alloc_cqc(hr_dev, hr_cq);
 	if (ret) {
 		ibdev_err(ibdev,
 			  "failed to alloc CQ context, ret = %d.\n", ret);
-		goto err_cq_db;
+		goto err_cqn;
 	}
 
 	/*
@@ -326,6 +386,8 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 
 err_cqc:
 	free_cqc(hr_dev, hr_cq);
+err_cqn:
+	free_cqn(hr_dev, hr_cq->cqn);
 err_cq_db:
 	free_cq_db(hr_dev, hr_cq, udata);
 err_cq_buf:
@@ -341,9 +403,11 @@ int hns_roce_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	if (hr_dev->hw->destroy_cq)
 		hr_dev->hw->destroy_cq(ib_cq, udata);
 
-	free_cq_buf(hr_dev, hr_cq);
-	free_cq_db(hr_dev, hr_cq, udata);
 	free_cqc(hr_dev, hr_cq);
+	free_cqn(hr_dev, hr_cq->cqn);
+	free_cq_db(hr_dev, hr_cq, udata);
+	free_cq_buf(hr_dev, hr_cq);
+
 	return 0;
 }
 
@@ -402,18 +466,32 @@ void hns_roce_cq_event(struct hns_roce_dev *hr_dev, u32 cqn, int event_type)
 		complete(&hr_cq->free);
 }
 
-int hns_roce_init_cq_table(struct hns_roce_dev *hr_dev)
+void hns_roce_init_cq_table(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_cq_table *cq_table = &hr_dev->cq_table;
+	unsigned int reserved_from_bot;
+	unsigned int i;
 
 	xa_init(&cq_table->array);
 
-	return hns_roce_bitmap_init(&cq_table->bitmap, hr_dev->caps.num_cqs,
-				    hr_dev->caps.num_cqs - 1,
-				    hr_dev->caps.reserved_cqs, 0);
+	reserved_from_bot = hr_dev->caps.reserved_cqs;
+
+	for (i = 0; i < reserved_from_bot; i++) {
+		cq_table->bank[get_cq_bankid(i)].inuse++;
+		cq_table->bank[get_cq_bankid(i)].min++;
+	}
+
+	for (i = 0; i < HNS_ROCE_CQ_BANK_NUM; i++) {
+		ida_init(&cq_table->bank[i].ida);
+		cq_table->bank[i].max = hr_dev->caps.num_cqs /
+					HNS_ROCE_CQ_BANK_NUM - 1;
+	}
 }
 
 void hns_roce_cleanup_cq_table(struct hns_roce_dev *hr_dev)
 {
-	hns_roce_bitmap_cleanup(&hr_dev->cq_table.bitmap);
+	int i;
+
+	for (i = 0; i < HNS_ROCE_CQ_BANK_NUM; i++)
+		ida_destroy(&hr_dev->cq_table.bank[i].ida);
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 55d5386..106cfef 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -119,6 +119,9 @@
 #define SRQ_DB_REG				0x230
 
 #define HNS_ROCE_QP_BANK_NUM 8
+#define HNS_ROCE_CQ_BANK_NUM 4
+
+#define CQ_BANKID_SHIFT 2
 
 /* The chip implementation of the consumer index is calculated
  * according to twice the actual EQ depth
@@ -536,9 +539,10 @@ struct hns_roce_qp_table {
 };
 
 struct hns_roce_cq_table {
-	struct hns_roce_bitmap		bitmap;
 	struct xarray			array;
 	struct hns_roce_hem_table	table;
+	struct hns_roce_bank bank[HNS_ROCE_CQ_BANK_NUM];
+	spinlock_t bank_lock;
 };
 
 struct hns_roce_srq_table {
@@ -779,7 +783,7 @@ struct hns_roce_caps {
 	u32		max_cqes;
 	u32		min_cqes;
 	u32		min_wqes;
-	int		reserved_cqs;
+	u32		reserved_cqs;
 	int		reserved_srqs;
 	int		num_aeq_vectors;
 	int		num_comp_vectors;
@@ -1164,7 +1168,7 @@ int hns_roce_mtr_map(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 
 int hns_roce_init_pd_table(struct hns_roce_dev *hr_dev);
 int hns_roce_init_mr_table(struct hns_roce_dev *hr_dev);
-int hns_roce_init_cq_table(struct hns_roce_dev *hr_dev);
+void hns_roce_init_cq_table(struct hns_roce_dev *hr_dev);
 int hns_roce_init_qp_table(struct hns_roce_dev *hr_dev);
 int hns_roce_init_srq_table(struct hns_roce_dev *hr_dev);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index d9179ba..2b78b1f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -748,11 +748,7 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 		goto err_pd_table_free;
 	}
 
-	ret = hns_roce_init_cq_table(hr_dev);
-	if (ret) {
-		dev_err(dev, "Failed to init completion queue table.\n");
-		goto err_mr_table_free;
-	}
+	hns_roce_init_cq_table(hr_dev);
 
 	ret = hns_roce_init_qp_table(hr_dev);
 	if (ret) {
@@ -777,8 +773,6 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 
 err_cq_table_free:
 	hns_roce_cleanup_cq_table(hr_dev);
-
-err_mr_table_free:
 	hns_roce_cleanup_mr_table(hr_dev);
 
 err_pd_table_free:
-- 
2.8.1

