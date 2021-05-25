Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039A338FB36
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 08:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhEYGx2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 02:53:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5543 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbhEYGx2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 May 2021 02:53:28 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fq4S12ltjzwSxD;
        Tue, 25 May 2021 14:49:05 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 14:51:56 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 25 May 2021 14:51:55 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: [PATCH v3 for-next 13/13] RDMA/rdmavt: Use refcount_t instead of atomic_t on refcount of rvt_mcast
Date:   Tue, 25 May 2021 14:51:44 +0800
Message-ID: <1621925504-33019-14-git-send-email-liweihang@huawei.com>
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
counter, and avoid use-after-free risks. Increase refcount_t from 0 to 1 is
regarded as there is a risk about use-after-free. So it should be set to 1
directly during initialization.

Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hfi1/verbs.c    |  3 ++-
 drivers/infiniband/hw/qib/qib_verbs.c |  3 ++-
 drivers/infiniband/sw/rdmavt/mcast.c  | 11 +++++------
 include/rdma/rdmavt_qp.h              |  2 +-
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index 5542943..d67f707 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -534,7 +534,8 @@ static inline void hfi1_handle_packet(struct hfi1_packet *packet,
 		 * Notify rvt_multicast_detach() if it is waiting for us
 		 * to finish.
 		 */
-		if (atomic_dec_return(&mcast->refcount) <= 1)
+		refcount_dec(&mcast->refcount);
+		if (refcount_read(&mcast->refcount) <= 1)
 			wake_up(&mcast->wait);
 	} else {
 		/* Get the destination QP number. */
diff --git a/drivers/infiniband/hw/qib/qib_verbs.c b/drivers/infiniband/hw/qib/qib_verbs.c
index d17d034..d6a7cc9 100644
--- a/drivers/infiniband/hw/qib/qib_verbs.c
+++ b/drivers/infiniband/hw/qib/qib_verbs.c
@@ -336,7 +336,8 @@ void qib_ib_rcv(struct qib_ctxtdata *rcd, void *rhdr, void *data, u32 tlen)
 		 * Notify rvt_multicast_detach() if it is waiting for us
 		 * to finish.
 		 */
-		if (atomic_dec_return(&mcast->refcount) <= 1)
+		refcount_dec(&mcast->refcount);
+		if (refcount_read(&mcast->refcount) <= 1)
 			wake_up(&mcast->wait);
 	} else {
 		rcu_read_lock();
diff --git a/drivers/infiniband/sw/rdmavt/mcast.c b/drivers/infiniband/sw/rdmavt/mcast.c
index 951abac..7746d5c 100644
--- a/drivers/infiniband/sw/rdmavt/mcast.c
+++ b/drivers/infiniband/sw/rdmavt/mcast.c
@@ -117,7 +117,6 @@ static struct rvt_mcast *rvt_mcast_alloc(union ib_gid *mgid, u16 lid)
 
 	INIT_LIST_HEAD(&mcast->qp_list);
 	init_waitqueue_head(&mcast->wait);
-	atomic_set(&mcast->refcount, 0);
 
 bail:
 	return mcast;
@@ -169,7 +168,7 @@ struct rvt_mcast *rvt_mcast_find(struct rvt_ibport *ibp, union ib_gid *mgid,
 		} else {
 			/* MGID/MLID must match */
 			if (mcast->mcast_addr.lid == lid) {
-				atomic_inc(&mcast->refcount);
+				refcount_inc(&mcast->refcount);
 				found = mcast;
 			}
 			break;
@@ -257,7 +256,7 @@ static int rvt_mcast_add(struct rvt_dev_info *rdi, struct rvt_ibport *ibp,
 
 	list_add_tail_rcu(&mqp->list, &mcast->qp_list);
 
-	atomic_inc(&mcast->refcount);
+	refcount_set(&mcast->refcount, 1);
 	rb_link_node(&mcast->rb_node, pn, n);
 	rb_insert_color(&mcast->rb_node, &ibp->mcast_tree);
 
@@ -410,12 +409,12 @@ int rvt_detach_mcast(struct ib_qp *ibqp, union ib_gid *gid, u16 lid)
 	 * Wait for any list walkers to finish before freeing the
 	 * list element.
 	 */
-	wait_event(mcast->wait, atomic_read(&mcast->refcount) <= 1);
+	wait_event(mcast->wait, refcount_read(&mcast->refcount) <= 1);
 	rvt_mcast_qp_free(delp);
 
 	if (last) {
-		atomic_dec(&mcast->refcount);
-		wait_event(mcast->wait, !atomic_read(&mcast->refcount));
+		refcount_dec(&mcast->refcount);
+		wait_event(mcast->wait, !refcount_read(&mcast->refcount));
 		rvt_mcast_free(mcast);
 		spin_lock_irq(&rdi->n_mcast_grps_lock);
 		rdi->n_mcast_grps_allocated--;
diff --git a/include/rdma/rdmavt_qp.h b/include/rdma/rdmavt_qp.h
index 8275954..cd19573 100644
--- a/include/rdma/rdmavt_qp.h
+++ b/include/rdma/rdmavt_qp.h
@@ -520,7 +520,7 @@ struct rvt_mcast {
 	struct rvt_mcast_addr mcast_addr;
 	struct list_head qp_list;
 	wait_queue_head_t wait;
-	atomic_t refcount;
+	refcount_t refcount;
 	int n_attached;
 };
 
-- 
2.7.4

