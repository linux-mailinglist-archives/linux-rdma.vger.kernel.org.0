Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875BF250738
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 20:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgHXSO4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 14:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgHXSO4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 14:14:56 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F3CC061573
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 11:14:56 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u20so5265538pfn.0
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 11:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N+gUadkvejZKzLYmUPaVrN6rrLrgiQ5s8W3HTmNkwSg=;
        b=IwuQhRNVCobGLipNI/ttMV8r4ZYTKxXS9S0p7TE44502q1/295hhL2Ipxh5SvQFL3E
         F0Mea0u2kHZO6FVDYgEGb6gNJJbMmdaEvJJ5XSubRXCgGU2cmzwukRtH14U9izTyZoqe
         IJYemBzscuDmd9p8ex8MfGpm/zpOYroT//rOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N+gUadkvejZKzLYmUPaVrN6rrLrgiQ5s8W3HTmNkwSg=;
        b=ENdcbTWplMG34fO8rkrPj8tRuln0OiHSQuqrMm2LQm/nQpKVgQFnbhwtTBpmEj3+Wa
         FiDSmUREPVIToS4arSg9z6chvtfFxOm4ckxXm/vKys+Nb6LNFINh8HG2+Iy6x8AYaQqb
         mQFa/qerhkwiobSz11z1o7Z6r6+EbkzhkMu/5YIiH0jFKjhEPctvkF27mHHGRfm3TNij
         8kwB9jowuYMfgcKzf07+LGDdimAx7+3esa+Q1BZLhkHI/zeaJ5Vla3qqCda6c1fHb+NV
         IOPZKieiifSyx9UUw/NWWVBH7mdb6KmJyGXeBRFWBapSiswZI5UcAWSMV6+M2sKOC9vz
         2mFA==
X-Gm-Message-State: AOAM5328xp3ZoAT49BkSWut8h49mdZYGC834qDNNcHff/SoQnSsnE3yB
        kvH+Z35QSzuKaco9bGuDMjPQbw==
X-Google-Smtp-Source: ABdhPJyUXe5FBaqP/NzCD1sWYw3HEapw57UAnws/3L76F7m6eEEv0PCcDe/+ucZMKxTK0R+5GFJ2OA==
X-Received: by 2002:a17:902:b193:: with SMTP id s19mr4829796plr.194.1598292895564;
        Mon, 24 Aug 2020 11:14:55 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q5sm5027811pfu.16.2020.08.24.11.14.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 11:14:54 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-rc 3/6] RDMA/bnxt_re: Fix the qp table indexing
Date:   Mon, 24 Aug 2020 11:14:33 -0700
Message-Id: <1598292876-26529-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1598292876-26529-1-git-send-email-selvin.xavier@broadcom.com>
References: <1598292876-26529-1-git-send-email-selvin.xavier@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

qp->id can be a value outside the max number of qp.
Indexing the qp table with the id can cause
out of bounds crash. So changing the qp table indexing
by (qp->id % max_qp -1).

Allocating one extra entry for QP1. Some adapters create
one more than the max_qp requested to accommodate QP1.
If the qp->id is 1, store the inforamtion in the last
entry of the qp table.

Fixes: f218d67ef004 ("RDMA/bnxt_re: Allow posting when QPs are in error")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 22 ++++++++++++++--------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 10 ++++++----
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  5 +++++
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 117b423..3535130 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -818,6 +818,7 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	u16 cmd_flags = 0;
 	u32 qp_flags = 0;
 	u8 pg_sz_lvl;
+	u32 tbl_indx;
 	int rc;
 
 	RCFW_CMD_PREP(req, CREATE_QP1, cmd_flags);
@@ -907,8 +908,9 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 		rq->dbinfo.db = qp->dpi->dbr;
 		rq->dbinfo.max_slot = bnxt_qplib_set_rq_max_slot(rq->wqe_size);
 	}
-	rcfw->qp_tbl[qp->id].qp_id = qp->id;
-	rcfw->qp_tbl[qp->id].qp_handle = (void *)qp;
+	tbl_indx = map_qp_id_to_tbl_indx(qp->id, rcfw);
+	rcfw->qp_tbl[tbl_indx].qp_id = qp->id;
+	rcfw->qp_tbl[tbl_indx].qp_handle = (void *)qp;
 
 	return 0;
 
@@ -959,6 +961,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	u16 cmd_flags = 0;
 	u32 qp_flags = 0;
 	u8 pg_sz_lvl;
+	u32 tbl_indx;
 	u16 nsge;
 
 	RCFW_CMD_PREP(req, CREATE_QP, cmd_flags);
@@ -1111,8 +1114,9 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 		rq->dbinfo.db = qp->dpi->dbr;
 		rq->dbinfo.max_slot = bnxt_qplib_set_rq_max_slot(rq->wqe_size);
 	}
-	rcfw->qp_tbl[qp->id].qp_id = qp->id;
-	rcfw->qp_tbl[qp->id].qp_handle = (void *)qp;
+	tbl_indx = map_qp_id_to_tbl_indx(qp->id, rcfw);
+	rcfw->qp_tbl[tbl_indx].qp_id = qp->id;
+	rcfw->qp_tbl[tbl_indx].qp_handle = (void *)qp;
 
 	return 0;
 fail:
@@ -1457,10 +1461,12 @@ int bnxt_qplib_destroy_qp(struct bnxt_qplib_res *res,
 	struct cmdq_destroy_qp req;
 	struct creq_destroy_qp_resp resp;
 	u16 cmd_flags = 0;
+	u32 tbl_indx;
 	int rc;
 
-	rcfw->qp_tbl[qp->id].qp_id = BNXT_QPLIB_QP_ID_INVALID;
-	rcfw->qp_tbl[qp->id].qp_handle = NULL;
+	tbl_indx = map_qp_id_to_tbl_indx(qp->id, rcfw);
+	rcfw->qp_tbl[tbl_indx].qp_id = BNXT_QPLIB_QP_ID_INVALID;
+	rcfw->qp_tbl[tbl_indx].qp_handle = NULL;
 
 	RCFW_CMD_PREP(req, DESTROY_QP, cmd_flags);
 
@@ -1468,8 +1474,8 @@ int bnxt_qplib_destroy_qp(struct bnxt_qplib_res *res,
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
 					  (void *)&resp, NULL, 0);
 	if (rc) {
-		rcfw->qp_tbl[qp->id].qp_id = qp->id;
-		rcfw->qp_tbl[qp->id].qp_handle = qp;
+		rcfw->qp_tbl[tbl_indx].qp_id = qp->id;
+		rcfw->qp_tbl[tbl_indx].qp_handle = qp;
 		return rc;
 	}
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 4e21116..f7736e3 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -307,14 +307,15 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 	__le16  mcookie;
 	u16 cookie;
 	int rc = 0;
-	u32 qp_id;
+	u32 qp_id, tbl_indx;
 
 	pdev = rcfw->pdev;
 	switch (qp_event->event) {
 	case CREQ_QP_EVENT_EVENT_QP_ERROR_NOTIFICATION:
 		err_event = (struct creq_qp_error_notification *)qp_event;
 		qp_id = le32_to_cpu(err_event->xid);
-		qp = rcfw->qp_tbl[qp_id].qp_handle;
+		tbl_indx = map_qp_id_to_tbl_indx(qp_id, rcfw);
+		qp = rcfw->qp_tbl[tbl_indx].qp_handle;
 		dev_dbg(&pdev->dev, "Received QP error notification\n");
 		dev_dbg(&pdev->dev,
 			"qpid 0x%x, req_err=0x%x, resp_err=0x%x\n",
@@ -615,8 +616,9 @@ int bnxt_qplib_alloc_rcfw_channel(struct bnxt_qplib_res *res,
 
 	cmdq->bmap_size = bmap_size;
 
-	rcfw->qp_tbl_size = qp_tbl_sz;
-	rcfw->qp_tbl = kcalloc(qp_tbl_sz, sizeof(struct bnxt_qplib_qp_node),
+	/* Allocate one extra to hold the QP1 entries */
+	rcfw->qp_tbl_size = qp_tbl_sz + 1;
+	rcfw->qp_tbl = kcalloc(rcfw->qp_tbl_size, sizeof(struct bnxt_qplib_qp_node),
 			       GFP_KERNEL);
 	if (!rcfw->qp_tbl)
 		goto fail;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 1573876..5f2f0a5 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -216,4 +216,9 @@ int bnxt_qplib_deinit_rcfw(struct bnxt_qplib_rcfw *rcfw);
 int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 			 struct bnxt_qplib_ctx *ctx, int is_virtfn);
 void bnxt_qplib_mark_qp_error(void *qp_handle);
+static inline u32 map_qp_id_to_tbl_indx(u32 qid, struct bnxt_qplib_rcfw *rcfw)
+{
+	/* Last index of the qp_tbl is for QP1 ie. qp_tbl_size - 1*/
+	return (qid == 1) ? rcfw->qp_tbl_size - 1 : qid % rcfw->qp_tbl_size - 2;
+}
 #endif /* __BNXT_QPLIB_RCFW_H__ */
-- 
2.5.5

