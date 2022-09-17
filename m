Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EC65BB5D1
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Sep 2022 05:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiIQDL5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Sep 2022 23:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiIQDLV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Sep 2022 23:11:21 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF829E0FD
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:11:18 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id h9-20020a9d5549000000b0063727299bb4so16109046oti.9
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ku0ZUcIZA3npQmzAHPTmYvCJbqp5m4nqBvFCAYUUG2w=;
        b=Tz76RYrfDHFNs8y/kJJvV220909bxwBpAVHYDQeWqdBgTfgrM7JITekMSVKzrI+xNl
         B/3In4DDECpkoM9YFetynRN+q/+PSkMfyl0kOpieDeU8c2ExoGN/ZSW6DQgU7NASj3Tc
         mxrer4ckB36SUf/a+t0Q9oaf4abNv3C98Q6RnRG5A8OrFvLgAPXSGjqts+RI5p0t21G6
         E8N5Ne9NryIlVPIKZaq5A9u+QzZMXLjtUlZQqA13vHB8rPkgcQGWkFBcrb8M4N5yIIA+
         nmRLzpyV+vYzSoSZ82A8WTyOcyOn/w1riM49Asrp+i/SqVH0sJ3Rdy7tOdtIAPAAg5Sm
         2uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ku0ZUcIZA3npQmzAHPTmYvCJbqp5m4nqBvFCAYUUG2w=;
        b=D20hG0bo7H23jf0bin/hVuIuZ0AX2YwH7bWrC2KyANwuohJefb2FbqfRWaURMvndcX
         RywmI/RYEuk0pvxe5X//oU5iznoKRo8qZQMDa+b5mZYmQM00CRn5bv/GuAaMJ3k+uio4
         bV4kYBM+DCqKZ3sD9xORTUBGQskEmFWwhaoifPehzcunSmzZYTLLeyhEX+YYAl07dFn9
         Dr4uItB1np6uqf7XN606SuYoWDmolIeJduQUUv04gwqGQb0SuyZN7QxkzVJzg5+CGaTL
         3pnZVnQPJlBMQTxdLTwc2qoJ8CB2VbAv6x1nBRFbBfoeCPDWzrqmETN3wsxfJnM24nNm
         Xr3w==
X-Gm-Message-State: ACrzQf1UZfiROpYwRc8O4R5oel8+5LCj/MVh8jSPx0AN7FEYUjh+RW3D
        9+B4JSwC13yCw+1ZYL5OvsL0iIZWd2Q=
X-Google-Smtp-Source: AMsMyM4++VijmLVspPdQ5MLNMXHHct6QrLDvH9h5f1sctewsR8FKreb6Ji3guGjH8S/Lw2LIh29zOw==
X-Received: by 2002:a05:6830:d86:b0:639:35d9:4b90 with SMTP id bv6-20020a0568300d8600b0063935d94b90mr3698644otb.184.1663384277349;
        Fri, 16 Sep 2022 20:11:17 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f9ea-fe1d-a45c-bca2.res6.spectrum.com. [2603:8081:140c:1a00:f9ea:fe1d:a45c:bca2])
        by smtp.googlemail.com with ESMTPSA id q17-20020a4a6c11000000b00475f26931c8sm921422ooc.13.2022.09.16.20.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 20:11:16 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 10/13] RDMA/rxe: Extend rxe_comp.c to support xrc qps
Date:   Fri, 16 Sep 2022 22:11:01 -0500
Message-Id: <20220917031104.21222-11-rpearsonhpe@gmail.com>
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

