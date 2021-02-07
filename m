Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CEE31211E
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Feb 2021 04:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhBGDQL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 6 Feb 2021 22:16:11 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12859 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhBGDP6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 6 Feb 2021 22:15:58 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DYDl44jDFz7hLS;
        Sun,  7 Feb 2021 11:13:52 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Sun, 7 Feb 2021 11:15:08 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH RFC rdma-core 1/5] Update kernel headers
Date:   Sun, 7 Feb 2021 11:12:50 +0800
Message-ID: <1612667574-56673-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1612667574-56673-1-git-send-email-liweihang@huawei.com>
References: <1612667574-56673-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
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
index 90b739d..b832f26 100644
--- a/kernel-headers/rdma/hns-abi.h
+++ b/kernel-headers/rdma/hns-abi.h
@@ -77,19 +77,83 @@ enum hns_roce_qp_cap_flags {
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
2.8.1

