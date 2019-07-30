Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 352E27A38C
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 11:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbfG3JA4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 05:00:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53844 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730144AbfG3JA4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jul 2019 05:00:56 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 757F7E1E986870529323;
        Tue, 30 Jul 2019 17:00:53 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Tue, 30 Jul 2019 17:00:44 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 01/13] RDMA/hns: Encapsulate some lines for setting sq size in user mode
Date:   Tue, 30 Jul 2019 16:56:38 +0800
Message-ID: <1564477010-29804-2-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1564477010-29804-1-git-send-email-oulijun@huawei.com>
References: <1564477010-29804-1-git-send-email-oulijun@huawei.com>
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
 drivers/infiniband/hw/hns/hns_roce_qp.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 9c272c2..35ef7e2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -324,16 +324,12 @@ static int hns_roce_set_rq_size(struct hns_roce_dev *hr_dev,
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
@@ -349,6 +345,25 @@ static int hns_roce_set_user_sq_size(struct hns_roce_dev *hr_dev,
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
+		dev_err(hr_dev->dev, "Sanity check sq size fail\n");
+		return ret;
+	}
+
 	hr_qp->sq.wqe_cnt = 1 << ucmd->log_sq_bb_count;
 	hr_qp->sq.wqe_shift = ucmd->log_sq_stride;
 
-- 
1.9.1

