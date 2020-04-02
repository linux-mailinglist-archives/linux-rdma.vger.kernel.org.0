Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3C819C88F
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2020 20:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732625AbgDBSMe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Apr 2020 14:12:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54549 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgDBSMe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Apr 2020 14:12:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id c81so4432942wmd.4
        for <linux-rdma@vger.kernel.org>; Thu, 02 Apr 2020 11:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y3Jujr9E5NQsJZIT0ZPQHLlTCsMIDfem4P7KkCwKgUI=;
        b=aSGxGS+35wzpSGdpitWeZ6QpfnThWRdej9J6beXcNI91AEY3fUAuB3iB7+qqtSQPui
         olZsQokffDJWnO4SQUOOSEkCL1xWrQInaZUmsp/BlgdZiTIM+70BbAPYHqGCMjVzjO+r
         21E7LNgdhEsLF37+6k7PP+KfY2fm1jLhjeKCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y3Jujr9E5NQsJZIT0ZPQHLlTCsMIDfem4P7KkCwKgUI=;
        b=oRMxtJN309vUDoE+MM9drP7kllN1fUynC506epVkrCFIRDKBynzPfRUVshJmGx0+EH
         uVwjmYd3Zey7nAAQCrdTObL07weVc0NoOTyH/qRgoNG4WiloOS/FrzfKFPPLU/PiUWdG
         e/PSZbMs0PAZ1BmoigFUh92kzQqaUC8tcHgQLmXudkI4AlkhQc3YYDtAQofeiZLYqN52
         wCSAX0iCT7ArAm3gQXXmHwkyJAaNjLQH2/rkRnU9Ltv+ZbXQR0OzdYvr2x/g5FIuvcHY
         INcbQ4/W2/unrQs73oYhG0Xzg0kVF2Ef5IuPsykV5ASs9/i/lWMq+rjHs8WFFEQvWH0K
         0nEA==
X-Gm-Message-State: AGi0PuYAtn360QT4utVQ2NCOrY1dliO98vj4ruaSqDFYccJS18tCoLXR
        jMsYGtdpmc6qykcjccKX3h9EwvfAZQRGZF4ARf9WYw8PtxsXJ5zgXoKehVts/mOd5tykgJT3iwb
        r3tR8wMIbnoq3CmNSuWAEkAMHuwD0IUEVnQq2pyeRHGtXIrIVFNfyijNH+Yu0bVeknKFAHlXIGD
        w+6PA=
X-Google-Smtp-Source: APiQypIg8i4WmGEvOX5BtFyySBhDxaqUo3l0lRQFD1BrHnon/30VUVwlI91oPsBK/Zf1UVv3EezNxg==
X-Received: by 2002:a1c:2e0a:: with SMTP id u10mr4544936wmu.119.1585851150015;
        Thu, 02 Apr 2020 11:12:30 -0700 (PDT)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k3sm8399351wro.39.2020.04.02.11.12.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 11:12:29 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, dledford@redhat.com
Subject: [PATCH for-next 1/4] RDMA/bnxt_re: reduce device page size detection code
Date:   Thu,  2 Apr 2020 14:12:12 -0400
Message-Id: <1585851136-2316-2-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1585851136-2316-1-git-send-email-devesh.sharma@broadcom.com>
References: <1585851136-2316-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Getting rid of the repeated code in the driver when deciding
on the page size of the hardware ring memory. A new common
function would translate the ring page size into device specific
page size.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 138 ++++++++---------------------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  72 ++++++---------
 drivers/infiniband/hw/bnxt_re/qplib_res.h  |  40 +++++++++
 3 files changed, 103 insertions(+), 147 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 899a5d2..d3bf9f6 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -612,6 +612,7 @@ int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
 	struct cmdq_create_srq req;
 	struct bnxt_qplib_pbl *pbl;
 	u16 cmd_flags = 0;
+	u16 pg_sz_lvl;
 	int rc, idx;
 
 	hwq_attr.res = res;
@@ -638,22 +639,11 @@ int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
 
 	req.srq_size = cpu_to_le16((u16)srq->hwq.max_elements);
 	pbl = &srq->hwq.pbl[PBL_LVL_0];
-	req.pg_size_lvl = cpu_to_le16((((u16)srq->hwq.level &
-				      CMDQ_CREATE_SRQ_LVL_MASK) <<
-				      CMDQ_CREATE_SRQ_LVL_SFT) |
-				      (pbl->pg_size == ROCE_PG_SIZE_4K ?
-				       CMDQ_CREATE_SRQ_PG_SIZE_PG_4K :
-				       pbl->pg_size == ROCE_PG_SIZE_8K ?
-				       CMDQ_CREATE_SRQ_PG_SIZE_PG_8K :
-				       pbl->pg_size == ROCE_PG_SIZE_64K ?
-				       CMDQ_CREATE_SRQ_PG_SIZE_PG_64K :
-				       pbl->pg_size == ROCE_PG_SIZE_2M ?
-				       CMDQ_CREATE_SRQ_PG_SIZE_PG_2M :
-				       pbl->pg_size == ROCE_PG_SIZE_8M ?
-				       CMDQ_CREATE_SRQ_PG_SIZE_PG_8M :
-				       pbl->pg_size == ROCE_PG_SIZE_1G ?
-				       CMDQ_CREATE_SRQ_PG_SIZE_PG_1G :
-				       CMDQ_CREATE_SRQ_PG_SIZE_PG_4K));
+	pg_sz_lvl = ((u16)bnxt_qplib_base_pg_size(&srq->hwq) <<
+		     CMDQ_CREATE_SRQ_PG_SIZE_SFT);
+	pg_sz_lvl |= (srq->hwq.level & CMDQ_CREATE_SRQ_LVL_MASK) <<
+		      CMDQ_CREATE_SRQ_LVL_SFT;
+	req.pg_size_lvl = cpu_to_le16(pg_sz_lvl);
 	req.pbl = cpu_to_le64(pbl->pg_map_arr[0]);
 	req.pd_id = cpu_to_le32(srq->pd->id);
 	req.eventq_id = cpu_to_le16(srq->eventq_hw_ring_id);
@@ -809,6 +799,7 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	struct bnxt_qplib_pbl *pbl;
 	u16 cmd_flags = 0;
 	u32 qp_flags = 0;
+	u8 pg_sz_lvl;
 	int rc;
 
 	RCFW_CMD_PREP(req, CREATE_QP1, cmd_flags);
@@ -835,28 +826,13 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	}
 	pbl = &sq->hwq.pbl[PBL_LVL_0];
 	req.sq_pbl = cpu_to_le64(pbl->pg_map_arr[0]);
-	req.sq_pg_size_sq_lvl =
-		((sq->hwq.level & CMDQ_CREATE_QP1_SQ_LVL_MASK)
-				<<  CMDQ_CREATE_QP1_SQ_LVL_SFT) |
-		(pbl->pg_size == ROCE_PG_SIZE_4K ?
-				CMDQ_CREATE_QP1_SQ_PG_SIZE_PG_4K :
-		 pbl->pg_size == ROCE_PG_SIZE_8K ?
-				CMDQ_CREATE_QP1_SQ_PG_SIZE_PG_8K :
-		 pbl->pg_size == ROCE_PG_SIZE_64K ?
-				CMDQ_CREATE_QP1_SQ_PG_SIZE_PG_64K :
-		 pbl->pg_size == ROCE_PG_SIZE_2M ?
-				CMDQ_CREATE_QP1_SQ_PG_SIZE_PG_2M :
-		 pbl->pg_size == ROCE_PG_SIZE_8M ?
-				CMDQ_CREATE_QP1_SQ_PG_SIZE_PG_8M :
-		 pbl->pg_size == ROCE_PG_SIZE_1G ?
-				CMDQ_CREATE_QP1_SQ_PG_SIZE_PG_1G :
-		 CMDQ_CREATE_QP1_SQ_PG_SIZE_PG_4K);
+	pg_sz_lvl = (bnxt_qplib_base_pg_size(&sq->hwq) <<
+		     CMDQ_CREATE_QP1_SQ_PG_SIZE_SFT);
+	pg_sz_lvl |= (sq->hwq.level & CMDQ_CREATE_QP1_SQ_LVL_MASK);
+	req.sq_pg_size_sq_lvl = pg_sz_lvl;
 
 	if (qp->scq)
 		req.scq_cid = cpu_to_le32(qp->scq->id);
-
-	qp_flags |= CMDQ_CREATE_QP1_QP_FLAGS_RESERVED_LKEY_ENABLE;
-
 	/* RQ */
 	if (rq->max_wqe) {
 		hwq_attr.res = res;
@@ -876,32 +852,20 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 		}
 		pbl = &rq->hwq.pbl[PBL_LVL_0];
 		req.rq_pbl = cpu_to_le64(pbl->pg_map_arr[0]);
-		req.rq_pg_size_rq_lvl =
-			((rq->hwq.level & CMDQ_CREATE_QP1_RQ_LVL_MASK) <<
-			 CMDQ_CREATE_QP1_RQ_LVL_SFT) |
-				(pbl->pg_size == ROCE_PG_SIZE_4K ?
-					CMDQ_CREATE_QP1_RQ_PG_SIZE_PG_4K :
-				 pbl->pg_size == ROCE_PG_SIZE_8K ?
-					CMDQ_CREATE_QP1_RQ_PG_SIZE_PG_8K :
-				 pbl->pg_size == ROCE_PG_SIZE_64K ?
-					CMDQ_CREATE_QP1_RQ_PG_SIZE_PG_64K :
-				 pbl->pg_size == ROCE_PG_SIZE_2M ?
-					CMDQ_CREATE_QP1_RQ_PG_SIZE_PG_2M :
-				 pbl->pg_size == ROCE_PG_SIZE_8M ?
-					CMDQ_CREATE_QP1_RQ_PG_SIZE_PG_8M :
-				 pbl->pg_size == ROCE_PG_SIZE_1G ?
-					CMDQ_CREATE_QP1_RQ_PG_SIZE_PG_1G :
-				 CMDQ_CREATE_QP1_RQ_PG_SIZE_PG_4K);
+		pg_sz_lvl = (bnxt_qplib_base_pg_size(&rq->hwq) <<
+			     CMDQ_CREATE_QP1_RQ_PG_SIZE_SFT);
+		pg_sz_lvl |= (rq->hwq.level & CMDQ_CREATE_QP1_RQ_LVL_MASK);
+		req.rq_pg_size_rq_lvl = pg_sz_lvl;
 		if (qp->rcq)
 			req.rcq_cid = cpu_to_le32(qp->rcq->id);
 	}
-
 	/* Header buffer - allow hdr_buf pass in */
 	rc = bnxt_qplib_alloc_qp_hdr_buf(res, qp);
 	if (rc) {
 		rc = -ENOMEM;
 		goto fail;
 	}
+	qp_flags |= CMDQ_CREATE_QP1_QP_FLAGS_RESERVED_LKEY_ENABLE;
 	req.qp_flags = cpu_to_le32(qp_flags);
 	req.sq_size = cpu_to_le32(sq->hwq.max_elements);
 	req.rq_size = cpu_to_le32(rq->hwq.max_elements);
@@ -965,6 +929,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	struct cmdq_create_qp req;
 	struct bnxt_qplib_pbl *pbl;
 	u32 qp_flags = 0;
+	u8 pg_sz_lvl;
 	u16 max_rsge;
 
 	RCFW_CMD_PREP(req, CREATE_QP, cmd_flags);
@@ -1025,31 +990,14 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	}
 	pbl = &sq->hwq.pbl[PBL_LVL_0];
 	req.sq_pbl = cpu_to_le64(pbl->pg_map_arr[0]);
-	req.sq_pg_size_sq_lvl =
-		((sq->hwq.level & CMDQ_CREATE_QP_SQ_LVL_MASK)
-				 <<  CMDQ_CREATE_QP_SQ_LVL_SFT) |
-		(pbl->pg_size == ROCE_PG_SIZE_4K ?
-				CMDQ_CREATE_QP_SQ_PG_SIZE_PG_4K :
-		 pbl->pg_size == ROCE_PG_SIZE_8K ?
-				CMDQ_CREATE_QP_SQ_PG_SIZE_PG_8K :
-		 pbl->pg_size == ROCE_PG_SIZE_64K ?
-				CMDQ_CREATE_QP_SQ_PG_SIZE_PG_64K :
-		 pbl->pg_size == ROCE_PG_SIZE_2M ?
-				CMDQ_CREATE_QP_SQ_PG_SIZE_PG_2M :
-		 pbl->pg_size == ROCE_PG_SIZE_8M ?
-				CMDQ_CREATE_QP_SQ_PG_SIZE_PG_8M :
-		 pbl->pg_size == ROCE_PG_SIZE_1G ?
-				CMDQ_CREATE_QP_SQ_PG_SIZE_PG_1G :
-		 CMDQ_CREATE_QP_SQ_PG_SIZE_PG_4K);
+	pg_sz_lvl = (bnxt_qplib_base_pg_size(&sq->hwq) <<
+		     CMDQ_CREATE_QP_SQ_PG_SIZE_SFT);
+	pg_sz_lvl |= (sq->hwq.level & CMDQ_CREATE_QP_SQ_LVL_MASK);
+	req.sq_pg_size_sq_lvl = pg_sz_lvl;
 
 	if (qp->scq)
 		req.scq_cid = cpu_to_le32(qp->scq->id);
 
-	qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_RESERVED_LKEY_ENABLE;
-	qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_FR_PMR_ENABLED;
-	if (qp->sig_type)
-		qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_FORCE_COMPLETION;
-
 	/* RQ */
 	if (rq->max_wqe) {
 		hwq_attr.res = res;
@@ -1071,22 +1019,10 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 		}
 		pbl = &rq->hwq.pbl[PBL_LVL_0];
 		req.rq_pbl = cpu_to_le64(pbl->pg_map_arr[0]);
-		req.rq_pg_size_rq_lvl =
-			((rq->hwq.level & CMDQ_CREATE_QP_RQ_LVL_MASK) <<
-			 CMDQ_CREATE_QP_RQ_LVL_SFT) |
-				(pbl->pg_size == ROCE_PG_SIZE_4K ?
-					CMDQ_CREATE_QP_RQ_PG_SIZE_PG_4K :
-				 pbl->pg_size == ROCE_PG_SIZE_8K ?
-					CMDQ_CREATE_QP_RQ_PG_SIZE_PG_8K :
-				 pbl->pg_size == ROCE_PG_SIZE_64K ?
-					CMDQ_CREATE_QP_RQ_PG_SIZE_PG_64K :
-				 pbl->pg_size == ROCE_PG_SIZE_2M ?
-					CMDQ_CREATE_QP_RQ_PG_SIZE_PG_2M :
-				 pbl->pg_size == ROCE_PG_SIZE_8M ?
-					CMDQ_CREATE_QP_RQ_PG_SIZE_PG_8M :
-				 pbl->pg_size == ROCE_PG_SIZE_1G ?
-					CMDQ_CREATE_QP_RQ_PG_SIZE_PG_1G :
-				 CMDQ_CREATE_QP_RQ_PG_SIZE_PG_4K);
+		pg_sz_lvl = (bnxt_qplib_base_pg_size(&rq->hwq) <<
+			     CMDQ_CREATE_QP_RQ_PG_SIZE_SFT);
+		pg_sz_lvl |= (rq->hwq.level & CMDQ_CREATE_QP_RQ_LVL_MASK);
+		req.rq_pg_size_rq_lvl = pg_sz_lvl;
 	} else {
 		/* SRQ */
 		if (qp->srq) {
@@ -1097,7 +1033,13 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 
 	if (qp->rcq)
 		req.rcq_cid = cpu_to_le32(qp->rcq->id);
+
+	qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_RESERVED_LKEY_ENABLE;
+	qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_FR_PMR_ENABLED;
+	if (qp->sig_type)
+		qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_FORCE_COMPLETION;
 	req.qp_flags = cpu_to_le32(qp_flags);
+
 	req.sq_size = cpu_to_le32(sq->hwq.max_elements);
 	req.rq_size = cpu_to_le32(rq->hwq.max_elements);
 	qp->sq_hdr_buf = NULL;
@@ -2000,6 +1942,7 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 	struct cmdq_create_cq req;
 	struct bnxt_qplib_pbl *pbl;
 	u16 cmd_flags = 0;
+	u32 pg_sz_lvl;
 	int rc;
 
 	hwq_attr.res = res;
@@ -2020,22 +1963,13 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 	}
 	req.dpi = cpu_to_le32(cq->dpi->dpi);
 	req.cq_handle = cpu_to_le64(cq->cq_handle);
-
 	req.cq_size = cpu_to_le32(cq->hwq.max_elements);
 	pbl = &cq->hwq.pbl[PBL_LVL_0];
-	req.pg_size_lvl = cpu_to_le32(
-	    ((cq->hwq.level & CMDQ_CREATE_CQ_LVL_MASK) <<
-						CMDQ_CREATE_CQ_LVL_SFT) |
-	    (pbl->pg_size == ROCE_PG_SIZE_4K ? CMDQ_CREATE_CQ_PG_SIZE_PG_4K :
-	     pbl->pg_size == ROCE_PG_SIZE_8K ? CMDQ_CREATE_CQ_PG_SIZE_PG_8K :
-	     pbl->pg_size == ROCE_PG_SIZE_64K ? CMDQ_CREATE_CQ_PG_SIZE_PG_64K :
-	     pbl->pg_size == ROCE_PG_SIZE_2M ? CMDQ_CREATE_CQ_PG_SIZE_PG_2M :
-	     pbl->pg_size == ROCE_PG_SIZE_8M ? CMDQ_CREATE_CQ_PG_SIZE_PG_8M :
-	     pbl->pg_size == ROCE_PG_SIZE_1G ? CMDQ_CREATE_CQ_PG_SIZE_PG_1G :
-	     CMDQ_CREATE_CQ_PG_SIZE_PG_4K));
-
+	pg_sz_lvl = (bnxt_qplib_base_pg_size(&cq->hwq) <<
+		     CMDQ_CREATE_CQ_PG_SIZE_SFT);
+	pg_sz_lvl |= (cq->hwq.level & CMDQ_CREATE_CQ_LVL_MASK);
+	req.pg_size_lvl = cpu_to_le32(pg_sz_lvl);
 	req.pbl = cpu_to_le64(pbl->pg_map_arr[0]);
-
 	req.cq_fco_cnq_id = cpu_to_le32(
 			(cq->cnq_hw_ring_id & CMDQ_CREATE_CQ_CNQ_ID_MASK) <<
 			 CMDQ_CREATE_CQ_CNQ_ID_SFT);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index f01e864..fe5e06f 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -468,29 +468,13 @@ int bnxt_qplib_deinit_rcfw(struct bnxt_qplib_rcfw *rcfw)
 	return 0;
 }
 
-static int __get_pbl_pg_idx(struct bnxt_qplib_pbl *pbl)
-{
-	return (pbl->pg_size == ROCE_PG_SIZE_4K ?
-				      CMDQ_INITIALIZE_FW_QPC_PG_SIZE_PG_4K :
-		pbl->pg_size == ROCE_PG_SIZE_8K ?
-				      CMDQ_INITIALIZE_FW_QPC_PG_SIZE_PG_8K :
-		pbl->pg_size == ROCE_PG_SIZE_64K ?
-				      CMDQ_INITIALIZE_FW_QPC_PG_SIZE_PG_64K :
-		pbl->pg_size == ROCE_PG_SIZE_2M ?
-				      CMDQ_INITIALIZE_FW_QPC_PG_SIZE_PG_2M :
-		pbl->pg_size == ROCE_PG_SIZE_8M ?
-				      CMDQ_INITIALIZE_FW_QPC_PG_SIZE_PG_8M :
-		pbl->pg_size == ROCE_PG_SIZE_1G ?
-				      CMDQ_INITIALIZE_FW_QPC_PG_SIZE_PG_1G :
-				      CMDQ_INITIALIZE_FW_QPC_PG_SIZE_PG_4K);
-}
-
 int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 			 struct bnxt_qplib_ctx *ctx, int is_virtfn)
 {
-	struct cmdq_initialize_fw req;
 	struct creq_initialize_fw_resp resp;
-	u16 cmd_flags = 0, level;
+	struct cmdq_initialize_fw req;
+	u16 cmd_flags = 0;
+	u8 pgsz, lvl;
 	int rc;
 
 	RCFW_CMD_PREP(req, INITIALIZE_FW, cmd_flags);
@@ -511,32 +495,30 @@ int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 	if (bnxt_qplib_is_chip_gen_p5(rcfw->res->cctx))
 		goto config_vf_res;
 
-	level = ctx->qpc_tbl.level;
-	req.qpc_pg_size_qpc_lvl = (level << CMDQ_INITIALIZE_FW_QPC_LVL_SFT) |
-				__get_pbl_pg_idx(&ctx->qpc_tbl.pbl[level]);
-	level = ctx->mrw_tbl.level;
-	req.mrw_pg_size_mrw_lvl = (level << CMDQ_INITIALIZE_FW_MRW_LVL_SFT) |
-				__get_pbl_pg_idx(&ctx->mrw_tbl.pbl[level]);
-	level = ctx->srqc_tbl.level;
-	req.srq_pg_size_srq_lvl = (level << CMDQ_INITIALIZE_FW_SRQ_LVL_SFT) |
-				__get_pbl_pg_idx(&ctx->srqc_tbl.pbl[level]);
-	level = ctx->cq_tbl.level;
-	req.cq_pg_size_cq_lvl = (level << CMDQ_INITIALIZE_FW_CQ_LVL_SFT) |
-				__get_pbl_pg_idx(&ctx->cq_tbl.pbl[level]);
-	level = ctx->srqc_tbl.level;
-	req.srq_pg_size_srq_lvl = (level << CMDQ_INITIALIZE_FW_SRQ_LVL_SFT) |
-				__get_pbl_pg_idx(&ctx->srqc_tbl.pbl[level]);
-	level = ctx->cq_tbl.level;
-	req.cq_pg_size_cq_lvl = (level << CMDQ_INITIALIZE_FW_CQ_LVL_SFT) |
-				__get_pbl_pg_idx(&ctx->cq_tbl.pbl[level]);
-	level = ctx->tim_tbl.level;
-	req.tim_pg_size_tim_lvl = (level << CMDQ_INITIALIZE_FW_TIM_LVL_SFT) |
-				  __get_pbl_pg_idx(&ctx->tim_tbl.pbl[level]);
-	level = ctx->tqm_ctx.pde.level;
-	req.tqm_pg_size_tqm_lvl =
-		(level << CMDQ_INITIALIZE_FW_TQM_LVL_SFT) |
-		 __get_pbl_pg_idx(&ctx->tqm_ctx.pde.pbl[level]);
-
+	lvl = ctx->qpc_tbl.level;
+	pgsz = bnxt_qplib_base_pg_size(&ctx->qpc_tbl);
+	req.qpc_pg_size_qpc_lvl = (pgsz << CMDQ_INITIALIZE_FW_QPC_PG_SIZE_SFT) |
+				   lvl;
+	lvl = ctx->mrw_tbl.level;
+	pgsz = bnxt_qplib_base_pg_size(&ctx->mrw_tbl);
+	req.mrw_pg_size_mrw_lvl = (pgsz << CMDQ_INITIALIZE_FW_QPC_PG_SIZE_SFT) |
+				   lvl;
+	lvl = ctx->srqc_tbl.level;
+	pgsz = bnxt_qplib_base_pg_size(&ctx->srqc_tbl);
+	req.srq_pg_size_srq_lvl = (pgsz << CMDQ_INITIALIZE_FW_QPC_PG_SIZE_SFT) |
+				   lvl;
+	lvl = ctx->cq_tbl.level;
+	pgsz = bnxt_qplib_base_pg_size(&ctx->cq_tbl);
+	req.cq_pg_size_cq_lvl = (pgsz << CMDQ_INITIALIZE_FW_QPC_PG_SIZE_SFT) |
+				 lvl;
+	lvl = ctx->tim_tbl.level;
+	pgsz = bnxt_qplib_base_pg_size(&ctx->tim_tbl);
+	req.tim_pg_size_tim_lvl = (pgsz << CMDQ_INITIALIZE_FW_QPC_PG_SIZE_SFT) |
+				   lvl;
+	lvl = ctx->tqm_ctx.pde.level;
+	pgsz = bnxt_qplib_base_pg_size(&ctx->tqm_ctx.pde);
+	req.tqm_pg_size_tqm_lvl = (pgsz << CMDQ_INITIALIZE_FW_QPC_PG_SIZE_SFT) |
+				   lvl;
 	req.qpc_page_dir =
 		cpu_to_le64(ctx->qpc_tbl.pbl[PBL_LVL_0].pg_map_arr[0]);
 	req.mrw_page_dir =
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 95b645d..79109ef 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -80,6 +80,15 @@ enum bnxt_qplib_pbl_lvl {
 #define ROCE_PG_SIZE_8M		(8 * 1024 * 1024)
 #define ROCE_PG_SIZE_1G		(1024 * 1024 * 1024)
 
+enum bnxt_qplib_hwrm_pg_size {
+	BNXT_QPLIB_HWRM_PG_SIZE_4K	= 0,
+	BNXT_QPLIB_HWRM_PG_SIZE_8K	= 1,
+	BNXT_QPLIB_HWRM_PG_SIZE_64K	= 2,
+	BNXT_QPLIB_HWRM_PG_SIZE_2M	= 3,
+	BNXT_QPLIB_HWRM_PG_SIZE_8M	= 4,
+	BNXT_QPLIB_HWRM_PG_SIZE_1G	= 5,
+};
+
 struct bnxt_qplib_reg_desc {
 	u8		bar_id;
 	resource_size_t	bar_base;
@@ -263,6 +272,37 @@ static inline u8 bnxt_qplib_get_ring_type(struct bnxt_qplib_chip_ctx *cctx)
 	       RING_ALLOC_REQ_RING_TYPE_ROCE_CMPL;
 }
 
+static inline u8 bnxt_qplib_base_pg_size(struct bnxt_qplib_hwq *hwq)
+{
+	u8 pg_size = BNXT_QPLIB_HWRM_PG_SIZE_4K;
+	struct bnxt_qplib_pbl *pbl;
+
+	pbl = &hwq->pbl[PBL_LVL_0];
+	switch (pbl->pg_size) {
+	case ROCE_PG_SIZE_4K:
+		pg_size = BNXT_QPLIB_HWRM_PG_SIZE_4K;
+		break;
+	case ROCE_PG_SIZE_8K:
+		pg_size = BNXT_QPLIB_HWRM_PG_SIZE_8K;
+		break;
+	case ROCE_PG_SIZE_64K:
+		pg_size = BNXT_QPLIB_HWRM_PG_SIZE_64K;
+		break;
+	case ROCE_PG_SIZE_2M:
+		pg_size = BNXT_QPLIB_HWRM_PG_SIZE_2M;
+		break;
+	case ROCE_PG_SIZE_8M:
+		pg_size = BNXT_QPLIB_HWRM_PG_SIZE_8M;
+		break;
+	case ROCE_PG_SIZE_1G:
+		pg_size = BNXT_QPLIB_HWRM_PG_SIZE_1G;
+		break;
+	default:
+		break;
+	}
+
+	return pg_size;
+}
 
 #define to_bnxt_qplib(ptr, type, member)	\
 	container_of(ptr, type, member)
-- 
1.8.3.1

