Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2711E2CEC61
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Dec 2020 11:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgLDKnK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Dec 2020 05:43:10 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8689 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgLDKnK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Dec 2020 05:43:10 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CnTlz67Zgzkkhc;
        Fri,  4 Dec 2020 18:41:51 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Dec 2020 18:42:18 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 02/11] RDMA/hns: Normalization the judgment of some features
Date:   Fri, 4 Dec 2020 18:40:27 +0800
Message-ID: <1607078436-26455-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1607078436-26455-1-git-send-email-liweihang@huawei.com>
References: <1607078436-26455-1-git-send-email-liweihang@huawei.com>
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
index cab95fd..9ca4892 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -607,7 +607,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 		goto err_unmap_trrl;
 	}
 
-	if (hr_dev->caps.srqc_entry_sz) {
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SRQ) {
 		ret = hns_roce_init_hem_table(hr_dev, &hr_dev->srq_table.table,
 					      HEM_TYPE_SRQC,
 					      hr_dev->caps.srqc_entry_sz,
@@ -619,7 +619,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 		}
 	}
 
-	if (hr_dev->caps.sccc_sz) {
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL) {
 		ret = hns_roce_init_hem_table(hr_dev,
 					      &hr_dev->qp_table.sccc_table,
 					      HEM_TYPE_SCCC,
@@ -680,11 +680,11 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
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
index ebf152f..0e784c5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -335,7 +335,7 @@ static int alloc_qpc(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 		}
 	}
 
-	if (hr_dev->caps.sccc_sz) {
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL) {
 		/* Alloc memory for SCC CTX */
 		ret = hns_roce_table_get(hr_dev, &qp_table->sccc_table,
 					 hr_qp->qpn);
-- 
2.8.1

