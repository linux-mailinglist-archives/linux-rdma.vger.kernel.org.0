Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84BA77D7BA
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 10:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbfHAId3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 04:33:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42110 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730280AbfHAId3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 04:33:29 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 396A8CA30EDC09BB2526;
        Thu,  1 Aug 2019 16:33:23 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Thu, 1 Aug 2019 16:33:14 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V2 for-next 08/13] RDMA/hns: Split bool statement and assign statement
Date:   Thu, 1 Aug 2019 16:29:09 +0800
Message-ID: <1564648154-123172-9-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1564648154-123172-1-git-send-email-oulijun@huawei.com>
References: <1564648154-123172-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Assign statement can not be contained in bool statement or
function param.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 6dcb3ac..05b906f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4938,7 +4938,7 @@ static int hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 			       struct hns_roce_eq *eq)
 {
 	struct device *dev = hr_dev->dev;
-	struct hns_roce_aeqe *aeqe;
+	struct hns_roce_aeqe *aeqe = next_aeqe_sw_v2(eq);
 	int aeqe_found = 0;
 	int event_type;
 	int sub_type;
@@ -4946,8 +4946,7 @@ static int hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 	u32 qpn;
 	u32 cqn;
 
-	while ((aeqe = next_aeqe_sw_v2(eq))) {
-
+	while (aeqe) {
 		/* Make sure we read AEQ entry after we have checked the
 		 * ownership bit
 		 */
@@ -5016,6 +5015,8 @@ static int hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 			eq->cons_index = 0;
 		}
 		hns_roce_v2_init_irq_work(hr_dev, eq, qpn, cqn);
+
+		aeqe = next_aeqe_sw_v2(eq);
 	}
 
 	set_eq_cons_index_v2(eq);
@@ -5068,12 +5069,11 @@ static int hns_roce_v2_ceq_int(struct hns_roce_dev *hr_dev,
 			       struct hns_roce_eq *eq)
 {
 	struct device *dev = hr_dev->dev;
-	struct hns_roce_ceqe *ceqe;
+	struct hns_roce_ceqe *ceqe = next_ceqe_sw_v2(eq);
 	int ceqe_found = 0;
 	u32 cqn;
 
-	while ((ceqe = next_ceqe_sw_v2(eq))) {
-
+	while (ceqe) {
 		/* Make sure we read CEQ entry after we have checked the
 		 * ownership bit
 		 */
@@ -5092,6 +5092,8 @@ static int hns_roce_v2_ceq_int(struct hns_roce_dev *hr_dev,
 			dev_warn(dev, "cons_index overflow, set back to 0.\n");
 			eq->cons_index = 0;
 		}
+
+		ceqe = next_ceqe_sw_v2(eq);
 	}
 
 	set_eq_cons_index_v2(eq);
-- 
1.9.1

