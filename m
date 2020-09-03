Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC3D25BADD
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 08:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgICGHP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 02:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgICGHO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Sep 2020 02:07:14 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF84BC061244
        for <linux-rdma@vger.kernel.org>; Wed,  2 Sep 2020 23:07:13 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ds1so981925pjb.1
        for <linux-rdma@vger.kernel.org>; Wed, 02 Sep 2020 23:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7qELzTY9D/PZ9hN6ksqo4sH3izZkxkXWXFuBSyF3z60=;
        b=s7RN7pAD8x8YfAXUMLp0Pph4yI6Sa4lS7J7rShZf3t79nOpYThmN3WP7pcw/IGm3OJ
         QvHPzjSR7fhT32gPheXkDF8RRB3NQPwDSBQq7Cs2scYBBPqPYB9057Y2ar3p6sLZFFyW
         19Lj4MutdZlysbG/4exYiVBBIFZXuKstd06eexblKns7FK10hvSw5HRCf+GV8OT5ZENt
         n6CI87SV5esvVXQ92T9LZzF8DFS/pAY14CNcKhhZz3Yfy8DYrM0kVsCmYTEnudcU5U3s
         MWJzN4mLt9iswlWYCJwRuOAbxhrrCIGQwsbSgMgp1E/aNlET7VwTVGmzKDQmeObXCdTo
         ADJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7qELzTY9D/PZ9hN6ksqo4sH3izZkxkXWXFuBSyF3z60=;
        b=C/V3p6TVcM7a+MekBz08uvMHDdn7dhOHTuU70FndULUDQi5oOEmG3AXxZlB4j+gCZ7
         Z0ldgsXV1wt9NwAxR9CVi9C62tyqonaZ5vBtT72YiQhWO9dd9ccfNO9FTmEaGz6J05j9
         sVEt2aHUNOaKntV11WVVmocpab+lAwhtQkISza7Hbgb6fwfEyTj+syNVg9kbMxWOPyzx
         JdMiKz/uNahdjocuMIE4o6o1zK/QPlp5Hx4BMl3GI+nvclPSBG/jxvB8Fq92Z5xWsUjL
         5h9cZngD9gul7nMMeDxGBzfg7QevwmwV1aK52ITNYM7D34lzLfF4oMpNj5Aqnp/m7HYb
         l3hg==
X-Gm-Message-State: AOAM530Xx+W+GqzN6OI3im6aBfyhrrvFRAiueaYG0I4zNAnJz942DTqP
        gmt6pIIw6oa87l0g9EDehWc=
X-Google-Smtp-Source: ABdhPJwydrFN5YgA2Le9U74T5ouf+Tn+dLHakb/eUKsb6vHGvyVCTFOs4RFGBcIdJMY8Gv/kbqsufw==
X-Received: by 2002:a17:90a:e291:: with SMTP id d17mr1658391pjz.156.1599113233327;
        Wed, 02 Sep 2020 23:07:13 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.170])
        by smtp.gmail.com with ESMTPSA id v1sm1210395pjh.16.2020.09.02.23.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 23:07:12 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     jgg@nvidia.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, selvin.xavier@broadcom.com,
        devesh.sharma@broadcom.com, somnath.kotur@broadcom.com,
        sriharsha.basavapatna@broadcom.com, nareshkumar.pbs@broadcom.com,
        jgg@ziepe.ca, mike.marciniszyn@intel.com,
        dennis.dalessandro@intel.com, faisal.latif@intel.com,
        shiraz.saleem@intel.com, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH v2 5/5] RDMA/rxe: convert tasklets to use new tasklet_setup() API
Date:   Thu,  3 Sep 2020 11:36:37 +0530
Message-Id: <20200903060637.424458-6-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903060637.424458-1-allen.lkml@gmail.com>
References: <20200903060637.424458-1-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_cq.c   | 6 +++---
 drivers/infiniband/sw/rxe/rxe_task.c | 8 ++++----
 drivers/infiniband/sw/rxe/rxe_task.h | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index ad3090131126..f232fd03d19a 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -66,9 +66,9 @@ int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq *cq,
 	return -EINVAL;
 }
 
-static void rxe_send_complete(unsigned long data)
+static void rxe_send_complete(struct tasklet_struct *t)
 {
-	struct rxe_cq *cq = (struct rxe_cq *)data;
+	struct rxe_cq *cq = from_tasklet(cq, t, comp_task);
 	unsigned long flags;
 
 	spin_lock_irqsave(&cq->cq_lock, flags);
@@ -107,7 +107,7 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 
 	cq->is_dying = false;
 
-	tasklet_init(&cq->comp_task, rxe_send_complete, (unsigned long)cq);
+	tasklet_setup(&cq->comp_task, rxe_send_complete);
 
 	spin_lock_init(&cq->cq_lock);
 	cq->ibcq.cqe = cqe;
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index ecdac3f8fcc9..afa38d613a91 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -55,12 +55,12 @@ int __rxe_do_task(struct rxe_task *task)
  * a second caller finds the task already running
  * but looks just after the last call to func
  */
-void rxe_do_task(unsigned long data)
+void rxe_do_task(struct tasklet_struct *t)
 {
 	int cont;
 	int ret;
 	unsigned long flags;
-	struct rxe_task *task = (struct rxe_task *)data;
+	struct rxe_task *task = from_tasklet(task, t, tasklet);
 
 	spin_lock_irqsave(&task->state_lock, flags);
 	switch (task->state) {
@@ -123,7 +123,7 @@ int rxe_init_task(void *obj, struct rxe_task *task,
 	snprintf(task->name, sizeof(task->name), "%s", name);
 	task->destroyed	= false;
 
-	tasklet_init(&task->tasklet, rxe_do_task, (unsigned long)task);
+	tasklet_setup(&task->tasklet, rxe_do_task);
 
 	task->state = TASK_STATE_START;
 	spin_lock_init(&task->state_lock);
@@ -159,7 +159,7 @@ void rxe_run_task(struct rxe_task *task, int sched)
 	if (sched)
 		tasklet_schedule(&task->tasklet);
 	else
-		rxe_do_task((unsigned long)task);
+		rxe_do_task(&task->tasklet);
 }
 
 void rxe_disable_task(struct rxe_task *task)
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index 08ff42d451c6..f69fbb2dd09f 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -80,7 +80,7 @@ int __rxe_do_task(struct rxe_task *task);
  * work to do someone must reschedule the task before
  * leaving
  */
-void rxe_do_task(unsigned long data);
+void rxe_do_task(struct tasklet_struct *t);
 
 /* run a task, else schedule it to run as a tasklet, The decision
  * to run or schedule tasklet is based on the parameter sched.
-- 
2.25.1

