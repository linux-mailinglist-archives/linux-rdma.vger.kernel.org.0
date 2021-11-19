Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E57945703E
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Nov 2021 15:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbhKSOJo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Nov 2021 09:09:44 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:15840 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbhKSOJn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Nov 2021 09:09:43 -0500
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HwdkK5ZFYz917T;
        Fri, 19 Nov 2021 22:06:17 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 19 Nov 2021 22:06:40 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 19 Nov 2021 22:06:40 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 4/9] RDMA/hns: Correct the type of variables participating in the shift operation
Date:   Fri, 19 Nov 2021 22:02:03 +0800
Message-ID: <20211119140208.40416-5-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211119140208.40416-1-liangwenpeng@huawei.com>
References: <20211119140208.40416-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xinhao Liu <liuxinhao5@hisilicon.com>

The type of the variable participating in the shift operation should be an
unsigned type instead of a signed type.

Signed-off-by: Xinhao Liu <liuxinhao5@hisilicon.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 18 +++++++++---------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  2 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c     |  8 ++++----
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  2 +-
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 4c3b2e8b0d07..e35164ae7376 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -374,8 +374,8 @@ struct hns_roce_wq {
 	u32		wqe_cnt;  /* WQE num */
 	u32		max_gs;
 	u32		rsv_sge;
-	int		offset;
-	int		wqe_shift; /* WQE size */
+	u32		offset;
+	u32		wqe_shift; /* WQE size */
 	u32		head;
 	u32		tail;
 	void __iomem	*db_reg;
@@ -383,8 +383,8 @@ struct hns_roce_wq {
 
 struct hns_roce_sge {
 	unsigned int	sge_cnt; /* SGE num */
-	int		offset;
-	int		sge_shift; /* SGE size */
+	u32		offset;
+	u32		sge_shift; /* SGE size */
 };
 
 struct hns_roce_buf_list {
@@ -468,7 +468,7 @@ struct hns_roce_cq {
 
 struct hns_roce_idx_que {
 	struct hns_roce_mtr		mtr;
-	int				entry_shift;
+	u32				entry_shift;
 	unsigned long			*bitmap;
 	u32				head;
 	u32				tail;
@@ -480,7 +480,7 @@ struct hns_roce_srq {
 	u32			wqe_cnt;
 	int			max_gs;
 	u32			rsv_sge;
-	int			wqe_shift;
+	u32			wqe_shift;
 	u32			cqn;
 	u32			xrcdn;
 	void __iomem		*db_reg;
@@ -767,7 +767,7 @@ struct hns_roce_caps {
 	u32		reserved_qps;
 	int		num_qpc_timer;
 	int		num_cqc_timer;
-	int		num_srqs;
+	u32		num_srqs;
 	u32		max_wqes;
 	u32		max_srq_wrs;
 	u32		max_srq_sges;
@@ -781,7 +781,7 @@ struct hns_roce_caps {
 	u32		min_cqes;
 	u32		min_wqes;
 	u32		reserved_cqs;
-	int		reserved_srqs;
+	u32		reserved_srqs;
 	int		num_aeq_vectors;
 	int		num_comp_vectors;
 	int		num_other_vectors;
@@ -1158,7 +1158,7 @@ void hns_roce_cmd_use_polling(struct hns_roce_dev *hr_dev);
 /* hns roce hw need current block and next block addr from mtt */
 #define MTT_MIN_COUNT	 2
 int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
-		      int offset, u64 *mtt_buf, int mtt_max, u64 *base_addr);
+		      u32 offset, u64 *mtt_buf, int mtt_max, u64 *base_addr);
 int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 			struct hns_roce_buf_attr *buf_attr,
 			unsigned int page_shift, struct ib_udata *udata,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 42bbb4278273..ae4f6fa8ad71 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5817,7 +5817,7 @@ static void hns_roce_v2_int_mask_enable(struct hns_roce_dev *hr_dev,
 	roce_write(hr_dev, ROCEE_VF_ABN_INT_CFG_REG, enable_flag);
 }
 
-static void hns_roce_v2_destroy_eqc(struct hns_roce_dev *hr_dev, int eqn)
+static void hns_roce_v2_destroy_eqc(struct hns_roce_dev *hr_dev, u32 eqn)
 {
 	struct device *dev = hr_dev->dev;
 	int ret;
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index bf47191ce38b..8de899372567 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -824,11 +824,11 @@ int hns_roce_mtr_map(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 }
 
 int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
-		      int offset, u64 *mtt_buf, int mtt_max, u64 *base_addr)
+		      u32 offset, u64 *mtt_buf, int mtt_max, u64 *base_addr)
 {
 	struct hns_roce_hem_cfg *cfg = &mtr->hem_cfg;
 	int mtt_count, left;
-	int start_index;
+	u32 start_index;
 	int total = 0;
 	__le64 *mtts;
 	u32 npage;
@@ -884,10 +884,10 @@ int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 static int mtr_init_buf_cfg(struct hns_roce_dev *hr_dev,
 			    struct hns_roce_buf_attr *attr,
 			    struct hns_roce_hem_cfg *cfg,
-			    unsigned int *buf_page_shift, int unalinged_size)
+			    unsigned int *buf_page_shift, u64 unalinged_size)
 {
 	struct hns_roce_buf_region *r;
-	int first_region_padding;
+	u64 first_region_padding;
 	int page_cnt, region_cnt;
 	unsigned int page_shift;
 	size_t buf_size;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 9af4509894e6..4fcab1611548 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1391,7 +1391,7 @@ void hns_roce_unlock_cqs(struct hns_roce_cq *send_cq,
 	}
 }
 
-static inline void *get_wqe(struct hns_roce_qp *hr_qp, int offset)
+static inline void *get_wqe(struct hns_roce_qp *hr_qp, u32 offset)
 {
 	return hns_roce_buf_offset(hr_qp->mtr.kmem, offset);
 }
-- 
2.33.0

