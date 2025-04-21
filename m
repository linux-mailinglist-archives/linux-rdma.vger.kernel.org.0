Return-Path: <linux-rdma+bounces-9642-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AA2A951A4
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 15:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E44F7A1334
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 13:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF57E2627FC;
	Mon, 21 Apr 2025 13:27:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461621E487
	for <linux-rdma@vger.kernel.org>; Mon, 21 Apr 2025 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745242078; cv=none; b=krjlAf30/66EU9VffmUJEk6rNuUUZQOUceATKp5G2MBypEBeCXWpvln/YbWP+P+F8o5gydAJ+nH8iyF4kezlw4mio8Kk5mwWYlcFX20ioB9HnUc75vCVin8+t0DToZQqxrCiOc4RwPv8Y7HEG/04VLBMQK61j0CQVrljCnSCY1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745242078; c=relaxed/simple;
	bh=a0jTVaQri0nJ2hnBICNcHwDsbrp1VQOhUuaYeivOTKI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KqaDpC+Wf0nn38RUe3WDPN7GzEcJUGUmF4BZVPFWn9MaKd9pwpnV7zbJv6hLJmITjkaYP5kiTN6581yW5vcC+HquWZuQGJmZLdsKb8mI5GMFBTAhFpprQcv9gaTma+xNaRW0R519yBnjhXnHsWyHgMHiE2vBo5rjpMf2BKFyA6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Zh5g61MqDz69ZY;
	Mon, 21 Apr 2025 21:24:02 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id AE8F1180080;
	Mon, 21 Apr 2025 21:27:52 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Apr 2025 21:27:52 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH v2 for-next 3/6] RDMA/hns: Add trace for AEQE dumping
Date: Mon, 21 Apr 2025 21:27:47 +0800
Message-ID: <20250421132750.1363348-4-huangjunxian6@hisilicon.com>
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
	  <idle>-0       [120] d.h1.  7995.835587: hns_ae_info: event 19 aeqe:
{0x80006013,0x0,0x0,0x10d2c,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0}

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  1 +
 drivers/infiniband/hw/hns/hns_roce_trace.h | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index ecc1e0b1df4e..5d3bf84c1aae 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6260,6 +6260,7 @@ static irqreturn_t hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 		eq->sub_type = sub_type;
 		++eq->cons_index;
 		aeqe_found = IRQ_HANDLED;
+		trace_hns_ae_info(event_type, aeqe, eq->eqe_size);
 
 		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_AEQE_CNT]);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_trace.h b/drivers/infiniband/hw/hns/hns_roce_trace.h
index 56e152387db4..75c89aff68c3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_trace.h
+++ b/drivers/infiniband/hw/hns/hns_roce_trace.h
@@ -85,6 +85,25 @@ DEFINE_EVENT(wqe_template, hns_srq_wqe,
 		      enum hns_roce_trace_type type),
 	     TP_ARGS(qpn, idx, wqe, len, id, type));
 
+TRACE_EVENT(hns_ae_info,
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


