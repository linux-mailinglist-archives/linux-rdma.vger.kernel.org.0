Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9E0EFBA7
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 11:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388632AbfKEKnm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 05:43:42 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5708 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388203AbfKEKnm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Nov 2019 05:43:42 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 19EBB53F40BDBA51B0F1;
        Tue,  5 Nov 2019 18:43:39 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Tue, 5 Nov 2019 18:43:30 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 7/9] {topost} RDMA/hns: Modify hns_roce_hw_v2_get_cfg to simplify the code
Date:   Tue, 5 Nov 2019 18:39:52 +0800
Message-ID: <1572950394-42910-8-git-send-email-liweihang@hisilicon.com>
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

Merge base configuration of hr_dev into hns_roce_hw_v2_get_cfg(). In
addition, there is no need to return 0 at last, so we change return
type of it to void.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index f65bd7a..fdc0cd6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6370,12 +6370,14 @@ static const struct pci_device_id hns_roce_hw_v2_pci_tbl[] = {
 
 MODULE_DEVICE_TABLE(pci, hns_roce_hw_v2_pci_tbl);
 
-static int hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
+static void hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
 				  struct hnae3_handle *handle)
 {
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	int i;
 
+	hr_dev->pci_dev = handle->pdev;
+	hr_dev->dev = &handle->pdev->dev;
 	hr_dev->hw = &hns_roce_hw_v2;
 	hr_dev->dfx = &hns_roce_dfx_hw_v2;
 	hr_dev->sdb_offset = ROCEE_DB_SQ_L_0_REG;
@@ -6400,8 +6402,6 @@ static int hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
 
 	hr_dev->reset_cnt = handle->ae_algo->ops->ae_dev_reset_cnt(handle);
 	priv->handle = handle;
-
-	return 0;
 }
 
 static int __hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
@@ -6419,14 +6419,7 @@ static int __hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
 		goto error_failed_kzalloc;
 	}
 
-	hr_dev->pci_dev = handle->pdev;
-	hr_dev->dev = &handle->pdev->dev;
-
-	ret = hns_roce_hw_v2_get_cfg(hr_dev, handle);
-	if (ret) {
-		dev_err(hr_dev->dev, "Get Configuration failed!\n");
-		goto error_failed_get_cfg;
-	}
+	hns_roce_hw_v2_get_cfg(hr_dev, handle);
 
 	ret = hns_roce_init(hr_dev);
 	if (ret) {
-- 
2.8.1

