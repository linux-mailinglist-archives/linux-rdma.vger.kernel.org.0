Return-Path: <linux-rdma+bounces-13885-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59107BE31EE
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 13:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125C43B09CD
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 11:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AD431A553;
	Thu, 16 Oct 2025 11:40:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57EB31A813
	for <linux-rdma@vger.kernel.org>; Thu, 16 Oct 2025 11:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614858; cv=none; b=jBNrfUrJQHAszhWnUQ/GEiIcUbycOtHzIwNQrDWLZQqIhKh8dMA47cMkzm8xWnuzgJWYCBBD/aO5iHdjFelThAq+mrftlCfXY0gXMICnl5mexM6n3vyw+ic1AcrFl7C5niUfIsSUfsDKCpUCP0uel0Ck1nJ8/mnPwxzvZ4u/Sug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614858; c=relaxed/simple;
	bh=GVdAYyvPbRPNj4kj+1ohhXo0XNJ0cyYvq3+GMSnGPUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGUF6uW2wPi41MMmm8XlgN7jcK+oxvEsBvw/LD8j9s9RAgiz0f4ZSLDlgFhzEbGk3c0m3J/GqYdx3mj9ZRiGYyCzNzw7VDpOGkkDc6VoxzmM9aHjVyFRmVlRrbVb0UYWYbpjxp5cBZYEFfC1wH5vy0j4D82BWcmiXJJVFQLweYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4cnQwm614Jzcb0q;
	Thu, 16 Oct 2025 19:39:52 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F42918007F;
	Thu, 16 Oct 2025 19:40:53 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Oct 2025 19:40:52 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-rc 1/4] RDMA/hns: Fix recv CQ and QP cache affinity
Date: Thu, 16 Oct 2025 19:40:48 +0800
Message-ID: <20251016114051.1963197-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251016114051.1963197-1-huangjunxian6@hisilicon.com>
References: <20251016114051.1963197-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: Chengchang Tang <tangchengchang@huawei.com>

Currently driver enforces affinity between QP cache and send CQ
cache, which helps improve the performance of sending, but doesn't
set affinity with recv CQ cache, resulting in suboptimal performance
of receiving.

Use one CQ bank per context to ensure the affinity among QP, send CQ
and recv CQ. For kernel ULP, CQ bank is fixed to 0.

Fixes: 9e03dbea2b06 ("RDMA/hns: Fix CQ and QP cache affinity")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c     | 58 +++++++++++++++++++--
 drivers/infiniband/hw/hns/hns_roce_device.h |  4 ++
 drivers/infiniband/hw/hns/hns_roce_main.c   |  4 ++
 3 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 3a5c93c9fb3e..6aa82fe9dd3d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -30,6 +30,7 @@
  * SOFTWARE.
  */
 
+#include <linux/pci.h>
 #include <rdma/ib_umem.h>
 #include <rdma/uverbs_ioctl.h>
 #include "hns_roce_device.h"
@@ -37,6 +38,43 @@
 #include "hns_roce_hem.h"
 #include "hns_roce_common.h"
 
+void hns_roce_put_cq_bankid_for_uctx(struct hns_roce_ucontext *uctx)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->ibucontext.device);
+	struct hns_roce_cq_table *cq_table = &hr_dev->cq_table;
+
+	if (hr_dev->pci_dev->revision < PCI_REVISION_ID_HIP09)
+		return;
+
+	mutex_lock(&cq_table->bank_mutex);
+	cq_table->ctx_num[uctx->cq_bank_id]--;
+	mutex_unlock(&cq_table->bank_mutex);
+}
+
+void hns_roce_get_cq_bankid_for_uctx(struct hns_roce_ucontext *uctx)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->ibucontext.device);
+	struct hns_roce_cq_table *cq_table = &hr_dev->cq_table;
+	u32 least_load = cq_table->ctx_num[0];
+	u8 bankid = 0;
+	u8 i;
+
+	if (hr_dev->pci_dev->revision < PCI_REVISION_ID_HIP09)
+		return;
+
+	mutex_lock(&cq_table->bank_mutex);
+	for (i = 1; i < HNS_ROCE_CQ_BANK_NUM; i++) {
+		if (cq_table->ctx_num[i] < least_load) {
+			least_load = cq_table->ctx_num[i];
+			bankid = i;
+		}
+	}
+	cq_table->ctx_num[bankid]++;
+	mutex_unlock(&cq_table->bank_mutex);
+
+	uctx->cq_bank_id = bankid;
+}
+
 static u8 get_least_load_bankid_for_cq(struct hns_roce_bank *bank)
 {
 	u32 least_load = bank[0].inuse;
@@ -55,7 +93,21 @@ static u8 get_least_load_bankid_for_cq(struct hns_roce_bank *bank)
 	return bankid;
 }
 
-static int alloc_cqn(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
+static u8 select_cq_bankid(struct hns_roce_dev *hr_dev,
+			   struct hns_roce_bank *bank, struct ib_udata *udata)
+{
+	struct hns_roce_ucontext *uctx = udata ?
+		rdma_udata_to_drv_context(udata, struct hns_roce_ucontext,
+					  ibucontext) : NULL;
+
+	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
+		return uctx ? uctx->cq_bank_id : 0;
+
+	return get_least_load_bankid_for_cq(bank);
+}
+
+static int alloc_cqn(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
+		     struct ib_udata *udata)
 {
 	struct hns_roce_cq_table *cq_table = &hr_dev->cq_table;
 	struct hns_roce_bank *bank;
@@ -63,7 +115,7 @@ static int alloc_cqn(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	int id;
 
 	mutex_lock(&cq_table->bank_mutex);
-	bankid = get_least_load_bankid_for_cq(cq_table->bank);
+	bankid = select_cq_bankid(hr_dev, cq_table->bank, udata);
 	bank = &cq_table->bank[bankid];
 
 	id = ida_alloc_range(&bank->ida, bank->min, bank->max, GFP_KERNEL);
@@ -396,7 +448,7 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 		goto err_cq_buf;
 	}
 
-	ret = alloc_cqn(hr_dev, hr_cq);
+	ret = alloc_cqn(hr_dev, hr_cq, udata);
 	if (ret) {
 		ibdev_err(ibdev, "failed to alloc CQN, ret = %d.\n", ret);
 		goto err_cq_db;
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 78ee04a48a74..06832c0ac055 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -217,6 +217,7 @@ struct hns_roce_ucontext {
 	struct mutex		page_mutex;
 	struct hns_user_mmap_entry *db_mmap_entry;
 	u32			config;
+	u8 cq_bank_id;
 };
 
 struct hns_roce_pd {
@@ -495,6 +496,7 @@ struct hns_roce_cq_table {
 	struct hns_roce_hem_table	table;
 	struct hns_roce_bank bank[HNS_ROCE_CQ_BANK_NUM];
 	struct mutex			bank_mutex;
+	u32 ctx_num[HNS_ROCE_CQ_BANK_NUM];
 };
 
 struct hns_roce_srq_table {
@@ -1305,5 +1307,7 @@ hns_roce_user_mmap_entry_insert(struct ib_ucontext *ucontext, u64 address,
 				size_t length,
 				enum hns_roce_mmap_type mmap_type);
 bool check_sl_valid(struct hns_roce_dev *hr_dev, u8 sl);
+void hns_roce_put_cq_bankid_for_uctx(struct hns_roce_ucontext *uctx);
+void hns_roce_get_cq_bankid_for_uctx(struct hns_roce_ucontext *uctx);
 
 #endif /* _HNS_ROCE_DEVICE_H */
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index d50f36f8a110..f3607fe107a7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -425,6 +425,8 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 	if (ret)
 		goto error_fail_copy_to_udata;
 
+	hns_roce_get_cq_bankid_for_uctx(context);
+
 	return 0;
 
 error_fail_copy_to_udata:
@@ -447,6 +449,8 @@ static void hns_roce_dealloc_ucontext(struct ib_ucontext *ibcontext)
 	struct hns_roce_ucontext *context = to_hr_ucontext(ibcontext);
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibcontext->device);
 
+	hns_roce_put_cq_bankid_for_uctx(context);
+
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
 	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB)
 		mutex_destroy(&context->page_mutex);
-- 
2.33.0


