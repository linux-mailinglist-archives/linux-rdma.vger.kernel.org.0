Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7441260235E
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 06:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJREgo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 00:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiJREgd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 00:36:33 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5570AA0249
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:32 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-12c8312131fso15610833fac.4
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AH0HuGzyqYEVe4u3MM7m2JilO3VaD70MzOFOyhxiih4=;
        b=d1JZbh82jANFWBCFVxuvUoiDvQETiNAw18gbXuZAM+le+gb0ZqkWMW4G7X6I2k8Snt
         dS8utI1TJqKY97T0Xadrb2viu+QzxmErm91+Q57NUWxEdDmNDx0Rmf21rnJD9+9mBLqb
         A6WX6zXY8afBdxewR0c2Mm7Jvr9RohNCt66BVzi7vsGntoNaNwZkiI0jjWNt4VSzxXCU
         ENxhfX1S9KZedu/XiNbU4SDcBTYPtzH+E6hN7LJNhP6tDSUeigriy1LZwVwf70d3GOFh
         Aa138Th6CwCpwxZICBdJypxIjxbhhssdhbM/u8pDGpT2AzzrAcsAHZA1DGHgS+QfYBfY
         4VhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AH0HuGzyqYEVe4u3MM7m2JilO3VaD70MzOFOyhxiih4=;
        b=OM9FCR/codFItEUw6mvVOfdv0bHt6M8SNG4twU3CmIZPt4WRXi79L+v7rNEfc6J5XD
         ttDzUS3XqzDKGJqdGtg43fKHnKqFBGJUNLSFKQObu6XxejEy2SO0OdhhVPF+p7rxB/HK
         TbElpG9EZfg+ObBJJ+rZj6HyACxxLRUv2VlxboqUjv2EG05znjfPwiuP8ybFk8ULY5+1
         Tp7VVpPsyM9Bps7JqX34bbcM4pUIUNLnAHL+m461aBgvHkeLyuU1xeapBTx/NXE72nJn
         EFeRXa7hGE9d5dPIOM2uLhf57knfHU833y0BoFUOGXULBjaLiweDtaMB6LFptJw6cg9d
         hdgQ==
X-Gm-Message-State: ACrzQf3Bxy84xBNWPhtP4SfDUtRjU22ymIRccbj7Mfhd04o4edenit8h
        YBmQIeG8mNSZWXPpMRVJQxk=
X-Google-Smtp-Source: AMsMyM7B/9qL6oAIIakt1io7o3eCWAG3+YjeVZ3tr1vr4iEGyFi/lXYMpRIZlTT4pJgdq9sWOsCf8w==
X-Received: by 2002:a05:6870:960b:b0:132:e9d6:ea39 with SMTP id d11-20020a056870960b00b00132e9d6ea39mr617905oaq.257.1666067791690;
        Mon, 17 Oct 2022 21:36:31 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-290b-8972-ce76-602c.res6.spectrum.com. [2603:8081:140c:1a00:290b:8972:ce76:602c])
        by smtp.googlemail.com with ESMTPSA id e96-20020a9d01e9000000b006618ca5caa0sm5480333ote.78.2022.10.17.21.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 21:36:31 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        jenny.hack@hpe.com, ian.ziemba@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 15/16] RDMA/rxe: Add workqueue support for tasks
Date:   Mon, 17 Oct 2022 23:33:46 -0500
Message-Id: <20221018043345.4033-16-rpearsonhpe@gmail.com>
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

Add a third task type RXE_TASK_TYPE_WORKQUEUE to rxe_task.c.

Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c      |  9 ++-
 drivers/infiniband/sw/rxe/rxe_task.c | 84 ++++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_task.h | 10 +++-
 3 files changed, 101 insertions(+), 2 deletions(-)

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
index a2c58ce66c8f..ea33ea3bc0b1 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -10,6 +10,25 @@
 
 #include "rxe.h"
 
+static struct workqueue_struct *rxe_wq;
+
+int rxe_alloc_wq(void)
+{
+	rxe_wq = alloc_workqueue("rxe_wq", WQ_MEM_RECLAIM |
+				WQ_HIGHPRI | WQ_CPU_INTENSIVE |
+				WQ_SYSFS, WQ_MAX_ACTIVE);
+
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
 	if (!task->valid)
@@ -216,6 +235,68 @@ static void tsklet_init(struct rxe_task *task)
 	task->ops = &tsklet_ops;
 }
 
+static void work_sched(struct rxe_task *task)
+{
+	if (!task->valid)
+		return;
+
+	queue_work(rxe_wq, &task->work);
+}
+
+static void work_do_task(struct work_struct *work)
+{
+	struct rxe_task *task = container_of(work, typeof(*task), work);
+
+	if (!task->valid)
+		return;
+
+	do_task(task);
+}
+
+static void work_run(struct rxe_task *task)
+{
+	if (!task->valid)
+		return;
+
+	do_task(task);
+}
+
+static void work_enable(struct rxe_task *task)
+{
+	if (!task->valid)
+		return;
+
+	enable_task(task);
+}
+
+static void work_disable(struct rxe_task *task)
+{
+	if (!task->valid)
+		return;
+
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
@@ -233,6 +314,9 @@ int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *),
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
index c81947e88629..4887ca566769 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -20,6 +20,7 @@ struct rxe_task_ops {
 enum rxe_task_type {
 	RXE_TASK_TYPE_INLINE	= 0,
 	RXE_TASK_TYPE_TASKLET	= 1,
+	RXE_TASK_TYPE_WORKQUEUE	= 2,
 };
 
 enum {
@@ -35,7 +36,10 @@ enum {
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
@@ -46,6 +50,10 @@ struct rxe_task {
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

