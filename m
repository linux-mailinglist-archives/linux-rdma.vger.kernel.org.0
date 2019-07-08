Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEC761FB5
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 15:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbfGHNox (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jul 2019 09:44:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2182 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729866AbfGHNox (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 8 Jul 2019 09:44:53 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6D2C342BED579F5C855D;
        Mon,  8 Jul 2019 21:44:49 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 8 Jul 2019 21:44:38 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 1/9] RDMA/hns: Package the flow of creating cq
Date:   Mon, 8 Jul 2019 21:41:17 +0800
Message-ID: <1562593285-8037-2-git-send-email-oulijun@huawei.com>
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

Here moves the relatived codes of creating cq into the separated
functions in order to comprehensibility.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c | 186 +++++++++++++++++++++-----------
 1 file changed, 124 insertions(+), 62 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 4e50c22..507d3c4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -298,21 +298,132 @@ static void hns_roce_ib_free_cq_buf(struct hns_roce_dev *hr_dev,
 			  &buf->hr_buf);
 }
 
+static int create_user_cq(struct hns_roce_dev *hr_dev,
+			  struct hns_roce_cq *hr_cq,
+			  struct ib_udata *udata,
+			  struct hns_roce_ib_create_cq_resp *resp,
+			  struct hns_roce_uar *uar,
+			  int cq_entries)
+{
+	struct hns_roce_ib_create_cq ucmd;
+	struct device *dev = hr_dev->dev;
+	int ret;
+	struct hns_roce_ucontext *context = rdma_udata_to_drv_context(
+				   udata, struct hns_roce_ucontext, ibucontext);
+
+	if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd))) {
+		dev_err(dev, "Failed to copy_from_udata.\n");
+		return -EFAULT;
+	}
+
+	/* Get user space address, write it into mtt table */
+	ret = hns_roce_ib_get_cq_umem(hr_dev, udata, &hr_cq->hr_buf,
+				      &hr_cq->umem, ucmd.buf_addr,
+				      cq_entries);
+	if (ret) {
+		dev_err(dev, "Failed to get_cq_umem.\n");
+		return ret;
+	}
+
+	if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB) &&
+	    (udata->outlen >= sizeof(*resp))) {
+		ret = hns_roce_db_map_user(context, udata, ucmd.db_addr,
+					   &hr_cq->db);
+		if (ret) {
+			dev_err(dev, "cq record doorbell map failed!\n");
+			goto err_mtt;
+		}
+		hr_cq->db_en = 1;
+		resp->cap_flags |= HNS_ROCE_SUPPORT_CQ_RECORD_DB;
+	}
+
+	/* Get user space parameters */
+	uar = &context->uar;
+
+	return 0;
+
+err_mtt:
+	hns_roce_mtt_cleanup(hr_dev, &hr_cq->hr_buf.hr_mtt);
+	ib_umem_release(hr_cq->umem);
+
+	return ret;
+}
+
+static int create_kernel_cq(struct hns_roce_dev *hr_dev,
+			    struct hns_roce_cq *hr_cq, struct hns_roce_uar *uar,
+			    int cq_entries)
+{
+	struct device *dev = hr_dev->dev;
+	int ret;
+
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB) {
+		ret = hns_roce_alloc_db(hr_dev, &hr_cq->db, 1);
+		if (ret)
+			return ret;
+
+		hr_cq->set_ci_db = hr_cq->db.db_record;
+		*hr_cq->set_ci_db = 0;
+		hr_cq->db_en = 1;
+	}
+
+	/* Init mtt table and write buff address to mtt table */
+	ret = hns_roce_ib_alloc_cq_buf(hr_dev, &hr_cq->hr_buf, cq_entries);
+	if (ret) {
+		dev_err(dev, "Failed to alloc_cq_buf.\n");
+		goto err_db;
+	}
+
+	uar = &hr_dev->priv_uar;
+	hr_cq->cq_db_l = hr_dev->reg_base + hr_dev->odb_offset +
+			 DB_REG_OFFSET * uar->index;
+
+	return 0;
+
+err_db:
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB)
+		hns_roce_free_db(hr_dev, &hr_cq->db);
+
+	return ret;
+}
+
+static void destroy_user_cq(struct hns_roce_dev *hr_dev,
+			    struct hns_roce_cq *hr_cq,
+			    struct ib_udata *udata,
+			    struct hns_roce_ib_create_cq_resp *resp)
+{
+	struct hns_roce_ucontext *context = rdma_udata_to_drv_context(
+				   udata, struct hns_roce_ucontext, ibucontext);
+
+	if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB) &&
+	    (udata->outlen >= sizeof(*resp)))
+		hns_roce_db_unmap_user(context, &hr_cq->db);
+
+	hns_roce_mtt_cleanup(hr_dev, &hr_cq->hr_buf.hr_mtt);
+	ib_umem_release(hr_cq->umem);
+}
+
+static void destroy_kernel_cq(struct hns_roce_dev *hr_dev,
+			      struct hns_roce_cq *hr_cq)
+{
+	hns_roce_mtt_cleanup(hr_dev, &hr_cq->hr_buf.hr_mtt);
+	hns_roce_ib_free_cq_buf(hr_dev, &hr_cq->hr_buf, hr_cq->ib_cq.cqe);
+
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB)
+		hns_roce_free_db(hr_dev, &hr_cq->db);
+}
+
 int hns_roce_ib_create_cq(struct ib_cq *ib_cq,
 			  const struct ib_cq_init_attr *attr,
 			  struct ib_udata *udata)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ib_cq->device);
 	struct device *dev = hr_dev->dev;
-	struct hns_roce_ib_create_cq ucmd;
 	struct hns_roce_ib_create_cq_resp resp = {};
 	struct hns_roce_cq *hr_cq = to_hr_cq(ib_cq);
 	struct hns_roce_uar *uar = NULL;
 	int vector = attr->comp_vector;
 	int cq_entries = attr->cqe;
 	int ret;
-	struct hns_roce_ucontext *context = rdma_udata_to_drv_context(
-		udata, struct hns_roce_ucontext, ibucontext);
 
 	if (cq_entries < 1 || cq_entries > hr_dev->caps.max_cqes) {
 		dev_err(dev, "Creat CQ failed. entries=%d, max=%d\n",
@@ -328,57 +439,18 @@ int hns_roce_ib_create_cq(struct ib_cq *ib_cq,
 	spin_lock_init(&hr_cq->lock);
 
 	if (udata) {
-		if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd))) {
-			dev_err(dev, "Failed to copy_from_udata.\n");
-			ret = -EFAULT;
-			goto err_cq;
-		}
-
-		/* Get user space address, write it into mtt table */
-		ret = hns_roce_ib_get_cq_umem(hr_dev, udata, &hr_cq->hr_buf,
-					      &hr_cq->umem, ucmd.buf_addr,
-					      cq_entries);
+		ret = create_user_cq(hr_dev, hr_cq, udata, &resp, uar,
+				     cq_entries);
 		if (ret) {
-			dev_err(dev, "Failed to get_cq_umem.\n");
+			dev_err(dev, "Create cq failed in user mode!\n");
 			goto err_cq;
 		}
-
-		if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB) &&
-		    (udata->outlen >= sizeof(resp))) {
-			ret = hns_roce_db_map_user(context, udata, ucmd.db_addr,
-						   &hr_cq->db);
-			if (ret) {
-				dev_err(dev, "cq record doorbell map failed!\n");
-				goto err_mtt;
-			}
-			hr_cq->db_en = 1;
-			resp.cap_flags |= HNS_ROCE_SUPPORT_CQ_RECORD_DB;
-		}
-
-		/* Get user space parameters */
-		uar = &context->uar;
 	} else {
-		if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB) {
-			ret = hns_roce_alloc_db(hr_dev, &hr_cq->db, 1);
-			if (ret)
-				goto err_cq;
-
-			hr_cq->set_ci_db = hr_cq->db.db_record;
-			*hr_cq->set_ci_db = 0;
-			hr_cq->db_en = 1;
-		}
-
-		/* Init mmt table and write buff address to mtt table */
-		ret = hns_roce_ib_alloc_cq_buf(hr_dev, &hr_cq->hr_buf,
-					       cq_entries);
+		ret = create_kernel_cq(hr_dev, hr_cq, uar, cq_entries);
 		if (ret) {
-			dev_err(dev, "Failed to alloc_cq_buf.\n");
-			goto err_db;
+			dev_err(dev, "Create cq failed in kernel mode!\n");
+			goto err_cq;
 		}
-
-		uar = &hr_dev->priv_uar;
-		hr_cq->cq_db_l = hr_dev->reg_base + hr_dev->odb_offset +
-				DB_REG_OFFSET * uar->index;
 	}
 
 	/* Allocate cq index, fill cq_context */
@@ -416,20 +488,10 @@ int hns_roce_ib_create_cq(struct ib_cq *ib_cq,
 	hns_roce_free_cq(hr_dev, hr_cq);
 
 err_dbmap:
-	if (udata && (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB) &&
-	    (udata->outlen >= sizeof(resp)))
-		hns_roce_db_unmap_user(context, &hr_cq->db);
-
-err_mtt:
-	hns_roce_mtt_cleanup(hr_dev, &hr_cq->hr_buf.hr_mtt);
-	ib_umem_release(hr_cq->umem);
-	if (!udata)
-		hns_roce_ib_free_cq_buf(hr_dev, &hr_cq->hr_buf,
-					hr_cq->ib_cq.cqe);
-
-err_db:
-	if (!udata && (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB))
-		hns_roce_free_db(hr_dev, &hr_cq->db);
+	if (udata)
+		destroy_user_cq(hr_dev, hr_cq, udata, &resp);
+	else
+		destroy_kernel_cq(hr_dev, hr_cq);
 
 err_cq:
 	return ret;
-- 
1.9.1

