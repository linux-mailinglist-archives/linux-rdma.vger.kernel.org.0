Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEED64FA607
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Apr 2022 10:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbiDIIfo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 9 Apr 2022 04:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbiDIIfk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 9 Apr 2022 04:35:40 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B05025E9E
        for <linux-rdma@vger.kernel.org>; Sat,  9 Apr 2022 01:33:34 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Kb7fj6mJFz1HBYb;
        Sat,  9 Apr 2022 16:33:01 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 9 Apr 2022 16:33:32 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 9 Apr 2022 16:33:32 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 2/5] RDMA/hns: Remove unused function to_hns_roce_state()
Date:   Sat, 9 Apr 2022 16:32:51 +0800
Message-ID: <20220409083254.9696-3-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220409083254.9696-1-liangwenpeng@huawei.com>
References: <20220409083254.9696-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixing Liu <liuyixing1@huawei.com>

This function is only used in HIP06, which has been removed. So remove it.

Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 11 -----------
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 20 --------------------
 2 files changed, 31 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 3083d6db1d68..bc9f25e79c87 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -106,16 +106,6 @@ enum {
 	SERV_TYPE_XRC = 5,
 };
 
-enum hns_roce_qp_state {
-	HNS_ROCE_QP_STATE_RST,
-	HNS_ROCE_QP_STATE_INIT,
-	HNS_ROCE_QP_STATE_RTR,
-	HNS_ROCE_QP_STATE_RTS,
-	HNS_ROCE_QP_STATE_SQD,
-	HNS_ROCE_QP_STATE_ERR,
-	HNS_ROCE_QP_NUM_STATE,
-};
-
 enum hns_roce_event {
 	HNS_ROCE_EVENT_TYPE_PATH_MIG                  = 0x01,
 	HNS_ROCE_EVENT_TYPE_PATH_MIG_FAILED           = 0x02,
@@ -1191,7 +1181,6 @@ void *hns_roce_get_send_wqe(struct hns_roce_qp *hr_qp, unsigned int n);
 void *hns_roce_get_extend_sge(struct hns_roce_qp *hr_qp, unsigned int n);
 bool hns_roce_wq_overflow(struct hns_roce_wq *hr_wq, u32 nreq,
 			  struct ib_cq *ib_cq);
-enum hns_roce_qp_state to_hns_roce_state(enum ib_qp_state state);
 void hns_roce_lock_cqs(struct hns_roce_cq *send_cq,
 		       struct hns_roce_cq *recv_cq);
 void hns_roce_unlock_cqs(struct hns_roce_cq *send_cq,
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index d78373e10aab..48d3616a6d71 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -243,26 +243,6 @@ static int alloc_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 	return 0;
 }
 
-enum hns_roce_qp_state to_hns_roce_state(enum ib_qp_state state)
-{
-	switch (state) {
-	case IB_QPS_RESET:
-		return HNS_ROCE_QP_STATE_RST;
-	case IB_QPS_INIT:
-		return HNS_ROCE_QP_STATE_INIT;
-	case IB_QPS_RTR:
-		return HNS_ROCE_QP_STATE_RTR;
-	case IB_QPS_RTS:
-		return HNS_ROCE_QP_STATE_RTS;
-	case IB_QPS_SQD:
-		return HNS_ROCE_QP_STATE_SQD;
-	case IB_QPS_ERR:
-		return HNS_ROCE_QP_STATE_ERR;
-	default:
-		return HNS_ROCE_QP_NUM_STATE;
-	}
-}
-
 static void add_qp_to_list(struct hns_roce_dev *hr_dev,
 			   struct hns_roce_qp *hr_qp,
 			   struct ib_cq *send_cq, struct ib_cq *recv_cq)
-- 
2.33.0

