Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C17D95E46
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 14:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbfHTMU5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Aug 2019 08:20:57 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:31112 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729409AbfHTMU5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Aug 2019 08:20:57 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7KCAacp027732;
        Tue, 20 Aug 2019 05:20:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=i28oIjO724lZX8jaAkYPrPnvh/qvlVSq3iS9+r1djgA=;
 b=RjO431nHtlhp43llGOgsu3j8BSei0WizALwvSDNfY83a7ViJYoLM666KL5kIFjrdd1nz
 3OdqD1dKy+wU3zB5kjVBYwIyqEw2fJH9qZxEAZy3ya2aDeUDgtHEuQYl0Vnhtw2WvdiZ
 I7dWgSkEjD6DVwIqxeTmqyf5A0u8b0BUwt7pjAdn+IdKPD9xWiSQ3r9HKsueNF8JtHsn
 RXmpQ+dgOmU3T88R6bE5sCAZzq1SzT4Zy2GH3EMtfNCS2Xyg55sQGnAv1FfCyNAUOBkU
 lhDCllyi8TnN5tOL5tLMW4j9CxbZeOfVyBA2tOdD5RpXi4EjobKh4StJItisDkPoFfox NQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2ug8a99p10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 20 Aug 2019 05:20:52 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 20 Aug
 2019 05:20:50 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 20 Aug 2019 05:20:50 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id B39A93F703F;
        Tue, 20 Aug 2019 05:20:47 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <mkalderon@marvell.com>, <aelior@marvell.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>, <bmt@zurich.ibm.com>, <galpress@amazon.com>,
        <sleybo@amazon.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        Ariel Elior <ariel.elior@marvell.com>
Subject: [PATCH v7 rdma-next 4/7] RDMA/siw: Use the common mmap_xa helpers
Date:   Tue, 20 Aug 2019 15:18:44 +0300
Message-ID: <20190820121847.25871-5-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190820121847.25871-1-michal.kalderon@marvell.com>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-20_05:2019-08-19,2019-08-20 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove the functions related to managing the mmap_xa database.
This code is now common in ib_core. Use the common API's instead.

Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
---
 drivers/infiniband/sw/siw/siw.h       |   8 +-
 drivers/infiniband/sw/siw/siw_verbs.c | 160 ++++++++++++++--------------------
 2 files changed, 69 insertions(+), 99 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 03fd7b2f595f..3ac745dac7e4 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -220,7 +220,7 @@ struct siw_cq {
 	u32 cq_get;
 	u32 num_cqe;
 	bool kernel_verbs;
-	u32 xa_cq_index; /* mmap information for CQE array */
+	u64 cq_key; /* mmap information for CQE array */
 	u32 id; /* For debugging only */
 };
 
@@ -263,7 +263,7 @@ struct siw_srq {
 	u32 rq_put;
 	u32 rq_get;
 	u32 num_rqe; /* max # of wqe's allowed */
-	u32 xa_srq_index; /* mmap information for SRQ array */
+	u64 srq_key; /* mmap information for SRQ array */
 	char armed; /* inform user if limit hit */
 	char kernel_verbs; /* '1' if kernel client */
 };
@@ -477,8 +477,8 @@ struct siw_qp {
 		u8 layer : 4, etype : 4;
 		u8 ecode;
 	} term_info;
-	u32 xa_sq_index; /* mmap information for SQE array */
-	u32 xa_rq_index; /* mmap information for RQE array */
+	u64 sq_key; /* mmap information for SQE array */
+	u64 rq_key; /* mmap information for RQE array */
 	struct rcu_head rcu;
 };
 
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 404e7ca4b30c..b5d3dff70741 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -34,43 +34,11 @@ static char ib_qp_state_to_string[IB_QPS_ERR + 1][sizeof("RESET")] = {
 	[IB_QPS_ERR] = "ERR"
 };
 
-static u32 siw_create_uobj(struct siw_ucontext *uctx, void *vaddr, u32 size)
-{
-	struct siw_uobj *uobj;
-	struct xa_limit limit = XA_LIMIT(0, SIW_UOBJ_MAX_KEY);
-	u32 key;
-
-	uobj = kzalloc(sizeof(*uobj), GFP_KERNEL);
-	if (!uobj)
-		return SIW_INVAL_UOBJ_KEY;
-
-	if (xa_alloc_cyclic(&uctx->xa, &key, uobj, limit, &uctx->uobj_nextkey,
-			    GFP_KERNEL) < 0) {
-		kfree(uobj);
-		return SIW_INVAL_UOBJ_KEY;
-	}
-	uobj->size = PAGE_ALIGN(size);
-	uobj->addr = vaddr;
-
-	return key;
-}
-
-static struct siw_uobj *siw_get_uobj(struct siw_ucontext *uctx,
-				     unsigned long off, u32 size)
-{
-	struct siw_uobj *uobj = xa_load(&uctx->xa, off);
-
-	if (uobj && uobj->size == size)
-		return uobj;
-
-	return NULL;
-}
-
 int siw_mmap(struct ib_ucontext *ctx, struct vm_area_struct *vma)
 {
 	struct siw_ucontext *uctx = to_siw_ctx(ctx);
-	struct siw_uobj *uobj;
-	unsigned long off = vma->vm_pgoff;
+	struct rdma_user_mmap_entry *entry;
+	unsigned long off = vma->vm_pgoff << PAGE_SHIFT;
 	int size = vma->vm_end - vma->vm_start;
 	int rv = -EINVAL;
 
@@ -81,15 +49,17 @@ int siw_mmap(struct ib_ucontext *ctx, struct vm_area_struct *vma)
 		pr_warn("siw: mmap not page aligned\n");
 		goto out;
 	}
-	uobj = siw_get_uobj(uctx, off, size);
-	if (!uobj) {
+	entry = rdma_user_mmap_entry_get(&uctx->base_ucontext, off, size, vma);
+	if (!entry) {
 		siw_dbg(&uctx->sdev->base_dev, "mmap lookup failed: %lu, %u\n",
 			off, size);
 		goto out;
 	}
-	rv = remap_vmalloc_range(vma, uobj->addr, 0);
-	if (rv)
+	rv = remap_vmalloc_range(vma, (void *)entry->address, 0);
+	if (rv) {
 		pr_warn("remap_vmalloc_range failed: %lu, %u\n", off, size);
+		rdma_user_mmap_entry_put(&uctx->base_ucontext, entry);
+	}
 out:
 	return rv;
 }
@@ -105,7 +75,7 @@ int siw_alloc_ucontext(struct ib_ucontext *base_ctx, struct ib_udata *udata)
 		rv = -ENOMEM;
 		goto err_out;
 	}
-	xa_init_flags(&ctx->xa, XA_FLAGS_ALLOC);
+
 	ctx->uobj_nextkey = 0;
 	ctx->sdev = sdev;
 
@@ -135,19 +105,7 @@ int siw_alloc_ucontext(struct ib_ucontext *base_ctx, struct ib_udata *udata)
 void siw_dealloc_ucontext(struct ib_ucontext *base_ctx)
 {
 	struct siw_ucontext *uctx = to_siw_ctx(base_ctx);
-	void *entry;
-	unsigned long index;
 
-	/*
-	 * Make sure all user mmap objects are gone. Since QP, CQ
-	 * and SRQ destroy routines destroy related objects, nothing
-	 * should be found here.
-	 */
-	xa_for_each(&uctx->xa, index, entry) {
-		kfree(xa_erase(&uctx->xa, index));
-		pr_warn("siw: dropping orphaned uobj at %lu\n", index);
-	}
-	xa_destroy(&uctx->xa);
 	atomic_dec(&uctx->sdev->num_ctx);
 }
 
@@ -317,6 +275,8 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
 	struct siw_cq *scq = NULL, *rcq = NULL;
 	unsigned long flags;
 	int num_sqe, num_rqe, rv = 0;
+	u64 length;
+	u64 key;
 
 	siw_dbg(base_dev, "create new QP\n");
 
@@ -380,8 +340,8 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
 	spin_lock_init(&qp->orq_lock);
 
 	qp->kernel_verbs = !udata;
-	qp->xa_sq_index = SIW_INVAL_UOBJ_KEY;
-	qp->xa_rq_index = SIW_INVAL_UOBJ_KEY;
+	qp->sq_key = RDMA_USER_MMAP_INVALID;
+	qp->rq_key = RDMA_USER_MMAP_INVALID;
 
 	rv = siw_qp_add(sdev, qp);
 	if (rv)
@@ -459,22 +419,29 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
 		uresp.qp_id = qp_id(qp);
 
 		if (qp->sendq) {
-			qp->xa_sq_index =
-				siw_create_uobj(uctx, qp->sendq,
-					num_sqe * sizeof(struct siw_sqe));
+			length = num_sqe * sizeof(struct siw_sqe);
+			key = rdma_user_mmap_entry_insert(&uctx->base_ucontext,
+							  qp,
+							  (uintptr_t)qp->sendq,
+							  length, 0);
+			qp->sq_key = key;
 		}
+
 		if (qp->recvq) {
-			qp->xa_rq_index =
-				 siw_create_uobj(uctx, qp->recvq,
-					num_rqe * sizeof(struct siw_rqe));
+			length = num_rqe * sizeof(struct siw_rqe);
+			key = rdma_user_mmap_entry_insert(&uctx->base_ucontext,
+							  qp,
+							  (uintptr_t)qp->recvq,
+							  length, 0);
+			qp->rq_key = key;
 		}
-		if (qp->xa_sq_index == SIW_INVAL_UOBJ_KEY ||
-		    qp->xa_rq_index == SIW_INVAL_UOBJ_KEY) {
+		if (qp->sq_key == RDMA_USER_MMAP_INVALID ||
+		    qp->rq_key == RDMA_USER_MMAP_INVALID) {
 			rv = -ENOMEM;
 			goto err_out_xa;
 		}
-		uresp.sq_key = qp->xa_sq_index << PAGE_SHIFT;
-		uresp.rq_key = qp->xa_rq_index << PAGE_SHIFT;
+		uresp.sq_key = qp->sq_key;
+		uresp.rq_key = qp->rq_key;
 
 		if (udata->outlen < sizeof(uresp)) {
 			rv = -EINVAL;
@@ -502,11 +469,8 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
 	kfree(siw_base_qp);
 
 	if (qp) {
-		if (qp->xa_sq_index != SIW_INVAL_UOBJ_KEY)
-			kfree(xa_erase(&uctx->xa, qp->xa_sq_index));
-		if (qp->xa_rq_index != SIW_INVAL_UOBJ_KEY)
-			kfree(xa_erase(&uctx->xa, qp->xa_rq_index));
-
+		rdma_user_mmap_entry_remove(&uctx->base_ucontext, qp->sq_key);
+		rdma_user_mmap_entry_remove(&uctx->base_ucontext, qp->rq_key);
 		vfree(qp->sendq);
 		vfree(qp->recvq);
 		kfree(qp);
@@ -620,10 +584,10 @@ int siw_destroy_qp(struct ib_qp *base_qp, struct ib_udata *udata)
 	qp->attrs.flags |= SIW_QP_IN_DESTROY;
 	qp->rx_stream.rx_suspend = 1;
 
-	if (uctx && qp->xa_sq_index != SIW_INVAL_UOBJ_KEY)
-		kfree(xa_erase(&uctx->xa, qp->xa_sq_index));
-	if (uctx && qp->xa_rq_index != SIW_INVAL_UOBJ_KEY)
-		kfree(xa_erase(&uctx->xa, qp->xa_rq_index));
+	if (uctx) {
+		rdma_user_mmap_entry_remove(&uctx->base_ucontext, qp->sq_key);
+		rdma_user_mmap_entry_remove(&uctx->base_ucontext, qp->rq_key);
+	}
 
 	down_write(&qp->state_lock);
 
@@ -993,8 +957,8 @@ void siw_destroy_cq(struct ib_cq *base_cq, struct ib_udata *udata)
 
 	siw_cq_flush(cq);
 
-	if (ctx && cq->xa_cq_index != SIW_INVAL_UOBJ_KEY)
-		kfree(xa_erase(&ctx->xa, cq->xa_cq_index));
+	if (ctx)
+		rdma_user_mmap_entry_remove(&ctx->base_ucontext, cq->cq_key);
 
 	atomic_dec(&sdev->num_cq);
 
@@ -1031,7 +995,7 @@ int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
 	size = roundup_pow_of_two(size);
 	cq->base_cq.cqe = size;
 	cq->num_cqe = size;
-	cq->xa_cq_index = SIW_INVAL_UOBJ_KEY;
+	cq->cq_key = RDMA_USER_MMAP_INVALID;
 
 	if (!udata) {
 		cq->kernel_verbs = 1;
@@ -1057,16 +1021,18 @@ int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
 		struct siw_ucontext *ctx =
 			rdma_udata_to_drv_context(udata, struct siw_ucontext,
 						  base_ucontext);
-
-		cq->xa_cq_index =
-			siw_create_uobj(ctx, cq->queue,
-					size * sizeof(struct siw_cqe) +
-						sizeof(struct siw_cq_ctrl));
-		if (cq->xa_cq_index == SIW_INVAL_UOBJ_KEY) {
+		u64 length = size * sizeof(struct siw_cqe) +
+			     sizeof(struct siw_cq_ctrl);
+
+		cq->cq_key = rdma_user_mmap_entry_insert(&ctx->base_ucontext,
+							 cq,
+							 (uintptr_t)cq->queue,
+							 length, 0);
+		if (cq->cq_key == RDMA_USER_MMAP_INVALID) {
 			rv = -ENOMEM;
 			goto err_out;
 		}
-		uresp.cq_key = cq->xa_cq_index << PAGE_SHIFT;
+		uresp.cq_key = cq->cq_key;
 		uresp.cq_id = cq->id;
 		uresp.num_cqe = size;
 
@@ -1087,8 +1053,7 @@ int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
 		struct siw_ucontext *ctx =
 			rdma_udata_to_drv_context(udata, struct siw_ucontext,
 						  base_ucontext);
-		if (cq->xa_cq_index != SIW_INVAL_UOBJ_KEY)
-			kfree(xa_erase(&ctx->xa, cq->xa_cq_index));
+		rdma_user_mmap_entry_remove(&ctx->base_ucontext, cq->cq_key);
 		vfree(cq->queue);
 	}
 	atomic_dec(&sdev->num_cq);
@@ -1484,7 +1449,7 @@ int siw_create_srq(struct ib_srq *base_srq,
 	}
 	srq->max_sge = attrs->max_sge;
 	srq->num_rqe = roundup_pow_of_two(attrs->max_wr);
-	srq->xa_srq_index = SIW_INVAL_UOBJ_KEY;
+	srq->srq_key = RDMA_USER_MMAP_INVALID;
 	srq->limit = attrs->srq_limit;
 	if (srq->limit)
 		srq->armed = 1;
@@ -1503,15 +1468,18 @@ int siw_create_srq(struct ib_srq *base_srq,
 	}
 	if (udata) {
 		struct siw_uresp_create_srq uresp = {};
-
-		srq->xa_srq_index = siw_create_uobj(
-			ctx, srq->recvq, srq->num_rqe * sizeof(struct siw_rqe));
-
-		if (srq->xa_srq_index == SIW_INVAL_UOBJ_KEY) {
+		u64 length = srq->num_rqe * sizeof(struct siw_rqe);
+
+		srq->srq_key =
+			rdma_user_mmap_entry_insert(&ctx->base_ucontext,
+						    srq,
+						    (uintptr_t)srq->recvq,
+						    length, 0);
+		if (srq->srq_key == RDMA_USER_MMAP_INVALID) {
 			rv = -ENOMEM;
 			goto err_out;
 		}
-		uresp.srq_key = srq->xa_srq_index;
+		uresp.srq_key = srq->srq_key;
 		uresp.num_rqe = srq->num_rqe;
 
 		if (udata->outlen < sizeof(uresp)) {
@@ -1530,8 +1498,9 @@ int siw_create_srq(struct ib_srq *base_srq,
 
 err_out:
 	if (srq->recvq) {
-		if (ctx && srq->xa_srq_index != SIW_INVAL_UOBJ_KEY)
-			kfree(xa_erase(&ctx->xa, srq->xa_srq_index));
+		if (ctx)
+			rdma_user_mmap_entry_remove(&ctx->base_ucontext,
+						    srq->srq_key);
 		vfree(srq->recvq);
 	}
 	atomic_dec(&sdev->num_srq);
@@ -1617,8 +1586,9 @@ void siw_destroy_srq(struct ib_srq *base_srq, struct ib_udata *udata)
 		rdma_udata_to_drv_context(udata, struct siw_ucontext,
 					  base_ucontext);
 
-	if (ctx && srq->xa_srq_index != SIW_INVAL_UOBJ_KEY)
-		kfree(xa_erase(&ctx->xa, srq->xa_srq_index));
+	if (ctx)
+		rdma_user_mmap_entry_remove(&ctx->base_ucontext,
+					    srq->srq_key);
 
 	vfree(srq->recvq);
 	atomic_dec(&sdev->num_srq);
-- 
2.14.5

