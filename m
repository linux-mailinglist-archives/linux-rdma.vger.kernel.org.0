Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C5C41D598
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 10:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348487AbhI3Inp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 04:43:45 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:27946 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348402AbhI3Ino (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 04:43:44 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HKmpG3bBHzbmym;
        Thu, 30 Sep 2021 16:37:42 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 16:41:56 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 16:41:56 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH rdma-core 1/2] Update kernel headers
Date:   Thu, 30 Sep 2021 16:37:45 +0800
Message-ID: <20210930083746.19136-2-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210930083746.19136-1-liangwenpeng@huawei.com>
References: <20210930083746.19136-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To commit ?? ("RDMA/hns: Add a new mmap implementation").

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 kernel-headers/CMakeLists.txt   |  5 +++++
 kernel-headers/rdma/hns-abi.h   | 21 ++++++++++++++++++++-
 kernel-headers/rdma/irdma-abi.h |  2 +-
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/kernel-headers/CMakeLists.txt b/kernel-headers/CMakeLists.txt
index d9621ee2..3048d189 100644
--- a/kernel-headers/CMakeLists.txt
+++ b/kernel-headers/CMakeLists.txt
@@ -26,6 +26,11 @@ publish_internal_headers(rdma
   rdma/vmw_pvrdma-abi.h
   )
 
+publish_internal_headers(rdma/hfi
+  rdma/hfi/hfi1_ioctl.h
+  rdma/hfi/hfi1_user.h
+  )
+
 publish_internal_headers(linux
   linux/vfio.h
   )
diff --git a/kernel-headers/rdma/hns-abi.h b/kernel-headers/rdma/hns-abi.h
index 42b17765..ce1e39f2 100644
--- a/kernel-headers/rdma/hns-abi.h
+++ b/kernel-headers/rdma/hns-abi.h
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
diff --git a/kernel-headers/rdma/irdma-abi.h b/kernel-headers/rdma/irdma-abi.h
index 26b638a7..a7085e09 100644
--- a/kernel-headers/rdma/irdma-abi.h
+++ b/kernel-headers/rdma/irdma-abi.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
+/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB */
 /*
  * Copyright (c) 2006 - 2021 Intel Corporation.  All rights reserved.
  * Copyright (c) 2005 Topspin Communications.  All rights reserved.
-- 
2.33.0

