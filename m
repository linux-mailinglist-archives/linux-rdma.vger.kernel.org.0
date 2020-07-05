Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7E4214B2B
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2020 10:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgGEI05 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Jul 2020 04:26:57 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:34045 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726280AbgGEI05 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Jul 2020 04:26:57 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with SMTP; 5 Jul 2020 11:20:05 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0658K5bW001688;
        Sun, 5 Jul 2020 11:20:05 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 0658K53m009291;
        Sun, 5 Jul 2020 11:20:05 +0300
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 0658K5UC009288;
        Sun, 5 Jul 2020 11:20:05 +0300
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, yishaih@mellanox.com, maorg@mellanox.com
Subject: [PATCH V1 rdma-core 05/13] mlx5: Refactor mlx5_alloc_context()
Date:   Sun,  5 Jul 2020 11:19:41 +0300
Message-Id: <1593937189-8744-6-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1593937189-8744-1-git-send-email-yishaih@mellanox.com>
References: <1593937189-8744-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch refactors mlx5_alloc_context() by splitting its functionality
to few parts, init context, get context command, set context, uninit
context.

As part of splitting, cleaned up some redundant outlen checks.

The above is some preparation step to enable implementing
mlx5_import_context() by sharing the applicable parts.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 providers/mlx5/mlx5.c | 274 ++++++++++++++++++++++++++++----------------------
 1 file changed, 154 insertions(+), 120 deletions(-)

diff --git a/providers/mlx5/mlx5.c b/providers/mlx5/mlx5.c
index 805be2c..cb9ed60 100644
--- a/providers/mlx5/mlx5.c
+++ b/providers/mlx5/mlx5.c
@@ -1268,17 +1268,17 @@ repeat:
 
 static void adjust_uar_info(struct mlx5_device *mdev,
 			    struct mlx5_context *context,
-			    struct mlx5_alloc_ucontext_resp resp)
+			    struct mlx5_ib_alloc_ucontext_resp *resp)
 {
-	if (!resp.log_uar_size && !resp.num_uars_per_page) {
+	if (!resp->log_uar_size && !resp->num_uars_per_page) {
 		/* old kernel */
 		context->uar_size = mdev->page_size;
 		context->num_uars_per_page = 1;
 		return;
 	}
 
-	context->uar_size = 1 << resp.log_uar_size;
-	context->num_uars_per_page = resp.num_uars_per_page;
+	context->uar_size = 1 << resp->log_uar_size;
+	context->num_uars_per_page = resp->num_uars_per_page;
 }
 
 bool mlx5dv_is_supported(struct ibv_device *device)
@@ -1297,120 +1297,108 @@ mlx5dv_open_device(struct ibv_device *device, struct mlx5dv_context_attr *attr)
 	return verbs_open_device(device, attr);
 }
 
-static struct verbs_context *mlx5_alloc_context(struct ibv_device *ibdev,
+static int get_uar_info(struct mlx5_device *mdev,
+			int *tot_uuars, int *low_lat_uuars)
+{
+	*tot_uuars = get_total_uuars(mdev->page_size);
+	if (*tot_uuars < 0) {
+		errno = -*tot_uuars;
+		return -1;
+	}
+
+	*low_lat_uuars = get_num_low_lat_uuars(*tot_uuars);
+	if (*low_lat_uuars < 0) {
+		errno = -*low_lat_uuars;
+		return -1;
+	}
+
+	if (*low_lat_uuars > *tot_uuars - 1) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	return 0;
+}
+
+static void mlx5_uninit_context(struct mlx5_context *context)
+{
+	close_debug_file(context);
+
+	verbs_uninit_context(&context->ibv_ctx);
+	free(context);
+}
+
+static struct mlx5_context *mlx5_init_context(struct ibv_device *ibdev,
 						int cmd_fd,
 						void *private_data)
 {
-	struct mlx5_context	       *context;
-	struct mlx5_alloc_ucontext	req;
-	struct mlx5_alloc_ucontext_resp resp;
-	int				i;
-	int				page_size;
-	int				tot_uuars;
-	int				low_lat_uuars;
-	int				gross_uuars;
-	int				j;
-	struct mlx5_device	       *mdev = to_mdev(ibdev);
-	struct verbs_context	       *v_ctx;
-	struct ibv_port_attr		port_attr;
-	struct ibv_device_attr_ex	device_attr;
-	int				k;
-	int				bfi;
-	int				num_sys_page_map;
-	struct mlx5dv_context_attr      *ctx_attr = private_data;
-	bool				always_devx = false;
+	struct mlx5dv_context_attr *ctx_attr = private_data;
+	struct mlx5_device *mdev = to_mdev(ibdev);
+	struct mlx5_context *context;
+	int low_lat_uuars;
+	int tot_uuars;
+	int ret;
 
 	if (ctx_attr && ctx_attr->comp_mask) {
 		errno = EINVAL;
 		return NULL;
 	}
 
+	ret = get_uar_info(mdev, &tot_uuars, &low_lat_uuars);
+	if (ret)
+		return NULL;
+
 	context = verbs_init_and_alloc_context(ibdev, cmd_fd, context, ibv_ctx,
 					       RDMA_DRIVER_MLX5);
 	if (!context)
 		return NULL;
 
-	v_ctx = &context->ibv_ctx;
-	page_size = mdev->page_size;
-	mlx5_single_threaded = single_threaded_app();
-
 	open_debug_file(context);
 	set_debug_mask();
 	set_freeze_on_error();
 	if (gethostname(context->hostname, sizeof(context->hostname)))
 		strcpy(context->hostname, "host_unknown");
 
-	tot_uuars = get_total_uuars(page_size);
-	if (tot_uuars < 0) {
-		errno = -tot_uuars;
-		goto err_free;
-	}
-
-	low_lat_uuars = get_num_low_lat_uuars(tot_uuars);
-	if (low_lat_uuars < 0) {
-		errno = -low_lat_uuars;
-		goto err_free;
-	}
-
-	if (low_lat_uuars > tot_uuars - 1) {
-		errno = ENOMEM;
-		goto err_free;
-	}
-
-	memset(&req, 0, sizeof(req));
-	memset(&resp, 0, sizeof(resp));
-
-	req.total_num_bfregs = tot_uuars;
-	req.num_low_latency_bfregs = low_lat_uuars;
-	req.max_cqe_version = MLX5_CQE_VERSION_V1;
-	req.lib_caps |= (MLX5_LIB_CAP_4K_UAR | MLX5_LIB_CAP_DYN_UAR);
-	if (ctx_attr && ctx_attr->flags) {
-
-		if (!check_comp_mask(ctx_attr->flags,
-				     MLX5DV_CONTEXT_FLAGS_DEVX)) {
-			errno = EINVAL;
-			goto err_free;
-		}
-
-		req.flags = MLX5_IB_ALLOC_UCTX_DEVX;
-	} else {
-		req.flags = MLX5_IB_ALLOC_UCTX_DEVX;
-		always_devx = true;
-	}
+	mlx5_single_threaded = single_threaded_app();
+	context->tot_uuars = tot_uuars;
+	context->low_lat_uuars = low_lat_uuars;
 
-retry_open:
-	if (mlx5_cmd_get_context(context, &req, sizeof(req), &resp,
-				 sizeof(resp))) {
-		if (always_devx) {
-			req.flags &= ~MLX5_IB_ALLOC_UCTX_DEVX;
-			always_devx = false;
-			memset(&resp, 0, sizeof(resp));
-			goto retry_open;
-		} else {
-			goto err_free;
-		}
-	}
+	return context;
+}
 
-	context->max_num_qps		= resp.qp_tab_size;
-	context->bf_reg_size		= resp.bf_reg_size;
-	context->tot_uuars		= resp.tot_bfregs;
-	context->low_lat_uuars		= low_lat_uuars;
-	context->cache_line_size	= resp.cache_line_size;
-	context->max_sq_desc_sz = resp.max_sq_desc_sz;
-	context->max_rq_desc_sz = resp.max_rq_desc_sz;
-	context->max_send_wqebb	= resp.max_send_wqebb;
-	context->num_ports	= resp.num_ports;
-	context->max_recv_wr	= resp.max_recv_wr;
-	context->max_srq_recv_wr = resp.max_srq_recv_wr;
-	context->num_dyn_bfregs = resp.num_dyn_bfregs;
-
-	if (resp.comp_mask & MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_ECE)
+static int mlx5_set_context(struct mlx5_context *context,
+			    struct mlx5_ib_alloc_ucontext_resp *resp)
+{
+	struct verbs_context *v_ctx = &context->ibv_ctx;
+	struct ibv_port_attr port_attr = {};
+	struct ibv_device_attr_ex device_attr = {};
+	int cmd_fd = v_ctx->context.cmd_fd;
+	struct mlx5_device *mdev = to_mdev(v_ctx->context.device);
+	struct ibv_device *ibdev = v_ctx->context.device;
+	int page_size = mdev->page_size;
+	int num_sys_page_map;
+	int gross_uuars;
+	int bfi;
+	int i, k, j;
+
+	context->max_num_qps = resp->qp_tab_size;
+	context->bf_reg_size = resp->bf_reg_size;
+	context->cache_line_size = resp->cache_line_size;
+	context->max_sq_desc_sz = resp->max_sq_desc_sz;
+	context->max_rq_desc_sz = resp->max_rq_desc_sz;
+	context->max_send_wqebb	= resp->max_send_wqebb;
+	context->num_ports = resp->num_ports;
+	context->max_recv_wr = resp->max_recv_wr;
+	context->max_srq_recv_wr = resp->max_srq_recv_wr;
+	context->num_dyn_bfregs = resp->num_dyn_bfregs;
+
+	if (resp->comp_mask & MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_ECE)
 		context->flags |= MLX5_CTX_FLAGS_ECE_SUPPORTED;
 
-	if (resp.comp_mask & MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_DUMP_FILL_MKEY) {
-		context->dump_fill_mkey = resp.dump_fill_mkey;
+	if (resp->comp_mask & MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_DUMP_FILL_MKEY) {
+		context->dump_fill_mkey = resp->dump_fill_mkey;
 		/* Have the BE value ready to be used in data path */
-		context->dump_fill_mkey_be = htobe32(resp.dump_fill_mkey);
+		context->dump_fill_mkey_be = htobe32(resp->dump_fill_mkey);
 	} else {
 		/* kernel driver will never return MLX5_INVALID_LKEY for
 		 * dump_fill_mkey
@@ -1419,19 +1407,18 @@ retry_open:
 		context->dump_fill_mkey_be = htobe32(MLX5_INVALID_LKEY);
 	}
 
-	context->cqe_version = resp.cqe_version;
-
+	context->cqe_version = resp->cqe_version;
 	adjust_uar_info(mdev, context, resp);
 
-	context->cmds_supp_uhw = resp.cmds_supp_uhw;
+	context->cmds_supp_uhw = resp->cmds_supp_uhw;
 	context->vendor_cap_flags = 0;
 	list_head_init(&context->dyn_uar_bf_list);
 	list_head_init(&context->dyn_uar_nc_list);
 	list_head_init(&context->dyn_uar_qp_shared_list);
 	list_head_init(&context->dyn_uar_qp_dedicated_list);
 
-	if (resp.eth_min_inline)
-		context->eth_min_inline_size = (resp.eth_min_inline == MLX5_USER_INLINE_MODE_NONE) ?
+	if (resp->eth_min_inline)
+		context->eth_min_inline_size = (resp->eth_min_inline == MLX5_USER_INLINE_MODE_NONE) ?
 						0 : MLX5_ETH_L2_INLINE_HEADER_SIZE;
 	else
 		context->eth_min_inline_size = MLX5_ETH_L2_INLINE_HEADER_SIZE;
@@ -1453,7 +1440,8 @@ retry_open:
 	context->prefer_bf = get_always_bf();
 	context->shut_up_bf = get_shut_up_bf();
 
-	if (context->tot_uuars) {
+	if (resp->tot_bfregs) {
+		context->tot_uuars = resp->tot_bfregs;
 		gross_uuars = context->tot_uuars / MLX5_NUM_NON_FP_BFREGS_PER_UAR * NUM_BFREGS_PER_UAR;
 		context->bfs = calloc(gross_uuars, sizeof(*context->bfs));
 		if (!context->bfs) {
@@ -1462,8 +1450,8 @@ retry_open:
 		}
 		context->flags |= MLX5_CTX_FLAGS_NO_KERN_DYN_UAR;
 	} else {
-		context->qp_max_dedicated_uuars = low_lat_uuars;
-		context->qp_max_shared_uuars = tot_uuars - low_lat_uuars;
+		context->qp_max_dedicated_uuars = context->low_lat_uuars;
+		context->qp_max_shared_uuars = context->tot_uuars - context->low_lat_uuars;
 		goto bf_done;
 	}
 
@@ -1491,9 +1479,9 @@ retry_open:
 				if (bfi)
 					context->bfs[bfi].buf_size = context->bf_reg_size / 2;
 				context->bfs[bfi].uuarn = bfi;
-				context->bfs[bfi].uar_mmap_offset = get_uar_mmap_offset(i,
-											page_size,
-											uar_type_to_cmd(context->uar[i].type));
+				context->bfs[bfi].uar_mmap_offset =
+					get_uar_mmap_offset(i, page_size,
+							uar_type_to_cmd(context->uar[i].type));
 			}
 		}
 	}
@@ -1501,23 +1489,16 @@ retry_open:
 bf_done:
 
 	context->hca_core_clock = NULL;
-	if (resp.response_length + sizeof(resp.ibv_resp) >=
-	    offsetof(struct mlx5_alloc_ucontext_resp, hca_core_clock_offset) +
-	    sizeof(resp.hca_core_clock_offset) &&
-	    resp.comp_mask & MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_CORE_CLOCK_OFFSET) {
-		context->core_clock.offset = resp.hca_core_clock_offset;
+	if (resp->comp_mask & MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_CORE_CLOCK_OFFSET) {
+		context->core_clock.offset = resp->hca_core_clock_offset;
 		mlx5_map_internal_clock(mdev, &v_ctx->context);
 	}
 
 	context->clock_info_page = NULL;
-	if (resp.response_length + sizeof(resp.ibv_resp) >=
-	    offsetof(struct mlx5_alloc_ucontext_resp, clock_info_versions) +
-	    sizeof(resp.clock_info_versions) &&
-	    (resp.clock_info_versions & (1 << MLX5_IB_CLOCK_INFO_V1))) {
+	if ((resp->clock_info_versions & (1 << MLX5_IB_CLOCK_INFO_V1)))
 		mlx5_map_clock_info(mdev, &v_ctx->context);
-	}
 
-	context->flow_action_flags = resp.flow_action_flags;
+	context->flow_action_flags = resp->flow_action_flags;
 
 	mlx5_read_env(ibdev, context);
 
@@ -1532,7 +1513,6 @@ bf_done:
 			goto err_free;
 	}
 
-	memset(&device_attr, 0, sizeof(device_attr));
 	if (!mlx5_query_device_ex(&v_ctx->context, NULL, &device_attr,
 				  sizeof(struct ibv_device_attr_ex))) {
 		context->cached_device_cap_flags =
@@ -1554,7 +1534,7 @@ bf_done:
 						    MLX5_IB_UAPI_UAR_ALLOC_TYPE_NC);
 	context->cq_uar_reg = context->cq_uar ? context->cq_uar->uar : context->uar[0].reg;
 
-	return v_ctx;
+	return 0;
 
 err_free_bf:
 	free(context->bfs);
@@ -1564,10 +1544,64 @@ err_free:
 		if (context->uar[i].reg)
 			munmap(context->uar[i].reg, page_size);
 	}
-	close_debug_file(context);
 
-	verbs_uninit_context(&context->ibv_ctx);
-	free(context);
+	return -1;
+}
+
+static struct verbs_context *mlx5_alloc_context(struct ibv_device *ibdev,
+						int cmd_fd,
+						void *private_data)
+{
+	struct mlx5_context	       *context;
+	struct mlx5_alloc_ucontext	req = {};
+	struct mlx5_alloc_ucontext_resp resp = {};
+	struct mlx5dv_context_attr      *ctx_attr = private_data;
+	bool				always_devx = false;
+	int ret;
+
+	context = mlx5_init_context(ibdev, cmd_fd, NULL);
+	if (!context)
+		return NULL;
+
+	req.total_num_bfregs = context->tot_uuars;
+	req.num_low_latency_bfregs = context->low_lat_uuars;
+	req.max_cqe_version = MLX5_CQE_VERSION_V1;
+	req.lib_caps |= (MLX5_LIB_CAP_4K_UAR | MLX5_LIB_CAP_DYN_UAR);
+	if (ctx_attr && ctx_attr->flags) {
+
+		if (!check_comp_mask(ctx_attr->flags,
+				     MLX5DV_CONTEXT_FLAGS_DEVX)) {
+			errno = EINVAL;
+			goto err;
+		}
+
+		req.flags = MLX5_IB_ALLOC_UCTX_DEVX;
+	} else {
+		req.flags = MLX5_IB_ALLOC_UCTX_DEVX;
+		always_devx = true;
+	}
+
+retry_open:
+	if (mlx5_cmd_get_context(context, &req, sizeof(req), &resp,
+				 sizeof(resp))) {
+		if (always_devx) {
+			req.flags &= ~MLX5_IB_ALLOC_UCTX_DEVX;
+			always_devx = false;
+			memset(&resp, 0, sizeof(resp));
+			goto retry_open;
+		} else {
+			goto err;
+		}
+	}
+
+	ret = mlx5_set_context(context, &resp.drv_payload);
+	if (ret)
+		goto err;
+
+	return &context->ibv_ctx;
+
+err:
+	mlx5_uninit_context(context);
 	return NULL;
 }
 
-- 
1.8.3.1

