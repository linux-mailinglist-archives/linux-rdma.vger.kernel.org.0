Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932FD526F04
	for <lists+linux-rdma@lfdr.de>; Sat, 14 May 2022 09:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiENDJY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 May 2022 23:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiENDJW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 May 2022 23:09:22 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC52332DF2
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 20:09:20 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-d39f741ba0so12709637fac.13
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 20:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FLYsPTf3mH4pLVB6koKRyPCBVVH6lTi57dBdJm9igvE=;
        b=dK2de0dlD5M61/vPU36dLGPnuz2n4n9bXwyn9zpA917p0PzXaDJXTwmjyrOPFifqXt
         MXPllpuxQHTy4tCSrjz6trkt8x/DXMh0SZPHxCqMXd/IsFSyA5XNbFWSZkySA6hA75Pb
         7Hr7SaRY7ur751wWY+alE4Y5iYZ9vUtFWcQwmkmCwD6cMb5zD0mOXgC1N4hvR4lOF0a+
         trme6ZsKX2Z/DF32TT2a0KXXYVxMRkiO4/NqYQdeZNPV1PhhUlQ67Dqc3984qjs9YXAp
         Kau97fmtC1MKijPWJO60MqGUvAfgrX2R1PHRHpxN+HQ5UHYOQQaktC/hPVlyotbukCwr
         I4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FLYsPTf3mH4pLVB6koKRyPCBVVH6lTi57dBdJm9igvE=;
        b=UCenOCOErUlZ03iWRkCCqPRU6YKVTGqd80C/ZmULhhaGLK44sDr4xW7YlaXUV5Beu4
         Epvj1ZGr0lC7fjLlSGKdp6qfPe+w/w4SX2uRRlK9WR4Zhvm1dUvnkaDzvq2PnrtGfEth
         qkG7lqtuZ78VXvFel54vCCSJbntkOTIEsmdez+FqF26FwnNN0T5mtJJtoaoPFusUWaqz
         wMVYadDVbP2l7M4YWiE7Hgrb/tUf31M7+79diwmsdyvXun4az26tfMRaocNSq+MEdkIV
         f6o/9ROYOmMAZFbE5Z9u80acadIFtQ36IkpRFuDfvmCEM344l9qfo7rmrA9Wr6BzqJqv
         kUkw==
X-Gm-Message-State: AOAM533M9JdgCNc2/6eUBn4WbNmQJSLnr4ze9Smfr3wDgpJBto2vaqAp
        LhOMCf5TeKm+pifxFHCUcjAiOlfH9wQ=
X-Google-Smtp-Source: ABdhPJymjLYI8crjRSzVqeo65J96EY97eCse5xpCsHE236JpPQYUaGTyCYCRdrVuxPOuPJbKbecFNg==
X-Received: by 2002:a05:6870:7d08:b0:ee:7028:8829 with SMTP id os8-20020a0568707d0800b000ee70288829mr9581630oab.106.1652497759618;
        Fri, 13 May 2022 20:09:19 -0700 (PDT)
Received: from u-22.tx.rr.com (2603-8081-140c-1a00-0642-4ec7-2b63-14d6.res6.spectrum.com. [2603:8081:140c:1a00:642:4ec7:2b63:14d6])
        by smtp.googlemail.com with ESMTPSA id h64-20020a9d2f46000000b0060603221262sm1691176otb.50.2022.05.13.20.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 20:09:19 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, tom@talpey.com,
        linux-rdma@vger.kernel.org, jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-rc v2 3/4] RDMA/rxe: Fix rnr retry behavior
Date:   Fri, 13 May 2022 22:04:38 -0500
Message-Id: <20220514030435.91155-4-rpearsonhpe@gmail.com>
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

Currently the completer tasklet when it sets the retransmit timer or the
rnr timer sets the same flag (qp->req.need_retry) so that if either
timer fires it will attempt to perform a retry flow on the send queue.
This has the effect of responding to an RNR NAK at the first retransmit
timer event which might not allow for the requested rnr timeout.

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
v2
  Added comments and changed the name of the new flag to make things
  more understandable per an email exchange with Tom Talpey.
---
 drivers/infiniband/sw/rxe/rxe_comp.c  |  8 +++++++-
 drivers/infiniband/sw/rxe/rxe_qp.c    |  1 +
 drivers/infiniband/sw/rxe/rxe_req.c   | 15 +++++++++++++--
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 +
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index badd423966dc..3c77201c01d1 100644
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
@@ -729,11 +731,15 @@ int rxe_completer(void *arg)
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
index fc22ff36fdea..2f6f378a232d 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -513,6 +513,7 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 	atomic_set(&qp->ssn, 0);
 	qp->req.opcode = -1;
 	qp->req.need_retry = 0;
+	qp->req.wait_for_rnr_timer = 0;
 	qp->req.noack_pkts = 0;
 	qp->resp.msn = 0;
 	qp->resp.opcode = -1;
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index d15165e9319c..aa9066ff5257 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -103,7 +103,11 @@ void rnr_nak_timer(struct timer_list *t)
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
 
@@ -628,10 +632,17 @@ int rxe_requester(void *arg)
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
index 83b6f80440d8..a6c6f0d786c7 100644
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

