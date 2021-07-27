Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3B63D6CBC
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 05:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbhG0Cux (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Jul 2021 22:50:53 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:12410 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbhG0Cuv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Jul 2021 22:50:51 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GYj0f6xM0zcjWG;
        Tue, 27 Jul 2021 11:27:46 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 11:31:07 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 11:31:07 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>, Xi Wang <wangxi11@huawei.com>
Subject: [PATCH v3 for-next 05/12] RDMA/hns: Add method for attaching WQE buffer
Date:   Tue, 27 Jul 2021 11:27:25 +0800
Message-ID: <1627356452-30564-6-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1627356452-30564-1-git-send-email-liangwenpeng@huawei.com>
References: <1627356452-30564-1-git-send-email-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

If a uQP works as DCA mode, the userspace driver needs to config the WQE
buffer by calling the 'HNS_IB_METHOD_DCA_MEM_ATTACH' method before filling
the WQE. This method will allocate a group of pages from DCA memory pool
and write the configuration of addressing to QPC.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_dca.c    | 494 +++++++++++++++++++++++++++-
 drivers/infiniband/hw/hns/hns_roce_dca.h    |  25 ++
 drivers/infiniband/hw/hns/hns_roce_device.h |  10 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  29 +-
 include/uapi/rdma/hns-abi.h                 |  11 +
 5 files changed, 557 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_dca.c b/drivers/infiniband/hw/hns/hns_roce_dca.c
index b14b23e..1dfd79e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_dca.c
+++ b/drivers/infiniband/hw/hns/hns_roce_dca.c
@@ -35,7 +35,40 @@ struct dca_mem_attr {
 	u32 size;
 };
 
+static inline void set_dca_page_to_free(struct hns_dca_page_state *state)
+{
+	state->buf_id = HNS_DCA_INVALID_BUF_ID;
+	state->active = 0;
+	state->lock = 0;
+}
+
+static inline void lock_dca_page_to_attach(struct hns_dca_page_state *state,
+					   u32 buf_id)
+{
+	state->buf_id = HNS_DCA_ID_MASK & buf_id;
+	state->active = 0;
+	state->lock = 1;
+}
+
+static inline void unlock_dca_page_to_active(struct hns_dca_page_state *state,
+					     u32 buf_id)
+{
+	state->buf_id = HNS_DCA_ID_MASK & buf_id;
+	state->active = 1;
+	state->lock = 0;
+}
+
 #define dca_page_is_free(s) ((s)->buf_id == HNS_DCA_INVALID_BUF_ID)
+
+/* only the own bit needs to be matched. */
+#define dca_page_is_attached(s, id) \
+	((HNS_DCA_OWN_MASK & (id)) == (HNS_DCA_OWN_MASK & (s)->buf_id))
+
+#define dca_page_is_allocated(s, id) \
+		(dca_page_is_attached(s, id) && (s)->lock)
+
+#define dca_page_is_inactive(s) (!(s)->lock && !(s)->active)
+
 #define dca_mem_is_available(m) \
 	((m)->flags == (DCA_MEM_FLAGS_ALLOCED | DCA_MEM_FLAGS_REGISTERED))
 
@@ -342,11 +375,408 @@ static void free_dca_mem(struct dca_mem *mem)
 	spin_unlock(&mem->lock);
 }
 
+static inline struct hns_roce_dca_ctx *hr_qp_to_dca_ctx(struct hns_roce_qp *qp)
+{
+	return to_hr_dca_ctx(to_hr_ucontext(qp->ibqp.pd->uobject->context));
+}
+
+struct dca_page_clear_attr {
+	u32 buf_id;
+	u32 max_pages;
+	u32 clear_pages;
+};
+
+static int clear_dca_pages_proc(struct dca_mem *mem, int index, void *param)
+{
+	struct hns_dca_page_state *state = &mem->states[index];
+	struct dca_page_clear_attr *attr = param;
+
+	if (dca_page_is_attached(state, attr->buf_id)) {
+		set_dca_page_to_free(state);
+		attr->clear_pages++;
+	}
+
+	if (attr->clear_pages >= attr->max_pages)
+		return DCA_MEM_STOP_ITERATE;
+	else
+		return 0;
+}
+
+static void clear_dca_pages(struct hns_roce_dca_ctx *ctx, u32 buf_id, u32 count)
+{
+	struct dca_page_clear_attr attr = {};
+
+	attr.buf_id = buf_id;
+	attr.max_pages = count;
+	travel_dca_pages(ctx, &attr, clear_dca_pages_proc);
+}
+
+struct dca_page_assign_attr {
+	u32 buf_id;
+	int unit;
+	int total;
+	int max;
+};
+
+static bool dca_page_is_allocable(struct hns_dca_page_state *state, bool head)
+{
+	bool is_free = dca_page_is_free(state) || dca_page_is_inactive(state);
+
+	return head ? is_free : is_free && !state->head;
+}
+
+static int assign_dca_pages_proc(struct dca_mem *mem, int index, void *param)
+{
+	struct dca_page_assign_attr *attr = param;
+	struct hns_dca_page_state *state;
+	int checked_pages = 0;
+	int start_index = 0;
+	int free_pages = 0;
+	int i;
+
+	/* Check the continuous pages count is not smaller than unit count */
+	for (i = index; free_pages < attr->unit && i < mem->page_count; i++) {
+		checked_pages++;
+		state = &mem->states[i];
+		if (dca_page_is_allocable(state, free_pages == 0)) {
+			if (free_pages == 0)
+				start_index = i;
+
+			free_pages++;
+		} else {
+			free_pages = 0;
+		}
+	}
+
+	if (free_pages < attr->unit)
+		return DCA_MEM_NEXT_ITERATE;
+
+	for (i = 0; i < free_pages; i++) {
+		state = &mem->states[start_index + i];
+		lock_dca_page_to_attach(state, attr->buf_id);
+		attr->total++;
+	}
+
+	if (attr->total >= attr->max)
+		return DCA_MEM_STOP_ITERATE;
+
+	return checked_pages;
+}
+
+static u32 assign_dca_pages(struct hns_roce_dca_ctx *ctx, u32 buf_id, u32 count,
+			    u32 unit)
+{
+	struct dca_page_assign_attr attr = {};
+
+	attr.buf_id = buf_id;
+	attr.unit = unit;
+	attr.max = count;
+	travel_dca_pages(ctx, &attr, assign_dca_pages_proc);
+	return attr.total;
+}
+
+struct dca_page_active_attr {
+	u32 buf_id;
+	u32 max_pages;
+	u32 alloc_pages;
+	u32 dirty_mems;
+};
+
+static int active_dca_pages_proc(struct dca_mem *mem, int index, void *param)
+{
+	struct dca_page_active_attr *attr = param;
+	struct hns_dca_page_state *state;
+	bool changed = false;
+	bool stop = false;
+	int i, free_pages;
+
+	free_pages = 0;
+	for (i = 0; !stop && i < mem->page_count; i++) {
+		state = &mem->states[i];
+		if (dca_page_is_free(state)) {
+			free_pages++;
+		} else if (dca_page_is_allocated(state, attr->buf_id)) {
+			free_pages++;
+			/* Change matched pages state */
+			unlock_dca_page_to_active(state, attr->buf_id);
+			changed = true;
+			attr->alloc_pages++;
+			if (attr->alloc_pages == attr->max_pages)
+				stop = true;
+		}
+	}
+
+	for (; changed && i < mem->page_count; i++)
+		if (dca_page_is_free(state))
+			free_pages++;
+
+	/* Clean mem changed to dirty */
+	if (changed && free_pages == mem->page_count)
+		attr->dirty_mems++;
+
+	return stop ? DCA_MEM_STOP_ITERATE : DCA_MEM_NEXT_ITERATE;
+}
+
+static u32 active_dca_pages(struct hns_roce_dca_ctx *ctx, u32 buf_id, u32 count)
+{
+	struct dca_page_active_attr attr = {};
+	unsigned long flags;
+
+	attr.buf_id = buf_id;
+	attr.max_pages = count;
+	travel_dca_pages(ctx, &attr, active_dca_pages_proc);
+
+	/* Update free size */
+	spin_lock_irqsave(&ctx->pool_lock, flags);
+	ctx->free_mems -= attr.dirty_mems;
+	ctx->free_size -= attr.alloc_pages << HNS_HW_PAGE_SHIFT;
+	spin_unlock_irqrestore(&ctx->pool_lock, flags);
+
+	return attr.alloc_pages;
+}
+
+struct dca_get_alloced_pages_attr {
+	u32 buf_id;
+	dma_addr_t *pages;
+	u32 total;
+	u32 max;
+};
+
+static int get_alloced_umem_proc(struct dca_mem *mem, int index, void *param)
+
+{
+	struct dca_get_alloced_pages_attr *attr = param;
+	struct hns_dca_page_state *states = mem->states;
+	struct ib_umem *umem = mem->pages;
+	struct ib_block_iter biter;
+	u32 i = 0;
+
+	rdma_for_each_block(umem->sg_head.sgl, &biter, umem->nmap,
+			    HNS_HW_PAGE_SIZE) {
+		if (dca_page_is_allocated(&states[i], attr->buf_id)) {
+			attr->pages[attr->total++] =
+					rdma_block_iter_dma_address(&biter);
+			if (attr->total >= attr->max)
+				return DCA_MEM_STOP_ITERATE;
+		}
+		i++;
+	}
+
+	return DCA_MEM_NEXT_ITERATE;
+}
+
+static int config_dca_qpc(struct hns_roce_dev *hr_dev,
+			  struct hns_roce_qp *hr_qp, dma_addr_t *pages,
+			  int page_count)
+{
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct hns_roce_mtr *mtr = &hr_qp->mtr;
+	int ret;
+
+	ret = hns_roce_mtr_map(hr_dev, mtr, pages, page_count);
+	if (ret) {
+		ibdev_err(ibdev, "failed to map DCA pages, ret = %d.\n", ret);
+		return ret;
+	}
+
+	if (hr_dev->hw->set_dca_buf) {
+		ret = hr_dev->hw->set_dca_buf(hr_dev, hr_qp);
+		if (ret) {
+			ibdev_err(ibdev, "failed to set DCA to HW, ret = %d.\n",
+				  ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int setup_dca_buf_to_hw(struct hns_roce_dev *hr_dev,
+			       struct hns_roce_qp *hr_qp,
+			       struct hns_roce_dca_ctx *ctx, u32 buf_id,
+			       u32 count)
+{
+	struct dca_get_alloced_pages_attr attr = {};
+	dma_addr_t *pages;
+	int ret;
+
+	/* alloc a tmp array to store buffer's dma address */
+	pages = kvcalloc(count, sizeof(dma_addr_t), GFP_ATOMIC);
+	if (!pages)
+		return -ENOMEM;
+
+	attr.buf_id = buf_id;
+	attr.pages = pages;
+	attr.max = count;
+
+	if (hr_qp->ibqp.uobject)
+		travel_dca_pages(ctx, &attr, get_alloced_umem_proc);
+
+	if (attr.total != count) {
+		ibdev_err(&hr_dev->ib_dev, "failed to get DCA page %u != %u.\n",
+			  attr.total, count);
+		ret = -ENOMEM;
+		goto err_get_pages;
+	}
+
+	ret = config_dca_qpc(hr_dev, hr_qp, pages, count);
+err_get_pages:
+	/* drop tmp array */
+	kvfree(pages);
+
+	return ret;
+}
+
+static int sync_dca_buf_offset(struct hns_roce_dev *hr_dev,
+			       struct hns_roce_qp *hr_qp,
+			       struct hns_dca_attach_attr *attr)
+{
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+
+	if (hr_qp->sq.wqe_cnt > 0) {
+		if (attr->sq_offset >= hr_qp->sge.offset) {
+			ibdev_err(ibdev, "failed to check SQ offset = %u\n",
+				  attr->sq_offset);
+			return -EINVAL;
+		}
+		hr_qp->sq.wqe_offset = hr_qp->sq.offset + attr->sq_offset;
+	}
+
+	if (hr_qp->sge.sge_cnt > 0) {
+		if (attr->sge_offset >= hr_qp->rq.offset) {
+			ibdev_err(ibdev, "failed to check exSGE offset = %u\n",
+				  attr->sge_offset);
+			return -EINVAL;
+		}
+		hr_qp->sge.wqe_offset = hr_qp->sge.offset + attr->sge_offset;
+	}
+
+	if (hr_qp->rq.wqe_cnt > 0) {
+		if (attr->rq_offset >= hr_qp->buff_size) {
+			ibdev_err(ibdev, "failed to check RQ offset = %u\n",
+				  attr->rq_offset);
+			return -EINVAL;
+		}
+		hr_qp->rq.wqe_offset = hr_qp->rq.offset + attr->rq_offset;
+	}
+
+	return 0;
+}
+
+static u32 alloc_buf_from_dca_mem(struct hns_roce_qp *hr_qp,
+				  struct hns_roce_dca_ctx *ctx)
+{
+	u32 buf_pages, unit_pages, alloc_pages;
+	u32 buf_id;
+
+	buf_pages = hr_qp->dca_cfg.npages;
+	/* Gen new buf id */
+	buf_id = HNS_DCA_TO_BUF_ID(hr_qp->qpn, hr_qp->dca_cfg.attach_count);
+
+	/* Assign pages from free pages */
+	unit_pages = hr_qp->mtr.hem_cfg.is_direct ? buf_pages : 1;
+	alloc_pages = assign_dca_pages(ctx, buf_id, buf_pages, unit_pages);
+	if (buf_pages != alloc_pages) {
+		if (alloc_pages > 0)
+			clear_dca_pages(ctx, buf_id, alloc_pages);
+		return HNS_DCA_INVALID_BUF_ID;
+	}
+
+	return buf_id;
+}
+
+static int active_alloced_buf(struct hns_roce_qp *hr_qp,
+			      struct hns_roce_dca_ctx *ctx,
+			      struct hns_dca_attach_attr *attr, u32 buf_id)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(hr_qp->ibqp.device);
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	u32 active_pages, alloc_pages;
+	int ret;
+
+	alloc_pages = hr_qp->dca_cfg.npages;
+	ret = sync_dca_buf_offset(hr_dev, hr_qp, attr);
+	if (ret) {
+		ibdev_err(ibdev, "failed to sync DCA offset, ret = %d\n", ret);
+		goto active_fail;
+	}
+
+	ret = setup_dca_buf_to_hw(hr_dev, hr_qp, ctx, buf_id, alloc_pages);
+	if (ret) {
+		ibdev_err(ibdev, "failed to setup DCA buf, ret = %d.\n", ret);
+		goto active_fail;
+	}
+
+	active_pages = active_dca_pages(ctx, buf_id, alloc_pages);
+	if (active_pages != alloc_pages) {
+		ibdev_err(ibdev, "failed to active DCA pages, %u != %u.\n",
+			  active_pages, alloc_pages);
+		ret = -ENOBUFS;
+		goto active_fail;
+	}
+
+	return 0;
+active_fail:
+	clear_dca_pages(ctx, buf_id, alloc_pages);
+	return ret;
+}
+
+static int attach_dca_mem(struct hns_roce_dev *hr_dev,
+			  struct hns_roce_qp *hr_qp,
+			  struct hns_dca_attach_attr *attr,
+			  struct hns_dca_attach_resp *resp)
+{
+	struct hns_roce_dca_ctx *ctx = hr_qp_to_dca_ctx(hr_qp);
+	struct hns_roce_dca_cfg *cfg = &hr_qp->dca_cfg;
+	u32 buf_id;
+	int ret;
+
+	resp->alloc_flags = 0;
+	spin_lock(&cfg->lock);
+	buf_id = cfg->buf_id;
+	/* Already attached */
+	if (buf_id != HNS_DCA_INVALID_BUF_ID) {
+		resp->alloc_pages = cfg->npages;
+		spin_unlock(&cfg->lock);
+		return 0;
+	}
+
+	/* Start to new attach */
+	resp->alloc_pages = 0;
+	buf_id = alloc_buf_from_dca_mem(hr_qp, ctx);
+	if (buf_id == HNS_DCA_INVALID_BUF_ID) {
+		spin_unlock(&cfg->lock);
+		/* No report fail, need try again after the pool increased */
+		return 0;
+	}
+
+	ret = active_alloced_buf(hr_qp, ctx, attr, buf_id);
+	if (ret) {
+		spin_unlock(&cfg->lock);
+		ibdev_err(&hr_dev->ib_dev,
+			  "failed to active DCA buf for QP-%lu, ret = %d.\n",
+			  hr_qp->qpn, ret);
+		return ret;
+	}
+
+	/* Attach ok */
+	cfg->buf_id = buf_id;
+	cfg->attach_count++;
+	spin_unlock(&cfg->lock);
+
+	resp->alloc_flags |= HNS_IB_ATTACH_FLAGS_NEW_BUFFER;
+	resp->alloc_pages = cfg->npages;
+
+	return 0;
+}
+
 void hns_roce_enable_dca(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 {
 	struct hns_roce_dca_cfg *cfg = &hr_qp->dca_cfg;
 
+	spin_lock_init(&cfg->lock);
 	cfg->buf_id = HNS_DCA_INVALID_BUF_ID;
+	cfg->npages = hr_qp->buff_size >> HNS_HW_PAGE_SHIFT;
 }
 
 void hns_roce_disable_dca(struct hns_roce_dev *hr_dev,
@@ -471,11 +901,73 @@ DECLARE_UVERBS_NAMED_METHOD(
 			    UVERBS_ATTR_TYPE(u64), UA_MANDATORY),
 	UVERBS_ATTR_PTR_OUT(HNS_IB_ATTR_DCA_MEM_SHRINK_OUT_FREE_MEMS,
 			    UVERBS_ATTR_TYPE(u32), UA_MANDATORY));
+
+static inline struct hns_roce_qp *
+uverbs_attr_to_hr_qp(struct uverbs_attr_bundle *attrs)
+{
+	struct ib_uobject *uobj =
+		uverbs_attr_get_uobject(attrs, 1U << UVERBS_ID_NS_SHIFT);
+
+	if (uobj_get_object_id(uobj) == UVERBS_OBJECT_QP)
+		return to_hr_qp(uobj->object);
+
+	return NULL;
+}
+
+static int UVERBS_HANDLER(HNS_IB_METHOD_DCA_MEM_ATTACH)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct hns_roce_qp *hr_qp = uverbs_attr_to_hr_qp(attrs);
+	struct hns_dca_attach_attr attr = {};
+	struct hns_dca_attach_resp resp = {};
+	int ret;
+
+	if (!hr_qp)
+		return -EINVAL;
+
+	if (uverbs_copy_from(&attr.sq_offset, attrs,
+			     HNS_IB_ATTR_DCA_MEM_ATTACH_SQ_OFFSET) ||
+	    uverbs_copy_from(&attr.sge_offset, attrs,
+			     HNS_IB_ATTR_DCA_MEM_ATTACH_SGE_OFFSET) ||
+	    uverbs_copy_from(&attr.rq_offset, attrs,
+			     HNS_IB_ATTR_DCA_MEM_ATTACH_RQ_OFFSET))
+		return -EFAULT;
+
+	ret = attach_dca_mem(to_hr_dev(hr_qp->ibqp.device), hr_qp, &attr,
+			     &resp);
+	if (ret)
+		return ret;
+
+	if (uverbs_copy_to(attrs, HNS_IB_ATTR_DCA_MEM_ATTACH_OUT_ALLOC_FLAGS,
+			   &resp.alloc_flags, sizeof(resp.alloc_flags)) ||
+	    uverbs_copy_to(attrs, HNS_IB_ATTR_DCA_MEM_ATTACH_OUT_ALLOC_PAGES,
+			   &resp.alloc_pages, sizeof(resp.alloc_pages)))
+		return -EFAULT;
+
+	return 0;
+}
+
+DECLARE_UVERBS_NAMED_METHOD(
+	HNS_IB_METHOD_DCA_MEM_ATTACH,
+	UVERBS_ATTR_IDR(HNS_IB_ATTR_DCA_MEM_ATTACH_HANDLE, UVERBS_OBJECT_QP,
+			UVERBS_ACCESS_WRITE, UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(HNS_IB_ATTR_DCA_MEM_ATTACH_SQ_OFFSET,
+			   UVERBS_ATTR_TYPE(u32), UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(HNS_IB_ATTR_DCA_MEM_ATTACH_SGE_OFFSET,
+			   UVERBS_ATTR_TYPE(u32), UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(HNS_IB_ATTR_DCA_MEM_ATTACH_RQ_OFFSET,
+			   UVERBS_ATTR_TYPE(u32), UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(HNS_IB_ATTR_DCA_MEM_ATTACH_OUT_ALLOC_FLAGS,
+			    UVERBS_ATTR_TYPE(u32), UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(HNS_IB_ATTR_DCA_MEM_ATTACH_OUT_ALLOC_PAGES,
+			    UVERBS_ATTR_TYPE(u32), UA_MANDATORY));
+
 DECLARE_UVERBS_NAMED_OBJECT(HNS_IB_OBJECT_DCA_MEM,
 			    UVERBS_TYPE_ALLOC_IDR(dca_cleanup),
 			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_REG),
 			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_DEREG),
-			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_SHRINK));
+			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_SHRINK),
+			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_ATTACH));
 
 static bool dca_is_supported(struct ib_device *device)
 {
diff --git a/drivers/infiniband/hw/hns/hns_roce_dca.h b/drivers/infiniband/hw/hns/hns_roce_dca.h
index a13a2d6..d66cb74 100644
--- a/drivers/infiniband/hw/hns/hns_roce_dca.h
+++ b/drivers/infiniband/hw/hns/hns_roce_dca.h
@@ -21,6 +21,31 @@ struct hns_dca_shrink_resp {
 };
 
 
+/*
+ * buffer id(29b) = tag(7b) + owner(22b)
+ * [28:22] tag  : indicate the QP config update times.
+ * [21: 0] owner: indicate the QP to which the page belongs.
+ */
+#define HNS_DCA_ID_MASK GENMASK(28, 0)
+#define HNS_DCA_TAG_MASK GENMASK(28, 22)
+#define HNS_DCA_OWN_MASK GENMASK(21, 0)
+
+#define HNS_DCA_BUF_ID_TO_TAG(buf_id) (((buf_id) & HNS_DCA_TAG_MASK) >> 22)
+#define HNS_DCA_BUF_ID_TO_QPN(buf_id) ((buf_id) & HNS_DCA_OWN_MASK)
+#define HNS_DCA_TO_BUF_ID(qpn, tag) (((qpn) & HNS_DCA_OWN_MASK) | \
+					(((tag) << 22) & HNS_DCA_TAG_MASK))
+
+struct hns_dca_attach_attr {
+	u32 sq_offset;
+	u32 sge_offset;
+	u32 rq_offset;
+};
+
+struct hns_dca_attach_resp {
+	u32 alloc_flags;
+	u32 alloc_pages;
+};
+
 void hns_roce_register_udca(struct hns_roce_dev *hr_dev,
 			    struct hns_roce_ucontext *uctx);
 void hns_roce_unregister_udca(struct hns_roce_dev *hr_dev,
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 00f80b3..50dc894 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -332,9 +332,13 @@ struct hns_roce_mtr {
 };
 
 struct hns_roce_dca_cfg {
+	spinlock_t lock;
 	u32 buf_id;
+	u16 attach_count;
+	u32 npages;
 };
 
+
 struct hns_roce_mw {
 	struct ib_mw		ibmw;
 	u32			pdn;
@@ -375,6 +379,7 @@ struct hns_roce_wq {
 	u32		max_gs;
 	u32		rsv_sge;
 	int		offset;
+	int		wqe_offset;
 	int		wqe_shift;	/* WQE size */
 	u32		head;
 	u32		tail;
@@ -385,6 +390,7 @@ struct hns_roce_sge {
 	unsigned int	sge_cnt;	/* SGE num */
 	int		offset;
 	int		sge_shift;	/* SGE size */
+	int		wqe_offset;
 };
 
 struct hns_roce_buf_list {
@@ -924,6 +930,10 @@ struct hns_roce_hw {
 	int (*clear_hem)(struct hns_roce_dev *hr_dev,
 			 struct hns_roce_hem_table *table, int obj,
 			 int step_idx);
+	int (*set_dca_buf)(struct hns_roce_dev *hr_dev,
+			   struct hns_roce_qp *hr_qp);
+	int (*query_qp)(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
+			int qp_attr_mask, struct ib_qp_init_attr *qp_init_attr);
 	int (*modify_qp)(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 			 int attr_mask, enum ib_qp_state cur_state,
 			 enum ib_qp_state new_state);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index ced0c44..b31b493 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4195,8 +4195,8 @@ static int config_qp_rq_buf(struct hns_roce_dev *hr_dev,
 	int count;
 
 	/* Search qp buf's mtts */
-	count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, hr_qp->rq.offset, mtts,
-				  MTT_MIN_COUNT, &wqe_sge_ba);
+	count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, hr_qp->rq.wqe_offset,
+				  mtts, ARRAY_SIZE(mtts), &wqe_sge_ba);
 	if (hr_qp->rq.wqe_cnt && count < 1) {
 		ibdev_err(&hr_dev->ib_dev,
 			  "failed to find RQ WQE, QPN = 0x%lx.\n", hr_qp->qpn);
@@ -4246,12 +4246,15 @@ static int config_qp_rq_buf(struct hns_roce_dev *hr_dev,
 		     upper_32_bits(to_hr_hw_page_addr(mtts[0])));
 	hr_reg_clear(qpc_mask, QPC_RQ_CUR_BLK_ADDR_H);
 
-	context->rq_nxt_blk_addr = cpu_to_le32(to_hr_hw_page_addr(mtts[1]));
-	qpc_mask->rq_nxt_blk_addr = 0;
-
-	hr_reg_write(context, QPC_RQ_NXT_BLK_ADDR_H,
-		     upper_32_bits(to_hr_hw_page_addr(mtts[1])));
-	hr_reg_clear(qpc_mask, QPC_RQ_NXT_BLK_ADDR_H);
+	// The rq next block address is only valid for HIP08 QPC.
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08) {
+		context->rq_nxt_blk_addr =
+				cpu_to_le32(to_hr_hw_page_addr(mtts[1]));
+		qpc_mask->rq_nxt_blk_addr = 0;
+		hr_reg_write(context, QPC_RQ_NXT_BLK_ADDR_H,
+			     upper_32_bits(to_hr_hw_page_addr(mtts[1])));
+		hr_reg_clear(qpc_mask, QPC_RQ_NXT_BLK_ADDR_H);
+	}
 
 	return 0;
 }
@@ -4267,7 +4270,8 @@ static int config_qp_sq_buf(struct hns_roce_dev *hr_dev,
 	int count;
 
 	/* search qp buf's mtts */
-	count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, 0, &sq_cur_blk, 1, NULL);
+	count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, hr_qp->sq.wqe_offset,
+				  &sq_cur_blk, 1, NULL);
 	if (count < 1) {
 		ibdev_err(ibdev, "failed to find QP(0x%lx) SQ buf.\n",
 			  hr_qp->qpn);
@@ -4275,8 +4279,8 @@ static int config_qp_sq_buf(struct hns_roce_dev *hr_dev,
 	}
 	if (hr_qp->sge.sge_cnt > 0) {
 		count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr,
-					  hr_qp->sge.offset,
-					  &sge_cur_blk, 1, NULL);
+					  hr_qp->sge.wqe_offset, &sge_cur_blk,
+					  1, NULL);
 		if (count < 1) {
 			ibdev_err(ibdev, "failed to find QP(0x%lx) SGE buf.\n",
 				  hr_qp->qpn);
@@ -4342,6 +4346,7 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	int mtu;
 	int ret;
 
+	hr_qp->rq.wqe_offset = hr_qp->rq.offset;
 	ret = config_qp_rq_buf(hr_dev, hr_qp, context, qpc_mask);
 	if (ret) {
 		ibdev_err(ibdev, "failed to config rq buf, ret = %d.\n", ret);
@@ -4476,6 +4481,8 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
 		return -EINVAL;
 	}
 
+	hr_qp->sq.wqe_offset = hr_qp->sq.offset;
+	hr_qp->sge.wqe_offset = hr_qp->sge.offset;
 	ret = config_qp_sq_buf(hr_dev, hr_qp, context, qpc_mask);
 	if (ret) {
 		ibdev_err(ibdev, "failed to config sq buf, ret = %d.\n", ret);
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index 4452b17..18ef96e 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -111,6 +111,7 @@ enum hns_ib_dca_mem_methods {
 	HNS_IB_METHOD_DCA_MEM_REG = (1U << UVERBS_ID_NS_SHIFT),
 	HNS_IB_METHOD_DCA_MEM_DEREG,
 	HNS_IB_METHOD_DCA_MEM_SHRINK,
+	HNS_IB_METHOD_DCA_MEM_ATTACH,
 };
 
 enum hns_ib_dca_mem_reg_attrs {
@@ -131,4 +132,14 @@ enum hns_ib_dca_mem_shrink_attrs {
 	HNS_IB_ATTR_DCA_MEM_SHRINK_OUT_FREE_MEMS,
 };
 
+#define HNS_IB_ATTACH_FLAGS_NEW_BUFFER 1U
+
+enum hns_ib_dca_mem_attach_attrs {
+	HNS_IB_ATTR_DCA_MEM_ATTACH_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+	HNS_IB_ATTR_DCA_MEM_ATTACH_SQ_OFFSET,
+	HNS_IB_ATTR_DCA_MEM_ATTACH_SGE_OFFSET,
+	HNS_IB_ATTR_DCA_MEM_ATTACH_RQ_OFFSET,
+	HNS_IB_ATTR_DCA_MEM_ATTACH_OUT_ALLOC_FLAGS,
+	HNS_IB_ATTR_DCA_MEM_ATTACH_OUT_ALLOC_PAGES,
+};
 #endif /* HNS_ABI_USER_H */
-- 
2.8.1

