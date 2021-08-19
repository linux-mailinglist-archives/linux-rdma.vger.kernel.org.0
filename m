Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5043F1008
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Aug 2021 03:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbhHSBkq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Aug 2021 21:40:46 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:14229 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbhHSBko (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Aug 2021 21:40:44 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GqnWL708zz1CYMp;
        Thu, 19 Aug 2021 09:39:42 +0800 (CST)
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
Subject: [PATCH for-next 2/3] RDMA/hns: Use IDA interface to manage srq index
Date:   Thu, 19 Aug 2021 09:36:19 +0800
Message-ID: <1629336980-17499-3-git-send-email-liangwenpeng@huawei.com>
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

Switch srq index allocation and release from hns' own bitmap interface to
IDA interface.

Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_alloc.c  |  2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h |  5 ++---
 drivers/infiniband/hw/hns/hns_roce_main.c   | 17 +----------------
 drivers/infiniband/hw/hns/hns_roce_srq.c    | 28 ++++++++++++++--------------
 4 files changed, 18 insertions(+), 34 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index 6ae506e..1dc35dd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -248,7 +248,7 @@ void hns_roce_cleanup_bitmap(struct hns_roce_dev *hr_dev)
 		ida_destroy(&hr_dev->xrcd_ida.ida);
 
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SRQ)
-		hns_roce_cleanup_srq_table(hr_dev);
+		ida_destroy(&hr_dev->srq_table.srq_ida.ida);
 	hns_roce_cleanup_qp_table(hr_dev);
 	hns_roce_cleanup_cq_table(hr_dev);
 	ida_destroy(&hr_dev->mr_table.mtpt_ida.ida);
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 01906f3..4b6c3c0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -514,7 +514,7 @@ struct hns_roce_cq_table {
 };
 
 struct hns_roce_srq_table {
-	struct hns_roce_bitmap		bitmap;
+	struct hns_roce_ida		srq_ida;
 	struct xarray			xa;
 	struct hns_roce_hem_table	table;
 };
@@ -1145,13 +1145,12 @@ void hns_roce_init_pd_table(struct hns_roce_dev *hr_dev);
 void hns_roce_init_mr_table(struct hns_roce_dev *hr_dev);
 void hns_roce_init_cq_table(struct hns_roce_dev *hr_dev);
 void hns_roce_init_qp_table(struct hns_roce_dev *hr_dev);
-int hns_roce_init_srq_table(struct hns_roce_dev *hr_dev);
+void hns_roce_init_srq_table(struct hns_roce_dev *hr_dev);
 void hns_roce_init_xrcd_table(struct hns_roce_dev *hr_dev);
 
 void hns_roce_cleanup_eq_table(struct hns_roce_dev *hr_dev);
 void hns_roce_cleanup_cq_table(struct hns_roce_dev *hr_dev);
 void hns_roce_cleanup_qp_table(struct hns_roce_dev *hr_dev);
-void hns_roce_cleanup_srq_table(struct hns_roce_dev *hr_dev);
 
 int hns_roce_bitmap_alloc(struct hns_roce_bitmap *bitmap, unsigned long *obj);
 void hns_roce_bitmap_free(struct hns_roce_bitmap *bitmap, unsigned long obj);
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 7ab685a..6467f8f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -758,26 +758,11 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 	hns_roce_init_qp_table(hr_dev);
 
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SRQ) {
-		ret = hns_roce_init_srq_table(hr_dev);
-		if (ret) {
-			dev_err(dev,
-				"Failed to init share receive queue table.\n");
-			goto err_qp_table_free;
-		}
+		hns_roce_init_srq_table(hr_dev);
 	}
 
 	return 0;
 
-err_qp_table_free:
-	hns_roce_cleanup_qp_table(hr_dev);
-	hns_roce_cleanup_cq_table(hr_dev);
-	ida_destroy(&hr_dev->mr_table.mtpt_ida.ida);
-
-	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_XRC)
-		ida_destroy(&hr_dev->xrcd_ida.ida);
-
-	ida_destroy(&hr_dev->pd_ida.ida);
-
 err_uar_table_free:
 	ida_destroy(&hr_dev->uar_ida.ida);
 	return ret;
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 6f2992f..6eee9de 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -80,15 +80,19 @@ static int hns_roce_hw_destroy_srq(struct hns_roce_dev *dev,
 static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 {
 	struct hns_roce_srq_table *srq_table = &hr_dev->srq_table;
+	struct hns_roce_ida *srq_ida = &hr_dev->srq_table.srq_ida;
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_cmd_mailbox *mailbox;
 	int ret;
+	int id;
 
-	ret = hns_roce_bitmap_alloc(&srq_table->bitmap, &srq->srqn);
-	if (ret) {
-		ibdev_err(ibdev, "failed to alloc SRQ number.\n");
+	id = ida_alloc_range(&srq_ida->ida, srq_ida->min, srq_ida->max,
+			     GFP_KERNEL);
+	if (id < 0) {
+		ibdev_err(ibdev, "failed to alloc srq(%d).\n", id);
 		return -ENOMEM;
 	}
+	srq->srqn = (unsigned long)id;
 
 	ret = hns_roce_table_get(hr_dev, &srq_table->table, srq->srqn);
 	if (ret) {
@@ -132,7 +136,7 @@ static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 err_put:
 	hns_roce_table_put(hr_dev, &srq_table->table, srq->srqn);
 err_out:
-	hns_roce_bitmap_free(&srq_table->bitmap, srq->srqn);
+	ida_free(&srq_ida->ida, id);
 
 	return ret;
 }
@@ -154,7 +158,7 @@ static void free_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 	wait_for_completion(&srq->free);
 
 	hns_roce_table_put(hr_dev, &srq_table->table, srq->srqn);
-	hns_roce_bitmap_free(&srq_table->bitmap, srq->srqn);
+	ida_free(&srq_table->srq_ida.ida, (int)srq->srqn);
 }
 
 static int alloc_srq_idx(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
@@ -440,18 +444,14 @@ int hns_roce_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 	return 0;
 }
 
-int hns_roce_init_srq_table(struct hns_roce_dev *hr_dev)
+void hns_roce_init_srq_table(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_srq_table *srq_table = &hr_dev->srq_table;
+	struct hns_roce_ida *srq_ida = &srq_table->srq_ida;
 
 	xa_init(&srq_table->xa);
 
-	return hns_roce_bitmap_init(&srq_table->bitmap, hr_dev->caps.num_srqs,
-				    hr_dev->caps.num_srqs - 1,
-				    hr_dev->caps.reserved_srqs, 0);
-}
-
-void hns_roce_cleanup_srq_table(struct hns_roce_dev *hr_dev)
-{
-	hns_roce_bitmap_cleanup(&hr_dev->srq_table.bitmap);
+	ida_init(&srq_ida->ida);
+	srq_ida->max = hr_dev->caps.num_srqs - 1;
+	srq_ida->min = hr_dev->caps.reserved_srqs;
 }
-- 
2.8.1

