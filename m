Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80E139EDAE
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 06:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhFHE22 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 00:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhFHE2Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 00:28:25 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE89DC061789
        for <linux-rdma@vger.kernel.org>; Mon,  7 Jun 2021 21:26:18 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id u11so20357450oiv.1
        for <linux-rdma@vger.kernel.org>; Mon, 07 Jun 2021 21:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MweJodyMfd5S1X8O7Yk0+lyl4lshU779R7fjC0A5hks=;
        b=TaxE3tmpyIYKLud0qjIwfxa3Ck9bbH17TVZCHGd1RaRWTFCiYMK76Wlo7oUbsfNPBd
         7p+jB7hj1v00/Xb3YpTwI9Yihwkt8QdddUP5W9lH+HlubYDY9mrQlkZqo/whGaeGZelo
         q1769cL04QPMcX1op2VeKX1z1VX5DMs4SQYHotL9PTYY/UlMaH7CAIob6R5yPifptgfx
         2dP5PL/SKtuYUJAdRBhidKZlqcy1bZMwTIKAy0JRFG6WcPwVi4PrAGiEVLyXA+JCLYmz
         AE9iZZZhw+bAUlUbklCAGq3mo5zcRilpKYsOKyLFpPhyxd/t/LUGztOVJESbdkwcdD0V
         x8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MweJodyMfd5S1X8O7Yk0+lyl4lshU779R7fjC0A5hks=;
        b=dl07vP0okk32E4k1TuWO/8dC2H8gcHhiEtPP9C+WAiblAKQov15FBo/Up8jiL7icEX
         4wVq9agVounIVr/n9kBzEH34+zSSg8gUvNZdqDv3+hN5JE4oEV4xXivMV2kM95toxyu9
         o4hsLhC4dy1gK2gNSSTBQ6Ndzl7O5hn7TSfi415op3CYTMGQY3r8ZlyXAg/sQ55iTm5H
         Y+RyPcw1uZ6TCZNoPKecfJdermgsmFCjtw1bWpW4ApoUYxLSKBW0h8vQpJ4/mVlfMuJN
         JVy7/+/VKpirdC12NHV498uGmnyXrDuQHF5YG1BNQ4KAM5XBa/YWeVtc+Qyfe4wZqcq6
         1BUQ==
X-Gm-Message-State: AOAM532Dq+bg1qhxTM5OwS1s0lDlE2Rv+1yV9mkRHyuSQDZ4WsUZhL/x
        zXBfCRyJck7tjjUu9Aluuio=
X-Google-Smtp-Source: ABdhPJzsuADCbagPnQvbMsD7vXmJrcnvedjFouDC4zsFKERKN7gYZXHpJ30mcNu3wdeBtw+qr9YXzg==
X-Received: by 2002:aca:aad2:: with SMTP id t201mr1607866oie.117.1623126376499;
        Mon, 07 Jun 2021 21:26:16 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-cb25-4f27-0965-41cc.res6.spectrum.com. [2603:8081:140c:1a00:cb25:4f27:965:41cc])
        by smtp.gmail.com with ESMTPSA id b8sm2869815ots.6.2021.06.07.21.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 21:26:16 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, monis@mellanox.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v9 06/10] RDMA/rxe: Move local ops to subroutine
Date:   Mon,  7 Jun 2021 23:25:49 -0500
Message-Id: <20210608042552.33275-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210608042552.33275-1-rpearsonhpe@gmail.com>
References: <20210608042552.33275-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Simplify rxe_requester() by moving the local operations to a subroutine.
Add an error return for illegal send WR opcode.  Moved next_index ahead
of rxe_run_task which fixed a small bug where work completions were
delayed until after the next wqe which was not the intended behavior.
Let errors return their own WC status. Previously all errors were
reported as protection errors which was incorrect. Changed the return of
errors from rxe_do_local_ops() to err: which causes an immediate completion.
Without this an error on a last WR may get lost. Changed fill_packet() to
finish_packet() which is more accurate.

Fixes: 8700e2e7c485 ("The software RoCE driver")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v9:
  Fixed long standing incorrect WC status values and error returns.
---
 drivers/infiniband/sw/rxe/rxe_req.c | 103 +++++++++++++++++-----------
 1 file changed, 63 insertions(+), 40 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 889c7fea6f18..80872ec54219 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -462,7 +462,7 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 	return skb;
 }
 
-static int fill_packet(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
+static int finish_packet(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		       struct rxe_pkt_info *pkt, struct sk_buff *skb,
 		       int paylen)
 {
@@ -578,6 +578,54 @@ static void update_state(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
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
@@ -618,42 +666,11 @@ int rxe_requester(void *arg)
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
-			goto exit;
-		}
-		if ((wqe->wr.send_flags & IB_SEND_SIGNALED) ||
-		    qp->sq_sig_type == IB_SIGNAL_ALL_WR)
-			rxe_run_task(&qp->comp.task, 1);
-		qp->req.wqe_index = next_index(qp->sq.queue,
-						qp->req.wqe_index);
-		goto next_wqe;
+		ret = rxe_do_local_ops(qp, wqe);
+		if (unlikely(ret))
+			goto err;
+		else
+			goto next_wqe;
 	}
 
 	if (unlikely(qp_type(qp) == IB_QPT_RC &&
@@ -711,11 +728,17 @@ int rxe_requester(void *arg)
 	skb = init_req_packet(qp, wqe, opcode, payload, &pkt);
 	if (unlikely(!skb)) {
 		pr_err("qp#%d Failed allocating skb\n", qp_num(qp));
+		wqe->status = IB_WC_LOC_QP_OP_ERR;
 		goto err;
 	}
 
-	if (fill_packet(qp, wqe, &pkt, skb, payload)) {
-		pr_debug("qp#%d Error during fill packet\n", qp_num(qp));
+	ret = finish_packet(qp, wqe, &pkt, skb, payload);
+	if (unlikely(ret)) {
+		pr_debug("qp#%d Error during finish packet\n", qp_num(qp));
+		if (ret == -EFAULT)
+			wqe->status = IB_WC_LOC_PROT_ERR;
+		else
+			wqe->status = IB_WC_LOC_QP_OP_ERR;
 		kfree_skb(skb);
 		goto err;
 	}
@@ -740,6 +763,7 @@ int rxe_requester(void *arg)
 			goto exit;
 		}
 
+		wqe->status = IB_WC_LOC_QP_OP_ERR;
 		goto err;
 	}
 
@@ -748,7 +772,6 @@ int rxe_requester(void *arg)
 	goto next_wqe;
 
 err:
-	wqe->status = IB_WC_LOC_PROT_ERR;
 	wqe->state = wqe_state_error;
 	__rxe_do_task(&qp->comp.task);
 
-- 
2.30.2

