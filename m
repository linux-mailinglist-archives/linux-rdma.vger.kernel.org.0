Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF0B9D0530
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2019 03:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfJIBZU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Oct 2019 21:25:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3277 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727051AbfJIBZU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Oct 2019 21:25:20 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0BD16F6C037AF9149F23;
        Wed,  9 Oct 2019 09:25:18 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Wed, 9 Oct 2019 09:25:11 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2 for-next] RDMA/hns: Release qp resources when failed to destroy qp
Date:   Wed, 9 Oct 2019 09:21:50 +0800
Message-ID: <1570584110-3659-1-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

Even if no response from hardware, we should make sure that qp related
resources are released to avoid memory leaks.

Fixes: 926a01dc000d ("RDMA/hns: Add QP operations support for hip08 SoC")

Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>

---
Changelog:
v1->v2: Add Fixes line.
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 5b2efc8..73070e2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5136,7 +5136,7 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 	struct hns_roce_cq *send_cq, *recv_cq;
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	unsigned long flags;
-	int ret;
+	int ret = 0;
 
 	if ((hr_qp->ibqp.qp_type == IB_QPT_RC ||
 	     hr_qp->ibqp.qp_type == IB_QPT_UD) &&
@@ -5144,10 +5144,8 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 		/* Modify qp to reset before destroying qp */
 		ret = hns_roce_v2_modify_qp(&hr_qp->ibqp, NULL, 0,
 					    hr_qp->state, IB_QPS_RESET);
-		if (ret) {
+		if (ret)
 			ibdev_err(ibdev, "modify QP to Reset failed.\n");
-			return ret;
-		}
 	}
 
 	send_cq = hr_qp->ibqp.send_cq ? to_hr_cq(hr_qp->ibqp.send_cq) : NULL;
@@ -5217,7 +5215,7 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 		kfree(hr_qp->rq_inl_buf.wqe_list);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int hns_roce_v2_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
@@ -5227,11 +5225,9 @@ static int hns_roce_v2_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	int ret;
 
 	ret = hns_roce_v2_destroy_qp_common(hr_dev, hr_qp, udata);
-	if (ret) {
+	if (ret)
 		ibdev_err(&hr_dev->ib_dev, "Destroy qp 0x%06lx failed(%d)\n",
 			  hr_qp->qpn, ret);
-		return ret;
-	}
 
 	if (hr_qp->ibqp.qp_type == IB_QPT_GSI)
 		kfree(hr_to_hr_sqp(hr_qp));
-- 
2.8.1

