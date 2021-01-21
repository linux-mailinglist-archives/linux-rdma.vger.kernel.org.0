Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBD02FDE59
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 02:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbhAUBAU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jan 2021 20:00:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:2132 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731693AbhAUADO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Jan 2021 19:03:14 -0500
IronPort-SDR: s/TjkbPXuY1HVItd/3x8xRz62bSn1EvYawDueTsZnAz65OTdP7VX3tr//dYd8wJKtWW0R1aKAx
 86tCg0WuwbAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="166291175"
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="166291175"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 15:59:43 -0800
IronPort-SDR: x1Pl7gpTCrLLXkpLLdqATfL20OwpwvNX44jbEU3AO8meOl2uGfb2Rg8bkckpZIMqCfpjF5hmMm
 pB+xJVgPn/5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="570551145"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by orsmga005.jf.intel.com with ESMTP; 20 Jan 2021 15:59:41 -0800
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Edward Srouji <edwards@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-core v6 3/6] mlx5: Support dma-buf based memory region
Date:   Wed, 20 Jan 2021 16:14:35 -0800
Message-Id: <1611188078-119233-4-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1611188078-119233-1-git-send-email-jianxin.xiong@intel.com>
References: <1611188078-119233-1-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Implement the new provider method for registering dma-buf based memory
regions.

Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
---
 providers/mlx5/mlx5.c  |  2 ++
 providers/mlx5/mlx5.h  |  3 +++
 providers/mlx5/verbs.c | 22 ++++++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/providers/mlx5/mlx5.c b/providers/mlx5/mlx5.c
index a2a1696..b3c49af 100644
--- a/providers/mlx5/mlx5.c
+++ b/providers/mlx5/mlx5.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2012 Mellanox Technologies, Inc.  All rights reserved.
+ * Copyright (c) 2020 Intel Corporation.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -95,6 +96,7 @@ static const struct verbs_context_ops mlx5_ctx_common_ops = {
 	.async_event   = mlx5_async_event,
 	.dealloc_pd    = mlx5_free_pd,
 	.reg_mr	       = mlx5_reg_mr,
+	.reg_dmabuf_mr = mlx5_reg_dmabuf_mr,
 	.rereg_mr      = mlx5_rereg_mr,
 	.dereg_mr      = mlx5_dereg_mr,
 	.alloc_mw      = mlx5_alloc_mw,
diff --git a/providers/mlx5/mlx5.h b/providers/mlx5/mlx5.h
index bafe077..decc7f8 100644
--- a/providers/mlx5/mlx5.h
+++ b/providers/mlx5/mlx5.h
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2012 Mellanox Technologies, Inc.  All rights reserved.
+ * Copyright (c) 2020 Intel Corporation.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -941,6 +942,8 @@ void mlx5_async_event(struct ibv_context *context,
 struct ibv_mr *mlx5_alloc_null_mr(struct ibv_pd *pd);
 struct ibv_mr *mlx5_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
 			   uint64_t hca_va, int access);
+struct ibv_mr *mlx5_reg_dmabuf_mr(struct ibv_pd *pd, uint64_t offset, size_t length,
+				  uint64_t iova, int fd, int access);
 int mlx5_rereg_mr(struct verbs_mr *mr, int flags, struct ibv_pd *pd, void *addr,
 		  size_t length, int access);
 int mlx5_dereg_mr(struct verbs_mr *mr);
diff --git a/providers/mlx5/verbs.c b/providers/mlx5/verbs.c
index b2391e8..cc0bc42 100644
--- a/providers/mlx5/verbs.c
+++ b/providers/mlx5/verbs.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2012 Mellanox Technologies, Inc.  All rights reserved.
+ * Copyright (c) 2020 Intel Corporation.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -626,6 +627,27 @@ struct ibv_mr *mlx5_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
 	return &mr->vmr.ibv_mr;
 }
 
+struct ibv_mr *mlx5_reg_dmabuf_mr(struct ibv_pd *pd, uint64_t offset, size_t length,
+				  uint64_t iova, int fd, int acc)
+{
+	struct mlx5_mr *mr;
+	int ret;
+
+	mr = calloc(1, sizeof(*mr));
+	if (!mr)
+		return NULL;
+
+	ret = ibv_cmd_reg_dmabuf_mr(pd, offset, length, iova, fd, acc,
+				    &mr->vmr);
+	if (ret) {
+		free(mr);
+		return NULL;
+	}
+	mr->alloc_flags = acc;
+
+	return &mr->vmr.ibv_mr;
+}
+
 struct ibv_mr *mlx5_alloc_null_mr(struct ibv_pd *pd)
 {
 	struct mlx5_mr *mr;
-- 
1.8.3.1

