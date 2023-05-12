Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72B67003A9
	for <lists+linux-rdma@lfdr.de>; Fri, 12 May 2023 11:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240374AbjELJYt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 May 2023 05:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240275AbjELJYs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 May 2023 05:24:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E869DE72B;
        Fri, 12 May 2023 02:24:46 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QHjsJ1T2wzTkd5;
        Fri, 12 May 2023 17:20:04 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 12 May 2023 17:24:44 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-rc 1/3] RDMA/hns: Fix timeout attr in query qp for HIP08
Date:   Fri, 12 May 2023 17:22:43 +0800
Message-ID: <20230512092245.344442-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230512092245.344442-1-huangjunxian6@hisilicon.com>
References: <20230512092245.344442-1-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Chengchang Tang <tangchengchang@huawei.com>

On HIP08, the queried timeout attr is different from the
timeout attr configured by the user.

It is found by rdma-core testcase test_rdmacm_async_traffic:

======================================================================
FAIL: test_rdmacm_async_traffic (tests.test_rdmacm.CMTestCase)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "./tests/test_rdmacm.py", line 33, in test_rdmacm_async_traffic
    self.two_nodes_rdmacm_traffic(CMAsyncConnection, self.rdmacm_traffic,
  File "./tests/base.py", line 382, in two_nodes_rdmacm_traffic
    raise(res)
AssertionError

Fixes: 926a01dc000d ("RDMA/hns: Add QP operations support for hip08 SoC")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 17 ++++++++++++++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  2 ++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 84f1167de1d9..3a1c90406ed9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5012,7 +5012,6 @@ static int hns_roce_v2_set_abs_fields(struct ib_qp *ibqp,
 static bool check_qp_timeout_cfg_range(struct hns_roce_dev *hr_dev, u8 *timeout)
 {
 #define QP_ACK_TIMEOUT_MAX_HIP08 20
-#define QP_ACK_TIMEOUT_OFFSET 10
 #define QP_ACK_TIMEOUT_MAX 31
 
 	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08) {
@@ -5021,7 +5020,7 @@ static bool check_qp_timeout_cfg_range(struct hns_roce_dev *hr_dev, u8 *timeout)
 				   "local ACK timeout shall be 0 to 20.\n");
 			return false;
 		}
-		*timeout += QP_ACK_TIMEOUT_OFFSET;
+		*timeout += HNS_ROCE_V2_QP_ACK_TIMEOUT_OFS_HIP08;
 	} else if (hr_dev->pci_dev->revision > PCI_REVISION_ID_HIP08) {
 		if (*timeout > QP_ACK_TIMEOUT_MAX) {
 			ibdev_warn(&hr_dev->ib_dev,
@@ -5307,6 +5306,18 @@ static int hns_roce_v2_query_qpc(struct hns_roce_dev *hr_dev, u32 qpn,
 	return ret;
 }
 
+static u8 get_qp_timeout_attr(struct hns_roce_dev *hr_dev,
+			      struct hns_roce_v2_qp_context *context)
+{
+	u8 timeout;
+
+	timeout = (u8)hr_reg_read(context, QPC_AT);
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08)
+		timeout -= HNS_ROCE_V2_QP_ACK_TIMEOUT_OFS_HIP08;
+
+	return timeout;
+}
+
 static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 				int qp_attr_mask,
 				struct ib_qp_init_attr *qp_init_attr)
@@ -5384,7 +5395,7 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	qp_attr->max_dest_rd_atomic = 1 << hr_reg_read(&context, QPC_RR_MAX);
 
 	qp_attr->min_rnr_timer = (u8)hr_reg_read(&context, QPC_MIN_RNR_TIME);
-	qp_attr->timeout = (u8)hr_reg_read(&context, QPC_AT);
+	qp_attr->timeout = get_qp_timeout_attr(hr_dev, &context);
 	qp_attr->retry_cnt = hr_reg_read(&context, QPC_RETRY_NUM_INIT);
 	qp_attr->rnr_retry = hr_reg_read(&context, QPC_RNR_NUM_INIT);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 1b44d2434ab4..7033eae2407c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -44,6 +44,8 @@
 #define HNS_ROCE_V2_MAX_XRCD_NUM		0x1000000
 #define HNS_ROCE_V2_RSV_XRCD_NUM		0
 
+#define HNS_ROCE_V2_QP_ACK_TIMEOUT_OFS_HIP08    10
+
 #define HNS_ROCE_V3_SCCC_SZ			64
 #define HNS_ROCE_V3_GMV_ENTRY_SZ		32
 
-- 
2.30.0

