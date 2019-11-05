Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A552FEFBA6
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 11:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387905AbfKEKnm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 05:43:42 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388605AbfKEKnm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Nov 2019 05:43:42 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2D50FF532E8505CEC26E;
        Tue,  5 Nov 2019 18:43:39 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Tue, 5 Nov 2019 18:43:28 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 3/9] {topost} RDMA/hns: Delete unnecessary uar from hns_roce_cq
Date:   Tue, 5 Nov 2019 18:39:48 +0800
Message-ID: <1572950394-42910-4-git-send-email-liweihang@hisilicon.com>
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

From: Yixian Liu <liuyixian@huawei.com>

The uar information is already recorded in priv_uar of hns_roce_dev,
there is no need to record it in hns_roce_cq again.

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c     | 4 +---
 drivers/infiniband/hw/hns/hns_roce_device.h | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 22541d1..d1d7739 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -347,7 +347,6 @@ static int create_kernel_cq(struct hns_roce_dev *hr_dev,
 			    struct hns_roce_cq *hr_cq, int cq_entries)
 {
 	struct device *dev = hr_dev->dev;
-	struct hns_roce_uar *uar;
 	int ret;
 
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB) {
@@ -367,9 +366,8 @@ static int create_kernel_cq(struct hns_roce_dev *hr_dev,
 		goto err_db;
 	}
 
-	uar = &hr_dev->priv_uar;
 	hr_cq->cq_db_l = hr_dev->reg_base + hr_dev->odb_offset +
-			 DB_REG_OFFSET * uar->index;
+			 DB_REG_OFFSET * hr_dev->priv_uar.index;
 
 	return 0;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 3529e27..3800fea 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -496,7 +496,6 @@ struct hns_roce_cq {
 	void (*comp)(struct hns_roce_cq *cq);
 	void (*event)(struct hns_roce_cq *cq, enum hns_roce_event event_type);
 
-	struct hns_roce_uar		*uar;
 	u32				cq_depth;
 	u32				cons_index;
 	u32				*set_ci_db;
-- 
2.8.1

