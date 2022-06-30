Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11722562292
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jun 2022 21:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbiF3TFS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jun 2022 15:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236817AbiF3TFR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jun 2022 15:05:17 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD9E37A29
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 12:05:16 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id r82so531248oig.2
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 12:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9D+sLMq8vkOoIkXhT2rT04WVWXiLtRahkQVBbSnUaUM=;
        b=ISyfCIYb8RhOkVb/p/raX/ebmNFv5EicWqI+6fZcxiW10SD3ZEpy76p5Q4pa2Dvq8j
         rEhxyw6GSwcJA2za4iXLufvlnPihpWBktrASp2JD5TKx18qjbuFJvDfGxUoYqfXitmCc
         hBlqRyf52MIkxiQ2YGqBF9znCyZv7UMIZ1o8/pXqMENd/wy6ke9XlRJXnDbBz6Kt5tSz
         OFjU1VYWMz3fIoHgoWHtKx9tI0ttzyhdYgaQk5RFKOHA06/mMvVX4cMnkVN5+k6tUNdE
         zmc5OIi6B/rHnoJPBMo28O0tC/zcz6nPBXOHSRizkBCCoKWuMrRMo9fByZnmA0aeweyY
         uPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9D+sLMq8vkOoIkXhT2rT04WVWXiLtRahkQVBbSnUaUM=;
        b=Bid5m1olG9TxFnsKtOisqkIULksKh9Ls/W2HKQfoI/qcrBJ/64vMtH+fMLi+Nl3Jj3
         Xsg42ni8xIAXqNPcOAYWHfeKsSeIrN3ejVpvJrR/R4qvd+dvoCYqCldyQOlkokm9iMTX
         lVGwziMltzKtUyUWLHH+sHV3iVT3agbdklq57/flsT7osoq59R6TtSObtvLfqf0xiUpJ
         a6dftF6cOsNWg0zJXuEuEi0f1jySU8dYqJmOaP8Intp2BcXzdyDh0cCn47c8/d4Tj5vK
         bIeKMGyIvUxQUfZYWbeI1MMx84fiCxXHQ0fzDJ/b9G4YDKWgwt8IHrUaKUpVCNzjaTMR
         KNlA==
X-Gm-Message-State: AJIora/45OeT3Gbz2MBTHos60yv1OREvMHPUwl4QS/L6TBgrwE9IEWkw
        eWL8dDKVSX4+fJBaSJLTB90=
X-Google-Smtp-Source: AGRyM1vbTKERmjY8jOCAXvzb2OUiVRru/QJvXS0OWgc0e3DuL6VR2toMFqOt/LfQIDoKIJ/WTYgPew==
X-Received: by 2002:a05:6808:2395:b0:335:93c2:5804 with SMTP id bp21-20020a056808239500b0033593c25804mr7829689oib.2.1656615916200;
        Thu, 30 Jun 2022 12:05:16 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id o4-20020a9d4104000000b0060bfb4e4033sm11756442ote.9.2022.06.30.12.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 12:05:15 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 8/9] RDMA/rxe: Limit the number of calls to each tasklet
Date:   Thu, 30 Jun 2022 14:04:25 -0500
Message-Id: <20220630190425.2251-9-rpearsonhpe@gmail.com>
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

Limit the maximum number of calls to each tasklet from rxe_do_task()
before yielding the cpu. When the limit is reached reschedule the
tasklet and exit the calling loop. This patch prevents one tasklet
from consuming 100% of a cpu core and causing a deadlock or soft lockup.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_param.h |  6 ++++++
 drivers/infiniband/sw/rxe/rxe_task.c  | 16 ++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 568a7cbd13d4..9f3b036e6bde 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -105,6 +105,12 @@ enum rxe_device_param {
 	RXE_INFLIGHT_SKBS_PER_QP_HIGH	= 64,
 	RXE_INFLIGHT_SKBS_PER_QP_LOW	= 16,
 
+	/* Max number of interations of each tasklet
+	 * before yielding the cpu to let other
+	 * work make progress
+	 */
+	RXE_MAX_ITERATIONS		= 1024,
+
 	/* Delay before calling arbiter timer */
 	RXE_NSEC_ARB_TIMER_DELAY	= 200,
 
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 0c4db5bb17d7..2248cf33d776 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -8,7 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/hardirq.h>
 
-#include "rxe_task.h"
+#include "rxe.h"
 
 int __rxe_do_task(struct rxe_task *task)
 
@@ -33,6 +33,7 @@ void rxe_do_task(struct tasklet_struct *t)
 	int cont;
 	int ret;
 	struct rxe_task *task = from_tasklet(task, t, tasklet);
+	unsigned int iterations = RXE_MAX_ITERATIONS;
 
 	spin_lock_bh(&task->state_lock);
 	switch (task->state) {
@@ -61,13 +62,20 @@ void rxe_do_task(struct tasklet_struct *t)
 		spin_lock_bh(&task->state_lock);
 		switch (task->state) {
 		case TASK_STATE_BUSY:
-			if (ret)
+			if (ret) {
 				task->state = TASK_STATE_START;
-			else
+			} else if (iterations--) {
 				cont = 1;
+			} else {
+				/* reschedule the tasklet and exit
+				 * the loop to give up the cpu
+				 */
+				tasklet_schedule(&task->tasklet);
+				task->state = TASK_STATE_START;
+			}
 			break;
 
-		/* soneone tried to run the task since the last time we called
+		/* someone tried to run the task since the last time we called
 		 * func, so we will call one more time regardless of the
 		 * return value
 		 */
-- 
2.34.1

