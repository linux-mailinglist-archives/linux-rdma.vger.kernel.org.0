Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC5E41D594
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 10:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348188AbhI3ImH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 04:42:07 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13008 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348201AbhI3ImG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 04:42:06 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HKmqp5mr7zWZCk;
        Thu, 30 Sep 2021 16:39:02 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 16:40:19 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 16:40:18 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 1/1] RDMA/hns: Add a new mmap implementation
Date:   Thu, 30 Sep 2021 16:36:08 +0800
Message-ID: <20210930083608.18981-2-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210930083608.18981-1-liangwenpeng@huawei.com>
References: <20210930083608.18981-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Chengchang Tang <tangchengchang@huawei.com>

Add a new implementation for mmap by using the new mmap entry API.

The new implementation prepares for subsequent features and is compatible
with the old implementation. And the old implementation using hard-coded
offset will not be extended in the future.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  21 +++
 drivers/infiniband/hw/hns/hns_roce_main.c   | 148 +++++++++++++++++++-
 include/uapi/rdma/hns-abi.h                 |  21 ++-
 3 files changed, 184 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 9467c39e3d28..ca456948b2d8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -225,11 +225,23 @@ struct hns_roce_uar {
 	unsigned long	logic_idx;
 };
 
+struct hns_user_mmap_entry {
+	struct rdma_user_mmap_entry rdma_entry;
+	u64 address;
+	u8 mmap_flag;
+};
+
+enum hns_roce_mmap_type {
+	HNS_ROCE_MMAP_TYPE_DB = 1,
+};
+
 struct hns_roce_ucontext {
 	struct ib_ucontext	ibucontext;
 	struct hns_roce_uar	uar;
 	struct list_head	page_list;
 	struct mutex		page_mutex;
+	bool			mmap_key_support;
+	struct rdma_user_mmap_entry *db_mmap_entry;
 };
 
 struct hns_roce_pd {
@@ -1049,6 +1061,12 @@ static inline struct hns_roce_srq *to_hr_srq(struct ib_srq *ibsrq)
 	return container_of(ibsrq, struct hns_roce_srq, ibsrq);
 }
 
+static inline struct hns_user_mmap_entry *to_hns_mmap(
+		struct rdma_user_mmap_entry *rdma_entry)
+{
+	return container_of(rdma_entry, struct hns_user_mmap_entry, rdma_entry);
+}
+
 static inline void hns_roce_write64_k(__le32 val[2], void __iomem *dest)
 {
 	writeq(*(u64 *)val, dest);
@@ -1259,4 +1277,7 @@ int hns_roce_init(struct hns_roce_dev *hr_dev);
 void hns_roce_exit(struct hns_roce_dev *hr_dev);
 int hns_roce_fill_res_cq_entry(struct sk_buff *msg,
 			       struct ib_cq *ib_cq);
+struct rdma_user_mmap_entry *hns_roce_user_mmap_entry_insert(
+		struct ib_ucontext *ucontext, u64 address,
+		size_t length, u8 mmap_flag);
 #endif /* _HNS_ROCE_DEVICE_H */
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 5d39bd08582a..029dcefecf82 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -291,6 +291,81 @@ static int hns_roce_modify_device(struct ib_device *ib_dev, int mask,
 	return 0;
 }
 
+struct rdma_user_mmap_entry *hns_roce_user_mmap_entry_insert(
+			struct ib_ucontext *ucontext, u64 address,
+			size_t length, u8 mmap_flag)
+{
+	struct hns_user_mmap_entry *entry;
+	int ret;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return NULL;
+
+	entry->address = address;
+	entry->mmap_flag = mmap_flag;
+
+	ret = rdma_user_mmap_entry_insert(ucontext, &entry->rdma_entry, length);
+	if (ret) {
+		kfree(entry);
+		return NULL;
+	}
+
+	return &entry->rdma_entry;
+}
+
+static void hns_roce_dealloc_uar_entry(struct hns_roce_ucontext *context)
+{
+	if (!context->mmap_key_support)
+		return;
+
+	rdma_user_mmap_entry_remove(context->db_mmap_entry);
+}
+
+static int hns_roce_alloc_uar_entry(struct ib_ucontext *uctx)
+{
+	struct hns_roce_ucontext *context = to_hr_ucontext(uctx);
+	u64 address;
+
+	if (!context->mmap_key_support)
+		return 0;
+
+	address = context->uar.pfn << PAGE_SHIFT;
+	context->db_mmap_entry =
+		hns_roce_user_mmap_entry_insert(uctx, address, PAGE_SIZE,
+						HNS_ROCE_MMAP_TYPE_DB);
+	if (!context->db_mmap_entry)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void ucontext_get_config(struct hns_roce_ucontext *context,
+				struct hns_roce_ib_alloc_ucontext *ucmd)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(context->ibucontext.device);
+
+	if (ucmd->comp & HNS_ROCE_ALLOC_UCTX_COMP_CONFIG &&
+	    hr_dev->hw_rev != HNS_ROCE_HW_VER1)
+		context->mmap_key_support = !!(ucmd->config &
+					       HNS_ROCE_UCTX_REQ_MMAP_KEY_EN);
+}
+
+static void ucontext_set_resp(struct hns_roce_ucontext *context,
+			      struct hns_roce_ib_alloc_ucontext_resp *resp)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(context->ibucontext.device);
+
+	resp->qp_tab_size = hr_dev->caps.num_qps;
+	resp->cqe_size = hr_dev->caps.cqe_sz;
+	resp->srq_tab_size = hr_dev->caps.num_srqs;
+	if (context->mmap_key_support) {
+		resp->config |= HNS_ROCE_UCTX_RESP_MMAP_KEY_EN;
+		resp->db_mmap_key =
+			rdma_user_mmap_get_offset(context->db_mmap_entry);
+	}
+}
+
 static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 				   struct ib_udata *udata)
 {
@@ -298,24 +373,35 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 	struct hns_roce_ucontext *context = to_hr_ucontext(uctx);
 	struct hns_roce_ib_alloc_ucontext_resp resp = {};
 	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->device);
+	struct hns_roce_ib_alloc_ucontext ucmd = {};
 
 	if (!hr_dev->active)
 		return -EAGAIN;
 
-	resp.qp_tab_size = hr_dev->caps.num_qps;
-	resp.srq_tab_size = hr_dev->caps.num_srqs;
+	if (udata->inlen) {
+		ret = ib_copy_from_udata(&ucmd, udata,
+					 min(udata->inlen, sizeof(ucmd)));
+		if (ret)
+			return ret;
+	}
+
+	ucontext_get_config(context, &ucmd);
 
 	ret = hns_roce_uar_alloc(hr_dev, &context->uar);
 	if (ret)
 		goto error_fail_uar_alloc;
 
+	ret = hns_roce_alloc_uar_entry(uctx);
+	if (ret)
+		goto error_fail_uar_entry;
+
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
 	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB) {
 		INIT_LIST_HEAD(&context->page_list);
 		mutex_init(&context->page_mutex);
 	}
 
-	resp.cqe_size = hr_dev->caps.cqe_sz;
+	ucontext_set_resp(context, &resp);
 
 	ret = ib_copy_to_udata(udata, &resp,
 			       min(udata->outlen, sizeof(resp)));
@@ -325,6 +411,9 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 	return 0;
 
 error_fail_copy_to_udata:
+	hns_roce_dealloc_uar_entry(context);
+
+error_fail_uar_entry:
 	ida_free(&hr_dev->uar_ida.ida, (int)context->uar.logic_idx);
 
 error_fail_uar_alloc:
@@ -336,11 +425,13 @@ static void hns_roce_dealloc_ucontext(struct ib_ucontext *ibcontext)
 	struct hns_roce_ucontext *context = to_hr_ucontext(ibcontext);
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibcontext->device);
 
+	hns_roce_dealloc_uar_entry(context);
+
 	ida_free(&hr_dev->uar_ida.ida, (int)context->uar.logic_idx);
 }
 
-static int hns_roce_mmap(struct ib_ucontext *context,
-			 struct vm_area_struct *vma)
+static int hns_roce_legacy_mmap(struct ib_ucontext *context,
+				struct vm_area_struct *vma)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(context->device);
 
@@ -371,6 +462,52 @@ static int hns_roce_mmap(struct ib_ucontext *context,
 	}
 }
 
+static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
+{
+	struct hns_roce_ucontext *context = to_hr_ucontext(uctx);
+	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->device);
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct rdma_user_mmap_entry *rdma_entry;
+	struct hns_user_mmap_entry *entry;
+	phys_addr_t pfn;
+	pgprot_t prot;
+	int ret;
+
+	if (!context->mmap_key_support)
+		return hns_roce_legacy_mmap(uctx, vma);
+
+	rdma_entry = rdma_user_mmap_entry_get_pgoff(uctx, vma->vm_pgoff);
+	if (!rdma_entry) {
+		ibdev_err(ibdev, "Invalid entry vm_pgoff %lu.\n",
+			  vma->vm_pgoff);
+		return -EINVAL;
+	}
+
+	entry = to_hns_mmap(rdma_entry);
+	pfn = entry->address >> PAGE_SHIFT;
+	prot = vma->vm_page_prot;
+	switch (entry->mmap_flag) {
+	case HNS_ROCE_MMAP_TYPE_DB:
+		ret = rdma_user_mmap_io(uctx, vma, pfn,
+					rdma_entry->npages * PAGE_SIZE,
+					pgprot_noncached(prot), rdma_entry);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	rdma_user_mmap_entry_put(rdma_entry);
+
+	return ret;
+}
+
+static void hns_roce_free_mmap(struct rdma_user_mmap_entry *rdma_entry)
+{
+	struct hns_user_mmap_entry *entry = to_hns_mmap(rdma_entry);
+
+	kfree(entry);
+}
+
 static int hns_roce_port_immutable(struct ib_device *ib_dev, u32 port_num,
 				   struct ib_port_immutable *immutable)
 {
@@ -444,6 +581,7 @@ static const struct ib_device_ops hns_roce_dev_ops = {
 	.get_link_layer = hns_roce_get_link_layer,
 	.get_port_immutable = hns_roce_port_immutable,
 	.mmap = hns_roce_mmap,
+	.mmap_free = hns_roce_free_mmap,
 	.modify_device = hns_roce_modify_device,
 	.modify_qp = hns_roce_modify_qp,
 	.query_ah = hns_roce_query_ah,
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index 42b177655560..ce1e39f21d73 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -83,11 +83,30 @@ struct hns_roce_ib_create_qp_resp {
 	__aligned_u64 cap_flags;
 };
 
+enum hns_roce_alloc_uctx_comp_flag {
+	HNS_ROCE_ALLOC_UCTX_COMP_CONFIG = 1 << 0,
+};
+
+enum hns_roce_alloc_uctx_resp_config {
+	HNS_ROCE_UCTX_RESP_MMAP_KEY_EN = 1 << 0,
+};
+
+enum hns_roce_alloc_uctx_req_config {
+	HNS_ROCE_UCTX_REQ_MMAP_KEY_EN = 1 << 0,
+};
+
+struct hns_roce_ib_alloc_ucontext {
+	__u32 comp;
+	__u32 config;
+};
+
 struct hns_roce_ib_alloc_ucontext_resp {
 	__u32	qp_tab_size;
 	__u32	cqe_size;
 	__u32	srq_tab_size;
-	__u32	reserved;
+	__u8    config;
+	__u8    rsv[3];
+	__aligned_u64 db_mmap_key;
 };
 
 struct hns_roce_ib_alloc_pd_resp {
-- 
2.33.0

