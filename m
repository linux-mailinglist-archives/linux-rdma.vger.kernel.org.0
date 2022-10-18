Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D43C602354
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 06:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiJREgb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 00:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiJREg0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 00:36:26 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E1AA025F
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:21 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-132b8f6f1b2so15555509fac.11
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ts7wj/6p6IhLkdtFxIR72LxXhWu5bCOcfIH/Wo6L9d8=;
        b=BJ2WGWpDbLi8Rm7OCO3jzs1c8yCgRIw8ZU1pBhWa+OH+rrzXd7qvzkq/S8k9IIWfPh
         XOnUcIXk+mLBcYrfTzBGYGlwU23WTx5S2JhRgKVgFv5pbzBegIvr349EyfqWXwTISxTR
         a0EV3/COCSyDH/oYyWwnTFks1cYAGAj+7RrdTcygPoJsIzLrfJr4qdw8yHlp7JwGu5VM
         U0AEBo7fqweddze6+a9+ymPASb7zaJ6JpTQgMNu2jBp/tyCZ6Sc8fpe1pE0wRGgAC4t2
         K6iL136Wp5HZmwF6/iA5GwXo/9DM8xWWP8+SV3a3hhhkHmtwOP2dW34TluJsh7j3Nczl
         KOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ts7wj/6p6IhLkdtFxIR72LxXhWu5bCOcfIH/Wo6L9d8=;
        b=zJ4uHLESAfF+VfmEi0tcsF6iE+on6Z73srUyCyyPEXkKVdOczL1+Gw2zNQjUwwwHOD
         GC7rwfbrmYxSYl12bZ7DBR7u2cqZQVeRtQl3oDT4UjXc8+IM++BsFZ2PBcjmFdg5MdxJ
         cSe/6fRWDMOSr9K+zRPpnq3o3EJUAC7L0zEvxybMXY9EMoQ8Sth79ClhCJKNV7xknlA+
         r7VNVdP8Rdq1L/feEEgMqPMCK7ugW6MksMIQgfXae9SHFvx9RR1s58leMdKB8+222+A9
         WMz6xLZi5bB/Nvpq+IHWh7lf8VFa5S2XmWPCmzXm6U2be/KlQIoHrItea45ckBBbRMEn
         mDeA==
X-Gm-Message-State: ACrzQf2sCovJ8S8/o4gsKY52xDz9NCuCCAIMeMde8VudVp6k5hNhglOv
        4KstcqwE+vfMUWI9MDc4eoc=
X-Google-Smtp-Source: AMsMyM4Jqm7Phy8dpRyJs58NYWCsHGUlZGcB5dVbUr142Z7f62AZS53+oFN/NDPqL3GiMVNpqWD/wg==
X-Received: by 2002:a05:6871:588:b0:132:8901:5d4c with SMTP id u8-20020a056871058800b0013289015d4cmr17199565oan.106.1666067779663;
        Mon, 17 Oct 2022 21:36:19 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-290b-8972-ce76-602c.res6.spectrum.com. [2603:8081:140c:1a00:290b:8972:ce76:602c])
        by smtp.googlemail.com with ESMTPSA id e96-20020a9d01e9000000b006618ca5caa0sm5480333ote.78.2022.10.17.21.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 21:36:19 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        jenny.hack@hpe.com, ian.ziemba@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 05/16] RDMA/rxe: Rename task->state_lock to task->lock
Date:   Mon, 17 Oct 2022 23:33:36 -0500
Message-Id: <20221018043345.4033-6-rpearsonhpe@gmail.com>
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

Rename task-state_lock to task->lock

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_task.c | 18 +++++++++---------
 drivers/infiniband/sw/rxe/rxe_task.h |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 097ddb16c230..42442ede99e8 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -35,22 +35,22 @@ static void do_task(struct tasklet_struct *t)
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
@@ -59,7 +59,7 @@ static void do_task(struct tasklet_struct *t)
 		cont = 0;
 		ret = task->func(task->arg);
 
-		spin_lock_bh(&task->state_lock);
+		spin_lock_bh(&task->lock);
 		switch (task->state) {
 		case TASK_STATE_BUSY:
 			if (ret) {
@@ -88,7 +88,7 @@ static void do_task(struct tasklet_struct *t)
 			pr_warn("%s failed with bad state %d\n", __func__,
 				task->state);
 		}
-		spin_unlock_bh(&task->state_lock);
+		spin_unlock_bh(&task->lock);
 	} while (cont);
 
 	task->ret = ret;
@@ -103,7 +103,7 @@ int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *))
 	tasklet_setup(&task->tasklet, do_task);
 
 	task->state = TASK_STATE_START;
-	spin_lock_init(&task->state_lock);
+	spin_lock_init(&task->lock);
 
 	return 0;
 }
@@ -119,9 +119,9 @@ void rxe_cleanup_task(struct rxe_task *task)
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

