Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE99424EF7
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2019 14:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfEUMdP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 08:33:15 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:13343 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfEUMdP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 May 2019 08:33:15 -0400
Received: from localhost (r10.asicdesigners.com [10.192.194.10])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x4LCWdvS023094;
        Tue, 21 May 2019 05:32:39 -0700
From:   Nirranjan Kirubaharan <nirranjan@chelsio.com>
To:     nirranjan@chelsio.com, bharat@chelsio.com, dledford@redhat.com,
        jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH for-next v3] iw_cxgb4: Fix qpid leak
Date:   Tue, 21 May 2019 05:32:30 -0700
Message-Id: <d60f04ae2f0f5ba6f925d7f56a31e09f33f3fde7.1558438183.git.nirranjan@chelsio.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In iw_cxgb4, Added wait in destroy_qp() so that all references to
qp are dereferenced and qp is freed in destroy_qp() itself.
This ensures freeing of all QPs before invocation of
dealloc_ucontext(), which prevents loss of in use qpids stored
in ucontext.

Signed-off-by: Nirranjan Kirubaharan <nirranjan@chelsio.com>
Reviewed-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
v2:
- Used kref instead of qid count.
---
v3:
- Ensured freeing of qp in destroy_qp() itself.
---
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h | 1 +
 drivers/infiniband/hw/cxgb4/qp.c       | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index 916ef982172e..10c3e5e9d3de 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -497,6 +497,7 @@ struct c4iw_qp {
 	struct work_struct free_work;
 	struct c4iw_ucontext *ucontext;
 	struct c4iw_wr_wait *wr_waitp;
+	struct completion qp_rel_comp;
 };
 
 static inline struct c4iw_qp *to_c4iw_qp(struct ib_qp *ibqp)
diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index e92b9544357a..ea0b7014fb03 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -905,7 +905,7 @@ static void free_qp_work(struct work_struct *work)
 		   ucontext ? &ucontext->uctx : &rhp->rdev.uctx, !qhp->srq);
 
 	c4iw_put_wr_wait(qhp->wr_waitp);
-	kfree(qhp);
+	complete(&qhp->qp_rel_comp);
 }
 
 static void queue_qp_free(struct kref *kref)
@@ -2120,7 +2120,11 @@ int c4iw_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 
 	c4iw_qp_rem_ref(ib_qp);
 
+	wait_for_completion(&qhp->qp_rel_comp);
+
 	pr_debug("ib_qp %p qpid 0x%0x\n", ib_qp, qhp->wq.sq.qid);
+
+	kfree(qhp);
 	return 0;
 }
 
@@ -2184,6 +2188,7 @@ struct ib_qp *c4iw_create_qp(struct ib_pd *pd, struct ib_qp_init_attr *attrs,
 		(sqsize + rhp->rdev.hw_queue.t4_eq_status_entries) *
 		sizeof(*qhp->wq.sq.queue) + 16 * sizeof(__be64);
 	qhp->wq.sq.flush_cidx = -1;
+	init_completion(&qhp->qp_rel_comp);
 	if (!attrs->srq) {
 		qhp->wq.rq.size = rqsize;
 		qhp->wq.rq.memsize =
-- 
1.8.3.1

