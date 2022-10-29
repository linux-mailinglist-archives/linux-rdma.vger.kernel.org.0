Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE1F611FA8
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Oct 2022 05:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiJ2DK7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 23:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiJ2DKq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 23:10:46 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655612AC65
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:10:27 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id d26-20020a05683018fa00b0066ab705617aso3999426otf.13
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgZtbe5QbJIdt0GKspEyQP1OPD6Un66ARePr7nadvDw=;
        b=QpXWXucHfuEvPLpd2lq2j0mQmgQUf4EM/5n/C/e5uMXOE3LmLjtES5Mq3gvg3gS6NN
         GTAWrFsO4DMFhXPD4S8B3SBiAg5DVNPOTYa0pnNH4o6nMnKsaKQ+ZvWYUZvOXNDHRJkI
         I7VmFOO08ltpB5MQXB1My4Ja4XcirjYm+NXcJsWUn/Twjr/6TupZzSvYBpOGjo65SRj0
         Kj1eWBHFItEM8jKTwxCRpEWJmdEh/QHYGoEMTRAjNR3dluXt23zfm/pvCF0L0w9YCdYn
         QvN4SJQXbFd2XNgvL3GdcbW215qmQUUfYgazLUC1lAfkey7/dKv5IjhxgIcyNXqT6n3E
         jfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgZtbe5QbJIdt0GKspEyQP1OPD6Un66ARePr7nadvDw=;
        b=gihvQ9+Q4FpoA6fpgOGqdhj3Uh/mZfB7hA7UyFDTlndfbA/oS4wZcedlqAxVyRlJHI
         y966gJBxJpVslYkyfXDoyc56jaRBafSl8LNz36dEyHNL5NYgAFgZSLZr94+MHinFRHDq
         dOSuHDUHHI7ryyRusmfhNP1x3nep8M8DUty2saJ7UQk/mjMph1DemyycNc0cS3RwlmWw
         JLimGdpJNXiIq1LA7IT8h0+37mHF8kX1d8jtzxWm8nhwN4CX2GOePVU/MFwz+5/3TR9c
         F6tHzsRLA51G7b5LUsG4wdLsLDkWR08NIHuB2EJ5kmZEoAPM3uHx2XR6XouScXnLX9UB
         zBfw==
X-Gm-Message-State: ACrzQf3NBbQC7izU04Tm4cYPisajEH8FxhxjrmzhPxcGumbuHYNLbNEk
        gQdDfh8Q6SWcBSqFVlGCuMk=
X-Google-Smtp-Source: AMsMyM7XMxd+nMxzP9eN2eN9cxRpuV+mKgnSQjZrD5hsh4Zhh6FMPFXKbZjsp30k7mUSnxb6yYmbtQ==
X-Received: by 2002:a05:6830:204f:b0:663:d1ef:9c0a with SMTP id f15-20020a056830204f00b00663d1ef9c0amr1245458otp.10.1667013027135;
        Fri, 28 Oct 2022 20:10:27 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-5d1e-45f3-e9b5-d771.res6.spectrum.com. [2603:8081:140c:1a00:5d1e:45f3:e9b5:d771])
        by smtp.googlemail.com with ESMTPSA id p3-20020a0568301d4300b006391adb6034sm162493oth.72.2022.10.28.20.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 20:10:26 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Ian Ziemba <ian.ziemba@hpe.com>
Subject: [PATCH for-next v3 09/13] RDMA/rxe: Replace TASK_STATE_START by TASK_STATE_IDLE
Date:   Fri, 28 Oct 2022 22:10:06 -0500
Message-Id: <20221029031009.64467-10-rpearsonhpe@gmail.com>
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

