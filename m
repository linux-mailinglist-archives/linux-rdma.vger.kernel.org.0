Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7B30169E9C
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 07:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgBXGl6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 01:41:58 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38010 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727170AbgBXGl5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Feb 2020 01:41:57 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 499E7C11C51B475D48B2;
        Mon, 24 Feb 2020 14:41:50 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Mon, 24 Feb 2020 14:41:42 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v4 for-next 3/7] RDMA/hns: Optimize qp number assign flow
Date:   Mon, 24 Feb 2020 14:37:34 +0800
Message-ID: <1582526258-13825-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1582526258-13825-1-git-send-email-liweihang@huawei.com>
References: <1582526258-13825-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Encapsulate the code associated with the qp number assignment into
alloc_qpn() and free_qpn().

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 91 ++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 47 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 396356a..8ec0ea96 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -156,15 +156,34 @@ static void hns_roce_ib_qp_event(struct hns_roce_qp *hr_qp,
 	}
 }
 
-static int hns_roce_reserve_range_qp(struct hns_roce_dev *hr_dev, int cnt,
-				     int align, unsigned long *base)
+static int alloc_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 {
-	struct hns_roce_qp_table *qp_table = &hr_dev->qp_table;
+	unsigned long num = 0;
+	int ret;
+
+	if (hr_qp->ibqp.qp_type == IB_QPT_GSI) {
+		/* when hw version is v1, the sqpn is allocated */
+		if (hr_dev->hw_rev == HNS_ROCE_HW_VER1)
+			num = HNS_ROCE_MAX_PORTS +
+			      hr_dev->iboe.phy_port[hr_qp->port];
+		else
+			num = 1;
+
+		hr_qp->doorbell_qpn = 1;
+	} else {
+		ret = hns_roce_bitmap_alloc_range(&hr_dev->qp_table.bitmap,
+						  1, 1, &num);
+		if (ret) {
+			ibdev_err(&hr_dev->ib_dev, "Failed to alloc bitmap\n");
+			return -ENOMEM;
+		}
+
+		hr_qp->doorbell_qpn = (u32)num;
+	}
+
+	hr_qp->qpn = num;
 
-	return hns_roce_bitmap_alloc_range(&qp_table->bitmap, cnt, align,
-					   base) ?
-		       -ENOMEM :
-		       0;
+	return 0;
 }
 
 enum hns_roce_qp_state to_hns_roce_state(enum ib_qp_state state)
@@ -323,15 +342,17 @@ static void free_qpc(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 	hns_roce_table_put(hr_dev, &qp_table->irrl_table, hr_qp->qpn);
 }
 
-void hns_roce_release_range_qp(struct hns_roce_dev *hr_dev, int base_qpn,
-			       int cnt)
+static void free_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 {
 	struct hns_roce_qp_table *qp_table = &hr_dev->qp_table;
 
-	if (base_qpn < hr_dev->caps.reserved_qps)
+	if (hr_qp->ibqp.qp_type == IB_QPT_GSI)
+		return;
+
+	if (hr_qp->qpn < hr_dev->caps.reserved_qps)
 		return;
 
-	hns_roce_bitmap_free_range(&qp_table->bitmap, base_qpn, cnt, BITMAP_RR);
+	hns_roce_bitmap_free_range(&qp_table->bitmap, hr_qp->qpn, 1, BITMAP_RR);
 }
 
 static int hns_roce_set_rq_size(struct hns_roce_dev *hr_dev,
@@ -749,7 +770,7 @@ static void free_rq_inline_buf(struct hns_roce_qp *hr_qp)
 static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 				     struct ib_pd *ib_pd,
 				     struct ib_qp_init_attr *init_attr,
-				     struct ib_udata *udata, unsigned long sqpn,
+				     struct ib_udata *udata,
 				     struct hns_roce_qp *hr_qp)
 {
 	dma_addr_t *buf_list[ARRAY_SIZE(hr_qp->regions)] = { NULL };
@@ -759,7 +780,6 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	struct hns_roce_ucontext *uctx = rdma_udata_to_drv_context(
 		udata, struct hns_roce_ucontext, ibucontext);
 	struct hns_roce_buf_region *r;
-	unsigned long qpn = 0;
 	u32 page_shift;
 	int buf_count;
 	int ret;
@@ -959,19 +979,6 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		}
 	}
 
-	if (sqpn) {
-		qpn = sqpn;
-	} else {
-		/* Get QPN */
-		ret = hns_roce_reserve_range_qp(hr_dev, 1, 1, &qpn);
-		if (ret) {
-			dev_err(dev, "hns_roce_reserve_range_qp alloc qpn error\n");
-			goto err_wrid;
-		}
-	}
-
-	hr_qp->qpn = qpn;
-
 	hr_qp->wqe_bt_pg_shift = calc_wqe_bt_page_shift(hr_dev, hr_qp->regions,
 							hr_qp->region_cnt);
 	hns_roce_mtr_init(&hr_qp->mtr, PAGE_SHIFT + hr_qp->wqe_bt_pg_shift,
@@ -980,6 +987,12 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 				  hr_qp->regions, hr_qp->region_cnt);
 	if (ret) {
 		dev_err(dev, "mtr attach error for create qp\n");
+		goto err_wrid;
+	}
+
+	ret = alloc_qpn(hr_dev, hr_qp);
+	if (ret) {
+		ibdev_err(&hr_dev->ib_dev, "Failed to alloc QPN\n");
 		goto err_mtr;
 	}
 
@@ -995,11 +1008,6 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		goto err_qpc;
 	}
 
-	if (sqpn)
-		hr_qp->doorbell_qpn = 1;
-	else
-		hr_qp->doorbell_qpn = (u32)hr_qp->qpn;
-
 	if (udata) {
 		ret = ib_copy_to_udata(udata, &resp,
 				       min(udata->outlen, sizeof(resp)));
@@ -1013,6 +1021,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 			goto err_store;
 	}
 
+	hr_qp->ibqp.qp_num = hr_qp->qpn;
 	hr_qp->event = hns_roce_ib_qp_event;
 	atomic_set(&hr_qp->refcount, 1);
 	init_completion(&hr_qp->free);
@@ -1028,8 +1037,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	free_qpc(hr_dev, hr_qp);
 
 err_qpn:
-	if (!sqpn)
-		hns_roce_release_range_qp(hr_dev, qpn, 1);
+	free_qpn(hr_dev, hr_qp);
 
 err_mtr:
 	hns_roce_mtr_cleanup(hr_dev, &hr_qp->mtr);
@@ -1088,9 +1096,7 @@ void hns_roce_qp_destroy(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 
 	free_qpc(hr_dev, hr_qp);
 
-	/* Not special_QP, free their QPN */
-	if (hr_qp->ibqp.qp_type != IB_QPT_GSI)
-		hns_roce_release_range_qp(hr_dev, hr_qp->qpn, 1);
+	free_qpn(hr_dev, hr_qp);
 
 	hns_roce_mtr_cleanup(hr_dev, &hr_qp->mtr);
 
@@ -1139,7 +1145,7 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 		if (!hr_qp)
 			return ERR_PTR(-ENOMEM);
 
-		ret = hns_roce_create_qp_common(hr_dev, pd, init_attr, udata, 0,
+		ret = hns_roce_create_qp_common(hr_dev, pd, init_attr, udata,
 						hr_qp);
 		if (ret) {
 			ibdev_err(ibdev, "Create QP 0x%06lx failed(%d)\n",
@@ -1148,8 +1154,6 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 			return ERR_PTR(ret);
 		}
 
-		hr_qp->ibqp.qp_num = hr_qp->qpn;
-
 		break;
 	}
 	case IB_QPT_GSI: {
@@ -1166,15 +1170,8 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 		hr_qp->port = init_attr->port_num - 1;
 		hr_qp->phy_port = hr_dev->iboe.phy_port[hr_qp->port];
 
-		/* when hw version is v1, the sqpn is allocated */
-		if (hr_dev->hw_rev == HNS_ROCE_HW_VER1)
-			hr_qp->ibqp.qp_num = HNS_ROCE_MAX_PORTS +
-					     hr_dev->iboe.phy_port[hr_qp->port];
-		else
-			hr_qp->ibqp.qp_num = 1;
-
 		ret = hns_roce_create_qp_common(hr_dev, pd, init_attr, udata,
-						hr_qp->ibqp.qp_num, hr_qp);
+						hr_qp);
 		if (ret) {
 			ibdev_err(ibdev, "Create GSI QP failed!\n");
 			kfree(hr_qp);
-- 
2.8.1

