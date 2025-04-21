Return-Path: <linux-rdma+bounces-9644-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CA3A951A6
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 15:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68273AB827
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 13:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D6326656F;
	Mon, 21 Apr 2025 13:27:59 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F1F265CB3
	for <linux-rdma@vger.kernel.org>; Mon, 21 Apr 2025 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745242079; cv=none; b=IRlP9GD4nMb3lpMSH4E7Zo3CQqXEi0Ej+Dfn3xgQqCkaIveoamCqL5Cx3dY96fE0H28NVnMhWh4ZntYzvRkgJiAc0ttoEunIpQ/MfLcgNzbSU6U/M+M5sUm1ZL/YmcZzefjv5TWvjs8c2ZE7vseiro54GM9jq1cKv4/fTJTJdN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745242079; c=relaxed/simple;
	bh=rcUA1Kiz3JB7iVN5t7PWKes8J3JAACXKPFGsT2IUWBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JBZUx+l7AEpeWW6X7SewMFhYiAeKG00n8R09myS5LJJp6p+qZa61oxI6e26s22oF+Vc37XM5nBFtMjzZNclX1hgAx+y5lJqY2P4JO8oPdo+JovIGrsCcCyWwsuMTqxxrUte0wdjFmA7V5cvQGd2Ng3Kd56E27zO8iaHUEupzPyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Zh5kT1mwBz1d0vp;
	Mon, 21 Apr 2025 21:26:57 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id ADA9218046A;
	Mon, 21 Apr 2025 21:27:53 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Apr 2025 21:27:53 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH v2 for-next 6/6] RDMA/hns: Add trace for CMDQ dumping
Date: Mon, 21 Apr 2025 21:27:50 +0800
Message-ID: <20250421132750.1363348-7-huangjunxian6@hisilicon.com>
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
  kworker/u512:1-14003   [089] b..1. 50737.238304: hns_cmdq_req: 0000:bd:00.0 cmdq opcode:0x8500, flag:0x1, retval:0x0, data:{0x2,0x0,0x0,0xffff0000,0x32323232,0x0}

  kworker/u512:1-14003   [089] b..1. 50737.238316: hns_cmdq_resp: 0000:bd:00.0 cmdq opcode:0x8500, flag:0x2, retval:0x0, data:{0x2,0x0,0x0,0xffff0000,0x32323232,0x0}

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  4 +++
 drivers/infiniband/hw/hns/hns_roce_trace.h | 35 ++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 9cb9fe6a0a98..fa8747656f25 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1321,6 +1321,8 @@ static int __hns_roce_cmq_send_one(struct hns_roce_dev *hr_dev,
 	tail = csq->head;
 
 	for (i = 0; i < num; i++) {
+		trace_hns_cmdq_req(hr_dev, &desc[i]);
+
 		csq->desc[csq->head++] = desc[i];
 		if (csq->head == csq->desc_num)
 			csq->head = 0;
@@ -1335,6 +1337,8 @@ static int __hns_roce_cmq_send_one(struct hns_roce_dev *hr_dev,
 	if (hns_roce_cmq_csq_done(hr_dev)) {
 		ret = 0;
 		for (i = 0; i < num; i++) {
+			trace_hns_cmdq_resp(hr_dev, &csq->desc[tail]);
+
 			/* check the result of hardware write back */
 			desc_ret = le16_to_cpu(csq->desc[tail++].retval);
 			if (tail == csq->desc_num)
diff --git a/drivers/infiniband/hw/hns/hns_roce_trace.h b/drivers/infiniband/hw/hns/hns_roce_trace.h
index b0bc22b9cc28..23cbdbaeffaa 100644
--- a/drivers/infiniband/hw/hns/hns_roce_trace.h
+++ b/drivers/infiniband/hw/hns/hns_roce_trace.h
@@ -12,6 +12,7 @@
 #include <linux/tracepoint.h>
 #include <linux/string_choices.h>
 #include "hns_roce_device.h"
+#include "hns_roce_hw_v2.h"
 
 DECLARE_EVENT_CLASS(flush_head_template,
 		    TP_PROTO(unsigned long qpn, u32 pi,
@@ -169,6 +170,40 @@ TRACE_EVENT(hns_buf_attr,
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
+DEFINE_EVENT(cmdq, hns_cmdq_req,
+	     TP_PROTO(struct hns_roce_dev *hr_dev,
+		      struct hns_roce_cmq_desc *desc),
+	     TP_ARGS(hr_dev, desc));
+DEFINE_EVENT(cmdq, hns_cmdq_resp,
+	     TP_PROTO(struct hns_roce_dev *hr_dev,
+		      struct hns_roce_cmq_desc *desc),
+	     TP_ARGS(hr_dev, desc));
+
 #endif /* __HNS_ROCE_TRACE_H */
 
 #undef TRACE_INCLUDE_FILE
-- 
2.33.0


