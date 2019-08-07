Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC9F78499E
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 12:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfHGKeN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 06:34:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfHGKeN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Aug 2019 06:34:13 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A10932086D;
        Wed,  7 Aug 2019 10:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565174049;
        bh=mkn85s+KG+VNErgYVWUR5P+waovEP8OYaAEUK6zrxoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T8LmHWlxkQy66UTul+E2DZePtnhkeGjzUhgmqn7lbfmAWI6uNpTss6gsckdrnFR5P
         /Dz4Ov3F7F1S8q0oDo8LC83eZLyzYZnZQpJ1Zyn1cJRSg/sDh2LkgPbte0Vk+IVJxc
         sNBCLMfusW8ZfRMlavYSXtmZFp2wM4tga6vpFh3k=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: [PATCH rdma-next 1/6] RDMA: Embed umem within core MR
Date:   Wed,  7 Aug 2019 13:33:58 +0300
Message-Id: <20190807103403.8102-2-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190807103403.8102-1-leon@kernel.org>
References: <20190807103403.8102-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Erez Alfasi <ereza@mellanox.com>

User memory regions (umems) are being handled and
managed in core level, therefore they should be
placed within struct ib_mr.

This patch is moving umems from vendor-level MR's
into struct ib_mr.

Signed-off-by: Erez Alfasi <ereza@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c     |  4 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h     |  1 -
 drivers/infiniband/hw/cxgb3/iwch_provider.c  | 15 +++----
 drivers/infiniband/hw/cxgb3/iwch_provider.h  |  1 -
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h       |  1 -
 drivers/infiniband/hw/cxgb4/mem.c            | 13 +++---
 drivers/infiniband/hw/efa/efa.h              |  1 -
 drivers/infiniband/hw/efa/efa_verbs.c        | 19 +++++----
 drivers/infiniband/hw/hns/hns_roce_device.h  |  1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c   |  7 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c   |  3 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c      | 42 +++++++++----------
 drivers/infiniband/hw/i40iw/i40iw_verbs.c    |  8 ++--
 drivers/infiniband/hw/i40iw/i40iw_verbs.h    |  1 -
 drivers/infiniband/hw/mlx4/mlx4_ib.h         |  1 -
 drivers/infiniband/hw/mlx4/mr.c              | 43 ++++++++++----------
 drivers/infiniband/hw/mlx5/mlx5_ib.h         |  5 +--
 drivers/infiniband/hw/mlx5/mr.c              | 36 ++++++++--------
 drivers/infiniband/hw/mlx5/odp.c             | 22 +++++-----
 drivers/infiniband/hw/mthca/mthca_provider.c | 17 ++++----
 drivers/infiniband/hw/mthca/mthca_provider.h |  1 -
 drivers/infiniband/hw/ocrdma/ocrdma.h        |  1 -
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  | 12 +++---
 drivers/infiniband/hw/qedr/qedr.h            |  1 -
 drivers/infiniband/hw/qedr/verbs.c           | 12 +++---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h    |  1 -
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c |  8 ++--
 include/rdma/ib_verbs.h                      |  1 +
 28 files changed, 137 insertions(+), 141 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 098ab883733e..5fcf8626f43e 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3333,7 +3333,7 @@ int bnxt_re_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 		mr->npages = 0;
 		mr->pages = NULL;
 	}
-	ib_umem_release(mr->ib_umem);
+	ib_umem_release(mr->ib_mr.umem);
 
 	kfree(mr);
 	atomic_dec(&rdev->mr_count);
@@ -3536,7 +3536,7 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 		rc = -EFAULT;
 		goto free_mrw;
 	}
-	mr->ib_umem = umem;
+	mr->ib_mr.umem = umem;
 
 	mr->qplib_mr.va = virt_addr;
 	umem_pgs = ib_umem_page_count(umem);
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 31662b1ee35a..422d56610042 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -109,7 +109,6 @@ struct bnxt_re_cq {
 struct bnxt_re_mr {
 	struct bnxt_re_dev	*rdev;
 	struct ib_mr		ib_mr;
-	struct ib_umem		*ib_umem;
 	struct bnxt_qplib_mrw	qplib_mr;
 	u32			npages;
 	u64			*pages;
diff --git a/drivers/infiniband/hw/cxgb3/iwch_provider.c b/drivers/infiniband/hw/cxgb3/iwch_provider.c
index e775c1a1a450..7a2977eb79b3 100644
--- a/drivers/infiniband/hw/cxgb3/iwch_provider.c
+++ b/drivers/infiniband/hw/cxgb3/iwch_provider.c
@@ -346,7 +346,7 @@ static int iwch_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 	xa_erase_irq(&rhp->mrs, mmid);
 	if (mhp->kva)
 		kfree((void *) (unsigned long) mhp->kva);
-	ib_umem_release(mhp->umem);
+	ib_umem_release(mhp->ibmr.umem);
 	pr_debug("%s mmid 0x%x ptr %p\n", __func__, mmid, mhp);
 	kfree(mhp);
 	return 0;
@@ -451,16 +451,16 @@ static struct ib_mr *iwch_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 
 	mhp->rhp = rhp;
 
-	mhp->umem = ib_umem_get(udata, start, length, acc, 0);
-	if (IS_ERR(mhp->umem)) {
-		err = PTR_ERR(mhp->umem);
+	mhp->ibmr.umem = ib_umem_get(udata, start, length, acc, 0);
+	if (IS_ERR(mhp->ibmr.umem)) {
+		err = PTR_ERR(mhp->ibmr.umem);
 		kfree(mhp);
 		return ERR_PTR(err);
 	}
 
 	shift = PAGE_SHIFT;
 
-	n = ib_umem_num_pages(mhp->umem);
+	n = ib_umem_num_pages(mhp->ibmr.umem);
 
 	err = iwch_alloc_pbl(mhp, n);
 	if (err)
@@ -474,7 +474,8 @@ static struct ib_mr *iwch_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 
 	i = n = 0;
 
-	for_each_sg_dma_page(mhp->umem->sg_head.sgl, &sg_iter, mhp->umem->nmap, 0) {
+	for_each_sg_dma_page(mhp->ibmr.umem->sg_head.sgl, &sg_iter,
+			     mhp->ibmr.umem->nmap, 0) {
 		pages[i++] = cpu_to_be64(sg_page_iter_dma_address(&sg_iter));
 		if (i == PAGE_SIZE / sizeof(*pages)) {
 			err = iwch_write_pbl(mhp, pages, i, n);
@@ -523,7 +524,7 @@ static struct ib_mr *iwch_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	iwch_free_pbl(mhp);
 
 err:
-	ib_umem_release(mhp->umem);
+	ib_umem_release(mhp->ibmr.umem);
 	kfree(mhp);
 	return ERR_PTR(err);
 }
diff --git a/drivers/infiniband/hw/cxgb3/iwch_provider.h b/drivers/infiniband/hw/cxgb3/iwch_provider.h
index 8adbe9658935..622aae5a3a9a 100644
--- a/drivers/infiniband/hw/cxgb3/iwch_provider.h
+++ b/drivers/infiniband/hw/cxgb3/iwch_provider.h
@@ -73,7 +73,6 @@ struct tpt_attributes {
 
 struct iwch_mr {
 	struct ib_mr ibmr;
-	struct ib_umem *umem;
 	struct iwch_dev *rhp;
 	u64 kva;
 	struct tpt_attributes attr;
diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index 7d06b0f8d49a..2ff535edc3aa 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -394,7 +394,6 @@ struct tpt_attributes {
 
 struct c4iw_mr {
 	struct ib_mr ibmr;
-	struct ib_umem *umem;
 	struct c4iw_dev *rhp;
 	struct sk_buff *dereg_skb;
 	u64 kva;
diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb4/mem.c
index aa772ee0706f..16d7e153ff32 100644
--- a/drivers/infiniband/hw/cxgb4/mem.c
+++ b/drivers/infiniband/hw/cxgb4/mem.c
@@ -537,13 +537,13 @@ struct ib_mr *c4iw_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 
 	mhp->rhp = rhp;
 
-	mhp->umem = ib_umem_get(udata, start, length, acc, 0);
-	if (IS_ERR(mhp->umem))
+	mhp->ibmr.umem = ib_umem_get(udata, start, length, acc, 0);
+	if (IS_ERR(mhp->ibmr.umem))
 		goto err_free_skb;
 
 	shift = PAGE_SHIFT;
 
-	n = ib_umem_num_pages(mhp->umem);
+	n = ib_umem_num_pages(mhp->ibmr.umem);
 	err = alloc_pbl(mhp, n);
 	if (err)
 		goto err_umem_release;
@@ -556,7 +556,8 @@ struct ib_mr *c4iw_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 
 	i = n = 0;
 
-	for_each_sg_dma_page(mhp->umem->sg_head.sgl, &sg_iter, mhp->umem->nmap, 0) {
+	for_each_sg_dma_page(mhp->ibmr.umem->sg_head.sgl, &sg_iter,
+			     mhp->ibmr.umem->nmap, 0) {
 		pages[i++] = cpu_to_be64(sg_page_iter_dma_address(&sg_iter));
 		if (i == PAGE_SIZE / sizeof(*pages)) {
 			err = write_pbl(&mhp->rhp->rdev, pages,
@@ -596,7 +597,7 @@ struct ib_mr *c4iw_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	c4iw_pblpool_free(&mhp->rhp->rdev, mhp->attr.pbl_addr,
 			      mhp->attr.pbl_size << 3);
 err_umem_release:
-	ib_umem_release(mhp->umem);
+	ib_umem_release(mhp->ibmr.umem);
 err_free_skb:
 	kfree_skb(mhp->dereg_skb);
 err_free_wr_wait:
@@ -808,7 +809,7 @@ int c4iw_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 				  mhp->attr.pbl_size << 3);
 	if (mhp->kva)
 		kfree((void *) (unsigned long) mhp->kva);
-	ib_umem_release(mhp->umem);
+	ib_umem_release(mhp->ibmr.umem);
 	pr_debug("mmid 0x%x ptr %p\n", mmid, mhp);
 	c4iw_put_wr_wait(mhp->wr_waitp);
 	kfree(mhp);
diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 2283e432693e..b965827e9bf8 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -83,7 +83,6 @@ struct efa_pd {
 
 struct efa_mr {
 	struct ib_mr ibmr;
-	struct ib_umem *umem;
 };
 
 struct efa_cq {
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 32d3b3deabce..c489957b0d50 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1343,7 +1343,8 @@ static int efa_create_inline_pbl(struct efa_dev *dev, struct efa_mr *mr,
 	int err;
 
 	params->inline_pbl = 1;
-	err = umem_to_page_list(dev, mr->umem, params->pbl.inline_pbl_array,
+	err = umem_to_page_list(dev, mr->ibmr.umem,
+				params->pbl.inline_pbl_array,
 				params->page_num, params->page_shift);
 	if (err)
 		return err;
@@ -1361,7 +1362,7 @@ static int efa_create_pbl(struct efa_dev *dev,
 {
 	int err;
 
-	err = pbl_create(dev, pbl, mr->umem, params->page_num,
+	err = pbl_create(dev, pbl, mr->ibmr.umem, params->page_num,
 			 params->page_shift);
 	if (err) {
 		ibdev_dbg(&dev->ibdev, "Failed to create pbl[%d]\n", err);
@@ -1423,9 +1424,9 @@ struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 		goto err_out;
 	}
 
-	mr->umem = ib_umem_get(udata, start, length, access_flags, 0);
-	if (IS_ERR(mr->umem)) {
-		err = PTR_ERR(mr->umem);
+	mr->ibmr.umem = ib_umem_get(udata, start, length, access_flags, 0);
+	if (IS_ERR(mr->ibmr.umem)) {
+		err = PTR_ERR(mr->ibmr.umem);
 		ibdev_dbg(&dev->ibdev,
 			  "Failed to pin and map user space memory[%d]\n", err);
 		goto err_free;
@@ -1436,7 +1437,7 @@ struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 	params.mr_length_in_bytes = length;
 	params.permissions = access_flags & 0x1;
 
-	pg_sz = ib_umem_find_best_pgsz(mr->umem,
+	pg_sz = ib_umem_find_best_pgsz(mr->ibmr.umem,
 				       dev->dev_attr.page_size_cap,
 				       virt_addr);
 	if (!pg_sz) {
@@ -1483,7 +1484,7 @@ struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 	return &mr->ibmr;
 
 err_unmap:
-	ib_umem_release(mr->umem);
+	ib_umem_release(mr->ibmr.umem);
 err_free:
 	kfree(mr);
 err_out:
@@ -1500,13 +1501,13 @@ int efa_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 
 	ibdev_dbg(&dev->ibdev, "Deregister mr[%d]\n", ibmr->lkey);
 
-	if (mr->umem) {
+	if (mr->ibmr.umem) {
 		params.l_key = mr->ibmr.lkey;
 		err = efa_com_dereg_mr(&dev->edev, &params);
 		if (err)
 			return err;
 	}
-	ib_umem_release(mr->umem);
+	ib_umem_release(mr->ibmr.umem);
 
 	kfree(mr);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index b39497a13b61..1d9b02195101 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -379,7 +379,6 @@ struct hns_roce_mw {
 
 struct hns_roce_mr {
 	struct ib_mr		ibmr;
-	struct ib_umem		*umem;
 	u64			iova; /* MR's virtual orignal addr */
 	u64			size; /* Address range of MR */
 	u32			key; /* Key of MR */
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 0ff5f9617639..059f51d35c88 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -1156,7 +1156,7 @@ static int hns_roce_v1_dereg_mr(struct hns_roce_dev *hr_dev,
 		mr->key, jiffies_to_usecs(jiffies) - jiffies_to_usecs(start));
 
 	if (mr->size != ~0ULL) {
-		npages = ib_umem_page_count(mr->umem);
+		npages = ib_umem_page_count(mr->ibmr.umem);
 		dma_free_coherent(dev, npages * 8, mr->pbl_buf,
 				  mr->pbl_dma_addr);
 	}
@@ -1164,7 +1164,7 @@ static int hns_roce_v1_dereg_mr(struct hns_roce_dev *hr_dev,
 	hns_roce_bitmap_free(&hr_dev->mr_table.mtpt_bitmap,
 			     key_to_hw_index(mr->key), 0);
 
-	ib_umem_release(mr->umem);
+	ib_umem_release(mr->ibmr.umem);
 
 	kfree(mr);
 
@@ -1892,7 +1892,8 @@ static int hns_roce_v1_write_mtpt(void *mb_buf, struct hns_roce_mr *mr,
 		return -ENOMEM;
 
 	i = 0;
-	for_each_sg_dma_page(mr->umem->sg_head.sgl, &sg_iter, mr->umem->nmap, 0) {
+	for_each_sg_dma_page(mr->ibmr.umem->sg_head.sgl, &sg_iter,
+			     mr->ibmr.umem->nmap, 0) {
 		pages[i] = ((u64)sg_page_iter_dma_address(&sg_iter)) >> 12;
 
 		/* Directly record to MTPT table firstly 7 entry */
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 59f88bf09952..2a0624f346f1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2147,7 +2147,8 @@ static int set_mtpt_pbl(struct hns_roce_v2_mpt_entry *mpt_entry,
 		return -ENOMEM;
 
 	i = 0;
-	for_each_sg_dma_page(mr->umem->sg_head.sgl, &sg_iter, mr->umem->nmap, 0) {
+	for_each_sg_dma_page(mr->ibmr.umem->sg_head.sgl, &sg_iter,
+			     mr->ibmr.umem->nmap, 0) {
 		page_addr = sg_page_iter_dma_address(&sg_iter);
 		pages[i] = page_addr >> 6;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 0cfa94605f77..34fa89a49f35 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -716,7 +716,7 @@ static void hns_roce_mr_free(struct hns_roce_dev *hr_dev,
 
 	if (mr->size != ~0ULL) {
 		if (mr->type == MR_TYPE_MR)
-			npages = ib_umem_page_count(mr->umem);
+			npages = ib_umem_page_count(mr->ibmr.umem);
 
 		if (!hr_dev->caps.pbl_hop_num)
 			dma_free_coherent(dev,
@@ -1005,7 +1005,7 @@ struct ib_mr *hns_roce_get_dma_mr(struct ib_pd *pd, int acc)
 		goto err_mr;
 
 	mr->ibmr.rkey = mr->ibmr.lkey = mr->key;
-	mr->umem = NULL;
+	mr->ibmr.umem = NULL;
 
 	return &mr->ibmr;
 
@@ -1144,13 +1144,13 @@ struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
-	mr->umem = ib_umem_get(udata, start, length, access_flags, 0);
-	if (IS_ERR(mr->umem)) {
-		ret = PTR_ERR(mr->umem);
+	mr->ibmr.umem = ib_umem_get(udata, start, length, access_flags, 0);
+	if (IS_ERR(mr->ibmr.umem)) {
+		ret = PTR_ERR(mr->ibmr.umem);
 		goto err_free;
 	}
 
-	n = ib_umem_page_count(mr->umem);
+	n = ib_umem_page_count(mr->ibmr.umem);
 
 	if (!hr_dev->caps.pbl_hop_num) {
 		if (n > HNS_ROCE_MAX_MTPT_PBL_NUM) {
@@ -1183,7 +1183,7 @@ struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (ret)
 		goto err_umem;
 
-	ret = hns_roce_ib_umem_write_mr(hr_dev, mr, mr->umem);
+	ret = hns_roce_ib_umem_write_mr(hr_dev, mr, mr->ibmr.umem);
 	if (ret)
 		goto err_mr;
 
@@ -1199,7 +1199,7 @@ struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	hns_roce_mr_free(hr_dev, mr);
 
 err_umem:
-	ib_umem_release(mr->umem);
+	ib_umem_release(mr->ibmr.umem);
 
 err_free:
 	kfree(mr);
@@ -1219,7 +1219,7 @@ static int rereg_mr_trans(struct ib_mr *ibmr, int flags,
 	int ret;
 
 	if (mr->size != ~0ULL) {
-		npages = ib_umem_page_count(mr->umem);
+		npages = ib_umem_page_count(mr->ibmr.umem);
 
 		if (hr_dev->caps.pbl_hop_num)
 			hns_roce_mhop_free(hr_dev, mr);
@@ -1227,15 +1227,15 @@ static int rereg_mr_trans(struct ib_mr *ibmr, int flags,
 			dma_free_coherent(dev, npages * 8,
 					  mr->pbl_buf, mr->pbl_dma_addr);
 	}
-	ib_umem_release(mr->umem);
+	ib_umem_release(mr->ibmr.umem);
 
-	mr->umem = ib_umem_get(udata, start, length, mr_access_flags, 0);
-	if (IS_ERR(mr->umem)) {
-		ret = PTR_ERR(mr->umem);
-		mr->umem = NULL;
+	mr->ibmr.umem = ib_umem_get(udata, start, length, mr_access_flags, 0);
+	if (IS_ERR(mr->ibmr.umem)) {
+		ret = PTR_ERR(mr->ibmr.umem);
+		mr->ibmr.umem = NULL;
 		return -ENOMEM;
 	}
-	npages = ib_umem_page_count(mr->umem);
+	npages = ib_umem_page_count(mr->ibmr.umem);
 
 	if (hr_dev->caps.pbl_hop_num) {
 		ret = hns_roce_mhop_alloc(hr_dev, npages, mr);
@@ -1258,10 +1258,10 @@ static int rereg_mr_trans(struct ib_mr *ibmr, int flags,
 		goto release_umem;
 
 
-	ret = hns_roce_ib_umem_write_mr(hr_dev, mr, mr->umem);
+	ret = hns_roce_ib_umem_write_mr(hr_dev, mr, mr->ibmr.umem);
 	if (ret) {
 		if (mr->size != ~0ULL) {
-			npages = ib_umem_page_count(mr->umem);
+			npages = ib_umem_page_count(mr->ibmr.umem);
 
 			if (hr_dev->caps.pbl_hop_num)
 				hns_roce_mhop_free(hr_dev, mr);
@@ -1277,7 +1277,7 @@ static int rereg_mr_trans(struct ib_mr *ibmr, int flags,
 	return 0;
 
 release_umem:
-	ib_umem_release(mr->umem);
+	ib_umem_release(mr->ibmr.umem);
 	return ret;
 
 }
@@ -1336,7 +1336,7 @@ int hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start, u64 length,
 	ret = hns_roce_sw2hw_mpt(hr_dev, mailbox, mtpt_idx);
 	if (ret) {
 		dev_err(dev, "SW2HW_MPT failed (%d)\n", ret);
-		ib_umem_release(mr->umem);
+		ib_umem_release(mr->ibmr.umem);
 		goto free_cmd_mbox;
 	}
 
@@ -1365,7 +1365,7 @@ int hns_roce_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	} else {
 		hns_roce_mr_free(hr_dev, mr);
 
-		ib_umem_release(mr->umem);
+		ib_umem_release(mr->ibmr.umem);
 		kfree(mr);
 	}
 
@@ -1411,7 +1411,7 @@ struct ib_mr *hns_roce_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 		goto err_mr;
 
 	mr->ibmr.rkey = mr->ibmr.lkey = mr->key;
-	mr->umem = NULL;
+	mr->ibmr.umem = NULL;
 
 	return &mr->ibmr;
 
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index d169a8031375..a2b91319f62c 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -1322,7 +1322,7 @@ static void i40iw_copy_user_pgaddrs(struct i40iw_mr *iwmr,
 				    u64 *pbl,
 				    enum i40iw_pble_level level)
 {
-	struct ib_umem *region = iwmr->region;
+	struct ib_umem *region = iwmr->ibmr.umem;
 	struct i40iw_pbl *iwpbl = &iwmr->iwpbl;
 	struct i40iw_pble_alloc *palloc = &iwpbl->pble_alloc;
 	struct i40iw_pble_info *pinfo;
@@ -1791,7 +1791,7 @@ static struct ib_mr *i40iw_reg_user_mr(struct ib_pd *pd,
 
 	iwpbl = &iwmr->iwpbl;
 	iwpbl->iwmr = iwmr;
-	iwmr->region = region;
+	iwmr->ibmr.umem = region;
 	iwmr->ibmr.pd = pd;
 	iwmr->ibmr.device = pd->device;
 
@@ -2006,11 +2006,11 @@ static int i40iw_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 	struct cqp_commands_info *cqp_info;
 	u32 stag_idx;
 
-	ib_umem_release(iwmr->region);
+	ib_umem_release(iwmr->ibmr.umem);
 
 	if (iwmr->type != IW_MEMREG_TYPE_MEM) {
 		/* region is released. only test for userness. */
-		if (iwmr->region) {
+		if (iwmr->ibmr.umem) {
 			struct i40iw_ucontext *ucontext =
 				rdma_udata_to_drv_context(
 					udata,
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.h b/drivers/infiniband/hw/i40iw/i40iw_verbs.h
index 3a413752ccc3..81a785fc218b 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.h
@@ -91,7 +91,6 @@ struct i40iw_mr {
 		struct ib_mw ibmw;
 		struct ib_fmr ibfmr;
 	};
-	struct ib_umem *region;
 	u16 type;
 	u32 page_cnt;
 	u64 page_size;
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index eb53bb4c0c91..b624e6f26f98 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -137,7 +137,6 @@ struct mlx4_ib_mr {
 	u32			npages;
 	u32			max_pages;
 	struct mlx4_mr		mmr;
-	struct ib_umem	       *umem;
 	size_t			page_map_size;
 };
 
diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index 6ae503cfc526..9af38d6f6b0c 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -74,7 +74,7 @@ struct ib_mr *mlx4_ib_get_dma_mr(struct ib_pd *pd, int acc)
 		goto err_mr;
 
 	mr->ibmr.rkey = mr->ibmr.lkey = mr->mmr.key;
-	mr->umem = NULL;
+	mr->ibmr.umem = NULL;
 
 	return &mr->ibmr;
 
@@ -415,21 +415,21 @@ struct ib_mr *mlx4_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
-	mr->umem = mlx4_get_umem_mr(udata, start, length, access_flags);
-	if (IS_ERR(mr->umem)) {
-		err = PTR_ERR(mr->umem);
+	mr->ibmr.umem = mlx4_get_umem_mr(udata, start, length, access_flags);
+	if (IS_ERR(mr->ibmr.umem)) {
+		err = PTR_ERR(mr->ibmr.umem);
 		goto err_free;
 	}
 
-	n = ib_umem_page_count(mr->umem);
-	shift = mlx4_ib_umem_calc_optimal_mtt_size(mr->umem, start, &n);
+	n = ib_umem_page_count(mr->ibmr.umem);
+	shift = mlx4_ib_umem_calc_optimal_mtt_size(mr->ibmr.umem, start, &n);
 
 	err = mlx4_mr_alloc(dev->dev, to_mpd(pd)->pdn, virt_addr, length,
 			    convert_access(access_flags), n, shift, &mr->mmr);
 	if (err)
 		goto err_umem;
 
-	err = mlx4_ib_umem_write_mtt(dev, &mr->mmr.mtt, mr->umem);
+	err = mlx4_ib_umem_write_mtt(dev, &mr->mmr.mtt, mr->ibmr.umem);
 	if (err)
 		goto err_mr;
 
@@ -448,7 +448,7 @@ struct ib_mr *mlx4_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	(void) mlx4_mr_free(to_mdev(pd->device)->dev, &mr->mmr);
 
 err_umem:
-	ib_umem_release(mr->umem);
+	ib_umem_release(mr->ibmr.umem);
 
 err_free:
 	kfree(mr);
@@ -486,7 +486,7 @@ int mlx4_ib_rereg_user_mr(struct ib_mr *mr, int flags,
 
 	if (flags & IB_MR_REREG_ACCESS) {
 		if (ib_access_writable(mr_access_flags) &&
-		    !mmr->umem->writable) {
+		    !mmr->ibmr.umem->writable) {
 			err = -EPERM;
 			goto release_mpt_entry;
 		}
@@ -503,32 +503,33 @@ int mlx4_ib_rereg_user_mr(struct ib_mr *mr, int flags,
 		int n;
 
 		mlx4_mr_rereg_mem_cleanup(dev->dev, &mmr->mmr);
-		ib_umem_release(mmr->umem);
-		mmr->umem = mlx4_get_umem_mr(udata, start, length,
+		ib_umem_release(mmr->ibmr.umem);
+		mmr->ibmr.umem = mlx4_get_umem_mr(udata, start, length,
 					     mr_access_flags);
-		if (IS_ERR(mmr->umem)) {
-			err = PTR_ERR(mmr->umem);
+		if (IS_ERR(mmr->ibmr.umem)) {
+			err = PTR_ERR(mmr->ibmr.umem);
 			/* Prevent mlx4_ib_dereg_mr from free'ing invalid pointer */
-			mmr->umem = NULL;
+			mmr->ibmr.umem = NULL;
 			goto release_mpt_entry;
 		}
-		n = ib_umem_page_count(mmr->umem);
+		n = ib_umem_page_count(mmr->ibmr.umem);
 		shift = PAGE_SHIFT;
 
 		err = mlx4_mr_rereg_mem_write(dev->dev, &mmr->mmr,
 					      virt_addr, length, n, shift,
 					      *pmpt_entry);
 		if (err) {
-			ib_umem_release(mmr->umem);
+			ib_umem_release(mmr->ibmr.umem);
 			goto release_mpt_entry;
 		}
 		mmr->mmr.iova       = virt_addr;
 		mmr->mmr.size       = length;
 
-		err = mlx4_ib_umem_write_mtt(dev, &mmr->mmr.mtt, mmr->umem);
+		err = mlx4_ib_umem_write_mtt(dev, &mmr->mmr.mtt,
+					     mmr->ibmr.umem);
 		if (err) {
 			mlx4_mr_rereg_mem_cleanup(dev->dev, &mmr->mmr);
-			ib_umem_release(mmr->umem);
+			ib_umem_release(mmr->ibmr.umem);
 			goto release_mpt_entry;
 		}
 	}
@@ -604,8 +605,8 @@ int mlx4_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	ret = mlx4_mr_free(to_mdev(ibmr->device)->dev, &mr->mmr);
 	if (ret)
 		return ret;
-	if (mr->umem)
-		ib_umem_release(mr->umem);
+	if (mr->ibmr.umem)
+		ib_umem_release(mr->ibmr.umem);
 	kfree(mr);
 
 	return 0;
@@ -684,7 +685,7 @@ struct ib_mr *mlx4_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 		goto err_free_pl;
 
 	mr->ibmr.rkey = mr->ibmr.lkey = mr->mmr.key;
-	mr->umem = NULL;
+	mr->ibmr.umem = NULL;
 
 	return &mr->ibmr;
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index f99c71b3c876..07a8a6aa75c5 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -596,7 +596,6 @@ struct mlx5_ib_mr {
 	int			desc_size;
 	int			access_mode;
 	struct mlx5_core_mkey	mmkey;
-	struct ib_umem	       *umem;
 	struct mlx5_shared_mr_info	*smr_info;
 	struct list_head	list;
 	int			order;
@@ -625,8 +624,8 @@ struct mlx5_ib_mr {
 
 static inline bool is_odp_mr(struct mlx5_ib_mr *mr)
 {
-	return IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING) && mr->umem &&
-	       mr->umem->is_odp;
+	return IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING) &&
+	       mr->ibmr.umem && mr->ibmr.umem->is_odp;
 }
 
 struct mlx5_ib_mw {
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 2c77456f359f..b83a754d8725 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -105,7 +105,7 @@ static void update_odp_mr(struct mlx5_ib_mr *mr)
 		 * handle invalidations.
 		 */
 		smp_wmb();
-		to_ib_umem_odp(mr->umem)->private = mr;
+		to_ib_umem_odp(mr->ibmr.umem)->private = mr;
 		/*
 		 * Make sure we will see the new
 		 * umem->odp_data->private value in the invalidation
@@ -757,7 +757,7 @@ struct ib_mr *mlx5_ib_get_dma_mr(struct ib_pd *pd, int acc)
 	mr->mmkey.type = MLX5_MKEY_MR;
 	mr->ibmr.lkey = mr->mmkey.key;
 	mr->ibmr.rkey = mr->mmkey.key;
-	mr->umem = NULL;
+	mr->ibmr.umem = NULL;
 
 	return &mr->ibmr;
 
@@ -890,7 +890,7 @@ static struct mlx5_ib_mr *alloc_mr_from_cache(
 		return ERR_PTR(-EAGAIN);
 
 	mr->ibmr.pd = pd;
-	mr->umem = umem;
+	mr->ibmr.umem = umem;
 	mr->access_flags = access_flags;
 	mr->desc_size = sizeof(struct mlx5_mtt);
 	mr->mmkey.iova = virt_addr;
@@ -905,7 +905,7 @@ static inline int populate_xlt(struct mlx5_ib_mr *mr, int idx, int npages,
 			       int flags)
 {
 	struct mlx5_ib_dev *dev = mr->dev;
-	struct ib_umem *umem = mr->umem;
+	struct ib_umem *umem = mr->ibmr.umem;
 
 	if (flags & MLX5_IB_UPD_XLT_INDIRECT) {
 		if (!umr_can_use_indirect_mkey(dev))
@@ -1204,7 +1204,7 @@ static struct ib_mr *mlx5_ib_get_dm_mr(struct ib_pd *pd, u64 start_addr,
 
 	kfree(in);
 
-	mr->umem = NULL;
+	mr->ibmr.umem = NULL;
 	set_mr_fields(dev, mr, 0, length, acc);
 
 	return &mr->ibmr;
@@ -1336,7 +1336,7 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 
 	mlx5_ib_dbg(dev, "mkey 0x%x\n", mr->mmkey.key);
 
-	mr->umem = umem;
+	mr->ibmr.umem = umem;
 	set_mr_fields(dev, mr, npages, length, access_flags);
 
 	update_odp_mr(mr);
@@ -1431,15 +1431,15 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 
 	atomic_sub(mr->npages, &dev->mdev->priv.reg_pages);
 
-	if (!mr->umem)
+	if (!mr->ibmr.umem)
 		return -EINVAL;
 
 	if (flags & IB_MR_REREG_TRANS) {
 		addr = virt_addr;
 		len = length;
 	} else {
-		addr = mr->umem->address;
-		len = mr->umem->length;
+		addr = mr->ibmr.umem->address;
+		len = mr->ibmr.umem->length;
 	}
 
 	if (flags != IB_MR_REREG_PD) {
@@ -1448,10 +1448,10 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 		 * used.
 		 */
 		flags |= IB_MR_REREG_TRANS;
-		ib_umem_release(mr->umem);
-		mr->umem = NULL;
+		ib_umem_release(mr->ibmr.umem);
+		mr->ibmr.umem = NULL;
 		err = mr_umem_get(dev, udata, addr, len, access_flags,
-				  &mr->umem, &npages, &page_shift, &ncont,
+				  &mr->ibmr.umem, &npages, &page_shift, &ncont,
 				  &order);
 		if (err)
 			goto err;
@@ -1468,7 +1468,7 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 		if (err)
 			goto err;
 
-		mr = reg_create(ib_mr, pd, addr, len, mr->umem, ncont,
+		mr = reg_create(ib_mr, pd, addr, len, mr->ibmr.umem, ncont,
 				page_shift, access_flags, true);
 
 		if (IS_ERR(mr)) {
@@ -1512,8 +1512,8 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 	return 0;
 
 err:
-	ib_umem_release(mr->umem);
-	mr->umem = NULL;
+	ib_umem_release(mr->ibmr.umem);
+	mr->ibmr.umem = NULL;
 
 	clean_mr(dev, mr);
 	return err;
@@ -1591,7 +1591,7 @@ static void clean_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 static void dereg_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 {
 	int npages = mr->npages;
-	struct ib_umem *umem = mr->umem;
+	struct ib_umem *umem = mr->ibmr.umem;
 
 	if (is_odp_mr(mr)) {
 		struct ib_umem_odp *umem_odp = to_ib_umem_odp(umem);
@@ -1737,7 +1737,7 @@ static struct mlx5_ib_mr *mlx5_ib_alloc_pi_mr(struct ib_pd *pd,
 	if (err)
 		goto err_free_in;
 
-	mr->umem = NULL;
+	mr->ibmr.umem = NULL;
 	kfree(in);
 
 	return mr;
@@ -1857,7 +1857,7 @@ static struct ib_mr *__mlx5_ib_alloc_mr(struct ib_pd *pd,
 	}
 
 	mr->ibmr.device = pd->device;
-	mr->umem = NULL;
+	mr->ibmr.umem = NULL;
 
 	switch (mr_type) {
 	case IB_MR_TYPE_MEM_REG:
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 6f1de5edbe8e..673d18b0b743 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -106,7 +106,7 @@ static struct ib_ucontext_per_mm *mr_to_per_mm(struct mlx5_ib_mr *mr)
 	if (WARN_ON(!mr || !is_odp_mr(mr)))
 		return NULL;
 
-	return to_ib_umem_odp(mr->umem)->per_mm;
+	return to_ib_umem_odp(mr->ibmr.umem)->per_mm;
 }
 
 static struct ib_umem_odp *odp_next(struct ib_umem_odp *odp)
@@ -420,7 +420,7 @@ static struct mlx5_ib_mr *implicit_mr_alloc(struct ib_pd *pd,
 	mr->dev = dev;
 	mr->access_flags = access_flags;
 	mr->mmkey.iova = 0;
-	mr->umem = umem;
+	mr->ibmr.umem = umem;
 
 	if (ksm) {
 		err = mlx5_ib_update_xlt(mr, 0,
@@ -464,7 +464,7 @@ static struct ib_umem_odp *implicit_mr_get_data(struct mlx5_ib_mr *mr,
 {
 	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.pd->device);
 	struct ib_umem_odp *odp, *result = NULL;
-	struct ib_umem_odp *odp_mr = to_ib_umem_odp(mr->umem);
+	struct ib_umem_odp *odp_mr = to_ib_umem_odp(mr->ibmr.umem);
 	u64 addr = io_virt & MLX5_IMR_MTT_MASK;
 	int nentries = 0, start_idx = 0, ret;
 	struct mlx5_ib_mr *mtt;
@@ -496,7 +496,7 @@ static struct ib_umem_odp *implicit_mr_get_data(struct mlx5_ib_mr *mr,
 		}
 
 		odp->private = mtt;
-		mtt->umem = &odp->umem;
+		mtt->ibmr.umem = &odp->umem;
 		mtt->mmkey.iova = addr;
 		mtt->parent = mr;
 		INIT_WORK(&odp->work, mr_leaf_free_action);
@@ -549,7 +549,7 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 		return ERR_CAST(imr);
 	}
 
-	imr->umem = umem;
+	imr->ibmr.umem = umem;
 	init_waitqueue_head(&imr->q_leaf_free);
 	atomic_set(&imr->num_leaf_free, 0);
 	atomic_set(&imr->num_pending_prefetch, 0);
@@ -598,7 +598,7 @@ static int pagefault_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
 {
 	int npages = 0, current_seq, page_shift, ret, np;
 	bool implicit = false;
-	struct ib_umem_odp *odp_mr = to_ib_umem_odp(mr->umem);
+	struct ib_umem_odp *odp_mr = to_ib_umem_odp(mr->ibmr.umem);
 	bool downgrade = flags & MLX5_PF_FLAGS_DOWNGRADE;
 	bool prefetch = flags & MLX5_PF_FLAGS_PREFETCH;
 	u64 access_mask;
@@ -625,7 +625,7 @@ static int pagefault_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
 	start_idx = (io_virt - (mr->mmkey.iova & page_mask)) >> page_shift;
 	access_mask = ODP_READ_ALLOWED_BIT;
 
-	if (prefetch && !downgrade && !mr->umem->writable) {
+	if (prefetch && !downgrade && !mr->ibmr.umem->writable) {
 		/* prefetch with write-access must
 		 * be supported by the MR
 		 */
@@ -633,7 +633,7 @@ static int pagefault_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
 		goto out;
 	}
 
-	if (mr->umem->writable && !downgrade)
+	if (mr->ibmr.umem->writable && !downgrade)
 		access_mask |= ODP_WRITE_ALLOWED_BIT;
 
 	current_seq = READ_ONCE(odp->notifiers_seq);
@@ -643,8 +643,8 @@ static int pagefault_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
 	 */
 	smp_rmb();
 
-	ret = ib_umem_odp_map_dma_pages(to_ib_umem_odp(mr->umem), io_virt, size,
-					access_mask, current_seq);
+	ret = ib_umem_odp_map_dma_pages(to_ib_umem_odp(mr->ibmr.umem), io_virt,
+					size, access_mask, current_seq);
 
 	if (ret < 0)
 		goto out;
@@ -652,7 +652,7 @@ static int pagefault_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
 	np = ret;
 
 	mutex_lock(&odp->umem_mutex);
-	if (!ib_umem_mmu_notifier_retry(to_ib_umem_odp(mr->umem),
+	if (!ib_umem_mmu_notifier_retry(to_ib_umem_odp(mr->ibmr.umem),
 					current_seq)) {
 		/*
 		 * No need to check whether the MTTs really belong to
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 23554d8bf241..e7b1577b9f36 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -846,7 +846,7 @@ static struct ib_mr *mthca_get_dma_mr(struct ib_pd *pd, int acc)
 		return ERR_PTR(err);
 	}
 
-	mr->umem = NULL;
+	mr->ibmr.umem = NULL;
 
 	return &mr->ibmr;
 }
@@ -880,15 +880,15 @@ static struct ib_mr *mthca_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
-	mr->umem = ib_umem_get(udata, start, length, acc,
+	mr->ibmr.umem = ib_umem_get(udata, start, length, acc,
 			       ucmd.mr_attrs & MTHCA_MR_DMASYNC);
 
-	if (IS_ERR(mr->umem)) {
-		err = PTR_ERR(mr->umem);
+	if (IS_ERR(mr->ibmr.umem)) {
+		err = PTR_ERR(mr->ibmr.umem);
 		goto err;
 	}
 
-	n = ib_umem_num_pages(mr->umem);
+	n = ib_umem_num_pages(mr->ibmr.umem);
 
 	mr->mtt = mthca_alloc_mtt(dev, n);
 	if (IS_ERR(mr->mtt)) {
@@ -906,7 +906,8 @@ static struct ib_mr *mthca_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 
 	write_mtt_size = min(mthca_write_mtt_size(dev), (int) (PAGE_SIZE / sizeof *pages));
 
-	for_each_sg_dma_page(mr->umem->sg_head.sgl, &sg_iter, mr->umem->nmap, 0) {
+	for_each_sg_dma_page(mr->ibmr.umem->sg_head.sgl, &sg_iter,
+			     mr->ibmr.umem->nmap, 0) {
 		pages[i++] = sg_page_iter_dma_address(&sg_iter);
 
 		/*
@@ -941,7 +942,7 @@ static struct ib_mr *mthca_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	mthca_free_mtt(dev, mr->mtt);
 
 err_umem:
-	ib_umem_release(mr->umem);
+	ib_umem_release(mr->ibmr.umem);
 
 err:
 	kfree(mr);
@@ -953,7 +954,7 @@ static int mthca_dereg_mr(struct ib_mr *mr, struct ib_udata *udata)
 	struct mthca_mr *mmr = to_mmr(mr);
 
 	mthca_free_mr(to_mdev(mr->device), mmr);
-	ib_umem_release(mmr->umem);
+	ib_umem_release(mmr->ibmr.umem);
 	kfree(mmr);
 
 	return 0;
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.h b/drivers/infiniband/hw/mthca/mthca_provider.h
index 596acc45569b..5003d367f773 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.h
+++ b/drivers/infiniband/hw/mthca/mthca_provider.h
@@ -72,7 +72,6 @@ struct mthca_mtt;
 
 struct mthca_mr {
 	struct ib_mr      ibmr;
-	struct ib_umem   *umem;
 	struct mthca_mtt *mtt;
 };
 
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma.h b/drivers/infiniband/hw/ocrdma/ocrdma.h
index 7baedc74e39d..1072577f9b11 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma.h
+++ b/drivers/infiniband/hw/ocrdma/ocrdma.h
@@ -192,7 +192,6 @@ struct ocrdma_hw_mr {
 
 struct ocrdma_mr {
 	struct ib_mr ibmr;
-	struct ib_umem *umem;
 	struct ocrdma_hw_mr hwmr;
 	u64 *pages;
 	u32 npages;
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index bccc11378109..032a5289b67a 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -824,7 +824,7 @@ static void build_user_pbes(struct ocrdma_dev *dev, struct ocrdma_mr *mr,
 	struct ocrdma_pbe *pbe;
 	struct sg_dma_page_iter sg_iter;
 	struct ocrdma_pbl *pbl_tbl = mr->hwmr.pbl_table;
-	struct ib_umem *umem = mr->umem;
+	struct ib_umem *umem = mr->ibmr.umem;
 	int pbe_cnt, total_num_pbes = 0;
 	u64 pg_addr;
 
@@ -875,18 +875,18 @@ struct ib_mr *ocrdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
 	if (!mr)
 		return ERR_PTR(status);
-	mr->umem = ib_umem_get(udata, start, len, acc, 0);
-	if (IS_ERR(mr->umem)) {
+	mr->ibmr.umem = ib_umem_get(udata, start, len, acc, 0);
+	if (IS_ERR(mr->ibmr.umem)) {
 		status = -EFAULT;
 		goto umem_err;
 	}
-	num_pbes = ib_umem_page_count(mr->umem);
+	num_pbes = ib_umem_page_count(mr->ibmr.umem);
 	status = ocrdma_get_pbl_info(dev, mr, num_pbes);
 	if (status)
 		goto umem_err;
 
 	mr->hwmr.pbe_size = PAGE_SIZE;
-	mr->hwmr.fbo = ib_umem_offset(mr->umem);
+	mr->hwmr.fbo = ib_umem_offset(mr->ibmr.umem);
 	mr->hwmr.va = usr_addr;
 	mr->hwmr.len = len;
 	mr->hwmr.remote_wr = (acc & IB_ACCESS_REMOTE_WRITE) ? 1 : 0;
@@ -925,7 +925,7 @@ int ocrdma_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 	ocrdma_free_mr_pbl_tbl(dev, &mr->hwmr);
 
 	/* it could be user registered memory. */
-	ib_umem_release(mr->umem);
+	ib_umem_release(mr->ibmr.umem);
 	kfree(mr);
 
 	/* Don't stop cleanup, in case FW is unresponsive */
diff --git a/drivers/infiniband/hw/qedr/qedr.h b/drivers/infiniband/hw/qedr/qedr.h
index 0cfd849b13d6..86844e5e22b7 100644
--- a/drivers/infiniband/hw/qedr/qedr.h
+++ b/drivers/infiniband/hw/qedr/qedr.h
@@ -464,7 +464,6 @@ struct mr_info {
 
 struct qedr_mr {
 	struct ib_mr ibmr;
-	struct ib_umem *umem;
 
 	struct qed_rdma_register_tid_in_params hw_mr;
 	enum qedr_mr_type type;
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 0c6a4bc848f5..85587b284c7d 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -2597,17 +2597,17 @@ struct ib_mr *qedr_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 
 	mr->type = QEDR_MR_USER;
 
-	mr->umem = ib_umem_get(udata, start, len, acc, 0);
-	if (IS_ERR(mr->umem)) {
+	mr->ibmr.umem = ib_umem_get(udata, start, len, acc, 0);
+	if (IS_ERR(mr->ibmr.umem)) {
 		rc = -EFAULT;
 		goto err0;
 	}
 
-	rc = init_mr_info(dev, &mr->info, ib_umem_page_count(mr->umem), 1);
+	rc = init_mr_info(dev, &mr->info, ib_umem_page_count(mr->ibmr.umem), 1);
 	if (rc)
 		goto err1;
 
-	qedr_populate_pbls(dev, mr->umem, mr->info.pbl_table,
+	qedr_populate_pbls(dev, mr->ibmr.umem, mr->info.pbl_table,
 			   &mr->info.pbl_info, PAGE_SHIFT);
 
 	rc = dev->ops->rdma_alloc_tid(dev->rdma_ctx, &mr->hw_mr.itid);
@@ -2630,7 +2630,7 @@ struct ib_mr *qedr_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 	mr->hw_mr.pbl_two_level = mr->info.pbl_info.two_layered;
 	mr->hw_mr.pbl_page_size_log = ilog2(mr->info.pbl_info.pbl_size);
 	mr->hw_mr.page_size_log = PAGE_SHIFT;
-	mr->hw_mr.fbo = ib_umem_offset(mr->umem);
+	mr->hw_mr.fbo = ib_umem_offset(mr->ibmr.umem);
 	mr->hw_mr.length = len;
 	mr->hw_mr.vaddr = usr_addr;
 	mr->hw_mr.zbva = false;
@@ -2677,7 +2677,7 @@ int qedr_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 		qedr_free_pbl(dev, &mr->info.pbl_info, mr->info.pbl_table);
 
 	/* it could be user registered memory. */
-	ib_umem_release(mr->umem);
+	ib_umem_release(mr->ibmr.umem);
 
 	kfree(mr);
 
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
index c142f5e7f25f..8b3125b2654e 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
@@ -139,7 +139,6 @@ struct pvrdma_mr {
 
 struct pvrdma_user_mr {
 	struct ib_mr ibmr;
-	struct ib_umem *umem;
 	struct pvrdma_mr mmr;
 	struct pvrdma_page_dir pdir;
 	u64 *pages;
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
index f3a3d22ee8d7..2db36fd8f28c 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
@@ -149,7 +149,7 @@ struct ib_mr *pvrdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 
 	mr->mmr.iova = virt_addr;
 	mr->mmr.size = length;
-	mr->umem = umem;
+	mr->ibmr.umem = umem;
 
 	ret = pvrdma_page_dir_init(dev, &mr->pdir, npages, false);
 	if (ret) {
@@ -158,7 +158,7 @@ struct ib_mr *pvrdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 		goto err_umem;
 	}
 
-	ret = pvrdma_page_dir_insert_umem(&mr->pdir, mr->umem, 0);
+	ret = pvrdma_page_dir_insert_umem(&mr->pdir, mr->ibmr.umem, 0);
 	if (ret)
 		goto err_pdir;
 
@@ -254,7 +254,7 @@ struct ib_mr *pvrdma_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 	mr->ibmr.lkey = resp->lkey;
 	mr->ibmr.rkey = resp->rkey;
 	mr->page_shift = PAGE_SHIFT;
-	mr->umem = NULL;
+	mr->ibmr.umem = NULL;
 
 	return &mr->ibmr;
 
@@ -290,7 +290,7 @@ int pvrdma_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 			 "could not deregister mem region, error: %d\n", ret);
 
 	pvrdma_page_dir_cleanup(dev, &mr->pdir);
-	ib_umem_release(mr->umem);
+	ib_umem_release(mr->ibmr.umem);
 
 	kfree(mr->pages);
 	kfree(mr);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 0ecda7d15df2..fc69972c24aa 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1758,6 +1758,7 @@ struct ib_dm {
 struct ib_mr {
 	struct ib_device  *device;
 	struct ib_pd	  *pd;
+	struct ib_umem	  *umem;
 	u32		   lkey;
 	u32		   rkey;
 	u64		   iova;
-- 
2.20.1

