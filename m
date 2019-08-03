Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4299180569
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Aug 2019 10:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387812AbfHCIti (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 3 Aug 2019 04:49:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3751 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387818AbfHCItf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 3 Aug 2019 04:49:35 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B9056D9B7BD7879EC479;
        Sat,  3 Aug 2019 16:49:30 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Sat, 3 Aug 2019 16:49:22 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V3 for-next 07/13] RDMA/hns: Handling the error return value of hem function
Date:   Sat, 3 Aug 2019 16:45:13 +0800
Message-ID: <1564821919-100676-8-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1564821919-100676-1-git-send-email-oulijun@huawei.com>
References: <1564821919-100676-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Handling the error return value of hns_roce_calc_hem_mhop.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index d3e72a0..0268c7a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -830,7 +830,8 @@ void *hns_roce_table_find(struct hns_roce_dev *hr_dev,
 	} else {
 		u32 seg_size = 64; /* 8 bytes per BA and 8 BA per segment */
 
-		hns_roce_calc_hem_mhop(hr_dev, table, &mhop_obj, &mhop);
+		if (hns_roce_calc_hem_mhop(hr_dev, table, &mhop_obj, &mhop))
+			goto out;
 		/* mtt mhop */
 		i = mhop.l0_idx;
 		j = mhop.l1_idx;
@@ -879,11 +880,13 @@ int hns_roce_table_get_range(struct hns_roce_dev *hr_dev,
 {
 	struct hns_roce_hem_mhop mhop;
 	unsigned long inc = table->table_chunk_size / table->obj_size;
-	unsigned long i;
+	unsigned long i = 0;
 	int ret;
 
 	if (hns_roce_check_whether_mhop(hr_dev, table->type)) {
-		hns_roce_calc_hem_mhop(hr_dev, table, NULL, &mhop);
+		ret = hns_roce_calc_hem_mhop(hr_dev, table, NULL, &mhop);
+		if (ret)
+			goto fail;
 		inc = mhop.bt_chunk_size / table->obj_size;
 	}
 
@@ -913,7 +916,8 @@ void hns_roce_table_put_range(struct hns_roce_dev *hr_dev,
 	unsigned long i;
 
 	if (hns_roce_check_whether_mhop(hr_dev, table->type)) {
-		hns_roce_calc_hem_mhop(hr_dev, table, NULL, &mhop);
+		if (hns_roce_calc_hem_mhop(hr_dev, table, NULL, &mhop))
+			return;
 		inc = mhop.bt_chunk_size / table->obj_size;
 	}
 
@@ -1035,7 +1039,8 @@ static void hns_roce_cleanup_mhop_hem_table(struct hns_roce_dev *hr_dev,
 	int i;
 	u64 obj;
 
-	hns_roce_calc_hem_mhop(hr_dev, table, NULL, &mhop);
+	if (hns_roce_calc_hem_mhop(hr_dev, table, NULL, &mhop))
+		return;
 	buf_chunk_size = table->type < HEM_TYPE_MTT ? mhop.buf_chunk_size :
 					mhop.bt_chunk_size;
 
-- 
1.9.1

