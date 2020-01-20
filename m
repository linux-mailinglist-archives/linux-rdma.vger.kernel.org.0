Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C61101424FD
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2020 09:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgATIXk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jan 2020 03:23:40 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9206 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbgATIXj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Jan 2020 03:23:39 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E29D19F8345AAC2BD45E;
        Mon, 20 Jan 2020 16:23:36 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Mon, 20 Jan 2020 16:23:26 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 5/7] RDMA/hns: Optimize qp param setup flow
Date:   Mon, 20 Jan 2020 16:19:35 +0800
Message-ID: <1579508377-55818-6-git-send-email-liweihang@huawei.com>
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

Encapsulate the qp param setup related code into set_qp_param().

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 114 +++++++++++++++++---------------
 1 file changed, 61 insertions(+), 53 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 5184cb4..baa3f48 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -307,7 +307,7 @@ static void free_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 	hns_roce_bitmap_free_range(&qp_table->bitmap, hr_qp->qpn, 1, BITMAP_RR);
 }
 
-static int hns_roce_set_rq_size(struct hns_roce_dev *hr_dev,
+static int set_rq_size(struct hns_roce_dev *hr_dev,
 				struct ib_qp_cap *cap, bool is_user, int has_rq,
 				struct hns_roce_qp *hr_qp)
 {
@@ -386,10 +386,9 @@ static int check_sq_size_with_integrity(struct hns_roce_dev *hr_dev,
 	return 0;
 }
 
-static int hns_roce_set_user_sq_size(struct hns_roce_dev *hr_dev,
-				     struct ib_qp_cap *cap,
-				     struct hns_roce_qp *hr_qp,
-				     struct hns_roce_ib_create_qp *ucmd)
+static int set_user_sq_size(struct hns_roce_dev *hr_dev,
+			    struct ib_qp_cap *cap, struct hns_roce_qp *hr_qp,
+			    struct hns_roce_ib_create_qp *ucmd)
 {
 	u32 ex_sge_num;
 	u32 page_size;
@@ -584,9 +583,8 @@ static int set_extend_sge_param(struct hns_roce_dev *hr_dev,
 	return 0;
 }
 
-static int hns_roce_set_kernel_sq_size(struct hns_roce_dev *hr_dev,
-				       struct ib_qp_cap *cap,
-				       struct hns_roce_qp *hr_qp)
+static int set_kernel_sq_size(struct hns_roce_dev *hr_dev,
+			      struct ib_qp_cap *cap, struct hns_roce_qp *hr_qp)
 {
 	struct device *dev = hr_dev->dev;
 	u32 page_size;
@@ -848,6 +846,58 @@ static void free_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 	     hr_qp->rq.wqe_cnt)
 		free_rq_inline_buf(hr_qp);
 }
+
+static int set_qp_param(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
+			struct ib_qp_init_attr *init_attr,
+			struct ib_udata *udata,
+			struct hns_roce_ib_create_qp *ucmd)
+{
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	int ret;
+
+	hr_qp->ibqp.qp_type = init_attr->qp_type;
+
+	if (init_attr->sq_sig_type == IB_SIGNAL_ALL_WR)
+		hr_qp->sq_signal_bits = IB_SIGNAL_ALL_WR;
+	else
+		hr_qp->sq_signal_bits = IB_SIGNAL_REQ_WR;
+
+	ret = set_rq_size(hr_dev, &init_attr->cap, udata,
+			  hns_roce_qp_has_rq(init_attr), hr_qp);
+	if (ret) {
+		ibdev_err(ibdev, "set user rq size failed\n");
+		return ret;
+	}
+
+	if (udata) {
+		if (ib_copy_from_udata(ucmd, udata, sizeof(*ucmd))) {
+			ibdev_err(ibdev, "copy create qp ucmd error\n");
+			return -EFAULT;
+		}
+
+		ret = set_user_sq_size(hr_dev, &init_attr->cap, hr_qp, ucmd);
+		if (ret)
+			ibdev_err(ibdev, "set user sq size error\n");
+	} else {
+		if (init_attr->create_flags &
+		    IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK) {
+			ibdev_err(ibdev, "invalid BLOCK_MULTICAST_LOOPBACK!\n");
+			return -EINVAL;
+		}
+
+		if (init_attr->create_flags & IB_QP_CREATE_IPOIB_UD_LSO) {
+			ibdev_err(ibdev, "invalid IPOIB_UD_LSO!\n");
+			return -EINVAL;
+		}
+
+		ret = set_kernel_sq_size(hr_dev, &init_attr->cap, hr_qp);
+		if (ret)
+			ibdev_err(ibdev, "set kernel sq size error\n");
+	}
+
+	return ret;
+}
+
 static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 				     struct ib_pd *ib_pd,
 				     struct ib_qp_init_attr *init_attr,
@@ -867,34 +917,13 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 
 	hr_qp->state = IB_QPS_RESET;
 
-	hr_qp->ibqp.qp_type = init_attr->qp_type;
-
-	if (init_attr->sq_sig_type == IB_SIGNAL_ALL_WR)
-		hr_qp->sq_signal_bits = IB_SIGNAL_ALL_WR;
-	else
-		hr_qp->sq_signal_bits = IB_SIGNAL_REQ_WR;
-
-	ret = hns_roce_set_rq_size(hr_dev, &init_attr->cap, udata,
-				   hns_roce_qp_has_rq(init_attr), hr_qp);
+	ret = set_qp_param(hr_dev, hr_qp, init_attr, udata, &ucmd);
 	if (ret) {
-		dev_err(dev, "hns_roce_set_rq_size failed\n");
-		goto err_out;
+		ibdev_err(&hr_dev->ib_dev, "set qp param error!\n");
+		return ret;
 	}
 
 	if (udata) {
-		if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd))) {
-			dev_err(dev, "ib_copy_from_udata error for create qp\n");
-			ret = -EFAULT;
-			goto err_out;
-		}
-
-		ret = hns_roce_set_user_sq_size(hr_dev, &init_attr->cap, hr_qp,
-						&ucmd);
-		if (ret) {
-			dev_err(dev, "hns_roce_set_user_sq_size error for create qp\n");
-			goto err_out;
-		}
-
 		if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SQ_RECORD_DB) &&
 		    (udata->inlen >= sizeof(ucmd)) &&
 		    (udata->outlen >= sizeof(resp)) &&
@@ -926,27 +955,6 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 			hr_qp->rdb_en = 1;
 		}
 	} else {
-		if (init_attr->create_flags &
-		    IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK) {
-			dev_err(dev, "init_attr->create_flags error!\n");
-			ret = -EINVAL;
-			goto err_out;
-		}
-
-		if (init_attr->create_flags & IB_QP_CREATE_IPOIB_UD_LSO) {
-			dev_err(dev, "init_attr->create_flags error!\n");
-			ret = -EINVAL;
-			goto err_out;
-		}
-
-		/* Set SQ size */
-		ret = hns_roce_set_kernel_sq_size(hr_dev, &init_attr->cap,
-						  hr_qp);
-		if (ret) {
-			dev_err(dev, "hns_roce_set_kernel_sq_size error!\n");
-			goto err_out;
-		}
-
 		/* QP doorbell register address */
 		hr_qp->sq.db_reg_l = hr_dev->reg_base + hr_dev->sdb_offset +
 				     DB_REG_OFFSET * hr_dev->priv_uar.index;
-- 
2.8.1

