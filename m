Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51542147857
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jan 2020 06:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbgAXFxL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jan 2020 00:53:11 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35045 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgAXFxL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jan 2020 00:53:11 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so334458plt.2
        for <linux-rdma@vger.kernel.org>; Thu, 23 Jan 2020 21:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WVCFFjdIHoP5igSobMduMVdQNo7+xXCrnj5Q/DyivqQ=;
        b=a5ayJrev8msCJiNOlesr+usco0PsnQo4z+X1ctHv7GHLrVvj6PITzo9KAUu32bcWAE
         LNR54qhyYqTTeZOgtO7Mxdsm8cqcij44Zmw2mXUlev64v5pcFAJ2XfTl73VL6IwGKGTo
         Xp0GbbWI6IJvwK1rjl2zqu2Q4ZVGFhBKf5YcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WVCFFjdIHoP5igSobMduMVdQNo7+xXCrnj5Q/DyivqQ=;
        b=EsFCpfl16TB7bYVLJrWFic6/rasG+6FI9gzcgutAaCpoXFRhwNztJcfUMVQW7XkJFd
         5i8MIp/gPqtBO2ZOgPfhIW91Bqlg3DvvNWsa8I4xEy0Zr7p+F7DASxl2aHshfg2gCebq
         IU95yqDMbxlNbPJUxjfrVZ/nqxw6An73wTO2caRXBoS36Nebfpyx+1cvbhc1eWaTGbtq
         qo8u/vOTRNCaPSg32j/rLN+Asn6tnXiULqK9hVFzTMMuYtArjyZ4l05XchjnjzhS8/o1
         etJDD8N/+XmVcAe/1KfTupQKbMFg7BOwvtVszVN++EN0PRJMwgfYQJ4qOErE8JZE1yLQ
         uQFg==
X-Gm-Message-State: APjAAAW9wQoFv+XmjDhrLiRLs5cO/JnBJwcglhUCqJZkTdtNX83ZdyKv
        joaIhg34ty9/Zl239Oqc1VlnrlMsxd2ONKGwmdxC16kK+s/49x9jvVvjfUG3VWoJE64+bYC+Ype
        73CzGu8qEw+t6fFMW+6XJWdYpMcvFz0HQ/9uHCJOcs6/dnss5uSqbZwibD2bp0ZqZnZ0sZ5E2Ms
        dKi9c0Dw==
X-Google-Smtp-Source: APXvYqzU509468BLwXoF9TrbLeNCzR4/UqgpFxq8SqmppWC2Lkm6iEYVSUroQnEXOVMybcJLBzkoDw==
X-Received: by 2002:a17:902:348:: with SMTP id 66mr1892260pld.137.1579845190271;
        Thu, 23 Jan 2020 21:53:10 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r20sm4781024pgu.89.2020.01.23.21.53.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jan 2020 21:53:09 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, dledford@redhat.com
Subject: [PATCH for-next 7/7] RDMA/bnxt_re: Refactor doorbell management functions
Date:   Fri, 24 Jan 2020 00:52:45 -0500
Message-Id: <1579845165-18002-8-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Moving all the fast path doorbell functions at one place
under qplib_res.h. To pass doorbell record information
a new structure bnxt_qplib_db_info has been introduced.
Every roce object holds an instance of this structure and
doorbell information is initialized during resource creation.

When DB is rung only the current queue index is read from
hardware ring and rest of the data is taken from pre-initialized
dbinfo structure.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 142 ++++++++++-------------------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h   |  44 +--------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  21 ++---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |   2 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h  |  78 ++++++++++++++++
 5 files changed, 141 insertions(+), 146 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 549ab43..83e566c 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -53,9 +53,7 @@
 #include "qplib_sp.h"
 #include "qplib_fp.h"
 
-static void bnxt_qplib_arm_cq_enable(struct bnxt_qplib_cq *cq);
 static void __clean_cq(struct bnxt_qplib_cq *cq, u64 qp);
-static void bnxt_qplib_arm_srq(struct bnxt_qplib_srq *srq, u32 arm_type);
 
 static void bnxt_qplib_cancel_phantom_processing(struct bnxt_qplib_qp *qp)
 {
@@ -236,7 +234,6 @@ static int bnxt_qplib_alloc_qp_hdr_buf(struct bnxt_qplib_res *res,
 static void bnxt_qplib_service_nq(unsigned long data)
 {
 	struct bnxt_qplib_nq *nq = (struct bnxt_qplib_nq *)data;
-	bool gen_p5 = bnxt_qplib_is_chip_gen_p5(nq->res->cctx);
 	struct bnxt_qplib_hwq *hwq = &nq->hwq;
 	struct nq_base *nqe, **nq_ptr;
 	struct bnxt_qplib_cq *cq;
@@ -272,7 +269,8 @@ static void bnxt_qplib_service_nq(unsigned long data)
 			q_handle |= (u64)le32_to_cpu(nqcne->cq_handle_high)
 						     << 32;
 			cq = (struct bnxt_qplib_cq *)(unsigned long)q_handle;
-			bnxt_qplib_arm_cq_enable(cq);
+			bnxt_qplib_armen_db(&cq->dbinfo,
+					    DBC_DBC_TYPE_CQ_ARMENA);
 			spin_lock_bh(&cq->compl_lock);
 			atomic_set(&cq->arm_state, 0);
 			if (!nq->cqn_handler(nq, (cq)))
@@ -285,14 +283,16 @@ static void bnxt_qplib_service_nq(unsigned long data)
 		}
 		case NQ_BASE_TYPE_SRQ_EVENT:
 		{
+			struct bnxt_qplib_srq *srq;
 			struct nq_srq_event *nqsrqe =
 						(struct nq_srq_event *)nqe;
 
 			q_handle = le32_to_cpu(nqsrqe->srq_handle_low);
 			q_handle |= (u64)le32_to_cpu(nqsrqe->srq_handle_high)
 				     << 32;
-			bnxt_qplib_arm_srq((struct bnxt_qplib_srq *)q_handle,
-					   DBC_DBC_TYPE_SRQ_ARMENA);
+			srq = (struct bnxt_qplib_srq *)q_handle;
+			bnxt_qplib_armen_db(&srq->dbinfo,
+					    DBC_DBC_TYPE_SRQ_ARMENA);
 			if (!nq->srqn_handler(nq,
 					      (struct bnxt_qplib_srq *)q_handle,
 					      nqsrqe->event))
@@ -314,9 +314,7 @@ static void bnxt_qplib_service_nq(unsigned long data)
 	}
 	if (hwq->cons != raw_cons) {
 		hwq->cons = raw_cons;
-		bnxt_qplib_ring_nq_db_rearm(nq->nq_db.db, hwq->cons,
-					    hwq->max_elements, nq->ring_id,
-					    gen_p5);
+		bnxt_qplib_ring_nq_db(&nq->nq_db.dbinfo, nq->res->cctx, true);
 	}
 }
 
@@ -340,11 +338,9 @@ static irqreturn_t bnxt_qplib_nq_irq(int irq, void *dev_instance)
 
 void bnxt_qplib_nq_stop_irq(struct bnxt_qplib_nq *nq, bool kill)
 {
-	bool gen_p5 = bnxt_qplib_is_chip_gen_p5(nq->res->cctx);
 	tasklet_disable(&nq->nq_tasklet);
 	/* Mask h/w interrupt */
-	bnxt_qplib_ring_nq_db(nq->nq_db.db, nq->hwq.cons,
-			      nq->hwq.max_elements, nq->ring_id, gen_p5);
+	bnxt_qplib_ring_nq_db(&nq->nq_db.dbinfo, nq->res->cctx, false);
 	/* Sync with last running IRQ handler */
 	synchronize_irq(nq->msix_vec);
 	if (kill)
@@ -380,7 +376,6 @@ void bnxt_qplib_disable_nq(struct bnxt_qplib_nq *nq)
 int bnxt_qplib_nq_start_irq(struct bnxt_qplib_nq *nq, int nq_indx,
 			    int msix_vector, bool need_init)
 {
-	bool gen_p5 = bnxt_qplib_is_chip_gen_p5(nq->res->cctx);
 	int rc;
 
 	if (nq->requested)
@@ -407,8 +402,7 @@ int bnxt_qplib_nq_start_irq(struct bnxt_qplib_nq *nq, int nq_indx,
 			 nq->msix_vec, nq_indx);
 	}
 	nq->requested = true;
-	bnxt_qplib_ring_nq_db_rearm(nq->nq_db.db, nq->hwq.cons,
-				    nq->hwq.max_elements, nq->ring_id, gen_p5);
+	bnxt_qplib_ring_nq_db(&nq->nq_db.dbinfo, nq->res->cctx, true);
 
 	return rc;
 }
@@ -442,7 +436,9 @@ static int bnxt_qplib_map_nq_db(struct bnxt_qplib_nq *nq,  u32 reg_offt)
 		goto fail;
 	}
 
-	nq_db->db = nq_db->reg.bar_reg;
+	nq_db->dbinfo.db = nq_db->reg.bar_reg;
+	nq_db->dbinfo.hwq = &nq->hwq;
+	nq_db->dbinfo.xid = nq->ring_id;
 fail:
 	return rc;
 }
@@ -517,24 +513,6 @@ int bnxt_qplib_alloc_nq(struct bnxt_qplib_res *res, struct bnxt_qplib_nq *nq)
 }
 
 /* SRQ */
-static void bnxt_qplib_arm_srq(struct bnxt_qplib_srq *srq, u32 arm_type)
-{
-	struct bnxt_qplib_hwq *srq_hwq = &srq->hwq;
-	void __iomem *db;
-	u32 sw_prod;
-	u64 val = 0;
-
-	/* Ring DB */
-	sw_prod = (arm_type == DBC_DBC_TYPE_SRQ_ARM) ?
-		   srq->threshold : HWQ_CMP(srq_hwq->prod, srq_hwq);
-	db = (arm_type == DBC_DBC_TYPE_SRQ_ARMENA) ? srq->dbr_base :
-						     srq->dpi->dbr;
-	val = ((srq->id << DBC_DBC_XID_SFT) & DBC_DBC_XID_MASK) | arm_type;
-	val <<= 32;
-	val |= (sw_prod << DBC_DBC_INDEX_SFT) & DBC_DBC_INDEX_MASK;
-	writeq(val, db);
-}
-
 void bnxt_qplib_destroy_srq(struct bnxt_qplib_res *res,
 			   struct bnxt_qplib_srq *srq)
 {
@@ -626,9 +604,12 @@ int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
 	srq->swq[srq->last_idx].next_idx = -1;
 
 	srq->id = le32_to_cpu(resp.xid);
-	srq->dbr_base = res->dpi_tbl.dbr_bar_reg_iomem;
+	srq->dbinfo.hwq = &srq->hwq;
+	srq->dbinfo.xid = srq->id;
+	srq->dbinfo.db = srq->dpi->dbr;
+	srq->dbinfo.priv_db = res->dpi_tbl.dbr_bar_reg_iomem;
 	if (srq->threshold)
-		bnxt_qplib_arm_srq(srq, DBC_DBC_TYPE_SRQ_ARMENA);
+		bnxt_qplib_armen_db(&srq->dbinfo, DBC_DBC_TYPE_SRQ_ARMENA);
 	srq->arm_req = false;
 
 	return 0;
@@ -652,7 +633,7 @@ int bnxt_qplib_modify_srq(struct bnxt_qplib_res *res,
 				    srq_hwq->max_elements - sw_cons + sw_prod;
 	if (count > srq->threshold) {
 		srq->arm_req = false;
-		bnxt_qplib_arm_srq(srq, DBC_DBC_TYPE_SRQ_ARM);
+		bnxt_qplib_srq_arm_db(&srq->dbinfo, srq->threshold);
 	} else {
 		/* Deferred arming */
 		srq->arm_req = true;
@@ -740,10 +721,10 @@ int bnxt_qplib_post_srq_recv(struct bnxt_qplib_srq *srq,
 				    srq_hwq->max_elements - sw_cons + sw_prod;
 	spin_unlock(&srq_hwq->lock);
 	/* Ring DB */
-	bnxt_qplib_arm_srq(srq, DBC_DBC_TYPE_SRQ);
+	bnxt_qplib_ring_prod_db(&srq->dbinfo, DBC_DBC_TYPE_SRQ);
 	if (srq->arm_req == true && count > srq->threshold) {
 		srq->arm_req = false;
-		bnxt_qplib_arm_srq(srq, DBC_DBC_TYPE_SRQ_ARM);
+		bnxt_qplib_srq_arm_db(&srq->dbinfo, srq->threshold);
 	}
 done:
 	return rc;
@@ -875,6 +856,15 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 
 	qp->id = le32_to_cpu(resp.xid);
 	qp->cur_qp_state = CMDQ_MODIFY_QP_NEW_STATE_RESET;
+	qp->cctx = res->cctx;
+	sq->dbinfo.hwq = &sq->hwq;
+	sq->dbinfo.xid = qp->id;
+	sq->dbinfo.db = qp->dpi->dbr;
+	if (rq->max_wqe) {
+		rq->dbinfo.hwq = &rq->hwq;
+		rq->dbinfo.xid = qp->id;
+		rq->dbinfo.db = qp->dpi->dbr;
+	}
 	rcfw->qp_tbl[qp->id].qp_id = qp->id;
 	rcfw->qp_tbl[qp->id].qp_handle = (void *)qp;
 
@@ -1114,9 +1104,17 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 
 	qp->id = le32_to_cpu(resp.xid);
 	qp->cur_qp_state = CMDQ_MODIFY_QP_NEW_STATE_RESET;
-	qp->cctx = res->cctx;
 	INIT_LIST_HEAD(&qp->sq_flush);
 	INIT_LIST_HEAD(&qp->rq_flush);
+	qp->cctx = res->cctx;
+	sq->dbinfo.hwq = &sq->hwq;
+	sq->dbinfo.xid = qp->id;
+	sq->dbinfo.db = qp->dpi->dbr;
+	if (rq->max_wqe) {
+		rq->dbinfo.hwq = &rq->hwq;
+		rq->dbinfo.xid = qp->id;
+		rq->dbinfo.db = qp->dpi->dbr;
+	}
 	rcfw->qp_tbl[qp->id].qp_id = qp->id;
 	rcfw->qp_tbl[qp->id].qp_handle = (void *)qp;
 
@@ -1556,16 +1554,8 @@ void *bnxt_qplib_get_qp1_rq_buf(struct bnxt_qplib_qp *qp,
 void bnxt_qplib_post_send_db(struct bnxt_qplib_qp *qp)
 {
 	struct bnxt_qplib_q *sq = &qp->sq;
-	u32 sw_prod;
-	u64 val = 0;
 
-	val = (((qp->id << DBC_DBC_XID_SFT) & DBC_DBC_XID_MASK) |
-	       DBC_DBC_TYPE_SQ);
-	val <<= 32;
-	sw_prod = HWQ_CMP(sq->hwq.prod, &sq->hwq);
-	val |= (sw_prod << DBC_DBC_INDEX_SFT) & DBC_DBC_INDEX_MASK;
-	/* Flush all the WQE writes to HW */
-	writeq(val, qp->dpi->dbr);
+	bnxt_qplib_ring_prod_db(&sq->dbinfo, DBC_DBC_TYPE_SQ);
 }
 
 int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
@@ -1857,16 +1847,8 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 void bnxt_qplib_post_recv_db(struct bnxt_qplib_qp *qp)
 {
 	struct bnxt_qplib_q *rq = &qp->rq;
-	u32 sw_prod;
-	u64 val = 0;
 
-	val = (((qp->id << DBC_DBC_XID_SFT) & DBC_DBC_XID_MASK) |
-	       DBC_DBC_TYPE_RQ);
-	val <<= 32;
-	sw_prod = HWQ_CMP(rq->hwq.prod, &rq->hwq);
-	val |= (sw_prod << DBC_DBC_INDEX_SFT) & DBC_DBC_INDEX_MASK;
-	/* Flush the writes to HW Rx WQE before the ringing Rx DB */
-	writeq(val, qp->dpi->dbr);
+	bnxt_qplib_ring_prod_db(&rq->dbinfo, DBC_DBC_TYPE_RQ);
 }
 
 int bnxt_qplib_post_recv(struct bnxt_qplib_qp *qp,
@@ -1946,34 +1928,6 @@ int bnxt_qplib_post_recv(struct bnxt_qplib_qp *qp,
 }
 
 /* CQ */
-
-/* Spinlock must be held */
-static void bnxt_qplib_arm_cq_enable(struct bnxt_qplib_cq *cq)
-{
-	u64 val = 0;
-
-	val = ((cq->id << DBC_DBC_XID_SFT) & DBC_DBC_XID_MASK) |
-	       DBC_DBC_TYPE_CQ_ARMENA;
-	val <<= 32;
-	/* Flush memory writes before enabling the CQ */
-	writeq(val, cq->dbr_base);
-}
-
-static void bnxt_qplib_arm_cq(struct bnxt_qplib_cq *cq, u32 arm_type)
-{
-	struct bnxt_qplib_hwq *cq_hwq = &cq->hwq;
-	u32 sw_cons;
-	u64 val = 0;
-
-	/* Ring DB */
-	val = ((cq->id << DBC_DBC_XID_SFT) & DBC_DBC_XID_MASK) | arm_type;
-	val <<= 32;
-	sw_cons = HWQ_CMP(cq_hwq->cons, cq_hwq);
-	val |= (sw_cons << DBC_DBC_INDEX_SFT) & DBC_DBC_INDEX_MASK;
-	/* flush memory writes before arming the CQ */
-	writeq(val, cq->dpi->dbr);
-}
-
 int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
@@ -2029,7 +1983,6 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 		goto fail;
 
 	cq->id = le32_to_cpu(resp.xid);
-	cq->dbr_base = res->dpi_tbl.dbr_bar_reg_iomem;
 	cq->period = BNXT_QPLIB_QUEUE_START_PERIOD;
 	init_waitqueue_head(&cq->waitq);
 	INIT_LIST_HEAD(&cq->sqf_head);
@@ -2037,7 +1990,13 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 	spin_lock_init(&cq->compl_lock);
 	spin_lock_init(&cq->flush_lock);
 
-	bnxt_qplib_arm_cq_enable(cq);
+	cq->dbinfo.hwq = &cq->hwq;
+	cq->dbinfo.xid = cq->id;
+	cq->dbinfo.db = cq->dpi->dbr;
+	cq->dbinfo.priv_db = res->dpi_tbl.dbr_bar_reg_iomem;
+
+	bnxt_qplib_armen_db(&cq->dbinfo, DBC_DBC_TYPE_CQ_ARMENA);
+
 	return 0;
 
 fail:
@@ -2194,8 +2153,7 @@ static int do_wa9060(struct bnxt_qplib_qp *qp, struct bnxt_qplib_cq *cq,
 		sq->send_phantom = true;
 
 		/* TODO: Only ARM if the previous SQE is ARMALL */
-		bnxt_qplib_arm_cq(cq, DBC_DBC_TYPE_CQ_ARMALL);
-
+		bnxt_qplib_ring_db(&cq->dbinfo, DBC_DBC_TYPE_CQ_ARMALL);
 		rc = -EAGAIN;
 		goto out;
 	}
@@ -2865,7 +2823,7 @@ int bnxt_qplib_poll_cq(struct bnxt_qplib_cq *cq, struct bnxt_qplib_cqe *cqe,
 	}
 	if (cq->hwq.cons != raw_cons) {
 		cq->hwq.cons = raw_cons;
-		bnxt_qplib_arm_cq(cq, DBC_DBC_TYPE_CQ);
+		bnxt_qplib_ring_db(&cq->dbinfo, DBC_DBC_TYPE_CQ);
 	}
 exit:
 	return num_cqes - budget;
@@ -2874,7 +2832,7 @@ int bnxt_qplib_poll_cq(struct bnxt_qplib_cq *cq, struct bnxt_qplib_cqe *cqe,
 void bnxt_qplib_req_notify_cq(struct bnxt_qplib_cq *cq, u32 arm_type)
 {
 	if (arm_type)
-		bnxt_qplib_arm_cq(cq, arm_type);
+		bnxt_qplib_ring_db(&cq->dbinfo, arm_type);
 	/* Using cq->arm_state variable to track whether to issue cq handler */
 	atomic_set(&cq->arm_state, 1);
 }
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 765e5d2..9e8d1c5 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -42,7 +42,7 @@
 struct bnxt_qplib_srq {
 	struct bnxt_qplib_pd		*pd;
 	struct bnxt_qplib_dpi		*dpi;
-	void __iomem			*dbr_base;
+	struct bnxt_qplib_db_info	dbinfo;
 	u64				srq_handle;
 	u32				id;
 	u32				max_wqe;
@@ -236,6 +236,7 @@ struct bnxt_qplib_swqe {
 struct bnxt_qplib_q {
 	struct bnxt_qplib_hwq		hwq;
 	struct bnxt_qplib_swq		*swq;
+	struct bnxt_qplib_db_info	dbinfo;
 	struct bnxt_qplib_sg_info	sg_info;
 	u32				max_wqe;
 	u16				q_full_delta;
@@ -370,7 +371,7 @@ struct bnxt_qplib_cqe {
 #define BNXT_QPLIB_QUEUE_START_PERIOD		0x01
 struct bnxt_qplib_cq {
 	struct bnxt_qplib_dpi		*dpi;
-	void __iomem			*dbr_base;
+	struct bnxt_qplib_db_info	dbinfo;
 	u32				max_wqe;
 	u32				id;
 	u16				count;
@@ -433,46 +434,9 @@ struct bnxt_qplib_cq {
 					 NQ_DB_IDX_VALID |	\
 					 NQ_DB_IRQ_DIS)
 
-static inline void bnxt_qplib_ring_nq_db64(void __iomem *db, u32 index,
-					   u32 xid, bool arm)
-{
-	u64 val;
-
-	val = xid & DBC_DBC_XID_MASK;
-	val |= DBC_DBC_PATH_ROCE;
-	val |= arm ? DBC_DBC_TYPE_NQ_ARM : DBC_DBC_TYPE_NQ;
-	val <<= 32;
-	val |= index & DBC_DBC_INDEX_MASK;
-	writeq(val, db);
-}
-
-static inline void bnxt_qplib_ring_nq_db_rearm(void __iomem *db, u32 raw_cons,
-					       u32 max_elements, u32 xid,
-					       bool gen_p5)
-{
-	u32 index = raw_cons & (max_elements - 1);
-
-	if (gen_p5)
-		bnxt_qplib_ring_nq_db64(db, index, xid, true);
-	else
-		writel(NQ_DB_CP_FLAGS_REARM | (index & DBC_DBC32_XID_MASK), db);
-}
-
-static inline void bnxt_qplib_ring_nq_db(void __iomem *db, u32 raw_cons,
-					 u32 max_elements, u32 xid,
-					 bool gen_p5)
-{
-	u32 index = raw_cons & (max_elements - 1);
-
-	if (gen_p5)
-		bnxt_qplib_ring_nq_db64(db, index, xid, false);
-	else
-		writel(NQ_DB_CP_FLAGS | (index & DBC_DBC32_XID_MASK), db);
-}
-
 struct bnxt_qplib_nq_db {
 	struct bnxt_qplib_reg_desc	reg;
-	void __iomem			*db;
+	struct bnxt_qplib_db_info	dbinfo;
 };
 
 typedef int (*cqn_handler_t)(struct bnxt_qplib_nq *nq,
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 8160404..5359933 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -379,7 +379,6 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 static void bnxt_qplib_service_creq(unsigned long data)
 {
 	struct bnxt_qplib_rcfw *rcfw = (struct bnxt_qplib_rcfw *)data;
-	bool gen_p5 = bnxt_qplib_is_chip_gen_p5(rcfw->res->cctx);
 	struct bnxt_qplib_creq_ctx *creq = &rcfw->creq;
 	u32 type, budget = CREQ_ENTRY_POLL_BUDGET;
 	struct bnxt_qplib_hwq *hwq = &creq->hwq;
@@ -429,9 +428,8 @@ static void bnxt_qplib_service_creq(unsigned long data)
 
 	if (hwq->cons != raw_cons) {
 		hwq->cons = raw_cons;
-		bnxt_qplib_ring_creq_db_rearm(creq->creq_db.db,
-					      raw_cons, hwq->max_elements,
-					      creq->ring_id, gen_p5);
+		bnxt_qplib_ring_nq_db(&creq->creq_db.dbinfo,
+				      rcfw->res->cctx, true);
 	}
 	spin_unlock_irqrestore(&hwq->lock, flags);
 }
@@ -662,15 +660,12 @@ int bnxt_qplib_alloc_rcfw_channel(struct bnxt_qplib_res *res,
 
 void bnxt_qplib_rcfw_stop_irq(struct bnxt_qplib_rcfw *rcfw, bool kill)
 {
-	bool gen_p5 = bnxt_qplib_is_chip_gen_p5(rcfw->res->cctx);
 	struct bnxt_qplib_creq_ctx *creq;
 
 	creq = &rcfw->creq;
 	tasklet_disable(&creq->creq_tasklet);
 	/* Mask h/w interrupts */
-	bnxt_qplib_ring_creq_db(creq->creq_db.db, creq->hwq.cons,
-				creq->hwq.max_elements, creq->ring_id,
-				gen_p5);
+	bnxt_qplib_ring_nq_db(&creq->creq_db.dbinfo, rcfw->res->cctx, false);
 	/* Sync with last running IRQ-handler */
 	synchronize_irq(creq->msix_vec);
 	if (kill)
@@ -710,7 +705,6 @@ void bnxt_qplib_disable_rcfw_channel(struct bnxt_qplib_rcfw *rcfw)
 int bnxt_qplib_rcfw_start_irq(struct bnxt_qplib_rcfw *rcfw, int msix_vector,
 			      bool need_init)
 {
-	bool gen_p5 = bnxt_qplib_is_chip_gen_p5(rcfw->res->cctx);
 	struct bnxt_qplib_creq_ctx *creq;
 	int rc;
 
@@ -730,9 +724,8 @@ int bnxt_qplib_rcfw_start_irq(struct bnxt_qplib_rcfw *rcfw, int msix_vector,
 	if (rc)
 		return rc;
 	creq->requested = true;
-	bnxt_qplib_ring_creq_db_rearm(creq->creq_db.db,
-				      creq->hwq.cons, creq->hwq.max_elements,
-				      creq->ring_id, gen_p5);
+
+	bnxt_qplib_ring_nq_db(&creq->creq_db.dbinfo, rcfw->res->cctx, true);
 
 	return 0;
 }
@@ -801,7 +794,9 @@ static int bnxt_qplib_map_creq_db(struct bnxt_qplib_rcfw *rcfw, u32 reg_offt)
 		return -ENOMEM;
 	}
 
-	creq_db->db = creq_db->reg.bar_reg;
+	creq_db->dbinfo.db = creq_db->reg.bar_reg;
+	creq_db->dbinfo.hwq = &rcfw->creq.hwq;
+	creq_db->dbinfo.xid = rcfw->creq.ring_id;
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 1aff6d4..411fce3 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -247,7 +247,7 @@ struct bnxt_qplib_cmdq_ctx {
 
 struct bnxt_qplib_creq_db {
 	struct bnxt_qplib_reg_desc	reg;
-	void __iomem			*db;
+	struct bnxt_qplib_db_info	dbinfo;
 };
 
 struct bnxt_qplib_creq_stat {
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 5fa278e..95b645d 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -133,6 +133,13 @@ struct bnxt_qplib_hwq {
 	u8				is_user;
 };
 
+struct bnxt_qplib_db_info {
+	void __iomem		*db;
+	void __iomem		*priv_db;
+	struct bnxt_qplib_hwq	*hwq;
+	u32			xid;
+};
+
 /* Tables */
 struct bnxt_qplib_pd_tbl {
 	unsigned long			*tbl;
@@ -290,4 +297,75 @@ void bnxt_qplib_free_ctx(struct bnxt_qplib_res *res,
 int bnxt_qplib_alloc_ctx(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_ctx *ctx,
 			 bool virt_fn, bool is_p5);
+
+static inline void bnxt_qplib_ring_db32(struct bnxt_qplib_db_info *info,
+					bool arm)
+{
+	u32 key;
+
+	key = info->hwq->cons & (info->hwq->max_elements - 1);
+	key |= (CMPL_DOORBELL_IDX_VALID |
+		(CMPL_DOORBELL_KEY_CMPL & CMPL_DOORBELL_KEY_MASK));
+	if (!arm)
+		key |= CMPL_DOORBELL_MASK;
+	writel(key, info->db);
+}
+
+static inline void bnxt_qplib_ring_db(struct bnxt_qplib_db_info *info,
+				      u32 type)
+{
+	u64 key = 0;
+
+	key = (info->xid & DBC_DBC_XID_MASK) | DBC_DBC_PATH_ROCE | type;
+	key <<= 32;
+	key |= (info->hwq->cons & (info->hwq->max_elements - 1)) &
+		DBC_DBC_INDEX_MASK;
+	writeq(key, info->db);
+}
+
+static inline void bnxt_qplib_ring_prod_db(struct bnxt_qplib_db_info *info,
+					   u32 type)
+{
+	u64 key = 0;
+
+	key = (info->xid & DBC_DBC_XID_MASK) | DBC_DBC_PATH_ROCE | type;
+	key <<= 32;
+	key |= (info->hwq->prod & (info->hwq->max_elements - 1)) &
+		DBC_DBC_INDEX_MASK;
+	writeq(key, info->db);
+}
+
+static inline void bnxt_qplib_armen_db(struct bnxt_qplib_db_info *info,
+				       u32 type)
+{
+	u64 key = 0;
+
+	key = (info->xid & DBC_DBC_XID_MASK) | DBC_DBC_PATH_ROCE | type;
+	key <<= 32;
+	writeq(key, info->priv_db);
+}
+
+static inline void bnxt_qplib_srq_arm_db(struct bnxt_qplib_db_info *info,
+					 u32 th)
+{
+	u64 key = 0;
+
+	key = (info->xid & DBC_DBC_XID_MASK) | DBC_DBC_PATH_ROCE | th;
+	key <<= 32;
+	key |=  th & DBC_DBC_INDEX_MASK;
+	writeq(key, info->priv_db);
+}
+
+static inline void bnxt_qplib_ring_nq_db(struct bnxt_qplib_db_info *info,
+					 struct bnxt_qplib_chip_ctx *cctx,
+					 bool arm)
+{
+	u32 type;
+
+	type = arm ? DBC_DBC_TYPE_NQ_ARM : DBC_DBC_TYPE_NQ;
+	if (bnxt_qplib_is_chip_gen_p5(cctx))
+		bnxt_qplib_ring_db(info, type);
+	else
+		bnxt_qplib_ring_db32(info, arm);
+}
 #endif /* __BNXT_QPLIB_RES_H__ */
-- 
1.8.3.1

