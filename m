Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D6C2CB802
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Dec 2020 10:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387947AbgLBJC0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Dec 2020 04:02:26 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8912 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387852AbgLBJCZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Dec 2020 04:02:25 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CmCc35t9Tz77Bs;
        Wed,  2 Dec 2020 17:00:35 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 2 Dec 2020 17:00:54 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 01/11] RDMA/hns: Limit the length of data copied between kernel and userspace
Date:   Wed, 2 Dec 2020 16:59:03 +0800
Message-ID: <1606899553-54592-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1606899553-54592-1-git-send-email-liweihang@huawei.com>
References: <1606899553-54592-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

For ib_copy_from_user(), the length of udata may not be the same as that
of cmd. For ib_copy_to_user(), the length of udata may not be the same as
that of resp. So limit the length to prevent out-of-bounds read and write
operations from ib_copy_from_user() and ib_copy_to_user().

Fixes: de77503a5940 ("RDMA/hns: RDMA/hns: Assign rq head pointer when enable rq record db")
Fixes: 633fb4d9fdaa ("RDMA/hns: Use structs to describe the uABI instead of opencoding")
Fixes: ae85bf92effc ("RDMA/hns: Optimize qp param setup flow")
Fixes: 6fd610c5733d ("RDMA/hns: Support 0 hop addressing for SRQ buffer")
Fixes: 9d9d4ff78884 ("RDMA/hns: Update the kernel header file of hns")
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c   |  5 +++--
 drivers/infiniband/hw/hns/hns_roce_main.c |  3 ++-
 drivers/infiniband/hw/hns/hns_roce_pd.c   | 11 ++++++-----
 drivers/infiniband/hw/hns/hns_roce_qp.c   |  9 ++++++---
 drivers/infiniband/hw/hns/hns_roce_srq.c  | 10 +++++-----
 5 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 68f355f..b94a560 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -277,7 +277,7 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 
 	if (udata) {
 		ret = ib_copy_from_udata(&ucmd, udata,
-					 min(sizeof(ucmd), udata->inlen));
+					 min(udata->inlen, sizeof(ucmd)));
 		if (ret) {
 			ibdev_err(ibdev, "Failed to copy CQ udata, err %d\n",
 				  ret);
@@ -316,7 +316,8 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 
 	if (udata) {
 		resp.cqn = hr_cq->cqn;
-		ret = ib_copy_to_udata(udata, &resp, sizeof(resp));
+		ret = ib_copy_to_udata(udata, &resp,
+				       min(udata->outlen, sizeof(resp)));
 		if (ret)
 			goto err_cqc;
 	}
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index f01590d..cab95fd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -328,7 +328,8 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 
 	resp.cqe_size = hr_dev->caps.cqe_sz;
 
-	ret = ib_copy_to_udata(udata, &resp, sizeof(resp));
+	ret = ib_copy_to_udata(udata, &resp,
+			       min(udata->outlen, sizeof(resp)));
 	if (ret)
 		goto error_fail_copy_to_udata;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_pd.c b/drivers/infiniband/hw/hns/hns_roce_pd.c
index 98f6949..f78fa1d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_pd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_pd.c
@@ -70,16 +70,17 @@ int hns_roce_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	}
 
 	if (udata) {
-		struct hns_roce_ib_alloc_pd_resp uresp = {.pdn = pd->pdn};
+		struct hns_roce_ib_alloc_pd_resp resp = {.pdn = pd->pdn};
 
-		if (ib_copy_to_udata(udata, &uresp, sizeof(uresp))) {
+		ret = ib_copy_to_udata(udata, &resp,
+				       min(udata->outlen, sizeof(resp)));
+		if (ret) {
 			hns_roce_pd_free(to_hr_dev(ib_dev), pd->pdn);
-			ibdev_err(ib_dev, "failed to copy to udata\n");
-			return -EFAULT;
+			ibdev_err(ib_dev, "failed to copy to udata, ret = %d\n", ret);
 		}
 	}
 
-	return 0;
+	return ret;
 }
 
 int hns_roce_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata)
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 34aa086..ebf152f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -925,9 +925,12 @@ static int set_qp_param(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 	}
 
 	if (udata) {
-		if (ib_copy_from_udata(ucmd, udata, sizeof(*ucmd))) {
-			ibdev_err(ibdev, "Failed to copy QP ucmd\n");
-			return -EFAULT;
+		ret = ib_copy_from_udata(ucmd, udata,
+					 min(udata->inlen, sizeof(*ucmd)));
+		if (ret) {
+			ibdev_err(ibdev,
+				  "failed to copy QP ucmd, ret = %d\n", ret);
+			return ret;
 		}
 
 		ret = set_user_sq_size(hr_dev, &init_attr->cap, hr_qp, ucmd);
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 27646b9..6ce250e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -304,7 +304,8 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	srq->max_gs = init_attr->attr.max_sge;
 
 	if (udata) {
-		ret = ib_copy_from_udata(&ucmd, udata, sizeof(ucmd));
+		ret = ib_copy_from_udata(&ucmd, udata,
+					 min(udata->inlen, sizeof(ucmd)));
 		if (ret) {
 			ibdev_err(ibdev, "Failed to copy SRQ udata, err %d\n",
 				  ret);
@@ -347,11 +348,10 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	resp.srqn = srq->srqn;
 
 	if (udata) {
-		if (ib_copy_to_udata(udata, &resp,
-				     min(udata->outlen, sizeof(resp)))) {
-			ret = -EFAULT;
+		ret = ib_copy_to_udata(udata, &resp,
+				       min(udata->outlen, sizeof(resp)));
+		if (ret)
 			goto err_srqc_alloc;
-		}
 	}
 
 	return 0;
-- 
2.8.1

