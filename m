Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D144264FEE
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 03:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfGKBfs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 21:35:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40494 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727619AbfGKBfs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 10 Jul 2019 21:35:48 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C54A6835F28885497804;
        Thu, 11 Jul 2019 09:35:45 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Thu, 11 Jul 2019 09:35:34 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-rc] RDMA/hns: Fix sg offset non-zero issue
Date:   Thu, 11 Jul 2019 09:32:17 +0800
Message-ID: <1562808737-45723-1-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

When run perftest in many times, the system will report a BUG as follows:

[ 2312.559759] BUG: Bad rss-counter state mm:(____ptrval____) idx:0 val:-1
[ 2312.574803] BUG: Bad rss-counter state mm:(____ptrval____) idx:1 val:1

We tested with different kernel version and found it started from the the
following commit:

commit d10bcf947a3e ("RDMA/umem: Combine contiguous PAGE_SIZE regions in
SGEs")

In this commit, the sg->offset is always 0 when sg_set_page() is called in
ib_umem_get() and the drivers are not allowed to change the sgl, otherwise
it will get bad page descriptor when unfolding SGEs in __ib_umem_release()
as sg_page_count() will get wrong result while sgl->offset is not 0.

However, there is a weird sgl usage in the current hns driver, the driver
modified sg->offset after calling ib_umem_get(), which caused we iterate
past the wrong number of pages in for_each_sg_page iterator.

This patch fixes it by correcting the non-standard sgl usage found in the
hns_roce_db_map_user() function.

Fixes: 0425e3e6e0c7 ("RDMA/hns: Support flush cqe for hip08 in kernel space")
Signed-off-by: Xi Wang <wangxi11@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_db.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_db.c b/drivers/infiniband/hw/hns/hns_roce_db.c
index 0c6c1fe..d60453e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_db.c
+++ b/drivers/infiniband/hw/hns/hns_roce_db.c
@@ -12,13 +12,15 @@ int hns_roce_db_map_user(struct hns_roce_ucontext *context,
 			 struct ib_udata *udata, unsigned long virt,
 			 struct hns_roce_db *db)
 {
+	unsigned long page_addr = virt & PAGE_MASK;
 	struct hns_roce_user_db_page *page;
+	unsigned int offset;
 	int ret = 0;
 
 	mutex_lock(&context->page_mutex);
 
 	list_for_each_entry(page, &context->page_list, list)
-		if (page->user_virt == (virt & PAGE_MASK))
+		if (page->user_virt == page_addr)
 			goto found;
 
 	page = kmalloc(sizeof(*page), GFP_KERNEL);
@@ -28,8 +30,8 @@ int hns_roce_db_map_user(struct hns_roce_ucontext *context,
 	}
 
 	refcount_set(&page->refcount, 1);
-	page->user_virt = (virt & PAGE_MASK);
-	page->umem = ib_umem_get(udata, virt & PAGE_MASK, PAGE_SIZE, 0, 0);
+	page->user_virt = page_addr;
+	page->umem = ib_umem_get(udata, page_addr, PAGE_SIZE, 0, 0);
 	if (IS_ERR(page->umem)) {
 		ret = PTR_ERR(page->umem);
 		kfree(page);
@@ -39,10 +41,9 @@ int hns_roce_db_map_user(struct hns_roce_ucontext *context,
 	list_add(&page->list, &context->page_list);
 
 found:
-	db->dma = sg_dma_address(page->umem->sg_head.sgl) +
-		  (virt & ~PAGE_MASK);
-	page->umem->sg_head.sgl->offset = virt & ~PAGE_MASK;
-	db->virt_addr = sg_virt(page->umem->sg_head.sgl);
+	offset = virt - page_addr;
+	db->dma = sg_dma_address(page->umem->sg_head.sgl) + offset;
+	db->virt_addr = sg_virt(page->umem->sg_head.sgl) + offset;
 	db->u.user_page = page;
 	refcount_inc(&page->refcount);
 
-- 
1.9.1

