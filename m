Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81AD1A6608
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 13:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgDML6Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Apr 2020 07:58:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38642 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728558AbgDML6Y (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Apr 2020 07:58:24 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 80E1E3D70D63EC37E379;
        Mon, 13 Apr 2020 19:58:22 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Mon, 13 Apr 2020 19:58:12 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 6/6] RDMA/hns: Support 0 hop addressing for CQE buffer
Date:   Mon, 13 Apr 2020 19:58:11 +0800
Message-ID: <1586779091-51410-7-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1586779091-51410-1-git-send-email-liweihang@huawei.com>
References: <1586779091-51410-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Add the zero hop addressing support by using mtr interface for CQE buffer,
so the hns driver can support addressing hopnum between 0 to 3 for CQE.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c     | 351 +++++++++-------------------
 drivers/infiniband/hw/hns/hns_roce_device.h |   8 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  13 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  15 +-
 4 files changed, 122 insertions(+), 265 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 92798ff..d2d7074 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -39,51 +39,40 @@
 #include <rdma/hns-abi.h>
 #include "hns_roce_common.h"
 
-static int hns_roce_alloc_cqc(struct hns_roce_dev *hr_dev,
-			      struct hns_roce_cq *hr_cq)
+static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 {
 	struct hns_roce_cmd_mailbox *mailbox;
-	struct hns_roce_hem_table *mtt_table;
 	struct hns_roce_cq_table *cq_table;
-	struct device *dev = hr_dev->dev;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	u64 mtts[MTT_MIN_COUNT] = { 0 };
 	dma_addr_t dma_handle;
-	u64 *mtts;
 	int ret;
 
-	cq_table = &hr_dev->cq_table;
-
-	/* Get the physical address of cq buf */
-	if (hns_roce_check_whether_mhop(hr_dev, HEM_TYPE_CQE))
-		mtt_table = &hr_dev->mr_table.mtt_cqe_table;
-	else
-		mtt_table = &hr_dev->mr_table.mtt_table;
-
-	mtts = hns_roce_table_find(hr_dev, mtt_table, hr_cq->mtt.first_seg,
-				   &dma_handle);
-
-	if (!mtts) {
-		dev_err(dev, "Failed to find mtt for CQ buf.\n");
+	ret = hns_roce_mtr_find(hr_dev, &hr_cq->mtr, 0, mtts, ARRAY_SIZE(mtts),
+				&dma_handle);
+	if (ret < 1) {
+		ibdev_err(ibdev, "Failed to find CQ mtr\n");
 		return -EINVAL;
 	}
 
+	cq_table = &hr_dev->cq_table;
 	ret = hns_roce_bitmap_alloc(&cq_table->bitmap, &hr_cq->cqn);
 	if (ret) {
-		dev_err(dev, "Num of CQ out of range.\n");
+		ibdev_err(ibdev, "Failed to alloc CQ bitmap, err %d\n", ret);
 		return ret;
 	}
 
 	/* Get CQC memory HEM(Hardware Entry Memory) table */
 	ret = hns_roce_table_get(hr_dev, &cq_table->table, hr_cq->cqn);
 	if (ret) {
-		dev_err(dev,
-			"Get context mem failed(%d) when CQ(0x%lx) alloc.\n",
-			ret, hr_cq->cqn);
+		ibdev_err(ibdev, "Failed to get CQ(0x%lx) context, err %d\n",
+			  hr_cq->cqn, ret);
 		goto err_out;
 	}
 
 	ret = xa_err(xa_store(&cq_table->array, hr_cq->cqn, hr_cq, GFP_KERNEL));
 	if (ret) {
-		dev_err(dev, "Failed to xa_store CQ.\n");
+		ibdev_err(ibdev, "Failed to xa_store CQ\n");
 		goto err_put;
 	}
 
@@ -101,9 +90,9 @@ static int hns_roce_alloc_cqc(struct hns_roce_dev *hr_dev,
 			HNS_ROCE_CMD_CREATE_CQC, HNS_ROCE_CMD_TIMEOUT_MSECS);
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 	if (ret) {
-		dev_err(dev,
-			"Send cmd mailbox failed(%d) when CQ(0x%lx) alloc.\n",
-			ret, hr_cq->cqn);
+		ibdev_err(ibdev,
+			  "Failed to send create cmd for CQ(0x%lx), err %d\n",
+			  hr_cq->cqn, ret);
 		goto err_xa;
 	}
 
@@ -126,7 +115,7 @@ static int hns_roce_alloc_cqc(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
-void hns_roce_free_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
+static void free_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 {
 	struct hns_roce_cq_table *cq_table = &hr_dev->cq_table;
 	struct device *dev = hr_dev->dev;
@@ -153,190 +142,86 @@ void hns_roce_free_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	hns_roce_bitmap_free(&cq_table->bitmap, hr_cq->cqn, BITMAP_NO_RR);
 }
 
-static int get_cq_umem(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
-		       struct hns_roce_ib_create_cq ucmd,
-		       struct ib_udata *udata)
-{
-	struct hns_roce_mtt *mtt = &hr_cq->mtt;
-	struct ib_umem **umem = &hr_cq->umem;
-	u32 npages;
-	int ret;
-
-	*umem = ib_umem_get(&hr_dev->ib_dev, ucmd.buf_addr, hr_cq->buf_size,
-			    IB_ACCESS_LOCAL_WRITE);
-	if (IS_ERR(*umem))
-		return PTR_ERR(*umem);
-
-	if (hns_roce_check_whether_mhop(hr_dev, HEM_TYPE_CQE))
-		mtt->mtt_type = MTT_TYPE_CQE;
-	else
-		mtt->mtt_type = MTT_TYPE_WQE;
-
-	npages = DIV_ROUND_UP(ib_umem_page_count(*umem),
-			      1 << hr_dev->caps.cqe_buf_pg_sz);
-	ret = hns_roce_mtt_init(hr_dev, npages, hr_cq->page_shift, mtt);
-	if (ret)
-		goto err_buf;
-
-	ret = hns_roce_ib_umem_write_mtt(hr_dev, mtt, *umem);
-	if (ret)
-		goto err_mtt;
-
-	return 0;
-
-err_mtt:
-	hns_roce_mtt_cleanup(hr_dev, mtt);
-
-err_buf:
-	ib_umem_release(*umem);
-	return ret;
-}
-
-static int alloc_cq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
+static int alloc_cq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
+			struct ib_udata *udata, unsigned long addr)
 {
-	struct hns_roce_buf *buf = &hr_cq->buf;
-	struct hns_roce_mtt *mtt = &hr_cq->mtt;
-	int ret;
-
-	ret = hns_roce_buf_alloc(hr_dev, hr_cq->buf_size,
-				 (1 << hr_cq->page_shift) * 2,
-				 buf, hr_cq->page_shift);
-	if (ret)
-		goto out;
-
-	if (hns_roce_check_whether_mhop(hr_dev, HEM_TYPE_CQE))
-		mtt->mtt_type = MTT_TYPE_CQE;
-	else
-		mtt->mtt_type = MTT_TYPE_WQE;
-
-	ret = hns_roce_mtt_init(hr_dev, buf->npages, buf->page_shift, mtt);
-	if (ret)
-		goto err_buf;
-
-	ret = hns_roce_buf_write_mtt(hr_dev, mtt, buf);
-	if (ret)
-		goto err_mtt;
-
-	return 0;
-
-err_mtt:
-	hns_roce_mtt_cleanup(hr_dev, mtt);
-
-err_buf:
-	hns_roce_buf_free(hr_dev, buf);
-
-out:
-	return ret;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct hns_roce_buf_attr buf_attr = {};
+	int err;
+
+	buf_attr.page_shift = hr_dev->caps.cqe_buf_pg_sz + PAGE_ADDR_SHIFT;
+	buf_attr.region[0].size = hr_cq->cq_depth * hr_dev->caps.cq_entry_sz;
+	buf_attr.region[0].hopnum = hr_dev->caps.cqe_hop_num;
+	buf_attr.region_count = 1;
+	buf_attr.fixed_page = true;
+
+	err = hns_roce_mtr_create(hr_dev, &hr_cq->mtr, &buf_attr,
+				  hr_dev->caps.cqe_ba_pg_sz + PAGE_ADDR_SHIFT,
+				  udata, addr);
+	if (err)
+		ibdev_err(ibdev, "Failed to alloc CQ mtr, err %d\n", err);
+
+	return err;
 }
 
 static void free_cq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 {
-	hns_roce_buf_free(hr_dev, &hr_cq->buf);
+	hns_roce_mtr_destroy(hr_dev, &hr_cq->mtr);
 }
 
-static int create_user_cq(struct hns_roce_dev *hr_dev,
-			  struct hns_roce_cq *hr_cq,
-			  struct ib_udata *udata,
-			  struct hns_roce_ib_create_cq_resp *resp)
+static int alloc_cq_db(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
+		       struct ib_udata *udata, unsigned long addr,
+		       struct hns_roce_ib_create_cq_resp *resp)
 {
-	struct hns_roce_ib_create_cq ucmd;
-	struct device *dev = hr_dev->dev;
-	int ret;
-	struct hns_roce_ucontext *context = rdma_udata_to_drv_context(
-				   udata, struct hns_roce_ucontext, ibucontext);
-
-	if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd))) {
-		dev_err(dev, "Failed to copy_from_udata.\n");
-		return -EFAULT;
-	}
+	bool has_db = hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB;
+	struct hns_roce_ucontext *uctx;
+	int err;
 
-	/* Get user space address, write it into mtt table */
-	ret = get_cq_umem(hr_dev, hr_cq, ucmd, udata);
-	if (ret) {
-		dev_err(dev, "Failed to get_cq_umem.\n");
-		return ret;
-	}
-
-	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB &&
-	    udata->outlen >= offsetofend(typeof(*resp), cap_flags)) {
-		ret = hns_roce_db_map_user(context, udata, ucmd.db_addr,
-					   &hr_cq->db);
-		if (ret) {
-			dev_err(dev, "cq record doorbell map failed!\n");
-			goto err_mtt;
+	if (udata) {
+		if (has_db &&
+		    udata->outlen >= offsetofend(typeof(*resp), cap_flags)) {
+			uctx = rdma_udata_to_drv_context(udata,
+					struct hns_roce_ucontext, ibucontext);
+			err = hns_roce_db_map_user(uctx, udata, addr,
+						   &hr_cq->db);
+			if (err)
+				return err;
+			hr_cq->db_en = 1;
+			resp->cap_flags |= HNS_ROCE_SUPPORT_CQ_RECORD_DB;
 		}
-		hr_cq->db_en = 1;
-		resp->cap_flags |= HNS_ROCE_SUPPORT_CQ_RECORD_DB;
-	}
-
-	return 0;
-
-err_mtt:
-	hns_roce_mtt_cleanup(hr_dev, &hr_cq->mtt);
-	ib_umem_release(hr_cq->umem);
-
-	return ret;
-}
-
-static int create_kernel_cq(struct hns_roce_dev *hr_dev,
-			    struct hns_roce_cq *hr_cq)
-{
-	struct device *dev = hr_dev->dev;
-	int ret;
-
-	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB) {
-		ret = hns_roce_alloc_db(hr_dev, &hr_cq->db, 1);
-		if (ret)
-			return ret;
-
-		hr_cq->set_ci_db = hr_cq->db.db_record;
-		*hr_cq->set_ci_db = 0;
-		hr_cq->db_en = 1;
-	}
-
-	/* Init mtt table and write buff address to mtt table */
-	ret = alloc_cq_buf(hr_dev, hr_cq);
-	if (ret) {
-		dev_err(dev, "Failed to alloc_cq_buf.\n");
-		goto err_db;
+	} else {
+		if (has_db) {
+			err = hns_roce_alloc_db(hr_dev, &hr_cq->db, 1);
+			if (err)
+				return err;
+			hr_cq->set_ci_db = hr_cq->db.db_record;
+			*hr_cq->set_ci_db = 0;
+			hr_cq->db_en = 1;
+		}
+		hr_cq->cq_db_l = hr_dev->reg_base + hr_dev->odb_offset +
+				 DB_REG_OFFSET * hr_dev->priv_uar.index;
 	}
 
-	hr_cq->cq_db_l = hr_dev->reg_base + hr_dev->odb_offset +
-			 DB_REG_OFFSET * hr_dev->priv_uar.index;
-
 	return 0;
-
-err_db:
-	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB)
-		hns_roce_free_db(hr_dev, &hr_cq->db);
-
-	return ret;
 }
 
-static void destroy_user_cq(struct hns_roce_dev *hr_dev,
-			    struct hns_roce_cq *hr_cq,
-			    struct ib_udata *udata,
-			    struct hns_roce_ib_create_cq_resp *resp)
+static void free_cq_db(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
+		       struct ib_udata *udata)
 {
-	struct hns_roce_ucontext *context = rdma_udata_to_drv_context(
-				   udata, struct hns_roce_ucontext, ibucontext);
+	struct hns_roce_ucontext *uctx;
 
-	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB &&
-	    udata->outlen >= offsetofend(typeof(*resp), cap_flags))
-		hns_roce_db_unmap_user(context, &hr_cq->db);
-
-	hns_roce_mtt_cleanup(hr_dev, &hr_cq->mtt);
-	ib_umem_release(hr_cq->umem);
-}
-
-static void destroy_kernel_cq(struct hns_roce_dev *hr_dev,
-			      struct hns_roce_cq *hr_cq)
-{
-	hns_roce_mtt_cleanup(hr_dev, &hr_cq->mtt);
-	free_cq_buf(hr_dev, hr_cq);
+	if (!hr_cq->db_en)
+		return;
 
-	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB)
+	hr_cq->db_en = 0;
+	if (udata) {
+		uctx = rdma_udata_to_drv_context(udata,
+						 struct hns_roce_ucontext,
+						 ibucontext);
+		hns_roce_db_unmap_user(uctx, &hr_cq->db);
+	} else {
 		hns_roce_free_db(hr_dev, &hr_cq->db);
+	}
 }
 
 int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
@@ -345,20 +230,21 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 	struct hns_roce_dev *hr_dev = to_hr_dev(ib_cq->device);
 	struct hns_roce_ib_create_cq_resp resp = {};
 	struct hns_roce_cq *hr_cq = to_hr_cq(ib_cq);
-	struct device *dev = hr_dev->dev;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct hns_roce_ib_create_cq ucmd = {};
 	int vector = attr->comp_vector;
 	u32 cq_entries = attr->cqe;
 	int ret;
 
 	if (cq_entries < 1 || cq_entries > hr_dev->caps.max_cqes) {
-		dev_err(dev, "Create CQ failed. entries=%d, max=%d\n",
-			cq_entries, hr_dev->caps.max_cqes);
+		ibdev_err(ibdev, "Failed to check CQ count %d max=%d\n",
+			  cq_entries, hr_dev->caps.max_cqes);
 		return -EINVAL;
 	}
 
 	if (vector >= hr_dev->caps.num_comp_vectors) {
-		dev_err(dev, "Create CQ failed, vector=%d, max=%d\n",
-			vector, hr_dev->caps.num_comp_vectors);
+		ibdev_err(ibdev, "Failed to check CQ vector=%d max=%d\n",
+			  vector, hr_dev->caps.num_comp_vectors);
 		return -EINVAL;
 	}
 
@@ -367,30 +253,35 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 	hr_cq->ib_cq.cqe = cq_entries - 1; /* used as cqe index */
 	hr_cq->cq_depth = cq_entries;
 	hr_cq->vector = vector;
-	hr_cq->buf_size = hr_cq->cq_depth * hr_dev->caps.cq_entry_sz;
-	hr_cq->page_shift = PAGE_SHIFT + hr_dev->caps.cqe_buf_pg_sz;
 	spin_lock_init(&hr_cq->lock);
 	INIT_LIST_HEAD(&hr_cq->sq_list);
 	INIT_LIST_HEAD(&hr_cq->rq_list);
 
 	if (udata) {
-		ret = create_user_cq(hr_dev, hr_cq, udata, &resp);
-		if (ret) {
-			dev_err(dev, "Create cq failed in user mode!\n");
-			goto err_cq;
-		}
-	} else {
-		ret = create_kernel_cq(hr_dev, hr_cq);
+		ret = ib_copy_from_udata(&ucmd, udata, sizeof(ucmd));
 		if (ret) {
-			dev_err(dev, "Create cq failed in kernel mode!\n");
-			goto err_cq;
+			ibdev_err(ibdev, "Failed to copy CQ udata, err %d\n",
+				  ret);
+			return ret;
 		}
 	}
 
-	ret = hns_roce_alloc_cqc(hr_dev, hr_cq);
+	ret = alloc_cq_buf(hr_dev, hr_cq, udata, ucmd.buf_addr);
+	if (ret) {
+		ibdev_err(ibdev, "Failed to alloc CQ buf, err %d\n", ret);
+		return ret;
+	}
+
+	ret = alloc_cq_db(hr_dev, hr_cq, udata, ucmd.db_addr, &resp);
 	if (ret) {
-		dev_err(dev, "Alloc CQ failed(%d).\n", ret);
-		goto err_dbmap;
+		ibdev_err(ibdev, "Failed to alloc CQ db, err %d\n", ret);
+		goto err_cq_buf;
+	}
+
+	ret = alloc_cqc(hr_dev, hr_cq);
+	if (ret) {
+		ibdev_err(ibdev, "Failed to alloc CQ context, err %d\n", ret);
+		goto err_cq_db;
 	}
 
 	/*
@@ -412,15 +303,11 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 	return 0;
 
 err_cqc:
-	hns_roce_free_cqc(hr_dev, hr_cq);
-
-err_dbmap:
-	if (udata)
-		destroy_user_cq(hr_dev, hr_cq, udata, &resp);
-	else
-		destroy_kernel_cq(hr_dev, hr_cq);
-
-err_cq:
+	free_cqc(hr_dev, hr_cq);
+err_cq_db:
+	free_cq_db(hr_dev, hr_cq, udata);
+err_cq_buf:
+	free_cq_buf(hr_dev, hr_cq);
 	return ret;
 }
 
@@ -429,28 +316,12 @@ void hns_roce_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	struct hns_roce_dev *hr_dev = to_hr_dev(ib_cq->device);
 	struct hns_roce_cq *hr_cq = to_hr_cq(ib_cq);
 
-	if (hr_dev->hw->destroy_cq) {
+	if (hr_dev->hw->destroy_cq)
 		hr_dev->hw->destroy_cq(ib_cq, udata);
-		return;
-	}
-
-	hns_roce_free_cqc(hr_dev, hr_cq);
-	hns_roce_mtt_cleanup(hr_dev, &hr_cq->mtt);
 
-	ib_umem_release(hr_cq->umem);
-	if (udata) {
-		if (hr_cq->db_en == 1)
-			hns_roce_db_unmap_user(rdma_udata_to_drv_context(
-						       udata,
-						       struct hns_roce_ucontext,
-						       ibucontext),
-					       &hr_cq->db);
-	} else {
-		/* Free the buff of stored cq */
-		free_cq_buf(hr_dev, hr_cq);
-		if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB)
-			hns_roce_free_db(hr_dev, &hr_cq->db);
-	}
+	free_cq_buf(hr_dev, hr_cq);
+	free_cq_db(hr_dev, hr_cq, udata);
+	free_cqc(hr_dev, hr_cq);
 }
 
 void hns_roce_cq_completion(struct hns_roce_dev *hr_dev, u32 cqn)
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 39af736..ecbfeb6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -503,14 +503,10 @@ struct hns_roce_db {
 
 struct hns_roce_cq {
 	struct ib_cq			ib_cq;
-	struct hns_roce_buf		buf;
-	struct hns_roce_mtt		mtt;
+	struct hns_roce_mtr		mtr;
 	struct hns_roce_db		db;
 	u8				db_en;
 	spinlock_t			lock;
-	struct ib_umem			*umem;
-	u32				buf_size;
-	int				page_shift;
 	u32				cq_depth;
 	u32				cons_index;
 	u32				*set_ci_db;
@@ -1294,8 +1290,6 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 		       struct ib_udata *udata);
 
 void hns_roce_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata);
-void hns_roce_free_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq);
-
 int hns_roce_db_map_user(struct hns_roce_ucontext *context,
 			 struct ib_udata *udata, unsigned long virt,
 			 struct hns_roce_db *db);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index ddf2a45..a1f053c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -1972,7 +1972,8 @@ static int hns_roce_v1_write_mtpt(void *mb_buf, struct hns_roce_mr *mr,
 
 static void *get_cqe(struct hns_roce_cq *hr_cq, int n)
 {
-	return hns_roce_buf_offset(&hr_cq->buf, n * HNS_ROCE_V1_CQE_ENTRY_SIZE);
+	return hns_roce_buf_offset(hr_cq->mtr.kmem,
+				   n * HNS_ROCE_V1_CQE_ENTRY_SIZE);
 }
 
 static void *get_sw_cqe(struct hns_roce_cq *hr_cq, int n)
@@ -3644,8 +3645,6 @@ static void hns_roce_v1_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	u32 cqe_cnt_cur;
 	int wait_time = 0;
 
-	hns_roce_free_cqc(hr_dev, hr_cq);
-
 	/*
 	 * Before freeing cq buffer, we need to ensure that the outstanding CQE
 	 * have been written by checking the CQE counter.
@@ -3668,14 +3667,6 @@ static void hns_roce_v1_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 		}
 		wait_time++;
 	}
-
-	hns_roce_mtt_cleanup(hr_dev, &hr_cq->mtt);
-
-	ib_umem_release(hr_cq->umem);
-	if (!udata) {
-		/* Free the buff of stored cq */
-		hns_roce_buf_free(hr_dev, &hr_cq->buf);
-	}
 }
 
 static void set_eq_cons_index_v1(struct hns_roce_eq *eq, int req_not)
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 42be8a2..a1f7e36 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2680,7 +2680,8 @@ static int hns_roce_v2_mw_write_mtpt(void *mb_buf, struct hns_roce_mw *mw)
 
 static void *get_cqe_v2(struct hns_roce_cq *hr_cq, int n)
 {
-	return hns_roce_buf_offset(&hr_cq->buf, n * HNS_ROCE_V2_CQE_ENTRY_SIZE);
+	return hns_roce_buf_offset(hr_cq->mtr.kmem,
+				   n * HNS_ROCE_V2_CQE_ENTRY_SIZE);
 }
 
 static void *get_sw_cqe_v2(struct hns_roce_cq *hr_cq, int n)
@@ -2801,30 +2802,30 @@ static void hns_roce_v2_write_cqc(struct hns_roce_dev *hr_dev,
 	roce_set_field(cq_context->byte_8_cqn, V2_CQC_BYTE_8_CQN_M,
 		       V2_CQC_BYTE_8_CQN_S, hr_cq->cqn);
 
-	cq_context->cqe_cur_blk_addr = cpu_to_le32(mtts[0] >> PAGE_ADDR_SHIFT);
+	cq_context->cqe_cur_blk_addr = cpu_to_le32(to_hr_hw_page_addr(mtts[0]));
 
 	roce_set_field(cq_context->byte_16_hop_addr,
 		       V2_CQC_BYTE_16_CQE_CUR_BLK_ADDR_M,
 		       V2_CQC_BYTE_16_CQE_CUR_BLK_ADDR_S,
-		       mtts[0] >> (32 + PAGE_ADDR_SHIFT));
+		       upper_32_bits(to_hr_hw_page_addr(mtts[0])));
 	roce_set_field(cq_context->byte_16_hop_addr,
 		       V2_CQC_BYTE_16_CQE_HOP_NUM_M,
 		       V2_CQC_BYTE_16_CQE_HOP_NUM_S, hr_dev->caps.cqe_hop_num ==
 		       HNS_ROCE_HOP_NUM_0 ? 0 : hr_dev->caps.cqe_hop_num);
 
-	cq_context->cqe_nxt_blk_addr = cpu_to_le32(mtts[1] >> PAGE_ADDR_SHIFT);
+	cq_context->cqe_nxt_blk_addr = cpu_to_le32(to_hr_hw_page_addr(mtts[1]));
 	roce_set_field(cq_context->byte_24_pgsz_addr,
 		       V2_CQC_BYTE_24_CQE_NXT_BLK_ADDR_M,
 		       V2_CQC_BYTE_24_CQE_NXT_BLK_ADDR_S,
-		       mtts[1] >> (32 + PAGE_ADDR_SHIFT));
+		       upper_32_bits(to_hr_hw_page_addr(mtts[1])));
 	roce_set_field(cq_context->byte_24_pgsz_addr,
 		       V2_CQC_BYTE_24_CQE_BA_PG_SZ_M,
 		       V2_CQC_BYTE_24_CQE_BA_PG_SZ_S,
-		       hr_dev->caps.cqe_ba_pg_sz + PG_SHIFT_OFFSET);
+		       to_hr_hw_page_shift(hr_cq->mtr.hem_cfg.ba_pg_shift));
 	roce_set_field(cq_context->byte_24_pgsz_addr,
 		       V2_CQC_BYTE_24_CQE_BUF_PG_SZ_M,
 		       V2_CQC_BYTE_24_CQE_BUF_PG_SZ_S,
-		       hr_dev->caps.cqe_buf_pg_sz + PG_SHIFT_OFFSET);
+		       to_hr_hw_page_shift(hr_cq->mtr.hem_cfg.buf_pg_shift));
 
 	cq_context->cqe_ba = cpu_to_le32(dma_handle >> 3);
 
-- 
2.8.1

