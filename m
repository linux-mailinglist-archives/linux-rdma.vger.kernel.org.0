Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04722B42EA
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 12:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgKPLfN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 06:35:13 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7909 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729455AbgKPLfN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Nov 2020 06:35:13 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CZRnY1Fhmz6wqB;
        Mon, 16 Nov 2020 19:34:57 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Nov 2020 19:35:03 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 6/7] RDMA/hns: Add UD support for HIP09
Date:   Mon, 16 Nov 2020 19:33:27 +0800
Message-ID: <1605526408-6936-7-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1605526408-6936-1-git-send-email-liweihang@huawei.com>
References: <1605526408-6936-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

HIP09 supports service type of Unreliable Datagram, add necessary process
to enable this feature.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_ah.c    |  3 +++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  6 +++--
 drivers/infiniband/hw/hns/hns_roce_main.c  |  1 +
 drivers/infiniband/hw/hns/hns_roce_qp.c    | 39 ++++++++++++++++++++++--------
 4 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_ah.c b/drivers/infiniband/hw/hns/hns_roce_ah.c
index d65ff6a..b09ef33 100644
--- a/drivers/infiniband/hw/hns/hns_roce_ah.c
+++ b/drivers/infiniband/hw/hns/hns_roce_ah.c
@@ -64,6 +64,9 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	struct hns_roce_ah *ah = to_hr_ah(ibah);
 	int ret = 0;
 
+	if (hr_dev->pci_dev->revision <= PCI_REVISION_ID_HIP08 && udata)
+		return -EOPNOTSUPP;
+
 	ah->av.port = rdma_ah_get_port_num(ah_attr);
 	ah->av.gid_index = grh->sgid_index;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 273d968..57ff223 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -693,7 +693,7 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 		       ~(((qp->sq.head + nreq) >> ilog2(qp->sq.wqe_cnt)) & 0x1);
 
 		/* Corresponding to the QP type, wqe process separately */
-		if (ibqp->qp_type == IB_QPT_GSI)
+		if (ibqp->qp_type == IB_QPT_GSI || ibqp->qp_type == IB_QPT_UD)
 			ret = set_ud_wqe(qp, wr, wqe, &sge_idx, owner_bit);
 		else if (ibqp->qp_type == IB_QPT_RC)
 			ret = set_rc_wqe(qp, wr, wqe, &sge_idx, owner_bit);
@@ -5151,7 +5151,9 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 	unsigned long flags;
 	int ret = 0;
 
-	if (hr_qp->ibqp.qp_type == IB_QPT_RC && hr_qp->state != IB_QPS_RESET) {
+	if ((hr_qp->ibqp.qp_type == IB_QPT_RC ||
+	     hr_qp->ibqp.qp_type == IB_QPT_UD) &&
+	   hr_qp->state != IB_QPS_RESET) {
 		/* Modify qp to reset before destroying qp */
 		ret = hns_roce_v2_modify_qp(&hr_qp->ibqp, NULL, 0,
 					    hr_qp->state, IB_QPS_RESET);
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 97fdc55..f01590d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -424,6 +424,7 @@ static const struct ib_device_ops hns_roce_dev_ops = {
 	.alloc_pd = hns_roce_alloc_pd,
 	.alloc_ucontext = hns_roce_alloc_ucontext,
 	.create_ah = hns_roce_create_ah,
+	.create_user_ah = hns_roce_create_ah,
 	.create_cq = hns_roce_create_cq,
 	.create_qp = hns_roce_create_qp,
 	.dealloc_pd = hns_roce_dealloc_pd,
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index e288946..5e505a3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -998,6 +998,30 @@ void hns_roce_qp_destroy(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 	kfree(hr_qp);
 }
 
+static int check_qp_type(struct hns_roce_dev *hr_dev, enum ib_qp_type type,
+			 bool is_user)
+{
+	switch (type) {
+	case IB_QPT_UD:
+		if (hr_dev->pci_dev->revision <= PCI_REVISION_ID_HIP08 &&
+		    is_user)
+			goto out;
+		fallthrough;
+	case IB_QPT_RC:
+	case IB_QPT_GSI:
+		break;
+	default:
+		goto out;
+	}
+
+	return 0;
+
+out:
+	ibdev_err(&hr_dev->ib_dev, "not support QP type %d\n", type);
+
+	return -EOPNOTSUPP;
+}
+
 struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 				 struct ib_qp_init_attr *init_attr,
 				 struct ib_udata *udata)
@@ -1007,15 +1031,9 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 	struct hns_roce_qp *hr_qp;
 	int ret;
 
-	switch (init_attr->qp_type) {
-	case IB_QPT_RC:
-	case IB_QPT_GSI:
-		break;
-	default:
-		ibdev_err(ibdev, "not support QP type %d\n",
-			  init_attr->qp_type);
-		return ERR_PTR(-EOPNOTSUPP);
-	}
+	ret = check_qp_type(hr_dev, init_attr->qp_type, !!udata);
+	if (ret)
+		return ERR_PTR(ret);
 
 	hr_qp = kzalloc(sizeof(*hr_qp), GFP_KERNEL);
 	if (!hr_qp)
@@ -1030,10 +1048,11 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 	if (ret) {
 		ibdev_err(ibdev, "Create QP type 0x%x failed(%d)\n",
 			  init_attr->qp_type, ret);
-		ibdev_err(ibdev, "Create GSI QP failed!\n");
+
 		kfree(hr_qp);
 		return ERR_PTR(ret);
 	}
+
 	return &hr_qp->ibqp;
 }
 
-- 
2.8.1

