Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF6254746C
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2019 14:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfFPMF1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 Jun 2019 08:05:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfFPMF1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 16 Jun 2019 08:05:27 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E96A920870;
        Sun, 16 Jun 2019 12:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560686725;
        bh=kO8/dGnYY1uvitXogD67iXQIZD6gFtWGe/Oh5w4xGpY=;
        h=From:To:Cc:Subject:Date:From;
        b=Wy2dOC+SOGOeGX6XHt941Dn6M8b7DiEL0zAWCtZnfvI/seoMKWMXlYotfdKV4//zK
         a1aSXEF73sPaaCui7sFF0+18rDq+juouoM4fqZXKrW4MzXHLExhxNyyEY/kgIsX5lr
         jm7VwvVBXCIcIFDDLDr+wLDEBPjsuUY57dsN8G/k=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next] RDMA: Check umem pointer validity prior to release
Date:   Sun, 16 Jun 2019 15:05:20 +0300
Message-Id: <20190616120520.12765-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Update ib_umem_release() to behave similarly to kfree() and allow
submitting NULL pointer as safe input to this function.

Fixes: a52c8e2469c3 ("RDMA: Clean destroy CQ in drivers do not return errors")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/umem.c               |  3 ++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c     | 29 ++++++--------------
 drivers/infiniband/hw/cxgb3/iwch_provider.c  |  3 +-
 drivers/infiniband/hw/cxgb4/mem.c            |  3 +-
 drivers/infiniband/hw/efa/efa_verbs.c        |  2 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c      |  8 ++----
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c   | 13 ++++-----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c   |  2 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c      |  4 +--
 drivers/infiniband/hw/hns/hns_roce_qp.c      |  5 ++--
 drivers/infiniband/hw/hns/hns_roce_srq.c     | 14 ++++------
 drivers/infiniband/hw/i40iw/i40iw_verbs.c    |  3 +-
 drivers/infiniband/hw/mlx4/cq.c              | 14 ++++------
 drivers/infiniband/hw/mlx4/qp.c              |  7 ++---
 drivers/infiniband/hw/mlx4/srq.c             |  7 ++---
 drivers/infiniband/hw/mlx5/cq.c              | 20 ++++----------
 drivers/infiniband/hw/mlx5/mr.c              | 13 ++++-----
 drivers/infiniband/hw/mlx5/qp.c              |  9 ++----
 drivers/infiniband/hw/mthca/mthca_provider.c |  3 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  |  3 +-
 drivers/infiniband/hw/qedr/verbs.c           |  9 ++----
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c |  6 ++--
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c |  3 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c | 16 +++--------
 drivers/infiniband/sw/rdmavt/mr.c            |  3 +-
 drivers/infiniband/sw/rxe/rxe_mr.c           |  3 +-
 26 files changed, 73 insertions(+), 132 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 79c347437d46..9ecd40b8a7be 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -401,6 +401,9 @@ static void __ib_umem_release_tail(struct ib_umem *umem)
  */
 void ib_umem_release(struct ib_umem *umem)
 {
+	if (!umem)
+		return;
+
 	if (umem->is_odp) {
 		ib_umem_odp_release(to_ib_umem_odp(umem));
 		__ib_umem_release_tail(umem);
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 68925f0a5ce4..5387d07633fd 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -805,10 +805,8 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 		rdev->sqp_ah = NULL;
 	}
 
-	if (!IS_ERR_OR_NULL(qp->rumem))
-		ib_umem_release(qp->rumem);
-	if (!IS_ERR_OR_NULL(qp->sumem))
-		ib_umem_release(qp->sumem);
+	ib_umem_release(qp->rumem);
+	ib_umem_release(qp->sumem);
 
 	mutex_lock(&rdev->qp_lock);
 	list_del(&qp->list);
@@ -1201,12 +1199,8 @@ struct ib_qp *bnxt_re_create_qp(struct ib_pd *ib_pd,
 qp_destroy:
 	bnxt_qplib_destroy_qp(&rdev->qplib_res, &qp->qplib_qp);
 free_umem:
-	if (udata) {
-		if (qp->rumem)
-			ib_umem_release(qp->rumem);
-		if (qp->sumem)
-			ib_umem_release(qp->sumem);
-	}
+	ib_umem_release(qp->rumem);
+	ib_umem_release(qp->sumem);
 fail:
 	kfree(qp);
 	return ERR_PTR(rc);
@@ -1302,8 +1296,7 @@ void bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
 	if (qplib_srq->cq)
 		nq = qplib_srq->cq->nq;
 	bnxt_qplib_destroy_srq(&rdev->qplib_res, qplib_srq);
-	if (srq->umem)
-		ib_umem_release(srq->umem);
+	ib_umem_release(srq->umem);
 	atomic_dec(&rdev->srq_count);
 	if (nq)
 		nq->budget--;
@@ -1412,8 +1405,7 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 	return 0;
 
 fail:
-	if (srq->umem)
-		ib_umem_release(srq->umem);
+	ib_umem_release(srq->umem);
 exit:
 	return rc;
 }
@@ -2528,8 +2520,7 @@ void bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	nq = cq->qplib_cq.nq;
 
 	bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
-	if (!cq->umem)
-		ib_umem_release(cq->umem);
+	ib_umem_release(cq->umem);
 
 	atomic_dec(&rdev->cq_count);
 	nq->budget--;
@@ -2632,8 +2623,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	return 0;
 
 c2fail:
-	if (udata)
-		ib_umem_release(cq->umem);
+	ib_umem_release(cq->umem);
 fail:
 	kfree(cq->cql);
 	return rc;
@@ -3340,8 +3330,7 @@ int bnxt_re_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 		mr->npages = 0;
 		mr->pages = NULL;
 	}
-	if (!IS_ERR_OR_NULL(mr->ib_umem))
-		ib_umem_release(mr->ib_umem);
+	ib_umem_release(mr->ib_umem);
 
 	kfree(mr);
 	atomic_dec(&rdev->mr_count);
diff --git a/drivers/infiniband/hw/cxgb3/iwch_provider.c b/drivers/infiniband/hw/cxgb3/iwch_provider.c
index 7c8d69c6a36b..d95054454916 100644
--- a/drivers/infiniband/hw/cxgb3/iwch_provider.c
+++ b/drivers/infiniband/hw/cxgb3/iwch_provider.c
@@ -346,8 +346,7 @@ static int iwch_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 	xa_erase_irq(&rhp->mrs, mmid);
 	if (mhp->kva)
 		kfree((void *) (unsigned long) mhp->kva);
-	if (mhp->umem)
-		ib_umem_release(mhp->umem);
+	ib_umem_release(mhp->umem);
 	pr_debug("%s mmid 0x%x ptr %p\n", __func__, mmid, mhp);
 	kfree(mhp);
 	return 0;
diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb4/mem.c
index 14eea43d9ca9..e75a48f94642 100644
--- a/drivers/infiniband/hw/cxgb4/mem.c
+++ b/drivers/infiniband/hw/cxgb4/mem.c
@@ -808,8 +808,7 @@ int c4iw_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 				  mhp->attr.pbl_size << 3);
 	if (mhp->kva)
 		kfree((void *) (unsigned long) mhp->kva);
-	if (mhp->umem)
-		ib_umem_release(mhp->umem);
+	ib_umem_release(mhp->umem);
 	pr_debug("mmid 0x%x ptr %p\n", mmid, mhp);
 	c4iw_put_wr_wait(mhp->wr_waitp);
 	kfree(mhp);
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index a9372c9e4b30..5e6e5eb65cff 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1513,8 +1513,8 @@ int efa_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 		err = efa_com_dereg_mr(&dev->edev, &params);
 		if (err)
 			return err;
-		ib_umem_release(mr->umem);
 	}
+	ib_umem_release(mr->umem);
 
 	kfree(mr);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 7e198c9ffbfe..6b4d8e50aabe 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -423,9 +423,8 @@ int hns_roce_ib_create_cq(struct ib_cq *ib_cq,
 
 err_mtt:
 	hns_roce_mtt_cleanup(hr_dev, &hr_cq->hr_buf.hr_mtt);
-	if (udata)
-		ib_umem_release(hr_cq->umem);
-	else
+	ib_umem_release(hr_cq->umem);
+	if (!udata)
 		hns_roce_ib_free_cq_buf(hr_dev, &hr_cq->hr_buf,
 					hr_cq->ib_cq.cqe);
 
@@ -451,9 +450,8 @@ void hns_roce_ib_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	hns_roce_free_cq(hr_dev, hr_cq);
 	hns_roce_mtt_cleanup(hr_dev, &hr_cq->hr_buf.hr_mtt);
 
+	ib_umem_release(hr_cq->umem);
 	if (udata) {
-		ib_umem_release(hr_cq->umem);
-
 		if (hr_cq->db_en == 1)
 			hns_roce_db_unmap_user(rdma_udata_to_drv_context(
 						       udata,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 50a320682bd1..cc1ea69d0f29 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -1164,8 +1164,7 @@ static int hns_roce_v1_dereg_mr(struct hns_roce_dev *hr_dev,
 	hns_roce_bitmap_free(&hr_dev->mr_table.mtpt_bitmap,
 			     key_to_hw_index(mr->key), 0);
 
-	if (mr->umem)
-		ib_umem_release(mr->umem);
+	ib_umem_release(mr->umem);
 
 	kfree(mr);
 
@@ -3642,9 +3641,8 @@ int hns_roce_v1_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 
 	hns_roce_mtt_cleanup(hr_dev, &hr_qp->mtt);
 
-	if (udata)
-		ib_umem_release(hr_qp->umem);
-	else {
+	ib_umem_release(hr_qp->umem);
+	if (!udata) {
 		kfree(hr_qp->sq.wrid);
 		kfree(hr_qp->rq.wrid);
 
@@ -3695,9 +3693,8 @@ static void hns_roce_v1_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 
 	hns_roce_mtt_cleanup(hr_dev, &hr_cq->hr_buf.hr_mtt);
 
-	if (ibcq->uobject)
-		ib_umem_release(hr_cq->umem);
-	else {
+	ib_umem_release(hr_cq->umem);
+	if (!udata) {
 		/* Free the buff of stored cq */
 		cq_buf_size = (ibcq->cqe + 1) * hr_dev->caps.cq_entry_sz;
 		hns_roce_buf_free(hr_dev, cq_buf_size, &hr_cq->hr_buf.hr_buf);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 2d27dc91a823..1b06c0421554 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4502,7 +4502,6 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 
 		if (hr_qp->rq.wqe_cnt && (hr_qp->rdb_en == 1))
 			hns_roce_db_unmap_user(context, &hr_qp->rdb);
-		ib_umem_release(hr_qp->umem);
 	} else {
 		kfree(hr_qp->sq.wrid);
 		kfree(hr_qp->rq.wrid);
@@ -4510,6 +4509,7 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 		if (hr_qp->rq.wqe_cnt)
 			hns_roce_free_db(hr_dev, &hr_qp->rdb);
 	}
+	ib_umem_release(hr_qp->umem);
 
 	if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE) &&
 	     hr_qp->rq.wqe_cnt) {
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index c888967fb653..a478aecb8304 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -1298,9 +1298,7 @@ int hns_roce_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	} else {
 		hns_roce_mr_free(hr_dev, mr);
 
-		if (mr->umem)
-			ib_umem_release(mr->umem);
-
+		ib_umem_release(mr->umem);
 		kfree(mr);
 	}
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 8db2817a249e..d86fee983880 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -833,10 +833,9 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	hns_roce_mtt_cleanup(hr_dev, &hr_qp->mtt);
 
 err_buf:
-	if (hr_qp->umem)
-		ib_umem_release(hr_qp->umem);
-	else
+	if (!hr_qp->umem)
 		hns_roce_buf_free(hr_dev, hr_qp->buff_size, &hr_qp->hr_buf);
+	ib_umem_release(hr_qp->umem);
 
 err_db:
 	if (!udata && hns_roce_qp_has_rq(init_attr) &&
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index c222f243953a..de645be8aa48 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -380,8 +380,7 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	hns_roce_mtt_cleanup(hr_dev, &srq->idx_que.mtt);
 
 err_idx_mtt:
-	if (udata)
-		ib_umem_release(srq->idx_que.umem);
+	ib_umem_release(srq->idx_que.umem);
 
 err_create_idx:
 	hns_roce_buf_free(hr_dev, srq->idx_que.buf_size,
@@ -392,9 +391,8 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	hns_roce_mtt_cleanup(hr_dev, &srq->mtt);
 
 err_buf:
-	if (udata)
-		ib_umem_release(srq->umem);
-	else
+	ib_umem_release(srq->umem);
+	if (!udata)
 		hns_roce_buf_free(hr_dev, srq_buf_size, &srq->buf);
 
 	return ret;
@@ -408,15 +406,15 @@ void hns_roce_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 	hns_roce_srq_free(hr_dev, srq);
 	hns_roce_mtt_cleanup(hr_dev, &srq->mtt);
 
-	if (ibsrq->uobject) {
+	if (udata) {
 		hns_roce_mtt_cleanup(hr_dev, &srq->idx_que.mtt);
-		ib_umem_release(srq->idx_que.umem);
-		ib_umem_release(srq->umem);
 	} else {
 		kvfree(srq->wrid);
 		hns_roce_buf_free(hr_dev, srq->max << srq->wqe_shift,
 				  &srq->buf);
 	}
+	ib_umem_release(srq->idx_que.umem);
+	ib_umem_release(srq->umem);
 }
 
 int hns_roce_init_srq_table(struct hns_roce_dev *hr_dev)
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index e79be21fcd92..835765495c4a 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -2007,8 +2007,7 @@ static int i40iw_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 	struct cqp_commands_info *cqp_info;
 	u32 stag_idx;
 
-	if (iwmr->region)
-		ib_umem_release(iwmr->region);
+	ib_umem_release(iwmr->region);
 
 	if (iwmr->type != IW_MEMREG_TYPE_MEM) {
 		/* region is released. only test for userness. */
diff --git a/drivers/infiniband/hw/mlx4/cq.c b/drivers/infiniband/hw/mlx4/cq.c
index 72f238ddafb5..a7d238d312f0 100644
--- a/drivers/infiniband/hw/mlx4/cq.c
+++ b/drivers/infiniband/hw/mlx4/cq.c
@@ -277,9 +277,8 @@ int mlx4_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 err_mtt:
 	mlx4_mtt_cleanup(dev->dev, &cq->buf.mtt);
 
-	if (udata)
-		ib_umem_release(cq->umem);
-	else
+	ib_umem_release(cq->umem);
+	if (!udata)
 		mlx4_ib_free_cq_buf(dev, &cq->buf, cq->ibcq.cqe);
 
 err_db:
@@ -468,11 +467,8 @@ int mlx4_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
 	kfree(cq->resize_buf);
 	cq->resize_buf = NULL;
 
-	if (cq->resize_umem) {
-		ib_umem_release(cq->resize_umem);
-		cq->resize_umem = NULL;
-	}
-
+	ib_umem_release(cq->resize_umem);
+	cq->resize_umem = NULL;
 out:
 	mutex_unlock(&cq->resize_mutex);
 
@@ -494,11 +490,11 @@ void mlx4_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
 				struct mlx4_ib_ucontext,
 				ibucontext),
 			&mcq->db);
-		ib_umem_release(mcq->umem);
 	} else {
 		mlx4_ib_free_cq_buf(dev, &mcq->buf, cq->cqe);
 		mlx4_db_free(dev->dev, &mcq->db);
 	}
+	ib_umem_release(mcq->umem);
 }
 
 static void dump_cqe(void *cqe)
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 7a9dc576b985..bd4aa04416c6 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -1284,10 +1284,9 @@ static int create_qp_common(struct ib_pd *pd, struct ib_qp_init_attr *init_attr,
 	mlx4_mtt_cleanup(dev->dev, &qp->mtt);
 
 err_buf:
-	if (qp->umem)
-		ib_umem_release(qp->umem);
-	else
+	if (!qp->umem)
 		mlx4_buf_free(dev->dev, qp->buf_size, &qp->buf);
+	ib_umem_release(qp->umem);
 
 err_db:
 	if (!udata && qp_has_rq(init_attr))
@@ -1498,7 +1497,6 @@ static void destroy_qp_common(struct mlx4_ib_dev *dev, struct mlx4_ib_qp *qp,
 
 			mlx4_ib_db_unmap_user(mcontext, &qp->db);
 		}
-		ib_umem_release(qp->umem);
 	} else {
 		kvfree(qp->sq.wrid);
 		kvfree(qp->rq.wrid);
@@ -1509,6 +1507,7 @@ static void destroy_qp_common(struct mlx4_ib_dev *dev, struct mlx4_ib_qp *qp,
 		if (qp->rq.wqe_cnt)
 			mlx4_db_free(dev->dev, &qp->db);
 	}
+	ib_umem_release(qp->umem);
 
 	del_gid_entries(qp);
 }
diff --git a/drivers/infiniband/hw/mlx4/srq.c b/drivers/infiniband/hw/mlx4/srq.c
index c9f555e04c9f..848db7264cc9 100644
--- a/drivers/infiniband/hw/mlx4/srq.c
+++ b/drivers/infiniband/hw/mlx4/srq.c
@@ -204,10 +204,9 @@ int mlx4_ib_create_srq(struct ib_srq *ib_srq,
 	mlx4_mtt_cleanup(dev->dev, &srq->mtt);
 
 err_buf:
-	if (srq->umem)
-		ib_umem_release(srq->umem);
-	else
+	if (!srq->umem)
 		mlx4_buf_free(dev->dev, buf_size, &srq->buf);
+	ib_umem_release(srq->umem);
 
 err_db:
 	if (!udata)
@@ -275,13 +274,13 @@ void mlx4_ib_destroy_srq(struct ib_srq *srq, struct ib_udata *udata)
 				struct mlx4_ib_ucontext,
 				ibucontext),
 			&msrq->db);
-		ib_umem_release(msrq->umem);
 	} else {
 		kvfree(msrq->wrid);
 		mlx4_buf_free(dev->dev, msrq->msrq.max << msrq->msrq.wqe_shift,
 			      &msrq->buf);
 		mlx4_db_free(dev->dev, &msrq->db);
 	}
+	ib_umem_release(msrq->umem);
 }
 
 void mlx4_ib_free_srq_wqe(struct mlx4_ib_srq *srq, int wqe_index)
diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index fa6d49d583fe..7a9f8a5a58dc 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -1126,11 +1126,6 @@ static int resize_user(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *cq,
 	return 0;
 }
 
-static void un_resize_user(struct mlx5_ib_cq *cq)
-{
-	ib_umem_release(cq->resize_umem);
-}
-
 static int resize_kernel(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *cq,
 			 int entries, int cqe_size)
 {
@@ -1153,12 +1148,6 @@ static int resize_kernel(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *cq,
 	return err;
 }
 
-static void un_resize_kernel(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *cq)
-{
-	free_cq_buf(dev, cq->resize_buf);
-	cq->resize_buf = NULL;
-}
-
 static int copy_resize_cqes(struct mlx5_ib_cq *cq)
 {
 	struct mlx5_ib_dev *dev = to_mdev(cq->ibcq.device);
@@ -1339,10 +1328,11 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
 	kvfree(in);
 
 ex_resize:
-	if (udata)
-		un_resize_user(cq);
-	else
-		un_resize_kernel(dev, cq);
+	ib_umem_release(cq->resize_umem);
+	if (!udata) {
+		free_cq_buf(dev, cq->resize_buf);
+		cq->resize_buf = NULL;
+	}
 ex:
 	mutex_unlock(&cq->resize_mutex);
 	return err;
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 94818d434b3e..926ace5339c1 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1510,10 +1510,9 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 	return 0;
 
 err:
-	if (mr->umem) {
-		ib_umem_release(mr->umem);
-		mr->umem = NULL;
-	}
+	ib_umem_release(mr->umem);
+	mr->umem = NULL;
+
 	clean_mr(dev, mr);
 	return err;
 }
@@ -1633,10 +1632,10 @@ static void dereg_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 	 * remove the DMA mapping.
 	 */
 	mlx5_mr_cache_free(dev, mr);
-	if (umem) {
-		ib_umem_release(umem);
+	ib_umem_release(umem);
+	if (umem)
 		atomic_sub(npages, &dev->mdev->priv.reg_pages);
-	}
+
 	if (!mr->allocated_from_cache)
 		kfree(mr);
 }
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 352bac1af57d..f7dac3e045e7 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -788,8 +788,7 @@ static void destroy_user_rq(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		atomic_dec(&dev->delay_drop.rqs_cnt);
 
 	mlx5_ib_db_unmap_user(context, &rwq->db);
-	if (rwq->umem)
-		ib_umem_release(rwq->umem);
+	ib_umem_release(rwq->umem);
 }
 
 static int create_user_rq(struct mlx5_ib_dev *dev, struct ib_pd *pd,
@@ -975,8 +974,7 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	kvfree(*in);
 
 err_umem:
-	if (ubuffer->umem)
-		ib_umem_release(ubuffer->umem);
+	ib_umem_release(ubuffer->umem);
 
 err_bfreg:
 	if (bfregn != MLX5_IB_INVALID_BFREG)
@@ -995,8 +993,7 @@ static void destroy_qp_user(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			ibucontext);
 
 	mlx5_ib_db_unmap_user(context, &qp->db);
-	if (base->ubuffer.umem)
-		ib_umem_release(base->ubuffer.umem);
+	ib_umem_release(base->ubuffer.umem);
 
 	/*
 	 * Free only the BFREGs which are handled by the kernel.
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 58050c180d26..4064a6de57fa 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -956,8 +956,7 @@ static int mthca_dereg_mr(struct ib_mr *mr, struct ib_udata *udata)
 	struct mthca_mr *mmr = to_mmr(mr);
 
 	mthca_free_mr(to_mdev(mr->device), mmr);
-	if (mmr->umem)
-		ib_umem_release(mmr->umem);
+	ib_umem_release(mmr->umem);
 	kfree(mmr);
 
 	return 0;
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index b6159444755c..5ef619745d98 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -925,8 +925,7 @@ int ocrdma_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 	ocrdma_free_mr_pbl_tbl(dev, &mr->hwmr);
 
 	/* it could be user registered memory. */
-	if (mr->umem)
-		ib_umem_release(mr->umem);
+	ib_umem_release(mr->umem);
 	kfree(mr);
 
 	/* Don't stop cleanup, in case FW is unresponsive */
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index f7eadc42dd77..9a08b9a82e4c 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1572,12 +1572,10 @@ qedr_iwarp_populate_user_qp(struct qedr_dev *dev,
 
 static void qedr_cleanup_user(struct qedr_dev *dev, struct qedr_qp *qp)
 {
-	if (qp->usq.umem)
-		ib_umem_release(qp->usq.umem);
+	ib_umem_release(qp->usq.umem);
 	qp->usq.umem = NULL;
 
-	if (qp->urq.umem)
-		ib_umem_release(qp->urq.umem);
+	ib_umem_release(qp->urq.umem);
 	qp->urq.umem = NULL;
 }
 
@@ -2680,8 +2678,7 @@ int qedr_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 		qedr_free_pbl(dev, &mr->info.pbl_info, mr->info.pbl_table);
 
 	/* it could be user registered memory. */
-	if (mr->umem)
-		ib_umem_release(mr->umem);
+	ib_umem_release(mr->umem);
 
 	kfree(mr);
 
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
index 38573fc0a9bf..7800e6930502 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
@@ -213,8 +213,7 @@ int pvrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 err_page_dir:
 	pvrdma_page_dir_cleanup(dev, &cq->pdir);
 err_umem:
-	if (!cq->is_kernel)
-		ib_umem_release(cq->umem);
+	ib_umem_release(cq->umem);
 err_cq:
 	atomic_dec(&dev->num_cqs);
 	return ret;
@@ -226,8 +225,7 @@ static void pvrdma_free_cq(struct pvrdma_dev *dev, struct pvrdma_cq *cq)
 		complete(&cq->free);
 	wait_for_completion(&cq->free);
 
-	if (!cq->is_kernel)
-		ib_umem_release(cq->umem);
+	ib_umem_release(cq->umem);
 
 	pvrdma_page_dir_cleanup(dev, &cq->pdir);
 }
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
index da55454c7f73..074740af1979 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
@@ -290,8 +290,7 @@ int pvrdma_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 			 "could not deregister mem region, error: %d\n", ret);
 
 	pvrdma_page_dir_cleanup(dev, &mr->pdir);
-	if (mr->umem)
-		ib_umem_release(mr->umem);
+	ib_umem_release(mr->umem);
 
 	kfree(mr->pages);
 	kfree(mr);
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
index 0eaaead5baec..bca6a58a442e 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
@@ -391,12 +391,8 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
 err_pdir:
 	pvrdma_page_dir_cleanup(dev, &qp->pdir);
 err_umem:
-	if (!qp->is_kernel) {
-		if (qp->rumem)
-			ib_umem_release(qp->rumem);
-		if (qp->sumem)
-			ib_umem_release(qp->sumem);
-	}
+	ib_umem_release(qp->rumem);
+	ib_umem_release(qp->sumem);
 err_qp:
 	kfree(qp);
 	atomic_dec(&dev->num_qps);
@@ -429,12 +425,8 @@ static void pvrdma_free_qp(struct pvrdma_qp *qp)
 		complete(&qp->free);
 	wait_for_completion(&qp->free);
 
-	if (!qp->is_kernel) {
-		if (qp->rumem)
-			ib_umem_release(qp->rumem);
-		if (qp->sumem)
-			ib_umem_release(qp->sumem);
-	}
+	ib_umem_release(qp->rumem);
+	ib_umem_release(qp->sumem);
 
 	pvrdma_page_dir_cleanup(dev, &qp->pdir);
 
diff --git a/drivers/infiniband/sw/rdmavt/mr.c b/drivers/infiniband/sw/rdmavt/mr.c
index 54f3f9c27552..db800eb2b1f5 100644
--- a/drivers/infiniband/sw/rdmavt/mr.c
+++ b/drivers/infiniband/sw/rdmavt/mr.c
@@ -560,8 +560,7 @@ int rvt_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	if (ret)
 		goto out;
 	rvt_deinit_mregion(&mr->mr);
-	if (mr->umem)
-		ib_umem_release(mr->umem);
+	ib_umem_release(mr->umem);
 	kfree(mr);
 out:
 	return ret;
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index f501f72489d8..ea6a819b7167 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -96,8 +96,7 @@ void rxe_mem_cleanup(struct rxe_pool_entry *arg)
 	struct rxe_mem *mem = container_of(arg, typeof(*mem), pelem);
 	int i;
 
-	if (mem->umem)
-		ib_umem_release(mem->umem);
+	ib_umem_release(mem->umem);
 
 	if (mem->map) {
 		for (i = 0; i < mem->num_map; i++)
-- 
2.20.1

