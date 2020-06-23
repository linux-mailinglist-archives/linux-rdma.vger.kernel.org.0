Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7D7205051
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 13:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732444AbgFWLPp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 07:15:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732443AbgFWLPo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jun 2020 07:15:44 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DBC720768;
        Tue, 23 Jun 2020 11:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592910943;
        bh=ttTezd0vE05kg0FGFPa7xavUg8cTy61SuVsWoUYTlH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qm/XDCMsgrKCilStS6xh5KAxs2sQD7md3DK7evuq7qlDUpB12FszuDG8I8S4CopJd
         zNnT0TQUKDTzoHITk7R6quhTyvOkoF0xwjqD7j2j14VTPErh07n7/qb6SW9LGfKvSe
         bPbztmJ54teDWlSA3GVc3ZlwqlGQeky88sauvGok=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 2/2] RDMA/core: Optimize XRC target lookup
Date:   Tue, 23 Jun 2020 14:15:31 +0300
Message-Id: <20200623111531.1227013-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200623111531.1227013-1-leon@kernel.org>
References: <20200623111531.1227013-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

Replace the mutex with read write semaphore and use xarray instead
of linked list for XRC target QPs. This will give faster XRC target
lookup. In addition, when QP is closed, don't insert it back to the
xarray if the destroy command failed.

Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/verbs.c | 57 ++++++++++++---------------------
 include/rdma/ib_verbs.h         |  5 ++-
 2 files changed, 23 insertions(+), 39 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index d66a0ad62077..1ccbe43e33cd 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1090,13 +1090,6 @@ static void __ib_shared_qp_event_handler(struct ib_event *event, void *context)
 	spin_unlock_irqrestore(&qp->device->qp_open_list_lock, flags);
 }
 
-static void __ib_insert_xrcd_qp(struct ib_xrcd *xrcd, struct ib_qp *qp)
-{
-	mutex_lock(&xrcd->tgt_qp_mutex);
-	list_add(&qp->xrcd_list, &xrcd->tgt_qp_list);
-	mutex_unlock(&xrcd->tgt_qp_mutex);
-}
-
 static struct ib_qp *__ib_open_qp(struct ib_qp *real_qp,
 				  void (*event_handler)(struct ib_event *, void *),
 				  void *qp_context)
@@ -1139,16 +1132,15 @@ struct ib_qp *ib_open_qp(struct ib_xrcd *xrcd,
 	if (qp_open_attr->qp_type != IB_QPT_XRC_TGT)
 		return ERR_PTR(-EINVAL);
 
-	qp = ERR_PTR(-EINVAL);
-	mutex_lock(&xrcd->tgt_qp_mutex);
-	list_for_each_entry(real_qp, &xrcd->tgt_qp_list, xrcd_list) {
-		if (real_qp->qp_num == qp_open_attr->qp_num) {
-			qp = __ib_open_qp(real_qp, qp_open_attr->event_handler,
-					  qp_open_attr->qp_context);
-			break;
-		}
+	down_read(&xrcd->tgt_qps_rwsem);
+	real_qp = xa_load(&xrcd->tgt_qps, qp_open_attr->qp_num);
+	if (!real_qp) {
+		up_read(&xrcd->tgt_qps_rwsem);
+		return ERR_PTR(-EINVAL);
 	}
-	mutex_unlock(&xrcd->tgt_qp_mutex);
+	qp = __ib_open_qp(real_qp, qp_open_attr->event_handler,
+			  qp_open_attr->qp_context);
+	up_read(&xrcd->tgt_qps_rwsem);
 	return qp;
 }
 EXPORT_SYMBOL(ib_open_qp);
@@ -1157,6 +1149,7 @@ static struct ib_qp *create_xrc_qp_user(struct ib_qp *qp,
 					struct ib_qp_init_attr *qp_init_attr)
 {
 	struct ib_qp *real_qp = qp;
+	int err;
 
 	qp->event_handler = __ib_shared_qp_event_handler;
 	qp->qp_context = qp;
@@ -1172,7 +1165,12 @@ static struct ib_qp *create_xrc_qp_user(struct ib_qp *qp,
 	if (IS_ERR(qp))
 		return qp;
 
-	__ib_insert_xrcd_qp(qp_init_attr->xrcd, real_qp);
+	err = xa_err(xa_store(&qp_init_attr->xrcd->tgt_qps, real_qp->qp_num,
+			      real_qp, GFP_KERNEL));
+	if (err) {
+		ib_close_qp(qp);
+		return ERR_PTR(err);
+	}
 	return qp;
 }
 
@@ -1888,21 +1886,18 @@ static int __ib_destroy_shared_qp(struct ib_qp *qp)
 
 	real_qp = qp->real_qp;
 	xrcd = real_qp->xrcd;
-
-	mutex_lock(&xrcd->tgt_qp_mutex);
+	down_write(&xrcd->tgt_qps_rwsem);
 	ib_close_qp(qp);
 	if (atomic_read(&real_qp->usecnt) == 0)
-		list_del(&real_qp->xrcd_list);
+		xa_erase(&xrcd->tgt_qps, real_qp->qp_num);
 	else
 		real_qp = NULL;
-	mutex_unlock(&xrcd->tgt_qp_mutex);
+	up_write(&xrcd->tgt_qps_rwsem);
 
 	if (real_qp) {
 		ret = ib_destroy_qp(real_qp);
 		if (!ret)
 			atomic_dec(&xrcd->usecnt);
-		else
-			__ib_insert_xrcd_qp(xrcd, real_qp);
 	}
 
 	return 0;
@@ -2308,8 +2303,8 @@ struct ib_xrcd *ib_alloc_xrcd_user(struct ib_device *device,
 		xrcd->device = device;
 		xrcd->inode = inode;
 		atomic_set(&xrcd->usecnt, 0);
-		mutex_init(&xrcd->tgt_qp_mutex);
-		INIT_LIST_HEAD(&xrcd->tgt_qp_list);
+		init_rwsem(&xrcd->tgt_qps_rwsem);
+		xa_init(&xrcd->tgt_qps);
 	}
 
 	return xrcd;
@@ -2318,20 +2313,10 @@ EXPORT_SYMBOL(ib_alloc_xrcd_user);
 
 int ib_dealloc_xrcd_user(struct ib_xrcd *xrcd, struct ib_udata *udata)
 {
-	struct ib_qp *qp;
-	int ret;
-
 	if (atomic_read(&xrcd->usecnt))
 		return -EBUSY;
 
-	while (!list_empty(&xrcd->tgt_qp_list)) {
-		qp = list_entry(xrcd->tgt_qp_list.next, struct ib_qp, xrcd_list);
-		ret = ib_destroy_qp(qp);
-		if (ret)
-			return ret;
-	}
-	mutex_destroy(&xrcd->tgt_qp_mutex);
-
+	WARN_ON(!xa_empty(&xrcd->tgt_qps));
 	return xrcd->device->ops.dealloc_xrcd(xrcd, udata);
 }
 EXPORT_SYMBOL(ib_dealloc_xrcd_user);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index f785a4f1e58b..9b973b3b6f4c 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1568,9 +1568,8 @@ struct ib_xrcd {
 	struct ib_device       *device;
 	atomic_t		usecnt; /* count all exposed resources */
 	struct inode	       *inode;
-
-	struct mutex		tgt_qp_mutex;
-	struct list_head	tgt_qp_list;
+	struct rw_semaphore	tgt_qps_rwsem;
+	struct xarray		tgt_qps;
 };
 
 struct ib_ah {
-- 
2.26.2

