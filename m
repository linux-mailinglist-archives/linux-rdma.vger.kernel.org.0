Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01631BBBD8
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2020 13:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgD1LEC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Apr 2020 07:04:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3364 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726364AbgD1LEC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Apr 2020 07:04:02 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 835E223496FA36EC4AD6;
        Tue, 28 Apr 2020 19:03:58 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Apr 2020 19:03:48 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v4 for-next 1/5] RDMA/hns: Optimize PBL buffer allocation process
Date:   Tue, 28 Apr 2020 19:03:39 +0800
Message-ID: <1588071823-40200-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1588071823-40200-1-git-send-email-liweihang@huawei.com>
References: <1588071823-40200-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

PBL table has its own implementation for multi-hop addressing currently,
but for the hardware, all table's addressing use the same logic, there is
no need to implement repeatedly. So optimize the PBL buffer allocation
process by using the mtr's interfaces.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  19 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  45 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  76 +--
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 726 ++++++----------------------
 4 files changed, 197 insertions(+), 669 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index ecbfeb6..0ef5c2e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -403,30 +403,17 @@ struct hns_roce_mw {
 
 struct hns_roce_mr {
 	struct ib_mr		ibmr;
-	struct ib_umem		*umem;
 	u64			iova; /* MR's virtual orignal addr */
 	u64			size; /* Address range of MR */
 	u32			key; /* Key of MR */
 	u32			pd;   /* PD num of MR */
 	u32			access;	/* Access permission of MR */
-	u32			npages;
 	int			enabled; /* MR's active status */
 	int			type;	/* MR's register type */
-	u64			*pbl_buf;	/* MR's PBL space */
-	dma_addr_t		pbl_dma_addr;	/* MR's PBL space PA */
-	u32			pbl_size;	/* PA number in the PBL */
-	u64			pbl_ba;		/* page table address */
-	u32			l0_chunk_last_num;	/* L0 last number */
-	u32			l1_chunk_last_num;	/* L1 last number */
-	u64			**pbl_bt_l2;	/* PBL BT L2 */
-	u64			**pbl_bt_l1;	/* PBL BT L1 */
-	u64			*pbl_bt_l0;	/* PBL BT L0 */
-	dma_addr_t		*pbl_l2_dma_addr;	/* PBL BT L2 dma addr */
-	dma_addr_t		*pbl_l1_dma_addr;	/* PBL BT L1 dma addr */
-	dma_addr_t		pbl_l0_dma_addr;	/* PBL BT L0 dma addr */
-	u32			pbl_ba_pg_sz;	/* BT chunk page size */
-	u32			pbl_buf_pg_sz;	/* buf chunk page size */
 	u32			pbl_hop_num;	/* multi-hop number */
+	struct hns_roce_mtr	pbl_mtr;
+	u32			npages;
+	dma_addr_t		*page_list;
 };
 
 struct hns_roce_mr_table {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 49775cd..b4b98e8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -1099,7 +1099,6 @@ static int hns_roce_v1_dereg_mr(struct hns_roce_dev *hr_dev,
 	struct completion comp;
 	long end = HNS_ROCE_V1_FREE_MR_TIMEOUT_MSECS;
 	unsigned long start = jiffies;
-	int npages;
 	int ret = 0;
 
 	priv = (struct hns_roce_v1_priv *)hr_dev->priv;
@@ -1146,17 +1145,9 @@ static int hns_roce_v1_dereg_mr(struct hns_roce_dev *hr_dev,
 	dev_dbg(dev, "Free mr 0x%x use 0x%x us.\n",
 		mr->key, jiffies_to_usecs(jiffies) - jiffies_to_usecs(start));
 
-	if (mr->size != ~0ULL) {
-		npages = ib_umem_page_count(mr->umem);
-		dma_free_coherent(dev, npages * 8, mr->pbl_buf,
-				  mr->pbl_dma_addr);
-	}
-
 	hns_roce_bitmap_free(&hr_dev->mr_table.mtpt_bitmap,
 			     key_to_hw_index(mr->key), 0);
-
-	ib_umem_release(mr->umem);
-
+	hns_roce_mtr_destroy(hr_dev, &mr->pbl_mtr);
 	kfree(mr);
 
 	return ret;
@@ -1826,9 +1817,12 @@ static void hns_roce_v1_set_mtu(struct hns_roce_dev *hr_dev, u8 phy_port,
 static int hns_roce_v1_write_mtpt(void *mb_buf, struct hns_roce_mr *mr,
 				  unsigned long mtpt_idx)
 {
+	struct hns_roce_dev *hr_dev = to_hr_dev(mr->ibmr.device);
+	u64 pages[HNS_ROCE_MAX_INNER_MTPT_NUM] = { 0 };
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_v1_mpt_entry *mpt_entry;
-	struct sg_dma_page_iter sg_iter;
-	u64 *pages;
+	dma_addr_t pbl_ba;
+	int count;
 	int i;
 
 	/* MPT filled into mailbox buf */
@@ -1878,22 +1872,15 @@ static int hns_roce_v1_write_mtpt(void *mb_buf, struct hns_roce_mr *mr,
 	if (mr->type == MR_TYPE_DMA)
 		return 0;
 
-	pages = (u64 *) __get_free_page(GFP_KERNEL);
-	if (!pages)
-		return -ENOMEM;
-
-	i = 0;
-	for_each_sg_dma_page(mr->umem->sg_head.sgl, &sg_iter, mr->umem->nmap, 0) {
-		pages[i] = ((u64)sg_page_iter_dma_address(&sg_iter)) >> 12;
-
-		/* Directly record to MTPT table firstly 7 entry */
-		if (i >= HNS_ROCE_MAX_INNER_MTPT_NUM)
-			break;
-		i++;
+	count = hns_roce_mtr_find(hr_dev, &mr->pbl_mtr, 0, pages,
+				  ARRAY_SIZE(pages), &pbl_ba);
+	if (count < 1) {
+		ibdev_err(ibdev, "failed to find PBL mtr, count = %d.", count);
+		return -ENOBUFS;
 	}
 
 	/* Register user mr */
-	for (i = 0; i < HNS_ROCE_MAX_INNER_MTPT_NUM; i++) {
+	for (i = 0; i < count; i++) {
 		switch (i) {
 		case 0:
 			mpt_entry->pa0_l = cpu_to_le32((u32)(pages[i]));
@@ -1959,13 +1946,9 @@ static int hns_roce_v1_write_mtpt(void *mb_buf, struct hns_roce_mr *mr,
 		}
 	}
 
-	free_page((unsigned long) pages);
-
-	mpt_entry->pbl_addr_l = cpu_to_le32((u32)(mr->pbl_dma_addr));
-
+	mpt_entry->pbl_addr_l = cpu_to_le32(pbl_ba);
 	roce_set_field(mpt_entry->mpt_byte_12, MPT_BYTE_12_PBL_ADDR_H_M,
-		       MPT_BYTE_12_PBL_ADDR_H_S,
-		       ((u32)(mr->pbl_dma_addr >> 32)));
+		       MPT_BYTE_12_PBL_ADDR_H_S, upper_32_bits(pbl_ba));
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 2a8c389..e699932 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -95,6 +95,7 @@ static void set_frmr_seg(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
 {
 	struct hns_roce_mr *mr = to_hr_mr(wr->mr);
 	struct hns_roce_wqe_frmr_seg *fseg = wqe;
+	u64 pbl_ba;
 
 	/* use ib_access_flags */
 	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_FRMR_WQE_BYTE_4_BIND_EN_S,
@@ -109,19 +110,20 @@ static void set_frmr_seg(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
 		     wr->access & IB_ACCESS_LOCAL_WRITE ? 1 : 0);
 
 	/* Data structure reuse may lead to confusion */
-	rc_sq_wqe->msg_len = cpu_to_le32(mr->pbl_ba & 0xffffffff);
-	rc_sq_wqe->inv_key = cpu_to_le32(mr->pbl_ba >> 32);
+	pbl_ba = mr->pbl_mtr.hem_cfg.root_ba;
+	rc_sq_wqe->msg_len = cpu_to_le32(lower_32_bits(pbl_ba));
+	rc_sq_wqe->inv_key = cpu_to_le32(upper_32_bits(pbl_ba));
 
 	rc_sq_wqe->byte_16 = cpu_to_le32(wr->mr->length & 0xffffffff);
 	rc_sq_wqe->byte_20 = cpu_to_le32(wr->mr->length >> 32);
 	rc_sq_wqe->rkey = cpu_to_le32(wr->key);
 	rc_sq_wqe->va = cpu_to_le64(wr->mr->iova);
 
-	fseg->pbl_size = cpu_to_le32(mr->pbl_size);
+	fseg->pbl_size = cpu_to_le32(mr->npages);
 	roce_set_field(fseg->mode_buf_pg_sz,
 		       V2_RC_FRMR_WQE_BYTE_40_PBL_BUF_PG_SZ_M,
 		       V2_RC_FRMR_WQE_BYTE_40_PBL_BUF_PG_SZ_S,
-		       mr->pbl_buf_pg_sz + PG_SHIFT_OFFSET);
+		       to_hr_hw_page_shift(mr->pbl_mtr.hem_cfg.buf_pg_shift));
 	roce_set_bit(fseg->mode_buf_pg_sz,
 		     V2_RC_FRMR_WQE_BYTE_40_BLK_MODE_S, 0);
 }
@@ -2439,32 +2441,30 @@ static int hns_roce_v2_set_mac(struct hns_roce_dev *hr_dev, u8 phy_port,
 static int set_mtpt_pbl(struct hns_roce_v2_mpt_entry *mpt_entry,
 			struct hns_roce_mr *mr)
 {
-	struct sg_dma_page_iter sg_iter;
-	u64 page_addr;
-	u64 *pages;
-	int i;
+	struct hns_roce_dev *hr_dev = to_hr_dev(mr->ibmr.device);
+	u64 pages[HNS_ROCE_V2_MAX_INNER_MTPT_NUM] = { 0 };
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	dma_addr_t pbl_ba;
+	int i, count;
 
-	mpt_entry->pbl_size = cpu_to_le32(mr->pbl_size);
-	mpt_entry->pbl_ba_l = cpu_to_le32(lower_32_bits(mr->pbl_ba >> 3));
-	roce_set_field(mpt_entry->byte_48_mode_ba,
-		       V2_MPT_BYTE_48_PBL_BA_H_M, V2_MPT_BYTE_48_PBL_BA_H_S,
-		       upper_32_bits(mr->pbl_ba >> 3));
+	count = hns_roce_mtr_find(hr_dev, &mr->pbl_mtr, 0, pages,
+				  ARRAY_SIZE(pages), &pbl_ba);
+	if (count < 1) {
+		ibdev_err(ibdev, "failed to find PBL mtr, count = %d.\n",
+			  count);
+		return -ENOBUFS;
+	}
 
-	pages = (u64 *)__get_free_page(GFP_KERNEL);
-	if (!pages)
-		return -ENOMEM;
+	/* Aligned to the hardware address access unit */
+	for (i = 0; i < count; i++)
+		pages[i] >>= 6;
 
-	i = 0;
-	for_each_sg_dma_page(mr->umem->sg_head.sgl, &sg_iter, mr->umem->nmap, 0) {
-		page_addr = sg_page_iter_dma_address(&sg_iter);
-		pages[i] = page_addr >> 6;
+	mpt_entry->pbl_size = cpu_to_le32(mr->npages);
+	mpt_entry->pbl_ba_l = cpu_to_le32(pbl_ba >> 3);
+	roce_set_field(mpt_entry->byte_48_mode_ba,
+		       V2_MPT_BYTE_48_PBL_BA_H_M, V2_MPT_BYTE_48_PBL_BA_H_S,
+		       upper_32_bits(pbl_ba >> 3));
 
-		/* Record the first 2 entry directly to MTPT table */
-		if (i >= HNS_ROCE_V2_MAX_INNER_MTPT_NUM - 1)
-			goto found;
-		i++;
-	}
-found:
 	mpt_entry->pa0_l = cpu_to_le32(lower_32_bits(pages[0]));
 	roce_set_field(mpt_entry->byte_56_pa0_h, V2_MPT_BYTE_56_PA0_H_M,
 		       V2_MPT_BYTE_56_PA0_H_S, upper_32_bits(pages[0]));
@@ -2475,9 +2475,7 @@ static int set_mtpt_pbl(struct hns_roce_v2_mpt_entry *mpt_entry,
 	roce_set_field(mpt_entry->byte_64_buf_pa1,
 		       V2_MPT_BYTE_64_PBL_BUF_PG_SZ_M,
 		       V2_MPT_BYTE_64_PBL_BUF_PG_SZ_S,
-		       mr->pbl_buf_pg_sz + PG_SHIFT_OFFSET);
-
-	free_page((unsigned long)pages);
+		       to_hr_hw_page_shift(mr->pbl_mtr.hem_cfg.buf_pg_shift));
 
 	return 0;
 }
@@ -2499,7 +2497,7 @@ static int hns_roce_v2_write_mtpt(void *mb_buf, struct hns_roce_mr *mr,
 	roce_set_field(mpt_entry->byte_4_pd_hop_st,
 		       V2_MPT_BYTE_4_PBL_BA_PG_SZ_M,
 		       V2_MPT_BYTE_4_PBL_BA_PG_SZ_S,
-		       mr->pbl_ba_pg_sz + PG_SHIFT_OFFSET);
+		       to_hr_hw_page_shift(mr->pbl_mtr.hem_cfg.ba_pg_shift));
 	roce_set_field(mpt_entry->byte_4_pd_hop_st, V2_MPT_BYTE_4_PD_M,
 		       V2_MPT_BYTE_4_PD_S, mr->pd);
 
@@ -2585,11 +2583,19 @@ static int hns_roce_v2_rereg_write_mtpt(struct hns_roce_dev *hr_dev,
 
 static int hns_roce_v2_frmr_write_mtpt(void *mb_buf, struct hns_roce_mr *mr)
 {
+	struct hns_roce_dev *hr_dev = to_hr_dev(mr->ibmr.device);
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_v2_mpt_entry *mpt_entry;
+	dma_addr_t pbl_ba = 0;
 
 	mpt_entry = mb_buf;
 	memset(mpt_entry, 0, sizeof(*mpt_entry));
 
+	if (hns_roce_mtr_find(hr_dev, &mr->pbl_mtr, 0, NULL, 0, &pbl_ba) < 0) {
+		ibdev_err(ibdev, "failed to find frmr mtr.\n");
+		return -ENOBUFS;
+	}
+
 	roce_set_field(mpt_entry->byte_4_pd_hop_st, V2_MPT_BYTE_4_MPT_ST_M,
 		       V2_MPT_BYTE_4_MPT_ST_S, V2_MPT_ST_FREE);
 	roce_set_field(mpt_entry->byte_4_pd_hop_st, V2_MPT_BYTE_4_PBL_HOP_NUM_M,
@@ -2597,7 +2603,7 @@ static int hns_roce_v2_frmr_write_mtpt(void *mb_buf, struct hns_roce_mr *mr)
 	roce_set_field(mpt_entry->byte_4_pd_hop_st,
 		       V2_MPT_BYTE_4_PBL_BA_PG_SZ_M,
 		       V2_MPT_BYTE_4_PBL_BA_PG_SZ_S,
-		       mr->pbl_ba_pg_sz + PG_SHIFT_OFFSET);
+		       to_hr_hw_page_shift(mr->pbl_mtr.hem_cfg.ba_pg_shift));
 	roce_set_field(mpt_entry->byte_4_pd_hop_st, V2_MPT_BYTE_4_PD_M,
 		       V2_MPT_BYTE_4_PD_S, mr->pd);
 
@@ -2610,17 +2616,17 @@ static int hns_roce_v2_frmr_write_mtpt(void *mb_buf, struct hns_roce_mr *mr)
 	roce_set_bit(mpt_entry->byte_12_mw_pa, V2_MPT_BYTE_12_MR_MW_S, 0);
 	roce_set_bit(mpt_entry->byte_12_mw_pa, V2_MPT_BYTE_12_BPD_S, 1);
 
-	mpt_entry->pbl_size = cpu_to_le32(mr->pbl_size);
+	mpt_entry->pbl_size = cpu_to_le32(mr->npages);
 
-	mpt_entry->pbl_ba_l = cpu_to_le32(lower_32_bits(mr->pbl_ba >> 3));
+	mpt_entry->pbl_ba_l = cpu_to_le32(lower_32_bits(pbl_ba >> 3));
 	roce_set_field(mpt_entry->byte_48_mode_ba, V2_MPT_BYTE_48_PBL_BA_H_M,
 		       V2_MPT_BYTE_48_PBL_BA_H_S,
-		       upper_32_bits(mr->pbl_ba >> 3));
+		       upper_32_bits(pbl_ba >> 3));
 
 	roce_set_field(mpt_entry->byte_64_buf_pa1,
 		       V2_MPT_BYTE_64_PBL_BUF_PG_SZ_M,
 		       V2_MPT_BYTE_64_PBL_BUF_PG_SZ_S,
-		       mr->pbl_buf_pg_sz + PG_SHIFT_OFFSET);
+		       to_hr_hw_page_shift(mr->pbl_mtr.hem_cfg.buf_pg_shift));
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 99e3876..c65f1f6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -293,418 +293,89 @@ void hns_roce_mtt_cleanup(struct hns_roce_dev *hr_dev, struct hns_roce_mtt *mtt)
 	}
 }
 
-static void hns_roce_loop_free(struct hns_roce_dev *hr_dev,
-			       struct hns_roce_mr *mr, int err_loop_index,
-			       int loop_i, int loop_j)
+static int alloc_mr_key(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr,
+			u32 pd, u64 iova, u64 size, u32 access)
 {
-	struct device *dev = hr_dev->dev;
-	u32 mhop_num;
-	u32 pbl_bt_sz;
-	u64 bt_idx;
-	int i, j;
-
-	pbl_bt_sz = 1 << (hr_dev->caps.pbl_ba_pg_sz + PAGE_SHIFT);
-	mhop_num = hr_dev->caps.pbl_hop_num;
-
-	i = loop_i;
-	if (mhop_num == 3 && err_loop_index == 2) {
-		for (; i >= 0; i--) {
-			dma_free_coherent(dev, pbl_bt_sz, mr->pbl_bt_l1[i],
-					  mr->pbl_l1_dma_addr[i]);
-
-			for (j = 0; j < pbl_bt_sz / BA_BYTE_LEN; j++) {
-				if (i == loop_i && j >= loop_j)
-					break;
-
-				bt_idx = i * pbl_bt_sz / BA_BYTE_LEN + j;
-				dma_free_coherent(dev, pbl_bt_sz,
-						  mr->pbl_bt_l2[bt_idx],
-						  mr->pbl_l2_dma_addr[bt_idx]);
-			}
-		}
-	} else if (mhop_num == 3 && err_loop_index == 1) {
-		for (i -= 1; i >= 0; i--) {
-			dma_free_coherent(dev, pbl_bt_sz, mr->pbl_bt_l1[i],
-					  mr->pbl_l1_dma_addr[i]);
-
-			for (j = 0; j < pbl_bt_sz / BA_BYTE_LEN; j++) {
-				bt_idx = i * pbl_bt_sz / BA_BYTE_LEN + j;
-				dma_free_coherent(dev, pbl_bt_sz,
-						  mr->pbl_bt_l2[bt_idx],
-						  mr->pbl_l2_dma_addr[bt_idx]);
-			}
-		}
-	} else if (mhop_num == 2 && err_loop_index == 1) {
-		for (i -= 1; i >= 0; i--)
-			dma_free_coherent(dev, pbl_bt_sz, mr->pbl_bt_l1[i],
-					  mr->pbl_l1_dma_addr[i]);
-	} else {
-		dev_warn(dev, "not support: mhop_num=%d, err_loop_index=%d.",
-			 mhop_num, err_loop_index);
-		return;
-	}
-
-	dma_free_coherent(dev, pbl_bt_sz, mr->pbl_bt_l0, mr->pbl_l0_dma_addr);
-	mr->pbl_bt_l0 = NULL;
-	mr->pbl_l0_dma_addr = 0;
-}
-static int pbl_1hop_alloc(struct hns_roce_dev *hr_dev, int npages,
-			       struct hns_roce_mr *mr, u32 pbl_bt_sz)
-{
-	struct device *dev = hr_dev->dev;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	unsigned long obj = 0;
+	int err;
 
-	if (npages > pbl_bt_sz / 8) {
-		dev_err(dev, "npages %d is larger than buf_pg_sz!",
-			npages);
-		return -EINVAL;
-	}
-	mr->pbl_buf = dma_alloc_coherent(dev, npages * 8,
-					 &(mr->pbl_dma_addr),
-					 GFP_KERNEL);
-	if (!mr->pbl_buf)
+	/* Allocate a key for mr from mr_table */
+	err = hns_roce_bitmap_alloc(&hr_dev->mr_table.mtpt_bitmap, &obj);
+	if (err) {
+		ibdev_err(ibdev,
+			  "failed to alloc bitmap for MR key, ret = %d.\n",
+			  err);
 		return -ENOMEM;
-
-	mr->pbl_size = npages;
-	mr->pbl_ba = mr->pbl_dma_addr;
-	mr->pbl_hop_num = 1;
-	mr->pbl_ba_pg_sz = hr_dev->caps.pbl_ba_pg_sz;
-	mr->pbl_buf_pg_sz = hr_dev->caps.pbl_buf_pg_sz;
-	return 0;
-
-}
-
-
-static int pbl_2hop_alloc(struct hns_roce_dev *hr_dev, int npages,
-			       struct hns_roce_mr *mr, u32 pbl_bt_sz)
-{
-	struct device *dev = hr_dev->dev;
-	int npages_allocated;
-	u64 pbl_last_bt_num;
-	u64 pbl_bt_cnt = 0;
-	u64 size;
-	int i;
-
-	pbl_last_bt_num = (npages + pbl_bt_sz / 8 - 1) / (pbl_bt_sz / 8);
-
-	/* alloc L1 BT */
-	for (i = 0; i < pbl_bt_sz / 8; i++) {
-		if (pbl_bt_cnt + 1 < pbl_last_bt_num) {
-			size = pbl_bt_sz;
-		} else {
-			npages_allocated = i * (pbl_bt_sz / 8);
-			size = (npages - npages_allocated) * 8;
-		}
-		mr->pbl_bt_l1[i] = dma_alloc_coherent(dev, size,
-					    &(mr->pbl_l1_dma_addr[i]),
-					    GFP_KERNEL);
-		if (!mr->pbl_bt_l1[i]) {
-			hns_roce_loop_free(hr_dev, mr, 1, i, 0);
-			return -ENOMEM;
-		}
-
-		*(mr->pbl_bt_l0 + i) = mr->pbl_l1_dma_addr[i];
-
-		pbl_bt_cnt++;
-		if (pbl_bt_cnt >= pbl_last_bt_num)
-			break;
 	}
 
-	mr->l0_chunk_last_num = i + 1;
-
-	return 0;
-}
-
-static int pbl_3hop_alloc(struct hns_roce_dev *hr_dev, int npages,
-			       struct hns_roce_mr *mr, u32 pbl_bt_sz)
-{
-	struct device *dev = hr_dev->dev;
-	int mr_alloc_done = 0;
-	int npages_allocated;
-	u64 pbl_last_bt_num;
-	u64 pbl_bt_cnt = 0;
-	u64 bt_idx;
-	u64 size;
-	int i;
-	int j = 0;
-
-	pbl_last_bt_num = (npages + pbl_bt_sz / 8 - 1) / (pbl_bt_sz / 8);
-
-	mr->pbl_l2_dma_addr = kcalloc(pbl_last_bt_num,
-				      sizeof(*mr->pbl_l2_dma_addr),
-				      GFP_KERNEL);
-	if (!mr->pbl_l2_dma_addr)
-		return -ENOMEM;
-
-	mr->pbl_bt_l2 = kcalloc(pbl_last_bt_num,
-				sizeof(*mr->pbl_bt_l2),
-				GFP_KERNEL);
-	if (!mr->pbl_bt_l2)
-		goto err_kcalloc_bt_l2;
-
-	/* alloc L1, L2 BT */
-	for (i = 0; i < pbl_bt_sz / 8; i++) {
-		mr->pbl_bt_l1[i] = dma_alloc_coherent(dev, pbl_bt_sz,
-					    &(mr->pbl_l1_dma_addr[i]),
-					    GFP_KERNEL);
-		if (!mr->pbl_bt_l1[i]) {
-			hns_roce_loop_free(hr_dev, mr, 1, i, 0);
-			goto err_dma_alloc_l0;
-		}
-
-		*(mr->pbl_bt_l0 + i) = mr->pbl_l1_dma_addr[i];
-
-		for (j = 0; j < pbl_bt_sz / 8; j++) {
-			bt_idx = i * pbl_bt_sz / 8 + j;
-
-			if (pbl_bt_cnt + 1 < pbl_last_bt_num) {
-				size = pbl_bt_sz;
-			} else {
-				npages_allocated = bt_idx *
-						   (pbl_bt_sz / 8);
-				size = (npages - npages_allocated) * 8;
-			}
-			mr->pbl_bt_l2[bt_idx] = dma_alloc_coherent(
-				      dev, size,
-				      &(mr->pbl_l2_dma_addr[bt_idx]),
-				      GFP_KERNEL);
-			if (!mr->pbl_bt_l2[bt_idx]) {
-				hns_roce_loop_free(hr_dev, mr, 2, i, j);
-				goto err_dma_alloc_l0;
-			}
-
-			*(mr->pbl_bt_l1[i] + j) =
-					mr->pbl_l2_dma_addr[bt_idx];
-
-			pbl_bt_cnt++;
-			if (pbl_bt_cnt >= pbl_last_bt_num) {
-				mr_alloc_done = 1;
-				break;
-			}
-		}
+	mr->iova = iova;			/* MR va starting addr */
+	mr->size = size;			/* MR addr range */
+	mr->pd = pd;				/* MR num */
+	mr->access = access;			/* MR access permit */
+	mr->enabled = 0;			/* MR active status */
+	mr->key = hw_index_to_key(obj);		/* MR key */
 
-		if (mr_alloc_done)
-			break;
+	err = hns_roce_table_get(hr_dev, &hr_dev->mr_table.mtpt_table, obj);
+	if (err) {
+		ibdev_err(ibdev, "failed to alloc mtpt, ret = %d.\n", err);
+		goto err_free_bitmap;
 	}
 
-	mr->l0_chunk_last_num = i + 1;
-	mr->l1_chunk_last_num = j + 1;
-
-
 	return 0;
-
-err_dma_alloc_l0:
-	kfree(mr->pbl_bt_l2);
-	mr->pbl_bt_l2 = NULL;
-
-err_kcalloc_bt_l2:
-	kfree(mr->pbl_l2_dma_addr);
-	mr->pbl_l2_dma_addr = NULL;
-
-	return -ENOMEM;
+err_free_bitmap:
+	hns_roce_bitmap_free(&hr_dev->mr_table.mtpt_bitmap, obj, BITMAP_NO_RR);
+	return err;
 }
 
-
-/* PBL multi hop addressing */
-static int hns_roce_mhop_alloc(struct hns_roce_dev *hr_dev, int npages,
-			       struct hns_roce_mr *mr)
+static void free_mr_key(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr)
 {
-	struct device *dev = hr_dev->dev;
-	u32 pbl_bt_sz;
-	u32 mhop_num;
+	unsigned long obj = key_to_hw_index(mr->key);
 
-	mhop_num = (mr->type == MR_TYPE_FRMR ? 1 : hr_dev->caps.pbl_hop_num);
-	pbl_bt_sz = 1 << (hr_dev->caps.pbl_ba_pg_sz + PAGE_SHIFT);
-
-	if (mhop_num == HNS_ROCE_HOP_NUM_0)
-		return 0;
-
-	if (mhop_num == 1)
-		return pbl_1hop_alloc(hr_dev, npages, mr, pbl_bt_sz);
-
-	mr->pbl_l1_dma_addr = kcalloc(pbl_bt_sz / 8,
-				      sizeof(*mr->pbl_l1_dma_addr),
-				      GFP_KERNEL);
-	if (!mr->pbl_l1_dma_addr)
-		return -ENOMEM;
-
-	mr->pbl_bt_l1 = kcalloc(pbl_bt_sz / 8, sizeof(*mr->pbl_bt_l1),
-				GFP_KERNEL);
-	if (!mr->pbl_bt_l1)
-		goto err_kcalloc_bt_l1;
-
-	/* alloc L0 BT */
-	mr->pbl_bt_l0 = dma_alloc_coherent(dev, pbl_bt_sz,
-					   &(mr->pbl_l0_dma_addr),
-					   GFP_KERNEL);
-	if (!mr->pbl_bt_l0)
-		goto err_kcalloc_l2_dma;
-
-	if (mhop_num == 2) {
-		if (pbl_2hop_alloc(hr_dev, npages, mr, pbl_bt_sz))
-			goto err_kcalloc_l2_dma;
-	}
-
-	if (mhop_num == 3) {
-		if (pbl_3hop_alloc(hr_dev, npages, mr, pbl_bt_sz))
-			goto err_kcalloc_l2_dma;
-	}
-
-
-	mr->pbl_size = npages;
-	mr->pbl_ba = mr->pbl_l0_dma_addr;
-	mr->pbl_hop_num = hr_dev->caps.pbl_hop_num;
-	mr->pbl_ba_pg_sz = hr_dev->caps.pbl_ba_pg_sz;
-	mr->pbl_buf_pg_sz = hr_dev->caps.pbl_buf_pg_sz;
-
-	return 0;
-
-err_kcalloc_l2_dma:
-	kfree(mr->pbl_bt_l1);
-	mr->pbl_bt_l1 = NULL;
-
-err_kcalloc_bt_l1:
-	kfree(mr->pbl_l1_dma_addr);
-	mr->pbl_l1_dma_addr = NULL;
-
-	return -ENOMEM;
+	hns_roce_table_put(hr_dev, &hr_dev->mr_table.mtpt_table, obj);
+	hns_roce_bitmap_free(&hr_dev->mr_table.mtpt_bitmap, obj, BITMAP_NO_RR);
 }
 
-static int hns_roce_mr_alloc(struct hns_roce_dev *hr_dev, u32 pd, u64 iova,
-			     u64 size, u32 access, int npages,
-			     struct hns_roce_mr *mr)
+static int alloc_mr_pbl(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr,
+			size_t length, struct ib_udata *udata, u64 start,
+			int access)
 {
-	struct device *dev = hr_dev->dev;
-	unsigned long index = 0;
-	int ret;
-
-	/* Allocate a key for mr from mr_table */
-	ret = hns_roce_bitmap_alloc(&hr_dev->mr_table.mtpt_bitmap, &index);
-	if (ret)
-		return -ENOMEM;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	bool is_fast = mr->type == MR_TYPE_FRMR;
+	struct hns_roce_buf_attr buf_attr = {};
+	int err;
 
-	mr->iova = iova;			/* MR va starting addr */
-	mr->size = size;			/* MR addr range */
-	mr->pd = pd;				/* MR num */
-	mr->access = access;			/* MR access permit */
-	mr->enabled = 0;			/* MR active status */
-	mr->key = hw_index_to_key(index);	/* MR key */
-
-	if (size == ~0ull) {
-		mr->pbl_buf = NULL;
-		mr->pbl_dma_addr = 0;
-		/* PBL multi-hop addressing parameters */
-		mr->pbl_bt_l2 = NULL;
-		mr->pbl_bt_l1 = NULL;
-		mr->pbl_bt_l0 = NULL;
-		mr->pbl_l2_dma_addr = NULL;
-		mr->pbl_l1_dma_addr = NULL;
-		mr->pbl_l0_dma_addr = 0;
-	} else {
-		if (!hr_dev->caps.pbl_hop_num) {
-			mr->pbl_buf = dma_alloc_coherent(dev,
-							 npages * BA_BYTE_LEN,
-							 &(mr->pbl_dma_addr),
-							 GFP_KERNEL);
-			if (!mr->pbl_buf)
-				return -ENOMEM;
-		} else {
-			ret = hns_roce_mhop_alloc(hr_dev, npages, mr);
-		}
-	}
+	mr->pbl_hop_num = is_fast ? 1 : hr_dev->caps.pbl_hop_num;
+	buf_attr.page_shift = is_fast ? PAGE_SHIFT :
+			      hr_dev->caps.pbl_buf_pg_sz + PAGE_ADDR_SHIFT;
+	buf_attr.region[0].size = length;
+	buf_attr.region[0].hopnum = mr->pbl_hop_num;
+	buf_attr.region_count = 1;
+	buf_attr.fixed_page = true;
+	buf_attr.user_access = access;
+	/* fast MR's buffer is alloced before mapping, not at creation */
+	buf_attr.mtt_only = is_fast;
+
+	err = hns_roce_mtr_create(hr_dev, &mr->pbl_mtr, &buf_attr,
+				  hr_dev->caps.pbl_ba_pg_sz + PAGE_ADDR_SHIFT,
+				  udata, start);
+	if (err)
+		ibdev_err(ibdev, "failed to alloc pbl mtr, ret = %d.\n", err);
+	else
+		mr->npages = mr->pbl_mtr.hem_cfg.buf_pg_count;
 
-	return ret;
+	return err;
 }
 
-static void hns_roce_mhop_free(struct hns_roce_dev *hr_dev,
-			       struct hns_roce_mr *mr)
+static void free_mr_pbl(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr)
 {
-	struct device *dev = hr_dev->dev;
-	int npages_allocated;
-	int npages;
-	int i, j;
-	u32 pbl_bt_sz;
-	u32 mhop_num;
-	u64 bt_idx;
-
-	npages = mr->pbl_size;
-	pbl_bt_sz = 1 << (hr_dev->caps.pbl_ba_pg_sz + PAGE_SHIFT);
-	mhop_num = (mr->type == MR_TYPE_FRMR) ? 1 : hr_dev->caps.pbl_hop_num;
-
-	if (mhop_num == HNS_ROCE_HOP_NUM_0)
-		return;
-
-	if (mhop_num == 1) {
-		dma_free_coherent(dev, (unsigned int)(npages * BA_BYTE_LEN),
-				  mr->pbl_buf, mr->pbl_dma_addr);
-		return;
-	}
-
-	dma_free_coherent(dev, pbl_bt_sz, mr->pbl_bt_l0,
-			  mr->pbl_l0_dma_addr);
-
-	if (mhop_num == 2) {
-		for (i = 0; i < mr->l0_chunk_last_num; i++) {
-			if (i == mr->l0_chunk_last_num - 1) {
-				npages_allocated =
-						i * (pbl_bt_sz / BA_BYTE_LEN);
-
-				dma_free_coherent(dev,
-				      (npages - npages_allocated) * BA_BYTE_LEN,
-				       mr->pbl_bt_l1[i],
-				       mr->pbl_l1_dma_addr[i]);
-
-				break;
-			}
-
-			dma_free_coherent(dev, pbl_bt_sz, mr->pbl_bt_l1[i],
-					  mr->pbl_l1_dma_addr[i]);
-		}
-	} else if (mhop_num == 3) {
-		for (i = 0; i < mr->l0_chunk_last_num; i++) {
-			dma_free_coherent(dev, pbl_bt_sz, mr->pbl_bt_l1[i],
-					  mr->pbl_l1_dma_addr[i]);
-
-			for (j = 0; j < pbl_bt_sz / BA_BYTE_LEN; j++) {
-				bt_idx = i * (pbl_bt_sz / BA_BYTE_LEN) + j;
-
-				if ((i == mr->l0_chunk_last_num - 1)
-				    && j == mr->l1_chunk_last_num - 1) {
-					npages_allocated = bt_idx *
-						      (pbl_bt_sz / BA_BYTE_LEN);
-
-					dma_free_coherent(dev,
-					      (npages - npages_allocated) *
-					      BA_BYTE_LEN,
-					      mr->pbl_bt_l2[bt_idx],
-					      mr->pbl_l2_dma_addr[bt_idx]);
-
-					break;
-				}
-
-				dma_free_coherent(dev, pbl_bt_sz,
-						mr->pbl_bt_l2[bt_idx],
-						mr->pbl_l2_dma_addr[bt_idx]);
-			}
-		}
-	}
-
-	kfree(mr->pbl_bt_l1);
-	kfree(mr->pbl_l1_dma_addr);
-	mr->pbl_bt_l1 = NULL;
-	mr->pbl_l1_dma_addr = NULL;
-	if (mhop_num == 3) {
-		kfree(mr->pbl_bt_l2);
-		kfree(mr->pbl_l2_dma_addr);
-		mr->pbl_bt_l2 = NULL;
-		mr->pbl_l2_dma_addr = NULL;
-	}
+	hns_roce_mtr_destroy(hr_dev, &mr->pbl_mtr);
 }
 
 static void hns_roce_mr_free(struct hns_roce_dev *hr_dev,
 			     struct hns_roce_mr *mr)
 {
-	struct device *dev = hr_dev->dev;
-	int npages = 0;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	int ret;
 
 	if (mr->enabled) {
@@ -712,27 +383,12 @@ static void hns_roce_mr_free(struct hns_roce_dev *hr_dev,
 					      key_to_hw_index(mr->key) &
 					      (hr_dev->caps.num_mtpts - 1));
 		if (ret)
-			dev_warn(dev, "DESTROY_MPT failed (%d)\n", ret);
-	}
-
-	if (mr->size != ~0ULL) {
-		if (mr->type == MR_TYPE_MR)
-			npages = ib_umem_page_count(mr->umem);
-
-		if (!hr_dev->caps.pbl_hop_num)
-			dma_free_coherent(dev,
-					  (unsigned int)(npages * BA_BYTE_LEN),
-					  mr->pbl_buf, mr->pbl_dma_addr);
-		else
-			hns_roce_mhop_free(hr_dev, mr);
+			ibdev_warn(ibdev, "failed to destroy mpt, ret = %d.\n",
+				   ret);
 	}
 
-	if (mr->enabled)
-		hns_roce_table_put(hr_dev, &hr_dev->mr_table.mtpt_table,
-				   key_to_hw_index(mr->key));
-
-	hns_roce_bitmap_free(&hr_dev->mr_table.mtpt_bitmap,
-			     key_to_hw_index(mr->key), BITMAP_NO_RR);
+	free_mr_pbl(hr_dev, mr);
+	free_mr_key(hr_dev, mr);
 }
 
 static int hns_roce_mr_enable(struct hns_roce_dev *hr_dev,
@@ -742,18 +398,12 @@ static int hns_roce_mr_enable(struct hns_roce_dev *hr_dev,
 	unsigned long mtpt_idx = key_to_hw_index(mr->key);
 	struct device *dev = hr_dev->dev;
 	struct hns_roce_cmd_mailbox *mailbox;
-	struct hns_roce_mr_table *mr_table = &hr_dev->mr_table;
-
-	/* Prepare HEM entry memory */
-	ret = hns_roce_table_get(hr_dev, &mr_table->mtpt_table, mtpt_idx);
-	if (ret)
-		return ret;
 
 	/* Allocate mailbox memory */
 	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
 	if (IS_ERR(mailbox)) {
 		ret = PTR_ERR(mailbox);
-		goto err_table;
+		return ret;
 	}
 
 	if (mr->type != MR_TYPE_FRMR)
@@ -780,8 +430,6 @@ static int hns_roce_mr_enable(struct hns_roce_dev *hr_dev,
 err_page:
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 
-err_table:
-	hns_roce_table_put(hr_dev, &mr_table->mtpt_table, mtpt_idx);
 	return ret;
 }
 
@@ -982,18 +630,19 @@ void hns_roce_cleanup_mr_table(struct hns_roce_dev *hr_dev)
 
 struct ib_mr *hns_roce_get_dma_mr(struct ib_pd *pd, int acc)
 {
+	struct hns_roce_dev *hr_dev = to_hr_dev(pd->device);
 	struct hns_roce_mr *mr;
 	int ret;
 
-	mr = kmalloc(sizeof(*mr), GFP_KERNEL);
+	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
 	if (mr == NULL)
 		return  ERR_PTR(-ENOMEM);
 
 	mr->type = MR_TYPE_DMA;
 
 	/* Allocate memory region key */
-	ret = hns_roce_mr_alloc(to_hr_dev(pd->device), to_hr_pd(pd)->pdn, 0,
-				~0ULL, acc, 0, mr);
+	hns_roce_hem_list_init(&mr->pbl_mtr.hem_list);
+	ret = alloc_mr_key(hr_dev, mr, to_hr_pd(pd)->pdn, 0, 0, acc);
 	if (ret)
 		goto err_free;
 
@@ -1002,12 +651,10 @@ struct ib_mr *hns_roce_get_dma_mr(struct ib_pd *pd, int acc)
 		goto err_mr;
 
 	mr->ibmr.rkey = mr->ibmr.lkey = mr->key;
-	mr->umem = NULL;
 
 	return &mr->ibmr;
-
 err_mr:
-	hns_roce_mr_free(to_hr_dev(pd->device), mr);
+	free_mr_key(hr_dev, mr);
 
 err_free:
 	kfree(mr);
@@ -1085,120 +732,41 @@ int hns_roce_ib_umem_write_mtt(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
-static int hns_roce_ib_umem_write_mr(struct hns_roce_dev *hr_dev,
-				     struct hns_roce_mr *mr,
-				     struct ib_umem *umem)
-{
-	struct sg_dma_page_iter sg_iter;
-	int i = 0, j = 0;
-	u64 page_addr;
-	u32 pbl_bt_sz;
-
-	if (hr_dev->caps.pbl_hop_num == HNS_ROCE_HOP_NUM_0)
-		return 0;
-
-	pbl_bt_sz = 1 << (hr_dev->caps.pbl_ba_pg_sz + PAGE_SHIFT);
-	for_each_sg_dma_page(umem->sg_head.sgl, &sg_iter, umem->nmap, 0) {
-		page_addr = sg_page_iter_dma_address(&sg_iter);
-		if (!hr_dev->caps.pbl_hop_num) {
-			/* for hip06, page addr is aligned to 4K */
-			mr->pbl_buf[i++] = page_addr >> 12;
-		} else if (hr_dev->caps.pbl_hop_num == 1) {
-			mr->pbl_buf[i++] = page_addr;
-		} else {
-			if (hr_dev->caps.pbl_hop_num == 2)
-				mr->pbl_bt_l1[i][j] = page_addr;
-			else if (hr_dev->caps.pbl_hop_num == 3)
-				mr->pbl_bt_l2[i][j] = page_addr;
-
-			j++;
-			if (j >= (pbl_bt_sz / BA_BYTE_LEN)) {
-				i++;
-				j = 0;
-			}
-		}
-	}
-
-	/* Memory barrier */
-	mb();
-
-	return 0;
-}
-
 struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 				   u64 virt_addr, int access_flags,
 				   struct ib_udata *udata)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(pd->device);
-	struct device *dev = hr_dev->dev;
 	struct hns_roce_mr *mr;
-	int bt_size;
 	int ret;
-	int n;
-	int i;
 
-	mr = kmalloc(sizeof(*mr), GFP_KERNEL);
+	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
-	mr->umem = ib_umem_get(pd->device, start, length, access_flags);
-	if (IS_ERR(mr->umem)) {
-		ret = PTR_ERR(mr->umem);
-		goto err_free;
-	}
-
-	n = ib_umem_page_count(mr->umem);
-
-	if (!hr_dev->caps.pbl_hop_num) {
-		if (n > HNS_ROCE_MAX_MTPT_PBL_NUM) {
-			dev_err(dev,
-			     " MR len %lld err. MR is limited to 4G at most!\n",
-			     length);
-			ret = -EINVAL;
-			goto err_umem;
-		}
-	} else {
-		u64 pbl_size = 1;
-
-		bt_size = (1 << (hr_dev->caps.pbl_ba_pg_sz + PAGE_SHIFT)) /
-			  BA_BYTE_LEN;
-		for (i = 0; i < hr_dev->caps.pbl_hop_num; i++)
-			pbl_size *= bt_size;
-		if (n > pbl_size) {
-			dev_err(dev,
-			    " MR len %lld err. MR page num is limited to %lld!\n",
-			    length, pbl_size);
-			ret = -EINVAL;
-			goto err_umem;
-		}
-	}
-
 	mr->type = MR_TYPE_MR;
-
-	ret = hns_roce_mr_alloc(hr_dev, to_hr_pd(pd)->pdn, virt_addr, length,
-				access_flags, n, mr);
+	ret = alloc_mr_key(hr_dev, mr, to_hr_pd(pd)->pdn, virt_addr, length,
+			   access_flags);
 	if (ret)
-		goto err_umem;
+		goto err_alloc_mr;
 
-	ret = hns_roce_ib_umem_write_mr(hr_dev, mr, mr->umem);
+	ret = alloc_mr_pbl(hr_dev, mr, length, udata, start, access_flags);
 	if (ret)
-		goto err_mr;
+		goto err_alloc_key;
 
 	ret = hns_roce_mr_enable(hr_dev, mr);
 	if (ret)
-		goto err_mr;
+		goto err_alloc_pbl;
 
 	mr->ibmr.rkey = mr->ibmr.lkey = mr->key;
 
 	return &mr->ibmr;
 
-err_mr:
-	hns_roce_mr_free(hr_dev, mr);
-
-err_umem:
-	ib_umem_release(mr->umem);
-
-err_free:
+err_alloc_pbl:
+	free_mr_pbl(hr_dev, mr);
+err_alloc_key:
+	free_mr_key(hr_dev, mr);
+err_alloc_mr:
 	kfree(mr);
 	return ERR_PTR(ret);
 }
@@ -1210,84 +778,36 @@ static int rereg_mr_trans(struct ib_mr *ibmr, int flags,
 			  u32 pdn, struct ib_udata *udata)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibmr->device);
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_mr *mr = to_hr_mr(ibmr);
-	struct device *dev = hr_dev->dev;
-	int npages;
 	int ret;
 
-	if (mr->size != ~0ULL) {
-		npages = ib_umem_page_count(mr->umem);
-
-		if (hr_dev->caps.pbl_hop_num)
-			hns_roce_mhop_free(hr_dev, mr);
-		else
-			dma_free_coherent(dev, npages * 8,
-					  mr->pbl_buf, mr->pbl_dma_addr);
-	}
-	ib_umem_release(mr->umem);
-
-	mr->umem = ib_umem_get(ibmr->device, start, length, mr_access_flags);
-	if (IS_ERR(mr->umem)) {
-		ret = PTR_ERR(mr->umem);
-		mr->umem = NULL;
-		return -ENOMEM;
-	}
-	npages = ib_umem_page_count(mr->umem);
-
-	if (hr_dev->caps.pbl_hop_num) {
-		ret = hns_roce_mhop_alloc(hr_dev, npages, mr);
-		if (ret)
-			goto release_umem;
-	} else {
-		mr->pbl_buf = dma_alloc_coherent(dev, npages * 8,
-						 &(mr->pbl_dma_addr),
-						 GFP_KERNEL);
-		if (!mr->pbl_buf) {
-			ret = -ENOMEM;
-			goto release_umem;
-		}
+	free_mr_pbl(hr_dev, mr);
+	ret = alloc_mr_pbl(hr_dev, mr, length, udata, start, mr_access_flags);
+	if (ret) {
+		ibdev_err(ibdev, "failed to create mr PBL, ret = %d.\n", ret);
+		return ret;
 	}
 
 	ret = hr_dev->hw->rereg_write_mtpt(hr_dev, mr, flags, pdn,
 					   mr_access_flags, virt_addr,
 					   length, mailbox->buf);
-	if (ret)
-		goto release_umem;
-
-
-	ret = hns_roce_ib_umem_write_mr(hr_dev, mr, mr->umem);
 	if (ret) {
-		if (mr->size != ~0ULL) {
-			npages = ib_umem_page_count(mr->umem);
-
-			if (hr_dev->caps.pbl_hop_num)
-				hns_roce_mhop_free(hr_dev, mr);
-			else
-				dma_free_coherent(dev, npages * 8,
-						  mr->pbl_buf,
-						  mr->pbl_dma_addr);
-		}
-
-		goto release_umem;
+		ibdev_err(ibdev, "failed to write mtpt, ret = %d.\n", ret);
+		free_mr_pbl(hr_dev, mr);
 	}
 
-	return 0;
-
-release_umem:
-	ib_umem_release(mr->umem);
 	return ret;
-
 }
 
-
 int hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start, u64 length,
 			   u64 virt_addr, int mr_access_flags, struct ib_pd *pd,
 			   struct ib_udata *udata)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibmr->device);
+	struct ib_device *ib_dev = &hr_dev->ib_dev;
 	struct hns_roce_mr *mr = to_hr_mr(ibmr);
 	struct hns_roce_cmd_mailbox *mailbox;
-	struct device *dev = hr_dev->dev;
 	unsigned long mtpt_idx;
 	u32 pdn = 0;
 	int ret;
@@ -1308,7 +828,7 @@ int hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start, u64 length,
 
 	ret = hns_roce_hw_destroy_mpt(hr_dev, NULL, mtpt_idx);
 	if (ret)
-		dev_warn(dev, "DESTROY_MPT failed (%d)\n", ret);
+		ibdev_warn(ib_dev, "failed to destroy MPT, ret = %d.\n", ret);
 
 	mr->enabled = 0;
 
@@ -1332,8 +852,7 @@ int hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start, u64 length,
 
 	ret = hns_roce_hw_create_mpt(hr_dev, mailbox, mtpt_idx);
 	if (ret) {
-		dev_err(dev, "CREATE_MPT failed (%d)\n", ret);
-		ib_umem_release(mr->umem);
+		ibdev_err(ib_dev, "failed to create MPT, ret = %d.\n", ret);
 		goto free_cmd_mbox;
 	}
 
@@ -1361,8 +880,6 @@ int hns_roce_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 		ret = hr_dev->hw->dereg_mr(hr_dev, mr, udata);
 	} else {
 		hns_roce_mr_free(hr_dev, mr);
-
-		ib_umem_release(mr->umem);
 		kfree(mr);
 	}
 
@@ -1376,12 +893,8 @@ struct ib_mr *hns_roce_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 	struct device *dev = hr_dev->dev;
 	struct hns_roce_mr *mr;
 	u64 length;
-	u32 page_size;
 	int ret;
 
-	page_size = 1 << (hr_dev->caps.pbl_buf_pg_sz + PAGE_SHIFT);
-	length = max_num_sg * page_size;
-
 	if (mr_type != IB_MR_TYPE_MEM_REG)
 		return ERR_PTR(-EINVAL);
 
@@ -1398,23 +911,27 @@ struct ib_mr *hns_roce_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 	mr->type = MR_TYPE_FRMR;
 
 	/* Allocate memory region key */
-	ret = hns_roce_mr_alloc(hr_dev, to_hr_pd(pd)->pdn, 0, length,
-				0, max_num_sg, mr);
+	length = max_num_sg * (1 << PAGE_SHIFT);
+	ret = alloc_mr_key(hr_dev, mr, to_hr_pd(pd)->pdn, 0, length, 0);
 	if (ret)
 		goto err_free;
 
+	ret = alloc_mr_pbl(hr_dev, mr, length, NULL, 0, 0);
+	if (ret)
+		goto err_key;
+
 	ret = hns_roce_mr_enable(hr_dev, mr);
 	if (ret)
-		goto err_mr;
+		goto err_pbl;
 
 	mr->ibmr.rkey = mr->ibmr.lkey = mr->key;
-	mr->umem = NULL;
 
 	return &mr->ibmr;
 
-err_mr:
-	hns_roce_mr_free(to_hr_dev(pd->device), mr);
-
+err_key:
+	free_mr_key(hr_dev, mr);
+err_pbl:
+	free_mr_pbl(hr_dev, mr);
 err_free:
 	kfree(mr);
 	return ERR_PTR(ret);
@@ -1424,19 +941,54 @@ static int hns_roce_set_page(struct ib_mr *ibmr, u64 addr)
 {
 	struct hns_roce_mr *mr = to_hr_mr(ibmr);
 
-	mr->pbl_buf[mr->npages++] = addr;
+	if (likely(mr->npages < mr->pbl_mtr.hem_cfg.buf_pg_count)) {
+		mr->page_list[mr->npages++] = addr;
+		return 0;
+	}
 
-	return 0;
+	return -ENOBUFS;
 }
 
 int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 		       unsigned int *sg_offset)
 {
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibmr->device);
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_mr *mr = to_hr_mr(ibmr);
+	struct hns_roce_buf_region region = {};
+	int ret = 0;
 
 	mr->npages = 0;
+	mr->page_list = kvcalloc(mr->pbl_mtr.hem_cfg.buf_pg_count,
+				 sizeof(dma_addr_t), GFP_KERNEL);
+	if (!mr->page_list)
+		return ret;
+
+	ret = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, hns_roce_set_page);
+	if (ret < 1) {
+		ibdev_err(ibdev, "failed to store sg pages %d %d, cnt = %d.\n",
+			  mr->npages, mr->pbl_mtr.hem_cfg.buf_pg_count, ret);
+		goto err_page_list;
+	}
 
-	return ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, hns_roce_set_page);
+	region.offset = 0;
+	region.count = mr->npages;
+	region.hopnum = mr->pbl_hop_num;
+	ret = hns_roce_mtr_map(hr_dev, &mr->pbl_mtr, &region, 1, mr->page_list,
+			       mr->npages);
+	if (ret) {
+		ibdev_err(ibdev, "failed to map sg mtr, ret = %d.\n", ret);
+		ret = 0;
+	} else {
+		mr->pbl_mtr.hem_cfg.buf_pg_shift = ilog2(ibmr->page_size);
+		ret = mr->npages;
+	}
+
+err_page_list:
+	kvfree(mr->page_list);
+	mr->page_list = NULL;
+
+	return ret;
 }
 
 static void hns_roce_mw_free(struct hns_roce_dev *hr_dev,
-- 
2.8.1

