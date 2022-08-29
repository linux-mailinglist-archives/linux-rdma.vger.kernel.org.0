Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0405A4791
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 12:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiH2KvE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 06:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiH2KvC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 06:51:02 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF50143E7F
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 03:51:00 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MGRw96TJSz1N7H9;
        Mon, 29 Aug 2022 18:47:21 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 18:50:58 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 18:50:58 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 3/4] RDMA/hns: Remove the num_qpc_timer variable
Date:   Mon, 29 Aug 2022 18:50:20 +0800
Message-ID: <20220829105021.1427804-4-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20220829105021.1427804-1-liangwenpeng@huawei.com>
References: <20220829105021.1427804-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixing Liu <liuyixing1@huawei.com>

The bt number of qpc_timer of HIP09 increases compared with that of HIP08.
Therefore, qpc_timer_bt_num and num_qpc_timer do not match. As a result,
the driver may fail to allocate qpc_timer. So the driver needs to uniquely
uses qpc_timer_bt_num to represent the bt number of qpc_timer.

Fixes: 0e40dc2f70cd ("RDMA/hns: Add timer allocation support for hip08")
Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 3 +--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 2 +-
 drivers/infiniband/hw/hns/hns_roce_main.c   | 2 +-
 4 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 1bcecc5589fa..22c5e9a564e0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -730,7 +730,6 @@ struct hns_roce_caps {
 	u32		num_qps;
 	u32		num_pi_qps;
 	u32		reserved_qps;
-	int		num_qpc_timer;
 	u32		num_srqs;
 	u32		max_wqes;
 	u32		max_srq_wrs;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index fa78b141dff2..9b71ea8040c1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1977,7 +1977,7 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 
 	caps->num_mtpts		= HNS_ROCE_V2_MAX_MTPT_NUM;
 	caps->num_pds		= HNS_ROCE_V2_MAX_PD_NUM;
-	caps->num_qpc_timer	= HNS_ROCE_V2_MAX_QPC_TIMER_NUM;
+	caps->qpc_timer_bt_num	= HNS_ROCE_V2_MAX_QPC_TIMER_BT_NUM;
 	caps->cqc_timer_bt_num	= HNS_ROCE_V2_MAX_CQC_TIMER_BT_NUM;
 
 	caps->max_qp_init_rdma	= HNS_ROCE_V2_MAX_QP_INIT_RDMA;
@@ -2273,7 +2273,6 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	caps->max_rq_sg		     = le16_to_cpu(resp_a->max_rq_sg);
 	caps->max_rq_sg = roundup_pow_of_two(caps->max_rq_sg);
 	caps->max_extend_sg	     = le32_to_cpu(resp_a->max_extend_sg);
-	caps->num_qpc_timer	     = le16_to_cpu(resp_a->num_qpc_timer);
 	caps->max_srq_sges	     = le16_to_cpu(resp_a->max_srq_sges);
 	caps->max_srq_sges = roundup_pow_of_two(caps->max_srq_sges);
 	caps->num_aeq_vectors	     = resp_a->num_aeq_vectors;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index c170cd2fe03f..da39e9a95c7e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -36,11 +36,11 @@
 #include <linux/bitops.h>
 
 #define HNS_ROCE_V2_MAX_QP_NUM			0x1000
-#define HNS_ROCE_V2_MAX_QPC_TIMER_NUM		0x200
 #define HNS_ROCE_V2_MAX_WQE_NUM			0x8000
 #define HNS_ROCE_V2_MAX_SRQ_WR			0x8000
 #define HNS_ROCE_V2_MAX_SRQ_SGE			64
 #define HNS_ROCE_V2_MAX_CQ_NUM			0x100000
+#define HNS_ROCE_V2_MAX_QPC_TIMER_BT_NUM	0x100
 #define HNS_ROCE_V2_MAX_CQC_TIMER_BT_NUM	0x100
 #define HNS_ROCE_V2_MAX_SRQ_NUM			0x100000
 #define HNS_ROCE_V2_MAX_CQE_NUM			0x400000
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 9de3a522980a..686b1235fe11 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -734,7 +734,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 		ret = hns_roce_init_hem_table(hr_dev, &hr_dev->qpc_timer_table,
 					      HEM_TYPE_QPC_TIMER,
 					      hr_dev->caps.qpc_timer_entry_sz,
-					      hr_dev->caps.num_qpc_timer, 1);
+					      hr_dev->caps.qpc_timer_bt_num, 1);
 		if (ret) {
 			dev_err(dev,
 				"Failed to init QPC timer memory, aborting.\n");
-- 
2.30.0

