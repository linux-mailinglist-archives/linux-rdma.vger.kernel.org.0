Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3F00165569
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2020 04:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbgBTDAV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 22:00:21 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10649 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727402AbgBTDAV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Feb 2020 22:00:21 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1B2C2D1184D5D927226C;
        Thu, 20 Feb 2020 11:00:18 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Thu, 20 Feb 2020 11:00:09 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v3 for-next 5/7] RDMA/hns: Optimize qp param setup flow
Date:   Thu, 20 Feb 2020 10:56:05 +0800
Message-ID: <1582167367-50380-6-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1582167367-50380-1-git-send-email-liweihang@huawei.com>
References: <1582167367-50380-1-git-send-email-liweihang@huawei.com>
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
 drivers/infiniband/hw/hns/hns_roce_qp.c | 136 +++++++++++++++++---------------
 1 file changed, 72 insertions(+), 64 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index dae899e..123fe35 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -346,18 +346,18 @@ static void free_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 	hns_roce_bitmap_free_range(&qp_table->bitmap, hr_qp->qpn, 1, BITMAP_RR);
 }
 
-static int hns_roce_set_rq_size(struct hns_roce_dev *hr_dev,
+static int set_rq_size(struct hns_roce_dev *hr_dev,
 				struct ib_qp_cap *cap, bool is_user, int has_rq,
 				struct hns_roce_qp *hr_qp)
 {
-	struct device *dev = hr_dev->dev;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	u32 max_cnt;
 
 	/* Check the validity of QP support capacity */
 	if (cap->max_recv_wr > hr_dev->caps.max_wqes ||
 	    cap->max_recv_sge > hr_dev->caps.max_rq_sg) {
-		dev_err(dev, "RQ WR or sge error!max_recv_wr=%d max_recv_sge=%d\n",
-			cap->max_recv_wr, cap->max_recv_sge);
+		ibdev_err(ibdev, "Failed to check max recv WR %d and SGE %d\n",
+			  cap->max_recv_wr, cap->max_recv_sge);
 		return -EINVAL;
 	}
 
@@ -369,7 +369,7 @@ static int hns_roce_set_rq_size(struct hns_roce_dev *hr_dev,
 		cap->max_recv_sge = 0;
 	} else {
 		if (is_user && (!cap->max_recv_wr || !cap->max_recv_sge)) {
-			dev_err(dev, "user space no need config max_recv_wr max_recv_sge\n");
+			ibdev_err(ibdev, "Failed to check user max recv WR and SGE\n");
 			return -EINVAL;
 		}
 
@@ -381,7 +381,7 @@ static int hns_roce_set_rq_size(struct hns_roce_dev *hr_dev,
 		hr_qp->rq.wqe_cnt = roundup_pow_of_two(max_cnt);
 
 		if ((u32)hr_qp->rq.wqe_cnt > hr_dev->caps.max_wqes) {
-			dev_err(dev, "while setting rq size, rq.wqe_cnt too large\n");
+			ibdev_err(ibdev, "Failed to check RQ WQE count limit\n");
 			return -EINVAL;
 		}
 
@@ -412,12 +412,12 @@ static int check_sq_size_with_integrity(struct hns_roce_dev *hr_dev,
 	/* Sanity check SQ size before proceeding */
 	if (ucmd->log_sq_stride > max_sq_stride ||
 	    ucmd->log_sq_stride < HNS_ROCE_IB_MIN_SQ_STRIDE) {
-		ibdev_err(&hr_dev->ib_dev, "check SQ size error!\n");
+		ibdev_err(&hr_dev->ib_dev, "Failed to check SQ stride size\n");
 		return -EINVAL;
 	}
 
 	if (cap->max_send_sge > hr_dev->caps.max_sq_sg) {
-		ibdev_err(&hr_dev->ib_dev, "SQ sge error! max_send_sge=%d\n",
+		ibdev_err(&hr_dev->ib_dev, "Failed to check SQ SGE size %d\n",
 			  cap->max_send_sge);
 		return -EINVAL;
 	}
@@ -425,10 +425,9 @@ static int check_sq_size_with_integrity(struct hns_roce_dev *hr_dev,
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
@@ -441,7 +440,7 @@ static int hns_roce_set_user_sq_size(struct hns_roce_dev *hr_dev,
 
 	ret = check_sq_size_with_integrity(hr_dev, cap, ucmd);
 	if (ret) {
-		ibdev_err(&hr_dev->ib_dev, "Sanity check sq size failed\n");
+		ibdev_err(&hr_dev->ib_dev, "Failed to check user SQ size limit\n");
 		return ret;
 	}
 
@@ -460,9 +459,9 @@ static int hns_roce_set_user_sq_size(struct hns_roce_dev *hr_dev,
 	if (hr_qp->sq.max_gs > HNS_ROCE_SGE_IN_WQE &&
 	    hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08_A) {
 		if (hr_qp->sge.sge_cnt > hr_dev->caps.max_extend_sg) {
-			dev_err(hr_dev->dev,
-				"The extended sge cnt error! sge_cnt=%d\n",
-				hr_qp->sge.sge_cnt);
+			ibdev_err(&hr_dev->ib_dev,
+				  "Failed to check extended SGE size limit %d\n",
+				  hr_qp->sge.sge_cnt);
 			return -EINVAL;
 		}
 	}
@@ -626,9 +625,8 @@ static int set_extend_sge_param(struct hns_roce_dev *hr_dev,
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
@@ -887,6 +885,58 @@ static void free_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
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
+		ibdev_err(ibdev, "Failed to set user RQ size\n");
+		return ret;
+	}
+
+	if (udata) {
+		if (ib_copy_from_udata(ucmd, udata, sizeof(*ucmd))) {
+			ibdev_err(ibdev, "Failed to copy QP ucmd\n");
+			return -EFAULT;
+		}
+
+		ret = set_user_sq_size(hr_dev, &init_attr->cap, hr_qp, ucmd);
+		if (ret)
+			ibdev_err(ibdev, "Failed to set user SQ size\n");
+	} else {
+		if (init_attr->create_flags &
+		    IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK) {
+			ibdev_err(ibdev, "Failed to check multicast loopback\n");
+			return -EINVAL;
+		}
+
+		if (init_attr->create_flags & IB_QP_CREATE_IPOIB_UD_LSO) {
+			ibdev_err(ibdev, "Failed to check ipoib ud lso\n");
+			return -EINVAL;
+		}
+
+		ret = set_kernel_sq_size(hr_dev, &init_attr->cap, hr_qp);
+		if (ret)
+			ibdev_err(ibdev, "Failed to set kernel SQ size\n");
+	}
+
+	return ret;
+}
+
 static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 				     struct ib_pd *ib_pd,
 				     struct ib_qp_init_attr *init_attr,
@@ -907,34 +957,13 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	hr_qp->state = IB_QPS_RESET;
 	hr_qp->flush_flag = 0;
 
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
+		ibdev_err(&hr_dev->ib_dev, "Failed to set QP param\n");
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
@@ -966,27 +995,6 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
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

