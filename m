Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2679234B401
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Mar 2021 04:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhC0DYZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Mar 2021 23:24:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14627 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhC0DYL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Mar 2021 23:24:11 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F6kfQ3wJcz1BGrl;
        Sat, 27 Mar 2021 11:22:06 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 11:24:01 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 2/5] RDMA/hns: Reorganize hns_roce_create_cq()
Date:   Sat, 27 Mar 2021 11:21:31 +0800
Message-ID: <1616815294-13434-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616815294-13434-1-git-send-email-liweihang@huawei.com>
References: <1616815294-13434-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixing Liu <liuyixing1@huawei.com>

Encapsulate two subprocesses into functions.

Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c | 86 ++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 74fc494..9e36d4d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -276,6 +276,57 @@ static void free_cq_db(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
 	}
 }
 
+static int verify_cq_create_attr(struct hns_roce_dev *hr_dev,
+				 const struct ib_cq_init_attr *attr)
+{
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+
+	if (!attr->cqe || attr->cqe > hr_dev->caps.max_cqes) {
+		ibdev_err(ibdev, "failed to check CQ count %u, max = %u.\n",
+			  attr->cqe, hr_dev->caps.max_cqes);
+		return -EINVAL;
+	}
+
+	if (attr->comp_vector >= hr_dev->caps.num_comp_vectors) {
+		ibdev_err(ibdev, "failed to check CQ vector = %u, max = %d.\n",
+			  attr->comp_vector, hr_dev->caps.num_comp_vectors);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int get_cq_ucmd(struct hns_roce_cq *hr_cq, struct ib_udata *udata,
+		       struct hns_roce_ib_create_cq *ucmd)
+{
+	struct ib_device *ibdev = hr_cq->ib_cq.device;
+	int ret;
+
+	ret = ib_copy_from_udata(ucmd, udata, min(udata->inlen, sizeof(*ucmd)));
+	if (ret) {
+		ibdev_err(ibdev, "failed to copy CQ udata, ret = %d.\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void set_cq_param(struct hns_roce_cq *hr_cq, u32 cq_entries, int vector,
+			 struct hns_roce_ib_create_cq *ucmd)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(hr_cq->ib_cq.device);
+
+	cq_entries = max(cq_entries, hr_dev->caps.min_cqes);
+	cq_entries = roundup_pow_of_two(cq_entries);
+	hr_cq->ib_cq.cqe = cq_entries - 1; /* used as cqe index */
+	hr_cq->cq_depth = cq_entries;
+	hr_cq->vector = vector;
+
+	spin_lock_init(&hr_cq->lock);
+	INIT_LIST_HEAD(&hr_cq->sq_list);
+	INIT_LIST_HEAD(&hr_cq->rq_list);
+}
+
 static void set_cqe_size(struct hns_roce_cq *hr_cq, struct ib_udata *udata,
 			 struct hns_roce_ib_create_cq *ucmd)
 {
@@ -299,44 +350,23 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 	struct hns_roce_cq *hr_cq = to_hr_cq(ib_cq);
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_ib_create_cq ucmd = {};
-	int vector = attr->comp_vector;
-	u32 cq_entries = attr->cqe;
 	int ret;
 
 	if (attr->flags)
 		return -EOPNOTSUPP;
 
-	if (cq_entries < 1 || cq_entries > hr_dev->caps.max_cqes) {
-		ibdev_err(ibdev, "failed to check CQ count %u, max = %u.\n",
-			  cq_entries, hr_dev->caps.max_cqes);
-		return -EINVAL;
-	}
-
-	if (vector >= hr_dev->caps.num_comp_vectors) {
-		ibdev_err(ibdev, "failed to check CQ vector = %d, max = %d.\n",
-			  vector, hr_dev->caps.num_comp_vectors);
-		return -EINVAL;
-	}
-
-	cq_entries = max(cq_entries, hr_dev->caps.min_cqes);
-	cq_entries = roundup_pow_of_two(cq_entries);
-	hr_cq->ib_cq.cqe = cq_entries - 1; /* used as cqe index */
-	hr_cq->cq_depth = cq_entries;
-	hr_cq->vector = vector;
-	spin_lock_init(&hr_cq->lock);
-	INIT_LIST_HEAD(&hr_cq->sq_list);
-	INIT_LIST_HEAD(&hr_cq->rq_list);
+	ret = verify_cq_create_attr(hr_dev, attr);
+	if (ret)
+		return ret;
 
 	if (udata) {
-		ret = ib_copy_from_udata(&ucmd, udata,
-					 min(udata->inlen, sizeof(ucmd)));
-		if (ret) {
-			ibdev_err(ibdev, "failed to copy CQ udata, ret = %d.\n",
-				  ret);
+		ret = get_cq_ucmd(hr_cq, udata, &ucmd);
+		if (ret)
 			return ret;
-		}
 	}
 
+	set_cq_param(hr_cq, attr->cqe, attr->comp_vector, &ucmd);
+
 	set_cqe_size(hr_cq, udata, &ucmd);
 
 	ret = alloc_cq_buf(hr_dev, hr_cq, udata, ucmd.buf_addr);
-- 
2.8.1

