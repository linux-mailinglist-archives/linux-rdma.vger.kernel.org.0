Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888433D9BB4
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jul 2021 04:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbhG2CXF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Jul 2021 22:23:05 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7764 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbhG2CXF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Jul 2021 22:23:05 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GZvL76G7fzYhmy;
        Thu, 29 Jul 2021 10:17:03 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 10:23:00 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 10:23:00 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <leon@kernel.org>, <liangwenpeng@huawei.com>,
        Xi Wang <wangxi11@huawei.com>
Subject: [PATCH v4 for-next 07/12] RDMA/hns: Add method to detach WQE buffer
Date:   Thu, 29 Jul 2021 10:19:18 +0800
Message-ID: <1627525163-1683-8-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1627525163-1683-1-git-send-email-liangwenpeng@huawei.com>
References: <1627525163-1683-1-git-send-email-liangwenpeng@huawei.com>
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

If a uQP works in DCA mode, the userspace driver needs to drop the WQE
buffer by calling the 'HNS_IB_METHOD_DCA_MEM_DETACH' method when the QP's
CI is equal to PI, that means, the hns ROCEE will not access the WQE's
buffer at this time, and the userspace driver can free this WQE's buffer.

This method will start an worker queue to recycle the WQE buffer in kernel
space, if the WQE buffer is indeed not being accessed by hns ROCEE, the
worker will change the pages' state as free in DCA memory pool.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_dca.c    | 245 +++++++++++++++++++++++++++-
 drivers/infiniband/hw/hns/hns_roce_dca.h    |   9 +-
 drivers/infiniband/hw/hns/hns_roce_device.h |  14 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  12 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  43 ++++-
 drivers/infiniband/hw/hns/hns_roce_qp.c     |   6 +-
 include/uapi/rdma/hns-abi.h                 |   7 +
 7 files changed, 321 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_dca.c b/drivers/infiniband/hw/hns/hns_roce_dca.c
index 45fe163..dd1d6c3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_dca.c
+++ b/drivers/infiniband/hw/hns/hns_roce_dca.c
@@ -15,6 +15,9 @@
 #define UVERBS_MODULE_NAME hns_ib
 #include <rdma/uverbs_named_ioctl.h>
 
+/* DCA mem ageing interval time */
+#define DCA_MEM_AGEING_MSES 1000
+
 /* DCA memory */
 struct dca_mem {
 #define DCA_MEM_FLAGS_ALLOCED BIT(0)
@@ -42,6 +45,12 @@ static inline void set_dca_page_to_free(struct hns_dca_page_state *state)
 	state->lock = 0;
 }
 
+static inline void set_dca_page_to_inactive(struct hns_dca_page_state *state)
+{
+	state->active = 0;
+	state->lock = 0;
+}
+
 static inline void lock_dca_page_to_attach(struct hns_dca_page_state *state,
 					   u32 buf_id)
 {
@@ -285,11 +294,94 @@ static int shrink_dca_mem(struct hns_roce_dev *hr_dev,
 	return 0;
 }
 
+static void restart_aging_dca_mem(struct hns_roce_dev *hr_dev,
+				  struct hns_roce_dca_ctx *ctx)
+{
+	spin_lock(&ctx->aging_lock);
+	ctx->exit_aging = false;
+	if (!list_empty(&ctx->aging_new_list))
+		queue_delayed_work(hr_dev->irq_workq, &ctx->aging_dwork,
+				   msecs_to_jiffies(DCA_MEM_AGEING_MSES));
+
+	spin_unlock(&ctx->aging_lock);
+}
+
+static void stop_aging_dca_mem(struct hns_roce_dca_ctx *ctx,
+			       struct hns_roce_dca_cfg *cfg, bool stop_worker)
+{
+	spin_lock(&ctx->aging_lock);
+	if (stop_worker) {
+		ctx->exit_aging = true;
+		cancel_delayed_work(&ctx->aging_dwork);
+	}
+
+	spin_lock(&cfg->lock);
+
+	if (!list_empty(&cfg->aging_node))
+		list_del_init(&cfg->aging_node);
+
+	spin_unlock(&cfg->lock);
+	spin_unlock(&ctx->aging_lock);
+}
+
+static void free_buf_from_dca_mem(struct hns_roce_dca_ctx *ctx,
+				  struct hns_roce_dca_cfg *cfg);
+static void process_aging_dca_mem(struct hns_roce_dev *hr_dev,
+				  struct hns_roce_dca_ctx *ctx)
+{
+	struct hns_roce_dca_cfg *cfg, *tmp_cfg;
+	struct hns_roce_qp *hr_qp;
+
+	spin_lock(&ctx->aging_lock);
+	list_for_each_entry_safe(cfg, tmp_cfg, &ctx->aging_new_list, aging_node)
+		list_move(&cfg->aging_node, &ctx->aging_proc_list);
+
+	while (!ctx->exit_aging && !list_empty(&ctx->aging_proc_list)) {
+		cfg = list_first_entry(&ctx->aging_proc_list,
+				       struct hns_roce_dca_cfg, aging_node);
+		list_del_init_careful(&cfg->aging_node);
+		hr_qp = container_of(cfg, struct hns_roce_qp, dca_cfg);
+		spin_unlock(&ctx->aging_lock);
+
+		if (hr_dev->hw->chk_dca_buf_inactive(hr_dev, hr_qp))
+			free_buf_from_dca_mem(ctx, cfg);
+
+		spin_lock(&ctx->aging_lock);
+
+		spin_lock(&cfg->lock);
+		/* If buf not free then add the buf to next aging list */
+		if (cfg->buf_id != HNS_DCA_INVALID_BUF_ID)
+			list_move(&cfg->aging_node, &ctx->aging_new_list);
+
+		spin_unlock(&cfg->lock);
+	}
+	spin_unlock(&ctx->aging_lock);
+}
+
+static void udca_mem_aging_work(struct work_struct *work)
+{
+	struct hns_roce_dca_ctx *ctx = container_of(work,
+			struct hns_roce_dca_ctx, aging_dwork.work);
+	struct hns_roce_ucontext *uctx = container_of(ctx,
+					 struct hns_roce_ucontext, dca_ctx);
+	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->ibucontext.device);
+
+	cancel_delayed_work(&ctx->aging_dwork);
+	process_aging_dca_mem(hr_dev, ctx);
+	if (!ctx->exit_aging)
+		restart_aging_dca_mem(hr_dev, ctx);
+}
+
 static void init_dca_context(struct hns_roce_dca_ctx *ctx)
 {
 	INIT_LIST_HEAD(&ctx->pool);
 	spin_lock_init(&ctx->pool_lock);
 	ctx->total_size = 0;
+	INIT_LIST_HEAD(&ctx->aging_new_list);
+	INIT_LIST_HEAD(&ctx->aging_proc_list);
+	spin_lock_init(&ctx->aging_lock);
+	ctx->exit_aging = false;
+	INIT_DELAYED_WORK(&ctx->aging_dwork, udca_mem_aging_work);
 }
 
 static void cleanup_dca_context(struct hns_roce_dev *hr_dev,
@@ -298,6 +390,10 @@ static void cleanup_dca_context(struct hns_roce_dev *hr_dev,
 	struct dca_mem *mem, *tmp;
 	unsigned long flags;
 
+	spin_lock(&ctx->aging_lock);
+	cancel_delayed_work_sync(&ctx->aging_dwork);
+	spin_unlock(&ctx->aging_lock);
+
 	spin_lock_irqsave(&ctx->pool_lock, flags);
 	list_for_each_entry_safe(mem, tmp, &ctx->pool, list) {
 		list_del(&mem->list);
@@ -731,7 +827,11 @@ static int attach_dca_mem(struct hns_roce_dev *hr_dev,
 	u32 buf_id;
 	int ret;
 
+	if (hr_qp->en_flags & HNS_ROCE_QP_CAP_DYNAMIC_CTX_DETACH)
+		stop_aging_dca_mem(ctx, cfg, false);
+
 	resp->alloc_flags = 0;
+
 	spin_lock(&cfg->lock);
 	buf_id = cfg->buf_id;
 	/* Already attached */
@@ -770,23 +870,138 @@ static int attach_dca_mem(struct hns_roce_dev *hr_dev,
 	return 0;
 }
 
+struct dca_page_free_buf_attr {
+	u32 buf_id;
+	u32 max_pages;
+	u32 free_pages;
+	u32 clean_mems;
+};
+
+static int free_buffer_pages_proc(struct dca_mem *mem, int index, void *param)
+{
+	struct dca_page_free_buf_attr *attr = param;
+	struct hns_dca_page_state *state;
+	bool changed = false;
+	bool stop = false;
+	int i, free_pages;
+
+	free_pages = 0;
+	for (i = 0; !stop && i < mem->page_count; i++) {
+		state = &mem->states[i];
+		/* Change matched pages state */
+		if (dca_page_is_attached(state, attr->buf_id)) {
+			set_dca_page_to_free(state);
+			changed = true;
+			attr->free_pages++;
+			if (attr->free_pages == attr->max_pages)
+				stop = true;
+		}
+
+		if (dca_page_is_free(state))
+			free_pages++;
+	}
+
+	for (; changed && i < mem->page_count; i++)
+		if (dca_page_is_free(state))
+			free_pages++;
+
+	if (changed && free_pages == mem->page_count)
+		attr->clean_mems++;
+
+	return stop ? DCA_MEM_STOP_ITERATE : DCA_MEM_NEXT_ITERATE;
+}
+
+static void free_buf_from_dca_mem(struct hns_roce_dca_ctx *ctx,
+				  struct hns_roce_dca_cfg *cfg)
+{
+	struct dca_page_free_buf_attr attr = {};
+	unsigned long flags;
+	u32 buf_id;
+
+	spin_lock(&cfg->lock);
+	buf_id = cfg->buf_id;
+	cfg->buf_id = HNS_DCA_INVALID_BUF_ID;
+	spin_unlock(&cfg->lock);
+	if (buf_id == HNS_DCA_INVALID_BUF_ID)
+		return;
+
+	attr.buf_id = buf_id;
+	attr.max_pages = cfg->npages;
+	travel_dca_pages(ctx, &attr, free_buffer_pages_proc);
+
+	/* Update free size */
+	spin_lock_irqsave(&ctx->pool_lock, flags);
+	ctx->free_mems += attr.clean_mems;
+	ctx->free_size += attr.free_pages << HNS_HW_PAGE_SHIFT;
+	spin_unlock_irqrestore(&ctx->pool_lock, flags);
+}
+
+static void detach_dca_mem(struct hns_roce_dev *hr_dev,
+			   struct hns_roce_qp *hr_qp,
+			   struct hns_dca_detach_attr *attr)
+{
+	struct hns_roce_dca_ctx *ctx = hr_qp_to_dca_ctx(hr_qp);
+	struct hns_roce_dca_cfg *cfg = &hr_qp->dca_cfg;
+
+	stop_aging_dca_mem(ctx, cfg, true);
+
+	spin_lock(&ctx->aging_lock);
+	spin_lock(&cfg->lock);
+	cfg->sq_idx = attr->sq_idx;
+	list_add_tail(&cfg->aging_node, &ctx->aging_new_list);
+	spin_unlock(&cfg->lock);
+	spin_unlock(&ctx->aging_lock);
+
+	restart_aging_dca_mem(hr_dev, ctx);
+}
+
+static void kick_dca_buf(struct hns_roce_dev *hr_dev,
+			 struct hns_roce_dca_cfg *cfg,
+			 struct hns_roce_dca_ctx *ctx)
+{
+	stop_aging_dca_mem(ctx, cfg, true);
+	free_buf_from_dca_mem(ctx, cfg);
+	restart_aging_dca_mem(hr_dev, ctx);
+}
+
 void hns_roce_enable_dca(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 {
 	struct hns_roce_dca_cfg *cfg = &hr_qp->dca_cfg;
 
 	spin_lock_init(&cfg->lock);
+	INIT_LIST_HEAD(&cfg->aging_node);
 	cfg->buf_id = HNS_DCA_INVALID_BUF_ID;
 	cfg->npages = hr_qp->buff_size >> HNS_HW_PAGE_SHIFT;
+	/* Support dynamic detach when rq is empty */
+	if (!hr_qp->rq.wqe_cnt)
+		hr_qp->en_flags |= HNS_ROCE_QP_CAP_DYNAMIC_CTX_DETACH;
 }
 
 void hns_roce_disable_dca(struct hns_roce_dev *hr_dev,
-			  struct hns_roce_qp *hr_qp)
+			  struct hns_roce_qp *hr_qp, struct ib_udata *udata)
 {
+	struct hns_roce_ucontext *uctx = rdma_udata_to_drv_context(udata,
+					 struct hns_roce_ucontext, ibucontext);
+	struct hns_roce_dca_ctx *ctx = to_hr_dca_ctx(uctx);
 	struct hns_roce_dca_cfg *cfg = &hr_qp->dca_cfg;
 
+	kick_dca_buf(hr_dev, cfg, ctx);
 	cfg->buf_id = HNS_DCA_INVALID_BUF_ID;
 }
 
+void hns_roce_modify_dca(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
+			 struct ib_udata *udata)
+{
+	struct hns_roce_ucontext *uctx = rdma_udata_to_drv_context(udata,
+					 struct hns_roce_ucontext, ibucontext);
+	struct hns_roce_dca_ctx *ctx = to_hr_dca_ctx(uctx);
+	struct hns_roce_dca_cfg *cfg = &hr_qp->dca_cfg;
+
+	if (hr_qp->state == IB_QPS_RESET || hr_qp->state == IB_QPS_ERR)
+		kick_dca_buf(hr_dev, cfg, ctx);
+
+}
+
 static struct hns_roce_ucontext *
 uverbs_attr_to_hr_uctx(struct uverbs_attr_bundle *attrs)
 {
@@ -962,12 +1177,38 @@ DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_ATTR_PTR_OUT(HNS_IB_ATTR_DCA_MEM_ATTACH_OUT_ALLOC_PAGES,
 			    UVERBS_ATTR_TYPE(u32), UA_MANDATORY));
 
+static int UVERBS_HANDLER(HNS_IB_METHOD_DCA_MEM_DETACH)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct hns_roce_qp *hr_qp = uverbs_attr_to_hr_qp(attrs);
+	struct hns_dca_detach_attr attr = {};
+
+	if (!hr_qp)
+		return -EINVAL;
+
+	if (uverbs_copy_from(&attr.sq_idx, attrs,
+			     HNS_IB_ATTR_DCA_MEM_DETACH_SQ_INDEX))
+		return -EFAULT;
+
+	detach_dca_mem(to_hr_dev(hr_qp->ibqp.device), hr_qp, &attr);
+
+	return 0;
+}
+
+DECLARE_UVERBS_NAMED_METHOD(
+	HNS_IB_METHOD_DCA_MEM_DETACH,
+	UVERBS_ATTR_IDR(HNS_IB_ATTR_DCA_MEM_DETACH_HANDLE, UVERBS_OBJECT_QP,
+			UVERBS_ACCESS_WRITE, UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(HNS_IB_ATTR_DCA_MEM_DETACH_SQ_INDEX,
+			   UVERBS_ATTR_TYPE(u32), UA_MANDATORY));
+
 DECLARE_UVERBS_NAMED_OBJECT(HNS_IB_OBJECT_DCA_MEM,
 			    UVERBS_TYPE_ALLOC_IDR(dca_cleanup),
 			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_REG),
 			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_DEREG),
 			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_SHRINK),
-			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_ATTACH));
+			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_ATTACH),
+			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_DETACH));
 
 static bool dca_is_supported(struct ib_device *device)
 {
diff --git a/drivers/infiniband/hw/hns/hns_roce_dca.h b/drivers/infiniband/hw/hns/hns_roce_dca.h
index d66cb74..4493854 100644
--- a/drivers/infiniband/hw/hns/hns_roce_dca.h
+++ b/drivers/infiniband/hw/hns/hns_roce_dca.h
@@ -46,6 +46,10 @@ struct hns_dca_attach_resp {
 	u32 alloc_pages;
 };
 
+struct hns_dca_detach_attr {
+	u32 sq_idx;
+};
+
 void hns_roce_register_udca(struct hns_roce_dev *hr_dev,
 			    struct hns_roce_ucontext *uctx);
 void hns_roce_unregister_udca(struct hns_roce_dev *hr_dev,
@@ -54,5 +58,8 @@ void hns_roce_unregister_udca(struct hns_roce_dev *hr_dev,
 void hns_roce_enable_dca(struct hns_roce_dev *hr_dev,
 			 struct hns_roce_qp *hr_qp);
 void hns_roce_disable_dca(struct hns_roce_dev *hr_dev,
-			  struct hns_roce_qp *hr_qp);
+			  struct hns_roce_qp *hr_qp, struct ib_udata *udata);
+void hns_roce_modify_dca(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
+			 struct ib_udata *udata);
+
 #endif
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 50dc894..fcaa004 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -231,6 +231,12 @@ struct hns_roce_dca_ctx {
 	unsigned int free_mems; /* free mem num in pool */
 	size_t free_size; /* free mem size in pool */
 	size_t total_size; /* total size in pool */
+
+	bool exit_aging;
+	struct list_head aging_proc_list;
+	struct list_head aging_new_list;
+	spinlock_t aging_lock;
+	struct delayed_work aging_dwork;
 };
 
 struct hns_roce_ucontext {
@@ -336,9 +342,11 @@ struct hns_roce_dca_cfg {
 	u32 buf_id;
 	u16 attach_count;
 	u32 npages;
+	u32 sq_idx;
+	bool			aging_enable;
+	struct list_head	aging_node;
 };
 
-
 struct hns_roce_mw {
 	struct ib_mw		ibmw;
 	u32			pdn;
@@ -932,11 +940,13 @@ struct hns_roce_hw {
 			 int step_idx);
 	int (*set_dca_buf)(struct hns_roce_dev *hr_dev,
 			   struct hns_roce_qp *hr_qp);
+	bool (*chk_dca_buf_inactive)(struct hns_roce_dev *hr_dev,
+				     struct hns_roce_qp *hr_qp);
 	int (*query_qp)(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 			int qp_attr_mask, struct ib_qp_init_attr *qp_init_attr);
 	int (*modify_qp)(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 			 int attr_mask, enum ib_qp_state cur_state,
-			 enum ib_qp_state new_state);
+			 enum ib_qp_state new_state, struct ib_udata *udata);
 	int (*qp_flow_control_init)(struct hns_roce_dev *hr_dev,
 			 struct hns_roce_qp *hr_qp);
 	int (*dereg_mr)(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index a3305d1..82fcf6b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -897,21 +897,21 @@ static int hns_roce_v1_rsv_lp_qp(struct hns_roce_dev *hr_dev)
 		rdma_ah_set_dgid_raw(&attr.ah_attr, dgid.raw);
 
 		ret = hr_dev->hw->modify_qp(&hr_qp->ibqp, &attr, attr_mask,
-					    IB_QPS_RESET, IB_QPS_INIT);
+					    IB_QPS_RESET, IB_QPS_INIT, NULL);
 		if (ret) {
 			dev_err(dev, "modify qp failed(%d)!\n", ret);
 			goto create_lp_qp_failed;
 		}
 
 		ret = hr_dev->hw->modify_qp(&hr_qp->ibqp, &attr, IB_QP_DEST_QPN,
-					    IB_QPS_INIT, IB_QPS_RTR);
+					    IB_QPS_INIT, IB_QPS_RTR, NULL);
 		if (ret) {
 			dev_err(dev, "modify qp failed(%d)!\n", ret);
 			goto create_lp_qp_failed;
 		}
 
 		ret = hr_dev->hw->modify_qp(&hr_qp->ibqp, &attr, attr_mask,
-					    IB_QPS_RTR, IB_QPS_RTS);
+					    IB_QPS_RTR, IB_QPS_RTS, NULL);
 		if (ret) {
 			dev_err(dev, "modify qp failed(%d)!\n", ret);
 			goto create_lp_qp_failed;
@@ -3326,7 +3326,8 @@ static int hns_roce_v1_m_qp(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 static int hns_roce_v1_modify_qp(struct ib_qp *ibqp,
 				 const struct ib_qp_attr *attr, int attr_mask,
 				 enum ib_qp_state cur_state,
-				 enum ib_qp_state new_state)
+				 enum ib_qp_state new_state,
+				 struct ib_udata *udata)
 {
 	if (attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
 		return -EOPNOTSUPP;
@@ -3612,7 +3613,8 @@ int hns_roce_v1_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	struct hns_roce_cq *send_cq, *recv_cq;
 	int ret;
 
-	ret = hns_roce_v1_modify_qp(ibqp, NULL, 0, hr_qp->state, IB_QPS_RESET);
+	ret = hns_roce_v1_modify_qp(ibqp, NULL, 0, hr_qp->state, IB_QPS_RESET,
+				    NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 7e44128..4677c48 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -46,6 +46,7 @@
 #include "hns_roce_device.h"
 #include "hns_roce_cmd.h"
 #include "hns_roce_hem.h"
+#include "hns_roce_dca.h"
 #include "hns_roce_hw_v2.h"
 
 enum {
@@ -5026,7 +5027,8 @@ static void v2_set_flushed_fields(struct ib_qp *ibqp,
 static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 				 const struct ib_qp_attr *attr,
 				 int attr_mask, enum ib_qp_state cur_state,
-				 enum ib_qp_state new_state)
+				 enum ib_qp_state new_state,
+				 struct ib_udata *udata)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
@@ -5086,6 +5088,9 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 	if (new_state == IB_QPS_RESET && !ibqp->uobject)
 		clear_qp(hr_qp);
 
+	if (check_dca_attach_enable(hr_qp))
+		hns_roce_modify_dca(hr_dev, hr_qp, udata);
+
 out:
 	return ret;
 }
@@ -5272,6 +5277,39 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	return ret;
 }
 
+static bool hns_roce_v2_chk_dca_buf_inactive(struct hns_roce_dev *hr_dev,
+					     struct hns_roce_qp *hr_qp)
+{
+	struct hns_roce_dca_cfg *cfg = &hr_qp->dca_cfg;
+	struct hns_roce_v2_qp_context context = {};
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	u32 tmp, sq_idx;
+	int state;
+	int ret;
+
+	ret = hns_roce_v2_query_qpc(hr_dev, hr_qp, &context);
+	if (ret) {
+		ibdev_err(ibdev, "failed to query DCA QPC, ret = %d.\n", ret);
+		return false;
+	}
+
+	state = hr_reg_read(&context, QPC_QP_ST);
+	if (state == HNS_ROCE_QP_ST_ERR || state == HNS_ROCE_QP_ST_RST)
+		return true;
+
+	if (hr_qp->sq.wqe_cnt > 0) {
+		tmp = (u32)hr_reg_read(&context, QPC_RETRY_MSG_MSN);
+		sq_idx = tmp & (hr_qp->sq.wqe_cnt - 1);
+		/* If SQ-PI equals to retry_msg_msn in QPC, the QP is
+		 * inactive.
+		 */
+		if (sq_idx != cfg->sq_idx)
+			return false;
+	}
+
+	return true;
+}
+
 static inline int modify_qp_is_ok(struct hns_roce_qp *hr_qp)
 {
 	return ((hr_qp->ibqp.qp_type == IB_QPT_RC ||
@@ -5293,7 +5331,7 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 	if (modify_qp_is_ok(hr_qp)) {
 		/* Modify qp to reset before destroying qp */
 		ret = hns_roce_v2_modify_qp(&hr_qp->ibqp, NULL, 0,
-					    hr_qp->state, IB_QPS_RESET);
+					    hr_qp->state, IB_QPS_RESET, udata);
 		if (ret)
 			ibdev_err(ibdev,
 				  "failed to modify QP to RST, ret = %d.\n",
@@ -6309,6 +6347,7 @@ static const struct hns_roce_hw hns_roce_hw_v2 = {
 	.set_hem = hns_roce_v2_set_hem,
 	.clear_hem = hns_roce_v2_clear_hem,
 	.set_dca_buf = hns_roce_v2_set_dca_buf,
+	.chk_dca_buf_inactive = hns_roce_v2_chk_dca_buf_inactive,
 	.modify_qp = hns_roce_v2_modify_qp,
 	.qp_flow_control_init = hns_roce_v2_qp_flow_control_init,
 	.init_eq = hns_roce_v2_init_eq_table,
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 4b8e850..0918c97 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -794,7 +794,7 @@ static int alloc_wqe_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 	if (ret) {
 		ibdev_err(ibdev, "failed to create WQE mtr, ret = %d.\n", ret);
 		if (dca_en)
-			hns_roce_disable_dca(hr_dev, hr_qp);
+			hns_roce_disable_dca(hr_dev, hr_qp, udata);
 	}
 
 	return ret;
@@ -806,7 +806,7 @@ static void free_wqe_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 	hns_roce_mtr_destroy(hr_dev, &hr_qp->mtr);
 
 	if (hr_qp->en_flags & HNS_ROCE_QP_CAP_DYNAMIC_CTX_ATTACH)
-		hns_roce_disable_dca(hr_dev, hr_qp);
+		hns_roce_disable_dca(hr_dev, hr_qp, udata);
 }
 
 static int alloc_qp_wqe(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
@@ -1414,7 +1414,7 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	}
 
 	ret = hr_dev->hw->modify_qp(ibqp, attr, attr_mask, cur_state,
-				    new_state);
+				    new_state, udata);
 
 out:
 	mutex_unlock(&hr_qp->mutex);
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index 18ef96e..97ab795 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -78,6 +78,7 @@ enum hns_roce_qp_cap_flags {
 	HNS_ROCE_QP_CAP_SQ_RECORD_DB = 1 << 1,
 	HNS_ROCE_QP_CAP_OWNER_DB = 1 << 2,
 	HNS_ROCE_QP_CAP_DYNAMIC_CTX_ATTACH = 1 << 4,
+	HNS_ROCE_QP_CAP_DYNAMIC_CTX_DETACH = 1 << 6,
 };
 
 struct hns_roce_ib_create_qp_resp {
@@ -112,6 +113,7 @@ enum hns_ib_dca_mem_methods {
 	HNS_IB_METHOD_DCA_MEM_DEREG,
 	HNS_IB_METHOD_DCA_MEM_SHRINK,
 	HNS_IB_METHOD_DCA_MEM_ATTACH,
+	HNS_IB_METHOD_DCA_MEM_DETACH,
 };
 
 enum hns_ib_dca_mem_reg_attrs {
@@ -142,4 +144,9 @@ enum hns_ib_dca_mem_attach_attrs {
 	HNS_IB_ATTR_DCA_MEM_ATTACH_OUT_ALLOC_FLAGS,
 	HNS_IB_ATTR_DCA_MEM_ATTACH_OUT_ALLOC_PAGES,
 };
+
+enum hns_ib_dca_mem_detach_attrs {
+	HNS_IB_ATTR_DCA_MEM_DETACH_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+	HNS_IB_ATTR_DCA_MEM_DETACH_SQ_INDEX,
+};
 #endif /* HNS_ABI_USER_H */
-- 
2.8.1

