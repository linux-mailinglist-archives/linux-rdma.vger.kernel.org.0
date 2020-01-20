Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 529721424FB
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2020 09:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgATIXj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jan 2020 03:23:39 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9208 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726650AbgATIXj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Jan 2020 03:23:39 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ECA8839547BECDF8E92E;
        Mon, 20 Jan 2020 16:23:36 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Mon, 20 Jan 2020 16:23:27 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 6/7] RDMA/hns: Optimize kernel qp wrid allocation flow
Date:   Mon, 20 Jan 2020 16:19:36 +0800
Message-ID: <1579508377-55818-7-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1579508377-55818-1-git-send-email-liweihang@huawei.com>
References: <1579508377-55818-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Encapsulate the kernel qp wrid allocation related code into 2 functions:
alloc_kernel_wrid() and free_kernel_wrid().

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 73 ++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index baa3f48..c51d4d4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -847,6 +847,45 @@ static void free_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 		free_rq_inline_buf(hr_qp);
 }
 
+static int alloc_kernel_wrid(struct hns_roce_dev *hr_dev,
+			     struct hns_roce_qp *hr_qp)
+{
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	u64 *sq_wrid = NULL;
+	u64 *rq_wrid = NULL;
+	int ret;
+
+	sq_wrid = kcalloc(hr_qp->sq.wqe_cnt, sizeof(u64), GFP_KERNEL);
+	if (ZERO_OR_NULL_PTR(sq_wrid)) {
+		ibdev_err(ibdev, "sq wrid alloc failed!\n");
+		return -ENOMEM;
+	}
+
+	if (hr_qp->rq.wqe_cnt) {
+		rq_wrid = kcalloc(hr_qp->rq.wqe_cnt, sizeof(u64), GFP_KERNEL);
+		if (ZERO_OR_NULL_PTR(rq_wrid)) {
+			ibdev_err(ibdev, "rq wrid alloc failed!\n");
+			ret = -ENOMEM;
+			goto err_sq;
+		}
+	}
+
+	hr_qp->sq.wrid = sq_wrid;
+	hr_qp->rq.wrid = rq_wrid;
+	return 0;
+err_sq:
+	kfree(sq_wrid);
+
+	return ret;
+}
+
+static void free_kernel_wrid(struct hns_roce_dev *hr_dev,
+			     struct hns_roce_qp *hr_qp)
+{
+	kfree(hr_qp->rq.wrid);
+	kfree(hr_qp->sq.wrid);
+}
+
 static int set_qp_param(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 			struct ib_qp_init_attr *init_attr,
 			struct ib_udata *udata,
@@ -972,21 +1011,11 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 			hr_qp->rdb_en = 1;
 		}
 
-		hr_qp->sq.wrid = kcalloc(hr_qp->sq.wqe_cnt, sizeof(u64),
-					 GFP_KERNEL);
-		if (ZERO_OR_NULL_PTR(hr_qp->sq.wrid)) {
-			ret = -ENOMEM;
+		ret = alloc_kernel_wrid(hr_dev, hr_qp);
+		if (ret) {
+			ibdev_err(&hr_dev->ib_dev, "alloc wrid error!\n");
 			goto err_db;
 		}
-
-		if (hr_qp->rq.wqe_cnt) {
-			hr_qp->rq.wrid = kcalloc(hr_qp->rq.wqe_cnt, sizeof(u64),
-						 GFP_KERNEL);
-			if (ZERO_OR_NULL_PTR(hr_qp->rq.wrid)) {
-				ret = -ENOMEM;
-				goto err_sq_wrid;
-			}
-		}
 	}
 
 	ret = alloc_qp_buf(hr_dev, hr_qp, init_attr, udata, ucmd.buf_addr);
@@ -1035,25 +1064,20 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 
 err_store:
 	hns_roce_qp_remove(hr_dev, hr_qp);
-
 err_qpc:
 	free_qpc(hr_dev, hr_qp);
-
 err_qpn:
 	free_qpn(hr_dev, hr_qp);
-
 err_buf:
 	free_qp_buf(hr_dev, hr_qp);
-
 err_wrid:
+	free_kernel_wrid(hr_dev, hr_qp);
+
 	if (udata) {
 		if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB) &&
 		    (udata->outlen >= sizeof(resp)) &&
 		    hns_roce_qp_has_rq(init_attr))
 			hns_roce_db_unmap_user(uctx, &hr_qp->rdb);
-	} else {
-		if (hr_qp->rq.wqe_cnt)
-			kfree(hr_qp->rq.wrid);
 	}
 
 err_sq_dbmap:
@@ -1064,10 +1088,6 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		    hns_roce_qp_has_sq(init_attr))
 			hns_roce_db_unmap_user(uctx, &hr_qp->sdb);
 
-err_sq_wrid:
-	if (!udata)
-		kfree(hr_qp->sq.wrid);
-
 err_db:
 	if (!udata && hns_roce_qp_has_rq(init_attr) &&
 	    (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB))
@@ -1085,10 +1105,9 @@ void hns_roce_qp_destroy(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 	wait_for_completion(&hr_qp->free);
 
 	free_qpc(hr_dev, hr_qp);
-
 	free_qpn(hr_dev, hr_qp);
-
 	free_qp_buf(hr_dev, hr_qp);
+	free_kernel_wrid(hr_dev, hr_qp);
 
 	if (udata) {
 		struct hns_roce_ucontext *context =
@@ -1103,8 +1122,6 @@ void hns_roce_qp_destroy(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 		if (hr_qp->rq.wqe_cnt && (hr_qp->rdb_en == 1))
 			hns_roce_db_unmap_user(context, &hr_qp->rdb);
 	} else {
-		kfree(hr_qp->sq.wrid);
-		kfree(hr_qp->rq.wrid);
 		if (hr_qp->rq.wqe_cnt)
 			hns_roce_free_db(hr_dev, &hr_qp->rdb);
 	}
-- 
2.8.1

