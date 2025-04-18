Return-Path: <linux-rdma+bounces-9580-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E84A934F7
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 10:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2469A4684BC
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 08:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE6426FD9C;
	Fri, 18 Apr 2025 08:56:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C251A26F471
	for <linux-rdma@vger.kernel.org>; Fri, 18 Apr 2025 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744966616; cv=none; b=fmyQ+OhCnuskOQq1GoDzwh3eJXV748CZ01hMhMYosNtUQKmnPvFxD5jBkQrjKUQU33dCj15LoKLHxkC1jCFY2ywAiLb5xVqNjJfYQWcsiU382MIBhAXnzMW9F6vc4DyDg4TDLXwsXsN/yiG5ff8GIt8m9V4vYKf9v6WzcxaQ9Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744966616; c=relaxed/simple;
	bh=jRfId58cUiMrZrRoFxe84rnQ4cZuY0mslshpZI/mK20=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YNfaGIya5sBzinjw+AuEiX4sXyvHi9hfUgr43AqRvuHWqFWo6eaCzpLZc/1+ffOh5660dKdRKXjjlq/l5rBS10VmfyCUdDfjqE20w7E/3ov1QW3W4wYRhX4EhfE5Mdm8XuTVdW6tdDNaQD1QwccSiJ6/Ub/i57CQHnRkKW9CeGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Zf7v017vyz27hKZ;
	Fri, 18 Apr 2025 16:57:32 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id DFD491A016C;
	Fri, 18 Apr 2025 16:56:49 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Apr 2025 16:56:49 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next 3/6] RDMA/hns: Add trace for AEQE dumping
Date: Fri, 18 Apr 2025 16:56:44 +0800
Message-ID: <20250418085647.4067840-4-huangjunxian6@hisilicon.com>
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

Add trace for AEQE dumping.

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
	  <idle>-0       [120] d.h1.  7995.835587: ae_info: event 19 aeqe:
{0x80006013,0x0,0x0,0x10d2c,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0}

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  1 +
 drivers/infiniband/hw/hns/hns_roce_trace.h | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index a86884cd1b25..ae8c790d4211 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6260,6 +6260,7 @@ static irqreturn_t hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 		eq->sub_type = sub_type;
 		++eq->cons_index;
 		aeqe_found = IRQ_HANDLED;
+		trace_ae_info(event_type, aeqe, eq->eqe_size);
 
 		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_AEQE_CNT]);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_trace.h b/drivers/infiniband/hw/hns/hns_roce_trace.h
index 71da01b19916..11b00564bfba 100644
--- a/drivers/infiniband/hw/hns/hns_roce_trace.h
+++ b/drivers/infiniband/hw/hns/hns_roce_trace.h
@@ -85,6 +85,25 @@ DEFINE_EVENT(wqe_template, srq_wqe,
 		      enum hns_roce_trace_type type),
 	     TP_ARGS(qpn, idx, wqe, len, id, type));
 
+TRACE_EVENT(ae_info,
+	    TP_PROTO(int event_type, void *aeqe, unsigned int len),
+	    TP_ARGS(event_type, aeqe, len),
+
+	    TP_STRUCT__entry(__field(int, event_type)
+			     __array(__le32, aeqe,
+				     HNS_ROCE_V3_EQE_SIZE / sizeof(__le32))
+			     __field(u32, len)
+	    ),
+
+	    TP_fast_assign(__entry->event_type = event_type;
+			   __entry->len = len / sizeof(__le32);
+			   memcpy(__entry->aeqe, aeqe, len);
+	    ),
+
+	    TP_printk("event %2d aeqe: %s", __entry->event_type,
+		      __print_array(__entry->aeqe, __entry->len, sizeof(__le32)))
+);
+
 #endif /* __HNS_ROCE_TRACE_H */
 
 #undef TRACE_INCLUDE_FILE
-- 
2.33.0


