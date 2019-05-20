Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9370B22C5E
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 08:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbfETGzH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 02:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730826AbfETGzH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 02:55:07 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00FFB20863;
        Mon, 20 May 2019 06:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558335305;
        bh=zohb5eNuxyo3HJq7Rq8Tv19Eo3JGFfCHUXmhTE2uXSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ueryzaukx/q9q4QT92OLLQdnkAwxuSmgrYBjyjmFFWN/4K++DaPwdmI71D+SBYHeP
         1L0zlYKVn1Ma4HptBDd0ODWmK0hSlUXMor+kC77AUpIk7VJe4lOChQqr1EmaQ6sYqZ
         OjfdUIlnXAcdBOrFfrCKD9raYa1xyplLdxZvdDb8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Glenn Streiff <gstreiff@neteffect.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH rdma-next 09/15] RDMA: Clean destroy CQ in drivers do not return errors
Date:   Mon, 20 May 2019 09:54:27 +0300
Message-Id: <20190520065433.8734-10-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520065433.8734-1-leon@kernel.org>
References: <20190520065433.8734-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Like all other destroy commands, .destroy_cq() call is not supposed
to fail. In all flows, the attempt to return earlier caused to memory
leaks.

This patch converts .destroy_cq() to do not return any errors.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cq.c                  |  5 +-
 drivers/infiniband/core/verbs.c               |  3 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      | 13 ++---
 drivers/infiniband/hw/bnxt_re/ib_verbs.h      |  2 +-
 drivers/infiniband/hw/cxgb3/cxio_hal.c        |  6 +--
 drivers/infiniband/hw/cxgb3/cxio_hal.h        |  2 +-
 drivers/infiniband/hw/cxgb3/iwch_provider.c   |  8 +---
 drivers/infiniband/hw/cxgb4/cq.c              | 13 ++---
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |  2 +-
 drivers/infiniband/hw/efa/efa.h               |  2 +-
 drivers/infiniband/hw/efa/efa_verbs.c         |  9 +---
 drivers/infiniband/hw/hns/hns_roce_cq.c       | 48 +++++++++----------
 drivers/infiniband/hw/hns/hns_roce_device.h   |  4 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c    | 14 ++----
 drivers/infiniband/hw/i40iw/i40iw_verbs.c     |  3 +-
 drivers/infiniband/hw/mlx4/cq.c               |  4 +-
 drivers/infiniband/hw/mlx4/mlx4_ib.h          |  2 +-
 drivers/infiniband/hw/mlx5/cq.c               |  4 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  2 +-
 drivers/infiniband/hw/mthca/mthca_provider.c  |  4 +-
 drivers/infiniband/hw/nes/nes_utils.c         |  4 +-
 drivers/infiniband/hw/nes/nes_verbs.c         | 30 ++++--------
 drivers/infiniband/hw/ocrdma/ocrdma_hw.c      |  8 ++--
 drivers/infiniband/hw/ocrdma/ocrdma_hw.h      |  2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  6 +--
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h   |  2 +-
 drivers/infiniband/hw/qedr/verbs.c            | 20 +-------
 drivers/infiniband/hw/qedr/verbs.h            |  2 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c  |  4 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.h  |  2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c  |  6 +--
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |  2 +-
 drivers/infiniband/sw/rdmavt/cq.c             |  6 +--
 drivers/infiniband/sw/rdmavt/cq.h             |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c         |  3 +-
 include/rdma/ib_verbs.h                       |  2 +-
 36 files changed, 82 insertions(+), 169 deletions(-)

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index a4c81992267c..de9fd7089349 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -207,8 +207,6 @@ EXPORT_SYMBOL(__ib_alloc_cq_user);
  */
 void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 {
-	int ret;
-
 	if (WARN_ON_ONCE(atomic_read(&cq->usecnt)))
 		return;
 
@@ -228,7 +226,6 @@ void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 
 	kfree(cq->wc);
 	rdma_restrack_del(&cq->res);
-	ret = cq->device->ops.destroy_cq(cq, udata);
-	WARN_ON_ONCE(ret);
+	cq->device->ops.destroy_cq(cq, udata);
 }
 EXPORT_SYMBOL(ib_free_cq_user);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index b09d4eb05b07..78103a95943e 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1958,7 +1958,8 @@ int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 		return -EBUSY;
 
 	rdma_restrack_del(&cq->res);
-	return cq->device->ops.destroy_cq(cq, udata);
+	cq->device->ops.destroy_cq(cq, udata);
+	return 0;
 }
 EXPORT_SYMBOL(ib_destroy_cq_user);
 
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 2c3685faa57a..a3c65e45a2bc 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2517,9 +2517,8 @@ int bnxt_re_post_recv(struct ib_qp *ib_qp, const struct ib_recv_wr *wr,
 }
 
 /* Completion Queues */
-int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
+void bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 {
-	int rc;
 	struct bnxt_re_cq *cq;
 	struct bnxt_qplib_nq *nq;
 	struct bnxt_re_dev *rdev;
@@ -2528,20 +2527,14 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	rdev = cq->rdev;
 	nq = cq->qplib_cq.nq;
 
-	rc = bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
-	if (rc) {
-		dev_err(rdev_to_dev(rdev), "Failed to destroy HW CQ");
-		return rc;
-	}
-	if (!IS_ERR_OR_NULL(cq->umem))
+	bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
+	if (!cq->umem)
 		ib_umem_release(cq->umem);
 
 	atomic_dec(&rdev->cq_count);
 	nq->budget--;
 	kfree(cq->cql);
 	kfree(cq);
-
-	return 0;
 }
 
 struct ib_cq *bnxt_re_create_cq(struct ib_device *ibdev,
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 09a33049e42f..828403ee0104 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -193,7 +193,7 @@ int bnxt_re_post_recv(struct ib_qp *qp, const struct ib_recv_wr *recv_wr,
 struct ib_cq *bnxt_re_create_cq(struct ib_device *ibdev,
 				const struct ib_cq_init_attr *attr,
 				struct ib_udata *udata);
-int bnxt_re_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
+void bnxt_re_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 int bnxt_re_poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc);
 int bnxt_re_req_notify_cq(struct ib_cq *cq, enum ib_cq_notify_flags flags);
 struct ib_mr *bnxt_re_get_dma_mr(struct ib_pd *pd, int mr_access_flags);
diff --git a/drivers/infiniband/hw/cxgb3/cxio_hal.c b/drivers/infiniband/hw/cxgb3/cxio_hal.c
index 8ac72ac7cbac..11ba482345ab 100644
--- a/drivers/infiniband/hw/cxgb3/cxio_hal.c
+++ b/drivers/infiniband/hw/cxgb3/cxio_hal.c
@@ -317,17 +317,15 @@ int cxio_create_qp(struct cxio_rdev *rdev_p, u32 kernel_domain,
 	return -ENOMEM;
 }
 
-int cxio_destroy_cq(struct cxio_rdev *rdev_p, struct t3_cq *cq)
+void cxio_destroy_cq(struct cxio_rdev *rdev_p, struct t3_cq *cq)
 {
-	int err;
-	err = cxio_hal_clear_cq_ctx(rdev_p, cq->cqid);
+	cxio_hal_clear_cq_ctx(rdev_p, cq->cqid);
 	kfree(cq->sw_queue);
 	dma_free_coherent(&(rdev_p->rnic_info.pdev->dev),
 			  (1UL << (cq->size_log2))
 			  * sizeof(struct t3_cqe) + 1, cq->queue,
 			  dma_unmap_addr(cq, mapping));
 	cxio_hal_put_cqid(rdev_p->rscp, cq->cqid);
-	return err;
 }
 
 int cxio_destroy_qp(struct cxio_rdev *rdev_p, struct t3_wq *wq,
diff --git a/drivers/infiniband/hw/cxgb3/cxio_hal.h b/drivers/infiniband/hw/cxgb3/cxio_hal.h
index c64e50b5a548..074932970d1c 100644
--- a/drivers/infiniband/hw/cxgb3/cxio_hal.h
+++ b/drivers/infiniband/hw/cxgb3/cxio_hal.h
@@ -158,7 +158,7 @@ void cxio_rdev_close(struct cxio_rdev *rdev);
 int cxio_hal_cq_op(struct cxio_rdev *rdev, struct t3_cq *cq,
 		   enum t3_cq_opcode op, u32 credit);
 int cxio_create_cq(struct cxio_rdev *rdev, struct t3_cq *cq, int kernel);
-int cxio_destroy_cq(struct cxio_rdev *rdev, struct t3_cq *cq);
+void cxio_destroy_cq(struct cxio_rdev *rdev, struct t3_cq *cq);
 int cxio_resize_cq(struct cxio_rdev *rdev, struct t3_cq *cq);
 void cxio_release_ucontext(struct cxio_rdev *rdev, struct cxio_ucontext *uctx);
 void cxio_init_ucontext(struct cxio_rdev *rdev, struct cxio_ucontext *uctx);
diff --git a/drivers/infiniband/hw/cxgb3/iwch_provider.c b/drivers/infiniband/hw/cxgb3/iwch_provider.c
index 3a481dfb1607..a0408933786c 100644
--- a/drivers/infiniband/hw/cxgb3/iwch_provider.c
+++ b/drivers/infiniband/hw/cxgb3/iwch_provider.c
@@ -88,7 +88,7 @@ static int iwch_alloc_ucontext(struct ib_ucontext *ucontext,
 	return 0;
 }
 
-static int iwch_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
+static void iwch_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 {
 	struct iwch_cq *chp;
 
@@ -101,7 +101,6 @@ static int iwch_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 
 	cxio_destroy_cq(&chp->rhp->rdev, &chp->cq);
 	kfree(chp);
-	return 0;
 }
 
 static struct ib_cq *iwch_create_cq(struct ib_device *ibdev,
@@ -263,10 +262,7 @@ static int iwch_resize_cq(struct ib_cq *cq, int cqe, struct ib_udata *udata)
 
 	/* destroy old t3_cq */
 	oldcq.cqid = newcq.cqid;
-	ret = cxio_destroy_cq(&chp->rhp->rdev, &oldcq);
-	if (ret) {
-		pr_err("%s - cxio_destroy_cq failed %d\n", __func__, ret);
-	}
+	cxio_destroy_cq(&chp->rhp->rdev, &oldcq);
 
 	/* add user hooks here */
 
diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
index 52ce586621c6..2b8c7ab62bb6 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -34,14 +34,13 @@
 
 #include "iw_cxgb4.h"
 
-static int destroy_cq(struct c4iw_rdev *rdev, struct t4_cq *cq,
-		      struct c4iw_dev_ucontext *uctx, struct sk_buff *skb,
-		      struct c4iw_wr_wait *wr_waitp)
+static void destroy_cq(struct c4iw_rdev *rdev, struct t4_cq *cq,
+		       struct c4iw_dev_ucontext *uctx, struct sk_buff *skb,
+		       struct c4iw_wr_wait *wr_waitp)
 {
 	struct fw_ri_res_wr *res_wr;
 	struct fw_ri_res *res;
 	int wr_len;
-	int ret;
 
 	wr_len = sizeof *res_wr + sizeof *res;
 	set_wr_txq(skb, CPL_PRIORITY_CONTROL, 0);
@@ -59,14 +58,13 @@ static int destroy_cq(struct c4iw_rdev *rdev, struct t4_cq *cq,
 	res->u.cq.iqid = cpu_to_be32(cq->cqid);
 
 	c4iw_init_wr_wait(wr_waitp);
-	ret = c4iw_ref_send_wait(rdev, skb, wr_waitp, 0, 0, __func__);
+	c4iw_ref_send_wait(rdev, skb, wr_waitp, 0, 0, __func__);
 
 	kfree(cq->sw_queue);
 	dma_free_coherent(&(rdev->lldi.pdev->dev),
 			  cq->memsize, cq->queue,
 			  dma_unmap_addr(cq, mapping));
 	c4iw_put_cqid(rdev, cq->cqid, uctx);
-	return ret;
 }
 
 static int create_cq(struct c4iw_rdev *rdev, struct t4_cq *cq,
@@ -970,7 +968,7 @@ int c4iw_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
 	return !err || err == -ENODATA ? npolled : err;
 }
 
-int c4iw_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
+void c4iw_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 {
 	struct c4iw_cq *chp;
 	struct c4iw_ucontext *ucontext;
@@ -989,7 +987,6 @@ int c4iw_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 		   chp->destroy_skb, chp->wr_waitp);
 	c4iw_put_wr_wait(chp->wr_waitp);
 	kfree(chp);
-	return 0;
 }
 
 struct ib_cq *c4iw_create_cq(struct ib_device *ibdev,
diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index 916ef982172e..7e014c33c718 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -992,7 +992,7 @@ struct ib_mr *c4iw_reg_user_mr(struct ib_pd *pd, u64 start,
 					   struct ib_udata *udata);
 struct ib_mr *c4iw_get_dma_mr(struct ib_pd *pd, int acc);
 int c4iw_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata);
-int c4iw_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata);
+void c4iw_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata);
 struct ib_cq *c4iw_create_cq(struct ib_device *ibdev,
 			     const struct ib_cq_init_attr *attr,
 			     struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 9e3cc3239c13..8d8d3bd47c35 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -136,7 +136,7 @@ int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata);
 struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
 			    struct ib_qp_init_attr *init_attr,
 			    struct ib_udata *udata);
-int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
+void efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
 struct ib_cq *efa_create_cq(struct ib_device *ibdev,
 			    const struct ib_cq_init_attr *attr,
 			    struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 4999a74cee24..e57f8adde174 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -847,25 +847,20 @@ static int efa_destroy_cq_idx(struct efa_dev *dev, int cq_idx)
 	return efa_com_destroy_cq(&dev->edev, &params);
 }
 
-int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
+void efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 {
 	struct efa_dev *dev = to_edev(ibcq->device);
 	struct efa_cq *cq = to_ecq(ibcq);
-	int err;
 
 	ibdev_dbg(&dev->ibdev,
 		  "Destroy cq[%d] virt[0x%p] freed: size[%lu], dma[%pad]\n",
 		  cq->cq_idx, cq->cpu_addr, cq->size, &cq->dma_addr);
 
-	err = efa_destroy_cq_idx(dev, cq->cq_idx);
-	if (err)
-		return err;
-
+	efa_destroy_cq_idx(dev, cq->cq_idx);
 	dma_unmap_single(&dev->pdev->dev, cq->dma_addr, cq->size,
 			 DMA_FROM_DEVICE);
 
 	kfree(cq);
-	return 0;
 }
 
 static int cq_mmap_entries_setup(struct efa_dev *dev, struct efa_cq *cq,
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 6e81ff3f1813..0eb7c16c007b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -443,40 +443,36 @@ struct ib_cq *hns_roce_ib_create_cq(struct ib_device *ib_dev,
 }
 EXPORT_SYMBOL_GPL(hns_roce_ib_create_cq);
 
-int hns_roce_ib_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
+void hns_roce_ib_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ib_cq->device);
 	struct hns_roce_cq *hr_cq = to_hr_cq(ib_cq);
-	int ret = 0;
 
 	if (hr_dev->hw->destroy_cq) {
-		ret = hr_dev->hw->destroy_cq(ib_cq, udata);
-	} else {
-		hns_roce_free_cq(hr_dev, hr_cq);
-		hns_roce_mtt_cleanup(hr_dev, &hr_cq->hr_buf.hr_mtt);
-
-		if (udata) {
-			ib_umem_release(hr_cq->umem);
-
-			if (hr_cq->db_en == 1)
-				hns_roce_db_unmap_user(
-					rdma_udata_to_drv_context(
-						udata,
-						struct hns_roce_ucontext,
-						ibucontext),
-					&hr_cq->db);
-		} else {
-			/* Free the buff of stored cq */
-			hns_roce_ib_free_cq_buf(hr_dev, &hr_cq->hr_buf,
-						ib_cq->cqe);
-			if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB)
-				hns_roce_free_db(hr_dev, &hr_cq->db);
-		}
+		hr_dev->hw->destroy_cq(ib_cq, udata);
+		return;
+	}
+
+	hns_roce_free_cq(hr_dev, hr_cq);
+	hns_roce_mtt_cleanup(hr_dev, &hr_cq->hr_buf.hr_mtt);
 
-		kfree(hr_cq);
+	if (udata) {
+		ib_umem_release(hr_cq->umem);
+
+		if (hr_cq->db_en == 1)
+			hns_roce_db_unmap_user(rdma_udata_to_drv_context(
+						       udata,
+						       struct hns_roce_ucontext,
+						       ibucontext),
+					       &hr_cq->db);
+	} else {
+		/* Free the buff of stored cq */
+		hns_roce_ib_free_cq_buf(hr_dev, &hr_cq->hr_buf, ib_cq->cqe);
+		if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB)
+			hns_roce_free_db(hr_dev, &hr_cq->db);
 	}
 
-	return ret;
+	kfree(hr_cq);
 }
 EXPORT_SYMBOL_GPL(hns_roce_ib_destroy_cq);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 563cf39df6d5..a6936aa0fde6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -921,7 +921,7 @@ struct hns_roce_hw {
 	int (*poll_cq)(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc);
 	int (*dereg_mr)(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr,
 			struct ib_udata *udata);
-	int (*destroy_cq)(struct ib_cq *ibcq, struct ib_udata *udata);
+	void (*destroy_cq)(struct ib_cq *ibcq, struct ib_udata *udata);
 	int (*modify_cq)(struct ib_cq *cq, u16 cq_count, u16 cq_period);
 	int (*init_eq)(struct hns_roce_dev *hr_dev);
 	void (*cleanup_eq)(struct hns_roce_dev *hr_dev);
@@ -1182,7 +1182,7 @@ struct ib_cq *hns_roce_ib_create_cq(struct ib_device *ib_dev,
 				    const struct ib_cq_init_attr *attr,
 				    struct ib_udata *udata);
 
-int hns_roce_ib_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata);
+void hns_roce_ib_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata);
 void hns_roce_free_cq(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq);
 
 int hns_roce_db_map_user(struct hns_roce_ucontext *context,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index e068a02122f5..955f36352d20 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -865,8 +865,7 @@ static int hns_roce_v1_rsv_lp_qp(struct hns_roce_dev *hr_dev)
 	kfree(pd);
 
 alloc_mem_failed:
-	if (hns_roce_ib_destroy_cq(cq, NULL))
-		dev_err(dev, "Destroy cq for create_lp_qp failed!\n");
+	hns_roce_ib_destroy_cq(cq, NULL);
 
 	return ret;
 }
@@ -894,10 +893,7 @@ static void hns_roce_v1_release_lp_qp(struct hns_roce_dev *hr_dev)
 				i, ret);
 	}
 
-	ret = hns_roce_ib_destroy_cq(&free_mr->mr_free_cq->ib_cq, NULL);
-	if (ret)
-		dev_err(dev, "Destroy cq for mr_free failed(%d)!\n", ret);
-
+	hns_roce_ib_destroy_cq(&free_mr->mr_free_cq->ib_cq, NULL);
 	hns_roce_dealloc_pd(&free_mr->mr_free_pd->ibpd, NULL);
 	kfree(&free_mr->mr_free_pd->ibpd);
 }
@@ -3649,7 +3645,7 @@ int hns_roce_v1_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	return 0;
 }
 
-static int hns_roce_v1_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
+static void hns_roce_v1_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibcq->device);
 	struct hns_roce_cq *hr_cq = to_hr_cq(ibcq);
@@ -3658,7 +3654,6 @@ static int hns_roce_v1_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	u32 cqe_cnt_cur;
 	u32 cq_buf_size;
 	int wait_time = 0;
-	int ret = 0;
 
 	hns_roce_free_cq(hr_dev, hr_cq);
 
@@ -3680,7 +3675,6 @@ static int hns_roce_v1_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 		if (wait_time > HNS_ROCE_MAX_FREE_CQ_WAIT_CNT) {
 			dev_warn(dev, "Destroy cq 0x%lx timeout!\n",
 				hr_cq->cqn);
-			ret = -ETIMEDOUT;
 			break;
 		}
 		wait_time++;
@@ -3697,8 +3691,6 @@ static int hns_roce_v1_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	}
 
 	kfree(hr_cq);
-
-	return ret;
 }
 
 static void set_eq_cons_index_v1(struct hns_roce_eq *eq, int req_not)
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index a10a30d44b32..3c4f8e015d6a 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -1064,7 +1064,7 @@ void i40iw_cq_wq_destroy(struct i40iw_device *iwdev, struct i40iw_sc_cq *cq)
  * @ib_cq: cq pointer
  * @udata: user data or NULL for kernel object
  */
-static int i40iw_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
+static void i40iw_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 {
 	struct i40iw_cq *iwcq;
 	struct i40iw_device *iwdev;
@@ -1077,7 +1077,6 @@ static int i40iw_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	cq_free_resources(iwdev, iwcq);
 	kfree(iwcq);
 	i40iw_rem_devusecount(iwdev);
-	return 0;
 }
 
 /**
diff --git a/drivers/infiniband/hw/mlx4/cq.c b/drivers/infiniband/hw/mlx4/cq.c
index 022a0b4ea452..8eb7490dabb8 100644
--- a/drivers/infiniband/hw/mlx4/cq.c
+++ b/drivers/infiniband/hw/mlx4/cq.c
@@ -486,7 +486,7 @@ int mlx4_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
 	return err;
 }
 
-int mlx4_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
+void mlx4_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
 {
 	struct mlx4_ib_dev *dev = to_mdev(cq->device);
 	struct mlx4_ib_cq *mcq = to_mcq(cq);
@@ -508,8 +508,6 @@ int mlx4_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
 	}
 
 	kfree(mcq);
-
-	return 0;
 }
 
 static void dump_cqe(void *cqe)
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index 26897102057d..af5ee45a9f19 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -746,7 +746,7 @@ int mlx4_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata);
 struct ib_cq *mlx4_ib_create_cq(struct ib_device *ibdev,
 				const struct ib_cq_init_attr *attr,
 				struct ib_udata *udata);
-int mlx4_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
+void mlx4_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 int mlx4_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc);
 int mlx4_ib_arm_cq(struct ib_cq *cq, enum ib_cq_notify_flags flags);
 void __mlx4_ib_cq_clean(struct mlx4_ib_cq *cq, u32 qpn, struct mlx4_ib_srq *srq);
diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 2e2e65f00257..ebd01bd7f8f6 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -998,7 +998,7 @@ struct ib_cq *mlx5_ib_create_cq(struct ib_device *ibdev,
 	return ERR_PTR(err);
 }
 
-int mlx5_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
+void mlx5_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
 {
 	struct mlx5_ib_dev *dev = to_mdev(cq->device);
 	struct mlx5_ib_cq *mcq = to_mcq(cq);
@@ -1010,8 +1010,6 @@ int mlx5_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
 		destroy_cq_kernel(dev, mcq);
 
 	kfree(mcq);
-
-	return 0;
 }
 
 static int is_equal_rsn(struct mlx5_cqe64 *cqe64, u32 rsn)
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 228ceac13d4d..3466d0c0c18c 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1122,7 +1122,7 @@ int mlx5_ib_read_user_wqe_srq(struct mlx5_ib_srq *srq, int wqe_index,
 struct ib_cq *mlx5_ib_create_cq(struct ib_device *ibdev,
 				const struct ib_cq_init_attr *attr,
 				struct ib_udata *udata);
-int mlx5_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
+void mlx5_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 int mlx5_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc);
 int mlx5_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
 int mlx5_ib_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period);
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 4f40dfedf920..2c6a1ee0d6cc 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -804,7 +804,7 @@ static int mthca_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *uda
 	return ret;
 }
 
-static int mthca_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
+static void mthca_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
 {
 	if (udata) {
 		struct mthca_ucontext *context =
@@ -824,8 +824,6 @@ static int mthca_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
 	}
 	mthca_free_cq(to_mdev(cq->device), to_mcq(cq));
 	kfree(cq);
-
-	return 0;
 }
 
 static inline u32 convert_access(int acc)
diff --git a/drivers/infiniband/hw/nes/nes_utils.c b/drivers/infiniband/hw/nes/nes_utils.c
index 90f28890246d..e976292fc6c0 100644
--- a/drivers/infiniband/hw/nes/nes_utils.c
+++ b/drivers/infiniband/hw/nes/nes_utils.c
@@ -588,9 +588,7 @@ struct nes_cqp_request *nes_get_cqp_request(struct nes_device *nesdev)
 		cqp_request->callback = 0;
 		nes_debug(NES_DBG_CQP, "Got cqp request %p from the available list \n",
 				cqp_request);
-	} else
-		printk(KERN_ERR PFX "%s: Could not allocated a CQP request.\n",
-			   __func__);
+	}
 
 	return cqp_request;
 }
diff --git a/drivers/infiniband/hw/nes/nes_verbs.c b/drivers/infiniband/hw/nes/nes_verbs.c
index 7ad90665b623..fc847440502f 100644
--- a/drivers/infiniband/hw/nes/nes_verbs.c
+++ b/drivers/infiniband/hw/nes/nes_verbs.c
@@ -1634,7 +1634,7 @@ static struct ib_cq *nes_create_cq(struct ib_device *ibdev,
 /**
  * nes_destroy_cq
  */
-static int nes_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
+static void nes_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 {
 	struct nes_cq *nescq;
 	struct nes_device *nesdev;
@@ -1644,7 +1644,6 @@ static int nes_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	struct nes_cqp_request cqp_request = {};
 	unsigned long flags;
 	u32 opcode = 0;
-	int ret;
 
 	nescq = to_nescq(ib_cq);
 	nesvnic = to_nesvnic(ib_cq->device);
@@ -1656,6 +1655,7 @@ static int nes_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	/* Send DestroyCQ request to CQP */
 	INIT_LIST_HEAD(&cqp_request.list);
 	init_waitqueue_head(&cqp_request.waitq);
+
 	cqp_request.waiting = 1;
 	cqp_wqe = &cqp_request.cqp_wqe;
 	opcode = NES_CQP_DESTROY_CQ | (nescq->hw_cq.cq_size << 16);
@@ -1689,30 +1689,18 @@ static int nes_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	/* Wait for CQP */
 	nes_debug(NES_DBG_CQ, "Waiting for destroy iWARP CQ%u to complete.\n",
 			nescq->hw_cq.cq_number);
-	ret = wait_event_timeout(cqp_request.waitq, cqp_request.request_done,
-				 NES_EVENT_TIMEOUT);
-	nes_debug(NES_DBG_CQ, "Destroy iWARP CQ%u completed, wait_event_timeout ret = %u,"
-			" CQP Major:Minor codes = 0x%04X:0x%04X.\n",
-			nescq->hw_cq.cq_number, ret, cqp_request.major_code,
-			cqp_request.minor_code);
-	if (!ret) {
-		nes_debug(NES_DBG_CQ, "iWARP CQ%u destroy timeout expired\n",
-					nescq->hw_cq.cq_number);
-		ret = -ETIME;
-	} else if (cqp_request.major_code) {
-		nes_debug(NES_DBG_CQ, "iWARP CQ%u destroy failed\n",
-					nescq->hw_cq.cq_number);
-		ret = -EIO;
-	} else {
-		ret = 0;
-	}
+	wait_event_timeout(cqp_request.waitq, cqp_request.request_done,
+			   NES_EVENT_TIMEOUT);
+	nes_debug(
+		NES_DBG_CQ,
+		"Destroy iWARP CQ%u completed CQP Major:Minor codes = 0x%04X:0x%04X.\n",
+		nescq->hw_cq.cq_number, cqp_request.major_code,
+		cqp_request.minor_code);
 
 	if (nescq->cq_mem_size)
 		pci_free_consistent(nesdev->pcidev, nescq->cq_mem_size,
 				    nescq->hw_cq.cq_vbase, nescq->hw_cq.cq_pbase);
 	kfree(nescq);
-
-	return ret;
 }
 
 /**
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_hw.c b/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
index 5127e2ea4bdd..b2dd4e0a4be2 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
@@ -1888,14 +1888,13 @@ int ocrdma_mbx_create_cq(struct ocrdma_dev *dev, struct ocrdma_cq *cq,
 	return status;
 }
 
-int ocrdma_mbx_destroy_cq(struct ocrdma_dev *dev, struct ocrdma_cq *cq)
+void ocrdma_mbx_destroy_cq(struct ocrdma_dev *dev, struct ocrdma_cq *cq)
 {
-	int status = -ENOMEM;
 	struct ocrdma_destroy_cq *cmd;
 
 	cmd = ocrdma_init_emb_mqe(OCRDMA_CMD_DELETE_CQ, sizeof(*cmd));
 	if (!cmd)
-		return status;
+		return;
 	ocrdma_init_mch(&cmd->req, OCRDMA_CMD_DELETE_CQ,
 			OCRDMA_SUBSYS_COMMON, sizeof(*cmd));
 
@@ -1903,11 +1902,10 @@ int ocrdma_mbx_destroy_cq(struct ocrdma_dev *dev, struct ocrdma_cq *cq)
 	    (cq->id << OCRDMA_DESTROY_CQ_QID_SHIFT) &
 	    OCRDMA_DESTROY_CQ_QID_MASK;
 
-	status = ocrdma_mbx_cmd(dev, (struct ocrdma_mqe *)cmd);
+	ocrdma_mbx_cmd(dev, (struct ocrdma_mqe *)cmd);
 	ocrdma_unbind_eq(dev, cq->eqn);
 	dma_free_coherent(&dev->nic_info.pdev->dev, cq->len, cq->va, cq->pa);
 	kfree(cmd);
-	return status;
 }
 
 int ocrdma_mbx_alloc_lkey(struct ocrdma_dev *dev, struct ocrdma_hw_mr *hwmr,
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_hw.h b/drivers/infiniband/hw/ocrdma/ocrdma_hw.h
index 06ec59326a90..12c23a7652b9 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_hw.h
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_hw.h
@@ -122,7 +122,7 @@ int ocrdma_reg_mr(struct ocrdma_dev *, struct ocrdma_hw_mr *hwmr,
 			u32 pd_id, int acc);
 int ocrdma_mbx_create_cq(struct ocrdma_dev *, struct ocrdma_cq *,
 				int entries, int dpp_cq, u16 pd_id);
-int ocrdma_mbx_destroy_cq(struct ocrdma_dev *, struct ocrdma_cq *);
+void ocrdma_mbx_destroy_cq(struct ocrdma_dev *dev, struct ocrdma_cq *cq);
 
 int ocrdma_mbx_create_qp(struct ocrdma_qp *, struct ib_qp_init_attr *attrs,
 			 u8 enable_dpp_cq, u16 dpp_cq_id, u16 *dpp_offset,
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 35ec87015792..94e4f7f9b1f7 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -1070,7 +1070,7 @@ static void ocrdma_flush_cq(struct ocrdma_cq *cq)
 	spin_unlock_irqrestore(&cq->cq_lock, flags);
 }
 
-int ocrdma_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
+void ocrdma_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 {
 	struct ocrdma_cq *cq = get_ocrdma_cq(ibcq);
 	struct ocrdma_eq *eq = NULL;
@@ -1080,14 +1080,13 @@ int ocrdma_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 
 	dev->cq_tbl[cq->id] = NULL;
 	indx = ocrdma_get_eq_table_index(dev, cq->eqn);
-	BUG_ON(indx == -EINVAL);
 
 	eq = &dev->eq_tbl[indx];
 	irq = ocrdma_get_irq(dev, eq);
 	synchronize_irq(irq);
 	ocrdma_flush_cq(cq);
 
-	(void)ocrdma_mbx_destroy_cq(dev, cq);
+	ocrdma_mbx_destroy_cq(dev, cq);
 	if (cq->ucontext) {
 		pdid = cq->ucontext->cntxt_pd->id;
 		ocrdma_del_mmap(cq->ucontext, (u64) cq->pa,
@@ -1098,7 +1097,6 @@ int ocrdma_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	}
 
 	kfree(cq);
-	return 0;
 }
 
 static int ocrdma_add_qpn_map(struct ocrdma_dev *dev, struct ocrdma_qp *qp)
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
index d76aae7ed0d3..89cebe05669e 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
@@ -75,7 +75,7 @@ struct ib_cq *ocrdma_create_cq(struct ib_device *ibdev,
 			       const struct ib_cq_init_attr *attr,
 			       struct ib_udata *udata);
 int ocrdma_resize_cq(struct ib_cq *, int cqe, struct ib_udata *);
-int ocrdma_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
+void ocrdma_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
 
 struct ib_qp *ocrdma_create_qp(struct ib_pd *,
 			       struct ib_qp_init_attr *attrs,
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 3d7bde19838e..d2a230d6c0e7 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -962,14 +962,13 @@ int qedr_resize_cq(struct ib_cq *ibcq, int new_cnt, struct ib_udata *udata)
 #define QEDR_DESTROY_CQ_MAX_ITERATIONS		(10)
 #define QEDR_DESTROY_CQ_ITER_DURATION		(10)
 
-int qedr_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
+void qedr_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 {
 	struct qedr_dev *dev = get_qedr_dev(ibcq->device);
 	struct qed_rdma_destroy_cq_out_params oparams;
 	struct qed_rdma_destroy_cq_in_params iparams;
 	struct qedr_cq *cq = get_qedr_cq(ibcq);
 	int iter;
-	int rc;
 
 	DP_DEBUG(dev, QEDR_MSG_CQ, "destroy cq %p (icid=%d)\n", cq, cq->icid);
 
@@ -980,10 +979,7 @@ int qedr_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 		goto done;
 
 	iparams.icid = cq->icid;
-	rc = dev->ops->rdma_destroy_cq(dev->rdma_ctx, &iparams, &oparams);
-	if (rc)
-		return rc;
-
+	dev->ops->rdma_destroy_cq(dev->rdma_ctx, &iparams, &oparams);
 	dev->ops->common->chain_free(dev->cdev, &cq->pbl);
 
 	if (udata) {
@@ -1014,9 +1010,6 @@ int qedr_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 		iter--;
 	}
 
-	if (oparams.num_cq_notif != cq->cnq_notif)
-		goto err;
-
 	/* Note that we don't need to have explicit code to wait for the
 	 * completion of the event handler because it is invoked from the EQ.
 	 * Since the destroy CQ ramrod has also been received on the EQ we can
@@ -1026,15 +1019,6 @@ int qedr_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	cq->sig = ~cq->sig;
 
 	kfree(cq);
-
-	return 0;
-
-err:
-	DP_ERR(dev,
-	       "CQ %p (icid=%d) not freed, expecting %d ints but got %d ints\n",
-	       cq, cq->icid, oparams.num_cq_notif, cq->cnq_notif);
-
-	return -EINVAL;
 }
 
 static inline int get_gid_info_from_table(struct ib_qp *ibqp,
diff --git a/drivers/infiniband/hw/qedr/verbs.h b/drivers/infiniband/hw/qedr/verbs.h
index 9328c80375ef..32d7ce77e339 100644
--- a/drivers/infiniband/hw/qedr/verbs.h
+++ b/drivers/infiniband/hw/qedr/verbs.h
@@ -54,7 +54,7 @@ struct ib_cq *qedr_create_cq(struct ib_device *ibdev,
 			     const struct ib_cq_init_attr *attr,
 			     struct ib_udata *udata);
 int qedr_resize_cq(struct ib_cq *, int cqe, struct ib_udata *);
-int qedr_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
+void qedr_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
 int qedr_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
 struct ib_qp *qedr_create_qp(struct ib_pd *, struct ib_qp_init_attr *attrs,
 			     struct ib_udata *);
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index e9352750e029..5686d14b86fe 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -604,11 +604,9 @@ struct ib_cq *usnic_ib_create_cq(struct ib_device *ibdev,
 	return cq;
 }
 
-int usnic_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
+void usnic_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
 {
-	usnic_dbg("\n");
 	kfree(cq);
-	return 0;
 }
 
 struct ib_mr *usnic_ib_reg_mr(struct ib_pd *pd, u64 start, u64 length,
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.h b/drivers/infiniband/hw/usnic/usnic_ib_verbs.h
index 028f322f8e9b..0b9d993433a7 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.h
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.h
@@ -61,7 +61,7 @@ int usnic_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 struct ib_cq *usnic_ib_create_cq(struct ib_device *ibdev,
 				 const struct ib_cq_init_attr *attr,
 				 struct ib_udata *udata);
-int usnic_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
+void usnic_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 struct ib_mr *usnic_ib_reg_mr(struct ib_pd *pd, u64 start, u64 length,
 				u64 virt_addr, int access_flags,
 				struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
index d7deb19a2800..0682781f6555 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
@@ -246,10 +246,8 @@ static void pvrdma_free_cq(struct pvrdma_dev *dev, struct pvrdma_cq *cq)
  * pvrdma_destroy_cq - destroy completion queue
  * @cq: the completion queue to destroy.
  * @udata: user data or null for kernel object
- *
- * @return: 0 for success.
  */
-int pvrdma_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
+void pvrdma_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
 {
 	struct pvrdma_cq *vcq = to_vcq(cq);
 	union pvrdma_cmd_req req;
@@ -275,8 +273,6 @@ int pvrdma_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
 
 	pvrdma_free_cq(dev, vcq);
 	atomic_dec(&dev->num_cqs);
-
-	return ret;
 }
 
 static inline struct pvrdma_cqe *get_cqe(struct pvrdma_cq *cq, int i)
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
index 9d7b021e1c59..f0dd6e4d058b 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
@@ -412,7 +412,7 @@ int pvrdma_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 struct ib_cq *pvrdma_create_cq(struct ib_device *ibdev,
 			       const struct ib_cq_init_attr *attr,
 			       struct ib_udata *udata);
-int pvrdma_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
+void pvrdma_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 int pvrdma_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc);
 int pvrdma_req_notify_cq(struct ib_cq *cq, enum ib_cq_notify_flags flags);
 int pvrdma_create_ah(struct ib_ah *ah, struct rdma_ah_attr *ah_attr, u32 flags,
diff --git a/drivers/infiniband/sw/rdmavt/cq.c b/drivers/infiniband/sw/rdmavt/cq.c
index a06e6da7a026..8e76036fad4a 100644
--- a/drivers/infiniband/sw/rdmavt/cq.c
+++ b/drivers/infiniband/sw/rdmavt/cq.c
@@ -300,10 +300,8 @@ struct ib_cq *rvt_create_cq(struct ib_device *ibdev,
  * @udata: user data or NULL for kernel object
  *
  * Called by ib_destroy_cq() in the generic verbs code.
- *
- * Return: always 0
  */
-int rvt_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
+void rvt_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 {
 	struct rvt_cq *cq = ibcq_to_rvtcq(ibcq);
 	struct rvt_dev_info *rdi = cq->rdi;
@@ -317,8 +315,6 @@ int rvt_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	else
 		vfree(cq->queue);
 	kfree(cq);
-
-	return 0;
 }
 
 /**
diff --git a/drivers/infiniband/sw/rdmavt/cq.h b/drivers/infiniband/sw/rdmavt/cq.h
index 3ad6faf18ecb..495d8c3e6580 100644
--- a/drivers/infiniband/sw/rdmavt/cq.h
+++ b/drivers/infiniband/sw/rdmavt/cq.h
@@ -54,7 +54,7 @@
 struct ib_cq *rvt_create_cq(struct ib_device *ibdev,
 			    const struct ib_cq_init_attr *attr,
 			    struct ib_udata *udata);
-int rvt_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
+void rvt_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
 int rvt_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags notify_flags);
 int rvt_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata);
 int rvt_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *entry);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 8c3e2a18cfe4..5f30800b33f8 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -819,14 +819,13 @@ static struct ib_cq *rxe_create_cq(struct ib_device *dev,
 	return ERR_PTR(err);
 }
 
-static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
+static void rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 {
 	struct rxe_cq *cq = to_rcq(ibcq);
 
 	rxe_cq_disable(cq);
 
 	rxe_drop_ref(cq);
-	return 0;
 }
 
 static int rxe_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index f54260018b69..b971effecad9 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2463,7 +2463,7 @@ struct ib_device_ops {
 				   const struct ib_cq_init_attr *attr,
 				   struct ib_udata *udata);
 	int (*modify_cq)(struct ib_cq *cq, u16 cq_count, u16 cq_period);
-	int (*destroy_cq)(struct ib_cq *cq, struct ib_udata *udata);
+	void (*destroy_cq)(struct ib_cq *cq, struct ib_udata *udata);
 	int (*resize_cq)(struct ib_cq *cq, int cqe, struct ib_udata *udata);
 	struct ib_mr *(*get_dma_mr)(struct ib_pd *pd, int mr_access_flags);
 	struct ib_mr *(*reg_user_mr)(struct ib_pd *pd, u64 start, u64 length,
-- 
2.20.1

