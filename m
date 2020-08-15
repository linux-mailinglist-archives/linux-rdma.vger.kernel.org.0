Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E0D2452F9
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Aug 2020 23:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbgHOV44 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Aug 2020 17:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729013AbgHOVwK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Aug 2020 17:52:10 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79109C0612A6
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 22:00:01 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id a24so10022941oia.6
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 22:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EWlpvldw1UL3R7mZHWBRz4v8hVMQtua8A/LbwQdpQtw=;
        b=nMV+lPxCnAb50yklbrNOHp1mek+D13K3FIeNoIXhpF3m2SN4U3r1CVQfoM8ywFe6tQ
         Y3vXEZ/EpuG7nTBpljBwnMrQ5i49oy40NQoytiTm2Tb3A1KHaFfAMRcf6ZG7lFkSZVtA
         wkT0gi0jc9sB5FS7b5XVxWLn2V/IbhvPe1Ch+fnc2fnGIltKNvPAMHHSg7OG7coWJ15C
         c5I0JgNMUA2DIhveV5zUW+EyYsN8YkY8rBD1lHPTBeDfNa9ZoYSsEwUwkkNFX25/e97l
         9KsMKgLzA9y82IRPLwLrpv6FWfJkWjel1tmE/E4ADlgQcOdz9twnE8PNLWPhcjQ7Z4K2
         0tOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EWlpvldw1UL3R7mZHWBRz4v8hVMQtua8A/LbwQdpQtw=;
        b=XakRlxUzqGewsqF8F7LVq8JnMYHtaM/dq1RN2E33Izj+EopPJq+tLc+Xaz2xLp2exm
         aiF/ZlVxCIgdRQEfKAYbmD4KtluBcD5iD5S10DCGldJKHU1vIcdO9w+wfDKPrj2++Cgk
         99bclZS+wbgqemZxsI+icgxjn52GHPl/LmAQOisrzHLTc5U2GHDuXA+rSMLtNYhPtkZo
         jbNYuJ1Vt7HBTlBJa6Yg4+WgRzYCyhvVANb1gO9UaUvoUqmRFw6I6jFUdjk+m6lmkLge
         moHJbv2ElR7q00x2q60ZDgY+mB1cKpy1422GsBs+RyJf7vXKPc0DWNWMiN2q6PzPGFzw
         2uew==
X-Gm-Message-State: AOAM530AfqmDMHY8Cxv1leSG4VhuK3GH37eFqGoFaDNTBosGFA7d1Xnb
        JXwpvh1k/PqE1Fnr+T1lGJ+YK8W+lncgHg==
X-Google-Smtp-Source: ABdhPJwV7jecvFxf48NKvt3HqlwDnU2NSdL+e5Kx7363bf4aQlKIdaQ9uU0ynDsgn6Ez7K6r9BC4BQ==
X-Received: by 2002:aca:5489:: with SMTP id i131mr3604274oib.157.1597467600499;
        Fri, 14 Aug 2020 22:00:00 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:b453:c5f2:2895:a54c])
        by smtp.gmail.com with ESMTPSA id 105sm2100438oti.13.2020.08.14.22.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 22:00:00 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 08/20] Added a stubbed bind_mw API.
Date:   Fri, 14 Aug 2020 23:58:32 -0500
Message-Id: <20200815045912.8626-9-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815045912.8626-1-rpearson@hpe.com>
References: <20200815045912.8626-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Added code to implement the path to rxe_bind_mw which
is still a stub. Now the ibv_bind_mw verb can be called.

Added bind_mw work requests to the opcodes file and added the new
local operation to rxe_req. Changed WR_REG_MASK to WR_LOCAL_MASK
since it is used to identify local operations.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c   |  3 +
 drivers/infiniband/sw/rxe/rxe_loc.h    |  1 +
 drivers/infiniband/sw/rxe/rxe_mw.c     |  6 ++
 drivers/infiniband/sw/rxe/rxe_opcode.c | 11 +++-
 drivers/infiniband/sw/rxe/rxe_req.c    | 76 +++++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_task.h   |  2 +
 6 files changed, 84 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index b9b8c4e115f4..caa8ad990337 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -130,6 +130,7 @@ static enum ib_wc_opcode wr_to_wc_opcode(enum ib_wr_opcode opcode)
 	case IB_WR_RDMA_READ_WITH_INV:		return IB_WC_RDMA_READ;
 	case IB_WR_LOCAL_INV:			return IB_WC_LOCAL_INV;
 	case IB_WR_REG_MR:			return IB_WC_REG_MR;
+	case IB_WR_BIND_MW:			return IB_WC_BIND_MW;
 
 	default:
 		return 0xff;
@@ -787,6 +788,8 @@ int rxe_completer(void *arg)
 	 */
 	WARN_ON_ONCE(skb);
 	rxe_drop_ref(qp);
+	// TODO this seems plain backwards
+	// EAGAIN normally means call me again
 	return -EAGAIN;
 
 done:
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 42375af68f48..02df9bf76d1a 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -140,6 +140,7 @@ int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
 struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 			   struct ib_udata *udata);
 int rxe_dealloc_mw(struct ib_mw *ibmw);
+int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 
 /* rxe_net.c */
 void rxe_loopback(struct sk_buff *skb);
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 50cd451751b8..230263c6d3e5 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -96,3 +96,9 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 
 	return 0;
 }
+
+int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
+{
+	pr_err("rxe_bind_mw: not implemented\n");
+	return -ENOSYS;
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
index 4cf11063e0b5..d2f2092f0be5 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -114,13 +114,20 @@ struct rxe_wr_opcode_info rxe_wr_opcode_info[] = {
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
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index c566372eebf8..b402eb82b402 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -586,6 +586,8 @@ static void update_state(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 int rxe_requester(void *arg)
 {
 	struct rxe_qp *qp = (struct rxe_qp *)arg;
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	struct rxe_mr *rmr;
 	struct rxe_pkt_info pkt;
 	struct sk_buff *skb;
 	struct rxe_send_wqe *wqe;
@@ -596,9 +598,17 @@ int rxe_requester(void *arg)
 	int ret;
 	struct rxe_send_wqe rollback_wqe;
 	u32 rollback_psn;
+	int entered;
 
 	rxe_add_ref(qp);
 
+	// this code is 'guaranteed' to never be entered more
+	// than once. Check to make sure that this is the case
+	entered = atomic_inc_return(&qp->req.task.entered);
+	if (entered > 1) {
+		pr_err("rxe_requester: entered %d times\n", entered);
+	}
+
 next_wqe:
 	if (unlikely(!qp->valid || qp->req.state == QP_STATE_ERROR))
 		goto exit;
@@ -621,13 +631,11 @@ int rxe_requester(void *arg)
 	if (unlikely(!wqe))
 		goto exit;
 
-	if (wqe->mask & WR_REG_MASK) {
-		if (wqe->wr.opcode == IB_WR_LOCAL_INV) {
-			struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
-			struct rxe_mr *rmr;
-
+	if (wqe->mask & WR_LOCAL_MASK) {
+		switch (wqe->wr.opcode) {
+		case IB_WR_LOCAL_INV:
 			rmr = rxe_pool_get_index(&rxe->mr_pool,
-						 wqe->wr.ex.invalidate_rkey >> 8);
+				 wqe->wr.ex.invalidate_rkey >> 8);
 			if (!rmr) {
 				pr_err("No mr for key %#x\n",
 				       wqe->wr.ex.invalidate_rkey);
@@ -635,13 +643,16 @@ int rxe_requester(void *arg)
 				wqe->status = IB_WC_MW_BIND_ERR;
 				goto exit;
 			}
+			// TODO this can race with external access
+			// to the MR in rxe_resp unless you can know
+			// that all accesses are done
 			rmr->state = RXE_MEM_STATE_FREE;
 			rxe_drop_ref(rmr);
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
-		} else if (wqe->wr.opcode == IB_WR_REG_MR) {
-			struct rxe_mr *rmr = to_rmr(wqe->wr.wr.reg.mr);
-
+			break;
+		case IB_WR_REG_MR:
+			rmr = to_rmr(wqe->wr.wr.reg.mr);
 			rmr->state = RXE_MEM_STATE_VALID;
 			rmr->access = wqe->wr.wr.reg.access;
 			rmr->lkey = wqe->wr.wr.reg.key;
@@ -649,7 +660,21 @@ int rxe_requester(void *arg)
 			rmr->iova = wqe->wr.wr.reg.mr->iova;
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
-		} else {
+			break;
+		case IB_WR_BIND_MW:
+			ret = rxe_bind_mw(qp, wqe);
+			if (ret) {
+				wqe->state = wqe_state_done;
+				wqe->status = IB_WC_MW_BIND_ERR;
+				// TODO err: will change status
+				// probably should not
+				goto err;
+			}
+			wqe->state = wqe_state_done;
+			wqe->status = IB_WC_SUCCESS;
+			break;
+		default:
+			pr_err("rxe_requester: unexpected LOCAL WR opcode = %d\n", wqe->wr.opcode);
 			goto exit;
 		}
 		if ((wqe->wr.send_flags & IB_SEND_SIGNALED) ||
@@ -704,9 +729,10 @@ int rxe_requester(void *arg)
 						       qp->req.wqe_index);
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
+			// TODO why?? why not just treat the same as a
+			// successful wqe and go to next wqe?
 			__rxe_do_task(&qp->comp.task);
-			rxe_drop_ref(qp);
-			return 0;
+			goto again;
 		}
 		payload = mtu;
 	}
@@ -750,12 +776,36 @@ int rxe_requester(void *arg)
 
 	goto next_wqe;
 
+	// TODO this can be cleaned up
 err:
+	/* we come here if an error occured while processing
+	 * a send wqe. The completer will put the qp in error
+	 * state and no more wqes will be processed unless
+	 * the qp is cleaned up and restarted. We do not want
+	 * to be called again */
 	wqe->status = IB_WC_LOC_PROT_ERR;
 	wqe->state = wqe_state_error;
 	__rxe_do_task(&qp->comp.task);
+	ret = -EAGAIN;
+	goto done;
 
 exit:
+	/* we come here if either there are no more wqes in the send
+	 * queue or we are blocked waiting for some resource or event.
+	 * The current wqe will be restarted or new wqe started when
+	 * there is work to do. */
+	ret = -EAGAIN;
+	goto done;
+
+again:
+	/* we come here if we are done with the current wqe but want to
+	 * get called again. Mostly we loop back to next wqe so should
+	 * be all one way or the other */
+	ret = 0;
+	goto done;
+
+done:
+	atomic_dec(&qp->req.task.entered);
 	rxe_drop_ref(qp);
-	return -EAGAIN;
+	return ret;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index 08ff42d451c6..e33806c6f5a4 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -55,6 +55,8 @@ struct rxe_task {
 	int			ret;
 	char			name[16];
 	bool			destroyed;
+	// debug code, delete me when done
+	atomic_t		entered;
 };
 
 /*
-- 
2.25.1

