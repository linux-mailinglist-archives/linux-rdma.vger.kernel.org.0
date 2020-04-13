Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBB8B1A6326
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 08:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgDMGk6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Apr 2020 02:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbgDMGk6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Apr 2020 02:40:58 -0400
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539A2C008679
        for <linux-rdma@vger.kernel.org>; Sun, 12 Apr 2020 23:40:57 -0700 (PDT)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 65B4A369C8F783123CCE;
        Mon, 13 Apr 2020 14:40:52 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 13 Apr 2020 14:40:43 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 6/6] RDMA/hns: Simplify the status judgment code of hns_roce_v1_m_qp()
Date:   Mon, 13 Apr 2020 14:40:42 +0800
Message-ID: <1586760042-40516-7-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1586760042-40516-1-git-send-email-liweihang@huawei.com>
References: <1586760042-40516-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Use status table to reduce cyclomatic complexity.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 42 +++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 5ff028d..697f94b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -2704,6 +2704,28 @@ static int hns_roce_v1_m_sqp(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 	return -EINVAL;
 }
 
+static bool check_qp_state(enum ib_qp_state cur_state,
+			   enum ib_qp_state new_state)
+{
+	bool sm[][IB_QPS_ERR + 1] = {
+		[IB_QPS_RESET] = { [IB_QPS_RESET] = true,
+				   [IB_QPS_INIT] = true },
+		[IB_QPS_INIT] = { [IB_QPS_RESET] = true,
+				  [IB_QPS_INIT] = true,
+				  [IB_QPS_RTR] = true,
+				  [IB_QPS_ERR] = true },
+		[IB_QPS_RTR] = { [IB_QPS_RESET] = true,
+				 [IB_QPS_RTS] = true,
+				 [IB_QPS_ERR] = true },
+		[IB_QPS_RTS] = { [IB_QPS_RESET] = true, [IB_QPS_ERR] = true },
+		[IB_QPS_SQD] = {},
+		[IB_QPS_SQE] = {},
+		[IB_QPS_ERR] = { [IB_QPS_RESET] = true, [IB_QPS_ERR] = true }
+	};
+
+	return sm[cur_state][new_state];
+}
+
 static int hns_roce_v1_m_qp(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 			    int attr_mask, enum ib_qp_state cur_state,
 			    enum ib_qp_state new_state)
@@ -2725,6 +2747,13 @@ static int hns_roce_v1_m_qp(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 	u8 *dmac;
 	u8 *smac;
 
+	if (!check_qp_state(cur_state, new_state)) {
+		ibdev_err(ibqp->device,
+			  "not support QP(%u) status from %d to %d\n",
+			  ibqp->qp_num, cur_state, new_state);
+		return -EINVAL;
+	}
+
 	context = kzalloc(sizeof(*context), GFP_KERNEL);
 	if (!context)
 		return -ENOMEM;
@@ -3062,8 +3091,7 @@ static int hns_roce_v1_m_qp(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 			       QP_CONTEXT_QPC_BYTES_156_SL_S,
 			       rdma_ah_get_sl(&attr->ah_attr));
 		hr_qp->sl = rdma_ah_get_sl(&attr->ah_attr);
-	} else if (cur_state == IB_QPS_RTR &&
-		new_state == IB_QPS_RTS) {
+	} else if (cur_state == IB_QPS_RTR && new_state == IB_QPS_RTS) {
 		/* If exist optional param, return error */
 		if ((attr_mask & IB_QP_ALT_PATH) ||
 		    (attr_mask & IB_QP_ACCESS_FLAGS) ||
@@ -3235,16 +3263,6 @@ static int hns_roce_v1_m_qp(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 			       QP_CONTEXT_QPC_BYTES_188_TX_RETRY_CUR_INDEX_M,
 			       QP_CONTEXT_QPC_BYTES_188_TX_RETRY_CUR_INDEX_S,
 			       0);
-	} else if (!((cur_state == IB_QPS_INIT && new_state == IB_QPS_RESET) ||
-		   (cur_state == IB_QPS_INIT && new_state == IB_QPS_ERR) ||
-		   (cur_state == IB_QPS_RTR && new_state == IB_QPS_RESET) ||
-		   (cur_state == IB_QPS_RTR && new_state == IB_QPS_ERR) ||
-		   (cur_state == IB_QPS_RTS && new_state == IB_QPS_RESET) ||
-		   (cur_state == IB_QPS_RTS && new_state == IB_QPS_ERR) ||
-		   (cur_state == IB_QPS_ERR && new_state == IB_QPS_RESET) ||
-		   (cur_state == IB_QPS_ERR && new_state == IB_QPS_ERR))) {
-		dev_err(dev, "not support this status migration\n");
-		goto out;
 	}
 
 	/* Every status migrate must change state */
-- 
2.8.1

