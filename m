Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CC63A2ABA
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 13:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhFJLwg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 07:52:36 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5490 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhFJLwe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Jun 2021 07:52:34 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G12KG1CbSzZf0v;
        Thu, 10 Jun 2021 19:47:46 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
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
Subject: [PATCH for-next 3/6] RDMA/hns: Remove unused RR mechanism
Date:   Thu, 10 Jun 2021 19:50:11 +0800
Message-ID: <1623325814-55737-4-git-send-email-liweihang@huawei.com>
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

Round-robin (RR) is no longer used in the allocation of the bitmap table,
and all the function input parameters that use this mechanism are
BITMAP_NO_RR. The code that defines and uses the RR needs to be deleted.

Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_alloc.c  | 6 ++----
 drivers/infiniband/hw/hns/hns_roce_device.h | 6 +-----
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  | 2 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 6 +++---
 drivers/infiniband/hw/hns/hns_roce_pd.c     | 7 +++----
 drivers/infiniband/hw/hns/hns_roce_srq.c    | 4 ++--
 6 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index f950ec4..eef5df1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -63,16 +63,14 @@ int hns_roce_bitmap_alloc(struct hns_roce_bitmap *bitmap, unsigned long *obj)
 	return ret;
 }
 
-void hns_roce_bitmap_free(struct hns_roce_bitmap *bitmap, unsigned long obj,
-			  int rr)
+void hns_roce_bitmap_free(struct hns_roce_bitmap *bitmap, unsigned long obj)
 {
 	obj &= bitmap->max + bitmap->reserved_top - 1;
 
 	spin_lock(&bitmap->lock);
 	clear_bit(obj, bitmap->table);
 
-	if (!rr)
-		bitmap->last = min(bitmap->last, obj);
+	bitmap->last = min(bitmap->last, obj);
 	bitmap->top = (bitmap->top + bitmap->max + bitmap->reserved_top)
 		       & bitmap->mask;
 	spin_unlock(&bitmap->lock);
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index cbf3b9b..18ec35a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -95,9 +95,6 @@
 
 #define HNS_ROCE_HOP_NUM_0			0xff
 
-#define BITMAP_NO_RR				0
-#define BITMAP_RR				1
-
 #define MR_TYPE_MR				0x00
 #define MR_TYPE_FRMR				0x01
 #define MR_TYPE_DMA				0x03
@@ -1157,8 +1154,7 @@ void hns_roce_cleanup_srq_table(struct hns_roce_dev *hr_dev);
 void hns_roce_cleanup_xrcd_table(struct hns_roce_dev *hr_dev);
 
 int hns_roce_bitmap_alloc(struct hns_roce_bitmap *bitmap, unsigned long *obj);
-void hns_roce_bitmap_free(struct hns_roce_bitmap *bitmap, unsigned long obj,
-			 int rr);
+void hns_roce_bitmap_free(struct hns_roce_bitmap *bitmap, unsigned long obj);
 int hns_roce_bitmap_init(struct hns_roce_bitmap *bitmap, u32 num, u32 mask,
 			 u32 reserved_bot, u32 resetrved_top);
 void hns_roce_bitmap_cleanup(struct hns_roce_bitmap *bitmap);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 0c836cc..94214c1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -1200,7 +1200,7 @@ static int hns_roce_v1_dereg_mr(struct hns_roce_dev *hr_dev,
 		mr->key, jiffies_to_usecs(jiffies) - jiffies_to_usecs(start));
 
 	hns_roce_bitmap_free(&hr_dev->mr_table.mtpt_bitmap,
-			     key_to_hw_index(mr->key), 0);
+			     key_to_hw_index(mr->key));
 	hns_roce_mtr_destroy(hr_dev, &mr->pbl_mtr);
 	kfree(mr);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 8e6b1ae..ce3ceec 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -91,7 +91,7 @@ static int alloc_mr_key(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr)
 
 	return 0;
 err_free_bitmap:
-	hns_roce_bitmap_free(&hr_dev->mr_table.mtpt_bitmap, obj, BITMAP_NO_RR);
+	hns_roce_bitmap_free(&hr_dev->mr_table.mtpt_bitmap, obj);
 	return err;
 }
 
@@ -100,7 +100,7 @@ static void free_mr_key(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr)
 	unsigned long obj = key_to_hw_index(mr->key);
 
 	hns_roce_table_put(hr_dev, &hr_dev->mr_table.mtpt_table, obj);
-	hns_roce_bitmap_free(&hr_dev->mr_table.mtpt_bitmap, obj, BITMAP_NO_RR);
+	hns_roce_bitmap_free(&hr_dev->mr_table.mtpt_bitmap, obj);
 }
 
 static int alloc_mr_pbl(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr,
@@ -504,7 +504,7 @@ static void hns_roce_mw_free(struct hns_roce_dev *hr_dev,
 	}
 
 	hns_roce_bitmap_free(&hr_dev->mr_table.mtpt_bitmap,
-			     key_to_hw_index(mw->rkey), BITMAP_NO_RR);
+			     key_to_hw_index(mw->rkey));
 }
 
 static int hns_roce_mw_enable(struct hns_roce_dev *hr_dev,
diff --git a/drivers/infiniband/hw/hns/hns_roce_pd.c b/drivers/infiniband/hw/hns/hns_roce_pd.c
index a5813bf..25e52cd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_pd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_pd.c
@@ -41,7 +41,7 @@ static int hns_roce_pd_alloc(struct hns_roce_dev *hr_dev, unsigned long *pdn)
 
 static void hns_roce_pd_free(struct hns_roce_dev *hr_dev, unsigned long pdn)
 {
-	hns_roce_bitmap_free(&hr_dev->pd_bitmap, pdn, BITMAP_NO_RR);
+	hns_roce_bitmap_free(&hr_dev->pd_bitmap, pdn);
 }
 
 int hns_roce_init_pd_table(struct hns_roce_dev *hr_dev)
@@ -121,8 +121,7 @@ int hns_roce_uar_alloc(struct hns_roce_dev *hr_dev, struct hns_roce_uar *uar)
 
 void hns_roce_uar_free(struct hns_roce_dev *hr_dev, struct hns_roce_uar *uar)
 {
-	hns_roce_bitmap_free(&hr_dev->uar_table.bitmap, uar->logic_idx,
-			     BITMAP_NO_RR);
+	hns_roce_bitmap_free(&hr_dev->uar_table.bitmap, uar->logic_idx);
 }
 
 int hns_roce_init_uar_table(struct hns_roce_dev *hr_dev)
@@ -155,7 +154,7 @@ static int hns_roce_xrcd_alloc(struct hns_roce_dev *hr_dev, u32 *xrcdn)
 static void hns_roce_xrcd_free(struct hns_roce_dev *hr_dev,
 			       u32 xrcdn)
 {
-	hns_roce_bitmap_free(&hr_dev->xrcd_bitmap, xrcdn, BITMAP_NO_RR);
+	hns_roce_bitmap_free(&hr_dev->xrcd_bitmap, xrcdn);
 }
 
 int hns_roce_init_xrcd_table(struct hns_roce_dev *hr_dev)
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index d668051..6f2992f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -132,7 +132,7 @@ static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 err_put:
 	hns_roce_table_put(hr_dev, &srq_table->table, srq->srqn);
 err_out:
-	hns_roce_bitmap_free(&srq_table->bitmap, srq->srqn, BITMAP_NO_RR);
+	hns_roce_bitmap_free(&srq_table->bitmap, srq->srqn);
 
 	return ret;
 }
@@ -154,7 +154,7 @@ static void free_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 	wait_for_completion(&srq->free);
 
 	hns_roce_table_put(hr_dev, &srq_table->table, srq->srqn);
-	hns_roce_bitmap_free(&srq_table->bitmap, srq->srqn, BITMAP_NO_RR);
+	hns_roce_bitmap_free(&srq_table->bitmap, srq->srqn);
 }
 
 static int alloc_srq_idx(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
-- 
2.7.4

