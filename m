Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9416AC1C2D
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Sep 2019 09:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfI3Hlh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Sep 2019 03:41:37 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:16831 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfI3Hlh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Sep 2019 03:41:37 -0400
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x8U7fVXZ001961;
        Mon, 30 Sep 2019 00:41:32 -0700
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com, Rahul Kundu <rahul.kundu@chelsio.com>
Subject: [PATCH for-rc] iw_cxgb4: fix SRQ access from dump_qp()
Date:   Mon, 30 Sep 2019 13:11:19 +0530
Message-Id: <20190930074119.20046-1-bharat@chelsio.com>
X-Mailer: git-send-email 2.18.0.232.gb7bd9486b055
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

dump_qp() is wrongly trying to dump SRQ structures as QP when SRQ is used
by the application. This patch matches the QPID before dumpig them.
Also removes unwanted SRQ id addition to QP id xarray.

Fixes: 2f43129127 ("cxgb4: Convert qpidr to XArray")
Signed-off-by: Rahul Kundu <rahul.kundu@chelsio.com>
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 drivers/infiniband/hw/cxgb4/device.c |  7 +++++--
 drivers/infiniband/hw/cxgb4/qp.c     | 10 +---------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/device.c b/drivers/infiniband/hw/cxgb4/device.c
index a8b9548bd1a2..599340c1f0b8 100644
--- a/drivers/infiniband/hw/cxgb4/device.c
+++ b/drivers/infiniband/hw/cxgb4/device.c
@@ -242,10 +242,13 @@ static void set_ep_sin6_addrs(struct c4iw_ep *ep,
 	}
 }
 
-static int dump_qp(struct c4iw_qp *qp, struct c4iw_debugfs_data *qpd)
+static int dump_qp(unsigned long id, struct c4iw_qp *qp,
+		   struct c4iw_debugfs_data *qpd)
 {
 	int space;
 	int cc;
+	if (id != qp->wq.sq.qid)
+		return 0;
 
 	space = qpd->bufsize - qpd->pos - 1;
 	if (space == 0)
@@ -350,7 +353,7 @@ static int qp_open(struct inode *inode, struct file *file)
 
 	xa_lock_irq(&qpd->devp->qps);
 	xa_for_each(&qpd->devp->qps, index, qp)
-		dump_qp(qp, qpd);
+		dump_qp(index, qp, qpd);
 	xa_unlock_irq(&qpd->devp->qps);
 
 	qpd->buf[qpd->pos++] = 0;
diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index eb9368be28c1..bbcac539777a 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -2737,15 +2737,11 @@ int c4iw_create_srq(struct ib_srq *ib_srq, struct ib_srq_init_attr *attrs,
 	if (CHELSIO_CHIP_VERSION(rhp->rdev.lldi.adapter_type) > CHELSIO_T6)
 		srq->flags = T4_SRQ_LIMIT_SUPPORT;
 
-	ret = xa_insert_irq(&rhp->qps, srq->wq.qid, srq, GFP_KERNEL);
-	if (ret)
-		goto err_free_queue;
-
 	if (udata) {
 		srq_key_mm = kmalloc(sizeof(*srq_key_mm), GFP_KERNEL);
 		if (!srq_key_mm) {
 			ret = -ENOMEM;
-			goto err_remove_handle;
+			goto err_free_queue;
 		}
 		srq_db_key_mm = kmalloc(sizeof(*srq_db_key_mm), GFP_KERNEL);
 		if (!srq_db_key_mm) {
@@ -2789,8 +2785,6 @@ int c4iw_create_srq(struct ib_srq *ib_srq, struct ib_srq_init_attr *attrs,
 	kfree(srq_db_key_mm);
 err_free_srq_key_mm:
 	kfree(srq_key_mm);
-err_remove_handle:
-	xa_erase_irq(&rhp->qps, srq->wq.qid);
 err_free_queue:
 	free_srq_queue(srq, ucontext ? &ucontext->uctx : &rhp->rdev.uctx,
 		       srq->wr_waitp);
@@ -2813,8 +2807,6 @@ void c4iw_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 	rhp = srq->rhp;
 
 	pr_debug("%s id %d\n", __func__, srq->wq.qid);
-
-	xa_erase_irq(&rhp->qps, srq->wq.qid);
 	ucontext = rdma_udata_to_drv_context(udata, struct c4iw_ucontext,
 					     ibucontext);
 	free_srq_queue(srq, ucontext ? &ucontext->uctx : &rhp->rdev.uctx,
-- 
2.18.0.232.gb7bd9486b055

