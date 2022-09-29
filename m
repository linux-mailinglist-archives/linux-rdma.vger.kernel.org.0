Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF9B5EFBAD
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Sep 2022 19:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbiI2RJT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Sep 2022 13:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbiI2RJP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Sep 2022 13:09:15 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006631CE915
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 10:09:13 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-131ea99262dso261211fac.9
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 10:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Vgko5WlFK+gfJcSWIJeIRuyVc9ynigRaD/hZ7gTFtac=;
        b=osTJsLKzmn960RqGi1C4yIH4YooDszdW8MH3OYC7xcgU2YSni7JFxph5g4Vgs+AW3e
         UYaH28WRWpZAJEnfRdPlwOVlx6PhmA7638oegqawQXB0cO0EsUXUk6mBOMwNo75nMfQP
         65Mzo01l4+eYdcRZuF1Qdixdo+tA1poR+04LdyUxhQ2vHKama+zEFJpgv7hpvrq49jFO
         XjxaUJ+ahIg8fo4Ky3IJ/00lE8DhUZ4MiL4hDVGKA9bm4/p3jLQGHVke0sg9YFAbyKsk
         L9Ew3gFvOoJNl/h2CccbbmotjeFweLZq0quliMEabn9fa8C47VT1+UVMlN3LM6KpUZIF
         lDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Vgko5WlFK+gfJcSWIJeIRuyVc9ynigRaD/hZ7gTFtac=;
        b=f7TFFbnDRRlpxiTSeVfur3essFzZnE72CJ97hyFLOn8rlls/GvvP9dhDY2m7yOo/c4
         G08IWk6/VTPOb/Wai9hs2AqCEuWhexsLMIvoJk+deVffKlflsQSnzafZId4+SNBOC/e5
         5qiwETN25Dl2ukZRmYQoBAebuwQIE0VvHSeiyCpM3X1uXhahNb91ri55ehnRkFSUu10q
         nEeUuYMeCV7VE9kLXt1ZcukHRlJLm0mCrAhne0M0mBOLyDEaD8mRr233w6aTX3+Y/5Ll
         7sYpFxg0DZrLTuXlrDRA0SBkxwAfG+Dp3aQkHh6BCcapcjrV8+Q+lVLQx26WFN+jn5hI
         yhZQ==
X-Gm-Message-State: ACrzQf0h0dV7qA/uvNu/hfIhWDlFy9Hki6AH3UPfphj2DYXcWL2TZ373
        u3Z9PYyodXO91D3F59gopUXWUFbPIlRlng==
X-Google-Smtp-Source: AMsMyM4wLHJqOpmd+eZxjn6SvIT3SESiFT2Q0+5O2Hxc8rP16o3B9UX2OlU8ha4TB2YyWGjPIN7sCw==
X-Received: by 2002:a05:6870:c149:b0:12d:8014:be54 with SMTP id g9-20020a056870c14900b0012d8014be54mr9048888oad.29.1664471353184;
        Thu, 29 Sep 2022 10:09:13 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-c4e7-bfae-90ed-ac81.res6.spectrum.com. [2603:8081:140c:1a00:c4e7:bfae:90ed:ac81])
        by smtp.googlemail.com with ESMTPSA id v17-20020a056808005100b00349a06c581fsm2798557oic.3.2022.09.29.10.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 10:09:12 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 07/13] RDMA/rxe: Extend srq verbs to support xrcd
Date:   Thu, 29 Sep 2022 12:08:31 -0500
Message-Id: <20220929170836.17838-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929170836.17838-1-rpearsonhpe@gmail.com>
References: <20220929170836.17838-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Extend srq to support xrcd in create verb

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2
  Rebased to current for-next

 drivers/infiniband/sw/rxe/rxe_srq.c   | 131 ++++++++++++++------------
 drivers/infiniband/sw/rxe/rxe_verbs.c |  12 +--
 drivers/infiniband/sw/rxe/rxe_verbs.h |   8 +-
 include/uapi/rdma/rdma_user_rxe.h     |   4 +-
 4 files changed, 83 insertions(+), 72 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index 02b39498c370..fcd1a58c3900 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -11,61 +11,85 @@
 int rxe_srq_chk_init(struct rxe_dev *rxe, struct ib_srq_init_attr *init)
 {
 	struct ib_srq_attr *attr = &init->attr;
+	int err = -EINVAL;
 
-	if (attr->max_wr > rxe->attr.max_srq_wr) {
-		pr_warn("max_wr(%d) > max_srq_wr(%d)\n",
-			attr->max_wr, rxe->attr.max_srq_wr);
-		goto err1;
+	if (init->srq_type == IB_SRQT_TM) {
+		err = -EOPNOTSUPP;
+		goto err_out;
 	}
 
-	if (attr->max_wr <= 0) {
-		pr_warn("max_wr(%d) <= 0\n", attr->max_wr);
-		goto err1;
+	if (init->srq_type == IB_SRQT_XRC) {
+		if (!init->ext.cq || !init->ext.xrc.xrcd)
+			goto err_out;
 	}
 
+	if (attr->max_wr > rxe->attr.max_srq_wr)
+		goto err_out;
+
+	if (attr->max_wr <= 0)
+		goto err_out;
+
 	if (attr->max_wr < RXE_MIN_SRQ_WR)
 		attr->max_wr = RXE_MIN_SRQ_WR;
 
-	if (attr->max_sge > rxe->attr.max_srq_sge) {
-		pr_warn("max_sge(%d) > max_srq_sge(%d)\n",
-			attr->max_sge, rxe->attr.max_srq_sge);
-		goto err1;
-	}
+	if (attr->max_sge > rxe->attr.max_srq_sge)
+		goto err_out;
 
 	if (attr->max_sge < RXE_MIN_SRQ_SGE)
 		attr->max_sge = RXE_MIN_SRQ_SGE;
 
 	return 0;
 
-err1:
-	return -EINVAL;
+err_out:
+	pr_debug("%s: failed err = %d\n", __func__, err);
+	return err;
 }
 
 int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 		      struct ib_srq_init_attr *init, struct ib_udata *udata,
 		      struct rxe_create_srq_resp __user *uresp)
 {
-	int err;
-	int srq_wqe_size;
+	struct rxe_pd *pd = to_rpd(srq->ibsrq.pd);
+	struct rxe_cq *cq;
+	struct rxe_xrcd *xrcd;
 	struct rxe_queue *q;
-	enum queue_type type;
+	int srq_wqe_size;
+	int err;
+
+	rxe_get(pd);
+	srq->pd = pd;
 
 	srq->ibsrq.event_handler	= init->event_handler;
 	srq->ibsrq.srq_context		= init->srq_context;
 	srq->limit		= init->attr.srq_limit;
-	srq->srq_num		= srq->elem.index;
 	srq->rq.max_wr		= init->attr.max_wr;
 	srq->rq.max_sge		= init->attr.max_sge;
 
-	srq_wqe_size		= rcv_wqe_size(srq->rq.max_sge);
+	if (init->srq_type == IB_SRQT_XRC) {
+		cq = to_rcq(init->ext.cq);
+		if (cq) {
+			rxe_get(cq);
+			srq->cq = to_rcq(init->ext.cq);
+		} else {
+			return -EINVAL;
+		}
+		xrcd = to_rxrcd(init->ext.xrc.xrcd);
+		if (xrcd) {
+			rxe_get(xrcd);
+			srq->xrcd = to_rxrcd(init->ext.xrc.xrcd);
+		}
+		srq->ibsrq.ext.xrc.srq_num = srq->elem.index;
+	}
 
 	spin_lock_init(&srq->rq.producer_lock);
 	spin_lock_init(&srq->rq.consumer_lock);
 
-	type = QUEUE_TYPE_FROM_CLIENT;
-	q = rxe_queue_init(rxe, &srq->rq.max_wr, srq_wqe_size, type);
+	srq_wqe_size = rcv_wqe_size(srq->rq.max_sge);
+	q = rxe_queue_init(rxe, &srq->rq.max_wr, srq_wqe_size,
+			   QUEUE_TYPE_FROM_CLIENT);
 	if (!q) {
-		pr_warn("unable to allocate queue for srq\n");
+		pr_debug("%s: srq#%d: unable to allocate queue\n",
+				__func__, srq->elem.index);
 		return -ENOMEM;
 	}
 
@@ -79,66 +103,45 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 		return err;
 	}
 
-	if (uresp) {
-		if (copy_to_user(&uresp->srq_num, &srq->srq_num,
-				 sizeof(uresp->srq_num))) {
-			rxe_queue_cleanup(q);
-			return -EFAULT;
-		}
-	}
-
 	return 0;
 }
 
 int rxe_srq_chk_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 		     struct ib_srq_attr *attr, enum ib_srq_attr_mask mask)
 {
-	if (srq->error) {
-		pr_warn("srq in error state\n");
-		goto err1;
-	}
+	int err = -EINVAL;
+
+	if (srq->error)
+		goto err_out;
 
 	if (mask & IB_SRQ_MAX_WR) {
-		if (attr->max_wr > rxe->attr.max_srq_wr) {
-			pr_warn("max_wr(%d) > max_srq_wr(%d)\n",
-				attr->max_wr, rxe->attr.max_srq_wr);
-			goto err1;
-		}
+		if (attr->max_wr > rxe->attr.max_srq_wr)
+			goto err_out;
 
-		if (attr->max_wr <= 0) {
-			pr_warn("max_wr(%d) <= 0\n", attr->max_wr);
-			goto err1;
-		}
+		if (attr->max_wr <= 0)
+			goto err_out;
 
-		if (srq->limit && (attr->max_wr < srq->limit)) {
-			pr_warn("max_wr (%d) < srq->limit (%d)\n",
-				attr->max_wr, srq->limit);
-			goto err1;
-		}
+		if (srq->limit && (attr->max_wr < srq->limit))
+			goto err_out;
 
 		if (attr->max_wr < RXE_MIN_SRQ_WR)
 			attr->max_wr = RXE_MIN_SRQ_WR;
 	}
 
 	if (mask & IB_SRQ_LIMIT) {
-		if (attr->srq_limit > rxe->attr.max_srq_wr) {
-			pr_warn("srq_limit(%d) > max_srq_wr(%d)\n",
-				attr->srq_limit, rxe->attr.max_srq_wr);
-			goto err1;
-		}
+		if (attr->srq_limit > rxe->attr.max_srq_wr)
+			goto err_out;
 
-		if (attr->srq_limit > srq->rq.queue->buf->index_mask) {
-			pr_warn("srq_limit (%d) > cur limit(%d)\n",
-				attr->srq_limit,
-				srq->rq.queue->buf->index_mask);
-			goto err1;
-		}
+		if (attr->srq_limit > srq->rq.queue->buf->index_mask)
+			goto err_out;
 	}
 
 	return 0;
 
-err1:
-	return -EINVAL;
+err_out:
+	pr_debug("%s: srq#%d: failed err = %d\n", __func__,
+			srq->elem.index, err);
+	return err;
 }
 
 int rxe_srq_from_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
@@ -182,6 +185,12 @@ void rxe_srq_cleanup(struct rxe_pool_elem *elem)
 	if (srq->pd)
 		rxe_put(srq->pd);
 
+	if (srq->cq)
+		rxe_put(srq->cq);
+
+	if (srq->xrcd)
+		rxe_put(srq->xrcd);
+
 	if (srq->rq.queue)
 		rxe_queue_cleanup(srq->rq.queue);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index c7641bdf3ba1..cee31b650fe0 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -305,7 +305,6 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 {
 	int err;
 	struct rxe_dev *rxe = to_rdev(ibsrq->device);
-	struct rxe_pd *pd = to_rpd(ibsrq->pd);
 	struct rxe_srq *srq = to_rsrq(ibsrq);
 	struct rxe_create_srq_resp __user *uresp = NULL;
 
@@ -315,9 +314,6 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 		uresp = udata->outbuf;
 	}
 
-	if (init->srq_type != IB_SRQT_BASIC)
-		return -EOPNOTSUPP;
-
 	err = rxe_srq_chk_init(rxe, init);
 	if (err)
 		return err;
@@ -326,13 +322,11 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 	if (err)
 		return err;
 
-	rxe_get(pd);
-	srq->pd = pd;
-
 	err = rxe_srq_from_init(rxe, srq, init, udata, uresp);
 	if (err)
 		goto err_cleanup;
 
+	rxe_finalize(srq);
 	return 0;
 
 err_cleanup:
@@ -366,6 +360,7 @@ static int rxe_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 	err = rxe_srq_from_attr(rxe, srq, attr, mask, &ucmd, udata);
 	if (err)
 		return err;
+
 	return 0;
 }
 
@@ -379,6 +374,7 @@ static int rxe_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
 	attr->max_wr = srq->rq.queue->buf->index_mask;
 	attr->max_sge = srq->rq.max_sge;
 	attr->srq_limit = srq->limit;
+
 	return 0;
 }
 
@@ -626,6 +622,8 @@ static void init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 		return;
 	}
 
+	wqe->dma.num_sge = ibwr->num_sge;
+
 	if (unlikely(ibwr->send_flags & IB_SEND_INLINE))
 		copy_inline_data_to_wqe(wqe, ibwr);
 	else
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index fb2fbf281232..465af1517112 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -102,13 +102,19 @@ struct rxe_srq {
 	struct ib_srq		ibsrq;
 	struct rxe_pool_elem	elem;
 	struct rxe_pd		*pd;
+	struct rxe_xrcd		*xrcd;		/* xrc only */
+	struct rxe_cq		*cq;		/* xrc only */
 	struct rxe_rq		rq;
-	u32			srq_num;
 
 	int			limit;
 	int			error;
 };
 
+static inline u32 srq_num(struct rxe_srq *srq)
+{
+	return srq->ibsrq.ext.xrc.srq_num;
+}
+
 enum rxe_qp_state {
 	QP_STATE_RESET,
 	QP_STATE_INIT,
diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index 73f679dfd2df..f908347963c0 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -74,7 +74,7 @@ struct rxe_av {
 
 struct rxe_send_wr {
 	__aligned_u64		wr_id;
-	__u32			reserved;
+	__u32			srq_num;	/* xrc only */
 	__u32			opcode;
 	__u32			send_flags;
 	union {
@@ -191,8 +191,6 @@ struct rxe_create_qp_resp {
 
 struct rxe_create_srq_resp {
 	struct mminfo mi;
-	__u32 srq_num;
-	__u32 reserved;
 };
 
 struct rxe_modify_srq_cmd {
-- 
2.34.1

