Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D6F355DCC
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 23:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242931AbhDFVVc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 17:21:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:37911 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343669AbhDFVVb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Apr 2021 17:21:31 -0400
IronPort-SDR: oZDa2qvkRyCdTT+Xoim3W8WM43Myf29Z49xJeqaTcgRNGRpWUnjUqn5Tl8iql6gKgq5MLVGSpi
 eLuUr4Kb5Ztw==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="180703607"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="180703607"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 14:21:22 -0700
IronPort-SDR: O4gFTIvfitzRPtls8AZLNCiOJUp4TsZve8vBMHLm0wBnshqgPUujvw4NskubBKU8nHsRbhsvXc
 R/gAhGLkCkdw==
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="598092754"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.212.86.191])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 14:21:22 -0700
From:   Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To:     jgg@nvidia.com, dledford@redhat.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [PATCH 2/5] rdma-core/irdma: Add Makefile and ABI definitions
Date:   Tue,  6 Apr 2021 16:17:25 -0500
Message-Id: <20210406211728.1362-3-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210406211728.1362-1-tatyana.e.nikolova@intel.com>
References: <20210406211728.1362-1-tatyana.e.nikolova@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add Makefile and ABI definitions for irdma provider.
Add utility macros to rdma-core util.h which are used by irdma.

Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 providers/irdma/CMakeLists.txt |  8 ++++++++
 providers/irdma/abi.h          | 39 +++++++++++++++++++++++++++++++++++++++
 util/util.h                    |  8 ++++++--
 3 files changed, 53 insertions(+), 2 deletions(-)
 create mode 100644 providers/irdma/CMakeLists.txt
 create mode 100644 providers/irdma/abi.h

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
index 0000000..bacce40
--- /dev/null
+++ b/providers/irdma/abi.h
@@ -0,0 +1,39 @@
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
+		empty, irdma_modify_qp_resp);
+DECLARE_DRV_CMD(irdma_get_context, IB_USER_VERBS_CMD_GET_CONTEXT,
+		irdma_alloc_ucontext_req, irdma_alloc_ucontext_resp);
+DECLARE_DRV_CMD(irdma_ureg_mr, IB_USER_VERBS_CMD_REG_MR,
+		irdma_mem_reg_req, empty);
+DECLARE_DRV_CMD(irdma_ucreate_ah, IB_USER_VERBS_CMD_CREATE_AH,
+		empty, irdma_create_ah_resp);
+
+struct irdma_modify_qp_cmd {
+	struct ibv_modify_qp_ex ibv_cmd;
+	__u8 sq_flush;
+	__u8 rq_flush;
+	__u8 rsvd[6];
+};
+#endif /* PROVIDER_IRDMA_ABI_H */
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

