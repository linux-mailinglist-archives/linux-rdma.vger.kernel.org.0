Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB43E3D9BB8
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jul 2021 04:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbhG2CXH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Jul 2021 22:23:07 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:16019 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbhG2CXG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Jul 2021 22:23:06 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GZvP20QgfzZv7w;
        Thu, 29 Jul 2021 10:19:34 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 10:23:00 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 10:22:59 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <leon@kernel.org>, <liangwenpeng@huawei.com>,
        Xi Wang <wangxi11@huawei.com>
Subject: [PATCH v4 for-next 04/12] RDMA/hns: Refactor QP modify flow
Date:   Thu, 29 Jul 2021 10:19:15 +0800
Message-ID: <1627525163-1683-5-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1627525163-1683-1-git-send-email-liangwenpeng@huawei.com>
References: <1627525163-1683-1-git-send-email-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Warp the qp modify checking logic as a funciton to make the code more
readable.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 50 ++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 91311a0..4b8e850 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1343,21 +1343,17 @@ static int hns_roce_check_qp_attr(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	return 0;
 }
 
-int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
-		       int attr_mask, struct ib_udata *udata)
+static int check_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
+			   int attr_mask, enum ib_qp_state cur_state,
+			   enum ib_qp_state new_state)
 {
-	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
-	enum ib_qp_state cur_state, new_state;
-	int ret = -EINVAL;
-
-	mutex_lock(&hr_qp->mutex);
-
-	if (attr_mask & IB_QP_CUR_STATE && attr->cur_qp_state != hr_qp->state)
-		goto out;
+	int ret;
 
-	cur_state = hr_qp->state;
-	new_state = attr_mask & IB_QP_STATE ? attr->qp_state : cur_state;
+	if (attr_mask & IB_QP_CUR_STATE && attr->cur_qp_state != hr_qp->state) {
+		ibdev_err(ibqp->device, "failed to check modify curr state\n");
+		return -EINVAL;
+	}
 
 	if (ibqp->uobject &&
 	    (attr_mask & IB_QP_STATE) && new_state == IB_QPS_ERR) {
@@ -1367,19 +1363,41 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 			if (hr_qp->en_flags & HNS_ROCE_QP_CAP_RQ_RECORD_DB)
 				hr_qp->rq.head = *(int *)(hr_qp->rdb.virt_addr);
 		} else {
-			ibdev_warn(&hr_dev->ib_dev,
+			ibdev_warn(ibqp->device,
 				  "flush cqe is not supported in userspace!\n");
-			goto out;
+			return -EINVAL;
 		}
 	}
 
 	if (!ib_modify_qp_is_ok(cur_state, new_state, ibqp->qp_type,
 				attr_mask)) {
-		ibdev_err(&hr_dev->ib_dev, "ib_modify_qp_is_ok failed\n");
-		goto out;
+		ibdev_err(ibqp->device, "failed to check modify qp state\n");
+		return -EINVAL;
 	}
 
 	ret = hns_roce_check_qp_attr(ibqp, attr, attr_mask);
+	if (ret) {
+		ibdev_err(ibqp->device, "failed to check modify qp attr\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
+		       int attr_mask, struct ib_udata *udata)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
+	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
+	enum ib_qp_state cur_state, new_state;
+	int ret;
+
+	mutex_lock(&hr_qp->mutex);
+
+	cur_state = hr_qp->state;
+	new_state = attr_mask & IB_QP_STATE ? attr->qp_state : cur_state;
+
+	ret = check_modify_qp(ibqp, attr, attr_mask, cur_state, new_state);
 	if (ret)
 		goto out;
 
-- 
2.8.1

