Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9525E26D70B
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Sep 2020 10:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgIQIrz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Sep 2020 04:47:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12827 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726514AbgIQIrp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Sep 2020 04:47:45 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C4781274986FAFA513F5;
        Thu, 17 Sep 2020 16:47:42 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 16:47:36 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] RDMA/mlx5: fix type warning of sizeof in __mlx5_ib_alloc_counters()
Date:   Thu, 17 Sep 2020 17:10:08 +0800
Message-ID: <20200917091008.2309158-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200917082926.GA869610@unreal>
References: <20200917082926.GA869610@unreal>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

sizeof() when applied to a pointer typed expression should give the
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

