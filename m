Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2865FFAB03
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2019 08:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfKMHc1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Nov 2019 02:32:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52436 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfKMHc1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Nov 2019 02:32:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hpisGvQXQ7nnvmaNhTGL/hqRvCZhDhEjz/ylDcUEpXo=; b=ZvscfNLc2xuzre+xNtP0H+eD4w
        +Gs/LncysqnT57xiTbx8rD3kW2mC01JZpOKkXHrwXZcfnLzaMO4miRPq6LIHTu58hOveB6DmtBRb1
        Qwc5muenW0XSP7avyz9cMRjmyWwMWWjyT+qd3QxMjdCH25eLgZF6f9qTDCXJeRxiOh4dITyxZwimH
        id6abBrZx+XftvZvDP4iE1oG6woEHZTv0idWCFnNk3Q5JJ1cURaPbnmrhcyLO9Jw36uGrsOKjUkU6
        3s3jlD7SK5fozuFFaVaqcsfRpLXypkWlBOW6T/xUDRftWv7BVg2crN1zlGgQscklNdq4Zhnm4c+EX
        Qf6xqj7Q==;
Received: from [2001:4bb8:180:3806:c70:4a89:bc61:5] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUn8X-0006rC-35; Wed, 13 Nov 2019 07:32:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        iommu@lists.linux-foundation.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 2/2] IB/umem: remove the dmasync argument to ib_umem_get
Date:   Wed, 13 Nov 2019 08:32:14 +0100
Message-Id: <20191113073214.9514-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113073214.9514-1-hch@lst.de>
References: <20191113073214.9514-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The argument is always ignored, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/infiniband/core/umem.c                |  3 +--
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      | 10 ++++-----
 drivers/infiniband/hw/cxgb3/iwch_provider.c   |  2 +-
 drivers/infiniband/hw/cxgb4/mem.c             |  2 +-
 drivers/infiniband/hw/efa/efa_verbs.c         |  2 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c       |  2 +-
 drivers/infiniband/hw/hns/hns_roce_db.c       |  2 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c       |  4 ++--
 drivers/infiniband/hw/hns/hns_roce_qp.c       |  2 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c      |  4 ++--
 drivers/infiniband/hw/i40iw/i40iw_verbs.c     |  2 +-
 drivers/infiniband/hw/mlx4/cq.c               |  2 +-
 drivers/infiniband/hw/mlx4/doorbell.c         |  2 +-
 drivers/infiniband/hw/mlx4/mr.c               |  2 +-
 drivers/infiniband/hw/mlx4/qp.c               |  5 ++---
 drivers/infiniband/hw/mlx4/srq.c              |  2 +-
 drivers/infiniband/hw/mlx5/cq.c               |  4 ++--
 drivers/infiniband/hw/mlx5/devx.c             |  2 +-
 drivers/infiniband/hw/mlx5/doorbell.c         |  2 +-
 drivers/infiniband/hw/mlx5/mr.c               |  2 +-
 drivers/infiniband/hw/mlx5/qp.c               |  4 ++--
 drivers/infiniband/hw/mlx5/srq.c              |  2 +-
 drivers/infiniband/hw/mthca/mthca_provider.c  |  4 +---
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  2 +-
 drivers/infiniband/hw/qedr/verbs.c            | 21 +++++++++----------
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c  |  2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c  |  2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c  |  4 ++--
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c |  2 +-
 drivers/infiniband/sw/rdmavt/mr.c             |  2 +-
 drivers/infiniband/sw/rxe/rxe_mr.c            |  2 +-
 include/rdma/ib_umem.h                        |  4 ++--
 32 files changed, 52 insertions(+), 57 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 66148739b00f..7a3b99597ead 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -185,10 +185,9 @@ EXPORT_SYMBOL(ib_umem_find_best_pgsz);
  * @addr: userspace virtual address to start at
  * @size: length of region to pin
  * @access: IB_ACCESS_xxx flags for memory being pinned
- * @dmasync: flush in-flight DMA when the memory region is written
  */
 struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
-			    size_t size, int access, int dmasync)
+			    size_t size, int access)
 {
 	struct ib_ucontext *context;
 	struct ib_umem *umem;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index b4149dc9e824..99a8e0b99e66 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -855,7 +855,7 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 		bytes += (qplib_qp->sq.max_wqe * psn_sz);
 	}
 	bytes = PAGE_ALIGN(bytes);
-	umem = ib_umem_get(udata, ureq.qpsva, bytes, IB_ACCESS_LOCAL_WRITE, 1);
+	umem = ib_umem_get(udata, ureq.qpsva, bytes, IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(umem))
 		return PTR_ERR(umem);
 
@@ -869,7 +869,7 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 		bytes = (qplib_qp->rq.max_wqe * BNXT_QPLIB_MAX_RQE_ENTRY_SIZE);
 		bytes = PAGE_ALIGN(bytes);
 		umem = ib_umem_get(udata, ureq.qprva, bytes,
-				   IB_ACCESS_LOCAL_WRITE, 1);
+				   IB_ACCESS_LOCAL_WRITE);
 		if (IS_ERR(umem))
 			goto rqfail;
 		qp->rumem = umem;
@@ -1322,7 +1322,7 @@ static int bnxt_re_init_user_srq(struct bnxt_re_dev *rdev,
 
 	bytes = (qplib_srq->max_wqe * BNXT_QPLIB_MAX_RQE_ENTRY_SIZE);
 	bytes = PAGE_ALIGN(bytes);
-	umem = ib_umem_get(udata, ureq.srqva, bytes, IB_ACCESS_LOCAL_WRITE, 1);
+	umem = ib_umem_get(udata, ureq.srqva, bytes, IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(umem))
 		return PTR_ERR(umem);
 
@@ -2565,7 +2565,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 		cq->umem = ib_umem_get(udata, req.cq_va,
 				       entries * sizeof(struct cq_base),
-				       IB_ACCESS_LOCAL_WRITE, 1);
+				       IB_ACCESS_LOCAL_WRITE);
 		if (IS_ERR(cq->umem)) {
 			rc = PTR_ERR(cq->umem);
 			goto fail;
@@ -3530,7 +3530,7 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 	/* The fixed portion of the rkey is the same as the lkey */
 	mr->ib_mr.rkey = mr->qplib_mr.rkey;
 
-	umem = ib_umem_get(udata, start, length, mr_access_flags, 0);
+	umem = ib_umem_get(udata, start, length, mr_access_flags);
 	if (IS_ERR(umem)) {
 		dev_err(rdev_to_dev(rdev), "Failed to get umem");
 		rc = -EFAULT;
diff --git a/drivers/infiniband/hw/cxgb3/iwch_provider.c b/drivers/infiniband/hw/cxgb3/iwch_provider.c
index dcf02ec02810..a6da164c6fc0 100644
--- a/drivers/infiniband/hw/cxgb3/iwch_provider.c
+++ b/drivers/infiniband/hw/cxgb3/iwch_provider.c
@@ -451,7 +451,7 @@ static struct ib_mr *iwch_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 
 	mhp->rhp = rhp;
 
-	mhp->umem = ib_umem_get(udata, start, length, acc, 0);
+	mhp->umem = ib_umem_get(udata, start, length, acc);
 	if (IS_ERR(mhp->umem)) {
 		err = PTR_ERR(mhp->umem);
 		kfree(mhp);
diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb4/mem.c
index 35c284af574d..fe3a7e8561df 100644
--- a/drivers/infiniband/hw/cxgb4/mem.c
+++ b/drivers/infiniband/hw/cxgb4/mem.c
@@ -543,7 +543,7 @@ struct ib_mr *c4iw_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 
 	mhp->rhp = rhp;
 
-	mhp->umem = ib_umem_get(udata, start, length, acc, 0);
+	mhp->umem = ib_umem_get(udata, start, length, acc);
 	if (IS_ERR(mhp->umem))
 		goto err_free_skb;
 
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 4edae89e8e3c..f065d31976e0 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1423,7 +1423,7 @@ struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 		goto err_out;
 	}
 
-	mr->umem = ib_umem_get(udata, start, length, access_flags, 0);
+	mr->umem = ib_umem_get(udata, start, length, access_flags);
 	if (IS_ERR(mr->umem)) {
 		err = PTR_ERR(mr->umem);
 		ibdev_dbg(&dev->ibdev,
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 22541d19cd09..51fdca85d74f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -214,7 +214,7 @@ static int hns_roce_ib_get_cq_umem(struct hns_roce_dev *hr_dev,
 	u32 npages;
 
 	*umem = ib_umem_get(udata, buf_addr, cqe * hr_dev->caps.cq_entry_sz,
-			    IB_ACCESS_LOCAL_WRITE, 1);
+			    IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(*umem))
 		return PTR_ERR(*umem);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_db.c b/drivers/infiniband/hw/hns/hns_roce_db.c
index c00714c2f16a..10af6958ab69 100644
--- a/drivers/infiniband/hw/hns/hns_roce_db.c
+++ b/drivers/infiniband/hw/hns/hns_roce_db.c
@@ -31,7 +31,7 @@ int hns_roce_db_map_user(struct hns_roce_ucontext *context,
 
 	refcount_set(&page->refcount, 1);
 	page->user_virt = page_addr;
-	page->umem = ib_umem_get(udata, page_addr, PAGE_SIZE, 0, 0);
+	page->umem = ib_umem_get(udata, page_addr, PAGE_SIZE, 0);
 	if (IS_ERR(page->umem)) {
 		ret = PTR_ERR(page->umem);
 		kfree(page);
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 5f8416ba09a9..59916dfcbf57 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -1143,7 +1143,7 @@ struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
-	mr->umem = ib_umem_get(udata, start, length, access_flags, 0);
+	mr->umem = ib_umem_get(udata, start, length, access_flags);
 	if (IS_ERR(mr->umem)) {
 		ret = PTR_ERR(mr->umem);
 		goto err_free;
@@ -1228,7 +1228,7 @@ static int rereg_mr_trans(struct ib_mr *ibmr, int flags,
 	}
 	ib_umem_release(mr->umem);
 
-	mr->umem = ib_umem_get(udata, start, length, mr_access_flags, 0);
+	mr->umem = ib_umem_get(udata, start, length, mr_access_flags);
 	if (IS_ERR(mr->umem)) {
 		ret = PTR_ERR(mr->umem);
 		mr->umem = NULL;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index bd78ff90d998..46209df25e81 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -743,7 +743,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		}
 
 		hr_qp->umem = ib_umem_get(udata, ucmd.buf_addr,
-					  hr_qp->buff_size, 0, 0);
+					  hr_qp->buff_size, 0);
 		if (IS_ERR(hr_qp->umem)) {
 			dev_err(dev, "ib_umem_get error for create qp\n");
 			ret = PTR_ERR(hr_qp->umem);
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 9591457eb768..59376aa0d62a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -187,7 +187,7 @@ static int create_user_srq(struct hns_roce_srq *srq, struct ib_udata *udata,
 	if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd)))
 		return -EFAULT;
 
-	srq->umem = ib_umem_get(udata, ucmd.buf_addr, srq_buf_size, 0, 0);
+	srq->umem = ib_umem_get(udata, ucmd.buf_addr, srq_buf_size, 0);
 	if (IS_ERR(srq->umem))
 		return PTR_ERR(srq->umem);
 
@@ -205,7 +205,7 @@ static int create_user_srq(struct hns_roce_srq *srq, struct ib_udata *udata,
 
 	/* config index queue BA */
 	srq->idx_que.umem = ib_umem_get(udata, ucmd.que_addr,
-					srq->idx_que.buf_size, 0, 0);
+					srq->idx_que.buf_size, 0);
 	if (IS_ERR(srq->idx_que.umem)) {
 		dev_err(hr_dev->dev, "ib_umem_get error for index queue\n");
 		ret = PTR_ERR(srq->idx_que.umem);
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index cd9ee1664a69..86375947bc67 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -1763,7 +1763,7 @@ static struct ib_mr *i40iw_reg_user_mr(struct ib_pd *pd,
 
 	if (length > I40IW_MAX_MR_SIZE)
 		return ERR_PTR(-EINVAL);
-	region = ib_umem_get(udata, start, length, acc, 0);
+	region = ib_umem_get(udata, start, length, acc);
 	if (IS_ERR(region))
 		return (struct ib_mr *)region;
 
diff --git a/drivers/infiniband/hw/mlx4/cq.c b/drivers/infiniband/hw/mlx4/cq.c
index a7d238d312f0..306b21281fa2 100644
--- a/drivers/infiniband/hw/mlx4/cq.c
+++ b/drivers/infiniband/hw/mlx4/cq.c
@@ -145,7 +145,7 @@ static int mlx4_ib_get_cq_umem(struct mlx4_ib_dev *dev, struct ib_udata *udata,
 	int n;
 
 	*umem = ib_umem_get(udata, buf_addr, cqe * cqe_size,
-			    IB_ACCESS_LOCAL_WRITE, 1);
+			    IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(*umem))
 		return PTR_ERR(*umem);
 
diff --git a/drivers/infiniband/hw/mlx4/doorbell.c b/drivers/infiniband/hw/mlx4/doorbell.c
index 0f390351cef0..714f9df5bf39 100644
--- a/drivers/infiniband/hw/mlx4/doorbell.c
+++ b/drivers/infiniband/hw/mlx4/doorbell.c
@@ -64,7 +64,7 @@ int mlx4_ib_db_map_user(struct ib_udata *udata, unsigned long virt,
 
 	page->user_virt = (virt & PAGE_MASK);
 	page->refcnt    = 0;
-	page->umem = ib_umem_get(udata, virt & PAGE_MASK, PAGE_SIZE, 0, 0);
+	page->umem = ib_umem_get(udata, virt & PAGE_MASK, PAGE_SIZE, 0);
 	if (IS_ERR(page->umem)) {
 		err = PTR_ERR(page->umem);
 		kfree(page);
diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index 6ae503cfc526..dfa17bcdcdbc 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -398,7 +398,7 @@ static struct ib_umem *mlx4_get_umem_mr(struct ib_udata *udata, u64 start,
 		up_read(&current->mm->mmap_sem);
 	}
 
-	return ib_umem_get(udata, start, length, access_flags, 0);
+	return ib_umem_get(udata, start, length, access_flags);
 }
 
 struct ib_mr *mlx4_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index bd4aa04416c6..85f57b76e446 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -916,7 +916,7 @@ static int create_rq(struct ib_pd *pd, struct ib_qp_init_attr *init_attr,
 	qp->buf_size = (qp->rq.wqe_cnt << qp->rq.wqe_shift) +
 		       (qp->sq.wqe_cnt << qp->sq.wqe_shift);
 
-	qp->umem = ib_umem_get(udata, wq.buf_addr, qp->buf_size, 0, 0);
+	qp->umem = ib_umem_get(udata, wq.buf_addr, qp->buf_size, 0);
 	if (IS_ERR(qp->umem)) {
 		err = PTR_ERR(qp->umem);
 		goto err;
@@ -1110,8 +1110,7 @@ static int create_qp_common(struct ib_pd *pd, struct ib_qp_init_attr *init_attr,
 		if (err)
 			goto err;
 
-		qp->umem =
-			ib_umem_get(udata, ucmd.buf_addr, qp->buf_size, 0, 0);
+		qp->umem = ib_umem_get(udata, ucmd.buf_addr, qp->buf_size, 0);
 		if (IS_ERR(qp->umem)) {
 			err = PTR_ERR(qp->umem);
 			goto err;
diff --git a/drivers/infiniband/hw/mlx4/srq.c b/drivers/infiniband/hw/mlx4/srq.c
index 848db7264cc9..8dcf6e3d9ae2 100644
--- a/drivers/infiniband/hw/mlx4/srq.c
+++ b/drivers/infiniband/hw/mlx4/srq.c
@@ -110,7 +110,7 @@ int mlx4_ib_create_srq(struct ib_srq *ib_srq,
 		if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd)))
 			return -EFAULT;
 
-		srq->umem = ib_umem_get(udata, ucmd.buf_addr, buf_size, 0, 0);
+		srq->umem = ib_umem_get(udata, ucmd.buf_addr, buf_size, 0);
 		if (IS_ERR(srq->umem))
 			return PTR_ERR(srq->umem);
 
diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 45f48cde6b9d..4c60ab13b8fd 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -710,7 +710,7 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 
 	cq->buf.umem =
 		ib_umem_get(udata, ucmd.buf_addr, entries * ucmd.cqe_size,
-			    IB_ACCESS_LOCAL_WRITE, 1);
+			    IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(cq->buf.umem)) {
 		err = PTR_ERR(cq->buf.umem);
 		return err;
@@ -1111,7 +1111,7 @@ static int resize_user(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *cq,
 
 	umem = ib_umem_get(udata, ucmd.buf_addr,
 			   (size_t)ucmd.cqe_size * entries,
-			   IB_ACCESS_LOCAL_WRITE, 1);
+			   IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(umem)) {
 		err = PTR_ERR(umem);
 		return err;
diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index d609f4659afb..e419fcfcf42f 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2121,7 +2121,7 @@ static int devx_umem_get(struct mlx5_ib_dev *dev, struct ib_ucontext *ucontext,
 	if (err)
 		return err;
 
-	obj->umem = ib_umem_get(&attrs->driver_udata, addr, size, access, 0);
+	obj->umem = ib_umem_get(&attrs->driver_udata, addr, size, access);
 	if (IS_ERR(obj->umem))
 		return PTR_ERR(obj->umem);
 
diff --git a/drivers/infiniband/hw/mlx5/doorbell.c b/drivers/infiniband/hw/mlx5/doorbell.c
index 8f4e5f22b84c..12737c509aa2 100644
--- a/drivers/infiniband/hw/mlx5/doorbell.c
+++ b/drivers/infiniband/hw/mlx5/doorbell.c
@@ -64,7 +64,7 @@ int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context,
 
 	page->user_virt = (virt & PAGE_MASK);
 	page->refcnt    = 0;
-	page->umem = ib_umem_get(udata, virt & PAGE_MASK, PAGE_SIZE, 0, 0);
+	page->umem = ib_umem_get(udata, virt & PAGE_MASK, PAGE_SIZE, 0);
 	if (IS_ERR(page->umem)) {
 		err = PTR_ERR(page->umem);
 		kfree(page);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 630599311586..506758477caa 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -779,7 +779,7 @@ static int mr_umem_get(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 		if (order)
 			*order = ilog2(roundup_pow_of_two(*ncont));
 	} else {
-		u = ib_umem_get(udata, start, length, access_flags, 0);
+		u = ib_umem_get(udata, start, length, access_flags);
 		if (IS_ERR(u)) {
 			mlx5_ib_dbg(dev, "umem get failed (%ld)\n", PTR_ERR(u));
 			return PTR_ERR(u);
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 8937d72ddcf6..72bfbbc60fd2 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -749,7 +749,7 @@ static int mlx5_ib_umem_get(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 {
 	int err;
 
-	*umem = ib_umem_get(udata, addr, size, 0, 0);
+	*umem = ib_umem_get(udata, addr, size, 0);
 	if (IS_ERR(*umem)) {
 		mlx5_ib_dbg(dev, "umem_get failed\n");
 		return PTR_ERR(*umem);
@@ -806,7 +806,7 @@ static int create_user_rq(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	if (!ucmd->buf_addr)
 		return -EINVAL;
 
-	rwq->umem = ib_umem_get(udata, ucmd->buf_addr, rwq->buf_size, 0, 0);
+	rwq->umem = ib_umem_get(udata, ucmd->buf_addr, rwq->buf_size, 0);
 	if (IS_ERR(rwq->umem)) {
 		mlx5_ib_dbg(dev, "umem_get failed\n");
 		err = PTR_ERR(rwq->umem);
diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index 4e7fde86c96b..62939df3c692 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -80,7 +80,7 @@ static int create_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
 
 	srq->wq_sig = !!(ucmd.flags & MLX5_SRQ_FLAG_SIGNATURE);
 
-	srq->umem = ib_umem_get(udata, ucmd.buf_addr, buf_size, 0, 0);
+	srq->umem = ib_umem_get(udata, ucmd.buf_addr, buf_size, 0);
 	if (IS_ERR(srq->umem)) {
 		mlx5_ib_dbg(dev, "failed umem get, size %d\n", buf_size);
 		err = PTR_ERR(srq->umem);
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 23554d8bf241..33002530fee7 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -880,9 +880,7 @@ static struct ib_mr *mthca_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
-	mr->umem = ib_umem_get(udata, start, length, acc,
-			       ucmd.mr_attrs & MTHCA_MR_DMASYNC);
-
+	mr->umem = ib_umem_get(udata, start, length, acc);
 	if (IS_ERR(mr->umem)) {
 		err = PTR_ERR(mr->umem);
 		goto err;
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index e8267e590772..222bafd215a0 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -875,7 +875,7 @@ struct ib_mr *ocrdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
 	if (!mr)
 		return ERR_PTR(status);
-	mr->umem = ib_umem_get(udata, start, len, acc, 0);
+	mr->umem = ib_umem_get(udata, start, len, acc);
 	if (IS_ERR(mr->umem)) {
 		status = -EFAULT;
 		goto umem_err;
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 6f3ce86019b7..6656e90fe540 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -697,7 +697,7 @@ static inline int qedr_align_cq_entries(int entries)
 static inline int qedr_init_user_queue(struct ib_udata *udata,
 				       struct qedr_dev *dev,
 				       struct qedr_userq *q, u64 buf_addr,
-				       size_t buf_len, int access, int dmasync,
+				       size_t buf_len, int access,
 				       int alloc_and_init)
 {
 	u32 fw_pages;
@@ -705,7 +705,7 @@ static inline int qedr_init_user_queue(struct ib_udata *udata,
 
 	q->buf_addr = buf_addr;
 	q->buf_len = buf_len;
-	q->umem = ib_umem_get(udata, q->buf_addr, q->buf_len, access, dmasync);
+	q->umem = ib_umem_get(udata, q->buf_addr, q->buf_len, access);
 	if (IS_ERR(q->umem)) {
 		DP_ERR(dev, "create user queue: failed ib_umem_get, got %ld\n",
 		       PTR_ERR(q->umem));
@@ -856,8 +856,7 @@ int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		cq->cq_type = QEDR_CQ_TYPE_USER;
 
 		rc = qedr_init_user_queue(udata, dev, &cq->q, ureq.addr,
-					  ureq.len, IB_ACCESS_LOCAL_WRITE, 1,
-					  1);
+					  ureq.len, IB_ACCESS_LOCAL_WRITE, 1);
 		if (rc)
 			goto err0;
 
@@ -1279,19 +1278,19 @@ static void qedr_free_srq_kernel_params(struct qedr_srq *srq)
 static int qedr_init_srq_user_params(struct ib_udata *udata,
 				     struct qedr_srq *srq,
 				     struct qedr_create_srq_ureq *ureq,
-				     int access, int dmasync)
+				     int access)
 {
 	struct scatterlist *sg;
 	int rc;
 
 	rc = qedr_init_user_queue(udata, srq->dev, &srq->usrq, ureq->srq_addr,
-				  ureq->srq_len, access, dmasync, 1);
+				  ureq->srq_len, access, 1);
 	if (rc)
 		return rc;
 
 	srq->prod_umem =
 		ib_umem_get(udata, ureq->prod_pair_addr,
-			    sizeof(struct rdma_srq_producers), access, dmasync);
+			    sizeof(struct rdma_srq_producers), access);
 	if (IS_ERR(srq->prod_umem)) {
 		qedr_free_pbl(srq->dev, &srq->usrq.pbl_info, srq->usrq.pbl_tbl);
 		ib_umem_release(srq->usrq.umem);
@@ -1387,7 +1386,7 @@ int qedr_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init_attr,
 			goto err0;
 		}
 
-		rc = qedr_init_srq_user_params(udata, srq, &ureq, 0, 0);
+		rc = qedr_init_srq_user_params(udata, srq, &ureq, 0);
 		if (rc)
 			goto err0;
 
@@ -1601,14 +1600,14 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
 
 	/* SQ - read access only (0), dma sync not required (0) */
 	rc = qedr_init_user_queue(udata, dev, &qp->usq, ureq.sq_addr,
-				  ureq.sq_len, 0, 0, alloc_and_init);
+				  ureq.sq_len, 0, alloc_and_init);
 	if (rc)
 		return rc;
 
 	if (!qp->srq) {
 		/* RQ - read access only (0), dma sync not required (0) */
 		rc = qedr_init_user_queue(udata, dev, &qp->urq, ureq.rq_addr,
-					  ureq.rq_len, 0, 0, alloc_and_init);
+					  ureq.rq_len, 0, alloc_and_init);
 		if (rc)
 			return rc;
 	}
@@ -2597,7 +2596,7 @@ struct ib_mr *qedr_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 
 	mr->type = QEDR_MR_USER;
 
-	mr->umem = ib_umem_get(udata, start, len, acc, 0);
+	mr->umem = ib_umem_get(udata, start, len, acc);
 	if (IS_ERR(mr->umem)) {
 		rc = -EFAULT;
 		goto err0;
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
index 7800e6930502..a26a4fd86bf4 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
@@ -136,7 +136,7 @@ int pvrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		}
 
 		cq->umem = ib_umem_get(udata, ucmd.buf_addr, ucmd.buf_size,
-				       IB_ACCESS_LOCAL_WRITE, 1);
+				       IB_ACCESS_LOCAL_WRITE);
 		if (IS_ERR(cq->umem)) {
 			ret = PTR_ERR(cq->umem);
 			goto err_cq;
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
index f3a3d22ee8d7..c61e665ff261 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
@@ -126,7 +126,7 @@ struct ib_mr *pvrdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 		return ERR_PTR(-EINVAL);
 	}
 
-	umem = ib_umem_get(udata, start, length, access_flags, 0);
+	umem = ib_umem_get(udata, start, length, access_flags);
 	if (IS_ERR(umem)) {
 		dev_warn(&dev->pdev->dev,
 			 "could not get umem for mem region\n");
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
index bca6a58a442e..9e5c4031d765 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
@@ -263,7 +263,7 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
 			if (!is_srq) {
 				/* set qp->sq.wqe_cnt, shift, buf_size.. */
 				qp->rumem = ib_umem_get(udata, ucmd.rbuf_addr,
-							ucmd.rbuf_size, 0, 0);
+							ucmd.rbuf_size, 0);
 				if (IS_ERR(qp->rumem)) {
 					ret = PTR_ERR(qp->rumem);
 					goto err_qp;
@@ -275,7 +275,7 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
 			}
 
 			qp->sumem = ib_umem_get(udata, ucmd.sbuf_addr,
-						ucmd.sbuf_size, 0, 0);
+						ucmd.sbuf_size, 0);
 			if (IS_ERR(qp->sumem)) {
 				if (!is_srq)
 					ib_umem_release(qp->rumem);
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
index 36cdfbdbd325..98c8be71d91d 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
@@ -146,7 +146,7 @@ int pvrdma_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init_attr,
 		goto err_srq;
 	}
 
-	srq->umem = ib_umem_get(udata, ucmd.buf_addr, ucmd.buf_size, 0, 0);
+	srq->umem = ib_umem_get(udata, ucmd.buf_addr, ucmd.buf_size, 0);
 	if (IS_ERR(srq->umem)) {
 		ret = PTR_ERR(srq->umem);
 		goto err_srq;
diff --git a/drivers/infiniband/sw/rdmavt/mr.c b/drivers/infiniband/sw/rdmavt/mr.c
index a6a39f01dca3..b9a76bf74857 100644
--- a/drivers/infiniband/sw/rdmavt/mr.c
+++ b/drivers/infiniband/sw/rdmavt/mr.c
@@ -390,7 +390,7 @@ struct ib_mr *rvt_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (length == 0)
 		return ERR_PTR(-EINVAL);
 
-	umem = ib_umem_get(udata, start, length, mr_access_flags, 0);
+	umem = ib_umem_get(udata, start, length, mr_access_flags);
 	if (IS_ERR(umem))
 		return (void *)umem;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index ea6a819b7167..35a2baf2f364 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -169,7 +169,7 @@ int rxe_mem_init_user(struct rxe_pd *pd, u64 start,
 	void			*vaddr;
 	int err;
 
-	umem = ib_umem_get(udata, start, length, access, 0);
+	umem = ib_umem_get(udata, start, length, access);
 	if (IS_ERR(umem)) {
 		pr_warn("err %d from rxe_umem_get\n",
 			(int)PTR_ERR(umem));
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index a91b2af64ec4..753f54e17e0a 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -70,7 +70,7 @@ static inline size_t ib_umem_num_pages(struct ib_umem *umem)
 #ifdef CONFIG_INFINIBAND_USER_MEM
 
 struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
-			    size_t size, int access, int dmasync);
+			    size_t size, int access);
 void ib_umem_release(struct ib_umem *umem);
 int ib_umem_page_count(struct ib_umem *umem);
 int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
@@ -85,7 +85,7 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
 
 static inline struct ib_umem *ib_umem_get(struct ib_udata *udata,
 					  unsigned long addr, size_t size,
-					  int access, int dmasync)
+					  int access)
 {
 	return ERR_PTR(-EINVAL);
 }
-- 
2.20.1

