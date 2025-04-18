Return-Path: <linux-rdma+bounces-9593-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CA2A93B86
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 18:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511C317FE5F
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 16:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63102218AA5;
	Fri, 18 Apr 2025 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="CYHTS770"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C7F217654;
	Fri, 18 Apr 2025 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995593; cv=none; b=QB84Go9dkhw8LGySWNUXX8zW02UUzEYBcn/J3QxI3w86HnDpEd/xT/JP2aREjgIcvkOjkkPTw40kKD9BINf+wtCs/TdkQFOwry2LS0Fxg0vCBEW7xhqvifR+wjKkPh/ZO6IASYMU/9bzf570VYnZ65Jox+qHWarY6UdeihN7BnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995593; c=relaxed/simple;
	bh=f9LCf5XY0NmuotjWlwn9SlS2ogqMZOVMR/R19eR6DwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sug7WHn8UISAj5iFjOcBhyHzdgVIDsf7wR0cMI65mo9FIHVvjmFlF2i2BmKxPAVmUhkBWiyerO0CXnwDfM6t1awe3eaoJmt4anB/wl/6s1HRuec6s8NyFa0MRMRgTYtjhptN9bBP/pkpaUDQhK902dFF5T7U/zzi0XhE2eM4VdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=CYHTS770; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=DP97MXZ7PzDPbpV50opJyj9CQ8OLjgOoekVd8uypiAA=; b=CYHTS770FIXqtMeZ
	yJ6AgMzHGZSgRVRNDOI07jAxIBTQfCQ7sw/E6hZo+dRiCsOwyhqY+6onjoaKDYcO8UuDYWdL82Ggq
	Ur261AmI/PY+4F/az0oODG7bwpdbWfM8ocrDPABo5U1voiAT33pjHn0QIct8yFg+LdmxYTTGsfcBd
	92Zg1NlLvtB6T3PfrfB1/qYeq/nzwPcJdJMPIeYSaJvTlplDGLHHMaYGkcNSGx2qHLVYqrOTbZqsU
	e7jcHfmX7MSS+jV+iKue6xR6fsOuSxY8kAd/cxsHet2Mtu40vlyzoHpHSCSJyje75tJFCg3qJr6K6
	nViR4jRzDyqjIv7O2w==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1u5p48-00CYEY-2b;
	Fri, 18 Apr 2025 16:59:48 +0000
From: linux@treblig.org
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] RDMA/rxe: Remove unused rxe_run_task
Date: Fri, 18 Apr 2025 17:59:48 +0100
Message-ID: <20250418165948.241433-1-linux@treblig.org>
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
 drivers/infiniband/sw/rxe/rxe_task.c | 18 ------------------
 drivers/infiniband/sw/rxe/rxe_task.h |  2 --
 2 files changed, 20 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 80332638d9e3..9d02d847fd78 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
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


