Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630752D5BAD
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Dec 2020 14:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389262AbgLJNZp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Dec 2020 08:25:45 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9151 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389230AbgLJNZp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Dec 2020 08:25:45 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CsF4d1Kjqz15Yrq;
        Thu, 10 Dec 2020 21:24:17 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Dec 2020 21:24:39 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v3 for-next 09/11] RDMA/hns: Fix incorrect symbol types
Date:   Thu, 10 Dec 2020 21:22:50 +0800
Message-ID: <1607606572-11968-10-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1607606572-11968-1-git-send-email-liweihang@huawei.com>
References: <1607606572-11968-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

Types of some fields, variables and parameters of some functions should be
unsigned.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cmd.c    | 10 +++---
 drivers/infiniband/hw/hns/hns_roce_cmd.h    |  2 +-
 drivers/infiniband/hw/hns/hns_roce_common.h | 14 ++++----
 drivers/infiniband/hw/hns/hns_roce_db.c     |  8 ++---
 drivers/infiniband/hw/hns/hns_roce_device.h | 53 +++++++++++++++--------------
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  8 ++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 30 ++++++++--------
 drivers/infiniband/hw/hns/hns_roce_main.c   |  2 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 11 +++---
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  8 ++---
 10 files changed, 73 insertions(+), 73 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c b/drivers/infiniband/hw/hns/hns_roce_cmd.c
index c493d76..339e3fd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
@@ -60,7 +60,7 @@ static int hns_roce_cmd_mbox_post_hw(struct hns_roce_dev *hr_dev, u64 in_param,
 static int __hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev, u64 in_param,
 				    u64 out_param, unsigned long in_modifier,
 				    u8 op_modifier, u16 op,
-				    unsigned long timeout)
+				    unsigned int timeout)
 {
 	struct device *dev = hr_dev->dev;
 	int ret;
@@ -78,7 +78,7 @@ static int __hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev, u64 in_param,
 
 static int hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev, u64 in_param,
 				  u64 out_param, unsigned long in_modifier,
-				  u8 op_modifier, u16 op, unsigned long timeout)
+				  u8 op_modifier, u16 op, unsigned int timeout)
 {
 	int ret;
 
@@ -108,7 +108,7 @@ void hns_roce_cmd_event(struct hns_roce_dev *hr_dev, u16 token, u8 status,
 static int __hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 				    u64 out_param, unsigned long in_modifier,
 				    u8 op_modifier, u16 op,
-				    unsigned long timeout)
+				    unsigned int timeout)
 {
 	struct hns_roce_cmdq *cmd = &hr_dev->cmd;
 	struct hns_roce_cmd_context *context;
@@ -159,7 +159,7 @@ static int __hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 
 static int hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 				  u64 out_param, unsigned long in_modifier,
-				  u8 op_modifier, u16 op, unsigned long timeout)
+				  u8 op_modifier, u16 op, unsigned int timeout)
 {
 	int ret;
 
@@ -173,7 +173,7 @@ static int hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 
 int hns_roce_cmd_mbox(struct hns_roce_dev *hr_dev, u64 in_param, u64 out_param,
 		      unsigned long in_modifier, u8 op_modifier, u16 op,
-		      unsigned long timeout)
+		      unsigned int timeout)
 {
 	int ret;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.h b/drivers/infiniband/hw/hns/hns_roce_cmd.h
index 8e63b82..8025e7f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.h
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.h
@@ -141,7 +141,7 @@ enum {
 
 int hns_roce_cmd_mbox(struct hns_roce_dev *hr_dev, u64 in_param, u64 out_param,
 		      unsigned long in_modifier, u8 op_modifier, u16 op,
-		      unsigned long timeout);
+		      unsigned int timeout);
 
 struct hns_roce_cmd_mailbox *
 hns_roce_alloc_cmd_mailbox(struct hns_roce_dev *hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_common.h b/drivers/infiniband/hw/hns/hns_roce_common.h
index 29469e1..5afee04 100644
--- a/drivers/infiniband/hw/hns/hns_roce_common.h
+++ b/drivers/infiniband/hw/hns/hns_roce_common.h
@@ -38,19 +38,19 @@
 #define roce_raw_write(value, addr) \
 	__raw_writel((__force u32)cpu_to_le32(value), (addr))
 
-#define roce_get_field(origin, mask, shift) \
-	(((le32_to_cpu(origin)) & (mask)) >> (shift))
+#define roce_get_field(origin, mask, shift)                                    \
+	((le32_to_cpu(origin) & (mask)) >> (u32)(shift))
 
 #define roce_get_bit(origin, shift) \
 	roce_get_field((origin), (1ul << (shift)), (shift))
 
-#define roce_set_field(origin, mask, shift, val) \
-	do { \
-		(origin) &= ~cpu_to_le32(mask); \
-		(origin) |= cpu_to_le32(((u32)(val) << (shift)) & (mask)); \
+#define roce_set_field(origin, mask, shift, val)                               \
+	do {                                                                   \
+		(origin) &= ~cpu_to_le32(mask);                                \
+		(origin) |= cpu_to_le32(((u32)(val) << (u32)(shift)) & (mask));     \
 	} while (0)
 
-#define roce_set_bit(origin, shift, val) \
+#define roce_set_bit(origin, shift, val)                                       \
 	roce_set_field((origin), (1ul << (shift)), (shift), (val))
 
 #define FIELD_LOC(field_type, field_h, field_l) field_type, field_h, field_l
diff --git a/drivers/infiniband/hw/hns/hns_roce_db.c b/drivers/infiniband/hw/hns/hns_roce_db.c
index bff6abd..5cb7376c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_db.c
+++ b/drivers/infiniband/hw/hns/hns_roce_db.c
@@ -95,8 +95,8 @@ static struct hns_roce_db_pgdir *hns_roce_alloc_db_pgdir(
 static int hns_roce_alloc_db_from_pgdir(struct hns_roce_db_pgdir *pgdir,
 					struct hns_roce_db *db, int order)
 {
-	int o;
-	int i;
+	unsigned long o;
+	unsigned long i;
 
 	for (o = order; o <= 1; ++o) {
 		i = find_first_bit(pgdir->bits[o], HNS_ROCE_DB_PER_PAGE >> o);
@@ -154,8 +154,8 @@ int hns_roce_alloc_db(struct hns_roce_dev *hr_dev, struct hns_roce_db *db,
 
 void hns_roce_free_db(struct hns_roce_dev *hr_dev, struct hns_roce_db *db)
 {
-	int o;
-	int i;
+	unsigned long o;
+	unsigned long i;
 
 	mutex_lock(&hr_dev->pgdir_mutex);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 4ba6ff5..89c0c74 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -311,7 +311,7 @@ struct hns_roce_hem_table {
 };
 
 struct hns_roce_buf_region {
-	int offset; /* page offset */
+	u32 offset; /* page offset */
 	u32 count; /* page count */
 	int hopnum; /* addressing hop num */
 };
@@ -331,10 +331,10 @@ struct hns_roce_buf_attr {
 		size_t	size;  /* region size */
 		int	hopnum; /* multi-hop addressing hop num */
 	} region[HNS_ROCE_MAX_BT_REGION];
-	int region_count; /* valid region count */
+	unsigned int region_count; /* valid region count */
 	unsigned int page_shift;  /* buffer page shift */
 	bool fixed_page; /* decide page shift is fixed-size or maximum size */
-	int user_access; /* umem access flag */
+	unsigned int user_access; /* umem access flag */
 	bool mtt_only; /* only alloc buffer-required MTT memory */
 };
 
@@ -345,7 +345,7 @@ struct hns_roce_hem_cfg {
 	unsigned int	buf_pg_shift; /* buffer page shift */
 	unsigned int	buf_pg_count;  /* buffer page count */
 	struct hns_roce_buf_region region[HNS_ROCE_MAX_BT_REGION];
-	int		region_count;
+	unsigned int	region_count;
 };
 
 /* memory translate region */
@@ -393,7 +393,7 @@ struct hns_roce_wq {
 	u64		*wrid;     /* Work request ID */
 	spinlock_t	lock;
 	u32		wqe_cnt;  /* WQE num */
-	int		max_gs;
+	u32		max_gs;
 	int		offset;
 	int		wqe_shift;	/* WQE size */
 	u32		head;
@@ -459,8 +459,8 @@ struct hns_roce_db {
 	} u;
 	dma_addr_t	dma;
 	void		*virt_addr;
-	int		index;
-	int		order;
+	unsigned long	index;
+	unsigned long	order;
 };
 
 struct hns_roce_cq {
@@ -508,8 +508,8 @@ struct hns_roce_srq {
 	u64		       *wrid;
 	struct hns_roce_idx_que idx_que;
 	spinlock_t		lock;
-	int			head;
-	int			tail;
+	u16			head;
+	u16			tail;
 	struct mutex		mutex;
 	void (*event)(struct hns_roce_srq *srq, enum hns_roce_event event);
 };
@@ -747,11 +747,11 @@ struct hns_roce_eq {
 	int				type_flag; /* Aeq:1 ceq:0 */
 	int				eqn;
 	u32				entries;
-	int				log_entries;
+	u32				log_entries;
 	int				eqe_size;
 	int				irq;
 	int				log_page_size;
-	int				cons_index;
+	u32				cons_index;
 	struct hns_roce_buf_list	*buf_list;
 	int				over_ignore;
 	int				coalesce;
@@ -759,7 +759,7 @@ struct hns_roce_eq {
 	int				hop_num;
 	struct hns_roce_mtr		mtr;
 	u16				eq_max_cnt;
-	int				eq_period;
+	u32				eq_period;
 	int				shift;
 	int				event_type;
 	int				sub_type;
@@ -782,8 +782,8 @@ struct hns_roce_caps {
 	u32		max_sq_inline;
 	u32		max_rq_sg;
 	u32		max_extend_sg;
-	int		num_qps;
-	u32             reserved_qps;
+	u32		num_qps;
+	u32		reserved_qps;
 	int		num_qpc_timer;
 	int		num_cqc_timer;
 	int		num_srqs;
@@ -795,7 +795,7 @@ struct hns_roce_caps {
 	u32		max_srq_desc_sz;
 	int		max_qp_init_rdma;
 	int		max_qp_dest_rdma;
-	int		num_cqs;
+	u32		num_cqs;
 	u32		max_cqes;
 	u32		min_cqes;
 	u32		min_wqes;
@@ -804,7 +804,7 @@ struct hns_roce_caps {
 	int		num_aeq_vectors;
 	int		num_comp_vectors;
 	int		num_other_vectors;
-	int		num_mtpts;
+	u32		num_mtpts;
 	u32		num_mtt_segs;
 	u32		num_cqe_segs;
 	u32		num_srqwqe_segs;
@@ -921,7 +921,7 @@ struct hns_roce_hw {
 	int (*post_mbox)(struct hns_roce_dev *hr_dev, u64 in_param,
 			 u64 out_param, u32 in_modifier, u8 op_modifier, u16 op,
 			 u16 token, int event);
-	int (*chk_mbox)(struct hns_roce_dev *hr_dev, unsigned long timeout);
+	int (*chk_mbox)(struct hns_roce_dev *hr_dev, unsigned int timeout);
 	int (*rst_prc_mbox)(struct hns_roce_dev *hr_dev);
 	int (*set_gid)(struct hns_roce_dev *hr_dev, u8 port, int gid_index,
 		       const union ib_gid *gid, const struct ib_gid_attr *attr);
@@ -1096,15 +1096,16 @@ static inline struct hns_roce_qp
 	return xa_load(&hr_dev->qp_table_xa, qpn & (hr_dev->caps.num_qps - 1));
 }
 
-static inline void *hns_roce_buf_offset(struct hns_roce_buf *buf, int offset)
+static inline void *hns_roce_buf_offset(struct hns_roce_buf *buf,
+					unsigned int offset)
 {
 	return (char *)(buf->trunk_list[offset >> buf->trunk_shift].buf) +
 			(offset & ((1 << buf->trunk_shift) - 1));
 }
 
-static inline dma_addr_t hns_roce_buf_page(struct hns_roce_buf *buf, int idx)
+static inline dma_addr_t hns_roce_buf_page(struct hns_roce_buf *buf, u32 idx)
 {
-	int offset = idx << buf->page_shift;
+	unsigned int offset = idx << buf->page_shift;
 
 	return buf->trunk_list[offset >> buf->trunk_shift].map +
 			(offset & ((1 << buf->trunk_shift) - 1));
@@ -1179,7 +1180,7 @@ int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 void hns_roce_mtr_destroy(struct hns_roce_dev *hr_dev,
 			  struct hns_roce_mtr *mtr);
 int hns_roce_mtr_map(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
-		     dma_addr_t *pages, int page_cnt);
+		     dma_addr_t *pages, unsigned int page_cnt);
 
 int hns_roce_init_pd_table(struct hns_roce_dev *hr_dev);
 int hns_roce_init_mr_table(struct hns_roce_dev *hr_dev);
@@ -1263,10 +1264,10 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *ib_pd,
 int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		       int attr_mask, struct ib_udata *udata);
 void init_flush_work(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp);
-void *hns_roce_get_recv_wqe(struct hns_roce_qp *hr_qp, int n);
-void *hns_roce_get_send_wqe(struct hns_roce_qp *hr_qp, int n);
-void *hns_roce_get_extend_sge(struct hns_roce_qp *hr_qp, int n);
-bool hns_roce_wq_overflow(struct hns_roce_wq *hr_wq, int nreq,
+void *hns_roce_get_recv_wqe(struct hns_roce_qp *hr_qp, unsigned int n);
+void *hns_roce_get_send_wqe(struct hns_roce_qp *hr_qp, unsigned int n);
+void *hns_roce_get_extend_sge(struct hns_roce_qp *hr_qp, unsigned int n);
+bool hns_roce_wq_overflow(struct hns_roce_wq *hr_wq, u32 nreq,
 			  struct ib_cq *ib_cq);
 enum hns_roce_qp_state to_hns_roce_state(enum ib_qp_state state);
 void hns_roce_lock_cqs(struct hns_roce_cq *send_cq,
@@ -1296,7 +1297,7 @@ void hns_roce_cq_completion(struct hns_roce_dev *hr_dev, u32 cqn);
 void hns_roce_cq_event(struct hns_roce_dev *hr_dev, u32 cqn, int event_type);
 void hns_roce_qp_event(struct hns_roce_dev *hr_dev, u32 qpn, int event_type);
 void hns_roce_srq_event(struct hns_roce_dev *hr_dev, u32 srqn, int event_type);
-int hns_get_gid_index(struct hns_roce_dev *hr_dev, u8 port, int gid_index);
+u8 hns_get_gid_index(struct hns_roce_dev *hr_dev, u8 port, int gid_index);
 void hns_roce_handle_device_err(struct hns_roce_dev *hr_dev);
 int hns_roce_init(struct hns_roce_dev *hr_dev);
 void hns_roce_exit(struct hns_roce_dev *hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 0f4273d..b7dd867 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -288,7 +288,7 @@ static int hns_roce_v1_post_send(struct ib_qp *ibqp,
 					ret = -EINVAL;
 					*bad_wr = wr;
 					dev_err(dev, "inline len(1-%d)=%d, illegal",
-						ctrl->msg_length,
+						le32_to_cpu(ctrl->msg_length),
 						hr_dev->caps.max_sq_inline);
 					goto out;
 				}
@@ -1639,7 +1639,7 @@ static int hns_roce_v1_post_mbox(struct hns_roce_dev *hr_dev, u64 in_param,
 }
 
 static int hns_roce_v1_chk_mbox(struct hns_roce_dev *hr_dev,
-				unsigned long timeout)
+				unsigned int timeout)
 {
 	u8 __iomem *hcr = hr_dev->reg_base + ROCEE_MB1_REG;
 	unsigned long end;
@@ -3600,10 +3600,10 @@ static int hns_roce_v1_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	return 0;
 }
 
-static void set_eq_cons_index_v1(struct hns_roce_eq *eq, int req_not)
+static void set_eq_cons_index_v1(struct hns_roce_eq *eq, u32 req_not)
 {
 	roce_raw_write((eq->cons_index & HNS_ROCE_V1_CONS_IDX_M) |
-		      (req_not << eq->log_entries), eq->doorbell);
+		       (req_not << eq->log_entries), eq->db_reg);
 }
 
 static void hns_roce_v1_wq_catas_err_handle(struct hns_roce_dev *hr_dev,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 941a70b..6bd83f2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -656,7 +656,7 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 	unsigned int sge_idx;
 	unsigned int wqe_idx;
 	void *wqe = NULL;
-	int nreq;
+	u32 nreq;
 	int ret;
 
 	spin_lock_irqsave(&qp->sq.lock, flags);
@@ -834,7 +834,7 @@ static void *get_srq_wqe(struct hns_roce_srq *srq, int n)
 	return hns_roce_buf_offset(srq->buf_mtr.kmem, n << srq->wqe_shift);
 }
 
-static void *get_idx_buf(struct hns_roce_idx_que *idx_que, int n)
+static void *get_idx_buf(struct hns_roce_idx_que *idx_que, unsigned int n)
 {
 	return hns_roce_buf_offset(idx_que->mtr.kmem,
 				   n << idx_que->entry_shift);
@@ -875,12 +875,12 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 	struct hns_roce_v2_wqe_data_seg *dseg;
 	struct hns_roce_v2_db srq_db;
 	unsigned long flags;
+	unsigned int ind;
 	__le32 *srq_idx;
 	int ret = 0;
 	int wqe_idx;
 	void *wqe;
 	int nreq;
-	int ind;
 	int i;
 
 	spin_lock_irqsave(&srq->lock, flags);
@@ -1125,7 +1125,7 @@ static void hns_roce_cmq_init_regs(struct hns_roce_dev *hr_dev, bool ring_type)
 		roce_write(hr_dev, ROCEE_TX_CMQ_BASEADDR_H_REG,
 			   upper_32_bits(dma));
 		roce_write(hr_dev, ROCEE_TX_CMQ_DEPTH_REG,
-			   ring->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S);
+			   (u32)ring->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S);
 		roce_write(hr_dev, ROCEE_TX_CMQ_HEAD_REG, 0);
 		roce_write(hr_dev, ROCEE_TX_CMQ_TAIL_REG, 0);
 	} else {
@@ -1133,7 +1133,7 @@ static void hns_roce_cmq_init_regs(struct hns_roce_dev *hr_dev, bool ring_type)
 		roce_write(hr_dev, ROCEE_RX_CMQ_BASEADDR_H_REG,
 			   upper_32_bits(dma));
 		roce_write(hr_dev, ROCEE_RX_CMQ_DEPTH_REG,
-			   ring->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S);
+			   (u32)ring->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S);
 		roce_write(hr_dev, ROCEE_RX_CMQ_HEAD_REG, 0);
 		roce_write(hr_dev, ROCEE_RX_CMQ_TAIL_REG, 0);
 	}
@@ -1919,8 +1919,8 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	}
 }
 
-static void calc_pg_sz(int obj_num, int obj_size, int hop_num, int ctx_bt_num,
-		       int *buf_page_size, int *bt_page_size, u32 hem_type)
+static void calc_pg_sz(u32 obj_num, u32 obj_size, u32 hop_num, u32 ctx_bt_num,
+		       u32 *buf_page_size, u32 *bt_page_size, u32 hem_type)
 {
 	u64 obj_per_chunk;
 	u64 bt_chunk_size = PAGE_SIZE;
@@ -2399,10 +2399,10 @@ static int hns_roce_init_link_table(struct hns_roce_dev *hr_dev,
 	u32 buf_chk_sz;
 	dma_addr_t t;
 	int func_num = 1;
-	int pg_num_a;
-	int pg_num_b;
-	int pg_num;
-	int size;
+	u32 pg_num_a;
+	u32 pg_num_b;
+	u32 pg_num;
+	u32 size;
 	int i;
 
 	switch (type) {
@@ -2598,7 +2598,7 @@ static int hns_roce_query_mbox_status(struct hns_roce_dev *hr_dev)
 	struct hns_roce_cmq_desc desc;
 	struct hns_roce_mbox_status *mb_st =
 				       (struct hns_roce_mbox_status *)desc.data;
-	enum hns_roce_cmd_return_status status;
+	int status;
 
 	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_QUERY_MB_ST, true);
 
@@ -2669,7 +2669,7 @@ static int hns_roce_v2_post_mbox(struct hns_roce_dev *hr_dev, u64 in_param,
 }
 
 static int hns_roce_v2_chk_mbox(struct hns_roce_dev *hr_dev,
-				unsigned long timeout)
+				unsigned int timeout)
 {
 	struct device *dev = hr_dev->dev;
 	unsigned long end;
@@ -3067,7 +3067,7 @@ static void *get_cqe_v2(struct hns_roce_cq *hr_cq, int n)
 	return hns_roce_buf_offset(hr_cq->mtr.kmem, n * hr_cq->cqe_size);
 }
 
-static void *get_sw_cqe_v2(struct hns_roce_cq *hr_cq, int n)
+static void *get_sw_cqe_v2(struct hns_roce_cq *hr_cq, unsigned int n)
 {
 	struct hns_roce_v2_cqe *cqe = get_cqe_v2(hr_cq, n & hr_cq->ib_cq.cqe);
 
@@ -3414,7 +3414,7 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 	int is_send;
 	u16 wqe_ctr;
 	u32 opcode;
-	int qpn;
+	u32 qpn;
 	int ret;
 
 	/* Find cqe according to consumer index */
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 3f3de32..d9179ba 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -53,7 +53,7 @@
  *		GID[0][0], GID[1][0],.....GID[N - 1][0],
  *		And so on
  */
-int hns_get_gid_index(struct hns_roce_dev *hr_dev, u8 port, int gid_index)
+u8 hns_get_gid_index(struct hns_roce_dev *hr_dev, u8 port, int gid_index)
 {
 	return gid_index * hr_dev->caps.num_ports + port;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index b9a7e73..f807ece 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -510,7 +510,7 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 		ibdev_err(ibdev, "failed to map sg mtr, ret = %d.\n", ret);
 		ret = 0;
 	} else {
-		mr->pbl_mtr.hem_cfg.buf_pg_shift = ilog2(ibmr->page_size);
+		mr->pbl_mtr.hem_cfg.buf_pg_shift = (u32)ilog2(ibmr->page_size);
 		ret = mr->npages;
 	}
 
@@ -829,12 +829,12 @@ static int mtr_get_pages(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 }
 
 int hns_roce_mtr_map(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
-		     dma_addr_t *pages, int page_cnt)
+		     dma_addr_t *pages, unsigned int page_cnt)
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_buf_region *r;
+	unsigned int i;
 	int err;
-	int i;
 
 	/*
 	 * Only use the first page address as root ba when hopnum is 0, this
@@ -871,13 +871,12 @@ int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		      int offset, u64 *mtt_buf, int mtt_max, u64 *base_addr)
 {
 	struct hns_roce_hem_cfg *cfg = &mtr->hem_cfg;
+	int mtt_count, left;
 	int start_index;
-	int mtt_count;
 	int total = 0;
 	__le64 *mtts;
-	int npage;
+	u32 npage;
 	u64 addr;
-	int left;
 
 	if (!mtt_buf || mtt_max < 1)
 		goto done;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index f89c52b..9a0851f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1322,22 +1322,22 @@ static inline void *get_wqe(struct hns_roce_qp *hr_qp, int offset)
 	return hns_roce_buf_offset(hr_qp->mtr.kmem, offset);
 }
 
-void *hns_roce_get_recv_wqe(struct hns_roce_qp *hr_qp, int n)
+void *hns_roce_get_recv_wqe(struct hns_roce_qp *hr_qp, unsigned int n)
 {
 	return get_wqe(hr_qp, hr_qp->rq.offset + (n << hr_qp->rq.wqe_shift));
 }
 
-void *hns_roce_get_send_wqe(struct hns_roce_qp *hr_qp, int n)
+void *hns_roce_get_send_wqe(struct hns_roce_qp *hr_qp, unsigned int n)
 {
 	return get_wqe(hr_qp, hr_qp->sq.offset + (n << hr_qp->sq.wqe_shift));
 }
 
-void *hns_roce_get_extend_sge(struct hns_roce_qp *hr_qp, int n)
+void *hns_roce_get_extend_sge(struct hns_roce_qp *hr_qp, unsigned int n)
 {
 	return get_wqe(hr_qp, hr_qp->sge.offset + (n << hr_qp->sge.sge_shift));
 }
 
-bool hns_roce_wq_overflow(struct hns_roce_wq *hr_wq, int nreq,
+bool hns_roce_wq_overflow(struct hns_roce_wq *hr_wq, u32 nreq,
 			  struct ib_cq *ib_cq)
 {
 	struct hns_roce_cq *hr_cq;
-- 
2.8.1

