Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB113A2ABC
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 13:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFJLwi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 07:52:38 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5491 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhFJLwe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Jun 2021 07:52:34 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G12KG4dK4zZfZq;
        Thu, 10 Jun 2021 19:47:46 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 19:50:37 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 10 Jun 2021 19:50:37 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Yangyang Li <liyangyang20@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 6/6] RDMA/hns: Use IDA interface to manage xrcd index
Date:   Thu, 10 Jun 2021 19:50:14 +0800
Message-ID: <1623325814-55737-7-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623325814-55737-1-git-send-email-liweihang@huawei.com>
References: <1623325814-55737-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

Switch xrcd index allocation and release from hns own bitmap interface
to IDA interface.

Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_alloc.c  |  2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h |  5 ++--
 drivers/infiniband/hw/hns/hns_roce_main.c   | 13 ++------
 drivers/infiniband/hw/hns/hns_roce_pd.c     | 46 ++++++++++++-----------------
 4 files changed, 25 insertions(+), 41 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index dcdfcc7..1b02d3b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -245,7 +245,7 @@ int hns_roce_get_umem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
 void hns_roce_cleanup_bitmap(struct hns_roce_dev *hr_dev)
 {
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_XRC)
-		hns_roce_cleanup_xrcd_table(hr_dev);
+		ida_destroy(&hr_dev->xrcd_ida.ida);
 
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SRQ)
 		hns_roce_cleanup_srq_table(hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index b70c977..d87bab0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -963,7 +963,7 @@ struct hns_roce_dev {
 
 	struct hns_roce_cmdq	cmd;
 	struct hns_roce_ida pd_ida;
-	struct hns_roce_bitmap xrcd_bitmap;
+	struct hns_roce_ida xrcd_ida;
 	struct hns_roce_uar_table uar_table;
 	struct hns_roce_mr_table  mr_table;
 	struct hns_roce_cq_table  cq_table;
@@ -1149,13 +1149,12 @@ void hns_roce_init_mr_table(struct hns_roce_dev *hr_dev);
 void hns_roce_init_cq_table(struct hns_roce_dev *hr_dev);
 int hns_roce_init_qp_table(struct hns_roce_dev *hr_dev);
 int hns_roce_init_srq_table(struct hns_roce_dev *hr_dev);
-int hns_roce_init_xrcd_table(struct hns_roce_dev *hr_dev);
+void hns_roce_init_xrcd_table(struct hns_roce_dev *hr_dev);
 
 void hns_roce_cleanup_eq_table(struct hns_roce_dev *hr_dev);
 void hns_roce_cleanup_cq_table(struct hns_roce_dev *hr_dev);
 void hns_roce_cleanup_qp_table(struct hns_roce_dev *hr_dev);
 void hns_roce_cleanup_srq_table(struct hns_roce_dev *hr_dev);
-void hns_roce_cleanup_xrcd_table(struct hns_roce_dev *hr_dev);
 
 int hns_roce_bitmap_alloc(struct hns_roce_bitmap *bitmap, unsigned long *obj);
 void hns_roce_bitmap_free(struct hns_roce_bitmap *bitmap, unsigned long obj);
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 0e558b5..2d79cf6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -750,14 +750,8 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 
 	hns_roce_init_pd_table(hr_dev);
 
-	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_XRC) {
-		ret = hns_roce_init_xrcd_table(hr_dev);
-		if (ret) {
-			dev_err(dev, "failed to init xrcd table, ret = %d.\n",
-				ret);
-			goto err_pd_table_free;
-		}
-	}
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_XRC)
+		hns_roce_init_xrcd_table(hr_dev);
 
 	hns_roce_init_mr_table(hr_dev);
 
@@ -788,9 +782,8 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 	ida_destroy(&hr_dev->mr_table.mtpt_ida.ida);
 
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_XRC)
-		hns_roce_cleanup_xrcd_table(hr_dev);
+		ida_destroy(&hr_dev->xrcd_ida.ida);
 
-err_pd_table_free:
 	ida_destroy(&hr_dev->pd_ida.ida);
 	hns_roce_uar_free(hr_dev, &hr_dev->priv_uar);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_pd.c b/drivers/infiniband/hw/hns/hns_roce_pd.c
index c2f67a7..ea56636 100644
--- a/drivers/infiniband/hw/hns/hns_roce_pd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_pd.c
@@ -134,35 +134,27 @@ void hns_roce_cleanup_uar_table(struct hns_roce_dev *hr_dev)
 
 static int hns_roce_xrcd_alloc(struct hns_roce_dev *hr_dev, u32 *xrcdn)
 {
-	unsigned long obj;
-	int ret;
-
-	ret = hns_roce_bitmap_alloc(&hr_dev->xrcd_bitmap, &obj);
-	if (ret)
-		return ret;
+	struct hns_roce_ida *xrcd_ida = &hr_dev->xrcd_ida;
+	int id;
 
-	*xrcdn = obj;
+	id = ida_alloc_range(&xrcd_ida->ida, xrcd_ida->min, xrcd_ida->max,
+			     GFP_KERNEL);
+	if (id < 0) {
+		ibdev_err(&hr_dev->ib_dev, "failed to alloc xrcdn(%d).\n", id);
+		return -ENOMEM;
+	}
+	*xrcdn = (u32)id;
 
 	return 0;
 }
 
-static void hns_roce_xrcd_free(struct hns_roce_dev *hr_dev,
-			       u32 xrcdn)
+void hns_roce_init_xrcd_table(struct hns_roce_dev *hr_dev)
 {
-	hns_roce_bitmap_free(&hr_dev->xrcd_bitmap, xrcdn);
-}
+	struct hns_roce_ida *xrcd_ida = &hr_dev->xrcd_ida;
 
-int hns_roce_init_xrcd_table(struct hns_roce_dev *hr_dev)
-{
-	return hns_roce_bitmap_init(&hr_dev->xrcd_bitmap,
-				    hr_dev->caps.num_xrcds,
-				    hr_dev->caps.num_xrcds - 1,
-				    hr_dev->caps.reserved_xrcds, 0);
-}
-
-void hns_roce_cleanup_xrcd_table(struct hns_roce_dev *hr_dev)
-{
-	hns_roce_bitmap_cleanup(&hr_dev->xrcd_bitmap);
+	ida_init(&xrcd_ida->ida);
+	xrcd_ida->max = hr_dev->caps.num_xrcds - 1;
+	xrcd_ida->min = hr_dev->caps.reserved_xrcds;
 }
 
 int hns_roce_alloc_xrcd(struct ib_xrcd *ib_xrcd, struct ib_udata *udata)
@@ -175,18 +167,18 @@ int hns_roce_alloc_xrcd(struct ib_xrcd *ib_xrcd, struct ib_udata *udata)
 		return -EINVAL;
 
 	ret = hns_roce_xrcd_alloc(hr_dev, &xrcd->xrcdn);
-	if (ret) {
-		dev_err(hr_dev->dev, "failed to alloc xrcdn, ret = %d.\n", ret);
+	if (ret)
 		return ret;
-	}
 
 	return 0;
 }
 
 int hns_roce_dealloc_xrcd(struct ib_xrcd *ib_xrcd, struct ib_udata *udata)
 {
-	hns_roce_xrcd_free(to_hr_dev(ib_xrcd->device),
-			   to_hr_xrcd(ib_xrcd)->xrcdn);
+	struct hns_roce_dev *hr_dev = to_hr_dev(ib_xrcd->device);
+	u32 xrcdn = to_hr_xrcd(ib_xrcd)->xrcdn;
+
+	ida_free(&hr_dev->xrcd_ida.ida, (int)xrcdn);
 
 	return 0;
 }
-- 
2.7.4

