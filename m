Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB5C301457
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Jan 2021 10:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbhAWJqy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 23 Jan 2021 04:46:54 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11142 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbhAWJqx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 23 Jan 2021 04:46:53 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DNB6S0y0Lz15wDn;
        Sat, 23 Jan 2021 17:44:16 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 23 Jan 2021 17:45:23 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v2 RFC 6/7] RDMA/hns: Add method to detach WQE buffer
Date:   Sat, 23 Jan 2021 17:43:13 +0800
Message-ID: <1611394994-50363-7-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1611394994-50363-1-git-send-email-liweihang@huawei.com>
References: <1611394994-50363-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
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
worker will change the pages' state as free in DCA memroy pool.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_dca.c    | 162 +++++++++++++++++++++++++++-
 drivers/infiniband/hw/hns/hns_roce_dca.h    |   7 +-
 drivers/infiniband/hw/hns/hns_roce_device.h |   4 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  47 ++++++++
 drivers/infiniband/hw/hns/hns_roce_qp.c     |   4 +-
 include/uapi/rdma/hns-abi.h                 |   6 ++
 6 files changed, 225 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_dca.c b/drivers/infiniband/hw/hns/hns_roce_dca.c
index 8edfa4a..0a12559 100644
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
@@ -741,7 +750,10 @@ static int attach_dca_mem(struct hns_roce_dev *hr_dev,
 	u32 buf_id;
 	int ret;
 
+	/* Stop DCA mem ageing worker */
+	cancel_delayed_work(&cfg->dwork);
 	resp->alloc_flags = 0;
+
 	spin_lock(&cfg->lock);
 	buf_id = cfg->buf_id;
 	/* Already attached */
@@ -780,11 +792,128 @@ static int attach_dca_mem(struct hns_roce_dev *hr_dev,
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
+static void kick_dca_mem(struct hns_roce_dev *hr_dev,
+			 struct hns_roce_dca_cfg *cfg,
+			 struct hns_roce_ucontext *uctx)
+{
+	struct hns_roce_dca_ctx *ctx = to_hr_dca_ctx(uctx);
+
+	/* Stop ageing worker and free DCA buffer from pool */
+	cancel_delayed_work_sync(&cfg->dwork);
+	free_buf_from_dca_mem(ctx, cfg);
+}
+
+static void dca_mem_ageing_work(struct work_struct *work)
+{
+	struct hns_roce_qp *hr_qp = container_of(work, struct hns_roce_qp,
+						 dca_cfg.dwork.work);
+	struct hns_roce_dev *hr_dev = to_hr_dev(hr_qp->ibqp.device);
+	struct hns_roce_dca_ctx *ctx = hr_qp_to_dca_ctx(hr_qp);
+	bool hw_is_inactive;
+
+	hw_is_inactive = hr_dev->hw->chk_dca_buf_inactive &&
+			 hr_dev->hw->chk_dca_buf_inactive(hr_dev, hr_qp);
+	if (hw_is_inactive)
+		free_buf_from_dca_mem(ctx, &hr_qp->dca_cfg);
+}
+
+void hns_roce_dca_kick(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
+{
+	struct hns_roce_ucontext *uctx;
+
+	if (hr_qp->ibqp.uobject && hr_qp->ibqp.pd->uobject) {
+		uctx = to_hr_ucontext(hr_qp->ibqp.pd->uobject->context);
+		kick_dca_mem(hr_dev, &hr_qp->dca_cfg, uctx);
+	}
+}
+
+static void detach_dca_mem(struct hns_roce_dev *hr_dev,
+			   struct hns_roce_qp *hr_qp,
+			   struct hns_dca_detach_attr *attr)
+{
+	struct hns_roce_dca_cfg *cfg = &hr_qp->dca_cfg;
+
+	/* Start an ageing worker to free buffer */
+	cancel_delayed_work(&cfg->dwork);
+	spin_lock(&cfg->lock);
+	cfg->sq_idx = attr->sq_idx;
+	queue_delayed_work(hr_dev->irq_workq, &cfg->dwork,
+			   msecs_to_jiffies(DCA_MEM_AGEING_MSES));
+	spin_unlock(&cfg->lock);
+}
+
 int hns_roce_enable_dca(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 {
 	struct hns_roce_dca_cfg *cfg = &hr_qp->dca_cfg;
 
 	spin_lock_init(&cfg->lock);
+	INIT_DELAYED_WORK(&cfg->dwork, dca_mem_ageing_work);
 	cfg->buf_id = HNS_DCA_INVALID_BUF_ID;
 	cfg->npages = hr_qp->buff_size >> HNS_HW_PAGE_SHIFT;
 
@@ -792,10 +921,13 @@ int hns_roce_enable_dca(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 }
 
 void hns_roce_disable_dca(struct hns_roce_dev *hr_dev,
-			  struct hns_roce_qp *hr_qp)
+			  struct hns_roce_qp *hr_qp, struct ib_udata *udata)
 {
+	struct hns_roce_ucontext *uctx = rdma_udata_to_drv_context(udata,
+					 struct hns_roce_ucontext, ibucontext);
 	struct hns_roce_dca_cfg *cfg = &hr_qp->dca_cfg;
 
+	kick_dca_mem(hr_dev, cfg, uctx);
 	cfg->buf_id = HNS_DCA_INVALID_BUF_ID;
 }
 
@@ -974,12 +1106,38 @@ DECLARE_UVERBS_NAMED_METHOD(
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
index 39ac99f..8155903 100644
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
@@ -53,5 +57,6 @@ void hns_roce_unregister_udca(struct hns_roce_dev *hr_dev,
 
 int hns_roce_enable_dca(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp);
 void hns_roce_disable_dca(struct hns_roce_dev *hr_dev,
-			  struct hns_roce_qp *hr_qp);
+			  struct hns_roce_qp *hr_qp, struct ib_udata *udata);
+void hns_roce_dca_kick(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp);
 #endif
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 611e594..db09dc9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -372,6 +372,8 @@ struct hns_roce_dca_cfg {
 	u32 buf_id;
 	u16 attach_count;
 	u32 npages;
+	u32 sq_idx;
+	struct delayed_work dwork;
 };
 
 /* DCA attr for setting WQE buffer */
@@ -956,6 +958,8 @@ struct hns_roce_hw {
 	int (*set_dca_buf)(struct hns_roce_dev *hr_dev,
 			   struct hns_roce_qp *hr_qp,
 			   struct hns_roce_dca_attr *attr);
+	bool (*chk_dca_buf_inactive)(struct hns_roce_dev *hr_dev,
+				     struct hns_roce_qp *hr_qp);
 	int (*query_qp)(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 			int qp_attr_mask, struct ib_qp_init_attr *qp_init_attr);
 	int (*modify_qp)(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 0067dbf..8ded78e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -46,6 +46,7 @@
 #include "hns_roce_device.h"
 #include "hns_roce_cmd.h"
 #include "hns_roce_hem.h"
+#include "hns_roce_dca.h"
 #include "hns_roce_hw_v2.h"
 
 static void set_data_seg_v2(struct hns_roce_v2_wqe_data_seg *dseg,
@@ -4979,6 +4980,9 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 			*hr_qp->rdb.db_record = 0;
 	}
 
+	if (check_qp_dca_enable(hr_qp) &&
+	    (new_state == IB_QPS_RESET || new_state == IB_QPS_ERR))
+		hns_roce_dca_kick(hr_dev, hr_qp);
 out:
 	return ret;
 }
@@ -5240,6 +5244,48 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
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
+	state = roce_get_field(context.byte_60_qpst_tempid,
+			       V2_QPC_BYTE_60_QP_ST_M, V2_QPC_BYTE_60_QP_ST_S);
+	if (state == HNS_ROCE_QP_ST_ERR || state == HNS_ROCE_QP_ST_RST)
+		return true;
+
+	/* If RQ is not empty, the buffer is always active until the QP stops
+	 * working.
+	 */
+	if (hr_qp->rq.wqe_cnt > 0)
+		return false;
+
+	if (hr_qp->sq.wqe_cnt > 0) {
+		tmp = (u32)roce_get_field(context.byte_220_retry_psn_msn,
+					  V2_QPC_BYTE_220_RETRY_MSG_MSN_M,
+					  V2_QPC_BYTE_220_RETRY_MSG_MSN_S);
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
 static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 					 struct hns_roce_qp *hr_qp,
 					 struct ib_udata *udata)
@@ -6379,6 +6425,7 @@ static const struct hns_roce_hw hns_roce_hw_v2 = {
 	.set_hem = hns_roce_v2_set_hem,
 	.clear_hem = hns_roce_v2_clear_hem,
 	.set_dca_buf = hns_roce_v2_set_dca_buf,
+	.chk_dca_buf_inactive = hns_roce_v2_chk_dca_buf_inactive,
 	.modify_qp = hns_roce_v2_modify_qp,
 	.query_qp = hns_roce_v2_query_qp,
 	.destroy_qp = hns_roce_v2_destroy_qp,
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index b08d111..ee2ea2e3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -751,7 +751,7 @@ static int alloc_wqe_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 	if (ret) {
 		ibdev_err(ibdev, "failed to create WQE mtr, ret = %d.\n", ret);
 		if (dca_en)
-			hns_roce_disable_dca(hr_dev, hr_qp);
+			hns_roce_disable_dca(hr_dev, hr_qp, udata);
 	}
 
 	return ret;
@@ -763,7 +763,7 @@ static void free_wqe_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 	hns_roce_mtr_destroy(hr_dev, &hr_qp->mtr);
 
 	if (hr_qp->en_flags & HNS_ROCE_QP_CAP_DCA)
-		hns_roce_disable_dca(hr_dev, hr_qp);
+		hns_roce_disable_dca(hr_dev, hr_qp, udata);
 }
 
 static int alloc_qp_wqe(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index 8536c09..3912c7ac 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -110,6 +110,7 @@ enum hns_ib_dca_mem_methods {
 	HNS_IB_METHOD_DCA_MEM_DEREG,
 	HNS_IB_METHOD_DCA_MEM_SHRINK,
 	HNS_IB_METHOD_DCA_MEM_ATTACH,
+	HNS_IB_METHOD_DCA_MEM_DETACH,
 };
 
 enum hns_ib_dca_mem_reg_attrs {
@@ -140,4 +141,9 @@ enum hns_ib_dca_mem_attach_attrs {
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

