Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A17453535
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Nov 2021 16:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237806AbhKPPIv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Nov 2021 10:08:51 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:27214 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238108AbhKPPI2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Nov 2021 10:08:28 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Htq7x5Jv4z8vNq;
        Tue, 16 Nov 2021 23:03:41 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 16 Nov 2021 23:05:24 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 16 Nov 2021 23:05:24 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <leon@kernel.org>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2 rdma-core 1/2] Update kernel headers
Date:   Tue, 16 Nov 2021 23:03:15 +0800
Message-ID: <20211116150316.21925-2-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211116150316.21925-1-liangwenpeng@huawei.com>
References: <20211116150316.21925-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To commit ?? ("RDMA/hns: Support direct wqe of userspace").

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 kernel-headers/rdma/hns-abi.h       |  2 ++
 kernel-headers/rdma/rdma_netlink.h  |  5 +++++
 kernel-headers/rdma/rdma_user_rxe.h | 14 +++++++++++---
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel-headers/rdma/hns-abi.h b/kernel-headers/rdma/hns-abi.h
index 42b17765..f6fde06d 100644
--- a/kernel-headers/rdma/hns-abi.h
+++ b/kernel-headers/rdma/hns-abi.h
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
diff --git a/kernel-headers/rdma/rdma_netlink.h b/kernel-headers/rdma/rdma_netlink.h
index 75a1ae23..e50c3573 100644
--- a/kernel-headers/rdma/rdma_netlink.h
+++ b/kernel-headers/rdma/rdma_netlink.h
@@ -297,6 +297,8 @@ enum rdma_nldev_command {
 
 	RDMA_NLDEV_CMD_RES_SRQ_GET, /* can dump */
 
+	RDMA_NLDEV_CMD_STAT_GET_STATUS,
+
 	RDMA_NLDEV_NUM_OPS
 };
 
@@ -549,6 +551,9 @@ enum rdma_nldev_attr {
 
 	RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK,	/* u8 */
 
+	RDMA_NLDEV_ATTR_STAT_HWCOUNTER_INDEX,	/* u32 */
+	RDMA_NLDEV_ATTR_STAT_HWCOUNTER_DYNAMIC, /* u8 */
+
 	/*
 	 * Always the end
 	 */
diff --git a/kernel-headers/rdma/rdma_user_rxe.h b/kernel-headers/rdma/rdma_user_rxe.h
index e283c222..f09c5c9e 100644
--- a/kernel-headers/rdma/rdma_user_rxe.h
+++ b/kernel-headers/rdma/rdma_user_rxe.h
@@ -98,6 +98,10 @@ struct rxe_send_wr {
 			__u32	remote_qpn;
 			__u32	remote_qkey;
 			__u16	pkey_index;
+			__u16	reserved;
+			__u32	ah_num;
+			__u32	pad[4];
+			struct rxe_av av;
 		} ud;
 		struct {
 			__aligned_u64	addr;
@@ -141,14 +145,13 @@ struct rxe_dma_info {
 	__u32			sge_offset;
 	__u32			reserved;
 	union {
-		__u8		inline_data[0];
-		struct rxe_sge	sge[0];
+		__DECLARE_FLEX_ARRAY(__u8, inline_data);
+		__DECLARE_FLEX_ARRAY(struct rxe_sge, sge);
 	};
 };
 
 struct rxe_send_wqe {
 	struct rxe_send_wr	wr;
-	struct rxe_av		av;
 	__u32			status;
 	__u32			state;
 	__aligned_u64		iova;
@@ -168,6 +171,11 @@ struct rxe_recv_wqe {
 	struct rxe_dma_info	dma;
 };
 
+struct rxe_create_ah_resp {
+	__u32 ah_num;
+	__u32 reserved;
+};
+
 struct rxe_create_cq_resp {
 	struct mminfo mi;
 };
-- 
2.33.0

