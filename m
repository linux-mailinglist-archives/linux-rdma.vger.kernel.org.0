Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF7D70360
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 17:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbfGVPOs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 11:14:48 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:58316 "EHLO
        os.inf.tu-dresden.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbfGVPOp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 11:14:45 -0400
Received: from [195.176.96.199] (helo=jupiter)
        by os.inf.tu-dresden.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92)
        id 1hpa1O-0008AD-6i; Mon, 22 Jul 2019 17:14:38 +0200
From:   Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
To:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Subject: [PATCH 08/10] Move responsibility of cleaning up pool elements
Date:   Mon, 22 Jul 2019 17:14:24 +0200
Message-Id: <20190722151426.5266-9-mplaneta@os.inf.tu-dresden.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
References: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Specific implementations must finish off the cleanup of pool elements
when it is the right moment. Reason for that is that a concreate cleanup
function may want postpone and schedule part of object destruction to
later time.

Signed-off-by: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
---
 drivers/infiniband/sw/rxe/rxe_cq.c    | 2 ++
 drivers/infiniband/sw/rxe/rxe_mcast.c | 2 ++
 drivers/infiniband/sw/rxe/rxe_mr.c    | 2 ++
 drivers/infiniband/sw/rxe/rxe_pool.c  | 9 ++++++++-
 drivers/infiniband/sw/rxe/rxe_pool.h  | 2 ++
 5 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index ad3090131126..5693986c8c1b 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -182,4 +182,6 @@ void rxe_cq_cleanup(struct rxe_pool_entry *arg)
 
 	if (cq->queue)
 		rxe_queue_cleanup(cq->queue);
+
+	rxe_elem_cleanup(arg);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 24ebc4ca1b99..6453ae97653f 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -187,4 +187,6 @@ void rxe_mc_cleanup(struct rxe_pool_entry *arg)
 
 	rxe_drop_key(&grp->pelem);
 	rxe_mcast_delete(rxe, &grp->mgid);
+
+	rxe_elem_cleanup(arg);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 441b01e30afa..1c0940655df1 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -104,6 +104,8 @@ void rxe_mem_cleanup(struct rxe_pool_entry *arg)
 
 		kfree(mem->map);
 	}
+
+	rxe_elem_cleanup(arg);
 }
 
 static int rxe_mem_alloc(struct rxe_mem *mem, int num_buf)
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 711d7d7f3692..3b14ab599662 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -462,9 +462,16 @@ void rxe_elem_release(struct kref *kref)
 
 	if (pool->cleanup)
 		pool->cleanup(elem);
+	else
+		rxe_elem_cleanup(elem);
+}
+
+void rxe_elem_cleanup(struct rxe_pool_entry *pelem)
+{
+	struct rxe_pool *pool = pelem->pool;
 
 	if (!(pool->flags & RXE_POOL_NO_ALLOC))
-		kmem_cache_free(pool_cache(pool), elem);
+		kmem_cache_free(pool_cache(pool), pelem);
 	atomic_dec(&pool->num_elem);
 	ib_device_put(&pool->rxe->ib_dev);
 	rxe_pool_put(pool);
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 1e3508c74dc0..84cfbc749a5c 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -160,6 +160,8 @@ void *rxe_pool_get_key(struct rxe_pool *pool, void *key);
 /* cleanup an object when all references are dropped */
 void rxe_elem_release(struct kref *kref);
 
+void rxe_elem_cleanup(struct rxe_pool_entry *pelem);
+
 /* take a reference on an object */
 static inline void rxe_add_ref(struct rxe_pool_entry *pelem) {
 	kref_get(&pelem->ref_cnt);
-- 
2.20.1

