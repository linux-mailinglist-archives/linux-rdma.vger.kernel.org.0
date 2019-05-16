Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B744D200F6
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2019 10:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfEPILT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 May 2019 04:11:19 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:62559 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfEPILT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 May 2019 04:11:19 -0400
Received: from localhost (r10.asicdesigners.com [10.192.194.10])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x4G8BCvm012439;
        Thu, 16 May 2019 01:11:12 -0700
From:   Nirranjan Kirubaharan <nirranjan@chelsio.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org, nirranjan@chelsio.com,
        bharat@chelsio.com
Subject: [PATCH for-next v2] iw_cxgb4: Fix qpid leak
Date:   Thu, 16 May 2019 01:11:03 -0700
Message-Id: <eb1b5ff6b86ee619fa18247ca70aee81f8846038.1557987454.git.nirranjan@chelsio.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In iw_cxgb4, sometimes scheduled freeing of QPs complete after
completion of dealloc_ucontext(). So in use qpids stored in ucontext
gets lost, causing qpid leak. Added changes in dealloc_ucontext(),
to wait until completion of freeing of all QPs.

Signed-off-by: Nirranjan Kirubaharan <nirranjan@chelsio.com>
Reviewed-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
v2:
- Used kref instead of qid count.
---
 drivers/infiniband/hw/cxgb4/device.c   |  2 ++
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h |  3 +++
 drivers/infiniband/hw/cxgb4/provider.c |  7 ++++++-
 drivers/infiniband/hw/cxgb4/resource.c | 13 +++++++++++++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/cxgb4/device.c b/drivers/infiniband/hw/cxgb4/device.c
index 4c0d925c5ff5..3cce6c4676c8 100644
--- a/drivers/infiniband/hw/cxgb4/device.c
+++ b/drivers/infiniband/hw/cxgb4/device.c
@@ -775,6 +775,8 @@ void c4iw_init_dev_ucontext(struct c4iw_rdev *rdev,
 	INIT_LIST_HEAD(&uctx->qpids);
 	INIT_LIST_HEAD(&uctx->cqids);
 	mutex_init(&uctx->lock);
+	kref_init(&uctx->qid_kref);
+	init_completion(&uctx->qid_rel_comp);
 }
 
 /* Caller takes care of locking if needed */
diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index 916ef982172e..28b127efd4ec 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -110,6 +110,8 @@ struct c4iw_dev_ucontext {
 	struct list_head cqids;
 	struct mutex lock;
 	struct kref kref;
+	struct completion qid_rel_comp;
+	struct kref qid_kref;
 };
 
 enum c4iw_rdev_flags {
@@ -1057,5 +1059,6 @@ int c4iw_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
 typedef int c4iw_restrack_func(struct sk_buff *msg,
 			       struct rdma_restrack_entry *res);
 extern c4iw_restrack_func *c4iw_restrack_funcs[RDMA_RESTRACK_MAX];
+void qid_release(struct kref *kref);
 
 #endif
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 74b795642fca..df3b2c43c706 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -64,12 +64,17 @@ static void c4iw_dealloc_ucontext(struct ib_ucontext *context)
 	struct c4iw_dev *rhp;
 	struct c4iw_mm_entry *mm, *tmp;
 
-	pr_debug("context %p\n", context);
+	pr_debug("context %p\n", &ucontext->uctx);
 	rhp = to_c4iw_dev(ucontext->ibucontext.device);
 
 	list_for_each_entry_safe(mm, tmp, &ucontext->mmaps, entry)
 		kfree(mm);
+
+	kref_put(&ucontext->uctx.qid_kref, qid_release);
+	wait_for_completion(&ucontext->uctx.qid_rel_comp);
+
 	c4iw_release_dev_ucontext(&rhp->rdev, &ucontext->uctx);
+	pr_debug("context %p done\n", &ucontext->uctx);
 }
 
 static int c4iw_alloc_ucontext(struct ib_ucontext *ucontext,
diff --git a/drivers/infiniband/hw/cxgb4/resource.c b/drivers/infiniband/hw/cxgb4/resource.c
index 57ed26b3cc21..9aef7dabab62 100644
--- a/drivers/infiniband/hw/cxgb4/resource.c
+++ b/drivers/infiniband/hw/cxgb4/resource.c
@@ -224,6 +224,8 @@ u32 c4iw_get_qpid(struct c4iw_rdev *rdev, struct c4iw_dev_ucontext *uctx)
 			list_add_tail(&entry->entry, &uctx->cqids);
 		}
 	}
+	kref_get(&uctx->qid_kref);
+
 out:
 	mutex_unlock(&uctx->lock);
 	pr_debug("qid 0x%x\n", qid);
@@ -234,6 +236,14 @@ u32 c4iw_get_qpid(struct c4iw_rdev *rdev, struct c4iw_dev_ucontext *uctx)
 	return qid;
 }
 
+void qid_release(struct kref *kref)
+{
+	struct c4iw_dev_ucontext *uctx;
+
+	uctx = container_of(kref, struct c4iw_dev_ucontext, qid_kref);
+	complete(&uctx->qid_rel_comp);
+}
+
 void c4iw_put_qpid(struct c4iw_rdev *rdev, u32 qid,
 		   struct c4iw_dev_ucontext *uctx)
 {
@@ -246,6 +256,9 @@ void c4iw_put_qpid(struct c4iw_rdev *rdev, u32 qid,
 	entry->qid = qid;
 	mutex_lock(&uctx->lock);
 	list_add_tail(&entry->entry, &uctx->qpids);
+
+	kref_put(&uctx->qid_kref, qid_release);
+
 	mutex_unlock(&uctx->lock);
 }
 
-- 
1.8.3.1

