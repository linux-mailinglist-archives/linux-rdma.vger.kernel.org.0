Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834A41C6D5A
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 11:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgEFJmI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 05:42:08 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33008 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729207AbgEFJmH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 May 2020 05:42:07 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 May 2020 12:42:00 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0469g0ep015455;
        Wed, 6 May 2020 12:42:00 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 0469g0cl024600;
        Wed, 6 May 2020 12:42:00 +0300
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 0469g0Me024599;
        Wed, 6 May 2020 12:42:00 +0300
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, yishaih@mellanox.com, maorg@mellanox.com
Subject: [PATCH rdma-core 5/8] verbs: Move SRQ create and destroy to ioctl
Date:   Wed,  6 May 2020 12:41:06 +0300
Message-Id: <1588758069-24464-6-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1588758069-24464-1-git-send-email-yishaih@mellanox.com>
References: <1588758069-24464-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Introduce create/destroy SRQ commands over the ioctl interface to let it
be extended to get an asynchronous event FD.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 libibverbs/CMakeLists.txt |   1 +
 libibverbs/cmd.c          | 137 -----------------------
 libibverbs/cmd_srq.c      | 279 ++++++++++++++++++++++++++++++++++++++++++++++
 libibverbs/driver.h       |   2 +-
 libibverbs/kern-abi.h     |   4 +
 providers/mlx4/srq.c      |   1 -
 providers/mlx5/verbs.c    |   2 +-
 7 files changed, 286 insertions(+), 140 deletions(-)
 create mode 100644 libibverbs/cmd_srq.c

diff --git a/libibverbs/CMakeLists.txt b/libibverbs/CMakeLists.txt
index 4328548..088f20f 100644
--- a/libibverbs/CMakeLists.txt
+++ b/libibverbs/CMakeLists.txt
@@ -37,6 +37,7 @@ rdma_library(ibverbs "${CMAKE_CURRENT_BINARY_DIR}/libibverbs.map"
   cmd_mw.c
   cmd_pd.c
   cmd_rwq_ind.c
+  cmd_srq.c
   cmd_xrcd.c
   compat-1_0.c
   device.c
diff --git a/libibverbs/cmd.c b/libibverbs/cmd.c
index 03d9143..a733cbf 100644
--- a/libibverbs/cmd.c
+++ b/libibverbs/cmd.c
@@ -480,120 +480,6 @@ int ibv_cmd_resize_cq(struct ibv_cq *cq, int cqe,
 	return 0;
 }
 
-int ibv_cmd_create_srq(struct ibv_pd *pd,
-		       struct ibv_srq *srq, struct ibv_srq_init_attr *attr,
-		       struct ibv_create_srq *cmd, size_t cmd_size,
-		       struct ib_uverbs_create_srq_resp *resp, size_t resp_size)
-{
-	int ret;
-
-	cmd->user_handle = (uintptr_t) srq;
-	cmd->pd_handle 	 = pd->handle;
-	cmd->max_wr      = attr->attr.max_wr;
-	cmd->max_sge     = attr->attr.max_sge;
-	cmd->srq_limit   = attr->attr.srq_limit;
-
-	ret = execute_cmd_write(pd->context, IB_USER_VERBS_CMD_CREATE_SRQ, cmd,
-				cmd_size, resp, resp_size);
-	if (ret)
-		return ret;
-
-	srq->handle  = resp->srq_handle;
-	srq->context = pd->context;
-
-	if (abi_ver > 5) {
-		attr->attr.max_wr = resp->max_wr;
-		attr->attr.max_sge = resp->max_sge;
-	} else {
-		struct ibv_create_srq_resp_v5 *resp_v5 =
-			(struct ibv_create_srq_resp_v5 *) resp;
-
-		memmove((void *) resp + sizeof *resp,
-			(void *) resp_v5 + sizeof *resp_v5,
-			resp_size - sizeof *resp);
-	}
-
-	return 0;
-}
-
-int ibv_cmd_create_srq_ex(struct ibv_context *context,
-			  struct verbs_srq *srq, int vsrq_sz,
-			  struct ibv_srq_init_attr_ex *attr_ex,
-			  struct ibv_create_xsrq *cmd, size_t cmd_size,
-			  struct ib_uverbs_create_srq_resp *resp, size_t resp_size)
-{
-	struct verbs_xrcd *vxrcd = NULL;
-	int ret;
-
-	if (attr_ex->comp_mask >= IBV_SRQ_INIT_ATTR_RESERVED)
-		return EOPNOTSUPP;
-
-	if (!(attr_ex->comp_mask & IBV_SRQ_INIT_ATTR_PD))
-		return EINVAL;
-
-	cmd->user_handle = (uintptr_t) srq;
-	cmd->pd_handle   = attr_ex->pd->handle;
-	cmd->max_wr      = attr_ex->attr.max_wr;
-	cmd->max_sge     = attr_ex->attr.max_sge;
-	cmd->srq_limit   = attr_ex->attr.srq_limit;
-
-	cmd->srq_type = (attr_ex->comp_mask & IBV_SRQ_INIT_ATTR_TYPE) ?
-			attr_ex->srq_type : IBV_SRQT_BASIC;
-	if (attr_ex->comp_mask & IBV_SRQ_INIT_ATTR_XRCD) {
-		if (!(attr_ex->comp_mask & IBV_SRQ_INIT_ATTR_CQ))
-			return EINVAL;
-
-		vxrcd = container_of(attr_ex->xrcd, struct verbs_xrcd, xrcd);
-		cmd->xrcd_handle = vxrcd->handle;
-		cmd->cq_handle   = attr_ex->cq->handle;
-	} else if (attr_ex->comp_mask & IBV_SRQ_INIT_ATTR_TM) {
-		if (cmd->srq_type != IBV_SRQT_TM)
-			return EINVAL;
-		if (!(attr_ex->comp_mask & IBV_SRQ_INIT_ATTR_CQ) ||
-		    !attr_ex->tm_cap.max_num_tags)
-			return EINVAL;
-
-		cmd->cq_handle    = attr_ex->cq->handle;
-		cmd->max_num_tags = attr_ex->tm_cap.max_num_tags;
-	} else if (cmd->srq_type != IBV_SRQT_BASIC) {
-		return EINVAL;
-	}
-
-	ret = execute_cmd_write(context, IB_USER_VERBS_CMD_CREATE_XSRQ, cmd,
-				cmd_size, resp, resp_size);
-	if (ret)
-		return ret;
-
-	srq->srq.handle           = resp->srq_handle;
-	srq->srq.context          = context;
-	srq->srq.srq_context      = attr_ex->srq_context;
-	srq->srq.pd               = attr_ex->pd;
-	srq->srq.events_completed = 0;
-	pthread_mutex_init(&srq->srq.mutex, NULL);
-	pthread_cond_init(&srq->srq.cond, NULL);
-
-	/*
-	 * check that the last field is available.
-	 * If it is than all the others exist as well
-	 */
-	if (vext_field_avail(struct verbs_srq, srq_num, vsrq_sz)) {
-		srq->srq_type = (attr_ex->comp_mask & IBV_SRQ_INIT_ATTR_TYPE) ?
-				attr_ex->srq_type : IBV_SRQT_BASIC;
-		if (srq->srq_type == IBV_SRQT_XRC)
-			srq->srq_num = resp->srqn;
-		if (attr_ex->comp_mask & IBV_SRQ_INIT_ATTR_XRCD)
-			srq->xrcd = vxrcd;
-		if (attr_ex->comp_mask & IBV_SRQ_INIT_ATTR_CQ)
-			srq->cq = attr_ex->cq;
-	}
-
-	attr_ex->attr.max_wr = resp->max_wr;
-	attr_ex->attr.max_sge = resp->max_sge;
-
-	return 0;
-}
-
-
 static int ibv_cmd_modify_srq_v3(struct ibv_srq *srq,
 				 struct ibv_srq_attr *srq_attr,
 				 int srq_attr_mask,
@@ -657,29 +543,6 @@ int ibv_cmd_query_srq(struct ibv_srq *srq, struct ibv_srq_attr *srq_attr,
 	return 0;
 }
 
-int ibv_cmd_destroy_srq(struct ibv_srq *srq)
-{
-	struct ibv_destroy_srq req;
-	struct ib_uverbs_destroy_srq_resp resp;
-	int ret;
-
-	req.core_payload = (struct ib_uverbs_destroy_srq){
-		.srq_handle = srq->handle,
-	};
-
-	ret = execute_cmd_write(srq->context, IB_USER_VERBS_CMD_DESTROY_SRQ,
-				&req, sizeof(req), &resp, sizeof(resp));
-	if (verbs_is_destroy_err(&ret))
-		return ret;
-
-	pthread_mutex_lock(&srq->mutex);
-	while (srq->events_completed != resp.events_reported)
-		pthread_cond_wait(&srq->cond, &srq->mutex);
-	pthread_mutex_unlock(&srq->mutex);
-
-	return 0;
-}
-
 static int create_qp_ex_common(struct verbs_qp *qp,
 			       struct ibv_qp_init_attr_ex *qp_attr,
 			       struct verbs_xrcd *vxrcd,
diff --git a/libibverbs/cmd_srq.c b/libibverbs/cmd_srq.c
new file mode 100644
index 0000000..4e63046
--- /dev/null
+++ b/libibverbs/cmd_srq.c
@@ -0,0 +1,279 @@
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
+#include "ibverbs.h"
+
+static void set_vsrq(struct verbs_srq *vsrq,
+		     struct ibv_srq_init_attr_ex *attr_ex,
+		     uint32_t srq_num)
+{
+	vsrq->srq_type = (attr_ex->comp_mask & IBV_SRQ_INIT_ATTR_TYPE) ?
+		attr_ex->srq_type : IBV_SRQT_BASIC;
+	if (vsrq->srq_type == IBV_SRQT_XRC) {
+		vsrq->srq_num = srq_num;
+		vsrq->xrcd = container_of(attr_ex->xrcd, struct verbs_xrcd, xrcd);
+	}
+	if (attr_ex->comp_mask & IBV_SRQ_INIT_ATTR_CQ)
+		vsrq->cq = attr_ex->cq;
+}
+
+static int ibv_icmd_create_srq(struct ibv_pd *pd, struct verbs_srq *vsrq,
+			       struct ibv_srq *srq_in,
+			       struct ibv_srq_init_attr_ex *attr_ex,
+			       struct ibv_command_buffer *link)
+{
+	DECLARE_FBCMD_BUFFER(cmdb, UVERBS_OBJECT_SRQ, UVERBS_METHOD_SRQ_CREATE, 13, link);
+	struct ib_uverbs_attr *handle;
+	uint32_t max_wr;
+	uint32_t max_sge;
+	uint32_t srq_num;
+	int ret;
+	struct ibv_srq *srq = vsrq ? &vsrq->srq : srq_in;
+	struct verbs_xrcd *vxrcd = NULL;
+	enum ibv_srq_type srq_type;
+
+	srq->context = pd->context;
+	pthread_mutex_init(&srq->mutex, NULL);
+	pthread_cond_init(&srq->cond, NULL);
+
+	srq_type = (attr_ex->comp_mask & IBV_SRQ_INIT_ATTR_TYPE) ?
+			attr_ex->srq_type : IBV_SRQT_BASIC;
+	switch (srq_type) {
+	case IBV_SRQT_XRC:
+		if (!(attr_ex->comp_mask & IBV_SRQ_INIT_ATTR_XRCD) ||
+		    !(attr_ex->comp_mask & IBV_SRQ_INIT_ATTR_CQ)) {
+			errno = EINVAL;
+			return errno;
+		}
+
+		vxrcd = container_of(attr_ex->xrcd, struct verbs_xrcd, xrcd);
+		fill_attr_in_obj(cmdb, UVERBS_ATTR_CREATE_SRQ_XRCD_HANDLE, vxrcd->handle);
+		fill_attr_in_obj(cmdb, UVERBS_ATTR_CREATE_SRQ_CQ_HANDLE, attr_ex->cq->handle);
+		fill_attr_out_ptr(cmdb, UVERBS_ATTR_CREATE_SRQ_RESP_SRQ_NUM, &srq_num);
+		break;
+	case IBV_SRQT_TM:
+		if (!(attr_ex->comp_mask & IBV_SRQ_INIT_ATTR_CQ) ||
+		    !(attr_ex->comp_mask & IBV_SRQ_INIT_ATTR_TM) ||
+		    !(attr_ex->tm_cap.max_num_tags)) {
+			errno = EINVAL;
+			return errno;
+		}
+
+		fill_attr_in_obj(cmdb, UVERBS_ATTR_CREATE_SRQ_CQ_HANDLE, attr_ex->cq->handle);
+		fill_attr_in_uint32(cmdb, UVERBS_ATTR_CREATE_SRQ_MAX_NUM_TAGS, attr_ex->tm_cap.max_num_tags);
+		break;
+	default:
+		break;
+	}
+
+	handle = fill_attr_out_obj(cmdb, UVERBS_ATTR_CREATE_SRQ_HANDLE);
+	fill_attr_const_in(cmdb, UVERBS_ATTR_CREATE_SRQ_TYPE, srq_type);
+	fill_attr_in_uint64(cmdb, UVERBS_ATTR_CREATE_SRQ_USER_HANDLE, (uintptr_t)srq);
+	fill_attr_in_obj(cmdb, UVERBS_ATTR_CREATE_SRQ_PD_HANDLE, pd->handle);
+	fill_attr_in_uint32(cmdb, UVERBS_ATTR_CREATE_SRQ_MAX_WR, attr_ex->attr.max_wr);
+	fill_attr_in_uint32(cmdb, UVERBS_ATTR_CREATE_SRQ_MAX_SGE, attr_ex->attr.max_sge);
+	fill_attr_in_uint32(cmdb, UVERBS_ATTR_CREATE_SRQ_LIMIT, attr_ex->attr.srq_limit);
+	fill_attr_in_fd(cmdb, UVERBS_ATTR_CREATE_SRQ_EVENT_FD, pd->context->async_fd);
+	fill_attr_out_ptr(cmdb, UVERBS_ATTR_CREATE_SRQ_RESP_MAX_WR, &max_wr);
+	fill_attr_out_ptr(cmdb, UVERBS_ATTR_CREATE_SRQ_RESP_MAX_SGE, &max_sge);
+
+	switch (execute_ioctl_fallback(srq->context, create_srq, cmdb, &ret)) {
+	case TRY_WRITE: {
+		if (attr_ex->srq_type == IBV_SRQT_BASIC && abi_ver > 5) {
+			DECLARE_LEGACY_UHW_BUFS(link, IB_USER_VERBS_CMD_CREATE_SRQ);
+
+			*req = (struct ib_uverbs_create_srq){
+				.pd_handle = pd->handle,
+				.user_handle = (uintptr_t)srq,
+				.max_wr = attr_ex->attr.max_wr,
+				.max_sge = attr_ex->attr.max_sge,
+				.srq_limit = attr_ex->attr.srq_limit,
+			};
+
+			ret = execute_write_bufs(
+				srq->context, IB_USER_VERBS_CMD_CREATE_SRQ, req, resp);
+			if (ret)
+				return ret;
+
+			srq->handle = resp->srq_handle;
+			attr_ex->attr.max_wr = resp->max_wr;
+			attr_ex->attr.max_sge = resp->max_sge;
+		} else if (attr_ex->srq_type == IBV_SRQT_BASIC && abi_ver <= 5) {
+			DECLARE_LEGACY_UHW_BUFS(link, IB_USER_VERBS_CMD_CREATE_SRQ_V5);
+
+			*req = (struct ib_uverbs_create_srq){
+				.pd_handle = pd->handle,
+				.user_handle = (uintptr_t)srq,
+				.max_wr = attr_ex->attr.max_wr,
+				.max_sge = attr_ex->attr.max_sge,
+				.srq_limit = attr_ex->attr.srq_limit,
+			};
+
+			ret = execute_write_bufs(
+				srq->context, IB_USER_VERBS_CMD_CREATE_SRQ_V5, req, resp);
+			if (ret)
+				return ret;
+
+			srq->handle = resp->srq_handle;
+		} else {
+			DECLARE_LEGACY_UHW_BUFS(link, IB_USER_VERBS_CMD_CREATE_XSRQ);
+
+			*req = (struct ib_uverbs_create_xsrq){
+				.pd_handle = pd->handle,
+				.user_handle = (uintptr_t)srq,
+				.max_wr = attr_ex->attr.max_wr,
+				.max_sge =  attr_ex->attr.max_sge,
+				.srq_limit = attr_ex->attr.srq_limit,
+				.srq_type = attr_ex->srq_type,
+				.cq_handle = attr_ex->cq->handle,
+			};
+
+			if (attr_ex->srq_type == IBV_SRQT_TM)
+				req->max_num_tags = attr_ex->tm_cap.max_num_tags;
+			else
+				req->xrcd_handle = vxrcd->handle;
+
+			ret = execute_write_bufs(
+				srq->context, IB_USER_VERBS_CMD_CREATE_XSRQ, req, resp);
+			if (ret)
+				return ret;
+
+			srq->handle = resp->srq_handle;
+			attr_ex->attr.max_wr = resp->max_wr;
+			attr_ex->attr.max_sge = resp->max_sge;
+			set_vsrq(vsrq, attr_ex, resp->srqn);
+		}
+
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
+	srq->handle = read_attr_obj(UVERBS_ATTR_CREATE_SRQ_HANDLE, handle);
+	attr_ex->attr.max_wr = max_wr;
+	attr_ex->attr.max_sge = max_sge;
+	if (vsrq)
+		set_vsrq(vsrq, attr_ex, srq_num);
+
+	return 0;
+}
+
+int ibv_cmd_create_srq(struct ibv_pd *pd, struct ibv_srq *srq,
+		       struct ibv_srq_init_attr *attr,
+		       struct ibv_create_srq *cmd, size_t cmd_size,
+		       struct ib_uverbs_create_srq_resp *resp, size_t resp_size)
+{
+	DECLARE_CMD_BUFFER_COMPAT(cmdb, UVERBS_OBJECT_SRQ,
+				  UVERBS_METHOD_SRQ_CREATE, cmd, cmd_size, resp,
+				  resp_size);
+
+	struct ibv_srq_init_attr_ex attr_ex = {};
+	int ret;
+
+	memcpy(&attr_ex, attr, sizeof(*attr));
+	ret = ibv_icmd_create_srq(pd, NULL, srq, &attr_ex, cmdb);
+	if (!ret) {
+		attr->attr.max_wr = attr_ex.attr.max_wr;
+		attr->attr.max_sge = attr_ex.attr.max_sge;
+	}
+
+	return ret;
+}
+
+int ibv_cmd_create_srq_ex(struct ibv_context *context,
+			  struct verbs_srq *srq,
+			  struct ibv_srq_init_attr_ex *attr_ex,
+			  struct ibv_create_xsrq *cmd, size_t cmd_size,
+			  struct ib_uverbs_create_srq_resp *resp, size_t resp_size)
+{
+	DECLARE_CMD_BUFFER_COMPAT(cmdb, UVERBS_OBJECT_SRQ,
+				  UVERBS_METHOD_SRQ_CREATE, cmd, cmd_size, resp,
+				  resp_size);
+
+	if (attr_ex->comp_mask >= IBV_SRQ_INIT_ATTR_RESERVED) {
+		errno = EOPNOTSUPP;
+		return errno;
+	}
+
+	if (!(attr_ex->comp_mask & IBV_SRQ_INIT_ATTR_PD)) {
+		errno = EINVAL;
+		return errno;
+	}
+
+	return ibv_icmd_create_srq(attr_ex->pd, srq, NULL, attr_ex, cmdb);
+}
+
+int ibv_cmd_destroy_srq(struct ibv_srq *srq)
+{
+	DECLARE_FBCMD_BUFFER(cmdb, UVERBS_OBJECT_SRQ, UVERBS_METHOD_SRQ_DESTROY, 2,
+			     NULL);
+	struct ib_uverbs_destroy_srq_resp resp;
+	int ret;
+
+	fill_attr_out_ptr(cmdb, UVERBS_ATTR_DESTROY_SRQ_RESP, &resp);
+	fill_attr_in_obj(cmdb, UVERBS_ATTR_DESTROY_SRQ_HANDLE, srq->handle);
+
+	switch (execute_ioctl_fallback(srq->context, destroy_srq, cmdb, &ret)) {
+	case TRY_WRITE: {
+		struct ibv_destroy_srq req;
+
+		req.core_payload = (struct ib_uverbs_destroy_srq){
+			.srq_handle = srq->handle,
+		};
+
+		ret = execute_cmd_write(srq->context,
+					IB_USER_VERBS_CMD_DESTROY_SRQ, &req,
+					sizeof(req), &resp, sizeof(resp));
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
+	pthread_mutex_lock(&srq->mutex);
+	while (srq->events_completed != resp.events_reported)
+		pthread_cond_wait(&srq->cond, &srq->mutex);
+	pthread_mutex_unlock(&srq->mutex);
+
+	return 0;
+}
+
diff --git a/libibverbs/driver.h b/libibverbs/driver.h
index 9cb78a5..9a6a8ae 100644
--- a/libibverbs/driver.h
+++ b/libibverbs/driver.h
@@ -503,7 +503,7 @@ int ibv_cmd_create_srq(struct ibv_pd *pd,
 		       struct ibv_create_srq *cmd, size_t cmd_size,
 		       struct ib_uverbs_create_srq_resp *resp, size_t resp_size);
 int ibv_cmd_create_srq_ex(struct ibv_context *context,
-			  struct verbs_srq *srq, int vsrq_sz,
+			  struct verbs_srq *srq,
 			  struct ibv_srq_init_attr_ex *attr_ex,
 			  struct ibv_create_xsrq *cmd, size_t cmd_size,
 			  struct ib_uverbs_create_srq_resp *resp, size_t resp_size);
diff --git a/libibverbs/kern-abi.h b/libibverbs/kern-abi.h
index dc2f33d..ef9c3f6 100644
--- a/libibverbs/kern-abi.h
+++ b/libibverbs/kern-abi.h
@@ -308,4 +308,8 @@ struct ibv_create_srq_resp_v5 {
 	__u32 srq_handle;
 };
 
+#define _STRUCT_ib_uverbs_create_srq_v5
+enum { IB_USER_VERBS_CMD_CREATE_SRQ_V5 = IB_USER_VERBS_CMD_CREATE_SRQ };
+DECLARE_CMDX(IB_USER_VERBS_CMD_CREATE_SRQ_V5, ibv_create_srq_v5, ib_uverbs_create_srq, ibv_create_srq_resp_v5);
+
 #endif /* KERN_ABI_H */
diff --git a/providers/mlx4/srq.c b/providers/mlx4/srq.c
index a02a932..987b7b7 100644
--- a/providers/mlx4/srq.c
+++ b/providers/mlx4/srq.c
@@ -267,7 +267,6 @@ struct ibv_srq *mlx4_create_xrc_srq(struct ibv_context *context,
 	cmd.db_addr  = (uintptr_t) srq->db;
 
 	ret = ibv_cmd_create_srq_ex(context, &srq->verbs_srq,
-				    sizeof(srq->verbs_srq),
 				    attr_ex,
 				    &cmd.ibv_cmd, sizeof cmd,
 				    &resp.ibv_resp, sizeof resp);
diff --git a/providers/mlx5/verbs.c b/providers/mlx5/verbs.c
index 1835e93..830c5b1 100644
--- a/providers/mlx5/verbs.c
+++ b/providers/mlx5/verbs.c
@@ -3160,7 +3160,7 @@ struct ibv_srq *mlx5_create_srq_ex(struct ibv_context *context,
 	 */
 	attr->attr.max_wr = msrq->max - 1;
 
-	err = ibv_cmd_create_srq_ex(context, &msrq->vsrq, sizeof(msrq->vsrq),
+	err = ibv_cmd_create_srq_ex(context, &msrq->vsrq,
 				    attr, &cmd.ibv_cmd, sizeof(cmd),
 				    &resp.ibv_resp, sizeof(resp));
 
-- 
1.8.3.1

