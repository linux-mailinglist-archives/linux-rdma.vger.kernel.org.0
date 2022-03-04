Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AAE4CCA90
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Mar 2022 01:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbiCDAJi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Mar 2022 19:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbiCDAJg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Mar 2022 19:09:36 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12234BBBF
        for <linux-rdma@vger.kernel.org>; Thu,  3 Mar 2022 16:08:48 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id d134-20020a4a528c000000b00319244f4b04so7659599oob.8
        for <linux-rdma@vger.kernel.org>; Thu, 03 Mar 2022 16:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o2aUG4D0hPr8V3HpNmOrQ5G5I7N8SaRoZffpas4ceic=;
        b=hyjAWD8dxmYUZORMpxj7/N16Czcx4nWM7z8h3h29VHhwTv41YXNPUVuFMLGqticwWE
         FlL7Ui7rtBukeju1bE3o7Pvqt2b7DyL2rMxuLDkILcKZeozY26ovComZct80yxb4DYEA
         pLDeEg4mkdM9UXqG6dk9M1Ay+inW+2SdsAH7gt3tmZSRuMV6cDHvKlgJHPadK8+OFX1q
         1jXQ3/KMDTdizWgvTkg1p6WJYqDkA7Dtgs/pA/+H7gp5nxwfn/pXlEQiVA8FW/tvmCN7
         S0V2lTHWzz/LuW9enk0qDI9zxepCPtsLrAITXfKCAjUFTv2jIfUYSLDhLMU70+z/kjPJ
         S/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o2aUG4D0hPr8V3HpNmOrQ5G5I7N8SaRoZffpas4ceic=;
        b=W7En97+aDkV+xSKIdzAaNAplOsn4G6JaiWMGr0ygPPtoHmr63qfxXD4wgAlAZfQIso
         6o3dkRpRNNnA4u8zEmElJWSBJI6/3SFapr1KHGCj7nFIPhkN6X7pst+g4omKCJONljk9
         J/U6pa1EhyyWxC4xRyFZf27IJgqaYo00YQlPMgr8/UUnjMPIVpko0sH5MURy9RdYxD5o
         zVMYn8oionr/NHR0JJ/RA6Y2Ec0/mQCcLLkyFOHFYzBsM8ENxQEh7OJgp8PXZpYPx3fJ
         TEhk0Z3ptA3EoFHobl9vaLMqA9Q2YyEz/fKm0Q84MeZiNQBQ1jxscwSh2B0dgB3CmXon
         X/NA==
X-Gm-Message-State: AOAM531/S03V14Q/eMctlxfuIxSuHVdNNdCbpcGZ6vX5PDM7jM3FHQ5L
        FdSZ+/ilmehmawO24tExasgkxAHJVUE=
X-Google-Smtp-Source: ABdhPJwbH3L1y+3xy0vqYRLQrE657cLlCl6qORNCPzJDW0UTCmHXhf6fOfvh45xydo/lJ7xa9sHWYA==
X-Received: by 2002:a05:6870:1147:b0:ce:c0c9:5ed with SMTP id 7-20020a056870114700b000cec0c905edmr6060614oag.63.1646352527964;
        Thu, 03 Mar 2022 16:08:47 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-4a4e-f957-5a09-0218.res6.spectrum.com. [2603:8081:140c:1a00:4a4e:f957:5a09:218])
        by smtp.googlemail.com with ESMTPSA id n23-20020a9d7417000000b005afc3371166sm1646469otk.81.2022.03.03.16.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:08:47 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v11 09/13] RDMA/rxe: Use standard names for ref counting
Date:   Thu,  3 Mar 2022 18:08:05 -0600
Message-Id: <20220304000808.225811-10-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304000808.225811-1-rpearsonhpe@gmail.com>
References: <20220304000808.225811-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Rename rxe_add_ref() to rxe_get() and rxe_drop_ref() to rxe_put().
Significantly improves readability for new readers.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_av.c    |  4 +--
 drivers/infiniband/sw/rxe/rxe_comp.c  |  8 +++---
 drivers/infiniband/sw/rxe/rxe_mcast.c |  4 +--
 drivers/infiniband/sw/rxe/rxe_mr.c    | 14 +++++-----
 drivers/infiniband/sw/rxe/rxe_mw.c    | 30 ++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_net.c   |  6 ++---
 drivers/infiniband/sw/rxe/rxe_pool.h  |  8 +++---
 drivers/infiniband/sw/rxe/rxe_qp.c    | 28 ++++++++++----------
 drivers/infiniband/sw/rxe/rxe_recv.c  |  8 +++---
 drivers/infiniband/sw/rxe/rxe_req.c   | 10 +++----
 drivers/infiniband/sw/rxe/rxe_resp.c  | 32 +++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_verbs.c | 38 +++++++++++++--------------
 12 files changed, 94 insertions(+), 96 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
index 360a567159fe..3b05314ca739 100644
--- a/drivers/infiniband/sw/rxe/rxe_av.c
+++ b/drivers/infiniband/sw/rxe/rxe_av.c
@@ -127,14 +127,14 @@ struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt, struct rxe_ah **ahp)
 
 		if (rxe_ah_pd(ah) != pkt->qp->pd) {
 			pr_warn("PDs don't match for AH and QP\n");
-			rxe_drop_ref(ah);
+			rxe_put(ah);
 			return NULL;
 		}
 
 		if (ahp)
 			*ahp = ah;
 		else
-			rxe_drop_ref(ah);
+			rxe_put(ah);
 
 		return &ah->av;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index f363fe3fa414..138b3e7d3a5f 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -526,7 +526,7 @@ static void rxe_drain_resp_pkts(struct rxe_qp *qp, bool notify)
 	struct rxe_queue *q = qp->sq.queue;
 
 	while ((skb = skb_dequeue(&qp->resp_pkts))) {
-		rxe_drop_ref(qp);
+		rxe_put(qp);
 		kfree_skb(skb);
 		ib_device_put(qp->ibqp.device);
 	}
@@ -548,7 +548,7 @@ static void free_pkt(struct rxe_pkt_info *pkt)
 	struct ib_device *dev = qp->ibqp.device;
 
 	kfree_skb(skb);
-	rxe_drop_ref(qp);
+	rxe_put(qp);
 	ib_device_put(dev);
 }
 
@@ -562,7 +562,7 @@ int rxe_completer(void *arg)
 	enum comp_state state;
 	int ret = 0;
 
-	rxe_add_ref(qp);
+	rxe_get(qp);
 
 	if (!qp->valid || qp->req.state == QP_STATE_ERROR ||
 	    qp->req.state == QP_STATE_RESET) {
@@ -761,7 +761,7 @@ int rxe_completer(void *arg)
 done:
 	if (pkt)
 		free_pkt(pkt);
-	rxe_drop_ref(qp);
+	rxe_put(qp);
 
 	return ret;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index c399a29b648b..ae8f11cb704a 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -319,7 +319,7 @@ static int __rxe_init_mca(struct rxe_qp *qp, struct rxe_mcg *mcg,
 
 	atomic_inc(&qp->mcg_num);
 
-	rxe_add_ref(qp);
+	rxe_get(qp);
 	mca->qp = qp;
 
 	list_add_tail(&mca->qp_list, &mcg->qp_list);
@@ -389,7 +389,7 @@ static void __rxe_cleanup_mca(struct rxe_mca *mca, struct rxe_mcg *mcg)
 	atomic_dec(&mcg->qp_num);
 	atomic_dec(&mcg->rxe->mcg_attach);
 	atomic_dec(&mca->qp->mcg_num);
-	rxe_drop_ref(mca->qp);
+	rxe_put(mca->qp);
 
 	kfree(mca);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 35628b8a00b4..60a31b718774 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -459,7 +459,7 @@ int copy_data(
 
 		if (offset >= sge->length) {
 			if (mr) {
-				rxe_drop_ref(mr);
+				rxe_put(mr);
 				mr = NULL;
 			}
 			sge++;
@@ -504,13 +504,13 @@ int copy_data(
 	dma->resid	= resid;
 
 	if (mr)
-		rxe_drop_ref(mr);
+		rxe_put(mr);
 
 	return 0;
 
 err2:
 	if (mr)
-		rxe_drop_ref(mr);
+		rxe_put(mr);
 err1:
 	return err;
 }
@@ -569,7 +569,7 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 		     (type == RXE_LOOKUP_REMOTE && mr->rkey != key) ||
 		     mr_pd(mr) != pd || (access && !(access & mr->access)) ||
 		     mr->state != RXE_MR_STATE_VALID)) {
-		rxe_drop_ref(mr);
+		rxe_put(mr);
 		mr = NULL;
 	}
 
@@ -613,7 +613,7 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
 	ret = 0;
 
 err_drop_ref:
-	rxe_drop_ref(mr);
+	rxe_put(mr);
 err:
 	return ret;
 }
@@ -690,8 +690,8 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	}
 
 	mr->state = RXE_MR_STATE_INVALID;
-	rxe_drop_ref(mr_pd(mr));
-	rxe_drop_ref(mr);
+	rxe_put(mr_pd(mr));
+	rxe_put(mr);
 
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 7df36c40eec2..c86b2efd58f2 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -12,11 +12,11 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 	struct rxe_dev *rxe = to_rdev(ibmw->device);
 	int ret;
 
-	rxe_add_ref(pd);
+	rxe_get(pd);
 
 	ret = rxe_add_to_pool(&rxe->mw_pool, mw);
 	if (ret) {
-		rxe_drop_ref(pd);
+		rxe_put(pd);
 		return ret;
 	}
 
@@ -35,14 +35,14 @@ static void rxe_do_dealloc_mw(struct rxe_mw *mw)
 
 		mw->mr = NULL;
 		atomic_dec(&mr->num_mw);
-		rxe_drop_ref(mr);
+		rxe_put(mr);
 	}
 
 	if (mw->qp) {
 		struct rxe_qp *qp = mw->qp;
 
 		mw->qp = NULL;
-		rxe_drop_ref(qp);
+		rxe_put(qp);
 	}
 
 	mw->access = 0;
@@ -60,8 +60,8 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 	rxe_do_dealloc_mw(mw);
 	spin_unlock_bh(&mw->lock);
 
-	rxe_drop_ref(mw);
-	rxe_drop_ref(pd);
+	rxe_put(mw);
+	rxe_put(pd);
 
 	return 0;
 }
@@ -170,7 +170,7 @@ static void rxe_do_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 	mw->length = wqe->wr.wr.mw.length;
 
 	if (mw->mr) {
-		rxe_drop_ref(mw->mr);
+		rxe_put(mw->mr);
 		atomic_dec(&mw->mr->num_mw);
 		mw->mr = NULL;
 	}
@@ -178,11 +178,11 @@ static void rxe_do_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 	if (mw->length) {
 		mw->mr = mr;
 		atomic_inc(&mr->num_mw);
-		rxe_add_ref(mr);
+		rxe_get(mr);
 	}
 
 	if (mw->ibmw.type == IB_MW_TYPE_2) {
-		rxe_add_ref(qp);
+		rxe_get(qp);
 		mw->qp = qp;
 	}
 }
@@ -233,9 +233,9 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	spin_unlock_bh(&mw->lock);
 err_drop_mr:
 	if (mr)
-		rxe_drop_ref(mr);
+		rxe_put(mr);
 err_drop_mw:
-	rxe_drop_ref(mw);
+	rxe_put(mw);
 err:
 	return ret;
 }
@@ -260,13 +260,13 @@ static void rxe_do_invalidate_mw(struct rxe_mw *mw)
 	/* valid type 2 MW will always have a QP pointer */
 	qp = mw->qp;
 	mw->qp = NULL;
-	rxe_drop_ref(qp);
+	rxe_put(qp);
 
 	/* valid type 2 MW will always have an MR pointer */
 	mr = mw->mr;
 	mw->mr = NULL;
 	atomic_dec(&mr->num_mw);
-	rxe_drop_ref(mr);
+	rxe_put(mr);
 
 	mw->access = 0;
 	mw->addr = 0;
@@ -301,7 +301,7 @@ int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey)
 err_unlock:
 	spin_unlock_bh(&mw->lock);
 err_drop_ref:
-	rxe_drop_ref(mw);
+	rxe_put(mw);
 err:
 	return ret;
 }
@@ -322,7 +322,7 @@ struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey)
 		     (mw->length == 0) ||
 		     (access && !(access & mw->access)) ||
 		     mw->state != RXE_MW_STATE_VALID)) {
-		rxe_drop_ref(mw);
+		rxe_put(mw);
 		return NULL;
 	}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index b06f22ffc5a8..c53f4529f098 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -348,7 +348,7 @@ static void rxe_skb_tx_dtor(struct sk_buff *skb)
 		     skb_out < RXE_INFLIGHT_SKBS_PER_QP_LOW))
 		rxe_run_task(&qp->req.task, 1);
 
-	rxe_drop_ref(qp);
+	rxe_put(qp);
 }
 
 static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
@@ -358,7 +358,7 @@ static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 	skb->destructor = rxe_skb_tx_dtor;
 	skb->sk = pkt->qp->sk->sk;
 
-	rxe_add_ref(pkt->qp);
+	rxe_get(pkt->qp);
 	atomic_inc(&pkt->qp->skb_out);
 
 	if (skb->protocol == htons(ETH_P_IP)) {
@@ -368,7 +368,7 @@ static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 	} else {
 		pr_err("Unknown layer 3 protocol: %d\n", skb->protocol);
 		atomic_dec(&pkt->qp->skb_out);
-		rxe_drop_ref(pkt->qp);
+		rxe_put(pkt->qp);
 		kfree_skb(skb);
 		return -EINVAL;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index d1e05d384b2c..24bcc786c1b3 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -69,16 +69,14 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem);
 /* lookup an indexed object from index. takes a reference on object */
 void *rxe_pool_get_index(struct rxe_pool *pool, u32 index);
 
-/* take a reference on an object */
 int __rxe_get(struct rxe_pool_elem *elem);
 
-#define rxe_add_ref(obj) __rxe_get(&(obj)->elem)
+#define rxe_get(obj) __rxe_get(&(obj)->elem)
 
-/* drop a reference on an object */
 int __rxe_put(struct rxe_pool_elem *elem);
 
-#define rxe_drop_ref(obj) __rxe_put(&(obj)->elem)
+#define rxe_put(obj) __rxe_put(&(obj)->elem)
 
-#define rxe_read_ref(obj) kref_read(&(obj)->elem.ref_cnt)
+#define rxe_read(obj) kref_read(&(obj)->elem.ref_cnt)
 
 #endif /* RXE_POOL_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 26d461a8d71c..62acf890af6c 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -323,11 +323,11 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
 	struct rxe_cq *scq = to_rcq(init->send_cq);
 	struct rxe_srq *srq = init->srq ? to_rsrq(init->srq) : NULL;
 
-	rxe_add_ref(pd);
-	rxe_add_ref(rcq);
-	rxe_add_ref(scq);
+	rxe_get(pd);
+	rxe_get(rcq);
+	rxe_get(scq);
 	if (srq)
-		rxe_add_ref(srq);
+		rxe_get(srq);
 
 	qp->pd			= pd;
 	qp->rcq			= rcq;
@@ -359,10 +359,10 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
 	qp->srq = NULL;
 
 	if (srq)
-		rxe_drop_ref(srq);
-	rxe_drop_ref(scq);
-	rxe_drop_ref(rcq);
-	rxe_drop_ref(pd);
+		rxe_put(srq);
+	rxe_put(scq);
+	rxe_put(rcq);
+	rxe_put(pd);
 
 	return err;
 }
@@ -521,7 +521,7 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 	qp->resp.sent_psn_nak = 0;
 
 	if (qp->resp.mr) {
-		rxe_drop_ref(qp->resp.mr);
+		rxe_put(qp->resp.mr);
 		qp->resp.mr = NULL;
 	}
 
@@ -809,20 +809,20 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 		rxe_queue_cleanup(qp->sq.queue);
 
 	if (qp->srq)
-		rxe_drop_ref(qp->srq);
+		rxe_put(qp->srq);
 
 	if (qp->rq.queue)
 		rxe_queue_cleanup(qp->rq.queue);
 
 	if (qp->scq)
-		rxe_drop_ref(qp->scq);
+		rxe_put(qp->scq);
 	if (qp->rcq)
-		rxe_drop_ref(qp->rcq);
+		rxe_put(qp->rcq);
 	if (qp->pd)
-		rxe_drop_ref(qp->pd);
+		rxe_put(qp->pd);
 
 	if (qp->resp.mr)
-		rxe_drop_ref(qp->resp.mr);
+		rxe_put(qp->resp.mr);
 
 	if (qp_type(qp) == IB_QPT_RC)
 		sk_dst_reset(qp->sk->sk);
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 53924453abef..d09a8b68c962 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -217,7 +217,7 @@ static int hdr_check(struct rxe_pkt_info *pkt)
 	return 0;
 
 err2:
-	rxe_drop_ref(qp);
+	rxe_put(qp);
 err1:
 	return -EINVAL;
 }
@@ -288,11 +288,11 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 
 			cpkt = SKB_TO_PKT(cskb);
 			cpkt->qp = qp;
-			rxe_add_ref(qp);
+			rxe_get(qp);
 			rxe_rcv_pkt(cpkt, cskb);
 		} else {
 			pkt->qp = qp;
-			rxe_add_ref(qp);
+			rxe_get(qp);
 			rxe_rcv_pkt(pkt, skb);
 			skb = NULL;	/* mark consumed */
 		}
@@ -397,7 +397,7 @@ void rxe_rcv(struct sk_buff *skb)
 
 drop:
 	if (pkt->qp)
-		rxe_drop_ref(pkt->qp);
+		rxe_put(pkt->qp);
 
 	kfree_skb(skb);
 	ib_device_put(&rxe->ib_dev);
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index f44535f82bea..2bde9e767dc7 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -611,7 +611,7 @@ int rxe_requester(void *arg)
 	struct rxe_ah *ah;
 	struct rxe_av *av;
 
-	rxe_add_ref(qp);
+	rxe_get(qp);
 
 next_wqe:
 	if (unlikely(!qp->valid || qp->req.state == QP_STATE_ERROR))
@@ -690,7 +690,7 @@ int rxe_requester(void *arg)
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
 			__rxe_do_task(&qp->comp.task);
-			rxe_drop_ref(qp);
+			rxe_put(qp);
 			return 0;
 		}
 		payload = mtu;
@@ -729,7 +729,7 @@ int rxe_requester(void *arg)
 	}
 
 	if (ah)
-		rxe_drop_ref(ah);
+		rxe_put(ah);
 
 	/*
 	 * To prevent a race on wqe access between requester and completer,
@@ -761,12 +761,12 @@ int rxe_requester(void *arg)
 
 err_drop_ah:
 	if (ah)
-		rxe_drop_ref(ah);
+		rxe_put(ah);
 err:
 	wqe->state = wqe_state_error;
 	__rxe_do_task(&qp->comp.task);
 
 exit:
-	rxe_drop_ref(qp);
+	rxe_put(qp);
 	return -EAGAIN;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index b1ec003f0bb8..16fc7ea1298d 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -99,7 +99,7 @@ static inline enum resp_states get_req(struct rxe_qp *qp,
 
 	if (qp->resp.state == QP_STATE_ERROR) {
 		while ((skb = skb_dequeue(&qp->req_pkts))) {
-			rxe_drop_ref(qp);
+			rxe_put(qp);
 			kfree_skb(skb);
 			ib_device_put(qp->ibqp.device);
 		}
@@ -464,8 +464,8 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 		if (mw->access & IB_ZERO_BASED)
 			qp->resp.offset = mw->addr;
 
-		rxe_drop_ref(mw);
-		rxe_add_ref(mr);
+		rxe_put(mw);
+		rxe_get(mr);
 	} else {
 		mr = lookup_mr(qp->pd, access, rkey, RXE_LOOKUP_REMOTE);
 		if (!mr) {
@@ -508,9 +508,9 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 
 err:
 	if (mr)
-		rxe_drop_ref(mr);
+		rxe_put(mr);
 	if (mw)
-		rxe_drop_ref(mw);
+		rxe_put(mw);
 
 	return state;
 }
@@ -694,12 +694,12 @@ static struct rxe_mr *rxe_recheck_mr(struct rxe_qp *qp, u32 rkey)
 			return NULL;
 
 		if (mw->state != RXE_MW_STATE_VALID) {
-			rxe_drop_ref(mw);
+			rxe_put(mw);
 			return NULL;
 		}
 
 		mr = mw->mr;
-		rxe_drop_ref(mw);
+		rxe_put(mw);
 	} else {
 		mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
 		if (!mr || mr->rkey != rkey)
@@ -707,7 +707,7 @@ static struct rxe_mr *rxe_recheck_mr(struct rxe_qp *qp, u32 rkey)
 	}
 
 	if (mr->state != RXE_MR_STATE_VALID) {
-		rxe_drop_ref(mr);
+		rxe_put(mr);
 		return NULL;
 	}
 
@@ -768,7 +768,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	if (err)
 		pr_err("Failed copying memory\n");
 	if (mr)
-		rxe_drop_ref(mr);
+		rxe_put(mr);
 
 	if (bth_pad(&ack_pkt)) {
 		u8 *pad = payload_addr(&ack_pkt) + payload;
@@ -1037,7 +1037,7 @@ static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	rc = rxe_xmit_packet(qp, &ack_pkt, skb);
 	if (rc) {
 		pr_err_ratelimited("Failed sending ack\n");
-		rxe_drop_ref(qp);
+		rxe_put(qp);
 	}
 out:
 	return rc;
@@ -1066,13 +1066,13 @@ static enum resp_states cleanup(struct rxe_qp *qp,
 
 	if (pkt) {
 		skb = skb_dequeue(&qp->req_pkts);
-		rxe_drop_ref(qp);
+		rxe_put(qp);
 		kfree_skb(skb);
 		ib_device_put(qp->ibqp.device);
 	}
 
 	if (qp->resp.mr) {
-		rxe_drop_ref(qp->resp.mr);
+		rxe_put(qp->resp.mr);
 		qp->resp.mr = NULL;
 	}
 
@@ -1216,7 +1216,7 @@ static enum resp_states do_class_d1e_error(struct rxe_qp *qp)
 		}
 
 		if (qp->resp.mr) {
-			rxe_drop_ref(qp->resp.mr);
+			rxe_put(qp->resp.mr);
 			qp->resp.mr = NULL;
 		}
 
@@ -1230,7 +1230,7 @@ static void rxe_drain_req_pkts(struct rxe_qp *qp, bool notify)
 	struct rxe_queue *q = qp->rq.queue;
 
 	while ((skb = skb_dequeue(&qp->req_pkts))) {
-		rxe_drop_ref(qp);
+		rxe_put(qp);
 		kfree_skb(skb);
 		ib_device_put(qp->ibqp.device);
 	}
@@ -1250,7 +1250,7 @@ int rxe_responder(void *arg)
 	struct rxe_pkt_info *pkt = NULL;
 	int ret = 0;
 
-	rxe_add_ref(qp);
+	rxe_get(qp);
 
 	qp->resp.aeth_syndrome = AETH_ACK_UNLIMITED;
 
@@ -1437,6 +1437,6 @@ int rxe_responder(void *arg)
 exit:
 	ret = -EAGAIN;
 done:
-	rxe_drop_ref(qp);
+	rxe_put(qp);
 	return ret;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index f0c5715ac500..67184b0281a0 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -115,7 +115,7 @@ static void rxe_dealloc_ucontext(struct ib_ucontext *ibuc)
 {
 	struct rxe_ucontext *uc = to_ruc(ibuc);
 
-	rxe_drop_ref(uc);
+	rxe_put(uc);
 }
 
 static int rxe_port_immutable(struct ib_device *dev, u32 port_num,
@@ -149,7 +149,7 @@ static int rxe_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct rxe_pd *pd = to_rpd(ibpd);
 
-	rxe_drop_ref(pd);
+	rxe_put(pd);
 	return 0;
 }
 
@@ -188,7 +188,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
 		err = copy_to_user(&uresp->ah_num, &ah->ah_num,
 					 sizeof(uresp->ah_num));
 		if (err) {
-			rxe_drop_ref(ah);
+			rxe_put(ah);
 			return -EFAULT;
 		}
 	} else if (ah->is_user) {
@@ -228,7 +228,7 @@ static int rxe_destroy_ah(struct ib_ah *ibah, u32 flags)
 {
 	struct rxe_ah *ah = to_rah(ibah);
 
-	rxe_drop_ref(ah);
+	rxe_put(ah);
 	return 0;
 }
 
@@ -303,7 +303,7 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 	if (err)
 		goto err1;
 
-	rxe_add_ref(pd);
+	rxe_get(pd);
 	srq->pd = pd;
 
 	err = rxe_srq_from_init(rxe, srq, init, udata, uresp);
@@ -313,8 +313,8 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 	return 0;
 
 err2:
-	rxe_drop_ref(pd);
-	rxe_drop_ref(srq);
+	rxe_put(pd);
+	rxe_put(srq);
 err1:
 	return err;
 }
@@ -371,8 +371,8 @@ static int rxe_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 	if (srq->rq.queue)
 		rxe_queue_cleanup(srq->rq.queue);
 
-	rxe_drop_ref(srq->pd);
-	rxe_drop_ref(srq);
+	rxe_put(srq->pd);
+	rxe_put(srq);
 	return 0;
 }
 
@@ -442,7 +442,7 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 	return 0;
 
 qp_init:
-	rxe_drop_ref(qp);
+	rxe_put(qp);
 	return err;
 }
 
@@ -496,7 +496,7 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 		return ret;
 
 	rxe_qp_destroy(qp);
-	rxe_drop_ref(qp);
+	rxe_put(qp);
 	return 0;
 }
 
@@ -809,7 +809,7 @@ static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 
 	rxe_cq_disable(cq);
 
-	rxe_drop_ref(cq);
+	rxe_put(cq);
 	return 0;
 }
 
@@ -902,7 +902,7 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
-	rxe_add_ref(pd);
+	rxe_get(pd);
 	rxe_mr_init_dma(pd, access, mr);
 
 	return &mr->ibmr;
@@ -926,7 +926,7 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	}
 
 
-	rxe_add_ref(pd);
+	rxe_get(pd);
 
 	err = rxe_mr_init_user(pd, start, length, iova, access, mr);
 	if (err)
@@ -935,8 +935,8 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	return &mr->ibmr;
 
 err3:
-	rxe_drop_ref(pd);
-	rxe_drop_ref(mr);
+	rxe_put(pd);
+	rxe_put(mr);
 err2:
 	return ERR_PTR(err);
 }
@@ -958,7 +958,7 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 		goto err1;
 	}
 
-	rxe_add_ref(pd);
+	rxe_get(pd);
 
 	err = rxe_mr_init_fast(pd, max_num_sg, mr);
 	if (err)
@@ -967,8 +967,8 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	return &mr->ibmr;
 
 err2:
-	rxe_drop_ref(pd);
-	rxe_drop_ref(mr);
+	rxe_put(pd);
+	rxe_put(mr);
 err1:
 	return ERR_PTR(err);
 }
-- 
2.32.0

