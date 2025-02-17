Return-Path: <linux-rdma+bounces-7789-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1E3A37BDA
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 08:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CAD816B2BD
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 07:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666571953A1;
	Mon, 17 Feb 2025 07:08:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DFB188006
	for <linux-rdma@vger.kernel.org>; Mon, 17 Feb 2025 07:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739776133; cv=none; b=tsYE6qXLsDxglP0eKvwc7HH5IUt4wMiIqrXiSDfRuyTB9imOpImAqiRodhxaFh7vTQjfNM5tDwZ2y10XGgcBvft/5Ou1zFnCWcmRIr6nHIvguZaxoCSLqptUag+nfCWkyEiwAjBzt6ZDhgZU/mfc3e9d+pHQhjuF20CnyJGzSKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739776133; c=relaxed/simple;
	bh=3uwjNrWtBKFfAgO3ete44atRM/eJUDr9ynL4OwhnZ90=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ef+2o4TBTfgYh739dKfh5kxVAhTUEOobE4XTNI3vUyNIJZw4W0pKnPS/GAxl6vRpcc2tSyWXLI+irEciyLMwtuqd4WCVAM+/ksApQp8pTdoLQMJ7L0gjDEv62v/v0OZHuPYfiZhCicP0rxGE6MYzGeu6izvTMBbmj/LaA0ltAHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YxDCx4vk1z1Y1qS;
	Mon, 17 Feb 2025 15:04:13 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id E36AC180103;
	Mon, 17 Feb 2025 15:08:46 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Feb 2025 15:08:46 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next 1/4] RDMA/hns: Change mtr member to pointer in hns QP/CQ/MR/SRQ/EQ struct
Date: Mon, 17 Feb 2025 15:01:20 +0800
Message-ID: <20250217070123.3171232-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250217070123.3171232-1-huangjunxian6@hisilicon.com>
References: <20250217070123.3171232-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Change mtr member to pointer in hns QP/CQ/MR/SRQ/EQ struct to decouple
the life cycle of mtr from these structs. This is the preparation for
delay-destruction mechanism. No functional changes.

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Signed-off-by: wenglianfa <wenglianfa@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c       | 18 ++--
 drivers/infiniband/hw/hns/hns_roce_device.h   | 21 ++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 82 ++++++++++---------
 drivers/infiniband/hw/hns/hns_roce_mr.c       | 61 ++++++++------
 drivers/infiniband/hw/hns/hns_roce_qp.c       | 13 +--
 drivers/infiniband/hw/hns/hns_roce_restrack.c |  4 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c      | 25 +++---
 7 files changed, 122 insertions(+), 102 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 4106423a1b39..236ee3fefe16 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -135,7 +135,7 @@ static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	u64 mtts[MTT_MIN_COUNT] = {};
 	int ret;
 
-	ret = hns_roce_mtr_find(hr_dev, &hr_cq->mtr, 0, mtts, ARRAY_SIZE(mtts));
+	ret = hns_roce_mtr_find(hr_dev, hr_cq->mtr, 0, mtts, ARRAY_SIZE(mtts));
 	if (ret) {
 		ibdev_err(ibdev, "failed to find CQ mtr, ret = %d.\n", ret);
 		return ret;
@@ -156,7 +156,7 @@ static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	}
 
 	ret = hns_roce_create_cqc(hr_dev, hr_cq, mtts,
-				  hns_roce_get_mtr_ba(&hr_cq->mtr));
+				  hns_roce_get_mtr_ba(hr_cq->mtr));
 	if (ret)
 		goto err_xa;
 
@@ -200,25 +200,27 @@ static int alloc_cq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_buf_attr buf_attr = {};
-	int ret;
+	int ret = 0;
 
 	buf_attr.page_shift = hr_dev->caps.cqe_buf_pg_sz + PAGE_SHIFT;
 	buf_attr.region[0].size = hr_cq->cq_depth * hr_cq->cqe_size;
 	buf_attr.region[0].hopnum = hr_dev->caps.cqe_hop_num;
 	buf_attr.region_count = 1;
 
-	ret = hns_roce_mtr_create(hr_dev, &hr_cq->mtr, &buf_attr,
-				  hr_dev->caps.cqe_ba_pg_sz + PAGE_SHIFT,
-				  udata, addr);
-	if (ret)
+	hr_cq->mtr = hns_roce_mtr_create(hr_dev, &buf_attr,
+					 hr_dev->caps.cqe_ba_pg_sz + PAGE_SHIFT,
+					 udata, addr);
+	if (IS_ERR(hr_cq->mtr)) {
+		ret = PTR_ERR(hr_cq->mtr);
 		ibdev_err(ibdev, "failed to alloc CQ mtr, ret = %d.\n", ret);
+	}
 
 	return ret;
 }
 
 static void free_cq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 {
-	hns_roce_mtr_destroy(hr_dev, &hr_cq->mtr);
+	hns_roce_mtr_destroy(hr_dev, hr_cq->mtr);
 }
 
 static int alloc_cq_db(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 560a1d9de408..ed0fa29f0cff 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -336,7 +336,7 @@ struct hns_roce_mr {
 	int			enabled; /* MR's active status */
 	int			type; /* MR's register type */
 	u32			pbl_hop_num; /* multi-hop number */
-	struct hns_roce_mtr	pbl_mtr;
+	struct hns_roce_mtr	*pbl_mtr;
 	u32			npages;
 	dma_addr_t		*page_list;
 };
@@ -424,7 +424,7 @@ struct hns_roce_db {
 
 struct hns_roce_cq {
 	struct ib_cq			ib_cq;
-	struct hns_roce_mtr		mtr;
+	struct hns_roce_mtr		*mtr;
 	struct hns_roce_db		db;
 	u32				flags;
 	spinlock_t			lock;
@@ -445,7 +445,7 @@ struct hns_roce_cq {
 };
 
 struct hns_roce_idx_que {
-	struct hns_roce_mtr		mtr;
+	struct hns_roce_mtr		*mtr;
 	u32				entry_shift;
 	unsigned long			*bitmap;
 	u32				head;
@@ -466,7 +466,7 @@ struct hns_roce_srq {
 	refcount_t		refcount;
 	struct completion	free;
 
-	struct hns_roce_mtr	buf_mtr;
+	struct hns_roce_mtr	*buf_mtr;
 
 	u64		       *wrid;
 	struct hns_roce_idx_que idx_que;
@@ -614,7 +614,7 @@ struct hns_roce_qp {
 	enum ib_sig_type	sq_signal_bits;
 	struct hns_roce_wq	sq;
 
-	struct hns_roce_mtr	mtr;
+	struct hns_roce_mtr	*mtr;
 
 	u32			buff_size;
 	struct mutex		mutex;
@@ -712,7 +712,7 @@ struct hns_roce_eq {
 	int				coalesce;
 	int				arm_st;
 	int				hop_num;
-	struct hns_roce_mtr		mtr;
+	struct hns_roce_mtr		*mtr;
 	u16				eq_max_cnt;
 	u32				eq_period;
 	int				shift;
@@ -1179,10 +1179,11 @@ static inline dma_addr_t hns_roce_get_mtr_ba(struct hns_roce_mtr *mtr)
 
 int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		      u32 offset, u64 *mtt_buf, int mtt_max);
-int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
-			struct hns_roce_buf_attr *buf_attr,
-			unsigned int page_shift, struct ib_udata *udata,
-			unsigned long user_addr);
+struct hns_roce_mtr *hns_roce_mtr_create(struct hns_roce_dev *hr_dev,
+					 struct hns_roce_buf_attr *buf_attr,
+					 unsigned int ba_page_shift,
+					 struct ib_udata *udata,
+					 unsigned long user_addr);
 void hns_roce_mtr_destroy(struct hns_roce_dev *hr_dev,
 			  struct hns_roce_mtr *mtr);
 int hns_roce_mtr_map(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index dded339802b3..d60ca0a306e9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -150,7 +150,7 @@ static void set_frmr_seg(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
 	hr_reg_write_bool(fseg, FRMR_LW, wr->access & IB_ACCESS_LOCAL_WRITE);
 
 	/* Data structure reuse may lead to confusion */
-	pbl_ba = mr->pbl_mtr.hem_cfg.root_ba;
+	pbl_ba = mr->pbl_mtr->hem_cfg.root_ba;
 	rc_sq_wqe->msg_len = cpu_to_le32(lower_32_bits(pbl_ba));
 	rc_sq_wqe->inv_key = cpu_to_le32(upper_32_bits(pbl_ba));
 
@@ -161,7 +161,7 @@ static void set_frmr_seg(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
 
 	hr_reg_write(fseg, FRMR_PBL_SIZE, mr->npages);
 	hr_reg_write(fseg, FRMR_PBL_BUF_PG_SZ,
-		     to_hr_hw_page_shift(mr->pbl_mtr.hem_cfg.buf_pg_shift));
+		     to_hr_hw_page_shift(mr->pbl_mtr->hem_cfg.buf_pg_shift));
 	hr_reg_clear(fseg, FRMR_BLK_MODE);
 }
 
@@ -864,12 +864,12 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 
 static void *get_srq_wqe_buf(struct hns_roce_srq *srq, u32 n)
 {
-	return hns_roce_buf_offset(srq->buf_mtr.kmem, n << srq->wqe_shift);
+	return hns_roce_buf_offset(srq->buf_mtr->kmem, n << srq->wqe_shift);
 }
 
 static void *get_idx_buf(struct hns_roce_idx_que *idx_que, u32 n)
 {
-	return hns_roce_buf_offset(idx_que->mtr.kmem,
+	return hns_roce_buf_offset(idx_que->mtr->kmem,
 				   n << idx_que->entry_shift);
 }
 
@@ -3227,7 +3227,7 @@ static int set_mtpt_pbl(struct hns_roce_dev *hr_dev,
 	int ret;
 	int i;
 
-	ret = hns_roce_mtr_find(hr_dev, &mr->pbl_mtr, 0, pages,
+	ret = hns_roce_mtr_find(hr_dev, mr->pbl_mtr, 0, pages,
 				min_t(int, ARRAY_SIZE(pages), mr->npages));
 	if (ret) {
 		ibdev_err(ibdev, "failed to find PBL mtr, ret = %d.\n", ret);
@@ -3238,7 +3238,7 @@ static int set_mtpt_pbl(struct hns_roce_dev *hr_dev,
 	for (i = 0; i < ARRAY_SIZE(pages); i++)
 		pages[i] >>= MPT_PBL_BUF_ADDR_S;
 
-	pbl_ba = hns_roce_get_mtr_ba(&mr->pbl_mtr);
+	pbl_ba = hns_roce_get_mtr_ba(mr->pbl_mtr);
 
 	mpt_entry->pbl_size = cpu_to_le32(mr->npages);
 	mpt_entry->pbl_ba_l = cpu_to_le32(pbl_ba >> MPT_PBL_BA_ADDR_S);
@@ -3251,7 +3251,7 @@ static int set_mtpt_pbl(struct hns_roce_dev *hr_dev,
 	mpt_entry->pa1_l = cpu_to_le32(lower_32_bits(pages[1]));
 	hr_reg_write(mpt_entry, MPT_PA1_H, upper_32_bits(pages[1]));
 	hr_reg_write(mpt_entry, MPT_PBL_BUF_PG_SZ,
-		     to_hr_hw_page_shift(mr->pbl_mtr.hem_cfg.buf_pg_shift));
+		     to_hr_hw_page_shift(mr->pbl_mtr->hem_cfg.buf_pg_shift));
 
 	return 0;
 }
@@ -3294,7 +3294,7 @@ static int hns_roce_v2_write_mtpt(struct hns_roce_dev *hr_dev,
 		hr_reg_write(mpt_entry, MPT_PBL_HOP_NUM, mr->pbl_hop_num);
 
 	hr_reg_write(mpt_entry, MPT_PBL_BA_PG_SZ,
-		     to_hr_hw_page_shift(mr->pbl_mtr.hem_cfg.ba_pg_shift));
+		     to_hr_hw_page_shift(mr->pbl_mtr->hem_cfg.ba_pg_shift));
 	hr_reg_enable(mpt_entry, MPT_INNER_PA_VLD);
 
 	return set_mtpt_pbl(hr_dev, mpt_entry, mr);
@@ -3338,7 +3338,7 @@ static int hns_roce_v2_rereg_write_mtpt(struct hns_roce_dev *hr_dev,
 
 static int hns_roce_v2_frmr_write_mtpt(void *mb_buf, struct hns_roce_mr *mr)
 {
-	dma_addr_t pbl_ba = hns_roce_get_mtr_ba(&mr->pbl_mtr);
+	dma_addr_t pbl_ba = hns_roce_get_mtr_ba(mr->pbl_mtr);
 	struct hns_roce_v2_mpt_entry *mpt_entry;
 
 	mpt_entry = mb_buf;
@@ -3357,9 +3357,9 @@ static int hns_roce_v2_frmr_write_mtpt(void *mb_buf, struct hns_roce_mr *mr)
 
 	hr_reg_write(mpt_entry, MPT_PBL_HOP_NUM, 1);
 	hr_reg_write(mpt_entry, MPT_PBL_BA_PG_SZ,
-		     to_hr_hw_page_shift(mr->pbl_mtr.hem_cfg.ba_pg_shift));
+		     to_hr_hw_page_shift(mr->pbl_mtr->hem_cfg.ba_pg_shift));
 	hr_reg_write(mpt_entry, MPT_PBL_BUF_PG_SZ,
-		     to_hr_hw_page_shift(mr->pbl_mtr.hem_cfg.buf_pg_shift));
+		     to_hr_hw_page_shift(mr->pbl_mtr->hem_cfg.buf_pg_shift));
 
 	mpt_entry->pbl_size = cpu_to_le32(mr->npages);
 
@@ -3497,7 +3497,7 @@ static void hns_roce_v2_dereg_mr(struct hns_roce_dev *hr_dev)
 
 static void *get_cqe_v2(struct hns_roce_cq *hr_cq, int n)
 {
-	return hns_roce_buf_offset(hr_cq->mtr.kmem, n * hr_cq->cqe_size);
+	return hns_roce_buf_offset(hr_cq->mtr->kmem, n * hr_cq->cqe_size);
 }
 
 static void *get_sw_cqe_v2(struct hns_roce_cq *hr_cq, unsigned int n)
@@ -3609,9 +3609,9 @@ static void hns_roce_v2_write_cqc(struct hns_roce_dev *hr_dev,
 	hr_reg_write(cq_context, CQC_CQE_NEX_BLK_ADDR_H,
 		     upper_32_bits(to_hr_hw_page_addr(mtts[1])));
 	hr_reg_write(cq_context, CQC_CQE_BAR_PG_SZ,
-		     to_hr_hw_page_shift(hr_cq->mtr.hem_cfg.ba_pg_shift));
+		     to_hr_hw_page_shift(hr_cq->mtr->hem_cfg.ba_pg_shift));
 	hr_reg_write(cq_context, CQC_CQE_BUF_PG_SZ,
-		     to_hr_hw_page_shift(hr_cq->mtr.hem_cfg.buf_pg_shift));
+		     to_hr_hw_page_shift(hr_cq->mtr->hem_cfg.buf_pg_shift));
 	hr_reg_write(cq_context, CQC_CQE_BA_L, dma_handle >> CQC_CQE_BA_L_S);
 	hr_reg_write(cq_context, CQC_CQE_BA_H, dma_handle >> CQC_CQE_BA_H_S);
 	hr_reg_write_bool(cq_context, CQC_DB_RECORD_EN,
@@ -4368,7 +4368,7 @@ static int config_qp_rq_buf(struct hns_roce_dev *hr_dev,
 	int ret;
 
 	/* Search qp buf's mtts */
-	ret = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, hr_qp->rq.offset, mtts,
+	ret = hns_roce_mtr_find(hr_dev, hr_qp->mtr, hr_qp->rq.offset, mtts,
 				MTT_MIN_COUNT);
 	if (hr_qp->rq.wqe_cnt && ret) {
 		ibdev_err(&hr_dev->ib_dev,
@@ -4377,7 +4377,7 @@ static int config_qp_rq_buf(struct hns_roce_dev *hr_dev,
 		return ret;
 	}
 
-	wqe_sge_ba = hns_roce_get_mtr_ba(&hr_qp->mtr);
+	wqe_sge_ba = hns_roce_get_mtr_ba(hr_qp->mtr);
 
 	context->wqe_sge_ba = cpu_to_le32(wqe_sge_ba >> 3);
 	qpc_mask->wqe_sge_ba = 0;
@@ -4408,11 +4408,11 @@ static int config_qp_rq_buf(struct hns_roce_dev *hr_dev,
 	hr_reg_clear(qpc_mask, QPC_RQ_HOP_NUM);
 
 	hr_reg_write(context, QPC_WQE_SGE_BA_PG_SZ,
-		     to_hr_hw_page_shift(hr_qp->mtr.hem_cfg.ba_pg_shift));
+		     to_hr_hw_page_shift(hr_qp->mtr->hem_cfg.ba_pg_shift));
 	hr_reg_clear(qpc_mask, QPC_WQE_SGE_BA_PG_SZ);
 
 	hr_reg_write(context, QPC_WQE_SGE_BUF_PG_SZ,
-		     to_hr_hw_page_shift(hr_qp->mtr.hem_cfg.buf_pg_shift));
+		     to_hr_hw_page_shift(hr_qp->mtr->hem_cfg.buf_pg_shift));
 	hr_reg_clear(qpc_mask, QPC_WQE_SGE_BUF_PG_SZ);
 
 	context->rq_cur_blk_addr = cpu_to_le32(to_hr_hw_page_addr(mtts[0]));
@@ -4445,7 +4445,7 @@ static int config_qp_sq_buf(struct hns_roce_dev *hr_dev,
 	int ret;
 
 	/* search qp buf's mtts */
-	ret = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, hr_qp->sq.offset,
+	ret = hns_roce_mtr_find(hr_dev, hr_qp->mtr, hr_qp->sq.offset,
 				&sq_cur_blk, 1);
 	if (ret) {
 		ibdev_err(ibdev, "failed to find QP(0x%lx) SQ WQE buf, ret = %d.\n",
@@ -4453,7 +4453,7 @@ static int config_qp_sq_buf(struct hns_roce_dev *hr_dev,
 		return ret;
 	}
 	if (hr_qp->sge.sge_cnt > 0) {
-		ret = hns_roce_mtr_find(hr_dev, &hr_qp->mtr,
+		ret = hns_roce_mtr_find(hr_dev, hr_qp->mtr,
 					hr_qp->sge.offset, &sge_cur_blk, 1);
 		if (ret) {
 			ibdev_err(ibdev, "failed to find QP(0x%lx) SGE buf, ret = %d.\n",
@@ -5734,7 +5734,7 @@ static int hns_roce_v2_write_srqc_index_queue(struct hns_roce_srq *srq,
 	int ret;
 
 	/* Get physical address of idx que buf */
-	ret = hns_roce_mtr_find(hr_dev, &idx_que->mtr, 0, mtts_idx,
+	ret = hns_roce_mtr_find(hr_dev, idx_que->mtr, 0, mtts_idx,
 				ARRAY_SIZE(mtts_idx));
 	if (ret) {
 		ibdev_err(ibdev, "failed to find mtr for SRQ idx, ret = %d.\n",
@@ -5742,7 +5742,7 @@ static int hns_roce_v2_write_srqc_index_queue(struct hns_roce_srq *srq,
 		return ret;
 	}
 
-	dma_handle_idx = hns_roce_get_mtr_ba(&idx_que->mtr);
+	dma_handle_idx = hns_roce_get_mtr_ba(idx_que->mtr);
 
 	hr_reg_write(ctx, SRQC_IDX_HOP_NUM,
 		     to_hr_hem_hopnum(hr_dev->caps.idx_hop_num, srq->wqe_cnt));
@@ -5752,9 +5752,9 @@ static int hns_roce_v2_write_srqc_index_queue(struct hns_roce_srq *srq,
 		     upper_32_bits(dma_handle_idx >> DMA_IDX_SHIFT));
 
 	hr_reg_write(ctx, SRQC_IDX_BA_PG_SZ,
-		     to_hr_hw_page_shift(idx_que->mtr.hem_cfg.ba_pg_shift));
+		     to_hr_hw_page_shift(idx_que->mtr->hem_cfg.ba_pg_shift));
 	hr_reg_write(ctx, SRQC_IDX_BUF_PG_SZ,
-		     to_hr_hw_page_shift(idx_que->mtr.hem_cfg.buf_pg_shift));
+		     to_hr_hw_page_shift(idx_que->mtr->hem_cfg.buf_pg_shift));
 
 	hr_reg_write(ctx, SRQC_IDX_CUR_BLK_ADDR_L,
 		     to_hr_hw_page_addr(mtts_idx[0]));
@@ -5781,7 +5781,7 @@ static int hns_roce_v2_write_srqc(struct hns_roce_srq *srq, void *mb_buf)
 	memset(ctx, 0, sizeof(*ctx));
 
 	/* Get the physical address of srq buf */
-	ret = hns_roce_mtr_find(hr_dev, &srq->buf_mtr, 0, mtts_wqe,
+	ret = hns_roce_mtr_find(hr_dev, srq->buf_mtr, 0, mtts_wqe,
 				ARRAY_SIZE(mtts_wqe));
 	if (ret) {
 		ibdev_err(ibdev, "failed to find mtr for SRQ WQE, ret = %d.\n",
@@ -5789,7 +5789,7 @@ static int hns_roce_v2_write_srqc(struct hns_roce_srq *srq, void *mb_buf)
 		return ret;
 	}
 
-	dma_handle_wqe = hns_roce_get_mtr_ba(&srq->buf_mtr);
+	dma_handle_wqe = hns_roce_get_mtr_ba(srq->buf_mtr);
 
 	hr_reg_write(ctx, SRQC_SRQ_ST, 1);
 	hr_reg_write_bool(ctx, SRQC_SRQ_TYPE,
@@ -5811,9 +5811,9 @@ static int hns_roce_v2_write_srqc(struct hns_roce_srq *srq, void *mb_buf)
 		     upper_32_bits(dma_handle_wqe >> DMA_WQE_SHIFT));
 
 	hr_reg_write(ctx, SRQC_WQE_BA_PG_SZ,
-		     to_hr_hw_page_shift(srq->buf_mtr.hem_cfg.ba_pg_shift));
+		     to_hr_hw_page_shift(srq->buf_mtr->hem_cfg.ba_pg_shift));
 	hr_reg_write(ctx, SRQC_WQE_BUF_PG_SZ,
-		     to_hr_hw_page_shift(srq->buf_mtr.hem_cfg.buf_pg_shift));
+		     to_hr_hw_page_shift(srq->buf_mtr->hem_cfg.buf_pg_shift));
 
 	if (srq->cap_flags & HNS_ROCE_SRQ_CAP_RECORD_DB) {
 		hr_reg_enable(ctx, SRQC_DB_RECORD_EN);
@@ -6166,7 +6166,7 @@ static struct hns_roce_aeqe *next_aeqe_sw_v2(struct hns_roce_eq *eq)
 {
 	struct hns_roce_aeqe *aeqe;
 
-	aeqe = hns_roce_buf_offset(eq->mtr.kmem,
+	aeqe = hns_roce_buf_offset(eq->mtr->kmem,
 				   (eq->cons_index & (eq->entries - 1)) *
 				   eq->eqe_size);
 
@@ -6234,7 +6234,7 @@ static struct hns_roce_ceqe *next_ceqe_sw_v2(struct hns_roce_eq *eq)
 {
 	struct hns_roce_ceqe *ceqe;
 
-	ceqe = hns_roce_buf_offset(eq->mtr.kmem,
+	ceqe = hns_roce_buf_offset(eq->mtr->kmem,
 				   (eq->cons_index & (eq->entries - 1)) *
 				   eq->eqe_size);
 
@@ -6474,7 +6474,7 @@ static void hns_roce_v2_int_mask_enable(struct hns_roce_dev *hr_dev,
 
 static void free_eq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq)
 {
-	hns_roce_mtr_destroy(hr_dev, &eq->mtr);
+	hns_roce_mtr_destroy(hr_dev, eq->mtr);
 }
 
 static void hns_roce_v2_destroy_eqc(struct hns_roce_dev *hr_dev,
@@ -6521,14 +6521,14 @@ static int config_eqc(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq,
 	init_eq_config(hr_dev, eq);
 
 	/* if not multi-hop, eqe buffer only use one trunk */
-	ret = hns_roce_mtr_find(hr_dev, &eq->mtr, 0, eqe_ba,
+	ret = hns_roce_mtr_find(hr_dev, eq->mtr, 0, eqe_ba,
 				ARRAY_SIZE(eqe_ba));
 	if (ret) {
 		dev_err(hr_dev->dev, "failed to find EQE mtr, ret = %d\n", ret);
 		return ret;
 	}
 
-	bt_ba = hns_roce_get_mtr_ba(&eq->mtr);
+	bt_ba = hns_roce_get_mtr_ba(eq->mtr);
 
 	hr_reg_write(eqc, EQC_EQ_ST, HNS_ROCE_V2_EQ_STATE_VALID);
 	hr_reg_write(eqc, EQC_EQE_HOP_NUM, eq->hop_num);
@@ -6538,9 +6538,9 @@ static int config_eqc(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq,
 	hr_reg_write(eqc, EQC_EQN, eq->eqn);
 	hr_reg_write(eqc, EQC_EQE_CNT, HNS_ROCE_EQ_INIT_EQE_CNT);
 	hr_reg_write(eqc, EQC_EQE_BA_PG_SZ,
-		     to_hr_hw_page_shift(eq->mtr.hem_cfg.ba_pg_shift));
+		     to_hr_hw_page_shift(eq->mtr->hem_cfg.ba_pg_shift));
 	hr_reg_write(eqc, EQC_EQE_BUF_PG_SZ,
-		     to_hr_hw_page_shift(eq->mtr.hem_cfg.buf_pg_shift));
+		     to_hr_hw_page_shift(eq->mtr->hem_cfg.buf_pg_shift));
 	hr_reg_write(eqc, EQC_EQ_PROD_INDX, HNS_ROCE_EQ_INIT_PROD_IDX);
 	hr_reg_write(eqc, EQC_EQ_MAX_CNT, eq->eq_max_cnt);
 
@@ -6573,7 +6573,7 @@ static int config_eqc(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq,
 static int alloc_eq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq)
 {
 	struct hns_roce_buf_attr buf_attr = {};
-	int err;
+	int err = 0;
 
 	if (hr_dev->caps.eqe_hop_num == HNS_ROCE_HOP_NUM_0)
 		eq->hop_num = 0;
@@ -6585,11 +6585,13 @@ static int alloc_eq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq)
 	buf_attr.region[0].hopnum = eq->hop_num;
 	buf_attr.region_count = 1;
 
-	err = hns_roce_mtr_create(hr_dev, &eq->mtr, &buf_attr,
-				  hr_dev->caps.eqe_ba_pg_sz + PAGE_SHIFT, NULL,
-				  0);
-	if (err)
+	eq->mtr = hns_roce_mtr_create(hr_dev, &buf_attr,
+				      hr_dev->caps.eqe_ba_pg_sz + PAGE_SHIFT,
+				      NULL, 0);
+	if (IS_ERR(eq->mtr)) {
+		err = PTR_ERR(eq->mtr);
 		dev_err(hr_dev->dev, "failed to alloc EQE mtr, err %d\n", err);
+	}
 
 	return err;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 55b9283bfc6f..3902243cac96 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -109,23 +109,23 @@ static int alloc_mr_pbl(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr,
 	buf_attr.adaptive = !is_fast;
 	buf_attr.type = MTR_PBL;
 
-	err = hns_roce_mtr_create(hr_dev, &mr->pbl_mtr, &buf_attr,
-				  hr_dev->caps.pbl_ba_pg_sz + PAGE_SHIFT,
-				  udata, start);
-	if (err) {
+	mr->pbl_mtr = hns_roce_mtr_create(hr_dev, &buf_attr,
+		hr_dev->caps.pbl_ba_pg_sz + PAGE_SHIFT, udata, start);
+	if (IS_ERR(mr->pbl_mtr)) {
+		err = PTR_ERR(mr->pbl_mtr);
 		ibdev_err(ibdev, "failed to alloc pbl mtr, ret = %d.\n", err);
 		return err;
 	}
 
-	mr->npages = mr->pbl_mtr.hem_cfg.buf_pg_count;
+	mr->npages = mr->pbl_mtr->hem_cfg.buf_pg_count;
 	mr->pbl_hop_num = buf_attr.region[0].hopnum;
 
-	return err;
+	return 0;
 }
 
 static void free_mr_pbl(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr)
 {
-	hns_roce_mtr_destroy(hr_dev, &mr->pbl_mtr);
+	hns_roce_mtr_destroy(hr_dev, mr->pbl_mtr);
 }
 
 static void hns_roce_mr_free(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr)
@@ -196,18 +196,22 @@ struct ib_mr *hns_roce_get_dma_mr(struct ib_pd *pd, int acc)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(pd->device);
 	struct hns_roce_mr *mr;
-	int ret;
+	int ret = -ENOMEM;
 
 	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
 	if (!mr)
 		return  ERR_PTR(-ENOMEM);
 
+	mr->pbl_mtr = kvzalloc(sizeof(*mr->pbl_mtr), GFP_KERNEL);
+	if (!mr->pbl_mtr)
+		goto err_mtr;
+
 	mr->type = MR_TYPE_DMA;
 	mr->pd = to_hr_pd(pd)->pdn;
 	mr->access = acc;
 
 	/* Allocate memory region key */
-	hns_roce_hem_list_init(&mr->pbl_mtr.hem_list);
+	hns_roce_hem_list_init(&mr->pbl_mtr->hem_list);
 	ret = alloc_mr_key(hr_dev, mr);
 	if (ret)
 		goto err_free;
@@ -223,6 +227,8 @@ struct ib_mr *hns_roce_get_dma_mr(struct ib_pd *pd, int acc)
 	free_mr_key(hr_dev, mr);
 
 err_free:
+	kvfree(mr->pbl_mtr);
+err_mtr:
 	kfree(mr);
 	return ERR_PTR(ret);
 }
@@ -426,7 +432,7 @@ static int hns_roce_set_page(struct ib_mr *ibmr, u64 addr)
 {
 	struct hns_roce_mr *mr = to_hr_mr(ibmr);
 
-	if (likely(mr->npages < mr->pbl_mtr.hem_cfg.buf_pg_count)) {
+	if (likely(mr->npages < mr->pbl_mtr->hem_cfg.buf_pg_count)) {
 		mr->page_list[mr->npages++] = addr;
 		return 0;
 	}
@@ -441,7 +447,7 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibmr->device);
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_mr *mr = to_hr_mr(ibmr);
-	struct hns_roce_mtr *mtr = &mr->pbl_mtr;
+	struct hns_roce_mtr *mtr = mr->pbl_mtr;
 	int ret, sg_num = 0;
 
 	if (!IS_ALIGNED(sg_offset, HNS_ROCE_FRMR_ALIGN_SIZE) ||
@@ -450,7 +456,7 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 		return sg_num;
 
 	mr->npages = 0;
-	mr->page_list = kvcalloc(mr->pbl_mtr.hem_cfg.buf_pg_count,
+	mr->page_list = kvcalloc(mr->pbl_mtr->hem_cfg.buf_pg_count,
 				 sizeof(dma_addr_t), GFP_KERNEL);
 	if (!mr->page_list)
 		return sg_num;
@@ -458,7 +464,7 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 	sg_num = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset_p, hns_roce_set_page);
 	if (sg_num < 1) {
 		ibdev_err(ibdev, "failed to store sg pages %u %u, cnt = %d.\n",
-			  mr->npages, mr->pbl_mtr.hem_cfg.buf_pg_count, sg_num);
+			  mr->npages, mr->pbl_mtr->hem_cfg.buf_pg_count, sg_num);
 		goto err_page_list;
 	}
 
@@ -471,7 +477,7 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 		ibdev_err(ibdev, "failed to map sg mtr, ret = %d.\n", ret);
 		sg_num = 0;
 	} else {
-		mr->pbl_mtr.hem_cfg.buf_pg_shift = (u32)ilog2(ibmr->page_size);
+		mr->pbl_mtr->hem_cfg.buf_pg_shift = (u32)ilog2(ibmr->page_size);
 	}
 
 err_page_list:
@@ -1132,20 +1138,25 @@ static void mtr_free_mtt(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr)
  * hns_roce_mtr_create - Create hns memory translate region.
  *
  * @hr_dev: RoCE device struct pointer
- * @mtr: memory translate region
  * @buf_attr: buffer attribute for creating mtr
  * @ba_page_shift: page shift for multi-hop base address table
  * @udata: user space context, if it's NULL, means kernel space
  * @user_addr: userspace virtual address to start at
  */
-int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
-			struct hns_roce_buf_attr *buf_attr,
-			unsigned int ba_page_shift, struct ib_udata *udata,
-			unsigned long user_addr)
+struct hns_roce_mtr *hns_roce_mtr_create(struct hns_roce_dev *hr_dev,
+					 struct hns_roce_buf_attr *buf_attr,
+					 unsigned int ba_page_shift,
+					 struct ib_udata *udata,
+					 unsigned long user_addr)
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct hns_roce_mtr *mtr;
 	int ret;
 
+	mtr = kvzalloc(sizeof(*mtr), GFP_KERNEL);
+	if (!mtr)
+		return ERR_PTR(-ENOMEM);
+
 	/* The caller has its own buffer list and invokes the hns_roce_mtr_map()
 	 * to finish the MTT configuration.
 	 */
@@ -1157,7 +1168,7 @@ int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		if (ret) {
 			ibdev_err(ibdev,
 				  "failed to alloc mtr bufs, ret = %d.\n", ret);
-			return ret;
+			goto err_out;
 		}
 
 		ret = get_best_page_shift(hr_dev, mtr, buf_attr);
@@ -1180,7 +1191,7 @@ int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 	}
 
 	if (buf_attr->mtt_only)
-		return 0;
+		return mtr;
 
 	/* Write buffer's dma address to MTT */
 	ret = mtr_map_bufs(hr_dev, mtr);
@@ -1189,14 +1200,15 @@ int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		goto err_alloc_mtt;
 	}
 
-	return 0;
+	return mtr;
 
 err_alloc_mtt:
 	mtr_free_mtt(hr_dev, mtr);
 err_init_buf:
 	mtr_free_bufs(hr_dev, mtr);
-
-	return ret;
+err_out:
+	kvfree(mtr);
+	return ERR_PTR(ret);
 }
 
 void hns_roce_mtr_destroy(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr)
@@ -1206,4 +1218,5 @@ void hns_roce_mtr_destroy(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr)
 
 	/* free buffers */
 	mtr_free_bufs(hr_dev, mtr);
+	kvfree(mtr);
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 9e2e76c59406..62fc9a3c784e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -780,10 +780,11 @@ static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 		ibdev_err(ibdev, "failed to split WQE buf, ret = %d.\n", ret);
 		goto err_inline;
 	}
-	ret = hns_roce_mtr_create(hr_dev, &hr_qp->mtr, &buf_attr,
-				  PAGE_SHIFT + hr_dev->caps.mtt_ba_pg_sz,
-				  udata, addr);
-	if (ret) {
+	hr_qp->mtr = hns_roce_mtr_create(hr_dev, &buf_attr,
+					 PAGE_SHIFT + hr_dev->caps.mtt_ba_pg_sz,
+					 udata, addr);
+	if (IS_ERR(hr_qp->mtr)) {
+		ret = PTR_ERR(hr_qp->mtr);
 		ibdev_err(ibdev, "failed to create WQE mtr, ret = %d.\n", ret);
 		goto err_inline;
 	}
@@ -800,7 +801,7 @@ static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 
 static void free_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 {
-	hns_roce_mtr_destroy(hr_dev, &hr_qp->mtr);
+	hns_roce_mtr_destroy(hr_dev, hr_qp->mtr);
 }
 
 static inline bool user_qp_has_sdb(struct hns_roce_dev *hr_dev,
@@ -1531,7 +1532,7 @@ void hns_roce_unlock_cqs(struct hns_roce_cq *send_cq,
 
 static inline void *get_wqe(struct hns_roce_qp *hr_qp, u32 offset)
 {
-	return hns_roce_buf_offset(hr_qp->mtr.kmem, offset);
+	return hns_roce_buf_offset(hr_qp->mtr->kmem, offset);
 }
 
 void *hns_roce_get_recv_wqe(struct hns_roce_qp *hr_qp, unsigned int n)
diff --git a/drivers/infiniband/hw/hns/hns_roce_restrack.c b/drivers/infiniband/hw/hns/hns_roce_restrack.c
index 3b0c0ffa6a29..db38a2045efe 100644
--- a/drivers/infiniband/hw/hns/hns_roce_restrack.c
+++ b/drivers/infiniband/hw/hns/hns_roce_restrack.c
@@ -291,11 +291,11 @@ int hns_roce_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr)
 		goto err;
 
 	if (rdma_nl_put_driver_u32_hex(msg, "ba_pg_shift",
-				       hr_mr->pbl_mtr.hem_cfg.ba_pg_shift))
+				       hr_mr->pbl_mtr->hem_cfg.ba_pg_shift))
 		goto err;
 
 	if (rdma_nl_put_driver_u32_hex(msg, "buf_pg_shift",
-				       hr_mr->pbl_mtr.hem_cfg.buf_pg_shift))
+				       hr_mr->pbl_mtr->hem_cfg.buf_pg_shift))
 		goto err;
 
 	nla_nest_end(msg, table_attr);
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 70c06ef65603..6685e5a1afd2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -179,10 +179,10 @@ static int alloc_srq_idx(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 	buf_attr.region[0].hopnum = hr_dev->caps.idx_hop_num;
 	buf_attr.region_count = 1;
 
-	ret = hns_roce_mtr_create(hr_dev, &idx_que->mtr, &buf_attr,
-				  hr_dev->caps.idx_ba_pg_sz + PAGE_SHIFT,
-				  udata, addr);
-	if (ret) {
+	idx_que->mtr = hns_roce_mtr_create(hr_dev, &buf_attr,
+		hr_dev->caps.idx_ba_pg_sz + PAGE_SHIFT, udata, addr);
+	if (IS_ERR(idx_que->mtr)) {
+		ret = PTR_ERR(idx_que->mtr);
 		ibdev_err(ibdev,
 			  "failed to alloc SRQ idx mtr, ret = %d.\n", ret);
 		return ret;
@@ -202,7 +202,7 @@ static int alloc_srq_idx(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 
 	return 0;
 err_idx_mtr:
-	hns_roce_mtr_destroy(hr_dev, &idx_que->mtr);
+	hns_roce_mtr_destroy(hr_dev, idx_que->mtr);
 
 	return ret;
 }
@@ -213,7 +213,7 @@ static void free_srq_idx(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 
 	bitmap_free(idx_que->bitmap);
 	idx_que->bitmap = NULL;
-	hns_roce_mtr_destroy(hr_dev, &idx_que->mtr);
+	hns_roce_mtr_destroy(hr_dev, idx_que->mtr);
 }
 
 static int alloc_srq_wqe_buf(struct hns_roce_dev *hr_dev,
@@ -222,7 +222,7 @@ static int alloc_srq_wqe_buf(struct hns_roce_dev *hr_dev,
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_buf_attr buf_attr = {};
-	int ret;
+	int ret = 0;
 
 	srq->wqe_shift = ilog2(roundup_pow_of_two(max(HNS_ROCE_SGE_SIZE,
 						      HNS_ROCE_SGE_SIZE *
@@ -234,12 +234,13 @@ static int alloc_srq_wqe_buf(struct hns_roce_dev *hr_dev,
 	buf_attr.region[0].hopnum = hr_dev->caps.srqwqe_hop_num;
 	buf_attr.region_count = 1;
 
-	ret = hns_roce_mtr_create(hr_dev, &srq->buf_mtr, &buf_attr,
-				  hr_dev->caps.srqwqe_ba_pg_sz + PAGE_SHIFT,
-				  udata, addr);
-	if (ret)
+	srq->buf_mtr = hns_roce_mtr_create(hr_dev, &buf_attr,
+		hr_dev->caps.srqwqe_ba_pg_sz + PAGE_SHIFT, udata, addr);
+	if (IS_ERR(srq->buf_mtr)) {
+		ret = PTR_ERR(srq->buf_mtr);
 		ibdev_err(ibdev,
 			  "failed to alloc SRQ buf mtr, ret = %d.\n", ret);
+	}
 
 	return ret;
 }
@@ -247,7 +248,7 @@ static int alloc_srq_wqe_buf(struct hns_roce_dev *hr_dev,
 static void free_srq_wqe_buf(struct hns_roce_dev *hr_dev,
 			     struct hns_roce_srq *srq)
 {
-	hns_roce_mtr_destroy(hr_dev, &srq->buf_mtr);
+	hns_roce_mtr_destroy(hr_dev, srq->buf_mtr);
 }
 
 static int alloc_srq_wrid(struct hns_roce_srq *srq)
-- 
2.33.0


