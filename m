Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A02D458942
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Nov 2021 07:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhKVGVq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Nov 2021 01:21:46 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:28089 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhKVGVq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Nov 2021 01:21:46 -0500
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HyH8T4G9Rz1DJXX;
        Mon, 22 Nov 2021 14:16:09 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 14:18:38 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 14:18:38 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <leon@kernel.org>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v3 rdma-core 1/2] Update kernel headers
Date:   Mon, 22 Nov 2021 14:14:04 +0800
Message-ID: <20211122061405.39621-2-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211122061405.39621-1-liangwenpeng@huawei.com>
References: <20211122061405.39621-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To commit ?? ("RDMA/hns: Support direct wqe of userspace").

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 kernel-headers/rdma/hns-abi.h | 2 ++
 1 file changed, 2 insertions(+)

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
-- 
2.33.0

