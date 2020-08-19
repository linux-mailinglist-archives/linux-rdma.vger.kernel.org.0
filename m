Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C490249392
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Aug 2020 05:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgHSDny (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 23:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgHSDnx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 23:43:53 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7069C061389
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 20:43:53 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id j7so19863488oij.9
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 20:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DBv+rn7JcB5qnZdj5a6+OERLF+F9NtVMpN6VznHKO6E=;
        b=S1NXsibGf8HeC/3KT1EspN7g9AMsQtPrYyREcQ0riIpiRVVwgtD2g0WyngyGlcD46a
         zt7CSoFhgBmJgEQ43f32HVcqw3E/jPtJZm/JLq5o7aBQr3fgP0iQmRYNVPzesNzNq1bY
         GZ2km3SXVQlZndIzXa8550NvtVpw6geqhqLTKRVilJB229xBeAaNHqmKRYQAnDk5XHu5
         Jimjwf95H1E0fiD/jT9yEAYVtowrdqU/syYnWv8JvnKDo4K+jKrNukREd/sZBf3LRwlZ
         rENFUS5Y5VvK7m9TeP/A2Q+6diu40x07znR4rRRvgay+cU9sD4p5z+3j4OIywta1OACA
         N3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DBv+rn7JcB5qnZdj5a6+OERLF+F9NtVMpN6VznHKO6E=;
        b=sa9T1t3lDRo9c7G1aFkasXCduoFE2/Jt7fyBlnlGyvZgKr9DVBh6AfQ1BlLFX0XZ3K
         VE825iIu+NaEl01qoKAwWe4AWNfcosIdhSkobONoMKal6DJj8WNhHRNWrfFGfHja1fxn
         /3VWwqU98NQ6gWzy65pBt0zoJRR+QpCJQVEaOLHMo2q2+OmYECc3A4ZReBUNyfnAsrQs
         EdyQ2nqJoRWWFIuWbtueeQUgGmETYkmIfXxEF2tSlthWkMNDhsPk3jGYNuD/riJAqzcA
         H69P7qgmzIUeKsTL5ZUS8dn01HQY0fIhYWchYnuPxHG6hr+ngdO1V8i15Tkm29BzRmNt
         eBIQ==
X-Gm-Message-State: AOAM532/S2M8H+GwKOqwY2eCh39KoUfyKUDDESw9TCAC9iOtG2hFbgvr
        38xBAlDEDQt1K5a/GioCXH8=
X-Google-Smtp-Source: ABdhPJzSz+IDXBKjRtGz773vEXk/SqXOIKOcAL8CDk2wX0tBuSACuRugT2e1YfT7Z2jhRjdJBvPmrQ==
X-Received: by 2002:aca:aa13:: with SMTP id t19mr2111525oie.59.1597808632888;
        Tue, 18 Aug 2020 20:43:52 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:2731:80e6:14c6:1150])
        by smtp.gmail.com with ESMTPSA id m24sm4283011oof.5.2020.08.18.20.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 20:43:52 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v2 12/16] rdma_rxe: Added bind mw API stub
Date:   Tue, 18 Aug 2020 22:40:10 -0500
Message-Id: <20200819034002.8835-13-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819034002.8835-1-rpearson@hpe.com>
References: <20200819034002.8835-1-rpearson@hpe.com>
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
index e45fc3bfb1a7..388492317e2c 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -118,6 +118,7 @@ int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
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
index 49eb0d8d00ec..ef71899e81c8 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -564,6 +564,8 @@ static void update_state(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 int rxe_requester(void *arg)
 {
 	struct rxe_qp *qp = (struct rxe_qp *)arg;
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	struct rxe_mr *mr;
 	struct rxe_pkt_info pkt;
 	struct sk_buff *skb;
 	struct rxe_send_wqe *wqe;
@@ -599,42 +601,55 @@ int rxe_requester(void *arg)
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
 
@@ -654,6 +669,7 @@ int rxe_requester(void *arg)
 	opcode = next_opcode(qp, wqe, wqe->wr.opcode);
 	if (unlikely(opcode < 0)) {
 		wqe->status = IB_WC_LOC_QP_OP_ERR;
+		/* TODO this should be goto err */
 		goto exit;
 	}
 
@@ -683,8 +699,7 @@ int rxe_requester(void *arg)
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
 			__rxe_do_task(&qp->comp.task);
-			rxe_drop_ref(qp);
-			return 0;
+			goto again;
 		}
 		payload = mtu;
 	}
@@ -692,12 +707,14 @@ int rxe_requester(void *arg)
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
 
@@ -721,6 +738,7 @@ int rxe_requester(void *arg)
 			goto exit;
 		}
 
+		wqe->status = IB_WC_LOC_PROT_ERR;
 		goto err;
 	}
 
@@ -729,11 +747,35 @@ int rxe_requester(void *arg)
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
index fabe47c5db6f..92874247851f 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -579,7 +579,7 @@ static int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	    qp_type(qp) == IB_QPT_GSI)
 		memcpy(&wqe->av, &to_rah(ud_wr(ibwr)->ah)->av, sizeof(wqe->av));
 
-	if (mask & WR_REG_MASK) {
+	if (mask & WR_LOCAL_MASK) {
 		wqe->mask = mask;
 		wqe->state = wqe_state_posted;
 		return 0;
-- 
2.25.1

