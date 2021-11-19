Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05833457044
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Nov 2021 15:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbhKSOJq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Nov 2021 09:09:46 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14959 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbhKSOJo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Nov 2021 09:09:44 -0500
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Hwdgz0Jl1zZd7J;
        Fri, 19 Nov 2021 22:04:15 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 19 Nov 2021 22:06:41 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 19 Nov 2021 22:06:40 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 8/9] RDMA/hns: Remove macros that are no longer used
Date:   Fri, 19 Nov 2021 22:02:07 +0800
Message-ID: <20211119140208.40416-9-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211119140208.40416-1-liangwenpeng@huawei.com>
References: <20211119140208.40416-1-liangwenpeng@huawei.com>
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

These macros are no longer used, so remove them.

Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 6858b939de63..fddb9bc3c14c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -35,26 +35,15 @@
 
 #include <linux/bitops.h>
 
-#define HNS_ROCE_VF_QPC_BT_NUM			256
-#define HNS_ROCE_VF_SCCC_BT_NUM			64
-#define HNS_ROCE_VF_SRQC_BT_NUM			64
-#define HNS_ROCE_VF_CQC_BT_NUM			64
-#define HNS_ROCE_VF_MPT_BT_NUM			64
-#define HNS_ROCE_VF_SMAC_NUM			32
-#define HNS_ROCE_VF_SL_NUM			8
-#define HNS_ROCE_VF_GMV_BT_NUM			256
-
 #define HNS_ROCE_V2_MAX_QP_NUM			0x1000
 #define HNS_ROCE_V2_MAX_QPC_TIMER_NUM		0x200
 #define HNS_ROCE_V2_MAX_WQE_NUM			0x8000
-#define	HNS_ROCE_V2_MAX_SRQ			0x100000
 #define HNS_ROCE_V2_MAX_SRQ_WR			0x8000
 #define HNS_ROCE_V2_MAX_SRQ_SGE			64
 #define HNS_ROCE_V2_MAX_CQ_NUM			0x100000
 #define HNS_ROCE_V2_MAX_CQC_TIMER_NUM		0x100
 #define HNS_ROCE_V2_MAX_SRQ_NUM			0x100000
 #define HNS_ROCE_V2_MAX_CQE_NUM			0x400000
-#define HNS_ROCE_V2_MAX_SRQWQE_NUM		0x8000
 #define HNS_ROCE_V2_MAX_RQ_SGE_NUM		64
 #define HNS_ROCE_V2_MAX_SQ_SGE_NUM		64
 #define HNS_ROCE_V2_MAX_EXTEND_SGE_NUM		0x200000
@@ -63,13 +52,10 @@
 #define HNS_ROCE_V2_MAX_RC_INL_INN_SZ		32
 #define HNS_ROCE_V2_UAR_NUM			256
 #define HNS_ROCE_V2_PHY_UAR_NUM			1
-#define HNS_ROCE_V2_MAX_IRQ_NUM			65
-#define HNS_ROCE_V2_COMP_VEC_NUM		63
 #define HNS_ROCE_V2_AEQE_VEC_NUM		1
 #define HNS_ROCE_V2_ABNORMAL_VEC_NUM		1
 #define HNS_ROCE_V2_MAX_MTPT_NUM		0x100000
 #define HNS_ROCE_V2_MAX_MTT_SEGS		0x1000000
-#define HNS_ROCE_V2_MAX_CQE_SEGS		0x1000000
 #define HNS_ROCE_V2_MAX_SRQWQE_SEGS		0x1000000
 #define HNS_ROCE_V2_MAX_IDX_SEGS		0x1000000
 #define HNS_ROCE_V2_MAX_PD_NUM			0x1000000
@@ -81,7 +67,6 @@
 #define HNS_ROCE_V2_MAX_RQ_DESC_SZ		16
 #define HNS_ROCE_V2_MAX_SRQ_DESC_SZ		64
 #define HNS_ROCE_V2_IRRL_ENTRY_SZ		64
-#define HNS_ROCE_V2_TRRL_ENTRY_SZ		48
 #define HNS_ROCE_V2_EXT_ATOMIC_TRRL_ENTRY_SZ	100
 #define HNS_ROCE_V2_CQC_ENTRY_SZ		64
 #define HNS_ROCE_V2_SRQC_ENTRY_SZ		64
@@ -103,7 +88,6 @@
 #define HNS_ROCE_INVALID_LKEY			0x0
 #define HNS_ROCE_INVALID_SGE_LENGTH		0x80000000
 #define HNS_ROCE_CMQ_TX_TIMEOUT			30000
-#define HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE	2
 #define HNS_ROCE_V2_RSV_QPS			8
 
 #define HNS_ROCE_V2_HW_RST_TIMEOUT		1000
-- 
2.33.0

