Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEE97134931
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 18:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgAHRWh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jan 2020 12:22:37 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:41791 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729773AbgAHRWh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jan 2020 12:22:37 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 8 Jan 2020 19:22:31 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 008HMVj4009596;
        Wed, 8 Jan 2020 19:22:31 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 008HMVjb009535;
        Wed, 8 Jan 2020 19:22:31 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 008HMVaL009534;
        Wed, 8 Jan 2020 19:22:31 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     yishaih@mellanox.com, maorg@mellanox.com, michaelgur@mellanox.com
Subject: [PATCH rdma-next 03/14] RDMA/mlx5: Simplify devx async commands
Date:   Wed,  8 Jan 2020 19:21:55 +0200
Message-Id: <1578504126-9400-4-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
References: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

With the new FD structure the async commands do not need to hold any
references while running. The existing mlx5_cmd_exec_cb() and
mlx5_cmd_cleanup_async_ctx() provide enough synchronization to ensure
that all outstanding commands are completed before the uobject can be
destructed.

Remove the now confusing get_file() and the type erasure of the
devx_async_cmd_event_file.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/hw/mlx5/devx.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 02125d8..7bb91d2 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -30,7 +30,7 @@ enum devx_obj_flags {
 struct devx_async_data {
 	struct mlx5_ib_dev *mdev;
 	struct list_head list;
-	struct ib_uobject *fd_uobj;
+	struct devx_async_cmd_event_file *ev_file;
 	struct mlx5_async_work cb_work;
 	u16 cmd_out_len;
 	/* must be last field in this structure */
@@ -1673,21 +1673,20 @@ static void devx_query_callback(int status, struct mlx5_async_work *context)
 {
 	struct devx_async_data *async_data =
 		container_of(context, struct devx_async_data, cb_work);
-	struct ib_uobject *fd_uobj = async_data->fd_uobj;
-	struct devx_async_cmd_event_file *ev_file;
-	struct devx_async_event_queue *ev_queue;
+	struct devx_async_cmd_event_file *ev_file = async_data->ev_file;
+	struct devx_async_event_queue *ev_queue = &ev_file->ev_queue;
 	unsigned long flags;
 
-	ev_file = container_of(fd_uobj, struct devx_async_cmd_event_file,
-			       uobj);
-	ev_queue = &ev_file->ev_queue;
-
+	/*
+	 * Note that if the struct devx_async_cmd_event_file uobj begins to be
+	 * destroyed it will block at mlx5_cmd_cleanup_async_ctx() until this
+	 * routine returns, ensuring that it always remains valid here.
+	 */
 	spin_lock_irqsave(&ev_queue->lock, flags);
 	list_add_tail(&async_data->list, &ev_queue->event_list);
 	spin_unlock_irqrestore(&ev_queue->lock, flags);
 
 	wake_up_interruptible(&ev_queue->poll_wait);
-	fput(fd_uobj->object);
 }
 
 #define MAX_ASYNC_BYTES_IN_USE (1024 * 1024) /* 1MB */
@@ -1756,9 +1755,8 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_ASYNC_QUERY)(
 
 	async_data->cmd_out_len = cmd_out_len;
 	async_data->mdev = mdev;
-	async_data->fd_uobj = fd_uobj;
+	async_data->ev_file = ev_file;
 
-	get_file(fd_uobj->object);
 	MLX5_SET(general_obj_in_cmd_hdr, cmd_in, uid, uid);
 	err = mlx5_cmd_exec_cb(&ev_file->async_ctx, cmd_in,
 		    uverbs_attr_get_len(attrs,
@@ -1768,12 +1766,10 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_ASYNC_QUERY)(
 		    devx_query_callback, &async_data->cb_work);
 
 	if (err)
-		goto cb_err;
+		goto free_async;
 
 	return 0;
 
-cb_err:
-	fput(fd_uobj->object);
 free_async:
 	kvfree(async_data);
 sub_bytes:
-- 
1.8.3.1

