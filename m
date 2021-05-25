Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0D8390BA3
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 23:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbhEYVkG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 17:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbhEYVkF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 May 2021 17:40:05 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEAEC061756
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 14:38:34 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id x15so31633274oic.13
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 14:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZMY8b1tjz2YG/shEnfos8gYNdvZROrbl7LCopGoAwvk=;
        b=lPrF/fPvoMmGyfbRidIy8GyKDelNBOM7Xs8Mi4KVGyybHaPKjfrBfgTSTN7P63+VXW
         MrVDKzW+i6boBbNouAkLVr3tncxzdyLN/LzT3zWuFxSuuKNSRqvIYIi0H7gmhlz63Jit
         oPE0dAuW3PG3GfklSDP7EosznIiS5Z9ZKxAGd4in6R13DNvHnp0JsBHkJ3u9mGDG5e1T
         s01Sfn+bsryy5oIB/e7ctPBx77aiYM9xVulaDZcb01cLH7EednGE095ifZKok3V/eBCX
         FBtSkYmkutDioy+ceandzIsOEqq+GjjkXZBWFuH6HGtfJjdLQpu85RYwstRUzg4zt1Gc
         XDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZMY8b1tjz2YG/shEnfos8gYNdvZROrbl7LCopGoAwvk=;
        b=XWGP7VLv5PNTYYqhTGPlIUbO8NDjrCEStSYYGeXGmFQ/PbOXl2xmdECPxXo9sBbOSX
         gcADu9drcb/4GNTMSVhDGhrtOiZGpAZPnC1Hn5m/SfdlxBeLW3tcaOqC0QL3NBXf6fkH
         qPA0BDe0u0zPFHBU3+Tqk2iwoFttNlaFSMzsp/nLIXN72uSFtHsze82dUTBU1Htrwj/E
         LTXOr8Gwi6bYa/TQFQgI4oBi8rEgaIfegg6dhIr6SFyQdw9FNtWQRYv6+APJuPGlnZ4i
         Q020/jfmCvXHquHez2ulRF30/b9QdkAa8n7xei/MgctDtm6sf00Jsd4uxv/0ziT9eXN1
         k9gw==
X-Gm-Message-State: AOAM533Jm8NjEM//lzKu8Kf9HfVoRQKbHn0QmkSL+O2Kb3xjgZ/P0aCT
        8p2OiVsGAi0fbTAtUmiXYHU=
X-Google-Smtp-Source: ABdhPJym9Zd6z+//h+Pz05dzF/bqiTge7piBElnyBhJRUCXNLNePaHibmyJ7q8Uh+OFx8YWflrF+LA==
X-Received: by 2002:aca:4a8b:: with SMTP id x133mr16004630oia.124.1621978714042;
        Tue, 25 May 2021 14:38:34 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-e4a4-ac6f-8cca-71ad.res6.spectrum.com. [2603:8081:140c:1a00:e4a4:ac6f:8cca:71ad])
        by smtp.gmail.com with ESMTPSA id r124sm3479856oig.38.2021.05.25.14.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 14:38:33 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v8 06/10] RDMA/rxe: Move local ops to subroutine
Date:   Tue, 25 May 2021 16:37:48 -0500
Message-Id: <20210525213751.629017-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210525213751.629017-1-rpearsonhpe@gmail.com>
References: <20210525213751.629017-1-rpearsonhpe@gmail.com>
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

