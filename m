Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0727937A5A6
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 13:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhEKLYA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 07:24:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2622 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhEKLX6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 May 2021 07:23:58 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ffb6S3gcFzPx19;
        Tue, 11 May 2021 19:19:28 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Tue, 11 May 2021 19:22:43 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, "Xi Wang" <wangxi11@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH v2 for-next 7/7] RDMA/hns: Add method to query WQE buffer's address
Date:   Tue, 11 May 2021 19:22:41 +0800
Message-ID: <1620732161-27180-8-git-send-email-liweihang@huawei.com>
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

If a uQP works in DCA mode, the userspace driver need to get the buffer's
address in DCA memory pool by calling the 'HNS_IB_METHOD_DCA_MEM_QUERY'
method after the QP was attached by calling the
'HNS_IB_METHOD_DCA_MEM_ATTACH' method.

This method will return the DCA mem object's key and the offset to let the
userspace driver get the WQE's virtual address in DCA memory pool.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_dca.c | 112 ++++++++++++++++++++++++++++++-
 drivers/infiniband/hw/hns/hns_roce_dca.h |   6 ++
 include/uapi/rdma/hns-abi.h              |  10 +++
 3 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_dca.c b/drivers/infiniband/hw/hns/hns_roce_dca.c
index 334b55f..6dcd8c4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_dca.c
+++ b/drivers/infiniband/hw/hns/hns_roce_dca.c
@@ -80,6 +80,14 @@ static inline bool dca_page_is_attached(struct hns_dca_page_state *state,
 			(HNS_DCA_OWN_MASK & state->buf_id);
 }
 
+static inline bool dca_page_is_active(struct hns_dca_page_state *state,
+				      u32 buf_id)
+{
+	/* all buf id bits must be matched */
+	return (HNS_DCA_ID_MASK & buf_id) == state->buf_id &&
+		!state->lock && state->active;
+}
+
 static inline bool dca_page_is_allocated(struct hns_dca_page_state *state,
 					 u32 buf_id)
 {
@@ -792,6 +800,64 @@ static int attach_dca_mem(struct hns_roce_dev *hr_dev,
 	return 0;
 }
 
+struct dca_page_query_active_attr {
+	u32 buf_id;
+	u32 curr_index;
+	u32 start_index;
+	u32 page_index;
+	u32 page_count;
+	u64 mem_key;
+};
+
+static int query_dca_active_pages_proc(struct dca_mem *mem, int index,
+				       void *param)
+{
+	struct hns_dca_page_state *state = &mem->states[index];
+	struct dca_page_query_active_attr *attr = param;
+
+	if (!dca_page_is_active(state, attr->buf_id))
+		return 0;
+
+	if (attr->curr_index < attr->start_index) {
+		attr->curr_index++;
+		return 0;
+	} else if (attr->curr_index > attr->start_index) {
+		return DCA_MEM_STOP_ITERATE;
+	}
+
+	/* Search first page in DCA mem */
+	attr->page_index = index;
+	attr->mem_key = mem->key;
+	/* Search active pages in continuous addresses */
+	while (index < mem->page_count) {
+		state = &mem->states[index];
+		if (!dca_page_is_active(state, attr->buf_id))
+			break;
+
+		index++;
+		attr->page_count++;
+	}
+
+	return DCA_MEM_STOP_ITERATE;
+}
+
+static int query_dca_mem(struct hns_roce_qp *hr_qp, u32 page_index,
+			 struct hns_dca_query_resp *resp)
+{
+	struct hns_roce_dca_ctx *ctx = hr_qp_to_dca_ctx(hr_qp);
+	struct dca_page_query_active_attr attr = {};
+
+	attr.buf_id = hr_qp->dca_cfg.buf_id;
+	attr.start_index = page_index;
+	travel_dca_pages(ctx, &attr, query_dca_active_pages_proc);
+
+	resp->mem_key = attr.mem_key;
+	resp->mem_ofs = attr.page_index << HNS_HW_PAGE_SHIFT;
+	resp->page_count = attr.page_count;
+
+	return attr.page_count ? 0 : -ENOMEM;
+}
+
 struct dca_page_free_buf_attr {
 	u32 buf_id;
 	u32 max_pages;
@@ -1129,13 +1195,57 @@ DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_ATTR_PTR_IN(HNS_IB_ATTR_DCA_MEM_DETACH_SQ_INDEX,
 			   UVERBS_ATTR_TYPE(u32), UA_MANDATORY));
 
+static int UVERBS_HANDLER(HNS_IB_METHOD_DCA_MEM_QUERY)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct hns_roce_qp *hr_qp = uverbs_attr_to_hr_qp(attrs);
+	struct hns_dca_query_resp resp = {};
+	u32 page_idx;
+	int ret;
+
+	if (!hr_qp)
+		return -EINVAL;
+
+	if (uverbs_copy_from(&page_idx, attrs,
+			     HNS_IB_ATTR_DCA_MEM_QUERY_PAGE_INDEX))
+		return -EFAULT;
+
+	ret = query_dca_mem(hr_qp, page_idx, &resp);
+	if (ret)
+		return ret;
+
+	if (uverbs_copy_to(attrs, HNS_IB_ATTR_DCA_MEM_QUERY_OUT_KEY,
+			   &resp.mem_key, sizeof(resp.mem_key)) ||
+	    uverbs_copy_to(attrs, HNS_IB_ATTR_DCA_MEM_QUERY_OUT_OFFSET,
+			   &resp.mem_ofs, sizeof(resp.mem_ofs)) ||
+	    uverbs_copy_to(attrs, HNS_IB_ATTR_DCA_MEM_QUERY_OUT_PAGE_COUNT,
+			   &resp.page_count, sizeof(resp.page_count)))
+		return -EFAULT;
+
+	return 0;
+}
+
+DECLARE_UVERBS_NAMED_METHOD(
+	HNS_IB_METHOD_DCA_MEM_QUERY,
+	UVERBS_ATTR_IDR(HNS_IB_ATTR_DCA_MEM_QUERY_HANDLE, UVERBS_OBJECT_QP,
+			UVERBS_ACCESS_READ, UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(HNS_IB_ATTR_DCA_MEM_QUERY_PAGE_INDEX,
+			   UVERBS_ATTR_TYPE(u32), UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(HNS_IB_ATTR_DCA_MEM_QUERY_OUT_KEY,
+			    UVERBS_ATTR_TYPE(u64), UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(HNS_IB_ATTR_DCA_MEM_QUERY_OUT_OFFSET,
+			    UVERBS_ATTR_TYPE(u32), UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(HNS_IB_ATTR_DCA_MEM_QUERY_OUT_PAGE_COUNT,
+			    UVERBS_ATTR_TYPE(u32), UA_MANDATORY));
+
 DECLARE_UVERBS_NAMED_OBJECT(HNS_IB_OBJECT_DCA_MEM,
 			    UVERBS_TYPE_ALLOC_IDR(dca_cleanup),
 			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_REG),
 			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_DEREG),
 			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_SHRINK),
 			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_ATTACH),
-			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_DETACH));
+			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_DETACH),
+			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_QUERY));
 
 static bool dca_is_supported(struct ib_device *device)
 {
diff --git a/drivers/infiniband/hw/hns/hns_roce_dca.h b/drivers/infiniband/hw/hns/hns_roce_dca.h
index 00f30ce..807a1aa 100644
--- a/drivers/infiniband/hw/hns/hns_roce_dca.h
+++ b/drivers/infiniband/hw/hns/hns_roce_dca.h
@@ -50,6 +50,12 @@ struct hns_dca_detach_attr {
 	u32 sq_idx;
 };
 
+struct hns_dca_query_resp {
+	u64 mem_key;
+	u32 mem_ofs;
+	u32 page_count;
+};
+
 void hns_roce_register_udca(struct hns_roce_dev *hr_dev,
 			    struct hns_roce_ucontext *uctx);
 void hns_roce_unregister_udca(struct hns_roce_dev *hr_dev,
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index 119fa4e..edcecc1 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -113,6 +113,7 @@ enum hns_ib_dca_mem_methods {
 	HNS_IB_METHOD_DCA_MEM_SHRINK,
 	HNS_IB_METHOD_DCA_MEM_ATTACH,
 	HNS_IB_METHOD_DCA_MEM_DETACH,
+	HNS_IB_METHOD_DCA_MEM_QUERY,
 };
 
 enum hns_ib_dca_mem_reg_attrs {
@@ -148,4 +149,13 @@ enum hns_ib_dca_mem_detach_attrs {
 	HNS_IB_ATTR_DCA_MEM_DETACH_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
 	HNS_IB_ATTR_DCA_MEM_DETACH_SQ_INDEX,
 };
+
+enum hns_ib_dca_mem_query_attrs {
+	HNS_IB_ATTR_DCA_MEM_QUERY_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+	HNS_IB_ATTR_DCA_MEM_QUERY_PAGE_INDEX,
+	HNS_IB_ATTR_DCA_MEM_QUERY_OUT_KEY,
+	HNS_IB_ATTR_DCA_MEM_QUERY_OUT_OFFSET,
+	HNS_IB_ATTR_DCA_MEM_QUERY_OUT_PAGE_COUNT,
+};
+
 #endif /* HNS_ABI_USER_H */
-- 
2.7.4

