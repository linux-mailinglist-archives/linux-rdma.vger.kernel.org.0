Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33255607F6E
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 22:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiJUUCv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 16:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiJUUCW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 16:02:22 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E9F26207F
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:08 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1364357a691so4894230fac.7
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWKHDmzwNMn+q2ooSjlIQRw6Jqrwp6NxfB1YrN3XR2o=;
        b=Bj2fkOdp4w2S0KWGbLDd6U3o8bNcCLSNt74349XcBihVS7F6mT3hDZgMUljs/k0imp
         yQTQj62frWES3QHSyS+tbIvxYjUFK+/GeLheIKapWnklOAbpOFgglx2wK/t9oZl1RBi+
         /ekPQ3bONWAGED61YcNX1zrVj2Z+EKUtAx8NTLOuRGLe66pbRbBc/JYeMSXNdEOyomvn
         ZpRa4ogqzge9doJp912Dk2W47C0HsxkDm4ijv6jJD0iholr9nVDwSOQRNrM07blv0pys
         048J8eYtPYLMfAas5T1A6BsDh06X7o4Ots6/s0UGfYhSZZHnsiVSiYJsxDoSFzMz/I98
         JFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWKHDmzwNMn+q2ooSjlIQRw6Jqrwp6NxfB1YrN3XR2o=;
        b=kU88FqdrPtFwB6iVjpPY83JWoH6HsMYidO/FIk9LCQbIS1H1wPBnvo415dJFONd8Zt
         x2MPq/XhoTRbAfbpC6Kl85tNquJZSezdii9MEIDo0vZcuJqKeozDyeA04PSMGRhwt+B7
         5WOVSDXF2Gr3aZfmyRZi5N/WhJBy9yJMk7cJtrKCfHv72rWTNgZCwPnBwv9yFnweilU3
         T+cK+V8GNnE1nmlFOwx6SN3DOoWnpBAQ46sZEGbUIBw0qA7jiSXGCQ7wclK4ME5u+VMN
         yerE/OAmAKRi57DVy7A8ONvopTscjR3lENqqNr1paMn2rlq7WAc7JtBF8onIjMFGTVBs
         PVkw==
X-Gm-Message-State: ACrzQf38nmTDZG9iWP6rWU5JXg5l2uqZM6FmJzkHMjU+XhCEwcDwOhu0
        0m4E2Klzi5zjZWZUd6YFVz6ymAD3QzM=
X-Google-Smtp-Source: AMsMyM4sC7Gh3EthPSJP8SivhPQGbMtQVfPtlzQmg9i5KfMVrgmSnzdGzckWdD+hVzwtzBkCRO2Y3w==
X-Received: by 2002:a05:6870:1611:b0:132:d73d:8f7f with SMTP id b17-20020a056870161100b00132d73d8f7fmr29951067oae.250.1666382528220;
        Fri, 21 Oct 2022 13:02:08 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-a860-f1d2-9e17-7593.res6.spectrum.com. [2603:8081:140c:1a00:a860:f1d2:9e17:7593])
        by smtp.googlemail.com with ESMTPSA id s23-20020a056870631700b00132f141ef2dsm10674684oao.56.2022.10.21.13.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 13:02:07 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leon@kernel.org,
        jhack@hpe.com, ian.ziemba@hpe.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, haris.phnx@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 06/18] RDMA/rxe: Rename task->state_lock to task->lock
Date:   Fri, 21 Oct 2022 15:01:07 -0500
Message-Id: <20221021200118.2163-7-rpearsonhpe@gmail.com>
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

Rename task-state_lock to task->lock

Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_task.c | 18 +++++++++---------
 drivers/infiniband/sw/rxe/rxe_task.h |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index fb953f5195b8..0208d833a41b 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -31,22 +31,22 @@ static void do_task(struct tasklet_struct *t)
 	struct rxe_task *task = from_tasklet(task, t, tasklet);
 	unsigned int iterations = RXE_MAX_ITERATIONS;
 
-	spin_lock_bh(&task->state_lock);
+	spin_lock_bh(&task->lock);
 	switch (task->state) {
 	case TASK_STATE_START:
 		task->state = TASK_STATE_BUSY;
-		spin_unlock_bh(&task->state_lock);
+		spin_unlock_bh(&task->lock);
 		break;
 
 	case TASK_STATE_BUSY:
 		task->state = TASK_STATE_ARMED;
 		fallthrough;
 	case TASK_STATE_ARMED:
-		spin_unlock_bh(&task->state_lock);
+		spin_unlock_bh(&task->lock);
 		return;
 
 	default:
-		spin_unlock_bh(&task->state_lock);
+		spin_unlock_bh(&task->lock);
 		pr_warn("%s failed with bad state %d\n", __func__, task->state);
 		return;
 	}
@@ -55,7 +55,7 @@ static void do_task(struct tasklet_struct *t)
 		cont = 0;
 		ret = task->func(task->arg);
 
-		spin_lock_bh(&task->state_lock);
+		spin_lock_bh(&task->lock);
 		switch (task->state) {
 		case TASK_STATE_BUSY:
 			if (ret) {
@@ -84,7 +84,7 @@ static void do_task(struct tasklet_struct *t)
 			pr_warn("%s failed with bad state %d\n", __func__,
 				task->state);
 		}
-		spin_unlock_bh(&task->state_lock);
+		spin_unlock_bh(&task->lock);
 	} while (cont);
 
 	task->ret = ret;
@@ -99,7 +99,7 @@ int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *))
 	tasklet_setup(&task->tasklet, do_task);
 
 	task->state = TASK_STATE_START;
-	spin_lock_init(&task->state_lock);
+	spin_lock_init(&task->lock);
 
 	return 0;
 }
@@ -115,9 +115,9 @@ void rxe_cleanup_task(struct rxe_task *task)
 	task->destroyed = true;
 
 	do {
-		spin_lock_bh(&task->state_lock);
+		spin_lock_bh(&task->lock);
 		idle = (task->state == TASK_STATE_START);
-		spin_unlock_bh(&task->state_lock);
+		spin_unlock_bh(&task->lock);
 	} while (!idle);
 
 	tasklet_kill(&task->tasklet);
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index 99e0173e5c46..7b88129702ac 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -21,7 +21,7 @@ enum {
 struct rxe_task {
 	struct tasklet_struct	tasklet;
 	int			state;
-	spinlock_t		state_lock; /* spinlock for task state */
+	spinlock_t		lock;
 	void			*arg;
 	int			(*func)(void *arg);
 	int			ret;
-- 
2.34.1

