Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01294D216C
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2019 09:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732928AbfJJHLP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Oct 2019 03:11:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfJJHLP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Oct 2019 03:11:15 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8A952190F;
        Thu, 10 Oct 2019 07:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570691474;
        bh=gJiegQZSfx7jtdSVQan5bfm1ct1XNfMwiuXombuFRaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uOx5XtRcHmT2tDJ+qhjN09Py0Lw7b8V9AewQD3cgc6JWBVC6IiX7a1uZ43M+8bgKZ
         5WTxLvBiJNzedKDIxLmoH37Kg2be41KofFT7E75lrd0Wcu+9QrzsfN1xs172NSoB6a
         f2SDBaiez7SUie9TybjatD5vS54YVFsiu489EmTg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next v1 1/2] RDMA/restrack: Remove PID namespace support
Date:   Thu, 10 Oct 2019 10:11:04 +0300
Message-Id: <20191010071105.25538-2-leon@kernel.org>
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

IB resources are bounded to IB device and file descriptors,
both entities are unaware to PID namespaces and to task lifetime.

The difference in model caused to unpredictable behavior for the
following scenario:
 1. Create FD and context
 2. Share it with ephemeral child
 3. Create any object and exit that child

The end result of this flow, that those newly created objects will be
tracked by restrack, but won't be visible for users because task_struct
associated with them already exited.

The right thing is to rely on net namespace only for any filtering
purposes  and drop PID namespace.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/counters.c | 14 --------------
 drivers/infiniband/core/nldev.c    | 13 +------------
 drivers/infiniband/core/restrack.c | 20 +-------------------
 drivers/infiniband/core/restrack.h |  1 -
 4 files changed, 2 insertions(+), 46 deletions(-)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index 736ab760025d..12ba2685abcf 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -149,9 +149,6 @@ static bool auto_mode_match(struct ib_qp *qp, struct rdma_counter *counter,
 	struct auto_mode_param *param = &counter->mode.param;
 	bool match = true;
 
-	if (!rdma_is_visible_in_pid_ns(&qp->res))
-		return false;
-
 	/* Ensure that counter belongs to the right PID */
 	if (task_pid_nr(counter->res.task) != task_pid_nr(qp->res.task))
 		return false;
@@ -229,9 +226,6 @@ static struct rdma_counter *rdma_get_counter_auto_mode(struct ib_qp *qp,
 	rt = &dev->res[RDMA_RESTRACK_COUNTER];
 	xa_lock(&rt->xa);
 	xa_for_each(&rt->xa, id, res) {
-		if (!rdma_is_visible_in_pid_ns(res))
-			continue;
-
 		counter = container_of(res, struct rdma_counter, res);
 		if ((counter->device != qp->device) || (counter->port != port))
 			goto next;
@@ -412,9 +406,6 @@ static struct ib_qp *rdma_counter_get_qp(struct ib_device *dev, u32 qp_num)
 	if (IS_ERR(res))
 		return NULL;
 
-	if (!rdma_is_visible_in_pid_ns(res))
-		goto err;
-
 	qp = container_of(res, struct ib_qp, res);
 	if (qp->qp_type == IB_QPT_RAW_PACKET && !capable(CAP_NET_RAW))
 		goto err;
@@ -445,11 +436,6 @@ static struct rdma_counter *rdma_get_counter_by_id(struct ib_device *dev,
 	if (IS_ERR(res))
 		return NULL;
 
-	if (!rdma_is_visible_in_pid_ns(res)) {
-		rdma_restrack_put(res);
-		return NULL;
-	}
-
 	counter = container_of(res, struct rdma_counter, res);
 	kref_get(&counter->kref);
 	rdma_restrack_put(res);
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 7a7474000100..71bc08510064 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -698,9 +698,6 @@ static int fill_stat_counter_qps(struct sk_buff *msg,
 	rt = &counter->device->res[RDMA_RESTRACK_QP];
 	xa_lock(&rt->xa);
 	xa_for_each(&rt->xa, id, res) {
-		if (!rdma_is_visible_in_pid_ns(res))
-			continue;
-
 		qp = container_of(res, struct ib_qp, res);
 		if (qp->qp_type == IB_QPT_RAW_PACKET && !capable(CAP_NET_RAW))
 			continue;
@@ -1222,15 +1219,10 @@ static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto err;
 	}
 
-	if (!rdma_is_visible_in_pid_ns(res)) {
-		ret = -ENOENT;
-		goto err_get;
-	}
-
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg) {
 		ret = -ENOMEM;
-		goto err;
+		goto err_get;
 	}
 
 	nlh = nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
@@ -1334,9 +1326,6 @@ static int res_get_common_dumpit(struct sk_buff *skb,
 	 * objects.
 	 */
 	xa_for_each(&rt->xa, id, res) {
-		if (!rdma_is_visible_in_pid_ns(res))
-			continue;
-
 		if (idx < start || !rdma_restrack_get(res))
 			goto next;
 
diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index a07665f7ef8c..62fbb0ae9cb4 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -116,11 +116,8 @@ int rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type)
 	u32 cnt = 0;
 
 	xa_lock(&rt->xa);
-	xas_for_each(&xas, e, U32_MAX) {
-		if (!rdma_is_visible_in_pid_ns(e))
-			continue;
+	xas_for_each(&xas, e, U32_MAX)
 		cnt++;
-	}
 	xa_unlock(&rt->xa);
 	return cnt;
 }
@@ -346,18 +343,3 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
 	}
 }
 EXPORT_SYMBOL(rdma_restrack_del);
-
-bool rdma_is_visible_in_pid_ns(struct rdma_restrack_entry *res)
-{
-	/*
-	 * 1. Kern resources should be visible in init
-	 *    namespace only
-	 * 2. Present only resources visible in the current
-	 *     namespace
-	 */
-	if (rdma_is_kernel_res(res))
-		return task_active_pid_ns(current) == &init_pid_ns;
-
-	/* PID 0 means that resource is not found in current namespace */
-	return task_pid_vnr(res->task);
-}
diff --git a/drivers/infiniband/core/restrack.h b/drivers/infiniband/core/restrack.h
index 7bd177cc0a61..d084e5f89849 100644
--- a/drivers/infiniband/core/restrack.h
+++ b/drivers/infiniband/core/restrack.h
@@ -27,5 +27,4 @@ int rdma_restrack_init(struct ib_device *dev);
 void rdma_restrack_clean(struct ib_device *dev);
 void rdma_restrack_attach_task(struct rdma_restrack_entry *res,
 			       struct task_struct *task);
-bool rdma_is_visible_in_pid_ns(struct rdma_restrack_entry *res);
 #endif /* _RDMA_CORE_RESTRACK_H_ */
-- 
2.20.1

