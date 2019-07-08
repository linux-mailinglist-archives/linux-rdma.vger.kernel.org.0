Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B779061D56
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 12:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbfGHK7W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jul 2019 06:59:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfGHK7W (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 8 Jul 2019 06:59:22 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2FA82087F;
        Mon,  8 Jul 2019 10:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562583560;
        bh=Hg/rwYVz6BEgNnxMkj5msh4YbOaYGbk0l+VlVJOy6Bw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VeyovYFfdvJlUhfaptFTMFrrroN/XzFoQYIFkp0pr4U/yViYKnEKxpzCzNDucOUwc
         Ae/p1ztltSyyWbfEtmf9NTeRhHCO6bRfsLuQshyjo2TOfPIpdv3APr+ZSR8+0qeiif
         KmKgIzuLctWJoYi3hCquEsoezYbWpbeLjMeJgcp4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yamin Friedman <yaminf@mellanox.com>
Subject: [PATCH rdma-next v5 2/4] RDMA/core: Provide RDMA DIM support for ULPs
Date:   Mon,  8 Jul 2019 13:59:03 +0300
Message-Id: <20190708105905.27468-3-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190708105905.27468-1-leon@kernel.org>
References: <20190708105905.27468-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yamin Friedman <yaminf@mellanox.com>

Added the interface in the infiniband driver that applies the rdma_dim
adaptive moderation. There is now a special function for allocating an
ib_cq that uses rdma_dim.

Performance improvement (ConnectX-5 100GbE, x86) running FIO benchmark over
NVMf between two equal end-hosts with 56 cores across a Mellanox switch
using null_blk device:

READS without DIM:
blk size | BW       | IOPS | 99th percentile latency  | 99.99th latency
512B     | 3.8GiB/s | 7.7M | 1401  usec               | 2442  usec
4k       | 7.0GiB/s | 1.8M | 4817  usec               | 6587  usec
64k      | 10.7GiB/s| 175k | 9896  usec               | 10028 usec

IO WRITES without DIM:
blk size | BW       | IOPS | 99th percentile latency  | 99.99th latency
512B     | 3.6GiB/s | 7.5M | 1434  usec               | 2474  usec
4k       | 6.3GiB/s | 1.6M | 938   usec               | 1221  usec
64k      | 10.7GiB/s| 175k | 8979  usec               | 12780 usec

IO READS with DIM:
blk size | BW       | IOPS | 99th percentile latency  | 99.99th latency
512B     | 4GiB/s   | 8.2M | 816    usec              | 889   usec
4k       | 10.1GiB/s| 2.65M| 3359   usec              | 5080  usec
64k      | 10.7GiB/s| 175k | 9896   usec              | 10028 usec

IO WRITES with DIM:
blk size | BW       | IOPS  | 99th percentile latency | 99.99th latency
512B     | 3.9GiB/s | 8.1M  | 799   usec              | 922   usec
4k       | 9.6GiB/s | 2.5M  | 717   usec              | 1004  usec
64k      | 10.7GiB/s| 176k  | 8586  usec              | 12256 usec

The rdma_dim algorithm was designed to measure the effectiveness of
moderation on the flow in a general way and thus should be appropriate
for all RDMA storage protocols.

rdma_dim is configured to be the default option based on performance
improvement seen after extensive tests.

Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cq.c | 45 ++++++++++++++++++++++++++++++++++++
 include/rdma/ib_verbs.h      |  4 ++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index 00d70f166209..ffd6e24109d5 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -18,6 +18,40 @@
 #define IB_POLL_FLAGS \
 	(IB_CQ_NEXT_COMP | IB_CQ_REPORT_MISSED_EVENTS)
 
+static void ib_cq_rdma_dim_work(struct work_struct *w)
+{
+	struct dim *dim = container_of(w, struct dim, work);
+	struct ib_cq *cq = dim->priv;
+
+	u16 usec = rdma_dim_prof[dim->profile_ix].usec;
+	u16 comps = rdma_dim_prof[dim->profile_ix].comps;
+
+	dim->state = DIM_START_MEASURE;
+
+	cq->device->ops.modify_cq(cq, comps, usec);
+}
+
+static void rdma_dim_init(struct ib_cq *cq)
+{
+	struct dim *dim;
+
+	if (!cq->device->ops.modify_cq || !cq->device->use_cq_dim ||
+	    cq->poll_ctx == IB_POLL_DIRECT)
+		return;
+
+	dim = kzalloc(sizeof(struct dim), GFP_KERNEL);
+	if (!dim)
+		return;
+
+	dim->state = DIM_START_MEASURE;
+	dim->tune_state = DIM_GOING_RIGHT;
+	dim->profile_ix = RDMA_DIM_START_PROFILE;
+	dim->priv = cq;
+	cq->dim = dim;
+
+	INIT_WORK(&dim->work, ib_cq_rdma_dim_work);
+}
+
 static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc *wcs,
 			   int batch)
 {
@@ -78,6 +112,7 @@ static void ib_cq_completion_direct(struct ib_cq *cq, void *private)
 static int ib_poll_handler(struct irq_poll *iop, int budget)
 {
 	struct ib_cq *cq = container_of(iop, struct ib_cq, iop);
+	struct dim *dim = cq->dim;
 	int completed;
 
 	completed = __ib_process_cq(cq, budget, cq->wc, IB_POLL_BATCH);
@@ -87,6 +122,9 @@ static int ib_poll_handler(struct irq_poll *iop, int budget)
 			irq_poll_sched(&cq->iop);
 	}
 
+	if (dim)
+		rdma_dim(dim, completed);
+
 	return completed;
 }
 
@@ -105,6 +143,8 @@ static void ib_cq_poll_work(struct work_struct *work)
 	if (completed >= IB_POLL_BUDGET_WORKQUEUE ||
 	    ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0)
 		queue_work(cq->comp_wq, &cq->work);
+	else if (cq->dim)
+		rdma_dim(cq->dim, completed);
 }
 
 static void ib_cq_completion_workqueue(struct ib_cq *cq, void *private)
@@ -161,6 +201,8 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
 
 	rdma_restrack_kadd(&cq->res);
 
+	rdma_dim_init(cq);
+
 	switch (cq->poll_ctx) {
 	case IB_POLL_DIRECT:
 		cq->comp_handler = ib_cq_completion_direct;
@@ -223,6 +265,9 @@ void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 
 	rdma_restrack_del(&cq->res);
 	cq->device->ops.destroy_cq(cq, udata);
+	if (cq->dim)
+		cancel_work_sync(&cq->dim->work);
+	kfree(cq->dim);
 	kfree(cq->wc);
 	kfree(cq);
 }
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 50806bef9f20..30eb68f36109 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -61,6 +61,7 @@
 #include <linux/cgroup_rdma.h>
 #include <linux/irqflags.h>
 #include <linux/preempt.h>
+#include <linux/dim.h>
 #include <uapi/rdma/ib_user_verbs.h>
 #include <rdma/rdma_counter.h>
 #include <rdma/restrack.h>
@@ -1509,6 +1510,7 @@ struct ib_cq {
 		struct work_struct	work;
 	};
 	struct workqueue_struct *comp_wq;
+	struct dim *dim;
 	/*
 	 * Implementation details of the RDMA core, don't use in drivers:
 	 */
@@ -2576,6 +2578,8 @@ struct ib_device {
 	u16                          is_switch:1;
 	/* Indicates kernel verbs support, should not be used in drivers */
 	u16                          kverbs_provider:1;
+	/* CQ adaptive moderation (RDMA DIM) */
+	u16                          use_cq_dim:1;
 	u8                           node_type;
 	u8                           phys_port_cnt;
 	struct ib_device_attr        attrs;
-- 
2.20.1

