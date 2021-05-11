Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A40937A5A8
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 13:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhEKLYA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 07:24:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2626 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhEKLX6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 May 2021 07:23:58 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ffb6S2tD2zPwy2;
        Tue, 11 May 2021 19:19:28 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Tue, 11 May 2021 19:22:41 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, "Xi Wang" <wangxi11@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH v2 for-next 1/7] RDMA/hns: Introduce DCA for RC QP
Date:   Tue, 11 May 2021 19:22:35 +0800
Message-ID: <1620732161-27180-2-git-send-email-liweihang@huawei.com>
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

The hip09 introduces the DCA(Dynamic context attachment) feature which
supports many RC QPs to share the WQE buffer in a memory pool, this will
reduce the memory consumption when there are too many QPs are inactive.

If a QP enables DCA feature, the WQE's buffer will not be allocated when
creating. But when the users start to post WRs, the hns driver will
allocate a buffer from the memory pool and then fill WQEs which tagged with
this QP's number.

The hns ROCEE will stop accessing the WQE buffer when the user polled all
of the CQEs for a DCA QP, then the driver will recycle this WQE's buffer
to the memory pool.

This patch adds a group of methods to support the user space register
buffers to a memory pool which belongs to the user context. The hns kernel
driver will update the pages state in this pool when the user calling the
post/poll methods and the user driver can get the QP's WQE buffer address
by the key and offset which queried from kernel.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/Makefile          |   2 +-
 drivers/infiniband/hw/hns/hns_roce_dca.c    | 381 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_dca.h    |  22 ++
 drivers/infiniband/hw/hns/hns_roce_device.h |   9 +
 drivers/infiniband/hw/hns/hns_roce_main.c   |  27 +-
 include/uapi/rdma/hns-abi.h                 |  27 ++
 6 files changed, 465 insertions(+), 3 deletions(-)
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_dca.c
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_dca.h

diff --git a/drivers/infiniband/hw/hns/Makefile b/drivers/infiniband/hw/hns/Makefile
index e105945..9962b23 100644
--- a/drivers/infiniband/hw/hns/Makefile
+++ b/drivers/infiniband/hw/hns/Makefile
@@ -6,7 +6,7 @@
 ccflags-y :=  -I $(srctree)/drivers/net/ethernet/hisilicon/hns3
 
 hns-roce-objs := hns_roce_main.o hns_roce_cmd.o hns_roce_pd.o \
-	hns_roce_ah.o hns_roce_hem.o hns_roce_mr.o hns_roce_qp.o \
+	hns_roce_ah.o hns_roce_hem.o hns_roce_mr.o hns_roce_qp.o hns_roce_dca.o \
 	hns_roce_cq.o hns_roce_alloc.o hns_roce_db.o hns_roce_srq.o hns_roce_restrack.o
 
 ifdef CONFIG_INFINIBAND_HNS_HIP06
diff --git a/drivers/infiniband/hw/hns/hns_roce_dca.c b/drivers/infiniband/hw/hns/hns_roce_dca.c
new file mode 100644
index 0000000..2a03cf3
--- /dev/null
+++ b/drivers/infiniband/hw/hns/hns_roce_dca.c
@@ -0,0 +1,381 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2021 Hisilicon Limited. All rights reserved.
+ */
+
+#include <rdma/ib_user_verbs.h>
+#include <rdma/ib_verbs.h>
+#include <rdma/uverbs_types.h>
+#include <rdma/uverbs_ioctl.h>
+#include <rdma/uverbs_std_types.h>
+#include <rdma/ib_umem.h>
+#include "hns_roce_device.h"
+#include "hns_roce_dca.h"
+
+#define UVERBS_MODULE_NAME hns_ib
+#include <rdma/uverbs_named_ioctl.h>
+
+/* DCA memory */
+struct dca_mem {
+#define DCA_MEM_FLAGS_ALLOCED BIT(0)
+#define DCA_MEM_FLAGS_REGISTERED BIT(1)
+	u32 flags;
+	struct list_head list; /* link to mem list in dca context */
+	spinlock_t lock; /* protect the @flags and @list */
+	int page_count; /* page count in this mem obj */
+	u64 key; /* register by caller */
+	u32 size; /* bytes in this mem object */
+	struct hns_dca_page_state *states; /* record each page's state */
+	void *pages; /* memory handle for getting dma address */
+};
+
+struct dca_mem_attr {
+	u64 key;
+	u64 addr;
+	u32 size;
+};
+
+static inline bool dca_mem_is_free(struct dca_mem *mem)
+{
+	return mem->flags == 0;
+}
+
+static inline void set_dca_mem_free(struct dca_mem *mem)
+{
+	mem->flags = 0;
+}
+
+static inline void set_dca_mem_alloced(struct dca_mem *mem)
+{
+	mem->flags |= DCA_MEM_FLAGS_ALLOCED;
+}
+
+static inline void set_dca_mem_registered(struct dca_mem *mem)
+{
+	mem->flags |= DCA_MEM_FLAGS_REGISTERED;
+}
+
+static inline void clr_dca_mem_registered(struct dca_mem *mem)
+{
+	mem->flags &= ~DCA_MEM_FLAGS_REGISTERED;
+}
+
+static void free_dca_pages(void *pages)
+{
+	ib_umem_release(pages);
+}
+
+static void *alloc_dca_pages(struct hns_roce_dev *hr_dev, struct dca_mem *mem,
+			     struct dca_mem_attr *attr)
+{
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct ib_umem *umem;
+
+	umem = ib_umem_get(ibdev, attr->addr, attr->size, 0);
+	if (IS_ERR(umem)) {
+		ibdev_err(ibdev, "failed to get uDCA pages, ret = %ld.\n",
+			  PTR_ERR(umem));
+		return NULL;
+	}
+
+	mem->page_count = ib_umem_num_dma_blocks(umem, HNS_HW_PAGE_SIZE);
+
+	return umem;
+}
+
+static void free_dca_states(struct hns_dca_page_state *states)
+{
+	kfree(states);
+}
+
+static void init_dca_umem_states(struct hns_dca_page_state *states, int count,
+				 struct ib_umem *umem)
+{
+	struct ib_block_iter biter;
+	dma_addr_t cur_addr;
+	dma_addr_t pre_addr;
+	int i = 0;
+
+	pre_addr = 0;
+	rdma_for_each_block(umem->sg_head.sgl, &biter, umem->nmap,
+			    HNS_HW_PAGE_SIZE) {
+		cur_addr = rdma_block_iter_dma_address(&biter);
+		if (i < count) {
+			if (cur_addr - pre_addr != HNS_HW_PAGE_SIZE)
+				states[i].head = 1;
+		}
+
+		pre_addr = cur_addr;
+		i++;
+	}
+}
+
+static struct hns_dca_page_state *alloc_dca_states(void *pages, int count)
+{
+	struct hns_dca_page_state *states;
+
+	states = kcalloc(count, sizeof(*states), GFP_NOWAIT);
+	if (!states)
+		return NULL;
+
+	init_dca_umem_states(states, count, pages);
+
+	return states;
+}
+
+/* user DCA is managed by ucontext */
+static inline struct hns_roce_dca_ctx *
+to_hr_dca_ctx(struct hns_roce_ucontext *uctx)
+{
+	return &uctx->dca_ctx;
+}
+
+static void unregister_dca_mem(struct hns_roce_ucontext *uctx,
+			       struct dca_mem *mem)
+{
+	struct hns_roce_dca_ctx *ctx = to_hr_dca_ctx(uctx);
+	unsigned long flags;
+	void *states, *pages;
+
+	spin_lock_irqsave(&ctx->pool_lock, flags);
+
+	spin_lock(&mem->lock);
+	clr_dca_mem_registered(mem);
+	mem->page_count = 0;
+	pages = mem->pages;
+	mem->pages = NULL;
+	states = mem->states;
+	mem->states = NULL;
+	spin_unlock(&mem->lock);
+
+	ctx->free_mems--;
+	ctx->free_size -= mem->size;
+
+	ctx->total_size -= mem->size;
+	spin_unlock_irqrestore(&ctx->pool_lock, flags);
+
+	free_dca_states(states);
+	free_dca_pages(pages);
+}
+
+static int register_dca_mem(struct hns_roce_dev *hr_dev,
+			    struct hns_roce_ucontext *uctx,
+			    struct dca_mem *mem, struct dca_mem_attr *attr)
+{
+	struct hns_roce_dca_ctx *ctx = to_hr_dca_ctx(uctx);
+	void *states, *pages;
+	unsigned long flags;
+
+	pages = alloc_dca_pages(hr_dev, mem, attr);
+	if (!pages)
+		return -ENOMEM;
+
+	states = alloc_dca_states(pages, mem->page_count);
+	if (!states) {
+		free_dca_pages(pages);
+		return -ENOMEM;
+	}
+
+	spin_lock_irqsave(&ctx->pool_lock, flags);
+
+	spin_lock(&mem->lock);
+	mem->pages = pages;
+	mem->states = states;
+	mem->key = attr->key;
+	mem->size = attr->size;
+	set_dca_mem_registered(mem);
+	spin_unlock(&mem->lock);
+
+	ctx->free_mems++;
+	ctx->free_size += attr->size;
+	ctx->total_size += attr->size;
+	spin_unlock_irqrestore(&ctx->pool_lock, flags);
+
+	return 0;
+}
+
+static void init_dca_context(struct hns_roce_dca_ctx *ctx)
+{
+	INIT_LIST_HEAD(&ctx->pool);
+	spin_lock_init(&ctx->pool_lock);
+	ctx->total_size = 0;
+}
+
+static void cleanup_dca_context(struct hns_roce_dev *hr_dev,
+				struct hns_roce_dca_ctx *ctx)
+{
+	struct dca_mem *mem, *tmp;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctx->pool_lock, flags);
+	list_for_each_entry_safe(mem, tmp, &ctx->pool, list) {
+		list_del(&mem->list);
+		set_dca_mem_free(mem);
+		spin_unlock_irqrestore(&ctx->pool_lock, flags);
+
+		free_dca_states(mem->states);
+		free_dca_pages(mem->pages);
+		kfree(mem);
+
+		spin_lock_irqsave(&ctx->pool_lock, flags);
+	}
+	ctx->total_size = 0;
+	spin_unlock_irqrestore(&ctx->pool_lock, flags);
+}
+
+void hns_roce_register_udca(struct hns_roce_dev *hr_dev,
+			    struct hns_roce_ucontext *uctx)
+{
+	init_dca_context(&uctx->dca_ctx);
+}
+
+void hns_roce_unregister_udca(struct hns_roce_dev *hr_dev,
+			      struct hns_roce_ucontext *uctx)
+{
+	cleanup_dca_context(hr_dev, &uctx->dca_ctx);
+}
+
+static struct dca_mem *alloc_dca_mem(struct hns_roce_dca_ctx *ctx)
+{
+	struct dca_mem *mem, *tmp, *found = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctx->pool_lock, flags);
+	list_for_each_entry_safe(mem, tmp, &ctx->pool, list) {
+		spin_lock(&mem->lock);
+		if (dca_mem_is_free(mem)) {
+			found = mem;
+			set_dca_mem_alloced(mem);
+			spin_unlock(&mem->lock);
+			goto done;
+		}
+		spin_unlock(&mem->lock);
+	}
+
+done:
+	spin_unlock_irqrestore(&ctx->pool_lock, flags);
+
+	if (found)
+		return found;
+
+	mem = kzalloc(sizeof(*mem), GFP_NOWAIT);
+	if (!mem)
+		return NULL;
+
+	spin_lock_init(&mem->lock);
+	INIT_LIST_HEAD(&mem->list);
+
+	set_dca_mem_alloced(mem);
+
+	spin_lock_irqsave(&ctx->pool_lock, flags);
+	list_add(&mem->list, &ctx->pool);
+	spin_unlock_irqrestore(&ctx->pool_lock, flags);
+	return mem;
+}
+
+static void free_dca_mem(struct dca_mem *mem)
+{
+	/* We cannot hold the whole pool's lock during the DCA is working
+	 * until cleanup the context in cleanup_dca_context(), so we just
+	 * set the DCA mem state as free when destroying DCA mem object.
+	 */
+	spin_lock(&mem->lock);
+	set_dca_mem_free(mem);
+	spin_unlock(&mem->lock);
+}
+
+static inline struct hns_roce_ucontext *
+uverbs_attr_to_hr_uctx(struct uverbs_attr_bundle *attrs)
+{
+	return rdma_udata_to_drv_context(&attrs->driver_udata,
+					 struct hns_roce_ucontext, ibucontext);
+}
+
+static int UVERBS_HANDLER(HNS_IB_METHOD_DCA_MEM_REG)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct hns_roce_ucontext *uctx = uverbs_attr_to_hr_uctx(attrs);
+	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->ibucontext.device);
+	struct ib_uobject *uobj =
+		uverbs_attr_get_uobject(attrs, HNS_IB_ATTR_DCA_MEM_REG_HANDLE);
+	struct dca_mem_attr init_attr = {};
+	struct dca_mem *mem;
+	int ret;
+
+	if (uverbs_copy_from(&init_attr.addr, attrs,
+			     HNS_IB_ATTR_DCA_MEM_REG_ADDR) ||
+	    uverbs_copy_from(&init_attr.size, attrs,
+			     HNS_IB_ATTR_DCA_MEM_REG_LEN) ||
+	    uverbs_copy_from(&init_attr.key, attrs,
+			     HNS_IB_ATTR_DCA_MEM_REG_KEY))
+		return -EFAULT;
+
+	mem = alloc_dca_mem(to_hr_dca_ctx(uctx));
+	if (!mem)
+		return -ENOMEM;
+
+	ret = register_dca_mem(hr_dev, uctx, mem, &init_attr);
+	if (ret) {
+		free_dca_mem(mem);
+		return ret;
+	}
+
+	uobj->object = mem;
+
+	return 0;
+}
+
+static int dca_cleanup(struct ib_uobject *uobject, enum rdma_remove_reason why,
+		       struct uverbs_attr_bundle *attrs)
+{
+	struct hns_roce_ucontext *uctx = uverbs_attr_to_hr_uctx(attrs);
+	struct dca_mem *mem;
+
+	/* One DCA MEM maybe shared by many QPs, so the DCA mem uobject must
+	 * be destroyed before all QP uobjects, and we will destroy the DCA
+	 * uobjects when cleanup DCA context by calling hns_roce_cleanup_dca().
+	 */
+	if (why == RDMA_REMOVE_CLOSE || why == RDMA_REMOVE_DRIVER_REMOVE)
+		return 0;
+
+	mem = uobject->object;
+	unregister_dca_mem(uctx, mem);
+	free_dca_mem(mem);
+
+	return 0;
+}
+
+DECLARE_UVERBS_NAMED_METHOD(
+	HNS_IB_METHOD_DCA_MEM_REG,
+	UVERBS_ATTR_IDR(HNS_IB_ATTR_DCA_MEM_REG_HANDLE, HNS_IB_OBJECT_DCA_MEM,
+			UVERBS_ACCESS_NEW, UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(HNS_IB_ATTR_DCA_MEM_REG_LEN, UVERBS_ATTR_TYPE(u32),
+			   UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(HNS_IB_ATTR_DCA_MEM_REG_ADDR, UVERBS_ATTR_TYPE(u64),
+			   UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(HNS_IB_ATTR_DCA_MEM_REG_KEY, UVERBS_ATTR_TYPE(u64),
+			   UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_METHOD_DESTROY(
+	HNS_IB_METHOD_DCA_MEM_DEREG,
+	UVERBS_ATTR_IDR(HNS_IB_ATTR_DCA_MEM_DEREG_HANDLE, HNS_IB_OBJECT_DCA_MEM,
+			UVERBS_ACCESS_DESTROY, UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_OBJECT(HNS_IB_OBJECT_DCA_MEM,
+			    UVERBS_TYPE_ALLOC_IDR(dca_cleanup),
+			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_REG),
+			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_DEREG));
+
+static bool dca_is_supported(struct ib_device *device)
+{
+	struct hns_roce_dev *dev = to_hr_dev(device);
+
+	return dev->caps.flags & HNS_ROCE_CAP_FLAG_DCA_MODE;
+}
+
+const struct uapi_definition hns_roce_dca_uapi_defs[] = {
+	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(
+		HNS_IB_OBJECT_DCA_MEM,
+		UAPI_DEF_IS_OBJ_SUPPORTED(dca_is_supported)),
+	{}
+};
diff --git a/drivers/infiniband/hw/hns/hns_roce_dca.h b/drivers/infiniband/hw/hns/hns_roce_dca.h
new file mode 100644
index 0000000..cb3481f
--- /dev/null
+++ b/drivers/infiniband/hw/hns/hns_roce_dca.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/*
+ * Copyright (c) 2021 Hisilicon Limited. All rights reserved.
+ */
+
+#ifndef __HNS_ROCE_DCA_H
+#define __HNS_ROCE_DCA_H
+
+/* DCA page state (32 bit) */
+struct hns_dca_page_state {
+	u32 buf_id : 29; /* If zero, means page can be used by any buffer. */
+	u32 lock : 1; /* @buf_id locked this page to prepare access. */
+	u32 active : 1; /* @buf_id is accessing this page. */
+	u32 head : 1; /* This page is the head in a continuous address range. */
+};
+
+void hns_roce_register_udca(struct hns_roce_dev *hr_dev,
+			    struct hns_roce_ucontext *uctx);
+void hns_roce_unregister_udca(struct hns_roce_dev *hr_dev,
+			      struct hns_roce_ucontext *uctx);
+
+#endif
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 97800d2..28fe33f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -230,11 +230,20 @@ struct hns_roce_uar {
 	unsigned long	logic_idx;
 };
 
+struct hns_roce_dca_ctx {
+	struct list_head pool; /* all DCA mems link to @pool */
+	spinlock_t pool_lock; /* protect @pool */
+	unsigned int free_mems; /* free mem num in pool */
+	size_t free_size; /* free mem size in pool */
+	size_t total_size; /* total size in pool */
+};
+
 struct hns_roce_ucontext {
 	struct ib_ucontext	ibucontext;
 	struct hns_roce_uar	uar;
 	struct list_head	page_list;
 	struct mutex		page_mutex;
+	struct hns_roce_dca_ctx	dca_ctx;
 };
 
 struct hns_roce_pd {
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 6c6e82b..8c613cf 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -37,10 +37,12 @@
 #include <rdma/ib_addr.h>
 #include <rdma/ib_smi.h>
 #include <rdma/ib_user_verbs.h>
+#include <rdma/uverbs_ioctl.h>
 #include <rdma/ib_cache.h>
 #include "hns_roce_common.h"
 #include "hns_roce_device.h"
 #include "hns_roce_hem.h"
+#include "hns_roce_dca.h"
 
 static int hns_roce_set_mac(struct hns_roce_dev *hr_dev, u32 port, u8 *addr)
 {
@@ -294,16 +296,17 @@ static int hns_roce_modify_device(struct ib_device *ib_dev, int mask,
 static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 				   struct ib_udata *udata)
 {
-	int ret;
 	struct hns_roce_ucontext *context = to_hr_ucontext(uctx);
-	struct hns_roce_ib_alloc_ucontext_resp resp = {};
 	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->device);
+	struct hns_roce_ib_alloc_ucontext_resp resp = {};
+	int ret;
 
 	if (!hr_dev->active)
 		return -EAGAIN;
 
 	resp.qp_tab_size = hr_dev->caps.num_qps;
 	resp.srq_tab_size = hr_dev->caps.num_srqs;
+	resp.cap_flags = hr_dev->caps.flags;
 
 	ret = hns_roce_uar_alloc(hr_dev, &context->uar);
 	if (ret)
@@ -315,6 +318,9 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 		mutex_init(&context->page_mutex);
 	}
 
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_DCA_MODE)
+		hns_roce_register_udca(hr_dev, context);
+
 	resp.cqe_size = hr_dev->caps.cqe_sz;
 
 	ret = ib_copy_to_udata(udata, &resp,
@@ -325,6 +331,9 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 	return 0;
 
 error_fail_copy_to_udata:
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_DCA_MODE)
+		hns_roce_unregister_udca(hr_dev, context);
+
 	hns_roce_uar_free(hr_dev, &context->uar);
 
 error_fail_uar_alloc:
@@ -334,8 +343,12 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 static void hns_roce_dealloc_ucontext(struct ib_ucontext *ibcontext)
 {
 	struct hns_roce_ucontext *context = to_hr_ucontext(ibcontext);
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibcontext->device);
 
 	hns_roce_uar_free(to_hr_dev(ibcontext->device), &context->uar);
+
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_DCA_MODE)
+		hns_roce_unregister_udca(hr_dev, context);
 }
 
 static int hns_roce_mmap(struct ib_ucontext *context,
@@ -417,6 +430,12 @@ static void hns_roce_unregister_device(struct hns_roce_dev *hr_dev)
 	ib_unregister_device(&hr_dev->ib_dev);
 }
 
+extern const struct uapi_definition hns_roce_dca_uapi_defs[];
+static const struct uapi_definition hns_roce_uapi_defs[] = {
+	UAPI_DEF_CHAIN(hns_roce_dca_uapi_defs),
+	{}
+};
+
 static const struct ib_device_ops hns_roce_dev_ops = {
 	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_HNS,
@@ -526,6 +545,10 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 
 	ib_set_device_ops(ib_dev, hr_dev->hw->hns_roce_dev_ops);
 	ib_set_device_ops(ib_dev, &hns_roce_dev_ops);
+
+	if (IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS))
+		ib_dev->driver_def = hns_roce_uapi_defs;
+
 	for (i = 0; i < hr_dev->caps.num_ports; i++) {
 		if (!hr_dev->iboe.netdevs[i])
 			continue;
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index 42b1776..c17ec91 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -83,15 +83,42 @@ struct hns_roce_ib_create_qp_resp {
 	__aligned_u64 cap_flags;
 };
 
+enum {
+	HNS_ROCE_CAP_FLAG_DCA_MODE = 1 << 15,
+};
+
 struct hns_roce_ib_alloc_ucontext_resp {
 	__u32	qp_tab_size;
 	__u32	cqe_size;
 	__u32	srq_tab_size;
 	__u32	reserved;
+	__aligned_u64 cap_flags;
 };
 
 struct hns_roce_ib_alloc_pd_resp {
 	__u32 pdn;
 };
 
+#define UVERBS_ID_NS_MASK 0xF000
+#define UVERBS_ID_NS_SHIFT 12
+
+enum hns_ib_objects {
+	HNS_IB_OBJECT_DCA_MEM = (1U << UVERBS_ID_NS_SHIFT),
+};
+
+enum hns_ib_dca_mem_methods {
+	HNS_IB_METHOD_DCA_MEM_REG = (1U << UVERBS_ID_NS_SHIFT),
+	HNS_IB_METHOD_DCA_MEM_DEREG,
+};
+
+enum hns_ib_dca_mem_reg_attrs {
+	HNS_IB_ATTR_DCA_MEM_REG_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+	HNS_IB_ATTR_DCA_MEM_REG_LEN,
+	HNS_IB_ATTR_DCA_MEM_REG_ADDR,
+	HNS_IB_ATTR_DCA_MEM_REG_KEY,
+};
+
+enum hns_ib_dca_mem_dereg_attrs {
+	HNS_IB_ATTR_DCA_MEM_DEREG_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+};
 #endif /* HNS_ABI_USER_H */
-- 
2.7.4

