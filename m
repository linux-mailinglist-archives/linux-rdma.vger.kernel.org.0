Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD9F306BC5
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 05:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhA1EBu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jan 2021 23:01:50 -0500
Received: from mga04.intel.com ([192.55.52.120]:62983 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231220AbhA1EBc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 Jan 2021 23:01:32 -0500
IronPort-SDR: UzMLGtfOvOk5ncjPY4E2zk2gXL9IdUY0M1K8g6mgOal8Tky/rKMPVRlZe0HFp/Cxm+8WI3ESy7
 oGsLc7yS+Cfw==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="177612833"
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; 
   d="scan'208";a="177612833"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 19:59:56 -0800
IronPort-SDR: QhyeZntmAqJr2VjR4gOpXBk68BCe4miOWpNUqyNCnR3dZvMjlIygQS7UgS/9VEbh/Ufl7OhRJK
 +Jm6WtmyX+PQ==
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; 
   d="scan'208";a="357282476"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.251.6.196])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 19:59:55 -0800
From:   Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To:     jgg@nvidia.com, dledford@redhat.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [PATCH rdma-core 2/5] rdma-core/irdma: Add Makefile and ABI definitions
Date:   Wed, 27 Jan 2021 21:57:01 -0600
Message-Id: <20210128035704.1781-3-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210128035704.1781-1-tatyana.e.nikolova@intel.com>
References: <20210128035704.1781-1-tatyana.e.nikolova@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add Makefile and ABI definitions for irdma provider.

Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 kernel-headers/rdma/irdma-abi.h | 140 ++++++++++++++++++++++++++++++++++++++++
 providers/irdma/CMakeLists.txt  |   8 +++
 providers/irdma/abi.h           |  43 ++++++++++++
 3 files changed, 191 insertions(+)
 create mode 100644 kernel-headers/rdma/irdma-abi.h
 create mode 100644 providers/irdma/CMakeLists.txt
 create mode 100644 providers/irdma/abi.h

diff --git a/kernel-headers/rdma/irdma-abi.h b/kernel-headers/rdma/irdma-abi.h
new file mode 100644
index 0000000..014c573
--- /dev/null
+++ b/kernel-headers/rdma/irdma-abi.h
@@ -0,0 +1,140 @@
+/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
+/*
+ * Copyright (c) 2006 - 2020 Intel Corporation.  All rights reserved.
+ * Copyright (c) 2005 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2005 Cisco Systems.  All rights reserved.
+ * Copyright (c) 2005 Open Grid Computing, Inc. All rights reserved.
+ */
+
+#ifndef IRDMA_ABI_H
+#define IRDMA_ABI_H
+
+#include <linux/types.h>
+
+/* irdma must support legacy GEN_1 i40iw kernel
+ * and user-space whose last ABI ver is 5
+ */
+#define IRDMA_ABI_VER 6
+
+enum irdma_memreg_type {
+	IW_MEMREG_TYPE_MEM  = 0,
+	IW_MEMREG_TYPE_QP   = 1,
+	IW_MEMREG_TYPE_CQ   = 2,
+	IW_MEMREG_TYPE_RSVD = 3,
+	IW_MEMREG_TYPE_MW   = 4,
+};
+
+struct irdma_alloc_ucontext_req {
+	__u32 rsvd32;
+	__u8 userspace_ver;
+	__u8 rsvd8[3];
+};
+
+struct i40iw_alloc_ucontext_req {
+	__u32 rsvd32;
+	__u8 userspace_ver;
+	__u8 rsvd8[3];
+};
+
+struct irdma_alloc_ucontext_resp {
+	__aligned_u64 feature_flags;
+	__aligned_u64 db_mmap_key;
+	__u32 max_hw_wq_frags;
+	__u32 max_hw_read_sges;
+	__u32 max_hw_inline;
+	__u32 max_hw_rq_quanta;
+	__u32 max_hw_wq_quanta;
+	__u32 min_hw_cq_size;
+	__u32 max_hw_cq_size;
+	__u32 rsvd1[7];
+	__u16 max_hw_sq_chunk;
+	__u16 rsvd2[11];
+	__u8 kernel_ver;
+	__u8 hw_rev;
+	__u8 rsvd3[6];
+};
+
+struct i40iw_alloc_ucontext_resp {
+	__u32 max_pds;
+	__u32 max_qps;
+	__u32 wq_size; /* size of the WQs (SQ+RQ) in the mmaped area */
+	__u8 kernel_ver;
+	__u8 rsvd[3];
+};
+
+struct irdma_alloc_pd_resp {
+	__u32 pd_id;
+	__u8 rsvd[4];
+};
+
+struct irdma_resize_cq_req {
+	__aligned_u64 user_cq_buffer;
+};
+
+struct irdma_create_cq_req {
+	__aligned_u64 user_cq_buf;
+	__aligned_u64 user_shadow_area;
+};
+
+struct irdma_create_qp_req {
+	__aligned_u64 user_wqe_bufs;
+	__aligned_u64 user_compl_ctx;
+};
+
+struct i40iw_create_qp_req {
+	__aligned_u64 user_wqe_bufs;
+	__aligned_u64 user_compl_ctx;
+};
+
+struct irdma_mem_reg_req {
+	__u16 reg_type; /* Memory, QP or CQ */
+	__u16 cq_pages;
+	__u16 rq_pages;
+	__u16 sq_pages;
+};
+
+struct irdma_modify_qp_req {
+	__u8 sq_flush;
+	__u8 rq_flush;
+	__u8 rsvd[6];
+};
+
+struct irdma_create_cq_resp {
+	__u32 cq_id;
+	__u32 cq_size;
+};
+
+struct irdma_create_qp_resp {
+	__u32 qp_id;
+	__u32 actual_sq_size;
+	__u32 actual_rq_size;
+	__u32 irdma_drv_opt;
+	__u32 qp_caps;
+	__u16 rsvd1;
+	__u8 lsmm;
+	__u8 rsvd2;
+};
+
+struct i40iw_create_qp_resp {
+	__u32 qp_id;
+	__u32 actual_sq_size;
+	__u32 actual_rq_size;
+	__u32 i40iw_drv_opt;
+	__u16 push_idx;
+	__u8 lsmm;
+	__u8 rsvd;
+};
+
+struct irdma_modify_qp_resp {
+	__aligned_u64 push_wqe_mmap_key;
+	__aligned_u64 push_db_mmap_key;
+	__u16 push_offset;
+	__u8 push_valid;
+	__u8 rsvd[5];
+};
+
+struct irdma_create_ah_resp {
+	__u32 ah_id;
+	__u8 rsvd[4];
+};
+#endif /* IRDMA_ABI_H */
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
index 0000000..9887319
--- /dev/null
+++ b/providers/irdma/abi.h
@@ -0,0 +1,43 @@
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
+#define IRDMA_MAX_ABI_VERSION	6
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
+DECLARE_DRV_CMD(i40iw_ucreate_qp, IB_USER_VERBS_CMD_CREATE_QP,
+		i40iw_create_qp_req, i40iw_create_qp_resp);
+DECLARE_DRV_CMD(irdma_umodify_qp, IB_USER_VERBS_EX_CMD_MODIFY_QP,
+		empty, irdma_modify_qp_resp);
+DECLARE_DRV_CMD(irdma_get_context, IB_USER_VERBS_CMD_GET_CONTEXT,
+		irdma_alloc_ucontext_req, irdma_alloc_ucontext_resp);
+DECLARE_DRV_CMD(i40iw_get_context, IB_USER_VERBS_CMD_GET_CONTEXT,
+		i40iw_alloc_ucontext_req, i40iw_alloc_ucontext_resp);
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
-- 
1.8.3.1

