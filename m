Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0A82D248E
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Dec 2020 08:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbgLHHgr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Dec 2020 02:36:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:50590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgLHHgr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Dec 2020 02:36:47 -0500
From:   Leon Romanovsky <leon@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 1/3] RDMA/core: Clean up cq pool mechanism
Date:   Tue,  8 Dec 2020 09:35:43 +0200
Message-Id: <20201208073545.9723-2-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201208073545.9723-1-leon@kernel.org>
References: <20201208073545.9723-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Morgenstein <jackm@dev.mellanox.co.il>

The CQ pool mechanism had two problems:
1. The CQ pool lists were uninitialized in the device registration
   error flow.  As a result, all the list pointers remained NULL.
   This caused the kernel to crash (in procedure ib_cq_pool_destroy)
   when that error flow was taken (and unregister called).
   The stack trace snippet:
   [ 4162.222276] BUG: kernel NULL pointer dereference, address: 0000000000000000
   [ 4162.222693] #PF: supervisor read access in kernel mode
   [ 4162.223184] #PF: error_code(0×0000) ? not-present page
   [ 4162.223602] PGD 0 P4D 0
   [ 4162.224060] Oops: 0000 [#1] SMP PTI
   . . .
   [ 4162.225312] RIP: 0010:ib_cq_pool_destroy+0x1b/0×70 [ib_core]
   . . .
   [ 4162.230853] Call Trace:
   [ 4162.231345]  disable_device+0x9f/0×130 [ib_core]
   [ 4162.232309]  __ib_unregister_device+0x35/0×90 [ib_core]
   [ 4162.232786]  ib_register_device+0x529/0×610 [ib_core]
   [ 4162.234259]  __mlx5_ib_add+0x3a/0×70 [mlx5_ib]
   [ 4162.234747]  mlx5_add_device+0x87/0×1c0 [mlx5_core]
   [ 4162.235263]  mlx5_register_interface+0x74/0xc0 [mlx5_core]
   [ 4162.236253]  do_one_initcall+0x4b/0×1f4
   [ 4162.237660]  do_init_module+0x5a/0×223
   [ 4162.238148]  load_module+0x1938/0×1d40

2. At device unregister, when cleaning up the cq pool, the cq's in the
   pool lists were freed, but the cq entries were left in the list.

The fix for the first issue is to initialize the cq pool lists when
the ib_device structure is allocated for a new device (in procedure
_ib_alloc_device).

The fix for the second problem is to delete cq entries from the pool
lists when cleaning up the cq pool.

In addition, procedure ib_cq_pool_destroy() is renamed to the more
appropriate name ib_cq_pool_cleanup().

Fixes: 4aa1615268a8 ("RDMA/core: Fix ordering of CQ pool destruction")
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/core_priv.h |  3 +--
 drivers/infiniband/core/cq.c        | 12 ++----------
 drivers/infiniband/core/device.c    |  9 ++++++---
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index f905c5a6456a..aec7005d4bbf 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -410,7 +410,6 @@ void rdma_umap_priv_init(struct rdma_umap_priv *priv,
 			 struct vm_area_struct *vma,
 			 struct rdma_user_mmap_entry *entry);
 
-void ib_cq_pool_init(struct ib_device *dev);
-void ib_cq_pool_destroy(struct ib_device *dev);
+void ib_cq_pool_cleanup(struct ib_device *dev);
 
 #endif /* _CORE_PRIV_H */
diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index f357cf59333a..03c0641c65ce 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -364,16 +364,7 @@ void ib_free_cq(struct ib_cq *cq)
 }
 EXPORT_SYMBOL(ib_free_cq);
 
-void ib_cq_pool_init(struct ib_device *dev)
-{
-	unsigned int i;
-
-	spin_lock_init(&dev->cq_pools_lock);
-	for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++)
-		INIT_LIST_HEAD(&dev->cq_pools[i]);
-}
-
-void ib_cq_pool_destroy(struct ib_device *dev)
+void ib_cq_pool_cleanup(struct ib_device *dev)
 {
 	struct ib_cq *cq, *n;
 	unsigned int i;
@@ -382,6 +373,7 @@ void ib_cq_pool_destroy(struct ib_device *dev)
 		list_for_each_entry_safe(cq, n, &dev->cq_pools[i],
 					 pool_entry) {
 			WARN_ON(cq->cqe_used);
+			list_del(&cq->pool_entry);
 			cq->shared = false;
 			ib_free_cq(cq);
 		}
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 3ab1edea6acb..11485b8748a2 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -570,6 +570,7 @@ static void rdma_init_coredev(struct ib_core_device *coredev,
 struct ib_device *_ib_alloc_device(size_t size)
 {
 	struct ib_device *device;
+	unsigned int i;
 
 	if (WARN_ON(size < sizeof(struct ib_device)))
 		return NULL;
@@ -601,6 +602,10 @@ struct ib_device *_ib_alloc_device(size_t size)
 	init_completion(&device->unreg_completion);
 	INIT_WORK(&device->unregistration_work, ib_unregister_work);
 
+	spin_lock_init(&device->cq_pools_lock);
+	for (i = 0; i < ARRAY_SIZE(device->cq_pools); i++)
+		INIT_LIST_HEAD(&device->cq_pools[i]);
+
 	device->uverbs_cmd_mask =
 		BIT_ULL(IB_USER_VERBS_CMD_ALLOC_MW) |
 		BIT_ULL(IB_USER_VERBS_CMD_ALLOC_PD) |
@@ -1262,7 +1267,7 @@ static void disable_device(struct ib_device *device)
 		remove_client_context(device, cid);
 	}
 
-	ib_cq_pool_destroy(device);
+	ib_cq_pool_cleanup(device);
 
 	/* Pairs with refcount_set in enable_device */
 	ib_device_put(device);
@@ -1307,8 +1312,6 @@ static int enable_device_and_get(struct ib_device *device)
 			goto out;
 	}
 
-	ib_cq_pool_init(device);
-
 	down_read(&clients_rwsem);
 	xa_for_each_marked (&clients, index, client, CLIENT_REGISTERED) {
 		ret = add_client_context(device, client);
-- 
2.28.0

