Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167453AC87E
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 12:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhFRKNE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 06:13:04 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5042 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhFRKNC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Jun 2021 06:13:02 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G5vgw3Nt9zXhDF;
        Fri, 18 Jun 2021 18:05:48 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 18:10:49 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 18 Jun 2021 18:10:49 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Yangyang Li <liyangyang20@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 07/10] RDMA/hns: Modify function return value type
Date:   Fri, 18 Jun 2021 18:10:17 +0800
Message-ID: <1624011020-16992-8-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624011020-16992-1-git-send-email-liweihang@huawei.com>
References: <1624011020-16992-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

hns_roce_init_qp_table() will only return 0, because this function does not
need to return a value, so it is modified to void type.

Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 2 +-
 drivers/infiniband/hw/hns/hns_roce_main.c   | 8 +-------
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 4 +---
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 7d00d4c..c5524f1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1144,7 +1144,7 @@ int hns_roce_mtr_map(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 int hns_roce_init_pd_table(struct hns_roce_dev *hr_dev);
 int hns_roce_init_mr_table(struct hns_roce_dev *hr_dev);
 void hns_roce_init_cq_table(struct hns_roce_dev *hr_dev);
-int hns_roce_init_qp_table(struct hns_roce_dev *hr_dev);
+void hns_roce_init_qp_table(struct hns_roce_dev *hr_dev);
 int hns_roce_init_srq_table(struct hns_roce_dev *hr_dev);
 int hns_roce_init_xrcd_table(struct hns_roce_dev *hr_dev);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 6c6e82b..0ca0634 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -771,11 +771,7 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 
 	hns_roce_init_cq_table(hr_dev);
 
-	ret = hns_roce_init_qp_table(hr_dev);
-	if (ret) {
-		dev_err(dev, "Failed to init queue pair table.\n");
-		goto err_cq_table_free;
-	}
+	hns_roce_init_qp_table(hr_dev);
 
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SRQ) {
 		ret = hns_roce_init_srq_table(hr_dev);
@@ -790,8 +786,6 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 
 err_qp_table_free:
 	hns_roce_cleanup_qp_table(hr_dev);
-
-err_cq_table_free:
 	hns_roce_cleanup_cq_table(hr_dev);
 	hns_roce_cleanup_mr_table(hr_dev);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 17b6ce2..5196369 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1414,7 +1414,7 @@ bool hns_roce_wq_overflow(struct hns_roce_wq *hr_wq, u32 nreq,
 	return cur + nreq >= hr_wq->wqe_cnt;
 }
 
-int hns_roce_init_qp_table(struct hns_roce_dev *hr_dev)
+void hns_roce_init_qp_table(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_qp_table *qp_table = &hr_dev->qp_table;
 	unsigned int reserved_from_bot;
@@ -1437,8 +1437,6 @@ int hns_roce_init_qp_table(struct hns_roce_dev *hr_dev)
 					       HNS_ROCE_QP_BANK_NUM - 1;
 		hr_dev->qp_table.bank[i].next = hr_dev->qp_table.bank[i].min;
 	}
-
-	return 0;
 }
 
 void hns_roce_cleanup_qp_table(struct hns_roce_dev *hr_dev)
-- 
2.7.4

