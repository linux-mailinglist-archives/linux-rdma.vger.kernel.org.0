Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5B9367946
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 07:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhDVF32 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Apr 2021 01:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhDVF31 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Apr 2021 01:29:27 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF529C06174A
        for <linux-rdma@vger.kernel.org>; Wed, 21 Apr 2021 22:28:53 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id i81so44733459oif.6
        for <linux-rdma@vger.kernel.org>; Wed, 21 Apr 2021 22:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QCOXR31Q2h/pgBTNlZj4sVWnF1hxQSkZsFCgSfz5iXo=;
        b=c6HPtAauZ/m5qc/39/bnEvrTuLGwnwpWhKaTredBvQsgY5Cf5SnWnVtHk6Ep78eLvm
         Ag866Sz8SZKc4haq0o6E/AIHER6j0ERm6+3QFc4iDrslmkp5uBE6pLNSOrpEPg1CUeac
         oAQiM4tbhv25DWXjy1Afqk8jIWs+v7qXDt4VrIwqca1Whvu5Vk/0bI+WrbFxodFPDhd2
         ljF1lKPdbmP/DTbkaj7LalPIZ2NGrAvTpbVGbYlaxWNlx5qIO/ftM0ECC7wWSpymdJiY
         gNnPUqG/jdJT2gwbnPHBuVAuI7nk8ZXOZ/dNwBMnr2bcFqk6ZuVsgjSJLlYk5WahxTFn
         M4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QCOXR31Q2h/pgBTNlZj4sVWnF1hxQSkZsFCgSfz5iXo=;
        b=Pc9iuX3fDz3swI0MnatPpjXWDLskXwiXBtKmntuPoX1rw0B22RlbnuceLy23l6LLG5
         02itqAFPHQ/qPcBg2MIHts2vxGGUF+JhlzptMEpUm+W+ZjHSUA4lR+6WzePUCIT+f1fn
         gQHfyFLw0Mswb/5kVWAWLEQFgZ+VjRtzLIMq0wYp4JOHsdbUcdWaTNb834HFlCqLkY65
         fWpCgLtp7ShHPCylpB/PICfUG5XO1l0qR+Jj+jQZs5hZAfjwvZZ5Jb++fk0smD6cRilE
         ln3qg4xD7Mwa+8cirLlusRN9WhQ5irA1ACGPE47efS7FXL+JlJiTDLa9kVxvpgiESLK+
         SD4Q==
X-Gm-Message-State: AOAM533R5PlZOzTyMtFsBd26hdN7lNV16D9ksxIw4nUiqY51Z0boxIJ8
        on9PrbDNANGKH7d61HCyiZA=
X-Google-Smtp-Source: ABdhPJzRv/yFsrTXOTRT+YpWujQ6LmLzCOm9+M+z7Gvw7EZFrdFpZ1UtOZoc2DmqUL7VoNeGwmM7ag==
X-Received: by 2002:aca:4b90:: with SMTP id y138mr1032893oia.169.1619069333138;
        Wed, 21 Apr 2021 22:28:53 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-e336-c4b4-ca5e-5b3f.res6.spectrum.com. [2603:8081:140c:1a00:e336:c4b4:ca5e:5b3f])
        by smtp.gmail.com with ESMTPSA id z25sm402185otm.34.2021.04.21.22.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 22:28:52 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v4 06/10] RDMA/rxe: Move local ops to subroutine
Date:   Thu, 22 Apr 2021 00:28:19 -0500
Message-Id: <20210422052822.36527-7-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210422052822.36527-1-rpearson@hpe.com>
References: <20210422052822.36527-1-rpearson@hpe.com>
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

