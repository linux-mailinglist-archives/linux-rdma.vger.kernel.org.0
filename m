Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B5A607F6D
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 22:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiJUUCu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 16:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiJUUCS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 16:02:18 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D332623DA
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:07 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id g130so4382116oia.13
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFM9klmBW4ISA+589VLKd91C/jSg7NSbf9UoDxhQrS4=;
        b=KfyVo5KZTRiLP5gj/wAR0mzYfmYplM3DAS8l5DFGmqGxXC8RuE5UXKvY7xpHhNnJwY
         QyWS9jTUcJPXUxv/J/6sql82v9qeJsm0lZTyBbVcvTA/zM/HUnk0tclHlr0vG6vHJnXJ
         4yxqzH73IgETmLjBJCS8M2G1CHriv73Imee9bW8QKcszgFVUZ7f46w4ATs9RCUXTjy3R
         ET8KCbmyV29B6zDjHBEXVcmkr2SAjyVUE97PDWM4EKBU7ensBfHEs1sDlXtg6lCJAry0
         ghh2QeW+P3QXoy+1CBgmpgrIR/b09ieHKv+9z50OTQO5AaVYqcVmAL6WkNFW7DXdaixe
         EyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFM9klmBW4ISA+589VLKd91C/jSg7NSbf9UoDxhQrS4=;
        b=iqL8fIvIet8aDnzTT6tgw2gFTY3KRL2B7S+KtViCbzOwi8SqaLe2nFLjkTGgqB0XsY
         WTsvOJYrNdh0NurT4iqwT6/+H9AMPABbcZ51OLoxdXHFyrFkETH9lFfc1Zjv2PJadD/t
         uFweg4zXULifLERaN9BIB5m8Ykinfgppt/5vpzP3VWALI0ooc4THFQUbTZKsaMbx5WrY
         BpMArUGM9LSCSX7Q3UFedacXpkstJWE+mfGsY5EVbHk+l29TNKGmhnbC7PqqF7p/g8Ma
         SYkl2DNvHxGNV1Ej8nWOo8hznlW1nIOHSdFARuqxs1kQLuPa9CrMKROHaRZM15FDB2jq
         q5Fw==
X-Gm-Message-State: ACrzQf24EYqzqR5l6/S4QwHm/7JlUosgD2LL7jXa0sCEtYz3lwDOxZcG
        j8LWQg4v+gzWBEPAMN6xOAs=
X-Google-Smtp-Source: AMsMyM7iHzwj3/GIDFYtJ5j58Q5WoTKcUw4nw72rVezMJP2KrC83GGlAkDCaINN8NIf7iqlTcXVDfA==
X-Received: by 2002:a05:6808:1209:b0:353:92d1:2a0 with SMTP id a9-20020a056808120900b0035392d102a0mr11011315oil.51.1666382526970;
        Fri, 21 Oct 2022 13:02:06 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-a860-f1d2-9e17-7593.res6.spectrum.com. [2603:8081:140c:1a00:a860:f1d2:9e17:7593])
        by smtp.googlemail.com with ESMTPSA id s23-20020a056870631700b00132f141ef2dsm10674684oao.56.2022.10.21.13.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 13:02:06 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leon@kernel.org,
        jhack@hpe.com, ian.ziemba@hpe.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, haris.phnx@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 05/18] RDMA/rxe: Make rxe_do_task static
Date:   Fri, 21 Oct 2022 15:01:06 -0500
Message-Id: <20221021200118.2163-6-rpearsonhpe@gmail.com>
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

The subroutine rxe_do_task() is only called in rxe_task.c. This patch
makes it static and renames it do_task().

Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_task.c | 6 +++---
 drivers/infiniband/sw/rxe/rxe_task.h | 8 --------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 442b7348acdc..fb953f5195b8 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -24,7 +24,7 @@ int __rxe_do_task(struct rxe_task *task)
  * a second caller finds the task already running
  * but looks just after the last call to func
  */
-void rxe_do_task(struct tasklet_struct *t)
+static void do_task(struct tasklet_struct *t)
 {
 	int cont;
 	int ret;
@@ -96,7 +96,7 @@ int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *))
 	task->func	= func;
 	task->destroyed	= false;
 
-	tasklet_setup(&task->tasklet, rxe_do_task);
+	tasklet_setup(&task->tasklet, do_task);
 
 	task->state = TASK_STATE_START;
 	spin_lock_init(&task->state_lock);
@@ -128,7 +128,7 @@ void rxe_run_task(struct rxe_task *task)
 	if (task->destroyed)
 		return;
 
-	rxe_do_task(&task->tasklet);
+	do_task(&task->tasklet);
 }
 
 void rxe_sched_task(struct rxe_task *task)
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index 590b1c1d7e7c..99e0173e5c46 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -44,14 +44,6 @@ void rxe_cleanup_task(struct rxe_task *task);
  */
 int __rxe_do_task(struct rxe_task *task);
 
-/*
- * common function called by any of the main tasklets
- * If there is any chance that there is additional
- * work to do someone must reschedule the task before
- * leaving
- */
-void rxe_do_task(struct tasklet_struct *t);
-
 void rxe_run_task(struct rxe_task *task);
 
 void rxe_sched_task(struct rxe_task *task);
-- 
2.34.1

