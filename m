Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F02394003
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 11:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbhE1Jer (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 05:34:47 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2389 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhE1Jer (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 05:34:47 -0400
Received: from dggeml752-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Frzsl6GBxz65ZP;
        Fri, 28 May 2021 17:29:31 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggeml752-chm.china.huawei.com (10.1.199.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 17:33:10 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 17:33:10 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH rdma-core 1/4] Update kernel headers
Date:   Fri, 28 May 2021 17:32:56 +0800
Message-ID: <1622194379-59868-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622194379-59868-1-git-send-email-liweihang@huawei.com>
References: <1622194379-59868-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To commit ?? ("RDMA/hns: Support direct WQE of userspace").

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 kernel-headers/rdma/hns-abi.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel-headers/rdma/hns-abi.h b/kernel-headers/rdma/hns-abi.h
index 42b1776..248c611 100644
--- a/kernel-headers/rdma/hns-abi.h
+++ b/kernel-headers/rdma/hns-abi.h
@@ -77,6 +77,7 @@ enum hns_roce_qp_cap_flags {
 	HNS_ROCE_QP_CAP_RQ_RECORD_DB = 1 << 0,
 	HNS_ROCE_QP_CAP_SQ_RECORD_DB = 1 << 1,
 	HNS_ROCE_QP_CAP_OWNER_DB = 1 << 2,
+	HNS_ROCE_QP_CAP_DIRECT_WQE = 1 << 5,
 };
 
 struct hns_roce_ib_create_qp_resp {
@@ -94,4 +95,9 @@ struct hns_roce_ib_alloc_pd_resp {
 	__u32 pdn;
 };
 
+enum {
+	HNS_ROCE_MMAP_REGULAR_PAGE,
+	HNS_ROCE_MMAP_DWQE_PAGE,
+};
+
 #endif /* HNS_ABI_USER_H */
-- 
2.7.4

