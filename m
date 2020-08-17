Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AB124601F
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Aug 2020 10:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgHQI3g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Aug 2020 04:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbgHQI3S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Aug 2020 04:29:18 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E683BC061388;
        Mon, 17 Aug 2020 01:29:17 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o13so7787788pgf.0;
        Mon, 17 Aug 2020 01:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vUxE5IeTrT0uCQB6Hz6X7n59nqYPK8f19l5eZsLWZHk=;
        b=MMpOJ+RWvTnu+RVdki2iQGVC8V89OH3VVXnGu/Y1RXOtkejr+GGOhHI3zVcflDZCqq
         g9v5dZss8ljsyK8YQZwsh20zKQzUtQa1GyansxULKF1ZunW/QCxnhgebjLu5MRqyTX+K
         kM3JBkP/wxurYrtpjJ1sUceO8AZi2c7hmKKgwsAD1BW+Y5QqjzW3hhyYmrS6uluFyaYn
         TDwFAbsuaWgLI6llChgHaLRJZHwXc/6xfUFeHSDkaLh3Eh88+iUYlP4M9g1jAznBqzxH
         r5reKQ0qB6hMVsvEpbk1WTLzXzSVwmKB3ShvqyfuP7COb5jgcZYAx7616Lg8HNsYNqbA
         u2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vUxE5IeTrT0uCQB6Hz6X7n59nqYPK8f19l5eZsLWZHk=;
        b=LiTwPuu9J2/suUnm75QvMsoKawgR2rw00jMKR6oZw3bX5IM88Sxm9YOZTjcRvKyE20
         zItdk2fdR6uxT8A1kcg8yNN07S/Pz8klw4qcdYt2KwJRUQf+8jSdxm0Q4F2MsDNgiMCe
         gsASQz8dmVVuZXTlv2532IlN0Nfwg/hqYOwf5D25TZQ8BSmGWgEubEbAk7PGWNgB+/TG
         A/PwEI9Zl3YBe3P0LlfTdhu48en/w1xUGIA5FEeB7y3ggdvfEyYOi3EF+Hh9pVlAJOql
         f+6sIHEkZcVZIQ8YXk3XnbumMjVcOibDxcYTNRIXex9A+mFyOseLdifppFvHBAIIyxQR
         6URA==
X-Gm-Message-State: AOAM532t9pcncnk5KLLWu99jC19sCOuUXAx/ptRcwh4T8TUngc7Sazao
        p9GSZkSM3SOEx0EuRsAA6jhUUnRO4ypo9w==
X-Google-Smtp-Source: ABdhPJyYs1aNn2mn1IdIEBv6VUmsXeEGAWZ/8yu4FckGc55qa1H6aT4QyV5onP+w/yrk5eNfiI4cfA==
X-Received: by 2002:a05:6a00:228f:: with SMTP id f15mr10444046pfe.222.1597652957399;
        Mon, 17 Aug 2020 01:29:17 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id r7sm18948102pfl.186.2020.08.17.01.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:29:16 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        somnath.kotur@broadcom.com, sriharsha.basavapatna@broadcom.com,
        nareshkumar.pbs@broadcom.com
Cc:     keescook@chromium.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 5/5] infiniband: rxe: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 13:58:44 +0530
Message-Id: <20200817082844.21700-6-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817082844.21700-1-allen.lkml@gmail.com>
References: <20200817082844.21700-1-allen.lkml@gmail.com>
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
index 08f05ac5f5d5..f7c944d2f987 100644
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
2.17.1

