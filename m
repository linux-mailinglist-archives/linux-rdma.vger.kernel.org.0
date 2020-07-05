Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEB5214B25
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2020 10:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgGEIUP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Jul 2020 04:20:15 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33111 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726491AbgGEIUM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Jul 2020 04:20:12 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with SMTP; 5 Jul 2020 11:20:05 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0658K5D1001673;
        Sun, 5 Jul 2020 11:20:05 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 0658K5QD009278;
        Sun, 5 Jul 2020 11:20:05 +0300
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 0658K52f009276;
        Sun, 5 Jul 2020 11:20:05 +0300
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, yishaih@mellanox.com, maorg@mellanox.com
Subject: [PATCH V1 rdma-core 03/13] verbs: Enhance async FD usage
Date:   Sun,  5 Jul 2020 11:19:39 +0300
Message-Id: <1593937189-8744-4-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1593937189-8744-1-git-send-email-yishaih@mellanox.com>
References: <1593937189-8744-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Enhance async FD usage by adding an option to enforce it be a mandatory
attribute in a given device once the applicable objects are created
(e.g.QP, CQ, etc.).

This is some preparation step before introducing in the next patch the
ibv_import_device() verb which must use its own async FD to be able to
get events on its private created objects.

In addition, we moved ibv_cmd_alloc_async_fd() to be called as part of
ibv_open_device() in case wasn't allocated yet (i.e. ioctl flow), this
will be aligned with the import device flow that will be introduced.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 libibverbs/cmd_cq.c     | 9 +++++++--
 libibverbs/cmd_device.c | 5 +----
 libibverbs/cmd_qp.c     | 4 ++++
 libibverbs/cmd_srq.c    | 4 ++++
 libibverbs/cmd_wq.c     | 4 ++++
 libibverbs/device.c     | 8 ++++++++
 libibverbs/driver.h     | 1 +
 libibverbs/ibverbs.h    | 1 +
 8 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/libibverbs/cmd_cq.c b/libibverbs/cmd_cq.c
index ec6f0e6..e8113d4 100644
--- a/libibverbs/cmd_cq.c
+++ b/libibverbs/cmd_cq.c
@@ -31,6 +31,7 @@
  */
 
 #include <infiniband/cmd_write.h>
+#include "ibverbs.h"
 
 static int ibv_icmd_create_cq(struct ibv_context *context, int cqe,
 			      struct ibv_comp_channel *channel, int comp_vector,
@@ -38,6 +39,7 @@ static int ibv_icmd_create_cq(struct ibv_context *context, int cqe,
 			      struct ibv_command_buffer *link)
 {
 	DECLARE_FBCMD_BUFFER(cmdb, UVERBS_OBJECT_CQ, UVERBS_METHOD_CQ_CREATE, 8, link);
+	struct verbs_ex_private *priv = get_priv(context);
 	struct ib_uverbs_attr *handle;
 	struct ib_uverbs_attr *async_fd_attr;
 	uint32_t resp_cqe;
@@ -54,8 +56,11 @@ static int ibv_icmd_create_cq(struct ibv_context *context, int cqe,
 		fill_attr_in_fd(cmdb, UVERBS_ATTR_CREATE_CQ_COMP_CHANNEL, channel->fd);
 	fill_attr_in_uint32(cmdb, UVERBS_ATTR_CREATE_CQ_COMP_VECTOR, comp_vector);
 	async_fd_attr = fill_attr_in_fd(cmdb, UVERBS_ATTR_CREATE_CQ_EVENT_FD, context->async_fd);
-	/* Prevent fallback to the 'write' mode if kernel doesn't support it */
-	attr_optional(async_fd_attr);
+	if (priv->imported)
+		fallback_require_ioctl(cmdb);
+	else
+		/* Prevent fallback to the 'write' mode if kernel doesn't support it */
+		attr_optional(async_fd_attr);
 
 	if (flags) {
 		fallback_require_ex(cmdb);
diff --git a/libibverbs/cmd_device.c b/libibverbs/cmd_device.c
index 4de59c0..648cc0b 100644
--- a/libibverbs/cmd_device.c
+++ b/libibverbs/cmd_device.c
@@ -99,7 +99,7 @@ int ibv_cmd_query_port(struct ibv_context *context, uint8_t port_num,
 	return 0;
 }
 
-static int cmd_alloc_async_fd(struct ibv_context *context)
+int ibv_cmd_alloc_async_fd(struct ibv_context *context)
 {
 	DECLARE_COMMAND_BUFFER(cmdb, UVERBS_OBJECT_ASYNC_EVENT,
 			       UVERBS_METHOD_ASYNC_EVENT_ALLOC, 1);
@@ -153,9 +153,6 @@ static int cmd_get_context(struct verbs_context *context_ex,
 		return 0;
 	}
 	case SUCCESS:
-		ret = cmd_alloc_async_fd(context);
-		if (ret)
-			return ret;
 		break;
 	default:
 		return ret;
diff --git a/libibverbs/cmd_qp.c b/libibverbs/cmd_qp.c
index a11bb98..567984d 100644
--- a/libibverbs/cmd_qp.c
+++ b/libibverbs/cmd_qp.c
@@ -76,6 +76,7 @@ static int ibv_icmd_create_qp(struct ibv_context *context,
 			      struct ibv_command_buffer *link)
 {
 	DECLARE_FBCMD_BUFFER(cmdb, UVERBS_OBJECT_QP, UVERBS_METHOD_QP_CREATE, 15, link);
+	struct verbs_ex_private *priv = get_priv(context);
 	struct ib_uverbs_attr *handle;
 	uint32_t qp_num;
 	uint32_t pd_handle;
@@ -172,6 +173,9 @@ static int ibv_icmd_create_qp(struct ibv_context *context,
 	fill_attr_in_ptr(cmdb, UVERBS_ATTR_CREATE_QP_CAP, &attr_ex->cap);
 	fill_attr_in_fd(cmdb, UVERBS_ATTR_CREATE_QP_EVENT_FD, context->async_fd);
 
+	if (priv->imported)
+		fallback_require_ioctl(cmdb);
+
 	if (attr_ex->sq_sig_all)
 		create_flags |= IB_UVERBS_QP_CREATE_SQ_SIG_ALL;
 
diff --git a/libibverbs/cmd_srq.c b/libibverbs/cmd_srq.c
index 4e63046..dfaaa6a 100644
--- a/libibverbs/cmd_srq.c
+++ b/libibverbs/cmd_srq.c
@@ -53,6 +53,7 @@ static int ibv_icmd_create_srq(struct ibv_pd *pd, struct verbs_srq *vsrq,
 			       struct ibv_command_buffer *link)
 {
 	DECLARE_FBCMD_BUFFER(cmdb, UVERBS_OBJECT_SRQ, UVERBS_METHOD_SRQ_CREATE, 13, link);
+	struct verbs_ex_private *priv = get_priv(pd->context);
 	struct ib_uverbs_attr *handle;
 	uint32_t max_wr;
 	uint32_t max_sge;
@@ -107,6 +108,9 @@ static int ibv_icmd_create_srq(struct ibv_pd *pd, struct verbs_srq *vsrq,
 	fill_attr_out_ptr(cmdb, UVERBS_ATTR_CREATE_SRQ_RESP_MAX_WR, &max_wr);
 	fill_attr_out_ptr(cmdb, UVERBS_ATTR_CREATE_SRQ_RESP_MAX_SGE, &max_sge);
 
+	if (priv->imported)
+		fallback_require_ioctl(cmdb);
+
 	switch (execute_ioctl_fallback(srq->context, create_srq, cmdb, &ret)) {
 	case TRY_WRITE: {
 		if (attr_ex->srq_type == IBV_SRQT_BASIC && abi_ver > 5) {
diff --git a/libibverbs/cmd_wq.c b/libibverbs/cmd_wq.c
index d233c3a..855fc04 100644
--- a/libibverbs/cmd_wq.c
+++ b/libibverbs/cmd_wq.c
@@ -31,6 +31,7 @@
  */
 
 #include <infiniband/cmd_write.h>
+#include "ibverbs.h"
 
 static int ibv_icmd_create_wq(struct ibv_context *context,
 			      struct ibv_wq_init_attr *wq_init_attr,
@@ -38,6 +39,7 @@ static int ibv_icmd_create_wq(struct ibv_context *context,
 			      struct ibv_command_buffer *link)
 {
 	DECLARE_FBCMD_BUFFER(cmdb, UVERBS_OBJECT_WQ, UVERBS_METHOD_WQ_CREATE, 13, link);
+	struct verbs_ex_private *priv = get_priv(context);
 	struct ib_uverbs_attr *handle;
 	uint32_t max_wr;
 	uint32_t max_sge;
@@ -62,6 +64,8 @@ static int ibv_icmd_create_wq(struct ibv_context *context,
 	fill_attr_out_ptr(cmdb, UVERBS_ATTR_CREATE_WQ_RESP_MAX_SGE, &max_sge);
 	fill_attr_out_ptr(cmdb, UVERBS_ATTR_CREATE_WQ_RESP_WQ_NUM, &wq_num);
 
+	if (priv->imported)
+		fallback_require_ioctl(cmdb);
 	fallback_require_ex(cmdb);
 
 	switch (execute_ioctl_fallback(context, create_wq, cmdb, &ret)) {
diff --git a/libibverbs/device.c b/libibverbs/device.c
index 629832e..4ef2a6a 100644
--- a/libibverbs/device.c
+++ b/libibverbs/device.c
@@ -344,6 +344,7 @@ struct ibv_context *verbs_open_device(struct ibv_device *device, void *private_d
 	struct verbs_device *verbs_device = verbs_get_device(device);
 	int cmd_fd;
 	struct verbs_context *context_ex;
+	int ret;
 
 	/*
 	 * We'll only be doing writes, but we need O_RDWR in case the
@@ -363,6 +364,13 @@ struct ibv_context *verbs_open_device(struct ibv_device *device, void *private_d
 		return NULL;
 
 	set_lib_ops(context_ex);
+	if (context_ex->context.async_fd == -1) {
+		ret = ibv_cmd_alloc_async_fd(&context_ex->context);
+		if (ret) {
+			ibv_close_device(&context_ex->context);
+			return NULL;
+		}
+	}
 
 	return &context_ex->context;
 }
diff --git a/libibverbs/driver.h b/libibverbs/driver.h
index 9f9933d..a1b241b 100644
--- a/libibverbs/driver.h
+++ b/libibverbs/driver.h
@@ -453,6 +453,7 @@ int ibv_cmd_query_device_ex(struct ibv_context *context,
 int ibv_cmd_query_port(struct ibv_context *context, uint8_t port_num,
 		       struct ibv_port_attr *port_attr,
 		       struct ibv_query_port *cmd, size_t cmd_size);
+int ibv_cmd_alloc_async_fd(struct ibv_context *context);
 int ibv_cmd_alloc_pd(struct ibv_context *context, struct ibv_pd *pd,
 		     struct ibv_alloc_pd *cmd, size_t cmd_size,
 		     struct ib_uverbs_alloc_pd_resp *resp, size_t resp_size);
diff --git a/libibverbs/ibverbs.h b/libibverbs/ibverbs.h
index 4b9b88f..6703c10 100644
--- a/libibverbs/ibverbs.h
+++ b/libibverbs/ibverbs.h
@@ -74,6 +74,7 @@ struct verbs_ex_private {
 	uint32_t driver_id;
 	bool use_ioctl_write;
 	struct verbs_context_ops ops;
+	bool imported;
 };
 
 static inline struct verbs_ex_private *get_priv(struct ibv_context *ctx)
-- 
1.8.3.1

