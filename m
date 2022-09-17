Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CDB5BB5C7
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Sep 2022 05:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiIQDLr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Sep 2022 23:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiIQDLS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Sep 2022 23:11:18 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC247FE76
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:11:09 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-127ba06d03fso54754294fac.3
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=N+HFvYsN9f3IreSqbp8SrkkQdK4b4GU/q0s3J8TRGp4=;
        b=e+GMJstFyyPVmE2O0w02BC/cy7JCjPyFsej4DLFDxCYd0UOvTCIznNefj1HpykAsbb
         py/XpLRjqY2Zl07ooLDt3/ASBQ5mH3S7KLbMRarAQOF36O2X5GtqJeXYKOrZq6CE57xE
         0LTgHJDMMqejLSDjgKuIOlWWnwdqJXVf9XmkK6CJN0pbMfcuaa4Qm5BO3CqGy7ehklc2
         l8q6QyLGfTkJBcH8XzO3oYzhg11qauqs3njZi3oJTQGgBsXyStpRitDSrrxayKksSYd/
         mYdAIWbEOswUAY68UsZcFs2NiOJSGcEcLbDG51XRsnbHEKA4zr5DjQ/u5yPp6t5+qHqo
         lMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=N+HFvYsN9f3IreSqbp8SrkkQdK4b4GU/q0s3J8TRGp4=;
        b=s+GIVInrKS4xJIMcgs0/sH+UrRfYdDlR9xp4R8xPqdo+f1YGLjhAW+OgmYgsDrrCqg
         9E6JWt3aMR7ra3cNOSXKZtMVYv8Sy6JUUxq8A2AUsVn+SwAvim7HrFDejlnQz2kNbhDG
         zmghCqYP4s0E99Mz9d29oYHE4G6FD+22VFKZ5eRDe30rX5+ybfGtWm9afPGqxk5hzDwC
         lt1pTjbKrZU8rXkHyphB4SCYnlGvp3mE8tkFQjPLNlUkK95SlB4FPR6spzR/MYEoyu6j
         WlYVfdQJo3w9WBOklwG208lK52uk3u1yB5fMiW0Xz5cUE3yyGORtvfKlLKSKZJnXQIod
         DuWQ==
X-Gm-Message-State: ACgBeo06Fs9KUbjmXxT3JrdSo7zRd5EEOEHSrk9cN6zOBL1vMSnKofgw
        Pcs6jaIMuD9xuSF13skJlBA=
X-Google-Smtp-Source: AA6agR6OfM+EJrcXSlI2ueBkFDBWnuPtJqY0u9xxlYeX4UpjZs0Jb/bztLTecIEbhwvSRNsZ866TZQ==
X-Received: by 2002:a05:6870:5581:b0:11e:300:8189 with SMTP id n1-20020a056870558100b0011e03008189mr10191327oao.199.1663384268406;
        Fri, 16 Sep 2022 20:11:08 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f9ea-fe1d-a45c-bca2.res6.spectrum.com. [2603:8081:140c:1a00:f9ea:fe1d:a45c:bca2])
        by smtp.googlemail.com with ESMTPSA id q17-20020a4a6c11000000b00475f26931c8sm921422ooc.13.2022.09.16.20.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 20:11:08 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 01/13] RDMA/rxe: Replace START->FIRST, END->LAST
Date:   Fri, 16 Sep 2022 22:10:52 -0500
Message-Id: <20220917031104.21222-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220917031104.21222-1-rpearsonhpe@gmail.com>
References: <20220917031104.21222-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replace RXE_START_MASK by RXE_FIRST_MASK, RXE_END_MASK by
RXE_LAST_MASK and add RXE_ONLY_MASK = FIRST | LAST to match
normal IBA usage.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c   |   6 +-
 drivers/infiniband/sw/rxe/rxe_net.c    |   2 +-
 drivers/infiniband/sw/rxe/rxe_opcode.c | 143 +++++++++++--------------
 drivers/infiniband/sw/rxe/rxe_opcode.h |   5 +-
 drivers/infiniband/sw/rxe/rxe_req.c    |  10 +-
 drivers/infiniband/sw/rxe/rxe_resp.c   |   4 +-
 6 files changed, 76 insertions(+), 94 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index fb0c008af78c..1f10ae4a35d5 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -221,7 +221,7 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 	switch (qp->comp.opcode) {
 	case -1:
 		/* Will catch all *_ONLY cases. */
-		if (!(mask & RXE_START_MASK))
+		if (!(mask & RXE_FIRST_MASK))
 			return COMPST_ERROR;
 
 		break;
@@ -354,7 +354,7 @@ static inline enum comp_state do_read(struct rxe_qp *qp,
 		return COMPST_ERROR;
 	}
 
-	if (wqe->dma.resid == 0 && (pkt->mask & RXE_END_MASK))
+	if (wqe->dma.resid == 0 && (pkt->mask & RXE_LAST_MASK))
 		return COMPST_COMP_ACK;
 
 	return COMPST_UPDATE_COMP;
@@ -636,7 +636,7 @@ int rxe_completer(void *arg)
 			break;
 
 		case COMPST_UPDATE_COMP:
-			if (pkt->mask & RXE_END_MASK)
+			if (pkt->mask & RXE_LAST_MASK)
 				qp->comp.opcode = -1;
 			else
 				qp->comp.opcode = pkt->opcode;
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index c53f4529f098..d46190ad082f 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -428,7 +428,7 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	}
 
 	if ((qp_type(qp) != IB_QPT_RC) &&
-	    (pkt->mask & RXE_END_MASK)) {
+	    (pkt->mask & RXE_LAST_MASK)) {
 		pkt->wqe->state = wqe_state_done;
 		rxe_run_task(&qp->comp.task, 1);
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
index d4ba4d506f17..0ea587c15931 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -107,7 +107,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RC_SEND_FIRST]			= {
 		.name	= "IB_OPCODE_RC_SEND_FIRST",
 		.mask	= RXE_PAYLOAD_MASK | RXE_REQ_MASK | RXE_RWR_MASK |
-			  RXE_SEND_MASK | RXE_START_MASK,
+			  RXE_SEND_MASK | RXE_FIRST_MASK,
 		.length = RXE_BTH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -127,7 +127,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RC_SEND_LAST]			= {
 		.name	= "IB_OPCODE_RC_SEND_LAST",
 		.mask	= RXE_PAYLOAD_MASK | RXE_REQ_MASK | RXE_COMP_MASK |
-			  RXE_SEND_MASK | RXE_END_MASK,
+			  RXE_SEND_MASK | RXE_LAST_MASK,
 		.length = RXE_BTH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -137,7 +137,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RC_SEND_LAST_WITH_IMMEDIATE]		= {
 		.name	= "IB_OPCODE_RC_SEND_LAST_WITH_IMMEDIATE",
 		.mask	= RXE_IMMDT_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK |
-			  RXE_COMP_MASK | RXE_SEND_MASK | RXE_END_MASK,
+			  RXE_COMP_MASK | RXE_SEND_MASK | RXE_LAST_MASK,
 		.length = RXE_BTH_BYTES + RXE_IMMDT_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -149,8 +149,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RC_SEND_ONLY]			= {
 		.name	= "IB_OPCODE_RC_SEND_ONLY",
 		.mask	= RXE_PAYLOAD_MASK | RXE_REQ_MASK | RXE_COMP_MASK |
-			  RXE_RWR_MASK | RXE_SEND_MASK |
-			  RXE_START_MASK | RXE_END_MASK,
+			  RXE_RWR_MASK | RXE_SEND_MASK | RXE_ONLY_MASK,
 		.length = RXE_BTH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -161,7 +160,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 		.name	= "IB_OPCODE_RC_SEND_ONLY_WITH_IMMEDIATE",
 		.mask	= RXE_IMMDT_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK |
 			  RXE_COMP_MASK | RXE_RWR_MASK | RXE_SEND_MASK |
-			  RXE_START_MASK | RXE_END_MASK,
+			  RXE_ONLY_MASK,
 		.length = RXE_BTH_BYTES + RXE_IMMDT_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -173,7 +172,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RC_RDMA_WRITE_FIRST]		= {
 		.name	= "IB_OPCODE_RC_RDMA_WRITE_FIRST",
 		.mask	= RXE_RETH_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK |
-			  RXE_WRITE_MASK | RXE_START_MASK,
+			  RXE_WRITE_MASK | RXE_FIRST_MASK,
 		.length = RXE_BTH_BYTES + RXE_RETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -195,7 +194,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RC_RDMA_WRITE_LAST]			= {
 		.name	= "IB_OPCODE_RC_RDMA_WRITE_LAST",
 		.mask	= RXE_PAYLOAD_MASK | RXE_REQ_MASK | RXE_WRITE_MASK |
-			  RXE_END_MASK,
+			  RXE_LAST_MASK,
 		.length = RXE_BTH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -206,7 +205,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 		.name	= "IB_OPCODE_RC_RDMA_WRITE_LAST_WITH_IMMEDIATE",
 		.mask	= RXE_IMMDT_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK |
 			  RXE_WRITE_MASK | RXE_COMP_MASK | RXE_RWR_MASK |
-			  RXE_END_MASK,
+			  RXE_LAST_MASK,
 		.length = RXE_BTH_BYTES + RXE_IMMDT_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -218,8 +217,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RC_RDMA_WRITE_ONLY]			= {
 		.name	= "IB_OPCODE_RC_RDMA_WRITE_ONLY",
 		.mask	= RXE_RETH_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK |
-			  RXE_WRITE_MASK | RXE_START_MASK |
-			  RXE_END_MASK,
+			  RXE_WRITE_MASK | RXE_ONLY_MASK,
 		.length = RXE_BTH_BYTES + RXE_RETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -231,9 +229,8 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RC_RDMA_WRITE_ONLY_WITH_IMMEDIATE]		= {
 		.name	= "IB_OPCODE_RC_RDMA_WRITE_ONLY_WITH_IMMEDIATE",
 		.mask	= RXE_RETH_MASK | RXE_IMMDT_MASK | RXE_PAYLOAD_MASK |
-			  RXE_REQ_MASK | RXE_WRITE_MASK |
-			  RXE_COMP_MASK | RXE_RWR_MASK |
-			  RXE_START_MASK | RXE_END_MASK,
+			  RXE_REQ_MASK | RXE_WRITE_MASK | RXE_COMP_MASK |
+			  RXE_RWR_MASK | RXE_ONLY_MASK,
 		.length = RXE_BTH_BYTES + RXE_IMMDT_BYTES + RXE_RETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -248,7 +245,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RC_RDMA_READ_REQUEST]			= {
 		.name	= "IB_OPCODE_RC_RDMA_READ_REQUEST",
 		.mask	= RXE_RETH_MASK | RXE_REQ_MASK | RXE_READ_MASK |
-			  RXE_START_MASK | RXE_END_MASK,
+			  RXE_ONLY_MASK,
 		.length = RXE_BTH_BYTES + RXE_RETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -260,7 +257,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST]		= {
 		.name	= "IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST",
 		.mask	= RXE_AETH_MASK | RXE_PAYLOAD_MASK | RXE_ACK_MASK |
-			  RXE_START_MASK,
+			  RXE_FIRST_MASK,
 		.length = RXE_BTH_BYTES + RXE_AETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -281,7 +278,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST]		= {
 		.name	= "IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST",
 		.mask	= RXE_AETH_MASK | RXE_PAYLOAD_MASK | RXE_ACK_MASK |
-			  RXE_END_MASK,
+			  RXE_LAST_MASK,
 		.length = RXE_BTH_BYTES + RXE_AETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -293,7 +290,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RC_RDMA_READ_RESPONSE_ONLY]		= {
 		.name	= "IB_OPCODE_RC_RDMA_READ_RESPONSE_ONLY",
 		.mask	= RXE_AETH_MASK | RXE_PAYLOAD_MASK | RXE_ACK_MASK |
-			  RXE_START_MASK | RXE_END_MASK,
+			  RXE_ONLY_MASK,
 		.length = RXE_BTH_BYTES + RXE_AETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -304,8 +301,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	},
 	[IB_OPCODE_RC_ACKNOWLEDGE]			= {
 		.name	= "IB_OPCODE_RC_ACKNOWLEDGE",
-		.mask	= RXE_AETH_MASK | RXE_ACK_MASK | RXE_START_MASK |
-			  RXE_END_MASK,
+		.mask	= RXE_AETH_MASK | RXE_ACK_MASK | RXE_ONLY_MASK,
 		.length = RXE_BTH_BYTES + RXE_AETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -317,7 +313,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE]			= {
 		.name	= "IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE",
 		.mask	= RXE_AETH_MASK | RXE_ATMACK_MASK | RXE_ACK_MASK |
-			  RXE_START_MASK | RXE_END_MASK,
+			  RXE_ONLY_MASK,
 		.length = RXE_BTH_BYTES + RXE_ATMACK_BYTES + RXE_AETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -332,7 +328,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RC_COMPARE_SWAP]			= {
 		.name	= "IB_OPCODE_RC_COMPARE_SWAP",
 		.mask	= RXE_ATMETH_MASK | RXE_REQ_MASK | RXE_ATOMIC_MASK |
-			  RXE_START_MASK | RXE_END_MASK,
+			  RXE_ONLY_MASK,
 		.length = RXE_BTH_BYTES + RXE_ATMETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -344,7 +340,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RC_FETCH_ADD]			= {
 		.name	= "IB_OPCODE_RC_FETCH_ADD",
 		.mask	= RXE_ATMETH_MASK | RXE_REQ_MASK | RXE_ATOMIC_MASK |
-			  RXE_START_MASK | RXE_END_MASK,
+			  RXE_ONLY_MASK,
 		.length = RXE_BTH_BYTES + RXE_ATMETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -356,7 +352,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RC_SEND_LAST_WITH_INVALIDATE]		= {
 		.name	= "IB_OPCODE_RC_SEND_LAST_WITH_INVALIDATE",
 		.mask	= RXE_IETH_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK |
-			  RXE_COMP_MASK | RXE_SEND_MASK | RXE_END_MASK,
+			  RXE_COMP_MASK | RXE_SEND_MASK | RXE_LAST_MASK,
 		.length = RXE_BTH_BYTES + RXE_IETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -369,7 +365,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 		.name	= "IB_OPCODE_RC_SEND_ONLY_INV",
 		.mask	= RXE_IETH_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK |
 			  RXE_COMP_MASK | RXE_RWR_MASK | RXE_SEND_MASK |
-			  RXE_END_MASK  | RXE_START_MASK,
+			  RXE_ONLY_MASK,
 		.length = RXE_BTH_BYTES + RXE_IETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -383,7 +379,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_UC_SEND_FIRST]			= {
 		.name	= "IB_OPCODE_UC_SEND_FIRST",
 		.mask	= RXE_PAYLOAD_MASK | RXE_REQ_MASK | RXE_RWR_MASK |
-			  RXE_SEND_MASK | RXE_START_MASK,
+			  RXE_SEND_MASK | RXE_FIRST_MASK,
 		.length = RXE_BTH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -403,7 +399,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_UC_SEND_LAST]			= {
 		.name	= "IB_OPCODE_UC_SEND_LAST",
 		.mask	= RXE_PAYLOAD_MASK | RXE_REQ_MASK | RXE_COMP_MASK |
-			  RXE_SEND_MASK | RXE_END_MASK,
+			  RXE_SEND_MASK | RXE_LAST_MASK,
 		.length = RXE_BTH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -413,7 +409,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_UC_SEND_LAST_WITH_IMMEDIATE]		= {
 		.name	= "IB_OPCODE_UC_SEND_LAST_WITH_IMMEDIATE",
 		.mask	= RXE_IMMDT_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK |
-			  RXE_COMP_MASK | RXE_SEND_MASK | RXE_END_MASK,
+			  RXE_COMP_MASK | RXE_SEND_MASK | RXE_LAST_MASK,
 		.length = RXE_BTH_BYTES + RXE_IMMDT_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -425,8 +421,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_UC_SEND_ONLY]			= {
 		.name	= "IB_OPCODE_UC_SEND_ONLY",
 		.mask	= RXE_PAYLOAD_MASK | RXE_REQ_MASK | RXE_COMP_MASK |
-			  RXE_RWR_MASK | RXE_SEND_MASK |
-			  RXE_START_MASK | RXE_END_MASK,
+			  RXE_RWR_MASK | RXE_SEND_MASK | RXE_ONLY_MASK,
 		.length = RXE_BTH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -437,7 +432,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 		.name	= "IB_OPCODE_UC_SEND_ONLY_WITH_IMMEDIATE",
 		.mask	= RXE_IMMDT_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK |
 			  RXE_COMP_MASK | RXE_RWR_MASK | RXE_SEND_MASK |
-			  RXE_START_MASK | RXE_END_MASK,
+			  RXE_ONLY_MASK,
 		.length = RXE_BTH_BYTES + RXE_IMMDT_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -449,7 +444,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_UC_RDMA_WRITE_FIRST]		= {
 		.name	= "IB_OPCODE_UC_RDMA_WRITE_FIRST",
 		.mask	= RXE_RETH_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK |
-			  RXE_WRITE_MASK | RXE_START_MASK,
+			  RXE_WRITE_MASK | RXE_FIRST_MASK,
 		.length = RXE_BTH_BYTES + RXE_RETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -471,7 +466,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_UC_RDMA_WRITE_LAST]			= {
 		.name	= "IB_OPCODE_UC_RDMA_WRITE_LAST",
 		.mask	= RXE_PAYLOAD_MASK | RXE_REQ_MASK | RXE_WRITE_MASK |
-			  RXE_END_MASK,
+			  RXE_LAST_MASK,
 		.length = RXE_BTH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -482,7 +477,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 		.name	= "IB_OPCODE_UC_RDMA_WRITE_LAST_WITH_IMMEDIATE",
 		.mask	= RXE_IMMDT_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK |
 			  RXE_WRITE_MASK | RXE_COMP_MASK | RXE_RWR_MASK |
-			  RXE_END_MASK,
+			  RXE_LAST_MASK,
 		.length = RXE_BTH_BYTES + RXE_IMMDT_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -494,8 +489,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_UC_RDMA_WRITE_ONLY]			= {
 		.name	= "IB_OPCODE_UC_RDMA_WRITE_ONLY",
 		.mask	= RXE_RETH_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK |
-			  RXE_WRITE_MASK | RXE_START_MASK |
-			  RXE_END_MASK,
+			  RXE_WRITE_MASK | RXE_ONLY_MASK,
 		.length = RXE_BTH_BYTES + RXE_RETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -507,9 +501,8 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_UC_RDMA_WRITE_ONLY_WITH_IMMEDIATE]		= {
 		.name	= "IB_OPCODE_UC_RDMA_WRITE_ONLY_WITH_IMMEDIATE",
 		.mask	= RXE_RETH_MASK | RXE_IMMDT_MASK | RXE_PAYLOAD_MASK |
-			  RXE_REQ_MASK | RXE_WRITE_MASK |
-			  RXE_COMP_MASK | RXE_RWR_MASK |
-			  RXE_START_MASK | RXE_END_MASK,
+			  RXE_REQ_MASK | RXE_WRITE_MASK | RXE_COMP_MASK |
+			  RXE_RWR_MASK | RXE_ONLY_MASK,
 		.length = RXE_BTH_BYTES + RXE_IMMDT_BYTES + RXE_RETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -527,7 +520,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 		.name	= "IB_OPCODE_RD_SEND_FIRST",
 		.mask	= RXE_RDETH_MASK | RXE_DETH_MASK | RXE_PAYLOAD_MASK |
 			  RXE_REQ_MASK | RXE_RWR_MASK | RXE_SEND_MASK |
-			  RXE_START_MASK,
+			  RXE_FIRST_MASK,
 		.length = RXE_BTH_BYTES + RXE_DETH_BYTES + RXE_RDETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -542,8 +535,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RD_SEND_MIDDLE]		= {
 		.name	= "IB_OPCODE_RD_SEND_MIDDLE",
 		.mask	= RXE_RDETH_MASK | RXE_DETH_MASK | RXE_PAYLOAD_MASK |
-			  RXE_REQ_MASK | RXE_SEND_MASK |
-			  RXE_MIDDLE_MASK,
+			  RXE_REQ_MASK | RXE_SEND_MASK | RXE_MIDDLE_MASK,
 		.length = RXE_BTH_BYTES + RXE_DETH_BYTES + RXE_RDETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -559,7 +551,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 		.name	= "IB_OPCODE_RD_SEND_LAST",
 		.mask	= RXE_RDETH_MASK | RXE_DETH_MASK | RXE_PAYLOAD_MASK |
 			  RXE_REQ_MASK | RXE_COMP_MASK | RXE_SEND_MASK |
-			  RXE_END_MASK,
+			  RXE_LAST_MASK,
 		.length = RXE_BTH_BYTES + RXE_DETH_BYTES + RXE_RDETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -574,9 +566,8 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RD_SEND_LAST_WITH_IMMEDIATE]		= {
 		.name	= "IB_OPCODE_RD_SEND_LAST_WITH_IMMEDIATE",
 		.mask	= RXE_RDETH_MASK | RXE_DETH_MASK | RXE_IMMDT_MASK |
-			  RXE_PAYLOAD_MASK | RXE_REQ_MASK |
-			  RXE_COMP_MASK | RXE_SEND_MASK |
-			  RXE_END_MASK,
+			  RXE_PAYLOAD_MASK | RXE_REQ_MASK | RXE_COMP_MASK |
+			  RXE_SEND_MASK | RXE_LAST_MASK,
 		.length = RXE_BTH_BYTES + RXE_IMMDT_BYTES + RXE_DETH_BYTES +
 			  RXE_RDETH_BYTES,
 		.offset = {
@@ -597,7 +588,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 		.name	= "IB_OPCODE_RD_SEND_ONLY",
 		.mask	= RXE_RDETH_MASK | RXE_DETH_MASK | RXE_PAYLOAD_MASK |
 			  RXE_REQ_MASK | RXE_COMP_MASK | RXE_RWR_MASK |
-			  RXE_SEND_MASK | RXE_START_MASK | RXE_END_MASK,
+			  RXE_SEND_MASK | RXE_ONLY_MASK,
 		.length = RXE_BTH_BYTES + RXE_DETH_BYTES + RXE_RDETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -612,9 +603,8 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RD_SEND_ONLY_WITH_IMMEDIATE]		= {
 		.name	= "IB_OPCODE_RD_SEND_ONLY_WITH_IMMEDIATE",
 		.mask	= RXE_RDETH_MASK | RXE_DETH_MASK | RXE_IMMDT_MASK |
-			  RXE_PAYLOAD_MASK | RXE_REQ_MASK |
-			  RXE_COMP_MASK | RXE_RWR_MASK | RXE_SEND_MASK |
-			  RXE_START_MASK | RXE_END_MASK,
+			  RXE_PAYLOAD_MASK | RXE_REQ_MASK | RXE_COMP_MASK |
+			  RXE_RWR_MASK | RXE_SEND_MASK | RXE_ONLY_MASK,
 		.length = RXE_BTH_BYTES + RXE_IMMDT_BYTES + RXE_DETH_BYTES +
 			  RXE_RDETH_BYTES,
 		.offset = {
@@ -634,8 +624,8 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RD_RDMA_WRITE_FIRST]		= {
 		.name	= "IB_OPCODE_RD_RDMA_WRITE_FIRST",
 		.mask	= RXE_RDETH_MASK | RXE_DETH_MASK | RXE_RETH_MASK |
-			  RXE_PAYLOAD_MASK | RXE_REQ_MASK |
-			  RXE_WRITE_MASK | RXE_START_MASK,
+			  RXE_PAYLOAD_MASK | RXE_REQ_MASK | RXE_WRITE_MASK |
+			  RXE_FIRST_MASK,
 		.length = RXE_BTH_BYTES + RXE_RETH_BYTES + RXE_DETH_BYTES +
 			  RXE_RDETH_BYTES,
 		.offset = {
@@ -655,8 +645,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RD_RDMA_WRITE_MIDDLE]		= {
 		.name	= "IB_OPCODE_RD_RDMA_WRITE_MIDDLE",
 		.mask	= RXE_RDETH_MASK | RXE_DETH_MASK | RXE_PAYLOAD_MASK |
-			  RXE_REQ_MASK | RXE_WRITE_MASK |
-			  RXE_MIDDLE_MASK,
+			  RXE_REQ_MASK | RXE_WRITE_MASK | RXE_MIDDLE_MASK,
 		.length = RXE_BTH_BYTES + RXE_DETH_BYTES + RXE_RDETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -671,8 +660,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RD_RDMA_WRITE_LAST]			= {
 		.name	= "IB_OPCODE_RD_RDMA_WRITE_LAST",
 		.mask	= RXE_RDETH_MASK | RXE_DETH_MASK | RXE_PAYLOAD_MASK |
-			  RXE_REQ_MASK | RXE_WRITE_MASK |
-			  RXE_END_MASK,
+			  RXE_REQ_MASK | RXE_WRITE_MASK | RXE_LAST_MASK,
 		.length = RXE_BTH_BYTES + RXE_DETH_BYTES + RXE_RDETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -687,9 +675,8 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RD_RDMA_WRITE_LAST_WITH_IMMEDIATE]		= {
 		.name	= "IB_OPCODE_RD_RDMA_WRITE_LAST_WITH_IMMEDIATE",
 		.mask	= RXE_RDETH_MASK | RXE_DETH_MASK | RXE_IMMDT_MASK |
-			  RXE_PAYLOAD_MASK | RXE_REQ_MASK |
-			  RXE_WRITE_MASK | RXE_COMP_MASK | RXE_RWR_MASK |
-			  RXE_END_MASK,
+			  RXE_PAYLOAD_MASK | RXE_REQ_MASK | RXE_WRITE_MASK |
+			  RXE_COMP_MASK | RXE_RWR_MASK | RXE_LAST_MASK,
 		.length = RXE_BTH_BYTES + RXE_IMMDT_BYTES + RXE_DETH_BYTES +
 			  RXE_RDETH_BYTES,
 		.offset = {
@@ -709,9 +696,8 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RD_RDMA_WRITE_ONLY]			= {
 		.name	= "IB_OPCODE_RD_RDMA_WRITE_ONLY",
 		.mask	= RXE_RDETH_MASK | RXE_DETH_MASK | RXE_RETH_MASK |
-				RXE_PAYLOAD_MASK | RXE_REQ_MASK |
-				RXE_WRITE_MASK | RXE_START_MASK |
-				RXE_END_MASK,
+			  RXE_PAYLOAD_MASK | RXE_REQ_MASK | RXE_WRITE_MASK |
+			  RXE_ONLY_MASK,
 		.length = RXE_BTH_BYTES + RXE_RETH_BYTES + RXE_DETH_BYTES +
 			  RXE_RDETH_BYTES,
 		.offset = {
@@ -731,10 +717,9 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RD_RDMA_WRITE_ONLY_WITH_IMMEDIATE]		= {
 		.name	= "IB_OPCODE_RD_RDMA_WRITE_ONLY_WITH_IMMEDIATE",
 		.mask	= RXE_RDETH_MASK | RXE_DETH_MASK | RXE_RETH_MASK |
-			  RXE_IMMDT_MASK | RXE_PAYLOAD_MASK |
-			  RXE_REQ_MASK | RXE_WRITE_MASK |
-			  RXE_COMP_MASK | RXE_RWR_MASK |
-			  RXE_START_MASK | RXE_END_MASK,
+			  RXE_IMMDT_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK |
+			  RXE_WRITE_MASK | RXE_COMP_MASK | RXE_RWR_MASK |
+			  RXE_ONLY_MASK,
 		.length = RXE_BTH_BYTES + RXE_IMMDT_BYTES + RXE_RETH_BYTES +
 			  RXE_DETH_BYTES + RXE_RDETH_BYTES,
 		.offset = {
@@ -759,8 +744,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RD_RDMA_READ_REQUEST]			= {
 		.name	= "IB_OPCODE_RD_RDMA_READ_REQUEST",
 		.mask	= RXE_RDETH_MASK | RXE_DETH_MASK | RXE_RETH_MASK |
-			  RXE_REQ_MASK | RXE_READ_MASK |
-			  RXE_START_MASK | RXE_END_MASK,
+			  RXE_REQ_MASK | RXE_READ_MASK | RXE_ONLY_MASK,
 		.length = RXE_BTH_BYTES + RXE_RETH_BYTES + RXE_DETH_BYTES +
 			  RXE_RDETH_BYTES,
 		.offset = {
@@ -779,9 +763,8 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	},
 	[IB_OPCODE_RD_RDMA_READ_RESPONSE_FIRST]		= {
 		.name	= "IB_OPCODE_RD_RDMA_READ_RESPONSE_FIRST",
-		.mask	= RXE_RDETH_MASK | RXE_AETH_MASK |
-			  RXE_PAYLOAD_MASK | RXE_ACK_MASK |
-			  RXE_START_MASK,
+		.mask	= RXE_RDETH_MASK | RXE_AETH_MASK | RXE_PAYLOAD_MASK |
+			  RXE_ACK_MASK | RXE_FIRST_MASK,
 		.length = RXE_BTH_BYTES + RXE_AETH_BYTES + RXE_RDETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -808,7 +791,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RD_RDMA_READ_RESPONSE_LAST]		= {
 		.name	= "IB_OPCODE_RD_RDMA_READ_RESPONSE_LAST",
 		.mask	= RXE_RDETH_MASK | RXE_AETH_MASK | RXE_PAYLOAD_MASK |
-			  RXE_ACK_MASK | RXE_END_MASK,
+			  RXE_ACK_MASK | RXE_LAST_MASK,
 		.length = RXE_BTH_BYTES + RXE_AETH_BYTES + RXE_RDETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -823,7 +806,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RD_RDMA_READ_RESPONSE_ONLY]		= {
 		.name	= "IB_OPCODE_RD_RDMA_READ_RESPONSE_ONLY",
 		.mask	= RXE_RDETH_MASK | RXE_AETH_MASK | RXE_PAYLOAD_MASK |
-			  RXE_ACK_MASK | RXE_START_MASK | RXE_END_MASK,
+			  RXE_ACK_MASK | RXE_ONLY_MASK,
 		.length = RXE_BTH_BYTES + RXE_AETH_BYTES + RXE_RDETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -838,7 +821,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RD_ACKNOWLEDGE]			= {
 		.name	= "IB_OPCODE_RD_ACKNOWLEDGE",
 		.mask	= RXE_RDETH_MASK | RXE_AETH_MASK | RXE_ACK_MASK |
-			  RXE_START_MASK | RXE_END_MASK,
+			  RXE_ONLY_MASK,
 		.length = RXE_BTH_BYTES + RXE_AETH_BYTES + RXE_RDETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -850,7 +833,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RD_ATOMIC_ACKNOWLEDGE]			= {
 		.name	= "IB_OPCODE_RD_ATOMIC_ACKNOWLEDGE",
 		.mask	= RXE_RDETH_MASK | RXE_AETH_MASK | RXE_ATMACK_MASK |
-			  RXE_ACK_MASK | RXE_START_MASK | RXE_END_MASK,
+			  RXE_ACK_MASK | RXE_ONLY_MASK,
 		.length = RXE_BTH_BYTES + RXE_ATMACK_BYTES + RXE_AETH_BYTES +
 			  RXE_RDETH_BYTES,
 		.offset = {
@@ -866,8 +849,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RD_COMPARE_SWAP]			= {
 		.name	= "RD_COMPARE_SWAP",
 		.mask	= RXE_RDETH_MASK | RXE_DETH_MASK | RXE_ATMETH_MASK |
-			  RXE_REQ_MASK | RXE_ATOMIC_MASK |
-			  RXE_START_MASK | RXE_END_MASK,
+			  RXE_REQ_MASK | RXE_ATOMIC_MASK | RXE_ONLY_MASK,
 		.length = RXE_BTH_BYTES + RXE_ATMETH_BYTES + RXE_DETH_BYTES +
 			  RXE_RDETH_BYTES,
 		.offset = {
@@ -887,8 +869,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 	[IB_OPCODE_RD_FETCH_ADD]			= {
 		.name	= "IB_OPCODE_RD_FETCH_ADD",
 		.mask	= RXE_RDETH_MASK | RXE_DETH_MASK | RXE_ATMETH_MASK |
-			  RXE_REQ_MASK | RXE_ATOMIC_MASK |
-			  RXE_START_MASK | RXE_END_MASK,
+			  RXE_REQ_MASK | RXE_ATOMIC_MASK | RXE_ONLY_MASK,
 		.length = RXE_BTH_BYTES + RXE_ATMETH_BYTES + RXE_DETH_BYTES +
 			  RXE_RDETH_BYTES,
 		.offset = {
@@ -911,7 +892,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 		.name	= "IB_OPCODE_UD_SEND_ONLY",
 		.mask	= RXE_DETH_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK |
 			  RXE_COMP_MASK | RXE_RWR_MASK | RXE_SEND_MASK |
-			  RXE_START_MASK | RXE_END_MASK,
+			  RXE_ONLY_MASK,
 		.length = RXE_BTH_BYTES + RXE_DETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
@@ -924,7 +905,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 		.name	= "IB_OPCODE_UD_SEND_ONLY_WITH_IMMEDIATE",
 		.mask	= RXE_DETH_MASK | RXE_IMMDT_MASK | RXE_PAYLOAD_MASK |
 			  RXE_REQ_MASK | RXE_COMP_MASK | RXE_RWR_MASK |
-			  RXE_SEND_MASK | RXE_START_MASK | RXE_END_MASK,
+			  RXE_SEND_MASK | RXE_ONLY_MASK,
 		.length = RXE_BTH_BYTES + RXE_IMMDT_BYTES + RXE_DETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.h b/drivers/infiniband/sw/rxe/rxe_opcode.h
index 8f9aaaf260f2..d2b6a8232e92 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.h
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.h
@@ -75,9 +75,10 @@ enum rxe_hdr_mask {
 	RXE_RWR_MASK		= BIT(NUM_HDR_TYPES + 6),
 	RXE_COMP_MASK		= BIT(NUM_HDR_TYPES + 7),
 
-	RXE_START_MASK		= BIT(NUM_HDR_TYPES + 8),
+	RXE_FIRST_MASK		= BIT(NUM_HDR_TYPES + 8),
 	RXE_MIDDLE_MASK		= BIT(NUM_HDR_TYPES + 9),
-	RXE_END_MASK		= BIT(NUM_HDR_TYPES + 10),
+	RXE_LAST_MASK		= BIT(NUM_HDR_TYPES + 10),
+	RXE_ONLY_MASK		= RXE_FIRST_MASK | RXE_LAST_MASK,
 
 	RXE_LOOPBACK_MASK	= BIT(NUM_HDR_TYPES + 12),
 
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index f63771207970..e136abc802af 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -403,7 +403,7 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 
 	/* init bth */
 	solicited = (ibwr->send_flags & IB_SEND_SOLICITED) &&
-			(pkt->mask & RXE_END_MASK) &&
+			(pkt->mask & RXE_LAST_MASK) &&
 			((pkt->mask & (RXE_SEND_MASK)) ||
 			(pkt->mask & (RXE_WRITE_MASK | RXE_IMMDT_MASK)) ==
 			(RXE_WRITE_MASK | RXE_IMMDT_MASK));
@@ -411,7 +411,7 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 	qp_num = (pkt->mask & RXE_DETH_MASK) ? ibwr->wr.ud.remote_qpn :
 					 qp->attr.dest_qp_num;
 
-	ack_req = ((pkt->mask & RXE_END_MASK) ||
+	ack_req = ((pkt->mask & RXE_LAST_MASK) ||
 		(qp->req.noack_pkts++ > RXE_MAX_PKT_PER_ACK));
 	if (ack_req)
 		qp->req.noack_pkts = 0;
@@ -493,7 +493,7 @@ static void update_wqe_state(struct rxe_qp *qp,
 		struct rxe_send_wqe *wqe,
 		struct rxe_pkt_info *pkt)
 {
-	if (pkt->mask & RXE_END_MASK) {
+	if (pkt->mask & RXE_LAST_MASK) {
 		if (qp_type(qp) == IB_QPT_RC)
 			wqe->state = wqe_state_pending;
 	} else {
@@ -513,7 +513,7 @@ static void update_wqe_psn(struct rxe_qp *qp,
 	if (num_pkt == 0)
 		num_pkt = 1;
 
-	if (pkt->mask & RXE_START_MASK) {
+	if (pkt->mask & RXE_FIRST_MASK) {
 		wqe->first_psn = qp->req.psn;
 		wqe->last_psn = (qp->req.psn + num_pkt - 1) & BTH_PSN_MASK;
 	}
@@ -550,7 +550,7 @@ static void update_state(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 {
 	qp->req.opcode = pkt->opcode;
 
-	if (pkt->mask & RXE_END_MASK)
+	if (pkt->mask & RXE_LAST_MASK)
 		qp->req.wqe_index = queue_next_index(qp->sq.queue,
 						     qp->req.wqe_index);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 7c336db5cb54..cb560cbe418d 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -147,7 +147,7 @@ static enum resp_states check_psn(struct rxe_qp *qp,
 
 	case IB_QPT_UC:
 		if (qp->resp.drop_msg || diff != 0) {
-			if (pkt->mask & RXE_START_MASK) {
+			if (pkt->mask & RXE_FIRST_MASK) {
 				qp->resp.drop_msg = 0;
 				return RESPST_CHK_OP_SEQ;
 			}
@@ -901,7 +901,7 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 			return RESPST_ERR_INVALIDATE_RKEY;
 	}
 
-	if (pkt->mask & RXE_END_MASK)
+	if (pkt->mask & RXE_LAST_MASK)
 		/* We successfully processed this new request. */
 		qp->resp.msn++;
 
-- 
2.34.1

