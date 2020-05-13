Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBDB1D11D6
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 13:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbgEMLxG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 07:53:06 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:41417 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731489AbgEMLxG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 May 2020 07:53:06 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from yaminf@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 13 May 2020 14:52:54 +0300
Received: from arch012.mtl.labs.mlnx. (arch012.mtl.labs.mlnx [10.7.13.12])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 04DBqs6f006542;
        Wed, 13 May 2020 14:52:54 +0300
From:   Yamin Friedman <yaminf@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Yamin Friedman <yaminf@mellanox.com>
Subject: [PATCH V2 1/4] RDMA/core: Add protection for shared CQs used by ULPs
Date:   Wed, 13 May 2020 14:52:40 +0300
Message-Id: <1589370763-81205-2-git-send-email-yaminf@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1589370763-81205-1-git-send-email-yaminf@mellanox.com>
References: <1589370763-81205-1-git-send-email-yaminf@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

A pre-step for adding shared CQs. Add the infrastructure to prevent
shared CQ users from altering the CQ configurations. For now all cqs are
marked as private (non-shared). The core driver should use the new force
functions to perform resize/destroy/moderation changes that are not
allowed for users of shared CQs.

Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/core/cq.c    | 18 ++++++++++++------
 drivers/infiniband/core/verbs.c |  9 +++++++++
 include/rdma/ib_verbs.h         |  8 ++++++++
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index 4f25b24..04046eb 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -300,12 +300,7 @@ struct ib_cq *__ib_alloc_cq_any(struct ib_device *dev, void *private,
 }
 EXPORT_SYMBOL(__ib_alloc_cq_any);
 
-/**
- * ib_free_cq_user - free a completion queue
- * @cq:		completion queue to free.
- * @udata:	User data or NULL for kernel object
- */
-void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
+static void _ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 {
 	if (WARN_ON_ONCE(atomic_read(&cq->usecnt)))
 		return;
@@ -333,4 +328,15 @@ void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 	kfree(cq->wc);
 	kfree(cq);
 }
+
+/**
+ * ib_free_cq_user - free a completion queue
+ * @cq:		completion queue to free.
+ * @udata:	User data or NULL for kernel object
+ */
+void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
+{
+	if (!cq->shared)
+		_ib_free_cq_user(cq, udata);
+}
 EXPORT_SYMBOL(ib_free_cq_user);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index bf0249f..d1bacd7 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1990,6 +1990,9 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
 
 int rdma_set_cq_moderation(struct ib_cq *cq, u16 cq_count, u16 cq_period)
 {
+	if (cq->shared)
+		return -EOPNOTSUPP;
+
 	return cq->device->ops.modify_cq ?
 		cq->device->ops.modify_cq(cq, cq_count,
 					  cq_period) : -EOPNOTSUPP;
@@ -1998,6 +2001,9 @@ int rdma_set_cq_moderation(struct ib_cq *cq, u16 cq_count, u16 cq_period)
 
 int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 {
+	if (cq->shared)
+		return -EOPNOTSUPP;
+
 	if (atomic_read(&cq->usecnt))
 		return -EBUSY;
 
@@ -2010,6 +2016,9 @@ int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 
 int ib_resize_cq(struct ib_cq *cq, int cqe)
 {
+	if (cq->shared)
+		return -EOPNOTSUPP;
+
 	return cq->device->ops.resize_cq ?
 		cq->device->ops.resize_cq(cq, cqe, NULL) : -EOPNOTSUPP;
 }
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 4c488ca..b79737b 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1582,6 +1582,7 @@ struct ib_cq {
 	 * Implementation details of the RDMA core, don't use in drivers:
 	 */
 	struct rdma_restrack_entry res;
+	bool shared;
 };
 
 struct ib_srq {
@@ -3824,6 +3825,8 @@ static inline struct ib_cq *ib_alloc_cq_any(struct ib_device *dev,
  * ib_free_cq_user - Free kernel/user CQ
  * @cq: The CQ to free
  * @udata: Valid user data or NULL for kernel objects
+ *
+ * NOTE: this will fail for shared cqs
  */
 void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata);
 
@@ -3832,6 +3835,7 @@ static inline struct ib_cq *ib_alloc_cq_any(struct ib_device *dev,
  * @cq: The CQ to free
  *
  * NOTE: for user cq use ib_free_cq_user with valid udata!
+ * NOTE: this will fail for shared cqs
  */
 static inline void ib_free_cq(struct ib_cq *cq)
 {
@@ -3868,6 +3872,7 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
  * @cqe: The minimum size of the CQ.
  *
  * Users can examine the cq structure to determine the actual CQ size.
+ * NOTE: Will fail for shared CQs.
  */
 int ib_resize_cq(struct ib_cq *cq, int cqe);
 
@@ -3877,6 +3882,7 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
  * @cq_count: number of CQEs that will trigger an event
  * @cq_period: max period of time in usec before triggering an event
  *
+ * NOTE: Will fail for shared CQs.
  */
 int rdma_set_cq_moderation(struct ib_cq *cq, u16 cq_count, u16 cq_period);
 
@@ -3884,6 +3890,8 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
  * ib_destroy_cq_user - Destroys the specified CQ.
  * @cq: The CQ to destroy.
  * @udata: Valid user data or NULL for kernel objects
+ *
+ * NOTE: Will fail for shared CQs.
  */
 int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata);
 
-- 
1.8.3.1

