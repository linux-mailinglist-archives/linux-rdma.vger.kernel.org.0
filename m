Return-Path: <linux-rdma+bounces-9579-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0C1A934F6
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 10:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 365077B1D13
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 08:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEF026FD8F;
	Fri, 18 Apr 2025 08:56:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67BD26F477
	for <linux-rdma@vger.kernel.org>; Fri, 18 Apr 2025 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744966615; cv=none; b=KfZ/urMcqQB69qMDkuQv9mTpBNceGbRKvO0nJACP40I0+gUcdM7m1Uy76WCRjqAMUdAc2B/ZxwoUs30O1GRDKIe8FvYATuCv4/1q0Z/E6gQ39FZ5fJKyNQ1zcT/hhYu9yMCGXmQKLa2kIkIH2uGKVYO6sahUStkvmgk5heLXgeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744966615; c=relaxed/simple;
	bh=xwuOF54IYIwKWeW4H7Z59F83Rs34TG6irTZLW+Q3lXw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VEPZOxg9SZe5+0eRAwYWOwK8x7+lPLoMK5hVj1zu8xcur34rf3mYuQ+8ndqgnKd8St6h1RoaWfcfRGxpjZYEZbSJO5k28ett4zslDxyK82urbGRUOsDHUkxwrX+jHP3h0uppP9ExWKncVL3mPcNJulQ0D+a7wCUW8hnvJ+y7oyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Zf7s968MGz1DKZ2;
	Fri, 18 Apr 2025 16:55:57 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 34123180B52;
	Fri, 18 Apr 2025 16:56:50 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Apr 2025 16:56:49 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next 4/6] RDMA/hns: Add trace for MR/MTR attribute dumping
Date: Fri, 18 Apr 2025 16:56:45 +0800
Message-ID: <20250418085647.4067840-5-huangjunxian6@hisilicon.com>
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

Add trace for MR/MTR attribute dumping.

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
      ib_send_bw-14751   [111] .....  8763.823038: buf_attr: rg cnt:1,
pg_sft:0xc, mtt_only:no, rg 0 (sz:131072, hop:2), rg 1 (sz:0, hop:0),
rg 2 (sz:0, hop:0)

      ib_send_bw-14751   [111] .....  8763.823118: drv_mr:
iova:0xffffb2968000, size:131072, key:512, pd:1, pbl_hop:1, npages:4,
type:0, status:0

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_mr.c    |  3 +
 drivers/infiniband/hw/hns/hns_roce_trace.h | 65 ++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 09da3496843b..a462a557b818 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -38,6 +38,7 @@
 #include "hns_roce_device.h"
 #include "hns_roce_cmd.h"
 #include "hns_roce_hem.h"
+#include "hns_roce_trace.h"
 
 static u32 hw_index_to_key(int ind)
 {
@@ -159,6 +160,7 @@ static int hns_roce_mr_enable(struct hns_roce_dev *hr_dev,
 	if (IS_ERR(mailbox))
 		return PTR_ERR(mailbox);
 
+	trace_drv_mr(mr);
 	if (mr->type != MR_TYPE_FRMR)
 		ret = hr_dev->hw->write_mtpt(hr_dev, mailbox->buf, mr);
 	else
@@ -1146,6 +1148,7 @@ int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	int ret;
 
+	trace_buf_attr(buf_attr);
 	/* The caller has its own buffer list and invokes the hns_roce_mtr_map()
 	 * to finish the MTT configuration.
 	 */
diff --git a/drivers/infiniband/hw/hns/hns_roce_trace.h b/drivers/infiniband/hw/hns/hns_roce_trace.h
index 11b00564bfba..2e60ab5943af 100644
--- a/drivers/infiniband/hw/hns/hns_roce_trace.h
+++ b/drivers/infiniband/hw/hns/hns_roce_trace.h
@@ -10,6 +10,7 @@
 #define __HNS_ROCE_TRACE_H
 
 #include <linux/tracepoint.h>
+#include <linux/string_choices.h>
 #include "hns_roce_device.h"
 
 DECLARE_EVENT_CLASS(flush_head_template,
@@ -104,6 +105,70 @@ TRACE_EVENT(ae_info,
 		      __print_array(__entry->aeqe, __entry->len, sizeof(__le32)))
 );
 
+TRACE_EVENT(drv_mr,
+	    TP_PROTO(struct hns_roce_mr *mr),
+	    TP_ARGS(mr),
+
+	    TP_STRUCT__entry(__field(u64, iova)
+			     __field(u64, size)
+			     __field(u32, key)
+			     __field(u32, pd)
+			     __field(u32, pbl_hop_num)
+			     __field(u32, npages)
+			     __field(int, type)
+			     __field(int, enabled)
+	    ),
+
+	    TP_fast_assign(__entry->iova = mr->iova;
+			   __entry->size = mr->size;
+			   __entry->key = mr->key;
+			   __entry->pd = mr->pd;
+			   __entry->pbl_hop_num = mr->pbl_hop_num;
+			   __entry->npages = mr->npages;
+			   __entry->type = mr->type;
+			   __entry->enabled = mr->enabled;
+	    ),
+
+	    TP_printk("iova:0x%llx, size:%llu, key:%u, pd:%u, pbl_hop:%u, npages:%u, type:%d, status:%d",
+		      __entry->iova, __entry->size, __entry->key,
+		      __entry->pd, __entry->pbl_hop_num, __entry->npages,
+		      __entry->type, __entry->enabled)
+);
+
+TRACE_EVENT(buf_attr,
+	    TP_PROTO(struct hns_roce_buf_attr *attr),
+	    TP_ARGS(attr),
+
+	    TP_STRUCT__entry(__field(unsigned int, region_count)
+			     __field(unsigned int, region0_size)
+			     __field(int, region0_hopnum)
+			     __field(unsigned int, region1_size)
+			     __field(int, region1_hopnum)
+			     __field(unsigned int, region2_size)
+			     __field(int, region2_hopnum)
+			     __field(unsigned int, page_shift)
+			     __field(bool, mtt_only)
+	    ),
+
+	    TP_fast_assign(__entry->region_count = attr->region_count;
+			   __entry->region0_size = attr->region[0].size;
+			   __entry->region0_hopnum = attr->region[0].hopnum;
+			   __entry->region1_size = attr->region[1].size;
+			   __entry->region1_hopnum = attr->region[1].hopnum;
+			   __entry->region2_size = attr->region[2].size;
+			   __entry->region2_hopnum = attr->region[2].hopnum;
+			   __entry->page_shift = attr->page_shift;
+			   __entry->mtt_only = attr->mtt_only;
+	    ),
+
+	    TP_printk("rg cnt:%u, pg_sft:0x%x, mtt_only:%s, rg 0 (sz:%u, hop:%u), rg 1 (sz:%u, hop:%u), rg 2 (sz:%u, hop:%u)\n",
+		      __entry->region_count, __entry->page_shift,
+		      str_yes_no(__entry->mtt_only),
+		      __entry->region0_size, __entry->region0_hopnum,
+		      __entry->region1_size, __entry->region1_hopnum,
+		      __entry->region2_size, __entry->region2_hopnum)
+);
+
 #endif /* __HNS_ROCE_TRACE_H */
 
 #undef TRACE_INCLUDE_FILE
-- 
2.33.0


