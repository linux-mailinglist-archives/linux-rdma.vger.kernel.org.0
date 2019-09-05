Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42765A9F2E
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2019 12:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbfIEKDM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Sep 2019 06:03:12 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:51040 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731573AbfIEKDM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Sep 2019 06:03:12 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x85A07qI009501;
        Thu, 5 Sep 2019 03:03:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=ik1inTQH/5kZwj9HuPbN1/OxKfMwFTwsHmI39IQ3594=;
 b=e7Jkai2aCQ6XPzD4nZAFnOFHLpKnBUjwxw52jNX55QsKb4ZE/R+4ECRHm0t4H2hHkCMP
 eOMDcjBD0yjcokf2lVjer5XqtwG51S16twgK1IRRyR0uCmDcGGylHHlrlggdPmH+z2dp
 u/enmMbMY3zBPr2+im27vU5MPLBlGMR4NLA913DV0iZZRui+u5zk0Ohuul+aYkg2nyBf
 jZ3Wa0ZG/04i41s1DG/lgSzfzsmuo/oDOVNTvADiHgTW27491YEVYF2S/6+5UGqbbD7n
 r4Jagy34M0Xw0S2KIhqy3IXm/FFXcy8ZR6USLIcZgrwVBzXcj8dm7heLr5O+B7QAxxdv DQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uqrdmhy38-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 05 Sep 2019 03:03:06 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 5 Sep
 2019 03:03:04 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 5 Sep 2019 03:03:04 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id D667D3F704C;
        Thu,  5 Sep 2019 03:03:01 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <mkalderon@marvell.com>, <aelior@marvell.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>, <bmt@zurich.ibm.com>, <galpress@amazon.com>,
        <sleybo@amazon.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>
Subject: [PATCH v11 rdma-next 4/7] RDMA/siw: Use the common mmap_xa helpers
Date:   Thu, 5 Sep 2019 13:01:14 +0300
Message-ID: <20190905100117.20879-5-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190905100117.20879-1-michal.kalderon@marvell.com>
References: <20190905100117.20879-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-05_03:2019-09-04,2019-09-05 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove the functions related to managing the mmap_xa database.
This code is now common in ib_core. Use the common API's instead.

Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw.h       |  20 +++-
 drivers/infiniband/sw/siw/siw_main.c  |   1 +
 drivers/infiniband/sw/siw/siw_verbs.c | 216 ++++++++++++++++++----------------
 drivers/infiniband/sw/siw/siw_verbs.h |   1 +
 4 files changed, 131 insertions(+), 107 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 77b1aabf6ff3..c20b4ee1cb4b 100644
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
 
@@ -503,6 +503,12 @@ struct iwarp_msg_info {
 	int (*rx_data)(struct siw_qp *qp);
 };
 
+struct siw_user_mmap_entry {
+	struct rdma_user_mmap_entry rdma_entry;
+	void *address;
+	size_t length;
+};
+
 /* Global siw parameters. Currently set in siw_main.c */
 extern const bool zcopy_tx;
 extern const bool try_gso;
@@ -607,6 +613,12 @@ static inline struct siw_mr *to_siw_mr(struct ib_mr *base_mr)
 	return container_of(base_mr, struct siw_mr, base_mr);
 }
 
+static inline struct siw_user_mmap_entry *
+to_siw_mmap_entry(struct rdma_user_mmap_entry *rdma_mmap)
+{
+	return container_of(rdma_mmap, struct siw_user_mmap_entry, rdma_entry);
+}
+
 static inline struct siw_qp *siw_qp_id2obj(struct siw_device *sdev, int id)
 {
 	struct siw_qp *qp;
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index 05a92f997f60..46c0bb59489d 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -298,6 +298,7 @@ static const struct ib_device_ops siw_device_ops = {
 	.iw_rem_ref = siw_qp_put_ref,
 	.map_mr_sg = siw_map_mr_sg,
 	.mmap = siw_mmap,
+	.mmap_free = siw_mmap_free,
 	.modify_qp = siw_verbs_modify_qp,
 	.modify_srq = siw_modify_srq,
 	.poll_cq = siw_poll_cq,
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 03176a3d1e18..bbe7bb962d63 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -34,44 +34,20 @@ static char ib_qp_state_to_string[IB_QPS_ERR + 1][sizeof("RESET")] = {
 	[IB_QPS_ERR] = "ERR"
 };
 
-static u32 siw_create_uobj(struct siw_ucontext *uctx, void *vaddr, u32 size)
+void siw_mmap_free(struct rdma_user_mmap_entry *rdma_entry)
 {
-	struct siw_uobj *uobj;
-	struct xa_limit limit = XA_LIMIT(0, SIW_UOBJ_MAX_KEY);
-	u32 key;
+	struct siw_user_mmap_entry *entry = to_siw_mmap_entry(rdma_entry);
 
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
+	kfree(entry);
 }
 
 int siw_mmap(struct ib_ucontext *ctx, struct vm_area_struct *vma)
 {
 	struct siw_ucontext *uctx = to_siw_ctx(ctx);
-	struct siw_uobj *uobj;
-	unsigned long off = vma->vm_pgoff;
-	int size = vma->vm_end - vma->vm_start;
+	unsigned long off = vma->vm_pgoff << PAGE_SHIFT;
+	size_t size = vma->vm_end - vma->vm_start;
+	struct rdma_user_mmap_entry *rdma_entry;
+	struct siw_user_mmap_entry *entry;
 	int rv = -EINVAL;
 
 	/*
@@ -79,18 +55,30 @@ int siw_mmap(struct ib_ucontext *ctx, struct vm_area_struct *vma)
 	 */
 	if (vma->vm_start & (PAGE_SIZE - 1)) {
 		pr_warn("siw: mmap not page aligned\n");
-		goto out;
+		return -EINVAL;
 	}
-	uobj = siw_get_uobj(uctx, off, size);
-	if (!uobj) {
-		siw_dbg(&uctx->sdev->base_dev, "mmap lookup failed: %lu, %u\n",
+	rdma_entry = rdma_user_mmap_entry_get(&uctx->base_ucontext, off,
+					      size, vma);
+	if (!rdma_entry) {
+		siw_dbg(&uctx->sdev->base_dev, "mmap lookup failed: %lu, %#zx\n",
 			off, size);
-		goto out;
+		return -EINVAL;
 	}
-	rv = remap_vmalloc_range(vma, uobj->addr, 0);
-	if (rv)
-		pr_warn("remap_vmalloc_range failed: %lu, %u\n", off, size);
-out:
+	entry = to_siw_mmap_entry(rdma_entry);
+	if (PAGE_ALIGN(entry->length) != size) {
+		siw_dbg(&uctx->sdev->base_dev,
+			"key[%#lx] does not have valid length[%#zx] expected[%#zx]\n",
+			off, size, entry->length);
+		rdma_user_mmap_entry_put(&uctx->base_ucontext, rdma_entry);
+		return -EINVAL;
+	}
+
+	rv = remap_vmalloc_range(vma, entry->address, 0);
+	if (rv) {
+		pr_warn("remap_vmalloc_range failed: %lu, %zu\n", off, size);
+		rdma_user_mmap_entry_put(&uctx->base_ucontext, rdma_entry);
+	}
+
 	return rv;
 }
 
@@ -105,7 +93,7 @@ int siw_alloc_ucontext(struct ib_ucontext *base_ctx, struct ib_udata *udata)
 		rv = -ENOMEM;
 		goto err_out;
 	}
-	xa_init_flags(&ctx->xa, XA_FLAGS_ALLOC);
+
 	ctx->uobj_nextkey = 0;
 	ctx->sdev = sdev;
 
@@ -135,19 +123,7 @@ int siw_alloc_ucontext(struct ib_ucontext *base_ctx, struct ib_udata *udata)
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
 
@@ -293,6 +269,28 @@ void siw_qp_put_ref(struct ib_qp *base_qp)
 	siw_qp_put(to_siw_qp(base_qp));
 }
 
+static int siw_user_mmap_entry_insert(struct ib_ucontext *ucontext,
+				      void *address, size_t length,
+				      u64 *key)
+{
+	struct siw_user_mmap_entry *entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+
+	if (!entry)
+		return -ENOMEM;
+
+	entry->address = address;
+	entry->length = length;
+
+	*key = rdma_user_mmap_entry_insert(ucontext, &entry->rdma_entry,
+					   length);
+	if (*key == RDMA_USER_MMAP_INVALID) {
+		kfree(entry);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 /*
  * siw_create_qp()
  *
@@ -317,6 +315,8 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
 	struct siw_cq *scq = NULL, *rcq = NULL;
 	unsigned long flags;
 	int num_sqe, num_rqe, rv = 0;
+	size_t length;
+	u64 key;
 
 	siw_dbg(base_dev, "create new QP\n");
 
@@ -380,8 +380,8 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
 	spin_lock_init(&qp->orq_lock);
 
 	qp->kernel_verbs = !udata;
-	qp->xa_sq_index = SIW_INVAL_UOBJ_KEY;
-	qp->xa_rq_index = SIW_INVAL_UOBJ_KEY;
+	qp->sq_key = RDMA_USER_MMAP_INVALID;
+	qp->rq_key = RDMA_USER_MMAP_INVALID;
 
 	rv = siw_qp_add(sdev, qp);
 	if (rv)
@@ -459,22 +459,29 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
 		uresp.qp_id = qp_id(qp);
 
 		if (qp->sendq) {
-			qp->xa_sq_index =
-				siw_create_uobj(uctx, qp->sendq,
-					num_sqe * sizeof(struct siw_sqe));
+			length = num_sqe * sizeof(struct siw_sqe);
+			rv = siw_user_mmap_entry_insert(&uctx->base_ucontext,
+							qp->sendq, length,
+							&key);
+			if (rv)
+				goto err_out_xa;
+
+			qp->sq_key = key;
 		}
+
 		if (qp->recvq) {
-			qp->xa_rq_index =
-				 siw_create_uobj(uctx, qp->recvq,
-					num_rqe * sizeof(struct siw_rqe));
-		}
-		if (qp->xa_sq_index == SIW_INVAL_UOBJ_KEY ||
-		    qp->xa_rq_index == SIW_INVAL_UOBJ_KEY) {
-			rv = -ENOMEM;
-			goto err_out_xa;
+			length = num_rqe * sizeof(struct siw_rqe);
+			rv = siw_user_mmap_entry_insert(&uctx->base_ucontext,
+							qp->recvq, length,
+							&key);
+			if (rv)
+				goto err_out_xa;
+
+			qp->rq_key = key;
 		}
-		uresp.sq_key = qp->xa_sq_index << PAGE_SHIFT;
-		uresp.rq_key = qp->xa_rq_index << PAGE_SHIFT;
+
+		uresp.sq_key = qp->sq_key;
+		uresp.rq_key = qp->rq_key;
 
 		if (udata->outlen < sizeof(uresp)) {
 			rv = -EINVAL;
@@ -502,11 +509,12 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
 	kfree(siw_base_qp);
 
 	if (qp) {
-		if (qp->xa_sq_index != SIW_INVAL_UOBJ_KEY)
-			kfree(xa_erase(&uctx->xa, qp->xa_sq_index));
-		if (qp->xa_rq_index != SIW_INVAL_UOBJ_KEY)
-			kfree(xa_erase(&uctx->xa, qp->xa_rq_index));
-
+		if (uctx) {
+			rdma_user_mmap_entry_remove(&uctx->base_ucontext,
+						    qp->sq_key);
+			rdma_user_mmap_entry_remove(&uctx->base_ucontext,
+						    qp->rq_key);
+		}
 		vfree(qp->sendq);
 		vfree(qp->recvq);
 		kfree(qp);
@@ -620,10 +628,10 @@ int siw_destroy_qp(struct ib_qp *base_qp, struct ib_udata *udata)
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
 
@@ -993,8 +1001,8 @@ void siw_destroy_cq(struct ib_cq *base_cq, struct ib_udata *udata)
 
 	siw_cq_flush(cq);
 
-	if (ctx && cq->xa_cq_index != SIW_INVAL_UOBJ_KEY)
-		kfree(xa_erase(&ctx->xa, cq->xa_cq_index));
+	if (ctx)
+		rdma_user_mmap_entry_remove(&ctx->base_ucontext, cq->cq_key);
 
 	atomic_dec(&sdev->num_cq);
 
@@ -1031,7 +1039,7 @@ int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
 	size = roundup_pow_of_two(size);
 	cq->base_cq.cqe = size;
 	cq->num_cqe = size;
-	cq->xa_cq_index = SIW_INVAL_UOBJ_KEY;
+	cq->cq_key = RDMA_USER_MMAP_INVALID;
 
 	if (!udata) {
 		cq->kernel_verbs = 1;
@@ -1057,16 +1065,16 @@ int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
 		struct siw_ucontext *ctx =
 			rdma_udata_to_drv_context(udata, struct siw_ucontext,
 						  base_ucontext);
+		size_t length = size * sizeof(struct siw_cqe) +
+			sizeof(struct siw_cq_ctrl);
 
-		cq->xa_cq_index =
-			siw_create_uobj(ctx, cq->queue,
-					size * sizeof(struct siw_cqe) +
-						sizeof(struct siw_cq_ctrl));
-		if (cq->xa_cq_index == SIW_INVAL_UOBJ_KEY) {
-			rv = -ENOMEM;
+		rv = siw_user_mmap_entry_insert(&ctx->base_ucontext,
+						cq->queue, length,
+						&cq->cq_key);
+		if (rv)
 			goto err_out;
-		}
-		uresp.cq_key = cq->xa_cq_index << PAGE_SHIFT;
+
+		uresp.cq_key = cq->cq_key;
 		uresp.cq_id = cq->id;
 		uresp.num_cqe = size;
 
@@ -1087,8 +1095,9 @@ int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
 		struct siw_ucontext *ctx =
 			rdma_udata_to_drv_context(udata, struct siw_ucontext,
 						  base_ucontext);
-		if (cq->xa_cq_index != SIW_INVAL_UOBJ_KEY)
-			kfree(xa_erase(&ctx->xa, cq->xa_cq_index));
+		if (ctx)
+			rdma_user_mmap_entry_remove(&ctx->base_ucontext,
+						    cq->cq_key);
 		vfree(cq->queue);
 	}
 	atomic_dec(&sdev->num_cq);
@@ -1490,7 +1499,7 @@ int siw_create_srq(struct ib_srq *base_srq,
 	}
 	srq->max_sge = attrs->max_sge;
 	srq->num_rqe = roundup_pow_of_two(attrs->max_wr);
-	srq->xa_srq_index = SIW_INVAL_UOBJ_KEY;
+	srq->srq_key = RDMA_USER_MMAP_INVALID;
 	srq->limit = attrs->srq_limit;
 	if (srq->limit)
 		srq->armed = 1;
@@ -1509,15 +1518,15 @@ int siw_create_srq(struct ib_srq *base_srq,
 	}
 	if (udata) {
 		struct siw_uresp_create_srq uresp = {};
+		size_t length = srq->num_rqe * sizeof(struct siw_rqe);
 
-		srq->xa_srq_index = siw_create_uobj(
-			ctx, srq->recvq, srq->num_rqe * sizeof(struct siw_rqe));
-
-		if (srq->xa_srq_index == SIW_INVAL_UOBJ_KEY) {
-			rv = -ENOMEM;
+		rv = siw_user_mmap_entry_insert(&ctx->base_ucontext,
+						srq->recvq, length,
+						&srq->srq_key);
+		if (rv)
 			goto err_out;
-		}
-		uresp.srq_key = srq->xa_srq_index;
+
+		uresp.srq_key = srq->srq_key;
 		uresp.num_rqe = srq->num_rqe;
 
 		if (udata->outlen < sizeof(uresp)) {
@@ -1536,8 +1545,9 @@ int siw_create_srq(struct ib_srq *base_srq,
 
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
@@ -1623,9 +1633,9 @@ void siw_destroy_srq(struct ib_srq *base_srq, struct ib_udata *udata)
 		rdma_udata_to_drv_context(udata, struct siw_ucontext,
 					  base_ucontext);
 
-	if (ctx && srq->xa_srq_index != SIW_INVAL_UOBJ_KEY)
-		kfree(xa_erase(&ctx->xa, srq->xa_srq_index));
-
+	if (ctx)
+		rdma_user_mmap_entry_remove(&ctx->base_ucontext,
+					    srq->srq_key);
 	vfree(srq->recvq);
 	atomic_dec(&sdev->num_srq);
 }
diff --git a/drivers/infiniband/sw/siw/siw_verbs.h b/drivers/infiniband/sw/siw/siw_verbs.h
index 1910869281cb..1a731989fad6 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.h
+++ b/drivers/infiniband/sw/siw/siw_verbs.h
@@ -83,6 +83,7 @@ void siw_destroy_srq(struct ib_srq *base_srq, struct ib_udata *udata);
 int siw_post_srq_recv(struct ib_srq *base_srq, const struct ib_recv_wr *wr,
 		      const struct ib_recv_wr **bad_wr);
 int siw_mmap(struct ib_ucontext *ctx, struct vm_area_struct *vma);
+void siw_mmap_free(struct rdma_user_mmap_entry *rdma_entry);
 void siw_qp_event(struct siw_qp *qp, enum ib_event_type type);
 void siw_cq_event(struct siw_cq *cq, enum ib_event_type type);
 void siw_srq_event(struct siw_srq *srq, enum ib_event_type type);
-- 
2.14.5

