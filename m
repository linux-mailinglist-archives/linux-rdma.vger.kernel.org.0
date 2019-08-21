Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83F7497A85
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 15:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfHUNR5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 09:17:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38352 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728050AbfHUNR4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 09:17:56 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E07B526F5063EE32A895;
        Wed, 21 Aug 2019 21:17:53 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Wed, 21 Aug 2019 21:17:46 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 2/9] RDMA/hns: Refactor the codes of creating qp
Date:   Wed, 21 Aug 2019 21:14:29 +0800
Message-ID: <1566393276-42555-3-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1566393276-42555-1-git-send-email-oulijun@huawei.com>
References: <1566393276-42555-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here packages the codes of allocating receive rq inline buffer
in hns_roce_create_qp_common function in order to reduce the
complexity.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 100 +++++++++++++++++++-------------
 1 file changed, 61 insertions(+), 39 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index ec6b5dd..7e10820 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -635,6 +635,55 @@ static int hns_roce_qp_has_rq(struct ib_qp_init_attr *attr)
 	return 1;
 }
 
+static int hns_roce_alloc_recv_inline_buffer(struct hns_roce_qp *hr_qp,
+					     struct ib_qp_init_attr *init_attr)
+{
+	int ret;
+	int i;
+
+	/* allocate recv inline buf */
+	hr_qp->rq_inl_buf.wqe_list = kcalloc(hr_qp->rq.wqe_cnt,
+					     sizeof(struct hns_roce_rinl_wqe),
+					     GFP_KERNEL);
+	if (!hr_qp->rq_inl_buf.wqe_list) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	hr_qp->rq_inl_buf.wqe_cnt = hr_qp->rq.wqe_cnt;
+
+	/* Firstly, allocate a list of sge space buffer */
+	hr_qp->rq_inl_buf.wqe_list[0].sg_list =
+					kcalloc(hr_qp->rq_inl_buf.wqe_cnt,
+					init_attr->cap.max_recv_sge *
+					sizeof(struct hns_roce_rinl_sge),
+					GFP_KERNEL);
+	if (!hr_qp->rq_inl_buf.wqe_list[0].sg_list) {
+		ret = -ENOMEM;
+		goto err_wqe_list;
+	}
+
+	for (i = 1; i < hr_qp->rq_inl_buf.wqe_cnt; i++)
+		/* Secondly, reallocate the buffer */
+		hr_qp->rq_inl_buf.wqe_list[i].sg_list =
+				     &hr_qp->rq_inl_buf.wqe_list[0].sg_list[i *
+				     init_attr->cap.max_recv_sge];
+
+	return 0;
+
+err_wqe_list:
+	kfree(hr_qp->rq_inl_buf.wqe_list);
+
+err:
+	return ret;
+}
+
+static void hns_roce_free_recv_inline_buffer(struct hns_roce_qp *hr_qp)
+{
+	kfree(hr_qp->rq_inl_buf.wqe_list[0].sg_list);
+	kfree(hr_qp->rq_inl_buf.wqe_list);
+}
+
 static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 				     struct ib_pd *ib_pd,
 				     struct ib_qp_init_attr *init_attr,
@@ -676,33 +725,11 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 
 	if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE) &&
 	    hns_roce_qp_has_rq(init_attr)) {
-		/* allocate recv inline buf */
-		hr_qp->rq_inl_buf.wqe_list = kcalloc(hr_qp->rq.wqe_cnt,
-					       sizeof(struct hns_roce_rinl_wqe),
-					       GFP_KERNEL);
-		if (!hr_qp->rq_inl_buf.wqe_list) {
-			ret = -ENOMEM;
+		ret = hns_roce_alloc_recv_inline_buffer(hr_qp, init_attr);
+		if (ret) {
+			dev_err(dev, "allocate receive inline buffer failed\n");
 			goto err_out;
 		}
-
-		hr_qp->rq_inl_buf.wqe_cnt = hr_qp->rq.wqe_cnt;
-
-		/* Firstly, allocate a list of sge space buffer */
-		hr_qp->rq_inl_buf.wqe_list[0].sg_list =
-					kcalloc(hr_qp->rq_inl_buf.wqe_cnt,
-					       init_attr->cap.max_recv_sge *
-					       sizeof(struct hns_roce_rinl_sge),
-					       GFP_KERNEL);
-		if (!hr_qp->rq_inl_buf.wqe_list[0].sg_list) {
-			ret = -ENOMEM;
-			goto err_wqe_list;
-		}
-
-		for (i = 1; i < hr_qp->rq_inl_buf.wqe_cnt; i++)
-			/* Secondly, reallocate the buffer */
-			hr_qp->rq_inl_buf.wqe_list[i].sg_list =
-				&hr_qp->rq_inl_buf.wqe_list[0].sg_list[i *
-				init_attr->cap.max_recv_sge];
 	}
 
 	page_shift = PAGE_SHIFT + hr_dev->caps.mtt_buf_pg_sz;
@@ -710,14 +737,14 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd))) {
 			dev_err(dev, "ib_copy_from_udata error for create qp\n");
 			ret = -EFAULT;
-			goto err_rq_sge_list;
+			goto err_alloc_recv_inline_buffer;
 		}
 
 		ret = hns_roce_set_user_sq_size(hr_dev, &init_attr->cap, hr_qp,
 						&ucmd);
 		if (ret) {
 			dev_err(dev, "hns_roce_set_user_sq_size error for create qp\n");
-			goto err_rq_sge_list;
+			goto err_alloc_recv_inline_buffer;
 		}
 
 		hr_qp->umem = ib_umem_get(udata, ucmd.buf_addr,
@@ -725,7 +752,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		if (IS_ERR(hr_qp->umem)) {
 			dev_err(dev, "ib_umem_get error for create qp\n");
 			ret = PTR_ERR(hr_qp->umem);
-			goto err_rq_sge_list;
+			goto err_alloc_recv_inline_buffer;
 		}
 		hr_qp->region_cnt = split_wqe_buf_region(hr_dev, hr_qp,
 				hr_qp->regions, ARRAY_SIZE(hr_qp->regions),
@@ -786,13 +813,13 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		    IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK) {
 			dev_err(dev, "init_attr->create_flags error!\n");
 			ret = -EINVAL;
-			goto err_rq_sge_list;
+			goto err_alloc_recv_inline_buffer;
 		}
 
 		if (init_attr->create_flags & IB_QP_CREATE_IPOIB_UD_LSO) {
 			dev_err(dev, "init_attr->create_flags error!\n");
 			ret = -EINVAL;
-			goto err_rq_sge_list;
+			goto err_alloc_recv_inline_buffer;
 		}
 
 		/* Set SQ size */
@@ -800,7 +827,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 						  hr_qp);
 		if (ret) {
 			dev_err(dev, "hns_roce_set_kernel_sq_size error!\n");
-			goto err_rq_sge_list;
+			goto err_alloc_recv_inline_buffer;
 		}
 
 		/* QP doorbell register address */
@@ -814,7 +841,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 			ret = hns_roce_alloc_db(hr_dev, &hr_qp->rdb, 0);
 			if (ret) {
 				dev_err(dev, "rq record doorbell alloc failed!\n");
-				goto err_rq_sge_list;
+				goto err_alloc_recv_inline_buffer;
 			}
 			*hr_qp->rdb.db_record = 0;
 			hr_qp->rdb_en = 1;
@@ -980,15 +1007,10 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	    (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB))
 		hns_roce_free_db(hr_dev, &hr_qp->rdb);
 
-err_rq_sge_list:
-	if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE) &&
-	     hns_roce_qp_has_rq(init_attr))
-		kfree(hr_qp->rq_inl_buf.wqe_list[0].sg_list);
-
-err_wqe_list:
+err_alloc_recv_inline_buffer:
 	if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE) &&
 	     hns_roce_qp_has_rq(init_attr))
-		kfree(hr_qp->rq_inl_buf.wqe_list);
+		hns_roce_free_recv_inline_buffer(hr_qp);
 
 err_out:
 	return ret;
-- 
2.8.1

