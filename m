Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D91CEFBAB
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 11:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388654AbfKEKno (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 05:43:44 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5716 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388655AbfKEKnn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Nov 2019 05:43:43 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 34D5216C139B8043D23E;
        Tue,  5 Nov 2019 18:43:39 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Tue, 5 Nov 2019 18:43:29 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 6/9] {topost} RDMA/hns: Simplify doorbell initialization code
Date:   Tue, 5 Nov 2019 18:39:51 +0800
Message-ID: <1572950394-42910-7-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1572950394-42910-1-git-send-email-liweihang@hisilicon.com>
References: <1572950394-42910-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

If a variable needs to be set to 0 before use, it can be directly
initialized to 0.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 266d746d..f65bd7a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4944,10 +4944,7 @@ static void hns_roce_v2_init_irq_work(struct hns_roce_dev *hr_dev,
 static void set_eq_cons_index_v2(struct hns_roce_eq *eq)
 {
 	struct hns_roce_dev *hr_dev = eq->hr_dev;
-	__le32 doorbell[2];
-
-	doorbell[0] = 0;
-	doorbell[1] = 0;
+	__le32 doorbell[2] = {};
 
 	if (eq->type_flag == HNS_ROCE_AEQ) {
 		roce_set_field(doorbell[0], HNS_ROCE_V2_EQ_DB_CMD_M,
-- 
2.8.1

