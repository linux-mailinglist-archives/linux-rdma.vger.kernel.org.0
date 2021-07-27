Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811B43D6CB8
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 05:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbhG0Cup (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Jul 2021 22:50:45 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7436 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbhG0Cuo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Jul 2021 22:50:44 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GYj0H0lPVz80fF;
        Tue, 27 Jul 2021 11:27:27 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 11:31:07 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 11:31:06 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>, Xi Wang <wangxi11@huawei.com>
Subject: [PATCH v3 for-next 02/12] RDMA/hns: Add method for shrinking DCA memory pool
Date:   Tue, 27 Jul 2021 11:27:22 +0800
Message-ID: <1627356452-30564-3-git-send-email-liangwenpeng@huawei.com>
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

If no QP is using a DCA mem object, the userspace driver can destroy it.
So add a new method 'HNS_IB_METHOD_DCA_MEM_SHRINK' to allow the userspace
dirver to remove an object from DCA memory pool.

If a DCA mem object has been shrunk, the userspace driver can destroy it
by 'HNS_IB_METHOD_DCA_MEM_DEREG' method and free the buffer which is
allocated in userspace.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_dca.c | 136 ++++++++++++++++++++++++++++++-
 drivers/infiniband/hw/hns/hns_roce_dca.h |   7 ++
 include/uapi/rdma/hns-abi.h              |   9 ++
 3 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_dca.c b/drivers/infiniband/hw/hns/hns_roce_dca.c
index a2de48c8..81b3c58 100644
--- a/drivers/infiniband/hw/hns/hns_roce_dca.c
+++ b/drivers/infiniband/hw/hns/hns_roce_dca.c
@@ -35,6 +35,10 @@ struct dca_mem_attr {
 	u32 size;
 };
 
+#define dca_page_is_free(s) ((s)->buf_id == HNS_DCA_INVALID_BUF_ID)
+#define dca_mem_is_available(m) \
+	((m)->flags == (DCA_MEM_FLAGS_ALLOCED | DCA_MEM_FLAGS_REGISTERED))
+
 static void *alloc_dca_pages(struct hns_roce_dev *hr_dev, struct dca_mem *mem,
 			     struct dca_mem_attr *attr)
 {
@@ -89,6 +93,41 @@ static struct hns_dca_page_state *alloc_dca_states(void *pages, int count)
 	return states;
 }
 
+#define DCA_MEM_STOP_ITERATE -1
+#define DCA_MEM_NEXT_ITERATE -2
+static void travel_dca_pages(struct hns_roce_dca_ctx *ctx, void *param,
+			     int (*cb)(struct dca_mem *, int, void *))
+{
+	struct dca_mem *mem, *tmp;
+	unsigned long flags;
+	bool avail;
+	int ret;
+	int i;
+
+	spin_lock_irqsave(&ctx->pool_lock, flags);
+	list_for_each_entry_safe(mem, tmp, &ctx->pool, list) {
+		spin_unlock_irqrestore(&ctx->pool_lock, flags);
+
+		spin_lock(&mem->lock);
+		avail = dca_mem_is_available(mem);
+		ret = 0;
+		for (i = 0; avail && i < mem->page_count; i++) {
+			ret = cb(mem, i, param);
+			if (ret == DCA_MEM_STOP_ITERATE ||
+			    ret == DCA_MEM_NEXT_ITERATE)
+				break;
+		}
+		spin_unlock(&mem->lock);
+		spin_lock_irqsave(&ctx->pool_lock, flags);
+
+		if (ret == DCA_MEM_STOP_ITERATE)
+			goto done;
+	}
+
+done:
+	spin_unlock_irqrestore(&ctx->pool_lock, flags);
+}
+
 /* user DCA is managed by ucontext */
 #define to_hr_dca_ctx(uctx) (&(uctx)->dca_ctx)
 
@@ -156,6 +195,63 @@ static int register_dca_mem(struct hns_roce_dev *hr_dev,
 	return 0;
 }
 
+struct dca_mem_shrink_attr {
+	u64 shrink_key;
+	u32 shrink_mems;
+};
+
+static int shrink_dca_page_proc(struct dca_mem *mem, int index, void *param)
+{
+	struct dca_mem_shrink_attr *attr = param;
+	struct hns_dca_page_state *state;
+	int i, free_pages;
+
+	free_pages = 0;
+	for (i = 0; i < mem->page_count; i++) {
+		state = &mem->states[i];
+		if (dca_page_is_free(state))
+			free_pages++;
+	}
+
+	/* No pages are in use */
+	if (free_pages == mem->page_count) {
+		/* unregister first empty DCA mem */
+		if (!attr->shrink_mems) {
+			mem->flags &= ~DCA_MEM_FLAGS_REGISTERED;
+			attr->shrink_key = mem->key;
+		}
+
+		attr->shrink_mems++;
+	}
+
+	if (attr->shrink_mems > 1)
+		return DCA_MEM_STOP_ITERATE;
+	else
+		return DCA_MEM_NEXT_ITERATE;
+}
+
+static int shrink_dca_mem(struct hns_roce_dev *hr_dev,
+			  struct hns_roce_ucontext *uctx, u64 reserved_size,
+			  struct hns_dca_shrink_resp *resp)
+{
+	struct hns_roce_dca_ctx *ctx = to_hr_dca_ctx(uctx);
+	struct dca_mem_shrink_attr attr = {};
+	unsigned long flags;
+	bool need_shink;
+
+	spin_lock_irqsave(&ctx->pool_lock, flags);
+	need_shink = ctx->free_mems > 0 && ctx->free_size > reserved_size;
+	spin_unlock_irqrestore(&ctx->pool_lock, flags);
+	if (!need_shink)
+		return 0;
+
+	travel_dca_pages(ctx, &attr, shrink_dca_page_proc);
+	resp->free_mems = attr.shrink_mems;
+	resp->free_key = attr.shrink_key;
+
+	return 0;
+}
+
 static void init_dca_context(struct hns_roce_dca_ctx *ctx)
 {
 	INIT_LIST_HEAD(&ctx->pool);
@@ -323,10 +419,48 @@ DECLARE_UVERBS_NAMED_METHOD_DESTROY(
 	UVERBS_ATTR_IDR(HNS_IB_ATTR_DCA_MEM_DEREG_HANDLE, HNS_IB_OBJECT_DCA_MEM,
 			UVERBS_ACCESS_DESTROY, UA_MANDATORY));
 
+static int UVERBS_HANDLER(HNS_IB_METHOD_DCA_MEM_SHRINK)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct hns_roce_ucontext *uctx = uverbs_attr_to_hr_uctx(attrs);
+	struct hns_dca_shrink_resp resp = {};
+	u64 reserved_size = 0;
+	int ret;
+
+	if (uverbs_copy_from(&reserved_size, attrs,
+			     HNS_IB_ATTR_DCA_MEM_SHRINK_RESERVED_SIZE))
+		return -EFAULT;
+
+	ret = shrink_dca_mem(to_hr_dev(uctx->ibucontext.device), uctx,
+			     reserved_size, &resp);
+	if (ret)
+		return ret;
+
+	if (uverbs_copy_to(attrs, HNS_IB_ATTR_DCA_MEM_SHRINK_OUT_FREE_KEY,
+			   &resp.free_key, sizeof(resp.free_key)) ||
+	    uverbs_copy_to(attrs, HNS_IB_ATTR_DCA_MEM_SHRINK_OUT_FREE_MEMS,
+			   &resp.free_mems, sizeof(resp.free_mems)))
+		return -EFAULT;
+
+	return 0;
+}
+
+DECLARE_UVERBS_NAMED_METHOD(
+	HNS_IB_METHOD_DCA_MEM_SHRINK,
+	UVERBS_ATTR_IDR(HNS_IB_ATTR_DCA_MEM_SHRINK_HANDLE,
+			HNS_IB_OBJECT_DCA_MEM, UVERBS_ACCESS_WRITE,
+			UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(HNS_IB_ATTR_DCA_MEM_SHRINK_RESERVED_SIZE,
+			   UVERBS_ATTR_TYPE(u64), UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(HNS_IB_ATTR_DCA_MEM_SHRINK_OUT_FREE_KEY,
+			    UVERBS_ATTR_TYPE(u64), UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(HNS_IB_ATTR_DCA_MEM_SHRINK_OUT_FREE_MEMS,
+			    UVERBS_ATTR_TYPE(u32), UA_MANDATORY));
 DECLARE_UVERBS_NAMED_OBJECT(HNS_IB_OBJECT_DCA_MEM,
 			    UVERBS_TYPE_ALLOC_IDR(dca_cleanup),
 			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_REG),
-			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_DEREG));
+			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_DEREG),
+			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_SHRINK));
 
 static bool dca_is_supported(struct ib_device *device)
 {
diff --git a/drivers/infiniband/hw/hns/hns_roce_dca.h b/drivers/infiniband/hw/hns/hns_roce_dca.h
index aad198c..a82ed5e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_dca.h
+++ b/drivers/infiniband/hw/hns/hns_roce_dca.h
@@ -14,6 +14,13 @@ struct hns_dca_page_state {
 	u32 head : 1; /* This page is the head in a continuous address range. */
 };
 
+struct hns_dca_shrink_resp {
+	u64 free_key; /* free buffer's key which registered by the user */
+	u32 free_mems; /* free buffer count which no any QP be using */
+};
+
+#define HNS_DCA_INVALID_BUF_ID 0UL
+
 void hns_roce_register_udca(struct hns_roce_dev *hr_dev,
 			    struct hns_roce_ucontext *uctx);
 void hns_roce_unregister_udca(struct hns_roce_dev *hr_dev,
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index c17ec91..bcca5be 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -109,6 +109,7 @@ enum hns_ib_objects {
 enum hns_ib_dca_mem_methods {
 	HNS_IB_METHOD_DCA_MEM_REG = (1U << UVERBS_ID_NS_SHIFT),
 	HNS_IB_METHOD_DCA_MEM_DEREG,
+	HNS_IB_METHOD_DCA_MEM_SHRINK,
 };
 
 enum hns_ib_dca_mem_reg_attrs {
@@ -121,4 +122,12 @@ enum hns_ib_dca_mem_reg_attrs {
 enum hns_ib_dca_mem_dereg_attrs {
 	HNS_IB_ATTR_DCA_MEM_DEREG_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
 };
+
+enum hns_ib_dca_mem_shrink_attrs {
+	HNS_IB_ATTR_DCA_MEM_SHRINK_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+	HNS_IB_ATTR_DCA_MEM_SHRINK_RESERVED_SIZE,
+	HNS_IB_ATTR_DCA_MEM_SHRINK_OUT_FREE_KEY,
+	HNS_IB_ATTR_DCA_MEM_SHRINK_OUT_FREE_MEMS,
+};
+
 #endif /* HNS_ABI_USER_H */
-- 
2.8.1

