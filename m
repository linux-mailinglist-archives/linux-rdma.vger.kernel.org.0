Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D6D562294
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jun 2022 21:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbiF3TFO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jun 2022 15:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbiF3TFN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jun 2022 15:05:13 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1245937A06
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 12:05:13 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-101d2e81bceso585999fac.0
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 12:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xyz7156MFriJeXhwB/oxcEWhAksS88t3ZJa/MRrEWnc=;
        b=W+wBKdJurIF0GyLI+gOhLaUaY+Qv5PT6oas9Ua/f4kdIbvKdB78bV9SNzgZOUZjHGg
         QDojitB9uZ2VpqbmnCo3n9oYtGNmiqIQa/qHVLO+ZnZTpk57MMQ1ebIs+7MHiuawnsfX
         +Hey53jed8N7rAOjUZG/QJzEkxkIdis9ROPKqUv+APeQMBdTpCHyExlXYuHLAIs3QbdS
         GwYclnNUdEZokWHV9U4RFP/Foz2F8Q1PdKV8UMlkFinnnskb3iJQhv7bw/GMJWn59F1g
         +DVXbfZljLCizdBewSz3SxEPc/v+gCq1OIDavVep7NmSoh3eCZNdaExiqycnIc00EpfK
         Ny2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xyz7156MFriJeXhwB/oxcEWhAksS88t3ZJa/MRrEWnc=;
        b=0cR9rOEWRQalyNfCF3mMwMkXTJkaXsu7wlpOhNsLVMoB1vK/G40gSggPEuvVUR+sSN
         lgBayBfXhpxe0GJN7A+PHOlnfu0o4G8rkPyO+KDjLdAFhDf/9fMMSmYQWOVeJqWVPdew
         GYuOZfZ2fK4Fozn04rzpQqFwm36D5lbiPd3QrWqzTWDm2uPjczHInuYN4Civ6/mMEtzp
         4ZfTwn/lHTqdwrLtrnQNllONvHw0njrUkvDEQ7ZwiopxyzE+pV03Fxy+OkX5VXDe7avg
         t9XlBINEY4WZ23qZLQmMPD2vO6PFDHZYksKcHDlu5ZLBu2YreggTW+MckI91rUhldRYW
         Viww==
X-Gm-Message-State: AJIora/IhS4MEas0lv+krIRGxL+v1IG9q6iNEYqhP2IVC02J/2q1rokG
        3tOF61cELYbP7x7ZgYfPFzY=
X-Google-Smtp-Source: AGRyM1sVGkcwrxDjF6czfXHNKzNXnFYibUdsAocBybm3hCtdoIQZFnmM+RQezlPzdHNIPYX5yQoHJA==
X-Received: by 2002:a05:6870:331f:b0:10b:af85:e15 with SMTP id x31-20020a056870331f00b0010baf850e15mr1074864oae.124.1656615912698;
        Thu, 30 Jun 2022 12:05:12 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id o4-20020a9d4104000000b0060bfb4e4033sm11756442ote.9.2022.06.30.12.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 12:05:12 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 5/9] RDMA/rxe: Fix rnr retry behavior
Date:   Thu, 30 Jun 2022 14:04:22 -0500
Message-Id: <20220630190425.2251-6-rpearsonhpe@gmail.com>
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

Currently the completer tasklet when retransmit timer or the rnr timer
fires the same flag (qp->req.need_retry) is set so that if either
timer fires it will attempt to perform a retry flow on the send queue.
This has the effect of responding to an RNR NAK at the first retransmit
timer event which might not allow the requested rnr timeout.

This patch adds a new flag (qp->req.wait_for_rnr_timer) which, if set,
prevents a retry flow until the rnr nak timer fires.

This patch fixes rnr retry errors which can be observed by running the
pyverbs test_rdmacm_async_traffic_external_qp multiple times. With this
patch applied they do not occur.

Link: https://lore.kernel.org/linux-rdma/a8287823-1408-4273-bc22-99a0678db640@gmail.com/
Link: https://lore.kernel.org/linux-rdma/2bafda9e-2bb6-186d-12a1-179e8f6a2678@talpey.com/
Fixes: 8700e3e7c485 ("Soft RoCE (RXE) - The software RoCE driver")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  |  8 +++++++-
 drivers/infiniband/sw/rxe/rxe_qp.c    |  1 +
 drivers/infiniband/sw/rxe/rxe_req.c   | 15 +++++++++++++--
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 +
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index da3a398053b8..4fc31bb7eee6 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -114,6 +114,8 @@ void retransmit_timer(struct timer_list *t)
 {
 	struct rxe_qp *qp = from_timer(qp, t, retrans_timer);
 
+	pr_debug("%s: fired for qp#%d\n", __func__, qp->elem.index);
+
 	if (qp->valid) {
 		qp->comp.timeout = 1;
 		rxe_run_task(&qp->comp.task, 1);
@@ -730,11 +732,15 @@ int rxe_completer(void *arg)
 			break;
 
 		case COMPST_RNR_RETRY:
+			/* we come here if we received an RNR NAK */
 			if (qp->comp.rnr_retry > 0) {
 				if (qp->comp.rnr_retry != 7)
 					qp->comp.rnr_retry--;
 
-				qp->req.need_retry = 1;
+				/* don't start a retry flow until the
+				 * rnr timer has fired
+				 */
+				qp->req.wait_for_rnr_timer = 1;
 				pr_debug("qp#%d set rnr nak timer\n",
 					 qp_num(qp));
 				mod_timer(&qp->rnr_nak_timer,
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 22e9b85344c3..edc0c34feb05 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -507,6 +507,7 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 	atomic_set(&qp->ssn, 0);
 	qp->req.opcode = -1;
 	qp->req.need_retry = 0;
+	qp->req.wait_for_rnr_timer = 0;
 	qp->req.noack_pkts = 0;
 	qp->resp.msn = 0;
 	qp->resp.opcode = -1;
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index e8a1664a40eb..4d92f929d269 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -101,7 +101,11 @@ void rnr_nak_timer(struct timer_list *t)
 {
 	struct rxe_qp *qp = from_timer(qp, t, rnr_nak_timer);
 
-	pr_debug("qp#%d rnr nak timer fired\n", qp_num(qp));
+	pr_debug("%s: fired for qp#%d\n", __func__, qp_num(qp));
+
+	/* request a send queue retry */
+	qp->req.need_retry = 1;
+	qp->req.wait_for_rnr_timer = 0;
 	rxe_run_task(&qp->req.task, 1);
 }
 
@@ -640,10 +644,17 @@ int rxe_requester(void *arg)
 		qp->req.need_rd_atomic = 0;
 		qp->req.wait_psn = 0;
 		qp->req.need_retry = 0;
+		qp->req.wait_for_rnr_timer = 0;
 		goto exit;
 	}
 
-	if (unlikely(qp->req.need_retry)) {
+	/* we come here if the retransmot timer has fired
+	 * or if the rnr timer has fired. If the retransmit
+	 * timer fires while we are processing an RNR NAK wait
+	 * until the rnr timer has fired before starting the
+	 * retry flow
+	 */
+	if (unlikely(qp->req.need_retry && !qp->req.wait_for_rnr_timer)) {
 		req_retry(qp);
 		qp->req.need_retry = 0;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index ec9a70aecc1e..d9f01af4050d 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -123,6 +123,7 @@ struct rxe_req_info {
 	int			need_rd_atomic;
 	int			wait_psn;
 	int			need_retry;
+	int			wait_for_rnr_timer;
 	int			noack_pkts;
 	struct rxe_task		task;
 };
-- 
2.34.1

