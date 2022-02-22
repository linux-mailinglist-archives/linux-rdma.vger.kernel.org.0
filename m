Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7074BF649
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Feb 2022 11:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiBVKlK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Feb 2022 05:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiBVKlI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Feb 2022 05:41:08 -0500
Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615E415B3C3
        for <linux-rdma@vger.kernel.org>; Tue, 22 Feb 2022 02:40:40 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V5D2OxP_1645526435;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0V5D2OxP_1645526435)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Feb 2022 18:40:36 +0800
Date:   Tue, 22 Feb 2022 18:40:35 +0800
From:   "dust.li" <dust.li@linux.alibaba.com>
To:     Cheng Xu <chengyou.xc@alibaba-inc.com>, jgg@ziepe.ca,
        dledford@redhat.com
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, chengyou@linux.alibaba.com,
        tonylu@linux.alibaba.com
Subject: Re: [PATCH for-next v3 07/12] RDMA/erdma: Add verbs header file
Message-ID: <20220222104035.GE5443@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20220217030116.6324-1-chengyou.xc@alibaba-inc.com>
 <20220217030116.6324-8-chengyou.xc@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217030116.6324-8-chengyou.xc@alibaba-inc.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 17, 2022 at 11:01:11AM +0800, Cheng Xu wrote:
>From: Cheng Xu <chengyou@linux.alibaba.com>
>
>This header file defines the main structrues and functions used for RDMA
>Verbs, including qp, cq, mr ucontext, etc,.
>
>Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
>---
> drivers/infiniband/hw/erdma/erdma_verbs.h | 345 ++++++++++++++++++++++
> 1 file changed, 345 insertions(+)
> create mode 100644 drivers/infiniband/hw/erdma/erdma_verbs.h
>
>diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
>new file mode 100644
>index 000000000000..261f8c0bdff3
>--- /dev/null
>+++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
>@@ -0,0 +1,345 @@
>+/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
>+
>+/* Authors: Cheng Xu <chengyou@linux.alibaba.com> */
>+/*          Kai Shen <kaishen@linux.alibaba.com> */
>+/* Copyright (c) 2020-2022, Alibaba Group. */

Maybe it's better to use a single '/**/' for multilines in the comment.

>+
>+#ifndef __ERDMA_VERBS_H__
>+#define __ERDMA_VERBS_H__
>+
>+#include <linux/errno.h>
>+
>+#include <rdma/iw_cm.h>
>+#include <rdma/ib_verbs.h>
>+#include <rdma/ib_user_verbs.h>
>+
>+#include "erdma.h"
>+#include "erdma_cm.h"
>+#include "erdma_hw.h"
>+
>+/* RDMA Capbility. */
>+#define ERDMA_MAX_PD (128 * 1024)
>+#define ERDMA_MAX_SEND_WR 4096
>+#define ERDMA_MAX_ORD 128
>+#define ERDMA_MAX_IRD 128
>+#define ERDMA_MAX_SGE_RD 1
>+#define ERDMA_MAX_FMR 0
>+#define ERDMA_MAX_SRQ 0 /* not support srq now. */
>+#define ERDMA_MAX_SRQ_WR 0 /* not support srq now. */
>+#define ERDMA_MAX_SRQ_SGE 0 /* not support srq now. */
>+#define ERDMA_MAX_CONTEXT (128 * 1024)
>+#define ERDMA_MAX_SEND_SGE 6
>+#define ERDMA_MAX_RECV_SGE 1
>+#define ERDMA_MAX_INLINE (sizeof(struct erdma_sge) * (ERDMA_MAX_SEND_SGE))
>+#define ERDMA_MAX_FRMR_PA 512
>+
>+enum {
>+	ERDMA_MMAP_IO_NC = 0, /* no cache */
>+};
>+
>+struct erdma_user_mmap_entry {
>+	struct rdma_user_mmap_entry rdma_entry;
>+	u64 address;
>+	u8 mmap_flag;
>+};
>+
>+struct erdma_ucontext {
>+	struct ib_ucontext ibucontext;
>+	struct erdma_dev *dev;
>+
>+	u32 sdb_type;
>+	u32 sdb_idx;
>+	u32 sdb_page_idx;
>+	u32 sdb_page_off;
>+	u64 sdb;
>+	u64 rdb;
>+	u64 cdb;
>+
>+	struct rdma_user_mmap_entry *sq_db_mmap_entry;
>+	struct rdma_user_mmap_entry *rq_db_mmap_entry;
>+	struct rdma_user_mmap_entry *cq_db_mmap_entry;
>+
>+	/* doorbell records */
>+	struct list_head dbrecords_page_list;
>+	struct mutex dbrecords_page_mutex;
>+};
>+
>+struct erdma_pd {
>+	struct ib_pd ibpd;
>+	u32 pdn;
>+};
>+
>+/*
>+ * MemoryRegion definition.
>+ */
>+#define ERDMA_MAX_INLINE_MTT_ENTRIES 4
>+#define MTT_SIZE(x) (x << 3) /* per mtt takes 8 Bytes. */
>+#define ERDMA_MR_MAX_MTT_CNT 524288
>+#define ERDMA_MTT_ENTRY_SIZE 8
>+
>+#define ERDMA_MR_TYPE_NORMAL 0
>+#define ERDMA_MR_TYPE_FRMR 1
>+#define ERDMA_MR_TYPE_DMA 2
>+
>+#define ERDMA_MR_INLINE_MTT 0
>+#define ERDMA_MR_INDIRECT_MTT 1
>+
>+#define ERDMA_MR_ACC_LR BIT(0)
>+#define ERDMA_MR_ACC_LW BIT(1)
>+#define ERDMA_MR_ACC_RR BIT(2)
>+#define ERDMA_MR_ACC_RW BIT(3)
>+
>+struct erdma_mem {
>+	struct ib_umem *umem;
>+	void *mtt_buf;
>+	u32 mtt_type;
>+	u32 page_size;
>+	u32 page_offset;
>+	u32 page_cnt;
>+	u32 mtt_nents;
>+
>+	u64 va;
>+	u64 len;
>+
>+	u64 mtt_entry[ERDMA_MAX_INLINE_MTT_ENTRIES];
>+};
>+
>+struct erdma_mr {
>+	struct ib_mr ibmr;
>+	struct erdma_mem mem;
>+	u8 type;
>+	u8 access;
>+	u8 valid;
>+};
>+
>+struct erdma_user_dbrecords_page {
>+	struct list_head list;
>+	struct ib_umem *umem;
>+	u64 va;
>+	int refcnt;
>+};
>+
>+struct erdma_uqp {
>+	struct erdma_mem sq_mtt;
>+	struct erdma_mem rq_mtt;
>+
>+	dma_addr_t sq_db_info_dma_addr;
>+	dma_addr_t rq_db_info_dma_addr;
>+
>+	struct erdma_user_dbrecords_page *user_dbr_page;
>+
>+	u32 rq_offset;
>+};
>+struct erdma_kqp {
>+	u16 sq_pi;
>+	u16 sq_ci;
>+
>+	u16 rq_pi;
>+	u16 rq_ci;
>+
>+	u64 *swr_tbl;
>+	u64 *rwr_tbl;
>+
>+	void *hw_sq_db;
>+	void *hw_rq_db;
>+
>+	void *sq_buf;
>+	dma_addr_t sq_buf_dma_addr;
>+
>+	void *rq_buf;
>+	dma_addr_t rq_buf_dma_addr;
>+
>+	void *sq_db_info;
>+	void *rq_db_info;
>+
>+	u8 sig_all;
>+};
>+
>+enum erdma_qp_state {
>+	ERDMA_QP_STATE_IDLE = 0,
>+	ERDMA_QP_STATE_RTR = 1,
>+	ERDMA_QP_STATE_RTS = 2,
>+	ERDMA_QP_STATE_CLOSING = 3,
>+	ERDMA_QP_STATE_TERMINATE = 4,
>+	ERDMA_QP_STATE_ERROR = 5,

Do we reserve 6 here on purpose ?

>+	ERDMA_QP_STATE_UNDEF = 7,
>+	ERDMA_QP_STATE_COUNT = 8
>+};
>+
>+enum erdma_qp_attr_mask {
>+	ERDMA_QP_ATTR_STATE = (1 << 0),
>+	ERDMA_QP_ATTR_LLP_HANDLE = (1 << 2),
>+	ERDMA_QP_ATTR_ORD = (1 << 3),
>+	ERDMA_QP_ATTR_IRD = (1 << 4),
>+	ERDMA_QP_ATTR_SQ_SIZE = (1 << 5),
>+	ERDMA_QP_ATTR_RQ_SIZE = (1 << 6),
>+	ERDMA_QP_ATTR_MPA = (1 << 7)
>+};
>+
>+struct erdma_qp_attrs {
>+	enum erdma_qp_state state;
>+	u32 sq_size;
>+	u32 rq_size;
>+	u32 orq_size;
>+	u32 irq_size;
>+	u32 max_send_sge;
>+	u32 max_recv_sge;
>+};
>+
>+struct erdma_qp {
>+	struct ib_qp ibqp;
>+	struct kref ref;
>+	struct completion safe_free;
>+	struct erdma_dev *dev;
>+	struct erdma_cep *cep;
>+	struct rw_semaphore state_lock;
>+
>+	union {
>+		struct erdma_kqp kern_qp;
>+		struct erdma_uqp user_qp;
>+	};
>+
>+	struct erdma_cq *scq;
>+	struct erdma_cq *rcq;
>+
>+	struct erdma_qp_attrs attrs;
>+	spinlock_t lock;
>+
>+	enum erdma_cc_method cc_method;
>+#define ERDMA_QP_ACTIVE 0
>+#define ERDMA_QP_PASSIVE 1
>+	u8 qp_type;
>+	u8 private_data_len;
>+};
>+
>+struct erdma_kcq_info {
>+	struct erdma_cqe *qbuf;
>+	dma_addr_t qbuf_dma_addr;
>+	u32 ci;
>+	u32 owner;
>+	u32 cmdsn;
>+
>+	spinlock_t lock;
>+	u8 __iomem *db;
>+	u64 *db_record;
>+};
>+
>+struct erdma_ucq_info {
>+	struct erdma_mem qbuf_mtt;
>+	struct erdma_user_dbrecords_page *user_dbr_page;
>+	dma_addr_t db_info_dma_addr;
>+};
>+
>+struct erdma_cq {
>+	struct ib_cq ibcq;
>+	u32 cqn;
>+
>+	u32 depth;
>+	u32 assoc_eqn;
>+
>+	union {
>+		struct erdma_kcq_info kern_cq;
>+		struct erdma_ucq_info user_cq;
>+	};
>+};
>+
>+#define QP_ID(qp) ((qp)->ibqp.qp_num)
>+
>+static inline struct erdma_qp *find_qp_by_qpn(struct erdma_dev *dev, int id)
>+{
>+	return (struct erdma_qp *)xa_load(&dev->qp_xa, id);
>+}
>+
>+static inline struct erdma_cq *find_cq_by_cqn(struct erdma_dev *dev, int id)
>+{
>+	return (struct erdma_cq *)xa_load(&dev->cq_xa, id);
>+}
>+
>+void erdma_qp_get(struct erdma_qp *qp);
>+void erdma_qp_put(struct erdma_qp *qp);
>+int erdma_modify_qp_internal(struct erdma_qp *qp, struct erdma_qp_attrs *attrs,
>+			     enum erdma_qp_attr_mask mask);
>+void erdma_qp_llp_close(struct erdma_qp *qp);
>+void erdma_qp_cm_drop(struct erdma_qp *qp);
>+
>+static inline struct erdma_ucontext *to_ectx(struct ib_ucontext *ibctx)
>+{
>+	return container_of(ibctx, struct erdma_ucontext, ibucontext);
>+}
>+
>+static inline struct erdma_pd *to_epd(struct ib_pd *pd)
>+{
>+	return container_of(pd, struct erdma_pd, ibpd);
>+}
>+
>+static inline struct erdma_mr *to_emr(struct ib_mr *ibmr)
>+{
>+	return container_of(ibmr, struct erdma_mr, ibmr);
>+}
>+
>+static inline struct erdma_qp *to_eqp(struct ib_qp *qp)
>+{
>+	return container_of(qp, struct erdma_qp, ibqp);
>+}
>+
>+static inline struct erdma_cq *to_ecq(struct ib_cq *ibcq)
>+{
>+	return container_of(ibcq, struct erdma_cq, ibcq);
>+}
>+
>+static inline struct erdma_user_mmap_entry *
>+to_emmap(struct rdma_user_mmap_entry *ibmmap)
>+{
>+	return container_of(ibmmap, struct erdma_user_mmap_entry, rdma_entry);
>+}
>+
>+static inline void *get_sq_entry(struct erdma_qp *qp, u16 idx)
>+{
>+	idx &= (qp->attrs.sq_size - 1);
>+	return qp->kern_qp.sq_buf + (idx << SQEBB_SHIFT);
>+}
>+
>+int erdma_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *data);
>+void erdma_dealloc_ucontext(struct ib_ucontext *ctx);
>+int erdma_query_device(struct ib_device *dev, struct ib_device_attr *attr,
>+		       struct ib_udata *data);
>+int erdma_get_port_immutable(struct ib_device *dev, u32 port,
>+			     struct ib_port_immutable *ib_port_immutable);
>+int erdma_create_cq(struct ib_cq *cq, const struct ib_cq_init_attr *attr,
>+		    struct ib_udata *data);
>+int erdma_query_port(struct ib_device *dev, u32 port,
>+		     struct ib_port_attr *attr);
>+int erdma_query_gid(struct ib_device *dev, u32 port, int idx,
>+		    union ib_gid *gid);
>+int erdma_alloc_pd(struct ib_pd *pd, struct ib_udata *data);
>+int erdma_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
>+int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
>+		    struct ib_udata *data);
>+int erdma_query_qp(struct ib_qp *qp, struct ib_qp_attr *attr, int mask,
>+		   struct ib_qp_init_attr *init_attr);
>+int erdma_modify_qp(struct ib_qp *qp, struct ib_qp_attr *attr, int mask,
>+		    struct ib_udata *data);
>+int erdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata);
>+int erdma_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
>+int erdma_req_notify_cq(struct ib_cq *cq, enum ib_cq_notify_flags flags);
>+struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
>+				u64 virt, int access, struct ib_udata *udata);
>+struct ib_mr *erdma_get_dma_mr(struct ib_pd *ibpd, int rights);
>+int erdma_dereg_mr(struct ib_mr *mr, struct ib_udata *data);
>+int erdma_mmap(struct ib_ucontext *ctx, struct vm_area_struct *vma);
>+void erdma_qp_get_ref(struct ib_qp *qp);
>+void erdma_qp_put_ref(struct ib_qp *qp);
>+struct ib_qp *erdma_get_ibqp(struct ib_device *dev, int id);
>+int erdma_post_send(struct ib_qp *qp, const struct ib_send_wr *send_wr,
>+		    const struct ib_send_wr **bad_send_wr);
>+int erdma_post_recv(struct ib_qp *qp, const struct ib_recv_wr *recv_wr,
>+		    const struct ib_recv_wr **bad_recv_wr);
>+int erdma_poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc);
>+struct ib_mr *erdma_ib_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
>+				u32 max_num_sg);
>+int erdma_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
>+		    unsigned int *sg_offset);
>+struct net_device *erdma_get_netdev(struct ib_device *device, u32 port_num);
>+void erdma_port_event(struct erdma_dev *dev, enum ib_event_type reason);
>+
>+#endif
>-- 
>2.27.0
