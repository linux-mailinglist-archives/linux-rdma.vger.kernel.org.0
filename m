Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2912D1CA1
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Dec 2020 23:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgLGWBm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Dec 2020 17:01:42 -0500
Received: from mga17.intel.com ([192.55.52.151]:10636 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgLGWBm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Dec 2020 17:01:42 -0500
IronPort-SDR: FanlUTsAPzz6ob/rqZk1nrLuGNYej3bLlhjcC2PuWlHkJOcLosoZ0HY06BfXCtzjJH/5947S6x
 7lPymDlMZL1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="153596070"
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="153596070"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 14:00:30 -0800
IronPort-SDR: dzZphDT55CB5bs4o4eVdC5851L/5keu59RkUCjO9vxRZ8VMjz9HJ5cHrdsVffTO5R+Btfc16oQ
 X4ZB0PzVYSKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="374912730"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by orsmga007.jf.intel.com with ESMTP; 07 Dec 2020 14:00:29 -0800
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH v13 2/4] RDMA/core: Add device method for registering dma-buf based memory region
Date:   Mon,  7 Dec 2020 14:15:51 -0800
Message-Id: <1607379353-116215-3-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1607379353-116215-1-git-send-email-jianxin.xiong@intel.com>
References: <1607379353-116215-1-git-send-email-jianxin.xiong@intel.com>
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
index 7bee8ab..fa3882b 100644
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
+				     u64 length, u64 virt_addr, int fd,
+				     int mr_access_flags,
+				     struct ib_udata *udata);
 	int (*rereg_user_mr)(struct ib_mr *mr, int flags, u64 start, u64 length,
 			     u64 virt_addr, int mr_access_flags,
 			     struct ib_pd *pd, struct ib_udata *udata);
-- 
1.8.3.1

