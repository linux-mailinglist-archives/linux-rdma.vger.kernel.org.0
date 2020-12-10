Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258842D6656
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Dec 2020 20:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388801AbgLJTXf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Dec 2020 14:23:35 -0500
Received: from mga09.intel.com ([134.134.136.24]:9406 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728092AbgLJTXc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Dec 2020 14:23:32 -0500
IronPort-SDR: m/KGuyjUkjfWQtRCkAXGKoPI5TOfhU/W9YKLf7NO4j44vLRj20Qn4gykkUT5XNGylhpN97weIS
 4bUXqRknipZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="174463537"
X-IronPort-AV: E=Sophos;i="5.78,409,1599548400"; 
   d="scan'208";a="174463537"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 11:22:25 -0800
IronPort-SDR: M7b6NYlYOE1u+oUIDSPR4+UIhipYQI0OC2bxMhzThtRf62Z2pzrjkBNAEJAwwpA78EOalBu02+
 yDNDyQNrtP2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,409,1599548400"; 
   d="scan'208";a="376061605"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by orsmga007.jf.intel.com with ESMTP; 10 Dec 2020 11:22:25 -0800
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH v15 2/4] RDMA/core: Add device method for registering dma-buf based memory region
Date:   Thu, 10 Dec 2020 11:37:36 -0800
Message-Id: <1607629058-141952-3-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1607629058-141952-1-git-send-email-jianxin.xiong@intel.com>
References: <1607629058-141952-1-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Dma-buf based memory region requires one extra parameter and is processed
quite differently. Adding a separate method allows clean separation from
regular memory regions.

Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
Reviewed-by: Sean Hefty <sean.hefty@intel.com>
Acked-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Acked-by: Christian Koenig <christian.koenig@amd.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/device.c | 1 +
 include/rdma/ib_verbs.h          | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 3ab1ede..23f7440 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2677,6 +2677,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, read_counters);
 	SET_DEVICE_OP(dev_ops, reg_dm_mr);
 	SET_DEVICE_OP(dev_ops, reg_user_mr);
+	SET_DEVICE_OP(dev_ops, reg_user_mr_dmabuf);
 	SET_DEVICE_OP(dev_ops, req_ncomp_notif);
 	SET_DEVICE_OP(dev_ops, req_notify_cq);
 	SET_DEVICE_OP(dev_ops, rereg_user_mr);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 06a5652..b2f02a7 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2,7 +2,7 @@
 /*
  * Copyright (c) 2004 Mellanox Technologies Ltd.  All rights reserved.
  * Copyright (c) 2004 Infinicon Corporation.  All rights reserved.
- * Copyright (c) 2004 Intel Corporation.  All rights reserved.
+ * Copyright (c) 2004, 2020 Intel Corporation.  All rights reserved.
  * Copyright (c) 2004 Topspin Corporation.  All rights reserved.
  * Copyright (c) 2004 Voltaire Corporation.  All rights reserved.
  * Copyright (c) 2005 Sun Microsystems, Inc. All rights reserved.
@@ -2433,6 +2433,10 @@ struct ib_device_ops {
 	struct ib_mr *(*reg_user_mr)(struct ib_pd *pd, u64 start, u64 length,
 				     u64 virt_addr, int mr_access_flags,
 				     struct ib_udata *udata);
+	struct ib_mr *(*reg_user_mr_dmabuf)(struct ib_pd *pd, u64 offset,
+					    u64 length, u64 virt_addr, int fd,
+					    int mr_access_flags,
+					    struct ib_udata *udata);
 	struct ib_mr *(*rereg_user_mr)(struct ib_mr *mr, int flags, u64 start,
 				       u64 length, u64 virt_addr,
 				       int mr_access_flags, struct ib_pd *pd,
-- 
1.8.3.1

