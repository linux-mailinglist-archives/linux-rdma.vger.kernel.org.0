Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD51322A71
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Feb 2021 13:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbhBWMXg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Feb 2021 07:23:36 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12991 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbhBWMXf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Feb 2021 07:23:35 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DlJ7C0yKVzjQVY;
        Tue, 23 Feb 2021 20:21:11 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Feb 2021 20:22:43 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next] RDMA/hns: Use new SQ doorbell register for HIP09
Date:   Tue, 23 Feb 2021 20:20:33 +0800
Message-ID: <1614082833-23130-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

HIP09 uses new address space to map SQ doorbell registers, the doorbell of
each QP is isolated based on the size of 64KB, which can improve the
performance in concurrency scenarios.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  3 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c    | 49 ++++++++++++++++--------------
 2 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index c3934ab..18394e5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -681,8 +681,7 @@ static void write_dwqe(struct hns_roce_dev *hr_dev, struct hns_roce_qp *qp,
 	roce_set_field(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_WQE_INDEX_M,
 		       V2_RC_SEND_WQE_BYTE_4_WQE_INDEX_S, qp->sq.head);
 
-	hns_roce_write512(hr_dev, wqe, hr_dev->mem_base +
-			  HNS_ROCE_DWQE_SIZE * qp->ibqp.qp_num);
+	hns_roce_write512(hr_dev, wqe, qp->sq.db_reg_l);
 }
 
 static int hns_roce_v2_post_send(struct ib_qp *ibqp,
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 8af411f..2318e3e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -840,9 +840,14 @@ static int alloc_qp_db(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 			resp->cap_flags |= HNS_ROCE_QP_CAP_RQ_RECORD_DB;
 		}
 	} else {
-		/* QP doorbell register address */
-		hr_qp->sq.db_reg_l = hr_dev->reg_base + hr_dev->sdb_offset +
-				     DB_REG_OFFSET * hr_dev->priv_uar.index;
+		if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
+			hr_qp->sq.db_reg_l = hr_dev->mem_base +
+					     HNS_ROCE_DWQE_SIZE * hr_qp->qpn;
+		else
+			hr_qp->sq.db_reg_l =
+				hr_dev->reg_base + hr_dev->sdb_offset +
+				DB_REG_OFFSET * hr_dev->priv_uar.index;
+
 		hr_qp->rq.db_reg_l = hr_dev->reg_base + hr_dev->odb_offset +
 				     DB_REG_OFFSET * hr_dev->priv_uar.index;
 
@@ -1011,36 +1016,36 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		}
 	}
 
-	ret = alloc_qp_db(hr_dev, hr_qp, init_attr, udata, &ucmd, &resp);
-	if (ret) {
-		ibdev_err(ibdev, "failed to alloc QP doorbell, ret = %d.\n",
-			  ret);
-		goto err_wrid;
-	}
-
 	ret = alloc_qp_buf(hr_dev, hr_qp, init_attr, udata, ucmd.buf_addr);
 	if (ret) {
 		ibdev_err(ibdev, "failed to alloc QP buffer, ret = %d.\n", ret);
-		goto err_db;
+		goto err_buf;
 	}
 
 	ret = alloc_qpn(hr_dev, hr_qp);
 	if (ret) {
 		ibdev_err(ibdev, "failed to alloc QPN, ret = %d.\n", ret);
-		goto err_buf;
+		goto err_qpn;
+	}
+
+	ret = alloc_qp_db(hr_dev, hr_qp, init_attr, udata, &ucmd, &resp);
+	if (ret) {
+		ibdev_err(ibdev, "failed to alloc QP doorbell, ret = %d.\n",
+			  ret);
+		goto err_db;
 	}
 
 	ret = alloc_qpc(hr_dev, hr_qp);
 	if (ret) {
 		ibdev_err(ibdev, "failed to alloc QP context, ret = %d.\n",
 			  ret);
-		goto err_qpn;
+		goto err_qpc;
 	}
 
 	ret = hns_roce_qp_store(hr_dev, hr_qp, init_attr);
 	if (ret) {
 		ibdev_err(ibdev, "failed to store QP, ret = %d.\n", ret);
-		goto err_qpc;
+		goto err_store;
 	}
 
 	if (udata) {
@@ -1055,7 +1060,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL) {
 		ret = hr_dev->hw->qp_flow_control_init(hr_dev, hr_qp);
 		if (ret)
-			goto err_store;
+			goto err_flow_ctrl;
 	}
 
 	hr_qp->ibqp.qp_num = hr_qp->qpn;
@@ -1065,17 +1070,17 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 
 	return 0;
 
-err_store:
+err_flow_ctrl:
 	hns_roce_qp_remove(hr_dev, hr_qp);
-err_qpc:
+err_store:
 	free_qpc(hr_dev, hr_qp);
-err_qpn:
+err_qpc:
+	free_qp_db(hr_dev, hr_qp, udata);
+err_db:
 	free_qpn(hr_dev, hr_qp);
-err_buf:
+err_qpn:
 	free_qp_buf(hr_dev, hr_qp);
-err_db:
-	free_qp_db(hr_dev, hr_qp, udata);
-err_wrid:
+err_buf:
 	free_kernel_wrid(hr_qp);
 	return ret;
 }
-- 
2.8.1

