Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC53380D27
	for <lists+linux-rdma@lfdr.de>; Fri, 14 May 2021 17:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhENPdQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 May 2021 11:33:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:25047 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234808AbhENPdQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 May 2021 11:33:16 -0400
IronPort-SDR: MkIuLvu/NmEFT+cWzaHrTCNL38MLseMImxiSkGbcmjwt4IuJXg9cLkSxPU3F7OwCc6lXsxsFU4
 0abCwAnewDkA==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="197107474"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="197107474"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 08:32:04 -0700
IronPort-SDR: gq9YYE5JM/izqnOiOhvAKAN7ldLkXWsnlgFuaWmGrxZr6reC1X1iJCiC1iY8zT2aru6U3yQVeO
 ppAsk8qQYDBw==
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="624738910"
Received: from sremersa-mobl1.amr.corp.intel.com (HELO tenikolo-mobl1.amr.corp.intel.com) ([10.209.178.103])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 08:32:03 -0700
From:   Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To:     jgg@nvidia.com, dledford@redhat.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [PATCH 2/5] rdma-core/irdma: Add irdma to Makefiles, distro files and kernel-headers
Date:   Fri, 14 May 2021 10:31:32 -0500
Message-Id: <20210514153135.1972-3-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210514153135.1972-1-tatyana.e.nikolova@intel.com>
References: <20210514153135.1972-1-tatyana.e.nikolova@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add irdma to rdma-core Makefiles, distro files and
kernel headers and update the MAINTAINERS file.

Add Makefile and ABI definitions for the irdma provider and
utility macros which irdma uses to rdma-core util.h.

Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 CMakeLists.txt                            |  1 +
 MAINTAINERS                               |  6 ++++++
 debian/control                            |  1 +
 debian/copyright                          |  4 ++++
 kernel-headers/CMakeLists.txt             |  2 ++
 kernel-headers/rdma/ib_user_ioctl_verbs.h |  1 +
 libibverbs/verbs.h                        |  1 +
 providers/irdma/CMakeLists.txt            |  8 ++++++++
 providers/irdma/abi.h                     | 33 +++++++++++++++++++++++++++++++
 redhat/rdma-core.spec                     |  3 +++
 suse/rdma-core.spec                       |  2 ++
 util/util.h                               |  8 ++++++--
 12 files changed, 68 insertions(+), 2 deletions(-)
 create mode 100644 providers/irdma/CMakeLists.txt
 create mode 100644 providers/irdma/abi.h

diff --git a/CMakeLists.txt b/CMakeLists.txt
index b07565f..2a1c4e5 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -662,6 +662,7 @@ add_subdirectory(providers/cxgb4) # NO SPARSE
 add_subdirectory(providers/efa)
 add_subdirectory(providers/efa/man)
 add_subdirectory(providers/hns)
+add_subdirectory(providers/irdma)
 add_subdirectory(providers/mlx4)
 add_subdirectory(providers/mlx4/man)
 add_subdirectory(providers/mlx5)
diff --git a/MAINTAINERS b/MAINTAINERS
index a3dba9d..9fec124 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -74,6 +74,12 @@ M:	Wei Hu(Xavier) <xavier.huwei@huawei.com>
 S:	Supported
 F:	providers/hns/
 
+IRDMA USERSPACE PROVIDER (for i40iw.ko and irdma.ko)
+M:	Sindhu Devale <sindhu.devale@intel.com>
+M:	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
+S:	Supported
+F:	providers/irdma/
+
 RDMA Communication Manager Assistant (for librdmacm.so)
 M:	Haakon Bugge <haakon.bugge@oracle.com>
 M:	Mark Haywood <mark.haywood@oracle.com>
diff --git a/debian/control b/debian/control
index 3822ee5..a400707 100644
--- a/debian/control
+++ b/debian/control
@@ -96,6 +96,7 @@ Description: User space provider drivers for libibverbs
   - hfi1verbs: Intel Omni-Path HFI
   - hns: HiSilicon Hip06 SoC
   - ipathverbs: QLogic InfiniPath HCAs
+  - irdma: Intel Ethernet Connection RDMA
   - mlx4: Mellanox ConnectX-3 InfiniBand HCAs
   - mlx5: Mellanox Connect-IB/X-4+ InfiniBand HCAs
   - mthca: Mellanox InfiniBand HCAs
diff --git a/debian/copyright b/debian/copyright
index 252c423..d58aa77 100644
--- a/debian/copyright
+++ b/debian/copyright
@@ -172,6 +172,10 @@ Copyright: 2006-2010, QLogic Corp.
            2013, Intel Corporation
 License: BSD-MIT or GPL-2
 
+Files: providers/irdma/*
+Copyright: 2015-2021, Intel Corporation.
+License: BSD-MIT or GPL-2
+
 Files: providers/mlx4/*
 Copyright: 2004-2005, Topspin Communications.
            2005-2007, Cisco, Inc.
diff --git a/kernel-headers/CMakeLists.txt b/kernel-headers/CMakeLists.txt
index 82a1f64..b961892 100644
--- a/kernel-headers/CMakeLists.txt
+++ b/kernel-headers/CMakeLists.txt
@@ -8,6 +8,7 @@ publish_internal_headers(rdma
   rdma/ib_user_mad.h
   rdma/ib_user_sa.h
   rdma/ib_user_verbs.h
+  rdma/irdma-abi.h
   rdma/mlx4-abi.h
   rdma/mlx5-abi.h
   rdma/mlx5_user_ioctl_cmds.h
@@ -61,6 +62,7 @@ rdma_kernel_provider_abi(
   rdma/efa-abi.h
   rdma/hns-abi.h
   rdma/ib_user_verbs.h
+  rdma/irdma-abi.h
   rdma/mlx4-abi.h
   rdma/mlx5-abi.h
   rdma/mthca-abi.h
diff --git a/kernel-headers/rdma/ib_user_ioctl_verbs.h b/kernel-headers/rdma/ib_user_ioctl_verbs.h
index f978ae3..d4c98ef 100644
--- a/kernel-headers/rdma/ib_user_ioctl_verbs.h
+++ b/kernel-headers/rdma/ib_user_ioctl_verbs.h
@@ -239,6 +239,7 @@ enum rdma_driver_id {
 	RDMA_DRIVER_BNXT_RE,
 	RDMA_DRIVER_OCRDMA,
 	RDMA_DRIVER_NES,
+	RDMA_DRIVER_IRDMA,
 	RDMA_DRIVER_VMW_PVRDMA,
 	RDMA_DRIVER_QEDR,
 	RDMA_DRIVER_HNS,
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index e943c57..10e841d 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -2209,6 +2209,7 @@ extern const struct verbs_device_ops verbs_provider_efa;
 extern const struct verbs_device_ops verbs_provider_hfi1verbs;
 extern const struct verbs_device_ops verbs_provider_hns;
 extern const struct verbs_device_ops verbs_provider_ipathverbs;
+extern const struct verbs_device_ops verbs_provider_irdma;
 extern const struct verbs_device_ops verbs_provider_mlx4;
 extern const struct verbs_device_ops verbs_provider_mlx5;
 extern const struct verbs_device_ops verbs_provider_mthca;
diff --git a/providers/irdma/CMakeLists.txt b/providers/irdma/CMakeLists.txt
new file mode 100644
index 0000000..1542482
--- /dev/null
+++ b/providers/irdma/CMakeLists.txt
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2019, Intel Corporation.
+
+rdma_provider(irdma
+  uk.c
+  umain.c
+  uverbs.c
+)
diff --git a/providers/irdma/abi.h b/providers/irdma/abi.h
new file mode 100644
index 0000000..e3d0397
--- /dev/null
+++ b/providers/irdma/abi.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* Copyright (C) 2019 - 2020 Intel Corporation */
+#ifndef PROVIDER_IRDMA_ABI_H
+#define PROVIDER_IRDMA_ABI_H
+
+#include "irdma.h"
+#include <infiniband/kern-abi.h>
+#include <rdma/irdma-abi.h>
+#include <kernel-abi/irdma-abi.h>
+
+#define IRDMA_MIN_ABI_VERSION	0
+#define IRDMA_MAX_ABI_VERSION	5
+
+DECLARE_DRV_CMD(irdma_ualloc_pd, IB_USER_VERBS_CMD_ALLOC_PD,
+		empty, irdma_alloc_pd_resp);
+DECLARE_DRV_CMD(irdma_ucreate_cq, IB_USER_VERBS_CMD_CREATE_CQ,
+		irdma_create_cq_req, irdma_create_cq_resp);
+DECLARE_DRV_CMD(irdma_ucreate_cq_ex, IB_USER_VERBS_EX_CMD_CREATE_CQ,
+		irdma_create_cq_req, irdma_create_cq_resp);
+DECLARE_DRV_CMD(irdma_uresize_cq, IB_USER_VERBS_CMD_RESIZE_CQ,
+		irdma_resize_cq_req, empty);
+DECLARE_DRV_CMD(irdma_ucreate_qp, IB_USER_VERBS_CMD_CREATE_QP,
+		irdma_create_qp_req, irdma_create_qp_resp);
+DECLARE_DRV_CMD(irdma_umodify_qp, IB_USER_VERBS_EX_CMD_MODIFY_QP,
+		irdma_modify_qp_req, irdma_modify_qp_resp);
+DECLARE_DRV_CMD(irdma_get_context, IB_USER_VERBS_CMD_GET_CONTEXT,
+		irdma_alloc_ucontext_req, irdma_alloc_ucontext_resp);
+DECLARE_DRV_CMD(irdma_ureg_mr, IB_USER_VERBS_CMD_REG_MR,
+		irdma_mem_reg_req, empty);
+DECLARE_DRV_CMD(irdma_ucreate_ah, IB_USER_VERBS_CMD_CREATE_AH,
+		empty, irdma_create_ah_resp);
+
+#endif /* PROVIDER_IRDMA_ABI_H */
diff --git a/redhat/rdma-core.spec b/redhat/rdma-core.spec
index cbad6aa..7d75ed5 100644
--- a/redhat/rdma-core.spec
+++ b/redhat/rdma-core.spec
@@ -153,6 +153,8 @@ Provides: libhfi1 = %{version}-%{release}
 Obsoletes: libhfi1 < %{version}-%{release}
 Provides: libipathverbs = %{version}-%{release}
 Obsoletes: libipathverbs < %{version}-%{release}
+Provides: libirdma = %{version}-%{release}
+Obsoletes: libirdma < %{version}-%{release}
 Provides: libmlx4 = %{version}-%{release}
 Obsoletes: libmlx4 < %{version}-%{release}
 Provides: libmlx5 = %{version}-%{release}
@@ -178,6 +180,7 @@ Device-specific plug-in ibverbs userspace drivers are included:
 - libhfi1: Intel Omni-Path HFI
 - libhns: HiSilicon Hip06 SoC
 - libipathverbs: QLogic InfiniPath HCA
+- libirdma: Intel Ethernet Connection RDMA
 - libmlx4: Mellanox ConnectX-3 InfiniBand HCA
 - libmlx5: Mellanox Connect-IB/X-4+ InfiniBand HCA
 - libmthca: Mellanox InfiniBand HCA
diff --git a/suse/rdma-core.spec b/suse/rdma-core.spec
index db831b9..9243e19 100644
--- a/suse/rdma-core.spec
+++ b/suse/rdma-core.spec
@@ -186,6 +186,7 @@ Obsoletes:      libcxgb4-rdmav2 < %{version}-%{release}
 Obsoletes:      libefa-rdmav2 < %{version}-%{release}
 Obsoletes:      libhfi1verbs-rdmav2 < %{version}-%{release}
 Obsoletes:      libipathverbs-rdmav2 < %{version}-%{release}
+Obsoletes:      libirdma-rdmav2 < %{version}-%{release}
 Obsoletes:      libmlx4-rdmav2 < %{version}-%{release}
 Obsoletes:      libmlx5-rdmav2 < %{version}-%{release}
 Obsoletes:      libmthca-rdmav2 < %{version}-%{release}
@@ -213,6 +214,7 @@ Device-specific plug-in ibverbs userspace drivers are included:
 - libhfi1: Intel Omni-Path HFI
 - libhns: HiSilicon Hip06 SoC
 - libipathverbs: QLogic InfiniPath HCA
+- libirdma: Intel Ethernet Connection RDMA
 - libmlx4: Mellanox ConnectX-3 InfiniBand HCA
 - libmlx5: Mellanox Connect-IB/X-4+ InfiniBand HCA
 - libmthca: Mellanox InfiniBand HCA
diff --git a/util/util.h b/util/util.h
index 6db46b1..2c05631 100644
--- a/util/util.h
+++ b/util/util.h
@@ -26,12 +26,16 @@ static inline bool __good_snprintf(size_t len, int rc)
 #define offsetofend(_type, _member)                                            \
 	(offsetof(_type, _member) + sizeof(((_type *)0)->_member))
 
-#define BITS_PER_LONG	(8 * sizeof(long))
+#define BITS_PER_LONG	   (8 * sizeof(long))
+#define BITS_PER_LONG_LONG (8 * sizeof(long long))
 
 #define GENMASK(h, l) \
 	(((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
+#define GENMASK_ULL(h, l) \
+	(((~0ULL) << (l)) & (~0ULL >> (BITS_PER_LONG_LONG - 1 - (h))))
 
-#define BIT(nr) (1UL << (nr))
+#define BIT(nr)     (1UL << (nr))
+#define BIT_ULL(nr) (1ULL << (nr))
 
 #define __bf_shf(x) (__builtin_ffsll(x) - 1)
 
-- 
1.8.3.1

