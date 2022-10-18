Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDE3602355
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 06:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiJREgb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 00:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiJREg1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 00:36:27 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF531A0244
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:22 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id g15-20020a4a894f000000b0047f8e899623so2927698ooi.5
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24SPsUkbVLd5ye8D67mHnRGjR1k+hcsP3X79sb7BR3w=;
        b=AMwE9dRaytTK20YWqrkFwDv4gSlPQpm7fW98AqGzGfATyg0p/jus8mX0/DKAWymhQs
         E97ULfgs0i72LK3+t50su/ubVO8hnj5u4HHzAcqhFeoQZGTFcgT05qI7rZA7J69v9HJs
         sfecUnayPt/x8aDuDl5pVZZwJm3UAe197L3XQPxNfPE0PxLGZ6sJHGE+eWirYJnTL/oR
         xsgJKCalQKQSyStFh6t8NPMmhro0821R64ZQOQQvCZ4GvCqSL+1Sy1JzYYkrqgKepYYy
         muQjRjJ/U85uR0QMSaFAWQ723jmwmPgDDSWQTQZzE2GdnPeDut3QdDCnd/kFRkeIsqOB
         NxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24SPsUkbVLd5ye8D67mHnRGjR1k+hcsP3X79sb7BR3w=;
        b=gEAjNCzHkwaxLIxTwHNnkBSNvktHkUGCOQEbZLxzCjj7gJFFBVxFV8MVwW9SRiXIEP
         PxsOtYh75Oj5css07kvWfL8ytSPI7fZ0t9A5Wow2H70NRynCVXD3rLIA6CT4r1V/bs9D
         fbTlJhg1P9HR5WCK3JQi4BFz8oeGwgV8ZplkWZA5ygoigltxo5R8rISllJZ7u2l3Ua+G
         fIWHDRn3eDapjK2agrJgdRQuKDFGeVHSTHYZUOIR5CyWo8kHjlh+3lzk3+hT2jIQfewb
         iFgRK/QLUrqm2GBuoa640TCHjBPZm5nYW6by8A5GsF/Cu6z+6N+DtMVPNehj/oUW0M/x
         V+xw==
X-Gm-Message-State: ACrzQf1AVa9546mFjPhqVa6ApjxrDjeaIsli7i+DY26ruYvLGraKT6+t
        /91x4YoukpkHg843z83n8iU=
X-Google-Smtp-Source: AMsMyM4eswEJxUXP7y86BbDDUbAbGQWPf6KYOI9drcySKpS4y1UiIthoi+XeCC5jnIBcefP1tDUJeA==
X-Received: by 2002:a4a:4847:0:b0:443:347d:6617 with SMTP id p68-20020a4a4847000000b00443347d6617mr535267ooa.94.1666067781936;
        Mon, 17 Oct 2022 21:36:21 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-290b-8972-ce76-602c.res6.spectrum.com. [2603:8081:140c:1a00:290b:8972:ce76:602c])
        by smtp.googlemail.com with ESMTPSA id e96-20020a9d01e9000000b006618ca5caa0sm5480333ote.78.2022.10.17.21.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 21:36:21 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        jenny.hack@hpe.com, ian.ziemba@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 07/16] RDMA/rxe: Simplify reset state handling in rxe_resp.c
Date:   Mon, 17 Oct 2022 23:33:38 -0500
Message-Id: <20221018043345.4033-8-rpearsonhpe@gmail.com>
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

Make rxe_responder() more like rxe_completer() and take qp reset
handling out of the state machine.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 2a2a50de51b2..dd11dea70bbf 100644
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
@@ -1278,8 +1276,9 @@ int rxe_responder(void *arg)
 
 	switch (qp->resp.state) {
 	case QP_STATE_RESET:
-		state = RESPST_RESET;
-		break;
+		rxe_drain_req_pkts(qp, false);
+		qp->resp.wqe = NULL;
+		goto exit;
 
 	default:
 		state = RESPST_GET_REQ;
@@ -1438,11 +1437,6 @@ int rxe_responder(void *arg)
 
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

