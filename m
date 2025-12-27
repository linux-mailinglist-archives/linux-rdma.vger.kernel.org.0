Return-Path: <linux-rdma+bounces-15230-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02019CDF4C7
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Dec 2025 07:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4061B3007949
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Dec 2025 06:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A83323BF8F;
	Sat, 27 Dec 2025 06:54:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BBDA937
	for <linux-rdma@vger.kernel.org>; Sat, 27 Dec 2025 06:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766818454; cv=none; b=aTDlevoI2UD+RxYSFrHCqbOSiJRN3Vw6H3kZltXwuycX5HZgF/BE3a+WG5MWznwhE+Yn/UhqNmBUxVfxMRiwms57inM3CqhO6NulYfCm+KbVR6YbCjDxl7DYVdipHgFwit65pO95ibjFB/A3ccMYkSn0/dTYBBp7hTGExSyO3VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766818454; c=relaxed/simple;
	bh=OzG4BXFrHyaV9RZR5URQVtpcSM6duRu1yjVwqCLS3Lo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hc7YunhWuUB1ucYwp1TXYmLnJPNL189lXl71j2DkaeFHZZ8hf7gZ+M5OXke6yJb4B2yOswW6e4oUvnUFO3UAvDq5qp4MOaWpOU5jDvbrZtDU6arSX6I1W9j+xxBaRtnNCSmfk24XBY6fZms/b4oBqSDIBkPh4PuXwVVgYeH9xWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4ddY626xHlzRhQp;
	Sat, 27 Dec 2025 14:50:50 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id F13524036C;
	Sat, 27 Dec 2025 14:53:59 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sat, 27 Dec 2025 14:53:59 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Introduce limit_bank mode with better performance
Date: Sat, 27 Dec 2025 14:53:58 +0800
Message-ID: <20251227065358.3397802-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: wenglianfa <wenglianfa@huawei.com>

In limit_bank mode, QPs/CQs are restricted to using half of the banks.
HW concentrates resources on these banks, thereby improving performance
compared to the default mode.

Switch between limit_bank mode and default mode by setting the cap
flag in FW. Since the number of QPs and CQs will be halved, this mode
is suitable for scenarios where fewer QPs and CQs are required.

Signed-off-by: wenglianfa <wenglianfa@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c     | 13 +++++-
 drivers/infiniband/hw/hns/hns_roce_device.h |  6 +++
 drivers/infiniband/hw/hns/hns_roce_main.c   |  5 +++
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 49 ++++++++++++++++-----
 4 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 6aa82fe9dd3d..bc57806abd39 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -53,9 +53,10 @@ void hns_roce_put_cq_bankid_for_uctx(struct hns_roce_ucontext *uctx)
 
 void hns_roce_get_cq_bankid_for_uctx(struct hns_roce_ucontext *uctx)
 {
+#define INVALID_LOAD_CQNUM 0xFFFFFFFF
 	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->ibucontext.device);
 	struct hns_roce_cq_table *cq_table = &hr_dev->cq_table;
-	u32 least_load = cq_table->ctx_num[0];
+	u32 least_load = INVALID_LOAD_CQNUM;
 	u8 bankid = 0;
 	u8 i;
 
@@ -63,7 +64,10 @@ void hns_roce_get_cq_bankid_for_uctx(struct hns_roce_ucontext *uctx)
 		return;
 
 	mutex_lock(&cq_table->bank_mutex);
-	for (i = 1; i < HNS_ROCE_CQ_BANK_NUM; i++) {
+	for (i = 0; i < HNS_ROCE_CQ_BANK_NUM; i++) {
+		if (!(cq_table->valid_cq_bank_mask & BIT(i)))
+			continue;
+
 		if (cq_table->ctx_num[i] < least_load) {
 			least_load = cq_table->ctx_num[i];
 			bankid = i;
@@ -581,6 +585,11 @@ void hns_roce_init_cq_table(struct hns_roce_dev *hr_dev)
 		cq_table->bank[i].max = hr_dev->caps.num_cqs /
 					HNS_ROCE_CQ_BANK_NUM - 1;
 	}
+
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_LIMIT_BANK)
+		cq_table->valid_cq_bank_mask = VALID_CQ_BANK_MASK_LIMIT;
+	else
+		cq_table->valid_cq_bank_mask = VALID_CQ_BANK_MASK_DEFAULT;
 }
 
 void hns_roce_cleanup_cq_table(struct hns_roce_dev *hr_dev)
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 318f18cf37aa..3f032b8038af 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -103,6 +103,10 @@
 
 #define CQ_BANKID_SHIFT 2
 #define CQ_BANKID_MASK GENMASK(1, 0)
+#define VALID_CQ_BANK_MASK_DEFAULT 0xF
+#define VALID_CQ_BANK_MASK_LIMIT 0x9
+
+#define VALID_EXT_SGE_QP_BANK_MASK_LIMIT 0x42
 
 #define HNS_ROCE_MAX_CQ_COUNT 0xFFFF
 #define HNS_ROCE_MAX_CQ_PERIOD 0xFFFF
@@ -156,6 +160,7 @@ enum {
 	HNS_ROCE_CAP_FLAG_CQE_INLINE		= BIT(19),
 	HNS_ROCE_CAP_FLAG_BOND                  = BIT(21),
 	HNS_ROCE_CAP_FLAG_SRQ_RECORD_DB         = BIT(22),
+	HNS_ROCE_CAP_FLAG_LIMIT_BANK            = BIT(23),
 };
 
 #define HNS_ROCE_DB_TYPE_COUNT			2
@@ -500,6 +505,7 @@ struct hns_roce_cq_table {
 	struct hns_roce_bank bank[HNS_ROCE_CQ_BANK_NUM];
 	struct mutex			bank_mutex;
 	u32 ctx_num[HNS_ROCE_CQ_BANK_NUM];
+	u8 valid_cq_bank_mask;
 };
 
 struct hns_roce_srq_table {
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 2f4864ab7d4e..a3490bab297a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -259,6 +259,11 @@ static int hns_roce_query_device(struct ib_device *ib_dev,
 		props->max_srq_sge = hr_dev->caps.max_srq_sges;
 	}
 
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_LIMIT_BANK) {
+		props->max_cq >>= 1;
+		props->max_qp >>= 1;
+	}
+
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_FRMR &&
 	    hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09) {
 		props->device_cap_flags |= IB_DEVICE_MEM_MGT_EXTENSIONS;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index d1640c5fbaab..5f7ea6c16644 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -197,22 +197,16 @@ static u8 get_affinity_cq_bank(u8 qp_bank)
 	return (qp_bank >> 1) & CQ_BANKID_MASK;
 }
 
-static u8 get_least_load_bankid_for_qp(struct ib_qp_init_attr *init_attr,
-					struct hns_roce_bank *bank)
+static u8 get_least_load_bankid_for_qp(struct hns_roce_bank *bank, u8 valid_qp_bank_mask)
 {
 #define INVALID_LOAD_QPNUM 0xFFFFFFFF
-	struct ib_cq *scq = init_attr->send_cq;
 	u32 least_load = INVALID_LOAD_QPNUM;
-	unsigned long cqn = 0;
 	u8 bankid = 0;
 	u32 bankcnt;
 	u8 i;
 
-	if (scq)
-		cqn = to_hr_cq(scq)->cqn;
-
 	for (i = 0; i < HNS_ROCE_QP_BANK_NUM; i++) {
-		if (scq && (get_affinity_cq_bank(i) != (cqn & CQ_BANKID_MASK)))
+		if (!(valid_qp_bank_mask & BIT(i)))
 			continue;
 
 		bankcnt = bank[i].inuse;
@@ -246,6 +240,42 @@ static int alloc_qpn_with_bankid(struct hns_roce_bank *bank, u8 bankid,
 
 	return 0;
 }
+
+static bool use_ext_sge(struct ib_qp_init_attr *init_attr)
+{
+	return init_attr->cap.max_send_sge > HNS_ROCE_SGE_IN_WQE ||
+		init_attr->qp_type == IB_QPT_UD ||
+		init_attr->qp_type == IB_QPT_GSI;
+}
+
+static u8 select_qp_bankid(struct hns_roce_dev *hr_dev,
+			   struct ib_qp_init_attr *init_attr)
+{
+	struct hns_roce_qp_table *qp_table = &hr_dev->qp_table;
+	struct hns_roce_bank *bank = qp_table->bank;
+	struct ib_cq *scq = init_attr->send_cq;
+	u8 valid_qp_bank_mask = 0;
+	unsigned long cqn = 0;
+	u8 i;
+
+	if (scq)
+		cqn = to_hr_cq(scq)->cqn;
+
+	for (i = 0; i < HNS_ROCE_QP_BANK_NUM; i++) {
+		if (scq && (get_affinity_cq_bank(i) != (cqn & CQ_BANKID_MASK)))
+			continue;
+
+		if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_LIMIT_BANK) &&
+		    use_ext_sge(init_attr) &&
+		    !(VALID_EXT_SGE_QP_BANK_MASK_LIMIT & BIT(i)))
+			continue;
+
+		valid_qp_bank_mask |= BIT(i);
+	}
+
+	return get_least_load_bankid_for_qp(bank, valid_qp_bank_mask);
+}
+
 static int alloc_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 		     struct ib_qp_init_attr *init_attr)
 {
@@ -258,8 +288,7 @@ static int alloc_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 		num = 1;
 	} else {
 		mutex_lock(&qp_table->bank_mutex);
-		bankid = get_least_load_bankid_for_qp(init_attr, qp_table->bank);
-
+		bankid = select_qp_bankid(hr_dev, init_attr);
 		ret = alloc_qpn_with_bankid(&qp_table->bank[bankid], bankid,
 					    &num);
 		if (ret) {
-- 
2.33.0


