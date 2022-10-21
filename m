Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6F4607F77
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 22:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiJUUDA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 16:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiJUUCZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 16:02:25 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A31D29CBBD
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:21 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so2454426otu.7
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgZtbe5QbJIdt0GKspEyQP1OPD6Un66ARePr7nadvDw=;
        b=Q0PNn0kI4ZVFivFv+eVhleAKa1HRWzZuX3dhIWS4xAYylmsDaJfMUidi4B/SwHucus
         Y7EjvVX+GDDS7EEWhkMmygxWj4bP6u03wurzbWS+OKXJ9t3pogAjZL6VX6OrprWWVTj2
         QoKKvgisj448IvmxGpmftK5nNHwqQWAbPmSYfsv+Zl/s4N8n3pGmFlfqslYJ+S8sGlUs
         Uc/nrEO2DlwGcmnPKp/i7WwRRyK1uCn3Yi5XQfUU+z7wl2UymbLH46Snb2IaHtglcA2F
         nQ9v55A4hBRCYRV8sA+Y88oGunpc0x5TEIqVnwYxDpjXzaXmHQbegQ5JqhAzc4retQ3J
         bTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgZtbe5QbJIdt0GKspEyQP1OPD6Un66ARePr7nadvDw=;
        b=dK5kvyIJlfmv833zZinFOfXyDroFC4FjcURfkg0P12JC19zq1fsHU35G5FREoeJIPs
         hPl/C2snkwBo4yqoU3IMh72ZHYGkb514w1x69q7+4SDslftfFSvAcSVSHcEVycsG/3Et
         rAplN5JHfMxZbzLrspGbK2WLVbAIB05Enn3Hr/nGZcCVsdGb/2rq5slKXR9a+lzd8kcR
         ycuOQoxkFPtSwkAv6z/JV7Qabi75PeRtgNqgWhPTE9XcJ8MZTNrUWdhV72kHWcyqp4c6
         7U71wZ6Xpfcl43p5IM75u+Bn0P8yR2zxs5PbDiACaI9isGLmLq+13YsWJF/nAIt534YL
         BNeA==
X-Gm-Message-State: ACrzQf3uF6y86I6r6aN49KgadP9dSlqWfyIzSZsK0j17DSQ1iaASbcze
        oNxBUITugFYSFp6nArXfmhk=
X-Google-Smtp-Source: AMsMyM4Cu1Tn6V0znBbM+s0LAcIBGHYqwm5opbrRAZC/TrGK36Y0y03hRSJzGwwymLjD2qJBTDeB/A==
X-Received: by 2002:a05:6830:148a:b0:661:94cb:32b1 with SMTP id s10-20020a056830148a00b0066194cb32b1mr10909647otq.174.1666382539947;
        Fri, 21 Oct 2022 13:02:19 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-a860-f1d2-9e17-7593.res6.spectrum.com. [2603:8081:140c:1a00:a860:f1d2:9e17:7593])
        by smtp.googlemail.com with ESMTPSA id s23-20020a056870631700b00132f141ef2dsm10674684oao.56.2022.10.21.13.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 13:02:19 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leon@kernel.org,
        jhack@hpe.com, ian.ziemba@hpe.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, haris.phnx@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 15/18] RDMA/rxe: Replace TASK_STATE_START by TASK_STATE_IDLE
Date:   Fri, 21 Oct 2022 15:01:16 -0500
Message-Id: <20221021200118.2163-16-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021200118.2163-1-rpearsonhpe@gmail.com>
References: <20221021200118.2163-1-rpearsonhpe@gmail.com>
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

Replace the enum TASK_STATE_START by TASK_STATE_IDLE.

Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_task.c | 14 +++++++-------
 drivers/infiniband/sw/rxe/rxe_task.h |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index d824de82f2ae..0fd0d97e8272 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -13,7 +13,7 @@ static bool task_is_idle(struct rxe_task *task)
 
 	spin_lock_bh(&task->lock);
 	switch (task->state) {
-	case TASK_STATE_START:
+	case TASK_STATE_IDLE:
 		task->state = TASK_STATE_BUSY;
 		spin_unlock_bh(&task->lock);
 		return true;
@@ -53,15 +53,15 @@ static void do_task(struct rxe_task *task)
 
 		spin_lock_bh(&task->lock);
 		switch (task->state) {
-		case TASK_STATE_START:
+		case TASK_STATE_IDLE:
 		case TASK_STATE_BUSY:
 			if (ret) {
-				task->state = TASK_STATE_START;
+				task->state = TASK_STATE_IDLE;
 			} else if (task->type == RXE_TASK_TYPE_INLINE ||
 					iterations--) {
 				cont = 1;
 			} else {
-				task->state = TASK_STATE_START;
+				task->state = TASK_STATE_IDLE;
 				resched = true;
 			}
 			break;
@@ -94,7 +94,7 @@ static void disable_task(struct rxe_task *task)
 static void enable_task(struct rxe_task *task)
 {
 	spin_lock_bh(&task->lock);
-	task->state = TASK_STATE_START;
+	task->state = TASK_STATE_IDLE;
 	spin_unlock_bh(&task->lock);
 
 	/* restart task in case */
@@ -110,7 +110,7 @@ static void cleanup_task(struct rxe_task *task)
 
 	do {
 		spin_lock_bh(&task->lock);
-		idle = (task->state == TASK_STATE_START ||
+		idle = (task->state == TASK_STATE_IDLE ||
 			task->state == TASK_STATE_PAUSED);
 		spin_unlock_bh(&task->lock);
 	} while (!idle);
@@ -219,7 +219,7 @@ int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *),
 	task->func	= func;
 	task->destroyed	= false;
 	task->type	= type;
-	task->state	= TASK_STATE_START;
+	task->state	= TASK_STATE_IDLE;
 
 	spin_lock_init(&task->lock);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index 792832786456..0146307fc517 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -23,7 +23,7 @@ enum rxe_task_type {
 };
 
 enum {
-	TASK_STATE_START	= 0,
+	TASK_STATE_IDLE		= 0,
 	TASK_STATE_BUSY		= 1,
 	TASK_STATE_ARMED	= 2,
 	TASK_STATE_PAUSED	= 3,
-- 
2.34.1

