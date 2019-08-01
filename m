Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C30D27D7B3
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 10:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfHAId0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 04:33:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41960 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729426AbfHAIdZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 04:33:25 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1A6DB271D930AADEC819;
        Thu,  1 Aug 2019 16:33:23 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Thu, 1 Aug 2019 16:33:12 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V2 for-next 01/13] RDMA/hns: Encapsulate some lines for setting sq size in user mode
Date:   Thu, 1 Aug 2019 16:29:02 +0800
Message-ID: <1564648154-123172-2-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1564648154-123172-1-git-send-email-oulijun@huawei.com>
References: <1564648154-123172-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It needs to check the sq size with integrity when configures
the relatived parameters of sq. Here moves the relatived code
into a special function.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
V1->V2:
1. Use the new print interface according to Gal Pressman because it
   can print the detail ib_device name
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 35 +++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 9c272c2..8abd1aa 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -324,31 +324,46 @@ static int hns_roce_set_rq_size(struct hns_roce_dev *hr_dev,
 	return 0;
 }
 
-static int hns_roce_set_user_sq_size(struct hns_roce_dev *hr_dev,
-				     struct ib_qp_cap *cap,
-				     struct hns_roce_qp *hr_qp,
-				     struct hns_roce_ib_create_qp *ucmd)
+static int check_sq_size_with_integrity(struct hns_roce_dev *hr_dev,
+					struct ib_qp_cap *cap,
+					struct hns_roce_ib_create_qp *ucmd)
 {
 	u32 roundup_sq_stride = roundup_pow_of_two(hr_dev->caps.max_sq_desc_sz);
 	u8 max_sq_stride = ilog2(roundup_sq_stride);
-	u32 ex_sge_num;
-	u32 page_size;
-	u32 max_cnt;
 
 	/* Sanity check SQ size before proceeding */
 	if ((u32)(1 << ucmd->log_sq_bb_count) > hr_dev->caps.max_wqes ||
 	     ucmd->log_sq_stride > max_sq_stride ||
 	     ucmd->log_sq_stride < HNS_ROCE_IB_MIN_SQ_STRIDE) {
-		dev_err(hr_dev->dev, "check SQ size error!\n");
+		ibdev_err(&hr_dev->ib_dev, "check SQ size error!\n");
 		return -EINVAL;
 	}
 
 	if (cap->max_send_sge > hr_dev->caps.max_sq_sg) {
-		dev_err(hr_dev->dev, "SQ sge error! max_send_sge=%d\n",
-			cap->max_send_sge);
+		ibdev_err(&hr_dev->ib_dev, "SQ sge error! max_send_sge=%d\n",
+			  cap->max_send_sge);
 		return -EINVAL;
 	}
 
+	return 0;
+}
+
+static int hns_roce_set_user_sq_size(struct hns_roce_dev *hr_dev,
+				     struct ib_qp_cap *cap,
+				     struct hns_roce_qp *hr_qp,
+				     struct hns_roce_ib_create_qp *ucmd)
+{
+	u32 ex_sge_num;
+	u32 page_size;
+	u32 max_cnt;
+	int ret;
+
+	ret = check_sq_size_with_integrity(hr_dev, cap, ucmd);
+	if (ret) {
+		ibdev_err(&hr_dev->ib_dev, "Sanity check sq size failed\n");
+		return ret;
+	}
+
 	hr_qp->sq.wqe_cnt = 1 << ucmd->log_sq_bb_count;
 	hr_qp->sq.wqe_shift = ucmd->log_sq_stride;
 
-- 
1.9.1

