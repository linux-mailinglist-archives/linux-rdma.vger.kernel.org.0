Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B80424C7F3
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Aug 2020 00:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgHTWri (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 18:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728577AbgHTWrY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Aug 2020 18:47:24 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A70C061346
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:24 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id a65so143405otc.8
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C8jhfETyqFrCgXGtPd3t92/ImEuvn568glLzmEPLORs=;
        b=bHq1hmVmRoEkIOvV34y46lOLLCtxhUP4JAX6vcXXHxk00gawxIAG1EPAcp3mfrCjPL
         ecaepM/n/VtbeWNMDALc/ernkpOdMr6nZMl3y+plqlnNK7L4o0jaO9Kk/qynI8iHpMdi
         qHhPdC0UxqhWy6IY1wf6lzg7svyWFGwGjRKuLddqgX4CNe6CoCahFoGOT/dZS0DEXQCT
         PNYP7SOBeJKmkGTN4c5m1a9vaot6Xi6d/z87wszSOhSn3l65K/tsXhsm8NjQ8VuXyAM6
         8KNqqWB0LqrpHjnBAtCp2eLITC8YmANAHMKqfDylG833P6LHIdCHsWNqoHx2SBV+c4Lv
         /wrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C8jhfETyqFrCgXGtPd3t92/ImEuvn568glLzmEPLORs=;
        b=unj7yzU0hbMr+M5FSk098xhr3tzY1vdJNizZd5Z1n1sSaC0/iuYMUEslbbU7CKLAiu
         HmfxPKGG8/iy6/xloxFLlWq53zmiKg2SOljzgHeC5plsk0y+eUXVgatMM9rDhwIGJLPg
         kr711qTP0XIzuLiOo/MccQd6/fYBq3Z9LvDA0cmxEZqfWHHu5N3Qckp23ZHw6qSakEe1
         74otNsiKWmLlY8Xfo3bH1PLVOvRTaMqXvMREn90ype2HuUYfrAvvdbix8uB65+3TLDeu
         vnwy8XBR6lL7hTRPaHwQTUeqc391YtX6FPWG2v4wCNNeIgoRSTwvNapmdqH7gSw9fawA
         xp6A==
X-Gm-Message-State: AOAM531MdCHcpNjsOYePwGG/5qyCza9Pr1JOaiW2nssDBIFNavZFb5q+
        noWG8BF89i59eUN3mQYcpE4aSNGALBKlpA==
X-Google-Smtp-Source: ABdhPJysp2Ij1UKvf6Zzf2dXcooNZ2ridTyDPDGrIv52LiDyOPJj2Xrm+msNp6wSPUBsdGrI2iMTxA==
X-Received: by 2002:a05:6830:1e4c:: with SMTP id e12mr655968otj.193.1597963642661;
        Thu, 20 Aug 2020 15:47:22 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:e2a0:5228:a0c3:36eb])
        by smtp.gmail.com with ESMTPSA id e9sm16695oog.10.2020.08.20.15.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 15:47:22 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v3 12/17] rdma_rxe: Added bind mw API stub
Date:   Thu, 20 Aug 2020 17:46:33 -0500
Message-Id: <20200820224638.3212-13-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820224638.3212-1-rpearson@hpe.com>
References: <20200820224638.3212-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In rxe_opcode.c
Added bind MW WR opcode
Changed RXE_REG_MASK to RXE_LOCAL_MASK since it refers to
local wqe commands generally.

In rxe_req.c
Added a local bind MW operation
Changes the error returns to each have a separate status.
Fixed a bug which caused rxe_comp to not report bind errors in WCs.
Noted a couple of more unrelated bugs for later fix up.

In rxe_mw.c
Added a stub for bind_mw

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c   |  1 +
 drivers/infiniband/sw/rxe/rxe_loc.h    |  1 +
 drivers/infiniband/sw/rxe/rxe_mw.c     |  6 ++
 drivers/infiniband/sw/rxe/rxe_opcode.c | 11 ++-
 drivers/infiniband/sw/rxe/rxe_opcode.h |  1 -
 drivers/infiniband/sw/rxe/rxe_req.c    | 92 +++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_verbs.c  |  2 +-
 7 files changed, 85 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 54fc55487bc0..c0fd1bad8c55 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -105,6 +105,7 @@ static enum ib_wc_opcode wr_to_wc_opcode(enum ib_wr_opcode opcode)
 	case IB_WR_RDMA_READ_WITH_INV:		return IB_WC_RDMA_READ;
 	case IB_WR_LOCAL_INV:			return IB_WC_LOCAL_INV;
 	case IB_WR_REG_MR:			return IB_WC_REG_MR;
+	case IB_WR_BIND_MW:			return IB_WC_BIND_MW;
 
 	default:
 		return 0xff;
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index cbed269edfe7..18ae0eb11fa8 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -115,6 +115,7 @@ int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
 struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 			   struct ib_udata *udata);
 int rxe_dealloc_mw(struct ib_mw *ibmw);
+int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 
 /* rxe_net.c */
 void rxe_loopback(struct sk_buff *skb);
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index ea8510044fbe..b461aed98c0c 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -67,3 +67,9 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 
 	return 0;
 }
+
+int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
+{
+	pr_err_once("%s: not implemented\n", __func__);
+	return -EINVAL;
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
index ddfc08c14893..0a34075ef25a 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -89,13 +89,20 @@ struct rxe_wr_opcode_info rxe_wr_opcode_info[] = {
 	[IB_WR_LOCAL_INV]				= {
 		.name	= "IB_WR_LOCAL_INV",
 		.mask	= {
-			[IB_QPT_RC]	= WR_REG_MASK,
+			[IB_QPT_RC]	= WR_LOCAL_MASK,
 		},
 	},
 	[IB_WR_REG_MR]					= {
 		.name	= "IB_WR_REG_MR",
 		.mask	= {
-			[IB_QPT_RC]	= WR_REG_MASK,
+			[IB_QPT_RC]	= WR_LOCAL_MASK,
+		},
+	},
+	[IB_WR_BIND_MW]					= {
+		.name	= "IB_WR_BIND_MW",
+		.mask	= {
+			[IB_QPT_RC]	= WR_LOCAL_MASK,
+			[IB_QPT_UC]	= WR_LOCAL_MASK,
 		},
 	},
 };
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.h b/drivers/infiniband/sw/rxe/rxe_opcode.h
index 59e8b3875826..4775453409d9 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.h
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.h
@@ -22,7 +22,6 @@ enum rxe_wr_mask {
 	WR_READ_MASK			= BIT(3),
 	WR_WRITE_MASK			= BIT(4),
 	WR_LOCAL_MASK			= BIT(5),
-	WR_REG_MASK			= BIT(6),
 
 	WR_READ_OR_WRITE_MASK		= WR_READ_MASK | WR_WRITE_MASK,
 	WR_READ_WRITE_OR_SEND_MASK	= WR_READ_OR_WRITE_MASK | WR_SEND_MASK,
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index ffc8f65b2ad7..46550a6fd6f8 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -561,6 +561,8 @@ static void update_state(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 int rxe_requester(void *arg)
 {
 	struct rxe_qp *qp = (struct rxe_qp *)arg;
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	struct rxe_mr *mr;
 	struct rxe_pkt_info pkt;
 	struct sk_buff *skb;
 	struct rxe_send_wqe *wqe;
@@ -596,42 +598,55 @@ int rxe_requester(void *arg)
 	if (unlikely(!wqe))
 		goto exit;
 
-	if (wqe->mask & WR_REG_MASK) {
-		if (wqe->wr.opcode == IB_WR_LOCAL_INV) {
-			struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
-			struct rxe_mr *rmr;
-
-			rmr = rxe_pool_get_index(&rxe->mr_pool,
-						 wqe->wr.ex.invalidate_rkey >> 8);
-			if (!rmr) {
+	if (wqe->mask & WR_LOCAL_MASK) {
+		switch (wqe->wr.opcode) {
+		case IB_WR_LOCAL_INV:
+			mr = rxe_pool_get_index(&rxe->mr_pool,
+					wqe->wr.ex.invalidate_rkey >> 8);
+			if (!mr) {
 				pr_err("No mr for key %#x\n",
 				       wqe->wr.ex.invalidate_rkey);
 				wqe->state = wqe_state_error;
 				wqe->status = IB_WC_MW_BIND_ERR;
+				/* TODO this should be goto err */
 				goto exit;
 			}
-			rmr->state = RXE_MEM_STATE_FREE;
-			rxe_drop_ref(rmr);
+			mr->state = RXE_MEM_STATE_FREE;
+			rxe_drop_ref(mr);
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
-		} else if (wqe->wr.opcode == IB_WR_REG_MR) {
-			struct rxe_mr *rmr = to_rmr(wqe->wr.wr.reg.mr);
-
-			rmr->state = RXE_MEM_STATE_VALID;
-			rmr->access = wqe->wr.wr.reg.access;
-			rmr->lkey = wqe->wr.wr.reg.key;
-			rmr->rkey = wqe->wr.wr.reg.key;
-			rmr->iova = wqe->wr.wr.reg.mr->iova;
+			break;
+		case IB_WR_REG_MR:
+			mr = to_rmr(wqe->wr.wr.reg.mr);
+			mr->state = RXE_MEM_STATE_VALID;
+			mr->access = wqe->wr.wr.reg.access;
+			mr->lkey = wqe->wr.wr.reg.key;
+			mr->rkey = wqe->wr.wr.reg.key;
+			mr->iova = wqe->wr.wr.reg.mr->iova;
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
-		} else {
+			break;
+		case IB_WR_BIND_MW:
+			ret = rxe_bind_mw(qp, wqe);
+			if (ret) {
+				wqe->state = wqe_state_done;
+				wqe->status = IB_WC_MW_BIND_ERR;
+				goto err;
+			}
+			wqe->state = wqe_state_done;
+			wqe->status = IB_WC_SUCCESS;
+			break;
+		default:
+			pr_err_once("unexpected LOCAL WR opcode = %d\n",
+					wqe->wr.opcode);
 			goto exit;
 		}
+		qp->req.wqe_index = next_index(qp->sq.queue,
+						qp->req.wqe_index);
+
 		if ((wqe->wr.send_flags & IB_SEND_SIGNALED) ||
 		    qp->sq_sig_type == IB_SIGNAL_ALL_WR)
 			rxe_run_task(&qp->comp.task, 1);
-		qp->req.wqe_index = next_index(qp->sq.queue,
-						qp->req.wqe_index);
 		goto next_wqe;
 	}
 
@@ -651,6 +666,7 @@ int rxe_requester(void *arg)
 	opcode = next_opcode(qp, wqe, wqe->wr.opcode);
 	if (unlikely(opcode < 0)) {
 		wqe->status = IB_WC_LOC_QP_OP_ERR;
+		/* TODO this should be goto err */
 		goto exit;
 	}
 
@@ -680,8 +696,7 @@ int rxe_requester(void *arg)
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
 			__rxe_do_task(&qp->comp.task);
-			rxe_drop_ref(qp);
-			return 0;
+			goto again;
 		}
 		payload = mtu;
 	}
@@ -689,12 +704,14 @@ int rxe_requester(void *arg)
 	skb = init_req_packet(qp, wqe, opcode, payload, &pkt);
 	if (unlikely(!skb)) {
 		pr_err("qp#%d Failed allocating skb\n", qp_num(qp));
+		wqe->status = IB_WC_LOC_PROT_ERR;
 		goto err;
 	}
 
 	if (fill_packet(qp, wqe, &pkt, skb, payload)) {
 		pr_debug("qp#%d Error during fill packet\n", qp_num(qp));
 		kfree_skb(skb);
+		wqe->status = IB_WC_LOC_PROT_ERR;
 		goto err;
 	}
 
@@ -718,6 +735,7 @@ int rxe_requester(void *arg)
 			goto exit;
 		}
 
+		wqe->status = IB_WC_LOC_PROT_ERR;
 		goto err;
 	}
 
@@ -726,11 +744,35 @@ int rxe_requester(void *arg)
 	goto next_wqe;
 
 err:
-	wqe->status = IB_WC_LOC_PROT_ERR;
+	/* we come here if an error occurred while processing
+	 * a send wqe. The completer will put the qp in error
+	 * state and no more wqes will be processed unless
+	 * the qp is cleaned up and restarted. We do not want
+	 * to be called again
+	 */
 	wqe->state = wqe_state_error;
 	__rxe_do_task(&qp->comp.task);
+	ret = -EAGAIN;
+	goto done;
 
 exit:
+	/* we come here if either there are no more wqes in the send
+	 * queue or we are blocked waiting for some resource or event.
+	 * The current wqe will be restarted or new wqe started when
+	 * there is work to do or we can complete the current wqe.
+	 */
+	ret = -EAGAIN;
+	goto done;
+
+again:
+	/* we come here if we are done with the current wqe but want to
+	 * get called again. Mostly we loop back to next wqe so should
+	 * be all one way or the other
+	 */
+	ret = 0;
+	goto done;
+
+done:
 	rxe_drop_ref(qp);
-	return -EAGAIN;
+	return ret;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index c0db1e318dab..d1630a2134da 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -566,7 +566,7 @@ static int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	    qp_type(qp) == IB_QPT_GSI)
 		memcpy(&wqe->av, &to_rah(ud_wr(ibwr)->ah)->av, sizeof(wqe->av));
 
-	if (mask & WR_REG_MASK) {
+	if (mask & WR_LOCAL_MASK) {
 		wqe->mask = mask;
 		wqe->state = wqe_state_posted;
 		return 0;
-- 
2.25.1

