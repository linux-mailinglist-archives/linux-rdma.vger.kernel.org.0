Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D268368492
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 18:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbhDVQO1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Apr 2021 12:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236780AbhDVQO0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Apr 2021 12:14:26 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C799FC06138B
        for <linux-rdma@vger.kernel.org>; Thu, 22 Apr 2021 09:13:50 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id x20so12576571oix.10
        for <linux-rdma@vger.kernel.org>; Thu, 22 Apr 2021 09:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QCOXR31Q2h/pgBTNlZj4sVWnF1hxQSkZsFCgSfz5iXo=;
        b=BoRsFA2EdY3EmqyfI9Oc0k/MPpMyyLebeqfZFRINFnlplcDMNskkPqccBtoI59x+l/
         RO10n/uBG3THbmUd61eOShOphZW1OGxewbnluNg7IXCGhMD07J68u8MDEO2FeyVlvP0j
         1TNuMz6HZnpbHM8y5w+jBfXe+zeVbUEfJdiPPq2UMUvOGD06ZMEgV0vEl4jouzh4EPJg
         o+Wy2kE88eVK++xEx45DxycccySzqG+o/k5HwjRMFlY8+fMcZZVZ5RhIbc+jAjQG160h
         L5MARrCDxVuTR7JGga+69kf2olSUmrg77jemXHy1CVZx7xJajHrYtn9v3u0UtkBVWGrx
         jXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QCOXR31Q2h/pgBTNlZj4sVWnF1hxQSkZsFCgSfz5iXo=;
        b=IcWD87trwgMNVHZeyYsnaLAFsYBxf4ERJmFM5Y910Yteukep25m47bMOSPLwY83S26
         rHjGW1EoUa8pySoDChiZJ6Cyq7qrnaPuRL3j1h/dm3j9Hd2qLVWjC9wW8s6y5F0ZXmi6
         s87cEeOxVLoN9yMJAm2fqNKlknTUWERPGyo7XlcXrX9hBwUwLGXS362ymV/eURa9anTV
         D4MfgZWFHNhUUa3AAv+NEM4YTsZeC//imWkt35+pGSvrfVc3lC0Ss+2A5hqGWXx3QDGp
         mTZnKJnx9eFdR2g75sljm8smhJt8D/T9VapDWO63o4CM3nXdhPLXICpfQI+5mKZcy/V/
         u/7Q==
X-Gm-Message-State: AOAM531R0i4NkVwNeVE9/YWj9krX3l71T6YzvTIWIhZloejBQzc+cldb
        qLx6Ucck9WEky/Ho/d1VIgDHczMWEgM=
X-Google-Smtp-Source: ABdhPJwvcJFEiRhAiBRwDazWgAoJllUy/xKB+xH5r9XKooySgr+t4c6UUaye95GL9YTq2Nld9SB0dw==
X-Received: by 2002:a05:6808:84:: with SMTP id s4mr535507oic.87.1619108030316;
        Thu, 22 Apr 2021 09:13:50 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-e336-c4b4-ca5e-5b3f.res6.spectrum.com. [2603:8081:140c:1a00:e336:c4b4:ca5e:5b3f])
        by smtp.gmail.com with ESMTPSA id v12sm698171ota.63.2021.04.22.09.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 09:13:49 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v5 06/10] RDMA/rxe: Move local ops to subroutine
Date:   Thu, 22 Apr 2021 11:13:37 -0500
Message-Id: <20210422161341.41929-7-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210422161341.41929-1-rpearson@hpe.com>
References: <20210422161341.41929-1-rpearson@hpe.com>
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

