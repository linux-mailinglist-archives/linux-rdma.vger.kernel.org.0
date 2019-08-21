Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F36D997A86
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 15:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbfHUNR5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 09:17:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38356 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728219AbfHUNR4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 09:17:56 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EA9CC55BEA2CE946CF95;
        Wed, 21 Aug 2019 21:17:53 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Wed, 21 Aug 2019 21:17:46 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 4/9] RDMA/hns: Remove the some magic number
Date:   Wed, 21 Aug 2019 21:14:31 +0800
Message-ID: <1566393276-42555-5-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1566393276-42555-1-git-send-email-oulijun@huawei.com>
References: <1566393276-42555-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here uses the meaningful macro instead of the magic number
for readability.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Lang Chen <chenglang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 5 +++++
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  | 3 ++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 4 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 3 ++-
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 011e038..5eb7134 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -127,6 +127,11 @@
 #define HNS_ROCE_IDX_QUE_ENTRY_SZ		4
 #define SRQ_DB_REG				0x230
 
+/* The chip implementation of the consumer index is calculated
+ * according to twice the actual EQ depth
+ */
+#define EQ_DEPTH_COEFF				2
+
 enum {
 	HNS_ROCE_SUPPORT_RQ_RECORD_DB = 1 << 0,
 	HNS_ROCE_SUPPORT_SQ_RECORD_DB = 1 << 1,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index d5be11a..73d17a3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -4016,7 +4016,8 @@ static int hns_roce_v1_ceq_int(struct hns_roce_dev *hr_dev,
 		++eq->cons_index;
 		ceqes_found = 1;
 
-		if (eq->cons_index > 2 * hr_dev->caps.ceqe_depth - 1) {
+		if (eq->cons_index >
+		    EQ_DEPTH_COEFF * hr_dev->caps.ceqe_depth - 1) {
 			dev_warn(&eq->hr_dev->pdev->dev,
 				"cons_index overflow, set back to 0.\n");
 			eq->cons_index = 0;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 67e56b8..d4c4c41 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5084,7 +5084,7 @@ static int hns_roce_v2_ceq_int(struct hns_roce_dev *hr_dev,
 		++eq->cons_index;
 		ceqe_found = 1;
 
-		if (eq->cons_index > (2 * eq->entries - 1)) {
+		if (eq->cons_index > (EQ_DEPTH_COEFF * eq->entries - 1)) {
 			dev_warn(dev, "cons_index overflow, set back to 0.\n");
 			eq->cons_index = 0;
 		}
@@ -6501,7 +6501,7 @@ static int hns_roce_hw_v2_reset_notify_uninit(struct hnae3_handle *handle)
 
 	handle->rinfo.reset_state = HNS_ROCE_STATE_RST_UNINIT;
 	dev_info(&handle->pdev->dev, "In reset process RoCE client uninit.\n");
-	msleep(100);
+	msleep(HNS_ROCE_V2_HW_RST_UNINT_DELAY);
 	__hns_roce_hw_v2_uninit_instance(handle, false);
 
 	return 0;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 58931b5..1301629 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -96,7 +96,8 @@
 #define HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE	2
 #define HNS_ROCE_V2_RSV_QPS			8
 
-#define HNS_ROCE_V2_HW_RST_TIMEOUT             1000
+#define HNS_ROCE_V2_HW_RST_TIMEOUT		1000
+#define HNS_ROCE_V2_HW_RST_UNINT_DELAY		100
 
 #define HNS_ROCE_CONTEXT_HOP_NUM		1
 #define HNS_ROCE_SCCC_HOP_NUM			1
-- 
2.8.1

