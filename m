Return-Path: <linux-rdma+bounces-11861-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5300AF72A4
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 13:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7567316E2AA
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 11:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A295F2E2F0C;
	Thu,  3 Jul 2025 11:39:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D20295524
	for <linux-rdma@vger.kernel.org>; Thu,  3 Jul 2025 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542752; cv=none; b=kNDMdTgg8AK8uHt/GNe0UlxX4rZBr/PpldeAu6+tiLD8ZyHZZeqA/4twZTTWO3NM3szKz8ofVZiJNavD5aXiPCC7eY28/1OKPfC2+KPrBj6SSIG4n9N/fNCjaxGCiKOyWyO1XulHoW7FWciANt/xaUJZDq5+fYTNJWWacjpRaoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542752; c=relaxed/simple;
	bh=xTX+QBGhA7JI8rLEZbhQnVO46GqKIo/NXONCyv+aLJM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cupIP5OTwc+UdZQznw9Hv4jr0ReBEFuyk7F+p6MWFDa37U2QaDF8UUV2ZTJDO7+EZ15t1qFDGdppMusOsI1SFUDeyKbvVod5qspFNKfxbLlJ2mYniyq7P+m8TFOiTe1mTkDtFO3VWSklnnPt1l8Gwk9Wwdad+E3qrQrCjFfYMO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bXvnH6S9TzWfxP;
	Thu,  3 Jul 2025 19:34:43 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 085CB1400E3;
	Thu,  3 Jul 2025 19:39:07 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 3 Jul 2025 19:39:06 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-rc 1/6] RDMA/hns: Fix double destruction of rsv_qp
Date: Thu, 3 Jul 2025 19:39:00 +0800
Message-ID: <20250703113905.3597124-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250703113905.3597124-1-huangjunxian6@hisilicon.com>
References: <20250703113905.3597124-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: wenglianfa <wenglianfa@huawei.com>

rsv_qp may be double destroyed in error flow, first in free_mr_init(),
and then in hns_roce_exit(). Fix it by moving the free_mr_init() call
into hns_roce_v2_init().

list_del corruption, ffff589732eb9b50->next is LIST_POISON1 (dead000000000100)
WARNING: CPU: 8 PID: 1047115 at lib/list_debug.c:53 __list_del_entry_valid+0x148/0x240
...
Call trace:
 __list_del_entry_valid+0x148/0x240
 hns_roce_qp_remove+0x4c/0x3f0 [hns_roce_hw_v2]
 hns_roce_v2_destroy_qp_common+0x1dc/0x5f4 [hns_roce_hw_v2]
 hns_roce_v2_destroy_qp+0x22c/0x46c [hns_roce_hw_v2]
 free_mr_exit+0x6c/0x120 [hns_roce_hw_v2]
 hns_roce_v2_exit+0x170/0x200 [hns_roce_hw_v2]
 hns_roce_exit+0x118/0x350 [hns_roce_hw_v2]
 __hns_roce_hw_v2_init_instance+0x1c8/0x304 [hns_roce_hw_v2]
 hns_roce_hw_v2_reset_notify_init+0x170/0x21c [hns_roce_hw_v2]
 hns_roce_hw_v2_reset_notify+0x6c/0x190 [hns_roce_hw_v2]
 hclge_notify_roce_client+0x6c/0x160 [hclge]
 hclge_reset_rebuild+0x150/0x5c0 [hclge]
 hclge_reset+0x10c/0x140 [hclge]
 hclge_reset_subtask+0x80/0x104 [hclge]
 hclge_reset_service_task+0x168/0x3ac [hclge]
 hclge_service_task+0x50/0x100 [hclge]
 process_one_work+0x250/0x9a0
 worker_thread+0x324/0x990
 kthread+0x190/0x210
 ret_from_fork+0x10/0x18

Fixes: fd8489294dd2 ("RDMA/hns: Fix Use-After-Free of rsv_qp on HIP08")
Signed-off-by: wenglianfa <wenglianfa@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 25 +++++++++++-----------
 drivers/infiniband/hw/hns/hns_roce_main.c  |  6 +++---
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 3e1189f456b9..602c5a4c682a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2986,14 +2986,22 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
 {
 	int ret;
 
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08) {
+		ret = free_mr_init(hr_dev);
+		if (ret) {
+			dev_err(hr_dev->dev, "failed to init free mr!\n");
+			return ret;
+		}
+	}
+
 	/* The hns ROCEE requires the extdb info to be cleared before using */
 	ret = hns_roce_clear_extdb_list_info(hr_dev);
 	if (ret)
-		return ret;
+		goto err_clear_extdb_failed;
 
 	ret = get_hem_table(hr_dev);
 	if (ret)
-		return ret;
+		goto err_clear_extdb_failed;
 
 	if (hr_dev->is_vf)
 		return 0;
@@ -3008,6 +3016,9 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
 
 err_llm_init_failed:
 	put_hem_table(hr_dev);
+err_clear_extdb_failed:
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08)
+		free_mr_exit(hr_dev);
 
 	return ret;
 }
@@ -7005,21 +7016,11 @@ static int __hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
 		goto error_failed_roce_init;
 	}
 
-	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08) {
-		ret = free_mr_init(hr_dev);
-		if (ret) {
-			dev_err(hr_dev->dev, "failed to init free mr!\n");
-			goto error_failed_free_mr_init;
-		}
-	}
 
 	handle->priv = hr_dev;
 
 	return 0;
 
-error_failed_free_mr_init:
-	hns_roce_exit(hr_dev);
-
 error_failed_roce_init:
 	kfree(hr_dev->priv);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 55962653f214..427dd700cddc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -955,6 +955,9 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 
 	spin_lock_init(&hr_dev->sm_lock);
 
+	INIT_LIST_HEAD(&hr_dev->qp_list);
+	spin_lock_init(&hr_dev->qp_list_lock);
+
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
 	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB) {
 		INIT_LIST_HEAD(&hr_dev->pgdir_list);
@@ -1122,9 +1125,6 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
 		}
 	}
 
-	INIT_LIST_HEAD(&hr_dev->qp_list);
-	spin_lock_init(&hr_dev->qp_list_lock);
-
 	ret = hns_roce_register_device(hr_dev);
 	if (ret)
 		goto error_failed_register_device;
-- 
2.33.0


