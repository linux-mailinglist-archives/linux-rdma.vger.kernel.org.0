Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF4828FADA
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Oct 2020 23:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbgJOVsj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Oct 2020 17:48:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:48800 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731632AbgJOVsj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Oct 2020 17:48:39 -0400
IronPort-SDR: uUKYaD49SCtX1gaC9z4WqeJOFwaRh4sGVdr/krubTmPTeHkUpj586unVdshXtDqbPbMCwS4baS
 RQ+pihPLde3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="162995490"
X-IronPort-AV: E=Sophos;i="5.77,380,1596524400"; 
   d="scan'208";a="162995490"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 14:48:39 -0700
IronPort-SDR: GptQWj41RzybP8sQrXIC1goAgkGOLxWeJddmHzIEFPm0JhiybKXFxoqMrIpjDuTxHb+glL2Jyb
 Ox8VgvoEbhGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,380,1596524400"; 
   d="scan'208";a="319188322"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by orsmga006.jf.intel.com with ESMTP; 15 Oct 2020 14:48:39 -0700
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH v5 2/5] RDMA/core: Add device method for registering dma-buf base memory region
Date:   Thu, 15 Oct 2020 15:02:51 -0700
Message-Id: <1602799371-138238-1-git-send-email-jianxin.xiong@intel.com>
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
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
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

