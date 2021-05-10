Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6841378ED6
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 15:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242351AbhEJNY2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 09:24:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2609 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352237AbhEJNOV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 May 2021 09:14:21 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ff1cL1hC1zQlnl;
        Mon, 10 May 2021 21:09:54 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 21:13:06 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH rdma-core 1/6] Update kernel headers
Date:   Mon, 10 May 2021 21:12:59 +0800
Message-ID: <1620652384-34097-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620652384-34097-1-git-send-email-liweihang@huawei.com>
References: <1620652384-34097-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To commit ?? ("RDMA/hns: Add method to query WQE buffer's address").

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 kernel-headers/rdma/hns-abi.h | 64 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/kernel-headers/rdma/hns-abi.h b/kernel-headers/rdma/hns-abi.h
index 42b1776..edcecc1 100644
--- a/kernel-headers/rdma/hns-abi.h
+++ b/kernel-headers/rdma/hns-abi.h
@@ -77,21 +77,85 @@ enum hns_roce_qp_cap_flags {
 	HNS_ROCE_QP_CAP_RQ_RECORD_DB = 1 << 0,
 	HNS_ROCE_QP_CAP_SQ_RECORD_DB = 1 << 1,
 	HNS_ROCE_QP_CAP_OWNER_DB = 1 << 2,
+	HNS_ROCE_QP_CAP_DCA = 1 << 4,
 };
 
 struct hns_roce_ib_create_qp_resp {
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
+	HNS_IB_METHOD_DCA_MEM_SHRINK,
+	HNS_IB_METHOD_DCA_MEM_ATTACH,
+	HNS_IB_METHOD_DCA_MEM_DETACH,
+	HNS_IB_METHOD_DCA_MEM_QUERY,
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
+
+enum hns_ib_dca_mem_shrink_attrs {
+	HNS_IB_ATTR_DCA_MEM_SHRINK_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+	HNS_IB_ATTR_DCA_MEM_SHRINK_RESERVED_SIZE,
+	HNS_IB_ATTR_DCA_MEM_SHRINK_OUT_FREE_KEY,
+	HNS_IB_ATTR_DCA_MEM_SHRINK_OUT_FREE_MEMS,
+};
+
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
+
+enum hns_ib_dca_mem_detach_attrs {
+	HNS_IB_ATTR_DCA_MEM_DETACH_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+	HNS_IB_ATTR_DCA_MEM_DETACH_SQ_INDEX,
+};
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

