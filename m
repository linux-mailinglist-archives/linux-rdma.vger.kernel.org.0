Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81AB01A6322
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 08:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgDMGk5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Apr 2020 02:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbgDMGk5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Apr 2020 02:40:57 -0400
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E35AC008674
        for <linux-rdma@vger.kernel.org>; Sun, 12 Apr 2020 23:40:55 -0700 (PDT)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 56C47DB07D02390170F8;
        Mon, 13 Apr 2020 14:40:52 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 13 Apr 2020 14:40:42 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 3/6] RDMA/hns: Simplify the qp state convert code
Date:   Mon, 13 Apr 2020 14:40:39 +0800
Message-ID: <1586760042-40516-4-git-send-email-liweihang@huawei.com>
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

Use type map table to reduce the cyclomatic complexity.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 6816278..e938bd8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4540,19 +4540,20 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 	return ret;
 }
 
-static inline enum ib_qp_state to_ib_qp_st(enum hns_roce_v2_qp_state state)
-{
-	switch (state) {
-	case HNS_ROCE_QP_ST_RST:	return IB_QPS_RESET;
-	case HNS_ROCE_QP_ST_INIT:	return IB_QPS_INIT;
-	case HNS_ROCE_QP_ST_RTR:	return IB_QPS_RTR;
-	case HNS_ROCE_QP_ST_RTS:	return IB_QPS_RTS;
-	case HNS_ROCE_QP_ST_SQ_DRAINING:
-	case HNS_ROCE_QP_ST_SQD:	return IB_QPS_SQD;
-	case HNS_ROCE_QP_ST_SQER:	return IB_QPS_SQE;
-	case HNS_ROCE_QP_ST_ERR:	return IB_QPS_ERR;
-	default:			return -1;
-	}
+static int to_ib_qp_st(enum hns_roce_v2_qp_state state)
+{
+	const enum ib_qp_state map[] = {
+		[HNS_ROCE_QP_ST_RST] = IB_QPS_RESET,
+		[HNS_ROCE_QP_ST_INIT] = IB_QPS_INIT,
+		[HNS_ROCE_QP_ST_RTR] = IB_QPS_RTR,
+		[HNS_ROCE_QP_ST_RTS] = IB_QPS_RTS,
+		[HNS_ROCE_QP_ST_SQD] = IB_QPS_SQD,
+		[HNS_ROCE_QP_ST_SQER] = IB_QPS_SQE,
+		[HNS_ROCE_QP_ST_ERR] = IB_QPS_ERR,
+		[HNS_ROCE_QP_ST_SQ_DRAINING] = IB_QPS_SQD
+	};
+
+	return (state < ARRAY_SIZE(map)) ? map[state] : -1;
 }
 
 static int hns_roce_v2_query_qpc(struct hns_roce_dev *hr_dev,
-- 
2.8.1

