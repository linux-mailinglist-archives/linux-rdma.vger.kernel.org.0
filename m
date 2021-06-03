Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C03399BB6
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 09:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhFCHjU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 03:39:20 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3043 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhFCHjT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Jun 2021 03:39:19 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fwd0K2Q88zWpfq;
        Thu,  3 Jun 2021 15:32:49 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 15:37:33 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 3 Jun 2021 15:37:32 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Yixing Liu <liuyixing1@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH v2 for-next 2/2] RDMA/hns: Support direct WQE of userspace
Date:   Thu, 3 Jun 2021 15:37:14 +0800
Message-ID: <1622705834-19353-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622705834-19353-1-git-send-email-liweihang@huawei.com>
References: <1622705834-19353-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixing Liu <liuyixing1@huawei.com>

Enable direct WQE of userspace and add address mapping for it.

Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  7 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  1 +
 drivers/infiniband/hw/hns/hns_roce_main.c   | 59 +++++++++++++++++++++++++----
 drivers/infiniband/hw/hns/hns_roce_pd.c     |  8 +++-
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  5 +++
 include/uapi/rdma/hns-abi.h                 |  2 +
 6 files changed, 69 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index c6cacd2..da74209 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -185,6 +185,7 @@ enum {
 	HNS_ROCE_CAP_FLAG_FRMR                  = BIT(8),
 	HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL		= BIT(9),
 	HNS_ROCE_CAP_FLAG_ATOMIC		= BIT(10),
+	HNS_ROCE_CAP_FLAG_DIRECT_WQE		= BIT(12),
 	HNS_ROCE_CAP_FLAG_SDI_MODE		= BIT(14),
 	HNS_ROCE_CAP_FLAG_STASH			= BIT(17),
 };
@@ -224,6 +225,7 @@ enum {
 
 struct hns_roce_uar {
 	u64		pfn;
+	u64		dwqe_page;
 	unsigned long	index;
 	unsigned long	logic_idx;
 };
@@ -606,10 +608,6 @@ struct hns_roce_work {
 	u32 queue_num;
 };
 
-enum {
-	HNS_ROCE_QP_CAP_DIRECT_WQE = BIT(5),
-};
-
 struct hns_roce_qp {
 	struct ib_qp		ibqp;
 	struct hns_roce_wq	rq;
@@ -654,6 +652,7 @@ struct hns_roce_qp {
 	struct list_head	node;		/* all qps are on a list */
 	struct list_head	rq_node;	/* all recv qps are on a list */
 	struct list_head	sq_node;	/* all send qps are on a list */
+	bool			has_mmaped;	/* mark qp of direct wqe */
 };
 
 struct hns_roce_ib_iboe {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index fbc45b9..ef19f36 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1945,6 +1945,7 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->gid_table_len[0] = HNS_ROCE_V2_GID_INDEX_NUM;
 
 	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09) {
+		caps->flags |= HNS_ROCE_CAP_FLAG_DIRECT_WQE;
 		caps->max_sq_inline = HNS_ROCE_V3_MAX_SQ_INLINE;
 	} else {
 		caps->max_sq_inline = HNS_ROCE_V2_MAX_SQ_INLINE;
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 9610bfd..fdb25a7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -331,13 +331,6 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 	return ret;
 }
 
-static void hns_roce_dealloc_ucontext(struct ib_ucontext *ibcontext)
-{
-	struct hns_roce_ucontext *context = to_hr_ucontext(ibcontext);
-
-	hns_roce_uar_free(to_hr_dev(ibcontext->device), &context->uar);
-}
-
 /* command value is offset[15:8] */
 static int hns_roce_mmap_get_command(unsigned long offset)
 {
@@ -350,6 +343,56 @@ static unsigned long hns_roce_mmap_get_index(unsigned long offset)
 	return ((offset >> 16) << 8) | (offset & 0xff);
 }
 
+static int mmap_dwqe(struct ib_ucontext *uctx, struct vm_area_struct *vma)
+{
+	struct hns_roce_ucontext *context = to_hr_ucontext(uctx);
+	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->device);
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct hns_roce_qp *hr_qp;
+	unsigned long pgoff;
+	unsigned long qpn;
+	phys_addr_t pfn;
+	pgprot_t prot;
+	int ret;
+
+	pgoff = hns_roce_mmap_get_index(vma->vm_pgoff);
+	qpn = pgoff / (HNS_ROCE_DWQE_SIZE / PAGE_SIZE);
+	hr_qp = __hns_roce_qp_lookup(hr_dev, qpn);
+	if (!hr_qp) {
+		ibdev_err(ibdev, "failed to find QP.\n");
+		return -EINVAL;
+	}
+
+	if (hr_qp->ibqp.pd->uobject->context != uctx) {
+		ibdev_err(ibdev,
+			  "the QP is not owned by the context, QPN = %lu.\n",
+			  hr_qp->qpn);
+		return -EINVAL;
+	}
+
+	if (hr_qp->has_mmaped) {
+		ibdev_err(ibdev,
+			  "the QP has been already mapped, QPN = %lu.\n",
+			  hr_qp->qpn);
+		return -EINVAL;
+	}
+
+	hr_qp->has_mmaped = true;
+	pfn = context->uar.dwqe_page + pgoff;
+	prot = pgprot_device(vma->vm_page_prot);
+
+	ret = rdma_user_mmap_io(uctx, vma, pfn, HNS_ROCE_DWQE_SIZE, prot, NULL);
+
+	return ret;
+}
+
+static void hns_roce_dealloc_ucontext(struct ib_ucontext *ibcontext)
+{
+	struct hns_roce_ucontext *context = to_hr_ucontext(ibcontext);
+
+	hns_roce_uar_free(to_hr_dev(ibcontext->device), &context->uar);
+}
+
 static int mmap_uar(struct ib_ucontext *context, struct vm_area_struct *vma)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(context->device);
@@ -386,6 +429,8 @@ static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
 	switch (hns_roce_mmap_get_command(vma->vm_pgoff)) {
 	case HNS_ROCE_MMAP_REGULAR_PAGE:
 		return mmap_uar(uctx, vma);
+	case HNS_ROCE_MMAP_DWQE_PAGE:
+		return mmap_dwqe(uctx, vma);
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/infiniband/hw/hns/hns_roce_pd.c b/drivers/infiniband/hw/hns/hns_roce_pd.c
index a5813bf..620eb25 100644
--- a/drivers/infiniband/hw/hns/hns_roce_pd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_pd.c
@@ -112,8 +112,12 @@ int hns_roce_uar_alloc(struct hns_roce_dev *hr_dev, struct hns_roce_uar *uar)
 		}
 		uar->pfn = ((res->start) >> PAGE_SHIFT) + uar->index;
 	} else {
-		uar->pfn = ((pci_resource_start(hr_dev->pci_dev, 2))
-			   >> PAGE_SHIFT);
+		uar->pfn = pci_resource_start(hr_dev->pci_dev, 2) >> PAGE_SHIFT;
+
+		if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_DIRECT_WQE)
+			uar->dwqe_page =
+				pci_resource_start(hr_dev->pci_dev, 4) >>
+				PAGE_SHIFT;
 	}
 
 	return 0;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 9203cf1..d89bc0b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -768,6 +768,10 @@ static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 		goto err_inline;
 	}
 
+	if ((PAGE_SIZE <= HNS_ROCE_DWQE_SIZE) &&
+	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_DIRECT_WQE)
+		hr_qp->en_flags |= HNS_ROCE_QP_CAP_DIRECT_WQE;
+
 	return 0;
 err_inline:
 	free_rq_inline_buf(hr_qp);
@@ -1060,6 +1064,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	}
 
 	if (udata) {
+		resp.cap_flags = hr_qp->en_flags;
 		ret = ib_copy_to_udata(udata, &resp,
 				       min(udata->outlen, sizeof(resp)));
 		if (ret) {
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index 18529d7..248c611 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -77,6 +77,7 @@ enum hns_roce_qp_cap_flags {
 	HNS_ROCE_QP_CAP_RQ_RECORD_DB = 1 << 0,
 	HNS_ROCE_QP_CAP_SQ_RECORD_DB = 1 << 1,
 	HNS_ROCE_QP_CAP_OWNER_DB = 1 << 2,
+	HNS_ROCE_QP_CAP_DIRECT_WQE = 1 << 5,
 };
 
 struct hns_roce_ib_create_qp_resp {
@@ -96,6 +97,7 @@ struct hns_roce_ib_alloc_pd_resp {
 
 enum {
 	HNS_ROCE_MMAP_REGULAR_PAGE,
+	HNS_ROCE_MMAP_DWQE_PAGE,
 };
 
 #endif /* HNS_ABI_USER_H */
-- 
2.7.4

