Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B86897D805
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 10:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbfHAItd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 04:49:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60356 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725946AbfHAItd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 04:49:33 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 063798B57938BD3E540C;
        Thu,  1 Aug 2019 16:33:23 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Thu, 1 Aug 2019 16:33:13 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V2 for-next 06/13] RDMA/hns: Update some comments style
Date:   Thu, 1 Aug 2019 16:29:07 +0800
Message-ID: <1564648154-123172-7-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1564648154-123172-1-git-send-email-oulijun@huawei.com>
References: <1564648154-123172-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Here removes some useless comments and adds necessary spaces to
another comments.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 65 ++++++++++++++---------------
 drivers/infiniband/hw/hns/hns_roce_hem.h    |  6 +--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  9 ++--
 drivers/infiniband/hw/hns/hns_roce_mr.c     |  1 -
 4 files changed, 38 insertions(+), 43 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index b39497a..8c4b120 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -84,7 +84,6 @@
 #define HNS_ROCE_CEQ_ENTRY_SIZE			0x4
 #define HNS_ROCE_AEQ_ENTRY_SIZE			0x10
 
-/* 4G/4K = 1M */
 #define HNS_ROCE_SL_SHIFT			28
 #define HNS_ROCE_TCLASS_SHIFT			20
 #define HNS_ROCE_FLOW_LABEL_MASK		0xfffff
@@ -322,7 +321,7 @@ struct hns_roce_hem_table {
 	unsigned long	num_hem;
 	/* HEM entry record obj total num */
 	unsigned long	num_obj;
-	/*Single obj size */
+	/* Single obj size */
 	unsigned long	obj_size;
 	unsigned long	table_chunk_size;
 	int		lowmem;
@@ -343,7 +342,7 @@ struct hns_roce_mtt {
 
 struct hns_roce_buf_region {
 	int offset; /* page offset */
-	u32 count; /* page count*/
+	u32 count; /* page count */
 	int hopnum; /* addressing hop num */
 };
 
@@ -384,25 +383,25 @@ struct hns_roce_mr {
 	u64			size; /* Address range of MR */
 	u32			key; /* Key of MR */
 	u32			pd;   /* PD num of MR */
-	u32			access;/* Access permission of MR */
+	u32			access;	/* Access permission of MR */
 	u32			npages;
 	int			enabled; /* MR's active status */
 	int			type;	/* MR's register type */
-	u64			*pbl_buf;/* MR's PBL space */
+	u64			*pbl_buf;	/* MR's PBL space */
 	dma_addr_t		pbl_dma_addr;	/* MR's PBL space PA */
-	u32			pbl_size;/* PA number in the PBL */
-	u64			pbl_ba;/* page table address */
-	u32			l0_chunk_last_num;/* L0 last number */
-	u32			l1_chunk_last_num;/* L1 last number */
-	u64			**pbl_bt_l2;/* PBL BT L2 */
-	u64			**pbl_bt_l1;/* PBL BT L1 */
-	u64			*pbl_bt_l0;/* PBL BT L0 */
-	dma_addr_t		*pbl_l2_dma_addr;/* PBL BT L2 dma addr */
-	dma_addr_t		*pbl_l1_dma_addr;/* PBL BT L1 dma addr */
-	dma_addr_t		pbl_l0_dma_addr;/* PBL BT L0 dma addr */
-	u32			pbl_ba_pg_sz;/* BT chunk page size */
-	u32			pbl_buf_pg_sz;/* buf chunk page size */
-	u32			pbl_hop_num;/* multi-hop number */
+	u32			pbl_size;	/* PA number in the PBL */
+	u64			pbl_ba;		/* page table address */
+	u32			l0_chunk_last_num;	/* L0 last number */
+	u32			l1_chunk_last_num;	/* L1 last number */
+	u64			**pbl_bt_l2;	/* PBL BT L2 */
+	u64			**pbl_bt_l1;	/* PBL BT L1 */
+	u64			*pbl_bt_l0;	/* PBL BT L0 */
+	dma_addr_t		*pbl_l2_dma_addr;	/* PBL BT L2 dma addr */
+	dma_addr_t		*pbl_l1_dma_addr;	/* PBL BT L1 dma addr */
+	dma_addr_t		pbl_l0_dma_addr;	/* PBL BT L0 dma addr */
+	u32			pbl_ba_pg_sz;	/* BT chunk page size */
+	u32			pbl_buf_pg_sz;	/* buf chunk page size */
+	u32			pbl_hop_num;	/* multi-hop number */
 };
 
 struct hns_roce_mr_table {
@@ -425,16 +424,16 @@ struct hns_roce_wq {
 	u32		max_post;
 	int		max_gs;
 	int		offset;
-	int		wqe_shift;/* WQE size */
+	int		wqe_shift;	/* WQE size */
 	u32		head;
 	u32		tail;
 	void __iomem	*db_reg_l;
 };
 
 struct hns_roce_sge {
-	int		sge_cnt;  /* SGE num */
+	int		sge_cnt;	/* SGE num */
 	int		offset;
-	int		sge_shift;/* SGE size */
+	int		sge_shift;	/* SGE size */
 };
 
 struct hns_roce_buf_list {
@@ -750,7 +749,7 @@ struct hns_roce_eq {
 	struct hns_roce_dev		*hr_dev;
 	void __iomem			*doorbell;
 
-	int				type_flag;/* Aeq:1 ceq:0 */
+	int				type_flag; /* Aeq:1 ceq:0 */
 	int				eqn;
 	u32				entries;
 	int				log_entries;
@@ -796,22 +795,22 @@ struct hns_roce_caps {
 	int		local_ca_ack_delay;
 	int		num_uars;
 	u32		phy_num_uars;
-	u32		max_sq_sg;	/* 2 */
-	u32		max_sq_inline;	/* 32 */
-	u32		max_rq_sg;	/* 2 */
+	u32		max_sq_sg;
+	u32		max_sq_inline;
+	u32		max_rq_sg;
 	u32		max_extend_sg;
-	int		num_qps;	/* 256k */
+	int		num_qps;
 	int             reserved_qps;
 	int		num_qpc_timer;
 	int		num_cqc_timer;
 	u32		max_srq_sg;
 	int		num_srqs;
-	u32		max_wqes;	/* 16k */
+	u32		max_wqes;
 	u32		max_srqs;
 	u32		max_srq_wrs;
 	u32		max_srq_sges;
-	u32		max_sq_desc_sz;	/* 64 */
-	u32		max_rq_desc_sz;	/* 64 */
+	u32		max_sq_desc_sz;
+	u32		max_rq_desc_sz;
 	u32		max_srq_desc_sz;
 	int		max_qp_init_rdma;
 	int		max_qp_dest_rdma;
@@ -822,7 +821,7 @@ struct hns_roce_caps {
 	int		reserved_cqs;
 	int		reserved_srqs;
 	u32		max_srqwqes;
-	int		num_aeq_vectors;	/* 1 */
+	int		num_aeq_vectors;
 	int		num_comp_vectors;
 	int		num_other_vectors;
 	int		num_mtpts;
@@ -903,7 +902,7 @@ struct hns_roce_caps {
 	u32		sl_num;
 	u32		tsq_buf_pg_sz;
 	u32		tpq_buf_pg_sz;
-	u32		chunk_sz;	/* chunk size in non multihop mode*/
+	u32		chunk_sz;	/* chunk size in non multihop mode */
 	u64		flags;
 };
 
@@ -1043,8 +1042,8 @@ struct hns_roce_dev {
 	int			loop_idc;
 	u32			sdb_offset;
 	u32			odb_offset;
-	dma_addr_t		tptr_dma_addr; /*only for hw v1*/
-	u32			tptr_size; /*only for hw v1*/
+	dma_addr_t		tptr_dma_addr;	/* only for hw v1 */
+	u32			tptr_size;	/* only for hw v1 */
 	const struct hns_roce_hw *hw;
 	void			*priv;
 	struct workqueue_struct *irq_workq;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.h b/drivers/infiniband/hw/hns/hns_roce_hem.h
index f1ccb8f..8678327 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.h
@@ -102,9 +102,9 @@ struct hns_roce_hem_mhop {
 	u32	buf_chunk_size;
 	u32	bt_chunk_size;
 	u32	ba_l0_num;
-	u32	l0_idx;/* level 0 base address table index */
-	u32	l1_idx;/* level 1 base address table index */
-	u32	l2_idx;/* level 2 base address table index */
+	u32	l0_idx; /* level 0 base address table index */
+	u32	l1_idx; /* level 1 base address table index */
+	u32	l2_idx; /* level 2 base address table index */
 };
 
 void hns_roce_free_hem(struct hns_roce_dev *hr_dev, struct hns_roce_hem *hem);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 88e96c1..6dcb3ac 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1886,7 +1886,7 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
 		goto err_tpq_init_failed;
 	}
 
-	/* Alloc memory for QPC Timer buffer space chunk*/
+	/* Alloc memory for QPC Timer buffer space chunk */
 	for (qpc_count = 0; qpc_count < hr_dev->caps.qpc_timer_bt_num;
 	     qpc_count++) {
 		ret = hns_roce_table_get(hr_dev, &hr_dev->qpc_timer_table,
@@ -1897,7 +1897,7 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
 		}
 	}
 
-	/* Alloc memory for CQC Timer buffer space chunk*/
+	/* Alloc memory for CQC Timer buffer space chunk */
 	for (cqc_count = 0; cqc_count < hr_dev->caps.cqc_timer_bt_num;
 	     cqc_count++) {
 		ret = hns_roce_table_get(hr_dev, &hr_dev->cqc_timer_table,
@@ -5236,14 +5236,12 @@ static void hns_roce_mhop_free_eq(struct hns_roce_dev *hr_dev,
 	buf_chk_sz = 1 << (hr_dev->caps.eqe_buf_pg_sz + PAGE_SHIFT);
 	bt_chk_sz = 1 << (hr_dev->caps.eqe_ba_pg_sz + PAGE_SHIFT);
 
-	/* hop_num = 0 */
 	if (mhop_num == HNS_ROCE_HOP_NUM_0) {
 		dma_free_coherent(dev, (unsigned int)(eq->entries *
 				  eq->eqe_size), eq->bt_l0, eq->l0_dma);
 		return;
 	}
 
-	/* hop_num = 1 or hop = 2 */
 	dma_free_coherent(dev, bt_chk_sz, eq->bt_l0, eq->l0_dma);
 	if (mhop_num == 1) {
 		for (i = 0; i < eq->l0_last_num; i++) {
@@ -5483,7 +5481,6 @@ static int hns_roce_mhop_alloc_eq(struct hns_roce_dev *hr_dev,
 			      buf_chk_sz);
 	bt_num = DIV_ROUND_UP(ba_num, bt_chk_sz / BA_BYTE_LEN);
 
-	/* hop_num = 0 */
 	if (mhop_num == HNS_ROCE_HOP_NUM_0) {
 		if (eq->entries > buf_chk_sz / eq->eqe_size) {
 			dev_err(dev, "eq entries %d is larger than buf_pg_sz!",
@@ -5749,7 +5746,7 @@ static int __hns_roce_request_irq(struct hns_roce_dev *hr_dev, int irq_num,
 		}
 	}
 
-	/* irq contains: abnormal + AEQ + CEQ*/
+	/* irq contains: abnormal + AEQ + CEQ */
 	for (j = 0; j < irq_num; j++)
 		if (j < other_num)
 			snprintf((char *)hr_dev->irq_names[j],
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 0cfa946..8157679 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -517,7 +517,6 @@ static int hns_roce_mhop_alloc(struct hns_roce_dev *hr_dev, int npages,
 	if (mhop_num == HNS_ROCE_HOP_NUM_0)
 		return 0;
 
-	/* hop_num = 1 */
 	if (mhop_num == 1)
 		return pbl_1hop_alloc(hr_dev, npages, mr, pbl_bt_sz);
 
-- 
1.9.1

