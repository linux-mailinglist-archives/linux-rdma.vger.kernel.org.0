Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 626FD1A6325
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 08:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgDMGk6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Apr 2020 02:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbgDMGk5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Apr 2020 02:40:57 -0400
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC847C008677
        for <linux-rdma@vger.kernel.org>; Sun, 12 Apr 2020 23:40:56 -0700 (PDT)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5DFDD77E69F0E7AC114B;
        Mon, 13 Apr 2020 14:40:52 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 13 Apr 2020 14:40:42 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 5/6] RDMA/hns: Simplify the state judgment code of qp
Date:   Mon, 13 Apr 2020 14:40:41 +0800
Message-ID: <1586760042-40516-6-git-send-email-liweihang@huawei.com>
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

Use state table to make the qp state migrate code more readable.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 54 +++++++++++++++---------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index c2d2c9e..7949591 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4078,21 +4078,6 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
 	return 0;
 }
 
-static inline bool hns_roce_v2_check_qp_stat(enum ib_qp_state cur_state,
-					     enum ib_qp_state new_state)
-{
-
-	if ((cur_state != IB_QPS_RESET &&
-	    (new_state == IB_QPS_ERR || new_state == IB_QPS_RESET)) ||
-	    ((cur_state == IB_QPS_RTS || cur_state == IB_QPS_SQD) &&
-	    (new_state == IB_QPS_RTS || new_state == IB_QPS_SQD)) ||
-	    (cur_state == IB_QPS_SQE && new_state == IB_QPS_RTS))
-		return true;
-
-	return false;
-
-}
-
 static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 				const struct ib_qp_attr *attr,
 				int attr_mask,
@@ -4196,6 +4181,28 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 	return 0;
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
 static int hns_roce_v2_set_abs_fields(struct ib_qp *ibqp,
 				      const struct ib_qp_attr *attr,
 				      int attr_mask,
@@ -4207,6 +4214,11 @@ static int hns_roce_v2_set_abs_fields(struct ib_qp *ibqp,
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	int ret = 0;
 
+	if (!check_qp_state(cur_state, new_state)) {
+		ibdev_err(&hr_dev->ib_dev, "Illegal state for QP!\n");
+		return -EINVAL;
+	}
+
 	if (cur_state == IB_QPS_RESET && new_state == IB_QPS_INIT) {
 		memset(qpc_mask, 0, sizeof(*qpc_mask));
 		modify_qp_reset_to_init(ibqp, attr, attr_mask, context,
@@ -4217,23 +4229,11 @@ static int hns_roce_v2_set_abs_fields(struct ib_qp *ibqp,
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_RTR) {
 		ret = modify_qp_init_to_rtr(ibqp, attr, attr_mask, context,
 					    qpc_mask);
-		if (ret)
-			goto out;
 	} else if (cur_state == IB_QPS_RTR && new_state == IB_QPS_RTS) {
 		ret = modify_qp_rtr_to_rts(ibqp, attr, attr_mask, context,
 					   qpc_mask);
-		if (ret)
-			goto out;
-	} else if (hns_roce_v2_check_qp_stat(cur_state, new_state)) {
-		/* Nothing */
-		;
-	} else {
-		ibdev_err(&hr_dev->ib_dev, "Illegal state for QP!\n");
-		ret = -EINVAL;
-		goto out;
 	}
 
-out:
 	return ret;
 }
 
-- 
2.8.1

