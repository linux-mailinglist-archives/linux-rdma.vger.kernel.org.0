Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 921F3CFF61
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2019 18:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfJHQ6h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Oct 2019 12:58:37 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33236 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfJHQ6g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Oct 2019 12:58:36 -0400
Received: by mail-io1-f65.google.com with SMTP id z19so38188470ior.0
        for <linux-rdma@vger.kernel.org>; Tue, 08 Oct 2019 09:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=DyChGZnWvZrWjyshx0N1JfSpeWTaTchfCsb7q025uyY=;
        b=P2DQHzIkpv8dHlYsE5zCvXqgGTuSQFnFSXK6/rPdgrWtBivG3HboYuC7eOeVT1T881
         04Hkt5yec4tbAo2dJMUEWhZezw1t3Vq3B/kIXuGMoAFBtkzqx7NPvU7FLgEB+1Rrb5WE
         RAG6nERvgEmXKpXvsLruEoqRxrpCmny8RHUbWWS7uu2PHj1fwqETbQLL9vZkAJ6l46/9
         gqD5OeMeCLO80z9Wq6BiSvUDyAOebC4HGrbZ79wxi6ufqBEvhxgSYBdbM/qSPPBNAm9J
         f1K/PbyHaCOQK9BqFxLT9mL5SIfOd7D9MBUgshNco9vlrgaZYlnUSSPFVwXWly6cd2aE
         +LMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=DyChGZnWvZrWjyshx0N1JfSpeWTaTchfCsb7q025uyY=;
        b=jDwA/w2Rp9ASTtvgGchWsRf/Uj2RXrEqq+hzci1p2o9DcRLe+bOEhtSpu7ugAus5qi
         uhi6reDc6xt7m6AO69gQeuC83QvExf/x88TzBDzaqFAJ7OynjgORm869diUF3uk2fikX
         stL8iqPK7s5rXvfXAMq7WyUP8QELKVMAKEUSe5gxj+sJbRuMz5MQKCjpMLAg0oPweuwZ
         g+qe6KzMPGB8QUbFVMzBmTtIPqxoJa5wXI2D0VaudgLoJNXzbemOyj9tw9BKvr/GQfbb
         zvOwZ7VgoG/3ML0fBvzWM6ysCHYocZSs/mjAdIyN0HgG42eRlIj+5XsnRC8JMiXNXGXy
         eitg==
X-Gm-Message-State: APjAAAVE1cOkxEvNtFv+W2+v7mnVmCwGUxCBuYt6khHnm8W/+7xgbv9i
        MoiPZjtQZ4/QGTMQVJ+WWq8+l+PP
X-Google-Smtp-Source: APXvYqwFTT1+hW858t/o14lrf76hIj21CmZDlgVL42OBbYoJTOJPHN3LEyJEoN0mEtfsXqCz9EB8Cg==
X-Received: by 2002:a6b:b792:: with SMTP id h140mr12603342iof.225.1570553915213;
        Tue, 08 Oct 2019 09:58:35 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id w16sm9548335ilc.62.2019.10.08.09.58.34
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 09:58:34 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x98GwWnO030978
        for <linux-rdma@vger.kernel.org>; Tue, 8 Oct 2019 16:58:33 GMT
Subject: [PATCH v2] IB/core: Trace points for diagnosing completion queue
 issues
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org
Date:   Tue, 08 Oct 2019 12:58:32 -0400
Message-ID: <20191008165832.4721.31859.stgit@manet.1015granger.net>
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
 drivers/infiniband/core/cq.c     |   29 ++++--
 drivers/infiniband/core/trace.c  |   14 +++
 include/rdma/ib_verbs.h          |    2 
 include/trace/events/rdma.h      |   91 ++++++++++++++++++
 include/trace/events/rdma_core.h |  193 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 321 insertions(+), 10 deletions(-)
 create mode 100644 drivers/infiniband/core/trace.c
 create mode 100644 include/trace/events/rdma_core.h

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
index bbfded6..bcde992 100644
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
 
@@ -70,13 +73,9 @@ static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc *wcs,
 {
 	int i, n, completed = 0;
 
-	/*
-	 * budget might be (-1) if the caller does not
-	 * want to bound this call, thus we need unsigned
-	 * minimum here.
-	 */
-	while ((n = ib_poll_cq(cq, min_t(u32, batch,
-					 budget - completed), wcs)) > 0) {
+	trace_cq_process(cq);
+	while ((n = ib_poll_cq(cq, batch, wcs)) > 0) {
+		trace_cq_poll(cq, batch, n);
 		for (i = 0; i < n; i++) {
 			struct ib_wc *wc = &wcs[i];
 
@@ -87,9 +86,15 @@ static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc *wcs,
 		}
 
 		completed += n;
-
 		if (n != batch || (budget != -1 && completed >= budget))
 			break;
+
+		/*
+		 * budget might be (-1) if the caller does not
+		 * want to bound this call, thus we need unsigned
+		 * minimum here.
+		 */
+		batch = min_t(u32, batch, budget - completed);
 	}
 
 	return completed;
@@ -131,8 +136,10 @@ static int ib_poll_handler(struct irq_poll *iop, int budget)
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
@@ -143,6 +150,7 @@ static int ib_poll_handler(struct irq_poll *iop, int budget)
 
 static void ib_cq_completion_softirq(struct ib_cq *cq, void *private)
 {
+	trace_cq_schedule(cq);
 	irq_poll_sched(&cq->iop);
 }
 
@@ -162,6 +170,7 @@ static void ib_cq_poll_work(struct work_struct *work)
 
 static void ib_cq_completion_workqueue(struct ib_cq *cq, void *private)
 {
+	trace_cq_schedule(cq);
 	queue_work(cq->comp_wq, &cq->work);
 }
 
@@ -239,6 +248,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
 		goto out_destroy_cq;
 	}
 
+	trace_cq_alloc(cq, comp_vector, poll_ctx);
 	return cq;
 
 out_destroy_cq:
@@ -304,6 +314,7 @@ void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
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
index 6a47ba8..95a6bce 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1555,6 +1555,8 @@ struct ib_cq {
 	};
 	struct workqueue_struct *comp_wq;
 	struct dim *dim;
+	ktime_t timestamp;
+	bool interrupt;
 	/*
 	 * Implementation details of the RDMA core, don't use in drivers:
 	 */
diff --git a/include/trace/events/rdma.h b/include/trace/events/rdma.h
index aa19afc..9a666f1 100644
--- a/include/trace/events/rdma.h
+++ b/include/trace/events/rdma.h
@@ -7,6 +7,8 @@
  * enum ib_event_type, from include/rdma/ib_verbs.h
  */
 
+#include <rdma/rdma_cm.h>
+
 #define IB_EVENT_LIST				\
 	ib_event(CQ_ERR)			\
 	ib_event(QP_FATAL)			\
@@ -127,3 +129,92 @@
 
 #define rdma_show_cm_event(x) \
 		__print_symbolic(x, RDMA_CM_EVENT_LIST)
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
+/*
+ * enum ib_wc_opcode, from include/rdma/ib_verbs.h
+ */
+#define IB_WC_OPCODE_LIST			\
+	ib_wc_opcode(SEND)			\
+	ib_wc_opcode(RDMA_WRITE)		\
+	ib_wc_opcode(RDMA_READ)			\
+	ib_wc_opcode(COMP_SWAP)			\
+	ib_wc_opcode(FETCH_ADD)			\
+	ib_wc_opcode(LSO)			\
+	ib_wc_opcode(LOCAL_INV)			\
+	ib_wc_opcode(REG_MR)			\
+	ib_wc_opcode(MASKED_COMP_SWAP)		\
+	ib_wc_opcode(MASKED_FETCH_ADD)		\
+	ib_wc_opcode(RECV)			\
+	ib_wc_opcode_end(RECV_RDMA_WITH_IMM)
+
+#undef ib_wc_opcode
+#undef ib_wc_opcode_end
+
+#define ib_wc_opcode(x)		TRACE_DEFINE_ENUM(IB_WC_##x);
+#define ib_wc_opcode_end(x)	TRACE_DEFINE_ENUM(IB_WC_##x);
+
+IB_WC_OPCODE_LIST
+
+#undef ib_wc_opcode
+#undef ib_wc_opcode_end
+
+#define ib_wc_opcode(x)		{ IB_WC_##x, #x },
+#define ib_wc_opcode_end(x)	{ IB_WC_##x, #x }
+
+#define rdma_show_wc_opcode(x) \
+		__print_symbolic(x, IB_WC_OPCODE_LIST)
+
+/*
+ * enum ib_wc_flags, from include/rdma/ib_verbs.h
+ */
+#define IB_WC_FLAGS_LIST			\
+	ib_wc_flags(GRH)			\
+	ib_wc_flags(WITH_IMM)			\
+	ib_wc_flags(WITH_INVALIDATE)		\
+	ib_wc_flags(IP_CSUM_OK)			\
+	ib_wc_flags(WITH_SMAC)			\
+	ib_wc_flags(WITH_VLAN)			\
+	ib_wc_flags_end(WITH_NETWORK_HDR_TYPE)
+
+#undef ib_wc_flags
+#undef ib_wc_flags_end
+
+#define ib_wc_flags(x)		TRACE_DEFINE_ENUM(IB_WC_##x);
+#define ib_wc_flags_end(x)	TRACE_DEFINE_ENUM(IB_WC_##x);
+
+IB_WC_FLAGS_LIST
+
+#undef ib_wc_flags
+#undef ib_wc_flags_end
+
+#define ib_wc_flags(x)		{ IB_WC_##x, #x },
+#define ib_wc_flags_end(x)	{ IB_WC_##x, #x }
+
+#define rdma_show_wc_flags(x) \
+		__print_symbolic(x, IB_WC_FLAGS_LIST)
diff --git a/include/trace/events/rdma_core.h b/include/trace/events/rdma_core.h
new file mode 100644
index 0000000..af18ac7
--- /dev/null
+++ b/include/trace/events/rdma_core.h
@@ -0,0 +1,193 @@
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
+#include <trace/events/rdma.h>
+#include <rdma/ib_verbs.h>
+#include <rdma/restrack.h>
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
+	TP_printk("id %u", __entry->id)
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
+	TP_printk("id %u", __entry->id)
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
+	TP_printk("id %u wake-up took %lld [us] from %s",
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
+	TP_printk("id %u requested %d, returned %d",
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
+	TP_printk("id %u comps=%u usec=%u",
+		__entry->id, __entry->comps, __entry->usec
+	)
+);
+
+TRACE_EVENT(cq_alloc,
+	TP_PROTO(
+		const struct ib_cq *cq,
+		int comp_vector,
+		enum ib_poll_context poll_ctx
+	),
+
+	TP_ARGS(cq, comp_vector, poll_ctx),
+
+	TP_STRUCT__entry(
+		__field(u32, id)
+		__field(int, comp_vector)
+		__field(unsigned long, poll_ctx)
+	),
+
+	TP_fast_assign(
+		__entry->id = cq->res.id;
+		__entry->comp_vector = comp_vector;
+		__entry->poll_ctx = poll_ctx;
+	),
+
+	TP_printk("id %u comp_vector=%d poll_ctx=%s",
+		__entry->id, __entry->comp_vector,
+		rdma_show_ib_poll_ctx(__entry->poll_ctx)
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
+	TP_printk("id %u", __entry->id)
+);
+
+#endif /* _TRACE_RDMA_CORE_H */
+
+#include <trace/define_trace.h>

