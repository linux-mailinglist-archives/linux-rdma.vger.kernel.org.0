Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A88611FA7
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Oct 2022 05:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiJ2DK5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 23:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiJ2DKp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 23:10:45 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571BD2A96A
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:10:29 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-13b6c1c89bdso8303695fac.13
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soz/F6qoTZgUnUzOYqKvjKeAcULP68mCGNrH+7qHydk=;
        b=ZMAR4uz82O8YYa71qADcL9CZVS1BmRsnxryByrsWV3hUsfLZrYhNqC3SLNhWuSzWbB
         RHeN8U5ersX+lruBCxVTLyInJgpzOjqnyT+Y04bA4dReX5kWUz/JQkoDxDXlszOec9h6
         qhgZdOVVmTjl3HFXGaHBD8lXKldJV9VDtxoYHD39fxUF+UyrsJy0dOg9z1zpD43lisyW
         Cyms/dPbIqsJShStzdnI/zRWhR58WV5sZohtexMsmIwakXrI3+fYHfEeOXK45pqFKuUI
         D2OwXeScd2413BXevawJqu7ZA2cV5NaWTchIuXY58CTeLfu8IQ6HYxnx6tYYzIwQnWwr
         J5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soz/F6qoTZgUnUzOYqKvjKeAcULP68mCGNrH+7qHydk=;
        b=RmCy/f7iWjYdsf9tg8rdMOslfhxLQc1MRu7HpI7ICrIgncqYj53YbwzPobT9cp26hV
         YFKIPAVZMBT+tlP/RqPyQ5LkTUYMMB+ypgelKy8aIsspnwXIVOvmJQyI/7iW+z6obMKL
         OhmEFv6veY50ccW3X1z5LbGXuJCCocfJV5XtiokwX5590Oh/GD58wIbZoAUCyt/32cYB
         pChRQZGr5AxcH+8c75h44U86yuoSEZd86FaeriNB7ZFEPJsvKV8PHcD69eRy1udLCiqI
         hbuugEmIDvF0v8Z2QIEphqO7q/VxUIRfjjo4BTrWA3BaDyLoYJdSHf25jG+L1siS2h40
         CoGw==
X-Gm-Message-State: ACrzQf1Swnh63JHQzR5L7rlnP2WXnjOriy1kBlqS0FNqXXJ5Lm/OxVj/
        wfknWQvKaePpizT74b/7bIg=
X-Google-Smtp-Source: AMsMyM5TMjLgrq7+C1+F2ZVElBA1teWXl3TMyg6kD21nGMvYMEYjBCDqK58/AbtEFAqFRPIVlh1Tdg==
X-Received: by 2002:a05:6870:3120:b0:132:7d08:7059 with SMTP id v32-20020a056870312000b001327d087059mr1336547oaa.226.1667013029213;
        Fri, 28 Oct 2022 20:10:29 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-5d1e-45f3-e9b5-d771.res6.spectrum.com. [2603:8081:140c:1a00:5d1e:45f3:e9b5:d771])
        by smtp.googlemail.com with ESMTPSA id p3-20020a0568301d4300b006391adb6034sm162493oth.72.2022.10.28.20.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 20:10:28 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Ian Ziemba <ian.ziemba@hpe.com>
Subject: [PATCH for-next v3 11/13] RDMA/rxe: Add workqueue support for tasks
Date:   Fri, 28 Oct 2022 22:10:08 -0500
Message-Id: <20221029031009.64467-12-rpearsonhpe@gmail.com>
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

Add a third task type RXE_TASK_TYPE_WORKQUEUE to rxe_task.c.

Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c      |  9 +++-
 drivers/infiniband/sw/rxe/rxe_task.c | 66 ++++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_task.h | 10 ++++-
 3 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 51daac5c4feb..6d80218334ca 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -210,10 +210,16 @@ static int __init rxe_module_init(void)
 {
 	int err;
 
-	err = rxe_net_init();
+	err = rxe_alloc_wq();
 	if (err)
 		return err;
 
+	err = rxe_net_init();
+	if (err) {
+		rxe_destroy_wq();
+		return err;
+	}
+
 	rdma_link_register(&rxe_link_ops);
 	pr_info("loaded\n");
 	return 0;
@@ -224,6 +230,7 @@ static void __exit rxe_module_exit(void)
 	rdma_link_unregister(&rxe_link_ops);
 	ib_unregister_driver(RDMA_DRIVER_RXE);
 	rxe_net_exit();
+	rxe_destroy_wq();
 
 	pr_info("unloaded\n");
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index da175f2a0dbf..c1177752088d 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -6,6 +6,22 @@
 
 #include "rxe.h"
 
+static struct workqueue_struct *rxe_wq;
+
+int rxe_alloc_wq(void)
+{
+	rxe_wq = alloc_workqueue("rxe_wq", WQ_CPU_INTENSIVE, WQ_MAX_ACTIVE);
+	if (!rxe_wq)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void rxe_destroy_wq(void)
+{
+	destroy_workqueue(rxe_wq);
+}
+
 static bool task_is_idle(struct rxe_task *task)
 {
 	spin_lock_bh(&task->lock);
@@ -198,6 +214,53 @@ static void tsklet_init(struct rxe_task *task)
 	task->ops = &tsklet_ops;
 }
 
+static void work_sched(struct rxe_task *task)
+{
+	if (task_is_idle(task))
+		queue_work(rxe_wq, &task->work);
+}
+
+static void work_do_task(struct work_struct *work)
+{
+	do_task(container_of(work, struct rxe_task, work));
+}
+
+static void work_run(struct rxe_task *task)
+{
+	if (task_is_idle(task))
+		do_task(task);
+}
+
+static void work_enable(struct rxe_task *task)
+{
+	enable_task(task);
+}
+
+static void work_disable(struct rxe_task *task)
+{
+	disable_task(task);
+	flush_workqueue(rxe_wq);
+}
+
+static void work_cleanup(struct rxe_task *task)
+{
+	cleanup_task(task);
+}
+
+static const struct rxe_task_ops work_ops = {
+	.sched = work_sched,
+	.run = work_run,
+	.enable = work_enable,
+	.disable = work_disable,
+	.cleanup = work_cleanup,
+};
+
+static void work_init(struct rxe_task *task)
+{
+	INIT_WORK(&task->work, work_do_task);
+	task->ops = &work_ops;
+}
+
 int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *),
 		  enum rxe_task_type type)
 {
@@ -215,6 +278,9 @@ int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *),
 	case RXE_TASK_TYPE_TASKLET:
 		tsklet_init(task);
 		break;
+	case RXE_TASK_TYPE_WORKQUEUE:
+		work_init(task);
+		break;
 	default:
 		pr_debug("%s: invalid task type = %d\n", __func__, type);
 		return -EINVAL;
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index 2c4ef4d339f1..d1156b935635 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -20,6 +20,7 @@ struct rxe_task_ops {
 enum rxe_task_type {
 	RXE_TASK_TYPE_INLINE	= 0,
 	RXE_TASK_TYPE_TASKLET	= 1,
+	RXE_TASK_TYPE_WORKQUEUE	= 2,
 };
 
 enum {
@@ -36,7 +37,10 @@ enum {
  * called again.
  */
 struct rxe_task {
-	struct tasklet_struct		tasklet;
+	union {
+		struct tasklet_struct		tasklet;
+		struct work_struct		work;
+	};
 	int				state;
 	spinlock_t			lock;
 	void				*arg;
@@ -47,6 +51,10 @@ struct rxe_task {
 	enum rxe_task_type		type;
 };
 
+int rxe_alloc_wq(void);
+
+void rxe_destroy_wq(void);
+
 int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *),
 		  enum rxe_task_type type);
 
-- 
2.34.1

