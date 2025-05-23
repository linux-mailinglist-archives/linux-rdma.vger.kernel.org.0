Return-Path: <linux-rdma+bounces-10587-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4680AC1A1A
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 04:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590721C04F00
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 02:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512792DCC09;
	Fri, 23 May 2025 02:34:40 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271102DCBE7
	for <linux-rdma@vger.kernel.org>; Fri, 23 May 2025 02:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747967680; cv=none; b=RTNcp38fWLSmRSZg00cswZV80ACLw5CXkWdRJPy2eRyB/OCoP01dcjz/dWRK7A0nE88r/MthEXGkZQFIqw5sOD7GXPrgz0ifDkTE+M1tdCOBb785ivx9iBqo3j5N8S/2M+h7cKcKOY2N3DfmiSkApoOr3DvyfIdpoV2rirfoyF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747967680; c=relaxed/simple;
	bh=VdqIANj/evickkUVgDK1721grDAXXXOkcuXMtmWN7BM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KcgmngJqeVlXVu0fnaolfXt/CLZ/qZI8LPLZ6kOY8hAnHY3rdhnLubdVCQxuXTv/niRSMQivMKTX0rWv6XUuBe/EHz43e4N/ZBQgCj3BRPdEgWKAPCQibZRWdLlDXHG2HQYnQASOSIqGBXPXEHdkOUNMYQCSujUEURFW8r3dx2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4b3ThP2g3Xz1R7mw;
	Fri, 23 May 2025 10:32:21 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 55A821A0188;
	Fri, 23 May 2025 10:34:34 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 23 May 2025 10:34:33 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Fix endian issue in trace events
Date: Fri, 23 May 2025 10:34:33 +0800
Message-ID: <20250523023433.2171003-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Avoid using __le32 directly in trace events to fix sparse complains:

drivers/infiniband/hw/hns/./hns_roce_trace.h:48:1: sparse: sparse: cast to restricted __le32
drivers/infiniband/hw/hns/./hns_roce_trace.h:48:1: sparse: sparse: restricted __le32 degrades to integer
drivers/infiniband/hw/hns/./hns_roce_trace.h:48:1: sparse: sparse: restricted __le32 degrades to integer
drivers/infiniband/hw/hns/./hns_roce_trace.h:90:1: sparse: sparse: cast to restricted __le32
drivers/infiniband/hw/hns/./hns_roce_trace.h:90:1: sparse: sparse: restricted __le32 degrades to integer
drivers/infiniband/hw/hns/./hns_roce_trace.h:90:1: sparse: sparse: restricted __le32 degrades to integer
drivers/infiniband/hw/hns/./hns_roce_trace.h:173:1: sparse: sparse: cast to restricted __le32
drivers/infiniband/hw/hns/./hns_roce_trace.h:173:1: sparse: sparse: restricted __le32 degrades to integer
drivers/infiniband/hw/hns/./hns_roce_trace.h:173:1: sparse: sparse: restricted __le32 degrades to integer

Fixes: 6c98c8670806 ("RDMA/hns: Add trace for WQE dumping")
Fixes: 1e63e2f96613 ("RDMA/hns: Add trace for AEQE dumping")
Fixes: 6bd18dabf1c9 ("RDMA/hns: Add trace for CMDQ dumping")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202505170327.TNOpreil-lkp@intel.com/
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_trace.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_trace.h b/drivers/infiniband/hw/hns/hns_roce_trace.h
index 23cbdbaeffaa..59ceb591b3a1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_trace.h
+++ b/drivers/infiniband/hw/hns/hns_roce_trace.h
@@ -52,7 +52,7 @@ DECLARE_EVENT_CLASS(wqe_template,
 
 		    TP_STRUCT__entry(__field(unsigned long, qpn)
 				     __field(u32, idx)
-				     __array(__le32, wqe,
+				     __array(u32, wqe,
 					     MAX_WQE_SIZE / sizeof(__le32))
 				     __field(u32, len)
 				     __field(u64, id)
@@ -62,9 +62,10 @@ DECLARE_EVENT_CLASS(wqe_template,
 		    TP_fast_assign(__entry->qpn = qpn;
 				   __entry->idx = idx;
 				   __entry->id = id;
-				   memcpy(__entry->wqe, wqe, len);
 				   __entry->len = len / sizeof(__le32);
 				   __entry->type = type;
+				   for (int i = 0; i < __entry->len; i++)
+					__entry->wqe[i] = le32_to_cpu(((__le32 *)wqe)[i]);
 				   ),
 
 		    TP_printk("%s 0x%lx wqe(0x%x/0x%llx): %s",
@@ -92,14 +93,15 @@ TRACE_EVENT(hns_ae_info,
 	    TP_ARGS(event_type, aeqe, len),
 
 	    TP_STRUCT__entry(__field(int, event_type)
-			     __array(__le32, aeqe,
+			     __array(u32, aeqe,
 				     HNS_ROCE_V3_EQE_SIZE / sizeof(__le32))
 			     __field(u32, len)
 	    ),
 
 	    TP_fast_assign(__entry->event_type = event_type;
 			   __entry->len = len / sizeof(__le32);
-			   memcpy(__entry->aeqe, aeqe, len);
+			   for (int i = 0; i < __entry->len; i++)
+				__entry->aeqe[i] = le32_to_cpu(((__le32 *)aeqe)[i]);
 	    ),
 
 	    TP_printk("event %2d aeqe: %s", __entry->event_type,
@@ -179,14 +181,15 @@ DECLARE_EVENT_CLASS(cmdq,
 				     __field(u16, opcode)
 				     __field(u16, flag)
 				     __field(u16, retval)
-				     __array(__le32, data, 6)
+				     __array(u32, data, 6)
 		    ),
 
 		    TP_fast_assign(__assign_str(dev_name);
 				   __entry->opcode = le16_to_cpu(desc->opcode);
 				   __entry->flag = le16_to_cpu(desc->flag);
 				   __entry->retval = le16_to_cpu(desc->retval);
-				   memcpy(__entry->data, desc->data, 6 * sizeof(__le32));
+				   for (int i = 0; i < 6; i++)
+					__entry->data[i] = le32_to_cpu(desc->data[i]);
 		    ),
 
 		    TP_printk("%s cmdq opcode:0x%x, flag:0x%x, retval:0x%x, data:%s\n",
-- 
2.33.0


