Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7084151457F
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Apr 2022 11:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347753AbiD2Jj6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Apr 2022 05:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiD2Jj6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Apr 2022 05:39:58 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409448AE4D
        for <linux-rdma@vger.kernel.org>; Fri, 29 Apr 2022 02:36:40 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KqS5n6bNGz1JBmy;
        Fri, 29 Apr 2022 17:35:41 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 17:36:38 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 17:36:38 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Remove the num_cqc_timer variable
Date:   Fri, 29 Apr 2022 17:35:45 +0800
Message-ID: <20220429093545.58070-1-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixing Liu <liuyixing1@huawei.com>

The bt number of cqc_timer of HIP09 increases compared with that of HIP08.
Therefore, cqc_timer_bt_num and num_cqc_timer do not match. As a result,
the driver may fail to allocate cqc_timer. So the driver needs to
uniquely uses cqc_timer_bt_num to represent the bt number of cqc_timer.

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
index bc9f25e79c87..0a54ed778f69 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -715,7 +715,6 @@ struct hns_roce_caps {
 	u32		num_pi_qps;
 	u32		reserved_qps;
 	int		num_qpc_timer;
-	int		num_cqc_timer;
 	u32		num_srqs;
 	u32		max_wqes;
 	u32		max_srq_wrs;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 2abed0e3dfd8..57d531961d63 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1957,7 +1957,7 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->num_mtpts		= HNS_ROCE_V2_MAX_MTPT_NUM;
 	caps->num_pds		= HNS_ROCE_V2_MAX_PD_NUM;
 	caps->num_qpc_timer	= HNS_ROCE_V2_MAX_QPC_TIMER_NUM;
-	caps->num_cqc_timer	= HNS_ROCE_V2_MAX_CQC_TIMER_NUM;
+	caps->cqc_timer_bt_num	= HNS_ROCE_V2_MAX_CQC_TIMER_BT_NUM;
 
 	caps->max_qp_init_rdma	= HNS_ROCE_V2_MAX_QP_INIT_RDMA;
 	caps->max_qp_dest_rdma	= HNS_ROCE_V2_MAX_QP_DEST_RDMA;
@@ -2253,7 +2253,6 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	caps->max_rq_sg = roundup_pow_of_two(caps->max_rq_sg);
 	caps->max_extend_sg	     = le32_to_cpu(resp_a->max_extend_sg);
 	caps->num_qpc_timer	     = le16_to_cpu(resp_a->num_qpc_timer);
-	caps->num_cqc_timer	     = le16_to_cpu(resp_a->num_cqc_timer);
 	caps->max_srq_sges	     = le16_to_cpu(resp_a->max_srq_sges);
 	caps->max_srq_sges = roundup_pow_of_two(caps->max_srq_sges);
 	caps->num_aeq_vectors	     = resp_a->num_aeq_vectors;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 0d87b627601e..9cbb230de03b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -41,7 +41,7 @@
 #define HNS_ROCE_V2_MAX_SRQ_WR			0x8000
 #define HNS_ROCE_V2_MAX_SRQ_SGE			64
 #define HNS_ROCE_V2_MAX_CQ_NUM			0x100000
-#define HNS_ROCE_V2_MAX_CQC_TIMER_NUM		0x100
+#define HNS_ROCE_V2_MAX_CQC_TIMER_BT_NUM	0x100
 #define HNS_ROCE_V2_MAX_SRQ_NUM			0x100000
 #define HNS_ROCE_V2_MAX_CQE_NUM			0x400000
 #define HNS_ROCE_V2_MAX_RQ_SGE_NUM		64
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index f73ba619f375..c8af4ebd7cbd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -737,7 +737,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 		ret = hns_roce_init_hem_table(hr_dev, &hr_dev->cqc_timer_table,
 					      HEM_TYPE_CQC_TIMER,
 					      hr_dev->caps.cqc_timer_entry_sz,
-					      hr_dev->caps.num_cqc_timer, 1);
+					      hr_dev->caps.cqc_timer_bt_num, 1);
 		if (ret) {
 			dev_err(dev,
 				"Failed to init CQC timer memory, aborting.\n");
-- 
2.33.0

