Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0526220F08
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2020 16:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgGOORY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jul 2020 10:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgGOORX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jul 2020 10:17:23 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840F1C061755
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2020 07:17:23 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gc15so1998338pjb.0
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2020 07:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XLf1QwxGfHxslYQRwvjYE/XM/sZ/chI6250to8ORScg=;
        b=WArjbJn4iJ6FP8+U0I0A6qxUq4QBOy3Q5zqeQhFwjx2H7PUAuOev8dlI5ln9IJtvne
         84/jrztt7wCgHiK4ZrhVfgQJfPDuoLnl4B72q63+fCTEflPU8rE0hpNcEJmjtHxJHkG7
         xMDOVzBj9NemlQfzpqxi9LqaZBaHXN9Wkn+ZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XLf1QwxGfHxslYQRwvjYE/XM/sZ/chI6250to8ORScg=;
        b=FJlgpYBHJV9dqOWiuDC343E0hxS1qsQM0RIjj1yqkC43Gr2fwfDdMY4XBLt8WJiRy2
         moktwtXlo+MaVgDB4tsgSwZfkRCw17lkUkmq4sO896cLkRKMncGfAWsSaFL9PNvbAuI6
         PSZ7/QlrNUxLuXEX8ZZA2k4FLNYDiB6EjY8svZrFK9ViqmcCziDqKcTODc4GKXbCKcP9
         chG6mk9eSiWuil0ybXcJfH9Gt93BOShzy17cQuGLazK5chp7s6P0W0vh3U6CTudrpqIj
         PMJOFWBYcDjwMTm2Zdd9sxO5JQfzJwhpFpfFyxg5T+XVHQmpyfeKB4OahSdne5swrphj
         F0YA==
X-Gm-Message-State: AOAM5312Ww0Z2MiN6axa4j7RbLz3mloTkYrOWbd1V2enwKbENNSomaqh
        x4FqTAsp9Wsz2CSA0Ndoe/v+O9YGcxZY6nUKcwKNHkjpj36oImScKz4z/+xIaED31/PTjO6Q3Pt
        w2JMDfTkZgdJohVrHQZ0icWC+wSFBOZkJg0zq/J46ZSCJhUeI8DdXY4Dqfg7RfwwUNLXabtwp2d
        JQu8s=
X-Google-Smtp-Source: ABdhPJyUjtHvp5T5SZV2i+84pQB5aZwkCi9InSQtaehaZG6Hqsp3RQNfWRI50tufN8PtS/5hUsmtCQ==
X-Received: by 2002:a17:902:6bc5:: with SMTP id m5mr2029554plt.150.1594822641933;
        Wed, 15 Jul 2020 07:17:21 -0700 (PDT)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k92sm2399254pje.30.2020.07.15.07.17.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 07:17:21 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     devesh.sharma@broadcom.com, leon@kernel.org
Subject: [PATCH V2 for-next 5/6] RDMA/bnxt_re: Change wr posting logic to accommodate variable wqes
Date:   Wed, 15 Jul 2020 10:16:58 -0400
Message-Id: <1594822619-4098-6-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1594822619-4098-1-git-send-email-devesh.sharma@broadcom.com>
References: <1594822619-4098-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Modifying the post-send and post-recv to initialize the
wqes slot by slot dynamically depending on the number of
max sges requested by consumer at the time of QP creation.

Changed the QP creation logic to determine the size of
SQ and RQ in 16B slots based on the number of wqe and
number of SGEs requested by consumer

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 167 +++++++++++----
 drivers/infiniband/hw/bnxt_re/ib_verbs.h  |   8 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 324 +++++++++++++++++++-----------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  60 +++++-
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  12 +-
 5 files changed, 398 insertions(+), 173 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index e97bee3..3f18efc 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -842,16 +842,79 @@ static u8 __from_ib_qp_type(enum ib_qp_type type)
 	}
 }
 
+static u16 bnxt_re_setup_rwqe_size(struct bnxt_qplib_qp *qplqp,
+				   int rsge, int max)
+{
+	if (qplqp->wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC)
+		rsge = max;
+	return bnxt_re_get_rwqe_size(rsge);
+}
+
+static u16 bnxt_re_get_wqe_size(int ilsize, int nsge)
+{
+	u16 wqe_size, calc_ils;
+
+	wqe_size = bnxt_re_get_swqe_size(nsge);
+	if (ilsize) {
+		calc_ils = sizeof(struct sq_send_hdr) + ilsize;
+		wqe_size = max_t(u16, calc_ils, wqe_size);
+		wqe_size = ALIGN(wqe_size, sizeof(struct sq_send_hdr));
+	}
+	return wqe_size;
+}
+
+static int bnxt_re_setup_swqe_size(struct bnxt_re_qp *qp,
+				   struct ib_qp_init_attr *init_attr)
+{
+	struct bnxt_qplib_dev_attr *dev_attr;
+	struct bnxt_qplib_qp *qplqp;
+	struct bnxt_re_dev *rdev;
+	struct bnxt_qplib_q *sq;
+	int align, ilsize;
+
+	rdev = qp->rdev;
+	qplqp = &qp->qplib_qp;
+	sq = &qplqp->sq;
+	dev_attr = &rdev->dev_attr;
+
+	align = sizeof(struct sq_send_hdr);
+	ilsize = ALIGN(init_attr->cap.max_inline_data, align);
+
+	sq->wqe_size = bnxt_re_get_wqe_size(ilsize, sq->max_sge);
+	if (sq->wqe_size > bnxt_re_get_swqe_size(dev_attr->max_qp_sges))
+		return -EINVAL;
+	/* For gen p4 and gen p5 backward compatibility mode
+	 * wqe size is fixed to 128 bytes
+	 */
+	if (sq->wqe_size < bnxt_re_get_swqe_size(dev_attr->max_qp_sges) &&
+			qplqp->wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC)
+		sq->wqe_size = bnxt_re_get_swqe_size(dev_attr->max_qp_sges);
+
+	if (init_attr->cap.max_inline_data) {
+		qplqp->max_inline_data = sq->wqe_size -
+			sizeof(struct sq_send_hdr);
+		init_attr->cap.max_inline_data = qplqp->max_inline_data;
+		if (qplqp->wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC)
+			sq->max_sge = qplqp->max_inline_data /
+				sizeof(struct sq_sge);
+	}
+
+	return 0;
+}
+
 static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 				struct bnxt_re_qp *qp, struct ib_udata *udata)
 {
+	struct bnxt_qplib_qp *qplib_qp;
+	struct bnxt_re_ucontext *cntx;
 	struct bnxt_re_qp_req ureq;
-	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
-	struct ib_umem *umem;
 	int bytes = 0, psn_sz;
-	struct bnxt_re_ucontext *cntx = rdma_udata_to_drv_context(
-		udata, struct bnxt_re_ucontext, ib_uctx);
+	struct ib_umem *umem;
+	int psn_nume;
 
+	qplib_qp = &qp->qplib_qp;
+	cntx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext,
+					 ib_uctx);
 	if (ib_copy_from_udata(&ureq, udata, sizeof(ureq)))
 		return -EFAULT;
 
@@ -859,10 +922,15 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	/* Consider mapping PSN search memory only for RC QPs. */
 	if (qplib_qp->type == CMDQ_CREATE_QP_TYPE_RC) {
 		psn_sz = bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx) ?
-					sizeof(struct sq_psn_search_ext) :
-					sizeof(struct sq_psn_search);
-		bytes += (qplib_qp->sq.max_wqe * psn_sz);
+						   sizeof(struct sq_psn_search_ext) :
+						   sizeof(struct sq_psn_search);
+		psn_nume = (qplib_qp->wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC) ?
+			    qplib_qp->sq.max_wqe :
+			    ((qplib_qp->sq.max_wqe * qplib_qp->sq.wqe_size) /
+			      sizeof(struct bnxt_qplib_sge));
+		bytes += (psn_nume * psn_sz);
 	}
+
 	bytes = PAGE_ALIGN(bytes);
 	umem = ib_umem_get(&rdev->ibdev, ureq.qpsva, bytes,
 			   IB_ACCESS_LOCAL_WRITE);
@@ -975,7 +1043,7 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	qp->qplib_qp.sig_type = true;
 
 	/* Shadow QP SQ depth should be same as QP1 RQ depth */
-	qp->qplib_qp.sq.wqe_size = bnxt_re_get_swqe_size();
+	qp->qplib_qp.sq.wqe_size = bnxt_re_get_wqe_size(0, 6);
 	qp->qplib_qp.sq.max_wqe = qp1_qp->rq.max_wqe;
 	qp->qplib_qp.sq.max_sge = 2;
 	/* Q full delta can be 1 since it is internal QP */
@@ -986,7 +1054,7 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	qp->qplib_qp.scq = qp1_qp->scq;
 	qp->qplib_qp.rcq = qp1_qp->rcq;
 
-	qp->qplib_qp.rq.wqe_size = bnxt_re_get_rwqe_size();
+	qp->qplib_qp.rq.wqe_size = bnxt_re_get_rwqe_size(6);
 	qp->qplib_qp.rq.max_wqe = qp1_qp->rq.max_wqe;
 	qp->qplib_qp.rq.max_sge = qp1_qp->rq.max_sge;
 	/* Q full delta can be 1 since it is internal QP */
@@ -1041,19 +1109,21 @@ static int bnxt_re_init_rq_attr(struct bnxt_re_qp *qp,
 		qplqp->srq = &srq->qplib_srq;
 		rq->max_wqe = 0;
 	} else {
-		rq->wqe_size = bnxt_re_get_rwqe_size();
+		rq->max_sge = init_attr->cap.max_recv_sge;
+		if (rq->max_sge > dev_attr->max_qp_sges)
+			rq->max_sge = dev_attr->max_qp_sges;
+		init_attr->cap.max_recv_sge = rq->max_sge;
+		rq->wqe_size = bnxt_re_setup_rwqe_size(qplqp, rq->max_sge,
+						       dev_attr->max_qp_sges);
 		/* Allocate 1 more than what's provided so posting max doesn't
 		 * mean empty.
 		 */
 		entries = roundup_pow_of_two(init_attr->cap.max_recv_wr + 1);
 		rq->max_wqe = min_t(u32, entries, dev_attr->max_qp_wqes + 1);
-		rq->q_full_delta = rq->max_wqe - init_attr->cap.max_recv_wr;
-		rq->max_sge = init_attr->cap.max_recv_sge;
-		if (rq->max_sge > dev_attr->max_qp_sges)
-			rq->max_sge = dev_attr->max_qp_sges;
+		rq->q_full_delta = 0;
+		rq->sg_info.pgsize = PAGE_SIZE;
+		rq->sg_info.pgshft = PAGE_SHIFT;
 	}
-	rq->sg_info.pgsize = PAGE_SIZE;
-	rq->sg_info.pgshft = PAGE_SHIFT;
 
 	return 0;
 }
@@ -1068,41 +1138,48 @@ static void bnxt_re_adjust_gsi_rq_attr(struct bnxt_re_qp *qp)
 	qplqp = &qp->qplib_qp;
 	dev_attr = &rdev->dev_attr;
 
-	qplqp->rq.max_sge = dev_attr->max_qp_sges;
-	if (qplqp->rq.max_sge > dev_attr->max_qp_sges)
+	if (!bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx)) {
 		qplqp->rq.max_sge = dev_attr->max_qp_sges;
-	qplqp->rq.max_sge = 6;
+		if (qplqp->rq.max_sge > dev_attr->max_qp_sges)
+			qplqp->rq.max_sge = dev_attr->max_qp_sges;
+		qplqp->rq.max_sge = 6;
+	}
 }
 
-static void bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
-				 struct ib_qp_init_attr *init_attr,
-				 struct ib_udata *udata)
+static int bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
+				struct ib_qp_init_attr *init_attr,
+				struct ib_udata *udata)
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_qp *qplqp;
 	struct bnxt_re_dev *rdev;
 	struct bnxt_qplib_q *sq;
 	int entries;
+	int diff;
+	int rc;
 
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
 	sq = &qplqp->sq;
 	dev_attr = &rdev->dev_attr;
 
-	sq->wqe_size = bnxt_re_get_swqe_size();
 	sq->max_sge = init_attr->cap.max_send_sge;
-	if (sq->max_sge > dev_attr->max_qp_sges)
+	if (sq->max_sge > dev_attr->max_qp_sges) {
 		sq->max_sge = dev_attr->max_qp_sges;
-	/*
-	 * Change the SQ depth if user has requested minimum using
-	 * configfs. Only supported for kernel consumers
-	 */
+		init_attr->cap.max_send_sge = sq->max_sge;
+	}
+
+	rc = bnxt_re_setup_swqe_size(qp, init_attr);
+	if (rc)
+		return rc;
+
 	entries = init_attr->cap.max_send_wr;
 	/* Allocate 128 + 1 more than what's provided */
-	entries = roundup_pow_of_two(entries + BNXT_QPLIB_RESERVED_QP_WRS + 1);
-	sq->max_wqe = min_t(u32, entries, dev_attr->max_qp_wqes +
-			    BNXT_QPLIB_RESERVED_QP_WRS + 1);
-	sq->q_full_delta = BNXT_QPLIB_RESERVED_QP_WRS + 1;
+	diff = (qplqp->wqe_mode == BNXT_QPLIB_WQE_MODE_VARIABLE) ?
+		0 : BNXT_QPLIB_RESERVED_QP_WRS;
+	entries = roundup_pow_of_two(entries + diff + 1);
+	sq->max_wqe = min_t(u32, entries, dev_attr->max_qp_wqes + diff + 1);
+	sq->q_full_delta = diff + 1;
 	/*
 	 * Reserving one slot for Phantom WQE. Application can
 	 * post one extra entry in this case. But allowing this to avoid
@@ -1111,6 +1188,8 @@ static void bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
 	qplqp->sq.q_full_delta -= 1;
 	qplqp->sq.sg_info.pgsize = PAGE_SIZE;
 	qplqp->sq.sg_info.pgshft = PAGE_SHIFT;
+
+	return 0;
 }
 
 static void bnxt_re_adjust_gsi_sq_attr(struct bnxt_re_qp *qp,
@@ -1125,13 +1204,16 @@ static void bnxt_re_adjust_gsi_sq_attr(struct bnxt_re_qp *qp,
 	qplqp = &qp->qplib_qp;
 	dev_attr = &rdev->dev_attr;
 
-	entries = roundup_pow_of_two(init_attr->cap.max_send_wr + 1);
-	qplqp->sq.max_wqe = min_t(u32, entries, dev_attr->max_qp_wqes + 1);
-	qplqp->sq.q_full_delta = qplqp->sq.max_wqe -
-				 init_attr->cap.max_send_wr;
-	qplqp->sq.max_sge++; /* Need one extra sge to put UD header */
-	if (qplqp->sq.max_sge > dev_attr->max_qp_sges)
-		qplqp->sq.max_sge = dev_attr->max_qp_sges;
+	if (!bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx)) {
+		entries = roundup_pow_of_two(init_attr->cap.max_send_wr + 1);
+		qplqp->sq.max_wqe = min_t(u32, entries,
+					  dev_attr->max_qp_wqes + 1);
+		qplqp->sq.q_full_delta = qplqp->sq.max_wqe -
+			init_attr->cap.max_send_wr;
+		qplqp->sq.max_sge++; /* Need one extra sge to put UD header */
+		if (qplqp->sq.max_sge > dev_attr->max_qp_sges)
+			qplqp->sq.max_sge = dev_attr->max_qp_sges;
+	}
 }
 
 static int bnxt_re_init_qp_type(struct bnxt_re_dev *rdev,
@@ -1227,7 +1309,9 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 		bnxt_re_adjust_gsi_rq_attr(qp);
 
 	/* Setup SQ */
-	bnxt_re_init_sq_attr(qp, init_attr, udata);
+	rc = bnxt_re_init_sq_attr(qp, init_attr, udata);
+	if (rc)
+		goto out;
 	if (init_attr->qp_type == IB_QPT_GSI)
 		bnxt_re_adjust_gsi_sq_attr(qp, init_attr);
 
@@ -1575,8 +1659,9 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 		entries = dev_attr->max_srq_wqes + 1;
 	srq->qplib_srq.max_wqe = entries;
 
-	srq->qplib_srq.wqe_size = bnxt_re_get_rwqe_size();
 	srq->qplib_srq.max_sge = srq_init_attr->attr.max_sge;
+	srq->qplib_srq.wqe_size =
+			bnxt_re_get_rwqe_size(srq->qplib_srq.max_sge);
 	srq->qplib_srq.threshold = srq_init_attr->attr.srq_limit;
 	srq->srq_limit = srq_init_attr->attr.srq_limit;
 	srq->qplib_srq.eventq_hw_ring_id = rdev->nq[0].ring_id;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index b4a06b5..1daeb30 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -136,14 +136,14 @@ struct bnxt_re_ucontext {
 	spinlock_t		sh_lock;	/* protect shpg */
 };
 
-static inline u16 bnxt_re_get_swqe_size(void)
+static inline u16 bnxt_re_get_swqe_size(int nsge)
 {
-	return sizeof(struct sq_send);
+	return sizeof(struct sq_send_hdr) + nsge * sizeof(struct sq_sge);
 }
 
-static inline u16 bnxt_re_get_rwqe_size(void)
+static inline u16 bnxt_re_get_rwqe_size(int nsge)
 {
-	return sizeof(struct rq_wqe);
+	return sizeof(struct rq_wqe_hdr) + (nsge * sizeof(struct sq_sge));
 }
 
 int bnxt_re_query_device(struct ib_device *ibdev,
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index e1896d3..117b423 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -660,6 +660,7 @@ int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
 	srq->dbinfo.hwq = &srq->hwq;
 	srq->dbinfo.xid = srq->id;
 	srq->dbinfo.db = srq->dpi->dbr;
+	srq->dbinfo.max_slot = 1;
 	srq->dbinfo.priv_db = res->dpi_tbl.dbr_bar_reg_iomem;
 	if (srq->threshold)
 		bnxt_qplib_armen_db(&srq->dbinfo, DBC_DBC_TYPE_SRQ_ARMENA);
@@ -797,10 +798,8 @@ static int bnxt_qplib_alloc_init_swq(struct bnxt_qplib_q *que)
 
 	que->swq_start = 0;
 	que->swq_last = que->max_wqe - 1;
-	for (indx = 0; indx < que->max_wqe; indx++) {
-		que->swq[indx].slots = 1;
+	for (indx = 0; indx < que->max_wqe; indx++)
 		que->swq[indx].next_idx = indx + 1;
-	}
 	que->swq[que->swq_last].next_idx = 0; /* Make it circular */
 	que->swq_last = 0;
 out:
@@ -831,8 +830,8 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	/* SQ */
 	hwq_attr.res = res;
 	hwq_attr.sginfo = &sq->sg_info;
-	hwq_attr.depth = sq->max_wqe;
-	hwq_attr.stride = sq->wqe_size;
+	hwq_attr.stride = sizeof(struct sq_sge);
+	hwq_attr.depth = bnxt_qplib_get_depth(sq);
 	hwq_attr.type = HWQ_TYPE_QUEUE;
 	rc = bnxt_qplib_alloc_init_hwq(&sq->hwq, &hwq_attr);
 	if (rc)
@@ -842,7 +841,7 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	if (rc)
 		goto fail_sq;
 
-	req.sq_size = cpu_to_le32(sq->max_wqe);
+	req.sq_size = cpu_to_le32(bnxt_qplib_set_sq_size(sq, qp->wqe_mode));
 	pbl = &sq->hwq.pbl[PBL_LVL_0];
 	req.sq_pbl = cpu_to_le64(pbl->pg_map_arr[0]);
 	pg_sz_lvl = (bnxt_qplib_base_pg_size(&sq->hwq) <<
@@ -858,8 +857,8 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	if (rq->max_wqe) {
 		hwq_attr.res = res;
 		hwq_attr.sginfo = &rq->sg_info;
-		hwq_attr.stride = rq->wqe_size;
-		hwq_attr.depth = qp->rq.max_wqe;
+		hwq_attr.stride = sizeof(struct sq_sge);
+		hwq_attr.depth = bnxt_qplib_get_depth(rq);
 		hwq_attr.type = HWQ_TYPE_QUEUE;
 		rc = bnxt_qplib_alloc_init_hwq(&rq->hwq, &hwq_attr);
 		if (rc)
@@ -901,10 +900,12 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	sq->dbinfo.hwq = &sq->hwq;
 	sq->dbinfo.xid = qp->id;
 	sq->dbinfo.db = qp->dpi->dbr;
+	sq->dbinfo.max_slot = bnxt_qplib_set_sq_max_slot(qp->wqe_mode);
 	if (rq->max_wqe) {
 		rq->dbinfo.hwq = &rq->hwq;
 		rq->dbinfo.xid = qp->id;
 		rq->dbinfo.db = qp->dpi->dbr;
+		rq->dbinfo.max_slot = bnxt_qplib_set_rq_max_slot(rq->wqe_size);
 	}
 	rcfw->qp_tbl[qp->id].qp_id = qp->id;
 	rcfw->qp_tbl[qp->id].qp_handle = (void *)qp;
@@ -976,10 +977,10 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 
 	hwq_attr.res = res;
 	hwq_attr.sginfo = &sq->sg_info;
-	hwq_attr.stride = sq->wqe_size;
-	hwq_attr.depth = sq->max_wqe;
+	hwq_attr.stride = sizeof(struct sq_sge);
+	hwq_attr.depth = bnxt_qplib_get_depth(sq);
 	hwq_attr.aux_stride = psn_sz;
-	hwq_attr.aux_depth = hwq_attr.depth;
+	hwq_attr.aux_depth = bnxt_qplib_set_sq_size(sq, qp->wqe_mode);
 	hwq_attr.type = HWQ_TYPE_QUEUE;
 	rc = bnxt_qplib_alloc_init_hwq(&sq->hwq, &hwq_attr);
 	if (rc)
@@ -992,7 +993,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	if (psn_sz)
 		bnxt_qplib_init_psn_ptr(qp, psn_sz);
 
-	req.sq_size = cpu_to_le32(sq->max_wqe);
+	req.sq_size = cpu_to_le32(bnxt_qplib_set_sq_size(sq, qp->wqe_mode));
 	pbl = &sq->hwq.pbl[PBL_LVL_0];
 	req.sq_pbl = cpu_to_le64(pbl->pg_map_arr[0]);
 	pg_sz_lvl = (bnxt_qplib_base_pg_size(&sq->hwq) <<
@@ -1008,8 +1009,8 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	if (!qp->srq) {
 		hwq_attr.res = res;
 		hwq_attr.sginfo = &rq->sg_info;
-		hwq_attr.stride = rq->wqe_size;
-		hwq_attr.depth = rq->max_wqe;
+		hwq_attr.stride = sizeof(struct sq_sge);
+		hwq_attr.depth = bnxt_qplib_get_depth(rq);
 		hwq_attr.aux_stride = 0;
 		hwq_attr.aux_depth = 0;
 		hwq_attr.type = HWQ_TYPE_QUEUE;
@@ -1044,6 +1045,8 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_FR_PMR_ENABLED;
 	if (qp->sig_type)
 		qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_FORCE_COMPLETION;
+	if (qp->wqe_mode == BNXT_QPLIB_WQE_MODE_VARIABLE)
+		qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_VARIABLE_SIZED_WQE_ENABLED;
 	req.qp_flags = cpu_to_le32(qp_flags);
 
 	/* ORRQ and IRRQ */
@@ -1101,10 +1104,12 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	sq->dbinfo.hwq = &sq->hwq;
 	sq->dbinfo.xid = qp->id;
 	sq->dbinfo.db = qp->dpi->dbr;
+	sq->dbinfo.max_slot = bnxt_qplib_set_sq_max_slot(qp->wqe_mode);
 	if (rq->max_wqe) {
 		rq->dbinfo.hwq = &rq->hwq;
 		rq->dbinfo.xid = qp->id;
 		rq->dbinfo.db = qp->dpi->dbr;
+		rq->dbinfo.max_slot = bnxt_qplib_set_rq_max_slot(rq->wqe_size);
 	}
 	rcfw->qp_tbl[qp->id].qp_id = qp->id;
 	rcfw->qp_tbl[qp->id].qp_handle = (void *)qp;
@@ -1562,22 +1567,115 @@ static void bnxt_qplib_fill_psn_search(struct bnxt_qplib_qp *qp,
 	if (bnxt_qplib_is_chip_gen_p5(qp->cctx)) {
 		psns_ext->opcode_start_psn = cpu_to_le32(op_spsn);
 		psns_ext->flags_next_psn = cpu_to_le32(flg_npsn);
+		psns_ext->start_slot_idx = cpu_to_le16(swq->slot_idx);
 	} else {
 		psns->opcode_start_psn = cpu_to_le32(op_spsn);
 		psns->flags_next_psn = cpu_to_le32(flg_npsn);
 	}
 }
 
+static int bnxt_qplib_put_inline(struct bnxt_qplib_qp *qp,
+				 struct bnxt_qplib_swqe *wqe,
+				 u16 *idx)
+{
+	struct bnxt_qplib_hwq *hwq;
+	int len, t_len, offt;
+	bool pull_dst = true;
+	void *il_dst = NULL;
+	void *il_src = NULL;
+	int t_cplen, cplen;
+	int indx;
+
+	hwq = &qp->sq.hwq;
+	t_len = 0;
+	for (indx = 0; indx < wqe->num_sge; indx++) {
+		len = wqe->sg_list[indx].size;
+		il_src = (void *)wqe->sg_list[indx].addr;
+		t_len += len;
+		if (t_len > qp->max_inline_data)
+			goto bad;
+		while (len) {
+			if (pull_dst) {
+				pull_dst = false;
+				il_dst = bnxt_qplib_get_prod_qe(hwq, *idx);
+				(*idx)++;
+				t_cplen = 0;
+				offt = 0;
+			}
+			cplen = min_t(int, len, sizeof(struct sq_sge));
+			cplen = min_t(int, cplen,
+					(sizeof(struct sq_sge) - offt));
+			memcpy(il_dst, il_src, cplen);
+			t_cplen += cplen;
+			il_src += cplen;
+			il_dst += cplen;
+			offt += cplen;
+			len -= cplen;
+			if (t_cplen == sizeof(struct sq_sge))
+				pull_dst = true;
+		}
+	}
+
+	return t_len;
+bad:
+	return -ENOMEM;
+}
+
+static u32 bnxt_qplib_put_sges(struct bnxt_qplib_hwq *hwq,
+			       struct bnxt_qplib_sge *ssge,
+			       u16 nsge, u16 *idx)
+{
+	struct sq_sge *dsge;
+	int indx, len = 0;
+
+	for (indx = 0; indx < nsge; indx++, (*idx)++) {
+		dsge = bnxt_qplib_get_prod_qe(hwq, *idx);
+		dsge->va_or_pa = cpu_to_le64(ssge[indx].addr);
+		dsge->l_key = cpu_to_le32(ssge[indx].lkey);
+		dsge->size = cpu_to_le32(ssge[indx].size);
+		len += ssge[indx].size;
+	}
+
+	return len;
+}
+
+static u16 bnxt_qplib_required_slots(struct bnxt_qplib_qp *qp,
+				     struct bnxt_qplib_swqe *wqe,
+				     u16 *wqe_sz, u16 *qdf, u8 mode)
+{
+	u32 ilsize, bytes;
+	u16 nsge;
+	u16 slot;
+
+	nsge = wqe->num_sge;
+	/* Adding sq_send_hdr is a misnomer, for rq also hdr size is same. */
+	bytes = sizeof(struct sq_send_hdr) + nsge * sizeof(struct sq_sge);
+	if (wqe->flags & BNXT_QPLIB_SWQE_FLAGS_INLINE) {
+		ilsize = bnxt_qplib_calc_ilsize(wqe, qp->max_inline_data);
+		bytes = ALIGN(ilsize, sizeof(struct sq_sge));
+		bytes += sizeof(struct sq_send_hdr);
+	}
+
+	*qdf =  __xlate_qfd(qp->sq.q_full_delta, bytes);
+	slot = bytes >> 4;
+	*wqe_sz = slot;
+	if (mode == BNXT_QPLIB_WQE_MODE_STATIC)
+		slot = 8;
+	return slot;
+}
+
 static void bnxt_qplib_pull_psn_buff(struct bnxt_qplib_q *sq,
-				     struct bnxt_qplib_swq *swq, u32 tail)
+				     struct bnxt_qplib_swq *swq)
 {
 	struct bnxt_qplib_hwq *hwq;
 	u32 pg_num, pg_indx;
 	void *buff;
+	u32 tail;
 
 	hwq = &sq->hwq;
 	if (!hwq->pad_pg)
 		return;
+	tail = swq->slot_idx / sq->dbinfo.max_slot;
 	pg_num = (tail + hwq->pad_pgofft) / (PAGE_SIZE / hwq->pad_stride);
 	pg_indx = (tail + hwq->pad_pgofft) % (PAGE_SIZE / hwq->pad_stride);
 	buff = (void *)(hwq->pad_pg[pg_num] + pg_indx * hwq->pad_stride);
@@ -1598,14 +1696,16 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 	struct bnxt_qplib_nq_work *nq_work = NULL;
 	int i, rc = 0, data_len = 0, pkt_num = 0;
 	struct bnxt_qplib_q *sq = &qp->sq;
-	struct sq_send *hw_sq_send_hdr;
 	struct bnxt_qplib_hwq *hwq;
 	struct bnxt_qplib_swq *swq;
 	bool sch_handler = false;
-	struct sq_sge *hw_sge;
-	u8 wqe_size16;
+	u16 wqe_sz, qdf = 0;
+	void *base_hdr;
+	void *ext_hdr;
 	__le32 temp32;
-	u32 sw_prod;
+	u32 wqe_idx;
+	u32 slots;
+	u16 idx;
 
 	hwq = &sq->hwq;
 	if (qp->state != CMDQ_MODIFY_QP_NEW_STATE_RTS &&
@@ -1617,18 +1717,21 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 		goto done;
 	}
 
-	if (bnxt_qplib_queue_full(sq)) {
+	slots = bnxt_qplib_required_slots(qp, wqe, &wqe_sz, &qdf, qp->wqe_mode);
+	if (bnxt_qplib_queue_full(sq, slots + qdf)) {
 		dev_err(&hwq->pdev->dev,
 			"prod = %#x cons = %#x qdepth = %#x delta = %#x\n",
-			hwq->prod, hwq->cons, hwq->max_elements,
-			sq->q_full_delta);
+			hwq->prod, hwq->cons, hwq->depth, sq->q_full_delta);
 		rc = -ENOMEM;
 		goto done;
 	}
 
-	sw_prod = sq->hwq.prod;
-	swq = bnxt_qplib_get_swqe(sq, NULL);
-	bnxt_qplib_pull_psn_buff(sq, swq, sw_prod);
+	swq = bnxt_qplib_get_swqe(sq, &wqe_idx);
+	bnxt_qplib_pull_psn_buff(sq, swq);
+
+	idx = 0;
+	swq->slot_idx = hwq->prod;
+	swq->slots = slots;
 	swq->wr_id = wqe->wr_id;
 	swq->type = wqe->type;
 	swq->flags = wqe->flags;
@@ -1636,8 +1739,6 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 	if (qp->sig_type)
 		swq->flags |= SQ_SEND_FLAGS_SIGNAL_COMP;
 
-	hw_sq_send_hdr = bnxt_qplib_get_qe(hwq, sw_prod, NULL);
-	memset(hw_sq_send_hdr, 0, sq->wqe_size);
 	if (qp->state == CMDQ_MODIFY_QP_NEW_STATE_ERR) {
 		sch_handler = true;
 		dev_dbg(&hwq->pdev->dev,
@@ -1645,50 +1746,34 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 		goto queue_err;
 	}
 
-	if (wqe->flags & BNXT_QPLIB_SWQE_FLAGS_INLINE) {
-		/* Copy the inline data */
-		if (wqe->inline_len > BNXT_QPLIB_SWQE_MAX_INLINE_LENGTH) {
-			dev_warn(&hwq->pdev->dev,
-				 "Inline data length > 96 detected\n");
-			data_len = BNXT_QPLIB_SWQE_MAX_INLINE_LENGTH;
-		} else {
-			data_len = wqe->inline_len;
-		}
-		memcpy(hw_sq_send_hdr->data, wqe->inline_data, data_len);
-		wqe_size16 = (data_len + 15) >> 4;
-	} else {
-		for (i = 0, hw_sge = (struct sq_sge *)hw_sq_send_hdr->data;
-		     i < wqe->num_sge; i++, hw_sge++) {
-			hw_sge->va_or_pa = cpu_to_le64(wqe->sg_list[i].addr);
-			hw_sge->l_key = cpu_to_le32(wqe->sg_list[i].lkey);
-			hw_sge->size = cpu_to_le32(wqe->sg_list[i].size);
-			data_len += wqe->sg_list[i].size;
-		}
-		/* Each SGE entry = 1 WQE size16 */
-		wqe_size16 = wqe->num_sge;
-		/* HW requires wqe size has room for atleast one SGE even if
-		 * none was supplied by ULP
-		 */
-		if (!wqe->num_sge)
-			wqe_size16++;
-	}
+	base_hdr = bnxt_qplib_get_prod_qe(hwq, idx++);
+	ext_hdr = bnxt_qplib_get_prod_qe(hwq, idx++);
+	memset(base_hdr, 0, sizeof(struct sq_sge));
+	memset(ext_hdr, 0, sizeof(struct sq_sge));
 
+	if (wqe->flags & BNXT_QPLIB_SWQE_FLAGS_INLINE)
+		/* Copy the inline data */
+		data_len = bnxt_qplib_put_inline(qp, wqe, &idx);
+	else
+		data_len = bnxt_qplib_put_sges(hwq, wqe->sg_list, wqe->num_sge,
+					       &idx);
+	if (data_len < 0)
+		goto queue_err;
 	/* Specifics */
 	switch (wqe->type) {
 	case BNXT_QPLIB_SWQE_TYPE_SEND:
 		if (qp->type == CMDQ_CREATE_QP1_TYPE_GSI) {
+			struct sq_send_raweth_qp1_hdr *sqe = base_hdr;
+			struct sq_raw_ext_hdr *ext_sqe = ext_hdr;
 			/* Assemble info for Raw Ethertype QPs */
-			struct sq_send_raweth_qp1 *sqe =
-				(struct sq_send_raweth_qp1 *)hw_sq_send_hdr;
 
 			sqe->wqe_type = wqe->type;
 			sqe->flags = wqe->flags;
-			sqe->wqe_size = wqe_size16 +
-				((offsetof(typeof(*sqe), data) + 15) >> 4);
+			sqe->wqe_size = wqe_sz;
 			sqe->cfa_action = cpu_to_le16(wqe->rawqp1.cfa_action);
 			sqe->lflags = cpu_to_le16(wqe->rawqp1.lflags);
 			sqe->length = cpu_to_le32(data_len);
-			sqe->cfa_meta = cpu_to_le32((wqe->rawqp1.cfa_meta &
+			ext_sqe->cfa_meta = cpu_to_le32((wqe->rawqp1.cfa_meta &
 				SQ_SEND_RAWETH_QP1_CFA_META_VLAN_VID_MASK) <<
 				SQ_SEND_RAWETH_QP1_CFA_META_VLAN_VID_SFT);
 
@@ -1698,27 +1783,24 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 	case BNXT_QPLIB_SWQE_TYPE_SEND_WITH_IMM:
 	case BNXT_QPLIB_SWQE_TYPE_SEND_WITH_INV:
 	{
-		struct sq_send *sqe = (struct sq_send *)hw_sq_send_hdr;
+		struct sq_ud_ext_hdr *ext_sqe = ext_hdr;
+		struct sq_send_hdr *sqe = base_hdr;
 
 		sqe->wqe_type = wqe->type;
 		sqe->flags = wqe->flags;
-		sqe->wqe_size = wqe_size16 +
-				((offsetof(typeof(*sqe), data) + 15) >> 4);
-		sqe->inv_key_or_imm_data = cpu_to_le32(
-						wqe->send.inv_key);
+		sqe->wqe_size = wqe_sz;
+		sqe->inv_key_or_imm_data = cpu_to_le32(wqe->send.inv_key);
 		if (qp->type == CMDQ_CREATE_QP_TYPE_UD ||
 		    qp->type == CMDQ_CREATE_QP_TYPE_GSI) {
 			sqe->q_key = cpu_to_le32(wqe->send.q_key);
-			sqe->dst_qp = cpu_to_le32(
-					wqe->send.dst_qp & SQ_SEND_DST_QP_MASK);
 			sqe->length = cpu_to_le32(data_len);
-			sqe->avid = cpu_to_le32(wqe->send.avid &
-						SQ_SEND_AVID_MASK);
 			sq->psn = (sq->psn + 1) & BTH_PSN_MASK;
+			ext_sqe->dst_qp = cpu_to_le32(wqe->send.dst_qp &
+						      SQ_SEND_DST_QP_MASK);
+			ext_sqe->avid = cpu_to_le32(wqe->send.avid &
+						    SQ_SEND_AVID_MASK);
 		} else {
 			sqe->length = cpu_to_le32(data_len);
-			sqe->dst_qp = 0;
-			sqe->avid = 0;
 			if (qp->mtu)
 				pkt_num = (data_len + qp->mtu - 1) / qp->mtu;
 			if (!pkt_num)
@@ -1731,16 +1813,16 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 	case BNXT_QPLIB_SWQE_TYPE_RDMA_WRITE_WITH_IMM:
 	case BNXT_QPLIB_SWQE_TYPE_RDMA_READ:
 	{
-		struct sq_rdma *sqe = (struct sq_rdma *)hw_sq_send_hdr;
+		struct sq_rdma_ext_hdr *ext_sqe = ext_hdr;
+		struct sq_rdma_hdr *sqe = base_hdr;
 
 		sqe->wqe_type = wqe->type;
 		sqe->flags = wqe->flags;
-		sqe->wqe_size = wqe_size16 +
-				((offsetof(typeof(*sqe), data) + 15) >> 4);
+		sqe->wqe_size = wqe_sz;
 		sqe->imm_data = cpu_to_le32(wqe->rdma.inv_key);
 		sqe->length = cpu_to_le32((u32)data_len);
-		sqe->remote_va = cpu_to_le64(wqe->rdma.remote_va);
-		sqe->remote_key = cpu_to_le32(wqe->rdma.r_key);
+		ext_sqe->remote_va = cpu_to_le64(wqe->rdma.remote_va);
+		ext_sqe->remote_key = cpu_to_le32(wqe->rdma.r_key);
 		if (qp->mtu)
 			pkt_num = (data_len + qp->mtu - 1) / qp->mtu;
 		if (!pkt_num)
@@ -1751,14 +1833,15 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 	case BNXT_QPLIB_SWQE_TYPE_ATOMIC_CMP_AND_SWP:
 	case BNXT_QPLIB_SWQE_TYPE_ATOMIC_FETCH_AND_ADD:
 	{
-		struct sq_atomic *sqe = (struct sq_atomic *)hw_sq_send_hdr;
+		struct sq_atomic_ext_hdr *ext_sqe = ext_hdr;
+		struct sq_atomic_hdr *sqe = base_hdr;
 
 		sqe->wqe_type = wqe->type;
 		sqe->flags = wqe->flags;
 		sqe->remote_key = cpu_to_le32(wqe->atomic.r_key);
 		sqe->remote_va = cpu_to_le64(wqe->atomic.remote_va);
-		sqe->swap_data = cpu_to_le64(wqe->atomic.swap_data);
-		sqe->cmp_data = cpu_to_le64(wqe->atomic.cmp_data);
+		ext_sqe->swap_data = cpu_to_le64(wqe->atomic.swap_data);
+		ext_sqe->cmp_data = cpu_to_le64(wqe->atomic.cmp_data);
 		if (qp->mtu)
 			pkt_num = (data_len + qp->mtu - 1) / qp->mtu;
 		if (!pkt_num)
@@ -1768,8 +1851,7 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 	}
 	case BNXT_QPLIB_SWQE_TYPE_LOCAL_INV:
 	{
-		struct sq_localinvalidate *sqe =
-				(struct sq_localinvalidate *)hw_sq_send_hdr;
+		struct sq_localinvalidate *sqe = base_hdr;
 
 		sqe->wqe_type = wqe->type;
 		sqe->flags = wqe->flags;
@@ -1779,7 +1861,8 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 	}
 	case BNXT_QPLIB_SWQE_TYPE_FAST_REG_MR:
 	{
-		struct sq_fr_pmr *sqe = (struct sq_fr_pmr *)hw_sq_send_hdr;
+		struct sq_fr_pmr_ext_hdr *ext_sqe = ext_hdr;
+		struct sq_fr_pmr_hdr *sqe = base_hdr;
 
 		sqe->wqe_type = wqe->type;
 		sqe->flags = wqe->flags;
@@ -1803,14 +1886,15 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 			wqe->frmr.pbl_ptr[i] = cpu_to_le64(
 						wqe->frmr.page_list[i] |
 						PTU_PTE_VALID);
-		sqe->pblptr = cpu_to_le64(wqe->frmr.pbl_dma_ptr);
-		sqe->va = cpu_to_le64(wqe->frmr.va);
+		ext_sqe->pblptr = cpu_to_le64(wqe->frmr.pbl_dma_ptr);
+		ext_sqe->va = cpu_to_le64(wqe->frmr.va);
 
 		break;
 	}
 	case BNXT_QPLIB_SWQE_TYPE_BIND_MW:
 	{
-		struct sq_bind *sqe = (struct sq_bind *)hw_sq_send_hdr;
+		struct sq_bind_ext_hdr *ext_sqe = ext_hdr;
+		struct sq_bind_hdr *sqe = base_hdr;
 
 		sqe->wqe_type = wqe->type;
 		sqe->flags = wqe->flags;
@@ -1819,9 +1903,8 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 			(wqe->bind.zero_based ? SQ_BIND_ZERO_BASED : 0);
 		sqe->parent_l_key = cpu_to_le32(wqe->bind.parent_l_key);
 		sqe->l_key = cpu_to_le32(wqe->bind.r_key);
-		sqe->va = cpu_to_le64(wqe->bind.va);
-		temp32 = cpu_to_le32(wqe->bind.length);
-		memcpy(&sqe->length, &temp32, sizeof(wqe->bind.length));
+		ext_sqe->va = cpu_to_le64(wqe->bind.va);
+		ext_sqe->length_lo = cpu_to_le32(wqe->bind.length);
 		break;
 	}
 	default:
@@ -1832,8 +1915,8 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 	swq->next_psn = sq->psn & BTH_PSN_MASK;
 	bnxt_qplib_fill_psn_search(qp, wqe, swq);
 queue_err:
-	bnxt_qplib_swq_mod_start(sq, sw_prod);
-	bnxt_qplib_hwq_incr_prod(&sq->hwq, 1);
+	bnxt_qplib_swq_mod_start(sq, wqe_idx);
+	bnxt_qplib_hwq_incr_prod(hwq, swq->slots);
 	qp->wqe_cnt++;
 done:
 	if (sch_handler) {
@@ -1864,13 +1947,14 @@ int bnxt_qplib_post_recv(struct bnxt_qplib_qp *qp,
 {
 	struct bnxt_qplib_nq_work *nq_work = NULL;
 	struct bnxt_qplib_q *rq = &qp->rq;
-	struct bnxt_qplib_swq *swq;
+	struct rq_wqe_hdr *base_hdr;
+	struct rq_ext_hdr *ext_hdr;
 	struct bnxt_qplib_hwq *hwq;
+	struct bnxt_qplib_swq *swq;
 	bool sch_handler = false;
-	struct sq_sge *hw_sge;
-	struct rq_wqe *rqe;
-	int i, rc = 0;
-	u32 sw_prod;
+	u16 wqe_sz, idx;
+	u32 wqe_idx;
+	int rc = 0;
 
 	hwq = &rq->hwq;
 	if (qp->state == CMDQ_MODIFY_QP_NEW_STATE_RESET) {
@@ -1881,16 +1965,16 @@ int bnxt_qplib_post_recv(struct bnxt_qplib_qp *qp,
 		goto done;
 	}
 
-	if (bnxt_qplib_queue_full(rq)) {
+	if (bnxt_qplib_queue_full(rq, rq->dbinfo.max_slot)) {
 		dev_err(&hwq->pdev->dev,
 			"FP: QP (0x%x) RQ is full!\n", qp->id);
 		rc = -EINVAL;
 		goto done;
 	}
 
-	sw_prod = rq->hwq.prod;
-	swq = bnxt_qplib_get_swqe(rq, NULL);
+	swq = bnxt_qplib_get_swqe(rq, &wqe_idx);
 	swq->wr_id = wqe->wr_id;
+	swq->slots = rq->dbinfo.max_slot;
 
 	if (qp->state == CMDQ_MODIFY_QP_NEW_STATE_ERR) {
 		sch_handler = true;
@@ -1899,32 +1983,28 @@ int bnxt_qplib_post_recv(struct bnxt_qplib_qp *qp,
 		goto queue_err;
 	}
 
-	rqe = bnxt_qplib_get_qe(hwq, sw_prod, NULL);
-	memset(rqe, 0, rq->wqe_size);
-
-	/* Calculate wqe_size16 and data_len */
-	for (i = 0, hw_sge = (struct sq_sge *)rqe->data;
-	     i < wqe->num_sge; i++, hw_sge++) {
-		hw_sge->va_or_pa = cpu_to_le64(wqe->sg_list[i].addr);
-		hw_sge->l_key = cpu_to_le32(wqe->sg_list[i].lkey);
-		hw_sge->size = cpu_to_le32(wqe->sg_list[i].size);
-	}
-	rqe->wqe_type = wqe->type;
-	rqe->flags = wqe->flags;
-	rqe->wqe_size = wqe->num_sge +
-			((offsetof(typeof(*rqe), data) + 15) >> 4);
-	/* HW requires wqe size has room for atleast one SGE even if none
-	 * was supplied by ULP
-	 */
-	if (!wqe->num_sge)
-		rqe->wqe_size++;
-
-	/* Supply the rqe->wr_id index to the wr_id_tbl for now */
-	rqe->wr_id[0] = cpu_to_le32(sw_prod);
-
+	idx = 0;
+	base_hdr = bnxt_qplib_get_prod_qe(hwq, idx++);
+	ext_hdr = bnxt_qplib_get_prod_qe(hwq, idx++);
+	memset(base_hdr, 0, sizeof(struct sq_sge));
+	memset(ext_hdr, 0, sizeof(struct sq_sge));
+	wqe_sz = (sizeof(struct rq_wqe_hdr) +
+	wqe->num_sge * sizeof(struct sq_sge)) >> 4;
+	bnxt_qplib_put_sges(hwq, wqe->sg_list, wqe->num_sge, &idx);
+	if (!wqe->num_sge) {
+		struct sq_sge *sge;
+
+		sge = bnxt_qplib_get_prod_qe(hwq, idx++);
+		sge->size = 0;
+		wqe_sz++;
+	}
+	base_hdr->wqe_type = wqe->type;
+	base_hdr->flags = wqe->flags;
+	base_hdr->wqe_size = wqe_sz;
+	base_hdr->wr_id[0] = cpu_to_le32(wqe_idx);
 queue_err:
-	bnxt_qplib_swq_mod_start(rq, sw_prod);
-	bnxt_qplib_hwq_incr_prod(&rq->hwq, 1);
+	bnxt_qplib_swq_mod_start(rq, wqe_idx);
+	bnxt_qplib_hwq_incr_prod(hwq, swq->slots);
 done:
 	if (sch_handler) {
 		nq_work = kzalloc(sizeof(*nq_work), GFP_ATOMIC);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index bf96a74..f507844 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -119,6 +119,7 @@ struct bnxt_qplib_swq {
 	u8				flags;
 	u32				start_psn;
 	u32				next_psn;
+	u32				slot_idx;
 	u8				slots;
 	struct sq_psn_search		*psn_search;
 	struct sq_psn_search_ext	*psn_ext;
@@ -349,11 +350,18 @@ struct bnxt_qplib_qp {
 	(!!((hdr)->cqe_type_toggle & CQ_BASE_TOGGLE) ==		\
 	   !((raw_cons) & (cp_bit)))
 
-static inline bool bnxt_qplib_queue_full(struct bnxt_qplib_q *qplib_q)
+static inline bool bnxt_qplib_queue_full(struct bnxt_qplib_q *que,
+					 u8 slots)
 {
-	return HWQ_CMP((qplib_q->hwq.prod + qplib_q->q_full_delta),
-		       &qplib_q->hwq) == HWQ_CMP(qplib_q->hwq.cons,
-						 &qplib_q->hwq);
+	struct bnxt_qplib_hwq *hwq;
+	int avail;
+
+	hwq = &que->hwq;
+	/* False full is possible, retrying post-send makes sense */
+	avail = hwq->cons - hwq->prod;
+	if (hwq->cons <= hwq->prod)
+		avail += hwq->depth;
+	return avail <= slots;
 }
 
 struct bnxt_qplib_cqe {
@@ -554,4 +562,48 @@ static inline void bnxt_qplib_swq_mod_start(struct bnxt_qplib_q *que, u32 idx)
 	que->swq_start = que->swq[idx].next_idx;
 }
 
+static inline u32 bnxt_qplib_get_depth(struct bnxt_qplib_q *que)
+{
+	return (que->wqe_size * que->max_wqe) / sizeof(struct sq_sge);
+}
+
+static inline u32 bnxt_qplib_set_sq_size(struct bnxt_qplib_q *que, u8 wqe_mode)
+{
+	return (wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC) ?
+		que->max_wqe : bnxt_qplib_get_depth(que);
+}
+
+static inline u32 bnxt_qplib_set_sq_max_slot(u8 wqe_mode)
+{
+	return (wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC) ?
+		sizeof(struct sq_send) / sizeof(struct sq_sge) : 1;
+}
+
+static inline u32 bnxt_qplib_set_rq_max_slot(u32 wqe_size)
+{
+	return (wqe_size / sizeof(struct sq_sge));
+}
+
+static inline u16 __xlate_qfd(u16 delta, u16 wqe_bytes)
+{
+	/* For Cu/Wh delta = 128, stride = 16, wqe_bytes = 128
+	 * For Gen-p5 B/C mode delta = 0, stride = 16, wqe_bytes = 128.
+	 * For Gen-p5 delta = 0, stride = 16, 32 <= wqe_bytes <= 512.
+	 * when 8916 is disabled.
+	 */
+	return (delta * wqe_bytes) / sizeof(struct sq_sge);
+}
+
+static inline u16 bnxt_qplib_calc_ilsize(struct bnxt_qplib_swqe *wqe, u16 max)
+{
+	u16 size = 0;
+	int indx;
+
+	for (indx = 0; indx < wqe->num_sge; indx++)
+		size += wqe->sg_list[indx].size;
+	if (size > max)
+		size = max;
+
+	return size;
+}
 #endif /* __BNXT_QPLIB_FP_H__ */
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index b29c2ad..9da470d 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -173,6 +173,7 @@ struct bnxt_qplib_db_info {
 	void __iomem		*priv_db;
 	struct bnxt_qplib_hwq	*hwq;
 	u32			xid;
+	u32			max_slot;
 };
 
 /* Tables */
@@ -332,6 +333,14 @@ static inline void *bnxt_qplib_get_qe(struct bnxt_qplib_hwq *hwq,
 	return (void *)(hwq->pbl_ptr[pg_num] + hwq->element_size * pg_idx);
 }
 
+static inline void *bnxt_qplib_get_prod_qe(struct bnxt_qplib_hwq *hwq, u32 idx)
+{
+	idx += hwq->prod;
+	if (idx >= hwq->depth)
+		idx -= hwq->depth;
+	return bnxt_qplib_get_qe(hwq, idx, NULL);
+}
+
 #define to_bnxt_qplib(ptr, type, member)	\
 	container_of(ptr, type, member)
 
@@ -409,8 +418,7 @@ static inline void bnxt_qplib_ring_prod_db(struct bnxt_qplib_db_info *info,
 
 	key = (info->xid & DBC_DBC_XID_MASK) | DBC_DBC_PATH_ROCE | type;
 	key <<= 32;
-	key |= (info->hwq->prod & (info->hwq->max_elements - 1)) &
-		DBC_DBC_INDEX_MASK;
+	key |= ((info->hwq->prod / info->max_slot)) & DBC_DBC_INDEX_MASK;
 	writeq(key, info->db);
 }
 
-- 
1.8.3.1

