Return-Path: <linux-rdma+bounces-18303-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QF12NxR6ummTWwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18303-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 11:10:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0852B9A83
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 11:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE0DA30A4D86
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 10:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913623BC67D;
	Wed, 18 Mar 2026 10:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+Gdp2lL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EFB3B894E;
	Wed, 18 Mar 2026 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773828548; cv=none; b=iWgVtQrQyujjjbyqhv+GDLmAqOdM/IRKcvjtvr5w+mrsXd2wvoQFRyVzVroLfyEFVJ5lInr4mX6/uM5oAZsuaqfJ8K2fAGfJufPVSaEDCoxFKmsu7XIAO7xoogbmgA7j6iFM+Vy6qD6kM3CrlDMcenRL6tGLiwp4KPPj9g2uyHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773828548; c=relaxed/simple;
	bh=fATHKtAaCK43dNNL4W06mJeYlOuUU6Bj57tAhbY/8Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hWggu/394Su9hNMiRBSmejq2eMBAaB0b2QnIUbRi4Aqypejgxs4nZpH8YQHtqT/LRwjwOZ/VCnnVeRYz6szKGBuHIZDP2cb45ROzFeFQp38Q9vdXqEqsd02BBzP3ujOP3TtYNqeR6PuKA1FFm8EHkCpeIqEdg7M7o36cb5jCk4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+Gdp2lL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28AEC2BC87;
	Wed, 18 Mar 2026 10:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773828548;
	bh=fATHKtAaCK43dNNL4W06mJeYlOuUU6Bj57tAhbY/8Og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A+Gdp2lLtHarHnpWg3S4EsTnEG/7+vgtdp9nkb9UdC1TngcI7r5xze9ZgrjvFWu+V
	 z0VfuB3AsG+dnJHsnR6Qw6QiewOxlYm1Pr0lkhq1e6jdmkhcfGATfQOd5CKMCA8tqt
	 UHZmKc7h6dFTsWl8BF9NMGyAD4/rag6T4ZYsVAEScUepiiwTUfG/vq0m93tgeFlvhI
	 6buJq190ahtIXD020Zw1an2D30cC7nOrFU0TohRF9p/6aKDnWJyhGc+glL0YuGpFIX
	 uLfxvd2AN+a67r63SXKUH8RYclXsLHFKQsdv3eUrdg2cOezc/WGxHtnjPItzhy24Bg
	 jU2L290JjVR4A==
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/4] RDMA/bnxt_re: Simplify bnxt_re_init_depth() callers and implementation
Date: Wed, 18 Mar 2026 12:08:50 +0200
Message-ID: <20260318-bnxt_re-cq-v1-1-381cb1b5e625@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318-bnxt_re-cq-v1-0-381cb1b5e625@nvidia.com>
References: <20260318-bnxt_re-cq-v1-0-381cb1b5e625@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18303-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 6B0852B9A83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Leon Romanovsky <leonro@nvidia.com>

All callers of bnxt_re_init_depth() compute the minimum between its return
value and another internal variable, often mixing variable types in the
process. Clean this up by making the logic simpler and more readable.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 81 ++++++++++++++------------------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  9 ++--
 2 files changed, 42 insertions(+), 48 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 182128ee4f242..40ac546f113bc 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1442,7 +1442,6 @@ static int bnxt_re_init_rq_attr(struct bnxt_re_qp *qp,
 	struct bnxt_qplib_qp *qplqp;
 	struct bnxt_re_dev *rdev;
 	struct bnxt_qplib_q *rq;
-	int entries;
 
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
@@ -1465,8 +1464,9 @@ static int bnxt_re_init_rq_attr(struct bnxt_re_qp *qp,
 		/* Allocate 1 more than what's provided so posting max doesn't
 		 * mean empty.
 		 */
-		entries = bnxt_re_init_depth(init_attr->cap.max_recv_wr + 1, uctx);
-		rq->max_wqe = min_t(u32, entries, dev_attr->max_qp_wqes + 1);
+		rq->max_wqe = bnxt_re_init_depth(init_attr->cap.max_recv_wr + 1,
+						 dev_attr->max_qp_wqes + 1,
+						 uctx);
 		rq->max_sw_wqe = rq->max_wqe;
 		rq->q_full_delta = 0;
 		rq->sg_info.pgsize = PAGE_SIZE;
@@ -1504,7 +1504,6 @@ static int bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
 	struct bnxt_re_dev *rdev;
 	struct bnxt_qplib_q *sq;
 	int diff = 0;
-	int entries;
 	int rc;
 
 	rdev = qp->rdev;
@@ -1513,7 +1512,6 @@ static int bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
 	dev_attr = rdev->dev_attr;
 
 	sq->max_sge = init_attr->cap.max_send_sge;
-	entries = init_attr->cap.max_send_wr;
 	if (uctx && qplqp->wqe_mode == BNXT_QPLIB_WQE_MODE_VARIABLE) {
 		sq->max_wqe = ureq->sq_slots;
 		sq->max_sw_wqe = ureq->sq_slots;
@@ -1529,10 +1527,11 @@ static int bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
 			return rc;
 
 		/* Allocate 128 + 1 more than what's provided */
-		diff = (qplqp->wqe_mode == BNXT_QPLIB_WQE_MODE_VARIABLE) ?
-			0 : BNXT_QPLIB_RESERVED_QP_WRS;
-		entries = bnxt_re_init_depth(entries + diff + 1, uctx);
-		sq->max_wqe = min_t(u32, entries, dev_attr->max_qp_wqes + diff + 1);
+		if (qplqp->wqe_mode != BNXT_QPLIB_WQE_MODE_VARIABLE)
+			diff = BNXT_QPLIB_RESERVED_QP_WRS;
+		sq->max_wqe = bnxt_re_init_depth(
+			init_attr->cap.max_send_wr + diff + 1,
+			dev_attr->max_qp_wqes + diff + 1, uctx);
 		if (qplqp->wqe_mode == BNXT_QPLIB_WQE_MODE_VARIABLE)
 			sq->max_sw_wqe = bnxt_qplib_get_depth(sq, qplqp->wqe_mode, true);
 		else
@@ -1559,16 +1558,15 @@ static void bnxt_re_adjust_gsi_sq_attr(struct bnxt_re_qp *qp,
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_qp *qplqp;
 	struct bnxt_re_dev *rdev;
-	int entries;
 
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
 	dev_attr = rdev->dev_attr;
 
 	if (!bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx)) {
-		entries = bnxt_re_init_depth(init_attr->cap.max_send_wr + 1, uctx);
-		qplqp->sq.max_wqe = min_t(u32, entries,
-					  dev_attr->max_qp_wqes + 1);
+		qplqp->sq.max_wqe =
+			bnxt_re_init_depth(init_attr->cap.max_send_wr + 1,
+					   dev_attr->max_qp_wqes + 1, uctx);
 		qplqp->sq.q_full_delta = qplqp->sq.max_wqe -
 			init_attr->cap.max_send_wr;
 		qplqp->sq.max_sge++; /* Need one extra sge to put UD header */
@@ -2086,7 +2084,7 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 	struct bnxt_re_pd *pd;
 	struct ib_pd *ib_pd;
 	u32 active_srqs;
-	int rc, entries;
+	int rc;
 
 	ib_pd = ib_srq->pd;
 	pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
@@ -2112,10 +2110,9 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 	/* Allocate 1 more than what's provided so posting max doesn't
 	 * mean empty
 	 */
-	entries = bnxt_re_init_depth(srq_init_attr->attr.max_wr + 1, uctx);
-	if (entries > dev_attr->max_srq_wqes + 1)
-		entries = dev_attr->max_srq_wqes + 1;
-	srq->qplib_srq.max_wqe = entries;
+	srq->qplib_srq.max_wqe =
+		bnxt_re_init_depth(srq_init_attr->attr.max_wr + 1,
+				   dev_attr->max_srq_wqes + 1, uctx);
 
 	srq->qplib_srq.max_sge = srq_init_attr->attr.max_sge;
 	 /* 128 byte wqe size for SRQ . So use max sges */
@@ -2296,7 +2293,7 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 	struct bnxt_re_dev *rdev = qp->rdev;
 	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
 	enum ib_qp_state curr_qp_state, new_qp_state;
-	int rc, entries;
+	int rc;
 	unsigned int flags;
 	u8 nw_type;
 
@@ -2510,9 +2507,9 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 				  "Create QP failed - max exceeded");
 			return -EINVAL;
 		}
-		entries = bnxt_re_init_depth(qp_attr->cap.max_send_wr, uctx);
-		qp->qplib_qp.sq.max_wqe = min_t(u32, entries,
-						dev_attr->max_qp_wqes + 1);
+		qp->qplib_qp.sq.max_wqe =
+			bnxt_re_init_depth(qp_attr->cap.max_send_wr,
+					   dev_attr->max_qp_wqes + 1, uctx);
 		qp->qplib_qp.sq.q_full_delta = qp->qplib_qp.sq.max_wqe -
 						qp_attr->cap.max_send_wr;
 		/*
@@ -2523,9 +2520,9 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 		qp->qplib_qp.sq.q_full_delta -= 1;
 		qp->qplib_qp.sq.max_sge = qp_attr->cap.max_send_sge;
 		if (qp->qplib_qp.rq.max_wqe) {
-			entries = bnxt_re_init_depth(qp_attr->cap.max_recv_wr, uctx);
-			qp->qplib_qp.rq.max_wqe =
-				min_t(u32, entries, dev_attr->max_qp_wqes + 1);
+			qp->qplib_qp.rq.max_wqe = bnxt_re_init_depth(
+				qp_attr->cap.max_recv_wr,
+				dev_attr->max_qp_wqes + 1, uctx);
 			qp->qplib_qp.rq.max_sw_wqe = qp->qplib_qp.rq.max_wqe;
 			qp->qplib_qp.rq.q_full_delta = qp->qplib_qp.rq.max_wqe -
 						       qp_attr->cap.max_recv_wr;
@@ -3381,8 +3378,8 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 	struct bnxt_re_cq_resp resp = {};
 	struct bnxt_re_cq_req req;
 	int cqe = attr->cqe;
-	int rc, entries;
-	u32 active_cqs;
+	int rc;
+	u32 active_cqs, entries;
 
 	if (attr->flags)
 		return -EOPNOTSUPP;
@@ -3397,17 +3394,16 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 	cctx = rdev->chip_ctx;
 	cq->qplib_cq.cq_handle = (u64)(unsigned long)(&cq->qplib_cq);
 
-	entries = bnxt_re_init_depth(cqe + 1, uctx);
-	if (entries > dev_attr->max_cq_wqes + 1)
-		entries = dev_attr->max_cq_wqes + 1;
-
 	rc = ib_copy_validate_udata_in_cm(udata, req, cq_handle,
 					  BNXT_RE_CQ_FIXED_NUM_CQE_ENABLE);
 	if (rc)
 		return rc;
 
 	if (req.comp_mask & BNXT_RE_CQ_FIXED_NUM_CQE_ENABLE)
-		entries = cqe;
+		entries = attr->cqe;
+	else
+		entries = bnxt_re_init_depth(attr->cqe + 1,
+					     dev_attr->max_cq_wqes + 1, uctx);
 
 	if (!ibcq->umem) {
 		ibcq->umem = ib_umem_get(&rdev->ibdev, req.cq_va,
@@ -3480,7 +3476,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
 	int cqe = attr->cqe;
-	int rc, entries;
+	int rc;
 	u32 active_cqs;
 
 	if (udata)
@@ -3498,11 +3494,8 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->rdev = rdev;
 	cq->qplib_cq.cq_handle = (u64)(unsigned long)(&cq->qplib_cq);
 
-	entries = bnxt_re_init_depth(cqe + 1, uctx);
-	if (entries > dev_attr->max_cq_wqes + 1)
-		entries = dev_attr->max_cq_wqes + 1;
-
-	cq->max_cql = min_t(u32, entries, MAX_CQL_PER_POLL);
+	cq->max_cql = bnxt_re_init_depth(attr->cqe + 1,
+					 dev_attr->max_cq_wqes + 1, uctx);
 	cq->cql = kcalloc(cq->max_cql, sizeof(struct bnxt_qplib_cqe),
 			  GFP_KERNEL);
 	if (!cq->cql)
@@ -3511,7 +3504,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->qplib_cq.sg_info.pgsize = SZ_4K;
 	cq->qplib_cq.sg_info.pgshft = __builtin_ctz(SZ_4K);
 	cq->qplib_cq.dpi = &rdev->dpi_privileged;
-	cq->qplib_cq.max_wqe = entries;
+	cq->qplib_cq.max_wqe = cq->max_cql;
 	cq->qplib_cq.coalescing = &rdev->cq_coalescing;
 	cq->qplib_cq.nq = bnxt_re_get_nq(rdev);
 	cq->qplib_cq.cnq_hw_ring_id = cq->qplib_cq.nq->ring_id;
@@ -3522,7 +3515,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		goto fail;
 	}
 
-	cq->ib_cq.cqe = entries;
+	cq->ib_cq.cqe = cq->max_cql;
 	cq->cq_period = cq->qplib_cq.period;
 	active_cqs = atomic_inc_return(&rdev->stats.res.cq_count);
 	if (active_cqs > rdev->stats.res.cq_watermark)
@@ -3560,7 +3553,8 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 	struct bnxt_re_resize_cq_req req;
 	struct bnxt_re_dev *rdev;
 	struct bnxt_re_cq *cq;
-	int rc, entries;
+	int rc;
+	u32 entries;
 
 	cq =  container_of(ibcq, struct bnxt_re_cq, ib_cq);
 	rdev = cq->rdev;
@@ -3584,10 +3578,7 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 	}
 
 	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
-	entries = bnxt_re_init_depth(cqe + 1, uctx);
-	if (entries > dev_attr->max_cq_wqes + 1)
-		entries = dev_attr->max_cq_wqes + 1;
-
+	entries = bnxt_re_init_depth(cqe + 1, dev_attr->max_cq_wqes + 1, uctx);
 	/* uverbs consumer */
 	rc = ib_copy_validate_udata_in(udata, req, cq_va);
 	if (rc)
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 3d02c16f54b61..dfe790ef42d75 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -190,10 +190,13 @@ enum {
 	BNXT_RE_UCNTX_CAP_VAR_WQE_ENABLED = 0x2ULL,
 };
 
-static inline u32 bnxt_re_init_depth(u32 ent, struct bnxt_re_ucontext *uctx)
+static inline u32 bnxt_re_init_depth(u32 ent, u32 max,
+				     struct bnxt_re_ucontext *uctx)
 {
-	return uctx ? (uctx->cmask & BNXT_RE_UCNTX_CAP_POW2_DISABLED) ?
-		ent : roundup_pow_of_two(ent) : ent;
+	if (uctx && !(uctx->cmask & BNXT_RE_UCNTX_CAP_POW2_DISABLED))
+		return min(roundup_pow_of_two(ent), max);
+
+	return ent;
 }
 
 static inline bool bnxt_re_is_var_size_supported(struct bnxt_re_dev *rdev,

-- 
2.53.0


