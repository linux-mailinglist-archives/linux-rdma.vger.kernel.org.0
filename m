Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 293A3147855
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jan 2020 06:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgAXFxI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jan 2020 00:53:08 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:51840 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgAXFxI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jan 2020 00:53:08 -0500
Received: by mail-pj1-f67.google.com with SMTP id d15so548220pjw.1
        for <linux-rdma@vger.kernel.org>; Thu, 23 Jan 2020 21:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C1wA14Jo8ql7iTRViX7Pq6efmrL4w5F9WHeXakuGLjY=;
        b=SAkzUD67d77ZgO88Oo/7wVVdjWibDCydEummNt9jBiwIEMOz1W14o5LKhRldAIDC71
         TIGlQoGz1btu1lH6Xftl5UAFh2odIwSwUhpRlVkQvBNuSnvi6g1eWrBbUhBOPGlGbB+O
         t5lXRQcXnuph9ysgw6URcdGNxGcvJwAldOlsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C1wA14Jo8ql7iTRViX7Pq6efmrL4w5F9WHeXakuGLjY=;
        b=GkyepnxQeid+pDDtQHrfg8jBjY5shnhOOEyTkHd7rjg9xkbXlhB+vyFigP1K2i08PQ
         9OJXU9kZXxImAvIYLL8wRKlhLWHExTd6f4SccvMxW/bjv2YOXkm2bI/e6rNisUyx8N3M
         W5HNCf/mBiUhGop3z5n6v5PROwd/wnkfCg8qgaMjhebkOh5NQcH8GU6EanUZF8UeFpEp
         m2SKlqNXWqaQc+AUkgLex1TK2CnYlt6+r5pMEqcia4l5axhxdinvTPoz3p5emWZBdlad
         nUmuQk+zr6IEYHaHpcHK3GScurGk78omtIOr7fsUTApv4DVRvXnPWsS6HXb6AIamXXL0
         Z6GA==
X-Gm-Message-State: APjAAAW1VCoMMOs90jM4SrPx62itLtYDQu0cX8rnilD3sXAeXWKwn+SD
        vfaKcgXafJ3AwGSgURJCZrVnu2zd1eeYRoFj3a9JCT6vjC9lmQncSzPTDKt9XeeKDh1WP0Nyuxr
        aElgeqRJucxEAYmg6fEI4uOyE4GtLaxCTFvDPqcYewnmm+XqNtGMM3s3D23VtE3NY+9ne/ONyZv
        oCxymnIQ==
X-Google-Smtp-Source: APXvYqyO5ANDaMsaztScVwCRUc7W8/ifuq36YQInU7jikXHCuDNkBGuK8DWx46XSHx0soYHtRdxWyg==
X-Received: by 2002:a17:90a:a88d:: with SMTP id h13mr1519244pjq.48.1579845186608;
        Thu, 23 Jan 2020 21:53:06 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r20sm4781024pgu.89.2020.01.23.21.53.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jan 2020 21:53:05 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, dledford@redhat.com
Subject: [PATCH for-next 5/7] RDMA/bnxt_re: Refactor command queue management code
Date:   Fri, 24 Jan 2020 00:52:43 -0500
Message-Id: <1579845165-18002-6-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Refactoring the command queue (rcfw) management code. A new
data-structure is introduced to describe the bar register.
each object which deals with mmio space should have a descriptor
structure. This structure specifically hold DB register information.
Thus, slow path creq structure now hold a bar register descriptor.

Further cleanup the rcfw structure to introduce the command queue
context and command response event queue context structures. Rest
of the rcfw related code has been touched to incorporate these three
structures.

Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c       |  12 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 422 +++++++++++++++++------------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  80 +++---
 drivers/infiniband/hw/bnxt_re/qplib_res.h  |   7 +
 4 files changed, 315 insertions(+), 206 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 648a5ea..7b7553b 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1345,7 +1345,7 @@ static void bnxt_re_ib_unreg(struct bnxt_re_dev *rdev)
 		bnxt_qplib_free_ctx(&rdev->qplib_res, &rdev->qplib_ctx);
 		bnxt_qplib_disable_rcfw_channel(&rdev->rcfw);
 		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
-		bnxt_re_net_ring_free(rdev, rdev->rcfw.creq_ring_id, type);
+		bnxt_re_net_ring_free(rdev, rdev->rcfw.creq.ring_id, type);
 		bnxt_qplib_free_rcfw_channel(&rdev->rcfw);
 	}
 	if (test_and_clear_bit(BNXT_RE_FLAG_GOT_MSIX, &rdev->flags)) {
@@ -1376,6 +1376,7 @@ static void bnxt_re_worker(struct work_struct *work)
 
 static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 {
+	struct bnxt_qplib_creq_ctx *creq;
 	struct bnxt_re_ring_attr rattr;
 	u32 db_offt;
 	bool locked;
@@ -1428,13 +1429,14 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 	}
 
 	type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
-	rattr.dma_arr = rdev->rcfw.creq.pbl[PBL_LVL_0].pg_map_arr;
-	rattr.pages = rdev->rcfw.creq.pbl[rdev->rcfw.creq.level].pg_count;
+	creq = &rdev->rcfw.creq;
+	rattr.dma_arr = creq->hwq.pbl[PBL_LVL_0].pg_map_arr;
+	rattr.pages = creq->hwq.pbl[creq->hwq.level].pg_count;
 	rattr.type = type;
 	rattr.mode = RING_ALLOC_REQ_INT_MODE_MSIX;
 	rattr.depth = BNXT_QPLIB_CREQE_MAX_CNT - 1;
 	rattr.lrid = rdev->msix_entries[BNXT_RE_AEQ_IDX].ring_idx;
-	rc = bnxt_re_net_ring_alloc(rdev, &rattr, &rdev->rcfw.creq_ring_id);
+	rc = bnxt_re_net_ring_alloc(rdev, &rattr, &creq->ring_id);
 	if (rc) {
 		pr_err("Failed to allocate CREQ: %#x\n", rc);
 		goto free_rcfw;
@@ -1528,7 +1530,7 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 	bnxt_qplib_disable_rcfw_channel(&rdev->rcfw);
 free_ring:
 	type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
-	bnxt_re_net_ring_free(rdev, rdev->rcfw.creq_ring_id, type);
+	bnxt_re_net_ring_free(rdev, rdev->rcfw.creq.ring_id, type);
 free_rcfw:
 	bnxt_qplib_free_rcfw_channel(&rdev->rcfw);
 fail:
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index d2464dc..8160404 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -55,12 +55,14 @@
 /* Hardware communication channel */
 static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
 {
+	struct bnxt_qplib_cmdq_ctx *cmdq;
 	u16 cbit;
 	int rc;
 
+	cmdq = &rcfw->cmdq;
 	cbit = cookie % rcfw->cmdq_depth;
-	rc = wait_event_timeout(rcfw->waitq,
-				!test_bit(cbit, rcfw->cmdq_bitmap),
+	rc = wait_event_timeout(cmdq->waitq,
+				!test_bit(cbit, cmdq->cmdq_bitmap),
 				msecs_to_jiffies(RCFW_CMD_WAIT_TIME_MS));
 	return rc ? 0 : -ETIMEDOUT;
 };
@@ -68,15 +70,17 @@ static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
 static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
 {
 	u32 count = RCFW_BLOCKED_CMD_WAIT_COUNT;
+	struct bnxt_qplib_cmdq_ctx *cmdq;
 	u16 cbit;
 
+	cmdq = &rcfw->cmdq;
 	cbit = cookie % rcfw->cmdq_depth;
-	if (!test_bit(cbit, rcfw->cmdq_bitmap))
+	if (!test_bit(cbit, cmdq->cmdq_bitmap))
 		goto done;
 	do {
 		mdelay(1); /* 1m sec */
 		bnxt_qplib_service_creq((unsigned long)rcfw);
-	} while (test_bit(cbit, rcfw->cmdq_bitmap) && --count);
+	} while (test_bit(cbit, cmdq->cmdq_bitmap) && --count);
 done:
 	return count ? 0 : -ETIMEDOUT;
 };
@@ -84,56 +88,61 @@ static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
 static int __send_message(struct bnxt_qplib_rcfw *rcfw, struct cmdq_base *req,
 			  struct creq_base *resp, void *sb, u8 is_block)
 {
-	struct bnxt_qplib_cmdqe *cmdqe, **cmdq_ptr;
-	struct bnxt_qplib_hwq *cmdq = &rcfw->cmdq;
+	struct bnxt_qplib_cmdq_ctx *cmdq = &rcfw->cmdq;
+	struct bnxt_qplib_cmdqe *cmdqe, **hwq_ptr;
+	struct bnxt_qplib_hwq *hwq = &cmdq->hwq;
+	struct bnxt_qplib_crsqe *crsqe;
 	u32 cmdq_depth = rcfw->cmdq_depth;
-	struct bnxt_qplib_crsq *crsqe;
 	u32 sw_prod, cmdq_prod;
+	struct pci_dev *pdev;
 	unsigned long flags;
 	u32 size, opcode;
 	u16 cookie, cbit;
+	int pg, idx;
 	u8 *preq;
 
+	pdev = rcfw->pdev;
+
 	opcode = req->opcode;
-	if (!test_bit(FIRMWARE_INITIALIZED_FLAG, &rcfw->flags) &&
+	if (!test_bit(FIRMWARE_INITIALIZED_FLAG, &cmdq->flags) &&
 	    (opcode != CMDQ_BASE_OPCODE_QUERY_FUNC &&
 	     opcode != CMDQ_BASE_OPCODE_INITIALIZE_FW &&
 	     opcode != CMDQ_BASE_OPCODE_QUERY_VERSION)) {
-		dev_err(&rcfw->pdev->dev,
+		dev_err(&pdev->dev,
 			"RCFW not initialized, reject opcode 0x%x\n", opcode);
 		return -EINVAL;
 	}
 
-	if (test_bit(FIRMWARE_INITIALIZED_FLAG, &rcfw->flags) &&
+	if (test_bit(FIRMWARE_INITIALIZED_FLAG, &cmdq->flags) &&
 	    opcode == CMDQ_BASE_OPCODE_INITIALIZE_FW) {
-		dev_err(&rcfw->pdev->dev, "RCFW already initialized!\n");
+		dev_err(&pdev->dev, "RCFW already initialized!\n");
 		return -EINVAL;
 	}
 
-	if (test_bit(FIRMWARE_TIMED_OUT, &rcfw->flags))
+	if (test_bit(FIRMWARE_TIMED_OUT, &cmdq->flags))
 		return -ETIMEDOUT;
 
 	/* Cmdq are in 16-byte units, each request can consume 1 or more
 	 * cmdqe
 	 */
-	spin_lock_irqsave(&cmdq->lock, flags);
-	if (req->cmd_size >= HWQ_FREE_SLOTS(cmdq)) {
-		dev_err(&rcfw->pdev->dev, "RCFW: CMDQ is full!\n");
-		spin_unlock_irqrestore(&cmdq->lock, flags);
+	spin_lock_irqsave(&hwq->lock, flags);
+	if (req->cmd_size >= HWQ_FREE_SLOTS(hwq)) {
+		dev_err(&pdev->dev, "RCFW: CMDQ is full!\n");
+		spin_unlock_irqrestore(&hwq->lock, flags);
 		return -EAGAIN;
 	}
 
 
-	cookie = rcfw->seq_num & RCFW_MAX_COOKIE_VALUE;
+	cookie = cmdq->seq_num & RCFW_MAX_COOKIE_VALUE;
 	cbit = cookie % rcfw->cmdq_depth;
 	if (is_block)
 		cookie |= RCFW_CMD_IS_BLOCKING;
 
-	set_bit(cbit, rcfw->cmdq_bitmap);
+	set_bit(cbit, cmdq->cmdq_bitmap);
 	req->cookie = cpu_to_le16(cookie);
 	crsqe = &rcfw->crsqe_tbl[cbit];
 	if (crsqe->resp) {
-		spin_unlock_irqrestore(&cmdq->lock, flags);
+		spin_unlock_irqrestore(&hwq->lock, flags);
 		return -EBUSY;
 	}
 
@@ -155,15 +164,18 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw, struct cmdq_base *req,
 				  BNXT_QPLIB_CMDQE_UNITS;
 	}
 
-	cmdq_ptr = (struct bnxt_qplib_cmdqe **)cmdq->pbl_ptr;
+	hwq_ptr = (struct bnxt_qplib_cmdqe **)hwq->pbl_ptr;
 	preq = (u8 *)req;
 	do {
+		pg = 0;
+		idx = 0;
+
 		/* Locate the next cmdq slot */
-		sw_prod = HWQ_CMP(cmdq->prod, cmdq);
-		cmdqe = &cmdq_ptr[get_cmdq_pg(sw_prod, cmdq_depth)]
+		sw_prod = HWQ_CMP(hwq->prod, hwq);
+		cmdqe = &hwq_ptr[get_cmdq_pg(sw_prod, cmdq_depth)]
 				[get_cmdq_idx(sw_prod, cmdq_depth)];
 		if (!cmdqe) {
-			dev_err(&rcfw->pdev->dev,
+			dev_err(&pdev->dev,
 				"RCFW request failed with no cmdqe!\n");
 			goto done;
 		}
@@ -172,31 +184,27 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw, struct cmdq_base *req,
 		memcpy(cmdqe, preq, min_t(u32, size, sizeof(*cmdqe)));
 		preq += min_t(u32, size, sizeof(*cmdqe));
 		size -= min_t(u32, size, sizeof(*cmdqe));
-		cmdq->prod++;
-		rcfw->seq_num++;
+		hwq->prod++;
 	} while (size > 0);
+	cmdq->seq_num++;
 
-	rcfw->seq_num++;
-
-	cmdq_prod = cmdq->prod;
-	if (test_bit(FIRMWARE_FIRST_FLAG, &rcfw->flags)) {
+	cmdq_prod = hwq->prod;
+	if (test_bit(FIRMWARE_FIRST_FLAG, &cmdq->flags)) {
 		/* The very first doorbell write
 		 * is required to set this flag
 		 * which prompts the FW to reset
 		 * its internal pointers
 		 */
 		cmdq_prod |= BIT(FIRMWARE_FIRST_FLAG);
-		clear_bit(FIRMWARE_FIRST_FLAG, &rcfw->flags);
+		clear_bit(FIRMWARE_FIRST_FLAG, &cmdq->flags);
 	}
 
 	/* ring CMDQ DB */
 	wmb();
-	writel(cmdq_prod, rcfw->cmdq_bar_reg_iomem +
-	       rcfw->cmdq_bar_reg_prod_off);
-	writel(RCFW_CMDQ_TRIG_VAL, rcfw->cmdq_bar_reg_iomem +
-	       rcfw->cmdq_bar_reg_trig_off);
+	writel(cmdq_prod, cmdq->cmdq_mbox.prod);
+	writel(RCFW_CMDQ_TRIG_VAL, cmdq->cmdq_mbox.db);
 done:
-	spin_unlock_irqrestore(&cmdq->lock, flags);
+	spin_unlock_irqrestore(&hwq->lock, flags);
 	/* Return the CREQ response pointer */
 	return 0;
 }
@@ -236,7 +244,7 @@ int bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 		/* timed out */
 		dev_err(&rcfw->pdev->dev, "cmdq[%#x]=%#x timedout (%d)msec\n",
 			cookie, opcode, RCFW_CMD_WAIT_TIME_MS);
-		set_bit(FIRMWARE_TIMED_OUT, &rcfw->flags);
+		set_bit(FIRMWARE_TIMED_OUT, &rcfw->cmdq.flags);
 		return rc;
 	}
 
@@ -253,6 +261,8 @@ int bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 static int bnxt_qplib_process_func_event(struct bnxt_qplib_rcfw *rcfw,
 					 struct creq_func_event *func_event)
 {
+	int rc;
+
 	switch (func_event->event) {
 	case CREQ_FUNC_EVENT_EVENT_TX_WQE_ERROR:
 		break;
@@ -286,37 +296,41 @@ static int bnxt_qplib_process_func_event(struct bnxt_qplib_rcfw *rcfw,
 	default:
 		return -EINVAL;
 	}
-	return 0;
+
+	rc = rcfw->creq.aeq_handler(rcfw, (void *)func_event, NULL);
+	return rc;
 }
 
 static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 				       struct creq_qp_event *qp_event)
 {
-	struct bnxt_qplib_hwq *cmdq = &rcfw->cmdq;
 	struct creq_qp_error_notification *err_event;
-	struct bnxt_qplib_crsq *crsqe;
-	unsigned long flags;
+	struct bnxt_qplib_hwq *hwq = &rcfw->cmdq.hwq;
+	struct bnxt_qplib_crsqe *crsqe;
 	struct bnxt_qplib_qp *qp;
 	u16 cbit, blocked = 0;
-	u16 cookie;
+	struct pci_dev *pdev;
+	unsigned long flags;
 	__le16  mcookie;
+	u16 cookie;
+	int rc = 0;
 	u32 qp_id;
 
+	pdev = rcfw->pdev;
 	switch (qp_event->event) {
 	case CREQ_QP_EVENT_EVENT_QP_ERROR_NOTIFICATION:
 		err_event = (struct creq_qp_error_notification *)qp_event;
 		qp_id = le32_to_cpu(err_event->xid);
 		qp = rcfw->qp_tbl[qp_id].qp_handle;
-		dev_dbg(&rcfw->pdev->dev,
-			"Received QP error notification\n");
-		dev_dbg(&rcfw->pdev->dev,
+		dev_dbg(&pdev->dev, "Received QP error notification\n");
+		dev_dbg(&pdev->dev,
 			"qpid 0x%x, req_err=0x%x, resp_err=0x%x\n",
 			qp_id, err_event->req_err_state_reason,
 			err_event->res_err_state_reason);
 		if (!qp)
 			break;
 		bnxt_qplib_mark_qp_error(qp);
-		rcfw->aeq_handler(rcfw, qp_event, qp);
+		rc = rcfw->creq.aeq_handler(rcfw, qp_event, qp);
 		break;
 	default:
 		/*
@@ -328,7 +342,7 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 		 *
 		 */
 
-		spin_lock_irqsave_nested(&cmdq->lock, flags,
+		spin_lock_irqsave_nested(&hwq->lock, flags,
 					 SINGLE_DEPTH_NESTING);
 		cookie = le16_to_cpu(qp_event->cookie);
 		mcookie = qp_event->cookie;
@@ -342,23 +356,23 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 			crsqe->resp = NULL;
 		} else {
 			if (crsqe->resp && crsqe->resp->cookie)
-				dev_err(&rcfw->pdev->dev,
+				dev_err(&pdev->dev,
 					"CMD %s cookie sent=%#x, recd=%#x\n",
 					crsqe->resp ? "mismatch" : "collision",
 					crsqe->resp ? crsqe->resp->cookie : 0,
 					mcookie);
 		}
-		if (!test_and_clear_bit(cbit, rcfw->cmdq_bitmap))
-			dev_warn(&rcfw->pdev->dev,
+		if (!test_and_clear_bit(cbit, rcfw->cmdq.cmdq_bitmap))
+			dev_warn(&pdev->dev,
 				 "CMD bit %d was not requested\n", cbit);
-		cmdq->cons += crsqe->req_size;
+		hwq->cons += crsqe->req_size;
 		crsqe->req_size = 0;
 
 		if (!blocked)
-			wake_up(&rcfw->waitq);
-		spin_unlock_irqrestore(&cmdq->lock, flags);
+			wake_up(&rcfw->cmdq.waitq);
+		spin_unlock_irqrestore(&hwq->lock, flags);
 	}
-	return 0;
+	return rc;
 }
 
 /* SP - CREQ Completion handlers */
@@ -366,20 +380,21 @@ static void bnxt_qplib_service_creq(unsigned long data)
 {
 	struct bnxt_qplib_rcfw *rcfw = (struct bnxt_qplib_rcfw *)data;
 	bool gen_p5 = bnxt_qplib_is_chip_gen_p5(rcfw->res->cctx);
-	struct bnxt_qplib_hwq *creq = &rcfw->creq;
+	struct bnxt_qplib_creq_ctx *creq = &rcfw->creq;
 	u32 type, budget = CREQ_ENTRY_POLL_BUDGET;
-	struct creq_base *creqe, **creq_ptr;
+	struct bnxt_qplib_hwq *hwq = &creq->hwq;
+	struct creq_base *creqe, **hwq_ptr;
 	u32 sw_cons, raw_cons;
 	unsigned long flags;
 
 	/* Service the CREQ until budget is over */
-	spin_lock_irqsave(&creq->lock, flags);
-	raw_cons = creq->cons;
+	spin_lock_irqsave(&hwq->lock, flags);
+	raw_cons = hwq->cons;
 	while (budget > 0) {
-		sw_cons = HWQ_CMP(raw_cons, creq);
-		creq_ptr = (struct creq_base **)creq->pbl_ptr;
-		creqe = &creq_ptr[get_creq_pg(sw_cons)][get_creq_idx(sw_cons)];
-		if (!CREQ_CMP_VALID(creqe, raw_cons, creq->max_elements))
+		sw_cons = HWQ_CMP(raw_cons, hwq);
+		hwq_ptr = (struct creq_base **)hwq->pbl_ptr;
+		creqe = &hwq_ptr[get_creq_pg(sw_cons)][get_creq_idx(sw_cons)];
+		if (!CREQ_CMP_VALID(creqe, raw_cons, hwq->max_elements))
 			break;
 		/* The valid test of the entry must be done first before
 		 * reading any further.
@@ -391,12 +406,12 @@ static void bnxt_qplib_service_creq(unsigned long data)
 		case CREQ_BASE_TYPE_QP_EVENT:
 			bnxt_qplib_process_qp_event
 				(rcfw, (struct creq_qp_event *)creqe);
-			rcfw->creq_qp_event_processed++;
+			creq->stats.creq_qp_event_processed++;
 			break;
 		case CREQ_BASE_TYPE_FUNC_EVENT:
 			if (!bnxt_qplib_process_func_event
 			    (rcfw, (struct creq_func_event *)creqe))
-				rcfw->creq_func_event_processed++;
+				creq->stats.creq_func_event_processed++;
 			else
 				dev_warn(&rcfw->pdev->dev,
 					 "aeqe:%#x Not handled\n", type);
@@ -412,28 +427,31 @@ static void bnxt_qplib_service_creq(unsigned long data)
 		budget--;
 	}
 
-	if (creq->cons != raw_cons) {
-		creq->cons = raw_cons;
-		bnxt_qplib_ring_creq_db_rearm(rcfw->creq_bar_reg_iomem,
-					      raw_cons, creq->max_elements,
-					      rcfw->creq_ring_id, gen_p5);
+	if (hwq->cons != raw_cons) {
+		hwq->cons = raw_cons;
+		bnxt_qplib_ring_creq_db_rearm(creq->creq_db.db,
+					      raw_cons, hwq->max_elements,
+					      creq->ring_id, gen_p5);
 	}
-	spin_unlock_irqrestore(&creq->lock, flags);
+	spin_unlock_irqrestore(&hwq->lock, flags);
 }
 
 static irqreturn_t bnxt_qplib_creq_irq(int irq, void *dev_instance)
 {
 	struct bnxt_qplib_rcfw *rcfw = dev_instance;
-	struct bnxt_qplib_hwq *creq = &rcfw->creq;
+	struct bnxt_qplib_creq_ctx *creq;
 	struct creq_base **creq_ptr;
+	struct bnxt_qplib_hwq *hwq;
 	u32 sw_cons;
 
+	creq = &rcfw->creq;
+	hwq = &creq->hwq;
 	/* Prefetch the CREQ element */
-	sw_cons = HWQ_CMP(creq->cons, creq);
-	creq_ptr = (struct creq_base **)rcfw->creq.pbl_ptr;
+	sw_cons = HWQ_CMP(hwq->cons, hwq);
+	creq_ptr = (struct creq_base **)creq->hwq.pbl_ptr;
 	prefetch(&creq_ptr[get_creq_pg(sw_cons)][get_creq_idx(sw_cons)]);
 
-	tasklet_schedule(&rcfw->worker);
+	tasklet_schedule(&creq->creq_tasklet);
 
 	return IRQ_HANDLED;
 }
@@ -452,7 +470,7 @@ int bnxt_qplib_deinit_rcfw(struct bnxt_qplib_rcfw *rcfw)
 	if (rc)
 		return rc;
 
-	clear_bit(FIRMWARE_INITIALIZED_FLAG, &rcfw->flags);
+	clear_bit(FIRMWARE_INITIALIZED_FLAG, &rcfw->cmdq.flags);
 	return 0;
 }
 
@@ -556,16 +574,17 @@ int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 					  NULL, 0);
 	if (rc)
 		return rc;
-	set_bit(FIRMWARE_INITIALIZED_FLAG, &rcfw->flags);
+	set_bit(FIRMWARE_INITIALIZED_FLAG, &rcfw->cmdq.flags);
 	return 0;
 }
 
 void bnxt_qplib_free_rcfw_channel(struct bnxt_qplib_rcfw *rcfw)
 {
+	kfree(rcfw->cmdq.cmdq_bitmap);
 	kfree(rcfw->qp_tbl);
 	kfree(rcfw->crsqe_tbl);
-	bnxt_qplib_free_hwq(rcfw->res, &rcfw->cmdq);
-	bnxt_qplib_free_hwq(rcfw->res, &rcfw->creq);
+	bnxt_qplib_free_hwq(rcfw->res, &rcfw->cmdq.hwq);
+	bnxt_qplib_free_hwq(rcfw->res, &rcfw->creq.hwq);
 	rcfw->pdev = NULL;
 }
 
@@ -576,8 +595,13 @@ int bnxt_qplib_alloc_rcfw_channel(struct bnxt_qplib_res *res,
 {
 	struct bnxt_qplib_hwq_attr hwq_attr;
 	struct bnxt_qplib_sg_info sginfo;
+	struct bnxt_qplib_cmdq_ctx *cmdq;
+	struct bnxt_qplib_creq_ctx *creq;
+	u32 bmap_size = 0;
 
 	rcfw->pdev = res->pdev;
+	cmdq = &rcfw->cmdq;
+	creq = &rcfw->creq;
 	rcfw->res = res;
 
 	memset(&hwq_attr, 0, sizeof(hwq_attr));
@@ -591,7 +615,7 @@ int bnxt_qplib_alloc_rcfw_channel(struct bnxt_qplib_res *res,
 	hwq_attr.stride = BNXT_QPLIB_CREQE_UNITS;
 	hwq_attr.type = bnxt_qplib_get_hwq_type(res);
 
-	if (bnxt_qplib_alloc_init_hwq(&rcfw->creq, &hwq_attr)) {
+	if (bnxt_qplib_alloc_init_hwq(&creq->hwq, &hwq_attr)) {
 		dev_err(&rcfw->pdev->dev,
 			"HW channel CREQ allocation failed\n");
 		goto fail;
@@ -605,17 +629,24 @@ int bnxt_qplib_alloc_rcfw_channel(struct bnxt_qplib_res *res,
 	hwq_attr.depth = rcfw->cmdq_depth;
 	hwq_attr.stride = BNXT_QPLIB_CMDQE_UNITS;
 	hwq_attr.type = HWQ_TYPE_CTX;
-	if (bnxt_qplib_alloc_init_hwq(&rcfw->cmdq, &hwq_attr)) {
+	if (bnxt_qplib_alloc_init_hwq(&cmdq->hwq, &hwq_attr)) {
 		dev_err(&rcfw->pdev->dev,
 			"HW channel CMDQ allocation failed\n");
 		goto fail;
 	}
 
-	rcfw->crsqe_tbl = kcalloc(rcfw->cmdq.max_elements,
+	rcfw->crsqe_tbl = kcalloc(cmdq->hwq.max_elements,
 				  sizeof(*rcfw->crsqe_tbl), GFP_KERNEL);
 	if (!rcfw->crsqe_tbl)
 		goto fail;
 
+	bmap_size = BITS_TO_LONGS(rcfw->cmdq_depth) * sizeof(unsigned long);
+	cmdq->cmdq_bitmap = kzalloc(bmap_size, GFP_KERNEL);
+	if (!cmdq->cmdq_bitmap)
+		goto fail;
+
+	cmdq->bmap_size = bmap_size;
+
 	rcfw->qp_tbl_size = qp_tbl_sz;
 	rcfw->qp_tbl = kcalloc(qp_tbl_sz, sizeof(struct bnxt_qplib_qp_node),
 			       GFP_KERNEL);
@@ -632,137 +663,202 @@ int bnxt_qplib_alloc_rcfw_channel(struct bnxt_qplib_res *res,
 void bnxt_qplib_rcfw_stop_irq(struct bnxt_qplib_rcfw *rcfw, bool kill)
 {
 	bool gen_p5 = bnxt_qplib_is_chip_gen_p5(rcfw->res->cctx);
+	struct bnxt_qplib_creq_ctx *creq;
 
-	tasklet_disable(&rcfw->worker);
+	creq = &rcfw->creq;
+	tasklet_disable(&creq->creq_tasklet);
 	/* Mask h/w interrupts */
-	bnxt_qplib_ring_creq_db(rcfw->creq_bar_reg_iomem, rcfw->creq.cons,
-				rcfw->creq.max_elements, rcfw->creq_ring_id,
+	bnxt_qplib_ring_creq_db(creq->creq_db.db, creq->hwq.cons,
+				creq->hwq.max_elements, creq->ring_id,
 				gen_p5);
 	/* Sync with last running IRQ-handler */
-	synchronize_irq(rcfw->vector);
+	synchronize_irq(creq->msix_vec);
 	if (kill)
-		tasklet_kill(&rcfw->worker);
+		tasklet_kill(&creq->creq_tasklet);
 
-	if (rcfw->requested) {
-		free_irq(rcfw->vector, rcfw);
-		rcfw->requested = false;
+	if (creq->requested) {
+		free_irq(creq->msix_vec, rcfw);
+		creq->requested = false;
 	}
 }
 
 void bnxt_qplib_disable_rcfw_channel(struct bnxt_qplib_rcfw *rcfw)
 {
+	struct bnxt_qplib_creq_ctx *creq;
+	struct bnxt_qplib_cmdq_ctx *cmdq;
 	unsigned long indx;
 
+	creq = &rcfw->creq;
+	cmdq = &rcfw->cmdq;
+	/* Make sure the HW channel is stopped! */
 	bnxt_qplib_rcfw_stop_irq(rcfw, true);
 
-	iounmap(rcfw->cmdq_bar_reg_iomem);
-	iounmap(rcfw->creq_bar_reg_iomem);
+	iounmap(cmdq->cmdq_mbox.reg.bar_reg);
+	iounmap(creq->creq_db.reg.bar_reg);
 
-	indx = find_first_bit(rcfw->cmdq_bitmap, rcfw->bmap_size);
-	if (indx != rcfw->bmap_size)
+	indx = find_first_bit(cmdq->cmdq_bitmap, cmdq->bmap_size);
+	if (indx != cmdq->bmap_size)
 		dev_err(&rcfw->pdev->dev,
 			"disabling RCFW with pending cmd-bit %lx\n", indx);
-	kfree(rcfw->cmdq_bitmap);
-	rcfw->bmap_size = 0;
 
-	rcfw->cmdq_bar_reg_iomem = NULL;
-	rcfw->creq_bar_reg_iomem = NULL;
-	rcfw->aeq_handler = NULL;
-	rcfw->vector = 0;
+	cmdq->cmdq_mbox.reg.bar_reg = NULL;
+	creq->creq_db.reg.bar_reg = NULL;
+	creq->aeq_handler = NULL;
+	creq->msix_vec = 0;
 }
 
 int bnxt_qplib_rcfw_start_irq(struct bnxt_qplib_rcfw *rcfw, int msix_vector,
 			      bool need_init)
 {
 	bool gen_p5 = bnxt_qplib_is_chip_gen_p5(rcfw->res->cctx);
+	struct bnxt_qplib_creq_ctx *creq;
 	int rc;
 
-	if (rcfw->requested)
+	creq = &rcfw->creq;
+
+	if (creq->requested)
 		return -EFAULT;
 
-	rcfw->vector = msix_vector;
+	creq->msix_vec = msix_vector;
 	if (need_init)
-		tasklet_init(&rcfw->worker,
+		tasklet_init(&creq->creq_tasklet,
 			     bnxt_qplib_service_creq, (unsigned long)rcfw);
 	else
-		tasklet_enable(&rcfw->worker);
-	rc = request_irq(rcfw->vector, bnxt_qplib_creq_irq, 0,
+		tasklet_enable(&creq->creq_tasklet);
+	rc = request_irq(creq->msix_vec, bnxt_qplib_creq_irq, 0,
 			 "bnxt_qplib_creq", rcfw);
 	if (rc)
 		return rc;
-	rcfw->requested = true;
-	bnxt_qplib_ring_creq_db_rearm(rcfw->creq_bar_reg_iomem,
-				      rcfw->creq.cons, rcfw->creq.max_elements,
-				      rcfw->creq_ring_id, gen_p5);
+	creq->requested = true;
+	bnxt_qplib_ring_creq_db_rearm(creq->creq_db.db,
+				      creq->hwq.cons, creq->hwq.max_elements,
+				      creq->ring_id, gen_p5);
 
 	return 0;
 }
 
-int bnxt_qplib_enable_rcfw_channel(struct bnxt_qplib_rcfw *rcfw,
-				   int msix_vector,
-				   int cp_bar_reg_off, int virt_fn,
-				   int (*aeq_handler)(struct bnxt_qplib_rcfw *,
-						      void *, void *))
+static int bnxt_qplib_map_cmdq_mbox(struct bnxt_qplib_rcfw *rcfw, bool is_vf)
 {
-	resource_size_t res_base;
-	struct cmdq_init init;
+	struct bnxt_qplib_cmdq_mbox *mbox;
+	resource_size_t bar_reg;
 	struct pci_dev *pdev;
-	u16 bmap_size;
-	int rc;
+	u16 prod_offt;
+	int rc = 0;
 
-	/* General */
 	pdev = rcfw->pdev;
-	rcfw->seq_num = 0;
-	set_bit(FIRMWARE_FIRST_FLAG, &rcfw->flags);
-	bmap_size = BITS_TO_LONGS(rcfw->cmdq_depth) * sizeof(unsigned long);
-	rcfw->cmdq_bitmap = kzalloc(bmap_size, GFP_KERNEL);
-	if (!rcfw->cmdq_bitmap)
-		return -ENOMEM;
-	rcfw->bmap_size = bmap_size;
-
-	/* CMDQ */
-	rcfw->cmdq_bar_reg = RCFW_COMM_PCI_BAR_REGION;
-	res_base = pci_resource_start(pdev, rcfw->cmdq_bar_reg);
-	if (!res_base)
+	mbox = &rcfw->cmdq.cmdq_mbox;
+
+	mbox->reg.bar_id = RCFW_COMM_PCI_BAR_REGION;
+	mbox->reg.len = RCFW_COMM_SIZE;
+	mbox->reg.bar_base = pci_resource_start(pdev, mbox->reg.bar_id);
+	if (!mbox->reg.bar_base) {
+		dev_err(&pdev->dev,
+			"QPLIB: CMDQ BAR region %d resc start is 0!\n",
+			mbox->reg.bar_id);
 		return -ENOMEM;
+	}
 
-	rcfw->cmdq_bar_reg_iomem = ioremap_nocache(res_base +
-					      RCFW_COMM_BASE_OFFSET,
-					      RCFW_COMM_SIZE);
-	if (!rcfw->cmdq_bar_reg_iomem) {
-		dev_err(&rcfw->pdev->dev, "CMDQ BAR region %d mapping failed\n",
-			rcfw->cmdq_bar_reg);
+	bar_reg = mbox->reg.bar_base + RCFW_COMM_BASE_OFFSET;
+	mbox->reg.len = RCFW_COMM_SIZE;
+	mbox->reg.bar_reg = ioremap_nocache(bar_reg, mbox->reg.len);
+	if (!mbox->reg.bar_reg) {
+		dev_err(&pdev->dev,
+			"QPLIB: CMDQ BAR region %d mapping failed\n",
+			mbox->reg.bar_id);
 		return -ENOMEM;
 	}
 
-	rcfw->cmdq_bar_reg_prod_off = virt_fn ? RCFW_VF_COMM_PROD_OFFSET :
-					RCFW_PF_COMM_PROD_OFFSET;
+	prod_offt = is_vf ? RCFW_VF_COMM_PROD_OFFSET :
+			    RCFW_PF_COMM_PROD_OFFSET;
+	mbox->prod = (void  __iomem *)(mbox->reg.bar_reg + prod_offt);
+	mbox->db = (void __iomem *)(mbox->reg.bar_reg + RCFW_COMM_TRIG_OFFSET);
+	return rc;
+}
 
-	rcfw->cmdq_bar_reg_trig_off = RCFW_COMM_TRIG_OFFSET;
+static int bnxt_qplib_map_creq_db(struct bnxt_qplib_rcfw *rcfw, u32 reg_offt)
+{
+	struct bnxt_qplib_creq_db *creq_db;
+	resource_size_t bar_reg;
+	struct pci_dev *pdev;
 
-	/* CREQ */
-	rcfw->creq_bar_reg = RCFW_COMM_CONS_PCI_BAR_REGION;
-	res_base = pci_resource_start(pdev, rcfw->creq_bar_reg);
-	if (!res_base)
-		dev_err(&rcfw->pdev->dev,
-			"CREQ BAR region %d resc start is 0!\n",
-			rcfw->creq_bar_reg);
-	/* Unconditionally map 8 bytes to support 57500 series */
-	rcfw->creq_bar_reg_iomem = ioremap_nocache(res_base + cp_bar_reg_off,
-						   8);
-	if (!rcfw->creq_bar_reg_iomem) {
-		dev_err(&rcfw->pdev->dev, "CREQ BAR region %d mapping failed\n",
-			rcfw->creq_bar_reg);
-		iounmap(rcfw->cmdq_bar_reg_iomem);
-		rcfw->cmdq_bar_reg_iomem = NULL;
+	pdev = rcfw->pdev;
+	creq_db = &rcfw->creq.creq_db;
+
+	creq_db->reg.bar_id = RCFW_COMM_CONS_PCI_BAR_REGION;
+	creq_db->reg.bar_base = pci_resource_start(pdev, creq_db->reg.bar_id);
+	if (!creq_db->reg.bar_id)
+		dev_err(&pdev->dev,
+			"QPLIB: CREQ BAR region %d resc start is 0!",
+			creq_db->reg.bar_id);
+
+	bar_reg = creq_db->reg.bar_base + reg_offt;
+	creq_db->reg.len = 8;
+	creq_db->reg.bar_reg = ioremap_nocache(bar_reg, creq_db->reg.len);
+	if (!creq_db->reg.bar_reg) {
+		dev_err(&pdev->dev,
+			"QPLIB: CREQ BAR region %d mapping failed",
+			creq_db->reg.bar_id);
 		return -ENOMEM;
 	}
-	rcfw->creq_qp_event_processed = 0;
-	rcfw->creq_func_event_processed = 0;
 
-	if (aeq_handler)
-		rcfw->aeq_handler = aeq_handler;
-	init_waitqueue_head(&rcfw->waitq);
+	creq_db->db = creq_db->reg.bar_reg;
+
+	return 0;
+}
+
+static void bnxt_qplib_start_rcfw(struct bnxt_qplib_rcfw *rcfw)
+{
+	struct bnxt_qplib_cmdq_ctx *cmdq;
+	struct bnxt_qplib_creq_ctx *creq;
+	struct bnxt_qplib_cmdq_mbox *mbox;
+	struct cmdq_init init = {0};
+
+	cmdq = &rcfw->cmdq;
+	creq = &rcfw->creq;
+	mbox = &cmdq->cmdq_mbox;
+
+	init.cmdq_pbl = cpu_to_le64(cmdq->hwq.pbl[PBL_LVL_0].pg_map_arr[0]);
+	init.cmdq_size_cmdq_lvl =
+			cpu_to_le16(((rcfw->cmdq_depth <<
+				      CMDQ_INIT_CMDQ_SIZE_SFT) &
+				    CMDQ_INIT_CMDQ_SIZE_MASK) |
+				    ((cmdq->hwq.level <<
+				      CMDQ_INIT_CMDQ_LVL_SFT) &
+				    CMDQ_INIT_CMDQ_LVL_MASK));
+	init.creq_ring_id = cpu_to_le16(creq->ring_id);
+	/* Write to the Bono mailbox register */
+	__iowrite32_copy(mbox->reg.bar_reg, &init, sizeof(init) / 4);
+}
+
+int bnxt_qplib_enable_rcfw_channel(struct bnxt_qplib_rcfw *rcfw,
+				   int msix_vector,
+				   int cp_bar_reg_off, int virt_fn,
+				   aeq_handler_t aeq_handler)
+{
+	struct bnxt_qplib_cmdq_ctx *cmdq;
+	struct bnxt_qplib_creq_ctx *creq;
+	int rc;
+
+	cmdq = &rcfw->cmdq;
+	creq = &rcfw->creq;
+
+	/* Clear to defaults */
+
+	cmdq->seq_num = 0;
+	set_bit(FIRMWARE_FIRST_FLAG, &cmdq->flags);
+	init_waitqueue_head(&cmdq->waitq);
+
+	creq->stats.creq_qp_event_processed = 0;
+	creq->stats.creq_func_event_processed = 0;
+	creq->aeq_handler = aeq_handler;
+
+	rc = bnxt_qplib_map_cmdq_mbox(rcfw, virt_fn);
+	if (rc)
+		return rc;
+
+	rc = bnxt_qplib_map_creq_db(rcfw, cp_bar_reg_off);
+	if (rc)
+		return rc;
 
 	rc = bnxt_qplib_rcfw_start_irq(rcfw, msix_vector, true);
 	if (rc) {
@@ -772,16 +868,8 @@ int bnxt_qplib_enable_rcfw_channel(struct bnxt_qplib_rcfw *rcfw,
 		return rc;
 	}
 
-	init.cmdq_pbl = cpu_to_le64(rcfw->cmdq.pbl[PBL_LVL_0].pg_map_arr[0]);
-	init.cmdq_size_cmdq_lvl = cpu_to_le16(
-		((rcfw->cmdq_depth << CMDQ_INIT_CMDQ_SIZE_SFT) &
-		 CMDQ_INIT_CMDQ_SIZE_MASK) |
-		((rcfw->cmdq.level << CMDQ_INIT_CMDQ_LVL_SFT) &
-		 CMDQ_INIT_CMDQ_LVL_MASK));
-	init.creq_ring_id = cpu_to_le16(rcfw->creq_ring_id);
+	bnxt_qplib_start_rcfw(rcfw);
 
-	/* Write to the Bono mailbox register */
-	__iowrite32_copy(rcfw->cmdq_bar_reg_iomem, &init, sizeof(init) / 4);
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index ab1531c..1aff6d4 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -206,8 +206,9 @@ static inline void bnxt_qplib_ring_creq_db(void __iomem *db, u32 raw_cons,
 #define CREQ_ENTRY_POLL_BUDGET		0x100
 
 /* HWQ */
+typedef int (*aeq_handler_t)(struct bnxt_qplib_rcfw *, void *, void *);
 
-struct bnxt_qplib_crsq {
+struct bnxt_qplib_crsqe {
 	struct creq_qp_event	*resp;
 	u32			req_size;
 };
@@ -225,41 +226,53 @@ struct bnxt_qplib_qp_node {
 
 #define BNXT_QPLIB_OOS_COUNT_MASK 0xFFFFFFFF
 
+#define FIRMWARE_INITIALIZED_FLAG	(0)
+#define FIRMWARE_FIRST_FLAG		(31)
+#define FIRMWARE_TIMED_OUT		(3)
+struct bnxt_qplib_cmdq_mbox {
+	struct bnxt_qplib_reg_desc	reg;
+	void __iomem			*prod;
+	void __iomem			*db;
+};
+
+struct bnxt_qplib_cmdq_ctx {
+	struct bnxt_qplib_hwq		hwq;
+	struct bnxt_qplib_cmdq_mbox	cmdq_mbox;
+	wait_queue_head_t		waitq;
+	unsigned long			flags;
+	unsigned long			*cmdq_bitmap;
+	u32				bmap_size;
+	u32				seq_num;
+};
+
+struct bnxt_qplib_creq_db {
+	struct bnxt_qplib_reg_desc	reg;
+	void __iomem			*db;
+};
+
+struct bnxt_qplib_creq_stat {
+	u64	creq_qp_event_processed;
+	u64	creq_func_event_processed;
+};
+
+struct bnxt_qplib_creq_ctx {
+	struct bnxt_qplib_hwq		hwq;
+	struct bnxt_qplib_creq_db	creq_db;
+	struct bnxt_qplib_creq_stat	stats;
+	struct tasklet_struct		creq_tasklet;
+	aeq_handler_t			aeq_handler;
+	u16				ring_id;
+	int				msix_vec;
+	bool				requested; /*irq handler installed */
+};
+
 /* RCFW Communication Channels */
 struct bnxt_qplib_rcfw {
 	struct pci_dev		*pdev;
 	struct bnxt_qplib_res	*res;
-	int			vector;
-	struct tasklet_struct	worker;
-	bool			requested;
-	unsigned long		*cmdq_bitmap;
-	u32			bmap_size;
-	unsigned long		flags;
-#define FIRMWARE_INITIALIZED_FLAG	0
-#define FIRMWARE_FIRST_FLAG		31
-#define FIRMWARE_TIMED_OUT		3
-	wait_queue_head_t	waitq;
-	int			(*aeq_handler)(struct bnxt_qplib_rcfw *,
-					       void *, void *);
-	u32			seq_num;
-
-	/* Bar region info */
-	void __iomem		*cmdq_bar_reg_iomem;
-	u16			cmdq_bar_reg;
-	u16			cmdq_bar_reg_prod_off;
-	u16			cmdq_bar_reg_trig_off;
-	u16			creq_ring_id;
-	u16			creq_bar_reg;
-	void __iomem		*creq_bar_reg_iomem;
-
-	/* Cmd-Resp and Async Event notification queue */
-	struct bnxt_qplib_hwq	creq;
-	u64			creq_qp_event_processed;
-	u64			creq_func_event_processed;
-
-	/* Actual Cmd and Resp Queues */
-	struct bnxt_qplib_hwq	cmdq;
-	struct bnxt_qplib_crsq	*crsqe_tbl;
+	struct bnxt_qplib_cmdq_ctx	cmdq;
+	struct bnxt_qplib_creq_ctx	creq;
+	struct bnxt_qplib_crsqe		*crsqe_tbl;
 	int qp_tbl_size;
 	struct bnxt_qplib_qp_node *qp_tbl;
 	u64 oos_prev;
@@ -279,8 +292,7 @@ int bnxt_qplib_rcfw_start_irq(struct bnxt_qplib_rcfw *rcfw, int msix_vector,
 int bnxt_qplib_enable_rcfw_channel(struct bnxt_qplib_rcfw *rcfw,
 				   int msix_vector,
 				   int cp_bar_reg_off, int virt_fn,
-				   int (*aeq_handler)(struct bnxt_qplib_rcfw *,
-						      void *aeqe, void *obj));
+				   aeq_handler_t aeq_handler);
 
 struct bnxt_qplib_rcfw_sbuf *bnxt_qplib_rcfw_alloc_sbuf(
 				struct bnxt_qplib_rcfw *rcfw,
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index fe8a6dd..5fa278e 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -80,6 +80,13 @@ enum bnxt_qplib_pbl_lvl {
 #define ROCE_PG_SIZE_8M		(8 * 1024 * 1024)
 #define ROCE_PG_SIZE_1G		(1024 * 1024 * 1024)
 
+struct bnxt_qplib_reg_desc {
+	u8		bar_id;
+	resource_size_t	bar_base;
+	void __iomem	*bar_reg;
+	size_t		len;
+};
+
 struct bnxt_qplib_pbl {
 	u32				pg_count;
 	u32				pg_size;
-- 
1.8.3.1

