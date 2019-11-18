Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4710F100E36
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Nov 2019 22:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfKRVtM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Nov 2019 16:49:12 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38584 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfKRVtM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Nov 2019 16:49:12 -0500
Received: by mail-yw1-f65.google.com with SMTP id m196so6490051ywd.5
        for <linux-rdma@vger.kernel.org>; Mon, 18 Nov 2019 13:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZzNsRwDhbXkzlbI/oeowujajaY17AWj78W9g9gERIY8=;
        b=vTQADTYYUcjUc3zzXiZjRsdNYyAM3HQyQXUo1oS8Crf5f+8tzJg6u8yPa28iNzsN/X
         og6PSZCUAbg9hurqLS3zWne4bFVnvGaae47C6n+KDDeU3BbQp/LflK8x46d/XVRJ/cJt
         WC0r0u/yZOlzmqBOT77GyeO64Bk8X93EsIiAnYX12d6NAmgFsfb0J+Ch7zWXXnTroz5Q
         mZ0Iv+HmygOOPxsaHj3DutYzNZm/QZy8DiiK7XDZtJ6KbbJKTkdsYq1RsWFHqvp9r7Xl
         hlSmRuItI06IR1+LLCKkONukr0FpGFcpi+vas94kztmvDZgEgLQhNU+fj3Y7ce/8d0UQ
         TU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZzNsRwDhbXkzlbI/oeowujajaY17AWj78W9g9gERIY8=;
        b=hKIgwcrjRhpQwDShltNBai+LBF3htbQb6pz2XG7woOiHV0AzOOx6+hlGMVhM34209L
         At6T8hD4FLtf/KpFZq4wICeGVmgDH0Qcr7M3qEglub1fNwzO2WwdF3qtOvzVQAwwx9zf
         Acy6iYLNyOvBxCZtuXoGfovHEM2tBCsPCWt3l9k2vJxXi48a9F++I3fQCGosqKy2uaUZ
         2wYy5h2Bes/3jAV2MenRxAlw+oVZNPcyN97SV1RwxbwxKBbRb8eSDhvAwWEPl0HlPMeg
         t/QBIJBWLtyEWAHU2Z1kGG64EPky181b1np+RITiNSX6NSQomey1CVBmAoVmeAKcW8kB
         C0PA==
X-Gm-Message-State: APjAAAW118ivU5epcfsEr2xTBEG9UJOSx8SzDdfooff9WLmB55iFz2Hk
        oimpFBPDXQL+pbMSOFSBAWZzVoHrkas=
X-Google-Smtp-Source: APXvYqxVU2kahgYr2tddwKnnpC1qRo6s/qQvgzGUZUg2/9qrzbX7RdxlpxoTDI0TnGdvezvxDQhSnA==
X-Received: by 2002:a0d:d701:: with SMTP id z1mr20157771ywd.430.1574113751054;
        Mon, 18 Nov 2019 13:49:11 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t7sm8895234ywe.19.2019.11.18.13.49.10
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 13:49:10 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id xAILn9Ks011176
        for <linux-rdma@vger.kernel.org>; Mon, 18 Nov 2019 21:49:09 GMT
Subject: [PATCH v6 1/2] RDMA/core: Trace points for diagnosing completion
 queue issues
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org
Date:   Mon, 18 Nov 2019 16:49:09 -0500
Message-ID: <20191118214906.27891.14380.stgit@manet.1015granger.net>
In-Reply-To: <20191118214447.27891.58814.stgit@manet.1015granger.net>
References: <20191118214447.27891.58814.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
---
 drivers/infiniband/core/Makefile |    2 
 drivers/infiniband/core/cq.c     |   36 +++++
 drivers/infiniband/core/trace.c  |   14 ++
 include/rdma/ib_verbs.h          |   11 +-
 include/trace/events/rdma_core.h |  250 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 306 insertions(+), 7 deletions(-)
 create mode 100644 drivers/infiniband/core/trace.c
 create mode 100644 include/trace/events/rdma_core.h

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index 09881bd5f12d..68d9e27c3c61 100644
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
index bbfded6d5d3d..98931472eaa0 100644
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
 
@@ -65,11 +68,35 @@ static void rdma_dim_init(struct ib_cq *cq)
 	INIT_WORK(&dim->work, ib_cq_rdma_dim_work);
 }
 
+/**
+ * ib_poll_cq - poll a CQ for completion(s)
+ * @cq: the CQ being polled
+ * @num_entries: maximum number of completions to return
+ * @wc: array of at least @num_entries &struct ib_wc where completions
+ *      will be returned
+ *
+ * Poll a CQ for (possibly multiple) completions.  If the return value
+ * is < 0, an error occurred.  If the return value is >= 0, it is the
+ * number of completions returned.  If the return value is
+ * non-negative and < num_entries, then the CQ was emptied.
+ */
+int ib_poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc)
+{
+	int rc;
+
+	rc = cq->device->ops.poll_cq(cq, num_entries, wc);
+	trace_cq_poll(cq, num_entries, rc);
+	return rc;
+}
+EXPORT_SYMBOL(ib_poll_cq);
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
@@ -131,8 +158,10 @@ static int ib_poll_handler(struct irq_poll *iop, int budget)
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
@@ -143,6 +172,7 @@ static int ib_poll_handler(struct irq_poll *iop, int budget)
 
 static void ib_cq_completion_softirq(struct ib_cq *cq, void *private)
 {
+	trace_cq_schedule(cq);
 	irq_poll_sched(&cq->iop);
 }
 
@@ -162,6 +192,7 @@ static void ib_cq_poll_work(struct work_struct *work)
 
 static void ib_cq_completion_workqueue(struct ib_cq *cq, void *private)
 {
+	trace_cq_schedule(cq);
 	queue_work(cq->comp_wq, &cq->work);
 }
 
@@ -239,6 +270,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
 		goto out_destroy_cq;
 	}
 
+	trace_cq_alloc(cq, nr_cqe, comp_vector, poll_ctx);
 	return cq;
 
 out_destroy_cq:
@@ -248,6 +280,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
 	kfree(cq->wc);
 out_free_cq:
 	kfree(cq);
+	trace_cq_alloc_error(nr_cqe, comp_vector, poll_ctx, ret);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL(__ib_alloc_cq_user);
@@ -304,6 +337,7 @@ void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
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
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index e7e733add99f..71353f81caf1 100644
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
@@ -3868,11 +3873,7 @@ static inline void ib_destroy_cq(struct ib_cq *cq)
  * number of completions returned.  If the return value is
  * non-negative and < num_entries, then the CQ was emptied.
  */
-static inline int ib_poll_cq(struct ib_cq *cq, int num_entries,
-			     struct ib_wc *wc)
-{
-	return cq->device->ops.poll_cq(cq, num_entries, wc);
-}
+int ib_poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc);
 
 /**
  * ib_req_notify_cq - Request completion notification on a CQ.
diff --git a/include/trace/events/rdma_core.h b/include/trace/events/rdma_core.h
new file mode 100644
index 000000000000..45f74c52ae24
--- /dev/null
+++ b/include/trace/events/rdma_core.h
@@ -0,0 +1,250 @@
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

