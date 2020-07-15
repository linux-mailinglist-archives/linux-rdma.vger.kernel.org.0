Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78C4220F05
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2020 16:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgGOORT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jul 2020 10:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgGOORS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jul 2020 10:17:18 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7962FC061755
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2020 07:17:18 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w2so3138237pgg.10
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2020 07:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8lJNaij+uDGUQNm//GY7MQY2/nvSgV3Omj9TCFtBoa0=;
        b=cuKMmKscxYKOb/8PuDC6khb+ZKKgkeBPraAH5JfvokOBmrX83W7fxrjHH9DBA8chVL
         lR00gNv3MJkRzUzIj+4LvkAQf2bArhF93JAcWv0d8mJnJVFd0broS6bBhzA96o3hoh0F
         rhXId+tvPDFY8V10rgDo0Jx9RaXa/D8La+Dx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8lJNaij+uDGUQNm//GY7MQY2/nvSgV3Omj9TCFtBoa0=;
        b=ndAJWMvnBNRf6em4MhUgAcqJ+hOZapgElikW0Gen2++6V9/yV3HunizyR3be+bqdsU
         qmdi8XFMpx/JYCIQuj0uqLF6bq+YPf8GnDc2duQI2vpftxVv/lwKmC84WcVAUcrN+cYL
         gphkC3SAMF5I+JCwfKs+xh6IpIzrwBiaiuG5Q1P3hkaOayEXQeJOJ54wUu8Ju1Kcnrjn
         tWXoe6EwtA8dX9RvUZfmQM6wAGO+eqr3jKrQJ/XWRE6/P/4NTcBNjxU7jmCnaCm+2mcf
         HyF/0pK/RKEAe0nboF1bMgDRnF1Ol3XZOAy7OEbLbT3xlDikyiKSuqOPQjVXoEubBnaw
         OqaQ==
X-Gm-Message-State: AOAM530S2SniLZQdjs2KsKdHcmmgYHwAgOz0ehicMAk/bGUxuaeGaeez
        5if/CZ5oQJwq5IQfuAmiE+d20rf3e1YNKFIc2uqzXAdCmWVru+GgUKST0jt2ZnLLMSQmkNQ9ZiN
        ORnzGMBAFY9k5vyp0VamDd1XqTeJnkIGMlV8p13TlkoJba3s9wo5Ii40IgZtdYpkwYKgU0Vn9r3
        wZznI=
X-Google-Smtp-Source: ABdhPJyhMhhfZvmcABlso+Oml41rFS7fqxyYiBU5ynEQ+UsDvfszVGsZpybEV6cqKf3r9nZpIPixoQ==
X-Received: by 2002:a63:1a0c:: with SMTP id a12mr8226285pga.24.1594822637362;
        Wed, 15 Jul 2020 07:17:17 -0700 (PDT)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k92sm2399254pje.30.2020.07.15.07.17.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 07:17:16 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     devesh.sharma@broadcom.com, leon@kernel.org
Subject: [PATCH V2 for-next 3/6] RDMA/bnxt_re: Pull psn buffer dynamically based on prod
Date:   Wed, 15 Jul 2020 10:16:56 -0400
Message-Id: <1594822619-4098-4-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1594822619-4098-1-git-send-email-devesh.sharma@broadcom.com>
References: <1594822619-4098-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Changing the PSN management memory buffers from statically
initialized to dynamic pull scheme.
During create qp only the start pointers are initialized and
during post-send the psn buffer is pulled based on current
producer index.

Adjusting post_send code to accommodate dynamic psn-pull and
changing post_recv code to match post-send code wrt pseudo
flush wqe generation.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 129 ++++++++++++++++--------------
 drivers/infiniband/hw/bnxt_re/qplib_res.h |   3 +
 2 files changed, 74 insertions(+), 58 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index c9e7be3..e1896d3 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -929,26 +929,18 @@ static void bnxt_qplib_init_psn_ptr(struct bnxt_qplib_qp *qp, int size)
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
@@ -1555,6 +1547,8 @@ static void bnxt_qplib_fill_psn_search(struct bnxt_qplib_qp *qp,
 	u32 flg_npsn;
 	u32 op_spsn;
 
+	if (!swq->psn_search)
+		return;
 	psns = swq->psn_search;
 	psns_ext = swq->psn_ext;
 
@@ -1574,6 +1568,23 @@ static void bnxt_qplib_fill_psn_search(struct bnxt_qplib_qp *qp,
 	}
 }
 
+static void bnxt_qplib_pull_psn_buff(struct bnxt_qplib_q *sq,
+				     struct bnxt_qplib_swq *swq, u32 tail)
+{
+	struct bnxt_qplib_hwq *hwq;
+	u32 pg_num, pg_indx;
+	void *buff;
+
+	hwq = &sq->hwq;
+	if (!hwq->pad_pg)
+		return;
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
@@ -1588,6 +1599,7 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 	int i, rc = 0, data_len = 0, pkt_num = 0;
 	struct bnxt_qplib_q *sq = &qp->sq;
 	struct sq_send *hw_sq_send_hdr;
+	struct bnxt_qplib_hwq *hwq;
 	struct bnxt_qplib_swq *swq;
 	bool sch_handler = false;
 	struct sq_sge *hw_sge;
@@ -1595,40 +1607,48 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 	__le32 temp32;
 	u32 sw_prod;
 
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
+		dev_err(&hwq->pdev->dev,
+			"QPLIB: FP: QP (0x%x) is in the 0x%x state",
+			qp->id, qp->state);
+		rc = -EINVAL;
+		goto done;
 	}
 
 	if (bnxt_qplib_queue_full(sq)) {
-		dev_err(&sq->hwq.pdev->dev,
+		dev_err(&hwq->pdev->dev,
 			"prod = %#x cons = %#x qdepth = %#x delta = %#x\n",
-			sq->hwq.prod, sq->hwq.cons, sq->hwq.max_elements,
+			hwq->prod, hwq->cons, hwq->max_elements,
 			sq->q_full_delta);
 		rc = -ENOMEM;
 		goto done;
 	}
+
 	sw_prod = sq->hwq.prod;
 	swq = bnxt_qplib_get_swqe(sq, NULL);
+	bnxt_qplib_pull_psn_buff(sq, swq, sw_prod);
 	swq->wr_id = wqe->wr_id;
 	swq->type = wqe->type;
 	swq->flags = wqe->flags;
+	swq->start_psn = sq->psn & BTH_PSN_MASK;
 	if (qp->sig_type)
 		swq->flags |= SQ_SEND_FLAGS_SIGNAL_COMP;
-	swq->start_psn = sq->psn & BTH_PSN_MASK;
 
-	hw_sq_send_hdr = bnxt_qplib_get_qe(&sq->hwq, sw_prod, NULL);
+	hw_sq_send_hdr = bnxt_qplib_get_qe(hwq, sw_prod, NULL);
 	memset(hw_sq_send_hdr, 0, sq->wqe_size);
+	if (qp->state == CMDQ_MODIFY_QP_NEW_STATE_ERR) {
+		sch_handler = true;
+		dev_dbg(&hwq->pdev->dev,
+			"%s Error QP. Scheduling for poll_cq\n", __func__);
+		goto queue_err;
+	}
 
 	if (wqe->flags & BNXT_QPLIB_SWQE_FLAGS_INLINE) {
 		/* Copy the inline data */
 		if (wqe->inline_len > BNXT_QPLIB_SWQE_MAX_INLINE_LENGTH) {
-			dev_warn(&sq->hwq.pdev->dev,
+			dev_warn(&hwq->pdev->dev,
 				 "Inline data length > 96 detected\n");
 			data_len = BNXT_QPLIB_SWQE_MAX_INLINE_LENGTH;
 		} else {
@@ -1810,24 +1830,11 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
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
 	bnxt_qplib_swq_mod_start(sq, sw_prod);
 	bnxt_qplib_hwq_incr_prod(&sq->hwq, 1);
 	qp->wqe_cnt++;
-
 done:
 	if (sch_handler) {
 		nq_work = kzalloc(sizeof(*nq_work), GFP_ATOMIC);
@@ -1837,7 +1844,7 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 			INIT_WORK(&nq_work->work, bnxt_qpn_cqn_sched_task);
 			queue_work(qp->scq->nq->cqn_wq, &nq_work->work);
 		} else {
-			dev_err(&sq->hwq.pdev->dev,
+			dev_err(&hwq->pdev->dev,
 				"FP: Failed to allocate SQ nq_work!\n");
 			rc = -ENOMEM;
 		}
@@ -1858,29 +1865,41 @@ int bnxt_qplib_post_recv(struct bnxt_qplib_qp *qp,
 	struct bnxt_qplib_nq_work *nq_work = NULL;
 	struct bnxt_qplib_q *rq = &qp->rq;
 	struct bnxt_qplib_swq *swq;
+	struct bnxt_qplib_hwq *hwq;
 	bool sch_handler = false;
 	struct sq_sge *hw_sge;
 	struct rq_wqe *rqe;
 	int i, rc = 0;
 	u32 sw_prod;
 
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
+
 	if (bnxt_qplib_queue_full(rq)) {
-		dev_err(&rq->hwq.pdev->dev,
+		dev_err(&hwq->pdev->dev,
 			"FP: QP (0x%x) RQ is full!\n", qp->id);
 		rc = -EINVAL;
 		goto done;
 	}
+
 	sw_prod = rq->hwq.prod;
 	swq = bnxt_qplib_get_swqe(rq, NULL);
 	swq->wr_id = wqe->wr_id;
 
-	rqe = bnxt_qplib_get_qe(&rq->hwq, sw_prod, NULL);
+	if (qp->state == CMDQ_MODIFY_QP_NEW_STATE_ERR) {
+		sch_handler = true;
+		dev_dbg(&hwq->pdev->dev,
+			"%s: Error QP. Scheduling for poll_cq\n", __func__);
+		goto queue_err;
+	}
+
+	rqe = bnxt_qplib_get_qe(hwq, sw_prod, NULL);
 	memset(rqe, 0, rq->wqe_size);
 
 	/* Calculate wqe_size16 and data_len */
@@ -1904,15 +1923,9 @@ int bnxt_qplib_post_recv(struct bnxt_qplib_qp *qp,
 	rqe->wr_id[0] = cpu_to_le32(sw_prod);
 
 queue_err:
-	if (sch_handler) {
-		/* Store the ULP info in the software structures */
-		sw_prod = HWQ_CMP(rq->hwq.prod, &rq->hwq);
-		swq = bnxt_qplib_get_swqe(rq, NULL);
-		swq->wr_id = wqe->wr_id;
-	}
-
 	bnxt_qplib_swq_mod_start(rq, sw_prod);
 	bnxt_qplib_hwq_incr_prod(&rq->hwq, 1);
+done:
 	if (sch_handler) {
 		nq_work = kzalloc(sizeof(*nq_work), GFP_ATOMIC);
 		if (nq_work) {
@@ -1921,12 +1934,12 @@ int bnxt_qplib_post_recv(struct bnxt_qplib_qp *qp,
 			INIT_WORK(&nq_work->work, bnxt_qpn_cqn_sched_task);
 			queue_work(qp->rcq->nq->cqn_wq, &nq_work->work);
 		} else {
-			dev_err(&rq->hwq.pdev->dev,
+			dev_err(&hwq->pdev->dev,
 				"FP: Failed to allocate RQ nq_work!\n");
 			rc = -ENOMEM;
 		}
 	}
-done:
+
 	return rc;
 }
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 98df68a..b29c2ad 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -163,6 +163,9 @@ struct bnxt_qplib_hwq {
 	u32				cons;		/* raw */
 	u8				cp_bit;
 	u8				is_user;
+	u64				*pad_pg;
+	u32				pad_stride;
+	u32				pad_pgofft;
 };
 
 struct bnxt_qplib_db_info {
-- 
1.8.3.1

