Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D163169E99
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 07:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgBXGly (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 01:41:54 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:37902 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726709AbgBXGly (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Feb 2020 01:41:54 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 454E72120481982A2A68;
        Mon, 24 Feb 2020 14:41:50 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Mon, 24 Feb 2020 14:41:42 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v4 for-next 6/7] RDMA/hns: Optimize kernel qp wrid allocation flow
Date:   Mon, 24 Feb 2020 14:37:37 +0800
Message-ID: <1582526258-13825-7-git-send-email-liweihang@huawei.com>
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

Encapsulate the kernel qp wrid allocation related code into 2 functions:
alloc_kernel_wrid() and free_kernel_wrid().

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 72 ++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 51c6318..a27c3da 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -895,6 +895,45 @@ static void free_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
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
+		ibdev_err(ibdev, "Failed to alloc SQ wrid\n");
+		return -ENOMEM;
+	}
+
+	if (hr_qp->rq.wqe_cnt) {
+		rq_wrid = kcalloc(hr_qp->rq.wqe_cnt, sizeof(u64), GFP_KERNEL);
+		if (ZERO_OR_NULL_PTR(rq_wrid)) {
+			ibdev_err(ibdev, "Failed to alloc RQ wrid\n");
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
@@ -1021,21 +1060,11 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 			hr_qp->rdb_en = 1;
 		}
 
-		hr_qp->sq.wrid = kcalloc(hr_qp->sq.wqe_cnt, sizeof(u64),
-					 GFP_KERNEL);
-		if (ZERO_OR_NULL_PTR(hr_qp->sq.wrid)) {
-			ret = -ENOMEM;
+		ret = alloc_kernel_wrid(hr_dev, hr_qp);
+		if (ret) {
+			ibdev_err(&hr_dev->ib_dev, "Failed to alloc wrid\n");
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
@@ -1084,24 +1113,20 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 
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
@@ -1112,10 +1137,6 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		    hns_roce_qp_has_sq(init_attr))
 			hns_roce_db_unmap_user(uctx, &hr_qp->sdb);
 
-err_sq_wrid:
-	if (!udata)
-		kfree(hr_qp->sq.wrid);
-
 err_db:
 	if (!udata && hns_roce_qp_has_rq(init_attr) &&
 	    (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB))
@@ -1133,10 +1154,9 @@ void hns_roce_qp_destroy(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 	wait_for_completion(&hr_qp->free);
 
 	free_qpc(hr_dev, hr_qp);
-
 	free_qpn(hr_dev, hr_qp);
-
 	free_qp_buf(hr_dev, hr_qp);
+	free_kernel_wrid(hr_dev, hr_qp);
 
 	if (udata) {
 		struct hns_roce_ucontext *context =
@@ -1151,8 +1171,6 @@ void hns_roce_qp_destroy(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
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

