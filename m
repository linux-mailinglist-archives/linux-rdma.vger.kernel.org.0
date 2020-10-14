Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257C528E3DC
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Oct 2020 18:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgJNQBo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Oct 2020 12:01:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:44281 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727034AbgJNQBn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 14 Oct 2020 12:01:43 -0400
IronPort-SDR: Sp6Iw2rbHn18wJfaBuVJlsTzoNSoloxck5QXhZ9u03Flq0WqUF729YzslY5/3wj0ATx6XY/2/S
 mkZKmx9ozIqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="153075436"
X-IronPort-AV: E=Sophos;i="5.77,375,1596524400"; 
   d="scan'208";a="153075436"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 09:01:24 -0700
IronPort-SDR: fYwJqAlDgkKX1DKUzGR4rICwG/GvP5YUGSKxJPTssGlGS0lO5YJCbP1xkECuzQ4Vb4uLog4Dm4
 5K2EYBaMKXmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,375,1596524400"; 
   d="scan'208";a="521471611"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by fmsmga005.fm.intel.com with ESMTP; 14 Oct 2020 09:01:23 -0700
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH v4 2/5] RDMA/core: Add device method for registering dma-buf base memory region
Date:   Wed, 14 Oct 2020 09:15:33 -0700
Message-Id: <1602692133-106979-1-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
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
---
 drivers/infiniband/core/device.c | 1 +
 include/rdma/ib_verbs.h          | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index feaec8d..d6cd0ac 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2653,6 +2653,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, read_counters);
 	SET_DEVICE_OP(dev_ops, reg_dm_mr);
 	SET_DEVICE_OP(dev_ops, reg_user_mr);
+	SET_DEVICE_OP(dev_ops, reg_user_mr_dmabuf);
 	SET_DEVICE_OP(dev_ops, req_ncomp_notif);
 	SET_DEVICE_OP(dev_ops, req_notify_cq);
 	SET_DEVICE_OP(dev_ops, rereg_user_mr);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9bf6c31..48bab74 100644
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
@@ -2429,6 +2429,10 @@ struct ib_device_ops {
 	struct ib_mr *(*reg_user_mr)(struct ib_pd *pd, u64 start, u64 length,
 				     u64 virt_addr, int mr_access_flags,
 				     struct ib_udata *udata);
+	struct ib_mr *(*reg_user_mr_dmabuf)(struct ib_pd *pd, u64 start,
+				     u64 length, u64 virt_addr, int dmabuf_fd,
+				     int mr_access_flags,
+				     struct ib_udata *udata);
 	int (*rereg_user_mr)(struct ib_mr *mr, int flags, u64 start, u64 length,
 			     u64 virt_addr, int mr_access_flags,
 			     struct ib_pd *pd, struct ib_udata *udata);
-- 
1.8.3.1

