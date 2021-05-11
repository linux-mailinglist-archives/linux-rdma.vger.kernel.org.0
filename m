Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF51237A5AB
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 13:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhEKLYB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 07:24:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2628 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbhEKLYB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 May 2021 07:24:01 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ffb6S38SczPwyw;
        Tue, 11 May 2021 19:19:28 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Tue, 11 May 2021 19:22:42 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, "Xi Wang" <wangxi11@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH v2 for-next 4/7] RDMA/hns: Add method for attaching WQE buffer
Date:   Tue, 11 May 2021 19:22:38 +0800
Message-ID: <1620732161-27180-5-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620732161-27180-1-git-send-email-liweihang@huawei.com>
References: <1620732161-27180-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

If a uQP works as DCA mode, the userspace driver need config the WQE buffer
by calling the 'HNS_IB_METHOD_DCA_MEM_ATTACH' method before filling the
WQE. This method will allocate a group of pages from DCA memory pool and
write the configuration of addressing to QPC.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_dca.c    | 460 +++++++++++++++++++++++++++-
 drivers/infiniband/hw/hns/hns_roce_dca.h    |  25 ++
 drivers/infiniband/hw/hns/hns_roce_device.h |  15 +
 include/uapi/rdma/hns-abi.h                 |  11 +
 4 files changed, 510 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_dca.c b/drivers/infiniband/hw/hns/hns_roce_dca.c
index 9e7c3e2..7014812 100644
--- a/drivers/infiniband/hw/hns/hns_roce_dca.c
+++ b/drivers/infiniband/hw/hns/hns_roce_dca.c
@@ -35,11 +35,53 @@ struct dca_mem_attr {
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
 static inline bool dca_page_is_free(struct hns_dca_page_state *state)
 {
 	return state->buf_id == HNS_DCA_INVALID_BUF_ID;
 }
 
+static inline bool dca_page_is_attached(struct hns_dca_page_state *state,
+					u32 buf_id)
+{
+	/* only the own bit needs to be matched. */
+	return (HNS_DCA_OWN_MASK & buf_id) ==
+			(HNS_DCA_OWN_MASK & state->buf_id);
+}
+
+static inline bool dca_page_is_allocated(struct hns_dca_page_state *state,
+					 u32 buf_id)
+{
+	return dca_page_is_attached(state, buf_id) && state->lock;
+}
+
+static inline bool dca_page_is_inactive(struct hns_dca_page_state *state)
+{
+	return !state->lock && !state->active;
+}
+
 static inline bool dca_mem_is_free(struct dca_mem *mem)
 {
 	return mem->flags == 0;
@@ -386,11 +428,365 @@ static void free_dca_mem(struct dca_mem *mem)
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
+static int apply_dca_cfg(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
+			 struct hns_dca_attach_attr *attach_attr)
+{
+	struct hns_roce_dca_attr attr;
+
+	if (hr_dev->hw->set_dca_buf) {
+		attr.sq_offset = attach_attr->sq_offset;
+		attr.sge_offset = attach_attr->sge_offset;
+		attr.rq_offset = attach_attr->rq_offset;
+		return hr_dev->hw->set_dca_buf(hr_dev, hr_qp, &attr);
+	}
+
+	return 0;
+}
+
+static int setup_dca_buf_to_hw(struct hns_roce_dca_ctx *ctx,
+			       struct hns_roce_qp *hr_qp, u32 buf_id,
+			       struct hns_dca_attach_attr *attach_attr)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(hr_qp->ibqp.device);
+	struct dca_get_alloced_pages_attr attr = {};
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	u32 count = hr_qp->dca_cfg.npages;
+	dma_addr_t *pages;
+	int ret;
+
+	/* Alloc a tmp array to store buffer's dma address */
+	pages = kvcalloc(count, sizeof(dma_addr_t), GFP_NOWAIT);
+	if (!pages)
+		return -ENOMEM;
+
+	attr.buf_id = buf_id;
+	attr.pages = pages;
+	attr.max = count;
+
+	travel_dca_pages(ctx, &attr, get_alloced_umem_proc);
+	if (attr.total != count) {
+		ibdev_err(ibdev, "failed to get DCA page %u != %u.\n",
+			  attr.total, count);
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	/* Update MTT for ROCEE addressing */
+	ret = hns_roce_mtr_map(hr_dev, &hr_qp->mtr, pages, count);
+	if (ret) {
+		ibdev_err(ibdev, "failed to map DCA pages, ret = %d.\n", ret);
+		goto done;
+	}
+
+	/* Apply the changes for WQE address */
+	ret = apply_dca_cfg(hr_dev, hr_qp, attach_attr);
+	if (ret)
+		ibdev_err(ibdev, "failed to apply DCA cfg, ret = %d.\n", ret);
+
+done:
+	/* Drop tmp array */
+	kvfree(pages);
+	return ret;
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
+	ret = setup_dca_buf_to_hw(ctx, hr_qp, buf_id, attr);
+	if (ret) {
+		ibdev_err(ibdev, "failed to setup DCA buf, ret = %d.\n", ret);
+		goto active_fail;
+	}
+
+	alloc_pages = hr_qp->dca_cfg.npages;
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
@@ -515,11 +911,73 @@ DECLARE_UVERBS_NAMED_METHOD(
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
index ee30b07..1b0aeef 100644
--- a/drivers/infiniband/hw/hns/hns_roce_dca.h
+++ b/drivers/infiniband/hw/hns/hns_roce_dca.h
@@ -21,6 +21,31 @@ struct hns_dca_shrink_resp {
 
 #define HNS_DCA_INVALID_BUF_ID 0UL
 
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
index d1ca142..96edbe0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -333,7 +333,17 @@ struct hns_roce_mtr {
 };
 
 struct hns_roce_dca_cfg {
+	spinlock_t lock;
 	u32 buf_id;
+	u16 attach_count;
+	u32 npages;
+};
+
+/* DCA attr for setting WQE buffer */
+struct hns_roce_dca_attr {
+	u32 sq_offset;
+	u32 sge_offset;
+	u32 rq_offset;
 };
 
 struct hns_roce_mw {
@@ -926,6 +936,11 @@ struct hns_roce_hw {
 	int (*clear_hem)(struct hns_roce_dev *hr_dev,
 			 struct hns_roce_hem_table *table, int obj,
 			 int step_idx);
+	int (*set_dca_buf)(struct hns_roce_dev *hr_dev,
+			   struct hns_roce_qp *hr_qp,
+			   struct hns_roce_dca_attr *attr);
+	int (*query_qp)(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
+			int qp_attr_mask, struct ib_qp_init_attr *qp_init_attr);
 	int (*modify_qp)(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 			 int attr_mask, enum ib_qp_state cur_state,
 			 enum ib_qp_state new_state);
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index 99da481..8f733f4 100644
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
2.7.4

