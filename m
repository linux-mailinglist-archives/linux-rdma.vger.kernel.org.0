Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B051236002A
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Apr 2021 04:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhDOCzf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Apr 2021 22:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhDOCzf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Apr 2021 22:55:35 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B82BC061574
        for <linux-rdma@vger.kernel.org>; Wed, 14 Apr 2021 19:55:11 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id c16so22853611oib.3
        for <linux-rdma@vger.kernel.org>; Wed, 14 Apr 2021 19:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QCOXR31Q2h/pgBTNlZj4sVWnF1hxQSkZsFCgSfz5iXo=;
        b=KSEXZk7FpmmqO4MoydCKpgXj0H0+WHmslhWTS8bvlTTFqdIwQCXKX9j006cAWTsBvg
         6NDowOCb9SbGir03gxtOYifAGH+QQ+UXOhd3ITXKodh5ojoAoeokmRd+NBYciRFgqeXW
         rafMTf+gedsRZsJpC2eSPrEfwPU9QQThlkuHvLDXnvWpaMqcDwW2ZyBv2mkht1LjRDyj
         XhLRMSYlMTGcUMFK2LbslPJRKWPgs7oygAY4A20kuKBKrhDvjg1BdFldgRRIEh0vkaI1
         Zav8M64ouhl6ACY3fe0DBPl39GHrfl8nBWrhqoh2FdrLz1OoYaLkuT2hyBWU1seO49kS
         TbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QCOXR31Q2h/pgBTNlZj4sVWnF1hxQSkZsFCgSfz5iXo=;
        b=arsyeuphOSxGY/UMZdyPkYzGn1xrMD2m+JQtGyTTJRkjmaYrWoNN6EEb34KWiTtiRQ
         O1jrmu+4beFrE2RpIfn90WbpVab62v2Ovistq/Fad9JaLjYQxYMWdx5H296YcQJTTF55
         uQ3Zd5+xnffiU7cThRBWpTz5ZlxoK+h+azIugnVLfj+6QcO+khryudybgIVWkWYaGtPp
         5IScfoTycGcTDPEk+7kBU2Juq2womXnCuIot6SKSXk82wzkuE6nKype6U2gTFVye+4nh
         e52uY2+ICElMHC/89ORb+Em/tbMTXoQ0za48tMF1a7Zdp7jO25RMwmi45Vfl+SWh50kt
         HsrQ==
X-Gm-Message-State: AOAM533LiUOe/oLNJJxLwTrIKfmYzHhhszQ+v5/uDNLzF0tmCJ9JDmLP
        z8HQq7+ti1uj3keUI25P92U=
X-Google-Smtp-Source: ABdhPJxRadYt5sMmVV89YE7uwNS+rn+f0e7Q7dsXSFtTEWJQFWnAXsFzQXeI/nMnQea9e1wNaFmkHw==
X-Received: by 2002:aca:1a0b:: with SMTP id a11mr934482oia.167.1618455310874;
        Wed, 14 Apr 2021 19:55:10 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-9ee3-9764-577f-477e.res6.spectrum.com. [2603:8081:140c:1a00:9ee3:9764:577f:477e])
        by smtp.gmail.com with ESMTPSA id n20sm352232otq.60.2021.04.14.19.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 19:55:10 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v2 6/9] RDMA/rxe: Move local ops to subroutine
Date:   Wed, 14 Apr 2021 21:54:27 -0500
Message-Id: <20210415025429.11053-7-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210415025429.11053-1-rpearson@hpe.com>
References: <20210415025429.11053-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Simplify rxe_requester() by moving the local operations
to a subroutine. Add an error return for illegal send WR opcode.
Moved next_index ahead of rxe_run_task which fixed a small bug where
work completions were delayed until after the next wqe which was not
the intended behavior.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 89 +++++++++++++++++------------
 1 file changed, 54 insertions(+), 35 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 0d4dcd514c55..0cf97e3db29f 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -555,6 +555,56 @@ static void update_state(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 			  jiffies + qp->qp_timeout_jiffies);
 }
 
+static int do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
+{
+	u8 opcode = wqe->wr.opcode;
+	struct rxe_dev *rxe;
+	struct rxe_mr *mr;
+	u32 rkey;
+
+	switch (opcode) {
+	case IB_WR_LOCAL_INV:
+		rxe = to_rdev(qp->ibqp.device);
+		rkey = wqe->wr.ex.invalidate_rkey;
+		mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
+		if (!mr) {
+			pr_err("No MR for rkey %#x\n", rkey);
+			wqe->state = wqe_state_error;
+			wqe->status = IB_WC_LOC_QP_OP_ERR;
+			return -EINVAL;
+		}
+		mr->state = RXE_MR_STATE_FREE;
+		rxe_drop_ref(mr);
+		break;
+	case IB_WR_REG_MR:
+		mr = to_rmr(wqe->wr.wr.reg.mr);
+
+		rxe_add_ref(mr);
+		mr->state = RXE_MR_STATE_VALID;
+		mr->access = wqe->wr.wr.reg.access;
+		mr->ibmr.lkey = wqe->wr.wr.reg.key;
+		mr->ibmr.rkey = wqe->wr.wr.reg.key;
+		mr->iova = wqe->wr.wr.reg.mr->iova;
+		rxe_drop_ref(mr);
+		break;
+	default:
+		pr_err("Unexpected send wqe opcode %d\n", opcode);
+		wqe->state = wqe_state_error;
+		wqe->status = IB_WC_LOC_QP_OP_ERR;
+		return -EINVAL;
+	}
+
+	wqe->state = wqe_state_done;
+	wqe->status = IB_WC_SUCCESS;
+	qp->req.wqe_index = next_index(qp->sq.queue, qp->req.wqe_index);
+
+	if ((wqe->wr.send_flags & IB_SEND_SIGNALED) ||
+	    qp->sq_sig_type == IB_SIGNAL_ALL_WR)
+		rxe_run_task(&qp->comp.task, 1);
+
+	return 0;
+}
+
 int rxe_requester(void *arg)
 {
 	struct rxe_qp *qp = (struct rxe_qp *)arg;
@@ -594,42 +644,11 @@ int rxe_requester(void *arg)
 		goto exit;
 
 	if (wqe->mask & WR_LOCAL_OP_MASK) {
-		if (wqe->wr.opcode == IB_WR_LOCAL_INV) {
-			struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
-			struct rxe_mr *rmr;
-
-			rmr = rxe_pool_get_index(&rxe->mr_pool,
-						 wqe->wr.ex.invalidate_rkey >> 8);
-			if (!rmr) {
-				pr_err("No mr for key %#x\n",
-				       wqe->wr.ex.invalidate_rkey);
-				wqe->state = wqe_state_error;
-				wqe->status = IB_WC_MW_BIND_ERR;
-				goto exit;
-			}
-			rmr->state = RXE_MR_STATE_FREE;
-			rxe_drop_ref(rmr);
-			wqe->state = wqe_state_done;
-			wqe->status = IB_WC_SUCCESS;
-		} else if (wqe->wr.opcode == IB_WR_REG_MR) {
-			struct rxe_mr *rmr = to_rmr(wqe->wr.wr.reg.mr);
-
-			rmr->state = RXE_MR_STATE_VALID;
-			rmr->access = wqe->wr.wr.reg.access;
-			rmr->ibmr.lkey = wqe->wr.wr.reg.key;
-			rmr->ibmr.rkey = wqe->wr.wr.reg.key;
-			rmr->iova = wqe->wr.wr.reg.mr->iova;
-			wqe->state = wqe_state_done;
-			wqe->status = IB_WC_SUCCESS;
-		} else {
+		ret = do_local_ops(qp, wqe);
+		if (unlikely(ret))
 			goto exit;
-		}
-		if ((wqe->wr.send_flags & IB_SEND_SIGNALED) ||
-		    qp->sq_sig_type == IB_SIGNAL_ALL_WR)
-			rxe_run_task(&qp->comp.task, 1);
-		qp->req.wqe_index = next_index(qp->sq.queue,
-						qp->req.wqe_index);
-		goto next_wqe;
+		else
+			goto next_wqe;
 	}
 
 	if (unlikely(qp_type(qp) == IB_QPT_RC &&
-- 
2.27.0

