Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40D92C7226
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Nov 2020 23:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgK1VuZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 Nov 2020 16:50:25 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8161 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730418AbgK1SlC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 28 Nov 2020 13:41:02 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CjnfC0pV1z15TDj;
        Sat, 28 Nov 2020 18:24:03 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Sat, 28 Nov 2020 18:24:19 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 3/3] RDMA/hns: Refactor process of setting extended sge
Date:   Sat, 28 Nov 2020 18:22:39 +0800
Message-ID: <1606558959-48510-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1606558959-48510-1-git-send-email-liweihang@huawei.com>
References: <1606558959-48510-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The variable 'cnt' is used to represent the max number of sge an SQ WQE can
use at first, then it means how many extended sge an SQ has. In addition,
this function has no need to return a value. So refactor and encapsulate
the parts of getting number of extended sge a WQE can use to make it easier
to understand.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 60 +++++++++++++++------------------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 7321e74..311fcf4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -404,42 +404,43 @@ static int set_rq_size(struct hns_roce_dev *hr_dev, struct ib_qp_cap *cap,
 	return 0;
 }
 
-static int set_extend_sge_param(struct hns_roce_dev *hr_dev, u32 sq_wqe_cnt,
-				struct hns_roce_qp *hr_qp,
-				struct ib_qp_cap *cap)
+static u32 get_wqe_ext_sge_cnt(struct hns_roce_qp *qp)
 {
-	u32 cnt;
+	/* GSI/UD QP only has extended sge */
+	if (qp->ibqp.qp_type == IB_QPT_GSI || qp->ibqp.qp_type == IB_QPT_UD)
+		return qp->sq.max_gs;
 
-	cnt = max(1U, cap->max_send_sge);
-	if (hr_dev->hw_rev == HNS_ROCE_HW_VER1) {
-		hr_qp->sq.max_gs = roundup_pow_of_two(cnt);
-		hr_qp->sge.sge_cnt = 0;
+	if (qp->sq.max_gs > HNS_ROCE_SGE_IN_WQE)
+		return qp->sq.max_gs - HNS_ROCE_SGE_IN_WQE;
 
-		return 0;
-	}
+	return 0;
+}
 
-	hr_qp->sq.max_gs = cnt;
+static void set_ext_sge_param(struct hns_roce_dev *hr_dev, u32 sq_wqe_cnt,
+			      struct hns_roce_qp *hr_qp, struct ib_qp_cap *cap)
+{
+	u32 total_sge_cnt;
+	u32 wqe_sge_cnt;
 
-	/* UD sqwqe's sge use extend sge */
-	if (hr_qp->ibqp.qp_type == IB_QPT_GSI ||
-	    hr_qp->ibqp.qp_type == IB_QPT_UD) {
-		cnt = roundup_pow_of_two(sq_wqe_cnt * hr_qp->sq.max_gs);
-	} else if (hr_qp->sq.max_gs > HNS_ROCE_SGE_IN_WQE) {
-		cnt = roundup_pow_of_two(sq_wqe_cnt *
-				     (hr_qp->sq.max_gs - HNS_ROCE_SGE_IN_WQE));
-	} else {
-		cnt = 0;
+	hr_qp->sge.sge_shift = HNS_ROCE_SGE_SHIFT;
+
+	if (hr_dev->hw_rev == HNS_ROCE_HW_VER1) {
+		hr_qp->sq.max_gs = HNS_ROCE_SGE_IN_WQE;
+		return;
 	}
 
-	hr_qp->sge.sge_shift = HNS_ROCE_SGE_SHIFT;
+	hr_qp->sq.max_gs = max(1U, cap->max_send_sge);
+
+	wqe_sge_cnt = get_wqe_ext_sge_cnt(hr_qp);
 
 	/* If the number of extended sge is not zero, they MUST use the
 	 * space of HNS_HW_PAGE_SIZE at least.
 	 */
-	hr_qp->sge.sge_cnt = cnt ?
-			max(cnt, (u32)HNS_HW_PAGE_SIZE / HNS_ROCE_SGE_SIZE) : 0;
-
-	return 0;
+	if (wqe_sge_cnt) {
+		total_sge_cnt = roundup_pow_of_two(sq_wqe_cnt * wqe_sge_cnt);
+		hr_qp->sge.sge_cnt = max(total_sge_cnt,
+				(u32)HNS_HW_PAGE_SIZE / HNS_ROCE_SGE_SIZE);
+	}
 }
 
 static int check_sq_size_with_integrity(struct hns_roce_dev *hr_dev,
@@ -484,9 +485,7 @@ static int set_user_sq_size(struct hns_roce_dev *hr_dev,
 		return ret;
 	}
 
-	ret = set_extend_sge_param(hr_dev, cnt, hr_qp, cap);
-	if (ret)
-		return ret;
+	set_ext_sge_param(hr_dev, cnt, hr_qp, cap);
 
 	hr_qp->sq.wqe_shift = ucmd->log_sq_stride;
 	hr_qp->sq.wqe_cnt = cnt;
@@ -551,7 +550,6 @@ static int set_kernel_sq_size(struct hns_roce_dev *hr_dev,
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	u32 cnt;
-	int ret;
 
 	if (!cap->max_send_wr || cap->max_send_wr > hr_dev->caps.max_wqes ||
 	    cap->max_send_sge > hr_dev->caps.max_sq_sg) {
@@ -571,9 +569,7 @@ static int set_kernel_sq_size(struct hns_roce_dev *hr_dev,
 	hr_qp->sq.wqe_shift = ilog2(hr_dev->caps.max_sq_desc_sz);
 	hr_qp->sq.wqe_cnt = cnt;
 
-	ret = set_extend_sge_param(hr_dev, cnt, hr_qp, cap);
-	if (ret)
-		return ret;
+	set_ext_sge_param(hr_dev, cnt, hr_qp, cap);
 
 	/* sync the parameters of kernel QP to user's configuration */
 	cap->max_send_wr = cnt;
-- 
2.8.1

