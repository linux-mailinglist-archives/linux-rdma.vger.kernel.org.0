Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75FE32CEDB
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Mar 2021 09:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbhCDIwq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Mar 2021 03:52:46 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13856 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236845AbhCDIwX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Mar 2021 03:52:23 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Drl1L3H2Jz7ssV;
        Thu,  4 Mar 2021 16:49:58 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Mar 2021 16:51:35 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: [PATCH RFC v2 rdma-core 4/6] libhns: Add support for attaching QP's WQE buffer
Date:   Thu, 4 Mar 2021 16:49:17 +0800
Message-ID: <1614847759-33139-5-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1614847759-33139-1-git-send-email-liweihang@huawei.com>
References: <1614847759-33139-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

If a uQP works in DCA mode, the WQE's buffer will be split as many blocks
and be stored into a list. The blocks are allocated from the DCA's memory
pool before posting WRs and are dropped when the QP's CI is equal to PI
after polling CQ.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 providers/hns/hns_roce_u.h       |  24 +++++-
 providers/hns/hns_roce_u_buf.c   | 156 ++++++++++++++++++++++++++++++++++++++-
 providers/hns/hns_roce_u_hw_v2.c | 131 +++++++++++++++++++++++++++++---
 providers/hns/hns_roce_u_hw_v2.h |   7 ++
 providers/hns/hns_roce_u_verbs.c |  32 ++++++--
 5 files changed, 332 insertions(+), 18 deletions(-)

diff --git a/providers/hns/hns_roce_u.h b/providers/hns/hns_roce_u.h
index 7dc4a1e..ae72709 100644
--- a/providers/hns/hns_roce_u.h
+++ b/providers/hns/hns_roce_u.h
@@ -119,6 +119,12 @@ struct hns_roce_device {
 	int				hw_version;
 };
 
+struct hns_roce_buf_list {
+	void **bufs;
+	unsigned int max_cnt;
+	unsigned int shift;
+};
+
 struct hns_roce_buf {
 	void				*buf;
 	unsigned int			length;
@@ -268,9 +274,20 @@ struct hns_roce_rinl_buf {
 	unsigned int			wqe_cnt;
 };
 
+struct hns_roce_dca_attach_attr {
+	uint32_t sq_offset;
+	uint32_t sge_offset;
+	uint32_t rq_offset;
+};
+
+struct hns_roce_dca_detach_attr {
+	uint32_t sq_index;
+};
+
 struct hns_roce_qp {
 	struct verbs_qp			verbs_qp;
 	struct hns_roce_buf		buf;
+	struct hns_roce_buf_list	page_list;
 	int				max_inline_data;
 	int				buf_size;
 	unsigned int			sq_signal_bits;
@@ -316,6 +333,7 @@ struct hns_roce_u_hw {
  * minimum page size.
  */
 #define hr_hw_page_align(x) align(x, HNS_HW_PAGE_SIZE)
+#define hr_hw_page_count(x) (hr_hw_page_align(x) / HNS_HW_PAGE_SIZE)
 
 static inline unsigned int to_hr_hem_entries_size(int count, int buf_shift)
 {
@@ -411,9 +429,13 @@ void hns_roce_free_buf(struct hns_roce_buf *buf);
 
 void hns_roce_free_qp_buf(struct hns_roce_qp *qp, struct hns_roce_context *ctx);
 
+int hns_roce_attach_dca_mem(struct hns_roce_context *ctx, uint32_t handle,
+			    struct hns_roce_dca_attach_attr *attr,
+			    uint32_t size, struct hns_roce_buf_list *buf_list);
+void hns_roce_detach_dca_mem(struct hns_roce_context *ctx, uint32_t handle,
+			     struct hns_roce_dca_detach_attr *attr);
 void hns_roce_shrink_dca_mem(struct hns_roce_context *ctx);
 void hns_roce_cleanup_dca_mem(struct hns_roce_context *ctx);
-int hns_roce_add_dca_mem(struct hns_roce_context *ctx, uint32_t size);
 
 void hns_roce_init_qp_indices(struct hns_roce_qp *qp);
 
diff --git a/providers/hns/hns_roce_u_buf.c b/providers/hns/hns_roce_u_buf.c
index 4970eac..d3e90d2 100644
--- a/providers/hns/hns_roce_u_buf.c
+++ b/providers/hns/hns_roce_u_buf.c
@@ -180,6 +180,66 @@ static int shrink_dca_mem(struct hns_roce_context *ctx, uint32_t handle,
 
 	return execute_ioctl(&ctx->ibv_ctx.context, cmd);
 }
+
+struct hns_dca_mem_query_resp {
+	uint64_t key;
+	uint32_t offset;
+	uint32_t page_count;
+};
+
+static int query_dca_mem(struct hns_roce_context *ctx, uint32_t handle,
+			 uint32_t index, struct hns_dca_mem_query_resp *resp)
+{
+	DECLARE_COMMAND_BUFFER(cmd, HNS_IB_OBJECT_DCA_MEM,
+			       HNS_IB_METHOD_DCA_MEM_QUERY, 5);
+	fill_attr_in_obj(cmd, HNS_IB_ATTR_DCA_MEM_QUERY_HANDLE, handle);
+	fill_attr_in_uint32(cmd, HNS_IB_ATTR_DCA_MEM_QUERY_PAGE_INDEX, index);
+	fill_attr_out(cmd, HNS_IB_ATTR_DCA_MEM_QUERY_OUT_KEY,
+		      &resp->key, sizeof(resp->key));
+	fill_attr_out(cmd, HNS_IB_ATTR_DCA_MEM_QUERY_OUT_OFFSET,
+		      &resp->offset, sizeof(resp->offset));
+	fill_attr_out(cmd, HNS_IB_ATTR_DCA_MEM_QUERY_OUT_PAGE_COUNT,
+		      &resp->page_count, sizeof(resp->page_count));
+	return execute_ioctl(&ctx->ibv_ctx.context, cmd);
+}
+
+static int detach_dca_mem(struct hns_roce_context *ctx, uint32_t handle,
+			  struct hns_roce_dca_detach_attr *attr)
+{
+	DECLARE_COMMAND_BUFFER(cmd, HNS_IB_OBJECT_DCA_MEM,
+			       HNS_IB_METHOD_DCA_MEM_DETACH, 4);
+	fill_attr_in_obj(cmd, HNS_IB_ATTR_DCA_MEM_DETACH_HANDLE, handle);
+	fill_attr_in_uint32(cmd, HNS_IB_ATTR_DCA_MEM_DETACH_SQ_INDEX,
+			    attr->sq_index);
+	return execute_ioctl(&ctx->ibv_ctx.context, cmd);
+}
+
+struct hns_dca_mem_attach_resp {
+#define HNS_DCA_ATTACH_OUT_FLAGS_NEW_BUFFER BIT(0)
+	uint32_t alloc_flags;
+	uint32_t alloc_pages;
+};
+
+static int attach_dca_mem(struct hns_roce_context *ctx, uint32_t handle,
+			  struct hns_roce_dca_attach_attr *attr,
+			  struct hns_dca_mem_attach_resp *resp)
+{
+	DECLARE_COMMAND_BUFFER(cmd, HNS_IB_OBJECT_DCA_MEM,
+			       HNS_IB_METHOD_DCA_MEM_ATTACH, 6);
+	fill_attr_in_obj(cmd, HNS_IB_ATTR_DCA_MEM_ATTACH_HANDLE, handle);
+	fill_attr_in_uint32(cmd, HNS_IB_ATTR_DCA_MEM_ATTACH_SQ_OFFSET,
+			    attr->sq_offset);
+	fill_attr_in_uint32(cmd, HNS_IB_ATTR_DCA_MEM_ATTACH_SGE_OFFSET,
+			    attr->sge_offset);
+	fill_attr_in_uint32(cmd, HNS_IB_ATTR_DCA_MEM_ATTACH_RQ_OFFSET,
+			    attr->rq_offset);
+	fill_attr_out(cmd, HNS_IB_ATTR_DCA_MEM_ATTACH_OUT_ALLOC_FLAGS,
+		      &resp->alloc_flags, sizeof(resp->alloc_flags));
+	fill_attr_out(cmd, HNS_IB_ATTR_DCA_MEM_ATTACH_OUT_ALLOC_PAGES,
+		      &resp->alloc_pages, sizeof(resp->alloc_pages));
+	return execute_ioctl(&ctx->ibv_ctx.context, cmd);
+}
+
 static bool add_dca_mem_enabled(struct hns_roce_dca_ctx *ctx,
 				uint32_t alloc_size)
 {
@@ -199,7 +259,7 @@ static bool add_dca_mem_enabled(struct hns_roce_dca_ctx *ctx,
 	return enable;
 }
 
-int hns_roce_add_dca_mem(struct hns_roce_context *ctx, uint32_t size)
+static int add_dca_mem(struct hns_roce_context *ctx, uint32_t size)
 {
 	struct hns_roce_dca_ctx *dca_ctx = &ctx->dca_ctx;
 	struct hns_roce_dca_mem *mem;
@@ -293,3 +353,97 @@ void hns_roce_shrink_dca_mem(struct hns_roce_context *ctx)
 		dca_mem_cnt--;
 	}
 }
+
+static void config_page_list(void *addr, struct hns_roce_buf_list *page_list,
+			     uint32_t page_index, int page_count)
+{
+	void **bufs = &page_list->bufs[page_index];
+	int page_size = 1 << page_list->shift;
+	int i;
+
+	for (i = 0; i < page_count; i++) {
+		bufs[i] = addr;
+		addr += page_size;
+	}
+}
+
+static int setup_dca_buf_list(struct hns_roce_context *ctx, uint32_t handle,
+			      struct hns_roce_buf_list *buf_list,
+			      uint32_t page_count)
+{
+	struct hns_roce_dca_ctx *dca_ctx = &ctx->dca_ctx;
+	struct hns_dca_mem_query_resp resp = {};
+	struct hns_roce_dca_mem *mem;
+	uint32_t idx = 0;
+	int ret;
+
+	while (idx < page_count && idx < buf_list->max_cnt) {
+		resp.page_count = 0;
+		ret = query_dca_mem(ctx, handle, idx, &resp);
+		if (ret)
+			return -ENOMEM;
+
+		if (resp.page_count < 1)
+			break;
+
+		pthread_spin_lock(&dca_ctx->lock);
+		mem = key_to_dca_mem(dca_ctx, resp.key);
+		if (mem && resp.offset < mem->buf.length) {
+			config_page_list(dca_mem_addr(mem, resp.offset),
+					 buf_list, idx, resp.page_count);
+		} else {
+			pthread_spin_unlock(&dca_ctx->lock);
+			break;
+		}
+
+		pthread_spin_unlock(&dca_ctx->lock);
+
+		idx += resp.page_count;
+	}
+
+	return (idx >= page_count) ? 0 : ENOMEM;
+}
+
+#define DCA_EXPAND_MEM_TRY_TIMES 3
+int hns_roce_attach_dca_mem(struct hns_roce_context *ctx, uint32_t handle,
+			    struct hns_roce_dca_attach_attr *attr,
+			    uint32_t size, struct hns_roce_buf_list *buf_list)
+{
+	uint32_t buf_pages = size >> buf_list->shift;
+	struct hns_dca_mem_attach_resp resp = {};
+	bool is_new_buf = true;
+	int try_times = 0;
+	int ret;
+
+	do {
+		resp.alloc_pages = 0;
+		ret = attach_dca_mem(ctx, handle, attr, &resp);
+		if (ret)
+			break;
+
+		if (resp.alloc_pages >= buf_pages) {
+			is_new_buf = !!(resp.alloc_flags &
+				     HNS_DCA_ATTACH_OUT_FLAGS_NEW_BUFFER);
+			break;
+		}
+
+		ret = add_dca_mem(ctx, size);
+		if (ret)
+			break;
+	} while (try_times++ < DCA_EXPAND_MEM_TRY_TIMES);
+
+	if (ret || resp.alloc_pages < buf_pages)
+		return -ENOMEM;
+
+	/* DCA config not changed */
+	if (!is_new_buf && buf_list->bufs[0])
+		return 0;
+
+	return setup_dca_buf_list(ctx, handle, buf_list, buf_pages);
+}
+
+void hns_roce_detach_dca_mem(struct hns_roce_context *ctx, uint32_t handle,
+			     struct hns_roce_dca_detach_attr *attr)
+{
+	detach_dca_mem(ctx, handle, attr);
+}
diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
index 93f3546..fb065d1 100644
--- a/providers/hns/hns_roce_u_hw_v2.c
+++ b/providers/hns/hns_roce_u_hw_v2.c
@@ -230,19 +230,28 @@ static struct hns_roce_v2_cqe *next_cqe_sw_v2(struct hns_roce_cq *cq)
 	return get_sw_cqe_v2(cq, cq->cons_index);
 }
 
+static inline void *get_wqe(struct hns_roce_qp *qp, unsigned int offset)
+{
+	if (qp->page_list.bufs)
+		return qp->page_list.bufs[offset >> qp->page_list.shift] +
+			(offset & ((1 << qp->page_list.shift) - 1));
+	else
+		return qp->buf.buf + offset;
+}
+
 static void *get_recv_wqe_v2(struct hns_roce_qp *qp, unsigned int n)
 {
-	return qp->buf.buf + qp->rq.offset + (n << qp->rq.wqe_shift);
+	return get_wqe(qp, qp->rq.offset + (n << qp->rq.wqe_shift));
 }
 
 static void *get_send_wqe(struct hns_roce_qp *qp, unsigned int n)
 {
-	return qp->buf.buf + qp->sq.offset + (n << qp->sq.wqe_shift);
+	return get_wqe(qp, qp->sq.offset + (n << qp->sq.wqe_shift));
 }
 
 static void *get_send_sge_ex(struct hns_roce_qp *qp, unsigned int n)
 {
-	return qp->buf.buf + qp->ex_sge.offset + (n << qp->ex_sge.sge_shift);
+	return get_wqe(qp, qp->ex_sge.offset + (n << qp->ex_sge.sge_shift));
 }
 
 static void *get_srq_wqe(struct hns_roce_srq *srq, int n)
@@ -507,6 +516,62 @@ static int hns_roce_handle_recv_inl_wqe(struct hns_roce_v2_cqe *cqe,
 	return V2_CQ_OK;
 }
 
+static inline bool check_qp_dca_enable(struct hns_roce_qp *qp)
+{
+	return !!qp->page_list.bufs && (qp->flags & HNS_ROCE_QP_CAP_DCA);
+}
+
+static int dca_attach_qp_buf(struct hns_roce_context *ctx,
+			     struct hns_roce_qp *qp)
+{
+	struct hns_roce_dca_attach_attr attr = {};
+	uint32_t idx;
+
+	pthread_spin_lock(&qp->sq.lock);
+	pthread_spin_lock(&qp->rq.lock);
+
+	if (qp->sq.wqe_cnt > 0) {
+		idx = qp->sq.head & (qp->sq.wqe_cnt - 1);
+		attr.sq_offset = idx << qp->sq.wqe_shift;
+	}
+
+	if (qp->ex_sge.sge_cnt > 0) {
+		idx = qp->next_sge & (qp->ex_sge.sge_cnt - 1);
+		attr.sge_offset = idx << qp->ex_sge.sge_shift;
+	}
+
+	if (qp->rq.wqe_cnt > 0) {
+		idx = qp->rq.head & (qp->rq.wqe_cnt - 1);
+		attr.rq_offset = idx << qp->rq.wqe_shift;
+	}
+
+	pthread_spin_unlock(&qp->rq.lock);
+	pthread_spin_unlock(&qp->sq.lock);
+
+	return hns_roce_attach_dca_mem(ctx, qp->verbs_qp.qp.handle, &attr,
+				       qp->buf_size, &qp->page_list);
+}
+
+static void dca_detach_qp_buf(struct hns_roce_context *ctx,
+			      struct hns_roce_qp *qp)
+{
+	struct hns_roce_dca_detach_attr attr;
+	bool is_empty;
+
+	pthread_spin_lock(&qp->sq.lock);
+	pthread_spin_lock(&qp->rq.lock);
+
+	is_empty = qp->sq.head == qp->sq.tail && qp->rq.head == qp->rq.tail;
+	if (is_empty && qp->sq.wqe_cnt > 0)
+		attr.sq_index = qp->sq.head & (qp->sq.wqe_cnt - 1);
+
+	pthread_spin_unlock(&qp->rq.lock);
+	pthread_spin_unlock(&qp->sq.lock);
+
+	if (is_empty)
+		hns_roce_detach_dca_mem(ctx, qp->verbs_qp.qp.handle, &attr);
+}
+
 static int hns_roce_v2_poll_one(struct hns_roce_cq *cq,
 				struct hns_roce_qp **cur_qp, struct ibv_wc *wc)
 {
@@ -636,6 +701,9 @@ static int hns_roce_u_v2_poll_cq(struct ibv_cq *ibvcq, int ne,
 
 	for (npolled = 0; npolled < ne; ++npolled) {
 		err = hns_roce_v2_poll_one(cq, &qp, wc + npolled);
+		if (qp && check_qp_dca_enable(qp))
+			dca_detach_qp_buf(ctx, qp);
+
 		if (err != V2_CQ_OK)
 			break;
 	}
@@ -1003,6 +1071,16 @@ static int set_rc_inl(struct hns_roce_qp *qp, const struct ibv_send_wr *wr,
 	return 0;
 }
 
+static inline void fill_rc_dca_fields(uint32_t qp_num,
+				      struct hns_roce_rc_sq_wqe *wqe)
+{
+	roce_set_field(wqe->byte_4, RC_SQ_WQE_BYTE_4_SQPN_L_M,
+		       RC_SQ_WQE_BYTE_4_SQPN_L_S, qp_num);
+	roce_set_field(wqe->byte_4, RC_SQ_WQE_BYTE_4_SQPN_H_M,
+		       RC_SQ_WQE_BYTE_4_SQPN_H_S,
+		       qp_num >> RC_SQ_WQE_BYTE_4_SQPN_L_W);
+}
+
 static void set_bind_mw_seg(struct hns_roce_rc_sq_wqe *wqe,
 			    const struct ibv_send_wr *wr)
 {
@@ -1120,6 +1198,9 @@ static int set_rc_wqe(void *wqe, struct hns_roce_qp *qp, struct ibv_send_wr *wr,
 		return ret;
 
 wqe_valid:
+	if (check_qp_dca_enable(qp))
+		fill_rc_dca_fields(qp->verbs_qp.qp.qp_num, rc_sq_wqe);
+
 	/*
 	 * The pipeline can sequentially post all valid WQEs into WQ buffer,
 	 * including new WQEs waiting for the doorbell to update the PI again.
@@ -1135,6 +1216,21 @@ wqe_valid:
 	return 0;
 }
 
+static int check_qp_send(struct hns_roce_qp *qp, struct hns_roce_context *ctx)
+{
+	struct ibv_qp *ibvqp = &qp->verbs_qp.qp;
+
+	/* check that state is OK to post receive */
+	if (ibvqp->state == IBV_QPS_RESET || ibvqp->state == IBV_QPS_INIT ||
+	    ibvqp->state == IBV_QPS_RTR)
+		return -EINVAL;
+
+	if (check_qp_dca_enable(qp))
+		return dca_attach_qp_buf(ctx, qp);
+
+	return 0;
+}
+
 int hns_roce_u_v2_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 			    struct ibv_send_wr **bad_wr)
 {
@@ -1143,14 +1239,14 @@ int hns_roce_u_v2_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 	struct hns_roce_sge_info sge_info = {};
 	unsigned int wqe_idx, nreq;
 	struct ibv_qp_attr attr;
-	int ret = 0;
 	void *wqe;
+	int ret;
 
 	/* check that state is OK to post send */
-	if (ibvqp->state == IBV_QPS_RESET || ibvqp->state == IBV_QPS_INIT ||
-	    ibvqp->state == IBV_QPS_RTR) {
+	ret = check_qp_send(qp, ctx);
+	if (unlikely(ret)) {
 		*bad_wr = wr;
-		return EINVAL;
+		return ret;
 	}
 
 	pthread_spin_lock(&qp->sq.lock);
@@ -1216,6 +1312,20 @@ out:
 	return ret;
 }
 
+static int check_qp_recv(struct hns_roce_qp *qp, struct hns_roce_context *ctx)
+{
+	struct ibv_qp *ibvqp = &qp->verbs_qp.qp;
+
+	/* check that state is OK to post receive */
+	if (ibvqp->state == IBV_QPS_RESET)
+		return -EINVAL;
+
+	if (check_qp_dca_enable(qp))
+		return dca_attach_qp_buf(ctx, qp);
+
+	return 0;
+}
+
 static void fill_rq_wqe(struct hns_roce_qp *qp, struct ibv_recv_wr *wr,
 			unsigned int wqe_idx)
 {
@@ -1253,12 +1363,13 @@ static int hns_roce_u_v2_post_recv(struct ibv_qp *ibvqp, struct ibv_recv_wr *wr,
 	struct hns_roce_qp *qp = to_hr_qp(ibvqp);
 	unsigned int wqe_idx, nreq;
 	struct ibv_qp_attr attr;
-	int ret = 0;
+	int ret;
 
 	/* check that state is OK to post receive */
-	if (ibvqp->state == IBV_QPS_RESET) {
+	ret = check_qp_recv(qp, ctx);
+	if (ret) {
 		*bad_wr = wr;
-		return EINVAL;
+		return ret;
 	}
 
 	pthread_spin_lock(&qp->rq.lock);
diff --git a/providers/hns/hns_roce_u_hw_v2.h b/providers/hns/hns_roce_u_hw_v2.h
index f5e6402..00716c6 100644
--- a/providers/hns/hns_roce_u_hw_v2.h
+++ b/providers/hns/hns_roce_u_hw_v2.h
@@ -250,6 +250,13 @@ struct hns_roce_rc_sq_wqe {
 
 #define RC_SQ_WQE_BYTE_4_RDMA_WRITE_S 22
 
+#define RC_SQ_WQE_BYTE_4_SQPN_L_W 2
+#define RC_SQ_WQE_BYTE_4_SQPN_L_S 5
+#define RC_SQ_WQE_BYTE_4_SQPN_L_M GENMASK(5, 2)
+
+#define RC_SQ_WQE_BYTE_4_SQPN_H_S 13
+#define RC_SQ_WQE_BYTE_4_SQPN_H_M GENMASK(18, 13)
+
 #define RC_SQ_WQE_BYTE_16_XRC_SRQN_S 0
 #define RC_SQ_WQE_BYTE_16_XRC_SRQN_M \
 	(((1UL << 24) - 1) << RC_SQ_WQE_BYTE_16_XRC_SRQN_S)
diff --git a/providers/hns/hns_roce_u_verbs.c b/providers/hns/hns_roce_u_verbs.c
index f3d6fc1..6ec8b12 100644
--- a/providers/hns/hns_roce_u_verbs.c
+++ b/providers/hns/hns_roce_u_verbs.c
@@ -688,6 +688,14 @@ static int calc_qp_buff_size(struct hns_roce_device *hr_dev,
 	return 0;
 }
 
+static inline bool check_qp_support_dca(bool pool_en, enum ibv_qp_type qp_type)
+{
+	if (pool_en && (qp_type == IBV_QPT_RC || qp_type == IBV_QPT_XRC_SEND))
+		return true;
+
+	return false;
+}
+
 static void qp_free_wqe(struct hns_roce_qp *qp)
 {
 	qp_free_recv_inl_buf(qp);
@@ -699,8 +707,8 @@ static void qp_free_wqe(struct hns_roce_qp *qp)
 	hns_roce_free_buf(&qp->buf);
 }
 
-static int qp_alloc_wqe(struct ibv_qp_cap *cap, struct hns_roce_qp *qp,
-			struct hns_roce_context *ctx)
+static int qp_alloc_wqe(struct ibv_qp_init_attr_ex *attr,
+			struct hns_roce_qp *qp, struct hns_roce_context *ctx)
 {
 	struct hns_roce_device *hr_dev = to_hr_dev(ctx->ibv_ctx.context.device);
 
@@ -718,12 +726,24 @@ static int qp_alloc_wqe(struct ibv_qp_cap *cap, struct hns_roce_qp *qp,
 	}
 
 	if (qp->rq_rinl_buf.wqe_cnt) {
-		if (qp_alloc_recv_inl_buf(cap, qp))
+		if (qp_alloc_recv_inl_buf(&attr->cap, qp))
 			goto err_alloc;
 	}
 
-	if (hns_roce_alloc_buf(&qp->buf, qp->buf_size, HNS_HW_PAGE_SIZE))
-		goto err_alloc;
+	if (check_qp_support_dca(ctx->dca_ctx.max_size != 0, attr->qp_type)) {
+		/* when DCA is enabled, use a buffer list to store page addr */
+		qp->buf.buf = NULL;
+		qp->page_list.max_cnt = hr_hw_page_count(qp->buf_size);
+		qp->page_list.shift = HNS_HW_PAGE_SHIFT;
+		qp->page_list.bufs = calloc(qp->page_list.max_cnt,
+					    sizeof(void *));
+		if (!qp->page_list.bufs)
+			goto err_alloc;
+	} else {
+		if (hns_roce_alloc_buf(&qp->buf, qp->buf_size,
+				       HNS_HW_PAGE_SIZE))
+			goto err_alloc;
+	}
 
 	return 0;
 
@@ -928,7 +948,7 @@ static int hns_roce_alloc_qp_buf(struct ibv_qp_init_attr_ex *attr,
 	    pthread_spin_init(&qp->rq.lock, PTHREAD_PROCESS_PRIVATE))
 		return -ENOMEM;
 
-	ret = qp_alloc_wqe(&attr->cap, qp, ctx);
+	ret = qp_alloc_wqe(attr, qp, ctx);
 	if (ret)
 		return ret;
 
-- 
2.8.1

