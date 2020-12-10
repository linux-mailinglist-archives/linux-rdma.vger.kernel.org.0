Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5248F2D5BA9
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Dec 2020 14:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389222AbgLJNZa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Dec 2020 08:25:30 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9582 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389230AbgLJNZ3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Dec 2020 08:25:29 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CsF4L4rqjzM32l;
        Thu, 10 Dec 2020 21:24:02 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Dec 2020 21:24:37 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v3 for-next 02/11] RDMA/hns: Normalization the judgment of some features
Date:   Thu, 10 Dec 2020 21:22:43 +0800
Message-ID: <1607606572-11968-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1607606572-11968-1-git-send-email-liweihang@huawei.com>
References: <1607606572-11968-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

Whether to enable the these features should better depend on the enable
flags, not the value of related fields.

Fixes: 5c1f167af112 ("RDMA/hns: Init SRQ table for hip08")
Fixes: 3cb2c996c9dc ("RDMA/hns: Add support for SCCC in size of 64 Bytes")
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c  | 4 ++--
 drivers/infiniband/hw/hns/hns_roce_main.c | 8 ++++----
 drivers/infiniband/hw/hns/hns_roce_qp.c   | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index 5c302ae..359e5dd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -1028,7 +1028,7 @@ void hns_roce_cleanup_hem_table(struct hns_roce_dev *hr_dev,
 
 void hns_roce_cleanup_hem(struct hns_roce_dev *hr_dev)
 {
-	if (hr_dev->caps.srqc_entry_sz)
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SRQ)
 		hns_roce_cleanup_hem_table(hr_dev,
 					   &hr_dev->srq_table.table);
 	hns_roce_cleanup_hem_table(hr_dev, &hr_dev->cq_table.table);
@@ -1038,7 +1038,7 @@ void hns_roce_cleanup_hem(struct hns_roce_dev *hr_dev)
 	if (hr_dev->caps.cqc_timer_entry_sz)
 		hns_roce_cleanup_hem_table(hr_dev,
 					   &hr_dev->cqc_timer_table);
-	if (hr_dev->caps.sccc_sz)
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL)
 		hns_roce_cleanup_hem_table(hr_dev,
 					   &hr_dev->qp_table.sccc_table);
 	if (hr_dev->caps.trrl_entry_sz)
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index bc46624..dbb1af1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -606,7 +606,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 		goto err_unmap_trrl;
 	}
 
-	if (hr_dev->caps.srqc_entry_sz) {
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SRQ) {
 		ret = hns_roce_init_hem_table(hr_dev, &hr_dev->srq_table.table,
 					      HEM_TYPE_SRQC,
 					      hr_dev->caps.srqc_entry_sz,
@@ -618,7 +618,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 		}
 	}
 
-	if (hr_dev->caps.sccc_sz) {
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL) {
 		ret = hns_roce_init_hem_table(hr_dev,
 					      &hr_dev->qp_table.sccc_table,
 					      HEM_TYPE_SCCC,
@@ -679,11 +679,11 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 		hns_roce_cleanup_hem_table(hr_dev, &hr_dev->qpc_timer_table);
 
 err_unmap_ctx:
-	if (hr_dev->caps.sccc_sz)
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL)
 		hns_roce_cleanup_hem_table(hr_dev,
 					   &hr_dev->qp_table.sccc_table);
 err_unmap_srq:
-	if (hr_dev->caps.srqc_entry_sz)
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SRQ)
 		hns_roce_cleanup_hem_table(hr_dev, &hr_dev->srq_table.table);
 
 err_unmap_cq:
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index c85513d..76a7c95 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -334,7 +334,7 @@ static int alloc_qpc(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 		}
 	}
 
-	if (hr_dev->caps.sccc_sz) {
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL) {
 		/* Alloc memory for SCC CTX */
 		ret = hns_roce_table_get(hr_dev, &qp_table->sccc_table,
 					 hr_qp->qpn);
-- 
2.8.1

