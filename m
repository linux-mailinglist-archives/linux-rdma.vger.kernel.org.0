Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5B460DE6A
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Oct 2022 11:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbiJZJv5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Oct 2022 05:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiJZJvy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Oct 2022 05:51:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F88B7F55
        for <linux-rdma@vger.kernel.org>; Wed, 26 Oct 2022 02:51:52 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4My3qj6Dc0zmVH1;
        Wed, 26 Oct 2022 17:46:57 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 17:51:51 +0800
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 17:51:50 +0800
From:   Haoyue Xu <xuhaoyue1@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <xuhaoyue1@hisilicon.com>
Subject: [PATCH v2 for-rc 5/5] RDMA/hns: Support cqe inline in user space
Date:   Wed, 26 Oct 2022 17:50:54 +0800
Message-ID: <20221026095054.2384620-6-xuhaoyue1@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221026095054.2384620-1-xuhaoyue1@hisilicon.com>
References: <20221026095054.2384620-1-xuhaoyue1@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Luoyouming <luoyouming@huawei.com>

Enable the CQEIE field and configure the CQEIS field of QPC.
And add compatibility handling.

Signed-off-by: Luoyouming <luoyouming@huawei.com>
Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 12 ++++++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  3 ++-
 drivers/infiniband/hw/hns/hns_roce_main.c   |  5 +++++
 include/uapi/rdma/hns-abi.h                 |  2 ++
 5 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 3f6f328d3a3e..893ec7e4e777 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -145,6 +145,7 @@ enum {
 	HNS_ROCE_CAP_FLAG_DIRECT_WQE		= BIT(12),
 	HNS_ROCE_CAP_FLAG_SDI_MODE		= BIT(14),
 	HNS_ROCE_CAP_FLAG_STASH			= BIT(17),
+	HNS_ROCE_CAP_FLAG_CQE_INLINE		= BIT(19),
 	HNS_ROCE_CAP_FLAG_RQ_INLINE		= BIT(20),
 };
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 19e326bda936..7381319d128a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4596,6 +4596,18 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 		hr_reg_clear(qpc_mask, QPC_RQIE);
 	}
 
+	if (udata &&
+	    (ibqp->qp_type == IB_QPT_RC || ibqp->qp_type == IB_QPT_XRC_TGT) &&
+	    (uctx->config & HNS_ROCE_CQE_INLINE_FLAGS)) {
+		hr_reg_write_bool(context, QPC_CQEIE,
+				  hr_dev->caps.flags &
+				  HNS_ROCE_CAP_FLAG_CQE_INLINE);
+		hr_reg_clear(qpc_mask, QPC_CQEIE);
+
+		hr_reg_write(context, QPC_CQEIS, 0);
+		hr_reg_clear(qpc_mask, QPC_CQEIS);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index c7bf2d52c1cd..d1fc76d7d78a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -526,7 +526,8 @@ struct hns_roce_v2_qp_context {
 #define QPC_RQ_RTY_TX_ERR QPC_FIELD_LOC(607, 607)
 #define QPC_RX_CQN QPC_FIELD_LOC(631, 608)
 #define QPC_XRC_QP_TYPE QPC_FIELD_LOC(632, 632)
-#define QPC_RSV3 QPC_FIELD_LOC(634, 633)
+#define QPC_CQEIE QPC_FIELD_LOC(633, 633)
+#define QPC_CQEIS QPC_FIELD_LOC(634, 634)
 #define QPC_MIN_RNR_TIME QPC_FIELD_LOC(639, 635)
 #define QPC_RQ_PRODUCER_IDX QPC_FIELD_LOC(655, 640)
 #define QPC_RQ_CONSUMER_IDX QPC_FIELD_LOC(671, 656)
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index ea1ef395f60f..56ed24501155 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -384,6 +384,11 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 		resp.config |= HNS_ROCE_RSP_RQ_INLINE_FLAGS;
 	}
 
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQE_INLINE) {
+		context->config |= ucmd.config & HNS_ROCE_CQE_INLINE_FLAGS;
+		resp.config |= HNS_ROCE_RSP_CQE_INLINE_FLAGS;
+	}
+
 	ret = hns_roce_uar_alloc(hr_dev, &context->uar);
 	if (ret)
 		goto error_fail_uar_alloc;
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index 9375ac3de059..b2b41d9d0dee 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -88,11 +88,13 @@ struct hns_roce_ib_create_qp_resp {
 enum {
 	HNS_ROCE_EXSGE_FLAGS = 1 << 0,
 	HNS_ROCE_RQ_INLINE_FLAGS = 1 << 1,
+	HNS_ROCE_CQE_INLINE_FLAGS = 1 << 2,
 };
 
 enum {
 	HNS_ROCE_RSP_EXSGE_FLAGS = 1 << 0,
 	HNS_ROCE_RSP_RQ_INLINE_FLAGS = 1 << 1,
+	HNS_ROCE_RSP_CQE_INLINE_FLAGS = 1 << 2,
 };
 
 
-- 
2.30.0

