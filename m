Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810413A2ABD
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 13:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhFJLwi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 07:52:38 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5492 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhFJLwg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Jun 2021 07:52:36 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G12KJ1bgjzZfrb;
        Thu, 10 Jun 2021 19:47:48 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 19:50:37 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 10 Jun 2021 19:50:36 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Yangyang Li <liyangyang20@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 4/6] RDMA/hns: Use IDA interface to manage mtpt index
Date:   Thu, 10 Jun 2021 19:50:12 +0800
Message-ID: <1623325814-55737-5-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623325814-55737-1-git-send-email-liweihang@huawei.com>
References: <1623325814-55737-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

Switch mtpt index allocation and release from hns own bitmap interface
to IDA interface.

Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_alloc.c  |  2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h | 11 +++--
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  3 +-
 drivers/infiniband/hw/hns/hns_roce_main.c   |  9 +---
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 66 ++++++++++++++---------------
 5 files changed, 43 insertions(+), 48 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index eef5df1..dc1f28a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -251,7 +251,7 @@ void hns_roce_cleanup_bitmap(struct hns_roce_dev *hr_dev)
 		hns_roce_cleanup_srq_table(hr_dev);
 	hns_roce_cleanup_qp_table(hr_dev);
 	hns_roce_cleanup_cq_table(hr_dev);
-	hns_roce_cleanup_mr_table(hr_dev);
+	ida_destroy(&hr_dev->mr_table.mtpt_ida.ida);
 	hns_roce_cleanup_pd_table(hr_dev);
 	hns_roce_cleanup_uar_table(hr_dev);
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 18ec35a..847829b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -253,6 +253,12 @@ struct hns_roce_bitmap {
 	unsigned long		*table;
 };
 
+struct hns_roce_ida {
+	struct ida ida;
+	u32 min; /* Lowest ID to allocate.  */
+	u32 max; /* Highest ID to allocate. */
+};
+
 /* For Hardware Entry Memory */
 struct hns_roce_hem_table {
 	/* HEM type: 0 = qpc, 1 = mtt, 2 = cqc, 3 = srq, 4 = other */
@@ -347,7 +353,7 @@ struct hns_roce_mr {
 };
 
 struct hns_roce_mr_table {
-	struct hns_roce_bitmap		mtpt_bitmap;
+	struct hns_roce_ida mtpt_ida;
 	struct hns_roce_hem_table	mtpt_table;
 };
 
@@ -1139,14 +1145,13 @@ int hns_roce_mtr_map(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		     dma_addr_t *pages, unsigned int page_cnt);
 
 int hns_roce_init_pd_table(struct hns_roce_dev *hr_dev);
-int hns_roce_init_mr_table(struct hns_roce_dev *hr_dev);
+void hns_roce_init_mr_table(struct hns_roce_dev *hr_dev);
 void hns_roce_init_cq_table(struct hns_roce_dev *hr_dev);
 int hns_roce_init_qp_table(struct hns_roce_dev *hr_dev);
 int hns_roce_init_srq_table(struct hns_roce_dev *hr_dev);
 int hns_roce_init_xrcd_table(struct hns_roce_dev *hr_dev);
 
 void hns_roce_cleanup_pd_table(struct hns_roce_dev *hr_dev);
-void hns_roce_cleanup_mr_table(struct hns_roce_dev *hr_dev);
 void hns_roce_cleanup_eq_table(struct hns_roce_dev *hr_dev);
 void hns_roce_cleanup_cq_table(struct hns_roce_dev *hr_dev);
 void hns_roce_cleanup_qp_table(struct hns_roce_dev *hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 94214c1..5f91dff 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -1199,8 +1199,7 @@ static int hns_roce_v1_dereg_mr(struct hns_roce_dev *hr_dev,
 	dev_dbg(dev, "Free mr 0x%x use 0x%x us.\n",
 		mr->key, jiffies_to_usecs(jiffies) - jiffies_to_usecs(start));
 
-	hns_roce_bitmap_free(&hr_dev->mr_table.mtpt_bitmap,
-			     key_to_hw_index(mr->key));
+	ida_free(&hr_dev->mr_table.mtpt_ida.ida, (int)key_to_hw_index(mr->key));
 	hns_roce_mtr_destroy(hr_dev, &mr->pbl_mtr);
 	kfree(mr);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 6c6e82b..1faadd3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -763,11 +763,7 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 		}
 	}
 
-	ret = hns_roce_init_mr_table(hr_dev);
-	if (ret) {
-		dev_err(dev, "Failed to init memory region table.\n");
-		goto err_xrcd_table_free;
-	}
+	hns_roce_init_mr_table(hr_dev);
 
 	hns_roce_init_cq_table(hr_dev);
 
@@ -793,9 +789,8 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 
 err_cq_table_free:
 	hns_roce_cleanup_cq_table(hr_dev);
-	hns_roce_cleanup_mr_table(hr_dev);
+	ida_destroy(&hr_dev->mr_table.mtpt_ida.ida);
 
-err_xrcd_table_free:
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_XRC)
 		hns_roce_cleanup_xrcd_table(hr_dev);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index ce3ceec..5296b09 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -38,9 +38,9 @@
 #include "hns_roce_cmd.h"
 #include "hns_roce_hem.h"
 
-static u32 hw_index_to_key(unsigned long ind)
+static u32 hw_index_to_key(int ind)
 {
-	return (u32)(ind >> 24) | (ind << 8);
+	return ((u32)ind >> 24) | ((u32)ind << 8);
 }
 
 unsigned long key_to_hw_index(u32 key)
@@ -68,22 +68,23 @@ int hns_roce_hw_destroy_mpt(struct hns_roce_dev *hr_dev,
 
 static int alloc_mr_key(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr)
 {
+	struct hns_roce_ida *mtpt_ida = &hr_dev->mr_table.mtpt_ida;
 	struct ib_device *ibdev = &hr_dev->ib_dev;
-	unsigned long obj = 0;
 	int err;
+	int id;
 
 	/* Allocate a key for mr from mr_table */
-	err = hns_roce_bitmap_alloc(&hr_dev->mr_table.mtpt_bitmap, &obj);
-	if (err) {
-		ibdev_err(ibdev,
-			  "failed to alloc bitmap for MR key, ret = %d.\n",
-			  err);
+	id = ida_alloc_range(&mtpt_ida->ida, mtpt_ida->min, mtpt_ida->max,
+			     GFP_KERNEL);
+	if (id < 0) {
+		ibdev_err(ibdev, "failed to alloc id for MR key, id(%d)\n", id);
 		return -ENOMEM;
 	}
 
-	mr->key = hw_index_to_key(obj);		/* MR key */
+	mr->key = hw_index_to_key(id);		/* MR key */
 
-	err = hns_roce_table_get(hr_dev, &hr_dev->mr_table.mtpt_table, obj);
+	err = hns_roce_table_get(hr_dev, &hr_dev->mr_table.mtpt_table,
+				 (unsigned long)id);
 	if (err) {
 		ibdev_err(ibdev, "failed to alloc mtpt, ret = %d.\n", err);
 		goto err_free_bitmap;
@@ -91,7 +92,7 @@ static int alloc_mr_key(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr)
 
 	return 0;
 err_free_bitmap:
-	hns_roce_bitmap_free(&hr_dev->mr_table.mtpt_bitmap, obj);
+	ida_free(&mtpt_ida->ida, id);
 	return err;
 }
 
@@ -100,7 +101,7 @@ static void free_mr_key(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr)
 	unsigned long obj = key_to_hw_index(mr->key);
 
 	hns_roce_table_put(hr_dev, &hr_dev->mr_table.mtpt_table, obj);
-	hns_roce_bitmap_free(&hr_dev->mr_table.mtpt_bitmap, obj);
+	ida_free(&hr_dev->mr_table.mtpt_ida.ida, (int)obj);
 }
 
 static int alloc_mr_pbl(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr,
@@ -196,23 +197,13 @@ static int hns_roce_mr_enable(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
-int hns_roce_init_mr_table(struct hns_roce_dev *hr_dev)
-{
-	struct hns_roce_mr_table *mr_table = &hr_dev->mr_table;
-	int ret;
-
-	ret = hns_roce_bitmap_init(&mr_table->mtpt_bitmap,
-				   hr_dev->caps.num_mtpts,
-				   hr_dev->caps.num_mtpts - 1,
-				   hr_dev->caps.reserved_mrws, 0);
-	return ret;
-}
-
-void hns_roce_cleanup_mr_table(struct hns_roce_dev *hr_dev)
+void hns_roce_init_mr_table(struct hns_roce_dev *hr_dev)
 {
-	struct hns_roce_mr_table *mr_table = &hr_dev->mr_table;
+	struct hns_roce_ida *mtpt_ida = &hr_dev->mr_table.mtpt_ida;
 
-	hns_roce_bitmap_cleanup(&mr_table->mtpt_bitmap);
+	ida_init(&mtpt_ida->ida);
+	mtpt_ida->max = hr_dev->caps.num_mtpts - 1;
+	mtpt_ida->min = hr_dev->caps.reserved_mrws;
 }
 
 struct ib_mr *hns_roce_get_dma_mr(struct ib_pd *pd, int acc)
@@ -503,8 +494,8 @@ static void hns_roce_mw_free(struct hns_roce_dev *hr_dev,
 				   key_to_hw_index(mw->rkey));
 	}
 
-	hns_roce_bitmap_free(&hr_dev->mr_table.mtpt_bitmap,
-			     key_to_hw_index(mw->rkey));
+	ida_free(&hr_dev->mr_table.mtpt_ida.ida,
+		 (int)key_to_hw_index(mw->rkey));
 }
 
 static int hns_roce_mw_enable(struct hns_roce_dev *hr_dev,
@@ -558,16 +549,21 @@ static int hns_roce_mw_enable(struct hns_roce_dev *hr_dev,
 int hns_roce_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibmw->device);
+	struct hns_roce_ida *mtpt_ida = &hr_dev->mr_table.mtpt_ida;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_mw *mw = to_hr_mw(ibmw);
-	unsigned long index = 0;
 	int ret;
+	int id;
 
-	/* Allocate a key for mw from bitmap */
-	ret = hns_roce_bitmap_alloc(&hr_dev->mr_table.mtpt_bitmap, &index);
-	if (ret)
-		return ret;
+	/* Allocate a key for mw from mr_table */
+	id = ida_alloc_range(&mtpt_ida->ida, mtpt_ida->min, mtpt_ida->max,
+			     GFP_KERNEL);
+	if (id < 0) {
+		ibdev_err(ibdev, "failed to alloc id for MW key, id(%d)\n", id);
+		return -ENOMEM;
+	}
 
-	mw->rkey = hw_index_to_key(index);
+	mw->rkey = hw_index_to_key(id);
 
 	ibmw->rkey = mw->rkey;
 	mw->pdn = to_hr_pd(ibmw->pd)->pdn;
-- 
2.7.4

