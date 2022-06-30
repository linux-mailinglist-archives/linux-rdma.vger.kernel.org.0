Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE485622A0
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jun 2022 21:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236819AbiF3TFR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jun 2022 15:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236817AbiF3TFQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jun 2022 15:05:16 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EA937A06
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 12:05:15 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w83so538367oiw.1
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 12:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LWdD9BfJ+fRfDfw5ycyY7chG7VG1cND2Lz8zAHRmU/s=;
        b=XdHapiG5BgngkGIhPDwBRZnO6ITy/Ukz57FfleX2ed+Q7G6nK4dEkR56IhJQXwDfNd
         CGiRC2Ea+JOxYXQ5PnKWvfB9E5XpZiH+/RtOSYZR97Dq6ePB3YmSliTNpfl83hJqkVIu
         1yePi6AJoejhOlJETjotn3YY5kXTqpwrRaOkvceyHHQ37gGJ0Y93qnmh0tZ66zeqKDfK
         COXSI1QMgek98yYkzqfqdovUbwukvp1cWBevs25uYUTlUiLRlz8EktKUV47/dpQtt0As
         OgLrhi66VNF4Qa+09GhSa4EUUDgTOHQFeEUqwBglV1vC9MIXBC+TP9LwcNsoN/5pBcEj
         +HTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LWdD9BfJ+fRfDfw5ycyY7chG7VG1cND2Lz8zAHRmU/s=;
        b=mYSr2jzjdq+Zs6hwSzk9UADUY2dpnN2kA8RSF9ScnQ2fE0V2+kCw+PglHuLjhSPunA
         8EdzfcOiMXIr1T7XLVbULf3YJ59/mSU4k6DtGNQ6IBCJS3GrEeuD2YVivZiZPHW67v7D
         5y0g1+8Nx66sHaduAR3yS+X1lFA3TKzG11x5qLyIBrk8kr/YSQ0yNLcKesrCaxxjYjI+
         TAiKzci2k3wO5gG2CrmWsGZFofLhI3QkmPEUqdDowSolDmhmRttVQjlwP7Mwke00yDYw
         lcZrX+c/w63nPLK7Kg2tLiiuuCEvGY4efazkBN4zR9ovJZemHs7dJW/sF8Qps8DQDuOT
         qWUg==
X-Gm-Message-State: AJIora/OgWlnRpmJklig+QNmSH1j+VP/2QSr4delJrRGuTXbr6w+XBP5
        e2LCHcBW4qt50BIrJcRUhd7P9ZU1N0alUw==
X-Google-Smtp-Source: AGRyM1tM1hxt7PvSdh+PmFcSmy3tIxZnJDW700lwb/q9zMzpxzL/TtzFhVA3m9cHHKCYPyzA40s5cg==
X-Received: by 2002:a05:6808:191b:b0:335:82bb:afd4 with SMTP id bf27-20020a056808191b00b0033582bbafd4mr6430795oib.5.1656615915178;
        Thu, 30 Jun 2022 12:05:15 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id o4-20020a9d4104000000b0060bfb4e4033sm11756442ote.9.2022.06.30.12.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 12:05:14 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 7/9] RDMA/rxe: Make the tasklet exits the same
Date:   Thu, 30 Jun 2022 14:04:24 -0500
Message-Id: <20220630190425.2251-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220630190425.2251-1-rpearsonhpe@gmail.com>
References: <20220630190425.2251-1-rpearsonhpe@gmail.com>
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

Make changes to the three tasklets so that the exit logic from
each is the same. This makes the code easier to understand.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 35 +++++++++---------
 drivers/infiniband/sw/rxe/rxe_req.c  | 54 ++++++++++++++++------------
 drivers/infiniband/sw/rxe/rxe_resp.c | 17 +++++----
 3 files changed, 60 insertions(+), 46 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 4fc31bb7eee6..bc53cad077aa 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -562,7 +562,7 @@ int rxe_completer(void *arg)
 	struct sk_buff *skb = NULL;
 	struct rxe_pkt_info *pkt = NULL;
 	enum comp_state state;
-	int ret = 0;
+	int ret;
 
 	if (!rxe_get(qp))
 		return -EAGAIN;
@@ -571,8 +571,7 @@ int rxe_completer(void *arg)
 	    qp->req.state == QP_STATE_RESET) {
 		rxe_drain_resp_pkts(qp, qp->valid &&
 				    qp->req.state == QP_STATE_ERROR);
-		ret = -EAGAIN;
-		goto done;
+		goto exit;
 	}
 
 	if (qp->comp.timeout) {
@@ -582,10 +581,8 @@ int rxe_completer(void *arg)
 		qp->comp.timeout_retry = 0;
 	}
 
-	if (qp->req.need_retry) {
-		ret = -EAGAIN;
-		goto done;
-	}
+	if (qp->req.need_retry)
+		goto exit;
 
 	state = COMPST_GET_ACK;
 
@@ -678,8 +675,7 @@ int rxe_completer(void *arg)
 			    qp->qp_timeout_jiffies)
 				mod_timer(&qp->retrans_timer,
 					  jiffies + qp->qp_timeout_jiffies);
-			ret = -EAGAIN;
-			goto done;
+			goto exit;
 
 		case COMPST_ERROR_RETRY:
 			/* we come here if the retry timer fired and we did
@@ -691,10 +687,8 @@ int rxe_completer(void *arg)
 			 */
 
 			/* there is nothing to retry in this case */
-			if (!wqe || (wqe->state == wqe_state_posted)) {
-				ret = -EAGAIN;
-				goto done;
-			}
+			if (!wqe || (wqe->state == wqe_state_posted))
+				goto exit;
 
 			/* if we've started a retry, don't start another
 			 * retry sequence, unless this is a timeout.
@@ -746,8 +740,7 @@ int rxe_completer(void *arg)
 				mod_timer(&qp->rnr_nak_timer,
 					  jiffies + rnrnak_jiffies(aeth_syn(pkt)
 						& ~AETH_TYPE_MASK));
-				ret = -EAGAIN;
-				goto done;
+				goto exit;
 			} else {
 				rxe_counter_inc(rxe,
 						RXE_CNT_RNR_RETRY_EXCEEDED);
@@ -760,12 +753,20 @@ int rxe_completer(void *arg)
 			WARN_ON_ONCE(wqe->status == IB_WC_SUCCESS);
 			do_complete(qp, wqe);
 			rxe_qp_error(qp);
-			ret = -EAGAIN;
-			goto done;
+			goto exit;
 		}
 	}
 
+	/* A non-zero return value will cause rxe_do_task to
+	 * exit its loop and end the tasklet. A zero return
+	 * will continue looping and return to rxe_completer
+	 */
 done:
+	ret = 0;
+	goto out;
+exit:
+	ret = -EAGAIN;
+out:
 	if (pkt)
 		free_pkt(pkt);
 	rxe_put(qp);
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 81eca57b04b8..008ae51c7560 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -625,6 +625,7 @@ int rxe_requester(void *arg)
 	u32 payload;
 	int mtu;
 	int opcode;
+	int err;
 	int ret;
 	struct rxe_send_wqe rollback_wqe;
 	u32 rollback_psn;
@@ -635,7 +636,6 @@ int rxe_requester(void *arg)
 	if (!rxe_get(qp))
 		return -EAGAIN;
 
-next_wqe:
 	if (unlikely(!qp->valid || qp->req.state == QP_STATE_ERROR))
 		goto exit;
 
@@ -650,7 +650,7 @@ int rxe_requester(void *arg)
 		goto exit;
 	}
 
-	/* we come here if the retransmot timer has fired
+	/* we come here if the retransmit timer has fired
 	 * or if the rnr timer has fired. If the retransmit
 	 * timer fires while we are processing an RNR NAK wait
 	 * until the rnr timer has fired before starting the
@@ -671,11 +671,11 @@ int rxe_requester(void *arg)
 	}
 
 	if (wqe->mask & WR_LOCAL_OP_MASK) {
-		ret = rxe_do_local_ops(qp, wqe);
-		if (unlikely(ret))
+		err = rxe_do_local_ops(qp, wqe);
+		if (unlikely(err))
 			goto err;
 		else
-			goto next_wqe;
+			goto done;
 	}
 
 	if (unlikely(qp_type(qp) == IB_QPT_RC &&
@@ -724,8 +724,7 @@ int rxe_requester(void *arg)
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
 			__rxe_do_task(&qp->comp.task);
-			rxe_put(qp);
-			return 0;
+			goto done;
 		}
 		payload = mtu;
 	}
@@ -741,25 +740,29 @@ int rxe_requester(void *arg)
 	if (unlikely(!av)) {
 		pr_err("qp#%d Failed no address vector\n", qp_num(qp));
 		wqe->status = IB_WC_LOC_QP_OP_ERR;
-		goto err_drop_ah;
+		goto err;
 	}
 
 	skb = init_req_packet(qp, av, wqe, opcode, payload, &pkt);
 	if (unlikely(!skb)) {
 		pr_err("qp#%d Failed allocating skb\n", qp_num(qp));
 		wqe->status = IB_WC_LOC_QP_OP_ERR;
-		goto err_drop_ah;
+		if (ah)
+			rxe_put(ah);
+		goto err;
 	}
 
-	ret = finish_packet(qp, av, wqe, &pkt, skb, payload);
-	if (unlikely(ret)) {
+	err = finish_packet(qp, av, wqe, &pkt, skb, payload);
+	if (unlikely(err)) {
 		pr_debug("qp#%d Error during finish packet\n", qp_num(qp));
-		if (ret == -EFAULT)
+		if (err == -EFAULT)
 			wqe->status = IB_WC_LOC_PROT_ERR;
 		else
 			wqe->status = IB_WC_LOC_QP_OP_ERR;
 		kfree_skb(skb);
-		goto err_drop_ah;
+		if (ah)
+			rxe_put(ah);
+		goto err;
 	}
 
 	if (ah)
@@ -774,13 +777,14 @@ int rxe_requester(void *arg)
 	save_state(wqe, qp, &rollback_wqe, &rollback_psn);
 	update_wqe_state(qp, wqe, &pkt);
 	update_wqe_psn(qp, wqe, &pkt, payload);
-	ret = rxe_xmit_packet(qp, &pkt, skb);
-	if (ret) {
+
+	err = rxe_xmit_packet(qp, &pkt, skb);
+	if (err) {
 		qp->need_req_skb = 1;
 
 		rollback_state(wqe, qp, &rollback_wqe, rollback_psn);
 
-		if (ret == -EAGAIN) {
+		if (err == -EAGAIN) {
 			rxe_run_task(&qp->req.task, 1);
 			goto exit;
 		}
@@ -791,16 +795,20 @@ int rxe_requester(void *arg)
 
 	update_state(qp, &pkt);
 
-	goto next_wqe;
-
-err_drop_ah:
-	if (ah)
-		rxe_put(ah);
+	/* A non-zero return value will cause rxe_do_task to
+	 * exit its loop and end the tasklet. A zero return
+	 * will continue looping and return to rxe_requester
+	 */
+done:
+	ret = 0;
+	goto out;
 err:
 	wqe->state = wqe_state_error;
 	__rxe_do_task(&qp->comp.task);
-
 exit:
+	ret = -EAGAIN;
+out:
 	rxe_put(qp);
-	return -EAGAIN;
+
+	return ret;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 7aea5f06d061..a45b1d22bc77 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1258,17 +1258,15 @@ int rxe_responder(void *arg)
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	enum resp_states state;
 	struct rxe_pkt_info *pkt = NULL;
-	int ret = 0;
+	int ret;
 
 	if (!rxe_get(qp))
 		return -EAGAIN;
 
 	qp->resp.aeth_syndrome = AETH_ACK_UNLIMITED;
 
-	if (!qp->valid) {
-		ret = -EINVAL;
-		goto done;
-	}
+	if (!qp->valid)
+		goto exit;
 
 	switch (qp->resp.state) {
 	case QP_STATE_RESET:
@@ -1445,9 +1443,16 @@ int rxe_responder(void *arg)
 		}
 	}
 
+	/* A non-zero return value will cause rxe_do_task to
+	 * exit its loop and end the tasklet. A zero return
+	 * will continue looping and return to rxe_responder
+	 */
+done:
+	ret = 0;
+	goto out;
 exit:
 	ret = -EAGAIN;
-done:
+out:
 	rxe_put(qp);
 	return ret;
 }
-- 
2.34.1

