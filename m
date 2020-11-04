Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9701F2A66A8
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 15:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbgKDOqL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Nov 2020 09:46:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:45878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730243AbgKDOqL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 4 Nov 2020 09:46:11 -0500
Received: from localhost (searspoint.nvidia.com [216.228.112.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3728020756;
        Wed,  4 Nov 2020 14:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604501170;
        bh=hmwoY4MJbp4fuCyVElNKcOABoCbpzbnNp7EcrYhDsOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t+ZZ/9DDeWnW+RvPkXzfiHoe3i0QXiPCU2ANSYIAsX5s7DW1uE7A8PvMYK3OmWoP9
         TlE2TTNFl78WiVTswY1PqZfaY1XCOKGqJ4pHQLiXcyujN3GLGB9ZV+dm5Yc8/Zolvb
         uVbnjnuQWQmwjEBeiy0dbTYbTKt0Hxyn7f0pF28I=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 2/2] RDMA/core: Make FD destroy callback void
Date:   Wed,  4 Nov 2020 16:45:56 +0200
Message-Id: <20201104144556.3809085-3-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104144556.3809085-1-leon@kernel.org>
References: <20201104144556.3809085-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

All FD object destroy implementations return 0, so declare
this callback void.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/rdma_core.c                 |  3 ++-
 drivers/infiniband/core/uverbs_std_types.c          |  3 +--
 drivers/infiniband/core/uverbs_std_types_async_fd.c |  5 ++---
 drivers/infiniband/hw/mlx5/devx.c                   | 10 ++++------
 include/rdma/uverbs_types.h                         |  4 ++--
 5 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 1ec1b1cd221d..1b641106b29b 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -571,7 +571,8 @@ static int __must_check destroy_hw_fd_uobject(struct ib_uobject *uobj,
 	const struct uverbs_obj_fd_type *fd_type = container_of(
 		uobj->uapi_object->type_attrs, struct uverbs_obj_fd_type, type);
 
-	return fd_type->destroy_object(uobj, why);
+	fd_type->destroy_object(uobj, why);
+	return 0;
 }
 
 static void remove_handle_fd_uobject(struct ib_uobject *uobj)
diff --git a/drivers/infiniband/core/uverbs_std_types.c b/drivers/infiniband/core/uverbs_std_types.c
index 585042ead939..13776a66e2e4 100644
--- a/drivers/infiniband/core/uverbs_std_types.c
+++ b/drivers/infiniband/core/uverbs_std_types.c
@@ -154,7 +154,7 @@ void ib_uverbs_free_event_queue(struct ib_uverbs_event_queue *event_queue)
 	spin_unlock_irq(&event_queue->lock);
 }
 
-static int
+static void
 uverbs_completion_event_file_destroy_uobj(struct ib_uobject *uobj,
 					  enum rdma_remove_reason why)
 {
@@ -163,7 +163,6 @@ uverbs_completion_event_file_destroy_uobj(struct ib_uobject *uobj,
 			     uobj);
 
 	ib_uverbs_free_event_queue(&file->ev_queue);
-	return 0;
 }
 
 int uverbs_destroy_def_handler(struct uverbs_attr_bundle *attrs)
diff --git a/drivers/infiniband/core/uverbs_std_types_async_fd.c b/drivers/infiniband/core/uverbs_std_types_async_fd.c
index 61899eaf1f91..cc24cfdf7aee 100644
--- a/drivers/infiniband/core/uverbs_std_types_async_fd.c
+++ b/drivers/infiniband/core/uverbs_std_types_async_fd.c
@@ -19,8 +19,8 @@ static int UVERBS_HANDLER(UVERBS_METHOD_ASYNC_EVENT_ALLOC)(
 	return 0;
 }
 
-static int uverbs_async_event_destroy_uobj(struct ib_uobject *uobj,
-					   enum rdma_remove_reason why)
+static void uverbs_async_event_destroy_uobj(struct ib_uobject *uobj,
+					    enum rdma_remove_reason why)
 {
 	struct ib_uverbs_async_event_file *event_file =
 		container_of(uobj, struct ib_uverbs_async_event_file, uobj);
@@ -30,7 +30,6 @@ static int uverbs_async_event_destroy_uobj(struct ib_uobject *uobj,
 	if (why == RDMA_REMOVE_DRIVER_REMOVE)
 		ib_uverbs_async_handler(event_file, 0, IB_EVENT_DEVICE_FATAL,
 					NULL, NULL);
-	return 0;
 }
 
 int uverbs_async_event_release(struct inode *inode, struct file *filp)
diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index a27a7110b63c..5acfe2ba9f0f 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2588,8 +2588,8 @@ static const struct file_operations devx_async_event_fops = {
 	.llseek	 = no_llseek,
 };
 
-static int devx_async_cmd_event_destroy_uobj(struct ib_uobject *uobj,
-					     enum rdma_remove_reason why)
+static void devx_async_cmd_event_destroy_uobj(struct ib_uobject *uobj,
+					      enum rdma_remove_reason why)
 {
 	struct devx_async_cmd_event_file *comp_ev_file =
 		container_of(uobj, struct devx_async_cmd_event_file,
@@ -2611,11 +2611,10 @@ static int devx_async_cmd_event_destroy_uobj(struct ib_uobject *uobj,
 		kvfree(entry);
 	}
 	spin_unlock_irq(&comp_ev_file->ev_queue.lock);
-	return 0;
 };
 
-static int devx_async_event_destroy_uobj(struct ib_uobject *uobj,
-					 enum rdma_remove_reason why)
+static void devx_async_event_destroy_uobj(struct ib_uobject *uobj,
+					  enum rdma_remove_reason why)
 {
 	struct devx_async_event_file *ev_file =
 		container_of(uobj, struct devx_async_event_file,
@@ -2659,7 +2658,6 @@ static int devx_async_event_destroy_uobj(struct ib_uobject *uobj,
 	mutex_unlock(&dev->devx_event_table.event_xa_lock);
 
 	put_device(&dev->ib_dev.dev);
-	return 0;
 };
 
 DECLARE_UVERBS_NAMED_METHOD(
diff --git a/include/rdma/uverbs_types.h b/include/rdma/uverbs_types.h
index 06db27e35f40..a27e9fb4903f 100644
--- a/include/rdma/uverbs_types.h
+++ b/include/rdma/uverbs_types.h
@@ -138,8 +138,8 @@ struct uverbs_obj_fd_type {
 	 * because the driver is removed or the FD is closed.
 	 */
 	struct uverbs_obj_type  type;
-	int (*destroy_object)(struct ib_uobject *uobj,
-			      enum rdma_remove_reason why);
+	void (*destroy_object)(struct ib_uobject *uobj,
+			       enum rdma_remove_reason why);
 	const struct file_operations	*fops;
 	const char			*name;
 	int				flags;
-- 
2.28.0

