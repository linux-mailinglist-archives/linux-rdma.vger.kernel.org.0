Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C5770DC55
	for <lists+linux-rdma@lfdr.de>; Tue, 23 May 2023 14:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbjEWMSx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 May 2023 08:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbjEWMSv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 May 2023 08:18:51 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FE9118;
        Tue, 23 May 2023 05:18:50 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QQYGn1b5WzLmFy;
        Tue, 23 May 2023 20:17:21 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 20:18:48 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-rc 1/3] RDMA/hns: Remove unnecessary QP type checks
Date:   Tue, 23 May 2023 20:16:39 +0800
Message-ID: <20230523121641.3132102-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230523121641.3132102-1-huangjunxian6@hisilicon.com>
References: <20230523121641.3132102-1-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It is not necessary to check the type of the queue on IO path
because unsupported QP type cannot be created.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d4c6b9bc0a4e..673fd31b9ecf 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -373,17 +373,10 @@ static int check_send_valid(struct hns_roce_dev *hr_dev,
 			    struct hns_roce_qp *hr_qp)
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
-	struct ib_qp *ibqp = &hr_qp->ibqp;
 
-	if (unlikely(ibqp->qp_type != IB_QPT_RC &&
-		     ibqp->qp_type != IB_QPT_GSI &&
-		     ibqp->qp_type != IB_QPT_UD)) {
-		ibdev_err(ibdev, "not supported QP(0x%x)type!\n",
-			  ibqp->qp_type);
-		return -EOPNOTSUPP;
-	} else if (unlikely(hr_qp->state == IB_QPS_RESET ||
-		   hr_qp->state == IB_QPS_INIT ||
-		   hr_qp->state == IB_QPS_RTR)) {
+	if (unlikely(hr_qp->state == IB_QPS_RESET ||
+		     hr_qp->state == IB_QPS_INIT ||
+		     hr_qp->state == IB_QPS_RTR)) {
 		ibdev_err(ibdev, "failed to post WQE, QP state %u!\n",
 			  hr_qp->state);
 		return -EINVAL;
@@ -772,15 +765,6 @@ static int check_recv_valid(struct hns_roce_dev *hr_dev,
 			    struct hns_roce_qp *hr_qp)
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
-	struct ib_qp *ibqp = &hr_qp->ibqp;
-
-	if (unlikely(ibqp->qp_type != IB_QPT_RC &&
-		     ibqp->qp_type != IB_QPT_GSI &&
-		     ibqp->qp_type != IB_QPT_UD)) {
-		ibdev_err(ibdev, "unsupported qp type, qp_type = %d.\n",
-			  ibqp->qp_type);
-		return -EOPNOTSUPP;
-	}
 
 	if (unlikely(hr_dev->state >= HNS_ROCE_DEVICE_STATE_RST_DOWN))
 		return -EIO;
-- 
2.30.0

