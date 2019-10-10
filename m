Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB4DD216D
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2019 09:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732993AbfJJHLT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Oct 2019 03:11:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfJJHLS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Oct 2019 03:11:18 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D43420B7C;
        Thu, 10 Oct 2019 07:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570691477;
        bh=nnYLH1uG+9nJcpWo+o1Jw9z0y1gV6PAnxk7tE/HKVG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YklC/xhmVB6choJA62r3cHHjhTR11/dJbsUeD1mcNeqB0XHTiH1MLvGKh0fvkwdAe
         1VyWW8qHC7KXf+Bpl9M6TJ8iKUbg/Qu6gOuHFmltxgDcFt+ZcjzAadqPbNeXNX29rN
         Mmky9zzOU1gv4VEUm/e/U6hm2rfXQ35jhOdp+Fjs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next v1 2/2] RDMA/core: Check that process is still alive before sending it to the users
Date:   Thu, 10 Oct 2019 10:11:05 +0300
Message-Id: <20191010071105.25538-3-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191010071105.25538-1-leon@kernel.org>
References: <20191010071105.25538-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The PID information can disappear asynchronically because task can be
killed and moved to zombie state. In such case, PID will be zero in
similar way to the kernel tasks. Recognize such situation where
we are asking to return orphaned object and simply skip filling
PID attribute.

As part of this change, document the same scenario in counter.c code.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/counters.c | 14 ++++++++++++--
 drivers/infiniband/core/nldev.c    | 28 +++++++++++++++++++++-------
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index 12ba2685abcf..47c551a0bcb0 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -149,8 +149,18 @@ static bool auto_mode_match(struct ib_qp *qp, struct rdma_counter *counter,
 	struct auto_mode_param *param = &counter->mode.param;
 	bool match = true;
 
-	/* Ensure that counter belongs to the right PID */
-	if (task_pid_nr(counter->res.task) != task_pid_nr(qp->res.task))
+	/*
+	 * Ensure that counter belongs to the right PID.
+	 * This operation can race with user space which kills
+	 * the process and leaves QP and counters orphans.
+	 *
+	 * It is not a big deal because exitted task will leave both
+	 * QP and counter in the same bucket of zombie process. Just ensure
+	 * that process is still alive before procedding.
+	 *
+	 */
+	if (task_pid_nr(counter->res.task) != task_pid_nr(qp->res.task) ||
+	    !task_pid_nr(qp->res.task))
 		return false;
 
 	if (auto_mask & RDMA_COUNTER_MASK_QP_TYPE)
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 71bc08510064..0ebe95c79ae0 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -399,20 +399,34 @@ static int fill_res_info(struct sk_buff *msg, struct ib_device *device)
 static int fill_res_name_pid(struct sk_buff *msg,
 			     struct rdma_restrack_entry *res)
 {
+	int err = 0;
+
 	/*
 	 * For user resources, user is should read /proc/PID/comm to get the
 	 * name of the task file.
 	 */
 	if (rdma_is_kernel_res(res)) {
-		if (nla_put_string(msg, RDMA_NLDEV_ATTR_RES_KERN_NAME,
-		    res->kern_name))
-			return -EMSGSIZE;
+		err = nla_put_string(msg, RDMA_NLDEV_ATTR_RES_KERN_NAME,
+				     res->kern_name);
 	} else {
-		if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PID,
-		    task_pid_vnr(res->task)))
-			return -EMSGSIZE;
+		pid_t pid;
+
+		pid = task_pid_vnr(res->task);
+		/*
+		 * Task is dead and in zombie state.
+		 * There is no need to print PID anymore.
+		 */
+		if (pid)
+			/*
+			 * This part is racy, task can be killed and PID will
+			 * be zero right here but it is ok, next query won't
+			 * return PID. We don't promise real-time reflection
+			 * of SW objects.
+			 */
+			err = nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PID, pid);
 	}
-	return 0;
+
+	return err ? -EMSGSIZE : 0;
 }
 
 static bool fill_res_entry(struct ib_device *dev, struct sk_buff *msg,
-- 
2.20.1

