Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5DA74FEF2
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jul 2023 08:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjGLGDS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jul 2023 02:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjGLGDQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jul 2023 02:03:16 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229A810C4;
        Tue, 11 Jul 2023 23:03:04 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R16Y52ltgzPkG1;
        Wed, 12 Jul 2023 14:00:41 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 14:03:00 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-rc 1/3] RDMA/hns: support get xrcd num from firmware
Date:   Wed, 12 Jul 2023 14:00:31 +0800
Message-ID: <20230712060033.15961-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230712060033.15961-1-huangjunxian6@hisilicon.com>
References: <20230712060033.15961-1-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Luoyouming <luoyouming@huawei.com>

Support driver get the num of xrcd from firmware

Signed-off-by: Luoyouming <luoyouming@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 5 ++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 3 ++-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d4c6b9bc0a4e..fb3ce4af22b5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2093,9 +2093,6 @@ static void apply_func_caps(struct hns_roce_dev *hr_dev)
 	caps->qpc_timer_hop_num = HNS_ROCE_HOP_NUM_0;
 	caps->cqc_timer_hop_num = HNS_ROCE_HOP_NUM_0;
 
-	caps->num_xrcds = HNS_ROCE_V2_MAX_XRCD_NUM;
-	caps->reserved_xrcds = HNS_ROCE_V2_RSV_XRCD_NUM;
-
 	caps->num_srqwqe_segs = HNS_ROCE_V2_MAX_SRQWQE_SEGS;
 	caps->num_idx_segs = HNS_ROCE_V2_MAX_IDX_SEGS;
 
@@ -2218,6 +2215,7 @@ static int hns_roce_query_caps(struct hns_roce_dev *hr_dev)
 	caps->num_cqs = 1 << hr_reg_read(resp_c, PF_CAPS_C_NUM_CQS);
 	caps->gid_table_len[0] = hr_reg_read(resp_c, PF_CAPS_C_MAX_GID);
 	caps->max_cqes = 1 << hr_reg_read(resp_c, PF_CAPS_C_CQ_DEPTH);
+	caps->num_xrcds = 1 << hr_reg_read(resp_c, PF_CAPS_C_NUM_XRCDS);
 	caps->num_mtpts = 1 << hr_reg_read(resp_c, PF_CAPS_C_NUM_MRWS);
 	caps->num_qps = 1 << hr_reg_read(resp_c, PF_CAPS_C_NUM_QPS);
 	caps->max_qp_init_rdma = hr_reg_read(resp_c, PF_CAPS_C_MAX_ORD);
@@ -2238,6 +2236,7 @@ static int hns_roce_query_caps(struct hns_roce_dev *hr_dev)
 	caps->reserved_mrws = hr_reg_read(resp_e, PF_CAPS_E_RSV_MRWS);
 	caps->chunk_sz = 1 << hr_reg_read(resp_e, PF_CAPS_E_CHUNK_SIZE_SHIFT);
 	caps->reserved_cqs = hr_reg_read(resp_e, PF_CAPS_E_RSV_CQS);
+	caps->reserved_xrcds = hr_reg_read(resp_e, PF_CAPS_E_RSV_XRCDS);
 	caps->reserved_srqs = hr_reg_read(resp_e, PF_CAPS_E_RSV_SRQS);
 	caps->reserved_lkey = hr_reg_read(resp_e, PF_CAPS_E_RSV_LKEYS);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 7033eae2407c..2b87f0cf06ec 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -42,7 +42,6 @@
 #define HNS_ROCE_V2_MAX_SRQWQE_SEGS		0x1000000
 #define HNS_ROCE_V2_MAX_IDX_SEGS		0x1000000
 #define HNS_ROCE_V2_MAX_XRCD_NUM		0x1000000
-#define HNS_ROCE_V2_RSV_XRCD_NUM		0
 
 #define HNS_ROCE_V2_QP_ACK_TIMEOUT_OFS_HIP08    10
 
@@ -1202,6 +1201,7 @@ struct hns_roce_query_pf_caps_c {
 #define PF_CAPS_C_NUM_CQS PF_CAPS_C_FIELD_LOC(51, 32)
 #define PF_CAPS_C_MAX_GID PF_CAPS_C_FIELD_LOC(60, 52)
 #define PF_CAPS_C_CQ_DEPTH PF_CAPS_C_FIELD_LOC(86, 64)
+#define PF_CAPS_C_NUM_XRCDS PF_CAPS_C_FIELD_LOC(91, 87)
 #define PF_CAPS_C_NUM_MRWS PF_CAPS_C_FIELD_LOC(115, 96)
 #define PF_CAPS_C_NUM_QPS PF_CAPS_C_FIELD_LOC(147, 128)
 #define PF_CAPS_C_MAX_ORD PF_CAPS_C_FIELD_LOC(155, 148)
@@ -1260,6 +1260,7 @@ struct hns_roce_query_pf_caps_e {
 #define PF_CAPS_E_RSV_MRWS PF_CAPS_E_FIELD_LOC(19, 0)
 #define PF_CAPS_E_CHUNK_SIZE_SHIFT PF_CAPS_E_FIELD_LOC(31, 20)
 #define PF_CAPS_E_RSV_CQS PF_CAPS_E_FIELD_LOC(51, 32)
+#define PF_CAPS_E_RSV_XRCDS PF_CAPS_E_FIELD_LOC(63, 52)
 #define PF_CAPS_E_RSV_SRQS PF_CAPS_E_FIELD_LOC(83, 64)
 #define PF_CAPS_E_RSV_LKEYS PF_CAPS_E_FIELD_LOC(115, 96)
 
-- 
2.30.0

