Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C770157179
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2020 10:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgBJJMv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Feb 2020 04:12:51 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40112 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726621AbgBJJMu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Feb 2020 04:12:50 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D5D816B5D6AE19B18614;
        Mon, 10 Feb 2020 17:12:48 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Mon, 10 Feb 2020 17:12:38 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 7/7] RDMA/hns: Optimize qp doorbell allocation flow
Date:   Mon, 10 Feb 2020 17:08:40 +0800
Message-ID: <1581325720-12975-8-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1581325720-12975-1-git-send-email-liweihang@huawei.com>
References: <1581325720-12975-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Encapsulate the kernel qp doorbell allocation related code into 2
functions: alloc_qp_db() and free_qp_db().

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 214 +++++++++++++++++---------------
 1 file changed, 113 insertions(+), 101 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index ad34187..46785f1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -844,6 +844,96 @@ static void free_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 		free_rq_inline_buf(hr_qp);
 }
 
+#define user_qp_has_sdb(hr_dev, init_attr, udata, resp, ucmd) \
+		((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SQ_RECORD_DB) && \
+		udata->outlen >= sizeof(*resp) && \
+		hns_roce_qp_has_sq(init_attr) && udata->inlen >= sizeof(*ucmd))
+
+#define user_qp_has_rdb(hr_dev, init_attr, udata, resp) \
+		((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB) && \
+		udata->outlen >= sizeof(*resp) && \
+		hns_roce_qp_has_rq(init_attr))
+
+#define kernel_qp_has_rdb(hr_dev, init_attr) \
+		((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB) && \
+		hns_roce_qp_has_rq(init_attr))
+
+static int alloc_qp_db(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
+		       struct ib_qp_init_attr *init_attr,
+		       struct ib_udata *udata,
+		       struct hns_roce_ib_create_qp *ucmd,
+		       struct hns_roce_ib_create_qp_resp *resp)
+{
+	struct hns_roce_ucontext *uctx = rdma_udata_to_drv_context(
+		udata, struct hns_roce_ucontext, ibucontext);
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	int ret;
+
+	if (udata) {
+		if (user_qp_has_sdb(hr_dev, init_attr, udata, resp, ucmd)) {
+			ret = hns_roce_db_map_user(uctx, udata, ucmd->sdb_addr,
+						   &hr_qp->sdb);
+			if (ret) {
+				ibdev_err(ibdev, "Failed to map user SQ doorbell\n");
+				goto err_out;
+			}
+			hr_qp->sdb_en = 1;
+			resp->cap_flags |= HNS_ROCE_SUPPORT_SQ_RECORD_DB;
+		}
+
+		if (user_qp_has_rdb(hr_dev, init_attr, udata, resp)) {
+			ret = hns_roce_db_map_user(uctx, udata, ucmd->db_addr,
+						   &hr_qp->rdb);
+			if (ret) {
+				ibdev_err(ibdev, "Failed to map user RQ doorbell\n");
+				goto err_sdb;
+			}
+			hr_qp->rdb_en = 1;
+			resp->cap_flags |= HNS_ROCE_SUPPORT_RQ_RECORD_DB;
+		}
+	} else {
+		/* QP doorbell register address */
+		hr_qp->sq.db_reg_l = hr_dev->reg_base + hr_dev->sdb_offset +
+				     DB_REG_OFFSET * hr_dev->priv_uar.index;
+		hr_qp->rq.db_reg_l = hr_dev->reg_base + hr_dev->odb_offset +
+				     DB_REG_OFFSET * hr_dev->priv_uar.index;
+
+		if (kernel_qp_has_rdb(hr_dev, init_attr)) {
+			ret = hns_roce_alloc_db(hr_dev, &hr_qp->rdb, 0);
+			if (ret) {
+				ibdev_err(ibdev, "Failed to alloc kernel RQ doorbell\n");
+				goto err_out;
+			}
+			*hr_qp->rdb.db_record = 0;
+			hr_qp->rdb_en = 1;
+		}
+	}
+
+	return 0;
+err_sdb:
+	if (udata && hr_qp->sdb_en)
+		hns_roce_db_unmap_user(uctx, &hr_qp->sdb);
+err_out:
+	return ret;
+}
+
+static void free_qp_db(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
+		       struct ib_udata *udata)
+{
+	struct hns_roce_ucontext *uctx = rdma_udata_to_drv_context(
+		udata, struct hns_roce_ucontext, ibucontext);
+
+	if (udata) {
+		if  (hr_qp->rdb_en)
+			hns_roce_db_unmap_user(uctx, &hr_qp->rdb);
+		if  (hr_qp->sdb_en)
+			hns_roce_db_unmap_user(uctx, &hr_qp->sdb);
+	} else {
+		if  (hr_qp->rdb_en)
+			hns_roce_free_db(hr_dev, &hr_qp->rdb);
+	}
+}
+
 static int alloc_kernel_wrid(struct hns_roce_dev *hr_dev,
 			     struct hns_roce_qp *hr_qp)
 {
@@ -940,11 +1030,9 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 				     struct ib_udata *udata,
 				     struct hns_roce_qp *hr_qp)
 {
-	struct device *dev = hr_dev->dev;
-	struct hns_roce_ib_create_qp ucmd;
 	struct hns_roce_ib_create_qp_resp resp = {};
-	struct hns_roce_ucontext *uctx = rdma_udata_to_drv_context(
-		udata, struct hns_roce_ucontext, ibucontext);
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct hns_roce_ib_create_qp ucmd;
 	int ret;
 
 	mutex_init(&hr_qp->mutex);
@@ -955,95 +1043,55 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 
 	ret = set_qp_param(hr_dev, hr_qp, init_attr, udata, &ucmd);
 	if (ret) {
-		ibdev_err(&hr_dev->ib_dev, "Failed to set QP param\n");
+		ibdev_err(ibdev, "Failed to set QP param\n");
 		return ret;
 	}
 
-	if (udata) {
-		if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SQ_RECORD_DB) &&
-		    (udata->inlen >= sizeof(ucmd)) &&
-		    (udata->outlen >= sizeof(resp)) &&
-		    hns_roce_qp_has_sq(init_attr)) {
-			ret = hns_roce_db_map_user(uctx, udata, ucmd.sdb_addr,
-						   &hr_qp->sdb);
-			if (ret) {
-				dev_err(dev, "sq record doorbell map failed!\n");
-				goto err_out;
-			}
-
-			/* indicate kernel supports sq record db */
-			resp.cap_flags |= HNS_ROCE_SUPPORT_SQ_RECORD_DB;
-			hr_qp->sdb_en = 1;
-		}
-
-		if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB) &&
-		    (udata->outlen >= sizeof(resp)) &&
-		    hns_roce_qp_has_rq(init_attr)) {
-			ret = hns_roce_db_map_user(uctx, udata, ucmd.db_addr,
-						   &hr_qp->rdb);
-			if (ret) {
-				dev_err(dev, "rq record doorbell map failed!\n");
-				goto err_sq_dbmap;
-			}
-
-			/* indicate kernel supports rq record db */
-			resp.cap_flags |= HNS_ROCE_SUPPORT_RQ_RECORD_DB;
-			hr_qp->rdb_en = 1;
-		}
-	} else {
-		/* QP doorbell register address */
-		hr_qp->sq.db_reg_l = hr_dev->reg_base + hr_dev->sdb_offset +
-				     DB_REG_OFFSET * hr_dev->priv_uar.index;
-		hr_qp->rq.db_reg_l = hr_dev->reg_base + hr_dev->odb_offset +
-				     DB_REG_OFFSET * hr_dev->priv_uar.index;
-
-		if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB) &&
-		    hns_roce_qp_has_rq(init_attr)) {
-			ret = hns_roce_alloc_db(hr_dev, &hr_qp->rdb, 0);
-			if (ret) {
-				dev_err(dev, "rq record doorbell alloc failed!\n");
-				goto err_out;
-			}
-			*hr_qp->rdb.db_record = 0;
-			hr_qp->rdb_en = 1;
-		}
-
+	if (!udata) {
 		ret = alloc_kernel_wrid(hr_dev, hr_qp);
 		if (ret) {
-			ibdev_err(&hr_dev->ib_dev, "Failed to alloc wrid\n");
-			goto err_db;
+			ibdev_err(ibdev, "Failed to alloc wrid\n");
+			return ret;
 		}
 	}
 
+	ret = alloc_qp_db(hr_dev, hr_qp, init_attr, udata, &ucmd, &resp);
+	if (ret) {
+		ibdev_err(ibdev, "Failed to alloc QP doorbell\n");
+		goto err_wrid;
+	}
+
 	ret = alloc_qp_buf(hr_dev, hr_qp, init_attr, udata, ucmd.buf_addr);
 	if (ret) {
-		ibdev_err(&hr_dev->ib_dev, "Failed to alloc QP buffer\n");
+		ibdev_err(ibdev, "Failed to alloc QP buffer\n");
 		goto err_db;
 	}
 
 	ret = alloc_qpn(hr_dev, hr_qp);
 	if (ret) {
-		ibdev_err(&hr_dev->ib_dev, "Failed to alloc QPN\n");
+		ibdev_err(ibdev, "Failed to alloc QPN\n");
 		goto err_buf;
 	}
 
 	ret = alloc_qpc(hr_dev, hr_qp);
 	if (ret) {
-		ibdev_err(&hr_dev->ib_dev, "Failed to alloc QP context\n");
+		ibdev_err(ibdev, "Failed to alloc QP context\n");
 		goto err_qpn;
 	}
 
 	ret = hns_roce_qp_store(hr_dev, hr_qp, init_attr);
 	if (ret) {
-		ibdev_err(&hr_dev->ib_dev, "Failed to store QP\n");
+		ibdev_err(ibdev, "Failed to store QP\n");
 		goto err_qpc;
 	}
 
 	if (udata) {
 		ret = ib_copy_to_udata(udata, &resp,
 				       min(udata->outlen, sizeof(resp)));
-		if (ret)
+		if (ret) {
+			ibdev_err(ibdev, "copy qp resp failed!\n");
 			goto err_store;
+		}
 	}
 
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL) {
@@ -1067,30 +1115,10 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	free_qpn(hr_dev, hr_qp);
 err_buf:
 	free_qp_buf(hr_dev, hr_qp);
-
-	free_kernel_wrid(hr_dev, hr_qp);
-
-	if (udata) {
-		if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB) &&
-		    (udata->outlen >= sizeof(resp)) &&
-		    hns_roce_qp_has_rq(init_attr))
-			hns_roce_db_unmap_user(uctx, &hr_qp->rdb);
-	}
-
-err_sq_dbmap:
-	if (udata)
-		if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SQ_RECORD_DB) &&
-		    (udata->inlen >= sizeof(ucmd)) &&
-		    (udata->outlen >= sizeof(resp)) &&
-		    hns_roce_qp_has_sq(init_attr))
-			hns_roce_db_unmap_user(uctx, &hr_qp->sdb);
-
 err_db:
-	if (!udata && hns_roce_qp_has_rq(init_attr) &&
-	    (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB))
-		hns_roce_free_db(hr_dev, &hr_qp->rdb);
-
-err_out:
+	free_qp_db(hr_dev, hr_qp, udata);
+err_wrid:
+	free_kernel_wrid(hr_dev, hr_qp);
 	return ret;
 }
 
@@ -1105,23 +1133,7 @@ void hns_roce_qp_destroy(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 	free_qpn(hr_dev, hr_qp);
 	free_qp_buf(hr_dev, hr_qp);
 	free_kernel_wrid(hr_dev, hr_qp);
-
-	if (udata) {
-		struct hns_roce_ucontext *context =
-			rdma_udata_to_drv_context(
-				udata,
-				struct hns_roce_ucontext,
-				ibucontext);
-
-		if (hr_qp->sq.wqe_cnt && (hr_qp->sdb_en == 1))
-			hns_roce_db_unmap_user(context, &hr_qp->sdb);
-
-		if (hr_qp->rq.wqe_cnt && (hr_qp->rdb_en == 1))
-			hns_roce_db_unmap_user(context, &hr_qp->rdb);
-	} else {
-		if (hr_qp->rq.wqe_cnt)
-			hns_roce_free_db(hr_dev, &hr_qp->rdb);
-	}
+	free_qp_db(hr_dev, hr_qp, udata);
 
 	kfree(hr_qp);
 }
-- 
2.8.1

