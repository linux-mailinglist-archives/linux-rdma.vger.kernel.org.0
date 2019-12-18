Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09D6412530A
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Dec 2019 21:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbfLRUSS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Dec 2019 15:18:18 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46997 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfLRUSS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Dec 2019 15:18:18 -0500
Received: by mail-yb1-f196.google.com with SMTP id v15so1269102ybp.13
        for <linux-rdma@vger.kernel.org>; Wed, 18 Dec 2019 12:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=8ToW+q3t+tcDSUgn7p2DRA98Vtmn4ukYfkUF0gyst9o=;
        b=MrAWXI3hTsJNZG+wflsn5qZ1HxqasZwOIb+pjSjJdHLRysPGNc6qCnL4MHHsge0v6p
         85qpsS3165rR2KfvH/PZBrPpAZpeZVT2dD9u+kVXNpx7cGOvZhh0PvfLYGK+I153zg1W
         uqTsGiRVgU3htYWA2J93V5614G40seUFgxdyTNa34TTNN7sPgkasXYz8A1StpDQ/ES/o
         D7dtB+C6O0o+n+WPWVqdeaEnZl0xkqmwtywmiiMFQ4hxUCtY7CzM2C2+leI/MPNVTXmu
         //tajukSJz+veEpMidU9D+cSYqN6xIZ/hcqjTkCgDXK44/NGs09VAmo5Clvc67A9FyUV
         TglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=8ToW+q3t+tcDSUgn7p2DRA98Vtmn4ukYfkUF0gyst9o=;
        b=eL1imFd+ypFaiIxBllFV2ToZ+NhABQjsADRhdQEI8joP4mh2rIHJhEUgaMHzgiISSn
         nwbdCec8oscty2TVZNivRED0FUTNqUdiBj5sBswjQRKKjdo6TTCDbsqYWEUS8yH4XNsb
         ZrQfB+LU6Uooqczi2yey4d3aUtJ4WQA80WufW+edHxOiN6fT1wzduQh54UM5QVHsJkgo
         VdYX1wHrdSdYhfaNvI7bKbbNdGdzrY9WI78iFuborbjJEoLJi4EbDNufC2+vmCLKAGhm
         2xURCKgymcRS9HSQWHQsPeTbYFS41D/SCod3v530ADd4i/2jtIC1nQUWVg6ks+l8Yckx
         koYA==
X-Gm-Message-State: APjAAAVnZ6yM8txc2MK3ZZ+8CDZCmqcLZk0NodD9EnuSclZ6n9J44vCE
        9xGBHXe6dv9E7R+XNgZci3L+SrtI
X-Google-Smtp-Source: APXvYqy/UMKqCz5p8Ls5nIuJPZmANWesG+aMK4WOMnlHZgZpoWKFXGCauYFaJOJ/2JMF8+iqjhXNCQ==
X-Received: by 2002:a25:6c86:: with SMTP id h128mr3326594ybc.53.1576700296820;
        Wed, 18 Dec 2019 12:18:16 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d13sm1435288ywj.91.2019.12.18.12.18.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 12:18:16 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id xBIKIF4A022500;
        Wed, 18 Dec 2019 20:18:15 GMT
Subject: [PATCH v10 2/3] RDMA/core: Trace points for diagnosing completion
 queue issues
From:   Chuck Lever <chuck.lever@oracle.com>
To:     dledford@redhat.com, jgg@mellanox.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Date:   Wed, 18 Dec 2019 15:18:15 -0500
Message-ID: <20191218201815.30584.3481.stgit@manet.1015granger.net>
In-Reply-To: <20191218201631.30584.53987.stgit@manet.1015granger.net>
References: <20191218201631.30584.53987.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Sample trace events:

   kworker/u29:0-300   [007]   120.042217: cq_alloc:             cq.id=4 nr_cqe=161 comp_vector=2 poll_ctx=WORKQUEUE
          <idle>-0     [002]   120.056292: cq_schedule:          cq.id=4
    kworker/2:1H-482   [002]   120.056402: cq_process:           cq.id=4 wake-up took 109 [us] from interrupt
    kworker/2:1H-482   [002]   120.056407: cq_poll:              cq.id=4 requested 16, returned 1
          <idle>-0     [002]   120.067503: cq_schedule:          cq.id=4
    kworker/2:1H-482   [002]   120.067537: cq_process:           cq.id=4 wake-up took 34 [us] from interrupt
    kworker/2:1H-482   [002]   120.067541: cq_poll:              cq.id=4 requested 16, returned 1
          <idle>-0     [002]   120.067657: cq_schedule:          cq.id=4
    kworker/2:1H-482   [002]   120.067672: cq_process:           cq.id=4 wake-up took 15 [us] from interrupt
    kworker/2:1H-482   [002]   120.067674: cq_poll:              cq.id=4 requested 16, returned 1

 ...

         systemd-1     [002]   122.392653: cq_schedule:          cq.id=4
    kworker/2:1H-482   [002]   122.392688: cq_process:           cq.id=4 wake-up took 35 [us] from interrupt
    kworker/2:1H-482   [002]   122.392693: cq_poll:              cq.id=4 requested 16, returned 16
    kworker/2:1H-482   [002]   122.392836: cq_poll:              cq.id=4 requested 16, returned 16
    kworker/2:1H-482   [002]   122.392970: cq_poll:              cq.id=4 requested 16, returned 16
    kworker/2:1H-482   [002]   122.393083: cq_poll:              cq.id=4 requested 16, returned 16
    kworker/2:1H-482   [002]   122.393195: cq_poll:              cq.id=4 requested 16, returned 3

Several features to note in this output:
 - The WCE count and context type are reported at allocation time
 - The CPU and kworker for each CQ is evident
 - The CQ's restracker ID is tagged on each trace event
 - CQ poll scheduling latency is measured
 - Details about how often single completions occur versus multiple
   completions are evident
 - The cost of the ULP's completion handler is recorded

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
---
 drivers/infiniband/core/Makefile |    3 
 drivers/infiniband/core/cq.c     |   27 +++-
 drivers/infiniband/core/trace.c  |   14 ++
 drivers/infiniband/core/verbs.c  |    4 +
 include/rdma/ib_verbs.h          |    5 +
 include/trace/events/rdma_core.h |  271 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 320 insertions(+), 4 deletions(-)
 create mode 100644 drivers/infiniband/core/trace.c
 create mode 100644 include/trace/events/rdma_core.h

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index f22555f982e2..2b86a514c9bf 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -11,7 +11,8 @@ ib_core-y :=			packer.o ud_header.o verbs.o cq.o rw.o sysfs.o \
 				device.o fmr_pool.o cache.o netlink.o \
 				roce_gid_mgmt.o mr_pool.o addr.o sa_query.o \
 				multicast.o mad.o smi.o agent.o mad_rmpp.o \
-				nldev.o restrack.o counters.o ib_core_uverbs.o
+				nldev.o restrack.o counters.o ib_core_uverbs.o \
+				trace.o
 
 ib_core-$(CONFIG_SECURITY_INFINIBAND) += security.o
 ib_core-$(CONFIG_CGROUP_RDMA) += cgroup.o
diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index bbfded6d5d3d..4f25b2400694 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -7,6 +7,8 @@
 #include <linux/slab.h>
 #include <rdma/ib_verbs.h>
 
+#include <trace/events/rdma_core.h>
+
 /* # of WCs to poll for with a single call to ib_poll_cq */
 #define IB_POLL_BATCH			16
 #define IB_POLL_BATCH_DIRECT		8
@@ -41,6 +43,7 @@ static void ib_cq_rdma_dim_work(struct work_struct *w)
 
 	dim->state = DIM_START_MEASURE;
 
+	trace_cq_modify(cq, comps, usec);
 	cq->device->ops.modify_cq(cq, comps, usec);
 }
 
@@ -65,18 +68,29 @@ static void rdma_dim_init(struct ib_cq *cq)
 	INIT_WORK(&dim->work, ib_cq_rdma_dim_work);
 }
 
+static int __poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc)
+{
+	int rc;
+
+	rc = ib_poll_cq(cq, num_entries, wc);
+	trace_cq_poll(cq, num_entries, rc);
+	return rc;
+}
+
 static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc *wcs,
 			   int batch)
 {
 	int i, n, completed = 0;
 
+	trace_cq_process(cq);
+
 	/*
 	 * budget might be (-1) if the caller does not
 	 * want to bound this call, thus we need unsigned
 	 * minimum here.
 	 */
-	while ((n = ib_poll_cq(cq, min_t(u32, batch,
-					 budget - completed), wcs)) > 0) {
+	while ((n = __poll_cq(cq, min_t(u32, batch,
+					budget - completed), wcs)) > 0) {
 		for (i = 0; i < n; i++) {
 			struct ib_wc *wc = &wcs[i];
 
@@ -131,8 +145,10 @@ static int ib_poll_handler(struct irq_poll *iop, int budget)
 	completed = __ib_process_cq(cq, budget, cq->wc, IB_POLL_BATCH);
 	if (completed < budget) {
 		irq_poll_complete(&cq->iop);
-		if (ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0)
+		if (ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0) {
+			trace_cq_reschedule(cq);
 			irq_poll_sched(&cq->iop);
+		}
 	}
 
 	if (dim)
@@ -143,6 +159,7 @@ static int ib_poll_handler(struct irq_poll *iop, int budget)
 
 static void ib_cq_completion_softirq(struct ib_cq *cq, void *private)
 {
+	trace_cq_schedule(cq);
 	irq_poll_sched(&cq->iop);
 }
 
@@ -162,6 +179,7 @@ static void ib_cq_poll_work(struct work_struct *work)
 
 static void ib_cq_completion_workqueue(struct ib_cq *cq, void *private)
 {
+	trace_cq_schedule(cq);
 	queue_work(cq->comp_wq, &cq->work);
 }
 
@@ -239,6 +257,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
 		goto out_destroy_cq;
 	}
 
+	trace_cq_alloc(cq, nr_cqe, comp_vector, poll_ctx);
 	return cq;
 
 out_destroy_cq:
@@ -248,6 +267,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
 	kfree(cq->wc);
 out_free_cq:
 	kfree(cq);
+	trace_cq_alloc_error(nr_cqe, comp_vector, poll_ctx, ret);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL(__ib_alloc_cq_user);
@@ -304,6 +324,7 @@ void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 		WARN_ON_ONCE(1);
 	}
 
+	trace_cq_free(cq);
 	rdma_restrack_del(&cq->res);
 	cq->device->ops.destroy_cq(cq, udata);
 	if (cq->dim)
diff --git a/drivers/infiniband/core/trace.c b/drivers/infiniband/core/trace.c
new file mode 100644
index 000000000000..6c3514beac4d
--- /dev/null
+++ b/drivers/infiniband/core/trace.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Trace points for core RDMA functions.
+ *
+ * Author: Chuck Lever <chuck.lever@oracle.com>
+ *
+ * Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved.
+ */
+
+#define CREATE_TRACE_POINTS
+
+#include <rdma/ib_verbs.h>
+
+#include <trace/events/rdma_core.h>
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index dd765e176cdd..289b2f7a9d5e 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -53,6 +53,8 @@
 
 #include "core_priv.h"
 
+#include <trace/events/rdma_core.h>
+
 static int ib_resolve_eth_dmac(struct ib_device *device,
 			       struct rdma_ah_attr *ah_attr);
 
@@ -2744,6 +2746,7 @@ void ib_drain_sq(struct ib_qp *qp)
 		qp->device->ops.drain_sq(qp);
 	else
 		__ib_drain_sq(qp);
+	trace_cq_drain_complete(qp->send_cq);
 }
 EXPORT_SYMBOL(ib_drain_sq);
 
@@ -2772,6 +2775,7 @@ void ib_drain_rq(struct ib_qp *qp)
 		qp->device->ops.drain_rq(qp);
 	else
 		__ib_drain_rq(qp);
+	trace_cq_drain_complete(qp->recv_cq);
 }
 EXPORT_SYMBOL(ib_drain_rq);
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 5608e14e3aad..42f28d39f28c 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1558,6 +1558,11 @@ struct ib_cq {
 	};
 	struct workqueue_struct *comp_wq;
 	struct dim *dim;
+
+	/* updated only by trace points */
+	ktime_t timestamp;
+	bool interrupt;
+
 	/*
 	 * Implementation details of the RDMA core, don't use in drivers:
 	 */
diff --git a/include/trace/events/rdma_core.h b/include/trace/events/rdma_core.h
new file mode 100644
index 000000000000..08f481554e7f
--- /dev/null
+++ b/include/trace/events/rdma_core.h
@@ -0,0 +1,271 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Trace point definitions for core RDMA functions.
+ *
+ * Author: Chuck Lever <chuck.lever@oracle.com>
+ *
+ * Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rdma_core
+
+#if !defined(_TRACE_RDMA_CORE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_RDMA_CORE_H
+
+#include <linux/tracepoint.h>
+#include <rdma/ib_verbs.h>
+
+/*
+ * enum ib_poll_context, from include/rdma/ib_verbs.h
+ */
+#define IB_POLL_CTX_LIST			\
+	ib_poll_ctx(DIRECT)			\
+	ib_poll_ctx(SOFTIRQ)			\
+	ib_poll_ctx(WORKQUEUE)			\
+	ib_poll_ctx_end(UNBOUND_WORKQUEUE)
+
+#undef ib_poll_ctx
+#undef ib_poll_ctx_end
+
+#define ib_poll_ctx(x)		TRACE_DEFINE_ENUM(IB_POLL_##x);
+#define ib_poll_ctx_end(x)	TRACE_DEFINE_ENUM(IB_POLL_##x);
+
+IB_POLL_CTX_LIST
+
+#undef ib_poll_ctx
+#undef ib_poll_ctx_end
+
+#define ib_poll_ctx(x)		{ IB_POLL_##x, #x },
+#define ib_poll_ctx_end(x)	{ IB_POLL_##x, #x }
+
+#define rdma_show_ib_poll_ctx(x) \
+		__print_symbolic(x, IB_POLL_CTX_LIST)
+
+/**
+ ** Completion Queue events
+ **/
+
+TRACE_EVENT(cq_schedule,
+	TP_PROTO(
+		struct ib_cq *cq
+	),
+
+	TP_ARGS(cq),
+
+	TP_STRUCT__entry(
+		__field(u32, cq_id)
+	),
+
+	TP_fast_assign(
+		cq->timestamp = ktime_get();
+		cq->interrupt = true;
+
+		__entry->cq_id = cq->res.id;
+	),
+
+	TP_printk("cq.id=%u", __entry->cq_id)
+);
+
+TRACE_EVENT(cq_reschedule,
+	TP_PROTO(
+		struct ib_cq *cq
+	),
+
+	TP_ARGS(cq),
+
+	TP_STRUCT__entry(
+		__field(u32, cq_id)
+	),
+
+	TP_fast_assign(
+		cq->timestamp = ktime_get();
+		cq->interrupt = false;
+
+		__entry->cq_id = cq->res.id;
+	),
+
+	TP_printk("cq.id=%u", __entry->cq_id)
+);
+
+TRACE_EVENT(cq_process,
+	TP_PROTO(
+		const struct ib_cq *cq
+	),
+
+	TP_ARGS(cq),
+
+	TP_STRUCT__entry(
+		__field(u32, cq_id)
+		__field(bool, interrupt)
+		__field(s64, latency)
+	),
+
+	TP_fast_assign(
+		ktime_t latency = ktime_sub(ktime_get(), cq->timestamp);
+
+		__entry->cq_id = cq->res.id;
+		__entry->latency = ktime_to_us(latency);
+		__entry->interrupt = cq->interrupt;
+	),
+
+	TP_printk("cq.id=%u wake-up took %lld [us] from %s",
+		__entry->cq_id, __entry->latency,
+		__entry->interrupt ? "interrupt" : "reschedule"
+	)
+);
+
+TRACE_EVENT(cq_poll,
+	TP_PROTO(
+		const struct ib_cq *cq,
+		int requested,
+		int rc
+	),
+
+	TP_ARGS(cq, requested, rc),
+
+	TP_STRUCT__entry(
+		__field(u32, cq_id)
+		__field(int, requested)
+		__field(int, rc)
+	),
+
+	TP_fast_assign(
+		__entry->cq_id = cq->res.id;
+		__entry->requested = requested;
+		__entry->rc = rc;
+	),
+
+	TP_printk("cq.id=%u requested %d, returned %d",
+		__entry->cq_id, __entry->requested, __entry->rc
+	)
+);
+
+TRACE_EVENT(cq_drain_complete,
+	TP_PROTO(
+		const struct ib_cq *cq
+	),
+
+	TP_ARGS(cq),
+
+	TP_STRUCT__entry(
+		__field(u32, cq_id)
+	),
+
+	TP_fast_assign(
+		__entry->cq_id = cq->res.id;
+	),
+
+	TP_printk("cq.id=%u",
+		__entry->cq_id
+	)
+);
+
+
+TRACE_EVENT(cq_modify,
+	TP_PROTO(
+		const struct ib_cq *cq,
+		u16 comps,
+		u16 usec
+	),
+
+	TP_ARGS(cq, comps, usec),
+
+	TP_STRUCT__entry(
+		__field(u32, cq_id)
+		__field(unsigned int, comps)
+		__field(unsigned int, usec)
+	),
+
+	TP_fast_assign(
+		__entry->cq_id = cq->res.id;
+		__entry->comps = comps;
+		__entry->usec = usec;
+	),
+
+	TP_printk("cq.id=%u comps=%u usec=%u",
+		__entry->cq_id, __entry->comps, __entry->usec
+	)
+);
+
+TRACE_EVENT(cq_alloc,
+	TP_PROTO(
+		const struct ib_cq *cq,
+		int nr_cqe,
+		int comp_vector,
+		enum ib_poll_context poll_ctx
+	),
+
+	TP_ARGS(cq, nr_cqe, comp_vector, poll_ctx),
+
+	TP_STRUCT__entry(
+		__field(u32, cq_id)
+		__field(int, nr_cqe)
+		__field(int, comp_vector)
+		__field(unsigned long, poll_ctx)
+	),
+
+	TP_fast_assign(
+		__entry->cq_id = cq->res.id;
+		__entry->nr_cqe = nr_cqe;
+		__entry->comp_vector = comp_vector;
+		__entry->poll_ctx = poll_ctx;
+	),
+
+	TP_printk("cq.id=%u nr_cqe=%d comp_vector=%d poll_ctx=%s",
+		__entry->cq_id, __entry->nr_cqe, __entry->comp_vector,
+		rdma_show_ib_poll_ctx(__entry->poll_ctx)
+	)
+);
+
+TRACE_EVENT(cq_alloc_error,
+	TP_PROTO(
+		int nr_cqe,
+		int comp_vector,
+		enum ib_poll_context poll_ctx,
+		int rc
+	),
+
+	TP_ARGS(nr_cqe, comp_vector, poll_ctx, rc),
+
+	TP_STRUCT__entry(
+		__field(int, rc)
+		__field(int, nr_cqe)
+		__field(int, comp_vector)
+		__field(unsigned long, poll_ctx)
+	),
+
+	TP_fast_assign(
+		__entry->rc = rc;
+		__entry->nr_cqe = nr_cqe;
+		__entry->comp_vector = comp_vector;
+		__entry->poll_ctx = poll_ctx;
+	),
+
+	TP_printk("nr_cqe=%d comp_vector=%d poll_ctx=%s rc=%d",
+		__entry->nr_cqe, __entry->comp_vector,
+		rdma_show_ib_poll_ctx(__entry->poll_ctx), __entry->rc
+	)
+);
+
+TRACE_EVENT(cq_free,
+	TP_PROTO(
+		const struct ib_cq *cq
+	),
+
+	TP_ARGS(cq),
+
+	TP_STRUCT__entry(
+		__field(u32, cq_id)
+	),
+
+	TP_fast_assign(
+		__entry->cq_id = cq->res.id;
+	),
+
+	TP_printk("cq.id=%u", __entry->cq_id)
+);
+
+#endif /* _TRACE_RDMA_CORE_H */
+
+#include <trace/define_trace.h>

