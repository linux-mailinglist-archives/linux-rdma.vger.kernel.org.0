Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839621C6D5F
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 11:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgEFJmU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 05:42:20 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:55221 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729204AbgEFJmU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 May 2020 05:42:20 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 May 2020 12:42:00 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0469g0R2015465;
        Wed, 6 May 2020 12:42:00 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 0469g0mo024608;
        Wed, 6 May 2020 12:42:00 +0300
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 0469g0X1024607;
        Wed, 6 May 2020 12:42:00 +0300
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, yishaih@mellanox.com, maorg@mellanox.com
Subject: [PATCH rdma-core 7/8] verbs: Move WQ create and destroy to ioctl
Date:   Wed,  6 May 2020 12:41:08 +0300
Message-Id: <1588758069-24464-8-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1588758069-24464-1-git-send-email-yishaih@mellanox.com>
References: <1588758069-24464-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Introduce create/destroy WQ commands over the ioctl interface to let it
be extended to get an asynchronous event FD.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 libibverbs/CMakeLists.txt |   1 +
 libibverbs/cmd.c          |  73 -------------------
 libibverbs/cmd_wq.c       | 173 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+), 73 deletions(-)
 create mode 100644 libibverbs/cmd_wq.c

diff --git a/libibverbs/CMakeLists.txt b/libibverbs/CMakeLists.txt
index 088f20f..2b77828 100644
--- a/libibverbs/CMakeLists.txt
+++ b/libibverbs/CMakeLists.txt
@@ -38,6 +38,7 @@ rdma_library(ibverbs "${CMAKE_CURRENT_BINARY_DIR}/libibverbs.map"
   cmd_pd.c
   cmd_rwq_ind.c
   cmd_srq.c
+  cmd_wq.c
   cmd_xrcd.c
   compat-1_0.c
   device.c
diff --git a/libibverbs/cmd.c b/libibverbs/cmd.c
index a733cbf..d962649 100644
--- a/libibverbs/cmd.c
+++ b/libibverbs/cmd.c
@@ -1600,53 +1600,6 @@ int ibv_cmd_create_flow(struct ibv_qp *qp,
 	return 0;
 }
 
-int ibv_cmd_create_wq(struct ibv_context *context,
-		      struct ibv_wq_init_attr *wq_init_attr,
-		      struct ibv_wq *wq,
-		      struct ibv_create_wq *cmd,
-		      size_t cmd_size,
-		      struct ib_uverbs_ex_create_wq_resp *resp,
-		      size_t resp_size)
-{
-	int err;
-
-	if (wq_init_attr->comp_mask >= IBV_WQ_INIT_ATTR_RESERVED)
-		return EINVAL;
-
-	cmd->user_handle   = (uintptr_t)wq;
-	cmd->pd_handle           = wq_init_attr->pd->handle;
-	cmd->cq_handle   = wq_init_attr->cq->handle;
-	cmd->wq_type = wq_init_attr->wq_type;
-	cmd->max_sge = wq_init_attr->max_sge;
-	cmd->max_wr = wq_init_attr->max_wr;
-	cmd->comp_mask = 0;
-
-	if (wq_init_attr->comp_mask & IBV_WQ_INIT_ATTR_FLAGS) {
-		if (wq_init_attr->create_flags & ~(IBV_WQ_FLAGS_RESERVED - 1))
-			return EOPNOTSUPP;
-		cmd->create_flags = wq_init_attr->create_flags;
-	}
-
-	err = execute_cmd_write_ex(context, IB_USER_VERBS_EX_CMD_CREATE_WQ,
-				   cmd, cmd_size, resp, resp_size);
-	if (err)
-		return err;
-
-	if (resp->response_length < sizeof(*resp))
-		return EINVAL;
-
-	wq->handle  = resp->wq_handle;
-	wq_init_attr->max_wr = resp->max_wr;
-	wq_init_attr->max_sge = resp->max_sge;
-	wq->wq_num = resp->wqn;
-	wq->context = context;
-	wq->cq = wq_init_attr->cq;
-	wq->pd = wq_init_attr->pd;
-	wq->wq_type = wq_init_attr->wq_type;
-
-	return 0;
-}
-
 int ibv_cmd_modify_wq(struct ibv_wq *wq, struct ibv_wq_attr *attr,
 		      struct ibv_modify_wq *cmd, size_t cmd_size)
 {
@@ -1679,32 +1632,6 @@ int ibv_cmd_modify_wq(struct ibv_wq *wq, struct ibv_wq_attr *attr,
 	return 0;
 }
 
-int ibv_cmd_destroy_wq(struct ibv_wq *wq)
-{
-	struct ibv_destroy_wq req;
-	struct ib_uverbs_ex_destroy_wq_resp resp;
-	int ret;
-
-	req.core_payload = (struct ib_uverbs_ex_destroy_wq){
-		.wq_handle = wq->handle,
-	};
-
-	ret = execute_cmd_write_ex(wq->context, IB_USER_VERBS_EX_CMD_DESTROY_WQ,
-				   &req, sizeof(req), &resp, sizeof(resp));
-	if (verbs_is_destroy_err(&ret))
-		return ret;
-
-	if (resp.response_length < sizeof(resp))
-		return EINVAL;
-
-	pthread_mutex_lock(&wq->mutex);
-	while (wq->events_completed != resp.events_reported)
-		pthread_cond_wait(&wq->cond, &wq->mutex);
-	pthread_mutex_unlock(&wq->mutex);
-
-	return 0;
-}
-
 int ibv_cmd_create_rwq_ind_table(struct ibv_context *context,
 				 struct ibv_rwq_ind_table_init_attr *init_attr,
 				 struct ibv_rwq_ind_table *rwq_ind_table,
diff --git a/libibverbs/cmd_wq.c b/libibverbs/cmd_wq.c
new file mode 100644
index 0000000..d233c3a
--- /dev/null
+++ b/libibverbs/cmd_wq.c
@@ -0,0 +1,173 @@
+/*
+ * Copyright (c) 2020 Mellanox Technologies, Ltd.  All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <infiniband/cmd_write.h>
+
+static int ibv_icmd_create_wq(struct ibv_context *context,
+			      struct ibv_wq_init_attr *wq_init_attr,
+			      struct ibv_wq *wq,
+			      struct ibv_command_buffer *link)
+{
+	DECLARE_FBCMD_BUFFER(cmdb, UVERBS_OBJECT_WQ, UVERBS_METHOD_WQ_CREATE, 13, link);
+	struct ib_uverbs_attr *handle;
+	uint32_t max_wr;
+	uint32_t max_sge;
+	uint32_t wq_num;
+	int ret;
+
+	wq->context = context;
+	wq->cq = wq_init_attr->cq;
+	wq->pd = wq_init_attr->pd;
+	wq->wq_type = wq_init_attr->wq_type;
+
+	handle = fill_attr_out_obj(cmdb, UVERBS_ATTR_CREATE_WQ_HANDLE);
+	fill_attr_in_uint64(cmdb, UVERBS_ATTR_CREATE_WQ_USER_HANDLE, (uintptr_t)wq);
+	fill_attr_in_obj(cmdb, UVERBS_ATTR_CREATE_WQ_PD_HANDLE, wq_init_attr->pd->handle);
+	fill_attr_in_obj(cmdb, UVERBS_ATTR_CREATE_WQ_CQ_HANDLE, wq_init_attr->cq->handle);
+	fill_attr_const_in(cmdb, UVERBS_ATTR_CREATE_WQ_TYPE, wq_init_attr->wq_type);
+	fill_attr_in_uint32(cmdb, UVERBS_ATTR_CREATE_WQ_MAX_WR, wq_init_attr->max_wr);
+	fill_attr_in_uint32(cmdb, UVERBS_ATTR_CREATE_WQ_MAX_SGE, wq_init_attr->max_sge);
+	fill_attr_in_fd(cmdb, UVERBS_ATTR_CREATE_WQ_EVENT_FD, wq->context->async_fd);
+	fill_attr_in_uint32(cmdb, UVERBS_ATTR_CREATE_WQ_FLAGS, wq_init_attr->create_flags);
+	fill_attr_out_ptr(cmdb, UVERBS_ATTR_CREATE_WQ_RESP_MAX_WR, &max_wr);
+	fill_attr_out_ptr(cmdb, UVERBS_ATTR_CREATE_WQ_RESP_MAX_SGE, &max_sge);
+	fill_attr_out_ptr(cmdb, UVERBS_ATTR_CREATE_WQ_RESP_WQ_NUM, &wq_num);
+
+	fallback_require_ex(cmdb);
+
+	switch (execute_ioctl_fallback(context, create_wq, cmdb, &ret)) {
+	case TRY_WRITE_EX: {
+		DECLARE_LEGACY_UHW_BUFS_EX(link,
+					   IB_USER_VERBS_EX_CMD_CREATE_WQ);
+
+		*req = (struct ib_uverbs_ex_create_wq){
+			.user_handle = (uintptr_t)wq,
+			.pd_handle = wq_init_attr->pd->handle,
+			.cq_handle = wq_init_attr->cq->handle,
+			.max_wr = wq_init_attr->max_wr,
+			.max_sge = wq_init_attr->max_sge,
+			.wq_type = wq_init_attr->wq_type,
+			.create_flags = wq_init_attr->create_flags,
+		};
+
+		ret = execute_write_bufs_ex(
+			context, IB_USER_VERBS_EX_CMD_CREATE_WQ, req, resp);
+		if (ret)
+			return ret;
+
+		wq->handle  = resp->wq_handle;
+		wq_init_attr->max_wr = resp->max_wr;
+		wq_init_attr->max_sge = resp->max_sge;
+		wq->wq_num = resp->wqn;
+		return 0;
+	}
+
+	case SUCCESS:
+		break;
+
+	default:
+		return ret;
+	}
+
+	wq->handle = read_attr_obj(UVERBS_ATTR_CREATE_WQ_HANDLE, handle);
+	wq->wq_num = wq_num;
+	wq_init_attr->max_wr = max_wr;
+	wq_init_attr->max_sge = max_sge;
+
+	return 0;
+}
+
+int ibv_cmd_create_wq(struct ibv_context *context,
+		      struct ibv_wq_init_attr *wq_init_attr,
+		      struct ibv_wq *wq,
+		      struct ibv_create_wq *cmd,
+		      size_t cmd_size,
+		      struct ib_uverbs_ex_create_wq_resp *resp,
+		      size_t resp_size)
+{
+	DECLARE_CMD_BUFFER_COMPAT(cmdb, UVERBS_OBJECT_WQ,
+				  UVERBS_METHOD_WQ_CREATE, cmd, cmd_size, resp,
+				  resp_size);
+
+	if (wq_init_attr->comp_mask >= IBV_WQ_INIT_ATTR_RESERVED) {
+		errno = EINVAL;
+		return errno;
+	}
+
+	if (wq_init_attr->comp_mask & IBV_WQ_INIT_ATTR_FLAGS) {
+		if (wq_init_attr->create_flags & ~(IBV_WQ_FLAGS_RESERVED - 1)) {
+			errno = EOPNOTSUPP;
+			return errno;
+		}
+	}
+
+	return ibv_icmd_create_wq(context, wq_init_attr, wq, cmdb);
+}
+
+int ibv_cmd_destroy_wq(struct ibv_wq *wq)
+{
+	DECLARE_FBCMD_BUFFER(cmdb, UVERBS_OBJECT_WQ, UVERBS_METHOD_WQ_DESTROY, 2,
+			     NULL);
+	struct ib_uverbs_ex_destroy_wq_resp resp;
+	int ret;
+
+	fill_attr_out_ptr(cmdb, UVERBS_ATTR_DESTROY_WQ_RESP, &resp.events_reported);
+	fill_attr_in_obj(cmdb, UVERBS_ATTR_DESTROY_WQ_HANDLE, wq->handle);
+
+	switch (execute_ioctl_fallback(wq->context, destroy_wq, cmdb, &ret)) {
+	case TRY_WRITE: {
+		struct ibv_destroy_wq req;
+
+		req.core_payload = (struct ib_uverbs_ex_destroy_wq){
+			.wq_handle = wq->handle,
+		};
+
+
+		ret = execute_cmd_write_ex(wq->context, IB_USER_VERBS_EX_CMD_DESTROY_WQ,
+				   &req, sizeof(req), &resp, sizeof(resp));
+		break;
+	}
+
+	default:
+		break;
+	}
+
+	if (verbs_is_destroy_err(&ret))
+		return ret;
+
+	pthread_mutex_lock(&wq->mutex);
+	while (wq->events_completed != resp.events_reported)
+		pthread_cond_wait(&wq->cond, &wq->mutex);
+	pthread_mutex_unlock(&wq->mutex);
+
+	return 0;
+}
-- 
1.8.3.1

