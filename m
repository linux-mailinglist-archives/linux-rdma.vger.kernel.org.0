Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F10C27BAC9
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 09:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbfGaHiP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 03:38:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725921AbfGaHiP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 03:38:15 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D6E559A7A884E45F7D12;
        Wed, 31 Jul 2019 15:38:12 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Wed, 31 Jul 2019
 15:38:06 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <oulijun@huawei.com>, <xavier.huwei@huawei.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] RDMA/hns: remove set but not used variable 'irq_num'
Date:   Wed, 31 Jul 2019 15:37:48 +0800
Message-ID: <20190731073748.17664-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/infiniband/hw/hns/hns_roce_hw_v2.c: In function hns_roce_v2_cleanup_eq_table:
drivers/infiniband/hw/hns/hns_roce_hw_v2.c:5920:6:
 warning: variable irq_num set but not used [-Wunused-but-set-variable]

It is not used since
commit 33db6f94847c ("RDMA/hns: Refactor eq table init for hip08")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 83c58be..59f88bf0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5917,12 +5917,10 @@ static int hns_roce_v2_init_eq_table(struct hns_roce_dev *hr_dev)
 static void hns_roce_v2_cleanup_eq_table(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_eq_table *eq_table = &hr_dev->eq_table;
-	int irq_num;
 	int eq_num;
 	int i;
 
 	eq_num = hr_dev->caps.num_comp_vectors + hr_dev->caps.num_aeq_vectors;
-	irq_num = eq_num + hr_dev->caps.num_other_vectors;
 
 	/* Disable irq */
 	hns_roce_v2_int_mask_enable(hr_dev, eq_num, EQ_DISABLE);
-- 
2.7.4


