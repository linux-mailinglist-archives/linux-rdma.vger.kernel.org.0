Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393563F893A
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Aug 2021 15:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242723AbhHZNmc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Aug 2021 09:42:32 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:18979 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242737AbhHZNmb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Aug 2021 09:42:31 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GwP6l4wpJzbj2p;
        Thu, 26 Aug 2021 21:37:51 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 26 Aug 2021 21:41:28 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 26 Aug 2021 21:41:28 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 6/7] RDMA/hns: Encapsulate the qp db as a function
Date:   Thu, 26 Aug 2021 21:37:35 +0800
Message-ID: <1629985056-57004-7-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1629985056-57004-1-git-send-email-liangwenpeng@huawei.com>
References: <1629985056-57004-1-git-send-email-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixing Liu <liuyixing1@huawei.com>

Encapsulate qp db into two functions: user and kernel.

Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 135 +++++++++++++++++++-------------
 1 file changed, 82 insertions(+), 53 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index d45beed..74c9101 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -823,75 +823,104 @@ static inline bool kernel_qp_has_rdb(struct hns_roce_dev *hr_dev,
 		hns_roce_qp_has_rq(init_attr));
 }
 
+static int alloc_user_qp_db(struct hns_roce_dev *hr_dev,
+			    struct hns_roce_qp *hr_qp,
+			    struct ib_qp_init_attr *init_attr,
+			    struct ib_udata *udata,
+			    struct hns_roce_ib_create_qp *ucmd,
+			    struct hns_roce_ib_create_qp_resp *resp)
+{
+	struct hns_roce_ucontext *uctx = rdma_udata_to_drv_context(udata,
+		struct hns_roce_ucontext, ibucontext);
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	int ret;
+
+	if (user_qp_has_sdb(hr_dev, init_attr, udata, resp, ucmd)) {
+		ret = hns_roce_db_map_user(uctx, ucmd->sdb_addr, &hr_qp->sdb);
+		if (ret) {
+			ibdev_err(ibdev,
+				  "failed to map user SQ doorbell, ret = %d.\n",
+				  ret);
+			goto err_out;
+		}
+		hr_qp->en_flags |= HNS_ROCE_QP_CAP_SQ_RECORD_DB;
+	}
+
+	if (user_qp_has_rdb(hr_dev, init_attr, udata, resp)) {
+		ret = hns_roce_db_map_user(uctx, ucmd->db_addr, &hr_qp->rdb);
+		if (ret) {
+			ibdev_err(ibdev,
+				  "failed to map user RQ doorbell, ret = %d.\n",
+				  ret);
+			goto err_sdb;
+		}
+		hr_qp->en_flags |= HNS_ROCE_QP_CAP_RQ_RECORD_DB;
+	}
+
+	return 0;
+
+err_sdb:
+	if (hr_qp->en_flags & HNS_ROCE_QP_CAP_SQ_RECORD_DB)
+		hns_roce_db_unmap_user(uctx, &hr_qp->sdb);
+err_out:
+	return ret;
+}
+
+static int alloc_kernel_qp_db(struct hns_roce_dev *hr_dev,
+			      struct hns_roce_qp *hr_qp,
+			      struct ib_qp_init_attr *init_attr)
+{
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	int ret;
+
+	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
+		hr_qp->sq.db_reg = hr_dev->mem_base +
+				   HNS_ROCE_DWQE_SIZE * hr_qp->qpn;
+	else
+		hr_qp->sq.db_reg = hr_dev->reg_base + hr_dev->sdb_offset +
+				   DB_REG_OFFSET * hr_dev->priv_uar.index;
+
+	hr_qp->rq.db_reg = hr_dev->reg_base + hr_dev->odb_offset +
+			   DB_REG_OFFSET * hr_dev->priv_uar.index;
+
+	if (kernel_qp_has_rdb(hr_dev, init_attr)) {
+		ret = hns_roce_alloc_db(hr_dev, &hr_qp->rdb, 0);
+		if (ret) {
+			ibdev_err(ibdev,
+				  "failed to alloc kernel RQ doorbell, ret = %d.\n",
+				  ret);
+			return ret;
+		}
+		*hr_qp->rdb.db_record = 0;
+		hr_qp->en_flags |= HNS_ROCE_QP_CAP_RQ_RECORD_DB;
+	}
+
+	return 0;
+}
+
 static int alloc_qp_db(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 		       struct ib_qp_init_attr *init_attr,
 		       struct ib_udata *udata,
 		       struct hns_roce_ib_create_qp *ucmd,
 		       struct hns_roce_ib_create_qp_resp *resp)
 {
-	struct hns_roce_ucontext *uctx = rdma_udata_to_drv_context(
-		udata, struct hns_roce_ucontext, ibucontext);
-	struct ib_device *ibdev = &hr_dev->ib_dev;
 	int ret;
 
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SDI_MODE)
 		hr_qp->en_flags |= HNS_ROCE_QP_CAP_OWNER_DB;
 
 	if (udata) {
-		if (user_qp_has_sdb(hr_dev, init_attr, udata, resp, ucmd)) {
-			ret = hns_roce_db_map_user(uctx, ucmd->sdb_addr,
-						   &hr_qp->sdb);
-			if (ret) {
-				ibdev_err(ibdev,
-					  "failed to map user SQ doorbell, ret = %d.\n",
-					  ret);
-				goto err_out;
-			}
-			hr_qp->en_flags |= HNS_ROCE_QP_CAP_SQ_RECORD_DB;
-		}
-
-		if (user_qp_has_rdb(hr_dev, init_attr, udata, resp)) {
-			ret = hns_roce_db_map_user(uctx, ucmd->db_addr,
-						   &hr_qp->rdb);
-			if (ret) {
-				ibdev_err(ibdev,
-					  "failed to map user RQ doorbell, ret = %d.\n",
-					  ret);
-				goto err_sdb;
-			}
-			hr_qp->en_flags |= HNS_ROCE_QP_CAP_RQ_RECORD_DB;
-		}
+		ret = alloc_user_qp_db(hr_dev, hr_qp, init_attr, udata, ucmd,
+				       resp);
+		if (ret)
+			return ret;
 	} else {
-		if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
-			hr_qp->sq.db_reg = hr_dev->mem_base +
-					   HNS_ROCE_DWQE_SIZE * hr_qp->qpn;
-		else
-			hr_qp->sq.db_reg =
-				hr_dev->reg_base + hr_dev->sdb_offset +
-				DB_REG_OFFSET * hr_dev->priv_uar.index;
-
-		hr_qp->rq.db_reg = hr_dev->reg_base + hr_dev->odb_offset +
-				   DB_REG_OFFSET * hr_dev->priv_uar.index;
-
-		if (kernel_qp_has_rdb(hr_dev, init_attr)) {
-			ret = hns_roce_alloc_db(hr_dev, &hr_qp->rdb, 0);
-			if (ret) {
-				ibdev_err(ibdev,
-					  "failed to alloc kernel RQ doorbell, ret = %d.\n",
-					  ret);
-				goto err_out;
-			}
-			*hr_qp->rdb.db_record = 0;
-			hr_qp->en_flags |= HNS_ROCE_QP_CAP_RQ_RECORD_DB;
-		}
+		ret = alloc_kernel_qp_db(hr_dev, hr_qp, init_attr);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
-err_sdb:
-	if (udata && hr_qp->en_flags & HNS_ROCE_QP_CAP_SQ_RECORD_DB)
-		hns_roce_db_unmap_user(uctx, &hr_qp->sdb);
-err_out:
-	return ret;
 }
 
 static void free_qp_db(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
-- 
2.8.1

