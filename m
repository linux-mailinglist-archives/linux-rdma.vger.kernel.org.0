Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B0C309350
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Jan 2021 10:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhA3JZD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 30 Jan 2021 04:25:03 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12367 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbhA3JYN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 30 Jan 2021 04:24:13 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DSSnG09gNz7d9B;
        Sat, 30 Jan 2021 16:59:14 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 30 Jan 2021 17:00:23 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 06/12] RDMA/hns: Refactor hns_roce_create_srq()
Date:   Sat, 30 Jan 2021 16:58:04 +0800
Message-ID: <1611997090-48820-7-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1611997090-48820-1-git-send-email-liweihang@huawei.com>
References: <1611997090-48820-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

Split the SRQ creation process into multiple steps and encapsulate them
into functions.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |   5 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  12 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c    | 269 ++++++++++++++++------------
 3 files changed, 161 insertions(+), 125 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index d6a846b..b325b9c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -506,6 +506,7 @@ struct hns_roce_srq {
 	int			max_gs;
 	u32			rsv_sge;
 	int			wqe_shift;
+	u32			cqn;
 	void __iomem		*db_reg_l;
 
 	atomic_t		refcount;
@@ -953,8 +954,8 @@ struct hns_roce_hw {
 	int (*init_eq)(struct hns_roce_dev *hr_dev);
 	void (*cleanup_eq)(struct hns_roce_dev *hr_dev);
 	void (*write_srqc)(struct hns_roce_dev *hr_dev,
-			   struct hns_roce_srq *srq, u32 pdn, u16 xrcd, u32 cqn,
-			   void *mb_buf, u64 *mtts_wqe, u64 *mtts_idx,
+			   struct hns_roce_srq *srq, void *mb_buf,
+			   u64 *mtts_wqe, u64 *mtts_idx,
 			   dma_addr_t dma_handle_wqe,
 			   dma_addr_t dma_handle_idx);
 	int (*modify_srq)(struct ib_srq *ibsrq, struct ib_srq_attr *srq_attr,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 49a8456..ec2d64c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5228,9 +5228,9 @@ static int hns_roce_v2_qp_flow_control_init(struct hns_roce_dev *hr_dev,
 }
 
 static void hns_roce_v2_write_srqc(struct hns_roce_dev *hr_dev,
-				   struct hns_roce_srq *srq, u32 pdn, u16 xrcd,
-				   u32 cqn, void *mb_buf, u64 *mtts_wqe,
-				   u64 *mtts_idx, dma_addr_t dma_handle_wqe,
+				   struct hns_roce_srq *srq, void *mb_buf,
+				   u64 *mtts_wqe, u64 *mtts_idx,
+				   dma_addr_t dma_handle_wqe,
 				   dma_addr_t dma_handle_idx)
 {
 	struct hns_roce_srq_context *srq_context;
@@ -5257,7 +5257,7 @@ static void hns_roce_v2_write_srqc(struct hns_roce_dev *hr_dev,
 		       SRQC_BYTE_8_SRQ_LIMIT_WL_S, 0);
 
 	roce_set_field(srq_context->byte_12_xrcd, SRQC_BYTE_12_SRQ_XRCD_M,
-		       SRQC_BYTE_12_SRQ_XRCD_S, xrcd);
+		       SRQC_BYTE_12_SRQ_XRCD_S, 0);
 
 	srq_context->wqe_bt_ba = cpu_to_le32((u32)(dma_handle_wqe >> 3));
 
@@ -5267,7 +5267,7 @@ static void hns_roce_v2_write_srqc(struct hns_roce_dev *hr_dev,
 		       dma_handle_wqe >> 35);
 
 	roce_set_field(srq_context->byte_28_rqws_pd, SRQC_BYTE_28_PD_M,
-		       SRQC_BYTE_28_PD_S, pdn);
+		       SRQC_BYTE_28_PD_S, to_hr_pd(srq->ibsrq.pd)->pdn);
 	roce_set_field(srq_context->byte_28_rqws_pd, SRQC_BYTE_28_RQWS_M,
 		       SRQC_BYTE_28_RQWS_S, srq->max_gs <= 0 ? 0 :
 		       fls(srq->max_gs - 1));
@@ -5307,7 +5307,7 @@ static void hns_roce_v2_write_srqc(struct hns_roce_dev *hr_dev,
 		       upper_32_bits(to_hr_hw_page_addr(mtts_idx[1])));
 	roce_set_field(srq_context->byte_56_xrc_cqn,
 		       SRQC_BYTE_56_SRQ_XRC_CQN_M, SRQC_BYTE_56_SRQ_XRC_CQN_S,
-		       cqn);
+		       srq->cqn);
 	roce_set_field(srq_context->byte_56_xrc_cqn,
 		       SRQC_BYTE_56_SRQ_WQE_BA_PG_SZ_M,
 		       SRQC_BYTE_56_SRQ_WQE_BA_PG_SZ_S,
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 5d20b30..5069b81 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -77,8 +77,7 @@ static int hns_roce_hw_destroy_srq(struct hns_roce_dev *dev,
 				 HNS_ROCE_CMD_TIMEOUT_MSECS);
 }
 
-static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
-		      u32 pdn, u32 cqn, u16 xrcd, u64 db_rec_addr)
+static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 {
 	struct hns_roce_srq_table *srq_table = &hr_dev->srq_table;
 	struct ib_device *ibdev = &hr_dev->ib_dev;
@@ -133,9 +132,8 @@ static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 		goto err_xa;
 	}
 
-	hr_dev->hw->write_srqc(hr_dev, srq, pdn, xrcd, cqn, mailbox->buf,
-			       mtts_wqe, mtts_idx, dma_handle_wqe,
-			       dma_handle_idx);
+	hr_dev->hw->write_srqc(hr_dev, srq, mailbox->buf, mtts_wqe, mtts_idx,
+			       dma_handle_wqe, dma_handle_idx);
 
 	ret = hns_roce_hw_create_srq(hr_dev, mailbox, srq->srqn);
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
@@ -144,9 +142,7 @@ static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 		goto err_xa;
 	}
 
-	atomic_set(&srq->refcount, 1);
-	init_completion(&srq->free);
-	return ret;
+	return 0;
 
 err_xa:
 	xa_erase(&srq_table->xa, srq->srqn);
@@ -179,45 +175,13 @@ static void free_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 	hns_roce_bitmap_free(&srq_table->bitmap, srq->srqn, BITMAP_NO_RR);
 }
 
-static int alloc_srq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
-			 struct ib_udata *udata, unsigned long addr)
-{
-	struct ib_device *ibdev = &hr_dev->ib_dev;
-	struct hns_roce_buf_attr buf_attr = {};
-	int err;
-
-	srq->wqe_shift = ilog2(roundup_pow_of_two(max(HNS_ROCE_SGE_SIZE,
-						      HNS_ROCE_SGE_SIZE *
-						      srq->max_gs)));
-
-	buf_attr.page_shift = hr_dev->caps.srqwqe_buf_pg_sz + HNS_HW_PAGE_SHIFT;
-	buf_attr.region[0].size = to_hr_hem_entries_size(srq->wqe_cnt,
-							 srq->wqe_shift);
-	buf_attr.region[0].hopnum = hr_dev->caps.srqwqe_hop_num;
-	buf_attr.region_count = 1;
-
-	err = hns_roce_mtr_create(hr_dev, &srq->buf_mtr, &buf_attr,
-				  hr_dev->caps.srqwqe_ba_pg_sz +
-				  HNS_HW_PAGE_SHIFT, udata, addr);
-	if (err)
-		ibdev_err(ibdev,
-			  "failed to alloc SRQ buf mtr, ret = %d.\n", err);
-
-	return err;
-}
-
-static void free_srq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
-{
-	hns_roce_mtr_destroy(hr_dev, &srq->buf_mtr);
-}
-
 static int alloc_srq_idx(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 			 struct ib_udata *udata, unsigned long addr)
 {
 	struct hns_roce_idx_que *idx_que = &srq->idx_que;
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_buf_attr buf_attr = {};
-	int err;
+	int ret;
 
 	srq->idx_que.entry_shift = ilog2(HNS_ROCE_IDX_QUE_ENTRY_SZ);
 
@@ -227,20 +191,20 @@ static int alloc_srq_idx(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 	buf_attr.region[0].hopnum = hr_dev->caps.idx_hop_num;
 	buf_attr.region_count = 1;
 
-	err = hns_roce_mtr_create(hr_dev, &idx_que->mtr, &buf_attr,
+	ret = hns_roce_mtr_create(hr_dev, &idx_que->mtr, &buf_attr,
 				  hr_dev->caps.idx_ba_pg_sz + HNS_HW_PAGE_SHIFT,
 				  udata, addr);
-	if (err) {
+	if (ret) {
 		ibdev_err(ibdev,
-			  "failed to alloc SRQ idx mtr, ret = %d.\n", err);
-		return err;
+			  "failed to alloc SRQ idx mtr, ret = %d.\n", ret);
+		return ret;
 	}
 
 	if (!udata) {
 		idx_que->bitmap = bitmap_zalloc(srq->wqe_cnt, GFP_KERNEL);
 		if (!idx_que->bitmap) {
 			ibdev_err(ibdev, "failed to alloc SRQ idx bitmap.\n");
-			err = -ENOMEM;
+			ret = -ENOMEM;
 			goto err_idx_mtr;
 		}
 	}
@@ -252,7 +216,7 @@ static int alloc_srq_idx(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 err_idx_mtr:
 	hns_roce_mtr_destroy(hr_dev, &idx_que->mtr);
 
-	return err;
+	return ret;
 }
 
 static void free_srq_idx(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
@@ -264,6 +228,40 @@ static void free_srq_idx(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 	hns_roce_mtr_destroy(hr_dev, &idx_que->mtr);
 }
 
+static int alloc_srq_wqe_buf(struct hns_roce_dev *hr_dev,
+			     struct hns_roce_srq *srq,
+			     struct ib_udata *udata, unsigned long addr)
+{
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct hns_roce_buf_attr buf_attr = {};
+	int ret;
+
+	srq->wqe_shift = ilog2(roundup_pow_of_two(max(HNS_ROCE_SGE_SIZE,
+						      HNS_ROCE_SGE_SIZE *
+						      srq->max_gs)));
+
+	buf_attr.page_shift = hr_dev->caps.srqwqe_buf_pg_sz + HNS_HW_PAGE_SHIFT;
+	buf_attr.region[0].size = to_hr_hem_entries_size(srq->wqe_cnt,
+							 srq->wqe_shift);
+	buf_attr.region[0].hopnum = hr_dev->caps.srqwqe_hop_num;
+	buf_attr.region_count = 1;
+
+	ret = hns_roce_mtr_create(hr_dev, &srq->buf_mtr, &buf_attr,
+				  hr_dev->caps.srqwqe_ba_pg_sz +
+				  HNS_HW_PAGE_SHIFT, udata, addr);
+	if (ret)
+		ibdev_err(ibdev,
+			  "failed to alloc SRQ buf mtr, ret = %d.\n", ret);
+
+	return ret;
+}
+
+static void free_srq_wqe_buf(struct hns_roce_dev *hr_dev,
+			     struct hns_roce_srq *srq)
+{
+	hns_roce_mtr_destroy(hr_dev, &srq->buf_mtr);
+}
+
 static int alloc_srq_wrid(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 {
 	srq->wrid = kvmalloc_array(srq->wqe_cnt, sizeof(u64), GFP_KERNEL);
@@ -301,110 +299,149 @@ static u32 proc_srq_sge(struct hns_roce_dev *dev, struct hns_roce_srq *hr_srq,
 	return max_sge;
 }
 
-int hns_roce_create_srq(struct ib_srq *ib_srq,
-			struct ib_srq_init_attr *init_attr,
-			struct ib_udata *udata)
+static int set_srq_basic_param(struct hns_roce_srq *srq,
+			       struct ib_srq_init_attr *init_attr,
+			       struct ib_udata *udata)
 {
-	struct hns_roce_dev *hr_dev = to_hr_dev(ib_srq->device);
-	struct hns_roce_ib_create_srq_resp resp = {};
-	struct hns_roce_srq *srq = to_hr_srq(ib_srq);
-	struct ib_device *ibdev = &hr_dev->ib_dev;
-	struct hns_roce_ib_create_srq ucmd = {};
+	struct hns_roce_dev *hr_dev = to_hr_dev(srq->ibsrq.device);
+	struct ib_srq_attr *attr = &init_attr->attr;
 	u32 max_sge;
-	int ret;
-	u32 cqn;
-
-	if (init_attr->srq_type != IB_SRQT_BASIC &&
-	    init_attr->srq_type != IB_SRQT_XRC)
-		return -EOPNOTSUPP;
 
 	max_sge = proc_srq_sge(hr_dev, srq, !!udata);
-
-	if (init_attr->attr.max_wr > hr_dev->caps.max_srq_wrs ||
-	    init_attr->attr.max_sge > max_sge) {
+	if (attr->max_wr > hr_dev->caps.max_srq_wrs ||
+	    attr->max_sge > max_sge) {
 		ibdev_err(&hr_dev->ib_dev,
-			  "SRQ config error, depth = %u, sge = %d\n",
-			  init_attr->attr.max_wr, init_attr->attr.max_sge);
+			  "invalid SRQ attr, depth = %u, sge = %u.\n",
+			  attr->max_wr, attr->max_sge);
 		return -EINVAL;
 	}
 
-	mutex_init(&srq->mutex);
-	spin_lock_init(&srq->lock);
+	attr->max_wr = max_t(u32, attr->max_wr, HNS_ROCE_MIN_SRQ_WQE_NUM);
+	srq->wqe_cnt = roundup_pow_of_two(attr->max_wr);
+	srq->max_gs = roundup_pow_of_two(attr->max_sge + srq->rsv_sge);
+
+	attr->max_wr = srq->wqe_cnt;
+	attr->max_sge = srq->max_gs - srq->rsv_sge;
+	attr->srq_limit = 0;
 
-	init_attr->attr.max_wr = max_t(u32, init_attr->attr.max_wr,
-				       HNS_ROCE_MIN_SRQ_WQE_NUM);
-	srq->wqe_cnt = roundup_pow_of_two(init_attr->attr.max_wr);
-	srq->max_gs =
-		roundup_pow_of_two(init_attr->attr.max_sge + srq->rsv_sge);
-	init_attr->attr.max_wr = srq->wqe_cnt;
-	init_attr->attr.max_sge = srq->max_gs;
-	init_attr->attr.srq_limit = 0;
+	return 0;
+}
+
+static void set_srq_ext_param(struct hns_roce_srq *srq,
+			      struct ib_srq_init_attr *init_attr)
+{
+	srq->cqn = ib_srq_has_cq(init_attr->srq_type) ?
+		   to_hr_cq(init_attr->ext.cq)->cqn : 0;
+}
+
+static int set_srq_param(struct hns_roce_srq *srq,
+			 struct ib_srq_init_attr *init_attr,
+			 struct ib_udata *udata)
+{
+	int ret;
+
+	ret = set_srq_basic_param(srq, init_attr, udata);
+	if (ret)
+		return ret;
+
+	set_srq_ext_param(srq, init_attr);
+
+	return 0;
+}
+
+static int alloc_srq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
+			 struct ib_udata *udata)
+{
+	struct hns_roce_ib_create_srq ucmd = {};
+	int ret;
 
 	if (udata) {
 		ret = ib_copy_from_udata(&ucmd, udata,
 					 min(udata->inlen, sizeof(ucmd)));
 		if (ret) {
-			ibdev_err(ibdev, "failed to copy SRQ udata, ret = %d.\n",
+			ibdev_err(&hr_dev->ib_dev,
+				  "failed to copy SRQ udata, ret = %d.\n",
 				  ret);
 			return ret;
 		}
 	}
 
-	ret = alloc_srq_buf(hr_dev, srq, udata, ucmd.buf_addr);
-	if (ret) {
-		ibdev_err(ibdev,
-			  "failed to alloc SRQ buffer, ret = %d.\n", ret);
+	ret = alloc_srq_idx(hr_dev, srq, udata, ucmd.que_addr);
+	if (ret)
 		return ret;
-	}
 
-	ret = alloc_srq_idx(hr_dev, srq, udata, ucmd.que_addr);
-	if (ret) {
-		ibdev_err(ibdev, "failed to alloc SRQ idx, ret = %d.\n", ret);
-		goto err_buf_alloc;
-	}
+	ret = alloc_srq_wqe_buf(hr_dev, srq, udata, ucmd.buf_addr);
+	if (ret)
+		goto err_idx;
 
 	if (!udata) {
 		ret = alloc_srq_wrid(hr_dev, srq);
-		if (ret) {
-			ibdev_err(ibdev, "failed to alloc SRQ wrid, ret = %d.\n",
-				  ret);
-			goto err_idx_alloc;
-		}
+		if (ret)
+			goto err_wqe_buf;
 	}
 
-	cqn = ib_srq_has_cq(init_attr->srq_type) ?
-	      to_hr_cq(init_attr->ext.cq)->cqn : 0;
-	srq->db_reg_l = hr_dev->reg_base + SRQ_DB_REG;
+	return 0;
 
-	ret = alloc_srqc(hr_dev, srq, to_hr_pd(ib_srq->pd)->pdn, cqn, 0, 0);
-	if (ret) {
-		ibdev_err(ibdev,
-			  "failed to alloc SRQ context, ret = %d.\n", ret);
-		goto err_wrid_alloc;
-	}
+err_wqe_buf:
+	free_srq_wqe_buf(hr_dev, srq);
+err_idx:
+	free_srq_idx(hr_dev, srq);
 
-	srq->event = hns_roce_ib_srq_event;
-	resp.srqn = srq->srqn;
-	srq->max_gs = init_attr->attr.max_sge;
-	init_attr->attr.max_sge = srq->max_gs - srq->rsv_sge;
+	return ret;
+}
+
+static void free_srq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
+{
+	free_srq_wrid(srq);
+	free_srq_wqe_buf(hr_dev, srq);
+	free_srq_idx(hr_dev, srq);
+}
+
+int hns_roce_create_srq(struct ib_srq *ib_srq,
+			struct ib_srq_init_attr *init_attr,
+			struct ib_udata *udata)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(ib_srq->device);
+	struct hns_roce_ib_create_srq_resp resp = {};
+	struct hns_roce_srq *srq = to_hr_srq(ib_srq);
+	int ret;
+
+	mutex_init(&srq->mutex);
+	spin_lock_init(&srq->lock);
+
+	ret = set_srq_param(srq, init_attr, udata);
+	if (ret)
+		return ret;
+
+	ret = alloc_srq_buf(hr_dev, srq, udata);
+	if (ret)
+		return ret;
+
+	ret = alloc_srqc(hr_dev, srq);
+	if (ret)
+		goto err_srq_buf;
 
 	if (udata) {
-		ret = ib_copy_to_udata(udata, &resp,
-				       min(udata->outlen, sizeof(resp)));
-		if (ret)
-			goto err_srqc_alloc;
+		resp.srqn = srq->srqn;
+		if (ib_copy_to_udata(udata, &resp,
+				     min(udata->outlen, sizeof(resp)))) {
+			ret = -EFAULT;
+			goto err_srqc;
+		}
 	}
 
+	srq->db_reg_l = hr_dev->reg_base + SRQ_DB_REG;
+	srq->event = hns_roce_ib_srq_event;
+	atomic_set(&srq->refcount, 1);
+	init_completion(&srq->free);
+
 	return 0;
 
-err_srqc_alloc:
+err_srqc:
 	free_srqc(hr_dev, srq);
-err_wrid_alloc:
-	free_srq_wrid(srq);
-err_idx_alloc:
-	free_srq_idx(hr_dev, srq);
-err_buf_alloc:
+err_srq_buf:
 	free_srq_buf(hr_dev, srq);
+
 	return ret;
 }
 
@@ -414,8 +451,6 @@ int hns_roce_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 	struct hns_roce_srq *srq = to_hr_srq(ibsrq);
 
 	free_srqc(hr_dev, srq);
-	free_srq_idx(hr_dev, srq);
-	free_srq_wrid(srq);
 	free_srq_buf(hr_dev, srq);
 	return 0;
 }
-- 
2.8.1

