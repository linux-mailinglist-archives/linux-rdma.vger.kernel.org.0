Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75E648232A
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Dec 2021 11:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhLaKNK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Dec 2021 05:13:10 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:29315 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhLaKNK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 31 Dec 2021 05:13:10 -0500
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JQLYL1m5vzbjcm;
        Fri, 31 Dec 2021 18:12:38 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 31 Dec 2021 18:13:08 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 31 Dec 2021 18:13:08 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 2/2] RDMA/hns: Modify the hop num of HIP09 EQ to 1
Date:   Fri, 31 Dec 2021 18:13:41 +0800
Message-ID: <20211231101341.45759-3-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211231101341.45759-1-liangwenpeng@huawei.com>
References: <20211231101341.45759-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

HIP09 EQ does not support level 2 addressing.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 3 ++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d0c0ea6754f6..6d1b3f9380fe 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2141,7 +2141,6 @@ static void apply_func_caps(struct hns_roce_dev *hr_dev)
 	caps->cqc_timer_entry_sz = HNS_ROCE_V2_CQC_TIMER_ENTRY_SZ;
 	caps->mtt_entry_sz = HNS_ROCE_V2_MTT_ENTRY_SZ;
 
-	caps->eqe_hop_num = HNS_ROCE_EQE_HOP_NUM;
 	caps->pbl_hop_num = HNS_ROCE_PBL_HOP_NUM;
 	caps->qpc_timer_hop_num = HNS_ROCE_HOP_NUM_0;
 	caps->cqc_timer_hop_num = HNS_ROCE_HOP_NUM_0;
@@ -2158,6 +2157,7 @@ static void apply_func_caps(struct hns_roce_dev *hr_dev)
 				  (u32)priv->handle->rinfo.num_vectors - 2);
 
 	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09) {
+		caps->eqe_hop_num = HNS_ROCE_V3_EQE_HOP_NUM;
 		caps->ceqe_size = HNS_ROCE_V3_EQE_SIZE;
 		caps->aeqe_size = HNS_ROCE_V3_EQE_SIZE;
 
@@ -2178,6 +2178,7 @@ static void apply_func_caps(struct hns_roce_dev *hr_dev)
 	} else {
 		u32 func_num = max_t(u32, 1, hr_dev->func_num);
 
+		caps->eqe_hop_num = HNS_ROCE_V2_EQE_HOP_NUM;
 		caps->ceqe_size = HNS_ROCE_CEQE_SIZE;
 		caps->aeqe_size = HNS_ROCE_AEQE_SIZE;
 		caps->gid_table_len[0] /= func_num;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index fddb9bc3c14c..e9a73c34389b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -101,12 +101,14 @@
 #define HNS_ROCE_CQE_HOP_NUM			1
 #define HNS_ROCE_SRQWQE_HOP_NUM			1
 #define HNS_ROCE_PBL_HOP_NUM			2
-#define HNS_ROCE_EQE_HOP_NUM			2
 #define HNS_ROCE_IDX_HOP_NUM			1
 #define HNS_ROCE_SQWQE_HOP_NUM			2
 #define HNS_ROCE_EXT_SGE_HOP_NUM		1
 #define HNS_ROCE_RQWQE_HOP_NUM			2
 
+#define HNS_ROCE_V2_EQE_HOP_NUM			2
+#define HNS_ROCE_V3_EQE_HOP_NUM			1
+
 #define HNS_ROCE_BA_PG_SZ_SUPPORTED_256K	6
 #define HNS_ROCE_BA_PG_SZ_SUPPORTED_16K		2
 #define HNS_ROCE_V2_GID_INDEX_NUM		16
-- 
2.33.0

