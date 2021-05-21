Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F97538CED0
	for <lists+linux-rdma@lfdr.de>; Fri, 21 May 2021 22:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhEUUUm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 May 2021 16:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhEUUUl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 May 2021 16:20:41 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19506C061574
        for <linux-rdma@vger.kernel.org>; Fri, 21 May 2021 13:19:18 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso19145057otn.3
        for <linux-rdma@vger.kernel.org>; Fri, 21 May 2021 13:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZMY8b1tjz2YG/shEnfos8gYNdvZROrbl7LCopGoAwvk=;
        b=VfM4Qh+JNsNssmTWcLLXemAS8yxqBJJXQU/vjI5ib9tQ/hvxR/8/3UMsjWC9sUP8wD
         6m6+7cwo598t8sHuyV82DKSi6DQ8V+TVVTfSxmIvdg6krlxlR2y9KVihLsSSAxeVn15a
         CRewT8rf5FJ2v1JDuUK2jyXl3YFnEKfyNa8lYedgWjTFJQ/q9MsGAWJ6tEO2Rtru1nwr
         O4Q3blY7L05uwUCZQ7oq9iTIDa27wEF9iGagVxDHrQ15IJQEJhVBCjBjq3IlKLejC6KR
         HfSyWpwVFGUq4VUNDr5G43H15z2NAINizwEH2K7pIE/uLoQr14LEzDKlsjGXzjICNooz
         colw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZMY8b1tjz2YG/shEnfos8gYNdvZROrbl7LCopGoAwvk=;
        b=AQ+uZgwIHdlATR94C4ZEpp+bIQlfQLMfp8iywYvAy75IWuqEXep6M1K/dUVYxY8GgX
         +dRBahod+MkF3BIFm4EjSdClwL2GQMu4gxuuA+mpv+oFKaOvJ267UZoYHvFz1BCTlY4P
         QggQrE1m8cZNN9RVKhH6UhQET4pXNY12c2hvmJ/jQ0v6Jc5GwHPm/dom9HT4PoKcHDSd
         a6TdS8bV58JXUBIo4UV1KylVkYVX3stn0k/UuARS6Gr4sFHNHB6Cn0Bip874h7T1msHL
         x44v+LPBGX+rgBkHdLJUbDadyVJXHq8r84uwGpbsD4UT8CDzYnjPIdESs2p3CihoQyvK
         Y/gw==
X-Gm-Message-State: AOAM530pmc28BasXpfcy25ihJfIK8H33xCFd/YFdaxA0j+eFYSpG/h8R
        T31O66XpYSJTlvfcFiJ+YlU=
X-Google-Smtp-Source: ABdhPJx0SaEjj91/yDTMGY7vPZfgKL7P0iQVEJx3DIBTlW2MZf+omfle59z4+A5g/1jSSGTbB/o3Mg==
X-Received: by 2002:a9d:7a99:: with SMTP id l25mr9797731otn.97.1621628357530;
        Fri, 21 May 2021 13:19:17 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-7300-72eb-72bd-e6db.res6.spectrum.com. [2603:8081:140c:1a00:7300:72eb:72bd:e6db])
        by smtp.gmail.com with ESMTPSA id l186sm1314822oih.55.2021.05.21.13.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 13:19:17 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v7 06/10] RDMA/rxe: Move local ops to subroutine
Date:   Fri, 21 May 2021 15:18:21 -0500
Message-Id: <20210521201824.659565-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210521201824.659565-1-rpearsonhpe@gmail.com>
References: <20210521201824.659565-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Simplify rxe_requester() by moving the local operations to a subroutine.
Add an error return for illegal send WR opcode.  Moved next_index ahead
of rxe_run_task which fixed a small bug where work completions were
delayed until after the next wqe which was not the intended behavior.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 89 +++++++++++++++++------------
 1 file changed, 54 insertions(+), 35 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 0d4dcd514c55..9163aac41848 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -555,6 +555,56 @@ static void update_state(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 			  jiffies + qp->qp_timeout_jiffies);
 }
 
+static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
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
+		ret = rxe_do_local_ops(qp, wqe);
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
2.30.2

