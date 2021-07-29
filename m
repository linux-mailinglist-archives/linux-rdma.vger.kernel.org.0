Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FD83D9BBF
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jul 2021 04:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbhG2CXM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Jul 2021 22:23:12 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7889 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbhG2CXL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Jul 2021 22:23:11 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GZvNn3l4sz81ZP;
        Thu, 29 Jul 2021 10:19:21 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
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
Subject: [PATCH v4 for-next 09/12] RDMA/hns: Add a shared memory to sync DCA status
Date:   Thu, 29 Jul 2021 10:19:20 +0800
Message-ID: <1627525163-1683-10-git-send-email-liangwenpeng@huawei.com>
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

The user DCA needs to check the QP attaching state before filling wqe
buffer by the resp from uverbs 'HNS_IB_METHOD_DCA_MEM_ATTACH', but this
will result in too much time being wasted on system calls, so add a shared
table between user driver and kernel driver to sync DCA status.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_dca.c    |  40 ++++++++++-
 drivers/infiniband/hw/hns/hns_roce_dca.h    |   2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h |   7 ++
 drivers/infiniband/hw/hns/hns_roce_main.c   | 104 +++++++++++++++++++++++++---
 include/uapi/rdma/hns-abi.h                 |  16 +++++
 5 files changed, 157 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_dca.c b/drivers/infiniband/hw/hns/hns_roce_dca.c
index 7d59744..ffa6137 100644
--- a/drivers/infiniband/hw/hns/hns_roce_dca.c
+++ b/drivers/infiniband/hw/hns/hns_roce_dca.c
@@ -414,16 +414,50 @@ static void cleanup_dca_context(struct hns_roce_dev *hr_dev,
 	spin_unlock_irqrestore(&ctx->pool_lock, flags);
 }
 
-void hns_roce_register_udca(struct hns_roce_dev *hr_dev,
+static void init_udca_status(struct hns_roce_dca_ctx *ctx, int udca_max_qps,
+			     unsigned int dev_max_qps)
+{
+	const unsigned int bits_per_qp = 2 * HNS_DCA_BITS_PER_STATUS;
+	void *kaddr;
+	size_t size;
+
+	size = BITS_TO_BYTES(udca_max_qps * bits_per_qp);
+	ctx->status_npage = DIV_ROUND_UP(size, PAGE_SIZE);
+
+	size = ctx->status_npage * PAGE_SIZE;
+	ctx->max_qps = min_t(unsigned int, dev_max_qps,
+			     size * BITS_PER_BYTE / bits_per_qp);
+
+	kaddr = alloc_pages_exact(size, GFP_KERNEL | __GFP_ZERO);
+	if (!kaddr)
+		return;
+
+	ctx->buf_status = (unsigned long *)kaddr;
+	ctx->sync_status = (unsigned long *)(kaddr + size / 2);
+}
+
+void hns_roce_register_udca(struct hns_roce_dev *hr_dev, int max_qps,
 			    struct hns_roce_ucontext *uctx)
 {
-	init_dca_context(&uctx->dca_ctx);
+	struct hns_roce_dca_ctx *ctx = to_hr_dca_ctx(uctx);
+
+	init_dca_context(ctx);
+	if (max_qps > 0)
+		init_udca_status(ctx, max_qps, hr_dev->caps.num_qps);
 }
 
 void hns_roce_unregister_udca(struct hns_roce_dev *hr_dev,
 			      struct hns_roce_ucontext *uctx)
 {
-	cleanup_dca_context(hr_dev, &uctx->dca_ctx);
+	struct hns_roce_dca_ctx *ctx = to_hr_dca_ctx(uctx);
+
+	cleanup_dca_context(hr_dev, ctx);
+
+	if (ctx->buf_status) {
+		free_pages_exact(ctx->buf_status,
+				 ctx->status_npage * PAGE_SIZE);
+		ctx->buf_status = NULL;
+	}
 }
 
 static struct dca_mem *alloc_dca_mem(struct hns_roce_dca_ctx *ctx)
diff --git a/drivers/infiniband/hw/hns/hns_roce_dca.h b/drivers/infiniband/hw/hns/hns_roce_dca.h
index cb7bd6a..1f59a62 100644
--- a/drivers/infiniband/hw/hns/hns_roce_dca.h
+++ b/drivers/infiniband/hw/hns/hns_roce_dca.h
@@ -56,7 +56,7 @@ struct hns_dca_query_resp {
 	u32 page_count;
 };
 
-void hns_roce_register_udca(struct hns_roce_dev *hr_dev,
+void hns_roce_register_udca(struct hns_roce_dev *hr_dev, int max_qps,
 			    struct hns_roce_ucontext *uctx);
 void hns_roce_unregister_udca(struct hns_roce_dev *hr_dev,
 			      struct hns_roce_ucontext *uctx);
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index fcaa004..ac53a44 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -232,6 +232,13 @@ struct hns_roce_dca_ctx {
 	size_t free_size; /* free mem size in pool */
 	size_t total_size; /* total size in pool */
 
+	unsigned int max_qps;
+	unsigned int status_npage;
+
+#define HNS_DCA_BITS_PER_STATUS 1
+	unsigned long *buf_status;
+	unsigned long *sync_status;
+
 	bool exit_aging;
 	struct list_head aging_proc_list;
 	struct list_head aging_new_list;
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 3df95d4..e37ece8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -293,20 +293,54 @@ static int hns_roce_modify_device(struct ib_device *ib_dev, int mask,
 	return 0;
 }
 
+static void ucontext_set_resp(struct ib_ucontext *uctx,
+			      struct hns_roce_ib_alloc_ucontext_resp *resp)
+{
+	struct hns_roce_ucontext *context = to_hr_ucontext(uctx);
+	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->device);
+
+	resp->qp_tab_size = hr_dev->caps.num_qps;
+	resp->cap_flags = hr_dev->caps.flags;
+	resp->cqe_size = hr_dev->caps.cqe_sz;
+	resp->srq_tab_size = hr_dev->caps.num_srqs;
+	resp->dca_qps = context->dca_ctx.max_qps;
+	resp->dca_mmap_size = PAGE_SIZE * context->dca_ctx.status_npage;
+}
+
+static u32 get_udca_max_qps(struct hns_roce_dev *hr_dev,
+			    struct hns_roce_ib_alloc_ucontext *ucmd)
+{
+	u32 qp_num;
+
+	if (ucmd->comp & HNS_ROCE_ALLOC_UCTX_COMP_DCA_MAX_QPS) {
+		qp_num = ucmd->dca_max_qps;
+		if (!qp_num)
+			qp_num = hr_dev->caps.num_qps;
+	} else {
+		qp_num = 0;
+	}
+
+	return qp_num;
+}
+
 static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 				   struct ib_udata *udata)
 {
 	struct hns_roce_ucontext *context = to_hr_ucontext(uctx);
 	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->device);
 	struct hns_roce_ib_alloc_ucontext_resp resp = {};
+	struct hns_roce_ib_alloc_ucontext ucmd = {};
 	int ret;
 
 	if (!hr_dev->active)
 		return -EAGAIN;
 
-	resp.qp_tab_size = hr_dev->caps.num_qps;
-	resp.srq_tab_size = hr_dev->caps.num_srqs;
-	resp.cap_flags = hr_dev->caps.flags;
+	if (udata->inlen == sizeof(struct hns_roce_ib_alloc_ucontext)) {
+		ret = ib_copy_from_udata(&ucmd, udata,
+					 min(udata->inlen, sizeof(ucmd)));
+		if (ret)
+			return ret;
+	}
 
 	ret = hns_roce_uar_alloc(hr_dev, &context->uar);
 	if (ret)
@@ -319,9 +353,10 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 	}
 
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_DCA_MODE)
-		hns_roce_register_udca(hr_dev, context);
+		hns_roce_register_udca(hr_dev, get_udca_max_qps(hr_dev, &ucmd),
+				       context);
 
-	resp.cqe_size = hr_dev->caps.cqe_sz;
+	ucontext_set_resp(uctx, &resp);
 
 	ret = ib_copy_to_udata(udata, &resp,
 			       min(udata->outlen, sizeof(resp)));
@@ -340,6 +375,17 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 	return ret;
 }
 
+/* command value is offset[15:8] */
+static int hns_roce_mmap_get_command(unsigned long offset)
+{
+	return (offset >> 8) & 0xff;
+}
+
+/* index value is offset[63:16] | offset[7:0] */
+static unsigned long hns_roce_mmap_get_index(unsigned long offset)
+{
+	return ((offset >> 16) << 8) | (offset & 0xff);
+}
 static void hns_roce_dealloc_ucontext(struct ib_ucontext *ibcontext)
 {
 	struct hns_roce_ucontext *context = to_hr_ucontext(ibcontext);
@@ -351,12 +397,11 @@ static void hns_roce_dealloc_ucontext(struct ib_ucontext *ibcontext)
 		hns_roce_unregister_udca(hr_dev, context);
 }
 
-static int hns_roce_mmap(struct ib_ucontext *context,
-			 struct vm_area_struct *vma)
+static int mmap_uar(struct ib_ucontext *context, struct vm_area_struct *vma)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(context->device);
 
-	switch (vma->vm_pgoff) {
+	switch (hns_roce_mmap_get_index(vma->vm_pgoff)) {
 	case 0:
 		return rdma_user_mmap_io(context, vma,
 					 to_hr_ucontext(context)->uar.pfn,
@@ -383,6 +428,49 @@ static int hns_roce_mmap(struct ib_ucontext *context,
 	}
 }
 
+static int mmap_dca(struct ib_ucontext *context, struct vm_area_struct *vma)
+{
+	struct hns_roce_ucontext *uctx = to_hr_ucontext(context);
+	struct hns_roce_dca_ctx *ctx = &uctx->dca_ctx;
+	struct page **pages;
+	unsigned long num;
+	int ret;
+
+	if ((vma->vm_end - vma->vm_start != (ctx->status_npage * PAGE_SIZE) ||
+	    !(vma->vm_flags & VM_SHARED)))
+		return -EINVAL;
+
+	if (!(vma->vm_flags & VM_WRITE) || (vma->vm_flags & VM_EXEC))
+		return -EPERM;
+
+	if (!ctx->buf_status)
+		return -EOPNOTSUPP;
+
+	pages = kcalloc(ctx->status_npage, sizeof(struct page *), GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
+
+	for (num = 0; num < ctx->status_npage; num++)
+		pages[num] = virt_to_page(ctx->buf_status + num * PAGE_SIZE);
+
+	ret = vm_insert_pages(vma, vma->vm_start, pages, &num);
+	kfree(pages);
+
+	return ret;
+}
+
+static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
+{
+	switch (hns_roce_mmap_get_command(vma->vm_pgoff)) {
+	case HNS_ROCE_MMAP_REGULAR_PAGE:
+		return mmap_uar(uctx, vma);
+	case HNS_ROCE_MMAP_DCA_PAGE:
+		return mmap_dca(uctx, vma);
+	default:
+		return -EINVAL;
+	}
+}
+
 static int hns_roce_port_immutable(struct ib_device *ib_dev, u32 port_num,
 				   struct ib_port_immutable *immutable)
 {
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index 7f5d2d5..476ea81 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -86,6 +86,15 @@ struct hns_roce_ib_create_qp_resp {
 };
 
 enum {
+	HNS_ROCE_ALLOC_UCTX_COMP_DCA_MAX_QPS = 1 << 0,
+};
+
+struct hns_roce_ib_alloc_ucontext {
+	__u32 comp;
+	__u32 dca_max_qps;
+};
+
+enum {
 	HNS_ROCE_CAP_FLAG_DCA_MODE = 1 << 15,
 };
 
@@ -95,12 +104,19 @@ struct hns_roce_ib_alloc_ucontext_resp {
 	__u32	srq_tab_size;
 	__u32	reserved;
 	__aligned_u64 cap_flags;
+	__u32	dca_qps;
+	__u32	dca_mmap_size;
 };
 
 struct hns_roce_ib_alloc_pd_resp {
 	__u32 pdn;
 };
 
+enum {
+	HNS_ROCE_MMAP_REGULAR_PAGE,
+	HNS_ROCE_MMAP_DCA_PAGE,
+};
+
 #define UVERBS_ID_NS_MASK 0xF000
 #define UVERBS_ID_NS_SHIFT 12
 
-- 
2.8.1

