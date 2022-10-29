Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9555E611FA5
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Oct 2022 05:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJ2DKy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 23:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiJ2DKp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 23:10:45 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2722AC53
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:10:21 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id v40-20020a056830092800b00661e37421c2so4023095ott.3
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiDP5+mzppeVixN1QhIBC8v4aiDRCLnh9K76vVm1dow=;
        b=JI4xsDSyclYeqRZW3zbZuOo8fg6JmdwSz9WbA+0xw5aEIuYYLiUELws0Rug7n3A9gU
         8Nmb5jFyQ15qkqVSwqbG3jemKQmKn8vszRXv4bchR9V2Lo7Rrjr+jXxb0uWlA7QuIB7P
         tKf131m/DPzJOz09FBxlWbLaJoxaEc5WXViGg8SECOh+uL5046phXaidUL+Nvg2b7L8I
         u0MLJqErd9xRtGBK7Z3XfcRzgBqOEu6vITcwA0D2l/fg6yTlJHACu83nbWDCLq1Wer9Z
         5nupRM9eJMtzeRn75PZqHMYq/K/05H5XAzqcF4444JTtgLFDCXvMyrJFzJv8DHIBU1c+
         iypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiDP5+mzppeVixN1QhIBC8v4aiDRCLnh9K76vVm1dow=;
        b=iPxoWSORmeKHQ0uz39eCEDGIVoI0B0dqMJKAr50OFWwaj4btTVRPksdPY1zLmfjN8R
         QpJDFY9SuN5Lko0CzKAAlwrEdogwzO8AgIc8dRElxjLlkgcR0UvaEe/F+uFMgkcwVMt1
         Z1MPlPFhZqRSlbspYkx4/tY7k/Gr/lgMAJ1k/WygPoCxqF+j3ZdPdJgg75sTAcmospUH
         wKIzXiFya2EA2GQX0rDAjuxV0h2BbK9cvbZY3iZB1XS7F7ZmPFmMHiY5CcnpZ4ICdQq3
         qmwiU9bJTJkMOBQkO2yOmZscZ3IywGOChkgnKjIxlXjIabwKpQGDECf5tyaSuuMpsW0o
         KIRw==
X-Gm-Message-State: ACrzQf2yw82LQqSDs7Iekz6/mb6YLtqLIxRn7I83htrpRx+kColFAT7P
        5OouRrnzGvonv0bQr8nBWD4=
X-Google-Smtp-Source: AMsMyM6x4piTdc19Q1c5E1T6XuYekKpuzQGhBPU2v6bBcZX+nX3VVCYEvwNY3dWA9FnGnj11WvJ0kA==
X-Received: by 2002:a05:6830:3703:b0:65f:c2ff:c526 with SMTP id bl3-20020a056830370300b0065fc2ffc526mr1193128otb.302.1667013021015;
        Fri, 28 Oct 2022 20:10:21 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-5d1e-45f3-e9b5-d771.res6.spectrum.com. [2603:8081:140c:1a00:5d1e:45f3:e9b5:d771])
        by smtp.googlemail.com with ESMTPSA id p3-20020a0568301d4300b006391adb6034sm162493oth.72.2022.10.28.20.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 20:10:20 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Ian Ziemba <ian.ziemba@hpe.com>
Subject: [PATCH for-next v3 03/13] RDMA/rxe: Simplify reset state handling in rxe_resp.c
Date:   Fri, 28 Oct 2022 22:10:00 -0500
Message-Id: <20221029031009.64467-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221029031009.64467-1-rpearsonhpe@gmail.com>
References: <20221029031009.64467-1-rpearsonhpe@gmail.com>
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

Make rxe_responder() more like rxe_completer() and take qp reset
handling out of the state machine.

Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index c32bc12cc82f..c4f365449aa5 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -40,7 +40,6 @@ enum resp_states {
 	RESPST_ERR_LENGTH,
 	RESPST_ERR_CQ_OVERFLOW,
 	RESPST_ERROR,
-	RESPST_RESET,
 	RESPST_DONE,
 	RESPST_EXIT,
 };
@@ -75,7 +74,6 @@ static char *resp_state_name[] = {
 	[RESPST_ERR_LENGTH]			= "ERR_LENGTH",
 	[RESPST_ERR_CQ_OVERFLOW]		= "ERR_CQ_OVERFLOW",
 	[RESPST_ERROR]				= "ERROR",
-	[RESPST_RESET]				= "RESET",
 	[RESPST_DONE]				= "DONE",
 	[RESPST_EXIT]				= "EXIT",
 };
@@ -1281,8 +1279,9 @@ int rxe_responder(void *arg)
 
 	switch (qp->resp.state) {
 	case QP_STATE_RESET:
-		state = RESPST_RESET;
-		break;
+		rxe_drain_req_pkts(qp, false);
+		qp->resp.wqe = NULL;
+		goto exit;
 
 	default:
 		state = RESPST_GET_REQ;
@@ -1441,11 +1440,6 @@ int rxe_responder(void *arg)
 
 			goto exit;
 
-		case RESPST_RESET:
-			rxe_drain_req_pkts(qp, false);
-			qp->resp.wqe = NULL;
-			goto exit;
-
 		case RESPST_ERROR:
 			qp->resp.goto_error = 0;
 			pr_debug("qp#%d moved to error state\n", qp_num(qp));
-- 
2.34.1

