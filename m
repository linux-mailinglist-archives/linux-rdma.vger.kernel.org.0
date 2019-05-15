Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4B501EC5C
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 12:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfEOKtg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 06:49:36 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:34531 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726392AbfEOKtf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 May 2019 06:49:35 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 15 May 2019 13:49:32 +0300
Received: from r-vnc08.mtr.labs.mlnx (r-vnc08.mtr.labs.mlnx [10.208.0.121])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x4FAnVKS025252;
        Wed, 15 May 2019 13:49:32 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-rdma@vger.kernel.org, leon@kernel.org, jgg@mellanox.com,
        dledford@redhat.com
Cc:     hch@lst.de, sagi@grimberg.me, maxg@mellanox.com,
        israelr@mellanox.com
Subject: [PATCH 7/7] RDMA/core: Fix doc typo
Date:   Wed, 15 May 2019 13:49:31 +0300
Message-Id: <1557917371-8777-8-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1557917371-8777-1-git-send-email-maxg@mellanox.com>
References: <1557917371-8777-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Israel Rukshin <israelr@mellanox.com>

Use the correct function names.

Fixes: c4367a26357b (IB: Pass uverbs_attr_bundle down ib_x destroy path)
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/core/cq.c    | 4 ++--
 drivers/infiniband/core/verbs.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index a4c81992267c..cb72aa4985a4 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -121,7 +121,7 @@ static void ib_cq_completion_workqueue(struct ib_cq *cq, void *private)
 }
 
 /**
- * __ib_alloc_cq - allocate a completion queue
+ * __ib_alloc_cq_user - allocate a completion queue
  * @dev:		device to allocate the CQ for
  * @private:		driver private data, accessible from cq->cq_context
  * @nr_cqe:		number of CQEs to allocate
@@ -201,7 +201,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
 EXPORT_SYMBOL(__ib_alloc_cq_user);
 
 /**
- * ib_free_cq - free a completion queue
+ * ib_free_cq_user - free a completion queue
  * @cq:		completion queue to free.
  * @udata:	User data or NULL for kernel object
  */
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index e666a1f7608d..4fd5aad890d2 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -316,7 +316,7 @@ struct ib_pd *__ib_alloc_pd(struct ib_device *device, unsigned int flags,
 EXPORT_SYMBOL(__ib_alloc_pd);
 
 /**
- * ib_dealloc_pd - Deallocates a protection domain.
+ * ib_dealloc_pd_user - Deallocates a protection domain.
  * @pd: The protection domain to deallocate.
  * @udata: Valid user data or NULL for kernel object
  *
@@ -1981,7 +1981,7 @@ int ib_dereg_mr_user(struct ib_mr *mr, struct ib_udata *udata)
 EXPORT_SYMBOL(ib_dereg_mr_user);
 
 /**
- * ib_alloc_mr() - Allocates a memory region
+ * ib_alloc_mr_user() - Allocates a memory region
  * @pd:            protection domain associated with the region
  * @mr_type:       memory region type
  * @max_num_sg:    maximum sg entries available for registration.
-- 
2.16.3

