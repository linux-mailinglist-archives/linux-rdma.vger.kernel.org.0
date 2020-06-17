Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7EE91FC7CF
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 09:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgFQHqc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 03:46:32 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:37708 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726303AbgFQHqb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jun 2020 03:46:31 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with SMTP; 17 Jun 2020 10:46:29 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 05H7kTbD017644;
        Wed, 17 Jun 2020 10:46:29 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 05H7kTVo007181;
        Wed, 17 Jun 2020 10:46:29 +0300
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 05H7kTYa007180;
        Wed, 17 Jun 2020 10:46:29 +0300
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, yishaih@mellanox.com, maorg@mellanox.com
Subject: [PATCH rdma-core 06/13] mlx5: Implement the import device functionality
Date:   Wed, 17 Jun 2020 10:45:49 +0300
Message-Id: <1592379956-7043-7-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
References: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Implement the import device functionality by using the query context
KABI to retrieve the original user context properties.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 libibverbs/cmd_device.c      | 27 ++++++++++++++++++++++++++
 libibverbs/driver.h          |  2 ++
 libibverbs/libibverbs.map.in |  1 +
 providers/mlx5/mlx5.c        | 45 ++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/libibverbs/cmd_device.c b/libibverbs/cmd_device.c
index 648cc0b..a55fb10 100644
--- a/libibverbs/cmd_device.c
+++ b/libibverbs/cmd_device.c
@@ -175,3 +175,30 @@ int ibv_cmd_get_context(struct verbs_context *context_ex,
 
 	return cmd_get_context(context_ex, cmdb);
 }
+
+int ibv_cmd_query_context(struct ibv_context *context,
+			  struct ibv_command_buffer *driver)
+{
+	DECLARE_COMMAND_BUFFER_LINK(cmd, UVERBS_OBJECT_DEVICE,
+				    UVERBS_METHOD_QUERY_CONTEXT,
+				    2,
+				    driver);
+
+	struct verbs_device *verbs_device;
+	uint64_t core_support;
+	int ret;
+
+	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_CONTEXT_NUM_COMP_VECTORS,
+			  &context->num_comp_vectors);
+	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_CONTEXT_CORE_SUPPORT,
+			  &core_support);
+
+	ret = execute_ioctl(context, cmd);
+	if (ret)
+		return ret;
+
+	verbs_device = verbs_get_device(context->device);
+	verbs_device->core_support = core_support;
+
+	return 0;
+}
diff --git a/libibverbs/driver.h b/libibverbs/driver.h
index 98a1b24..1883df3 100644
--- a/libibverbs/driver.h
+++ b/libibverbs/driver.h
@@ -424,6 +424,8 @@ struct ibv_context *verbs_open_device(struct ibv_device *device,
 int ibv_cmd_get_context(struct verbs_context *context,
 			struct ibv_get_context *cmd, size_t cmd_size,
 			struct ib_uverbs_get_context_resp *resp, size_t resp_size);
+int ibv_cmd_query_context(struct ibv_context *ctx,
+			  struct ibv_command_buffer *driver);
 int ibv_cmd_query_device(struct ibv_context *context,
 			 struct ibv_device_attr *device_attr,
 			 uint64_t *raw_fw_ver,
diff --git a/libibverbs/libibverbs.map.in b/libibverbs/libibverbs.map.in
index a60991e..a17e6ad 100644
--- a/libibverbs/libibverbs.map.in
+++ b/libibverbs/libibverbs.map.in
@@ -190,6 +190,7 @@ IBVERBS_PRIVATE_@IBVERBS_PABI_VERSION@ {
 		ibv_cmd_post_recv;
 		ibv_cmd_post_send;
 		ibv_cmd_post_srq_recv;
+		ibv_cmd_query_context;
 		ibv_cmd_query_device;
 		ibv_cmd_query_device_ex;
 		ibv_cmd_query_port;
diff --git a/providers/mlx5/mlx5.c b/providers/mlx5/mlx5.c
index e5ed17e..dbd86c0 100644
--- a/providers/mlx5/mlx5.c
+++ b/providers/mlx5/mlx5.c
@@ -43,6 +43,7 @@
 #include <sys/param.h>
 
 #include <util/symver.h>
+#include <rdma/mlx5_user_ioctl_cmds.h>
 
 #include "mlx5.h"
 #include "mlx5-abi.h"
@@ -1369,7 +1370,8 @@ static struct mlx5_context *mlx5_init_context(struct ibv_device *ibdev,
 }
 
 static int mlx5_set_context(struct mlx5_context *context,
-			    struct mlx5_ib_alloc_ucontext_resp *resp)
+			    struct mlx5_ib_alloc_ucontext_resp *resp,
+			    bool is_import)
 {
 	struct verbs_context *v_ctx = &context->ibv_ctx;
 	struct ibv_port_attr port_attr = {};
@@ -1440,6 +1442,10 @@ static int mlx5_set_context(struct mlx5_context *context,
 	context->shut_up_bf = get_shut_up_bf();
 
 	if (resp->tot_bfregs) {
+		if (is_import) {
+			errno = EINVAL;
+			return EINVAL;
+		}
 		context->tot_uuars = resp->tot_bfregs;
 		gross_uuars = context->tot_uuars / MLX5_NUM_NON_FP_BFREGS_PER_UAR * NUM_BFREGS_PER_UAR;
 		context->bfs = calloc(gross_uuars, sizeof(*context->bfs));
@@ -1593,7 +1599,7 @@ retry_open:
 		}
 	}
 
-	ret = mlx5_set_context(context, &resp.drv_payload);
+	ret = mlx5_set_context(context, &resp.drv_payload, false);
 	if (ret)
 		goto err;
 
@@ -1604,6 +1610,40 @@ err:
 	return NULL;
 }
 
+static struct verbs_context *mlx5_import_context(struct ibv_device *ibdev,
+						int cmd_fd)
+
+{
+	struct mlx5_ib_alloc_ucontext_resp resp = {};
+	DECLARE_COMMAND_BUFFER_LINK(driver_attr, UVERBS_OBJECT_DEVICE,
+				    UVERBS_METHOD_QUERY_CONTEXT, 1,
+				    NULL);
+	struct ibv_context *context;
+	struct mlx5_context *mctx;
+	int ret;
+
+	mctx = mlx5_init_context(ibdev, cmd_fd, NULL);
+	if (!mctx)
+		return NULL;
+
+	context = &mctx->ibv_ctx.context;
+
+	fill_attr_out_ptr(driver_attr, MLX5_IB_ATTR_QUERY_CONTEXT_RESP_UCTX, &resp);
+	ret = ibv_cmd_query_context(context, driver_attr);
+	if (ret)
+		goto err;
+
+	ret = mlx5_set_context(mctx, &resp, true);
+	if (ret)
+		goto err;
+
+	return &mctx->ibv_ctx;
+
+err:
+	mlx5_uninit_context(mctx);
+	return NULL;
+}
+
 static void mlx5_free_context(struct ibv_context *ibctx)
 {
 	struct mlx5_context *context = to_mctx(ibctx);
@@ -1656,6 +1696,7 @@ static const struct verbs_device_ops mlx5_dev_ops = {
 	.alloc_device = mlx5_device_alloc,
 	.uninit_device = mlx5_uninit_device,
 	.alloc_context = mlx5_alloc_context,
+	.import_context = mlx5_import_context,
 };
 
 bool is_mlx5_dev(struct ibv_device *device)
-- 
1.8.3.1

