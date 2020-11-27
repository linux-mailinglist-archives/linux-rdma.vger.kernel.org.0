Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33C12C6CB3
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Nov 2020 21:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbgK0UqH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Nov 2020 15:46:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:6750 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732611AbgK0UmX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 27 Nov 2020 15:42:23 -0500
IronPort-SDR: PRQvhb9HzflRbR6oeXnlg9Sl2ckmtoeXxbhb88h7d0fCDByg0mE7HJIaKvP+bBKZIUwahS1Rgr
 Aiyybl3ximYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9818"; a="172533988"
X-IronPort-AV: E=Sophos;i="5.78,375,1599548400"; 
   d="scan'208";a="172533988"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2020 12:41:45 -0800
IronPort-SDR: OGGEj6j8XwePoQt8wvF+RjV9vgtyeyFu3CFLoZ+Js5Kfa0vhvgtLpGRUlt3qLGhIZwkLFamCPZ
 Q++/GJnehv3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,375,1599548400"; 
   d="scan'208";a="537737686"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by fmsmga005.fm.intel.com with ESMTP; 27 Nov 2020 12:41:45 -0800
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH rdma-core v3 3/6] mlx5: Support dma-buf based memory region
Date:   Fri, 27 Nov 2020 12:55:40 -0800
Message-Id: <1606510543-45567-4-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1606510543-45567-1-git-send-email-jianxin.xiong@intel.com>
References: <1606510543-45567-1-git-send-email-jianxin.xiong@intel.com>
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
index 1378acf..b3e2d57 100644
--- a/providers/mlx5/mlx5.c
+++ b/providers/mlx5/mlx5.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2012 Mellanox Technologies, Inc.  All rights reserved.
+ * Copyright (c) 2020 Intel Corporation.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -96,6 +97,7 @@ static const struct verbs_context_ops mlx5_ctx_common_ops = {
 	.async_event   = mlx5_async_event,
 	.dealloc_pd    = mlx5_free_pd,
 	.reg_mr	       = mlx5_reg_mr,
+	.reg_dmabuf_mr = mlx5_reg_dmabuf_mr,
 	.rereg_mr      = mlx5_rereg_mr,
 	.dereg_mr      = mlx5_dereg_mr,
 	.alloc_mw      = mlx5_alloc_mw,
diff --git a/providers/mlx5/mlx5.h b/providers/mlx5/mlx5.h
index 8c94f72..17a2470 100644
--- a/providers/mlx5/mlx5.h
+++ b/providers/mlx5/mlx5.h
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2012 Mellanox Technologies, Inc.  All rights reserved.
+ * Copyright (c) 2020 Intel Corporation.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -903,6 +904,8 @@ void mlx5_async_event(struct ibv_context *context,
 struct ibv_mr *mlx5_alloc_null_mr(struct ibv_pd *pd);
 struct ibv_mr *mlx5_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
 			   uint64_t hca_va, int access);
+struct ibv_mr *mlx5_reg_dmabuf_mr(struct ibv_pd *pd, uint64_t offset, size_t length,
+				  uint64_t iova, int fd, int access);
 int mlx5_rereg_mr(struct verbs_mr *mr, int flags, struct ibv_pd *pd, void *addr,
 		  size_t length, int access);
 int mlx5_dereg_mr(struct verbs_mr *mr);
diff --git a/providers/mlx5/verbs.c b/providers/mlx5/verbs.c
index b956156..a7fc3b0 100644
--- a/providers/mlx5/verbs.c
+++ b/providers/mlx5/verbs.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2012 Mellanox Technologies, Inc.  All rights reserved.
+ * Copyright (c) 2020 Intel Corporation.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -647,6 +648,27 @@ struct ibv_mr *mlx5_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
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

