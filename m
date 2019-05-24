Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C688429B0C
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 17:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389517AbfEXPbA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 11:31:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44642 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389766AbfEXPbA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 May 2019 11:31:00 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0625C51AFAE7EE833C97;
        Fri, 24 May 2019 23:30:55 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Fri, 24 May 2019 23:30:45 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Clear magic number
Date:   Fri, 24 May 2019 23:29:36 +0800
Message-ID: <1558711776-11053-1-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch makes the code more readable by clearing magic numbers.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_db.c     |  8 ++--
 drivers/infiniband/hw/hns/hns_roce_device.h | 37 +++++++++++++---
 drivers/infiniband/hw/hns/hns_roce_hem.c    | 18 ++++----
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  4 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 65 ++++++++++++++++-------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  4 ++
 drivers/infiniband/hw/hns/hns_roce_main.c   |  7 ++--
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 43 ++++++++++---------
 8 files changed, 116 insertions(+), 70 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_db.c b/drivers/infiniband/hw/hns/hns_roce_db.c
index 0c6c1fe..3a040a9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_db.c
+++ b/drivers/infiniband/hw/hns/hns_roce_db.c
@@ -78,7 +78,8 @@ static struct hns_roce_db_pgdir *hns_roce_alloc_db_pgdir(
 	if (!pgdir)
 		return NULL;
 
-	bitmap_fill(pgdir->order1, HNS_ROCE_DB_PER_PAGE / 2);
+	bitmap_fill(pgdir->order1,
+		    HNS_ROCE_DB_PER_PAGE / HNS_ROCE_DB_TYPE_COUNT);
 	pgdir->bits[0] = pgdir->order0;
 	pgdir->bits[1] = pgdir->order1;
 	pgdir->page = dma_alloc_coherent(dma_device, PAGE_SIZE,
@@ -116,7 +117,7 @@ static int hns_roce_alloc_db_from_pgdir(struct hns_roce_db_pgdir *pgdir,
 	db->u.pgdir	= pgdir;
 	db->index	= i;
 	db->db_record	= pgdir->page + db->index;
-	db->dma		= pgdir->db_dma  + db->index * 4;
+	db->dma		= pgdir->db_dma  + db->index * HNS_ROCE_DB_UNIT_SIZE;
 	db->order	= order;
 
 	return 0;
@@ -170,7 +171,8 @@ void hns_roce_free_db(struct hns_roce_dev *hr_dev, struct hns_roce_db *db)
 	i >>= o;
 	set_bit(i, db->u.pgdir->bits[o]);
 
-	if (bitmap_full(db->u.pgdir->order1, HNS_ROCE_DB_PER_PAGE / 2)) {
+	if (bitmap_full(db->u.pgdir->order1,
+			HNS_ROCE_DB_PER_PAGE / HNS_ROCE_DB_TYPE_COUNT)) {
 		dma_free_coherent(hr_dev->dev, PAGE_SIZE, db->u.pgdir->page,
 				  db->u.pgdir->db_dma);
 		list_del(&db->u.pgdir->list);
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 563cf39..d6e8b44 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -37,9 +37,12 @@
 
 #define DRV_NAME "hns_roce"
 
+/* hip08 is a pci device, it includes two version according pci version id */
+#define PCI_REVISION_ID_HIP08_A			0x20
+#define PCI_REVISION_ID_HIP08_B			0x21
+
 #define HNS_ROCE_HW_VER1	('h' << 24 | 'i' << 16 | '0' << 8 | '6')
 
-#define MAC_ADDR_OCTET_NUM			6
 #define HNS_ROCE_MAX_MSG_LEN			0x80000000
 
 #define HNS_ROCE_ALOGN_UP(a, b) ((((a) + (b) - 1) / (b)) * (b))
@@ -48,6 +51,10 @@
 
 #define HNS_ROCE_BA_SIZE			(32 * 4096)
 
+#define BA_BYTE_LEN				8
+
+#define BITS_PER_BYTE				8
+
 /* Hardware specification only for v1 engine */
 #define HNS_ROCE_MIN_CQE_NUM			0x40
 #define HNS_ROCE_MIN_WQE_NUM			0x20
@@ -55,6 +62,7 @@
 /* Hardware specification only for v1 engine */
 #define HNS_ROCE_MAX_INNER_MTPT_NUM		0x7
 #define HNS_ROCE_MAX_MTPT_PBL_NUM		0x100000
+#define HNS_ROCE_MAX_SGE_NUM			2
 
 #define HNS_ROCE_EACH_FREE_CQ_WAIT_MSECS	20
 #define HNS_ROCE_MAX_FREE_CQ_WAIT_CNT	\
@@ -64,6 +72,9 @@
 
 #define HNS_ROCE_MAX_IRQ_NUM			128
 
+#define HNS_ROCE_SGE_IN_WQE			2
+#define HNS_ROCE_SGE_SHIFT			4
+
 #define EQ_ENABLE				1
 #define EQ_DISABLE				0
 
@@ -81,6 +92,7 @@
 #define HNS_ROCE_MAX_PORTS			6
 #define HNS_ROCE_MAX_GID_NUM			16
 #define HNS_ROCE_GID_SIZE			16
+#define HNS_ROCE_SGE_SIZE			16
 
 #define HNS_ROCE_HOP_NUM_0			0xff
 
@@ -111,6 +123,8 @@
 #define PAGES_SHIFT_24				24
 #define PAGES_SHIFT_32				32
 
+#define HNS_ROCE_PCI_BAR_NUM			2
+
 #define HNS_ROCE_IDX_QUE_ENTRY_SZ		4
 #define SRQ_DB_REG				0x230
 
@@ -213,6 +227,9 @@ enum hns_roce_mtt_type {
 	MTT_TYPE_IDX
 };
 
+#define HNS_ROCE_DB_TYPE_COUNT			2
+#define HNS_ROCE_DB_UNIT_SIZE			4
+
 enum {
 	HNS_ROCE_DB_PER_PAGE = PAGE_SIZE / 4
 };
@@ -413,8 +430,8 @@ struct hns_roce_buf {
 struct hns_roce_db_pgdir {
 	struct list_head	list;
 	DECLARE_BITMAP(order0, HNS_ROCE_DB_PER_PAGE);
-	DECLARE_BITMAP(order1, HNS_ROCE_DB_PER_PAGE / 2);
-	unsigned long		*bits[2];
+	DECLARE_BITMAP(order1, HNS_ROCE_DB_PER_PAGE / HNS_ROCE_DB_TYPE_COUNT);
+	unsigned long		*bits[HNS_ROCE_DB_TYPE_COUNT];
 	u32			*page;
 	dma_addr_t		db_dma;
 };
@@ -535,7 +552,7 @@ struct hns_roce_av {
 	u8          hop_limit;
 	__le32      sl_tclass_flowlabel;
 	u8          dgid[HNS_ROCE_GID_SIZE];
-	u8          mac[6];
+	u8          mac[ETH_ALEN];
 	__le16      vlan;
 	bool	    vlan_en;
 };
@@ -940,6 +957,16 @@ struct hns_roce_hw {
 	const struct ib_device_ops *hns_roce_dev_srq_ops;
 };
 
+enum hns_phy_state {
+	HNS_ROCE_PHY_SLEEP		= 1,
+	HNS_ROCE_PHY_POLLING		= 2,
+	HNS_ROCE_PHY_DISABLED		= 3,
+	HNS_ROCE_PHY_TRAINING		= 4,
+	HNS_ROCE_PHY_LINKUP		= 5,
+	HNS_ROCE_PHY_LINKERR		= 6,
+	HNS_ROCE_PHY_TEST		= 7
+};
+
 struct hns_roce_dev {
 	struct ib_device	ib_dev;
 	struct platform_device  *pdev;
@@ -962,7 +989,7 @@ struct hns_roce_dev {
 	struct hns_roce_caps	caps;
 	struct xarray		qp_table_xa;
 
-	unsigned char	dev_addr[HNS_ROCE_MAX_PORTS][MAC_ADDR_OCTET_NUM];
+	unsigned char	dev_addr[HNS_ROCE_MAX_PORTS][ETH_ALEN];
 	u64			sys_image_guid;
 	u32                     vendor_id;
 	u32                     vendor_part_id;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index d0eacd8..157c84a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -165,7 +165,7 @@ int hns_roce_calc_hem_mhop(struct hns_roce_dev *hr_dev,
 					     + PAGE_SHIFT);
 		mhop->bt_chunk_size = 1 << (hr_dev->caps.mtt_ba_pg_sz
 					     + PAGE_SHIFT);
-		mhop->ba_l0_num = mhop->bt_chunk_size / 8;
+		mhop->ba_l0_num = mhop->bt_chunk_size / BA_BYTE_LEN;
 		mhop->hop_num = hr_dev->caps.mtt_hop_num;
 		break;
 	case HEM_TYPE_CQE:
@@ -173,7 +173,7 @@ int hns_roce_calc_hem_mhop(struct hns_roce_dev *hr_dev,
 					     + PAGE_SHIFT);
 		mhop->bt_chunk_size = 1 << (hr_dev->caps.cqe_ba_pg_sz
 					     + PAGE_SHIFT);
-		mhop->ba_l0_num = mhop->bt_chunk_size / 8;
+		mhop->ba_l0_num = mhop->bt_chunk_size / BA_BYTE_LEN;
 		mhop->hop_num = hr_dev->caps.cqe_hop_num;
 		break;
 	case HEM_TYPE_SRQWQE:
@@ -181,7 +181,7 @@ int hns_roce_calc_hem_mhop(struct hns_roce_dev *hr_dev,
 					    + PAGE_SHIFT);
 		mhop->bt_chunk_size = 1 << (hr_dev->caps.srqwqe_ba_pg_sz
 					    + PAGE_SHIFT);
-		mhop->ba_l0_num = mhop->bt_chunk_size / 8;
+		mhop->ba_l0_num = mhop->bt_chunk_size / BA_BYTE_LEN;
 		mhop->hop_num = hr_dev->caps.srqwqe_hop_num;
 		break;
 	case HEM_TYPE_IDX:
@@ -189,7 +189,7 @@ int hns_roce_calc_hem_mhop(struct hns_roce_dev *hr_dev,
 				       + PAGE_SHIFT);
 		mhop->bt_chunk_size = 1 << (hr_dev->caps.idx_ba_pg_sz
 				       + PAGE_SHIFT);
-		mhop->ba_l0_num = mhop->bt_chunk_size / 8;
+		mhop->ba_l0_num = mhop->bt_chunk_size / BA_BYTE_LEN;
 		mhop->hop_num = hr_dev->caps.idx_hop_num;
 		break;
 	default:
@@ -206,7 +206,7 @@ int hns_roce_calc_hem_mhop(struct hns_roce_dev *hr_dev,
 	 * MTT/CQE alloc hem for bt pages.
 	 */
 	bt_num = hns_roce_get_bt_num(table->type, mhop->hop_num);
-	chunk_ba_num = mhop->bt_chunk_size / 8;
+	chunk_ba_num = mhop->bt_chunk_size / BA_BYTE_LEN;
 	chunk_size = table->type < HEM_TYPE_MTT ? mhop->buf_chunk_size :
 			      mhop->bt_chunk_size;
 	table_idx = (*obj & (table->num_obj - 1)) /
@@ -436,7 +436,7 @@ static int hns_roce_table_mhop_get(struct hns_roce_dev *hr_dev,
 	buf_chunk_size = mhop.buf_chunk_size;
 	bt_chunk_size = mhop.bt_chunk_size;
 	hop_num = mhop.hop_num;
-	chunk_ba_num = bt_chunk_size / 8;
+	chunk_ba_num = bt_chunk_size / BA_BYTE_LEN;
 
 	bt_num = hns_roce_get_bt_num(table->type, hop_num);
 	switch (bt_num) {
@@ -646,7 +646,7 @@ static void hns_roce_table_mhop_put(struct hns_roce_dev *hr_dev,
 
 	bt_chunk_size = mhop.bt_chunk_size;
 	hop_num = mhop.hop_num;
-	chunk_ba_num = bt_chunk_size / 8;
+	chunk_ba_num = bt_chunk_size / BA_BYTE_LEN;
 
 	bt_num = hns_roce_get_bt_num(table->type, hop_num);
 	switch (bt_num) {
@@ -800,7 +800,7 @@ void *hns_roce_table_find(struct hns_roce_dev *hr_dev,
 		i = mhop.l0_idx;
 		j = mhop.l1_idx;
 		if (mhop.hop_num == 2)
-			hem_idx = i * (mhop.bt_chunk_size / 8) + j;
+			hem_idx = i * (mhop.bt_chunk_size / BA_BYTE_LEN) + j;
 		else if (mhop.hop_num == 1 ||
 			 mhop.hop_num == HNS_ROCE_HOP_NUM_0)
 			hem_idx = i;
@@ -1000,7 +1000,7 @@ int hns_roce_init_hem_table(struct hns_roce_dev *hr_dev,
 		}
 		obj_per_chunk = buf_chunk_size / obj_size;
 		num_hem = (nobj + obj_per_chunk - 1) / obj_per_chunk;
-		bt_chunk_num = bt_chunk_size / 8;
+		bt_chunk_num = bt_chunk_size / BA_BYTE_LEN;
 		if (type >= HEM_TYPE_MTT)
 			num_bt_l0 = bt_chunk_num;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 8b3169a..878c8ae 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -818,7 +818,7 @@ static int hns_roce_v1_rsv_lp_qp(struct hns_roce_dev *hr_dev)
 		attr.dest_qp_num	= hr_qp->qpn;
 		memcpy(rdma_ah_retrieve_dmac(&attr.ah_attr),
 		       hr_dev->dev_addr[port],
-		       MAC_ADDR_OCTET_NUM);
+		       ETH_ALEN);
 
 		memcpy(&dgid.raw, &subnet_prefix, sizeof(u64));
 		memcpy(&dgid.raw[8], hr_dev->dev_addr[port], 3);
@@ -1103,7 +1103,7 @@ static int hns_roce_v1_dereg_mr(struct hns_roce_dev *hr_dev,
 	struct hns_roce_free_mr *free_mr;
 	struct hns_roce_v1_priv *priv;
 	struct completion comp;
-	unsigned long end = HNS_ROCE_V1_FREE_MR_TIMEOUT_MSECS ;
+	unsigned long end = HNS_ROCE_V1_FREE_MR_TIMEOUT_MSECS;
 	unsigned long start = jiffies;
 	int npages;
 	int ret = 0;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 1c7e6e6..7fcec99 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3426,7 +3426,9 @@ static void modify_qp_init_to_init(struct ib_qp *ibqp,
 	else
 		roce_set_field(context->byte_4_sqpn_tst,
 			       V2_QPC_BYTE_4_SGE_SHIFT_M,
-			       V2_QPC_BYTE_4_SGE_SHIFT_S, hr_qp->sq.max_gs > 2 ?
+			       V2_QPC_BYTE_4_SGE_SHIFT_S,
+			       hr_qp->sq.max_gs >
+			       HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE ?
 			       ilog2((unsigned int)hr_qp->sge.sge_cnt) : 0);
 
 	roce_set_field(qpc_mask->byte_4_sqpn_tst, V2_QPC_BYTE_4_SGE_SHIFT_M,
@@ -3708,13 +3710,14 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	roce_set_field(qpc_mask->byte_20_smac_sgid_idx,
 		       V2_QPC_BYTE_20_SGID_IDX_M,
 		       V2_QPC_BYTE_20_SGID_IDX_S, 0);
-	memcpy(&(context->dmac), dmac, 4);
+	memcpy(&(context->dmac), dmac, sizeof(u32));
 	roce_set_field(context->byte_52_udpspn_dmac, V2_QPC_BYTE_52_DMAC_M,
 		       V2_QPC_BYTE_52_DMAC_S, *((u16 *)(&dmac[4])));
 	qpc_mask->dmac = 0;
 	roce_set_field(qpc_mask->byte_52_udpspn_dmac, V2_QPC_BYTE_52_DMAC_M,
 		       V2_QPC_BYTE_52_DMAC_S, 0);
 
+	/* mtu*(2^LP_PKTN_INI) should not bigger than 1 message length 64kb */
 	roce_set_field(context->byte_56_dqpn_err, V2_QPC_BYTE_56_LP_PKTN_INI_M,
 		       V2_QPC_BYTE_56_LP_PKTN_INI_S, 4);
 	roce_set_field(qpc_mask->byte_56_dqpn_err, V2_QPC_BYTE_56_LP_PKTN_INI_M,
@@ -3756,6 +3759,7 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	roce_set_field(qpc_mask->byte_132_trrl, V2_QPC_BYTE_132_TRRL_TAIL_MAX_M,
 		       V2_QPC_BYTE_132_TRRL_TAIL_MAX_S, 0);
 
+	/* rocee send 2^lp_sgen_ini segs every time */
 	roce_set_field(context->byte_168_irrl_idx,
 		       V2_QPC_BYTE_168_LP_SGEN_INI_M,
 		       V2_QPC_BYTE_168_LP_SGEN_INI_S, 3);
@@ -3810,14 +3814,15 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
 		       V2_QPC_BYTE_168_SQ_CUR_BLK_ADDR_S, 0);
 
 	page_size = 1 << (hr_dev->caps.mtt_buf_pg_sz + PAGE_SHIFT);
-	context->sq_cur_sge_blk_addr =
-		       ((ibqp->qp_type == IB_QPT_GSI) || hr_qp->sq.max_gs > 2) ?
-				      ((u32)(mtts[hr_qp->sge.offset / page_size]
-				      >> PAGE_ADDR_SHIFT)) : 0;
+	context->sq_cur_sge_blk_addr = ((ibqp->qp_type == IB_QPT_GSI) ||
+		       hr_qp->sq.max_gs > HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE) ?
+		       ((u32)(mtts[hr_qp->sge.offset / page_size] >>
+		       PAGE_ADDR_SHIFT)) : 0;
 	roce_set_field(context->byte_184_irrl_idx,
 		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_M,
 		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_S,
-		       ((ibqp->qp_type == IB_QPT_GSI) || hr_qp->sq.max_gs > 2) ?
+		       ((ibqp->qp_type == IB_QPT_GSI) || hr_qp->sq.max_gs >
+		       HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE) ?
 		       (mtts[hr_qp->sge.offset / page_size] >>
 		       (32 + PAGE_ADDR_SHIFT)) : 0);
 	qpc_mask->sq_cur_sge_blk_addr = 0;
@@ -4144,7 +4149,7 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 		roce_set_field(context->byte_224_retry_msg,
 			       V2_QPC_BYTE_224_RETRY_MSG_PSN_M,
 			       V2_QPC_BYTE_224_RETRY_MSG_PSN_S,
-			       attr->sq_psn >> 16);
+			       attr->sq_psn >> V2_QPC_BYTE_220_RETRY_MSG_PSN_S);
 		roce_set_field(qpc_mask->byte_224_retry_msg,
 			       V2_QPC_BYTE_224_RETRY_MSG_PSN_M,
 			       V2_QPC_BYTE_224_RETRY_MSG_PSN_S, 0);
@@ -4374,11 +4379,12 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 						  V2_QPC_BYTE_56_DQPN_M,
 						  V2_QPC_BYTE_56_DQPN_S);
 	qp_attr->qp_access_flags = ((roce_get_bit(context->byte_76_srqn_op_en,
-						  V2_QPC_BYTE_76_RRE_S)) << 2) |
-				   ((roce_get_bit(context->byte_76_srqn_op_en,
-						  V2_QPC_BYTE_76_RWE_S)) << 1) |
-				   ((roce_get_bit(context->byte_76_srqn_op_en,
-						  V2_QPC_BYTE_76_ATE_S)) << 3);
+				    V2_QPC_BYTE_76_RRE_S)) << V2_QP_RWE_S) |
+				    ((roce_get_bit(context->byte_76_srqn_op_en,
+				    V2_QPC_BYTE_76_RWE_S)) << V2_QP_RRE_S) |
+				    ((roce_get_bit(context->byte_76_srqn_op_en,
+				    V2_QPC_BYTE_76_ATE_S)) << V2_QP_ATE_S);
+
 	if (hr_qp->ibqp.qp_type == IB_QPT_RC ||
 	    hr_qp->ibqp.qp_type == IB_QPT_UC) {
 		struct ib_global_route *grh =
@@ -5150,8 +5156,8 @@ static void hns_roce_mhop_free_eq(struct hns_roce_dev *hr_dev,
 			dma_free_coherent(dev, bt_chk_sz, eq->bt_l1[i],
 					  eq->l1_dma[i]);
 
-			for (j = 0; j < bt_chk_sz / 8; j++) {
-				idx = i * (bt_chk_sz / 8) + j;
+			for (j = 0; j < bt_chk_sz / BA_BYTE_LEN; j++) {
+				idx = i * (bt_chk_sz / BA_BYTE_LEN) + j;
 				if ((i == eq->l0_last_num - 1)
 				     && j == eq->l1_last_num - 1) {
 					eqe_alloc = (buf_chk_sz / eq->eqe_size)
@@ -5367,9 +5373,9 @@ static int hns_roce_mhop_alloc_eq(struct hns_roce_dev *hr_dev,
 	buf_chk_sz = 1 << (hr_dev->caps.eqe_buf_pg_sz + PAGE_SHIFT);
 	bt_chk_sz = 1 << (hr_dev->caps.eqe_ba_pg_sz + PAGE_SHIFT);
 
-	ba_num = (PAGE_ALIGN(eq->entries * eq->eqe_size) + buf_chk_sz - 1)
-		  / buf_chk_sz;
-	bt_num = (ba_num + bt_chk_sz / 8 - 1) / (bt_chk_sz / 8);
+	ba_num = DIV_ROUND_UP(PAGE_ALIGN(eq->entries * eq->eqe_size),
+			      buf_chk_sz);
+	bt_num = DIV_ROUND_UP(ba_num, bt_chk_sz / BA_BYTE_LEN);
 
 	/* hop_num = 0 */
 	if (mhop_num == HNS_ROCE_HOP_NUM_0) {
@@ -5414,12 +5420,12 @@ static int hns_roce_mhop_alloc_eq(struct hns_roce_dev *hr_dev,
 		goto err_dma_alloc_l0;
 
 	if (mhop_num == 1) {
-		if (ba_num > (bt_chk_sz / 8))
+		if (ba_num > (bt_chk_sz / BA_BYTE_LEN))
 			dev_err(dev, "ba_num %d is too large for 1 hop\n",
 				ba_num);
 
 		/* alloc buf */
-		for (i = 0; i < bt_chk_sz / 8; i++) {
+		for (i = 0; i < bt_chk_sz / BA_BYTE_LEN; i++) {
 			if (eq_buf_cnt + 1 < ba_num) {
 				size = buf_chk_sz;
 			} else {
@@ -5443,7 +5449,7 @@ static int hns_roce_mhop_alloc_eq(struct hns_roce_dev *hr_dev,
 
 	} else if (mhop_num == 2) {
 		/* alloc L1 BT and buf */
-		for (i = 0; i < bt_chk_sz / 8; i++) {
+		for (i = 0; i < bt_chk_sz / BA_BYTE_LEN; i++) {
 			eq->bt_l1[i] = dma_alloc_coherent(dev, bt_chk_sz,
 							  &(eq->l1_dma[i]),
 							  GFP_KERNEL);
@@ -5451,8 +5457,8 @@ static int hns_roce_mhop_alloc_eq(struct hns_roce_dev *hr_dev,
 				goto err_dma_alloc_l1;
 			*(eq->bt_l0 + i) = eq->l1_dma[i];
 
-			for (j = 0; j < bt_chk_sz / 8; j++) {
-				idx = i * bt_chk_sz / 8 + j;
+			for (j = 0; j < bt_chk_sz / BA_BYTE_LEN; j++) {
+				idx = i * bt_chk_sz / BA_BYTE_LEN + j;
 				if (eq_buf_cnt + 1 < ba_num) {
 					size = buf_chk_sz;
 				} else {
@@ -5497,8 +5503,8 @@ static int hns_roce_mhop_alloc_eq(struct hns_roce_dev *hr_dev,
 		dma_free_coherent(dev, bt_chk_sz, eq->bt_l1[i],
 				  eq->l1_dma[i]);
 
-		for (j = 0; j < bt_chk_sz / 8; j++) {
-			idx = i * bt_chk_sz / 8 + j;
+		for (j = 0; j < bt_chk_sz / BA_BYTE_LEN; j++) {
+			idx = i * bt_chk_sz / BA_BYTE_LEN + j;
 			dma_free_coherent(dev, buf_chk_sz, eq->buf[idx],
 					  eq->buf_dma[idx]);
 		}
@@ -5521,11 +5527,11 @@ static int hns_roce_mhop_alloc_eq(struct hns_roce_dev *hr_dev,
 			dma_free_coherent(dev, bt_chk_sz, eq->bt_l1[i],
 					  eq->l1_dma[i]);
 
-			for (j = 0; j < bt_chk_sz / 8; j++) {
+			for (j = 0; j < bt_chk_sz / BA_BYTE_LEN; j++) {
 				if (i == record_i && j >= record_j)
 					break;
 
-				idx = i * bt_chk_sz / 8 + j;
+				idx = i * bt_chk_sz / BA_BYTE_LEN + j;
 				dma_free_coherent(dev, buf_chk_sz,
 						  eq->buf[idx],
 						  eq->buf_dma[idx]);
@@ -5982,7 +5988,7 @@ static int find_empty_entry(struct hns_roce_idx_que *idx_que)
 	bit_num = ffs(idx_que->bitmap[i]);
 	idx_que->bitmap[i] &= ~(1ULL << (bit_num - 1));
 
-	return i * sizeof(u64) * 8 + (bit_num - 1);
+	return i * BITS_PER_LONG_LONG + (bit_num - 1);
 }
 
 static void fill_idx_queue(struct hns_roce_idx_que *idx_que,
@@ -6058,7 +6064,8 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 		 */
 		wmb();
 
-		srq_db.byte_4 = HNS_ROCE_V2_SRQ_DB << 24 | srq->srqn;
+		srq_db.byte_4 = HNS_ROCE_V2_SRQ_DB << V2_DB_BYTE_4_CMD_S |
+				(srq->srqn & V2_DB_BYTE_4_TAG_M);
 		srq_db.parameter = srq->head;
 
 		hns_roce_write64(hr_dev, (__le32 *)&srq_db, srq->db_reg_l);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 0ac177a..bce21fd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -886,6 +886,10 @@ struct hns_roce_v2_qp_context {
 #define	V2_QPC_BYTE_256_SQ_FLUSH_IDX_S 16
 #define V2_QPC_BYTE_256_SQ_FLUSH_IDX_M GENMASK(31, 16)
 
+#define	V2_QP_RWE_S 1 /* rdma write enable */
+#define	V2_QP_RRE_S 2 /* rdma read enable */
+#define	V2_QP_ATE_S 3 /* rdma atomic enable */
+
 struct hns_roce_v2_cqe {
 	__le32	byte_4;
 	union {
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 05a0f7d..a6c5c67 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -64,10 +64,10 @@ static int hns_roce_set_mac(struct hns_roce_dev *hr_dev, u8 port, u8 *addr)
 	u8 phy_port;
 	u32 i = 0;
 
-	if (!memcmp(hr_dev->dev_addr[port], addr, MAC_ADDR_OCTET_NUM))
+	if (!memcmp(hr_dev->dev_addr[port], addr, ETH_ALEN))
 		return 0;
 
-	for (i = 0; i < MAC_ADDR_OCTET_NUM; i++)
+	for (i = 0; i < ETH_ALEN; i++)
 		hr_dev->dev_addr[port][i] = addr[i];
 
 	phy_port = hr_dev->iboe.phy_port[port];
@@ -262,7 +262,8 @@ static int hns_roce_query_port(struct ib_device *ib_dev, u8 port_num,
 	props->active_mtu = mtu ? min(props->max_mtu, mtu) : IB_MTU_256;
 	props->state = (netif_running(net_dev) && netif_carrier_ok(net_dev)) ?
 			IB_PORT_ACTIVE : IB_PORT_DOWN;
-	props->phys_state = (props->state == IB_PORT_ACTIVE) ? 5 : 3;
+	props->phys_state = (props->state == IB_PORT_ACTIVE) ?
+			     HNS_ROCE_PHY_LINKUP : HNS_ROCE_PHY_DISABLED;
 
 	spin_unlock_irqrestore(&hr_dev->iboe.lock, flags);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 6110ec4..38ed4ac 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -314,11 +314,11 @@ static void hns_roce_loop_free(struct hns_roce_dev *hr_dev,
 			dma_free_coherent(dev, pbl_bt_sz, mr->pbl_bt_l1[i],
 					  mr->pbl_l1_dma_addr[i]);
 
-			for (j = 0; j < pbl_bt_sz / 8; j++) {
+			for (j = 0; j < pbl_bt_sz / BA_BYTE_LEN; j++) {
 				if (i == loop_i && j >= loop_j)
 					break;
 
-				bt_idx = i * pbl_bt_sz / 8 + j;
+				bt_idx = i * pbl_bt_sz / BA_BYTE_LEN + j;
 				dma_free_coherent(dev, pbl_bt_sz,
 						  mr->pbl_bt_l2[bt_idx],
 						  mr->pbl_l2_dma_addr[bt_idx]);
@@ -329,8 +329,8 @@ static void hns_roce_loop_free(struct hns_roce_dev *hr_dev,
 			dma_free_coherent(dev, pbl_bt_sz, mr->pbl_bt_l1[i],
 					  mr->pbl_l1_dma_addr[i]);
 
-			for (j = 0; j < pbl_bt_sz / 8; j++) {
-				bt_idx = i * pbl_bt_sz / 8 + j;
+			for (j = 0; j < pbl_bt_sz / BA_BYTE_LEN; j++) {
+				bt_idx = i * pbl_bt_sz / BA_BYTE_LEN + j;
 				dma_free_coherent(dev, pbl_bt_sz,
 						  mr->pbl_bt_l2[bt_idx],
 						  mr->pbl_l2_dma_addr[bt_idx]);
@@ -533,7 +533,7 @@ static int hns_roce_mr_alloc(struct hns_roce_dev *hr_dev, u32 pd, u64 iova,
 {
 	struct device *dev = hr_dev->dev;
 	unsigned long index = 0;
-	int ret = 0;
+	int ret;
 
 	/* Allocate a key for mr from mr_table */
 	ret = hns_roce_bitmap_alloc(&hr_dev->mr_table.mtpt_bitmap, &index);
@@ -559,7 +559,8 @@ static int hns_roce_mr_alloc(struct hns_roce_dev *hr_dev, u32 pd, u64 iova,
 		mr->pbl_l0_dma_addr = 0;
 	} else {
 		if (!hr_dev->caps.pbl_hop_num) {
-			mr->pbl_buf = dma_alloc_coherent(dev, npages * 8,
+			mr->pbl_buf = dma_alloc_coherent(dev,
+							 npages * BA_BYTE_LEN,
 							 &(mr->pbl_dma_addr),
 							 GFP_KERNEL);
 			if (!mr->pbl_buf)
@@ -590,9 +591,8 @@ static void hns_roce_mhop_free(struct hns_roce_dev *hr_dev,
 	if (mhop_num == HNS_ROCE_HOP_NUM_0)
 		return;
 
-	/* hop_num = 1 */
 	if (mhop_num == 1) {
-		dma_free_coherent(dev, (unsigned int)(npages * 8),
+		dma_free_coherent(dev, (unsigned int)(npages * BA_BYTE_LEN),
 				  mr->pbl_buf, mr->pbl_dma_addr);
 		return;
 	}
@@ -603,12 +603,13 @@ static void hns_roce_mhop_free(struct hns_roce_dev *hr_dev,
 	if (mhop_num == 2) {
 		for (i = 0; i < mr->l0_chunk_last_num; i++) {
 			if (i == mr->l0_chunk_last_num - 1) {
-				npages_allocated = i * (pbl_bt_sz / 8);
+				npages_allocated =
+						i * (pbl_bt_sz / BA_BYTE_LEN);
 
 				dma_free_coherent(dev,
-					      (npages - npages_allocated) * 8,
-					      mr->pbl_bt_l1[i],
-					      mr->pbl_l1_dma_addr[i]);
+				      (npages - npages_allocated) * BA_BYTE_LEN,
+				       mr->pbl_bt_l1[i],
+				       mr->pbl_l1_dma_addr[i]);
 
 				break;
 			}
@@ -621,16 +622,17 @@ static void hns_roce_mhop_free(struct hns_roce_dev *hr_dev,
 			dma_free_coherent(dev, pbl_bt_sz, mr->pbl_bt_l1[i],
 					  mr->pbl_l1_dma_addr[i]);
 
-			for (j = 0; j < pbl_bt_sz / 8; j++) {
-				bt_idx = i * (pbl_bt_sz / 8) + j;
+			for (j = 0; j < pbl_bt_sz / BA_BYTE_LEN; j++) {
+				bt_idx = i * (pbl_bt_sz / BA_BYTE_LEN) + j;
 
 				if ((i == mr->l0_chunk_last_num - 1)
 				    && j == mr->l1_chunk_last_num - 1) {
 					npages_allocated = bt_idx *
-							   (pbl_bt_sz / 8);
+						      (pbl_bt_sz / BA_BYTE_LEN);
 
 					dma_free_coherent(dev,
-					      (npages - npages_allocated) * 8,
+					      (npages - npages_allocated) *
+					      BA_BYTE_LEN,
 					      mr->pbl_bt_l2[bt_idx],
 					      mr->pbl_l2_dma_addr[bt_idx]);
 
@@ -675,7 +677,8 @@ static void hns_roce_mr_free(struct hns_roce_dev *hr_dev,
 			npages = ib_umem_page_count(mr->umem);
 
 		if (!hr_dev->caps.pbl_hop_num)
-			dma_free_coherent(dev, (unsigned int)(npages * 8),
+			dma_free_coherent(dev,
+					  (unsigned int)(npages * BA_BYTE_LEN),
 					  mr->pbl_buf, mr->pbl_dma_addr);
 		else
 			hns_roce_mhop_free(hr_dev, mr);
@@ -1059,6 +1062,7 @@ static int hns_roce_ib_umem_write_mr(struct hns_roce_dev *hr_dev,
 	for_each_sg_dma_page(umem->sg_head.sgl, &sg_iter, umem->nmap, 0) {
 		page_addr = sg_page_iter_dma_address(&sg_iter);
 		if (!hr_dev->caps.pbl_hop_num) {
+			/* for hip06, page addr is aligned to 4K */
 			mr->pbl_buf[i++] = page_addr >> 12;
 		} else if (hr_dev->caps.pbl_hop_num == 1) {
 			mr->pbl_buf[i++] = page_addr;
@@ -1069,7 +1073,7 @@ static int hns_roce_ib_umem_write_mr(struct hns_roce_dev *hr_dev,
 				mr->pbl_bt_l2[i][j] = page_addr;
 
 			j++;
-			if (j >= (pbl_bt_sz / 8)) {
+			if (j >= (pbl_bt_sz / BA_BYTE_LEN)) {
 				i++;
 				j = 0;
 			}
@@ -1117,7 +1121,8 @@ struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	} else {
 		u64 pbl_size = 1;
 
-		bt_size = (1 << (hr_dev->caps.pbl_ba_pg_sz + PAGE_SHIFT)) / 8;
+		bt_size = (1 << (hr_dev->caps.pbl_ba_pg_sz + PAGE_SHIFT)) /
+			  BA_BYTE_LEN;
 		for (i = 0; i < hr_dev->caps.pbl_hop_num; i++)
 			pbl_size *= bt_size;
 		if (n > pbl_size) {
-- 
1.9.1

