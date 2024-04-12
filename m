Return-Path: <linux-rdma+bounces-1926-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 998768A2AF9
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Apr 2024 11:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D13D1F21B6D
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Apr 2024 09:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D3D53802;
	Fri, 12 Apr 2024 09:20:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D04B524B4;
	Fri, 12 Apr 2024 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913652; cv=none; b=czcQ8EsMZK4IlAtS8WYoGTSXqbs95pK3A2TxaR+S/MyrL0TacClGTmvmY1HCyMenP8fXM9oT4daZLqNp3D+HGP17wPeNRhlWmtIpf3moczhWDEYwVipU98YTJ7jlkj696BbULZw6jzgIw5HvBtmP9+CQRE8OpcYvAX65/K9UiGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913652; c=relaxed/simple;
	bh=4pN/8MrYrmENmQbNtvDxyr8m8cUIpruV7AmA7o+nKHg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eacnqHQkX6R27jZguvyWDK5jFT5AzrdDZ7o6JuMyIWVt/PgfImGzj3iYyuCN86r6ysVhyRM7FHEcBj9grcpD10phU3m5ldFrmyqsm3TNSmm8zc/ohUZ13mp1KT1NHw/pbJxfYLtfq8X9iSjbNOt33E5CRShB00z8DfdtV7Z1TwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VG9y76V2Xz1xmTb;
	Fri, 12 Apr 2024 17:19:59 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 1AAE01A0172;
	Fri, 12 Apr 2024 17:20:48 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 17:20:47 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 03/10] RDMA/hns: Add max_ah and cq moderation capacities in query_device()
Date: Fri, 12 Apr 2024 17:16:09 +0800
Message-ID: <20240412091616.370789-4-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240412091616.370789-1-huangjunxian6@hisilicon.com>
References: <20240412091616.370789-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500006.china.huawei.com (7.221.188.68)

From: Chengchang Tang <tangchengchang@huawei.com>

Add max_ah and cq moderation capacities to hns_roce_query_device().

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 3 +++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 2 +-
 drivers/infiniband/hw/hns/hns_roce_main.c   | 7 +++++++
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 37888f78849d..ff0b3f68ee3a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -100,6 +100,9 @@
 #define CQ_BANKID_SHIFT 2
 #define CQ_BANKID_MASK GENMASK(1, 0)
 
+#define HNS_ROCE_MAX_CQ_COUNT 0xFFFF
+#define HNS_ROCE_MAX_CQ_PERIOD 0xFFFF
+
 enum {
 	SERV_TYPE_RC,
 	SERV_TYPE_UC,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index e3f87090bad0..2a97a81ae19f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5848,7 +5848,7 @@ static int hns_roce_v2_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period)
 			dev_info(hr_dev->dev,
 				 "cq_period(%u) reached the upper limit, adjusted to 65.\n",
 				 cq_period);
-			cq_period = HNS_ROCE_MAX_CQ_PERIOD;
+			cq_period = HNS_ROCE_MAX_CQ_PERIOD_HIP08;
 		}
 		cq_period *= HNS_ROCE_CLOCK_ADJUST;
 	}
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 4bac34f6bbe8..def1d15a03c7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1347,7 +1347,7 @@ struct fmea_ram_ecc {
 
 /* only for RNR timeout issue of HIP08 */
 #define HNS_ROCE_CLOCK_ADJUST 1000
-#define HNS_ROCE_MAX_CQ_PERIOD 65
+#define HNS_ROCE_MAX_CQ_PERIOD_HIP08 65
 #define HNS_ROCE_MAX_EQ_PERIOD 65
 #define HNS_ROCE_RNR_TIMER_10NS 1
 #define HNS_ROCE_1US_CFG 999
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 1dc60c2b2b7a..4d94fcb8685a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -40,6 +40,7 @@
 #include "hns_roce_common.h"
 #include "hns_roce_device.h"
 #include "hns_roce_hem.h"
+#include "hns_roce_hw_v2.h"
 
 static int hns_roce_set_mac(struct hns_roce_dev *hr_dev, u32 port,
 			    const u8 *addr)
@@ -192,6 +193,12 @@ static int hns_roce_query_device(struct ib_device *ib_dev,
 			    IB_ATOMIC_HCA : IB_ATOMIC_NONE;
 	props->max_pkeys = 1;
 	props->local_ca_ack_delay = hr_dev->caps.local_ca_ack_delay;
+	props->max_ah = INT_MAX;
+	props->cq_caps.max_cq_moderation_period = HNS_ROCE_MAX_CQ_PERIOD;
+	props->cq_caps.max_cq_moderation_count = HNS_ROCE_MAX_CQ_COUNT;
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08)
+		props->cq_caps.max_cq_moderation_period = HNS_ROCE_MAX_CQ_PERIOD_HIP08;
+
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SRQ) {
 		props->max_srq = hr_dev->caps.num_srqs;
 		props->max_srq_wr = hr_dev->caps.max_srq_wrs;
-- 
2.30.0


