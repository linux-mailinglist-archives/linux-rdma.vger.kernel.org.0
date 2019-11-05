Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C92A1EFC28
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 12:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388636AbfKELLt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 06:11:49 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5724 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388734AbfKELLs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Nov 2019 06:11:48 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8AD8CEE6EF40B63FA101;
        Tue,  5 Nov 2019 19:11:44 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Tue, 5 Nov 2019 19:11:37 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 2/9] RDMA/hns: Remove unnecessary structure hns_roce_sqp
Date:   Tue, 5 Nov 2019 19:07:55 +0800
Message-ID: <1572952082-6681-3-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1572952082-6681-1-git-send-email-liweihang@hisilicon.com>
References: <1572952082-6681-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Special QP have no differences with normal qp in data structure, so
definition of struct hns_roce_sqp should be removed and replaced by
struct hns_roce_qp.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 9 ---------
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  | 5 +----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 5 +----
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 8 +++-----
 4 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 3ed6b9e..3529e27 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -694,10 +694,6 @@ struct hns_roce_qp {
 	struct hns_roce_rinl_buf rq_inl_buf;
 };
 
-struct hns_roce_sqp {
-	struct hns_roce_qp	hr_qp;
-};
-
 struct hns_roce_ib_iboe {
 	spinlock_t		lock;
 	struct net_device      *netdevs[HNS_ROCE_MAX_PORTS];
@@ -1091,11 +1087,6 @@ static inline struct hns_roce_srq *to_hr_srq(struct ib_srq *ibsrq)
 	return container_of(ibsrq, struct hns_roce_srq, ibsrq);
 }
 
-static inline struct hns_roce_sqp *hr_to_hr_sqp(struct hns_roce_qp *hr_qp)
-{
-	return container_of(hr_qp, struct hns_roce_sqp, hr_qp);
-}
-
 static inline void hns_roce_write64_k(__le32 val[2], void __iomem *dest)
 {
 	__raw_writeq(*(u64 *) val, dest);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 5f74bf5..bfe9cee 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -3644,10 +3644,7 @@ int hns_roce_v1_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 		hns_roce_buf_free(hr_dev, hr_qp->buff_size, &hr_qp->hr_buf);
 	}
 
-	if (hr_qp->ibqp.qp_type == IB_QPT_RC)
-		kfree(hr_qp);
-	else
-		kfree(hr_to_hr_sqp(hr_qp));
+	kfree(hr_qp);
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 14e24b4..9b6b046 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4727,10 +4727,7 @@ static int hns_roce_v2_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 		ibdev_err(&hr_dev->ib_dev, "Destroy qp 0x%06lx failed(%d)\n",
 			  hr_qp->qpn, ret);
 
-	if (hr_qp->ibqp.qp_type == IB_QPT_GSI)
-		kfree(hr_to_hr_sqp(hr_qp));
-	else
-		kfree(hr_qp);
+	kfree(hr_qp);
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 071e9bc..ecfa875 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1017,7 +1017,6 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(pd->device);
 	struct ib_device *ibdev = &hr_dev->ib_dev;
-	struct hns_roce_sqp *hr_sqp;
 	struct hns_roce_qp *hr_qp;
 	int ret;
 
@@ -1047,11 +1046,10 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 			return ERR_PTR(-EINVAL);
 		}
 
-		hr_sqp = kzalloc(sizeof(*hr_sqp), GFP_KERNEL);
-		if (!hr_sqp)
+		hr_qp = kzalloc(sizeof(*hr_qp), GFP_KERNEL);
+		if (!hr_qp)
 			return ERR_PTR(-ENOMEM);
 
-		hr_qp = &hr_sqp->hr_qp;
 		hr_qp->port = init_attr->port_num - 1;
 		hr_qp->phy_port = hr_dev->iboe.phy_port[hr_qp->port];
 
@@ -1066,7 +1064,7 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 						hr_qp->ibqp.qp_num, hr_qp);
 		if (ret) {
 			ibdev_err(ibdev, "Create GSI QP failed!\n");
-			kfree(hr_sqp);
+			kfree(hr_qp);
 			return ERR_PTR(ret);
 		}
 
-- 
2.8.1

