Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E56567D2C7
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 03:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfHABWh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 21:22:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726622AbfHABWh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 21:22:37 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 65EA34DAA86A04A9AAFF;
        Thu,  1 Aug 2019 09:22:35 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Thu, 1 Aug 2019 09:22:26 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Colin Ian King" <colin.king@canonical.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-rdma@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH] RDMA/hns: Fix error return code in hns_roce_v1_rsv_lp_qp()
Date:   Thu, 1 Aug 2019 01:27:25 +0000
Message-ID: <20190801012725.150493-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix to return error code -ENOMEM from the rdma_zalloc_drv_obj() error
handling case instead of 0, as done elsewhere in this function.

Fixes: e8ac9389f0d7 ("RDMA: Fix allocation failure on pointer pd")
Fixes: 21a428a019c9 ("RDMA: Handle PD allocations by IB/core")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 70583f82e290..aa8a660ffcda 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -750,8 +750,10 @@ static int hns_roce_v1_rsv_lp_qp(struct hns_roce_dev *hr_dev)
 	atomic_set(&free_mr->mr_free_cq->ib_cq.usecnt, 0);
 
 	pd = rdma_zalloc_drv_obj(ibdev, ib_pd);
-	if (!pd)
+	if (!pd) {
+		ret = -ENOMEM;
 		goto alloc_mem_failed;
+	}
 
 	pd->device  = ibdev;
 	ret = hns_roce_alloc_pd(pd, NULL);



