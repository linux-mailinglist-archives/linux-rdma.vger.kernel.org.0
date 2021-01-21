Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6802FDE7E
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 02:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731864AbhAUBAk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jan 2021 20:00:40 -0500
Received: from mga02.intel.com ([134.134.136.20]:2132 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387765AbhAUAF3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Jan 2021 19:05:29 -0500
IronPort-SDR: lfwFhOwf3rj64Bot91yvxuT5/tXW10YqFrrXYM6ZbDvjRVANWWYVB/F/PGmP8sHgDdjnu/dMPT
 c0ByOBNLu2hw==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="166291171"
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="166291171"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 15:59:43 -0800
IronPort-SDR: unPqcIQ4/Ulgq2IbYKuVMaKgecUqM1y+lRKKT0yBq0oBTTQkP6kJcXaV2HVspgyCRpc2YPJoaZ
 D3c9/PQ0HNSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="570551140"
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
Subject: [PATCH rdma-core v6 1/6] Update kernel headers
Date:   Wed, 20 Jan 2021 16:14:33 -0800
Message-Id: <1611188078-119233-2-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1611188078-119233-1-git-send-email-jianxin.xiong@intel.com>
References: <1611188078-119233-1-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To commit 2eef437c4669 ("RDMA/uverbs: Add uverbs command for dma-buf based
MR registration").

Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
---
 kernel-headers/rdma/ib_user_ioctl_cmds.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel-headers/rdma/ib_user_ioctl_cmds.h b/kernel-headers/rdma/ib_user_ioctl_cmds.h
index 7968a18..dafc7eb 100644
--- a/kernel-headers/rdma/ib_user_ioctl_cmds.h
+++ b/kernel-headers/rdma/ib_user_ioctl_cmds.h
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2018, Mellanox Technologies inc.  All rights reserved.
+ * Copyright (c) 2020, Intel Corporation. All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -251,6 +252,7 @@ enum uverbs_methods_mr {
 	UVERBS_METHOD_MR_DESTROY,
 	UVERBS_METHOD_ADVISE_MR,
 	UVERBS_METHOD_QUERY_MR,
+	UVERBS_METHOD_REG_DMABUF_MR,
 };
 
 enum uverbs_attrs_mr_destroy_ids {
@@ -272,6 +274,18 @@ enum uverbs_attrs_query_mr_cmd_attr_ids {
 	UVERBS_ATTR_QUERY_MR_RESP_IOVA,
 };
 
+enum uverbs_attrs_reg_dmabuf_mr_cmd_attr_ids {
+	UVERBS_ATTR_REG_DMABUF_MR_HANDLE,
+	UVERBS_ATTR_REG_DMABUF_MR_PD_HANDLE,
+	UVERBS_ATTR_REG_DMABUF_MR_OFFSET,
+	UVERBS_ATTR_REG_DMABUF_MR_LENGTH,
+	UVERBS_ATTR_REG_DMABUF_MR_IOVA,
+	UVERBS_ATTR_REG_DMABUF_MR_FD,
+	UVERBS_ATTR_REG_DMABUF_MR_ACCESS_FLAGS,
+	UVERBS_ATTR_REG_DMABUF_MR_RESP_LKEY,
+	UVERBS_ATTR_REG_DMABUF_MR_RESP_RKEY,
+};
+
 enum uverbs_attrs_create_counters_cmd_attr_ids {
 	UVERBS_ATTR_CREATE_COUNTERS_HANDLE,
 };
-- 
1.8.3.1

