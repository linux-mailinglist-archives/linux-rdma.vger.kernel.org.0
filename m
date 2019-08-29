Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 523C0A13FE
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2019 10:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfH2IpG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Aug 2019 04:45:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45110 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725939AbfH2IpG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Aug 2019 04:45:06 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CF96C3EDE1A825363B9D;
        Thu, 29 Aug 2019 16:45:00 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Thu, 29 Aug 2019 16:44:54 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 2/2] RDMA/hns: Package operations of rq inline buffer into separate functions
Date:   Thu, 29 Aug 2019 16:41:42 +0800
Message-ID: <1567068102-56919-3-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1567068102-56919-1-git-send-email-liweihang@hisilicon.com>
References: <1567068102-56919-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

Here packages the codes of allocating and freeing rq inline buffer
in hns_roce_create_qp_common function in order to reduce the
complexity.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 95 +++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 39 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 8868172..bd78ff9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -635,6 +635,50 @@ static int hns_roce_qp_has_rq(struct ib_qp_init_attr *attr)
 	return 1;
 }
 
+static int alloc_rq_inline_buf(struct hns_roce_qp *hr_qp,
+			       struct ib_qp_init_attr *init_attr)
+{
+	u32 max_recv_sge = init_attr->cap.max_recv_sge;
+	struct hns_roce_rinl_wqe *wqe_list;
+	u32 wqe_cnt = hr_qp->rq.wqe_cnt;
+	int i;
+
+	/* allocate recv inline buf */
+	wqe_list = kcalloc(wqe_cnt, sizeof(struct hns_roce_rinl_wqe),
+			   GFP_KERNEL);
+
+	if (!wqe_list)
+		goto err;
+
+	/* Allocate a continuous buffer for all inline sge we need */
+	wqe_list[0].sg_list = kcalloc(wqe_cnt, (max_recv_sge *
+				      sizeof(struct hns_roce_rinl_sge)),
+				      GFP_KERNEL);
+	if (!wqe_list[0].sg_list)
+		goto err_wqe_list;
+
+	/* Assign buffers of sg_list to each inline wqe */
+	for (i = 1; i < wqe_cnt; i++)
+		wqe_list[i].sg_list = &wqe_list[0].sg_list[i * max_recv_sge];
+
+	hr_qp->rq_inl_buf.wqe_list = wqe_list;
+	hr_qp->rq_inl_buf.wqe_cnt = wqe_cnt;
+
+	return 0;
+
+err_wqe_list:
+	kfree(wqe_list);
+
+err:
+	return -ENOMEM;
+}
+
+static void free_rq_inline_buf(struct hns_roce_qp *hr_qp)
+{
+	kfree(hr_qp->rq_inl_buf.wqe_list[0].sg_list);
+	kfree(hr_qp->rq_inl_buf.wqe_list);
+}
+
 static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 				     struct ib_pd *ib_pd,
 				     struct ib_qp_init_attr *init_attr,
@@ -676,33 +720,11 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 
 	if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE) &&
 	    hns_roce_qp_has_rq(init_attr)) {
-		/* allocate recv inline buf */
-		hr_qp->rq_inl_buf.wqe_list = kcalloc(hr_qp->rq.wqe_cnt,
-					       sizeof(struct hns_roce_rinl_wqe),
-					       GFP_KERNEL);
-		if (!hr_qp->rq_inl_buf.wqe_list) {
-			ret = -ENOMEM;
+		ret = alloc_rq_inline_buf(hr_qp, init_attr);
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
@@ -710,14 +732,14 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd))) {
 			dev_err(dev, "ib_copy_from_udata error for create qp\n");
 			ret = -EFAULT;
-			goto err_rq_sge_list;
+			goto err_alloc_rq_inline_buf;
 		}
 
 		ret = hns_roce_set_user_sq_size(hr_dev, &init_attr->cap, hr_qp,
 						&ucmd);
 		if (ret) {
 			dev_err(dev, "hns_roce_set_user_sq_size error for create qp\n");
-			goto err_rq_sge_list;
+			goto err_alloc_rq_inline_buf;
 		}
 
 		hr_qp->umem = ib_umem_get(udata, ucmd.buf_addr,
@@ -725,7 +747,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		if (IS_ERR(hr_qp->umem)) {
 			dev_err(dev, "ib_umem_get error for create qp\n");
 			ret = PTR_ERR(hr_qp->umem);
-			goto err_rq_sge_list;
+			goto err_alloc_rq_inline_buf;
 		}
 		hr_qp->region_cnt = split_wqe_buf_region(hr_dev, hr_qp,
 				hr_qp->regions, ARRAY_SIZE(hr_qp->regions),
@@ -786,13 +808,13 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		    IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK) {
 			dev_err(dev, "init_attr->create_flags error!\n");
 			ret = -EINVAL;
-			goto err_rq_sge_list;
+			goto err_alloc_rq_inline_buf;
 		}
 
 		if (init_attr->create_flags & IB_QP_CREATE_IPOIB_UD_LSO) {
 			dev_err(dev, "init_attr->create_flags error!\n");
 			ret = -EINVAL;
-			goto err_rq_sge_list;
+			goto err_alloc_rq_inline_buf;
 		}
 
 		/* Set SQ size */
@@ -800,7 +822,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 						  hr_qp);
 		if (ret) {
 			dev_err(dev, "hns_roce_set_kernel_sq_size error!\n");
-			goto err_rq_sge_list;
+			goto err_alloc_rq_inline_buf;
 		}
 
 		/* QP doorbell register address */
@@ -814,7 +836,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 			ret = hns_roce_alloc_db(hr_dev, &hr_qp->rdb, 0);
 			if (ret) {
 				dev_err(dev, "rq record doorbell alloc failed!\n");
-				goto err_rq_sge_list;
+				goto err_alloc_rq_inline_buf;
 			}
 			*hr_qp->rdb.db_record = 0;
 			hr_qp->rdb_en = 1;
@@ -980,15 +1002,10 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	    (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB))
 		hns_roce_free_db(hr_dev, &hr_qp->rdb);
 
-err_rq_sge_list:
-	if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE) &&
-	     hns_roce_qp_has_rq(init_attr))
-		kfree(hr_qp->rq_inl_buf.wqe_list[0].sg_list);
-
-err_wqe_list:
+err_alloc_rq_inline_buf:
 	if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE) &&
 	     hns_roce_qp_has_rq(init_attr))
-		kfree(hr_qp->rq_inl_buf.wqe_list);
+		free_rq_inline_buf(hr_qp);
 
 err_out:
 	return ret;
-- 
2.8.1

