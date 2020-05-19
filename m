Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF8D1D9684
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 14:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgESMn4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 08:43:56 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:34299 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726196AbgESMnz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 08:43:55 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yaminf@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 19 May 2020 15:43:49 +0300
Received: from arch012.mtl.labs.mlnx. (arch012.mtl.labs.mlnx [10.7.13.12])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 04JChn9K001676;
        Tue, 19 May 2020 15:43:49 +0300
From:   Yamin Friedman <yaminf@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Yamin Friedman <yaminf@mellanox.com>
Subject: [PATCH V3 1/4] RDMA/core: Add protection for shared CQs used by ULPs
Date:   Tue, 19 May 2020 15:43:33 +0300
Message-Id: <1589892216-39283-2-git-send-email-yaminf@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1589892216-39283-1-git-send-email-yaminf@mellanox.com>
References: <1589892216-39283-1-git-send-email-yaminf@mellanox.com>
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
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/verbs.c | 9 +++++++++
 include/rdma/ib_verbs.h         | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index bf0249f..675f601 100644
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
+	if (WARN_ON_ONCE(cq->shared))
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
index 4c488ca..1659131 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1582,6 +1582,7 @@ struct ib_cq {
 	 * Implementation details of the RDMA core, don't use in drivers:
 	 */
 	struct rdma_restrack_entry res;
+	u8 shared:1;
 };
 
 struct ib_srq {
@@ -3824,6 +3825,8 @@ static inline struct ib_cq *ib_alloc_cq_any(struct ib_device *dev,
  * ib_free_cq_user - Free kernel/user CQ
  * @cq: The CQ to free
  * @udata: Valid user data or NULL for kernel objects
+ *
+ * NOTE: This function shouldn't be called on shared CQs.
  */
 void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata);
 
-- 
1.8.3.1

