Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE8843C7F1
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Oct 2021 12:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241526AbhJ0KsW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Oct 2021 06:48:22 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13981 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239765AbhJ0KsV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Oct 2021 06:48:21 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HfQKS0V0VzZcVY;
        Wed, 27 Oct 2021 18:43:56 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 27 Oct 2021 18:45:48 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 27 Oct 2021 18:45:48 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH v3 for-next] RDMA/hns: Add a new mmap implementation
Date:   Wed, 27 Oct 2021 18:41:29 +0800
Message-ID: <20211027104129.36902-1-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Chengchang Tang <tangchengchang@huawei.com>

Add a new implementation for mmap by using the new mmap entry API.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  23 ++++
 drivers/infiniband/hw/hns/hns_roce_main.c   | 139 ++++++++++++++++----
 include/rdma/ib_verbs.h                     |   8 ++
 3 files changed, 144 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index e5dadcd118ac..b624799624dc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -225,11 +225,24 @@ struct hns_roce_uar {
 	unsigned long	logic_idx;
 };
 
+enum hns_roce_mmap_type {
+	HNS_ROCE_MMAP_TYPE_DB = 1,
+	HNS_ROCE_MMAP_TYPE_TPTR,
+};
+
+struct hns_user_mmap_entry {
+	struct rdma_user_mmap_entry rdma_entry;
+	enum hns_roce_mmap_type mmap_type;
+	u64 address;
+};
+
 struct hns_roce_ucontext {
 	struct ib_ucontext	ibucontext;
 	struct hns_roce_uar	uar;
 	struct list_head	page_list;
 	struct mutex		page_mutex;
+	struct hns_user_mmap_entry *db_mmap_entry;
+	struct hns_user_mmap_entry *tptr_mmap_entry;
 };
 
 struct hns_roce_pd {
@@ -1050,6 +1063,12 @@ static inline struct hns_roce_srq *to_hr_srq(struct ib_srq *ibsrq)
 	return container_of(ibsrq, struct hns_roce_srq, ibsrq);
 }
 
+static inline struct hns_user_mmap_entry *to_hns_mmap(
+					struct rdma_user_mmap_entry *rdma_entry)
+{
+	return container_of(rdma_entry, struct hns_user_mmap_entry, rdma_entry);
+}
+
 static inline void hns_roce_write64_k(__le32 val[2], void __iomem *dest)
 {
 	writeq(*(u64 *)val, dest);
@@ -1260,4 +1279,8 @@ int hns_roce_init(struct hns_roce_dev *hr_dev);
 void hns_roce_exit(struct hns_roce_dev *hr_dev);
 int hns_roce_fill_res_cq_entry(struct sk_buff *msg,
 			       struct ib_cq *ib_cq);
+struct hns_user_mmap_entry *hns_roce_user_mmap_entry_insert(
+				struct ib_ucontext *ucontext,
+				u64 address, size_t length,
+				enum hns_roce_mmap_type mmap_type);
 #endif /* _HNS_ROCE_DEVICE_H */
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index b3595b6079b5..8630377ab99c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -292,6 +292,76 @@ static int hns_roce_modify_device(struct ib_device *ib_dev, int mask,
 	return 0;
 }
 
+struct hns_user_mmap_entry *hns_roce_user_mmap_entry_insert(
+				struct ib_ucontext *ucontext,
+				u64 address, size_t length,
+				enum hns_roce_mmap_type mmap_type)
+{
+	struct hns_user_mmap_entry *entry;
+	int ret;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return NULL;
+
+	entry->address = address;
+	entry->mmap_type = mmap_type;
+
+	ret = rdma_user_mmap_entry_insert_exact(
+			ucontext, &entry->rdma_entry, length,
+			mmap_type == HNS_ROCE_MMAP_TYPE_DB ? 0 : 1);
+	if (ret) {
+		kfree(entry);
+		return NULL;
+	}
+
+	return entry;
+}
+
+static void hns_roce_dealloc_uar_entry(struct hns_roce_ucontext *context)
+{
+	if (context->db_mmap_entry)
+		rdma_user_mmap_entry_remove(
+				&context->db_mmap_entry->rdma_entry);
+
+	if (context->tptr_mmap_entry)
+		rdma_user_mmap_entry_remove(
+				&context->tptr_mmap_entry->rdma_entry);
+}
+
+static int hns_roce_alloc_uar_entry(struct ib_ucontext *uctx)
+{
+	struct hns_roce_ucontext *context = to_hr_ucontext(uctx);
+	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->device);
+	u64 address;
+	int ret;
+
+	address = context->uar.pfn << PAGE_SHIFT;
+	context->db_mmap_entry =
+		hns_roce_user_mmap_entry_insert(uctx, address, PAGE_SIZE,
+						HNS_ROCE_MMAP_TYPE_DB);
+	if (!context->db_mmap_entry)
+		return -ENOMEM;
+
+	if (!hr_dev->tptr_dma_addr || !hr_dev->tptr_size)
+		return 0;
+
+	context->tptr_mmap_entry =
+		hns_roce_user_mmap_entry_insert(uctx, hr_dev->tptr_dma_addr,
+						hr_dev->tptr_size,
+						HNS_ROCE_MMAP_TYPE_TPTR);
+	if (!context->tptr_mmap_entry) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	return 0;
+
+err:
+	hns_roce_dealloc_uar_entry(context);
+	return ret;
+}
+
 static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 				   struct ib_udata *udata)
 {
@@ -310,6 +380,10 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 	if (ret)
 		goto error_fail_uar_alloc;
 
+	ret = hns_roce_alloc_uar_entry(uctx);
+	if (ret)
+		goto error_fail_uar_entry;
+
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
 	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB) {
 		INIT_LIST_HEAD(&context->page_list);
@@ -326,6 +400,9 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 	return 0;
 
 error_fail_copy_to_udata:
+	hns_roce_dealloc_uar_entry(context);
+
+error_fail_uar_entry:
 	ida_free(&hr_dev->uar_ida.ida, (int)context->uar.logic_idx);
 
 error_fail_uar_alloc:
@@ -337,39 +414,48 @@ static void hns_roce_dealloc_ucontext(struct ib_ucontext *ibcontext)
 	struct hns_roce_ucontext *context = to_hr_ucontext(ibcontext);
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibcontext->device);
 
+	hns_roce_dealloc_uar_entry(context);
+
 	ida_free(&hr_dev->uar_ida.ida, (int)context->uar.logic_idx);
 }
 
-static int hns_roce_mmap(struct ib_ucontext *context,
-			 struct vm_area_struct *vma)
+static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
 {
-	struct hns_roce_dev *hr_dev = to_hr_dev(context->device);
-
-	switch (vma->vm_pgoff) {
-	case 0:
-		return rdma_user_mmap_io(context, vma,
-					 to_hr_ucontext(context)->uar.pfn,
-					 PAGE_SIZE,
-					 pgprot_noncached(vma->vm_page_prot),
-					 NULL);
-
-	/* vm_pgoff: 1 -- TPTR */
-	case 1:
-		if (!hr_dev->tptr_dma_addr || !hr_dev->tptr_size)
-			return -EINVAL;
-		/*
-		 * FIXME: using io_remap_pfn_range on the dma address returned
-		 * by dma_alloc_coherent is totally wrong.
-		 */
-		return rdma_user_mmap_io(context, vma,
-					 hr_dev->tptr_dma_addr >> PAGE_SHIFT,
-					 hr_dev->tptr_size,
-					 vma->vm_page_prot,
-					 NULL);
+	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->device);
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct rdma_user_mmap_entry *rdma_entry;
+	struct hns_user_mmap_entry *entry;
+	phys_addr_t pfn;
+	pgprot_t prot;
+	int ret;
 
-	default:
+	rdma_entry = rdma_user_mmap_entry_get_pgoff(uctx, vma->vm_pgoff);
+	if (!rdma_entry) {
+		ibdev_err(ibdev, "Invalid entry vm_pgoff %lu.\n",
+			  vma->vm_pgoff);
 		return -EINVAL;
 	}
+
+	entry = to_hns_mmap(rdma_entry);
+	pfn = entry->address >> PAGE_SHIFT;
+	prot = vma->vm_page_prot;
+
+	if (entry->mmap_type != HNS_ROCE_MMAP_TYPE_TPTR)
+		prot = pgprot_noncached(prot);
+
+	ret = rdma_user_mmap_io(uctx, vma, pfn, rdma_entry->npages * PAGE_SIZE,
+				prot, rdma_entry);
+
+	rdma_user_mmap_entry_put(rdma_entry);
+
+	return ret;
+}
+
+static void hns_roce_free_mmap(struct rdma_user_mmap_entry *rdma_entry)
+{
+	struct hns_user_mmap_entry *entry = to_hns_mmap(rdma_entry);
+
+	kfree(entry);
 }
 
 static int hns_roce_port_immutable(struct ib_device *ib_dev, u32 port_num,
@@ -445,6 +531,7 @@ static const struct ib_device_ops hns_roce_dev_ops = {
 	.get_link_layer = hns_roce_get_link_layer,
 	.get_port_immutable = hns_roce_port_immutable,
 	.mmap = hns_roce_mmap,
+	.mmap_free = hns_roce_free_mmap,
 	.modify_device = hns_roce_modify_device,
 	.modify_qp = hns_roce_modify_qp,
 	.query_ah = hns_roce_query_ah,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 61c73adccbbd..301689d31438 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2914,6 +2914,14 @@ int rdma_user_mmap_entry_insert_range(struct ib_ucontext *ucontext,
 				      size_t length, u32 min_pgoff,
 				      u32 max_pgoff);
 
+static inline int rdma_user_mmap_entry_insert_exact(struct ib_ucontext *ucontext,
+				      struct rdma_user_mmap_entry *entry,
+				      size_t length, u32 pgoff)
+{
+	return rdma_user_mmap_entry_insert_range(ucontext, entry, length,
+						 pgoff, pgoff);
+}
+
 struct rdma_user_mmap_entry *
 rdma_user_mmap_entry_get_pgoff(struct ib_ucontext *ucontext,
 			       unsigned long pgoff);
-- 
2.33.0

