Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC1A1CBC5D
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 15:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388491AbfJDN5Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 09:57:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42315 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388333AbfJDN5Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Oct 2019 09:57:24 -0400
Received: by mail-io1-f67.google.com with SMTP id n197so13655679iod.9
        for <linux-rdma@vger.kernel.org>; Fri, 04 Oct 2019 06:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=DRKC+1lGRw6w68saQFnhUetJfMSVSqw2UHd3PQIJOWs=;
        b=NBQtpPUGSKf2Z5NSecfogjBMW5N4Je/n4fnsVlyLCmzaSdJ8InnlGvag54EUuQpDP8
         VXEQmMOEpdZ9HYwznaY6WJjkRrf8IYj5P/AV+hAFWJsYm4Of1B86t8vaAJVrjB55cd6o
         VYF1P3BXdbQE9oq+EDpwVNroGPMPbA6tcxK5sCceOISeQj07yh7YjctrI3inMIHQgLBx
         7bJcpv8nK55ElR1SC/Hn4qTWgrGyH+551Z1NShWKTsHOv2t7Vp+ZzMfAx7O5lpviVZG4
         VAmBCg84T55+9G55rJ4qRqcaDPWarlBXmRhDZep0vC0+CwtSrWEJ4Eu5Rdx5Yq68K9Nl
         AH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=DRKC+1lGRw6w68saQFnhUetJfMSVSqw2UHd3PQIJOWs=;
        b=j0JXt6XsUARJhGeoFRd2wN3IyWkLNYldauuE9xF+JT6/RbApGEPEVnkdKkwvHfUqBn
         R5zxmjYG2tH6nvkPwqaomo6S7/hE2pA81yyCqZMplZw4KDiDBnjeaBgxYwlfD5mouHMD
         pdp1TDcD7/lpgV6ZRARTR4qJiWU8LdBTgn3SqlHEpvxjO2GD5DWbwKz/VcJ1XC4h/Bbe
         b7URJKehdYwuKZbzu/bE+i6znRBd8keXKuG0LfDU/ioYgdYhvggTQ8uFau0gEZQYLGfL
         2L3xyyJBMP6bifTzwpOCyyxRjNaRUq9Q9Z3JNhMz+0/BzpXGkyvbvfQF2A+e0yVA9sfF
         wsJQ==
X-Gm-Message-State: APjAAAX96oR9qK6YfEyQWVkW0u5ZsZIu9fEQdQIpXE4RD3E1JV0oAWnS
        QnTypn3wVYBXQLpFHJyKcCq3PQX/
X-Google-Smtp-Source: APXvYqzlPTkWnMb4MpLf52mSb3kIEbh0kBCCnvIDZDRNjZdqNFTHXw8eX4lGel7LybcI60KVFLe7Mg==
X-Received: by 2002:a02:3f12:: with SMTP id d18mr14597092jaa.39.1570197443491;
        Fri, 04 Oct 2019 06:57:23 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d6sm2459958ilc.39.2019.10.04.06.57.22
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 06:57:22 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x94DvL5H019107
        for <linux-rdma@vger.kernel.org>; Fri, 4 Oct 2019 13:57:22 GMT
Subject: [PATCH RFC] IB/core: Trace points for diagnosing completion queue
 issues
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org
Date:   Fri, 04 Oct 2019 09:57:21 -0400
Message-ID: <20191004135721.2488.63359.stgit@manet.1015granger.net>
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
 drivers/infiniband/core/trace.c  |   15 +++
 include/rdma/ib_verbs.h          |    2 
 include/trace/events/rdma.h      |   89 ++++++++++++++++++
 include/trace/events/rdma_core.h |  192 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 319 insertions(+), 10 deletions(-)
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
index 0000000..568f57d
--- /dev/null
+++ b/drivers/infiniband/core/trace.c
@@ -0,0 +1,15 @@
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
+#include <rdma/rdma_cm.h>
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
index aa19afc..d5e5fa7a 100644
--- a/include/trace/events/rdma.h
+++ b/include/trace/events/rdma.h
@@ -127,3 +127,92 @@
 
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
index 0000000..d5cafe8
--- /dev/null
+++ b/include/trace/events/rdma_core.h
@@ -0,0 +1,192 @@
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
+		__field(const void *, cq)
+	),
+
+	TP_fast_assign(
+		cq->timestamp = ktime_get();
+		cq->interrupt = true;
+
+		__entry->cq = cq;
+	),
+
+	TP_printk("cq=%p", __entry->cq)
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
+		__field(const void *, cq)
+	),
+
+	TP_fast_assign(
+		cq->timestamp = ktime_get();
+		cq->interrupt = false;
+
+		__entry->cq = cq;
+	),
+
+	TP_printk("cq=%p", __entry->cq)
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
+		__field(const void *, cq)
+		__field(s64, latency)
+		__field(bool, interrupt)
+	),
+
+	TP_fast_assign(
+		ktime_t latency = ktime_sub(ktime_get(), cq->timestamp);
+
+		__entry->cq = cq;
+		__entry->latency = ktime_to_us(latency);
+		__entry->interrupt = cq->interrupt;
+	),
+
+	TP_printk("cq=%p: wake-up took %lld [us] from %s",
+		__entry->cq, __entry->latency,
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
+		__field(const void *, cq)
+		__field(int, requested)
+		__field(int, rc)
+	),
+
+	TP_fast_assign(
+		__entry->cq = cq;
+		__entry->requested = requested;
+		__entry->rc = rc;
+	),
+
+	TP_printk("cq=%p: requested %d, returned %d",
+		__entry->cq, __entry->requested, __entry->rc
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
+		__field(const void *, cq)
+		__field(unsigned int, comps)
+		__field(unsigned int, usec)
+	),
+
+	TP_fast_assign(
+		__entry->cq = cq;
+		__entry->comps = comps;
+		__entry->usec = usec;
+	),
+
+	TP_printk("cq=%p: comps=%u usec=%u",
+		__entry->cq, __entry->comps, __entry->usec
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
+		__field(const void *, cq)
+		__field(int, comp_vector)
+		__field(unsigned long, poll_ctx)
+	),
+
+	TP_fast_assign(
+		__entry->cq = cq;
+		__entry->comp_vector = comp_vector;
+		__entry->poll_ctx = poll_ctx;
+	),
+
+	TP_printk("cq=%p: comp_vector=%d poll_ctx=%s",
+		__entry->cq, __entry->comp_vector,
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
+		__field(const void *, cq)
+	),
+
+	TP_fast_assign(
+		__entry->cq = cq;
+	),
+
+	TP_printk("cq=%p", __entry->cq)
+);
+
+#endif /* _TRACE_RDMA_CORE_H */
+
+#include <trace/define_trace.h>

