Return-Path: <linux-rdma+bounces-9646-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E719A951A7
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 15:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28E0D7A26A9
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 13:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD70264A9E;
	Mon, 21 Apr 2025 13:28:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA077B640
	for <linux-rdma@vger.kernel.org>; Mon, 21 Apr 2025 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745242092; cv=none; b=T2ymAddy/DqZsWflS6s9P316Z7K3jQRhmXzGO1jh8MG+HKfh2oqumoT1B4Sw1Mj/v+wOWXlu3fAUNgY8zvOCNCL21qG4gcCCw7kTBD4vlhHmy3nqhJaTzzVct58dIyQ0R6efc9g9/AZ63GoTDucHInrAcFU8VBnZSyUioVMSiIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745242092; c=relaxed/simple;
	bh=QlrvfQaITZkAub9RAdmczIcwCED2FKdAxxV8rQnIxMM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdYFCD1TNjpX0kamCrXrGGGjZfQaA0PtayohbwGtwHeH/FTxY6WsZbdm/BYzRZaGGRFs67kz3AosVD6M5n8PqsodfcLKuWhCz1lwA+giob+oRFN4DZGTC9qRkfU8AeQi+mWKc8Geh1iiS2aC4wmcuDfRY6YgO6z7iJ1Ci3n4hFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Zh5gW66qWz2CdPb;
	Mon, 21 Apr 2025 21:24:23 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 67D0414011F;
	Mon, 21 Apr 2025 21:27:52 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Apr 2025 21:27:51 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH v2 for-next 2/6] RDMA/hns: Add trace for WQE dumping
Date: Mon, 21 Apr 2025 21:27:46 +0800
Message-ID: <20250421132750.1363348-3-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250421132750.1363348-1-huangjunxian6@hisilicon.com>
References: <20250421132750.1363348-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Add trace for WQE dumping, including SQ, RQ and SRQ.

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
  roce_test_main-22730   [074] d..1. 16133.898282: hns_sq_wqe: SQ 0xc wqe
(0x0/0xffff0820a6076060): {0x180,0x639c,0x0,0x1000000,0x0,0x0,0x0,0x0,
0x639c,0x300,0xf7e38000,0x0,0x0,0x0,0x0,0x0}

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  3 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  8 ++++
 drivers/infiniband/hw/hns/hns_roce_trace.h  | 44 +++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 080bd049b0f8..1dcc9cbb4678 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1030,6 +1030,7 @@ struct hns_roce_dev {
 enum hns_roce_trace_type {
 	TRACE_SQ,
 	TRACE_RQ,
+	TRACE_SRQ,
 };
 
 static inline const char *trace_type_to_str(enum hns_roce_trace_type type)
@@ -1039,6 +1040,8 @@ static inline const char *trace_type_to_str(enum hns_roce_trace_type type)
 		return "SQ";
 	case TRACE_RQ:
 		return "RQ";
+	case TRACE_SRQ:
+		return "SRQ";
 	default:
 		return "UNKNOWN";
 	}
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index e1c27c9556fd..ecc1e0b1df4e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -741,6 +741,8 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 		else
 			ret = set_ud_wqe(qp, wr, wqe, &sge_idx, owner_bit);
 
+		trace_hns_sq_wqe(qp->qpn, wqe_idx, wqe, 1 << qp->sq.wqe_shift,
+				 wr->wr_id, TRACE_SQ);
 		if (unlikely(ret)) {
 			*bad_wr = wr;
 			goto out;
@@ -810,6 +812,9 @@ static void fill_rq_wqe(struct hns_roce_qp *hr_qp, const struct ib_recv_wr *wr,
 
 	wqe = hns_roce_get_recv_wqe(hr_qp, wqe_idx);
 	fill_recv_sge_to_wqe(wr, wqe, max_sge, hr_qp->rq.rsv_sge);
+
+	trace_hns_rq_wqe(hr_qp->qpn, wqe_idx, wqe, 1 << hr_qp->rq.wqe_shift,
+			 wr->wr_id, TRACE_RQ);
 }
 
 static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
@@ -987,6 +992,9 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 		fill_recv_sge_to_wqe(wr, wqe, max_sge, srq->rsv_sge);
 		fill_wqe_idx(srq, wqe_idx);
 		srq->wrid[wqe_idx] = wr->wr_id;
+
+		trace_hns_srq_wqe(srq->srqn, wqe_idx, wqe, 1 << srq->wqe_shift,
+				  wr->wr_id, TRACE_SRQ);
 	}
 
 	if (likely(nreq)) {
diff --git a/drivers/infiniband/hw/hns/hns_roce_trace.h b/drivers/infiniband/hw/hns/hns_roce_trace.h
index 3deace357fb7..56e152387db4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_trace.h
+++ b/drivers/infiniband/hw/hns/hns_roce_trace.h
@@ -41,6 +41,50 @@ DEFINE_EVENT(flush_head_template, hns_rq_flush_cqe,
 		      enum hns_roce_trace_type type),
 	     TP_ARGS(qpn, pi, type));
 
+#define MAX_SGE_PER_WQE 64
+#define MAX_WQE_SIZE (MAX_SGE_PER_WQE * HNS_ROCE_SGE_SIZE)
+DECLARE_EVENT_CLASS(wqe_template,
+		    TP_PROTO(unsigned long qpn, u32 idx, void *wqe, u32 len,
+			     u64 id, enum hns_roce_trace_type type),
+		    TP_ARGS(qpn, idx, wqe, len, id, type),
+
+		    TP_STRUCT__entry(__field(unsigned long, qpn)
+				     __field(u32, idx)
+				     __array(__le32, wqe,
+					     MAX_WQE_SIZE / sizeof(__le32))
+				     __field(u32, len)
+				     __field(u64, id)
+				     __field(enum hns_roce_trace_type, type)
+				     ),
+
+		    TP_fast_assign(__entry->qpn = qpn;
+				   __entry->idx = idx;
+				   __entry->id = id;
+				   memcpy(__entry->wqe, wqe, len);
+				   __entry->len = len / sizeof(__le32);
+				   __entry->type = type;
+				   ),
+
+		    TP_printk("%s 0x%lx wqe(0x%x/0x%llx): %s",
+			      trace_type_to_str(__entry->type),
+			      __entry->qpn, __entry->idx, __entry->id,
+			      __print_array(__entry->wqe, __entry->len,
+					    sizeof(__le32)))
+);
+
+DEFINE_EVENT(wqe_template, hns_sq_wqe,
+	     TP_PROTO(unsigned long qpn, u32 idx, void *wqe, u32 len, u64 id,
+		      enum hns_roce_trace_type type),
+	     TP_ARGS(qpn, idx, wqe, len, id, type));
+DEFINE_EVENT(wqe_template, hns_rq_wqe,
+	     TP_PROTO(unsigned long qpn, u32 idx, void *wqe, u32 len, u64 id,
+		      enum hns_roce_trace_type type),
+	     TP_ARGS(qpn, idx, wqe, len, id, type));
+DEFINE_EVENT(wqe_template, hns_srq_wqe,
+	     TP_PROTO(unsigned long qpn, u32 idx, void *wqe, u32 len, u64 id,
+		      enum hns_roce_trace_type type),
+	     TP_ARGS(qpn, idx, wqe, len, id, type));
+
 #endif /* __HNS_ROCE_TRACE_H */
 
 #undef TRACE_INCLUDE_FILE
-- 
2.33.0


