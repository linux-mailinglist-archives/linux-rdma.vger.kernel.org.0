Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65F63D6CC4
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 05:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbhG0CvJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Jul 2021 22:51:09 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7062 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbhG0CvI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Jul 2021 22:51:08 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GYhyF01r1zYgkb;
        Tue, 27 Jul 2021 11:25:41 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 11:31:34 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 11:31:34 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2 rdma-core 01/10] Update kernel headers
Date:   Tue, 27 Jul 2021 11:27:51 +0800
Message-ID: <1627356480-41805-2-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1627356480-41805-1-git-send-email-liangwenpeng@huawei.com>
References: <1627356480-41805-1-git-send-email-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To commit ?? ("RDMA/hns: Dump detailed driver-specific UCTX").

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 kernel-headers/rdma/hns-abi.h  | 86 ++++++++++++++++++++++++++++++++++++++++++
 kernel-headers/rdma/mlx5-abi.h | 17 ++++++++-
 2 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/kernel-headers/rdma/hns-abi.h b/kernel-headers/rdma/hns-abi.h
index 42b1776..40ac2c3 100644
--- a/kernel-headers/rdma/hns-abi.h
+++ b/kernel-headers/rdma/hns-abi.h
@@ -77,21 +77,107 @@ enum hns_roce_qp_cap_flags {
 	HNS_ROCE_QP_CAP_RQ_RECORD_DB = 1 << 0,
 	HNS_ROCE_QP_CAP_SQ_RECORD_DB = 1 << 1,
 	HNS_ROCE_QP_CAP_OWNER_DB = 1 << 2,
+	HNS_ROCE_QP_CAP_DYNAMIC_CTX_ATTACH = 1 << 4,
+	HNS_ROCE_QP_CAP_DYNAMIC_CTX_DETACH = 1 << 6,
 };
 
 struct hns_roce_ib_create_qp_resp {
 	__aligned_u64 cap_flags;
 };
 
+enum {
+	HNS_ROCE_ALLOC_UCTX_COMP_DCA_MAX_QPS = 1 << 0,
+};
+
+struct hns_roce_ib_alloc_ucontext {
+	__u32 comp;
+	__u32 dca_max_qps;
+};
+
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
+struct hns_roce_ib_modify_qp_resp {
+	__u32	dcan;
+	__u32	reserved;
+};
+
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
diff --git a/kernel-headers/rdma/mlx5-abi.h b/kernel-headers/rdma/mlx5-abi.h
index 8597e6f..86be4a9 100644
--- a/kernel-headers/rdma/mlx5-abi.h
+++ b/kernel-headers/rdma/mlx5-abi.h
@@ -50,6 +50,7 @@ enum {
 	MLX5_QP_FLAG_ALLOW_SCATTER_CQE	= 1 << 8,
 	MLX5_QP_FLAG_PACKET_BASED_CREDIT_MODE	= 1 << 9,
 	MLX5_QP_FLAG_UAR_PAGE_INDEX = 1 << 10,
+	MLX5_QP_FLAG_DCI_STREAM	= 1 << 11,
 };
 
 enum {
@@ -238,6 +239,11 @@ struct mlx5_ib_striding_rq_caps {
 	__u32 reserved;
 };
 
+struct mlx5_ib_dci_streams_caps {
+	__u8 max_log_num_concurent;
+	__u8 max_log_num_errored;
+};
+
 enum mlx5_ib_query_dev_resp_flags {
 	/* Support 128B CQE compression */
 	MLX5_IB_QUERY_DEV_RESP_FLAGS_CQE_128B_COMP = 1 << 0,
@@ -266,7 +272,8 @@ struct mlx5_ib_query_device_resp {
 	struct mlx5_ib_sw_parsing_caps sw_parsing_caps;
 	struct mlx5_ib_striding_rq_caps striding_rq_caps;
 	__u32	tunnel_offloads_caps; /* enum mlx5_ib_tunnel_offloads */
-	__u32	reserved;
+	struct  mlx5_ib_dci_streams_caps dci_streams_caps;
+	__u16 reserved;
 };
 
 enum mlx5_ib_create_cq_flags {
@@ -313,6 +320,11 @@ struct mlx5_ib_create_srq_resp {
 	__u32	reserved;
 };
 
+struct mlx5_ib_create_qp_dci_streams {
+	__u8 log_num_concurent;
+	__u8 log_num_errored;
+};
+
 struct mlx5_ib_create_qp {
 	__aligned_u64 buf_addr;
 	__aligned_u64 db_addr;
@@ -327,7 +339,8 @@ struct mlx5_ib_create_qp {
 		__aligned_u64 access_key;
 	};
 	__u32  ece_options;
-	__u32  reserved;
+	struct  mlx5_ib_create_qp_dci_streams dci_streams;
+	__u16 reserved;
 };
 
 /* RX Hash function flags */
-- 
2.8.1

