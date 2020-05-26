Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A4E1E1AAF
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2020 07:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgEZFUe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 May 2020 01:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgEZFUd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 May 2020 01:20:33 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDDFC061A0E
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 22:20:32 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id n5so1997010wmd.0
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 22:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=duz8OcrsjZL1D8DAlauoJv3YDRM3jsp+GCb8UAm0kQQ=;
        b=Td2+teoEH7zGiYsSXpt0INDLpCv3lvRnOzRxyhFw0W3dk7woTMpNtd/uVzJvs8NV6w
         HKdGkHuP8FRyJUrTa7vbqVZCdheRqzZRsi6RVg4mC1t6XG5niUhTnLBvYn5evuPJ/IFS
         EFb141zEn+s1xSVCW4Gx9e9A/NLK7cdGffDww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=duz8OcrsjZL1D8DAlauoJv3YDRM3jsp+GCb8UAm0kQQ=;
        b=qMGMmCBFgC6NauxbOPF3g9Mhr739zhGP3So5ugYEXpvmk4N8kQ49jsw06U7i/ZOj9d
         kYCLbuVStpTaG9px6/n26ojhAZ5ChI6m/jdRIxLgiy3iAg49aoCAfrJDgHO4O3UK4mt9
         jCRj2M30tqpqbr0tyuNAftw0+p8kOM/VFYGsnPp6lKKUzDfHQpd5iSoX7aA7Hjs3j7G7
         6GVV9TzFtPiAAwl7bEH1YgZALdKiSwnthhSAHJc11OtTKrwtktYp6p/XUTbVEMWMF4nN
         hNNY2tFs2pRohJBxPlOUTuKJid6HkRmtDiRAGP9judUvwzfYk1Hi/c7zgHg1iq3x9Vf1
         ktZA==
X-Gm-Message-State: AOAM5304dPb6Wo5kxVaZZGOVV3oIMiTRVSsmO0xHYEIl3BtZyQ+EY47l
        QEnoJEK0Duz6Hs6L9fADP4bWS4U2WfkRj4A0b3HIOBkCigEsYkXwZkzZLfmudhe1CKT/olhZg1I
        YJl7/SaGYymVOtHbkhdK+o0GirkX5TGbG37Y5fPY5FZV/p4hW0+NsnVqFkjxPD5CCPQECqouZm2
        S9Hqg=
X-Google-Smtp-Source: ABdhPJzjjYEmfbykNGGVNpIWHt+yCIkpuELm1Z+8oVNmrytWf292Dtp+VRvKq3D+P9lBwa1WF64McA==
X-Received: by 2002:a1c:4105:: with SMTP id o5mr5636846wma.168.1590470429579;
        Mon, 25 May 2020 22:20:29 -0700 (PDT)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 40sm19807069wrc.15.2020.05.25.22.20.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 May 2020 22:20:28 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     devesh.sharma@broadcom.com, leon@kernel.org
Subject: [PATCH for-next 1/2] RDMA/bnxt_re: change sq and rq to be indexed with 16B stride
Date:   Tue, 26 May 2020 01:20:01 -0400
Message-Id: <1590470402-32590-2-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1590470402-32590-1-git-send-email-devesh.sharma@broadcom.com>
References: <1590470402-32590-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Changing the fast path of Broadcom's roce driver to index
the fast path queue with an stride of 16B instead of fixed
128B stride.
The main motivation for this change is to allow gen p5
and future generation devices to enable variable sized
wqes in SQ and RQ of QP. As a first patch series to fully
enable that support the fast path queues are being
changed.

In this patch the default mode in which fast path queue
works is still fixed size 128B wqe but when pulling the
memory from the SQ and RQ the stride of 16B is used.

There is a top level control to change the driver from
static-wqe mode to variable wqe mode via a variabled called
"wqe-mode". For now in the first version of this change it
has been tide to static wqe mode.

Listing down the major changes done here:
 -- Added a logic to calculate wqe-size based on the
    requested number of wqes and sges.
 -- select psn memory size based on wqe-mode and implement
    routine to pull psn memory dynamically.
 -- select queue full delta based on wqe-mode
 -- set wqe-mode to static by default
 -- use pre configured shadow wq to maintain wr_id.
 -- select sq size and rq size based on wqe-mode.
 -- set qp creation flag according to wqe-mode.
 -- maintain max-slots in per SQ and RQ db-info record.
    divide prod by max-slots during db-ring.
 -- add new routine to put inline-data or sges into wqe.
 -- added new routine to calculate posted wqe-size and
    change modified the queue full check condition.
 -- changed wqe filling algorithm to pull slots dynammically.
 -- change polling routines to use new shadow wr_id queue
    and modify cons/prods according to new algo.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 149 ++++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.h  |   8 +-
 drivers/infiniband/hw/bnxt_re/main.c      |  23 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 746 +++++++++++++++++-------------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  | 128 ++++-
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  63 ++-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c  |  13 +-
 drivers/infiniband/hw/bnxt_re/roce_hsi.h  |   1 +
 8 files changed, 739 insertions(+), 392 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 5a7c090..e1dbdf0 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -845,6 +845,66 @@ static u8 __from_ib_qp_type(enum ib_qp_type type)
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
+	    qplqp->wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC)
+		sq->wqe_size = bnxt_re_get_swqe_size(dev_attr->max_qp_sges);
+
+	if (init_attr->cap.max_inline_data) {
+		qplqp->max_inline_data = sq->wqe_size -
+					 sizeof(struct sq_send_hdr);
+		init_attr->cap.max_inline_data = qplqp->max_inline_data;
+		if (qplqp->wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC)
+			sq->max_sge = qplqp->max_inline_data /
+				      sizeof(struct sq_sge);
+	}
+
+	return 0;
+}
+
 static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 				struct bnxt_re_qp *qp, struct ib_udata *udata)
 {
@@ -852,6 +912,7 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
 	struct ib_umem *umem;
 	int bytes = 0, psn_sz;
+	int psn_nume;
 	struct bnxt_re_ucontext *cntx = rdma_udata_to_drv_context(
 		udata, struct bnxt_re_ucontext, ib_uctx);
 
@@ -864,8 +925,13 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 		psn_sz = bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx) ?
 					sizeof(struct sq_psn_search_ext) :
 					sizeof(struct sq_psn_search);
-		bytes += (qplib_qp->sq.max_wqe * psn_sz);
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
@@ -978,7 +1044,7 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	qp->qplib_qp.sig_type = true;
 
 	/* Shadow QP SQ depth should be same as QP1 RQ depth */
-	qp->qplib_qp.sq.wqe_size = bnxt_re_get_swqe_size();
+	qp->qplib_qp.sq.wqe_size = bnxt_re_get_wqe_size(0, 6);
 	qp->qplib_qp.sq.max_wqe = qp1_qp->rq.max_wqe;
 	qp->qplib_qp.sq.max_sge = 2;
 	/* Q full delta can be 1 since it is internal QP */
@@ -989,7 +1055,7 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	qp->qplib_qp.scq = qp1_qp->scq;
 	qp->qplib_qp.rcq = qp1_qp->rcq;
 
-	qp->qplib_qp.rq.wqe_size = bnxt_re_get_rwqe_size();
+	qp->qplib_qp.rq.wqe_size = bnxt_re_get_rwqe_size(6);
 	qp->qplib_qp.rq.max_wqe = qp1_qp->rq.max_wqe;
 	qp->qplib_qp.rq.max_sge = qp1_qp->rq.max_sge;
 	/* Q full delta can be 1 since it is internal QP */
@@ -1044,19 +1110,21 @@ static int bnxt_re_init_rq_attr(struct bnxt_re_qp *qp,
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
@@ -1071,41 +1139,48 @@ static void bnxt_re_adjust_gsi_rq_attr(struct bnxt_re_qp *qp)
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
@@ -1114,6 +1189,8 @@ static void bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
 	qplqp->sq.q_full_delta -= 1;
 	qplqp->sq.sg_info.pgsize = PAGE_SIZE;
 	qplqp->sq.sg_info.pgshft = PAGE_SHIFT;
+
+	return 0;
 }
 
 static void bnxt_re_adjust_gsi_sq_attr(struct bnxt_re_qp *qp,
@@ -1128,13 +1205,16 @@ static void bnxt_re_adjust_gsi_sq_attr(struct bnxt_re_qp *qp,
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
+					 init_attr->cap.max_send_wr;
+		qplqp->sq.max_sge++; /* Need one extra sge to put UD header */
+		if (qplqp->sq.max_sge > dev_attr->max_qp_sges)
+			qplqp->sq.max_sge = dev_attr->max_qp_sges;
+	}
 }
 
 static int bnxt_re_init_qp_type(struct bnxt_re_dev *rdev,
@@ -1186,6 +1266,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 		goto out;
 	}
 	qplqp->type = (u8)qptype;
+	qplqp->wqe_mode = rdev->chip_ctx->modes.wqe_mode;
 
 	if (init_attr->qp_type == IB_QPT_RC) {
 		qplqp->max_rd_atomic = dev_attr->max_qp_rd_atom;
@@ -1577,8 +1658,8 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 		entries = dev_attr->max_srq_wqes + 1;
 	srq->qplib_srq.max_wqe = entries;
 
-	srq->qplib_srq.wqe_size = bnxt_re_get_rwqe_size();
 	srq->qplib_srq.max_sge = srq_init_attr->attr.max_sge;
+	srq->qplib_srq.wqe_size = bnxt_re_get_rwqe_size(srq->qplib_srq.max_sge);
 	srq->qplib_srq.threshold = srq_init_attr->attr.srq_limit;
 	srq->srq_limit = srq_init_attr->attr.srq_limit;
 	srq->qplib_srq.eventq_hw_ring_id = rdev->nq[0].ring_id;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 204c084..295a411f 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -142,14 +142,14 @@ struct bnxt_re_ucontext {
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
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index b12fbc8..dad0df8 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -82,6 +82,15 @@
 static void bnxt_re_dealloc_driver(struct ib_device *ib_dev);
 static void bnxt_re_stop_irq(void *handle);
 
+static void bnxt_re_set_drv_mode(struct bnxt_re_dev *rdev, u8 mode)
+{
+	struct bnxt_qplib_chip_ctx *cctx;
+
+	cctx = rdev->chip_ctx;
+	cctx->modes.wqe_mode = bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx) ?
+			       mode : BNXT_QPLIB_WQE_MODE_STATIC;
+}
+
 static void bnxt_re_destroy_chip_ctx(struct bnxt_re_dev *rdev)
 {
 	struct bnxt_qplib_chip_ctx *chip_ctx;
@@ -97,7 +106,7 @@ static void bnxt_re_destroy_chip_ctx(struct bnxt_re_dev *rdev)
 	kfree(chip_ctx);
 }
 
-static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev)
+static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev, u8 wqe_mode)
 {
 	struct bnxt_qplib_chip_ctx *chip_ctx;
 	struct bnxt_en_dev *en_dev;
@@ -117,6 +126,7 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev)
 	rdev->qplib_res.cctx = rdev->chip_ctx;
 	rdev->rcfw.res = &rdev->qplib_res;
 
+	bnxt_re_set_drv_mode(rdev, wqe_mode);
 	return 0;
 }
 
@@ -1386,7 +1396,7 @@ static void bnxt_re_worker(struct work_struct *work)
 	schedule_delayed_work(&rdev->worker, msecs_to_jiffies(30000));
 }
 
-static int bnxt_re_dev_init(struct bnxt_re_dev *rdev)
+static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 wqe_mode)
 {
 	struct bnxt_qplib_creq_ctx *creq;
 	struct bnxt_re_ring_attr rattr;
@@ -1406,7 +1416,7 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev)
 	}
 	set_bit(BNXT_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
 
-	rc = bnxt_re_setup_chip_ctx(rdev);
+	rc = bnxt_re_setup_chip_ctx(rdev, wqe_mode);
 	if (rc) {
 		ibdev_err(&rdev->ibdev, "Failed to get chip context\n");
 		return -EINVAL;
@@ -1585,7 +1595,7 @@ static void bnxt_re_remove_device(struct bnxt_re_dev *rdev)
 }
 
 static int bnxt_re_add_device(struct bnxt_re_dev **rdev,
-			      struct net_device *netdev)
+			      struct net_device *netdev, u8 wqe_mode)
 {
 	int rc;
 
@@ -1599,7 +1609,7 @@ static int bnxt_re_add_device(struct bnxt_re_dev **rdev,
 	}
 
 	pci_dev_get((*rdev)->en_dev->pdev);
-	rc = bnxt_re_dev_init(*rdev);
+	rc = bnxt_re_dev_init(*rdev, wqe_mode);
 	if (rc) {
 		pci_dev_put((*rdev)->en_dev->pdev);
 		bnxt_re_dev_unreg(*rdev);
@@ -1711,7 +1721,8 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 	case NETDEV_REGISTER:
 		if (rdev)
 			break;
-		rc = bnxt_re_add_device(&rdev, real_dev);
+		rc = bnxt_re_add_device(&rdev, real_dev,
+					BNXT_QPLIB_WQE_MODE_STATIC);
 		if (!rc)
 			sch_work = true;
 		release = false;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index c5e2957..3e55800 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -178,11 +178,11 @@ static void bnxt_qplib_free_qp_hdr_buf(struct bnxt_qplib_res *res,
 
 	if (qp->rq_hdr_buf)
 		dma_free_coherent(&res->pdev->dev,
-				  rq->hwq.max_elements * qp->rq_hdr_buf_size,
+				  rq->max_wqe * qp->rq_hdr_buf_size,
 				  qp->rq_hdr_buf, qp->rq_hdr_buf_map);
 	if (qp->sq_hdr_buf)
 		dma_free_coherent(&res->pdev->dev,
-				  sq->hwq.max_elements * qp->sq_hdr_buf_size,
+				  sq->max_wqe * qp->sq_hdr_buf_size,
 				  qp->sq_hdr_buf, qp->sq_hdr_buf_map);
 	qp->rq_hdr_buf = NULL;
 	qp->sq_hdr_buf = NULL;
@@ -201,8 +201,7 @@ static int bnxt_qplib_alloc_qp_hdr_buf(struct bnxt_qplib_res *res,
 
 	if (qp->sq_hdr_buf_size && sq->hwq.max_elements) {
 		qp->sq_hdr_buf = dma_alloc_coherent(&res->pdev->dev,
-					sq->hwq.max_elements *
-					qp->sq_hdr_buf_size,
+					sq->max_wqe * qp->sq_hdr_buf_size,
 					&qp->sq_hdr_buf_map, GFP_KERNEL);
 		if (!qp->sq_hdr_buf) {
 			rc = -ENOMEM;
@@ -214,7 +213,7 @@ static int bnxt_qplib_alloc_qp_hdr_buf(struct bnxt_qplib_res *res,
 
 	if (qp->rq_hdr_buf_size && rq->hwq.max_elements) {
 		qp->rq_hdr_buf = dma_alloc_coherent(&res->pdev->dev,
-						    rq->hwq.max_elements *
+						    rq->max_wqe *
 						    qp->rq_hdr_buf_size,
 						    &qp->rq_hdr_buf_map,
 						    GFP_KERNEL);
@@ -661,6 +660,7 @@ int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
 	srq->dbinfo.hwq = &srq->hwq;
 	srq->dbinfo.xid = srq->id;
 	srq->dbinfo.db = srq->dpi->dbr;
+	srq->dbinfo.max_slot = 1;
 	srq->dbinfo.priv_db = res->dpi_tbl.dbr_bar_reg_iomem;
 	if (srq->threshold)
 		bnxt_qplib_armen_db(&srq->dbinfo, DBC_DBC_TYPE_SRQ_ARMENA);
@@ -784,6 +784,27 @@ int bnxt_qplib_post_srq_recv(struct bnxt_qplib_srq *srq,
 }
 
 /* QP */
+static int bnxt_qplib_alloc_init_swq(struct bnxt_qplib_q *que)
+{
+	int rc = 0;
+	int indx;
+
+	que->swq = kcalloc(que->max_wqe, sizeof(*que->swq), GFP_KERNEL);
+	if (!que->swq) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	que->swq_start = 0;
+	que->swq_last = que->max_wqe - 1;
+	for (indx = 0; indx < que->max_wqe; indx++)
+		que->swq[indx].next_idx = indx + 1;
+	que->swq[que->swq_last].next_idx = 0; /* Make it circular */
+	que->swq_last = 0;
+out:
+	return rc;
+}
+
 int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 {
 	struct bnxt_qplib_hwq_attr hwq_attr = {};
@@ -808,71 +829,64 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
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
 		goto exit;
-
-	sq->swq = kcalloc(sq->hwq.max_elements, sizeof(*sq->swq), GFP_KERNEL);
-	if (!sq->swq) {
-		rc = -ENOMEM;
+	rc = bnxt_qplib_alloc_init_swq(sq);
+	if (rc)
 		goto fail_sq;
-	}
+
+	req.sq_size = cpu_to_le32(bnxt_qplib_set_sq_size(sq, qp->wqe_mode));
 	pbl = &sq->hwq.pbl[PBL_LVL_0];
 	req.sq_pbl = cpu_to_le64(pbl->pg_map_arr[0]);
 	pg_sz_lvl = (bnxt_qplib_base_pg_size(&sq->hwq) <<
 		     CMDQ_CREATE_QP1_SQ_PG_SIZE_SFT);
 	pg_sz_lvl |= (sq->hwq.level & CMDQ_CREATE_QP1_SQ_LVL_MASK);
 	req.sq_pg_size_sq_lvl = pg_sz_lvl;
+	req.sq_fwo_sq_sge =
+		cpu_to_le16((sq->max_sge & CMDQ_CREATE_QP1_SQ_SGE_MASK) <<
+			    CMDQ_CREATE_QP1_SQ_SGE_SFT);
+	req.scq_cid = cpu_to_le32(qp->scq->id);
 
-	if (qp->scq)
-		req.scq_cid = cpu_to_le32(qp->scq->id);
 	/* RQ */
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
-			goto fail_sq;
-
-		rq->swq = kcalloc(rq->hwq.max_elements, sizeof(*rq->swq),
-				  GFP_KERNEL);
-		if (!rq->swq) {
-			rc = -ENOMEM;
+			goto sq_swq;
+		rc = bnxt_qplib_alloc_init_swq(rq);
+		if (rc)
 			goto fail_rq;
-		}
+		req.rq_size = cpu_to_le32(rq->max_wqe);
 		pbl = &rq->hwq.pbl[PBL_LVL_0];
 		req.rq_pbl = cpu_to_le64(pbl->pg_map_arr[0]);
 		pg_sz_lvl = (bnxt_qplib_base_pg_size(&rq->hwq) <<
 			     CMDQ_CREATE_QP1_RQ_PG_SIZE_SFT);
 		pg_sz_lvl |= (rq->hwq.level & CMDQ_CREATE_QP1_RQ_LVL_MASK);
 		req.rq_pg_size_rq_lvl = pg_sz_lvl;
-		if (qp->rcq)
-			req.rcq_cid = cpu_to_le32(qp->rcq->id);
+		req.rq_fwo_rq_sge =
+			cpu_to_le16((rq->max_sge &
+				     CMDQ_CREATE_QP1_RQ_SGE_MASK) <<
+				    CMDQ_CREATE_QP1_RQ_SGE_SFT);
 	}
+	req.rcq_cid = cpu_to_le32(qp->rcq->id);
+
 	/* Header buffer - allow hdr_buf pass in */
 	rc = bnxt_qplib_alloc_qp_hdr_buf(res, qp);
 	if (rc) {
 		rc = -ENOMEM;
-		goto fail;
+		goto rq_rwq;
 	}
+
 	qp_flags |= CMDQ_CREATE_QP1_QP_FLAGS_RESERVED_LKEY_ENABLE;
 	req.qp_flags = cpu_to_le32(qp_flags);
-	req.sq_size = cpu_to_le32(sq->hwq.max_elements);
-	req.rq_size = cpu_to_le32(rq->hwq.max_elements);
-
-	req.sq_fwo_sq_sge =
-		cpu_to_le16((sq->max_sge & CMDQ_CREATE_QP1_SQ_SGE_MASK) <<
-			    CMDQ_CREATE_QP1_SQ_SGE_SFT);
-	req.rq_fwo_rq_sge =
-		cpu_to_le16((rq->max_sge & CMDQ_CREATE_QP1_RQ_SGE_MASK) <<
-			    CMDQ_CREATE_QP1_RQ_SGE_SFT);
-
 	req.pd_id = cpu_to_le32(qp->pd->id);
 
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
@@ -886,10 +900,12 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
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
@@ -898,12 +914,14 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 
 fail:
 	bnxt_qplib_free_qp_hdr_buf(res, qp);
+rq_rwq:
+	kfree(rq->swq);
 fail_rq:
 	bnxt_qplib_free_hwq(res, &rq->hwq);
-	kfree(rq->swq);
+sq_swq:
+	kfree(sq->swq);
 fail_sq:
 	bnxt_qplib_free_hwq(res, &sq->hwq);
-	kfree(sq->swq);
 exit:
 	return rc;
 }
@@ -912,26 +930,18 @@ static void bnxt_qplib_init_psn_ptr(struct bnxt_qplib_qp *qp, int size)
 {
 	struct bnxt_qplib_hwq *hwq;
 	struct bnxt_qplib_q *sq;
-	u64 fpsne, psne, psn_pg;
-	u16 indx_pad = 0, indx;
-	u16 pg_num, pg_indx;
-	u64 *page;
+	u64 fpsne, psn_pg;
+	u16 indx_pad = 0;
 
 	sq = &qp->sq;
 	hwq = &sq->hwq;
-
-	fpsne = (u64)bnxt_qplib_get_qe(hwq, hwq->max_elements, &psn_pg);
+	fpsne = (u64)bnxt_qplib_get_qe(hwq, hwq->depth, &psn_pg);
 	if (!IS_ALIGNED(fpsne, PAGE_SIZE))
 		indx_pad = ALIGN(fpsne, PAGE_SIZE) / size;
 
-	page = (u64 *)psn_pg;
-	for (indx = 0; indx < hwq->max_elements; indx++) {
-		pg_num = (indx + indx_pad) / (PAGE_SIZE / size);
-		pg_indx = (indx + indx_pad) % (PAGE_SIZE / size);
-		psne = page[pg_num] + pg_indx * size;
-		sq->swq[indx].psn_ext = (struct sq_psn_search_ext *)psne;
-		sq->swq[indx].psn_search = (struct sq_psn_search *)psne;
-	}
+	hwq->pad_pgofft = indx_pad;
+	hwq->pad_pg = (u64 *)psn_pg;
+	hwq->pad_stride = size;
 }
 
 int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
@@ -944,12 +954,12 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	struct creq_create_qp_resp resp;
 	int rc, req_size, psn_sz = 0;
 	struct bnxt_qplib_hwq *xrrq;
-	u16 cmd_flags = 0, max_ssge;
 	struct bnxt_qplib_pbl *pbl;
 	struct cmdq_create_qp req;
+	u16 cmd_flags = 0;
 	u32 qp_flags = 0;
 	u8 pg_sz_lvl;
-	u16 max_rsge;
+	u16 nsge;
 
 	RCFW_CMD_PREP(req, CREATE_QP, cmd_flags);
 
@@ -967,97 +977,74 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 
 	hwq_attr.res = res;
 	hwq_attr.sginfo = &sq->sg_info;
-	hwq_attr.stride = sq->wqe_size;
-	hwq_attr.depth = sq->max_wqe;
+	hwq_attr.stride = sizeof(struct sq_sge);
+	hwq_attr.depth = bnxt_qplib_get_depth(sq);
 	hwq_attr.aux_stride = psn_sz;
 	hwq_attr.aux_depth = hwq_attr.depth;
 	hwq_attr.type = HWQ_TYPE_QUEUE;
 	rc = bnxt_qplib_alloc_init_hwq(&sq->hwq, &hwq_attr);
 	if (rc)
 		goto exit;
-
-	sq->swq = kcalloc(sq->hwq.max_elements, sizeof(*sq->swq), GFP_KERNEL);
-	if (!sq->swq) {
-		rc = -ENOMEM;
+	rc = bnxt_qplib_alloc_init_swq(sq);
+	if (rc)
 		goto fail_sq;
-	}
-
 	if (psn_sz)
 		bnxt_qplib_init_psn_ptr(qp, psn_sz);
 
+	req.sq_size = cpu_to_le32(bnxt_qplib_set_sq_size(sq, qp->wqe_mode));
 	pbl = &sq->hwq.pbl[PBL_LVL_0];
 	req.sq_pbl = cpu_to_le64(pbl->pg_map_arr[0]);
 	pg_sz_lvl = (bnxt_qplib_base_pg_size(&sq->hwq) <<
 		     CMDQ_CREATE_QP_SQ_PG_SIZE_SFT);
 	pg_sz_lvl |= (sq->hwq.level & CMDQ_CREATE_QP_SQ_LVL_MASK);
 	req.sq_pg_size_sq_lvl = pg_sz_lvl;
+	req.sq_fwo_sq_sge =
+			cpu_to_le16(((sq->max_sge & CMDQ_CREATE_QP_SQ_SGE_MASK)
+				     << CMDQ_CREATE_QP_SQ_SGE_SFT) | 0);
+	req.scq_cid = cpu_to_le32(qp->scq->id);
 
-	if (qp->scq)
-		req.scq_cid = cpu_to_le32(qp->scq->id);
-
-	/* RQ */
-	if (rq->max_wqe) {
+	if (qp->srq) {
+		/* SRQ */
+		qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_SRQ_USED;
+		req.srq_cid = cpu_to_le32(qp->srq->id);
+	} else {
+		/* RQ */
 		hwq_attr.res = res;
 		hwq_attr.sginfo = &rq->sg_info;
-		hwq_attr.stride = rq->wqe_size;
-		hwq_attr.depth = rq->max_wqe;
+		hwq_attr.stride = sizeof(struct sq_sge);
+		hwq_attr.depth = bnxt_qplib_get_depth(rq);
 		hwq_attr.aux_stride = 0;
 		hwq_attr.aux_depth = 0;
 		hwq_attr.type = HWQ_TYPE_QUEUE;
 		rc = bnxt_qplib_alloc_init_hwq(&rq->hwq, &hwq_attr);
 		if (rc)
-			goto fail_sq;
-
-		rq->swq = kcalloc(rq->hwq.max_elements, sizeof(*rq->swq),
-				  GFP_KERNEL);
-		if (!rq->swq) {
-			rc = -ENOMEM;
+			goto sq_swq;
+		rc = bnxt_qplib_alloc_init_swq(rq);
+		if (rc)
 			goto fail_rq;
-		}
+		req.rq_size = cpu_to_le32(rq->max_wqe);
 		pbl = &rq->hwq.pbl[PBL_LVL_0];
 		req.rq_pbl = cpu_to_le64(pbl->pg_map_arr[0]);
 		pg_sz_lvl = (bnxt_qplib_base_pg_size(&rq->hwq) <<
 			     CMDQ_CREATE_QP_RQ_PG_SIZE_SFT);
 		pg_sz_lvl |= (rq->hwq.level & CMDQ_CREATE_QP_RQ_LVL_MASK);
 		req.rq_pg_size_rq_lvl = pg_sz_lvl;
-	} else {
-		/* SRQ */
-		if (qp->srq) {
-			qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_SRQ_USED;
-			req.srq_cid = cpu_to_le32(qp->srq->id);
-		}
+		nsge = (qp->wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC) ?
+			6 : rq->max_sge;
+		req.rq_fwo_rq_sge =
+			cpu_to_le16(((nsge & CMDQ_CREATE_QP_RQ_SGE_MASK) <<
+				     CMDQ_CREATE_QP_RQ_SGE_SFT) | 0);
 	}
-
-	if (qp->rcq)
-		req.rcq_cid = cpu_to_le32(qp->rcq->id);
+	req.rcq_cid = cpu_to_le32(qp->rcq->id);
 
 	qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_RESERVED_LKEY_ENABLE;
 	qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_FR_PMR_ENABLED;
 	if (qp->sig_type)
 		qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_FORCE_COMPLETION;
+	if (qp->wqe_mode == BNXT_QPLIB_WQE_MODE_VARIABLE)
+		qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_VARIABLE_SIZED_WQE_ENABLED;
 	req.qp_flags = cpu_to_le32(qp_flags);
 
-	req.sq_size = cpu_to_le32(sq->hwq.max_elements);
-	req.rq_size = cpu_to_le32(rq->hwq.max_elements);
-	qp->sq_hdr_buf = NULL;
-	qp->rq_hdr_buf = NULL;
-
-	rc = bnxt_qplib_alloc_qp_hdr_buf(res, qp);
-	if (rc)
-		goto fail_rq;
-
-	/* CTRL-22434: Irrespective of the requested SGE count on the SQ
-	 * always create the QP with max send sges possible if the requested
-	 * inline size is greater than 0.
-	 */
-	max_ssge = qp->max_inline_data ? 6 : sq->max_sge;
-	req.sq_fwo_sq_sge = cpu_to_le16(
-				((max_ssge & CMDQ_CREATE_QP_SQ_SGE_MASK)
-				 << CMDQ_CREATE_QP_SQ_SGE_SFT) | 0);
-	max_rsge = bnxt_qplib_is_chip_gen_p5(res->cctx) ? 6 : rq->max_sge;
-	req.rq_fwo_rq_sge = cpu_to_le16(
-				((max_rsge & CMDQ_CREATE_QP_RQ_SGE_MASK)
-				 << CMDQ_CREATE_QP_RQ_SGE_SFT) | 0);
 	/* ORRQ and IRRQ */
 	if (psn_sz) {
 		xrrq = &qp->orrq;
@@ -1078,7 +1065,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 		hwq_attr.type = HWQ_TYPE_CTX;
 		rc = bnxt_qplib_alloc_init_hwq(xrrq, &hwq_attr);
 		if (rc)
-			goto fail_buf_free;
+			goto rq_swq;
 		pbl = &xrrq->pbl[PBL_LVL_0];
 		req.orrq_addr = cpu_to_le64(pbl->pg_map_arr[0]);
 
@@ -1113,10 +1100,12 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
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
@@ -1124,19 +1113,17 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	return 0;
 
 fail:
-	if (qp->irrq.max_elements)
-		bnxt_qplib_free_hwq(res, &qp->irrq);
+	bnxt_qplib_free_hwq(res, &qp->irrq);
 fail_orrq:
-	if (qp->orrq.max_elements)
-		bnxt_qplib_free_hwq(res, &qp->orrq);
-fail_buf_free:
-	bnxt_qplib_free_qp_hdr_buf(res, qp);
+	bnxt_qplib_free_hwq(res, &qp->orrq);
+rq_swq:
+	kfree(rq->swq);
 fail_rq:
 	bnxt_qplib_free_hwq(res, &rq->hwq);
-	kfree(rq->swq);
+sq_swq:
+	kfree(sq->swq);
 fail_sq:
 	bnxt_qplib_free_hwq(res, &sq->hwq);
-	kfree(sq->swq);
 exit:
 	return rc;
 }
@@ -1512,7 +1499,7 @@ void *bnxt_qplib_get_qp1_sq_buf(struct bnxt_qplib_qp *qp,
 	memset(sge, 0, sizeof(*sge));
 
 	if (qp->sq_hdr_buf) {
-		sw_prod = HWQ_CMP(sq->hwq.prod, &sq->hwq);
+		sw_prod = sq->swq_start;
 		sge->addr = (dma_addr_t)(qp->sq_hdr_buf_map +
 					 sw_prod * qp->sq_hdr_buf_size);
 		sge->lkey = 0xFFFFFFFF;
@@ -1526,7 +1513,7 @@ u32 bnxt_qplib_get_rq_prod_index(struct bnxt_qplib_qp *qp)
 {
 	struct bnxt_qplib_q *rq = &qp->rq;
 
-	return HWQ_CMP(rq->hwq.prod, &rq->hwq);
+	return rq->swq_start;
 }
 
 dma_addr_t bnxt_qplib_get_qp_buf_from_index(struct bnxt_qplib_qp *qp, u32 index)
@@ -1543,7 +1530,7 @@ void *bnxt_qplib_get_qp1_rq_buf(struct bnxt_qplib_qp *qp,
 	memset(sge, 0, sizeof(*sge));
 
 	if (qp->rq_hdr_buf) {
-		sw_prod = HWQ_CMP(rq->hwq.prod, &rq->hwq);
+		sw_prod = rq->swq_start;
 		sge->addr = (dma_addr_t)(qp->rq_hdr_buf_map +
 					 sw_prod * qp->rq_hdr_buf_size);
 		sge->lkey = 0xFFFFFFFF;
@@ -1562,6 +1549,8 @@ static void bnxt_qplib_fill_psn_search(struct bnxt_qplib_qp *qp,
 	u32 flg_npsn;
 	u32 op_spsn;
 
+	if (!swq->psn_search)
+		return;
 	psns = swq->psn_search;
 	psns_ext = swq->psn_ext;
 
@@ -1575,12 +1564,122 @@ static void bnxt_qplib_fill_psn_search(struct bnxt_qplib_qp *qp,
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
+				      (sizeof(struct sq_sge) - offt));
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
+static void bnxt_qplib_pull_psn_buff(struct bnxt_qplib_q *sq,
+				     struct bnxt_qplib_swq *swq)
+{
+	struct bnxt_qplib_hwq *hwq;
+	u32 pg_num, pg_indx;
+	void *buff;
+	u32 tail;
+
+	hwq = &sq->hwq;
+	if (!hwq->pad_pg)
+		return;
+	tail = swq->slot_idx / sq->dbinfo.max_slot;
+	pg_num = (tail + hwq->pad_pgofft) / (PAGE_SIZE / hwq->pad_stride);
+	pg_indx = (tail + hwq->pad_pgofft) % (PAGE_SIZE / hwq->pad_stride);
+	buff = (void *)(hwq->pad_pg[pg_num] + pg_indx * hwq->pad_stride);
+	swq->psn_ext = buff;
+	swq->psn_search = buff;
+}
+
 void bnxt_qplib_post_send_db(struct bnxt_qplib_qp *qp)
 {
 	struct bnxt_qplib_q *sq = &qp->sq;
@@ -1594,88 +1693,81 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 	struct bnxt_qplib_nq_work *nq_work = NULL;
 	int i, rc = 0, data_len = 0, pkt_num = 0;
 	struct bnxt_qplib_q *sq = &qp->sq;
-	struct sq_send *hw_sq_send_hdr;
+	struct bnxt_qplib_hwq *hwq;
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
 
-	if (qp->state != CMDQ_MODIFY_QP_NEW_STATE_RTS) {
-		if (qp->state == CMDQ_MODIFY_QP_NEW_STATE_ERR) {
-			sch_handler = true;
-			dev_dbg(&sq->hwq.pdev->dev,
-				"%s Error QP. Scheduling for poll_cq\n",
-				__func__);
-			goto queue_err;
-		}
+	hwq = &sq->hwq;
+	if (qp->state != CMDQ_MODIFY_QP_NEW_STATE_RTS &&
+	    qp->state != CMDQ_MODIFY_QP_NEW_STATE_ERR) {
+		dev_err(&hwq->pdev->dev, "QPLIB:FP: QP(0x%x) state 0x%x",
+			qp->id, qp->state);
+		rc = -EINVAL;
+		goto done;
 	}
 
-	if (bnxt_qplib_queue_full(sq)) {
-		dev_err(&sq->hwq.pdev->dev,
+	slots = bnxt_qplib_required_slots(qp, wqe, &wqe_sz, &qdf, qp->wqe_mode);
+	if (bnxt_qplib_queue_full(sq, slots + qdf)) {
+		dev_err(&hwq->pdev->dev,
 			"prod = %#x cons = %#x qdepth = %#x delta = %#x\n",
-			sq->hwq.prod, sq->hwq.cons, sq->hwq.max_elements,
-			sq->q_full_delta);
+			hwq->prod, hwq->cons, hwq->depth, sq->q_full_delta);
 		rc = -ENOMEM;
 		goto done;
 	}
-	sw_prod = HWQ_CMP(sq->hwq.prod, &sq->hwq);
-	swq = &sq->swq[sw_prod];
+
+	swq = bnxt_qplib_get_swqe(sq, &wqe_idx);
+	bnxt_qplib_pull_psn_buff(sq, swq);
+
+	idx = 0;
+	swq->slot_idx = hwq->prod;
+	swq->slots = slots;
 	swq->wr_id = wqe->wr_id;
 	swq->type = wqe->type;
 	swq->flags = wqe->flags;
+	swq->start_psn = sq->psn & BTH_PSN_MASK;
 	if (qp->sig_type)
 		swq->flags |= SQ_SEND_FLAGS_SIGNAL_COMP;
-	swq->start_psn = sq->psn & BTH_PSN_MASK;
 
-	hw_sq_send_hdr = bnxt_qplib_get_qe(&sq->hwq, sw_prod, NULL);
-	memset(hw_sq_send_hdr, 0, sq->wqe_size);
-
-	if (wqe->flags & BNXT_QPLIB_SWQE_FLAGS_INLINE) {
-		/* Copy the inline data */
-		if (wqe->inline_len > BNXT_QPLIB_SWQE_MAX_INLINE_LENGTH) {
-			dev_warn(&sq->hwq.pdev->dev,
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
+	if (qp->state == CMDQ_MODIFY_QP_NEW_STATE_ERR) {
+		sch_handler = true;
+		goto queue_err;
 	}
 
+	base_hdr = bnxt_qplib_get_prod_qe(hwq, idx++);
+	ext_hdr = bnxt_qplib_get_prod_qe(hwq, idx++);
+	memset(base_hdr, 0, sizeof(struct sq_sge));
+	memset(ext_hdr, 0, sizeof(struct sq_sge));
+
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
 
@@ -1685,27 +1777,24 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
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
@@ -1718,16 +1807,16 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
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
@@ -1738,14 +1827,15 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
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
@@ -1755,8 +1845,7 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 	}
 	case BNXT_QPLIB_SWQE_TYPE_LOCAL_INV:
 	{
-		struct sq_localinvalidate *sqe =
-				(struct sq_localinvalidate *)hw_sq_send_hdr;
+		struct sq_localinvalidate *sqe = base_hdr;
 
 		sqe->wqe_type = wqe->type;
 		sqe->flags = wqe->flags;
@@ -1766,7 +1855,8 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 	}
 	case BNXT_QPLIB_SWQE_TYPE_FAST_REG_MR:
 	{
-		struct sq_fr_pmr *sqe = (struct sq_fr_pmr *)hw_sq_send_hdr;
+		struct sq_fr_pmr_ext_hdr *ext_sqe = ext_hdr;
+		struct sq_fr_pmr_hdr *sqe = base_hdr;
 
 		sqe->wqe_type = wqe->type;
 		sqe->flags = wqe->flags;
@@ -1790,14 +1880,14 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 			wqe->frmr.pbl_ptr[i] = cpu_to_le64(
 						wqe->frmr.page_list[i] |
 						PTU_PTE_VALID);
-		sqe->pblptr = cpu_to_le64(wqe->frmr.pbl_dma_ptr);
-		sqe->va = cpu_to_le64(wqe->frmr.va);
-
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
@@ -1806,9 +1896,8 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
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
@@ -1817,23 +1906,11 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 		goto done;
 	}
 	swq->next_psn = sq->psn & BTH_PSN_MASK;
-	if (qp->type == CMDQ_CREATE_QP_TYPE_RC)
-		bnxt_qplib_fill_psn_search(qp, wqe, swq);
+	bnxt_qplib_fill_psn_search(qp, wqe, swq);
 queue_err:
-	if (sch_handler) {
-		/* Store the ULP info in the software structures */
-		sw_prod = HWQ_CMP(sq->hwq.prod, &sq->hwq);
-		swq = &sq->swq[sw_prod];
-		swq->wr_id = wqe->wr_id;
-		swq->type = wqe->type;
-		swq->flags = wqe->flags;
-		if (qp->sig_type)
-			swq->flags |= SQ_SEND_FLAGS_SIGNAL_COMP;
-		swq->start_psn = sq->psn & BTH_PSN_MASK;
-	}
-	sq->hwq.prod++;
+	bnxt_qplib_swq_mod_start(sq, wqe_idx);
+	bnxt_qplib_hwq_incr_prod(hwq, swq->slots);
 	qp->wqe_cnt++;
-
 done:
 	if (sch_handler) {
 		nq_work = kzalloc(sizeof(*nq_work), GFP_ATOMIC);
@@ -1863,58 +1940,68 @@ int bnxt_qplib_post_recv(struct bnxt_qplib_qp *qp,
 {
 	struct bnxt_qplib_nq_work *nq_work = NULL;
 	struct bnxt_qplib_q *rq = &qp->rq;
+	struct rq_wqe_hdr *base_hdr;
+	struct rq_ext_hdr *ext_hdr;
+	struct bnxt_qplib_hwq *hwq;
+	struct bnxt_qplib_swq *swq;
 	bool sch_handler = false;
-	struct sq_sge *hw_sge;
-	struct rq_wqe *rqe;
-	int i, rc = 0;
-	u32 sw_prod;
+	u16 wqe_sz, idx;
+	u32 wqe_idx;
+	int rc = 0;
 
-	if (qp->state == CMDQ_MODIFY_QP_NEW_STATE_ERR) {
-		sch_handler = true;
-		dev_dbg(&rq->hwq.pdev->dev,
-			"%s: Error QP. Scheduling for poll_cq\n", __func__);
-		goto queue_err;
+	hwq = &rq->hwq;
+	if (qp->state == CMDQ_MODIFY_QP_NEW_STATE_RESET) {
+		dev_err(&hwq->pdev->dev,
+			"QPLIB: FP: QP (0x%x) is in the 0x%x state",
+			qp->id, qp->state);
+		rc = -EINVAL;
+		goto done;
 	}
-	if (bnxt_qplib_queue_full(rq)) {
-		dev_err(&rq->hwq.pdev->dev,
-			"FP: QP (0x%x) RQ is full!\n", qp->id);
+
+	if (bnxt_qplib_queue_full(rq, rq->dbinfo.max_slot)) {
+		dev_err(&hwq->pdev->dev, "FP: QP (0x%x) RQ is full!\n",
+			qp->id);
 		rc = -EINVAL;
 		goto done;
 	}
-	sw_prod = HWQ_CMP(rq->hwq.prod, &rq->hwq);
-	rq->swq[sw_prod].wr_id = wqe->wr_id;
 
-	rqe = bnxt_qplib_get_qe(&rq->hwq, sw_prod, NULL);
-	memset(rqe, 0, rq->wqe_size);
+	swq = bnxt_qplib_get_swqe(rq, &wqe_idx);
+	swq->wr_id = wqe->wr_id;
+	swq->slots = rq->dbinfo.max_slot;
 
-	/* Calculate wqe_size16 and data_len */
-	for (i = 0, hw_sge = (struct sq_sge *)rqe->data;
-	     i < wqe->num_sge; i++, hw_sge++) {
-		hw_sge->va_or_pa = cpu_to_le64(wqe->sg_list[i].addr);
-		hw_sge->l_key = cpu_to_le32(wqe->sg_list[i].lkey);
-		hw_sge->size = cpu_to_le32(wqe->sg_list[i].size);
+	if (qp->state == CMDQ_MODIFY_QP_NEW_STATE_ERR) {
+		sch_handler = true;
+		dev_dbg(&hwq->pdev->dev, "%s Error QP. Sched a flushed cmpl\n",
+			__func__);
+		goto queue_err;
 	}
-	rqe->wqe_type = wqe->type;
-	rqe->flags = wqe->flags;
-	rqe->wqe_size = wqe->num_sge +
-			((offsetof(typeof(*rqe), data) + 15) >> 4);
-	/* HW requires wqe size has room for atleast one SGE even if none
-	 * was supplied by ULP
-	 */
-	if (!wqe->num_sge)
-		rqe->wqe_size++;
 
-	/* Supply the rqe->wr_id index to the wr_id_tbl for now */
-	rqe->wr_id[0] = cpu_to_le32(sw_prod);
+	idx = 0;
+	base_hdr = bnxt_qplib_get_prod_qe(hwq, idx++);
+	ext_hdr = bnxt_qplib_get_prod_qe(hwq, idx++);
+	memset(base_hdr, 0, sizeof(struct sq_sge));
+	memset(ext_hdr, 0, sizeof(struct sq_sge));
 
-queue_err:
-	if (sch_handler) {
-		/* Store the ULP info in the software structures */
-		sw_prod = HWQ_CMP(rq->hwq.prod, &rq->hwq);
-		rq->swq[sw_prod].wr_id = wqe->wr_id;
+	wqe_sz = (sizeof(struct rq_wqe_hdr) +
+		  wqe->num_sge * sizeof(struct sq_sge)) >> 4;
+	bnxt_qplib_put_sges(hwq, wqe->sg_list, wqe->num_sge, &idx);
+	if (!wqe->num_sge) {
+		struct sq_sge *sge;
+
+		sge = bnxt_qplib_get_prod_qe(hwq, idx++);
+		sge->size = 0;
+		wqe_sz++;
 	}
 
-	rq->hwq.prod++;
+	base_hdr->wqe_type = wqe->type;
+	base_hdr->flags = wqe->flags;
+	base_hdr->wqe_size = wqe_sz;
+	base_hdr->wr_id[0] = cpu_to_le32(wqe_idx);
+
+queue_err:
+	bnxt_qplib_swq_mod_start(rq, wqe_idx);
+	bnxt_qplib_hwq_incr_prod(hwq, swq->slots);
+done:
 	if (sch_handler) {
 		nq_work = kzalloc(sizeof(*nq_work), GFP_ATOMIC);
 		if (nq_work) {
@@ -1928,7 +2015,6 @@ int bnxt_qplib_post_recv(struct bnxt_qplib_qp *qp,
 			rc = -ENOMEM;
 		}
 	}
-done:
 	return rc;
 }
 
@@ -2026,20 +2112,19 @@ int bnxt_qplib_destroy_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 static int __flush_sq(struct bnxt_qplib_q *sq, struct bnxt_qplib_qp *qp,
 		      struct bnxt_qplib_cqe **pcqe, int *budget)
 {
-	u32 sw_prod, sw_cons;
 	struct bnxt_qplib_cqe *cqe;
+	u32 start, last;
 	int rc = 0;
 
 	/* Now complete all outstanding SQEs with FLUSHED_ERR */
-	sw_prod = HWQ_CMP(sq->hwq.prod, &sq->hwq);
+	start = sq->swq_start;
 	cqe = *pcqe;
 	while (*budget) {
-		sw_cons = HWQ_CMP(sq->hwq.cons, &sq->hwq);
-		if (sw_cons == sw_prod) {
+		last = sq->swq_last;
+		if (start == last)
 			break;
-		}
 		/* Skip the FENCE WQE completions */
-		if (sq->swq[sw_cons].wr_id == BNXT_QPLIB_FENCE_WRID) {
+		if (sq->swq[last].wr_id == BNXT_QPLIB_FENCE_WRID) {
 			bnxt_qplib_cancel_phantom_processing(qp);
 			goto skip_compl;
 		}
@@ -2047,16 +2132,17 @@ static int __flush_sq(struct bnxt_qplib_q *sq, struct bnxt_qplib_qp *qp,
 		cqe->status = CQ_REQ_STATUS_WORK_REQUEST_FLUSHED_ERR;
 		cqe->opcode = CQ_BASE_CQE_TYPE_REQ;
 		cqe->qp_handle = (u64)(unsigned long)qp;
-		cqe->wr_id = sq->swq[sw_cons].wr_id;
+		cqe->wr_id = sq->swq[last].wr_id;
 		cqe->src_qp = qp->id;
-		cqe->type = sq->swq[sw_cons].type;
+		cqe->type = sq->swq[last].type;
 		cqe++;
 		(*budget)--;
 skip_compl:
-		sq->hwq.cons++;
+		bnxt_qplib_hwq_incr_cons(&sq->hwq, sq->swq[last].slots);
+		sq->swq_last = sq->swq[last].next_idx;
 	}
 	*pcqe = cqe;
-	if (!(*budget) && HWQ_CMP(sq->hwq.cons, &sq->hwq) != sw_prod)
+	if (!(*budget) && sq->swq_last != start)
 		/* Out of budget */
 		rc = -EAGAIN;
 
@@ -2067,9 +2153,9 @@ static int __flush_rq(struct bnxt_qplib_q *rq, struct bnxt_qplib_qp *qp,
 		      struct bnxt_qplib_cqe **pcqe, int *budget)
 {
 	struct bnxt_qplib_cqe *cqe;
-	u32 sw_prod, sw_cons;
-	int rc = 0;
+	u32 start, last;
 	int opcode = 0;
+	int rc = 0;
 
 	switch (qp->type) {
 	case CMDQ_CREATE_QP1_TYPE_GSI:
@@ -2085,24 +2171,25 @@ static int __flush_rq(struct bnxt_qplib_q *rq, struct bnxt_qplib_qp *qp,
 	}
 
 	/* Flush the rest of the RQ */
-	sw_prod = HWQ_CMP(rq->hwq.prod, &rq->hwq);
+	start = rq->swq_start;
 	cqe = *pcqe;
 	while (*budget) {
-		sw_cons = HWQ_CMP(rq->hwq.cons, &rq->hwq);
-		if (sw_cons == sw_prod)
+		last = rq->swq_last;
+		if (last == start)
 			break;
 		memset(cqe, 0, sizeof(*cqe));
 		cqe->status =
 		    CQ_RES_RC_STATUS_WORK_REQUEST_FLUSHED_ERR;
 		cqe->opcode = opcode;
 		cqe->qp_handle = (unsigned long)qp;
-		cqe->wr_id = rq->swq[sw_cons].wr_id;
+		cqe->wr_id = rq->swq[last].wr_id;
 		cqe++;
 		(*budget)--;
-		rq->hwq.cons++;
+		bnxt_qplib_hwq_incr_cons(&rq->hwq, rq->swq[last].slots);
+		rq->swq_last = rq->swq[last].next_idx;
 	}
 	*pcqe = cqe;
-	if (!*budget && HWQ_CMP(rq->hwq.cons, &rq->hwq) != sw_prod)
+	if (!*budget && rq->swq_last != start)
 		/* Out of budget */
 		rc = -EAGAIN;
 
@@ -2125,7 +2212,7 @@ void bnxt_qplib_mark_qp_error(void *qp_handle)
  *       CQE is track from sw_cq_cons to max_element but valid only if VALID=1
  */
 static int do_wa9060(struct bnxt_qplib_qp *qp, struct bnxt_qplib_cq *cq,
-		     u32 cq_cons, u32 sw_sq_cons, u32 cqe_sq_cons)
+		     u32 cq_cons, u32 swq_last, u32 cqe_sq_cons)
 {
 	u32 peek_sw_cq_cons, peek_raw_cq_cons, peek_sq_cons_idx;
 	struct bnxt_qplib_q *sq = &qp->sq;
@@ -2138,7 +2225,7 @@ static int do_wa9060(struct bnxt_qplib_qp *qp, struct bnxt_qplib_cq *cq,
 
 	/* Normal mode */
 	/* Check for the psn_search marking before completing */
-	swq = &sq->swq[sw_sq_cons];
+	swq = &sq->swq[swq_last];
 	if (swq->psn_search &&
 	    le32_to_cpu(swq->psn_search->flags_next_psn) & 0x80000000) {
 		/* Unmark */
@@ -2147,7 +2234,7 @@ static int do_wa9060(struct bnxt_qplib_qp *qp, struct bnxt_qplib_cq *cq,
 				     & ~0x80000000);
 		dev_dbg(&cq->hwq.pdev->dev,
 			"FP: Process Req cq_cons=0x%x qp=0x%x sq cons sw=0x%x cqe=0x%x marked!\n",
-			cq_cons, qp->id, sw_sq_cons, cqe_sq_cons);
+			cq_cons, qp->id, swq_last, cqe_sq_cons);
 		sq->condition = true;
 		sq->send_phantom = true;
 
@@ -2184,9 +2271,10 @@ static int do_wa9060(struct bnxt_qplib_qp *qp, struct bnxt_qplib_cq *cq,
 						 le64_to_cpu
 						 (peek_req_hwcqe->qp_handle));
 					peek_sq = &peek_qp->sq;
-					peek_sq_cons_idx = HWQ_CMP(le16_to_cpu(
-						peek_req_hwcqe->sq_cons_idx) - 1
-						, &sq->hwq);
+					peek_sq_cons_idx =
+						((le16_to_cpu(
+						  peek_req_hwcqe->sq_cons_idx)
+						  - 1) % sq->max_wqe);
 					/* If the hwcqe's sq's wr_id matches */
 					if (peek_sq == sq &&
 					    sq->swq[peek_sq_cons_idx].wr_id ==
@@ -2214,7 +2302,7 @@ static int do_wa9060(struct bnxt_qplib_qp *qp, struct bnxt_qplib_cq *cq,
 		}
 		dev_err(&cq->hwq.pdev->dev,
 			"Should not have come here! cq_cons=0x%x qp=0x%x sq cons sw=0x%x hw=0x%x\n",
-			cq_cons, qp->id, sw_sq_cons, cqe_sq_cons);
+			cq_cons, qp->id, swq_last, cqe_sq_cons);
 		rc = -EINVAL;
 	}
 out:
@@ -2226,11 +2314,11 @@ static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
 				     struct bnxt_qplib_cqe **pcqe, int *budget,
 				     u32 cq_cons, struct bnxt_qplib_qp **lib_qp)
 {
-	u32 sw_sq_cons, cqe_sq_cons;
 	struct bnxt_qplib_swq *swq;
 	struct bnxt_qplib_cqe *cqe;
 	struct bnxt_qplib_qp *qp;
 	struct bnxt_qplib_q *sq;
+	u32 cqe_sq_cons;
 	int rc = 0;
 
 	qp = (struct bnxt_qplib_qp *)((unsigned long)
@@ -2242,14 +2330,7 @@ static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
 	}
 	sq = &qp->sq;
 
-	cqe_sq_cons = HWQ_CMP(le16_to_cpu(hwcqe->sq_cons_idx), &sq->hwq);
-	if (cqe_sq_cons > sq->hwq.max_elements) {
-		dev_err(&cq->hwq.pdev->dev,
-			"FP: CQ Process req reported sq_cons_idx 0x%x which exceeded max 0x%x\n",
-			cqe_sq_cons, sq->hwq.max_elements);
-		return -EINVAL;
-	}
-
+	cqe_sq_cons = le16_to_cpu(hwcqe->sq_cons_idx) % sq->max_wqe;
 	if (qp->sq.flushed) {
 		dev_dbg(&cq->hwq.pdev->dev,
 			"%s: QP in Flush QP = %p\n", __func__, qp);
@@ -2261,12 +2342,11 @@ static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
 	 */
 	cqe = *pcqe;
 	while (*budget) {
-		sw_sq_cons = HWQ_CMP(sq->hwq.cons, &sq->hwq);
-		if (sw_sq_cons == cqe_sq_cons)
+		if (sq->swq_last == cqe_sq_cons)
 			/* Done */
 			break;
 
-		swq = &sq->swq[sw_sq_cons];
+		swq = &sq->swq[sq->swq_last];
 		memset(cqe, 0, sizeof(*cqe));
 		cqe->opcode = CQ_BASE_CQE_TYPE_REQ;
 		cqe->qp_handle = (u64)(unsigned long)qp;
@@ -2280,12 +2360,12 @@ static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
 		 * of the request being signaled or not, it must complete with
 		 * the hwcqe error status
 		 */
-		if (HWQ_CMP((sw_sq_cons + 1), &sq->hwq) == cqe_sq_cons &&
+		if (swq->next_idx == cqe_sq_cons &&
 		    hwcqe->status != CQ_REQ_STATUS_OK) {
 			cqe->status = hwcqe->status;
 			dev_err(&cq->hwq.pdev->dev,
 				"FP: CQ Processed Req wr_id[%d] = 0x%llx with status 0x%x\n",
-				sw_sq_cons, cqe->wr_id, cqe->status);
+				sq->swq_last, cqe->wr_id, cqe->status);
 			cqe++;
 			(*budget)--;
 			bnxt_qplib_mark_qp_error(qp);
@@ -2293,7 +2373,7 @@ static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
 			bnxt_qplib_add_flush_qp(qp);
 		} else {
 			/* Before we complete, do WA 9060 */
-			if (do_wa9060(qp, cq, cq_cons, sw_sq_cons,
+			if (do_wa9060(qp, cq, cq_cons, sq->swq_last,
 				      cqe_sq_cons)) {
 				*lib_qp = qp;
 				goto out;
@@ -2305,13 +2385,14 @@ static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
 			}
 		}
 skip:
-		sq->hwq.cons++;
+		bnxt_qplib_hwq_incr_cons(&sq->hwq, swq->slots);
+		sq->swq_last = swq->next_idx;
 		if (sq->single)
 			break;
 	}
 out:
 	*pcqe = cqe;
-	if (HWQ_CMP(sq->hwq.cons, &sq->hwq) != cqe_sq_cons) {
+	if (sq->swq_last != cqe_sq_cons) {
 		/* Out of budget */
 		rc = -EAGAIN;
 		goto done;
@@ -2386,17 +2467,23 @@ static int bnxt_qplib_cq_process_res_rc(struct bnxt_qplib_cq *cq,
 		(*budget)--;
 		*pcqe = cqe;
 	} else {
+		struct bnxt_qplib_swq *swq;
+
 		rq = &qp->rq;
-		if (wr_id_idx >= rq->hwq.max_elements) {
+		if (wr_id_idx > (rq->max_wqe - 1)) {
 			dev_err(&cq->hwq.pdev->dev,
 				"FP: CQ Process RC wr_id idx 0x%x exceeded RQ max 0x%x\n",
-				wr_id_idx, rq->hwq.max_elements);
+				wr_id_idx, rq->max_wqe);
 			return -EINVAL;
 		}
-		cqe->wr_id = rq->swq[wr_id_idx].wr_id;
+		if (wr_id_idx != rq->swq_last)
+			return -EINVAL;
+		swq = &rq->swq[rq->swq_last];
+		cqe->wr_id = swq->wr_id;
 		cqe++;
 		(*budget)--;
-		rq->hwq.cons++;
+		bnxt_qplib_hwq_incr_cons(&rq->hwq, swq->slots);
+		rq->swq_last = swq->next_idx;
 		*pcqe = cqe;
 
 		if (hwcqe->status != CQ_RES_RC_STATUS_OK) {
@@ -2467,18 +2554,24 @@ static int bnxt_qplib_cq_process_res_ud(struct bnxt_qplib_cq *cq,
 		(*budget)--;
 		*pcqe = cqe;
 	} else {
+		struct bnxt_qplib_swq *swq;
+
 		rq = &qp->rq;
-		if (wr_id_idx >= rq->hwq.max_elements) {
+		if (wr_id_idx > (rq->max_wqe - 1)) {
 			dev_err(&cq->hwq.pdev->dev,
 				"FP: CQ Process UD wr_id idx 0x%x exceeded RQ max 0x%x\n",
-				wr_id_idx, rq->hwq.max_elements);
+				wr_id_idx, rq->max_wqe);
 			return -EINVAL;
 		}
 
-		cqe->wr_id = rq->swq[wr_id_idx].wr_id;
+		if (rq->swq_last != wr_id_idx)
+			return -EINVAL;
+		swq = &rq->swq[rq->swq_last];
+		cqe->wr_id = swq->wr_id;
 		cqe++;
 		(*budget)--;
-		rq->hwq.cons++;
+		bnxt_qplib_hwq_incr_cons(&rq->hwq, swq->slots);
+		rq->swq_last = swq->next_idx;
 		*pcqe = cqe;
 
 		if (hwcqe->status != CQ_RES_RC_STATUS_OK) {
@@ -2569,17 +2662,23 @@ static int bnxt_qplib_cq_process_res_raweth_qp1(struct bnxt_qplib_cq *cq,
 		(*budget)--;
 		*pcqe = cqe;
 	} else {
+		struct bnxt_qplib_swq *swq;
+
 		rq = &qp->rq;
-		if (wr_id_idx >= rq->hwq.max_elements) {
+		if (wr_id_idx > (rq->max_wqe - 1)) {
 			dev_err(&cq->hwq.pdev->dev,
 				"FP: CQ Process Raw/QP1 RQ wr_id idx 0x%x exceeded RQ max 0x%x\n",
-				wr_id_idx, rq->hwq.max_elements);
+				wr_id_idx, rq->max_wqe);
 			return -EINVAL;
 		}
-		cqe->wr_id = rq->swq[wr_id_idx].wr_id;
+		if (rq->swq_last != wr_id_idx)
+			return -EINVAL;
+		swq = &rq->swq[rq->swq_last];
+		cqe->wr_id = swq->wr_id;
 		cqe++;
 		(*budget)--;
-		rq->hwq.cons++;
+		bnxt_qplib_hwq_incr_cons(&rq->hwq, swq->slots);
+		rq->swq_last = swq->next_idx;
 		*pcqe = cqe;
 
 		if (hwcqe->status != CQ_RES_RC_STATUS_OK) {
@@ -2601,7 +2700,7 @@ static int bnxt_qplib_cq_process_terminal(struct bnxt_qplib_cq *cq,
 	struct bnxt_qplib_qp *qp;
 	struct bnxt_qplib_q *sq, *rq;
 	struct bnxt_qplib_cqe *cqe;
-	u32 sw_cons = 0, cqe_cons;
+	u32 swq_last = 0, cqe_cons;
 	int rc = 0;
 
 	/* Check the Status */
@@ -2627,13 +2726,7 @@ static int bnxt_qplib_cq_process_terminal(struct bnxt_qplib_cq *cq,
 	cqe_cons = le16_to_cpu(hwcqe->sq_cons_idx);
 	if (cqe_cons == 0xFFFF)
 		goto do_rq;
-
-	if (cqe_cons > sq->hwq.max_elements) {
-		dev_err(&cq->hwq.pdev->dev,
-			"FP: CQ Process terminal reported sq_cons_idx 0x%x which exceeded max 0x%x\n",
-			cqe_cons, sq->hwq.max_elements);
-		goto do_rq;
-	}
+	cqe_cons %= sq->max_wqe;
 
 	if (qp->sq.flushed) {
 		dev_dbg(&cq->hwq.pdev->dev,
@@ -2647,24 +2740,25 @@ static int bnxt_qplib_cq_process_terminal(struct bnxt_qplib_cq *cq,
 	 */
 	cqe = *pcqe;
 	while (*budget) {
-		sw_cons = HWQ_CMP(sq->hwq.cons, &sq->hwq);
-		if (sw_cons == cqe_cons)
+		swq_last = sq->swq_last;
+		if (swq_last == cqe_cons)
 			break;
-		if (sq->swq[sw_cons].flags & SQ_SEND_FLAGS_SIGNAL_COMP) {
+		if (sq->swq[swq_last].flags & SQ_SEND_FLAGS_SIGNAL_COMP) {
 			memset(cqe, 0, sizeof(*cqe));
 			cqe->status = CQ_REQ_STATUS_OK;
 			cqe->opcode = CQ_BASE_CQE_TYPE_REQ;
 			cqe->qp_handle = (u64)(unsigned long)qp;
 			cqe->src_qp = qp->id;
-			cqe->wr_id = sq->swq[sw_cons].wr_id;
-			cqe->type = sq->swq[sw_cons].type;
+			cqe->wr_id = sq->swq[swq_last].wr_id;
+			cqe->type = sq->swq[swq_last].type;
 			cqe++;
 			(*budget)--;
 		}
-		sq->hwq.cons++;
+		bnxt_qplib_hwq_incr_cons(&sq->hwq, sq->swq[swq_last].slots);
+		sq->swq_last = sq->swq[swq_last].next_idx;
 	}
 	*pcqe = cqe;
-	if (!(*budget) && sw_cons != cqe_cons) {
+	if (!(*budget) && swq_last != cqe_cons) {
 		/* Out of budget */
 		rc = -EAGAIN;
 		goto sq_done;
@@ -2676,10 +2770,10 @@ static int bnxt_qplib_cq_process_terminal(struct bnxt_qplib_cq *cq,
 	cqe_cons = le16_to_cpu(hwcqe->rq_cons_idx);
 	if (cqe_cons == 0xFFFF) {
 		goto done;
-	} else if (cqe_cons > rq->hwq.max_elements) {
+	} else if (cqe_cons > rq->max_wqe - 1) {
 		dev_err(&cq->hwq.pdev->dev,
 			"FP: CQ Processed terminal reported rq_cons_idx 0x%x exceeds max 0x%x\n",
-			cqe_cons, rq->hwq.max_elements);
+			cqe_cons, rq->max_wqe);
 		goto done;
 	}
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 568ca39..b8679b2 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -39,6 +39,51 @@
 #ifndef __BNXT_QPLIB_FP_H__
 #define __BNXT_QPLIB_FP_H__
 
+/* Few helper structures temporarily defined here
+ * should get rid of these when roce_hsi.h is updated
+ * in original code base
+ */
+struct sq_ud_ext_hdr {
+	__le32	dst_qp;
+	__le32	avid;
+	__le64	rsvd;
+};
+
+struct sq_raw_ext_hdr {
+	__le32	cfa_meta;
+	__le32	rsvd0;
+	__le64	rsvd1;
+};
+
+struct sq_rdma_ext_hdr {
+	__le64	remote_va;
+	__le32	remote_key;
+	__le32	rsvd;
+};
+
+struct sq_atomic_ext_hdr {
+	__le64	swap_data;
+	__le64	cmp_data;
+};
+
+struct sq_fr_pmr_ext_hdr {
+	__le64	pblptr;
+	__le64	va;
+};
+
+struct sq_bind_ext_hdr {
+	__le64	va;
+	__le32	length_lo;
+	__le32	length_hi;
+};
+
+struct rq_ext_hdr {
+	__le64	rsvd1;
+	__le64	rsvd2;
+};
+
+/* Helper structures end */
+
 struct bnxt_qplib_srq {
 	struct bnxt_qplib_pd		*pd;
 	struct bnxt_qplib_dpi		*dpi;
@@ -74,8 +119,11 @@ struct bnxt_qplib_swq {
 	u8				flags;
 	u32				start_psn;
 	u32				next_psn;
+	u32				slot_idx;
+	u8				slots;
 	struct sq_psn_search		*psn_search;
 	struct sq_psn_search_ext	*psn_ext;
+	void				*inline_data;
 };
 
 struct bnxt_qplib_swqe {
@@ -213,6 +261,8 @@ struct bnxt_qplib_q {
 	u32				phantom_cqe_cnt;
 	u32				next_cq_cons;
 	bool				flushed;
+	u32				swq_start;
+	u32				swq_last;
 };
 
 struct bnxt_qplib_qp {
@@ -224,9 +274,10 @@ struct bnxt_qplib_qp {
 	u32				id;
 	u8				type;
 	u8				sig_type;
-	u32				modify_flags;
+	u8				wqe_mode;
 	u8				state;
 	u8				cur_qp_state;
+	u64				modify_flags;
 	u32				max_inline_data;
 	u32				mtu;
 	u8				path_mtu;
@@ -300,11 +351,18 @@ struct bnxt_qplib_qp {
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
@@ -489,4 +547,64 @@ int bnxt_qplib_process_flush_list(struct bnxt_qplib_cq *cq,
 				  struct bnxt_qplib_cqe *cqe,
 				  int num_cqes);
 void bnxt_qplib_flush_cqn_wq(struct bnxt_qplib_qp *qp);
+
+static inline void *bnxt_qplib_get_swqe(struct bnxt_qplib_q *que, u32 *swq_idx)
+{
+	u32 idx;
+
+	idx = que->swq_start;
+	if (swq_idx)
+		*swq_idx = idx;
+	return &que->swq[idx];
+}
+
+static inline void bnxt_qplib_swq_mod_start(struct bnxt_qplib_q *que, u32 idx)
+{
+	que->swq_start = que->swq[idx].next_idx;
+}
+
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
index c29cbd3..ea05157 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -41,6 +41,28 @@
 
 extern const struct bnxt_qplib_gid bnxt_qplib_gid_zero;
 
+#define CHIP_NUM_57508		0x1750
+#define CHIP_NUM_57504		0x1751
+#define CHIP_NUM_57502		0x1752
+
+enum bnxt_qplib_wqe_mode {
+	BNXT_QPLIB_WQE_MODE_STATIC	 = 0x00,
+	BNXT_QPLIB_WQE_MODE_VARIABLE	= 0x01,
+	BNXT_QPLIB_WQE_MODE_INVALID	= 0x02
+};
+
+struct bnxt_qplib_drv_modes {
+	u8	wqe_mode;
+	/* Other modes to follow here */
+};
+
+struct bnxt_qplib_chip_ctx {
+	u16	chip_num;
+	u8	chip_rev;
+	u8	chip_metal;
+	struct	bnxt_qplib_drv_modes modes;
+};
+
 #define PTR_CNT_PER_PG		(PAGE_SIZE / sizeof(void *))
 #define PTR_MAX_IDX_PER_PG	(PTR_CNT_PER_PG - 1)
 #define PTR_PG(x)		(((x) & ~PTR_MAX_IDX_PER_PG) / PTR_CNT_PER_PG)
@@ -141,6 +163,9 @@ struct bnxt_qplib_hwq {
 	u32				cons;		/* raw */
 	u8				cp_bit;
 	u8				is_user;
+	u64				*pad_pg;
+	u32				pad_stride;
+	u32				pad_pgofft;
 };
 
 struct bnxt_qplib_db_info {
@@ -148,6 +173,7 @@ struct bnxt_qplib_db_info {
 	void __iomem		*priv_db;
 	struct bnxt_qplib_hwq	*hwq;
 	u32			xid;
+	u32			max_slot;
 };
 
 /* Tables */
@@ -230,16 +256,6 @@ struct bnxt_qplib_ctx {
 	u64				hwrm_intf_ver;
 };
 
-struct bnxt_qplib_chip_ctx {
-	u16	chip_num;
-	u8	chip_rev;
-	u8	chip_metal;
-};
-
-#define CHIP_NUM_57508		0x1750
-#define CHIP_NUM_57504		0x1751
-#define CHIP_NUM_57502		0x1752
-
 struct bnxt_qplib_res {
 	struct pci_dev			*pdev;
 	struct bnxt_qplib_chip_ctx	*cctx;
@@ -253,6 +269,11 @@ struct bnxt_qplib_res {
 	bool				prio;
 };
 
+static inline bool bnxt_re_is_wqe_mode_var(struct bnxt_qplib_chip_ctx *cctx)
+{
+	return cctx->modes.wqe_mode == BNXT_QPLIB_WQE_MODE_VARIABLE;
+}
+
 static inline bool bnxt_qplib_is_chip_gen_p5(struct bnxt_qplib_chip_ctx *cctx)
 {
 	return (cctx->chip_num == CHIP_NUM_57508 ||
@@ -305,6 +326,17 @@ static inline u8 bnxt_qplib_base_pg_size(struct bnxt_qplib_hwq *hwq)
 	return pg_size;
 }
 
+static inline void bnxt_qplib_hwq_incr_prod(struct bnxt_qplib_hwq *hwq, u32 cnt)
+{
+	hwq->prod = (hwq->prod + cnt) % hwq->depth;
+}
+
+static inline void bnxt_qplib_hwq_incr_cons(struct bnxt_qplib_hwq *hwq,
+					    u32 cnt)
+{
+	hwq->cons = (hwq->cons + cnt) % hwq->depth;
+}
+
 static inline void *bnxt_qplib_get_qe(struct bnxt_qplib_hwq *hwq,
 				      u32 indx, u64 *pg)
 {
@@ -317,6 +349,14 @@ static inline void *bnxt_qplib_get_qe(struct bnxt_qplib_hwq *hwq,
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
 
@@ -383,8 +423,7 @@ static inline void bnxt_qplib_ring_prod_db(struct bnxt_qplib_db_info *info,
 
 	key = (info->xid & DBC_DBC_XID_MASK) | DBC_DBC_PATH_ROCE | type;
 	key <<= 32;
-	key |= (info->hwq->prod & (info->hwq->max_elements - 1)) &
-		DBC_DBC_INDEX_MASK;
+	key |= ((info->hwq->prod / info->max_slot)) & DBC_DBC_INDEX_MASK;
 	writeq(key, info->db);
 }
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 66954ff..1d87cbf 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -77,14 +77,17 @@ static void bnxt_qplib_query_version(struct bnxt_qplib_rcfw *rcfw,
 int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 			    struct bnxt_qplib_dev_attr *attr, bool vf)
 {
-	struct cmdq_query_func req;
-	struct creq_query_func_resp resp;
-	struct bnxt_qplib_rcfw_sbuf *sbuf;
 	struct creq_query_func_resp_sb *sb;
+	struct bnxt_qplib_rcfw_sbuf *sbuf;
+	struct creq_query_func_resp resp;
+	struct bnxt_qplib_chip_ctx *cctx;
+	struct cmdq_query_func req;
 	u16 cmd_flags = 0;
-	u32 temp;
 	u8 *tqm_alloc;
 	int i, rc = 0;
+	u32 temp;
+
+	cctx = rcfw->res->cctx;
 
 	RCFW_CMD_PREP(req, QUERY_FUNC, cmd_flags);
 
@@ -119,7 +122,7 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 	 * reporting the max number
 	 */
 	attr->max_qp_wqes -= BNXT_QPLIB_RESERVED_QP_WRS;
-	attr->max_qp_sges = bnxt_qplib_is_chip_gen_p5(rcfw->res->cctx) ?
+	attr->max_qp_sges = bnxt_qplib_is_chip_gen_p5(cctx) ?
 			    6 : sb->max_sge;
 	attr->max_cq = le32_to_cpu(sb->max_cq);
 	attr->max_cq_wqes = le32_to_cpu(sb->max_cqe);
diff --git a/drivers/infiniband/hw/bnxt_re/roce_hsi.h b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
index 6f00f07..3e40e0d 100644
--- a/drivers/infiniband/hw/bnxt_re/roce_hsi.h
+++ b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
@@ -1126,6 +1126,7 @@ struct cmdq_create_qp {
 	#define CMDQ_CREATE_QP_QP_FLAGS_FORCE_COMPLETION	   0x2UL
 	#define CMDQ_CREATE_QP_QP_FLAGS_RESERVED_LKEY_ENABLE      0x4UL
 	#define CMDQ_CREATE_QP_QP_FLAGS_FR_PMR_ENABLED		   0x8UL
+	#define CMDQ_CREATE_QP_QP_FLAGS_VARIABLE_SIZED_WQE_ENABLED 0x10UL
 	u8 type;
 	#define CMDQ_CREATE_QP_TYPE_RC				   0x2UL
 	#define CMDQ_CREATE_QP_TYPE_UD				   0x4UL
-- 
1.8.3.1

