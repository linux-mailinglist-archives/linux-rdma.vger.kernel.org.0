Return-Path: <linux-rdma+bounces-9603-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EC3A94394
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Apr 2025 15:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0101119E17EA
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Apr 2025 13:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF801C7007;
	Sat, 19 Apr 2025 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="NHPBaC4Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700A8647;
	Sat, 19 Apr 2025 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745069257; cv=none; b=d3UymKWxc92rJm0C+4U8hQ4FF9uzk6nM9blRY7jsOv5y16+qhyM5lGnJED/qf69pNJ1e0szCu04scBjKWviSRhhR8e6cJL1aO6MtKspcmMHsTw/xTvaX65eG0xHBppthNHdsBmklOik+sIl8QL4+ZdpERUCvC3YYwZkfJA2jMkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745069257; c=relaxed/simple;
	bh=+uz/4w6JNaDoPA9Ed/apbbZcQ5BJZe2Xz7DdZUVE1HM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EI6wrPm+qiyQlnqxbJBq5lWYtwpoMel274y1+3cFPaKY3+DYyoKASWMgnkRQyERmRq+z3Xk14LFiwkcZuzMD83Si/EfP90vKJIjxIKfeDLAtNpOqvlWiKbzFXP1glex9fs58rfltNqYX8U0kdPGtFc5pz/iylPYF/hYky75VW5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=NHPBaC4Q; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=gU/E1vKlkPLWrJ0OVNNoWBxNFhw6hZGKnzDZ9DEn8dE=; b=NHPBaC4QRsGrYCbH
	YhSNOZE7sI27YD1iN/o5cGp9DunmAmFx4WHQRfOl2pkmK7UAq1kDkLgipVNARPxPtQ0+FA02Sm9KK
	EMqgSizzETFSw0Fun2MU1lTRbue1PNBmcW6ZZVVQfOmSc728EMFvzebtc7Ml64svoRGg+y1RQkTQs
	pxYiQ8+E77KSB9qk/pQ/XwE+Z1iGNzei+BdVpRB6s1EEHrJEbkPoSAoEjLrDzPRBtuMlqZDdnsZbC
	mCpgNw2u3nLbJbwlYAO3nbnRG1f63Lae6g/OBGpjl1zVAYTtwaqejhW0yYFv9jxr5488S1xmImj8B
	MoU14Q/DnONux8hJLQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1u68EA-00CeT3-0M;
	Sat, 19 Apr 2025 13:27:26 +0000
From: linux@treblig.org
To: yanjun.zhu@linux.dev,
	zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH v2] RDMA/rxe: Remove unused rxe_run_task
Date: Sat, 19 Apr 2025 14:27:25 +0100
Message-ID: <20250419132725.199785-1-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

rxe_run_task() has been unused since 2024's
commit 23bc06af547f ("RDMA/rxe: Don't call direct between tasks")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
v2
  Remove reference in comment and reformat comment

 drivers/infiniband/sw/rxe/rxe_task.c | 40 ++++++++--------------------
 drivers/infiniband/sw/rxe/rxe_task.h |  2 --
 2 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 80332638d9e3..6f8f353e9583 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -85,17 +85,17 @@ static bool is_done(struct rxe_task *task)
 
 /* do_task is a wrapper for the three tasks (requester,
  * completer, responder) and calls them in a loop until
- * they return a non-zero value. It is called either
- * directly by rxe_run_task or indirectly if rxe_sched_task
- * schedules the task. They must call __reserve_if_idle to
- * move the task to busy before calling or scheduling.
- * The task can also be moved to drained or invalid
- * by calls to rxe_cleanup_task or rxe_disable_task.
- * In that case tasks which get here are not executed but
- * just flushed. The tasks are designed to look to see if
- * there is work to do and then do part of it before returning
- * here with a return value of zero until all the work
- * has been consumed then it returns a non-zero value.
+ * they return a non-zero value. It is called indirectly
+ * when rxe_sched_task schedules the task. They must
+ * call __reserve_if_idle to move the task to busy before
+ * calling or scheduling. The task can also be moved to
+ * drained or invalid by calls to rxe_cleanup_task or
+ * rxe_disable_task. In that case tasks which get here
+ * are not executed but just flushed. The tasks are
+ * designed to look to see if there is work to do and
+ * then do part of it before returning here with a return
+ * value of zero until all the work has been consumed then
+ * it returns a non-zero value.
  * The number of times the task can be run is limited by
  * max iterations so one task cannot hold the cpu forever.
  * If the limit is hit and work remains the task is rescheduled.
@@ -234,24 +234,6 @@ void rxe_cleanup_task(struct rxe_task *task)
 	spin_unlock_irqrestore(&task->lock, flags);
 }
 
-/* run the task inline if it is currently idle
- * cannot call do_task holding the lock
- */
-void rxe_run_task(struct rxe_task *task)
-{
-	unsigned long flags;
-	bool run;
-
-	WARN_ON(rxe_read(task->qp) <= 0);
-
-	spin_lock_irqsave(&task->lock, flags);
-	run = __reserve_if_idle(task);
-	spin_unlock_irqrestore(&task->lock, flags);
-
-	if (run)
-		do_task(task);
-}
-
 /* schedule the task to run later as a work queue entry.
  * the queue_work call can be called holding
  * the lock.
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index a63e258b3d66..a8c9a77b6027 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -47,8 +47,6 @@ int rxe_init_task(struct rxe_task *task, struct rxe_qp *qp,
 /* cleanup task */
 void rxe_cleanup_task(struct rxe_task *task);
 
-void rxe_run_task(struct rxe_task *task);
-
 void rxe_sched_task(struct rxe_task *task);
 
 /* keep a task from scheduling */
-- 
2.49.0


