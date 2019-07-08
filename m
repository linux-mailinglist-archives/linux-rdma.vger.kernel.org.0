Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC09061FB2
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 15:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbfGHNox (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jul 2019 09:44:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2181 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731410AbfGHNox (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 8 Jul 2019 09:44:53 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 68D5A578EF4A1672D726;
        Mon,  8 Jul 2019 21:44:49 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 8 Jul 2019 21:44:39 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 4/9] RDMA/hns: Use a separated function for setting extend sge paramters
Date:   Mon, 8 Jul 2019 21:41:20 +0800
Message-ID: <1562593285-8037-5-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562593285-8037-1-git-send-email-oulijun@huawei.com>
References: <1562593285-8037-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here moves the related lines of setting extend sge size into
the separate function as well as removes the unused variables.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  2 -
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 61 ++++++++++++++++++-----------
 2 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index a548b28..b39497a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -654,8 +654,6 @@ struct hns_roce_qp {
 	u32			doorbell_qpn;
 	__le32			sq_signal_bits;
 	u32			sq_next_wqe;
-	int			sq_max_wqes_per_wr;
-	int			sq_spare_wqes;
 	struct hns_roce_wq	sq;
 
 	struct ib_umem		*umem;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index c109602..d35033b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -502,6 +502,35 @@ static int calc_wqe_bt_page_shift(struct hns_roce_dev *hr_dev,
 	return bt_pg_shift - PAGE_SHIFT;
 }
 
+static int set_extend_sge_param(struct hns_roce_dev *hr_dev,
+				struct hns_roce_qp *hr_qp)
+{
+	struct device *dev = hr_dev->dev;
+
+	if (hr_qp->sq.max_gs > 2) {
+		hr_qp->sge.sge_cnt = roundup_pow_of_two(hr_qp->sq.wqe_cnt *
+				     (hr_qp->sq.max_gs - 2));
+		hr_qp->sge.sge_shift = 4;
+	}
+
+	/* ud sqwqe's sge use extend sge */
+	if (hr_dev->caps.max_sq_sg > 2 && hr_qp->ibqp.qp_type == IB_QPT_GSI) {
+		hr_qp->sge.sge_cnt = roundup_pow_of_two(hr_qp->sq.wqe_cnt *
+				     hr_qp->sq.max_gs);
+		hr_qp->sge.sge_shift = 4;
+	}
+
+	if ((hr_qp->sq.max_gs > 2) && hr_dev->pci_dev->revision == 0x20) {
+		if (hr_qp->sge.sge_cnt > hr_dev->caps.max_extend_sg) {
+			dev_err(dev, "The extended sge cnt error! sge_cnt=%d\n",
+				hr_qp->sge.sge_cnt);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int hns_roce_set_kernel_sq_size(struct hns_roce_dev *hr_dev,
 				       struct ib_qp_cap *cap,
 				       struct hns_roce_qp *hr_qp)
@@ -510,6 +539,7 @@ static int hns_roce_set_kernel_sq_size(struct hns_roce_dev *hr_dev,
 	u32 page_size;
 	u32 max_cnt;
 	int size;
+	int ret;
 
 	if (cap->max_send_wr  > hr_dev->caps.max_wqes  ||
 	    cap->max_send_sge > hr_dev->caps.max_sq_sg ||
@@ -519,8 +549,6 @@ static int hns_roce_set_kernel_sq_size(struct hns_roce_dev *hr_dev,
 	}
 
 	hr_qp->sq.wqe_shift = ilog2(hr_dev->caps.max_sq_desc_sz);
-	hr_qp->sq_max_wqes_per_wr = 1;
-	hr_qp->sq_spare_wqes = 0;
 
 	if (hr_dev->caps.min_wqes)
 		max_cnt = max(cap->max_send_wr, hr_dev->caps.min_wqes);
@@ -540,25 +568,10 @@ static int hns_roce_set_kernel_sq_size(struct hns_roce_dev *hr_dev,
 	else
 		hr_qp->sq.max_gs = max_cnt;
 
-	if (hr_qp->sq.max_gs > 2) {
-		hr_qp->sge.sge_cnt = roundup_pow_of_two(hr_qp->sq.wqe_cnt *
-				     (hr_qp->sq.max_gs - 2));
-		hr_qp->sge.sge_shift = 4;
-	}
-
-	/* ud sqwqe's sge use extend sge */
-	if (hr_dev->caps.max_sq_sg > 2 && hr_qp->ibqp.qp_type == IB_QPT_GSI) {
-		hr_qp->sge.sge_cnt = roundup_pow_of_two(hr_qp->sq.wqe_cnt *
-				     hr_qp->sq.max_gs);
-		hr_qp->sge.sge_shift = 4;
-	}
-
-	if ((hr_qp->sq.max_gs > 2) && hr_dev->pci_dev->revision == 0x20) {
-		if (hr_qp->sge.sge_cnt > hr_dev->caps.max_extend_sg) {
-			dev_err(dev, "The extended sge cnt error! sge_cnt=%d\n",
-				hr_qp->sge.sge_cnt);
-			return -EINVAL;
-		}
+	ret = set_extend_sge_param(hr_dev, hr_qp);
+	if (ret) {
+		dev_err(dev, "set extend sge parameters fail\n");
+		return ret;
 	}
 
 	/* Get buf size, SQ and RQ are aligned to PAGE_SIZE */
@@ -943,11 +956,13 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		hns_roce_free_db(hr_dev, &hr_qp->rdb);
 
 err_rq_sge_list:
-	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE)
+	if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE) &&
+	     hns_roce_qp_has_rq(init_attr))
 		kfree(hr_qp->rq_inl_buf.wqe_list[0].sg_list);
 
 err_wqe_list:
-	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE)
+	if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE) &&
+	     hns_roce_qp_has_rq(init_attr))
 		kfree(hr_qp->rq_inl_buf.wqe_list);
 
 err_out:
-- 
1.9.1

