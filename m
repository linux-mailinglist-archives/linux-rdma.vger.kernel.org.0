Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B94C26D5AE
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Sep 2020 10:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgIQIHa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Sep 2020 04:07:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13223 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726457AbgIQIH2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Sep 2020 04:07:28 -0400
X-Greylist: delayed 938 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 04:07:27 EDT
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3F2F88CBBAD0360DC0BF;
        Thu, 17 Sep 2020 15:51:29 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 15:51:21 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] RDMA/mlx5: fix type warning of sizeof in __mlx5_ib_alloc_counters()
Date:   Thu, 17 Sep 2020 16:13:54 +0800
Message-ID: <20200917081354.2083293-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

sizeof() when applied to a pointer typed expression should gives the
size of the pointed data, even if the data is a pointer.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/infiniband/hw/mlx5/counters.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
index 145f3cb40ccb..aeeb14ecb3ee 100644
--- a/drivers/infiniband/hw/mlx5/counters.c
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -456,12 +456,12 @@ static int __mlx5_ib_alloc_counters(struct mlx5_ib_dev *dev,
 		cnts->num_ext_ppcnt_counters = ARRAY_SIZE(ext_ppcnt_cnts);
 		num_counters += ARRAY_SIZE(ext_ppcnt_cnts);
 	}
-	cnts->names = kcalloc(num_counters, sizeof(cnts->names), GFP_KERNEL);
+	cnts->names = kcalloc(num_counters, sizeof(*cnts->names), GFP_KERNEL);
 	if (!cnts->names)
 		return -ENOMEM;
 
 	cnts->offsets = kcalloc(num_counters,
-				sizeof(cnts->offsets), GFP_KERNEL);
+				sizeof(*cnts->offsets), GFP_KERNEL);
 	if (!cnts->offsets)
 		goto err_names;
 
-- 
2.25.1

