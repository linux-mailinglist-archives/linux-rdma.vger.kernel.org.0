Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25ED0189E91
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 16:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgCRPDE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 11:03:04 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:39921 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726757AbgCRPDE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Mar 2020 11:03:04 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 18 Mar 2020 17:02:57 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02IF2vEL008733;
        Wed, 18 Mar 2020 17:02:57 +0200
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        loberman@redhat.com, bvanassche@acm.org, linux-rdma@vger.kernel.org
Cc:     kbusch@kernel.org, leonro@mellanox.com, jgg@mellanox.com,
        dledford@redhat.com, idanb@mellanox.com, shlomin@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, rgirase@redhat.com,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH v2 1/5] IB/core: add a simple SRQ pool per PD
Date:   Wed, 18 Mar 2020 17:02:53 +0200
Message-Id: <20200318150257.198402-2-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200318150257.198402-1-maxg@mellanox.com>
References: <20200318150257.198402-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ULP's can use this API to create/destroy SRQ's with the same
characteristics for implementing a logic that aimed to save resources
without significant performance penalty (e.g. create SRQ per completion
vector and use shared receive buffers for multiple controllers of the
ULP).

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/core/Makefile   |  2 +-
 drivers/infiniband/core/srq_pool.c | 75 ++++++++++++++++++++++++++++++++++++++
 drivers/infiniband/core/verbs.c    |  3 ++
 include/rdma/ib_verbs.h            |  4 ++
 include/rdma/srq_pool.h            | 18 +++++++++
 5 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 drivers/infiniband/core/srq_pool.c
 create mode 100644 include/rdma/srq_pool.h

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index d1b14887..ca377b0 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -12,7 +12,7 @@ ib_core-y :=			packer.o ud_header.o verbs.o cq.o rw.o sysfs.o \
 				roce_gid_mgmt.o mr_pool.o addr.o sa_query.o \
 				multicast.o mad.o smi.o agent.o mad_rmpp.o \
 				nldev.o restrack.o counters.o ib_core_uverbs.o \
-				trace.o
+				trace.o srq_pool.o
 
 ib_core-$(CONFIG_SECURITY_INFINIBAND) += security.o
 ib_core-$(CONFIG_CGROUP_RDMA) += cgroup.o
diff --git a/drivers/infiniband/core/srq_pool.c b/drivers/infiniband/core/srq_pool.c
new file mode 100644
index 0000000..68321f0
--- /dev/null
+++ b/drivers/infiniband/core/srq_pool.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2020 Mellanox Technologies. All rights reserved.
+ */
+
+#include <rdma/srq_pool.h>
+
+struct ib_srq *rdma_srq_pool_get(struct ib_pd *pd)
+{
+	struct ib_srq *srq;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pd->srq_lock, flags);
+	srq = list_first_entry_or_null(&pd->srqs, struct ib_srq, pd_entry);
+	if (srq)
+		list_del(&srq->pd_entry);
+	spin_unlock_irqrestore(&pd->srq_lock, flags);
+
+	return srq;
+}
+EXPORT_SYMBOL(rdma_srq_pool_get);
+
+void rdma_srq_pool_put(struct ib_pd *pd, struct ib_srq *srq)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pd->srq_lock, flags);
+	list_add(&srq->pd_entry, &pd->srqs);
+	spin_unlock_irqrestore(&pd->srq_lock, flags);
+}
+EXPORT_SYMBOL(rdma_srq_pool_put);
+
+int rdma_srq_pool_init(struct ib_pd *pd, int nr,
+		struct ib_srq_init_attr *srq_attr)
+{
+	struct ib_srq *srq;
+	unsigned long flags;
+	int ret, i;
+
+	for (i = 0; i < nr; i++) {
+		srq = ib_create_srq(pd, srq_attr);
+		if (IS_ERR(srq)) {
+			ret = PTR_ERR(srq);
+			goto out;
+		}
+
+		spin_lock_irqsave(&pd->srq_lock, flags);
+		list_add_tail(&srq->pd_entry, &pd->srqs);
+		spin_unlock_irqrestore(&pd->srq_lock, flags);
+	}
+
+	return 0;
+out:
+	rdma_srq_pool_destroy(pd);
+	return ret;
+}
+EXPORT_SYMBOL(rdma_srq_pool_init);
+
+void rdma_srq_pool_destroy(struct ib_pd *pd)
+{
+	struct ib_srq *srq;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pd->srq_lock, flags);
+	while (!list_empty(&pd->srqs)) {
+		srq = list_first_entry(&pd->srqs, struct ib_srq, pd_entry);
+		list_del(&srq->pd_entry);
+
+		spin_unlock_irqrestore(&pd->srq_lock, flags);
+		ib_destroy_srq(srq);
+		spin_lock_irqsave(&pd->srq_lock, flags);
+	}
+	spin_unlock_irqrestore(&pd->srq_lock, flags);
+}
+EXPORT_SYMBOL(rdma_srq_pool_destroy);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index e62c9df..0bb69d2 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -272,6 +272,8 @@ struct ib_pd *__ib_alloc_pd(struct ib_device *device, unsigned int flags,
 	pd->__internal_mr = NULL;
 	atomic_set(&pd->usecnt, 0);
 	pd->flags = flags;
+	spin_lock_init(&pd->srq_lock);
+	INIT_LIST_HEAD(&pd->srqs);
 
 	pd->res.type = RDMA_RESTRACK_PD;
 	rdma_restrack_set_task(&pd->res, caller);
@@ -340,6 +342,7 @@ void ib_dealloc_pd_user(struct ib_pd *pd, struct ib_udata *udata)
 		pd->__internal_mr = NULL;
 	}
 
+	WARN_ON_ONCE(!list_empty(&pd->srqs));
 	/* uverbs manipulates usecnt with proper locking, while the kabi
 	   requires the caller to guarantee we can't race here. */
 	WARN_ON(atomic_read(&pd->usecnt));
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 1f779fa..1dcfefb 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1517,6 +1517,9 @@ struct ib_pd {
 
 	u32			unsafe_global_rkey;
 
+	spinlock_t		srq_lock;
+	struct list_head	srqs;
+
 	/*
 	 * Implementation details of the RDMA core, don't use in drivers:
 	 */
@@ -1585,6 +1588,7 @@ struct ib_srq {
 	void		       *srq_context;
 	enum ib_srq_type	srq_type;
 	atomic_t		usecnt;
+	struct list_head	pd_entry; /* srq pool entry */
 
 	struct {
 		struct ib_cq   *cq;
diff --git a/include/rdma/srq_pool.h b/include/rdma/srq_pool.h
new file mode 100644
index 0000000..ee83896
--- /dev/null
+++ b/include/rdma/srq_pool.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB) */
+/*
+ * Copyright (c) 2020 Mellanox Technologies. All rights reserved.
+ */
+
+#ifndef _RDMA_SRQ_POOL_H
+#define _RDMA_SRQ_POOL_H
+
+#include <rdma/ib_verbs.h>
+
+struct ib_srq *rdma_srq_pool_get(struct ib_pd *pd);
+void rdma_srq_pool_put(struct ib_pd *pd, struct ib_srq *srq);
+
+int rdma_srq_pool_init(struct ib_pd *pd, int nr,
+		struct ib_srq_init_attr *srq_attr);
+void rdma_srq_pool_destroy(struct ib_pd *pd);
+
+#endif /* _RDMA_SRQ_POOL_H */
-- 
1.8.3.1

