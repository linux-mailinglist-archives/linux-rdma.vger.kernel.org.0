Return-Path: <linux-rdma+bounces-9578-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E203A934F5
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 10:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA5F47B1CCF
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 08:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3F526FD8C;
	Fri, 18 Apr 2025 08:56:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DD826B2BF
	for <linux-rdma@vger.kernel.org>; Fri, 18 Apr 2025 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744966615; cv=none; b=DS0cWHIM/v4m21AnSr09yMGlZNbhy5fOqW0JT9QUH5WXAC23gkSWnSRzSOTpk2rvUG+fAAkynUUBnkgZE3hqElt0jiIQ14c7GLJf1c2o9n05raSvm7jJBzCCRk7VOUppsMayeqJBI6g3EA2PBKKBP4HKUie7mevZ9ujv8CAYYlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744966615; c=relaxed/simple;
	bh=cu+HBQrpFKjChizciigPKRMAgzVfqFQkpDkFuOU4GXQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/trExqcdK7QwKSPoUmmtShiyABdAChLD6/sNy3zcZ2MVrKq+4iZxVIpeipc6wtCawDEmvYFhq7kQeQyDSgHEW6odnz/masHPoU5tdrsDKknXmlIJxfKliSfxuEsm9pslFZLODpJ5QilCHTdELM62yYgAakRl4obwOoi4+ofQQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Zf7p95sNszHrGN;
	Fri, 18 Apr 2025 16:53:21 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 35E40180B52;
	Fri, 18 Apr 2025 16:56:49 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Apr 2025 16:56:48 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next 1/6] RDMA/hns: Add trace for flush CQE
Date: Fri, 18 Apr 2025 16:56:42 +0800
Message-ID: <20250418085647.4067840-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250418085647.4067840-1-huangjunxian6@hisilicon.com>
References: <20250418085647.4067840-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Add trace to print the producer index of QP when triggering flush CQE.

Output example:
$ cat /sys/kernel/debug/tracing/trace
  tracer: nop

  entries-in-buffer/entries-written: 2/2   #P:128

                                 _-----=> irqs-off/BH-disabled
                                / _----=> need-resched
                               | / _---=> hardirq/softirq
                               || / _--=> preempt-depth
                               ||| / _-=> migrate-disable
                               |||| /     delay
            TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
               | |         |   |||||     |         |
      ib_send_bw-11474   [075] d..1.  2393.434738: sq_flush_cqe: SQ 0x2 flush head 0xb5c7.
      ib_send_bw-11474   [075] d..1.  2393.434739: rq_flush_cqe: RQ 0x2 flush head 0.

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 17 +++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  5 +++
 drivers/infiniband/hw/hns/hns_roce_trace.h  | 50 +++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_trace.h

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 560a1d9de408..080bd049b0f8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1027,6 +1027,23 @@ struct hns_roce_dev {
 	atomic64_t *dfx_cnt;
 };
 
+enum hns_roce_trace_type {
+	TRACE_SQ,
+	TRACE_RQ,
+};
+
+static inline const char *trace_type_to_str(enum hns_roce_trace_type type)
+{
+	switch (type) {
+	case TRACE_SQ:
+		return "SQ";
+	case TRACE_RQ:
+		return "RQ";
+	default:
+		return "UNKNOWN";
+	}
+}
+
 static inline struct hns_roce_dev *to_hr_dev(struct ib_device *ib_dev)
 {
 	return container_of(ib_dev, struct hns_roce_dev, ib_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index c6399490e3a5..f29265f28ba9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -50,6 +50,9 @@
 #include "hns_roce_hem.h"
 #include "hns_roce_hw_v2.h"
 
+#define CREATE_TRACE_POINTS
+#include "hns_roce_trace.h"
+
 enum {
 	CMD_RST_PRC_OTHERS,
 	CMD_RST_PRC_SUCCESS,
@@ -5312,6 +5315,7 @@ static void v2_set_flushed_fields(struct ib_qp *ibqp,
 		return;
 
 	spin_lock_irqsave(&hr_qp->sq.lock, sq_flag);
+	trace_sq_flush_cqe(hr_qp->qpn, hr_qp->sq.head, TRACE_SQ);
 	hr_reg_write(context, QPC_SQ_PRODUCER_IDX, hr_qp->sq.head);
 	hr_reg_clear(qpc_mask, QPC_SQ_PRODUCER_IDX);
 	hr_qp->state = IB_QPS_ERR;
@@ -5321,6 +5325,7 @@ static void v2_set_flushed_fields(struct ib_qp *ibqp,
 		return;
 
 	spin_lock_irqsave(&hr_qp->rq.lock, rq_flag);
+	trace_rq_flush_cqe(hr_qp->qpn, hr_qp->rq.head, TRACE_RQ);
 	hr_reg_write(context, QPC_RQ_PRODUCER_IDX, hr_qp->rq.head);
 	hr_reg_clear(qpc_mask, QPC_RQ_PRODUCER_IDX);
 	spin_unlock_irqrestore(&hr_qp->rq.lock, rq_flag);
diff --git a/drivers/infiniband/hw/hns/hns_roce_trace.h b/drivers/infiniband/hw/hns/hns_roce_trace.h
new file mode 100644
index 000000000000..104a4abf9177
--- /dev/null
+++ b/drivers/infiniband/hw/hns/hns_roce_trace.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2025 Hisilicon Limited.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM hns_roce
+
+#if !defined(__HNS_ROCE_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define __HNS_ROCE_TRACE_H
+
+#include <linux/tracepoint.h>
+#include "hns_roce_device.h"
+
+DECLARE_EVENT_CLASS(flush_head_template,
+		    TP_PROTO(unsigned long qpn, u32 pi,
+			     enum hns_roce_trace_type type),
+		    TP_ARGS(qpn, pi, type),
+
+		    TP_STRUCT__entry(__field(unsigned long, qpn)
+				     __field(u32, pi)
+				     __field(enum hns_roce_trace_type, type)
+		    ),
+
+		    TP_fast_assign(__entry->qpn = qpn;
+				   __entry->pi = pi;
+				   __entry->type = type;
+		    ),
+
+		    TP_printk("%s 0x%lx flush head 0x%x.",
+			      trace_type_to_str(__entry->type),
+			      __entry->qpn, __entry->pi)
+);
+
+DEFINE_EVENT(flush_head_template, sq_flush_cqe,
+	     TP_PROTO(unsigned long qpn, u32 pi,
+		      enum hns_roce_trace_type type),
+	     TP_ARGS(qpn, pi, type));
+DEFINE_EVENT(flush_head_template, rq_flush_cqe,
+	     TP_PROTO(unsigned long qpn, u32 pi,
+		      enum hns_roce_trace_type type),
+	     TP_ARGS(qpn, pi, type));
+
+#endif /* __HNS_ROCE_TRACE_H */
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE hns_roce_trace
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#include <trace/define_trace.h>
-- 
2.33.0


