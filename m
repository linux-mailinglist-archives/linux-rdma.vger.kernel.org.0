Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60E2A5DCB8
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 05:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfGCDD5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jul 2019 23:03:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8689 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727049AbfGCDD5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 2 Jul 2019 23:03:57 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CE8CBFC842A631321067;
        Wed,  3 Jul 2019 11:03:54 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Wed, 3 Jul 2019 11:03:48 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-rdma@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] RDMA/hns: Remove set but not used variable 'fclr_write_fail_flag'
Date:   Wed, 3 Jul 2019 03:10:21 +0000
Message-ID: <20190703031021.14896-1-yuehaibing@huawei.com>
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

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/infiniband/hw/hns/hns_roce_hw_v2.c: In function 'hns_roce_function_clear':
drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1135:7: warning:
 variable 'fclr_write_fail_flag' set but not used [-Wunused-but-set-variable]

It is never used, so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index edd62b4dc0a0..edaf900b739c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1132,7 +1132,6 @@ static int hns_roce_cmq_query_hw_info(struct hns_roce_dev *hr_dev)
 
 static void hns_roce_function_clear(struct hns_roce_dev *hr_dev)
 {
-	bool fclr_write_fail_flag = false;
 	struct hns_roce_func_clear *resp;
 	struct hns_roce_cmq_desc desc;
 	unsigned long end;
@@ -1143,7 +1142,6 @@ static void hns_roce_function_clear(struct hns_roce_dev *hr_dev)
 
 	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
 	if (ret) {
-		fclr_write_fail_flag = true;
 		dev_err(hr_dev->dev, "Func clear write failed, ret = %d.\n",
 			 ret);
 		return;



