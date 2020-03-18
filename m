Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4461E189E93
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 16:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgCRPDF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 11:03:05 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:39941 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726776AbgCRPDE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Mar 2020 11:03:04 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 18 Mar 2020 17:02:58 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02IF2vEP008733;
        Wed, 18 Mar 2020 17:02:57 +0200
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        loberman@redhat.com, bvanassche@acm.org, linux-rdma@vger.kernel.org
Cc:     kbusch@kernel.org, leonro@mellanox.com, jgg@mellanox.com,
        dledford@redhat.com, idanb@mellanox.com, shlomin@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, rgirase@redhat.com,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH v2 5/5] RDMA/srpt: use SRQ per completion vector
Date:   Wed, 18 Mar 2020 17:02:57 +0200
Message-Id: <20200318150257.198402-6-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200318150257.198402-1-maxg@mellanox.com>
References: <20200318150257.198402-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In order to save resource allocation and utilize the completion
locality in a better way (compared to SRQ per device that exist
today), allocate Shared Receive Queues (SRQs) per completion vector.
Associate each created channel with an appropriate SRQ according to the
completion vector index. This association will reduce the lock
contention in the fast path (compared to SRQ per device solution) and
increase the locality in memory buffers.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 166 +++++++++++++++++++++++++---------
 drivers/infiniband/ulp/srpt/ib_srpt.h |  26 +++++-
 2 files changed, 145 insertions(+), 47 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index d0294d8..a30890d 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -813,6 +813,31 @@ static bool srpt_test_and_set_cmd_state(struct srpt_send_ioctx *ioctx,
 }
 
 /**
+ * srpt_srq_post_recv - post an initial IB receive request for SRQ
+ * @srq: SRPT SRQ context.
+ * @ioctx: Receive I/O context pointer.
+ */
+static int srpt_srq_post_recv(struct srpt_srq *srq,
+			      struct srpt_recv_ioctx *ioctx)
+{
+	struct srpt_device *sdev = srq->sdev;
+	struct ib_sge list;
+	struct ib_recv_wr wr;
+
+	list.addr = ioctx->ioctx.dma + ioctx->ioctx.offset;
+	list.length = srp_max_req_size;
+	list.lkey = sdev->lkey;
+
+	ioctx->ioctx.cqe.done = srpt_recv_done;
+	wr.wr_cqe = &ioctx->ioctx.cqe;
+	wr.next = NULL;
+	wr.sg_list = &list;
+	wr.num_sge = 1;
+
+	return ib_post_srq_recv(srq->ibsrq, &wr, NULL);
+}
+
+/**
  * srpt_post_recv - post an IB receive request
  * @sdev: SRPT HCA pointer.
  * @ch: SRPT RDMA channel.
@@ -836,7 +861,7 @@ static int srpt_post_recv(struct srpt_device *sdev, struct srpt_rdma_ch *ch,
 	wr.num_sge = 1;
 
 	if (sdev->use_srq)
-		return ib_post_srq_recv(sdev->srq, &wr, NULL);
+		return ib_post_srq_recv(ch->srq->ibsrq, &wr, NULL);
 	else
 		return ib_post_recv(ch->qp, &wr, NULL);
 }
@@ -1824,7 +1849,8 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
 					SRPT_MAX_SG_PER_WQE);
 	qp_init->port_num = ch->sport->port;
 	if (sdev->use_srq) {
-		qp_init->srq = sdev->srq;
+		ch->srq = sdev->srqs[comp_vector % sdev->srq_count];
+		qp_init->srq = ch->srq->ibsrq;
 	} else {
 		qp_init->cap.max_recv_wr = ch->rq_size;
 		qp_init->cap.max_recv_sge = min(attrs->max_recv_sge,
@@ -1882,6 +1908,8 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
 
 static void srpt_destroy_ch_ib(struct srpt_rdma_ch *ch)
 {
+	if (ch->srq)
+		ch->srq = NULL;
 	ib_destroy_qp(ch->qp);
 	ib_free_cq(ch->cq);
 }
@@ -3030,20 +3058,73 @@ static struct se_wwn *srpt_lookup_wwn(const char *name)
 	return wwn;
 }
 
-static void srpt_free_srq(struct srpt_device *sdev)
+static void srpt_free_srq(struct srpt_srq *srq)
 {
-	if (!sdev->srq)
-		return;
 
-	ib_destroy_srq(sdev->srq);
-	srpt_free_ioctx_ring((struct srpt_ioctx **)sdev->ioctx_ring, sdev,
-			     sdev->srq_size, sdev->req_buf_cache,
+	srpt_free_ioctx_ring((struct srpt_ioctx **)srq->ioctx_ring, srq->sdev,
+			     srq->sdev->srq_size, srq->sdev->req_buf_cache,
 			     DMA_FROM_DEVICE);
+	rdma_srq_pool_put(srq->sdev->pd, srq->ibsrq);
+	kfree(srq);
+
+}
+
+static void srpt_free_srqs(struct srpt_device *sdev)
+{
+	int i;
+
+	if (!sdev->srqs)
+		return;
+
+	for (i = 0; i < sdev->srq_count; i++)
+		srpt_free_srq(sdev->srqs[i]);
 	kmem_cache_destroy(sdev->req_buf_cache);
-	sdev->srq = NULL;
+	rdma_srq_pool_destroy(sdev->pd);
+	kfree(sdev->srqs);
+	sdev->srqs = NULL;
 }
 
-static int srpt_alloc_srq(struct srpt_device *sdev)
+static struct srpt_srq *srpt_alloc_srq(struct srpt_device *sdev)
+{
+	struct srpt_srq	*srq;
+	int i, ret;
+
+	srq = kzalloc(sizeof(*srq), GFP_KERNEL);
+	if (!srq)
+		return ERR_PTR(-ENOMEM);
+
+	srq->ibsrq = rdma_srq_pool_get(sdev->pd);
+	if (!srq->ibsrq) {
+		ret = -EAGAIN;
+		goto free_srq;
+	}
+
+	srq->ioctx_ring = (struct srpt_recv_ioctx **)
+		srpt_alloc_ioctx_ring(sdev, sdev->srq_size,
+				      sizeof(*srq->ioctx_ring[0]),
+				      sdev->req_buf_cache, 0, DMA_FROM_DEVICE);
+	if (!srq->ioctx_ring) {
+		ret = -ENOMEM;
+		goto put_srq;
+	}
+
+	srq->sdev = sdev;
+
+	for (i = 0; i < sdev->srq_size; ++i) {
+		INIT_LIST_HEAD(&srq->ioctx_ring[i]->wait_list);
+		srpt_srq_post_recv(srq, srq->ioctx_ring[i]);
+	}
+
+	return srq;
+
+put_srq:
+	rdma_srq_pool_put(sdev->pd, srq->ibsrq);
+free_srq:
+	kfree(srq);
+	return ERR_PTR(ret);
+}
+
+static int srpt_alloc_srqs(struct srpt_device *sdev)
 {
 	struct ib_srq_init_attr srq_attr = {
 		.event_handler = srpt_srq_event,
@@ -3053,46 +3134,45 @@ static int srpt_alloc_srq(struct srpt_device *sdev)
 		.srq_type = IB_SRQT_BASIC,
 	};
 	struct ib_device *device = sdev->device;
-	struct ib_srq *srq;
-	int i;
+	int i, j, ret;
 
-	WARN_ON_ONCE(sdev->srq);
-	srq = ib_create_srq(sdev->pd, &srq_attr);
-	if (IS_ERR(srq)) {
-		pr_debug("ib_create_srq() failed: %ld\n", PTR_ERR(srq));
-		return PTR_ERR(srq);
-	}
+	WARN_ON_ONCE(sdev->srqs);
+	sdev->srqs = kcalloc(sdev->srq_count, sizeof(*sdev->srqs), GFP_KERNEL);
+	if (!sdev->srqs)
+		return -ENOMEM;
+
+	pr_debug("create SRQ set #wr= %d max_allow=%d dev= %s\n",
+		 sdev->srq_size, sdev->device->attrs.max_srq_wr,
+		 dev_name(&device->dev));
 
-	pr_debug("create SRQ #wr= %d max_allow=%d dev= %s\n", sdev->srq_size,
-		 sdev->device->attrs.max_srq_wr, dev_name(&device->dev));
+	ret = rdma_srq_pool_init(sdev->pd, sdev->srq_count, &srq_attr);
+	if (ret)
+		goto out_free;
 
 	sdev->req_buf_cache = kmem_cache_create("srpt-srq-req-buf",
 						srp_max_req_size, 0, 0, NULL);
 	if (!sdev->req_buf_cache)
-		goto free_srq;
+		goto out_free_pool;
 
-	sdev->ioctx_ring = (struct srpt_recv_ioctx **)
-		srpt_alloc_ioctx_ring(sdev, sdev->srq_size,
-				      sizeof(*sdev->ioctx_ring[0]),
-				      sdev->req_buf_cache, 0, DMA_FROM_DEVICE);
-	if (!sdev->ioctx_ring)
-		goto free_cache;
+	for (i = 0; i < sdev->srq_count; i++) {
+		sdev->srqs[i] = srpt_alloc_srq(sdev);
+		if (IS_ERR(sdev->srqs[i]))
+			goto free_srq;
+	}
 
 	sdev->use_srq = true;
-	sdev->srq = srq;
-
-	for (i = 0; i < sdev->srq_size; ++i) {
-		INIT_LIST_HEAD(&sdev->ioctx_ring[i]->wait_list);
-		srpt_post_recv(sdev, NULL, sdev->ioctx_ring[i]);
-	}
 
 	return 0;
 
-free_cache:
-	kmem_cache_destroy(sdev->req_buf_cache);
-
 free_srq:
-	ib_destroy_srq(srq);
+	for (j = 0; j < i; j++)
+		srpt_free_srq(sdev->srqs[j]);
+	kmem_cache_destroy(sdev->req_buf_cache);
+out_free_pool:
+	rdma_srq_pool_destroy(sdev->pd);
+out_free:
+	kfree(sdev->srqs);
+	sdev->srqs = NULL;
 	return -ENOMEM;
 }
 
@@ -3102,10 +3182,10 @@ static int srpt_use_srq(struct srpt_device *sdev, bool use_srq)
 	int ret = 0;
 
 	if (!use_srq) {
-		srpt_free_srq(sdev);
+		srpt_free_srqs(sdev);
 		sdev->use_srq = false;
-	} else if (use_srq && !sdev->srq) {
-		ret = srpt_alloc_srq(sdev);
+	} else if (use_srq && !sdev->srqs) {
+		ret = srpt_alloc_srqs(sdev);
 	}
 	pr_debug("%s(%s): use_srq = %d; ret = %d\n", __func__,
 		 dev_name(&device->dev), sdev->use_srq, ret);
@@ -3139,6 +3219,8 @@ static void srpt_add_one(struct ib_device *device)
 	sdev->lkey = sdev->pd->local_dma_lkey;
 
 	sdev->srq_size = min(srpt_srq_size, sdev->device->attrs.max_srq_wr);
+	sdev->srq_count = min(sdev->device->num_comp_vectors,
+			      sdev->device->attrs.max_srq);
 
 	srpt_use_srq(sdev, sdev->port[0].port_attrib.use_srq);
 
@@ -3216,7 +3298,7 @@ static void srpt_add_one(struct ib_device *device)
 	if (sdev->cm_id)
 		ib_destroy_cm_id(sdev->cm_id);
 err_ring:
-	srpt_free_srq(sdev);
+	srpt_free_srqs(sdev);
 	ib_dealloc_pd(sdev->pd);
 free_dev:
 	kfree(sdev);
@@ -3267,7 +3349,7 @@ static void srpt_remove_one(struct ib_device *device, void *client_data)
 	for (i = 0; i < sdev->device->phys_port_cnt; i++)
 		srpt_release_sport(&sdev->port[i]);
 
-	srpt_free_srq(sdev);
+	srpt_free_srqs(sdev);
 
 	ib_dealloc_pd(sdev->pd);
 
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.h b/drivers/infiniband/ulp/srpt/ib_srpt.h
index 5c40653..cad8635 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.h
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.h
@@ -42,6 +42,7 @@
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_sa.h>
 #include <rdma/ib_cm.h>
+#include <rdma/srq_pool.h>
 #include <rdma/rdma_cm.h>
 #include <rdma/rw.h>
 
@@ -56,6 +57,7 @@
 #define SRP_SERVICE_NAME_PREFIX		"SRP.T10:"
 
 struct srpt_nexus;
+struct srpt_srq;
 
 enum {
 	/*
@@ -255,6 +257,7 @@ enum rdma_ch_state {
 /**
  * struct srpt_rdma_ch - RDMA channel
  * @nexus:         I_T nexus this channel is associated with.
+ * @srq:           SRQ that this channel is associated with (if use_srq=True).
  * @qp:            IB queue pair used for communicating over this channel.
  * @ib_cm:	   See below.
  * @ib_cm.cm_id:   IB CM ID associated with the channel.
@@ -296,6 +299,7 @@ enum rdma_ch_state {
  */
 struct srpt_rdma_ch {
 	struct srpt_nexus	*nexus;
+	struct srpt_srq		*srq;
 	struct ib_qp		*qp;
 	union {
 		struct {
@@ -434,17 +438,29 @@ struct srpt_port {
 };
 
 /**
+ * struct srpt_srq - SRQ (shared receive queue) context for SRPT
+ * @ibsrq:         verbs SRQ pointer.
+ * @ioctx_ring:    Per SRQ ring.
+ * @sdev:          backpointer to the HCA information.
+ */
+struct srpt_srq {
+	struct ib_srq		*ibsrq;
+	struct srpt_recv_ioctx	**ioctx_ring;
+	struct srpt_device	*sdev;
+};
+
+/**
  * struct srpt_device - information associated by SRPT with a single HCA
  * @device:        Backpointer to the struct ib_device managed by the IB core.
  * @pd:            IB protection domain.
  * @lkey:          L_Key (local key) with write access to all local memory.
- * @srq:           Per-HCA SRQ (shared receive queue).
  * @cm_id:         Connection identifier.
- * @srq_size:      SRQ size.
+ * @srqs:          SRQ's array.
+ * @srq_count:     SRQs array size.
+ * @srq_size:      SRQ size for each in SRQ the array.
  * @sdev_mutex:	   Serializes use_srq changes.
  * @use_srq:       Whether or not to use SRQ.
  * @req_buf_cache: kmem_cache for @ioctx_ring buffers.
- * @ioctx_ring:    Per-HCA SRQ.
  * @event_handler: Per-HCA asynchronous IB event handler.
  * @list:          Node in srpt_dev_list.
  * @port:          Information about the ports owned by this HCA.
@@ -453,13 +469,13 @@ struct srpt_device {
 	struct ib_device	*device;
 	struct ib_pd		*pd;
 	u32			lkey;
-	struct ib_srq		*srq;
 	struct ib_cm_id		*cm_id;
+	struct srpt_srq		**srqs;
+	int			srq_count;
 	int			srq_size;
 	struct mutex		sdev_mutex;
 	bool			use_srq;
 	struct kmem_cache	*req_buf_cache;
-	struct srpt_recv_ioctx	**ioctx_ring;
 	struct ib_event_handler	event_handler;
 	struct list_head	list;
 	struct srpt_port        port[];
-- 
1.8.3.1

