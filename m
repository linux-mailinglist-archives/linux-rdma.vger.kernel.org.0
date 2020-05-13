Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133231D11D8
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 13:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbgEMLxR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 07:53:17 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:53761 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725982AbgEMLxQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 May 2020 07:53:16 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yaminf@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 13 May 2020 14:52:55 +0300
Received: from arch012.mtl.labs.mlnx. (arch012.mtl.labs.mlnx [10.7.13.12])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 04DBqs6g006542;
        Wed, 13 May 2020 14:52:54 +0300
From:   Yamin Friedman <yaminf@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Yamin Friedman <yaminf@mellanox.com>
Subject: [PATCH V2 2/4] RDMA/core: Introduce shared CQ pool API
Date:   Wed, 13 May 2020 14:52:41 +0300
Message-Id: <1589370763-81205-3-git-send-email-yaminf@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1589370763-81205-1-git-send-email-yaminf@mellanox.com>
References: <1589370763-81205-1-git-send-email-yaminf@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Allow a ULP to ask the core to provide a completion queue based on a
least-used search on a per-device CQ pools. The device CQ pools grow in a
lazy fashion when more CQs are requested.

This feature reduces the amount of interrupts when using many QPs.
Using shared CQs allows for more effcient completion handling. It also
reduces the amount of overhead needed for CQ contexts.

Test setup:
Intel(R) Xeon(R) Platinum 8176M CPU @ 2.10GHz servers.
Running NVMeoF 4KB read IOs over ConnectX-5EX across Spectrum switch.
TX-depth = 32. The patch was applied in the nvme driver on both the target
and initiator. Four controllers are accessed from each core. In the
current test case we have exposed sixteen NVMe namespaces using four
different subsystems (four namespaces per subsystem) from one NVM port.
Each controller allocated X queues (RDMA QPs) and attached to Y CQs.
Before this series we had X == Y, i.e for four controllers we've created
total of 4X QPs and 4X CQs. In the shared case, we've created 4X QPs and
only X CQs which means that we have four controllers that share a
completion queue per core. Until fourteen cores there is no significant
change in performance and the number of interrupts per second is less than
a million in the current case.
==================================================
|Cores|Current KIOPs  |Shared KIOPs  |improvement|
|-----|---------------|--------------|-----------|
|14   |2332           |2723          |16.7%      |
|-----|---------------|--------------|-----------|
|20   |2086           |2712          |30%        |
|-----|---------------|--------------|-----------|
|28   |1971           |2669          |35.4%      |
|=================================================
|Cores|Current avg lat|Shared avg lat|improvement|
|-----|---------------|--------------|-----------|
|14   |767us          |657us         |14.3%      |
|-----|---------------|--------------|-----------|
|20   |1225us         |943us         |23%        |
|-----|---------------|--------------|-----------|
|28   |1816us         |1341us        |26.1%      |
========================================================
|Cores|Current interrupts|Shared interrupts|improvement|
|-----|------------------|-----------------|-----------|
|14   |1.6M/sec          |0.4M/sec         |72%        |
|-----|------------------|-----------------|-----------|
|20   |2.8M/sec          |0.6M/sec         |72.4%      |
|-----|------------------|-----------------|-----------|
|28   |2.9M/sec          |0.8M/sec         |63.4%      |
====================================================================
|Cores|Current 99.99th PCTL lat|Shared 99.99th PCTL lat|improvement|
|-----|------------------------|-----------------------|-----------|
|14   |67ms                    |6ms                    |90.9%      |
|-----|------------------------|-----------------------|-----------|
|20   |5ms                     |6ms                    |-10%       |
|-----|------------------------|-----------------------|-----------|
|28   |8.7ms                   |6ms                    |25.9%      |
|===================================================================

Performance improvement with sixteen disks (sixteen CQs per core) is
comparable.

Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/core/core_priv.h |   4 ++
 drivers/infiniband/core/cq.c        | 137 ++++++++++++++++++++++++++++++++++++
 drivers/infiniband/core/device.c    |   2 +
 include/rdma/ib_verbs.h             |  35 +++++++++
 4 files changed, 178 insertions(+)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index cf42acc..fa3151b 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -414,4 +414,8 @@ void rdma_umap_priv_init(struct rdma_umap_priv *priv,
 			 struct vm_area_struct *vma,
 			 struct rdma_user_mmap_entry *entry);
 
+void ib_cq_pool_init(struct ib_device *dev);
+
+void ib_cq_pool_destroy(struct ib_device *dev);
+
 #endif /* _CORE_PRIV_H */
diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index 04046eb..5319c14 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -7,7 +7,11 @@
 #include <linux/slab.h>
 #include <rdma/ib_verbs.h>
 
+#include "core_priv.h"
+
 #include <trace/events/rdma_core.h>
+/* Max size for shared CQ, may require tuning */
+#define IB_MAX_SHARED_CQ_SZ		4096
 
 /* # of WCs to poll for with a single call to ib_poll_cq */
 #define IB_POLL_BATCH			16
@@ -218,6 +222,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
 	cq->cq_context = private;
 	cq->poll_ctx = poll_ctx;
 	atomic_set(&cq->usecnt, 0);
+	cq->comp_vector = comp_vector;
 
 	cq->wc = kmalloc_array(IB_POLL_BATCH, sizeof(*cq->wc), GFP_KERNEL);
 	if (!cq->wc)
@@ -304,6 +309,8 @@ static void _ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 {
 	if (WARN_ON_ONCE(atomic_read(&cq->usecnt)))
 		return;
+	if (WARN_ON_ONCE(cq->cqe_used != 0))
+		return;
 
 	switch (cq->poll_ctx) {
 	case IB_POLL_DIRECT:
@@ -340,3 +347,133 @@ void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 		_ib_free_cq_user(cq, udata);
 }
 EXPORT_SYMBOL(ib_free_cq_user);
+
+void ib_cq_pool_init(struct ib_device *dev)
+{
+	int i;
+
+	spin_lock_init(&dev->cq_pools_lock);
+	for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++)
+		INIT_LIST_HEAD(&dev->cq_pools[i]);
+}
+
+void ib_cq_pool_destroy(struct ib_device *dev)
+{
+	struct ib_cq *cq, *n;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++) {
+		list_for_each_entry_safe(cq, n, &dev->cq_pools[i], pool_entry)
+			_ib_free_cq_user(cq, NULL);
+	}
+
+}
+
+static int ib_alloc_cqs(struct ib_device *dev, int nr_cqes,
+			enum ib_poll_context poll_ctx)
+{
+	LIST_HEAD(tmp_list);
+	struct ib_cq *cq;
+	unsigned long flags;
+	int nr_cqs, ret, i;
+
+	/*
+	 * Allocated at least as many CQEs as requested, and otherwise
+	 * a reasonable batch size so that we can share CQs between
+	 * multiple users instead of allocating a larger number of CQs.
+	 */
+	nr_cqes = min(dev->attrs.max_cqe, max(nr_cqes, IB_MAX_SHARED_CQ_SZ));
+	nr_cqs = min_t(int, dev->num_comp_vectors, num_online_cpus());
+	for (i = 0; i < nr_cqs; i++) {
+		cq = ib_alloc_cq(dev, NULL, nr_cqes, i, poll_ctx);
+		if (IS_ERR(cq)) {
+			ret = PTR_ERR(cq);
+			goto out_free_cqs;
+		}
+		cq->shared = true;
+		list_add_tail(&cq->pool_entry, &tmp_list);
+	}
+
+	spin_lock_irqsave(&dev->cq_pools_lock, flags);
+	list_splice(&tmp_list, &dev->cq_pools[poll_ctx - 1]);
+	spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
+
+	return 0;
+
+out_free_cqs:
+	list_for_each_entry(cq, &tmp_list, pool_entry)
+		ib_free_cq(cq);
+	return ret;
+}
+
+struct ib_cq *ib_cq_pool_get(struct ib_device *dev, unsigned int nr_cqe,
+			     int comp_vector_hint,
+			     enum ib_poll_context poll_ctx)
+{
+	static unsigned int default_comp_vector;
+	int vector, ret, num_comp_vectors;
+	struct ib_cq *cq, *found = NULL;
+	unsigned long flags;
+
+	if (poll_ctx > ARRAY_SIZE(dev->cq_pools) || poll_ctx == IB_POLL_DIRECT)
+		return ERR_PTR(-EINVAL);
+
+	num_comp_vectors = min_t(int, dev->num_comp_vectors,
+				 num_online_cpus());
+	/* Project the affinty to the device completion vector range */
+	if (comp_vector_hint < 0)
+		vector = default_comp_vector++ % num_comp_vectors;
+	else
+		vector = comp_vector_hint % num_comp_vectors;
+
+	/*
+	 * Find the least used CQ with correct affinity and
+	 * enough free CQ entries
+	 */
+	while (!found) {
+		spin_lock_irqsave(&dev->cq_pools_lock, flags);
+		list_for_each_entry(cq, &dev->cq_pools[poll_ctx - 1],
+				    pool_entry) {
+			if (vector != cq->comp_vector)
+				continue;
+			if (cq->cqe_used + nr_cqe > cq->cqe)
+				continue;
+			if (found && cq->cqe_used >= found->cqe_used)
+				continue;
+			found = cq;
+			break;
+		}
+
+		if (found) {
+			found->cqe_used += nr_cqe;
+			spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
+
+			return found;
+		}
+		spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
+
+		/*
+		 * Didn't find a match or ran out of CQs in the device
+		 * pool, allocate a new array of CQs.
+		 */
+		ret = ib_alloc_cqs(dev, nr_cqe, poll_ctx);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
+	return found;
+}
+EXPORT_SYMBOL(ib_cq_pool_get);
+
+void ib_cq_pool_put(struct ib_cq *cq, unsigned int nr_cqe)
+{
+	unsigned long flags;
+
+	if (nr_cqe > cq->cqe_used)
+		return;
+
+	spin_lock_irqsave(&cq->device->cq_pools_lock, flags);
+	cq->cqe_used -= nr_cqe;
+	spin_unlock_irqrestore(&cq->device->cq_pools_lock, flags);
+}
+EXPORT_SYMBOL(ib_cq_pool_put);
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index d9f565a..abd7cd0 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -600,6 +600,7 @@ struct ib_device *_ib_alloc_device(size_t size)
 	mutex_init(&device->compat_devs_mutex);
 	init_completion(&device->unreg_completion);
 	INIT_WORK(&device->unregistration_work, ib_unregister_work);
+	ib_cq_pool_init(device);
 
 	return device;
 }
@@ -1455,6 +1456,7 @@ static void __ib_unregister_device(struct ib_device *ib_dev)
 	device_del(&ib_dev->dev);
 	ib_device_unregister_rdmacg(ib_dev);
 	ib_cache_cleanup_one(ib_dev);
+	ib_cq_pool_destroy(ib_dev);
 
 	/*
 	 * Drivers using the new flow may not call ib_dealloc_device except
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index b79737b..0ca6617 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1555,6 +1555,7 @@ enum ib_poll_context {
 	IB_POLL_SOFTIRQ,	   /* poll from softirq context */
 	IB_POLL_WORKQUEUE,	   /* poll from workqueue */
 	IB_POLL_UNBOUND_WORKQUEUE, /* poll from unbound workqueue */
+	IB_POLL_LAST,
 };
 
 struct ib_cq {
@@ -1564,9 +1565,12 @@ struct ib_cq {
 	void                  (*event_handler)(struct ib_event *, void *);
 	void                   *cq_context;
 	int               	cqe;
+	int			cqe_used;
 	atomic_t          	usecnt; /* count number of work queues */
 	enum ib_poll_context	poll_ctx;
+	int                     comp_vector;
 	struct ib_wc		*wc;
+	struct list_head        pool_entry;
 	union {
 		struct irq_poll		iop;
 		struct work_struct	work;
@@ -2695,6 +2699,10 @@ struct ib_device {
 #endif
 
 	u32                          index;
+
+	spinlock_t                   cq_pools_lock;
+	struct list_head             cq_pools[IB_POLL_LAST - 1];
+
 	struct rdma_restrack_root *res;
 
 	const struct uapi_definition   *driver_def;
@@ -3957,6 +3965,33 @@ static inline int ib_req_notify_cq(struct ib_cq *cq,
 	return cq->device->ops.req_notify_cq(cq, flags);
 }
 
+/*
+ * ib_cq_pool_get() - Find the least used completion queue that matches
+ *     a given cpu hint (or least used for wild card affinity)
+ *     and fits nr_cqe
+ * @dev: rdma device
+ * @nr_cqe: number of needed cqe entries
+ * @comp_vector_hint: completion vector hint (-1) for the driver to assign
+ *   a comp vector based on internal counter
+ * @poll_ctx: cq polling context
+ *
+ * Finds a cq that satisfies @comp_vector_hint and @nr_cqe requirements and
+ * claim entries in it for us. In case there is no available cq, allocate
+ * a new cq with the requirements and add it to the device pool.
+ * IB_POLL_DIRECT cannot be used for shared cqs so it is not a valid value
+ * for @poll_ctx.
+ */
+struct ib_cq *ib_cq_pool_get(struct ib_device *dev, unsigned int nr_cqe,
+			     int comp_vector_hint,
+			     enum ib_poll_context poll_ctx);
+
+/**
+ * ib_cq_pool_put - Return a CQ taken from a shared pool.
+ * @cq: The CQ to return.
+ * @nr_cqe: The max number of cqes that the user had requested.
+ */
+void ib_cq_pool_put(struct ib_cq *cq, unsigned int nr_cqe);
+
 /**
  * ib_req_ncomp_notif - Request completion notification when there are
  *   at least the specified number of unreaped completions on the CQ.
-- 
1.8.3.1

