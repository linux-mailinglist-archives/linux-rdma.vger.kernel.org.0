Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A05D46BBD6
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 13:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhLGM5P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Dec 2021 07:57:15 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:28282 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbhLGM5P (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Dec 2021 07:57:15 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J7gG32Q83zbjKG;
        Tue,  7 Dec 2021 20:53:31 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 20:53:43 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 20:53:43 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH v6 for-next 1/1] RDMA/hns: Support direct wqe of userspace
Date:   Tue, 7 Dec 2021 20:49:01 +0800
Message-ID: <20211207124901.42123-2-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211207124901.42123-1-liangwenpeng@huawei.com>
References: <20211207124901.42123-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixing Liu <liuyixing1@huawei.com>

Add direct wqe enable switch and address mapping.

Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  8 +--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  3 +-
 drivers/infiniband/hw/hns/hns_roce_main.c   | 36 +++++++++++---
 drivers/infiniband/hw/hns/hns_roce_pd.c     |  3 ++
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 54 ++++++++++++++++++++-
 include/uapi/rdma/hns-abi.h                 |  2 +
 6 files changed, 94 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index e35164ae7376..bc7112a205a7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -182,6 +182,7 @@ enum {
 	HNS_ROCE_CAP_FLAG_FRMR                  = BIT(8),
 	HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL		= BIT(9),
 	HNS_ROCE_CAP_FLAG_ATOMIC		= BIT(10),
+	HNS_ROCE_CAP_FLAG_DIRECT_WQE		= BIT(12),
 	HNS_ROCE_CAP_FLAG_SDI_MODE		= BIT(14),
 	HNS_ROCE_CAP_FLAG_STASH			= BIT(17),
 };
@@ -228,6 +229,7 @@ struct hns_roce_uar {
 enum hns_roce_mmap_type {
 	HNS_ROCE_MMAP_TYPE_DB = 1,
 	HNS_ROCE_MMAP_TYPE_TPTR,
+	HNS_ROCE_MMAP_TYPE_DWQE,
 };
 
 struct hns_user_mmap_entry {
@@ -627,10 +629,6 @@ struct hns_roce_work {
 	u32 queue_num;
 };
 
-enum {
-	HNS_ROCE_QP_CAP_DIRECT_WQE = BIT(5),
-};
-
 struct hns_roce_qp {
 	struct ib_qp		ibqp;
 	struct hns_roce_wq	rq;
@@ -675,6 +673,7 @@ struct hns_roce_qp {
 	struct list_head	node; /* all qps are on a list */
 	struct list_head	rq_node; /* all recv qps are on a list */
 	struct list_head	sq_node; /* all send qps are on a list */
+	struct hns_user_mmap_entry *dwqe_mmap_entry;
 };
 
 struct hns_roce_ib_iboe {
@@ -1010,6 +1009,7 @@ struct hns_roce_dev {
 	u32 func_num;
 	u32 is_vf;
 	u32 cong_algo_tmpl_id;
+	u64 dwqe_page;
 };
 
 static inline struct hns_roce_dev *to_hr_dev(struct ib_device *ib_dev)
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index bdf220dc8dd3..2d475348a6cd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1989,7 +1989,8 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->gid_table_len[0] = HNS_ROCE_V2_GID_INDEX_NUM;
 
 	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09) {
-		caps->flags |= HNS_ROCE_CAP_FLAG_STASH;
+		caps->flags |= HNS_ROCE_CAP_FLAG_STASH |
+			       HNS_ROCE_CAP_FLAG_DIRECT_WQE;
 		caps->max_sq_inline = HNS_ROCE_V3_MAX_SQ_INLINE;
 	} else {
 		caps->max_sq_inline = HNS_ROCE_V2_MAX_SQ_INLINE;
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index a906c6078b72..d0b976a86cd5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -310,9 +310,25 @@ hns_roce_user_mmap_entry_insert(struct ib_ucontext *ucontext, u64 address,
 	entry->address = address;
 	entry->mmap_type = mmap_type;
 
-	ret = rdma_user_mmap_entry_insert_exact(
-		ucontext, &entry->rdma_entry, length,
-		mmap_type == HNS_ROCE_MMAP_TYPE_DB ? 0 : 1);
+	switch (mmap_type) {
+	case HNS_ROCE_MMAP_TYPE_DB:
+		ret = rdma_user_mmap_entry_insert_exact(
+				ucontext, &entry->rdma_entry, length, 0);
+		break;
+	case HNS_ROCE_MMAP_TYPE_TPTR:
+		ret = rdma_user_mmap_entry_insert_exact(
+				ucontext, &entry->rdma_entry, length, 1);
+		break;
+	case HNS_ROCE_MMAP_TYPE_DWQE:
+		ret = rdma_user_mmap_entry_insert_range(
+				ucontext, &entry->rdma_entry, length, 2,
+				U32_MAX);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
 	if (ret) {
 		kfree(entry);
 		return NULL;
@@ -439,10 +455,18 @@ static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
 
 	entry = to_hns_mmap(rdma_entry);
 	pfn = entry->address >> PAGE_SHIFT;
-	prot = vma->vm_page_prot;
 
-	if (entry->mmap_type != HNS_ROCE_MMAP_TYPE_TPTR)
-		prot = pgprot_device(prot);
+	switch (entry->mmap_type) {
+	case HNS_ROCE_MMAP_TYPE_DB:
+	case HNS_ROCE_MMAP_TYPE_DWQE:
+		prot = pgprot_device(vma->vm_page_prot);
+		break;
+	case HNS_ROCE_MMAP_TYPE_TPTR:
+		prot = vma->vm_page_prot;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	ret = rdma_user_mmap_io(uctx, vma, pfn, rdma_entry->npages * PAGE_SIZE,
 				prot, rdma_entry);
diff --git a/drivers/infiniband/hw/hns/hns_roce_pd.c b/drivers/infiniband/hw/hns/hns_roce_pd.c
index 81ffad77ae42..03c349f7ebbe 100644
--- a/drivers/infiniband/hw/hns/hns_roce_pd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_pd.c
@@ -115,6 +115,9 @@ int hns_roce_uar_alloc(struct hns_roce_dev *hr_dev, struct hns_roce_uar *uar)
 	} else {
 		uar->pfn = ((pci_resource_start(hr_dev->pci_dev, 2))
 			   >> PAGE_SHIFT);
+		if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_DIRECT_WQE)
+			hr_dev->dwqe_page =
+				pci_resource_start(hr_dev->pci_dev, 4);
 	}
 
 	return 0;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 4fcab1611548..c84e1c23722c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -379,6 +379,11 @@ static int alloc_qpc(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 	return ret;
 }
 
+static void qp_user_mmap_entry_remove(struct hns_roce_qp *hr_qp)
+{
+	rdma_user_mmap_entry_remove(&hr_qp->dwqe_mmap_entry->rdma_entry);
+}
+
 void hns_roce_qp_remove(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 {
 	struct xarray *xa = &hr_dev->qp_table_xa;
@@ -780,7 +785,11 @@ static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 		goto err_inline;
 	}
 
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_DIRECT_WQE)
+		hr_qp->en_flags |= HNS_ROCE_QP_CAP_DIRECT_WQE;
+
 	return 0;
+
 err_inline:
 	free_rq_inline_buf(hr_qp);
 
@@ -822,6 +831,35 @@ static inline bool kernel_qp_has_rdb(struct hns_roce_dev *hr_dev,
 		hns_roce_qp_has_rq(init_attr));
 }
 
+static int qp_mmap_entry(struct hns_roce_qp *hr_qp,
+			 struct hns_roce_dev *hr_dev,
+			 struct ib_udata *udata,
+			 struct hns_roce_ib_create_qp_resp *resp)
+{
+	struct hns_roce_ucontext *uctx =
+		rdma_udata_to_drv_context(udata,
+			struct hns_roce_ucontext, ibucontext);
+	struct rdma_user_mmap_entry *rdma_entry;
+	u64 address;
+
+	address = hr_dev->dwqe_page + hr_qp->qpn * HNS_ROCE_DWQE_SIZE;
+
+	hr_qp->dwqe_mmap_entry =
+		hns_roce_user_mmap_entry_insert(&uctx->ibucontext, address,
+						HNS_ROCE_DWQE_SIZE,
+						HNS_ROCE_MMAP_TYPE_DWQE);
+
+	if (!hr_qp->dwqe_mmap_entry) {
+		ibdev_err(&hr_dev->ib_dev, "failed to get dwqe mmap entry.\n");
+		return -ENOMEM;
+	}
+
+	rdma_entry = &hr_qp->dwqe_mmap_entry->rdma_entry;
+	resp->dwqe_mmap_key = rdma_user_mmap_get_offset(rdma_entry);
+
+	return 0;
+}
+
 static int alloc_user_qp_db(struct hns_roce_dev *hr_dev,
 			    struct hns_roce_qp *hr_qp,
 			    struct ib_qp_init_attr *init_attr,
@@ -909,10 +947,16 @@ static int alloc_qp_db(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 		hr_qp->en_flags |= HNS_ROCE_QP_CAP_OWNER_DB;
 
 	if (udata) {
+		if (hr_qp->en_flags & HNS_ROCE_QP_CAP_DIRECT_WQE) {
+			ret = qp_mmap_entry(hr_qp, hr_dev, udata, resp);
+			if (ret)
+				return ret;
+		}
+
 		ret = alloc_user_qp_db(hr_dev, hr_qp, init_attr, udata, ucmd,
 				       resp);
 		if (ret)
-			return ret;
+			goto err_remove_qp;
 	} else {
 		ret = alloc_kernel_qp_db(hr_dev, hr_qp, init_attr);
 		if (ret)
@@ -920,6 +964,12 @@ static int alloc_qp_db(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 	}
 
 	return 0;
+
+err_remove_qp:
+	if (hr_qp->en_flags & HNS_ROCE_QP_CAP_DIRECT_WQE)
+		qp_user_mmap_entry_remove(hr_qp);
+
+	return ret;
 }
 
 static void free_qp_db(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
@@ -933,6 +983,8 @@ static void free_qp_db(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 			hns_roce_db_unmap_user(uctx, &hr_qp->rdb);
 		if (hr_qp->en_flags & HNS_ROCE_QP_CAP_SQ_RECORD_DB)
 			hns_roce_db_unmap_user(uctx, &hr_qp->sdb);
+		if (hr_qp->en_flags & HNS_ROCE_QP_CAP_DIRECT_WQE)
+			qp_user_mmap_entry_remove(hr_qp);
 	} else {
 		if (hr_qp->en_flags & HNS_ROCE_QP_CAP_RQ_RECORD_DB)
 			hns_roce_free_db(hr_dev, &hr_qp->rdb);
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index 42b177655560..f6fde06db4b4 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -77,10 +77,12 @@ enum hns_roce_qp_cap_flags {
 	HNS_ROCE_QP_CAP_RQ_RECORD_DB = 1 << 0,
 	HNS_ROCE_QP_CAP_SQ_RECORD_DB = 1 << 1,
 	HNS_ROCE_QP_CAP_OWNER_DB = 1 << 2,
+	HNS_ROCE_QP_CAP_DIRECT_WQE = 1 << 5,
 };
 
 struct hns_roce_ib_create_qp_resp {
 	__aligned_u64 cap_flags;
+	__aligned_u64 dwqe_mmap_key;
 };
 
 struct hns_roce_ib_alloc_ucontext_resp {
-- 
2.33.0

