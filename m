Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A658C3F1007
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Aug 2021 03:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbhHSBkq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Aug 2021 21:40:46 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:17040 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235435AbhHSBkp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Aug 2021 21:40:45 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GqnRV51qSzbf6q;
        Thu, 19 Aug 2021 09:36:22 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 19 Aug 2021 09:40:07 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 19 Aug 2021 09:40:07 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 1/3] RDMA/hns: Use IDA interface to manage uar index
Date:   Thu, 19 Aug 2021 09:36:18 +0800
Message-ID: <1629336980-17499-2-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1629336980-17499-1-git-send-email-liangwenpeng@huawei.com>
References: <1629336980-17499-1-git-send-email-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

Switch uar index allocation and release from hns' own bitmap interface to
IDA interface.

Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_alloc.c  |  2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h |  6 ++----
 drivers/infiniband/hw/hns/hns_roce_main.c   | 14 +++++--------
 drivers/infiniband/hw/hns/hns_roce_pd.c     | 31 +++++++++++++----------------
 4 files changed, 22 insertions(+), 31 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index 1b02d3b..6ae506e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -253,5 +253,5 @@ void hns_roce_cleanup_bitmap(struct hns_roce_dev *hr_dev)
 	hns_roce_cleanup_cq_table(hr_dev);
 	ida_destroy(&hr_dev->mr_table.mtpt_ida.ida);
 	ida_destroy(&hr_dev->pd_ida.ida);
-	hns_roce_cleanup_uar_table(hr_dev);
+	ida_destroy(&hr_dev->uar_ida.ida);
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 0c3eb11..01906f3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -963,7 +963,7 @@ struct hns_roce_dev {
 	struct hns_roce_cmdq	cmd;
 	struct hns_roce_ida pd_ida;
 	struct hns_roce_ida xrcd_ida;
-	struct hns_roce_uar_table uar_table;
+	struct hns_roce_ida uar_ida;
 	struct hns_roce_mr_table  mr_table;
 	struct hns_roce_cq_table  cq_table;
 	struct hns_roce_srq_table srq_table;
@@ -1118,10 +1118,8 @@ static inline u8 get_tclass(const struct ib_global_route *grh)
 	       grh->traffic_class >> DSCP_SHIFT : grh->traffic_class;
 }
 
-int hns_roce_init_uar_table(struct hns_roce_dev *dev);
+void hns_roce_init_uar_table(struct hns_roce_dev *dev);
 int hns_roce_uar_alloc(struct hns_roce_dev *dev, struct hns_roce_uar *uar);
-void hns_roce_uar_free(struct hns_roce_dev *dev, struct hns_roce_uar *uar);
-void hns_roce_cleanup_uar_table(struct hns_roce_dev *dev);
 
 int hns_roce_cmd_init(struct hns_roce_dev *hr_dev);
 void hns_roce_cmd_cleanup(struct hns_roce_dev *hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 23b88a5..7ab685a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -325,7 +325,7 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 	return 0;
 
 error_fail_copy_to_udata:
-	hns_roce_uar_free(hr_dev, &context->uar);
+	ida_free(&hr_dev->uar_ida.ida, (int)context->uar.logic_idx);
 
 error_fail_uar_alloc:
 	return ret;
@@ -334,8 +334,9 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 static void hns_roce_dealloc_ucontext(struct ib_ucontext *ibcontext)
 {
 	struct hns_roce_ucontext *context = to_hr_ucontext(ibcontext);
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibcontext->device);
 
-	hns_roce_uar_free(to_hr_dev(ibcontext->device), &context->uar);
+	ida_free(&hr_dev->uar_ida.ida, (int)context->uar.logic_idx);
 }
 
 static int hns_roce_mmap(struct ib_ucontext *context,
@@ -737,11 +738,7 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 		mutex_init(&hr_dev->pgdir_mutex);
 	}
 
-	ret = hns_roce_init_uar_table(hr_dev);
-	if (ret) {
-		dev_err(dev, "Failed to initialize uar table. aborting\n");
-		return ret;
-	}
+	hns_roce_init_uar_table(hr_dev);
 
 	ret = hns_roce_uar_alloc(hr_dev, &hr_dev->priv_uar);
 	if (ret) {
@@ -780,10 +777,9 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 		ida_destroy(&hr_dev->xrcd_ida.ida);
 
 	ida_destroy(&hr_dev->pd_ida.ida);
-	hns_roce_uar_free(hr_dev, &hr_dev->priv_uar);
 
 err_uar_table_free:
-	hns_roce_cleanup_uar_table(hr_dev);
+	ida_destroy(&hr_dev->uar_ida.ida);
 	return ret;
 }
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_pd.c b/drivers/infiniband/hw/hns/hns_roce_pd.c
index ea56636..81ffad7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_pd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_pd.c
@@ -85,13 +85,18 @@ int hns_roce_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata)
 
 int hns_roce_uar_alloc(struct hns_roce_dev *hr_dev, struct hns_roce_uar *uar)
 {
+	struct hns_roce_ida *uar_ida = &hr_dev->uar_ida;
 	struct resource *res;
-	int ret;
+	int id;
 
 	/* Using bitmap to manager UAR index */
-	ret = hns_roce_bitmap_alloc(&hr_dev->uar_table.bitmap, &uar->logic_idx);
-	if (ret)
+	id = ida_alloc_range(&uar_ida->ida, uar_ida->min, uar_ida->max,
+			     GFP_KERNEL);
+	if (id < 0) {
+		ibdev_err(&hr_dev->ib_dev, "failed to alloc uar id(%d).\n", id);
 		return -ENOMEM;
+	}
+	uar->logic_idx = (unsigned long)id;
 
 	if (uar->logic_idx > 0 && hr_dev->caps.phy_num_uars > 1)
 		uar->index = (uar->logic_idx - 1) %
@@ -102,6 +107,7 @@ int hns_roce_uar_alloc(struct hns_roce_dev *hr_dev, struct hns_roce_uar *uar)
 	if (!dev_is_pci(hr_dev->dev)) {
 		res = platform_get_resource(hr_dev->pdev, IORESOURCE_MEM, 0);
 		if (!res) {
+			ida_free(&uar_ida->ida, id);
 			dev_err(&hr_dev->pdev->dev, "memory resource not found!\n");
 			return -EINVAL;
 		}
@@ -114,22 +120,13 @@ int hns_roce_uar_alloc(struct hns_roce_dev *hr_dev, struct hns_roce_uar *uar)
 	return 0;
 }
 
-void hns_roce_uar_free(struct hns_roce_dev *hr_dev, struct hns_roce_uar *uar)
+void hns_roce_init_uar_table(struct hns_roce_dev *hr_dev)
 {
-	hns_roce_bitmap_free(&hr_dev->uar_table.bitmap, uar->logic_idx);
-}
+	struct hns_roce_ida *uar_ida = &hr_dev->uar_ida;
 
-int hns_roce_init_uar_table(struct hns_roce_dev *hr_dev)
-{
-	return hns_roce_bitmap_init(&hr_dev->uar_table.bitmap,
-				    hr_dev->caps.num_uars,
-				    hr_dev->caps.num_uars - 1,
-				    hr_dev->caps.reserved_uars, 0);
-}
-
-void hns_roce_cleanup_uar_table(struct hns_roce_dev *hr_dev)
-{
-	hns_roce_bitmap_cleanup(&hr_dev->uar_table.bitmap);
+	ida_init(&uar_ida->ida);
+	uar_ida->max = hr_dev->caps.num_uars - 1;
+	uar_ida->min = hr_dev->caps.reserved_uars;
 }
 
 static int hns_roce_xrcd_alloc(struct hns_roce_dev *hr_dev, u32 *xrcdn)
-- 
2.8.1

