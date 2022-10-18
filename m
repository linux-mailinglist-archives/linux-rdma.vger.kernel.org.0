Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEC2602358
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 06:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJREgh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 00:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiJREg2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 00:36:28 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A7BA0249
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:24 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-136b5dd6655so15617205fac.3
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSv2XfJeImnY9SqiatADTftY/YAZIrV/g9P7mzLsx/0=;
        b=lm9ga4DMZocsvBrgDeeH09EJdAqQGUq8vs6htY7hv3/iZ5+3OIgUXXZp9lxbc61bfK
         vPvv99eCjKFVDOs0owrGunmFZ4QP8HsTo7YIXNPhzaX3gXlCn5SK3i2hlbRG/O5yoE5L
         LBgrNYG+7OwVq2gB6O9iRuVmXAXAdbNV0jX5m0Ak5MMKdzLiKAZ3/pRUWoYLUP3v/2Sm
         fQVdXriGzL1UMrD8413L7OuGevuApZc2Ck6vAx3Mw0gsHwiQVw2B26ZQ2+QcHtB7jQ8f
         BsMKqn0P1hIF731b4APCm8QCutfrf0zPzO5W3B08E7aLgwKEW2VBHlTQuOtXVARFpt2e
         HeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tSv2XfJeImnY9SqiatADTftY/YAZIrV/g9P7mzLsx/0=;
        b=aim1Pct/JQLYPd2zQkstTmU6LWxYT41z0vN9JZiPoCjio7ZGpP6RSZtdhhrvTF9wdR
         Mv2F7Xm2DiNFHfl66Ex8c9uTDQA/MWKZ2ByyGLxFHqfQ4yCDN1uwIYCtd7H0s0DgCAMt
         RuU27CuXKMwUi1pkMv+8sxkFGKytPq1XcJS4eUZwcqn+xfbXDBMapOufmq8K07MxoIVq
         /CyMgNscOSpd/axncQMJ6ZulLiPChCDexGSjHUCEi4M/Ky1qcS9pSUCOPByERtuqHIjW
         fPNLTfvv+L1KhQP22fZuWkc0d3kcwLuquFAbMBXqyIfAgD0lXCuZmX8yFhO2HzIwzKUb
         ygcg==
X-Gm-Message-State: ACrzQf1FqupIWb/XTjmbHg5HGSjqhlnZZT6Gixk8lf9nnaoFJm8dg8ze
        qGy6BNV7wSuvP6yy/QXNP00=
X-Google-Smtp-Source: AMsMyM53KGjfRC7Jn0MdwO19FEa6wR//mS/QHTnU3hOD9wDM1EuA4DbA/blR+N7ids0rgaJTlF8llQ==
X-Received: by 2002:a05:6870:f622:b0:130:8d6:cbdb with SMTP id ek34-20020a056870f62200b0013008d6cbdbmr16512907oab.265.1666067784330;
        Mon, 17 Oct 2022 21:36:24 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-290b-8972-ce76-602c.res6.spectrum.com. [2603:8081:140c:1a00:290b:8972:ce76:602c])
        by smtp.googlemail.com with ESMTPSA id e96-20020a9d01e9000000b006618ca5caa0sm5480333ote.78.2022.10.17.21.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 21:36:23 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        jenny.hack@hpe.com, ian.ziemba@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 09/16] RDMA/rxe: Handle qp error in rxe_resp.c
Date:   Mon, 17 Oct 2022 23:33:40 -0500
Message-Id: <20221018043345.4033-10-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018043345.4033-1-rpearsonhpe@gmail.com>
References: <20221018043345.4033-1-rpearsonhpe@gmail.com>
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

Split rxe_drain_req_pkts() into two subroutines which perform
separate tasks. Change qp error and reset states and !qp->valid
in the same way as rxe_comp.c. FLush recv wqes for qp in error.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 64 ++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index dd11dea70bbf..0bcdd1154641 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1025,7 +1025,6 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 		return RESPST_CLEANUP;
 }
 
-
 static int send_common_ack(struct rxe_qp *qp, u8 syndrome, u32 psn,
 				  int opcode, const char *msg)
 {
@@ -1240,22 +1239,56 @@ static enum resp_states do_class_d1e_error(struct rxe_qp *qp)
 	}
 }
 
-static void rxe_drain_req_pkts(struct rxe_qp *qp, bool notify)
+static void rxe_drain_req_pkts(struct rxe_qp *qp)
 {
 	struct sk_buff *skb;
-	struct rxe_queue *q = qp->rq.queue;
 
 	while ((skb = skb_dequeue(&qp->req_pkts))) {
 		rxe_put(qp);
 		kfree_skb(skb);
 		ib_device_put(qp->ibqp.device);
 	}
+}
+
+int complete_flush(struct rxe_qp *qp, struct rxe_recv_wqe *wqe)
+{
+	struct rxe_cqe cqe;
+	struct ib_wc *wc = &cqe.ibwc;
+	struct ib_uverbs_wc *uwc = &cqe.uibwc;
+
+	memset(&cqe, 0, sizeof(cqe));
 
-	if (notify)
-		return;
+	if (qp->rcq->is_user) {
+		uwc->status		= IB_WC_WR_FLUSH_ERR;
+		uwc->qp_num		= qp->ibqp.qp_num;
+		uwc->wr_id		= wqe->wr_id;
+	} else {
+		wc->status		= IB_WC_WR_FLUSH_ERR;
+		wc->qp			= &qp->ibqp;
+		wc->wr_id		= wqe->wr_id;
+	}
 
-	while (!qp->srq && q && queue_head(q, q->type))
+	if (rxe_cq_post(qp->rcq, &cqe, 0))
+		return -ENOMEM;
+
+	return 0;
+}
+
+/* drain the receive queue. Complete each wqe with a flush error
+ * if notify is true or until a cq overflow occurs.
+ */
+static void rxe_drain_recv_queue(struct rxe_qp *qp, bool notify)
+{
+	struct rxe_recv_wqe *wqe;
+	struct rxe_queue *q = qp->rq.queue;
+
+	while ((wqe = queue_head(q, q->type))) {
+		if (notify && complete_flush(qp, wqe))
+			notify = 0;
 		queue_advance_consumer(q, q->type);
+	}
+
+	qp->resp.wqe = NULL;
 }
 
 int rxe_responder(void *arg)
@@ -1264,6 +1297,7 @@ int rxe_responder(void *arg)
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	enum resp_states state;
 	struct rxe_pkt_info *pkt = NULL;
+	bool notify;
 	int ret;
 
 	if (!rxe_get(qp))
@@ -1271,20 +1305,16 @@ int rxe_responder(void *arg)
 
 	qp->resp.aeth_syndrome = AETH_ACK_UNLIMITED;
 
-	if (!qp->valid)
-		goto exit;
-
-	switch (qp->resp.state) {
-	case QP_STATE_RESET:
-		rxe_drain_req_pkts(qp, false);
-		qp->resp.wqe = NULL;
+	if (!qp->valid || qp->resp.state == QP_STATE_ERROR ||
+	    qp->resp.state == QP_STATE_RESET) {
+		notify = qp->valid && (qp->resp.state == QP_STATE_ERROR);
+		rxe_drain_req_pkts(qp);
+		rxe_drain_recv_queue(qp, notify);
 		goto exit;
-
-	default:
-		state = RESPST_GET_REQ;
-		break;
 	}
 
+	state = RESPST_GET_REQ;
+
 	while (1) {
 		pr_debug("qp#%d state = %s\n", qp_num(qp),
 			 resp_state_name[state]);
-- 
2.34.1

