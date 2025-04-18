Return-Path: <linux-rdma+bounces-9581-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DE4A934F8
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 10:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 616B97B20D2
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 08:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471CA26FDA2;
	Fri, 18 Apr 2025 08:56:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FF126FA42
	for <linux-rdma@vger.kernel.org>; Fri, 18 Apr 2025 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744966616; cv=none; b=f4MOvNjyWmBhcdh2GaG1MozT1Pn1rsS9ZAMSFu9WE+C1yGSvuk1XXjbgmpk9HMlSRz6xlZLi8sY+Wde7B7WNeSy8aEpAi7npeYoo5WTKZWPVlP0wxw4CSPb700hDb3ad/8oSB9NfOrP7lLuXPJh5I49df8z10B4IQJ6y9flXbrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744966616; c=relaxed/simple;
	bh=Pucp2291KbU0bVfQOllrLMwriXWi6Ruy4xwCQzDob1Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3gegWrN915fZ6QMomAQi8wbkkFcArBrJWyqXHrRv8Hrxzva4VGD4rHJ2SD2O90ZivZ0UF1BFQ411BJ5bcvleDXCR97yinkU1n/tVG7lWd7NWmkGVKxIibha8KKysFoJm9qZ/8EkocYJPrJt2Vq57InQ+EcXHaOfFfjcP4wV1+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Zf7t05pdTz2TRxy;
	Fri, 18 Apr 2025 16:56:40 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id DB5F4140296;
	Fri, 18 Apr 2025 16:56:50 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Apr 2025 16:56:50 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next 6/6] RDMA/hns: Add trace for CMDQ dumping
Date: Fri, 18 Apr 2025 16:56:47 +0800
Message-ID: <20250418085647.4067840-7-huangjunxian6@hisilicon.com>
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

Add trace for CMDQ dumping.

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
  kworker/u512:1-14003   [089] b..1. 50737.238304: cmdq_req: 0000:bd:00.0 cmdq opcode:0x8500, flag:0x1, retval:0x0, data:{0x2,0x0,0x0,0xffff0000,0x32323232,0x0}

  kworker/u512:1-14003   [089] b..1. 50737.238316: cmdq_resp: 0000:bd:00.0 cmdq opcode:0x8500, flag:0x2, retval:0x0, data:{0x2,0x0,0x0,0xffff0000,0x32323232,0x0}

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  4 +++
 drivers/infiniband/hw/hns/hns_roce_trace.h | 35 ++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 78d39afb2aa0..db33b4d329d1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1321,6 +1321,8 @@ static int __hns_roce_cmq_send_one(struct hns_roce_dev *hr_dev,
 	tail = csq->head;
 
 	for (i = 0; i < num; i++) {
+		trace_cmdq_req(hr_dev, &desc[i]);
+
 		csq->desc[csq->head++] = desc[i];
 		if (csq->head == csq->desc_num)
 			csq->head = 0;
@@ -1335,6 +1337,8 @@ static int __hns_roce_cmq_send_one(struct hns_roce_dev *hr_dev,
 	if (hns_roce_cmq_csq_done(hr_dev)) {
 		ret = 0;
 		for (i = 0; i < num; i++) {
+			trace_cmdq_resp(hr_dev, &csq->desc[tail]);
+
 			/* check the result of hardware write back */
 			desc_ret = le16_to_cpu(csq->desc[tail++].retval);
 			if (tail == csq->desc_num)
diff --git a/drivers/infiniband/hw/hns/hns_roce_trace.h b/drivers/infiniband/hw/hns/hns_roce_trace.h
index 2e60ab5943af..adc3d66ce06c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_trace.h
+++ b/drivers/infiniband/hw/hns/hns_roce_trace.h
@@ -12,6 +12,7 @@
 #include <linux/tracepoint.h>
 #include <linux/string_choices.h>
 #include "hns_roce_device.h"
+#include "hns_roce_hw_v2.h"
 
 DECLARE_EVENT_CLASS(flush_head_template,
 		    TP_PROTO(unsigned long qpn, u32 pi,
@@ -169,6 +170,40 @@ TRACE_EVENT(buf_attr,
 		      __entry->region2_size, __entry->region2_hopnum)
 );
 
+DECLARE_EVENT_CLASS(cmdq,
+		    TP_PROTO(struct hns_roce_dev *hr_dev,
+			     struct hns_roce_cmq_desc *desc),
+		    TP_ARGS(hr_dev, desc),
+
+		    TP_STRUCT__entry(__string(dev_name, dev_name(hr_dev->dev))
+				     __field(u16, opcode)
+				     __field(u16, flag)
+				     __field(u16, retval)
+				     __array(__le32, data, 6)
+		    ),
+
+		    TP_fast_assign(__assign_str(dev_name);
+				   __entry->opcode = le16_to_cpu(desc->opcode);
+				   __entry->flag = le16_to_cpu(desc->flag);
+				   __entry->retval = le16_to_cpu(desc->retval);
+				   memcpy(__entry->data, desc->data, 6 * sizeof(__le32));
+		    ),
+
+		    TP_printk("%s cmdq opcode:0x%x, flag:0x%x, retval:0x%x, data:%s\n",
+			      __get_str(dev_name), __entry->opcode,
+			      __entry->flag, __entry->retval,
+			      __print_array(__entry->data, 6, sizeof(__le32)))
+);
+
+DEFINE_EVENT(cmdq, cmdq_req,
+	     TP_PROTO(struct hns_roce_dev *hr_dev,
+		      struct hns_roce_cmq_desc *desc),
+	     TP_ARGS(hr_dev, desc));
+DEFINE_EVENT(cmdq, cmdq_resp,
+	     TP_PROTO(struct hns_roce_dev *hr_dev,
+		      struct hns_roce_cmq_desc *desc),
+	     TP_ARGS(hr_dev, desc));
+
 #endif /* __HNS_ROCE_TRACE_H */
 
 #undef TRACE_INCLUDE_FILE
-- 
2.33.0


