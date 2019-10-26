Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A67EDE58EC
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Oct 2019 09:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfJZHAP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 26 Oct 2019 03:00:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56886 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbfJZHAP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 26 Oct 2019 03:00:15 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D1EA58DD75C91D30EB9D;
        Sat, 26 Oct 2019 15:00:12 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Sat, 26 Oct 2019 15:00:05 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-rc 2/2] RDMA/hns: Prevent memory leaks about eq
Date:   Sat, 26 Oct 2019 14:56:35 +0800
Message-ID: <1572072995-11277-3-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1572072995-11277-1-git-send-email-liweihang@hisilicon.com>
References: <1572072995-11277-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

eq->buf_list->buf and eq->buf_list should also be freed when eqe_hop_num
is set to 0, or there will be memory leaks.

Fixes: a5073d6054f7 ("RDMA/hns: Add eq support of hip08")
Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 7a89d66..e82567f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5389,9 +5389,9 @@ static void hns_roce_v2_free_eq(struct hns_roce_dev *hr_dev,
 		return;
 	}
 
-	if (eq->buf_list)
-		dma_free_coherent(hr_dev->dev, buf_chk_sz,
-				  eq->buf_list->buf, eq->buf_list->map);
+	dma_free_coherent(hr_dev->dev, buf_chk_sz, eq->buf_list->buf,
+			  eq->buf_list->map);
+	kfree(eq->buf_list);
 }
 
 static void hns_roce_config_eqc(struct hns_roce_dev *hr_dev,
-- 
2.8.1

