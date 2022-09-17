Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EE05BB5C9
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Sep 2022 05:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiIQDLu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Sep 2022 23:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiIQDLU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Sep 2022 23:11:20 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18658BD106
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:11:15 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id u6-20020a056830118600b006595e8f9f3fso3954909otq.1
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=QdO3klLpVE9C39N+UNoV5oSHsEGmmluYbUXlMnbabqs=;
        b=Pg4U67fC6jUVbhbnRXk2+hBur6wPQpa4HLNNpdgi7Vy+VXJWb3weMc72NckMVdeovz
         kulN0NCnJKWgJR25KI1+LuGeirItYZKWo0LQVWxhyGkxnT0IeyfBTsMiJQ8vZa5H6jJv
         4t08PbwLU7SY9Lam8BKojljY6hoa1vaqfO/tIVQGjdpvbU0Ci0h/+Rcidtdq8UQBn/4q
         tY1zo/DfsxUb0HFANQ+mRqMpr7SKE0Q9XjniWtr7Qi94qvK4To1kIO5ILv3z7aLJJ4Ng
         Br63vKC1W16sGoFzMJEaozgKq+X1tz7hDCCeb/RjENebHWuKAdPVSXkxkSCwdZxVp3uq
         jEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QdO3klLpVE9C39N+UNoV5oSHsEGmmluYbUXlMnbabqs=;
        b=yR1U2VRlauIS0Qxzn5ZswQeT8Nm/Q0oU1wLiOnWyej2X0lvhBjG0URYVqOF92IEdrv
         ImQBLS7kjRtpMQzcdQDu0FLbYnRdxH3ccHZ9JHSaG552Z3cIvX8C65Mu9dq6E013kNEw
         lxnqlUoOfRZAodYi7HntuExLSMy3ICjmgVPxqOH6FragpFUVdG1jV1zD5+fCtyp58UUb
         ojgGJknGBH6UA37iUKEULJhvIimuaH3tieBQN7cV4f9tBrzv/vh4zxVtynOLoNhaMXrl
         18jlxGPa0FaYw7JlI61jKKz84zi84QVLEDc8kzLQZbbJJ2g5AcbgIK1exlPThzGI16DN
         bKKQ==
X-Gm-Message-State: ACrzQf3Uhg/xwfHlDaXT9tld8lcYZwEE6JgR440naIlHBSZVeTSuMkfC
        3MkoqhcphiCugGggbJwo92A=
X-Google-Smtp-Source: AMsMyM4w5CTt7jK7HQM2zkjdvpzDCG2eUzPwW2R5IUjSm2RQLdVRLoNwLnpqXO5AoIQpWM45yvacWw==
X-Received: by 2002:a05:6830:2a0d:b0:656:bd3f:253f with SMTP id y13-20020a0568302a0d00b00656bd3f253fmr3587986otu.25.1663384274371;
        Fri, 16 Sep 2022 20:11:14 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f9ea-fe1d-a45c-bca2.res6.spectrum.com. [2603:8081:140c:1a00:f9ea:fe1d:a45c:bca2])
        by smtp.googlemail.com with ESMTPSA id q17-20020a4a6c11000000b00475f26931c8sm921422ooc.13.2022.09.16.20.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 20:11:13 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 07/13] RDMA/rxe: Extend srq verbs to support xrcd
Date:   Fri, 16 Sep 2022 22:10:58 -0500
Message-Id: <20220917031104.21222-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220917031104.21222-1-rpearsonhpe@gmail.com>
References: <20220917031104.21222-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_srq.c   | 131 ++++++++++++++------------
 drivers/infiniband/sw/rxe/rxe_verbs.c |  13 +--
 drivers/infiniband/sw/rxe/rxe_verbs.h |   8 +-
 include/uapi/rdma/rdma_user_rxe.h     |   4 +-
 4 files changed, 83 insertions(+), 73 deletions(-)

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
index 4a5da079bf11..ef86f0c5890e 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -306,7 +306,6 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 {
 	int err;
 	struct rxe_dev *rxe = to_rdev(ibsrq->device);
-	struct rxe_pd *pd = to_rpd(ibsrq->pd);
 	struct rxe_srq *srq = to_rsrq(ibsrq);
 	struct rxe_create_srq_resp __user *uresp = NULL;
 
@@ -316,9 +315,6 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 		uresp = udata->outbuf;
 	}
 
-	if (init->srq_type != IB_SRQT_BASIC)
-		return -EOPNOTSUPP;
-
 	err = rxe_srq_chk_init(rxe, init);
 	if (err)
 		return err;
@@ -327,13 +323,11 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
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
@@ -367,6 +361,7 @@ static int rxe_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 	err = rxe_srq_from_attr(rxe, srq, attr, mask, &ucmd, udata);
 	if (err)
 		return err;
+
 	return 0;
 }
 
@@ -380,6 +375,7 @@ static int rxe_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
 	attr->max_wr = srq->rq.queue->buf->index_mask;
 	attr->max_sge = srq->rq.max_sge;
 	attr->srq_limit = srq->limit;
+
 	return 0;
 }
 
@@ -546,7 +542,6 @@ static void init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
 			 const struct ib_send_wr *ibwr)
 {
 	wr->wr_id = ibwr->wr_id;
-	wr->num_sge = ibwr->num_sge;
 	wr->opcode = ibwr->opcode;
 	wr->send_flags = ibwr->send_flags;
 
@@ -628,6 +623,8 @@ static void init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 		return;
 	}
 
+	wqe->dma.num_sge = ibwr->num_sge;
+
 	if (unlikely(ibwr->send_flags & IB_SEND_INLINE))
 		copy_inline_data_to_wqe(wqe, ibwr);
 	else
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 6c4cfb802dd4..7dab7fa3ba6c 100644
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
index f09c5c9e3dd5..514a1b6976fe 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -74,7 +74,7 @@ struct rxe_av {
 
 struct rxe_send_wr {
 	__aligned_u64		wr_id;
-	__u32			num_sge;
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

