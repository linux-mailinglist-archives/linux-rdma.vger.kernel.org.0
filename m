Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31623A2ABB
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 13:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhFJLwh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 07:52:37 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3943 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhFJLwe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Jun 2021 07:52:34 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G12K04nHxz6xCj;
        Thu, 10 Jun 2021 19:47:32 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
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
Subject: [PATCH for-next 5/6] RDMA/hns: Use IDA interface to manage pd index
Date:   Thu, 10 Jun 2021 19:50:13 +0800
Message-ID: <1623325814-55737-6-git-send-email-liweihang@huawei.com>
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

Switch pd index allocation and release from hns own bitmap interface
to IDA interface.

Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_alloc.c  |  2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h |  5 ++--
 drivers/infiniband/hw/hns/hns_roce_main.c   | 10 ++-----
 drivers/infiniband/hw/hns/hns_roce_pd.c     | 45 +++++++++++++----------------
 4 files changed, 25 insertions(+), 37 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index dc1f28a..dcdfcc7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -252,6 +252,6 @@ void hns_roce_cleanup_bitmap(struct hns_roce_dev *hr_dev)
 	hns_roce_cleanup_qp_table(hr_dev);
 	hns_roce_cleanup_cq_table(hr_dev);
 	ida_destroy(&hr_dev->mr_table.mtpt_ida.ida);
-	hns_roce_cleanup_pd_table(hr_dev);
+	ida_destroy(&hr_dev->pd_ida.ida);
 	hns_roce_cleanup_uar_table(hr_dev);
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 847829b..b70c977 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -962,7 +962,7 @@ struct hns_roce_dev {
 	void __iomem            *priv_addr;
 
 	struct hns_roce_cmdq	cmd;
-	struct hns_roce_bitmap    pd_bitmap;
+	struct hns_roce_ida pd_ida;
 	struct hns_roce_bitmap xrcd_bitmap;
 	struct hns_roce_uar_table uar_table;
 	struct hns_roce_mr_table  mr_table;
@@ -1144,14 +1144,13 @@ void hns_roce_mtr_destroy(struct hns_roce_dev *hr_dev,
 int hns_roce_mtr_map(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		     dma_addr_t *pages, unsigned int page_cnt);
 
-int hns_roce_init_pd_table(struct hns_roce_dev *hr_dev);
+void hns_roce_init_pd_table(struct hns_roce_dev *hr_dev);
 void hns_roce_init_mr_table(struct hns_roce_dev *hr_dev);
 void hns_roce_init_cq_table(struct hns_roce_dev *hr_dev);
 int hns_roce_init_qp_table(struct hns_roce_dev *hr_dev);
 int hns_roce_init_srq_table(struct hns_roce_dev *hr_dev);
 int hns_roce_init_xrcd_table(struct hns_roce_dev *hr_dev);
 
-void hns_roce_cleanup_pd_table(struct hns_roce_dev *hr_dev);
 void hns_roce_cleanup_eq_table(struct hns_roce_dev *hr_dev);
 void hns_roce_cleanup_cq_table(struct hns_roce_dev *hr_dev);
 void hns_roce_cleanup_qp_table(struct hns_roce_dev *hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 1faadd3..0e558b5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -748,11 +748,7 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 		goto err_uar_table_free;
 	}
 
-	ret = hns_roce_init_pd_table(hr_dev);
-	if (ret) {
-		dev_err(dev, "Failed to init protected domain table.\n");
-		goto err_uar_alloc_free;
-	}
+	hns_roce_init_pd_table(hr_dev);
 
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_XRC) {
 		ret = hns_roce_init_xrcd_table(hr_dev);
@@ -795,9 +791,7 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 		hns_roce_cleanup_xrcd_table(hr_dev);
 
 err_pd_table_free:
-	hns_roce_cleanup_pd_table(hr_dev);
-
-err_uar_alloc_free:
+	ida_destroy(&hr_dev->pd_ida.ida);
 	hns_roce_uar_free(hr_dev, &hr_dev->priv_uar);
 
 err_uar_table_free:
diff --git a/drivers/infiniband/hw/hns/hns_roce_pd.c b/drivers/infiniband/hw/hns/hns_roce_pd.c
index 25e52cd..c2f67a7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_pd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_pd.c
@@ -34,39 +34,31 @@
 #include <linux/pci.h>
 #include "hns_roce_device.h"
 
-static int hns_roce_pd_alloc(struct hns_roce_dev *hr_dev, unsigned long *pdn)
+void hns_roce_init_pd_table(struct hns_roce_dev *hr_dev)
 {
-	return hns_roce_bitmap_alloc(&hr_dev->pd_bitmap, pdn) ? -ENOMEM : 0;
-}
-
-static void hns_roce_pd_free(struct hns_roce_dev *hr_dev, unsigned long pdn)
-{
-	hns_roce_bitmap_free(&hr_dev->pd_bitmap, pdn);
-}
-
-int hns_roce_init_pd_table(struct hns_roce_dev *hr_dev)
-{
-	return hns_roce_bitmap_init(&hr_dev->pd_bitmap, hr_dev->caps.num_pds,
-				    hr_dev->caps.num_pds - 1,
-				    hr_dev->caps.reserved_pds, 0);
-}
+	struct hns_roce_ida *pd_ida = &hr_dev->pd_ida;
 
-void hns_roce_cleanup_pd_table(struct hns_roce_dev *hr_dev)
-{
-	hns_roce_bitmap_cleanup(&hr_dev->pd_bitmap);
+	ida_init(&pd_ida->ida);
+	pd_ida->max = hr_dev->caps.num_pds - 1;
+	pd_ida->min = hr_dev->caps.reserved_pds;
 }
 
 int hns_roce_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct ib_device *ib_dev = ibpd->device;
+	struct hns_roce_dev *hr_dev = to_hr_dev(ib_dev);
+	struct hns_roce_ida *pd_ida = &hr_dev->pd_ida;
 	struct hns_roce_pd *pd = to_hr_pd(ibpd);
-	int ret;
+	int ret = 0;
+	int id;
 
-	ret = hns_roce_pd_alloc(to_hr_dev(ib_dev), &pd->pdn);
-	if (ret) {
-		ibdev_err(ib_dev, "failed to alloc pd, ret = %d.\n", ret);
-		return ret;
+	id = ida_alloc_range(&pd_ida->ida, pd_ida->min, pd_ida->max,
+			     GFP_KERNEL);
+	if (id < 0) {
+		ibdev_err(ib_dev, "failed to alloc pd, id = %d.\n", id);
+		return -ENOMEM;
 	}
+	pd->pdn = (unsigned long)id;
 
 	if (udata) {
 		struct hns_roce_ib_alloc_pd_resp resp = {.pdn = pd->pdn};
@@ -74,7 +66,7 @@ int hns_roce_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 		ret = ib_copy_to_udata(udata, &resp,
 				       min(udata->outlen, sizeof(resp)));
 		if (ret) {
-			hns_roce_pd_free(to_hr_dev(ib_dev), pd->pdn);
+			ida_free(&pd_ida->ida, id);
 			ibdev_err(ib_dev, "failed to copy to udata, ret = %d\n", ret);
 		}
 	}
@@ -84,7 +76,10 @@ int hns_roce_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 
 int hns_roce_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata)
 {
-	hns_roce_pd_free(to_hr_dev(pd->device), to_hr_pd(pd)->pdn);
+	struct hns_roce_dev *hr_dev = to_hr_dev(pd->device);
+
+	ida_free(&hr_dev->pd_ida.ida, (int)to_hr_pd(pd)->pdn);
+
 	return 0;
 }
 
-- 
2.7.4

