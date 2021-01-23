Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091B030145A
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Jan 2021 10:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbhAWJvC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 23 Jan 2021 04:51:02 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11432 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbhAWJvA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 23 Jan 2021 04:51:00 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DNBDH4r2nzj9lQ;
        Sat, 23 Jan 2021 17:49:19 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Sat, 23 Jan 2021 17:50:10 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v2 for-next 2/3] RDMA/hns: Optimize the MR registration process
Date:   Sat, 23 Jan 2021 17:48:01 +0800
Message-ID: <1611395282-991-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1611395282-991-1-git-send-email-liweihang@huawei.com>
References: <1611395282-991-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

When creating or re-registering an MR, storing the PDN, access flag and
IOVA information ASAP can simplify the number of parameters passed into
the subsequent process.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |   4 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  22 ++----
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 110 ++++++++++------------------
 3 files changed, 47 insertions(+), 89 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index ffed82d..f62851f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -914,8 +914,7 @@ struct hns_roce_hw {
 	int (*write_mtpt)(struct hns_roce_dev *hr_dev, void *mb_buf,
 			  struct hns_roce_mr *mr, unsigned long mtpt_idx);
 	int (*rereg_write_mtpt)(struct hns_roce_dev *hr_dev,
-				struct hns_roce_mr *mr, int flags, u32 pdn,
-				int mr_access_flags, u64 iova, u64 size,
+				struct hns_roce_mr *mr, int flags,
 				void *mb_buf);
 	int (*frmr_write_mtpt)(struct hns_roce_dev *hr_dev, void *mb_buf,
 			       struct hns_roce_mr *mr);
@@ -1284,7 +1283,6 @@ u8 hns_get_gid_index(struct hns_roce_dev *hr_dev, u8 port, int gid_index);
 void hns_roce_handle_device_err(struct hns_roce_dev *hr_dev);
 int hns_roce_init(struct hns_roce_dev *hr_dev);
 void hns_roce_exit(struct hns_roce_dev *hr_dev);
-
 int hns_roce_fill_res_cq_entry(struct sk_buff *msg,
 			       struct ib_cq *ib_cq);
 #endif /* _HNS_ROCE_DEVICE_H */
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 110354b..16ef631 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2927,20 +2927,17 @@ static int hns_roce_v2_write_mtpt(struct hns_roce_dev *hr_dev,
 
 static int hns_roce_v2_rereg_write_mtpt(struct hns_roce_dev *hr_dev,
 					struct hns_roce_mr *mr, int flags,
-					u32 pdn, int mr_access_flags, u64 iova,
-					u64 size, void *mb_buf)
+					void *mb_buf)
 {
 	struct hns_roce_v2_mpt_entry *mpt_entry = mb_buf;
+	u32 mr_access_flags = mr->access;
 	int ret = 0;
 
 	roce_set_field(mpt_entry->byte_4_pd_hop_st, V2_MPT_BYTE_4_MPT_ST_M,
 		       V2_MPT_BYTE_4_MPT_ST_S, V2_MPT_ST_VALID);
 
-	if (flags & IB_MR_REREG_PD) {
-		roce_set_field(mpt_entry->byte_4_pd_hop_st, V2_MPT_BYTE_4_PD_M,
-			       V2_MPT_BYTE_4_PD_S, pdn);
-		mr->pd = pdn;
-	}
+	roce_set_field(mpt_entry->byte_4_pd_hop_st, V2_MPT_BYTE_4_PD_M,
+		       V2_MPT_BYTE_4_PD_S, mr->pd);
 
 	if (flags & IB_MR_REREG_ACCESS) {
 		roce_set_bit(mpt_entry->byte_8_mw_cnt_en,
@@ -2958,13 +2955,10 @@ static int hns_roce_v2_rereg_write_mtpt(struct hns_roce_dev *hr_dev,
 	}
 
 	if (flags & IB_MR_REREG_TRANS) {
-		mpt_entry->va_l = cpu_to_le32(lower_32_bits(iova));
-		mpt_entry->va_h = cpu_to_le32(upper_32_bits(iova));
-		mpt_entry->len_l = cpu_to_le32(lower_32_bits(size));
-		mpt_entry->len_h = cpu_to_le32(upper_32_bits(size));
-
-		mr->iova = iova;
-		mr->size = size;
+		mpt_entry->va_l = cpu_to_le32(lower_32_bits(mr->iova));
+		mpt_entry->va_h = cpu_to_le32(upper_32_bits(mr->iova));
+		mpt_entry->len_l = cpu_to_le32(lower_32_bits(mr->size));
+		mpt_entry->len_h = cpu_to_le32(upper_32_bits(mr->size));
 
 		ret = set_mtpt_pbl(hr_dev, mpt_entry, mr);
 	}
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 45ceeab..5a2a557 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -66,8 +66,7 @@ int hns_roce_hw_destroy_mpt(struct hns_roce_dev *hr_dev,
 				 HNS_ROCE_CMD_TIMEOUT_MSECS);
 }
 
-static int alloc_mr_key(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr,
-			u32 pd, u64 iova, u64 size, u32 access)
+static int alloc_mr_key(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr)
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	unsigned long obj = 0;
@@ -82,11 +81,6 @@ static int alloc_mr_key(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr,
 		return -ENOMEM;
 	}
 
-	mr->iova = iova;			/* MR va starting addr */
-	mr->size = size;			/* MR addr range */
-	mr->pd = pd;				/* MR num */
-	mr->access = access;			/* MR access permit */
-	mr->enabled = 0;			/* MR active status */
 	mr->key = hw_index_to_key(obj);		/* MR key */
 
 	err = hns_roce_table_get(hr_dev, &hr_dev->mr_table.mtpt_table, obj);
@@ -110,8 +104,7 @@ static void free_mr_key(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr)
 }
 
 static int alloc_mr_pbl(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr,
-			size_t length, struct ib_udata *udata, u64 start,
-			int access)
+			struct ib_udata *udata, u64 start)
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	bool is_fast = mr->type == MR_TYPE_FRMR;
@@ -121,10 +114,10 @@ static int alloc_mr_pbl(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr,
 	mr->pbl_hop_num = is_fast ? 1 : hr_dev->caps.pbl_hop_num;
 	buf_attr.page_shift = is_fast ? PAGE_SHIFT :
 			      hr_dev->caps.pbl_buf_pg_sz + PAGE_SHIFT;
-	buf_attr.region[0].size = length;
+	buf_attr.region[0].size = mr->size;
 	buf_attr.region[0].hopnum = mr->pbl_hop_num;
 	buf_attr.region_count = 1;
-	buf_attr.user_access = access;
+	buf_attr.user_access = mr->access;
 	/* fast MR's buffer is alloced before mapping, not at creation */
 	buf_attr.mtt_only = is_fast;
 
@@ -196,9 +189,6 @@ static int hns_roce_mr_enable(struct hns_roce_dev *hr_dev,
 	}
 
 	mr->enabled = 1;
-	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
-
-	return 0;
 
 err_page:
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
@@ -236,14 +226,16 @@ struct ib_mr *hns_roce_get_dma_mr(struct ib_pd *pd, int acc)
 		return  ERR_PTR(-ENOMEM);
 
 	mr->type = MR_TYPE_DMA;
+	mr->pd = to_hr_pd(pd)->pdn;
+	mr->access = acc;
 
 	/* Allocate memory region key */
 	hns_roce_hem_list_init(&mr->pbl_mtr.hem_list);
-	ret = alloc_mr_key(hr_dev, mr, to_hr_pd(pd)->pdn, 0, 0, acc);
+	ret = alloc_mr_key(hr_dev, mr);
 	if (ret)
 		goto err_free;
 
-	ret = hns_roce_mr_enable(to_hr_dev(pd->device), mr);
+	ret = hns_roce_mr_enable(hr_dev, mr);
 	if (ret)
 		goto err_mr;
 
@@ -270,13 +262,17 @@ struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
+	mr->iova = virt_addr;
+	mr->size = length;
+	mr->pd = to_hr_pd(pd)->pdn;
+	mr->access = access_flags;
 	mr->type = MR_TYPE_MR;
-	ret = alloc_mr_key(hr_dev, mr, to_hr_pd(pd)->pdn, virt_addr, length,
-			   access_flags);
+
+	ret = alloc_mr_key(hr_dev, mr);
 	if (ret)
 		goto err_alloc_mr;
 
-	ret = alloc_mr_pbl(hr_dev, mr, length, udata, start, access_flags);
+	ret = alloc_mr_pbl(hr_dev, mr, udata, start);
 	if (ret)
 		goto err_alloc_key;
 
@@ -298,35 +294,6 @@ struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	return ERR_PTR(ret);
 }
 
-static int rereg_mr_trans(struct ib_mr *ibmr, int flags,
-			  u64 start, u64 length,
-			  u64 virt_addr, int mr_access_flags,
-			  struct hns_roce_cmd_mailbox *mailbox,
-			  u32 pdn, struct ib_udata *udata)
-{
-	struct hns_roce_dev *hr_dev = to_hr_dev(ibmr->device);
-	struct ib_device *ibdev = &hr_dev->ib_dev;
-	struct hns_roce_mr *mr = to_hr_mr(ibmr);
-	int ret;
-
-	free_mr_pbl(hr_dev, mr);
-	ret = alloc_mr_pbl(hr_dev, mr, length, udata, start, mr_access_flags);
-	if (ret) {
-		ibdev_err(ibdev, "failed to create mr PBL, ret = %d.\n", ret);
-		return ret;
-	}
-
-	ret = hr_dev->hw->rereg_write_mtpt(hr_dev, mr, flags, pdn,
-					   mr_access_flags, virt_addr,
-					   length, mailbox->buf);
-	if (ret) {
-		ibdev_err(ibdev, "failed to write mtpt, ret = %d.\n", ret);
-		free_mr_pbl(hr_dev, mr);
-	}
-
-	return ret;
-}
-
 struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
 				     u64 length, u64 virt_addr,
 				     int mr_access_flags, struct ib_pd *pd,
@@ -337,7 +304,6 @@ struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
 	struct hns_roce_mr *mr = to_hr_mr(ibmr);
 	struct hns_roce_cmd_mailbox *mailbox;
 	unsigned long mtpt_idx;
-	u32 pdn = 0;
 	int ret;
 
 	if (!mr->enabled)
@@ -359,23 +325,29 @@ struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
 		ibdev_warn(ib_dev, "failed to destroy MPT, ret = %d.\n", ret);
 
 	mr->enabled = 0;
+	mr->iova = virt_addr;
+	mr->size = length;
 
 	if (flags & IB_MR_REREG_PD)
-		pdn = to_hr_pd(pd)->pdn;
+		mr->pd = to_hr_pd(pd)->pdn;
+
+	if (flags & IB_MR_REREG_ACCESS)
+		mr->access = mr_access_flags;
 
 	if (flags & IB_MR_REREG_TRANS) {
-		ret = rereg_mr_trans(ibmr, flags,
-				     start, length,
-				     virt_addr, mr_access_flags,
-				     mailbox, pdn, udata);
-		if (ret)
-			goto free_cmd_mbox;
-	} else {
-		ret = hr_dev->hw->rereg_write_mtpt(hr_dev, mr, flags, pdn,
-						   mr_access_flags, virt_addr,
-						   length, mailbox->buf);
-		if (ret)
+		free_mr_pbl(hr_dev, mr);
+		ret = alloc_mr_pbl(hr_dev, mr, udata, start);
+		if (ret) {
+			ibdev_err(ib_dev, "failed to alloc mr PBL, ret = %d.\n",
+				  ret);
 			goto free_cmd_mbox;
+		}
+	}
+
+	ret = hr_dev->hw->rereg_write_mtpt(hr_dev, mr, flags, mailbox->buf);
+	if (ret) {
+		ibdev_err(ib_dev, "failed to write mtpt, ret = %d.\n", ret);
+		goto free_cmd_mbox;
 	}
 
 	ret = hns_roce_hw_create_mpt(hr_dev, mailbox, mtpt_idx);
@@ -385,12 +357,6 @@ struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
 	}
 
 	mr->enabled = 1;
-	if (flags & IB_MR_REREG_ACCESS)
-		mr->access = mr_access_flags;
-
-	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
-
-	return NULL;
 
 free_cmd_mbox:
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
@@ -420,7 +386,6 @@ struct ib_mr *hns_roce_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 	struct hns_roce_dev *hr_dev = to_hr_dev(pd->device);
 	struct device *dev = hr_dev->dev;
 	struct hns_roce_mr *mr;
-	u64 length;
 	int ret;
 
 	if (mr_type != IB_MR_TYPE_MEM_REG)
@@ -437,14 +402,15 @@ struct ib_mr *hns_roce_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 		return ERR_PTR(-ENOMEM);
 
 	mr->type = MR_TYPE_FRMR;
+	mr->pd = to_hr_pd(pd)->pdn;
+	mr->size = max_num_sg * (1 << PAGE_SHIFT);
 
 	/* Allocate memory region key */
-	length = max_num_sg * (1 << PAGE_SHIFT);
-	ret = alloc_mr_key(hr_dev, mr, to_hr_pd(pd)->pdn, 0, length, 0);
+	ret = alloc_mr_key(hr_dev, mr);
 	if (ret)
 		goto err_free;
 
-	ret = alloc_mr_pbl(hr_dev, mr, length, NULL, 0, 0);
+	ret = alloc_mr_pbl(hr_dev, mr, NULL, 0);
 	if (ret)
 		goto err_key;
 
@@ -453,7 +419,7 @@ struct ib_mr *hns_roce_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 		goto err_pbl;
 
 	mr->ibmr.rkey = mr->ibmr.lkey = mr->key;
-	mr->ibmr.length = length;
+	mr->ibmr.length = mr->size;
 
 	return &mr->ibmr;
 
-- 
2.8.1

