Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58503864EE
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2019 16:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733153AbfHHO6U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Aug 2019 10:58:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50788 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728120AbfHHO6T (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Aug 2019 10:58:19 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 62AC587B3BF9282EF296;
        Thu,  8 Aug 2019 22:58:17 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Thu, 8 Aug 2019 22:58:07 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V4 for-next 12/14] RDMA/hns: Remove redundant print in hns_roce_v2_ceq_int()
Date:   Thu, 8 Aug 2019 22:53:52 +0800
Message-ID: <1565276034-97329-13-git-send-email-oulijun@huawei.com>
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

From: Weihang Li <liweihang@hisilicon.com>

There is no need to tell users when eq->cons_index is overflow, we
just set it back to zero.

Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index c7f1585..b949329 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5009,10 +5009,9 @@ static int hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 		++eq->cons_index;
 		aeqe_found = 1;
 
-		if (eq->cons_index > (2 * eq->entries - 1)) {
-			dev_warn(dev, "cons_index overflow, set back to 0.\n");
+		if (eq->cons_index > (2 * eq->entries - 1))
 			eq->cons_index = 0;
-		}
+
 		hns_roce_v2_init_irq_work(hr_dev, eq, qpn, cqn);
 
 		aeqe = next_aeqe_sw_v2(eq);
-- 
1.9.1

