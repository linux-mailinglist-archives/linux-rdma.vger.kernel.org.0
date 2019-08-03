Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1D0580560
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Aug 2019 10:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387822AbfHCItf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 3 Aug 2019 04:49:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3742 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727541AbfHCIte (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 3 Aug 2019 04:49:34 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 85E5E4A966F3ABF2DE83;
        Sat,  3 Aug 2019 16:49:30 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Sat, 3 Aug 2019 16:49:21 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V3 for-next 03/13] RDMA/hns: Update the prompt message for creating and destroy qp
Date:   Sat, 3 Aug 2019 16:45:09 +0800
Message-ID: <1564821919-100676-4-git-send-email-oulijun@huawei.com>
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

From: Yixian Liu <liuyixian@huawei.com>

Current prompt message is uncorrect when destroying qp, add qpn
information when creating qp.

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
V1->V2:
1. Use ibdev_err instead of dev_err
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  8 ++++----
 drivers/infiniband/hw/hns/hns_roce_qp.c    | 12 +++++++-----
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 83c58be..2769802 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4563,7 +4563,7 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 					 struct ib_udata *udata)
 {
 	struct hns_roce_cq *send_cq, *recv_cq;
-	struct device *dev = hr_dev->dev;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	int ret;
 
 	if (hr_qp->ibqp.qp_type == IB_QPT_RC && hr_qp->state != IB_QPS_RESET) {
@@ -4571,8 +4571,7 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 		ret = hns_roce_v2_modify_qp(&hr_qp->ibqp, NULL, 0,
 					    hr_qp->state, IB_QPS_RESET);
 		if (ret) {
-			dev_err(dev, "modify QP %06lx to ERR failed.\n",
-				hr_qp->qpn);
+			ibdev_err(ibdev, "modify QP to Reset failed.\n");
 			return ret;
 		}
 	}
@@ -4641,7 +4640,8 @@ static int hns_roce_v2_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 
 	ret = hns_roce_v2_destroy_qp_common(hr_dev, hr_qp, udata);
 	if (ret) {
-		dev_err(hr_dev->dev, "Destroy qp failed(%d)\n", ret);
+		ibdev_err(&hr_dev->ib_dev, "Destroy qp 0x%06lx failed(%d)\n",
+			  hr_qp->qpn, ret);
 		return ret;
 	}
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 2eb5b0a..b1ee729 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -988,7 +988,7 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 				 struct ib_udata *udata)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(pd->device);
-	struct device *dev = hr_dev->dev;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_sqp *hr_sqp;
 	struct hns_roce_qp *hr_qp;
 	int ret;
@@ -1002,7 +1002,8 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 		ret = hns_roce_create_qp_common(hr_dev, pd, init_attr, udata, 0,
 						hr_qp);
 		if (ret) {
-			dev_err(dev, "Create RC QP failed\n");
+			ibdev_err(ibdev, "Create RC QP 0x%06lx failed(%d)\n",
+				  hr_qp->qpn, ret);
 			kfree(hr_qp);
 			return ERR_PTR(ret);
 		}
@@ -1014,7 +1015,7 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 	case IB_QPT_GSI: {
 		/* Userspace is not allowed to create special QPs: */
 		if (udata) {
-			dev_err(dev, "not support usr space GSI\n");
+			ibdev_err(ibdev, "not support usr space GSI\n");
 			return ERR_PTR(-EINVAL);
 		}
 
@@ -1036,7 +1037,7 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 		ret = hns_roce_create_qp_common(hr_dev, pd, init_attr, udata,
 						hr_qp->ibqp.qp_num, hr_qp);
 		if (ret) {
-			dev_err(dev, "Create GSI QP failed!\n");
+			ibdev_err(ibdev, "Create GSI QP failed!\n");
 			kfree(hr_sqp);
 			return ERR_PTR(ret);
 		}
@@ -1044,7 +1045,8 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 		break;
 	}
 	default:{
-		dev_err(dev, "not support QP type %d\n", init_attr->qp_type);
+		ibdev_err(ibdev, "not support QP type %d\n",
+			  init_attr->qp_type);
 		return ERR_PTR(-EINVAL);
 	}
 	}
-- 
1.9.1

