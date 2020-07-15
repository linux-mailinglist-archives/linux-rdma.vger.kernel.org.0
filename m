Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7DA4220F04
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2020 16:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgGOORR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jul 2020 10:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgGOORQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jul 2020 10:17:16 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F3FC061755
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2020 07:17:16 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p3so3156253pgh.3
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2020 07:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oXPdZEy4xFOhSOsI17BblXcBjtO3nXX/wiLLyJDlRR8=;
        b=F9J3YFaoIlzIbtND46LT+hHHx0ovcBq9yzpeFGrVCRU5JiQ21raf0TlCiyA/gzXnbe
         xfNFGX5feBXo3Ab2A7WkufwLv1Bix9maWpTq4trRLdxNHX7wfoVl5iFNVrc5UPDoyc/9
         HUgYtSRrY/c6kOYyYzRtLWo3ae8y+Bt1vTqH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oXPdZEy4xFOhSOsI17BblXcBjtO3nXX/wiLLyJDlRR8=;
        b=UKlwShj4HceWojic9xcUjnl/s0IuVDrbGLK3tA0EBxeju0qHNmaloUmnJ2lAtCL/b4
         B+4r+aB/RIY3om8Dsk72H+Bx+aOPO64FObZ20DdD4HueHqpgWFxBFRpiRHNwwV8PZl/j
         BBVJztGNJmAhcdJVZTmPU5pI65k9yQLPNvF/G7prHtHyart3I5ONj2Ju1Vzcnk1vqpuM
         QTHatIOE60bv1hiS7CBVNoQevTalwDFCSdXbgce9pgyTnQT85wApZ9zHg5bpmYqf1ufB
         vCiDxzkZ74TZuNsiXIecNEtjbnAo5jATkno4d4GNvMeJUN2+sikr9RhJ8V1D/FoARDfP
         AgvQ==
X-Gm-Message-State: AOAM531e5C3oOVF5vOkdbbsj8jsIc/2EVZLzn5Nqcq2Qy++zavA5BGvl
        uVt6MhLqVW/6naI0/A651eWw3tYDFE64NlZvhgAhttjT7Xy19QAyjPwIbTna7RXnQtFbYI8omfx
        bSBQj0nxhwM7xNwMR6zH7owa+qiQsuKZQsCzkQGjmep/nT0hM/YjJGUZdUIVWh/byFfpQd1b+PT
        2yzPs=
X-Google-Smtp-Source: ABdhPJwK1RpggusIOfsT5LnXRY1bggEKWO1pyRJUrKEESwdxTd9ujozKh3iD1F22Q35UG07PhEGkOQ==
X-Received: by 2002:a63:be47:: with SMTP id g7mr8251816pgo.7.1594822634864;
        Wed, 15 Jul 2020 07:17:14 -0700 (PDT)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k92sm2399254pje.30.2020.07.15.07.17.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 07:17:14 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     devesh.sharma@broadcom.com, leon@kernel.org
Subject: [PATCH V2 for-next 2/6] RDMA/bnxt_re: introduce a function to allocate swq
Date:   Wed, 15 Jul 2020 10:16:55 -0400
Message-Id: <1594822619-4098-3-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1594822619-4098-1-git-send-email-devesh.sharma@broadcom.com>
References: <1594822619-4098-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The bnxt_re driver now  allocates shadow sq and rq to
maintain per wqe wr_id and few other flags required to
support variable wqe. Segregated the allocation of shadow
queue in a separate function and adjust the cqe polling
logic. The new polling logic is based on shadow queue
indices.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 348 +++++++++++++++---------------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  19 ++
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  11 +
 3 files changed, 207 insertions(+), 171 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index c5e2957..c9e7be3 100644
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
@@ -199,10 +199,9 @@ static int bnxt_qplib_alloc_qp_hdr_buf(struct bnxt_qplib_res *res,
 	struct bnxt_qplib_q *sq = &qp->sq;
 	int rc = 0;
 
-	if (qp->sq_hdr_buf_size && sq->hwq.max_elements) {
+	if (qp->sq_hdr_buf_size && sq->max_wqe) {
 		qp->sq_hdr_buf = dma_alloc_coherent(&res->pdev->dev,
-					sq->hwq.max_elements *
-					qp->sq_hdr_buf_size,
+					sq->max_wqe * qp->sq_hdr_buf_size,
 					&qp->sq_hdr_buf_map, GFP_KERNEL);
 		if (!qp->sq_hdr_buf) {
 			rc = -ENOMEM;
@@ -212,9 +211,9 @@ static int bnxt_qplib_alloc_qp_hdr_buf(struct bnxt_qplib_res *res,
 		}
 	}
 
-	if (qp->rq_hdr_buf_size && rq->hwq.max_elements) {
+	if (qp->rq_hdr_buf_size && rq->max_wqe) {
 		qp->rq_hdr_buf = dma_alloc_coherent(&res->pdev->dev,
-						    rq->hwq.max_elements *
+						    rq->max_wqe *
 						    qp->rq_hdr_buf_size,
 						    &qp->rq_hdr_buf_map,
 						    GFP_KERNEL);
@@ -784,6 +783,30 @@ int bnxt_qplib_post_srq_recv(struct bnxt_qplib_srq *srq,
 }
 
 /* QP */
+
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
+	for (indx = 0; indx < que->max_wqe; indx++) {
+		que->swq[indx].slots = 1;
+		que->swq[indx].next_idx = indx + 1;
+	}
+	que->swq[que->swq_last].next_idx = 0; /* Make it circular */
+	que->swq_last = 0;
+out:
+	return rc;
+}
+
 int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 {
 	struct bnxt_qplib_hwq_attr hwq_attr = {};
@@ -815,20 +838,22 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	if (rc)
 		goto exit;
 
-	sq->swq = kcalloc(sq->hwq.max_elements, sizeof(*sq->swq), GFP_KERNEL);
-	if (!sq->swq) {
-		rc = -ENOMEM;
+	rc = bnxt_qplib_alloc_init_swq(sq);
+	if (rc)
 		goto fail_sq;
-	}
+
+	req.sq_size = cpu_to_le32(sq->max_wqe);
 	pbl = &sq->hwq.pbl[PBL_LVL_0];
 	req.sq_pbl = cpu_to_le64(pbl->pg_map_arr[0]);
 	pg_sz_lvl = (bnxt_qplib_base_pg_size(&sq->hwq) <<
 		     CMDQ_CREATE_QP1_SQ_PG_SIZE_SFT);
 	pg_sz_lvl |= (sq->hwq.level & CMDQ_CREATE_QP1_SQ_LVL_MASK);
 	req.sq_pg_size_sq_lvl = pg_sz_lvl;
+	req.sq_fwo_sq_sge =
+		cpu_to_le16((sq->max_sge & CMDQ_CREATE_QP1_SQ_SGE_MASK) <<
+			     CMDQ_CREATE_QP1_SQ_SGE_SFT);
+	req.scq_cid = cpu_to_le32(qp->scq->id);
 
-	if (qp->scq)
-		req.scq_cid = cpu_to_le32(qp->scq->id);
 	/* RQ */
 	if (rq->max_wqe) {
 		hwq_attr.res = res;
@@ -838,41 +863,31 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
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
 	/* Header buffer - allow hdr_buf pass in */
 	rc = bnxt_qplib_alloc_qp_hdr_buf(res, qp);
 	if (rc) {
 		rc = -ENOMEM;
-		goto fail;
+		goto rq_rwq;
 	}
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
@@ -898,12 +913,14 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 
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
@@ -944,12 +961,12 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
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
 
@@ -976,27 +993,27 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	if (rc)
 		goto exit;
 
-	sq->swq = kcalloc(sq->hwq.max_elements, sizeof(*sq->swq), GFP_KERNEL);
-	if (!sq->swq) {
-		rc = -ENOMEM;
+	rc = bnxt_qplib_alloc_init_swq(sq);
+	if (rc)
 		goto fail_sq;
-	}
 
 	if (psn_sz)
 		bnxt_qplib_init_psn_ptr(qp, psn_sz);
 
+	req.sq_size = cpu_to_le32(sq->max_wqe);
 	pbl = &sq->hwq.pbl[PBL_LVL_0];
 	req.sq_pbl = cpu_to_le64(pbl->pg_map_arr[0]);
 	pg_sz_lvl = (bnxt_qplib_base_pg_size(&sq->hwq) <<
 		     CMDQ_CREATE_QP_SQ_PG_SIZE_SFT);
 	pg_sz_lvl |= (sq->hwq.level & CMDQ_CREATE_QP_SQ_LVL_MASK);
 	req.sq_pg_size_sq_lvl = pg_sz_lvl;
-
-	if (qp->scq)
-		req.scq_cid = cpu_to_le32(qp->scq->id);
+	req.sq_fwo_sq_sge =
+		cpu_to_le16(((sq->max_sge & CMDQ_CREATE_QP_SQ_SGE_MASK) <<
+			     CMDQ_CREATE_QP_SQ_SGE_SFT) | 0);
+	req.scq_cid = cpu_to_le32(qp->scq->id);
 
 	/* RQ */
-	if (rq->max_wqe) {
+	if (!qp->srq) {
 		hwq_attr.res = res;
 		hwq_attr.sginfo = &rq->sg_info;
 		hwq_attr.stride = rq->wqe_size;
@@ -1006,30 +1023,30 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
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
+
+		req.rq_size = cpu_to_le32(rq->max_wqe);
 		pbl = &rq->hwq.pbl[PBL_LVL_0];
 		req.rq_pbl = cpu_to_le64(pbl->pg_map_arr[0]);
 		pg_sz_lvl = (bnxt_qplib_base_pg_size(&rq->hwq) <<
 			     CMDQ_CREATE_QP_RQ_PG_SIZE_SFT);
 		pg_sz_lvl |= (rq->hwq.level & CMDQ_CREATE_QP_RQ_LVL_MASK);
 		req.rq_pg_size_rq_lvl = pg_sz_lvl;
+		nsge = (qp->wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC) ?
+			6 : rq->max_sge;
+		req.rq_fwo_rq_sge =
+			cpu_to_le16(((nsge &
+				      CMDQ_CREATE_QP_RQ_SGE_MASK) <<
+				     CMDQ_CREATE_QP_RQ_SGE_SFT) | 0);
 	} else {
 		/* SRQ */
-		if (qp->srq) {
-			qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_SRQ_USED;
-			req.srq_cid = cpu_to_le32(qp->srq->id);
-		}
+		qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_SRQ_USED;
+		req.srq_cid = cpu_to_le32(qp->srq->id);
 	}
-
-	if (qp->rcq)
-		req.rcq_cid = cpu_to_le32(qp->rcq->id);
+	req.rcq_cid = cpu_to_le32(qp->rcq->id);
 
 	qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_RESERVED_LKEY_ENABLE;
 	qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_FR_PMR_ENABLED;
@@ -1037,27 +1054,6 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 		qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_FORCE_COMPLETION;
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
@@ -1078,7 +1074,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 		hwq_attr.type = HWQ_TYPE_CTX;
 		rc = bnxt_qplib_alloc_init_hwq(xrrq, &hwq_attr);
 		if (rc)
-			goto fail_buf_free;
+			goto rq_swq;
 		pbl = &xrrq->pbl[PBL_LVL_0];
 		req.orrq_addr = cpu_to_le64(pbl->pg_map_arr[0]);
 
@@ -1122,21 +1118,18 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	rcfw->qp_tbl[qp->id].qp_handle = (void *)qp;
 
 	return 0;
-
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
@@ -1512,7 +1505,7 @@ void *bnxt_qplib_get_qp1_sq_buf(struct bnxt_qplib_qp *qp,
 	memset(sge, 0, sizeof(*sge));
 
 	if (qp->sq_hdr_buf) {
-		sw_prod = HWQ_CMP(sq->hwq.prod, &sq->hwq);
+		sw_prod = sq->swq_start;
 		sge->addr = (dma_addr_t)(qp->sq_hdr_buf_map +
 					 sw_prod * qp->sq_hdr_buf_size);
 		sge->lkey = 0xFFFFFFFF;
@@ -1526,7 +1519,7 @@ u32 bnxt_qplib_get_rq_prod_index(struct bnxt_qplib_qp *qp)
 {
 	struct bnxt_qplib_q *rq = &qp->rq;
 
-	return HWQ_CMP(rq->hwq.prod, &rq->hwq);
+	return rq->swq_start;
 }
 
 dma_addr_t bnxt_qplib_get_qp_buf_from_index(struct bnxt_qplib_qp *qp, u32 index)
@@ -1543,7 +1536,7 @@ void *bnxt_qplib_get_qp1_rq_buf(struct bnxt_qplib_qp *qp,
 	memset(sge, 0, sizeof(*sge));
 
 	if (qp->rq_hdr_buf) {
-		sw_prod = HWQ_CMP(rq->hwq.prod, &rq->hwq);
+		sw_prod = rq->swq_start;
 		sge->addr = (dma_addr_t)(qp->rq_hdr_buf_map +
 					 sw_prod * qp->rq_hdr_buf_size);
 		sge->lkey = 0xFFFFFFFF;
@@ -1620,8 +1613,8 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 		rc = -ENOMEM;
 		goto done;
 	}
-	sw_prod = HWQ_CMP(sq->hwq.prod, &sq->hwq);
-	swq = &sq->swq[sw_prod];
+	sw_prod = sq->hwq.prod;
+	swq = bnxt_qplib_get_swqe(sq, NULL);
 	swq->wr_id = wqe->wr_id;
 	swq->type = wqe->type;
 	swq->flags = wqe->flags;
@@ -1831,7 +1824,8 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 			swq->flags |= SQ_SEND_FLAGS_SIGNAL_COMP;
 		swq->start_psn = sq->psn & BTH_PSN_MASK;
 	}
-	sq->hwq.prod++;
+	bnxt_qplib_swq_mod_start(sq, sw_prod);
+	bnxt_qplib_hwq_incr_prod(&sq->hwq, 1);
 	qp->wqe_cnt++;
 
 done:
@@ -1863,6 +1857,7 @@ int bnxt_qplib_post_recv(struct bnxt_qplib_qp *qp,
 {
 	struct bnxt_qplib_nq_work *nq_work = NULL;
 	struct bnxt_qplib_q *rq = &qp->rq;
+	struct bnxt_qplib_swq *swq;
 	bool sch_handler = false;
 	struct sq_sge *hw_sge;
 	struct rq_wqe *rqe;
@@ -1881,8 +1876,9 @@ int bnxt_qplib_post_recv(struct bnxt_qplib_qp *qp,
 		rc = -EINVAL;
 		goto done;
 	}
-	sw_prod = HWQ_CMP(rq->hwq.prod, &rq->hwq);
-	rq->swq[sw_prod].wr_id = wqe->wr_id;
+	sw_prod = rq->hwq.prod;
+	swq = bnxt_qplib_get_swqe(rq, NULL);
+	swq->wr_id = wqe->wr_id;
 
 	rqe = bnxt_qplib_get_qe(&rq->hwq, sw_prod, NULL);
 	memset(rqe, 0, rq->wqe_size);
@@ -1911,10 +1907,12 @@ int bnxt_qplib_post_recv(struct bnxt_qplib_qp *qp,
 	if (sch_handler) {
 		/* Store the ULP info in the software structures */
 		sw_prod = HWQ_CMP(rq->hwq.prod, &rq->hwq);
-		rq->swq[sw_prod].wr_id = wqe->wr_id;
+		swq = bnxt_qplib_get_swqe(rq, NULL);
+		swq->wr_id = wqe->wr_id;
 	}
 
-	rq->hwq.prod++;
+	bnxt_qplib_swq_mod_start(rq, sw_prod);
+	bnxt_qplib_hwq_incr_prod(&rq->hwq, 1);
 	if (sch_handler) {
 		nq_work = kzalloc(sizeof(*nq_work), GFP_ATOMIC);
 		if (nq_work) {
@@ -2026,20 +2024,19 @@ int bnxt_qplib_destroy_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
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
@@ -2047,16 +2044,17 @@ static int __flush_sq(struct bnxt_qplib_q *sq, struct bnxt_qplib_qp *qp,
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
 
@@ -2067,9 +2065,9 @@ static int __flush_rq(struct bnxt_qplib_q *rq, struct bnxt_qplib_qp *qp,
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
@@ -2085,24 +2083,25 @@ static int __flush_rq(struct bnxt_qplib_q *rq, struct bnxt_qplib_qp *qp,
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
 
@@ -2125,7 +2124,7 @@ void bnxt_qplib_mark_qp_error(void *qp_handle)
  *       CQE is track from sw_cq_cons to max_element but valid only if VALID=1
  */
 static int do_wa9060(struct bnxt_qplib_qp *qp, struct bnxt_qplib_cq *cq,
-		     u32 cq_cons, u32 sw_sq_cons, u32 cqe_sq_cons)
+		     u32 cq_cons, u32 swq_last, u32 cqe_sq_cons)
 {
 	u32 peek_sw_cq_cons, peek_raw_cq_cons, peek_sq_cons_idx;
 	struct bnxt_qplib_q *sq = &qp->sq;
@@ -2138,7 +2137,7 @@ static int do_wa9060(struct bnxt_qplib_qp *qp, struct bnxt_qplib_cq *cq,
 
 	/* Normal mode */
 	/* Check for the psn_search marking before completing */
-	swq = &sq->swq[sw_sq_cons];
+	swq = &sq->swq[swq_last];
 	if (swq->psn_search &&
 	    le32_to_cpu(swq->psn_search->flags_next_psn) & 0x80000000) {
 		/* Unmark */
@@ -2147,7 +2146,7 @@ static int do_wa9060(struct bnxt_qplib_qp *qp, struct bnxt_qplib_cq *cq,
 				     & ~0x80000000);
 		dev_dbg(&cq->hwq.pdev->dev,
 			"FP: Process Req cq_cons=0x%x qp=0x%x sq cons sw=0x%x cqe=0x%x marked!\n",
-			cq_cons, qp->id, sw_sq_cons, cqe_sq_cons);
+			cq_cons, qp->id, swq_last, cqe_sq_cons);
 		sq->condition = true;
 		sq->send_phantom = true;
 
@@ -2184,9 +2183,10 @@ static int do_wa9060(struct bnxt_qplib_qp *qp, struct bnxt_qplib_cq *cq,
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
@@ -2214,7 +2214,7 @@ static int do_wa9060(struct bnxt_qplib_qp *qp, struct bnxt_qplib_cq *cq,
 		}
 		dev_err(&cq->hwq.pdev->dev,
 			"Should not have come here! cq_cons=0x%x qp=0x%x sq cons sw=0x%x hw=0x%x\n",
-			cq_cons, qp->id, sw_sq_cons, cqe_sq_cons);
+			cq_cons, qp->id, swq_last, cqe_sq_cons);
 		rc = -EINVAL;
 	}
 out:
@@ -2226,11 +2226,11 @@ static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
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
@@ -2242,14 +2242,7 @@ static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
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
@@ -2261,12 +2254,11 @@ static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
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
@@ -2280,12 +2272,12 @@ static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
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
@@ -2293,7 +2285,7 @@ static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
 			bnxt_qplib_add_flush_qp(qp);
 		} else {
 			/* Before we complete, do WA 9060 */
-			if (do_wa9060(qp, cq, cq_cons, sw_sq_cons,
+			if (do_wa9060(qp, cq, cq_cons, sq->swq_last,
 				      cqe_sq_cons)) {
 				*lib_qp = qp;
 				goto out;
@@ -2305,13 +2297,14 @@ static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
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
@@ -2386,17 +2379,23 @@ static int bnxt_qplib_cq_process_res_rc(struct bnxt_qplib_cq *cq,
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
@@ -2467,18 +2466,24 @@ static int bnxt_qplib_cq_process_res_ud(struct bnxt_qplib_cq *cq,
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
@@ -2569,17 +2574,23 @@ static int bnxt_qplib_cq_process_res_raweth_qp1(struct bnxt_qplib_cq *cq,
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
@@ -2601,7 +2612,7 @@ static int bnxt_qplib_cq_process_terminal(struct bnxt_qplib_cq *cq,
 	struct bnxt_qplib_qp *qp;
 	struct bnxt_qplib_q *sq, *rq;
 	struct bnxt_qplib_cqe *cqe;
-	u32 sw_cons = 0, cqe_cons;
+	u32 swq_last = 0, cqe_cons;
 	int rc = 0;
 
 	/* Check the Status */
@@ -2627,13 +2638,7 @@ static int bnxt_qplib_cq_process_terminal(struct bnxt_qplib_cq *cq,
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
@@ -2647,24 +2652,25 @@ static int bnxt_qplib_cq_process_terminal(struct bnxt_qplib_cq *cq,
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
@@ -2676,10 +2682,10 @@ static int bnxt_qplib_cq_process_terminal(struct bnxt_qplib_cq *cq,
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
index 6146f7d..50e4f79 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -74,6 +74,7 @@ struct bnxt_qplib_swq {
 	u8				flags;
 	u32				start_psn;
 	u32				next_psn;
+	u8				slots;
 	struct sq_psn_search		*psn_search;
 	struct sq_psn_search_ext	*psn_ext;
 };
@@ -213,6 +214,8 @@ struct bnxt_qplib_q {
 	u32				phantom_cqe_cnt;
 	u32				next_cq_cons;
 	bool				flushed;
+	u32				swq_start;
+	u32				swq_last;
 };
 
 struct bnxt_qplib_qp {
@@ -490,4 +493,20 @@ int bnxt_qplib_process_flush_list(struct bnxt_qplib_cq *cq,
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
 #endif /* __BNXT_QPLIB_FP_H__ */
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 03a0f29..98df68a 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -363,6 +363,17 @@ int bnxt_qplib_alloc_ctx(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_ctx *ctx,
 			 bool virt_fn, bool is_p5);
 
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
 static inline void bnxt_qplib_ring_db32(struct bnxt_qplib_db_info *info,
 					bool arm)
 {
-- 
1.8.3.1

