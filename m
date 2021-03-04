Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D42432CEE2
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Mar 2021 09:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbhCDIxS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Mar 2021 03:53:18 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13858 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236900AbhCDIxE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Mar 2021 03:53:04 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Drl1L3spyz7t3c;
        Thu,  4 Mar 2021 16:49:58 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Mar 2021 16:51:36 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: [PATCH RFC v2 rdma-core 5/6] libhns: Add direct verb to support config DCA memory pool
Date:   Thu, 4 Mar 2021 16:49:18 +0800
Message-ID: <1614847759-33139-6-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1614847759-33139-1-git-send-email-liweihang@huawei.com>
References: <1614847759-33139-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Add a direct verb 'hnsdv_open_device' to config DCA memory pool, and append
'IBV_QP_CREATE_DYNAMIC_CONTEXT_ATTACH' for creating a DCA QP.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 debian/ibverbs-providers.install           |  1 +
 debian/ibverbs-providers.lintian-overrides |  4 +-
 debian/ibverbs-providers.symbols           |  5 +++
 debian/libibverbs-dev.install              |  4 ++
 libibverbs/cmd_qp.c                        |  3 +-
 libibverbs/verbs.h                         |  1 +
 providers/hns/CMakeLists.txt               |  9 +++-
 providers/hns/hns_roce_u.c                 | 71 ++++++++++++++++++++++++++----
 providers/hns/hns_roce_u.h                 |  4 +-
 providers/hns/hns_roce_u_abi.h             |  1 +
 providers/hns/hns_roce_u_verbs.c           | 18 ++++++--
 providers/hns/hnsdv.h                      | 44 ++++++++++++++++++
 providers/hns/libhns.map                   |  8 ++++
 redhat/rdma-core.spec                      |  3 ++
 suse/rdma-core.spec                        | 19 ++++++++
 15 files changed, 178 insertions(+), 17 deletions(-)
 create mode 100644 providers/hns/hnsdv.h
 create mode 100644 providers/hns/libhns.map

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
index b79bc34..daa5b32 100644
--- a/debian/ibverbs-providers.symbols
+++ b/debian/ibverbs-providers.symbols
@@ -132,3 +132,8 @@ libefa.so.1 ibverbs-providers #MINVER#
  efadv_create_qp_ex@EFA_1.1 26
  efadv_query_device@EFA_1.1 26
  efadv_query_ah@EFA_1.1 26
+libhns.so.1 ibverbs-providers #MINVER#
+* Build-Depends-Package: libibverbs-dev
+ HNS_1.0@HNS_1.0 34
+ hnsdv_is_supported@HNS_1.0 34
+ hnsdv_open_device@HNS_1.0 34
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
diff --git a/libibverbs/cmd_qp.c b/libibverbs/cmd_qp.c
index 056f397..f9899ad 100644
--- a/libibverbs/cmd_qp.c
+++ b/libibverbs/cmd_qp.c
@@ -38,7 +38,8 @@ enum {
 					IBV_QP_CREATE_SCATTER_FCS |
 					IBV_QP_CREATE_CVLAN_STRIPPING |
 					IBV_QP_CREATE_SOURCE_QPN |
-					IBV_QP_CREATE_PCI_WRITE_END_PADDING
+					IBV_QP_CREATE_PCI_WRITE_END_PADDING |
+					IBV_QP_CREATE_DYNAMIC_CONTEXT_ATTACH
 };
 
 
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index 656b0f9..db37dce 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -918,6 +918,7 @@ enum ibv_qp_create_flags {
 	IBV_QP_CREATE_CVLAN_STRIPPING		= 1 << 9,
 	IBV_QP_CREATE_SOURCE_QPN		= 1 << 10,
 	IBV_QP_CREATE_PCI_WRITE_END_PADDING	= 1 << 11,
+	IBV_QP_CREATE_DYNAMIC_CONTEXT_ATTACH	= 1 << 13,
 };
 
 enum ibv_qp_create_send_ops_flags {
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
index 28b1130..58edb17 100644
--- a/providers/hns/hns_roce_u.c
+++ b/providers/hns/hns_roce_u.c
@@ -89,22 +89,69 @@ static const struct verbs_context_ops hns_common_ops = {
 	.destroy_ah = hns_roce_u_destroy_ah,
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
@@ -127,6 +174,7 @@ static struct verbs_context *hns_roce_alloc_context(struct ibv_device *ibdev,
 						    int cmd_fd,
 						    void *private_data)
 {
+	struct hnsdv_context_attr *ctx_attr = private_data;
 	struct hns_roce_device *hr_dev = to_hr_dev(ibdev);
 	struct hns_roce_alloc_ucontext_resp resp = {};
 	struct ibv_device_attr dev_attrs;
@@ -198,7 +246,7 @@ static struct verbs_context *hns_roce_alloc_context(struct ibv_device *ibdev,
 	verbs_set_ops(&context->ibv_ctx, &hns_common_ops);
 	verbs_set_ops(&context->ibv_ctx, &hr_dev->u_hw->hw_ops);
 
-	if (init_dca_context(context, hr_dev->page_size))
+	if (init_dca_context(context, hr_dev->page_size, ctx_attr))
 		goto db_free;
 
 	return &context->ibv_ctx;
@@ -258,4 +306,11 @@ static const struct verbs_device_ops hns_roce_dev_ops = {
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
index ae72709..4e86edc 100644
--- a/providers/hns/hns_roce_u.h
+++ b/providers/hns/hns_roce_u.h
@@ -154,11 +154,11 @@ struct hns_roce_db_page {
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
@@ -376,6 +376,8 @@ static inline struct hns_roce_ah *to_hr_ah(struct ibv_ah *ibv_ah)
 	return container_of(ibv_ah, struct hns_roce_ah, ibv_ah);
 }
 
+bool is_hns_dev(struct ibv_device *device);
+
 int hns_roce_u_query_device(struct ibv_context *context,
 			    const struct ibv_query_device_ex_input *input,
 			    struct ibv_device_attr_ex *attr, size_t attr_size);
diff --git a/providers/hns/hns_roce_u_abi.h b/providers/hns/hns_roce_u_abi.h
index 4341207..d87944d 100644
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
index 6ec8b12..baebd76 100644
--- a/providers/hns/hns_roce_u_verbs.c
+++ b/providers/hns/hns_roce_u_verbs.c
@@ -542,7 +542,7 @@ int hns_roce_u_destroy_srq(struct ibv_srq *srq)
 }
 
 enum {
-	CREATE_QP_SUP_CREATE_FLAGS = 0,
+	CREATE_QP_SUP_CREATE_FLAGS = IBV_QP_CREATE_DYNAMIC_CONTEXT_ATTACH,
 };
 
 enum {
@@ -688,10 +688,11 @@ static int calc_qp_buff_size(struct hns_roce_device *hr_dev,
 	return 0;
 }
 
-static inline bool check_qp_support_dca(bool pool_en, enum ibv_qp_type qp_type)
+static inline bool check_qp_support_dca(bool pool_en, enum ibv_qp_type qp_type,
+					uint32_t create_flags)
 {
 	if (pool_en && (qp_type == IBV_QPT_RC || qp_type == IBV_QPT_XRC_SEND))
-		return true;
+		return !!(create_flags & IBV_QP_CREATE_DYNAMIC_CONTEXT_ATTACH);
 
 	return false;
 }
@@ -730,7 +731,8 @@ static int qp_alloc_wqe(struct ibv_qp_init_attr_ex *attr,
 			goto err_alloc;
 	}
 
-	if (check_qp_support_dca(ctx->dca_ctx.max_size != 0, attr->qp_type)) {
+	if (check_qp_support_dca(ctx->dca_ctx.unit_size != 0,
+				 attr->qp_type, attr->create_flags)) {
 		/* when DCA is enabled, use a buffer list to store page addr */
 		qp->buf.buf = NULL;
 		qp->page_list.max_cnt = hr_hw_page_count(qp->buf_size);
@@ -901,6 +903,14 @@ static int qp_exec_create_cmd(struct ibv_qp_init_attr_ex *attr,
 	struct hns_roce_create_qp_ex cmd_ex = {};
 	int ret;
 
+	/*
+	 * When the kernel driver handling the command , whether to enable the
+	 * DCA mode of the user QP depends on whether the cmd.buf_addr is NULL
+	 * instead of whether the DCA bit of attr->create_flags is set, so
+	 * clear this bit before sending the command.
+	 */
+	attr->create_flags &= ~IBV_QP_CREATE_DYNAMIC_CONTEXT_ATTACH;
+
 	cmd_ex.sdb_addr = (uintptr_t)qp->sdb;
 	cmd_ex.db_addr = (uintptr_t)qp->rdb;
 	cmd_ex.buf_addr = (uintptr_t)qp->buf.buf;
diff --git a/providers/hns/hnsdv.h b/providers/hns/hnsdv.h
new file mode 100644
index 0000000..18b2803
--- /dev/null
+++ b/providers/hns/hnsdv.h
@@ -0,0 +1,44 @@
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
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __HNSDV_H__ */
diff --git a/providers/hns/libhns.map b/providers/hns/libhns.map
new file mode 100644
index 0000000..d03a5e9
--- /dev/null
+++ b/providers/hns/libhns.map
@@ -0,0 +1,8 @@
+/* Export symbols should be added below according to
+   Documentation/versioning.md document. */
+HNS_1.0 {
+	global:
+		hnsdv_is_supported;
+		hnsdv_open_device;
+	local: *;
+};
diff --git a/redhat/rdma-core.spec b/redhat/rdma-core.spec
index f2bb27f..f4e00c3 100644
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
@@ -563,6 +565,7 @@ fi
 %dir %{_sysconfdir}/libibverbs.d
 %dir %{_libdir}/libibverbs
 %{_libdir}/libefa.so.*
+%{_libdir}/libhns.so.*
 %{_libdir}/libibverbs*.so.*
 %{_libdir}/libibverbs/*.so
 %{_libdir}/libmlx5.so.*
diff --git a/suse/rdma-core.spec b/suse/rdma-core.spec
index 496933f..fd0ed87 100644
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
@@ -477,6 +489,9 @@ rm -rf %{buildroot}/%{_sbindir}/srp_daemon.sh
 %post -n %efa_lname -p /sbin/ldconfig
 %postun -n %efa_lname -p /sbin/ldconfig
 
+%post -n %hns_lname -p /sbin/ldconfig
+%postun -n %hns_lname -p /sbin/ldconfig
+
 %post -n %mlx4_lname -p /sbin/ldconfig
 %postun -n %mlx4_lname -p /sbin/ldconfig
 
@@ -659,6 +674,10 @@ rm -rf %{buildroot}/%{_sbindir}/srp_daemon.sh
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

