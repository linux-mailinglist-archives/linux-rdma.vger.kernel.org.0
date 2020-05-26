Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A372619C891
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2020 20:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733252AbgDBSMk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Apr 2020 14:12:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52227 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgDBSMk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Apr 2020 14:12:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id t8so4438370wmi.2
        for <linux-rdma@vger.kernel.org>; Thu, 02 Apr 2020 11:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LQ1tiHU+vnWs26+Os/sGPHSP2+xvvHpnRKL2MmjbCM8=;
        b=BdXjCfSfUZVglwVUGGaRWoHLO8GBCQmx3A5kAjm+zIZA0EgWG6GAe93960EagV9mLx
         veWg1rq6OHtz6ymWHAOfqEuFOB38p/GT8hyTa5luMQAc2KMLS/zFjm0EJCz9c8RqoM19
         2bsJGpuC9awHSao6GgQist8WbMbmIenjJ1OVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LQ1tiHU+vnWs26+Os/sGPHSP2+xvvHpnRKL2MmjbCM8=;
        b=sn2bo69vKF2PzyH7VyOjzQE/buqf8oNG0ivbL0ZgLx5/MbHkL+t3aAsCilZxB8GbjQ
         z1bGFISwaJ6uiRtyBlYC8QDyhhUY2XqBRCddLAZp1LkyWuOESidVUOSlfQ4jBCnlGzcK
         AAACg0zs7saU8ho7VAba+/Gg9EiB/sPXm71CXvBNPvWb0k/Zj2ofo9VE3KcWRTw9KdXo
         HB988ko3L3ci3G5+Dlhseh+kXPl70VnVS3uuVnaBKurYOcKj0EdOXKl/ipDPfA8IC31z
         x0VXGnBLdHzsFEo4TXxooeTEFGmx5rjYy7ZuVqWU/aCcMcGyGe3PJZ4GDhuLzmaLT0hs
         sqsQ==
X-Gm-Message-State: AGi0PubkuEJBgoN+NN/jDtKxWurWxLieNfTPU2qgsGZOPbHXVYhajbld
        cvWSxCD8mgfFccDs5Aag2Puh9CIFoasN/EstM6QLF0wQO6MzfTyxg0fJzU12CguTmA2sz5qp8/2
        nGmmsH9ovNg22HI/dQ6F1Nj8xA3hRk6kHmurMtB3X1KB+1JZaLISPdCYlQkkNoz90oNS7ijRpRf
        Oz08s=
X-Google-Smtp-Source: APiQypJe5HRRhdca/+vA4zq7C7T5weRi4wTUZoN5fU8V3H9W3g1HIBaURYESHKn9Qc5zoJk/vqNPrA==
X-Received: by 2002:a7b:c18e:: with SMTP id y14mr4320254wmi.99.1585851155469;
        Thu, 02 Apr 2020 11:12:35 -0700 (PDT)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k3sm8399351wro.39.2020.04.02.11.12.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 11:12:34 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, dledford@redhat.com
Subject: [PATCH for-next 3/4] RDMA/bnxt_re: simplify obtaining queue entry from hw ring
Date:   Thu,  2 Apr 2020 14:12:14 -0400
Message-Id: <1585851136-2316-4-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1585851136-2316-1-git-send-email-devesh.sharma@broadcom.com>
References: <1585851136-2316-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Restructring the data path and control path queue management
code to simplify the way a queue element is extracted from
the hardware ring.

Introduced a new function which will give a pointer to the
next ring item depending upon the current cons/prod index
in the hardware queue.

further, there are hardcoding when size of queue entry is
calculated, replacing it with an inline function. This function
would be easier to expand if need going forward.

The code section to initialize the PSN search areas has also
been restructured and couple of functions has been added there.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c   |  65 +++++----
 drivers/infiniband/hw/bnxt_re/ib_verbs.h   |  10 ++
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 216 ++++++++++++++---------------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h   |  42 +-----
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  16 +--
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  41 ------
 drivers/infiniband/hw/bnxt_re/qplib_res.c  |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_res.h  |  13 ++
 8 files changed, 176 insertions(+), 228 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 95f6d49..d98348e 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -856,7 +856,7 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	if (ib_copy_from_udata(&ureq, udata, sizeof(ureq)))
 		return -EFAULT;
 
-	bytes = (qplib_qp->sq.max_wqe * BNXT_QPLIB_MAX_SQE_ENTRY_SIZE);
+	bytes = (qplib_qp->sq.max_wqe * qplib_qp->sq.wqe_size);
 	/* Consider mapping PSN search memory only for RC QPs. */
 	if (qplib_qp->type == CMDQ_CREATE_QP_TYPE_RC) {
 		psn_sz = bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx) ?
@@ -879,7 +879,7 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	qplib_qp->qp_handle = ureq.qp_handle;
 
 	if (!qp->qplib_qp.srq) {
-		bytes = (qplib_qp->rq.max_wqe * BNXT_QPLIB_MAX_RQE_ENTRY_SIZE);
+		bytes = (qplib_qp->rq.max_wqe * qplib_qp->rq.wqe_size);
 		bytes = PAGE_ALIGN(bytes);
 		umem = ib_umem_get(&rdev->ibdev, ureq.qprva, bytes,
 				   IB_ACCESS_LOCAL_WRITE);
@@ -976,6 +976,7 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	qp->qplib_qp.sig_type = true;
 
 	/* Shadow QP SQ depth should be same as QP1 RQ depth */
+	qp->qplib_qp.sq.wqe_size = bnxt_re_get_swqe_size();
 	qp->qplib_qp.sq.max_wqe = qp1_qp->rq.max_wqe;
 	qp->qplib_qp.sq.max_sge = 2;
 	/* Q full delta can be 1 since it is internal QP */
@@ -986,6 +987,7 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	qp->qplib_qp.scq = qp1_qp->scq;
 	qp->qplib_qp.rcq = qp1_qp->rcq;
 
+	qp->qplib_qp.rq.wqe_size = bnxt_re_get_rwqe_size();
 	qp->qplib_qp.rq.max_wqe = qp1_qp->rq.max_wqe;
 	qp->qplib_qp.rq.max_sge = qp1_qp->rq.max_sge;
 	/* Q full delta can be 1 since it is internal QP */
@@ -1021,10 +1023,12 @@ static int bnxt_re_init_rq_attr(struct bnxt_re_qp *qp,
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_qp *qplqp;
 	struct bnxt_re_dev *rdev;
+	struct bnxt_qplib_q *rq;
 	int entries;
 
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
+	rq = &qplqp->rq;
 	dev_attr = &rdev->dev_attr;
 
 	if (init_attr->srq) {
@@ -1036,23 +1040,21 @@ static int bnxt_re_init_rq_attr(struct bnxt_re_qp *qp,
 			return -EINVAL;
 		}
 		qplqp->srq = &srq->qplib_srq;
-		qplqp->rq.max_wqe = 0;
+		rq->max_wqe = 0;
 	} else {
+		rq->wqe_size = bnxt_re_get_rwqe_size();
 		/* Allocate 1 more than what's provided so posting max doesn't
 		 * mean empty.
 		 */
 		entries = roundup_pow_of_two(init_attr->cap.max_recv_wr + 1);
-		qplqp->rq.max_wqe = min_t(u32, entries,
-					  dev_attr->max_qp_wqes + 1);
-
-		qplqp->rq.q_full_delta = qplqp->rq.max_wqe -
-					 init_attr->cap.max_recv_wr;
-		qplqp->rq.max_sge = init_attr->cap.max_recv_sge;
-		if (qplqp->rq.max_sge > dev_attr->max_qp_sges)
-			qplqp->rq.max_sge = dev_attr->max_qp_sges;
+		rq->max_wqe = min_t(u32, entries, dev_attr->max_qp_wqes + 1);
+		rq->q_full_delta = rq->max_wqe - init_attr->cap.max_recv_wr;
+		rq->max_sge = init_attr->cap.max_recv_sge;
+		if (rq->max_sge > dev_attr->max_qp_sges)
+			rq->max_sge = dev_attr->max_qp_sges;
 	}
-	qplqp->rq.sg_info.pgsize = PAGE_SIZE;
-	qplqp->rq.sg_info.pgshft = PAGE_SHIFT;
+	rq->sg_info.pgsize = PAGE_SIZE;
+	rq->sg_info.pgshft = PAGE_SHIFT;
 
 	return 0;
 }
@@ -1080,15 +1082,18 @@ static void bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_qp *qplqp;
 	struct bnxt_re_dev *rdev;
+	struct bnxt_qplib_q *sq;
 	int entries;
 
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
+	sq = &qplqp->sq;
 	dev_attr = &rdev->dev_attr;
 
-	qplqp->sq.max_sge = init_attr->cap.max_send_sge;
-	if (qplqp->sq.max_sge > dev_attr->max_qp_sges)
-		qplqp->sq.max_sge = dev_attr->max_qp_sges;
+	sq->wqe_size = bnxt_re_get_swqe_size();
+	sq->max_sge = init_attr->cap.max_send_sge;
+	if (sq->max_sge > dev_attr->max_qp_sges)
+		sq->max_sge = dev_attr->max_qp_sges;
 	/*
 	 * Change the SQ depth if user has requested minimum using
 	 * configfs. Only supported for kernel consumers
@@ -1096,9 +1101,9 @@ static void bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
 	entries = init_attr->cap.max_send_wr;
 	/* Allocate 128 + 1 more than what's provided */
 	entries = roundup_pow_of_two(entries + BNXT_QPLIB_RESERVED_QP_WRS + 1);
-	qplqp->sq.max_wqe = min_t(u32, entries, dev_attr->max_qp_wqes +
-			BNXT_QPLIB_RESERVED_QP_WRS + 1);
-	qplqp->sq.q_full_delta = BNXT_QPLIB_RESERVED_QP_WRS + 1;
+	sq->max_wqe = min_t(u32, entries, dev_attr->max_qp_wqes +
+			    BNXT_QPLIB_RESERVED_QP_WRS + 1);
+	sq->q_full_delta = BNXT_QPLIB_RESERVED_QP_WRS + 1;
 	/*
 	 * Reserving one slot for Phantom WQE. Application can
 	 * post one extra entry in this case. But allowing this to avoid
@@ -1511,7 +1516,7 @@ static int bnxt_re_init_user_srq(struct bnxt_re_dev *rdev,
 	if (ib_copy_from_udata(&ureq, udata, sizeof(ureq)))
 		return -EFAULT;
 
-	bytes = (qplib_srq->max_wqe * BNXT_QPLIB_MAX_RQE_ENTRY_SIZE);
+	bytes = (qplib_srq->max_wqe * qplib_srq->wqe_size);
 	bytes = PAGE_ALIGN(bytes);
 	umem = ib_umem_get(&rdev->ibdev, ureq.srqva, bytes,
 			   IB_ACCESS_LOCAL_WRITE);
@@ -1534,15 +1539,20 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 		       struct ib_srq_init_attr *srq_init_attr,
 		       struct ib_udata *udata)
 {
-	struct ib_pd *ib_pd = ib_srq->pd;
-	struct bnxt_re_pd *pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
-	struct bnxt_re_dev *rdev = pd->rdev;
-	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
-	struct bnxt_re_srq *srq =
-		container_of(ib_srq, struct bnxt_re_srq, ib_srq);
+	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_nq *nq = NULL;
+	struct bnxt_re_dev *rdev;
+	struct bnxt_re_srq *srq;
+	struct bnxt_re_pd *pd;
+	struct ib_pd *ib_pd;
 	int rc, entries;
 
+	ib_pd = ib_srq->pd;
+	pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
+	rdev = pd->rdev;
+	dev_attr = &rdev->dev_attr;
+	srq = container_of(ib_srq, struct bnxt_re_srq, ib_srq);
+
 	if (srq_init_attr->attr.max_wr >= dev_attr->max_srq_wqes) {
 		ibdev_err(&rdev->ibdev, "Create CQ failed - max exceeded");
 		rc = -EINVAL;
@@ -1563,8 +1573,9 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 	entries = roundup_pow_of_two(srq_init_attr->attr.max_wr + 1);
 	if (entries > dev_attr->max_srq_wqes + 1)
 		entries = dev_attr->max_srq_wqes + 1;
-
 	srq->qplib_srq.max_wqe = entries;
+
+	srq->qplib_srq.wqe_size = bnxt_re_get_rwqe_size();
 	srq->qplib_srq.max_sge = srq_init_attr->attr.max_sge;
 	srq->qplib_srq.threshold = srq_init_attr->attr.srq_limit;
 	srq->srq_limit = srq_init_attr->attr.srq_limit;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 23d972d..18dd46f 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -142,6 +142,16 @@ struct bnxt_re_ucontext {
 	spinlock_t		sh_lock;	/* protect shpg */
 };
 
+static inline u16 bnxt_re_get_swqe_size(void)
+{
+	return sizeof(struct sq_send);
+}
+
+static inline u16 bnxt_re_get_rwqe_size(void)
+{
+	return sizeof(struct rq_wqe);
+}
+
 int bnxt_re_query_device(struct ib_device *ibdev,
 			 struct ib_device_attr *ib_attr,
 			 struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index d3bf9f6..a4de56b 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -301,9 +301,9 @@ static void bnxt_qplib_service_nq(unsigned long data)
 	struct bnxt_qplib_nq *nq = (struct bnxt_qplib_nq *)data;
 	struct bnxt_qplib_hwq *hwq = &nq->hwq;
 	struct nq_base *nqe, **nq_ptr;
-	struct bnxt_qplib_cq *cq;
-	int num_cqne_processed = 0;
 	int num_srqne_processed = 0;
+	int num_cqne_processed = 0;
+	struct bnxt_qplib_cq *cq;
 	int budget = nq->budget;
 	u32 sw_cons, raw_cons;
 	uintptr_t q_handle;
@@ -315,7 +315,7 @@ static void bnxt_qplib_service_nq(unsigned long data)
 	while (budget--) {
 		sw_cons = HWQ_CMP(raw_cons, hwq);
 		nq_ptr = (struct nq_base **)hwq->pbl_ptr;
-		nqe = &nq_ptr[NQE_PG(sw_cons)][NQE_IDX(sw_cons)];
+		nqe = bnxt_qplib_get_qe(hwq, sw_cons, NULL);
 		if (!NQE_CMP_VALID(nqe, raw_cons, hwq->max_elements))
 			break;
 
@@ -392,13 +392,11 @@ static irqreturn_t bnxt_qplib_nq_irq(int irq, void *dev_instance)
 {
 	struct bnxt_qplib_nq *nq = dev_instance;
 	struct bnxt_qplib_hwq *hwq = &nq->hwq;
-	struct nq_base **nq_ptr;
 	u32 sw_cons;
 
 	/* Prefetch the NQ element */
 	sw_cons = HWQ_CMP(hwq->cons, hwq);
-	nq_ptr = (struct nq_base **)nq->hwq.pbl_ptr;
-	prefetch(&nq_ptr[NQE_PG(sw_cons)][NQE_IDX(sw_cons)]);
+	prefetch(bnxt_qplib_get_qe(hwq, sw_cons, NULL));
 
 	/* Fan out to CPU affinitized kthreads? */
 	tasklet_schedule(&nq->nq_tasklet);
@@ -618,7 +616,7 @@ int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
 	hwq_attr.res = res;
 	hwq_attr.sginfo = &srq->sg_info;
 	hwq_attr.depth = srq->max_wqe;
-	hwq_attr.stride = BNXT_QPLIB_MAX_RQE_ENTRY_SIZE;
+	hwq_attr.stride = srq->wqe_size;
 	hwq_attr.type = HWQ_TYPE_QUEUE;
 	rc = bnxt_qplib_alloc_init_hwq(&srq->hwq, &hwq_attr);
 	if (rc)
@@ -730,7 +728,7 @@ int bnxt_qplib_post_srq_recv(struct bnxt_qplib_srq *srq,
 			     struct bnxt_qplib_swqe *wqe)
 {
 	struct bnxt_qplib_hwq *srq_hwq = &srq->hwq;
-	struct rq_wqe *srqe, **srqe_ptr;
+	struct rq_wqe *srqe;
 	struct sq_sge *hw_sge;
 	u32 sw_prod, sw_cons, count = 0;
 	int i, rc = 0, next;
@@ -748,9 +746,8 @@ int bnxt_qplib_post_srq_recv(struct bnxt_qplib_srq *srq,
 	spin_unlock(&srq_hwq->lock);
 
 	sw_prod = HWQ_CMP(srq_hwq->prod, srq_hwq);
-	srqe_ptr = (struct rq_wqe **)srq_hwq->pbl_ptr;
-	srqe = &srqe_ptr[RQE_PG(sw_prod)][RQE_IDX(sw_prod)];
-	memset(srqe, 0, BNXT_QPLIB_MAX_RQE_ENTRY_SIZE);
+	srqe = bnxt_qplib_get_qe(srq_hwq, sw_prod, NULL);
+	memset(srqe, 0, srq->wqe_size);
 	/* Calculate wqe_size16 and data_len */
 	for (i = 0, hw_sge = (struct sq_sge *)srqe->data;
 	     i < wqe->num_sge; i++, hw_sge++) {
@@ -813,7 +810,7 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	hwq_attr.res = res;
 	hwq_attr.sginfo = &sq->sg_info;
 	hwq_attr.depth = sq->max_wqe;
-	hwq_attr.stride = BNXT_QPLIB_MAX_SQE_ENTRY_SIZE;
+	hwq_attr.stride = sq->wqe_size;
 	hwq_attr.type = HWQ_TYPE_QUEUE;
 	rc = bnxt_qplib_alloc_init_hwq(&sq->hwq, &hwq_attr);
 	if (rc)
@@ -837,7 +834,7 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	if (rq->max_wqe) {
 		hwq_attr.res = res;
 		hwq_attr.sginfo = &rq->sg_info;
-		hwq_attr.stride = BNXT_QPLIB_MAX_RQE_ENTRY_SIZE;
+		hwq_attr.stride = rq->wqe_size;
 		hwq_attr.depth = qp->rq.max_wqe;
 		hwq_attr.type = HWQ_TYPE_QUEUE;
 		rc = bnxt_qplib_alloc_init_hwq(&rq->hwq, &hwq_attr);
@@ -912,22 +909,45 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	return rc;
 }
 
+static void bnxt_qplib_init_psn_ptr(struct bnxt_qplib_qp *qp, int size)
+{
+	struct bnxt_qplib_hwq *hwq;
+	struct bnxt_qplib_q *sq;
+	u64 fpsne, psne, psn_pg;
+	u16 indx_pad = 0, indx;
+	u16 pg_num, pg_indx;
+	u64 *page;
+
+	sq = &qp->sq;
+	hwq = &sq->hwq;
+
+	fpsne = (u64)bnxt_qplib_get_qe(hwq, hwq->max_elements, &psn_pg);
+	if (!IS_ALIGNED(fpsne, PAGE_SIZE))
+		indx_pad = ALIGN(fpsne, PAGE_SIZE) / size;
+
+	page = (u64 *)psn_pg;
+	for (indx = 0; indx < hwq->max_elements; indx++) {
+		pg_num = (indx + indx_pad) / (PAGE_SIZE / size);
+		pg_indx = (indx + indx_pad) % (PAGE_SIZE / size);
+		psne = page[pg_num] + pg_indx * size;
+		sq->swq[indx].psn_ext = (struct sq_psn_search_ext *)psne;
+		sq->swq[indx].psn_search = (struct sq_psn_search *)psne;
+	}
+}
+
 int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct bnxt_qplib_hwq_attr hwq_attr = {};
-	unsigned long int psn_search, poff = 0;
 	struct bnxt_qplib_sg_info sginfo = {};
-	struct sq_psn_search **psn_search_ptr;
 	struct bnxt_qplib_q *sq = &qp->sq;
 	struct bnxt_qplib_q *rq = &qp->rq;
-	int i, rc, req_size, psn_sz = 0;
-	struct sq_send **hw_sq_send_ptr;
 	struct creq_create_qp_resp resp;
+	int rc, req_size, psn_sz = 0;
 	struct bnxt_qplib_hwq *xrrq;
 	u16 cmd_flags = 0, max_ssge;
-	struct cmdq_create_qp req;
 	struct bnxt_qplib_pbl *pbl;
+	struct cmdq_create_qp req;
 	u32 qp_flags = 0;
 	u8 pg_sz_lvl;
 	u16 max_rsge;
@@ -948,7 +968,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 
 	hwq_attr.res = res;
 	hwq_attr.sginfo = &sq->sg_info;
-	hwq_attr.stride = BNXT_QPLIB_MAX_SQE_ENTRY_SIZE;
+	hwq_attr.stride = sq->wqe_size;
 	hwq_attr.depth = sq->max_wqe;
 	hwq_attr.aux_stride = psn_sz;
 	hwq_attr.aux_depth = hwq_attr.depth;
@@ -962,32 +982,10 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 		rc = -ENOMEM;
 		goto fail_sq;
 	}
-	hw_sq_send_ptr = (struct sq_send **)sq->hwq.pbl_ptr;
-	if (psn_sz) {
-		psn_search_ptr = (struct sq_psn_search **)
-				  &hw_sq_send_ptr[get_sqe_pg
-					(sq->hwq.max_elements)];
-		psn_search = (unsigned long int)
-			      &hw_sq_send_ptr[get_sqe_pg(sq->hwq.max_elements)]
-			      [get_sqe_idx(sq->hwq.max_elements)];
-		if (psn_search & ~PAGE_MASK) {
-			/* If the psn_search does not start on a page boundary,
-			 * then calculate the offset
-			 */
-			poff = (psn_search & ~PAGE_MASK) /
-				BNXT_QPLIB_MAX_PSNE_ENTRY_SIZE;
-		}
-		for (i = 0; i < sq->hwq.max_elements; i++) {
-			sq->swq[i].psn_search =
-				&psn_search_ptr[get_psne_pg(i + poff)]
-					       [get_psne_idx(i + poff)];
-			/*psns_ext will be used only for P5 chips. */
-			sq->swq[i].psn_ext =
-				(struct sq_psn_search_ext *)
-				&psn_search_ptr[get_psne_pg(i + poff)]
-					       [get_psne_idx(i + poff)];
-		}
-	}
+
+	if (psn_sz)
+		bnxt_qplib_init_psn_ptr(qp, psn_sz);
+
 	pbl = &sq->hwq.pbl[PBL_LVL_0];
 	req.sq_pbl = cpu_to_le64(pbl->pg_map_arr[0]);
 	pg_sz_lvl = (bnxt_qplib_base_pg_size(&sq->hwq) <<
@@ -1002,7 +1000,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	if (rq->max_wqe) {
 		hwq_attr.res = res;
 		hwq_attr.sginfo = &rq->sg_info;
-		hwq_attr.stride = BNXT_QPLIB_MAX_RQE_ENTRY_SIZE;
+		hwq_attr.stride = rq->wqe_size;
 		hwq_attr.depth = rq->max_wqe;
 		hwq_attr.aux_stride = 0;
 		hwq_attr.aux_depth = 0;
@@ -1425,12 +1423,11 @@ int bnxt_qplib_query_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 static void __clean_cq(struct bnxt_qplib_cq *cq, u64 qp)
 {
 	struct bnxt_qplib_hwq *cq_hwq = &cq->hwq;
-	struct cq_base *hw_cqe, **hw_cqe_ptr;
+	struct cq_base *hw_cqe;
 	int i;
 
 	for (i = 0; i < cq_hwq->max_elements; i++) {
-		hw_cqe_ptr = (struct cq_base **)cq_hwq->pbl_ptr;
-		hw_cqe = &hw_cqe_ptr[CQE_PG(i)][CQE_IDX(i)];
+		hw_cqe = bnxt_qplib_get_qe(cq_hwq, i, NULL);
 		if (!CQE_CMP_VALID(hw_cqe, i, cq_hwq->max_elements))
 			continue;
 		/*
@@ -1557,6 +1554,34 @@ void *bnxt_qplib_get_qp1_rq_buf(struct bnxt_qplib_qp *qp,
 	return NULL;
 }
 
+static void bnxt_qplib_fill_psn_search(struct bnxt_qplib_qp *qp,
+				       struct bnxt_qplib_swqe *wqe,
+				       struct bnxt_qplib_swq *swq)
+{
+	struct sq_psn_search_ext *psns_ext;
+	struct sq_psn_search *psns;
+	u32 flg_npsn;
+	u32 op_spsn;
+
+	psns = swq->psn_search;
+	psns_ext = swq->psn_ext;
+
+	op_spsn = ((swq->start_psn << SQ_PSN_SEARCH_START_PSN_SFT) &
+		    SQ_PSN_SEARCH_START_PSN_MASK);
+	op_spsn |= ((wqe->type << SQ_PSN_SEARCH_OPCODE_SFT) &
+		     SQ_PSN_SEARCH_OPCODE_MASK);
+	flg_npsn = ((swq->next_psn << SQ_PSN_SEARCH_NEXT_PSN_SFT) &
+		     SQ_PSN_SEARCH_NEXT_PSN_MASK);
+
+	if (bnxt_qplib_is_chip_gen_p5(qp->cctx)) {
+		psns_ext->opcode_start_psn = cpu_to_le32(op_spsn);
+		psns_ext->flags_next_psn = cpu_to_le32(flg_npsn);
+	} else {
+		psns->opcode_start_psn = cpu_to_le32(op_spsn);
+		psns->flags_next_psn = cpu_to_le32(flg_npsn);
+	}
+}
+
 void bnxt_qplib_post_send_db(struct bnxt_qplib_qp *qp)
 {
 	struct bnxt_qplib_q *sq = &qp->sq;
@@ -1567,16 +1592,16 @@ void bnxt_qplib_post_send_db(struct bnxt_qplib_qp *qp)
 int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 			 struct bnxt_qplib_swqe *wqe)
 {
+	struct bnxt_qplib_nq_work *nq_work = NULL;
+	int i, rc = 0, data_len = 0, pkt_num = 0;
 	struct bnxt_qplib_q *sq = &qp->sq;
+	struct sq_send *hw_sq_send_hdr;
 	struct bnxt_qplib_swq *swq;
-	struct sq_send *hw_sq_send_hdr, **hw_sq_send_ptr;
-	struct sq_sge *hw_sge;
-	struct bnxt_qplib_nq_work *nq_work = NULL;
 	bool sch_handler = false;
-	u32 sw_prod;
+	struct sq_sge *hw_sge;
 	u8 wqe_size16;
-	int i, rc = 0, data_len = 0, pkt_num = 0;
 	__le32 temp32;
+	u32 sw_prod;
 
 	if (qp->state != CMDQ_MODIFY_QP_NEW_STATE_RTS) {
 		if (qp->state == CMDQ_MODIFY_QP_NEW_STATE_ERR) {
@@ -1605,11 +1630,8 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 		swq->flags |= SQ_SEND_FLAGS_SIGNAL_COMP;
 	swq->start_psn = sq->psn & BTH_PSN_MASK;
 
-	hw_sq_send_ptr = (struct sq_send **)sq->hwq.pbl_ptr;
-	hw_sq_send_hdr = &hw_sq_send_ptr[get_sqe_pg(sw_prod)]
-					[get_sqe_idx(sw_prod)];
-
-	memset(hw_sq_send_hdr, 0, BNXT_QPLIB_MAX_SQE_ENTRY_SIZE);
+	hw_sq_send_hdr = bnxt_qplib_get_qe(&sq->hwq, sw_prod, NULL);
+	memset(hw_sq_send_hdr, 0, sq->wqe_size);
 
 	if (wqe->flags & BNXT_QPLIB_SWQE_FLAGS_INLINE) {
 		/* Copy the inline data */
@@ -1796,28 +1818,8 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 		goto done;
 	}
 	swq->next_psn = sq->psn & BTH_PSN_MASK;
-	if (swq->psn_search) {
-		u32 opcd_spsn;
-		u32 flg_npsn;
-
-		opcd_spsn = ((swq->start_psn << SQ_PSN_SEARCH_START_PSN_SFT) &
-			      SQ_PSN_SEARCH_START_PSN_MASK);
-		opcd_spsn |= ((wqe->type << SQ_PSN_SEARCH_OPCODE_SFT) &
-			       SQ_PSN_SEARCH_OPCODE_MASK);
-		flg_npsn = ((swq->next_psn << SQ_PSN_SEARCH_NEXT_PSN_SFT) &
-			     SQ_PSN_SEARCH_NEXT_PSN_MASK);
-		if (bnxt_qplib_is_chip_gen_p5(qp->cctx)) {
-			swq->psn_ext->opcode_start_psn =
-						cpu_to_le32(opcd_spsn);
-			swq->psn_ext->flags_next_psn =
-						cpu_to_le32(flg_npsn);
-		} else {
-			swq->psn_search->opcode_start_psn =
-						cpu_to_le32(opcd_spsn);
-			swq->psn_search->flags_next_psn =
-						cpu_to_le32(flg_npsn);
-		}
-	}
+	if (qp->type == CMDQ_CREATE_QP_TYPE_RC)
+		bnxt_qplib_fill_psn_search(qp, wqe, swq);
 queue_err:
 	if (sch_handler) {
 		/* Store the ULP info in the software structures */
@@ -1860,13 +1862,13 @@ void bnxt_qplib_post_recv_db(struct bnxt_qplib_qp *qp)
 int bnxt_qplib_post_recv(struct bnxt_qplib_qp *qp,
 			 struct bnxt_qplib_swqe *wqe)
 {
-	struct bnxt_qplib_q *rq = &qp->rq;
-	struct rq_wqe *rqe, **rqe_ptr;
-	struct sq_sge *hw_sge;
 	struct bnxt_qplib_nq_work *nq_work = NULL;
+	struct bnxt_qplib_q *rq = &qp->rq;
 	bool sch_handler = false;
-	u32 sw_prod;
+	struct sq_sge *hw_sge;
+	struct rq_wqe *rqe;
 	int i, rc = 0;
+	u32 sw_prod;
 
 	if (qp->state == CMDQ_MODIFY_QP_NEW_STATE_ERR) {
 		sch_handler = true;
@@ -1883,10 +1885,8 @@ int bnxt_qplib_post_recv(struct bnxt_qplib_qp *qp,
 	sw_prod = HWQ_CMP(rq->hwq.prod, &rq->hwq);
 	rq->swq[sw_prod].wr_id = wqe->wr_id;
 
-	rqe_ptr = (struct rq_wqe **)rq->hwq.pbl_ptr;
-	rqe = &rqe_ptr[RQE_PG(sw_prod)][RQE_IDX(sw_prod)];
-
-	memset(rqe, 0, BNXT_QPLIB_MAX_RQE_ENTRY_SIZE);
+	rqe = bnxt_qplib_get_qe(&rq->hwq, sw_prod, NULL);
+	memset(rqe, 0, rq->wqe_size);
 
 	/* Calculate wqe_size16 and data_len */
 	for (i = 0, hw_sge = (struct sq_sge *)rqe->data;
@@ -1939,8 +1939,8 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct bnxt_qplib_hwq_attr hwq_attr = {};
 	struct creq_create_cq_resp resp;
-	struct cmdq_create_cq req;
 	struct bnxt_qplib_pbl *pbl;
+	struct cmdq_create_cq req;
 	u16 cmd_flags = 0;
 	u32 pg_sz_lvl;
 	int rc;
@@ -2128,13 +2128,13 @@ void bnxt_qplib_mark_qp_error(void *qp_handle)
 static int do_wa9060(struct bnxt_qplib_qp *qp, struct bnxt_qplib_cq *cq,
 		     u32 cq_cons, u32 sw_sq_cons, u32 cqe_sq_cons)
 {
-	struct bnxt_qplib_q *sq = &qp->sq;
-	struct bnxt_qplib_swq *swq;
 	u32 peek_sw_cq_cons, peek_raw_cq_cons, peek_sq_cons_idx;
-	struct cq_base *peek_hwcqe, **peek_hw_cqe_ptr;
+	struct bnxt_qplib_q *sq = &qp->sq;
 	struct cq_req *peek_req_hwcqe;
 	struct bnxt_qplib_qp *peek_qp;
 	struct bnxt_qplib_q *peek_sq;
+	struct bnxt_qplib_swq *swq;
+	struct cq_base *peek_hwcqe;
 	int i, rc = 0;
 
 	/* Normal mode */
@@ -2164,9 +2164,8 @@ static int do_wa9060(struct bnxt_qplib_qp *qp, struct bnxt_qplib_cq *cq,
 		i = cq->hwq.max_elements;
 		while (i--) {
 			peek_sw_cq_cons = HWQ_CMP((peek_sw_cq_cons), &cq->hwq);
-			peek_hw_cqe_ptr = (struct cq_base **)cq->hwq.pbl_ptr;
-			peek_hwcqe = &peek_hw_cqe_ptr[CQE_PG(peek_sw_cq_cons)]
-						     [CQE_IDX(peek_sw_cq_cons)];
+			peek_hwcqe = bnxt_qplib_get_qe(&cq->hwq,
+						       peek_sw_cq_cons, NULL);
 			/* If the next hwcqe is VALID */
 			if (CQE_CMP_VALID(peek_hwcqe, peek_raw_cq_cons,
 					  cq->hwq.max_elements)) {
@@ -2228,11 +2227,11 @@ static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
 				     struct bnxt_qplib_cqe **pcqe, int *budget,
 				     u32 cq_cons, struct bnxt_qplib_qp **lib_qp)
 {
-	struct bnxt_qplib_qp *qp;
-	struct bnxt_qplib_q *sq;
-	struct bnxt_qplib_cqe *cqe;
 	u32 sw_sq_cons, cqe_sq_cons;
 	struct bnxt_qplib_swq *swq;
+	struct bnxt_qplib_cqe *cqe;
+	struct bnxt_qplib_qp *qp;
+	struct bnxt_qplib_q *sq;
 	int rc = 0;
 
 	qp = (struct bnxt_qplib_qp *)((unsigned long)
@@ -2342,10 +2341,10 @@ static int bnxt_qplib_cq_process_res_rc(struct bnxt_qplib_cq *cq,
 					struct bnxt_qplib_cqe **pcqe,
 					int *budget)
 {
-	struct bnxt_qplib_qp *qp;
-	struct bnxt_qplib_q *rq;
 	struct bnxt_qplib_srq *srq;
 	struct bnxt_qplib_cqe *cqe;
+	struct bnxt_qplib_qp *qp;
+	struct bnxt_qplib_q *rq;
 	u32 wr_id_idx;
 	int rc = 0;
 
@@ -2417,10 +2416,10 @@ static int bnxt_qplib_cq_process_res_ud(struct bnxt_qplib_cq *cq,
 					struct bnxt_qplib_cqe **pcqe,
 					int *budget)
 {
-	struct bnxt_qplib_qp *qp;
-	struct bnxt_qplib_q *rq;
 	struct bnxt_qplib_srq *srq;
 	struct bnxt_qplib_cqe *cqe;
+	struct bnxt_qplib_qp *qp;
+	struct bnxt_qplib_q *rq;
 	u32 wr_id_idx;
 	int rc = 0;
 
@@ -2495,15 +2494,13 @@ static int bnxt_qplib_cq_process_res_ud(struct bnxt_qplib_cq *cq,
 
 bool bnxt_qplib_is_cq_empty(struct bnxt_qplib_cq *cq)
 {
-	struct cq_base *hw_cqe, **hw_cqe_ptr;
+	struct cq_base *hw_cqe;
 	u32 sw_cons, raw_cons;
 	bool rc = true;
 
 	raw_cons = cq->hwq.cons;
 	sw_cons = HWQ_CMP(raw_cons, &cq->hwq);
-	hw_cqe_ptr = (struct cq_base **)cq->hwq.pbl_ptr;
-	hw_cqe = &hw_cqe_ptr[CQE_PG(sw_cons)][CQE_IDX(sw_cons)];
-
+	hw_cqe = bnxt_qplib_get_qe(&cq->hwq, sw_cons, NULL);
 	 /* Check for Valid bit. If the CQE is valid, return false */
 	rc = !CQE_CMP_VALID(hw_cqe, raw_cons, cq->hwq.max_elements);
 	return rc;
@@ -2747,7 +2744,7 @@ int bnxt_qplib_process_flush_list(struct bnxt_qplib_cq *cq,
 int bnxt_qplib_poll_cq(struct bnxt_qplib_cq *cq, struct bnxt_qplib_cqe *cqe,
 		       int num_cqes, struct bnxt_qplib_qp **lib_qp)
 {
-	struct cq_base *hw_cqe, **hw_cqe_ptr;
+	struct cq_base *hw_cqe;
 	u32 sw_cons, raw_cons;
 	int budget, rc = 0;
 
@@ -2756,8 +2753,7 @@ int bnxt_qplib_poll_cq(struct bnxt_qplib_cq *cq, struct bnxt_qplib_cqe *cqe,
 
 	while (budget) {
 		sw_cons = HWQ_CMP(raw_cons, &cq->hwq);
-		hw_cqe_ptr = (struct cq_base **)cq->hwq.pbl_ptr;
-		hw_cqe = &hw_cqe_ptr[CQE_PG(sw_cons)][CQE_IDX(sw_cons)];
+		hw_cqe = bnxt_qplib_get_qe(&cq->hwq, sw_cons, NULL);
 
 		/* Check for Valid bit */
 		if (!CQE_CMP_VALID(hw_cqe, raw_cons, cq->hwq.max_elements))
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 7edb70b..568ca39 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -45,6 +45,7 @@ struct bnxt_qplib_srq {
 	struct bnxt_qplib_db_info	dbinfo;
 	u64				srq_handle;
 	u32				id;
+	u16				wqe_size;
 	u32				max_wqe;
 	u32				max_sge;
 	u32				threshold;
@@ -65,38 +66,7 @@ struct bnxt_qplib_sge {
 	u32				size;
 };
 
-#define BNXT_QPLIB_MAX_SQE_ENTRY_SIZE	sizeof(struct sq_send)
-
-#define SQE_CNT_PER_PG		(PAGE_SIZE / BNXT_QPLIB_MAX_SQE_ENTRY_SIZE)
-#define SQE_MAX_IDX_PER_PG	(SQE_CNT_PER_PG - 1)
-
-static inline u32 get_sqe_pg(u32 val)
-{
-	return ((val & ~SQE_MAX_IDX_PER_PG) / SQE_CNT_PER_PG);
-}
-
-static inline u32 get_sqe_idx(u32 val)
-{
-	return (val & SQE_MAX_IDX_PER_PG);
-}
-
-#define BNXT_QPLIB_MAX_PSNE_ENTRY_SIZE	sizeof(struct sq_psn_search)
-
-#define PSNE_CNT_PER_PG		(PAGE_SIZE / BNXT_QPLIB_MAX_PSNE_ENTRY_SIZE)
-#define PSNE_MAX_IDX_PER_PG	(PSNE_CNT_PER_PG - 1)
-
-static inline u32 get_psne_pg(u32 val)
-{
-	return ((val & ~PSNE_MAX_IDX_PER_PG) / PSNE_CNT_PER_PG);
-}
-
-static inline u32 get_psne_idx(u32 val)
-{
-	return (val & PSNE_MAX_IDX_PER_PG);
-}
-
 #define BNXT_QPLIB_QP_MAX_SGL	6
-
 struct bnxt_qplib_swq {
 	u64				wr_id;
 	int				next_idx;
@@ -226,19 +196,13 @@ struct bnxt_qplib_swqe {
 	};
 };
 
-#define BNXT_QPLIB_MAX_RQE_ENTRY_SIZE	sizeof(struct rq_wqe)
-
-#define RQE_CNT_PER_PG		(PAGE_SIZE / BNXT_QPLIB_MAX_RQE_ENTRY_SIZE)
-#define RQE_MAX_IDX_PER_PG	(RQE_CNT_PER_PG - 1)
-#define RQE_PG(x)		(((x) & ~RQE_MAX_IDX_PER_PG) / RQE_CNT_PER_PG)
-#define RQE_IDX(x)		((x) & RQE_MAX_IDX_PER_PG)
-
 struct bnxt_qplib_q {
 	struct bnxt_qplib_hwq		hwq;
 	struct bnxt_qplib_swq		*swq;
 	struct bnxt_qplib_db_info	dbinfo;
 	struct bnxt_qplib_sg_info	sg_info;
 	u32				max_wqe;
+	u16				wqe_size;
 	u16				q_full_delta;
 	u16				max_sge;
 	u32				psn;
@@ -256,7 +220,7 @@ struct bnxt_qplib_qp {
 	struct bnxt_qplib_dpi		*dpi;
 	struct bnxt_qplib_chip_ctx	*cctx;
 	u64				qp_handle;
-#define        BNXT_QPLIB_QP_ID_INVALID        0xFFFFFFFF
+#define BNXT_QPLIB_QP_ID_INVALID        0xFFFFFFFF
 	u32				id;
 	u8				type;
 	u8				sig_type;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index fe5e06f..4e21116 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -89,10 +89,9 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw, struct cmdq_base *req,
 			  struct creq_base *resp, void *sb, u8 is_block)
 {
 	struct bnxt_qplib_cmdq_ctx *cmdq = &rcfw->cmdq;
-	struct bnxt_qplib_cmdqe *cmdqe, **hwq_ptr;
 	struct bnxt_qplib_hwq *hwq = &cmdq->hwq;
 	struct bnxt_qplib_crsqe *crsqe;
-	u32 cmdq_depth = rcfw->cmdq_depth;
+	struct bnxt_qplib_cmdqe *cmdqe;
 	u32 sw_prod, cmdq_prod;
 	struct pci_dev *pdev;
 	unsigned long flags;
@@ -163,13 +162,11 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw, struct cmdq_base *req,
 				  BNXT_QPLIB_CMDQE_UNITS;
 	}
 
-	hwq_ptr = (struct bnxt_qplib_cmdqe **)hwq->pbl_ptr;
 	preq = (u8 *)req;
 	do {
 		/* Locate the next cmdq slot */
 		sw_prod = HWQ_CMP(hwq->prod, hwq);
-		cmdqe = &hwq_ptr[get_cmdq_pg(sw_prod, cmdq_depth)]
-				[get_cmdq_idx(sw_prod, cmdq_depth)];
+		cmdqe = bnxt_qplib_get_qe(hwq, sw_prod, NULL);
 		if (!cmdqe) {
 			dev_err(&pdev->dev,
 				"RCFW request failed with no cmdqe!\n");
@@ -378,7 +375,7 @@ static void bnxt_qplib_service_creq(unsigned long data)
 	struct bnxt_qplib_creq_ctx *creq = &rcfw->creq;
 	u32 type, budget = CREQ_ENTRY_POLL_BUDGET;
 	struct bnxt_qplib_hwq *hwq = &creq->hwq;
-	struct creq_base *creqe, **hwq_ptr;
+	struct creq_base *creqe;
 	u32 sw_cons, raw_cons;
 	unsigned long flags;
 
@@ -387,8 +384,7 @@ static void bnxt_qplib_service_creq(unsigned long data)
 	raw_cons = hwq->cons;
 	while (budget > 0) {
 		sw_cons = HWQ_CMP(raw_cons, hwq);
-		hwq_ptr = (struct creq_base **)hwq->pbl_ptr;
-		creqe = &hwq_ptr[get_creq_pg(sw_cons)][get_creq_idx(sw_cons)];
+		creqe = bnxt_qplib_get_qe(hwq, sw_cons, NULL);
 		if (!CREQ_CMP_VALID(creqe, raw_cons, hwq->max_elements))
 			break;
 		/* The valid test of the entry must be done first before
@@ -434,7 +430,6 @@ static irqreturn_t bnxt_qplib_creq_irq(int irq, void *dev_instance)
 {
 	struct bnxt_qplib_rcfw *rcfw = dev_instance;
 	struct bnxt_qplib_creq_ctx *creq;
-	struct creq_base **creq_ptr;
 	struct bnxt_qplib_hwq *hwq;
 	u32 sw_cons;
 
@@ -442,8 +437,7 @@ static irqreturn_t bnxt_qplib_creq_irq(int irq, void *dev_instance)
 	hwq = &creq->hwq;
 	/* Prefetch the CREQ element */
 	sw_cons = HWQ_CMP(hwq->cons, hwq);
-	creq_ptr = (struct creq_base **)creq->hwq.pbl_ptr;
-	prefetch(&creq_ptr[get_creq_pg(sw_cons)][get_creq_idx(sw_cons)]);
+	prefetch(bnxt_qplib_get_qe(hwq, sw_cons, NULL));
 
 	tasklet_schedule(&creq->creq_tasklet);
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 411fce3..bf38409 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -87,12 +87,6 @@ static inline u32 bnxt_qplib_cmdqe_page_size(u32 depth)
 	return (bnxt_qplib_cmdqe_npages(depth) * PAGE_SIZE);
 }
 
-static inline u32 bnxt_qplib_cmdqe_cnt_per_pg(u32 depth)
-{
-	return (bnxt_qplib_cmdqe_page_size(depth) /
-		 BNXT_QPLIB_CMDQE_UNITS);
-}
-
 /* Set the cmd_size to a factor of CMDQE unit */
 static inline void bnxt_qplib_set_cmd_slots(struct cmdq_base *req)
 {
@@ -100,30 +94,12 @@ static inline void bnxt_qplib_set_cmd_slots(struct cmdq_base *req)
 			 BNXT_QPLIB_CMDQE_UNITS;
 }
 
-#define MAX_CMDQ_IDX(depth)		((depth) - 1)
-
-static inline u32 bnxt_qplib_max_cmdq_idx_per_pg(u32 depth)
-{
-	return (bnxt_qplib_cmdqe_cnt_per_pg(depth) - 1);
-}
-
 #define RCFW_MAX_COOKIE_VALUE		0x7FFF
 #define RCFW_CMD_IS_BLOCKING		0x8000
 #define RCFW_BLOCKED_CMD_WAIT_COUNT	0x4E20
 
 #define HWRM_VERSION_RCFW_CMDQ_DEPTH_CHECK 0x1000900020011ULL
 
-static inline u32 get_cmdq_pg(u32 val, u32 depth)
-{
-	return (val & ~(bnxt_qplib_max_cmdq_idx_per_pg(depth))) /
-		(bnxt_qplib_cmdqe_cnt_per_pg(depth));
-}
-
-static inline u32 get_cmdq_idx(u32 val, u32 depth)
-{
-	return val & (bnxt_qplib_max_cmdq_idx_per_pg(depth));
-}
-
 /* Crsq buf is 1024-Byte */
 struct bnxt_qplib_crsbe {
 	u8			data[1024];
@@ -133,23 +109,6 @@ struct bnxt_qplib_crsbe {
 /* Allocate 1 per QP for async error notification for now */
 #define BNXT_QPLIB_CREQE_MAX_CNT	(64 * 1024)
 #define BNXT_QPLIB_CREQE_UNITS		16	/* 16-Bytes per prod unit */
-#define BNXT_QPLIB_CREQE_CNT_PER_PG	(PAGE_SIZE / BNXT_QPLIB_CREQE_UNITS)
-
-#define MAX_CREQ_IDX			(BNXT_QPLIB_CREQE_MAX_CNT - 1)
-#define MAX_CREQ_IDX_PER_PG		(BNXT_QPLIB_CREQE_CNT_PER_PG - 1)
-
-static inline u32 get_creq_pg(u32 val)
-{
-	return (val & ~MAX_CREQ_IDX_PER_PG) / BNXT_QPLIB_CREQE_CNT_PER_PG;
-}
-
-static inline u32 get_creq_idx(u32 val)
-{
-	return val & MAX_CREQ_IDX_PER_PG;
-}
-
-#define BNXT_QPLIB_CREQE_PER_PG	(PAGE_SIZE / sizeof(struct creq_base))
-
 #define CREQ_CMP_VALID(hdr, raw_cons, cp_bit)			\
 	(!!((hdr)->v & CREQ_BASE_V) ==				\
 	   !((raw_cons) & (cp_bit)))
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index cab1adf..7efa6e5 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -347,6 +347,7 @@ int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *hwq,
 	hwq->depth = hwq_attr->depth;
 	hwq->max_elements = depth;
 	hwq->element_size = stride;
+	hwq->qe_ppg = pg_size / stride;
 	/* For direct access to the elements */
 	lvl = hwq->level;
 	if (hwq_attr->sginfo->nopte && hwq->level)
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 79109ef..c29cbd3 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -135,6 +135,7 @@ struct bnxt_qplib_hwq {
 	u32				max_elements;
 	u32				depth;
 	u16				element_size;	/* Size of each entry */
+	u16				qe_ppg;	/* queue entry per page */
 
 	u32				prod;		/* raw */
 	u32				cons;		/* raw */
@@ -304,6 +305,18 @@ static inline u8 bnxt_qplib_base_pg_size(struct bnxt_qplib_hwq *hwq)
 	return pg_size;
 }
 
+static inline void *bnxt_qplib_get_qe(struct bnxt_qplib_hwq *hwq,
+				      u32 indx, u64 *pg)
+{
+	u32 pg_num, pg_idx;
+
+	pg_num = (indx / hwq->qe_ppg);
+	pg_idx = (indx % hwq->qe_ppg);
+	if (pg)
+		*pg = (u64)&hwq->pbl_ptr[pg_num];
+	return (void *)(hwq->pbl_ptr[pg_num] + hwq->element_size * pg_idx);
+}
+
 #define to_bnxt_qplib(ptr, type, member)	\
 	container_of(ptr, type, member)
 
-- 
1.8.3.1

