Return-Path: <linux-rdma+bounces-7788-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FA4A37BDC
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 08:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61CF33AC84A
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 07:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEFF194A7C;
	Mon, 17 Feb 2025 07:08:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545291885B4
	for <linux-rdma@vger.kernel.org>; Mon, 17 Feb 2025 07:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739776132; cv=none; b=me6fg+fe7ULHgTRs+FTzdHQqykfcRLmpm0Yvj4LUCZHn9+w0gPqasmYEV2NOQ7rjOPeyyQp26V+pzy3T3XsupYsD1HS+Vp2RTugYNuvMlx+iCpzhm/CuXGNDKg3yCN2mV802Vhnf0tFd5DOyaK+Dv9nROFFqRLUBbf57JrtQjNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739776132; c=relaxed/simple;
	bh=9Lm7cDRBvts196ursNNSQaBn5BSKlRwXFZ6WuNDfYy8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CuWyVGk3GM8Nv247bwSkIa66jNONYqIg6zSqIMyoQkjy+MT8TJwKlsaKgi7DtCmqbt00BHt/OC39E2krTtlxotQE1oxrrnWVevMh+FTWh9FRQAILnzVFbFgv/SpVfy6UqlxYCluIAtFZGcO1hYOfg4GWo/QvN+1ZPvQAvGwCzeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4YxDKp0PP2z1xxLw;
	Mon, 17 Feb 2025 15:09:18 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E7CF1400CB;
	Mon, 17 Feb 2025 15:08:47 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Feb 2025 15:08:47 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next 3/4] RDMA/hns: Fix HW doorbell UAF by adding delay-destruction mechanism
Date: Mon, 17 Feb 2025 15:01:22 +0800
Message-ID: <20250217070123.3171232-4-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250217070123.3171232-1-huangjunxian6@hisilicon.com>
References: <20250217070123.3171232-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100018.china.huawei.com (7.202.181.17)

When mailboxes for resource(QP/CQ/SRQ) destruction fail, it's unable
to notify HW about the destruction. In this case, driver will still
free the doorbells, while HW may still access them, thus leading to
a UAF.

Introduce a delay-destruction mechanism. When mailboxes for resource
destruction fail, the related buffer will not be freed in the normal
destruction flow. Instead, link the resource node to a list. Free
all buffers in the list when the device is uninited.

Fixes: b0969f83890b ("RDMA/hns: Do not destroy QP resources in the hw resetting phase")
Signed-off-by: wenglianfa <wenglianfa@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c     |  6 +-
 drivers/infiniband/hw/hns/hns_roce_db.c     | 91 +++++++++++++++------
 drivers/infiniband/hw/hns/hns_roce_device.h | 26 ++++--
 drivers/infiniband/hw/hns/hns_roce_main.c   |  6 ++
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 25 ++++++
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 11 ++-
 drivers/infiniband/hw/hns/hns_roce_srq.c    |  5 +-
 7 files changed, 134 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index dc49d35ec4ec..13bcf82939cd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -277,9 +277,11 @@ static void free_cq_db(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
 		uctx = rdma_udata_to_drv_context(udata,
 						 struct hns_roce_ucontext,
 						 ibucontext);
-		hns_roce_db_unmap_user(uctx, &hr_cq->db);
+		hns_roce_db_unmap_user(uctx, &hr_cq->db,
+				       hr_cq->delayed_destroy_flag);
 	} else {
-		hns_roce_free_db(hr_dev, &hr_cq->db);
+		hns_roce_free_db(hr_dev, &hr_cq->db,
+				 hr_cq->delayed_destroy_flag);
 	}
 }
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_db.c b/drivers/infiniband/hw/hns/hns_roce_db.c
index 5c4c0480832b..14dd32cd5594 100644
--- a/drivers/infiniband/hw/hns/hns_roce_db.c
+++ b/drivers/infiniband/hw/hns/hns_roce_db.c
@@ -12,6 +12,7 @@ int hns_roce_db_map_user(struct hns_roce_ucontext *context, unsigned long virt,
 {
 	unsigned long page_addr = virt & PAGE_MASK;
 	struct hns_roce_user_db_page *page;
+	struct ib_umem *umem;
 	unsigned int offset;
 	int ret = 0;
 
@@ -24,43 +25,65 @@ int hns_roce_db_map_user(struct hns_roce_ucontext *context, unsigned long virt,
 	page = kmalloc(sizeof(*page), GFP_KERNEL);
 	if (!page) {
 		ret = -ENOMEM;
-		goto out;
+		goto err_out;
 	}
 
 	refcount_set(&page->refcount, 1);
 	page->user_virt = page_addr;
-	page->umem = ib_umem_get(context->ibucontext.device, page_addr,
-				 PAGE_SIZE, 0);
-	if (IS_ERR(page->umem)) {
-		ret = PTR_ERR(page->umem);
-		kfree(page);
-		goto out;
+	page->db_node = kvzalloc(sizeof(*page->db_node), GFP_KERNEL);
+	if (!page->db_node) {
+		ret = -ENOMEM;
+		goto err_page;
+	}
+
+	umem = ib_umem_get(context->ibucontext.device, page_addr, PAGE_SIZE, 0);
+	if (IS_ERR(umem)) {
+		ret = PTR_ERR(umem);
+		goto err_dbnode;
 	}
 
+	page->db_node->umem = umem;
 	list_add(&page->list, &context->page_list);
 
 found:
 	offset = virt - page_addr;
-	db->dma = sg_dma_address(page->umem->sgt_append.sgt.sgl) + offset;
-	db->virt_addr = sg_virt(page->umem->sgt_append.sgt.sgl) + offset;
+	db->dma = sg_dma_address(page->db_node->umem->sgt_append.sgt.sgl) + offset;
+	db->virt_addr = sg_virt(page->db_node->umem->sgt_append.sgt.sgl) + offset;
 	db->u.user_page = page;
 	refcount_inc(&page->refcount);
+	mutex_unlock(&context->page_mutex);
+	return 0;
 
-out:
+err_dbnode:
+	kvfree(page->db_node);
+err_page:
+	kfree(page);
+err_out:
 	mutex_unlock(&context->page_mutex);
 
 	return ret;
 }
 
 void hns_roce_db_unmap_user(struct hns_roce_ucontext *context,
-			    struct hns_roce_db *db)
+			    struct hns_roce_db *db,
+			    bool delayed_unmap_flag)
 {
+	struct hns_roce_dev *hr_dev = to_hr_dev(context->ibucontext.device);
+	struct hns_roce_db_pg_node *db_node = db->u.user_page->db_node;
+
 	mutex_lock(&context->page_mutex);
 
+	db_node->delayed_unmap_flag |= delayed_unmap_flag;
+
 	refcount_dec(&db->u.user_page->refcount);
 	if (refcount_dec_if_one(&db->u.user_page->refcount)) {
 		list_del(&db->u.user_page->list);
-		ib_umem_release(db->u.user_page->umem);
+		if (db_node->delayed_unmap_flag) {
+			hns_roce_add_unfree_db(db_node, hr_dev);
+		} else {
+			ib_umem_release(db_node->umem);
+			kvfree(db_node);
+		}
 		kfree(db->u.user_page);
 	}
 
@@ -71,6 +94,8 @@ static struct hns_roce_db_pgdir *hns_roce_alloc_db_pgdir(
 					struct device *dma_device)
 {
 	struct hns_roce_db_pgdir *pgdir;
+	dma_addr_t db_dma;
+	u32 *page;
 
 	pgdir = kzalloc(sizeof(*pgdir), GFP_KERNEL);
 	if (!pgdir)
@@ -80,14 +105,24 @@ static struct hns_roce_db_pgdir *hns_roce_alloc_db_pgdir(
 		    HNS_ROCE_DB_PER_PAGE / HNS_ROCE_DB_TYPE_COUNT);
 	pgdir->bits[0] = pgdir->order0;
 	pgdir->bits[1] = pgdir->order1;
-	pgdir->page = dma_alloc_coherent(dma_device, PAGE_SIZE,
-					 &pgdir->db_dma, GFP_KERNEL);
-	if (!pgdir->page) {
-		kfree(pgdir);
-		return NULL;
-	}
+	pgdir->db_node = kvzalloc(sizeof(*pgdir->db_node), GFP_KERNEL);
+	if (!pgdir->db_node)
+		goto err_node;
+
+	page = dma_alloc_coherent(dma_device, PAGE_SIZE, &db_dma, GFP_KERNEL);
+	if (!page)
+		goto err_dma;
+
+	pgdir->db_node->kdb.page = page;
+	pgdir->db_node->kdb.db_dma = db_dma;
 
 	return pgdir;
+
+err_dma:
+	kvfree(pgdir->db_node);
+err_node:
+	kfree(pgdir);
+	return NULL;
 }
 
 static int hns_roce_alloc_db_from_pgdir(struct hns_roce_db_pgdir *pgdir,
@@ -114,8 +149,8 @@ static int hns_roce_alloc_db_from_pgdir(struct hns_roce_db_pgdir *pgdir,
 
 	db->u.pgdir	= pgdir;
 	db->index	= i;
-	db->db_record	= pgdir->page + db->index;
-	db->dma		= pgdir->db_dma  + db->index * HNS_ROCE_DB_UNIT_SIZE;
+	db->db_record = pgdir->db_node->kdb.page + db->index;
+	db->dma	= pgdir->db_node->kdb.db_dma + db->index * HNS_ROCE_DB_UNIT_SIZE;
 	db->order	= order;
 
 	return 0;
@@ -150,13 +185,17 @@ int hns_roce_alloc_db(struct hns_roce_dev *hr_dev, struct hns_roce_db *db,
 	return ret;
 }
 
-void hns_roce_free_db(struct hns_roce_dev *hr_dev, struct hns_roce_db *db)
+void hns_roce_free_db(struct hns_roce_dev *hr_dev, struct hns_roce_db *db,
+		      bool delayed_unmap_flag)
 {
+	struct hns_roce_db_pg_node *db_node = db->u.pgdir->db_node;
 	unsigned long o;
 	unsigned long i;
 
 	mutex_lock(&hr_dev->pgdir_mutex);
 
+	db_node->delayed_unmap_flag |= delayed_unmap_flag;
+
 	o = db->order;
 	i = db->index;
 
@@ -170,9 +209,15 @@ void hns_roce_free_db(struct hns_roce_dev *hr_dev, struct hns_roce_db *db)
 
 	if (bitmap_full(db->u.pgdir->order1,
 			HNS_ROCE_DB_PER_PAGE / HNS_ROCE_DB_TYPE_COUNT)) {
-		dma_free_coherent(hr_dev->dev, PAGE_SIZE, db->u.pgdir->page,
-				  db->u.pgdir->db_dma);
 		list_del(&db->u.pgdir->list);
+		if (db_node->delayed_unmap_flag) {
+			hns_roce_add_unfree_db(db_node, hr_dev);
+		} else {
+			dma_free_coherent(hr_dev->dev, PAGE_SIZE,
+					  db_node->kdb.page,
+					  db_node->kdb.db_dma);
+			kvfree(db_node);
+		}
 		kfree(db->u.pgdir);
 	}
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index e010fb3230a2..bcf85ec488fa 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -400,20 +400,29 @@ struct hns_roce_buf {
 	unsigned int			page_shift;
 };
 
+struct hns_roce_db_pg_node {
+	struct list_head list;
+	struct ib_umem *umem;
+	struct {
+		u32 *page;
+		dma_addr_t db_dma;
+	} kdb;
+	bool delayed_unmap_flag;
+};
+
 struct hns_roce_db_pgdir {
 	struct list_head	list;
 	DECLARE_BITMAP(order0, HNS_ROCE_DB_PER_PAGE);
 	DECLARE_BITMAP(order1, HNS_ROCE_DB_PER_PAGE / HNS_ROCE_DB_TYPE_COUNT);
 	unsigned long		*bits[HNS_ROCE_DB_TYPE_COUNT];
-	u32			*page;
-	dma_addr_t		db_dma;
+	struct hns_roce_db_pg_node *db_node;
 };
 
 struct hns_roce_user_db_page {
 	struct list_head	list;
-	struct ib_umem		*umem;
 	unsigned long		user_virt;
 	refcount_t		refcount;
+	struct hns_roce_db_pg_node *db_node;
 };
 
 struct hns_roce_db {
@@ -1048,6 +1057,8 @@ struct hns_roce_dev {
 	atomic64_t *dfx_cnt;
 	struct list_head mtr_unfree_list; /* list of unfree mtr on this dev */
 	struct mutex mtr_unfree_list_mutex; /* protect mtr_unfree_list */
+	struct list_head db_unfree_list; /* list of unfree db on this dev */
+	struct mutex db_unfree_list_mutex; /* protect db_unfree_list */
 };
 
 static inline struct hns_roce_dev *to_hr_dev(struct ib_device *ib_dev)
@@ -1299,10 +1310,12 @@ int hns_roce_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata);
 int hns_roce_db_map_user(struct hns_roce_ucontext *context, unsigned long virt,
 			 struct hns_roce_db *db);
 void hns_roce_db_unmap_user(struct hns_roce_ucontext *context,
-			    struct hns_roce_db *db);
+			    struct hns_roce_db *db,
+			    bool delayed_unmap_flag);
 int hns_roce_alloc_db(struct hns_roce_dev *hr_dev, struct hns_roce_db *db,
 		      int order);
-void hns_roce_free_db(struct hns_roce_dev *hr_dev, struct hns_roce_db *db);
+void hns_roce_free_db(struct hns_roce_dev *hr_dev, struct hns_roce_db *db,
+		      bool delayed_unmap_flag);
 
 void hns_roce_cq_completion(struct hns_roce_dev *hr_dev, u32 cqn);
 void hns_roce_cq_event(struct hns_roce_dev *hr_dev, u32 cqn, int event_type);
@@ -1319,6 +1332,9 @@ int hns_roce_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ib_qp);
 int hns_roce_fill_res_qp_entry_raw(struct sk_buff *msg, struct ib_qp *ib_qp);
 int hns_roce_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr);
 int hns_roce_fill_res_mr_entry_raw(struct sk_buff *msg, struct ib_mr *ib_mr);
+void hns_roce_add_unfree_db(struct hns_roce_db_pg_node *db_node,
+			    struct hns_roce_dev *hr_dev);
+void hns_roce_free_unfree_db(struct hns_roce_dev *hr_dev);
 void hns_roce_add_unfree_mtr(struct hns_roce_dev *hr_dev,
 			     struct hns_roce_mtr *mtr);
 void hns_roce_free_unfree_mtr(struct hns_roce_dev *hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index b5ece1bedc11..5840340e0f14 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -953,6 +953,7 @@ static void hns_roce_teardown_hca(struct hns_roce_dev *hr_dev)
 	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB)
 		mutex_destroy(&hr_dev->pgdir_mutex);
 
+	mutex_destroy(&hr_dev->db_unfree_list_mutex);
 	mutex_destroy(&hr_dev->mtr_unfree_list_mutex);
 }
 
@@ -971,6 +972,9 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 	INIT_LIST_HEAD(&hr_dev->mtr_unfree_list);
 	mutex_init(&hr_dev->mtr_unfree_list_mutex);
 
+	INIT_LIST_HEAD(&hr_dev->db_unfree_list);
+	mutex_init(&hr_dev->db_unfree_list_mutex);
+
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
 	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB) {
 		INIT_LIST_HEAD(&hr_dev->pgdir_list);
@@ -1010,6 +1014,7 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
 	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB)
 		mutex_destroy(&hr_dev->pgdir_mutex);
+	mutex_destroy(&hr_dev->db_unfree_list_mutex);
 	mutex_destroy(&hr_dev->mtr_unfree_list_mutex);
 
 	return ret;
@@ -1185,6 +1190,7 @@ void hns_roce_exit(struct hns_roce_dev *hr_dev)
 
 	if (hr_dev->hw->hw_exit)
 		hr_dev->hw->hw_exit(hr_dev);
+	hns_roce_free_unfree_db(hr_dev);
 	hns_roce_free_unfree_mtr(hr_dev);
 	hns_roce_teardown_hca(hr_dev);
 	hns_roce_cleanup_hem(hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 228a3512e1a0..226a785e1fc4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -1246,3 +1246,28 @@ void hns_roce_free_unfree_mtr(struct hns_roce_dev *hr_dev)
 	}
 	mutex_unlock(&hr_dev->mtr_unfree_list_mutex);
 }
+
+void hns_roce_add_unfree_db(struct hns_roce_db_pg_node *db_node,
+			    struct hns_roce_dev *hr_dev)
+{
+	mutex_lock(&hr_dev->db_unfree_list_mutex);
+	list_add_tail(&db_node->list, &hr_dev->db_unfree_list);
+	mutex_unlock(&hr_dev->db_unfree_list_mutex);
+}
+
+void hns_roce_free_unfree_db(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_db_pg_node *pos, *next;
+
+	mutex_lock(&hr_dev->db_unfree_list_mutex);
+	list_for_each_entry_safe(pos, next, &hr_dev->db_unfree_list, list) {
+		list_del(&pos->list);
+		if (pos->umem)
+			ib_umem_release(pos->umem);
+		else
+			dma_free_coherent(hr_dev->dev, PAGE_SIZE,
+					  pos->kdb.page, pos->kdb.db_dma);
+		kvfree(pos);
+	}
+	mutex_unlock(&hr_dev->db_unfree_list_mutex);
+}
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 91c605f67dca..66854f9b64ad 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -906,7 +906,7 @@ static int alloc_user_qp_db(struct hns_roce_dev *hr_dev,
 
 err_sdb:
 	if (hr_qp->en_flags & HNS_ROCE_QP_CAP_SQ_RECORD_DB)
-		hns_roce_db_unmap_user(uctx, &hr_qp->sdb);
+		hns_roce_db_unmap_user(uctx, &hr_qp->sdb, false);
 err_out:
 	return ret;
 }
@@ -988,14 +988,17 @@ static void free_qp_db(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 
 	if (udata) {
 		if (hr_qp->en_flags & HNS_ROCE_QP_CAP_RQ_RECORD_DB)
-			hns_roce_db_unmap_user(uctx, &hr_qp->rdb);
+			hns_roce_db_unmap_user(uctx, &hr_qp->rdb,
+					       hr_qp->delayed_destroy_flag);
 		if (hr_qp->en_flags & HNS_ROCE_QP_CAP_SQ_RECORD_DB)
-			hns_roce_db_unmap_user(uctx, &hr_qp->sdb);
+			hns_roce_db_unmap_user(uctx, &hr_qp->sdb,
+					       hr_qp->delayed_destroy_flag);
 		if (hr_qp->en_flags & HNS_ROCE_QP_CAP_DIRECT_WQE)
 			qp_user_mmap_entry_remove(hr_qp);
 	} else {
 		if (hr_qp->en_flags & HNS_ROCE_QP_CAP_RQ_RECORD_DB)
-			hns_roce_free_db(hr_dev, &hr_qp->rdb);
+			hns_roce_free_db(hr_dev, &hr_qp->rdb,
+					 hr_qp->delayed_destroy_flag);
 	}
 }
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 848a82395185..a39f07f44356 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -426,9 +426,10 @@ static void free_srq_db(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 		uctx = rdma_udata_to_drv_context(udata,
 						 struct hns_roce_ucontext,
 						 ibucontext);
-		hns_roce_db_unmap_user(uctx, &srq->rdb);
+		hns_roce_db_unmap_user(uctx, &srq->rdb,
+				       srq->delayed_destroy_flag);
 	} else {
-		hns_roce_free_db(hr_dev, &srq->rdb);
+		hns_roce_free_db(hr_dev, &srq->rdb, srq->delayed_destroy_flag);
 	}
 }
 
-- 
2.33.0


