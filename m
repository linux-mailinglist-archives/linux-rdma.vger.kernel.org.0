Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9799C38FB3F
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 08:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhEYGxf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 02:53:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3938 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbhEYGxe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 May 2021 02:53:34 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fq4S34prFzBvcX;
        Tue, 25 May 2021 14:49:07 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 14:51:59 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 25 May 2021 14:51:55 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [PATCH v3 for-next 11/13] RDMA/cxgb4: Use refcount_t instead of atomic_t for reference counting
Date:   Tue, 25 May 2021 14:51:42 +0800
Message-ID: <1621925504-33019-12-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621925504-33019-1-git-send-email-liweihang@huawei.com>
References: <1621925504-33019-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The refcount_t API will WARN on underflow and overflow of a reference
counter, and avoid use-after-free risks.

Cc: Potnuri Bharat Teja <bharat@chelsio.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/cxgb4/cq.c       | 6 +++---
 drivers/infiniband/hw/cxgb4/ev.c       | 8 ++++----
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
index 44c2416..6c8c910 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -976,8 +976,8 @@ int c4iw_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	chp = to_c4iw_cq(ib_cq);
 
 	xa_erase_irq(&chp->rhp->cqs, chp->cq.cqid);
-	atomic_dec(&chp->refcnt);
-	wait_event(chp->wait, !atomic_read(&chp->refcnt));
+	refcount_dec(&chp->refcnt);
+	wait_event(chp->wait, !refcount_read(&chp->refcnt));
 
 	ucontext = rdma_udata_to_drv_context(udata, struct c4iw_ucontext,
 					     ibucontext);
@@ -1080,7 +1080,7 @@ int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	chp->ibcq.cqe = entries - 2;
 	spin_lock_init(&chp->lock);
 	spin_lock_init(&chp->comp_handler_lock);
-	atomic_set(&chp->refcnt, 1);
+	refcount_set(&chp->refcnt, 1);
 	init_waitqueue_head(&chp->wait);
 	ret = xa_insert_irq(&rhp->cqs, chp->cq.cqid, chp, GFP_KERNEL);
 	if (ret)
diff --git a/drivers/infiniband/hw/cxgb4/ev.c b/drivers/infiniband/hw/cxgb4/ev.c
index 4cd877b..7798d090 100644
--- a/drivers/infiniband/hw/cxgb4/ev.c
+++ b/drivers/infiniband/hw/cxgb4/ev.c
@@ -151,7 +151,7 @@ void c4iw_ev_dispatch(struct c4iw_dev *dev, struct t4_cqe *err_cqe)
 	}
 
 	c4iw_qp_add_ref(&qhp->ibqp);
-	atomic_inc(&chp->refcnt);
+	refcount_inc(&chp->refcnt);
 	xa_unlock_irq(&dev->qps);
 
 	/* Bad incoming write */
@@ -213,7 +213,7 @@ void c4iw_ev_dispatch(struct c4iw_dev *dev, struct t4_cqe *err_cqe)
 		break;
 	}
 done:
-	if (atomic_dec_and_test(&chp->refcnt))
+	if (refcount_dec_and_test(&chp->refcnt))
 		wake_up(&chp->wait);
 	c4iw_qp_rem_ref(&qhp->ibqp);
 out:
@@ -228,13 +228,13 @@ int c4iw_ev_handler(struct c4iw_dev *dev, u32 qid)
 	xa_lock_irqsave(&dev->cqs, flag);
 	chp = xa_load(&dev->cqs, qid);
 	if (chp) {
-		atomic_inc(&chp->refcnt);
+		refcount_inc(&chp->refcnt);
 		xa_unlock_irqrestore(&dev->cqs, flag);
 		t4_clear_cq_armed(&chp->cq);
 		spin_lock_irqsave(&chp->comp_handler_lock, flag);
 		(*chp->ibcq.comp_handler)(&chp->ibcq, chp->ibcq.cq_context);
 		spin_unlock_irqrestore(&chp->comp_handler_lock, flag);
-		if (atomic_dec_and_test(&chp->refcnt))
+		if (refcount_dec_and_test(&chp->refcnt))
 			wake_up(&chp->wait);
 	} else {
 		pr_debug("unknown cqid 0x%x\n", qid);
diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index cdec5de..3883af3 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -427,7 +427,7 @@ struct c4iw_cq {
 	struct t4_cq cq;
 	spinlock_t lock;
 	spinlock_t comp_handler_lock;
-	atomic_t refcnt;
+	refcount_t refcnt;
 	wait_queue_head_t wait;
 	struct c4iw_wr_wait *wr_waitp;
 };
-- 
2.7.4

