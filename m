Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0018760235D
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 06:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiJREgn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 00:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiJREgc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 00:36:32 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A11EA0248
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:31 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id c17-20020a4aa4d1000000b0047653e7c5f3so2943162oom.1
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLdRG9YSPMV2q7W0Y/cMM2IC9csSbc4KwhgV7nSPUMw=;
        b=i+lLYZJdPF+8JZl0ehJ+puus/Ngr40vRQnSM6DBTTvUlydH5Y/zbwFJ2hF8pwOvbyW
         +O6dEnlHWQzF1vcrt6r0WAlZ5t6sYPS7cpc5EnCaWdkNsVhXLSMd9ZjmP1yAfRmedP7G
         asy18nbz2RbC1m8QPpl2L7EI/956QH1nSkhTIAGbW+tgY0SZk9TrCH5RHH2sMDr7MnI0
         poXGWL4a33S2x/sCTssEq9LRIS+jy68rQ464fJwtifWs5NK3b+B7lnMuqRdcWPPFlxvr
         wZYgGEJeM/yrMwhtCJiS98dKi6fduYJOAUa5mgmTNWYq6X+B+0d7vC9DkWf17e/hmnu6
         KBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLdRG9YSPMV2q7W0Y/cMM2IC9csSbc4KwhgV7nSPUMw=;
        b=HqJaasRYO0UA6o6u/x6mghyBB0tjk1cbEWq76TK8oijpB79qqTUNeKLBfarfQ62thg
         /kksZ5BmjBS/ujq4SKTXDPY4OgEj52vpkWFHfFU1nMssksAzyisThlvn13OC+1/phyEo
         efX0A7m8VqNqnXzeZld/pGqlMOkMc5ecFz8XM5xqCppZiBZBUiyEfShAFdgPfMDRqYw1
         FjvwWpn7U+phM4GFEp38kKBSTG0u3+qwuVRzc55x1Mmrmy4zwwHyBa+LfZPFWyZMiIFc
         2S13Di9hQMBmKlirujADzKHxdLT/jYe2wxbVhhcLeMeWc/HOy6XfXOgYO/J49rXO2qQ+
         Ve2g==
X-Gm-Message-State: ACrzQf1N2vSrmUaiJk+isNYAjS+ROS9LMeCjCHRKEbywOUXwT1AaN0Vp
        XzNKZ637zxWbdFohi+jZzl4IvOnfWb9kMw==
X-Google-Smtp-Source: AMsMyM4BIIdRKpr2HEfRbpGmbU4PoLiDBekM7S3m3fDuNBIy1WjWHDCMZLhzX+JLKf2TGHNcPFUbXQ==
X-Received: by 2002:a4a:8d57:0:b0:476:99ae:46a5 with SMTP id x23-20020a4a8d57000000b0047699ae46a5mr538016ook.51.1666067790469;
        Mon, 17 Oct 2022 21:36:30 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-290b-8972-ce76-602c.res6.spectrum.com. [2603:8081:140c:1a00:290b:8972:ce76:602c])
        by smtp.googlemail.com with ESMTPSA id e96-20020a9d01e9000000b006618ca5caa0sm5480333ote.78.2022.10.17.21.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 21:36:29 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        jenny.hack@hpe.com, ian.ziemba@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 14/16] RDMA/rxe: Replace TASK_STATE_START by TASK_STATE_IDLE
Date:   Mon, 17 Oct 2022 23:33:45 -0500
Message-Id: <20221018043345.4033-15-rpearsonhpe@gmail.com>
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

Replace the enum TASK_STATE_START by TASK_STATE_IDLE.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_task.c | 37 ++++++++++++++--------------
 drivers/infiniband/sw/rxe/rxe_task.h |  4 +--
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index a9eb66d69cb7..a2c58ce66c8f 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -12,12 +12,12 @@
 
 static bool task_is_idle(struct rxe_task *task)
 {
-	if (task->destroyed)
+	if (!task->valid)
 		return false;
 
 	spin_lock_bh(&task->lock);
 	switch (task->state) {
-	case TASK_STATE_START:
+	case TASK_STATE_IDLE:
 		task->state = TASK_STATE_BUSY;
 		spin_unlock_bh(&task->lock);
 		return true;
@@ -57,15 +57,15 @@ static void do_task(struct rxe_task *task)
 
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
@@ -98,7 +98,7 @@ static void disable_task(struct rxe_task *task)
 static void enable_task(struct rxe_task *task)
 {
 	spin_lock_bh(&task->lock);
-	task->state = TASK_STATE_START;
+	task->state = TASK_STATE_IDLE;
 	spin_unlock_bh(&task->lock);
 
 	/* restart task in case */
@@ -110,11 +110,11 @@ static void cleanup_task(struct rxe_task *task)
 {
 	bool idle;
 
-	task->destroyed = true;
+	task->valid = false;
 
 	do {
 		spin_lock_bh(&task->lock);
-		idle = (task->state == TASK_STATE_START ||
+		idle = (task->state == TASK_STATE_IDLE ||
 			task->state == TASK_STATE_PAUSED);
 		spin_unlock_bh(&task->lock);
 	} while (!idle);
@@ -135,13 +135,13 @@ static void inline_run(struct rxe_task *task)
 
 static void inline_disable(struct rxe_task *task)
 {
-	if (!task->destroyed)
+	if (task->valid)
 		disable_task(task);
 }
 
 static void inline_enable(struct rxe_task *task)
 {
-	if (!task->destroyed)
+	if (task->valid)
 		enable_task(task);
 }
 
@@ -174,7 +174,7 @@ static void tsklet_do_task(struct tasklet_struct *tasklet)
 {
 	struct rxe_task *task = container_of(tasklet, typeof(*task), tasklet);
 
-	if (!task->destroyed)
+	if (task->valid)
 		do_task(task);
 }
 
@@ -186,13 +186,13 @@ static void tsklet_run(struct rxe_task *task)
 
 static void tsklet_disable(struct rxe_task *task)
 {
-	if (!task->destroyed)
+	if (task->valid)
 		disable_task(task);
 }
 
 static void tsklet_enable(struct rxe_task *task)
 {
-	if (!task->destroyed)
+	if (task->valid)
 		enable_task(task);
 }
 
@@ -219,11 +219,10 @@ static void tsklet_init(struct rxe_task *task)
 int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *),
 		  enum rxe_task_type type)
 {
-	task->arg	= arg;
-	task->func	= func;
-	task->destroyed	= false;
-	task->type	= type;
-	task->state	= TASK_STATE_START;
+	task->arg = arg;
+	task->func = func;
+	task->type = type;
+	task->state = TASK_STATE_IDLE;
 
 	spin_lock_init(&task->lock);
 
@@ -239,6 +238,8 @@ int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *),
 		return -EINVAL;
 	}
 
+	task->valid = true;
+
 	return 0;
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index 792832786456..c81947e88629 100644
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
@@ -41,7 +41,7 @@ struct rxe_task {
 	void				*arg;
 	int				(*func)(void *arg);
 	int				ret;
-	bool				destroyed;
+	bool				valid;
 	const struct rxe_task_ops	*ops;
 	enum rxe_task_type		type;
 };
-- 
2.34.1

