Return-Path: <linux-rdma+bounces-9577-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 790DFA934F3
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 10:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC208A8479
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 08:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E535E26FD82;
	Fri, 18 Apr 2025 08:56:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806EB26F468
	for <linux-rdma@vger.kernel.org>; Fri, 18 Apr 2025 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744966614; cv=none; b=GwHgVdkW3xr0+B6hlBTBYvmLwdlqbYSD6sYUxEHCEt6zsHrIyrzhsfjlkiWID6ObTecvxkG06zo/Z3XFknf2GX0oNdM0NW3lyvjVxe4v9ybt1Vl+9+M64e69L3/DLSqMBpxzAY4IiRyzOJsjaXrOUenwQjON54mn4PFB3aK9hCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744966614; c=relaxed/simple;
	bh=DSfQMAqitIequEOqeHrNMiLqUX260notTa7ONd4G/ac=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VTimS5gAIYIy3kZsZNPZwhQleoERokYw5A5wpbHtoufLBPq3GXLPyKNtRwyUA7ZRM7ooBNgRAh9GI/1/JbFNOAw37VtUGKCjHvuLzBxzYc7QkPkyCtfaoWyM8KT6gbLBeuvzWvRf5HaYYwEEij4F5VLa8Mxj3urHeRR0LiYpCpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Zf7nm3JSMzQjxP;
	Fri, 18 Apr 2025 16:53:00 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 8AFE214027A;
	Fri, 18 Apr 2025 16:56:49 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Apr 2025 16:56:49 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next 2/6] RDMA/hns: Add trace for WQE dumping
Date: Fri, 18 Apr 2025 16:56:43 +0800
Message-ID: <20250418085647.4067840-3-huangjunxian6@hisilicon.com>
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
  roce_test_main-22730   [074] d..1. 16133.898282: sq_wqe: SQ 0xc wqe
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
index f29265f28ba9..a86884cd1b25 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -741,6 +741,8 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 		else
 			ret = set_ud_wqe(qp, wr, wqe, &sge_idx, owner_bit);
 
+		trace_sq_wqe(qp->qpn, wqe_idx, wqe, 1 << qp->sq.wqe_shift,
+			     wr->wr_id, TRACE_SQ);
 		if (unlikely(ret)) {
 			*bad_wr = wr;
 			goto out;
@@ -810,6 +812,9 @@ static void fill_rq_wqe(struct hns_roce_qp *hr_qp, const struct ib_recv_wr *wr,
 
 	wqe = hns_roce_get_recv_wqe(hr_qp, wqe_idx);
 	fill_recv_sge_to_wqe(wr, wqe, max_sge, hr_qp->rq.rsv_sge);
+
+	trace_rq_wqe(hr_qp->qpn, wqe_idx, wqe, 1 << hr_qp->rq.wqe_shift,
+		     wr->wr_id, TRACE_RQ);
 }
 
 static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
@@ -987,6 +992,9 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 		fill_recv_sge_to_wqe(wr, wqe, max_sge, srq->rsv_sge);
 		fill_wqe_idx(srq, wqe_idx);
 		srq->wrid[wqe_idx] = wr->wr_id;
+
+		trace_srq_wqe(srq->srqn, wqe_idx, wqe, 1 << srq->wqe_shift,
+			      wr->wr_id, TRACE_SRQ);
 	}
 
 	if (likely(nreq)) {
diff --git a/drivers/infiniband/hw/hns/hns_roce_trace.h b/drivers/infiniband/hw/hns/hns_roce_trace.h
index 104a4abf9177..71da01b19916 100644
--- a/drivers/infiniband/hw/hns/hns_roce_trace.h
+++ b/drivers/infiniband/hw/hns/hns_roce_trace.h
@@ -41,6 +41,50 @@ DEFINE_EVENT(flush_head_template, rq_flush_cqe,
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
+DEFINE_EVENT(wqe_template, sq_wqe,
+	     TP_PROTO(unsigned long qpn, u32 idx, void *wqe, u32 len, u64 id,
+		      enum hns_roce_trace_type type),
+	     TP_ARGS(qpn, idx, wqe, len, id, type));
+DEFINE_EVENT(wqe_template, rq_wqe,
+	     TP_PROTO(unsigned long qpn, u32 idx, void *wqe, u32 len, u64 id,
+		      enum hns_roce_trace_type type),
+	     TP_ARGS(qpn, idx, wqe, len, id, type));
+DEFINE_EVENT(wqe_template, srq_wqe,
+	     TP_PROTO(unsigned long qpn, u32 idx, void *wqe, u32 len, u64 id,
+		      enum hns_roce_trace_type type),
+	     TP_ARGS(qpn, idx, wqe, len, id, type));
+
 #endif /* __HNS_ROCE_TRACE_H */
 
 #undef TRACE_INCLUDE_FILE
-- 
2.33.0


