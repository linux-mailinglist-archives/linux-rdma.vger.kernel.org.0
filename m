Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1DED5245
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Oct 2019 21:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfJLTnC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 12 Oct 2019 15:43:02 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34261 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbfJLTnC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 12 Oct 2019 15:43:02 -0400
Received: by mail-io1-f66.google.com with SMTP id q1so28680313ion.1
        for <linux-rdma@vger.kernel.org>; Sat, 12 Oct 2019 12:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=UAV0MESdIdbnriLkEMnkjDOJVfThCot1FzK4/9ryBfI=;
        b=l/PHE0cqliQaLxsEbzLAT/rrESG05rJgk6PsMbT9tHbAVx0lNM7+U279FHtK2tQsHL
         xM4sLcz699wo8zjxRSm1P8oCxNFD0Vqplbm1G0otqiwit3qPwXN5sUErapLady9fZPIY
         bqY4ClcWuA/mgkJ+LzIVsF6YQVX3A1b94bmQT3sDI5V6RPNUOL3SL8y0M5FPaBGQg5wM
         HzUGVfhqE/bFiClY1H+wXR+n5uU60iawGor3aOFWjP1C2FrLrSseUBBo2sap2xdi3Kh5
         7/xYJKyELERxMEJpG69R8RZJJzNhiIX9KyQZZnl4sl5/CPf55bP2Bo6AJisfAR2ZAJtS
         dRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=UAV0MESdIdbnriLkEMnkjDOJVfThCot1FzK4/9ryBfI=;
        b=M60VAwKsX8Ipmh/NkJsBXx+OKsL1k5OU8/dJBiqyCD9B8IL5/Zl/vwQRy65vSMnQvk
         m41zitcAybJJ/fir3w3Jle8QoVik77QzMOpRhNObZeUJi8ARTsHnLAzlHIVn7H0tMoaV
         jIPnY6BExtVx9Gl9fP3MGS6ZoRlNfhBEKenreYjW/e72BPcpKoehVohLeas1UsCuB72f
         d2grRsbggob1W78xS7Lqr+TsE3zbyLc52Et7Es1ltmu+wEQIS4bzFOi7LvMKFDXY7K+P
         Z9vQt/2GIFniFKx4e/ZPXhRsmhkH5+K8h8xDQwyZcSJyUCyggAxxsWMm+Ji9bUoy6xGu
         pGVg==
X-Gm-Message-State: APjAAAVUjgH6jErntoXPJ7sQPSoSRzhQJFPvYf4lVFHQVuUXOL83+Zv0
        S2RCQq6DjlMe3HWd88a6jEcrJprg
X-Google-Smtp-Source: APXvYqx5gpQbAYrIrF7UVwA5YRnrTncprDujPwIYQCfo+0WLBRuwkodcpXO3C81HZ7LKW5XAsBcnGg==
X-Received: by 2002:a5d:96cb:: with SMTP id r11mr13004519iol.266.1570909380748;
        Sat, 12 Oct 2019 12:43:00 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q74sm17687976iod.72.2019.10.12.12.42.59
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Oct 2019 12:42:59 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x9CJgulg011561
        for <linux-rdma@vger.kernel.org>; Sat, 12 Oct 2019 19:42:57 GMT
Subject: [PATCH v4] IB/core: Trace points for diagnosing completion queue
 issues
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org
Date:   Sat, 12 Oct 2019 15:42:56 -0400
Message-ID: <20191012193714.3336.53797.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/Makefile |    2 
 drivers/infiniband/core/cq.c     |   27 ++++
 drivers/infiniband/core/trace.c  |   14 ++
 include/rdma/ib_verbs.h          |    5 +
 include/trace/events/rdma_core.h |  251 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 295 insertions(+), 4 deletions(-)
 create mode 100644 drivers/infiniband/core/trace.c
 create mode 100644 include/trace/events/rdma_core.h

Changes since v3:
- Reverted unnecessary behavior change in __ib_process_cq
- Clarified what "id" is in trace point output
- Added comment before new fields in struct ib_cq
- New trace point that fires when there is a CQ allocation failure

Changes since v2:
- Removed extraneous changes to include/trace/events/rdma.h

Changes since RFC:
- Display CQ's global resource ID instead of it's pointer address

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index 09881bd..68d9e27 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -11,7 +11,7 @@ ib_core-y :=			packer.o ud_header.o verbs.o cq.o rw.o sysfs.o \
 				device.o fmr_pool.o cache.o netlink.o \
 				roce_gid_mgmt.o mr_pool.o addr.o sa_query.o \
 				multicast.o mad.o smi.o agent.o mad_rmpp.o \
-				nldev.o restrack.o counters.o
+				nldev.o restrack.o counters.o trace.o
 
 ib_core-$(CONFIG_SECURITY_INFINIBAND) += security.o
 ib_core-$(CONFIG_CGROUP_RDMA) += cgroup.o
diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index bbfded6..e035895 100644
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
 
+static int __ib_poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc)
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
+	while ((n = __ib_poll_cq(cq, min_t(u32, batch,
+					   budget - completed), wcs)) > 0) {
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
index 0000000..6c3514b
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
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 6a47ba8..43468a3 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1555,6 +1555,11 @@ struct ib_cq {
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
index 0000000..0d56065
--- /dev/null
+++ b/include/trace/events/rdma_core.h
@@ -0,0 +1,251 @@
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
+#include <rdma/restrack.h>
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
+		__field(u32, id)
+	),
+
+	TP_fast_assign(
+		cq->timestamp = ktime_get();
+		cq->interrupt = true;
+
+		__entry->id = cq->res.id;
+	),
+
+	TP_printk("cq.id=%u", __entry->id)
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
+		__field(u32, id)
+	),
+
+	TP_fast_assign(
+		cq->timestamp = ktime_get();
+		cq->interrupt = false;
+
+		__entry->id = cq->res.id;
+	),
+
+	TP_printk("cq.id=%u", __entry->id)
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
+		__field(s64, latency)
+		__field(u32, id)
+		__field(bool, interrupt)
+	),
+
+	TP_fast_assign(
+		ktime_t latency = ktime_sub(ktime_get(), cq->timestamp);
+
+		__entry->id = cq->res.id;
+		__entry->latency = ktime_to_us(latency);
+		__entry->interrupt = cq->interrupt;
+	),
+
+	TP_printk("cq.id=%u wake-up took %lld [us] from %s",
+		__entry->id, __entry->latency,
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
+		__field(u32, id)
+		__field(int, requested)
+		__field(int, rc)
+	),
+
+	TP_fast_assign(
+		__entry->id = cq->res.id;
+		__entry->requested = requested;
+		__entry->rc = rc;
+	),
+
+	TP_printk("cq.id=%u requested %d, returned %d",
+		__entry->id, __entry->requested, __entry->rc
+	)
+);
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
+		__field(u32, id)
+		__field(unsigned int, comps)
+		__field(unsigned int, usec)
+	),
+
+	TP_fast_assign(
+		__entry->id = cq->res.id;
+		__entry->comps = comps;
+		__entry->usec = usec;
+	),
+
+	TP_printk("cq.id=%u comps=%u usec=%u",
+		__entry->id, __entry->comps, __entry->usec
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
+		__field(u32, id)
+		__field(int, nr_cqe)
+		__field(int, comp_vector)
+		__field(unsigned long, poll_ctx)
+	),
+
+	TP_fast_assign(
+		__entry->id = cq->res.id;
+		__entry->nr_cqe = nr_cqe;
+		__entry->comp_vector = comp_vector;
+		__entry->poll_ctx = poll_ctx;
+	),
+
+	TP_printk("cq.id=%u nr_cqe=%d comp_vector=%d poll_ctx=%s",
+		__entry->id, __entry->nr_cqe, __entry->comp_vector,
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
+		__field(u32, id)
+	),
+
+	TP_fast_assign(
+		__entry->id = cq->res.id;
+	),
+
+	TP_printk("cq.id=%u", __entry->id)
+);
+
+#endif /* _TRACE_RDMA_CORE_H */
+
+#include <trace/define_trace.h>

