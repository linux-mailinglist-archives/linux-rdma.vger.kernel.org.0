Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D623B611FA6
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Oct 2022 05:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiJ2DKz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 23:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiJ2DKp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 23:10:45 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506702A967
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:10:32 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id r15-20020a4abf0f000000b004761c7e6be1so1011500oop.9
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/7LZaHNgDRVDQQv8FaYutnEvbje8YPWsOt8sPGR6AM=;
        b=pAHL8t3HHmtfugM+KyxWPEPbIMHHpmIF2rCBs0mTTqHjGuYthib3yOTt0liupOk0oZ
         +v0aGUxyQBF2AQg33CjypmC+9R70G46fa52hAyp39N1ZDxhJua2+YlkCygOCZnpxlkBA
         T460lIZcpgB7Faxg729nAbFrli7oNybiRuGgeuiFAb4R6cLMJE8OwsJGifvxmgs/inns
         ZgwTotR8j6m9isVw57usYCKtA8GlMX1zJQcj9YJOLam/meQGEDBlD/9eZkh0icuInq9x
         tX+YmeaBq+WgpZxf7TDK2x4ypoGTemFWfCqvefE0sxg/b/8P3SvsU5DBO16by81pj3Fa
         oJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/7LZaHNgDRVDQQv8FaYutnEvbje8YPWsOt8sPGR6AM=;
        b=12sMd9mZDfb5+qZMIBmfenXwS9bIjRjCLYIDtUdUyFM2jJVe854e287fen4DiJJfrz
         28jFaY5jLZCjoz1pZSVUQqOpR4PzSY3r6vangPfb1qenNW9UQeYIpNRkIC0sSluZ0LI7
         /eyVbNaVTSImTUzW5g8ig1q62tBY/jPzqwdi8q3E6fHdvNy73Y8LLKApyrQO84Ul5bmI
         BDzvwTZc5rxRPrtoBssbnr6zAl3Q68AQ0yLLxw8WnrlG3H+OHJLMBmJZBtfMjLjW2l5x
         EYmhrAPanVbCOhYCUi8yMOfpXhRcpI4AbonKMQEC+k6ZZj9rgeV+fVgvTenlht7lkpoq
         19og==
X-Gm-Message-State: ACrzQf3Y9IJcXQMHr2A0E/8WkqVfEy0boBqUPNwAMpT3wg78z6i6x/Ep
        Tm8eW1itQhtxdqfysylvEhw=
X-Google-Smtp-Source: AMsMyM6cL8e8PL32hmf8h4oKW0wMc7Rrb+8Yv5f8I9nsNPncGAeMXW4PT+E80gGg2UTo4wPrQYpW7Q==
X-Received: by 2002:a4a:d4c1:0:b0:494:87d8:426a with SMTP id r1-20020a4ad4c1000000b0049487d8426amr1106239oos.70.1667013031433;
        Fri, 28 Oct 2022 20:10:31 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-5d1e-45f3-e9b5-d771.res6.spectrum.com. [2603:8081:140c:1a00:5d1e:45f3:e9b5:d771])
        by smtp.googlemail.com with ESMTPSA id p3-20020a0568301d4300b006391adb6034sm162493oth.72.2022.10.28.20.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 20:10:31 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 13/13] RDMA/rxe: Remove tasklets from rxe_task.c
Date:   Fri, 28 Oct 2022 22:10:10 -0500
Message-Id: <20221029031009.64467-14-rpearsonhpe@gmail.com>
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

Remove the option to select tasklets(). Maintain the option to have
a pluggable interface for future expansion.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_task.c | 51 ----------------------------
 drivers/infiniband/sw/rxe/rxe_task.h |  8 ++---
 2 files changed, 2 insertions(+), 57 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index c1177752088d..d9c4ab2e58c8 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -166,54 +166,6 @@ static void inline_init(struct rxe_task *task)
 	task->ops = &inline_ops;
 }
 
-/* use tsklet_xxx to avoid name collisions with tasklet_xxx */
-static void tsklet_sched(struct rxe_task *task)
-{
-	if (task_is_idle(task))
-		tasklet_schedule(&task->tasklet);
-}
-
-static void tsklet_do_task(struct tasklet_struct *tasklet)
-{
-	do_task(container_of(tasklet, struct rxe_task, tasklet));
-}
-
-static void tsklet_run(struct rxe_task *task)
-{
-	if (task_is_idle(task))
-		do_task(task);
-}
-
-static void tsklet_disable(struct rxe_task *task)
-{
-	disable_task(task);
-}
-
-static void tsklet_enable(struct rxe_task *task)
-{
-	enable_task(task);
-}
-
-static void tsklet_cleanup(struct rxe_task *task)
-{
-	cleanup_task(task);
-	tasklet_kill(&task->tasklet);
-}
-
-static const struct rxe_task_ops tsklet_ops = {
-	.sched = tsklet_sched,
-	.run = tsklet_run,
-	.enable = tsklet_enable,
-	.disable = tsklet_disable,
-	.cleanup = tsklet_cleanup,
-};
-
-static void tsklet_init(struct rxe_task *task)
-{
-	tasklet_setup(&task->tasklet, tsklet_do_task);
-	task->ops = &tsklet_ops;
-}
-
 static void work_sched(struct rxe_task *task)
 {
 	if (task_is_idle(task))
@@ -275,9 +227,6 @@ int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *),
 	case RXE_TASK_TYPE_INLINE:
 		inline_init(task);
 		break;
-	case RXE_TASK_TYPE_TASKLET:
-		tsklet_init(task);
-		break;
 	case RXE_TASK_TYPE_WORKQUEUE:
 		work_init(task);
 		break;
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index d1156b935635..fbc7e2bf4e5a 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -19,8 +19,7 @@ struct rxe_task_ops {
 
 enum rxe_task_type {
 	RXE_TASK_TYPE_INLINE	= 0,
-	RXE_TASK_TYPE_TASKLET	= 1,
-	RXE_TASK_TYPE_WORKQUEUE	= 2,
+	RXE_TASK_TYPE_WORKQUEUE	= 1,
 };
 
 enum {
@@ -37,10 +36,7 @@ enum {
  * called again.
  */
 struct rxe_task {
-	union {
-		struct tasklet_struct		tasklet;
-		struct work_struct		work;
-	};
+	struct work_struct		work;
 	int				state;
 	spinlock_t			lock;
 	void				*arg;
-- 
2.34.1

