Return-Path: <linux-rdma+bounces-9582-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A52A934F9
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 10:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A29F57B1FE1
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 08:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7554F26FA7D;
	Fri, 18 Apr 2025 08:57:01 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1624126FA42
	for <linux-rdma@vger.kernel.org>; Fri, 18 Apr 2025 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744966621; cv=none; b=AW9pBXaVAUlCz6uEmVNn5AYanp7U4voDA2UTXi82weFZ0r6Aocf9a3kbJIURHwV4/0uoQO7sD1GpYvPHQtb8RZgtWkJNGMqsqgDc3DN9Q1ZZ0x1Gkg7l3pa6NQ5cO2Edp7mGoa//fP6GNYqkkt8BtJYnJa4D17KjCjdobl3SlaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744966621; c=relaxed/simple;
	bh=VG73jVBkpEj9L2W7Wtg/jHnQmxfnSMVMcCsfum6TeMo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dywqsx6VoNQGeAdYdmhk2fgFnVbbSmYlhO+sKY9dv8DZleybvrqQXm9wqVHHGqdr5xSzYpF8ZZWU9vOfEkNSPkMWgNyQ41djFiQ4s2ttE+8KWsDcNxVzMJT7HJlYsdGBIk0B5eHqtOyV44Hw+EWbgowz2sTldiOE+g4FGFv1faE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Zf7nR4cHhzvWp8;
	Fri, 18 Apr 2025 16:52:43 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 87B7C1402E2;
	Fri, 18 Apr 2025 16:56:50 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Apr 2025 16:56:50 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next 5/6] RDMA/hns: Include hnae3.h in hns_roce_hw_v2.h
Date: Fri, 18 Apr 2025 16:56:46 +0800
Message-ID: <20250418085647.4067840-6-huangjunxian6@hisilicon.com>
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

hns_roce_hw_v2.h has a direct dependency on hnae3.h due to the
inline function hns_roce_write64(), but it doesn't include this
header currently. This leads to that files including
hns_roce_hw_v2.h must also include hnae3.h to avoid compilation
errors, even if they themselves don't really rely on hnae3.h.
This doesn't make sense, hns_roce_hw_v2.h should include hnae3.h
directly.

Fixes: d3743fa94ccd ("RDMA/hns: Fix the chip hanging caused by sending doorbell during reset")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_ah.c       | 1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h    | 1 +
 drivers/infiniband/hw/hns/hns_roce_main.c     | 1 -
 drivers/infiniband/hw/hns/hns_roce_restrack.c | 1 -
 5 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_ah.c b/drivers/infiniband/hw/hns/hns_roce_ah.c
index 4fc5b9d5fea8..307c35888b30 100644
--- a/drivers/infiniband/hw/hns/hns_roce_ah.c
+++ b/drivers/infiniband/hw/hns/hns_roce_ah.c
@@ -33,7 +33,6 @@
 #include <linux/pci.h>
 #include <rdma/ib_addr.h>
 #include <rdma/ib_cache.h>
-#include "hnae3.h"
 #include "hns_roce_device.h"
 #include "hns_roce_hw_v2.h"
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index ae8c790d4211..78d39afb2aa0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -43,7 +43,6 @@
 #include <rdma/ib_umem.h>
 #include <rdma/uverbs_ioctl.h>
 
-#include "hnae3.h"
 #include "hns_roce_common.h"
 #include "hns_roce_device.h"
 #include "hns_roce_cmd.h"
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 91a5665465ff..bc7466830eaf 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -34,6 +34,7 @@
 #define _HNS_ROCE_HW_V2_H
 
 #include <linux/bitops.h>
+#include "hnae3.h"
 
 #define HNS_ROCE_V2_MAX_RC_INL_INN_SZ		32
 #define HNS_ROCE_V2_MTT_ENTRY_SZ		64
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index cf89a8db4f64..02f7acb30c5d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -37,7 +37,6 @@
 #include <rdma/ib_smi.h>
 #include <rdma/ib_user_verbs.h>
 #include <rdma/ib_cache.h>
-#include "hnae3.h"
 #include "hns_roce_common.h"
 #include "hns_roce_device.h"
 #include "hns_roce_hem.h"
diff --git a/drivers/infiniband/hw/hns/hns_roce_restrack.c b/drivers/infiniband/hw/hns/hns_roce_restrack.c
index 356d98816949..f637b73b946e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_restrack.c
+++ b/drivers/infiniband/hw/hns/hns_roce_restrack.c
@@ -4,7 +4,6 @@
 #include <rdma/rdma_cm.h>
 #include <rdma/restrack.h>
 #include <uapi/rdma/rdma_netlink.h>
-#include "hnae3.h"
 #include "hns_roce_common.h"
 #include "hns_roce_device.h"
 #include "hns_roce_hw_v2.h"
-- 
2.33.0


