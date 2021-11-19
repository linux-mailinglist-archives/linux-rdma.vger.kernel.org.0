Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA8D457040
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Nov 2021 15:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbhKSOJp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Nov 2021 09:09:45 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:26335 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235648AbhKSOJo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Nov 2021 09:09:44 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Hwdd32yVLzbhwl;
        Fri, 19 Nov 2021 22:01:43 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
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
Subject: [PATCH for-next 3/9] RDMA/hns: Replace tab with space in the right-side comments
Date:   Fri, 19 Nov 2021 22:02:02 +0800
Message-ID: <20211119140208.40416-4-liangwenpeng@huawei.com>
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

There should be a space between the code and the comment on the right.

Signed-off-by: Xinhao Liu <liuxinhao5@hisilicon.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 26 ++++++++++-----------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  2 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c     |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 43e17d61cb63..4c3b2e8b0d07 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -354,10 +354,10 @@ struct hns_roce_mr {
 	u64			size; /* Address range of MR */
 	u32			key; /* Key of MR */
 	u32			pd;   /* PD num of MR */
-	u32			access;	/* Access permission of MR */
+	u32			access; /* Access permission of MR */
 	int			enabled; /* MR's active status */
-	int			type;	/* MR's register type */
-	u32			pbl_hop_num;	/* multi-hop number */
+	int			type; /* MR's register type */
+	u32			pbl_hop_num; /* multi-hop number */
 	struct hns_roce_mtr	pbl_mtr;
 	u32			npages;
 	dma_addr_t		*page_list;
@@ -375,16 +375,16 @@ struct hns_roce_wq {
 	u32		max_gs;
 	u32		rsv_sge;
 	int		offset;
-	int		wqe_shift;	/* WQE size */
+	int		wqe_shift; /* WQE size */
 	u32		head;
 	u32		tail;
 	void __iomem	*db_reg;
 };
 
 struct hns_roce_sge {
-	unsigned int	sge_cnt;	/* SGE num */
+	unsigned int	sge_cnt; /* SGE num */
 	int		offset;
-	int		sge_shift;	/* SGE size */
+	int		sge_shift; /* SGE size */
 };
 
 struct hns_roce_buf_list {
@@ -672,9 +672,9 @@ struct hns_roce_qp {
 	unsigned long		flush_flag;
 	struct hns_roce_work	flush_work;
 	struct hns_roce_rinl_buf rq_inl_buf;
-	struct list_head	node;		/* all qps are on a list */
-	struct list_head	rq_node;	/* all recv qps are on a list */
-	struct list_head	sq_node;	/* all send qps are on a list */
+	struct list_head	node; /* all qps are on a list */
+	struct list_head	rq_node; /* all recv qps are on a list */
+	struct list_head	sq_node; /* all send qps are on a list */
 };
 
 struct hns_roce_ib_iboe {
@@ -855,7 +855,7 @@ struct hns_roce_caps {
 	u32		cqc_timer_ba_pg_sz;
 	u32		cqc_timer_buf_pg_sz;
 	u32		cqc_timer_hop_num;
-	u32             cqe_ba_pg_sz;	/* page_size = 4K*(2^cqe_ba_pg_sz) */
+	u32		cqe_ba_pg_sz; /* page_size = 4K*(2^cqe_ba_pg_sz) */
 	u32		cqe_buf_pg_sz;
 	u32		cqe_hop_num;
 	u32		srqwqe_ba_pg_sz;
@@ -874,7 +874,7 @@ struct hns_roce_caps {
 	u32		gmv_hop_num;
 	u32		sl_num;
 	u32		llm_buf_pg_sz;
-	u32		chunk_sz;	/* chunk size in non multihop mode */
+	u32		chunk_sz; /* chunk size in non multihop mode */
 	u64		flags;
 	u16		default_ceq_max_cnt;
 	u16		default_ceq_period;
@@ -1001,8 +1001,8 @@ struct hns_roce_dev {
 	int			loop_idc;
 	u32			sdb_offset;
 	u32			odb_offset;
-	dma_addr_t		tptr_dma_addr;	/* only for hw v1 */
-	u32			tptr_size;	/* only for hw v1 */
+	dma_addr_t		tptr_dma_addr; /* only for hw v1 */
+	u32			tptr_size; /* only for hw v1 */
 	const struct hns_roce_hw *hw;
 	void			*priv;
 	struct workqueue_struct *irq_workq;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 4d904d5e82be..6858b939de63 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1441,7 +1441,7 @@ struct hns_roce_v2_priv {
 struct hns_roce_dip {
 	u8 dgid[GID_LEN_V2];
 	u32 dip_idx;
-	struct list_head node;	/* all dips are on a list */
+	struct list_head node; /* all dips are on a list */
 };
 
 #define HNS_ROCE_AEQ_DEFAULT_BURST_NUM	0x0
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 7089ac780291..bf47191ce38b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -81,7 +81,7 @@ static int alloc_mr_key(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr)
 		return -ENOMEM;
 	}
 
-	mr->key = hw_index_to_key(id);		/* MR key */
+	mr->key = hw_index_to_key(id); /* MR key */
 
 	err = hns_roce_table_get(hr_dev, &hr_dev->mr_table.mtpt_table,
 				 (unsigned long)id);
-- 
2.33.0

