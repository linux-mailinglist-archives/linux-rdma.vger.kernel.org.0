Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADE77CC3B9
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Oct 2023 14:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjJQM4A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Oct 2023 08:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbjJQMz7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Oct 2023 08:55:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD15FB;
        Tue, 17 Oct 2023 05:55:56 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S8v4p10nnzCrPb;
        Tue, 17 Oct 2023 20:51:54 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 17 Oct 2023 20:55:52 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-rc 4/7] RDMA/hns: Add check for SL
Date:   Tue, 17 Oct 2023 20:52:36 +0800
Message-ID: <20231017125239.164455-5-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231017125239.164455-1-huangjunxian6@hisilicon.com>
References: <20231017125239.164455-1-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Luoyouming <luoyouming@huawei.com>

SL set by users may exceed the capability of devices. So add check
for this situation.

Fixes: fba429fcf9a5 ("RDMA/hns: Fix missing fields in address vector")
Fixes: 70f92521584f ("RDMA/hns: Use the reserved loopback QPs to free MR before destroying MPT")
Fixes: f0cb411aad23 ("RDMA/hns: Use new interface to modify QP context")
Signed-off-by: Luoyouming <luoyouming@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_ah.c    | 13 +++++++++++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 23 ++++++++++++----------
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_ah.c b/drivers/infiniband/hw/hns/hns_roce_ah.c
index e77fcc74f15c..3df032ddda18 100644
--- a/drivers/infiniband/hw/hns/hns_roce_ah.c
+++ b/drivers/infiniband/hw/hns/hns_roce_ah.c
@@ -33,7 +33,9 @@
 #include <linux/pci.h>
 #include <rdma/ib_addr.h>
 #include <rdma/ib_cache.h>
+#include "hnae3.h"
 #include "hns_roce_device.h"
+#include "hns_roce_hw_v2.h"
 
 static inline u16 get_ah_udp_sport(const struct rdma_ah_attr *ah_attr)
 {
@@ -57,6 +59,7 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibah->device);
 	struct hns_roce_ah *ah = to_hr_ah(ibah);
 	int ret = 0;
+	u32 max_sl;
 
 	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08 && udata)
 		return -EOPNOTSUPP;
@@ -70,9 +73,17 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	ah->av.hop_limit = grh->hop_limit;
 	ah->av.flowlabel = grh->flow_label;
 	ah->av.udp_sport = get_ah_udp_sport(ah_attr);
-	ah->av.sl = rdma_ah_get_sl(ah_attr);
 	ah->av.tclass = get_tclass(grh);
 
+	ah->av.sl = rdma_ah_get_sl(ah_attr);
+	max_sl = min_t(u32, MAX_SERVICE_LEVEL, hr_dev->caps.sl_num - 1);
+	if (unlikely(ah->av.sl > max_sl)) {
+		ibdev_err_ratelimited(&hr_dev->ib_dev,
+				      "failed to set sl, sl (%u) shouldn't be larger than %u.\n",
+				      ah->av.sl, max_sl);
+		return -EINVAL;
+	}
+
 	memcpy(ah->av.dgid, grh->dgid.raw, HNS_ROCE_GID_SIZE);
 	memcpy(ah->av.mac, ah_attr->roce.dmac, ETH_ALEN);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 3daa684f8836..b7faf5c8f6ba 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4821,22 +4821,32 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	const struct ib_gid_attr *gid_attr = NULL;
+	u8 sl = rdma_ah_get_sl(&attr->ah_attr);
 	int is_roce_protocol;
 	u16 vlan_id = 0xffff;
 	bool is_udp = false;
+	u32 max_sl;
 	u8 ib_port;
 	u8 hr_port;
 	int ret;
 
+	max_sl = min_t(u32, MAX_SERVICE_LEVEL, hr_dev->caps.sl_num - 1);
+	if (unlikely(sl > max_sl)) {
+		ibdev_err_ratelimited(ibdev,
+				      "failed to fill QPC, sl (%u) shouldn't be larger than %u.\n",
+				      sl, max_sl);
+		return -EINVAL;
+	}
+
 	/*
 	 * If free_mr_en of qp is set, it means that this qp comes from
 	 * free mr. This qp will perform the loopback operation.
 	 * In the loopback scenario, only sl needs to be set.
 	 */
 	if (hr_qp->free_mr_en) {
-		hr_reg_write(context, QPC_SL, rdma_ah_get_sl(&attr->ah_attr));
+		hr_reg_write(context, QPC_SL, sl);
 		hr_reg_clear(qpc_mask, QPC_SL);
-		hr_qp->sl = rdma_ah_get_sl(&attr->ah_attr);
+		hr_qp->sl = sl;
 		return 0;
 	}
 
@@ -4903,14 +4913,7 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 	memcpy(context->dgid, grh->dgid.raw, sizeof(grh->dgid.raw));
 	memset(qpc_mask->dgid, 0, sizeof(grh->dgid.raw));
 
-	hr_qp->sl = rdma_ah_get_sl(&attr->ah_attr);
-	if (unlikely(hr_qp->sl > MAX_SERVICE_LEVEL)) {
-		ibdev_err(ibdev,
-			  "failed to fill QPC, sl (%u) shouldn't be larger than %d.\n",
-			  hr_qp->sl, MAX_SERVICE_LEVEL);
-		return -EINVAL;
-	}
-
+	hr_qp->sl = sl;
 	hr_reg_write(context, QPC_SL, hr_qp->sl);
 	hr_reg_clear(qpc_mask, QPC_SL);
 
-- 
2.30.0

