Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F161C5EFBA7
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Sep 2022 19:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbiI2RJY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Sep 2022 13:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbiI2RJU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Sep 2022 13:09:20 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBB71D1E01
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 10:09:17 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id d74-20020a4a524d000000b004755f8aae16so529857oob.11
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 10:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ku0ZUcIZA3npQmzAHPTmYvCJbqp5m4nqBvFCAYUUG2w=;
        b=QypgKAedzTGaVDdff7L9RWA0idQzKQcrIDQ+niOOecq4kANkhclJ5MEnFCw/DGRd9h
         tXy5AvAS/jtuQPlz7cTPUx7b1ztetr22PfJ+Qkw4ojF/I1+aXLn5RKZjGh1fiQKKRURY
         X5cfUk7AdRJ0PJcf1OOiqAfHzq1xII8T/zdunDyDhtjGNweAvOW8s7+pwxxny/4ADSOZ
         +F3TAhoeMT8ADViCQLVTRJ+A5ymfBjuPZiwrqSPn72A/GBZY5rh5G/wb7YSOPhggbm07
         EcMq2rtORj+agL5WKQfIlivElyP6uqx+q3+WS+NdgMvlkM4xFRsWiqTeGvTRs2yBVzOD
         arQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ku0ZUcIZA3npQmzAHPTmYvCJbqp5m4nqBvFCAYUUG2w=;
        b=0Gz/bA1Y14dEcmEUd30d9KkWLmw9wlKW2U+Gg4enFZqVr8exwPzduyjzQydin3Fn50
         XtPt/dat5HS8DpunvFbHgEZq9yp2WanyMjFhMY8qtF9kMEYnmILFXTAW6ukxfTNUp2SE
         rIh98LYrZjQAeCi8mZYCG06YOMXfqNlZhB76PGMZKxEZrL9ai0Y0gnucZ6WlBjJ8cP/W
         EqABCojWaJgOxacjOTOuv6qIHq5ZSbuAvnEa+YF9kyKOlpPLAEyp/NUA/lbVNOBWd8G5
         rtKqJ6oBeyph08vVauD6H0403MOt7RJNN66b6s8xds8BwNJhrxv5T9POOsvG9vw81t8p
         AFqA==
X-Gm-Message-State: ACrzQf2KhVDNMQu7exuF0QBdd0TBIYtcyPgO+9q/atHKdkwJU1bvckWQ
        vRwtiiPFl5Le6fmS2+9y3Cs=
X-Google-Smtp-Source: AMsMyM4jZqTis+HEgW+apXpkIDS5+1rgfsnpscfxfywCJ/p4d/i50EkxJKt04LA/wKpfLD+Vai0bfQ==
X-Received: by 2002:a05:6830:2709:b0:659:d9e4:b6b with SMTP id j9-20020a056830270900b00659d9e40b6bmr1809738otu.9.1664471356445;
        Thu, 29 Sep 2022 10:09:16 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-c4e7-bfae-90ed-ac81.res6.spectrum.com. [2603:8081:140c:1a00:c4e7:bfae:90ed:ac81])
        by smtp.googlemail.com with ESMTPSA id v17-20020a056808005100b00349a06c581fsm2798557oic.3.2022.09.29.10.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 10:09:15 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 10/13] RDMA/rxe: Extend rxe_comp.c to support xrc qps
Date:   Thu, 29 Sep 2022 12:08:34 -0500
Message-Id: <20220929170836.17838-11-rpearsonhpe@gmail.com>
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

Extend code in rxe_comp.c to support xrc qp types.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 45 ++++++++++++++--------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 1f10ae4a35d5..cb6621b4055d 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -213,12 +213,13 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 					struct rxe_pkt_info *pkt,
 					struct rxe_send_wqe *wqe)
 {
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	unsigned int mask = pkt->mask;
+	int opcode;
 	u8 syn;
-	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 
-	/* Check the sequence only */
-	switch (qp->comp.opcode) {
+	/* Mask off type bits and check the sequence only */
+	switch (qp->comp.opcode & IB_OPCODE_CMD) {
 	case -1:
 		/* Will catch all *_ONLY cases. */
 		if (!(mask & RXE_FIRST_MASK))
@@ -226,42 +227,39 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 
 		break;
 
-	case IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST:
-	case IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE:
-		if (pkt->opcode != IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE &&
-		    pkt->opcode != IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST) {
+	case IB_OPCODE_RDMA_READ_RESPONSE_FIRST:
+	case IB_OPCODE_RDMA_READ_RESPONSE_MIDDLE:
+		opcode = pkt->opcode & IB_OPCODE_CMD;
+		if (opcode != IB_OPCODE_RDMA_READ_RESPONSE_MIDDLE &&
+		    opcode != IB_OPCODE_RDMA_READ_RESPONSE_LAST) {
 			/* read retries of partial data may restart from
 			 * read response first or response only.
 			 */
 			if ((pkt->psn == wqe->first_psn &&
-			     pkt->opcode ==
-			     IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST) ||
+			     opcode == IB_OPCODE_RDMA_READ_RESPONSE_FIRST) ||
 			    (wqe->first_psn == wqe->last_psn &&
-			     pkt->opcode ==
-			     IB_OPCODE_RC_RDMA_READ_RESPONSE_ONLY))
+			     opcode == IB_OPCODE_RDMA_READ_RESPONSE_ONLY))
 				break;
 
 			return COMPST_ERROR;
 		}
 		break;
 	default:
-		WARN_ON_ONCE(1);
+		//WARN_ON_ONCE(1);
 	}
 
-	/* Check operation validity. */
-	switch (pkt->opcode) {
-	case IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST:
-	case IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST:
-	case IB_OPCODE_RC_RDMA_READ_RESPONSE_ONLY:
+	/* Mask off the type bits and check operation validity. */
+	switch (pkt->opcode & IB_OPCODE_CMD) {
+	case IB_OPCODE_RDMA_READ_RESPONSE_FIRST:
+	case IB_OPCODE_RDMA_READ_RESPONSE_LAST:
+	case IB_OPCODE_RDMA_READ_RESPONSE_ONLY:
 		syn = aeth_syn(pkt);
 
 		if ((syn & AETH_TYPE_MASK) != AETH_ACK)
 			return COMPST_ERROR;
 
 		fallthrough;
-		/* (IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE doesn't have an AETH)
-		 */
-	case IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE:
+	case IB_OPCODE_RDMA_READ_RESPONSE_MIDDLE:
 		if (wqe->wr.opcode != IB_WR_RDMA_READ &&
 		    wqe->wr.opcode != IB_WR_RDMA_READ_WITH_INV) {
 			wqe->status = IB_WC_FATAL_ERR;
@@ -270,7 +268,7 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 		reset_retry_counters(qp);
 		return COMPST_READ;
 
-	case IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE:
+	case IB_OPCODE_ATOMIC_ACKNOWLEDGE:
 		syn = aeth_syn(pkt);
 
 		if ((syn & AETH_TYPE_MASK) != AETH_ACK)
@@ -282,7 +280,7 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 		reset_retry_counters(qp);
 		return COMPST_ATOMIC;
 
-	case IB_OPCODE_RC_ACKNOWLEDGE:
+	case IB_OPCODE_ACKNOWLEDGE:
 		syn = aeth_syn(pkt);
 		switch (syn & AETH_TYPE_MASK) {
 		case AETH_ACK:
@@ -669,7 +667,8 @@ int rxe_completer(void *arg)
 			 *     timeouts but try to keep them as few as possible)
 			 * (4) the timeout parameter is set
 			 */
-			if ((qp_type(qp) == IB_QPT_RC) &&
+			if ((qp_type(qp) == IB_QPT_RC ||
+			     qp_type(qp) == IB_QPT_XRC_INI) &&
 			    (qp->req.state == QP_STATE_READY) &&
 			    (psn_compare(qp->req.psn, qp->comp.psn) > 0) &&
 			    qp->qp_timeout_jiffies)
-- 
2.34.1

