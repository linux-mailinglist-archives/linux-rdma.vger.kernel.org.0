Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFEB9864EC
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2019 16:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfHHO6T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Aug 2019 10:58:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50838 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733149AbfHHO6S (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Aug 2019 10:58:18 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 70D6F51533CC48E97B80;
        Thu,  8 Aug 2019 22:58:17 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Thu, 8 Aug 2019 22:58:06 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V4 for-next 08/14] RDMA/hns: Split bool statement and assign statement
Date:   Thu, 8 Aug 2019 22:53:48 +0800
Message-ID: <1565276034-97329-9-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565276034-97329-1-git-send-email-oulijun@huawei.com>
References: <1565276034-97329-1-git-send-email-oulijun@huawei.com>
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
index 9b037b3..4b9f839 100644
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

