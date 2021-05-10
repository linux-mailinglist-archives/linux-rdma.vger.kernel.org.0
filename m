Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD947378EEA
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 15:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242479AbhEJNYr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 09:24:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2614 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbhEJNO7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 May 2021 09:14:59 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ff1cL1QSzzQlnj;
        Mon, 10 May 2021 21:09:54 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 21:13:07 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH rdma-core 5/6] libhns: Add direct verbs support to config DCA
Date:   Mon, 10 May 2021 21:13:03 +0800
Message-ID: <1620652384-34097-6-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620652384-34097-1-git-send-email-liweihang@huawei.com>
References: <1620652384-34097-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Add two direct verbs to config DCA:
1. hnsdv_open_device() is used to config DCA memory pool.
2. hnsdv_create_qp() is used to create a DCA QP.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 debian/control                             |  2 +-
 debian/ibverbs-providers.install           |  1 +
 debian/ibverbs-providers.lintian-overrides |  4 +-
 debian/ibverbs-providers.symbols           |  6 +++
 debian/libibverbs-dev.install              |  4 ++
 providers/hns/CMakeLists.txt               |  9 +++-
 providers/hns/hns_roce_u.c                 | 71 ++++++++++++++++++++++++++----
 providers/hns/hns_roce_u.h                 |  4 +-
 providers/hns/hns_roce_u_abi.h             |  1 +
 providers/hns/hns_roce_u_verbs.c           | 43 ++++++++++++++----
 providers/hns/hnsdv.h                      | 61 +++++++++++++++++++++++++
 providers/hns/libhns.map                   |  9 ++++
 redhat/rdma-core.spec                      |  5 ++-
 suse/rdma-core.spec                        | 21 ++++++++-
 14 files changed, 218 insertions(+), 23 deletions(-)
 create mode 100644 providers/hns/hnsdv.h
 create mode 100644 providers/hns/libhns.map

diff --git a/debian/control b/debian/control
index 8cbab0b..1ccb7f4 100644
--- a/debian/control
+++ b/debian/control
@@ -94,7 +94,7 @@ Description: User space provider drivers for libibverbs
   - cxgb4: Chelsio T4 iWARP HCAs
   - efa: Amazon Elastic Fabric Adapter
   - hfi1verbs: Intel Omni-Path HFI
-  - hns: HiSilicon Hip06 SoC
+  - hns: HiSilicon Hip06+ SoC
   - i40iw: Intel Ethernet Connection X722 RDMA
   - ipathverbs: QLogic InfiniPath HCAs
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
index 3c75ecc..34bc9d5 100644
--- a/debian/ibverbs-providers.symbols
+++ b/debian/ibverbs-providers.symbols
@@ -136,3 +136,9 @@ libefa.so.1 ibverbs-providers #MINVER#
  efadv_create_qp_ex@EFA_1.1 26
  efadv_query_device@EFA_1.1 26
  efadv_query_ah@EFA_1.1 26
+libhns.so.1 ibverbs-providers #MINVER#
+* Build-Depends-Package: libibverbs-dev
+ HNS_1.0@HNS_1.0 34
+ hnsdv_is_supported@HNS_1.0 34
+ hnsdv_open_device@HNS_1.0 34
+ hnsdv_create_qp@HNS_1.0 34
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
index a4e0997..230befe 100644
--- a/providers/hns/hns_roce_u.c
+++ b/providers/hns/hns_roce_u.c
@@ -95,22 +95,69 @@ static const struct verbs_context_ops hns_common_ops = {
 	.get_srq_num = hns_roce_u_get_srq_num,
 };
 
-static int init_dca_context(struct hns_roce_context *ctx, int page_size)
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
+					     ctx->unit_size);
+	else
+		ctx->max_size = HNS_DCA_MAX_MEM_SIZE;
+
+	/* If not set, the memory pool cannot be shrunk. */
+	if (attr->comp_mask & HNSDV_CONTEXT_MASK_DCA_MIN_SIZE)
+		ctx->min_size = DIV_ROUND_UP(attr->dca_min_size,
+					     ctx->unit_size);
+	else
+		ctx->min_size = HNS_DCA_MAX_MEM_SIZE;
+}
+
+static int init_dca_context(struct hns_roce_context *ctx, int page_size,
+			    struct hnsdv_context_attr *attr)
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
+	if (!attr)
+		return 0;
+
+	if (!(attr->flags & HNSDV_CONTEXT_FLAGS_DCA))
+		return 0;
+
+	set_dca_pool_param(attr, page_size, dca_ctx);
 
 	return 0;
 }
@@ -133,6 +180,7 @@ static struct verbs_context *hns_roce_alloc_context(struct ibv_device *ibdev,
 						    int cmd_fd,
 						    void *private_data)
 {
+	struct hnsdv_context_attr *ctx_attr = private_data;
 	struct hns_roce_device *hr_dev = to_hr_dev(ibdev);
 	struct hns_roce_alloc_ucontext_resp resp = {};
 	struct ibv_device_attr dev_attrs;
@@ -214,7 +262,7 @@ static struct verbs_context *hns_roce_alloc_context(struct ibv_device *ibdev,
 	verbs_set_ops(&context->ibv_ctx, &hns_common_ops);
 	verbs_set_ops(&context->ibv_ctx, &hr_dev->u_hw->hw_ops);
 
-	if (init_dca_context(context, hr_dev->page_size))
+	if (init_dca_context(context, hr_dev->page_size, ctx_attr))
 		goto tptr_free;
 
 	return &context->ibv_ctx;
@@ -278,4 +326,11 @@ static const struct verbs_device_ops hns_roce_dev_ops = {
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
index a488694..5c8427a 100644
--- a/providers/hns/hns_roce_u.h
+++ b/providers/hns/hns_roce_u.h
@@ -157,11 +157,11 @@ struct hns_roce_db_page {
 struct hns_roce_dca_ctx {
 	struct list_head mem_list;
 	pthread_spinlock_t lock;
+	uint32_t unit_size;
 	uint64_t max_size;
 	uint64_t min_size;
 	uint64_t curr_size;
 	int mem_cnt;
-	unsigned int unit_size;
 };
 
 struct hns_roce_context {
@@ -391,6 +391,8 @@ static inline struct hns_roce_ah *to_hr_ah(struct ibv_ah *ibv_ah)
 	return container_of(ibv_ah, struct hns_roce_ah, ibv_ah);
 }
 
+bool is_hns_dev(struct ibv_device *device);
+
 int hns_roce_u_query_device(struct ibv_context *context,
 			    const struct ibv_query_device_ex_input *input,
 			    struct ibv_device_attr_ex *attr, size_t attr_size);
diff --git a/providers/hns/hns_roce_u_abi.h b/providers/hns/hns_roce_u_abi.h
index e56f9d3..92404bc 100644
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
index 21e295a..350a6d2 100644
--- a/providers/hns/hns_roce_u_verbs.c
+++ b/providers/hns/hns_roce_u_verbs.c
@@ -870,9 +870,21 @@ static int calc_qp_buff_size(struct hns_roce_device *hr_dev,
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
+	    (hns_attr->create_flags & HNSDV_QP_CREATE_DYNAMIC_CONTEXT_ATTACH))
 		return true;
 
 	return false;
@@ -890,6 +902,7 @@ static void qp_free_wqe(struct hns_roce_qp *qp)
 }
 
 static int qp_alloc_wqe(struct ibv_qp_init_attr_ex *attr,
+			struct hnsdv_qp_init_attr *hns_attr,
 			struct hns_roce_qp *qp, struct hns_roce_context *ctx)
 {
 	struct hns_roce_device *hr_dev = to_hr_dev(ctx->ibv_ctx.context.device);
@@ -912,7 +925,7 @@ static int qp_alloc_wqe(struct ibv_qp_init_attr_ex *attr,
 			goto err_alloc;
 	}
 
-	if (check_qp_support_dca(ctx->dca_ctx.max_size != 0, attr->qp_type)) {
+	if (check_qp_support_dca(&ctx->dca_ctx, attr, hns_attr)) {
 		/* when DCA is enabled, use a buffer list to store page addr */
 		qp->buf.buf = NULL;
 		qp->page_list.max_cnt = hr_hw_page_count(qp->buf_size);
@@ -1134,6 +1147,7 @@ void hns_roce_free_qp_buf(struct hns_roce_qp *qp, struct hns_roce_context *ctx)
 }
 
 static int hns_roce_alloc_qp_buf(struct ibv_qp_init_attr_ex *attr,
+				 struct hnsdv_qp_init_attr *hns_attr,
 				 struct hns_roce_qp *qp,
 				 struct hns_roce_context *ctx)
 {
@@ -1143,7 +1157,7 @@ static int hns_roce_alloc_qp_buf(struct ibv_qp_init_attr_ex *attr,
 	    pthread_spin_init(&qp->rq.lock, PTHREAD_PROCESS_PRIVATE))
 		return -ENOMEM;
 
-	ret = qp_alloc_wqe(attr, qp, ctx);
+	ret = qp_alloc_wqe(attr, hns_attr, qp, ctx);
 	if (ret)
 		return ret;
 
@@ -1155,7 +1169,8 @@ static int hns_roce_alloc_qp_buf(struct ibv_qp_init_attr_ex *attr,
 }
 
 static struct ibv_qp *create_qp(struct ibv_context *ibv_ctx,
-				struct ibv_qp_init_attr_ex *attr)
+				struct ibv_qp_init_attr_ex *attr,
+				struct hnsdv_qp_init_attr *hns_attr)
 {
 	struct hns_roce_context *context = to_hr_ctx(ibv_ctx);
 	struct hns_roce_qp *qp;
@@ -1173,7 +1188,7 @@ static struct ibv_qp *create_qp(struct ibv_context *ibv_ctx,
 
 	hns_roce_set_qp_params(attr, qp, context);
 
-	ret = hns_roce_alloc_qp_buf(attr, qp, context);
+	ret = hns_roce_alloc_qp_buf(attr, hns_attr, qp, context);
 	if (ret)
 		goto err_buf;
 
@@ -1213,7 +1228,7 @@ struct ibv_qp *hns_roce_u_create_qp(struct ibv_pd *pd,
 	attrx.comp_mask = IBV_QP_INIT_ATTR_PD;
 	attrx.pd = pd;
 
-	qp = create_qp(pd->context, &attrx);
+	qp = create_qp(pd->context, &attrx, NULL);
 	if (qp)
 		memcpy(attr, &attrx, sizeof(*attr));
 
@@ -1223,7 +1238,19 @@ struct ibv_qp *hns_roce_u_create_qp(struct ibv_pd *pd,
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
index 0000000..876183b
--- /dev/null
+++ b/providers/hns/hnsdv.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (c) 2021 Hisilicon Limited.
+ */
+
+#ifndef __HNSDV_H__
+#define __HNSDV_H__
+
+#include <stdio.h>
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
+	HNSDV_CONTEXT_MASK_DCA_UNIT_SIZE = 1 << 0,
+	HNSDV_CONTEXT_MASK_DCA_MAX_SIZE = 1 << 1,
+	HNSDV_CONTEXT_MASK_DCA_MIN_SIZE = 1 << 2,
+};
+
+struct hnsdv_context_attr {
+	uint32_t flags; /* Use enum hnsdv_context_attr_flags */
+	uint64_t comp_mask; /* Use enum hnsdv_context_comp_mask */
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
+	HNSDV_QP_CREATE_DYNAMIC_CONTEXT_ATTACH = 1 << 0,
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
index 207859d..e1dda8f 100644
--- a/redhat/rdma-core.spec
+++ b/redhat/rdma-core.spec
@@ -151,6 +151,8 @@ Provides: libefa = %{version}-%{release}
 Obsoletes: libefa < %{version}-%{release}
 Provides: libhfi1 = %{version}-%{release}
 Obsoletes: libhfi1 < %{version}-%{release}
+Provides: libhns = %{version}-%{release}
+Obsoletes: libhns < %{version}-%{release}
 Provides: libi40iw = %{version}-%{release}
 Obsoletes: libi40iw < %{version}-%{release}
 Provides: libipathverbs = %{version}-%{release}
@@ -178,7 +180,7 @@ Device-specific plug-in ibverbs userspace drivers are included:
 - libcxgb4: Chelsio T4 iWARP HCA
 - libefa: Amazon Elastic Fabric Adapter
 - libhfi1: Intel Omni-Path HFI
-- libhns: HiSilicon Hip06 SoC
+- libhns: HiSilicon Hip06+ SoC
 - libi40iw: Intel Ethernet Connection X722 RDMA
 - libipathverbs: QLogic InfiniPath HCA
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
index db6a361..1c14773 100644
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
 Obsoletes:      libi40iw-rdmav2 < %{version}-%{release}
 Obsoletes:      libipathverbs-rdmav2 < %{version}-%{release}
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
 - libi40iw: Intel Ethernet Connection X722 RDMA
 - libipathverbs: QLogic InfiniPath HCA
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
2.7.4

