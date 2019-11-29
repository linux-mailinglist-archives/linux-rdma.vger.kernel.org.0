Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBE810D863
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Nov 2019 17:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfK2QZa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Nov 2019 11:25:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13232 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726909AbfK2QZa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 29 Nov 2019 11:25:30 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xATGHDmg099106
        for <linux-rdma@vger.kernel.org>; Fri, 29 Nov 2019 11:25:28 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wjvfgn0fv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 29 Nov 2019 11:25:27 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rdma@vger.kernel.org> from <bmt@zurich.ibm.com>;
        Fri, 29 Nov 2019 16:25:25 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 29 Nov 2019 16:25:23 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xATGPLaf44302706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Nov 2019 16:25:22 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D331FAE045;
        Fri, 29 Nov 2019 16:25:21 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96F32AE055;
        Fri, 29 Nov 2019 16:25:21 +0000 (GMT)
Received: from spoke.zurich.ibm.com (unknown [9.4.69.152])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Nov 2019 16:25:21 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@ziepe.ca, krishna2@chelsio.com, leon@kernel.org,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH for-next] RDMA/siw: Simplify QP representation.
Date:   Fri, 29 Nov 2019 17:25:09 +0100
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 19112916-0012-0000-0000-0000036E0015
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112916-0013-0000-0000-000021A9B1DC
Message-Id: <20191129162509.26576-1-bmt@zurich.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-29_05:2019-11-29,2019-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 adultscore=0 clxscore=1011 spamscore=0 priorityscore=1501 suspectscore=1
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911290140
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Change siw_qp to contain ib_qp. Use ib_qp's uobject pointer
to distinguish kernel level and user level applications.
Apply same mechanism for kerne/user level application
detection to shared receive queues and completion queues.

Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw.h       | 28 +++++---------
 drivers/infiniband/sw/siw/siw_cq.c    |  2 +-
 drivers/infiniband/sw/siw/siw_main.c  |  2 +-
 drivers/infiniband/sw/siw/siw_qp.c    | 11 +++---
 drivers/infiniband/sw/siw/siw_qp_rx.c |  6 +--
 drivers/infiniband/sw/siw/siw_qp_tx.c |  2 +-
 drivers/infiniband/sw/siw/siw_verbs.c | 53 +++++++++------------------
 7 files changed, 39 insertions(+), 65 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index b939f489cd46..01d1deaf6285 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -209,7 +209,6 @@ struct siw_cq {
 	u32 cq_put;
 	u32 cq_get;
 	u32 num_cqe;
-	bool kernel_verbs;
 	struct rdma_user_mmap_entry *cq_entry; /* mmap info for CQE array */
 	u32 id; /* For debugging only */
 };
@@ -254,8 +253,7 @@ struct siw_srq {
 	u32 rq_get;
 	u32 num_rqe; /* max # of wqe's allowed */
 	struct rdma_user_mmap_entry *srq_entry; /* mmap info for SRQ array */
-	char armed; /* inform user if limit hit */
-	char kernel_verbs; /* '1' if kernel client */
+	bool armed; /* inform user if limit hit */
 };
 
 struct siw_qp_attrs {
@@ -418,13 +416,11 @@ struct siw_iwarp_tx {
 };
 
 struct siw_qp {
+	struct ib_qp base_qp;
 	struct siw_device *sdev;
-	struct ib_qp *ib_qp;
 	struct kref ref;
-	u32 qp_num;
 	struct list_head devq;
 	int tx_cpu;
-	bool kernel_verbs;
 	struct siw_qp_attrs attrs;
 
 	struct siw_cep *cep;
@@ -472,11 +468,6 @@ struct siw_qp {
 	struct rcu_head rcu;
 };
 
-struct siw_base_qp {
-	struct ib_qp base_qp;
-	struct siw_qp *qp;
-};
-
 /* helper macros */
 #define rx_qp(rx) container_of(rx, struct siw_qp, rx_stream)
 #define tx_qp(tx) container_of(tx, struct siw_qp, tx_ctx)
@@ -572,14 +563,9 @@ static inline struct siw_ucontext *to_siw_ctx(struct ib_ucontext *base_ctx)
 	return container_of(base_ctx, struct siw_ucontext, base_ucontext);
 }
 
-static inline struct siw_base_qp *to_siw_base_qp(struct ib_qp *base_qp)
-{
-	return container_of(base_qp, struct siw_base_qp, base_qp);
-}
-
 static inline struct siw_qp *to_siw_qp(struct ib_qp *base_qp)
 {
-	return to_siw_base_qp(base_qp)->qp;
+	return container_of(base_qp, struct siw_qp, base_qp);
 }
 
 static inline struct siw_cq *to_siw_cq(struct ib_cq *base_cq)
@@ -624,7 +610,7 @@ static inline struct siw_qp *siw_qp_id2obj(struct siw_device *sdev, int id)
 
 static inline u32 qp_id(struct siw_qp *qp)
 {
-	return qp->qp_num;
+	return qp->base_qp.qp_num;
 }
 
 static inline void siw_qp_get(struct siw_qp *qp)
@@ -715,6 +701,12 @@ static inline void siw_crc_skb(struct siw_rx_stream *srx, unsigned int len)
 	*(u32 *)shash_desc_ctx(srx->mpa_crc_hd) = crc;
 }
 
+/*
+ * RDMA core base objects have a valid uobject pointer
+ * only if created for user space application.
+ */
+#define is_kernel_user(base_obj) ((base_obj)->uobject == NULL)
+
 #define siw_dbg(ibdev, fmt, ...)                                               \
 	ibdev_dbg(ibdev, "%s: " fmt, __func__, ##__VA_ARGS__)
 
diff --git a/drivers/infiniband/sw/siw/siw_cq.c b/drivers/infiniband/sw/siw/siw_cq.c
index d8db3bee9da7..47ec0efa184a 100644
--- a/drivers/infiniband/sw/siw/siw_cq.c
+++ b/drivers/infiniband/sw/siw/siw_cq.c
@@ -65,7 +65,7 @@ int siw_reap_cqe(struct siw_cq *cq, struct ib_wc *wc)
 		 * reaped here, which do not hold a QP reference
 		 * and do not qualify for memory extension verbs.
 		 */
-		if (likely(cq->kernel_verbs)) {
+		if (likely(is_kernel_user(&cq->base_cq))) {
 			if (cqe->flags & SIW_WQE_REM_INVAL) {
 				wc->ex.invalidate_rkey = cqe->inval_stag;
 				wc->wc_flags = IB_WC_WITH_INVALIDATE;
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index c147f0613d95..96ed349c0939 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -244,7 +244,7 @@ static struct ib_qp *siw_get_base_qp(struct ib_device *base_dev, int id)
 		 * siw_qp_id2obj() increments object reference count
 		 */
 		siw_qp_put(qp);
-		return qp->ib_qp;
+		return &qp->base_qp;
 	}
 	return NULL;
 }
diff --git a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
index 52d402f39df9..ccbf74931b8b 100644
--- a/drivers/infiniband/sw/siw/siw_qp.c
+++ b/drivers/infiniband/sw/siw/siw_qp.c
@@ -1070,8 +1070,8 @@ int siw_sqe_complete(struct siw_qp *qp, struct siw_sqe *sqe, u32 bytes,
 			cqe->imm_data = 0;
 			cqe->bytes = bytes;
 
-			if (cq->kernel_verbs)
-				cqe->base_qp = qp->ib_qp;
+			if (is_kernel_user(&cq->base_cq))
+				cqe->base_qp = &qp->base_qp;
 			else
 				cqe->qp_id = qp_id(qp);
 
@@ -1128,8 +1128,8 @@ int siw_rqe_complete(struct siw_qp *qp, struct siw_rqe *rqe, u32 bytes,
 			cqe->imm_data = 0;
 			cqe->bytes = bytes;
 
-			if (cq->kernel_verbs) {
-				cqe->base_qp = qp->ib_qp;
+			if (is_kernel_user(&cq->base_cq)) {
+				cqe->base_qp = &qp->base_qp;
 				if (inval_stag) {
 					cqe_flags |= SIW_WQE_REM_INVAL;
 					cqe->inval_stag = inval_stag;
@@ -1297,13 +1297,12 @@ void siw_rq_flush(struct siw_qp *qp)
 
 int siw_qp_add(struct siw_device *sdev, struct siw_qp *qp)
 {
-	int rv = xa_alloc(&sdev->qp_xa, &qp->ib_qp->qp_num, qp, xa_limit_32b,
+	int rv = xa_alloc(&sdev->qp_xa, &qp->base_qp.qp_num, qp, xa_limit_32b,
 			  GFP_KERNEL);
 
 	if (!rv) {
 		kref_init(&qp->ref);
 		qp->sdev = sdev;
-		qp->qp_num = qp->ib_qp->qp_num;
 		siw_dbg_qp(qp, "new QP\n");
 	}
 	return rv;
diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
index c0a887240325..3bc269cec10b 100644
--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -68,7 +68,7 @@ static int siw_rx_umem(struct siw_rx_stream *srx, struct siw_umem *umem,
 			return -EFAULT;
 		}
 		if (srx->mpa_crc_hd) {
-			if (rx_qp(srx)->kernel_verbs) {
+			if (is_kernel_user(&rx_qp(srx)->base_qp)) {
 				crypto_shash_update(srx->mpa_crc_hd,
 					(u8 *)(dest + pg_off), bytes);
 				kunmap_atomic(dest);
@@ -388,7 +388,7 @@ static struct siw_wqe *siw_rqe_get(struct siw_qp *qp)
 				struct siw_rqe *rqe2 = &srq->recvq[off];
 
 				if (!(rqe2->flags & SIW_WQE_VALID)) {
-					srq->armed = 0;
+					srq->armed = false;
 					srq_event = true;
 				}
 			}
@@ -1264,7 +1264,7 @@ static int siw_rdmap_complete(struct siw_qp *qp, int error)
 
 			if (wc_status == SIW_WC_SUCCESS)
 				wc_status = SIW_WC_GENERAL_ERR;
-		} else if (qp->kernel_verbs &&
+		} else if (is_kernel_user(&qp->base_qp) &&
 			   rx_type(wqe) == SIW_OP_READ_LOCAL_INV) {
 			/*
 			 * Handle any STag invalidation request
diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 5d97bba0ce6d..5478bf865d42 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -817,7 +817,7 @@ static int siw_qp_sq_proc_tx(struct siw_qp *qp, struct siw_wqe *wqe)
 			}
 		} else {
 			wqe->bytes = wqe->sqe.sge[0].length;
-			if (!qp->kernel_verbs) {
+			if (!is_kernel_user(&qp->base_qp)) {
 				if (wqe->bytes > SIW_MAX_INLINE) {
 					rv = -EINVAL;
 					goto tx_error;
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index c992dd7299d9..c99e3cfad6b1 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -303,7 +303,6 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
 			    struct ib_udata *udata)
 {
 	struct siw_qp *qp = NULL;
-	struct siw_base_qp *siw_base_qp = NULL;
 	struct ib_device *base_dev = pd->device;
 	struct siw_device *sdev = to_siw_dev(base_dev);
 	struct siw_ucontext *uctx =
@@ -357,26 +356,16 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
 		rv = -EINVAL;
 		goto err_out;
 	}
-	siw_base_qp = kzalloc(sizeof(*siw_base_qp), GFP_KERNEL);
-	if (!siw_base_qp) {
-		rv = -ENOMEM;
-		goto err_out;
-	}
 	qp = kzalloc(sizeof(*qp), GFP_KERNEL);
 	if (!qp) {
 		rv = -ENOMEM;
 		goto err_out;
 	}
-	siw_base_qp->qp = qp;
-	qp->ib_qp = &siw_base_qp->base_qp;
-
 	init_rwsem(&qp->state_lock);
 	spin_lock_init(&qp->sq_lock);
 	spin_lock_init(&qp->rq_lock);
 	spin_lock_init(&qp->orq_lock);
 
-	qp->kernel_verbs = !udata;
-
 	rv = siw_qp_add(sdev, qp);
 	if (rv)
 		goto err_out;
@@ -389,10 +378,10 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
 	num_sqe = roundup_pow_of_two(attrs->cap.max_send_wr);
 	num_rqe = roundup_pow_of_two(attrs->cap.max_recv_wr);
 
-	if (qp->kernel_verbs)
-		qp->sendq = vzalloc(num_sqe * sizeof(struct siw_sqe));
-	else
+	if (udata)
 		qp->sendq = vmalloc_user(num_sqe * sizeof(struct siw_sqe));
+	else
+		qp->sendq = vzalloc(num_sqe * sizeof(struct siw_sqe));
 
 	if (qp->sendq == NULL) {
 		siw_dbg(base_dev, "SQ size %d alloc failed\n", num_sqe);
@@ -419,13 +408,14 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
 		 */
 		qp->srq = to_siw_srq(attrs->srq);
 		qp->attrs.rq_size = 0;
-		siw_dbg(base_dev, "QP [%u]: SRQ attached\n", qp->qp_num);
+		siw_dbg(base_dev, "QP [%u]: SRQ attached\n",
+			qp->base_qp.qp_num);
 	} else if (num_rqe) {
-		if (qp->kernel_verbs)
-			qp->recvq = vzalloc(num_rqe * sizeof(struct siw_rqe));
-		else
+		if (udata)
 			qp->recvq =
 				vmalloc_user(num_rqe * sizeof(struct siw_rqe));
+		else
+			qp->recvq = vzalloc(num_rqe * sizeof(struct siw_rqe));
 
 		if (qp->recvq == NULL) {
 			siw_dbg(base_dev, "RQ size %d alloc failed\n", num_rqe);
@@ -492,13 +482,11 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
 	list_add_tail(&qp->devq, &sdev->qp_list);
 	spin_unlock_irqrestore(&sdev->lock, flags);
 
-	return qp->ib_qp;
+	return &qp->base_qp;
 
 err_out_xa:
 	xa_erase(&sdev->qp_xa, qp_id(qp));
 err_out:
-	kfree(siw_base_qp);
-
 	if (qp) {
 		if (uctx) {
 			rdma_user_mmap_entry_remove(qp->sq_entry);
@@ -602,7 +590,6 @@ int siw_verbs_modify_qp(struct ib_qp *base_qp, struct ib_qp_attr *attr,
 int siw_destroy_qp(struct ib_qp *base_qp, struct ib_udata *udata)
 {
 	struct siw_qp *qp = to_siw_qp(base_qp);
-	struct siw_base_qp *siw_base_qp = to_siw_base_qp(base_qp);
 	struct siw_ucontext *uctx =
 		rdma_udata_to_drv_context(udata, struct siw_ucontext,
 					  base_ucontext);
@@ -639,7 +626,6 @@ int siw_destroy_qp(struct ib_qp *base_qp, struct ib_udata *udata)
 	qp->scq = qp->rcq = NULL;
 
 	siw_qp_put(qp);
-	kfree(siw_base_qp);
 
 	return 0;
 }
@@ -744,7 +730,7 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
 	unsigned long flags;
 	int rv = 0;
 
-	if (wr && !qp->kernel_verbs) {
+	if (wr && !is_kernel_user(base_qp)) {
 		siw_dbg_qp(qp, "wr must be empty for user mapped sq\n");
 		*bad_wr = wr;
 		return -EINVAL;
@@ -941,7 +927,7 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
 	if (rv <= 0)
 		goto skip_direct_sending;
 
-	if (qp->kernel_verbs) {
+	if (is_kernel_user(base_qp)) {
 		rv = siw_sq_start(qp);
 	} else {
 		qp->tx_ctx.in_syscall = 1;
@@ -986,8 +972,8 @@ int siw_post_receive(struct ib_qp *base_qp, const struct ib_recv_wr *wr,
 		*bad_wr = wr;
 		return -EOPNOTSUPP; /* what else from errno.h? */
 	}
-	if (!qp->kernel_verbs) {
-		siw_dbg_qp(qp, "no kernel post_recv for user mapped sq\n");
+	if (!is_kernel_user(base_qp)) {
+		siw_dbg_qp(qp, "no kernel post_recv for user mapped rq\n");
 		*bad_wr = wr;
 		return -EINVAL;
 	}
@@ -1130,7 +1116,6 @@ int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
 	cq->num_cqe = size;
 
 	if (!udata) {
-		cq->kernel_verbs = 1;
 		cq->queue = vzalloc(size * sizeof(struct siw_cqe) +
 				    sizeof(struct siw_cq_ctrl));
 	} else {
@@ -1591,9 +1576,7 @@ int siw_create_srq(struct ib_srq *base_srq,
 	srq->num_rqe = roundup_pow_of_two(attrs->max_wr);
 	srq->limit = attrs->srq_limit;
 	if (srq->limit)
-		srq->armed = 1;
-
-	srq->kernel_verbs = !udata;
+		srq->armed = true;
 
 	if (udata)
 		srq->recvq =
@@ -1673,9 +1656,9 @@ int siw_modify_srq(struct ib_srq *base_srq, struct ib_srq_attr *attrs,
 				rv = -EINVAL;
 				goto out;
 			}
-			srq->armed = 1;
+			srq->armed = true;
 		} else {
-			srq->armed = 0;
+			srq->armed = false;
 		}
 		srq->limit = attrs->srq_limit;
 	}
@@ -1747,7 +1730,7 @@ int siw_post_srq_recv(struct ib_srq *base_srq, const struct ib_recv_wr *wr,
 	unsigned long flags;
 	int rv = 0;
 
-	if (unlikely(!srq->kernel_verbs)) {
+	if (unlikely(!is_kernel_user(base_srq))) {
 		siw_dbg_pd(base_srq->pd,
 			   "[SRQ]: no kernel post_recv for mapped srq\n");
 		rv = -EINVAL;
@@ -1799,7 +1782,7 @@ int siw_post_srq_recv(struct ib_srq *base_srq, const struct ib_recv_wr *wr,
 void siw_qp_event(struct siw_qp *qp, enum ib_event_type etype)
 {
 	struct ib_event event;
-	struct ib_qp *base_qp = qp->ib_qp;
+	struct ib_qp *base_qp = &qp->base_qp;
 
 	/*
 	 * Do not report asynchronous errors on QP which gets
-- 
2.17.2

