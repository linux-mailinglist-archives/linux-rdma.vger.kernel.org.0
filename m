Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FF6526EED
	for <lists+linux-rdma@lfdr.de>; Sat, 14 May 2022 09:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiENDKy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 May 2022 23:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiENDKw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 May 2022 23:10:52 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227A233A27A
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 20:10:51 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id y63so12322383oia.7
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 20:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NRENJ0bxgIqZBpmM5qNHMIVE3NOny+0esbBqnsG0aFA=;
        b=qB7jQY7AwkK82LmaVCd4lY4xCGu06NT9hCR0Wd5WfITv+2A6SFQac5L5yluIoNHfDd
         1GT5GvbITbpSKIHeWfmwnnXEbJ2PspA/aaj8pTC9PL5R1hILfjTiYfn42PIRgmXfXFlO
         Xp/gV8jm45Ktfuwsy6qdqGOkNHY6oLrgEkqz6OgcihFKdkGc7Rf87cJn3EFGttgRuU9s
         0KllgMNq/aTLvKoTLJKCxFtwEFuWWUhGDlESVye5i/UWvdJYZZ7NEjUv1/1SvW4s5O99
         4mgxCWNzWJgQ7K3Fd2qo+cl+DLOJbg14RxWjYAjS/6H2EUcaWIzX5fZ4PugyTOE4Jpu9
         NkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NRENJ0bxgIqZBpmM5qNHMIVE3NOny+0esbBqnsG0aFA=;
        b=djavG1NxhMfgCV/RcndrigjrHZPJMpDqPHGba1AT7VOkBouZ68svqi73vmE8iYIdVj
         ccnuOns+UqzIuEipsTEz6miKQ8C+/Hd30Km/PeUhZuESC49Uxmm9DFeyLio8bb4Y6HbQ
         MG6zqEQ0kzCimZ+MEeLolB+Kz0+lhppfByinGeImkCXGsbA+VsEZ1ia/XJLSC3BcTQ9r
         kUJzHKLGjiLdpOGzz7rWdvTPcjLdHmt1P8WAuDS2eUFZGgNX36S/TdPhZYS0BfrMSgGX
         rvidDP36FDa33IA18buYix3Yzooa2zFoPqvOU+fLzkSkDL36a/zwyArdWcUO+Zubz/dq
         Xeqg==
X-Gm-Message-State: AOAM5308Pa+EHw8WzpALlKSEx0QzLJGCu6UvYgt7HO1Kb96i9a1UDfTQ
        2o22Ofi2Mm8IKcQmjT6V5W8=
X-Google-Smtp-Source: ABdhPJyu4P/qf6oA87EjqQscDvT6zzrUh204HuGzFbguaIME5X1HpZ5ojdmGwheqwNHOC3ZoPqp94w==
X-Received: by 2002:aca:f085:0:b0:328:c4cd:2b53 with SMTP id o127-20020acaf085000000b00328c4cd2b53mr5408519oih.197.1652497850465;
        Fri, 13 May 2022 20:10:50 -0700 (PDT)
Received: from u-22.tx.rr.com (2603-8081-140c-1a00-0642-4ec7-2b63-14d6.res6.spectrum.com. [2603:8081:140c:1a00:642:4ec7:2b63:14d6])
        by smtp.googlemail.com with ESMTPSA id h64-20020a9d2f46000000b0060603221262sm1691176otb.50.2022.05.13.20.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 20:10:50 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, tom@talpey.com,
        linux-rdma@vger.kernel.org, jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-rc v2 4/4] RDMA/rxe: Reduce spurious retransmit timeouts
Date:   Fri, 13 May 2022 22:04:40 -0500
Message-Id: <20220514030435.91155-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220514030435.91155-1-rpearsonhpe@gmail.com>
References: <20220514030435.91155-1-rpearsonhpe@gmail.com>
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

Currently the rxe driver sets a timer to handle response timeouts
from lost packets or other failures. However this timer is never
deleted so it will always fire in the period it was set for.
Under heavy load this means that there will be retry flows attempted
every few msec depending on the setting for retry timeout.

This patch modifies the driver in several ways to reduce the
number of spurious timeouts:

 - The psn of the current packet is saved when the timer is set
   for non-read requests and for read requests a psn in the
   expected response is saved. When a response packet is received
   by the completer tasklet that has a psn >= to the saved psn
   the timer is deleted.
 - As soon as there is no pending timer any new request will
   reset the timer. For long read replies the timer is reset
   as blocks of data arrive so that the response is covered by
   a timer.

For typical heavy loads (e.g. ib_send_bw etc.) the number of
retries is reduced from ~40 retries per second to one every
several seconds. These are legitimate timeouts where the responder
does not reply in the given time.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  | 50 ++++++++++++++++++---------
 drivers/infiniband/sw/rxe/rxe_req.c   | 26 ++++++++++++--
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 +
 3 files changed, 57 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 3c77201c01d1..a8ef1f781a24 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -170,12 +170,44 @@ static inline void reset_retry_counters(struct rxe_qp *qp)
 	qp->comp.started_retry = 0;
 }
 
+static void update_retransmit_timer(struct rxe_qp *qp,
+				    struct rxe_pkt_info *pkt,
+				    struct rxe_send_wqe *wqe)
+{
+	/* reset the retry timer for long read responses
+	 * if there is more data expected
+	 */
+	if ((pkt->opcode & 0x1f) == IB_OPCODE_RDMA_READ_REQUEST) {
+		int psn = (pkt->psn + RXE_MAX_PKT_PER_ACK) & 0xffffff;
+
+		if (psn_compare(psn, wqe->last_psn) > 0)
+			psn = wqe->last_psn;
+
+		if (psn_compare(psn, pkt->psn) > 0) {
+			atomic_set(&qp->timeout_psn, psn);
+			mod_timer(&qp->retrans_timer,
+				  jiffies + qp->timeout_jiffies);
+			return;
+		}
+	}
+
+	/* else just delete the timer */
+	del_timer_sync(&qp->retrans_timer);
+}
+
 static inline enum comp_state check_psn(struct rxe_qp *qp,
 					struct rxe_pkt_info *pkt,
 					struct rxe_send_wqe *wqe)
 {
 	s32 diff;
 
+	/* if this packet psn matches or exceeds the request that set the
+	 * retry timer update the timer.
+	 */
+	if ((psn_compare(pkt->psn, atomic_read(&qp->timeout_psn)) >= 0) &&
+	    timer_pending(&qp->retrans_timer))
+		update_retransmit_timer(qp, pkt, wqe);
+
 	/* check to see if response is past the oldest WQE. if it is, complete
 	 * send/write or error read/atomic
 	 */
@@ -663,20 +695,6 @@ int rxe_completer(void *arg)
 				break;
 			}
 
-			/* re reset the timeout counter if
-			 * (1) QP is type RC
-			 * (2) the QP is alive
-			 * (3) there is a packet sent by the requester that
-			 *     might be acked (we still might get spurious
-			 *     timeouts but try to keep them as few as possible)
-			 * (4) the timeout parameter is set
-			 */
-			if ((qp_type(qp) == IB_QPT_RC) &&
-			    (qp->req.state == QP_STATE_READY) &&
-			    (psn_compare(qp->req.psn, qp->comp.psn) > 0) &&
-			    qp->timeout_jiffies)
-				mod_timer(&qp->retrans_timer,
-					  jiffies + qp->timeout_jiffies);
 			ret = -EAGAIN;
 			goto done;
 
@@ -684,9 +702,7 @@ int rxe_completer(void *arg)
 			/* we come here if the retry timer fired and we did
 			 * not receive a response packet. try to retry the send
 			 * queue if that makes sense and the limits have not
-			 * been exceeded. remember that some timeouts are
-			 * spurious since we do not reset the timer but kick
-			 * it down the road or let it expire
+			 * been exceeded.
 			 */
 
 			/* there is nothing to retry in this case */
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index aa9066ff5257..5e031661bc49 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -397,7 +397,9 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 					 qp->attr.dest_qp_num;
 
 	ack_req = ((pkt->mask & RXE_END_MASK) ||
-		(qp->req.noack_pkts++ > RXE_MAX_PKT_PER_ACK));
+		   (qp->req.noack_pkts++ > RXE_MAX_PKT_PER_ACK) ||
+		   (qp->timeout_jiffies &&
+				!timer_pending(&qp->retrans_timer)));
 	if (ack_req) {
 		qp->req.noack_pkts = 0;
 		pkt->mask |= RXE_ACK_REQ_MASK;
@@ -545,10 +547,28 @@ static void update_state(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 
 	qp->need_req_skb = 0;
 
-	if ((pkt->mask & RXE_ACK_REQ_MASK) && qp->timeout_jiffies &&
-	    !timer_pending(&qp->retrans_timer))
+	/* reset the retry timer if the packet has the ackreq bit set,
+	 * we are using the retry timer and there is no timer set
+	 * currently
+	 */
+	if (pkt->mask & RXE_ACK_REQ_MASK && qp->timeout_jiffies &&
+	    !timer_pending(&qp->retrans_timer)) {
+		int psn = pkt->psn;
+
+		/* for read ops delay matching psn by RXE_MAX_PKT_PER_ACK
+		 * up to the last psn. The completer will also reset the
+		 * retry timer as required
+		 */
+		if ((pkt->opcode & 0x1f) == IB_OPCODE_RDMA_READ_REQUEST) {
+			psn = (psn + RXE_MAX_PKT_PER_ACK) & 0xffffff;
+			if (psn_compare(psn, wqe->last_psn) > 0)
+				psn = wqe->last_psn;
+		}
+
+		atomic_set(&qp->timeout_psn, psn);
 		mod_timer(&qp->retrans_timer,
 			  jiffies + qp->timeout_jiffies);
+	}
 }
 
 static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index a6c6f0d786c7..c41092d790f0 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -252,6 +252,7 @@ struct rxe_qp {
 	 */
 	struct timer_list	retrans_timer;
 	u64			timeout_jiffies;
+	atomic_t		timeout_psn;
 
 	/* Timer for handling RNR NAKS. */
 	struct timer_list	rnr_nak_timer;
-- 
2.34.1

