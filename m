Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00CED135AEE
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2020 15:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbgAIOFX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jan 2020 09:05:23 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33792 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728319AbgAIOFX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jan 2020 09:05:23 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 9 Jan 2020 16:05:16 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 009E5GLt016609;
        Thu, 9 Jan 2020 16:05:16 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 009E5FCQ001334;
        Thu, 9 Jan 2020 16:05:15 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 009E5FoX001333;
        Thu, 9 Jan 2020 16:05:15 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, dledford@redhat.com, yishaih@mellanox.com,
        maorg@mellanox.com, michaelgur@mellanox.com
Subject: [PATCH rdma-core 3/7] verbs: Move alloc_context to ioctl
Date:   Thu,  9 Jan 2020 16:04:32 +0200
Message-Id: <1578578676-752-4-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1578578676-752-1-git-send-email-yishaih@mellanox.com>
References: <1578578676-752-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Michael Guralnik <michaelgur@mellanox.com>

Execute alloc_context using ioctl mechanism with fallback to write
method.

In the ioctl flow split the aync_fd allocation to a new ioctl call and
get the 'core_support' field returned from the kernel.

Signed-off-by: Michael Guralnik <michaelgur@mellanox.com>
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 libibverbs/cmd.c        | 18 -----------
 libibverbs/cmd_device.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
 libibverbs/driver.h     |  1 +
 3 files changed, 80 insertions(+), 18 deletions(-)

diff --git a/libibverbs/cmd.c b/libibverbs/cmd.c
index 26eaa47..b68f3e3 100644
--- a/libibverbs/cmd.c
+++ b/libibverbs/cmd.c
@@ -47,24 +47,6 @@
 
 bool verbs_allow_disassociate_destroy;
 
-int ibv_cmd_get_context(struct verbs_context *context_ex,
-			struct ibv_get_context *cmd, size_t cmd_size,
-			struct ib_uverbs_get_context_resp *resp, size_t resp_size)
-{
-	int ret;
-
-	ret = execute_cmd_write(&context_ex->context,
-				IB_USER_VERBS_CMD_GET_CONTEXT, cmd, cmd_size,
-				resp, resp_size);
-	if (ret)
-		return ret;
-
-	context_ex->context.async_fd = resp->async_fd;
-	context_ex->context.num_comp_vectors = resp->num_comp_vectors;
-
-	return 0;
-}
-
 static void copy_query_dev_fields(struct ibv_device_attr *device_attr,
 				  struct ib_uverbs_query_device_resp *resp,
 				  uint64_t *raw_fw_ver)
diff --git a/libibverbs/cmd_device.c b/libibverbs/cmd_device.c
index d806351..4de59c0 100644
--- a/libibverbs/cmd_device.c
+++ b/libibverbs/cmd_device.c
@@ -99,3 +99,82 @@ int ibv_cmd_query_port(struct ibv_context *context, uint8_t port_num,
 	return 0;
 }
 
+static int cmd_alloc_async_fd(struct ibv_context *context)
+{
+	DECLARE_COMMAND_BUFFER(cmdb, UVERBS_OBJECT_ASYNC_EVENT,
+			       UVERBS_METHOD_ASYNC_EVENT_ALLOC, 1);
+	struct ib_uverbs_attr *handle;
+	int ret;
+
+	handle = fill_attr_out_fd(cmdb, UVERBS_ATTR_ASYNC_EVENT_ALLOC_FD_HANDLE,
+				  0);
+
+	ret = execute_ioctl(context, cmdb);
+	if (ret)
+		return ret;
+
+	context->async_fd =
+		read_attr_fd(UVERBS_ATTR_ASYNC_EVENT_ALLOC_FD_HANDLE, handle);
+	return 0;
+}
+
+static int cmd_get_context(struct verbs_context *context_ex,
+				struct ibv_command_buffer *link)
+{
+	DECLARE_FBCMD_BUFFER(cmdb, UVERBS_OBJECT_DEVICE,
+			     UVERBS_METHOD_GET_CONTEXT, 2, link);
+
+	struct ibv_context *context = &context_ex->context;
+	struct verbs_device *verbs_device;
+	uint64_t core_support;
+	uint32_t num_comp_vectors;
+	int ret;
+
+	fill_attr_out_ptr(cmdb, UVERBS_ATTR_GET_CONTEXT_NUM_COMP_VECTORS,
+			  &num_comp_vectors);
+	fill_attr_out_ptr(cmdb, UVERBS_ATTR_GET_CONTEXT_CORE_SUPPORT,
+			  &core_support);
+
+	/* Using free_context cmd_name as alloc context is not in
+	 * verbs_context_ops while free_context is and doesn't use ioctl
+	 */
+	switch (execute_ioctl_fallback(context, free_context, cmdb, &ret)) {
+	case TRY_WRITE: {
+		DECLARE_LEGACY_UHW_BUFS(link, IB_USER_VERBS_CMD_GET_CONTEXT);
+
+		ret = execute_write_bufs(context, IB_USER_VERBS_CMD_GET_CONTEXT,
+					 req, resp);
+		if (ret)
+			return ret;
+
+		context->async_fd = resp->async_fd;
+		context->num_comp_vectors = resp->num_comp_vectors;
+
+		return 0;
+	}
+	case SUCCESS:
+		ret = cmd_alloc_async_fd(context);
+		if (ret)
+			return ret;
+		break;
+	default:
+		return ret;
+	};
+
+	context->num_comp_vectors = num_comp_vectors;
+	verbs_device = verbs_get_device(context->device);
+	verbs_device->core_support = core_support;
+	return 0;
+}
+
+int ibv_cmd_get_context(struct verbs_context *context_ex,
+			struct ibv_get_context *cmd, size_t cmd_size,
+			struct ib_uverbs_get_context_resp *resp,
+			size_t resp_size)
+{
+	DECLARE_CMD_BUFFER_COMPAT(cmdb, UVERBS_OBJECT_DEVICE,
+				  UVERBS_METHOD_GET_CONTEXT, cmd, cmd_size,
+				  resp, resp_size);
+
+	return cmd_get_context(context_ex, cmdb);
+}
diff --git a/libibverbs/driver.h b/libibverbs/driver.h
index 88603ce..09974d9 100644
--- a/libibverbs/driver.h
+++ b/libibverbs/driver.h
@@ -230,6 +230,7 @@ struct verbs_device {
 	atomic_int refcount;
 	struct list_node entry;
 	struct verbs_sysfs_dev *sysfs;
+	uint64_t core_support;
 };
 
 struct verbs_counters {
-- 
1.8.3.1

