Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527FC3D706C
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 09:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbhG0HcE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 03:32:04 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:12318 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbhG0HcC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Jul 2021 03:32:02 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GYpK203r0z7yfR;
        Tue, 27 Jul 2021 15:27:18 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 15:31:56 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 15:31:56 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2 rdma-core 07/10] libhns: Add direct verbs support to config DCA
Date:   Tue, 27 Jul 2021 15:28:18 +0800
Message-ID: <1627370901-10054-8-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1627370901-10054-1-git-send-email-liangwenpeng@huawei.com>
References: <1627370901-10054-1-git-send-email-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Add two direct verbs to config DCA:
1. hnsdv_open_device() is used to config DCA memory pool.
2. hnsdv_create_qp() is used to create a DCA QP.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 debian/control                             |  2 +-
 debian/ibverbs-providers.install           |  1 +
 debian/ibverbs-providers.lintian-overrides |  4 +-
 debian/ibverbs-providers.symbols           |  6 ++
 debian/libibverbs-dev.install              |  4 ++
 providers/hns/CMakeLists.txt               |  9 ++-
 providers/hns/hns_roce_u.c                 | 89 ++++++++++++++++++++++++------
 providers/hns/hns_roce_u.h                 |  2 +
 providers/hns/hns_roce_u_abi.h             |  1 +
 providers/hns/hns_roce_u_verbs.c           | 43 ++++++++++++---
 providers/hns/hnsdv.h                      | 65 ++++++++++++++++++++++
 providers/hns/libhns.map                   |  9 +++
 redhat/rdma-core.spec                      |  5 +-
 suse/rdma-core.spec                        | 21 ++++++-
 14 files changed, 231 insertions(+), 30 deletions(-)
 create mode 100644 providers/hns/hnsdv.h
 create mode 100644 providers/hns/libhns.map

diff --git a/debian/control b/debian/control
index a400707..4d40de8 100644
--- a/debian/control
+++ b/debian/control
@@ -94,7 +94,7 @@ Description: User space provider drivers for libibverbs
   - cxgb4: Chelsio T4 iWARP HCAs
   - efa: Amazon Elastic Fabric Adapter
   - hfi1verbs: Intel Omni-Path HFI
-  - hns: HiSilicon Hip06 SoC
+  - hns: HiSilicon+ Hip06 SoC
   - ipathverbs: QLogic InfiniPath HCAs
   - irdma: Intel Ethernet Connection RDMA
   - mlx4: Mellanox ConnectX-3 InfiniBand HCAs
diff --git a/debian/ibverbs-providers.install b/debian/ibverbs-providers.install
index 4f971fb..c6ecbbc 100644
--- a/debian/ibverbs-providers.install
+++ b/debian/ibverbs-providers.install
@@ -1,5 +1,6 @@
 etc/libibverbs.d/
 usr/lib/*/libefa.so.*
 usr/lib/*/libibverbs/lib*-rdmav*.so
+usr/lib/*/libhns.so.*
 usr/lib/*/libmlx4.so.*
 usr/lib/*/libmlx5.so.*
diff --git a/debian/ibverbs-providers.lintian-overrides b/debian/ibverbs-providers.lintian-overrides
index 8a44d54..f6afb70 100644
--- a/debian/ibverbs-providers.lintian-overrides
+++ b/debian/ibverbs-providers.lintian-overrides
@@ -1,2 +1,2 @@
-# libefa, libmlx4 and libmlx5 are ibverbs provider that provides more functions.
-ibverbs-providers: package-name-doesnt-match-sonames libefa1 libmlx4-1 libmlx5-1
+# libefa, libhns, libmlx4 and libmlx5 are ibverbs provider that provides more functions.
+ibverbs-providers: package-name-doesnt-match-sonames libefa1 libhns-1 libmlx4-1 libmlx5-1
diff --git a/debian/ibverbs-providers.symbols b/debian/ibverbs-providers.symbols
index 294832b..c048e82 100644
--- a/debian/ibverbs-providers.symbols
+++ b/debian/ibverbs-providers.symbols
@@ -141,3 +141,9 @@ libefa.so.1 ibverbs-providers #MINVER#
  efadv_create_qp_ex@EFA_1.1 26
  efadv_query_device@EFA_1.1 26
  efadv_query_ah@EFA_1.1 26
+libhns.so.1 ibverbs-providers #MINVER#
+* Build-Depends-Package: libibverbs-dev
+ HNS_1.0@HNS_1.0 36
+ hnsdv_is_supported@HNS_1.0 36
+ hnsdv_open_device@HNS_1.0 36
+ hnsdv_create_qp@HNS_1.0 36
diff --git a/debian/libibverbs-dev.install b/debian/libibverbs-dev.install
index bc8caa5..7d6e6a2 100644
--- a/debian/libibverbs-dev.install
+++ b/debian/libibverbs-dev.install
@@ -1,5 +1,6 @@
 usr/include/infiniband/arch.h
 usr/include/infiniband/efadv.h
+usr/include/infiniband/hnsdv.h
 usr/include/infiniband/ib_user_ioctl_verbs.h
 usr/include/infiniband/mlx4dv.h
 usr/include/infiniband/mlx5_api.h
@@ -14,6 +15,8 @@ usr/include/infiniband/verbs_api.h
 usr/lib/*/lib*-rdmav*.a
 usr/lib/*/libefa.a
 usr/lib/*/libefa.so
+usr/lib/*/libhns.a
+usr/lib/*/libhns.so
 usr/lib/*/libibverbs*.so
 usr/lib/*/libibverbs.a
 usr/lib/*/libmlx4.a
@@ -21,6 +24,7 @@ usr/lib/*/libmlx4.so
 usr/lib/*/libmlx5.a
 usr/lib/*/libmlx5.so
 usr/lib/*/pkgconfig/libefa.pc
+usr/lib/*/pkgconfig/libhns.pc
 usr/lib/*/pkgconfig/libibverbs.pc
 usr/lib/*/pkgconfig/libmlx4.pc
 usr/lib/*/pkgconfig/libmlx5.pc
diff --git a/providers/hns/CMakeLists.txt b/providers/hns/CMakeLists.txt
index 697dbd7..6e602f6 100644
--- a/providers/hns/CMakeLists.txt
+++ b/providers/hns/CMakeLists.txt
@@ -1,4 +1,5 @@
-rdma_provider(hns
+rdma_shared_provider(hns libhns.map
+  1 1.0.${PACKAGE_VERSION}
   hns_roce_u.c
   hns_roce_u_buf.c
   hns_roce_u_db.c
@@ -6,3 +7,9 @@ rdma_provider(hns
   hns_roce_u_hw_v2.c
   hns_roce_u_verbs.c
 )
+
+publish_headers(infiniband
+	hnsdv.h
+)
+
+rdma_pkg_config("hns" "libibverbs" "${CMAKE_THREAD_LIBS_INIT}")
diff --git a/providers/hns/hns_roce_u.c b/providers/hns/hns_roce_u.c
index 3b13d0f..cbfdb74 100644
--- a/providers/hns/hns_roce_u.c
+++ b/providers/hns/hns_roce_u.c
@@ -133,23 +133,67 @@ static int mmap_dca(struct hns_roce_dca_ctx *dca_ctx, int cmd_fd, int page_size,
 	return 0;
 }
 
+bool hnsdv_is_supported(struct ibv_device *device)
+{
+	return is_hns_dev(device);
+}
+
+struct ibv_context *hnsdv_open_device(struct ibv_device *device,
+				      struct hnsdv_context_attr *attr)
+{
+	if (!is_hns_dev(device)) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	return verbs_open_device(device, attr);
+}
+
+static void set_dca_pool_param(struct hnsdv_context_attr *attr, int page_size,
+			       struct hns_roce_dca_ctx *ctx)
+{
+	if (attr->comp_mask & HNSDV_CONTEXT_MASK_DCA_UNIT_SIZE)
+		ctx->unit_size = align(attr->dca_unit_size, page_size);
+	else
+		ctx->unit_size = page_size * HNS_DCA_DEFAULT_UNIT_PAGES;
+
+	/* The memory pool cannot be expanded, only init the DCA context. */
+	if (ctx->unit_size == 0)
+		return;
+
+	/* If not set, the memory pool can be expanded unlimitedly. */
+	if (attr->comp_mask & HNSDV_CONTEXT_MASK_DCA_MAX_SIZE)
+		ctx->max_size = DIV_ROUND_UP(attr->dca_max_size,
+					ctx->unit_size) * ctx->unit_size;
+	else
+		ctx->max_size = HNS_DCA_MAX_MEM_SIZE;
+
+	/* If not set, the memory pool cannot be shrunk. */
+	if (attr->comp_mask & HNSDV_CONTEXT_MASK_DCA_MIN_SIZE)
+		ctx->min_size = DIV_ROUND_UP(attr->dca_min_size,
+					ctx->unit_size) * ctx->unit_size;
+	else
+		ctx->min_size = HNS_DCA_MAX_MEM_SIZE;
+}
+
 static int init_dca_context(struct hns_roce_context *ctx, int cmd_fd,
-			    int page_size, int max_qps, int mmap_size)
+			    int page_size, struct hnsdv_context_attr *attr,
+			    int max_qps, int mmap_size)
 {
 	struct hns_roce_dca_ctx *dca_ctx = &ctx->dca_ctx;
 	int ret;
 
-	if (!(ctx->cap_flags & HNS_ROCE_CAP_FLAG_DCA_MODE))
-		return 0;
-
+	dca_ctx->unit_size = 0;
+	dca_ctx->mem_cnt = 0;
 	list_head_init(&dca_ctx->mem_list);
 	ret = pthread_spin_init(&dca_ctx->lock, PTHREAD_PROCESS_PRIVATE);
 	if (ret)
 		return ret;
 
-	dca_ctx->unit_size = page_size * HNS_DCA_DEFAULT_UNIT_PAGES;
-	dca_ctx->max_size = HNS_DCA_MAX_MEM_SIZE;
-	dca_ctx->mem_cnt = 0;
+	if (!attr || !(attr->flags & HNSDV_CONTEXT_FLAGS_DCA))
+		return 0;
+
+	set_dca_pool_param(attr, page_size, dca_ctx);
 
 	if (mmap_size > 0) {
 		const unsigned int bits_per_qp = 2 * HNS_DCA_BITS_PER_STATUS;
@@ -214,16 +258,22 @@ db_free:
 	return -EINVAL;
 }
 
-static void ucontext_set_cmd(struct hns_roce_alloc_ucontext *cmd, int page_size)
+static void ucontext_set_cmd(struct hns_roce_alloc_ucontext *cmd,
+			     struct hnsdv_context_attr *attr)
 {
-	cmd->comp = HNS_ROCE_ALLOC_UCTX_COMP_DCA_MAX_QPS;
-	cmd->dca_max_qps = page_size * 8 / 2 * HNS_DCA_BITS_PER_STATUS;
+	if (!attr || !(attr->flags & HNSDV_CONTEXT_FLAGS_DCA))
+		return;
+
+	if (attr->comp_mask & HNSDV_CONTEXT_MASK_DCA_PRIME_QPS) {
+		cmd->comp = HNS_ROCE_ALLOC_UCTX_COMP_DCA_MAX_QPS;
+		cmd->dca_max_qps = attr->dca_prime_qps;
+	}
 }
 
-static struct verbs_context *hns_roce_alloc_context(struct ibv_device *ibdev,
-						    int cmd_fd,
-						    void *private_data)
+static struct verbs_context *
+hns_roce_alloc_context(struct ibv_device *ibdev, int cmd_fd, void *private_data)
 {
+	struct hnsdv_context_attr *ctx_attr = private_data;
 	struct hns_roce_device *hr_dev = to_hr_dev(ibdev);
 	struct hns_roce_alloc_ucontext_resp resp = {};
 	struct hns_roce_alloc_ucontext cmd = {};
@@ -236,7 +286,7 @@ static struct verbs_context *hns_roce_alloc_context(struct ibv_device *ibdev,
 	if (!context)
 		return NULL;
 
-	ucontext_set_cmd(&cmd, hr_dev->page_size);
+	ucontext_set_cmd(&cmd, ctx_attr);
 	if (ibv_cmd_get_context(&context->ibv_ctx, &cmd.ibv_cmd, sizeof(cmd),
 				&resp.ibv_resp, sizeof(resp)))
 		goto err_free;
@@ -286,8 +336,8 @@ static struct verbs_context *hns_roce_alloc_context(struct ibv_device *ibdev,
 	verbs_set_ops(&context->ibv_ctx, &hns_common_ops);
 	verbs_set_ops(&context->ibv_ctx, &hr_dev->u_hw->hw_ops);
 
-	if (init_dca_context(context, cmd_fd, hr_dev->page_size, resp.dca_qps,
-			     resp.dca_mmap_size))
+	if (init_dca_context(context, cmd_fd, hr_dev->page_size, ctx_attr,
+			     resp.dca_qps, resp.dca_mmap_size))
 		goto err_free;
 
 	if (hns_roce_mmap(hr_dev, context, cmd_fd))
@@ -349,4 +399,11 @@ static const struct verbs_device_ops hns_roce_dev_ops = {
 	.uninit_device = hns_uninit_device,
 	.alloc_context = hns_roce_alloc_context,
 };
+
+bool is_hns_dev(struct ibv_device *device)
+{
+	struct verbs_device *verbs_device = verbs_get_device(device);
+
+	return verbs_device->ops == &hns_roce_dev_ops;
+}
 PROVIDER_DRIVER(hns, hns_roce_dev_ops);
diff --git a/providers/hns/hns_roce_u.h b/providers/hns/hns_roce_u.h
index fb7b864..086e285 100644
--- a/providers/hns/hns_roce_u.h
+++ b/providers/hns/hns_roce_u.h
@@ -430,6 +430,8 @@ static inline void clear_bit_unlock(atomic_bitmap_t *p, uint32_t nr)
 	atomic_fetch_and(p, ~HNS_ROCE_BIT_MASK(nr));
 }
 
+bool is_hns_dev(struct ibv_device *device);
+
 int hns_roce_u_query_device(struct ibv_context *context,
 			    const struct ibv_query_device_ex_input *input,
 			    struct ibv_device_attr_ex *attr, size_t attr_size);
diff --git a/providers/hns/hns_roce_u_abi.h b/providers/hns/hns_roce_u_abi.h
index 3a9aacf..5d41ea9 100644
--- a/providers/hns/hns_roce_u_abi.h
+++ b/providers/hns/hns_roce_u_abi.h
@@ -36,6 +36,7 @@
 #include <infiniband/kern-abi.h>
 #include <rdma/hns-abi.h>
 #include <kernel-abi/hns-abi.h>
+#include "hnsdv.h"
 
 DECLARE_DRV_CMD(hns_roce_alloc_pd, IB_USER_VERBS_CMD_ALLOC_PD,
 		empty, hns_roce_ib_alloc_pd_resp);
diff --git a/providers/hns/hns_roce_u_verbs.c b/providers/hns/hns_roce_u_verbs.c
index 015f417..59257e8 100644
--- a/providers/hns/hns_roce_u_verbs.c
+++ b/providers/hns/hns_roce_u_verbs.c
@@ -903,9 +903,21 @@ static int calc_qp_buff_size(struct hns_roce_device *hr_dev,
 	return 0;
 }
 
-static inline bool check_qp_support_dca(bool pool_en, enum ibv_qp_type qp_type)
+static inline bool check_qp_support_dca(struct hns_roce_dca_ctx *dca_ctx,
+					struct ibv_qp_init_attr_ex *attr,
+					struct hnsdv_qp_init_attr *hns_attr)
 {
-	if (pool_en && (qp_type == IBV_QPT_RC || qp_type == IBV_QPT_XRC_SEND))
+	/* DCA pool disable */
+	if (!dca_ctx->unit_size)
+		return false;
+
+	/* Unsupport type */
+	if (attr->qp_type != IBV_QPT_RC && attr->qp_type != IBV_QPT_XRC_SEND)
+		return false;
+
+	if (hns_attr &&
+	    (hns_attr->comp_mask & HNSDV_QP_INIT_ATTR_MASK_QP_CREATE_FLAGS) &&
+	    (hns_attr->create_flags & HNSDV_QP_CREATE_ENABLE_DCA_MODE))
 		return true;
 
 	return false;
@@ -923,6 +935,7 @@ static void qp_free_wqe(struct hns_roce_qp *qp)
 }
 
 static int qp_alloc_wqe(struct ibv_qp_init_attr_ex *attr,
+			struct hnsdv_qp_init_attr *hns_attr,
 			struct hns_roce_qp *qp, struct hns_roce_context *ctx)
 {
 	struct hns_roce_device *hr_dev = to_hr_dev(ctx->ibv_ctx.context.device);
@@ -945,7 +958,7 @@ static int qp_alloc_wqe(struct ibv_qp_init_attr_ex *attr,
 			goto err_alloc;
 	}
 
-	if (check_qp_support_dca(ctx->dca_ctx.max_size != 0, attr->qp_type)) {
+	if (check_qp_support_dca(&ctx->dca_ctx, attr, hns_attr)) {
 		/* when DCA is enabled, use a buffer list to store page addr */
 		qp->buf.buf = NULL;
 		qp->dca_wqe.max_cnt = hr_hw_page_count(qp->buf_size);
@@ -1185,6 +1198,7 @@ void hns_roce_free_qp_buf(struct hns_roce_qp *qp, struct hns_roce_context *ctx)
 }
 
 static int hns_roce_alloc_qp_buf(struct ibv_qp_init_attr_ex *attr,
+				 struct hnsdv_qp_init_attr *hns_attr,
 				 struct hns_roce_qp *qp,
 				 struct hns_roce_context *ctx)
 {
@@ -1194,7 +1208,7 @@ static int hns_roce_alloc_qp_buf(struct ibv_qp_init_attr_ex *attr,
 	    pthread_spin_init(&qp->rq.lock, PTHREAD_PROCESS_PRIVATE))
 		return -ENOMEM;
 
-	ret = qp_alloc_wqe(attr, qp, ctx);
+	ret = qp_alloc_wqe(attr, hns_attr, qp, ctx);
 	if (ret)
 		return ret;
 
@@ -1206,7 +1220,8 @@ static int hns_roce_alloc_qp_buf(struct ibv_qp_init_attr_ex *attr,
 }
 
 static struct ibv_qp *create_qp(struct ibv_context *ibv_ctx,
-				struct ibv_qp_init_attr_ex *attr)
+				struct ibv_qp_init_attr_ex *attr,
+				struct hnsdv_qp_init_attr *hns_attr)
 {
 	struct hns_roce_context *context = to_hr_ctx(ibv_ctx);
 	struct hns_roce_qp *qp;
@@ -1224,7 +1239,7 @@ static struct ibv_qp *create_qp(struct ibv_context *ibv_ctx,
 
 	hns_roce_set_qp_params(attr, qp, context);
 
-	ret = hns_roce_alloc_qp_buf(attr, qp, context);
+	ret = hns_roce_alloc_qp_buf(attr, hns_attr, qp, context);
 	if (ret)
 		goto err_buf;
 
@@ -1264,7 +1279,7 @@ struct ibv_qp *hns_roce_u_create_qp(struct ibv_pd *pd,
 	attrx.comp_mask = IBV_QP_INIT_ATTR_PD;
 	attrx.pd = pd;
 
-	qp = create_qp(pd->context, &attrx);
+	qp = create_qp(pd->context, &attrx, NULL);
 	if (qp)
 		memcpy(attr, &attrx, sizeof(*attr));
 
@@ -1274,7 +1289,19 @@ struct ibv_qp *hns_roce_u_create_qp(struct ibv_pd *pd,
 struct ibv_qp *hns_roce_u_create_qp_ex(struct ibv_context *context,
 				       struct ibv_qp_init_attr_ex *attr)
 {
-	return create_qp(context, attr);
+	return create_qp(context, attr, NULL);
+}
+
+struct ibv_qp *hnsdv_create_qp(struct ibv_context *context,
+			       struct ibv_qp_init_attr_ex *qp_attr,
+			       struct hnsdv_qp_init_attr *hns_attr)
+{
+	if (!is_hns_dev(context->device)) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	return create_qp(context, qp_attr, hns_attr);
 }
 
 struct ibv_qp *hns_roce_u_open_qp(struct ibv_context *context,
diff --git a/providers/hns/hnsdv.h b/providers/hns/hnsdv.h
new file mode 100644
index 0000000..cfe1611
--- /dev/null
+++ b/providers/hns/hnsdv.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (c) 2021 HiSilicon Limited.
+ */
+
+#ifndef __HNSDV_H__
+#define __HNSDV_H__
+
+#include <stdio.h>
+#include <stdbool.h>
+
+#include <sys/types.h>
+
+#include <infiniband/verbs.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+enum hnsdv_context_attr_flags {
+	HNSDV_CONTEXT_FLAGS_DCA = 1 << 0,
+};
+
+enum hnsdv_context_comp_mask {
+	HNSDV_CONTEXT_MASK_DCA_PRIME_QPS = 1 << 0,
+	HNSDV_CONTEXT_MASK_DCA_UNIT_SIZE = 1 << 1,
+	HNSDV_CONTEXT_MASK_DCA_MAX_SIZE = 1 << 2,
+	HNSDV_CONTEXT_MASK_DCA_MIN_SIZE = 1 << 3,
+};
+
+struct hnsdv_context_attr {
+	uint64_t flags; /* Use enum hnsdv_context_attr_flags */
+	uint64_t comp_mask; /* Use enum hnsdv_context_comp_mask */
+	uint32_t dca_prime_qps;
+	uint32_t dca_unit_size;
+	uint64_t dca_max_size;
+	uint64_t dca_min_size;
+};
+
+bool hnsdv_is_supported(struct ibv_device *device);
+struct ibv_context *hnsdv_open_device(struct ibv_device *device,
+				      struct hnsdv_context_attr *attr);
+
+enum hnsdv_qp_create_flags {
+	HNSDV_QP_CREATE_ENABLE_DCA_MODE = 1 << 0,
+};
+
+enum hnsdv_qp_init_attr_mask {
+	HNSDV_QP_INIT_ATTR_MASK_QP_CREATE_FLAGS	= 1 << 0,
+};
+
+struct hnsdv_qp_init_attr {
+	uint64_t comp_mask;	/* Use enum hnsdv_qp_init_attr_mask */
+	uint32_t create_flags;	/* Use enum hnsdv_qp_create_flags */
+};
+
+struct ibv_qp *hnsdv_create_qp(struct ibv_context *context,
+			       struct ibv_qp_init_attr_ex *qp_attr,
+			       struct hnsdv_qp_init_attr *hns_qp_attr);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __HNSDV_H__ */
diff --git a/providers/hns/libhns.map b/providers/hns/libhns.map
new file mode 100644
index 0000000..aed491c
--- /dev/null
+++ b/providers/hns/libhns.map
@@ -0,0 +1,9 @@
+/* Export symbols should be added below according to
+   Documentation/versioning.md document. */
+HNS_1.0 {
+	global:
+		hnsdv_is_supported;
+		hnsdv_open_device;
+		hnsdv_create_qp;
+	local: *;
+};
diff --git a/redhat/rdma-core.spec b/redhat/rdma-core.spec
index 1aecbaa..0d99e1c 100644
--- a/redhat/rdma-core.spec
+++ b/redhat/rdma-core.spec
@@ -151,6 +151,8 @@ Provides: libefa = %{version}-%{release}
 Obsoletes: libefa < %{version}-%{release}
 Provides: libhfi1 = %{version}-%{release}
 Obsoletes: libhfi1 < %{version}-%{release}
+Provides: libhns = %{version}-%{release}
+Obsoletes: libhns < %{version}-%{release}
 Provides: libipathverbs = %{version}-%{release}
 Obsoletes: libipathverbs < %{version}-%{release}
 Provides: libirdma = %{version}-%{release}
@@ -178,7 +180,7 @@ Device-specific plug-in ibverbs userspace drivers are included:
 - libcxgb4: Chelsio T4 iWARP HCA
 - libefa: Amazon Elastic Fabric Adapter
 - libhfi1: Intel Omni-Path HFI
-- libhns: HiSilicon Hip06 SoC
+- libhns: HiSilicon Hip06+ SoC
 - libipathverbs: QLogic InfiniPath HCA
 - libirdma: Intel Ethernet Connection RDMA
 - libmlx4: Mellanox ConnectX-3 InfiniBand HCA
@@ -563,6 +565,7 @@ fi
 %dir %{_sysconfdir}/libibverbs.d
 %dir %{_libdir}/libibverbs
 %{_libdir}/libefa.so.*
+%{_libdir}/libhns.so.*
 %{_libdir}/libibverbs*.so.*
 %{_libdir}/libibverbs/*.so
 %{_libdir}/libmlx5.so.*
diff --git a/suse/rdma-core.spec b/suse/rdma-core.spec
index b0967f3..6ee1767 100644
--- a/suse/rdma-core.spec
+++ b/suse/rdma-core.spec
@@ -30,6 +30,7 @@ License:        GPL-2.0-only OR BSD-2-Clause
 Group:          Productivity/Networking/Other
 
 %define efa_so_major    1
+%define hns_so_major    1
 %define verbs_so_major  1
 %define rdmacm_so_major 1
 %define umad_so_major   3
@@ -39,6 +40,7 @@ Group:          Productivity/Networking/Other
 %define mad_major       5
 
 %define  efa_lname    libefa%{efa_so_major}
+%define  hns_lname    libhns%{hns_so_major}
 %define  verbs_lname  libibverbs%{verbs_so_major}
 %define  rdmacm_lname librdmacm%{rdmacm_so_major}
 %define  umad_lname   libibumad%{umad_so_major}
@@ -145,6 +147,7 @@ Requires:       %{umad_lname} = %{version}-%{release}
 Requires:       %{verbs_lname} = %{version}-%{release}
 %if 0%{?dma_coherent}
 Requires:       %{efa_lname} = %{version}-%{release}
+Requires:       %{hns_lname} = %{version}-%{release}
 Requires:       %{mlx4_lname} = %{version}-%{release}
 Requires:       %{mlx5_lname} = %{version}-%{release}
 %endif
@@ -185,6 +188,7 @@ Requires:       %{name}%{?_isa} = %{version}-%{release}
 Obsoletes:      libcxgb4-rdmav2 < %{version}-%{release}
 Obsoletes:      libefa-rdmav2 < %{version}-%{release}
 Obsoletes:      libhfi1verbs-rdmav2 < %{version}-%{release}
+Obsoletes:      libhns-rdmav2 < %{version}-%{release}
 Obsoletes:      libipathverbs-rdmav2 < %{version}-%{release}
 Obsoletes:      libirdma-rdmav2 < %{version}-%{release}
 Obsoletes:      libmlx4-rdmav2 < %{version}-%{release}
@@ -194,6 +198,7 @@ Obsoletes:      libocrdma-rdmav2 < %{version}-%{release}
 Obsoletes:      librxe-rdmav2 < %{version}-%{release}
 %if 0%{?dma_coherent}
 Requires:       %{efa_lname} = %{version}-%{release}
+Requires:       %{hns_lname} = %{version}-%{release}
 Requires:       %{mlx4_lname} = %{version}-%{release}
 Requires:       %{mlx5_lname} = %{version}-%{release}
 %endif
@@ -212,7 +217,7 @@ Device-specific plug-in ibverbs userspace drivers are included:
 - libcxgb4: Chelsio T4 iWARP HCA
 - libefa: Amazon Elastic Fabric Adapter
 - libhfi1: Intel Omni-Path HFI
-- libhns: HiSilicon Hip06 SoC
+- libhns: HiSilicon Hip06+ SoC
 - libipathverbs: QLogic InfiniPath HCA
 - libirdma: Intel Ethernet Connection RDMA
 - libmlx4: Mellanox ConnectX-3 InfiniBand HCA
@@ -239,6 +244,13 @@ Group:          System/Libraries
 %description -n %efa_lname
 This package contains the efa runtime library.
 
+%package -n %hns_lname
+Summary:        HNS runtime library
+Group:          System/Libraries
+
+%description -n %hns_lname
+This package contains the hns runtime library.
+
 %package -n %mlx4_lname
 Summary:        MLX4 runtime library
 Group:          System/Libraries
@@ -482,6 +494,9 @@ rm -rf %{buildroot}/%{_sbindir}/srp_daemon.sh
 %post -n %efa_lname -p /sbin/ldconfig
 %postun -n %efa_lname -p /sbin/ldconfig
 
+%post -n %hns_lname -p /sbin/ldconfig
+%postun -n %hns_lname -p /sbin/ldconfig
+
 %post -n %mlx4_lname -p /sbin/ldconfig
 %postun -n %mlx4_lname -p /sbin/ldconfig
 
@@ -664,6 +679,10 @@ rm -rf %{buildroot}/%{_sbindir}/srp_daemon.sh
 %defattr(-,root,root)
 %{_libdir}/libefa*.so.*
 
+%files -n %hns_lname
+%defattr(-,root,root)
+%{_libdir}/libhns*.so.*
+
 %files -n %mlx4_lname
 %defattr(-,root,root)
 %{_libdir}/libmlx4*.so.*
-- 
2.8.1

