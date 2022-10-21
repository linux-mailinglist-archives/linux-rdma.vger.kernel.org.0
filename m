Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8E5607F79
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 22:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiJUUDA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 16:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiJUUC1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 16:02:27 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C510726109E
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:23 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id j6-20020a4ab1c6000000b004809a59818cso597726ooo.0
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJWw3ZWMyyqJyXyBd0hMBqS86p0cuWLJRsxZt7tbY50=;
        b=Ea+0oy3gaxaeDylQ3Gn/lcdFomaCjTK/fuYibIXnWG6o2yvxfVfp7mnoXzBpC3VsDH
         sdywuG2OKqby4RJGpUyrenp1A1z/nnVKRGwihQcwPonJbElZNxgDWNF21RPua/Y+XzS+
         yKFG1beycOqIsOltVIbQaAp5gV8Hr1pBe2jXt3Dxn2YfCfaM6+y71YlXdjuZC9Zvq6bB
         kkRpEENwGgDtbqiMGV5jY1ZeiFpqWJoJ/somrvBYyyDpyyWbGBDKhfmsHpkjUouXZ+uc
         IS6zFPsGPpM1Ki2fS4gAJHaGzsGwbVQ0YtBp/N8qm/WhXboozmk/2ttoBbx5m4GAZGPa
         T87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJWw3ZWMyyqJyXyBd0hMBqS86p0cuWLJRsxZt7tbY50=;
        b=Zt3Dv5Rd1YbgWDh+BnNeFwZgTDoabIFr22y7KNuNeJFlx4/wRNt29RsdhiGDMuqlKV
         YUwM6Cw+wftSWUmihHuSY1kjGpJwGHkw2jUUubs4rZhGGyHS7zV5MoEIHe7yF6y1FGYU
         IvsNZkw4+sAgAxwmnhlnitafMShmhGKT4BIGyo1gXPHYkJUEpR2fW3EV+P1Z25UdNDiW
         ENMkgVkplKGlAtlVCAV6/EugNlZp1OjeGsRza9KS3Kh64NZ7580GtiCOwQW6d1trNGmV
         KmCnVx4nd3rUruu+tDK/JG42pKslgPZ+0zMH0HlmDGo9R30f9UHdt8hi1l6tp/Jy2jFm
         PBKw==
X-Gm-Message-State: ACrzQf3dGaaYbxm2bnG7BEXgDkT2UMFQUXBZxNSdxanMx9hgEV0bw4AS
        kJylIvu1DuFXNPmeV9I3LhY=
X-Google-Smtp-Source: AMsMyM5+KCQVFxiWOrhiN8HZ/i698R6AW6J1kSPhtiNeRwsYXvUEgBnUtTDJlDEInrU3uvcJmk1uHA==
X-Received: by 2002:a4a:97a5:0:b0:475:fa71:731e with SMTP id w34-20020a4a97a5000000b00475fa71731emr9712464ooi.38.1666382542534;
        Fri, 21 Oct 2022 13:02:22 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-a860-f1d2-9e17-7593.res6.spectrum.com. [2603:8081:140c:1a00:a860:f1d2:9e17:7593])
        by smtp.googlemail.com with ESMTPSA id s23-20020a056870631700b00132f141ef2dsm10674684oao.56.2022.10.21.13.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 13:02:22 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leon@kernel.org,
        jhack@hpe.com, ian.ziemba@hpe.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, haris.phnx@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 17/18] RDMA/rxe: Add workqueue support for tasks
Date:   Fri, 21 Oct 2022 15:01:18 -0500
Message-Id: <20221021200118.2163-18-rpearsonhpe@gmail.com>
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

Add a third task type RXE_TASK_TYPE_WORKQUEUE to rxe_task.c.

Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c      |  9 +++-
 drivers/infiniband/sw/rxe/rxe_task.c | 69 ++++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_task.h | 10 +++-
 3 files changed, 86 insertions(+), 2 deletions(-)

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
index da175f2a0dbf..9b8c9d28ee46 100644
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
@@ -198,6 +217,53 @@ static void tsklet_init(struct rxe_task *task)
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
@@ -215,6 +281,9 @@ int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *),
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

