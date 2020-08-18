Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DD0248461
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 14:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgHRMFv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 08:05:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:32836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgHRMFt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Aug 2020 08:05:49 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD5B320786;
        Tue, 18 Aug 2020 12:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597752348;
        bh=X3AeP62a00KDnPp2+4Xbc0s/t9gAET2ghbLAphrR/88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lStuJ1p8mlN3HAqcN2axn8yD3lLeeTW7fP87bNigo6zFgzxhtEZR9c0E9VNMjp7MR
         yPi/Lwwl9ZrjyRxZKy3+jLVMS8nktmQV1yEI4aO2uyDKQksbuvmBW/iEQBRVRHgEKL
         lTGwsvMyAkQgDsJnBqmuQpnM0hyS/DPfxo/jiKN8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 05/14] RDMA/ucma: Remove mc_list and rely on xarray
Date:   Tue, 18 Aug 2020 15:05:17 +0300
Message-Id: <20200818120526.702120-6-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818120526.702120-1-leon@kernel.org>
References: <20200818120526.702120-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

It is not really necessary to keep a linked list of mcs associated with
each context when we can just scan the xarray to find the right things.

The removes another overloading of file->mut by relying on the xarray
locking for mc instead.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/ucma.c | 59 +++++++++++++---------------------
 1 file changed, 22 insertions(+), 37 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 7416a5a6aa69..dd12931f3038 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -96,7 +96,6 @@ struct ucma_context {
 	u64			uid;
 
 	struct list_head	list;
-	struct list_head	mc_list;
 	/* mark that device is in process of destroying the internal HW
 	 * resources, protected by the ctx_table lock
 	 */
@@ -113,7 +112,6 @@ struct ucma_multicast {
 
 	u64			uid;
 	u8			join_state;
-	struct list_head	list;
 	struct sockaddr_storage	addr;
 };
 
@@ -217,7 +215,6 @@ static struct ucma_context *ucma_alloc_ctx(struct ucma_file *file)
 	INIT_WORK(&ctx->close_work, ucma_close_id);
 	refcount_set(&ctx->ref, 1);
 	init_completion(&ctx->comp);
-	INIT_LIST_HEAD(&ctx->mc_list);
 	/* So list_del() will work if we don't do ucma_finish_ctx() */
 	INIT_LIST_HEAD(&ctx->list);
 	ctx->file = file;
@@ -237,26 +234,6 @@ static void ucma_finish_ctx(struct ucma_context *ctx)
 	xa_store(&ctx_table, ctx->id, ctx, GFP_KERNEL);
 }
 
-static struct ucma_multicast* ucma_alloc_multicast(struct ucma_context *ctx)
-{
-	struct ucma_multicast *mc;
-
-	mc = kzalloc(sizeof(*mc), GFP_KERNEL);
-	if (!mc)
-		return NULL;
-
-	mc->ctx = ctx;
-	if (xa_alloc(&multicast_table, &mc->id, NULL, xa_limit_32b, GFP_KERNEL))
-		goto error;
-
-	list_add_tail(&mc->list, &ctx->mc_list);
-	return mc;
-
-error:
-	kfree(mc);
-	return NULL;
-}
-
 static void ucma_copy_conn_event(struct rdma_ucm_conn_param *dst,
 				 struct rdma_conn_param *src)
 {
@@ -551,21 +528,26 @@ static ssize_t ucma_create_id(struct ucma_file *file, const char __user *inbuf,
 
 static void ucma_cleanup_multicast(struct ucma_context *ctx)
 {
-	struct ucma_multicast *mc, *tmp;
+	struct ucma_multicast *mc;
+	unsigned long index;
 
-	mutex_lock(&ctx->file->mut);
-	list_for_each_entry_safe(mc, tmp, &ctx->mc_list, list) {
-		list_del(&mc->list);
-		xa_erase(&multicast_table, mc->id);
+	xa_for_each(&multicast_table, index, mc) {
+		if (mc->ctx != ctx)
+			continue;
+		/*
+		 * At this point mc->ctx->ref is 0 so the mc cannot leave the
+		 * lock on the reader and this is enough serialization
+		 */
+		xa_erase(&multicast_table, index);
 		kfree(mc);
 	}
-	mutex_unlock(&ctx->file->mut);
 }
 
 static void ucma_cleanup_mc_events(struct ucma_multicast *mc)
 {
 	struct ucma_event *uevent, *tmp;
 
+	mutex_lock(&mc->ctx->file->mut);
 	list_for_each_entry_safe(uevent, tmp, &mc->ctx->file->event_list, list) {
 		if (uevent->mc != mc)
 			continue;
@@ -573,6 +555,7 @@ static void ucma_cleanup_mc_events(struct ucma_multicast *mc)
 		list_del(&uevent->list);
 		kfree(uevent);
 	}
+	mutex_unlock(&mc->ctx->file->mut);
 }
 
 /*
@@ -1501,15 +1484,23 @@ static ssize_t ucma_process_join(struct ucma_file *file,
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
-	mutex_lock(&file->mut);
-	mc = ucma_alloc_multicast(ctx);
+	mc = kzalloc(sizeof(*mc), GFP_KERNEL);
 	if (!mc) {
 		ret = -ENOMEM;
 		goto err1;
 	}
+
+	mc->ctx = ctx;
 	mc->join_state = join_state;
 	mc->uid = cmd->uid;
 	memcpy(&mc->addr, addr, cmd->addr_size);
+
+	if (xa_alloc(&multicast_table, &mc->id, NULL, xa_limit_32b,
+		     GFP_KERNEL)) {
+		ret = -ENOMEM;
+		goto err1;
+	}
+
 	mutex_lock(&ctx->mutex);
 	ret = rdma_join_multicast(ctx->cm_id, (struct sockaddr *)&mc->addr,
 				  join_state, mc);
@@ -1526,7 +1517,6 @@ static ssize_t ucma_process_join(struct ucma_file *file,
 
 	xa_store(&multicast_table, mc->id, mc, 0);
 
-	mutex_unlock(&file->mut);
 	ucma_put_ctx(ctx);
 	return 0;
 
@@ -1535,10 +1525,8 @@ static ssize_t ucma_process_join(struct ucma_file *file,
 	ucma_cleanup_mc_events(mc);
 err2:
 	xa_erase(&multicast_table, mc->id);
-	list_del(&mc->list);
 	kfree(mc);
 err1:
-	mutex_unlock(&file->mut);
 	ucma_put_ctx(ctx);
 	return ret;
 }
@@ -1617,10 +1605,7 @@ static ssize_t ucma_leave_multicast(struct ucma_file *file,
 	rdma_leave_multicast(mc->ctx->cm_id, (struct sockaddr *) &mc->addr);
 	mutex_unlock(&mc->ctx->mutex);
 
-	mutex_lock(&mc->ctx->file->mut);
 	ucma_cleanup_mc_events(mc);
-	list_del(&mc->list);
-	mutex_unlock(&mc->ctx->file->mut);
 
 	ucma_put_ctx(mc->ctx);
 	resp.events_reported = mc->events_reported;
-- 
2.26.2

