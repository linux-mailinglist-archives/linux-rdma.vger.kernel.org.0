Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47511A95F3
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2020 10:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635697AbgDOIO7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Apr 2020 04:14:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47870 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2635696AbgDOIOt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Apr 2020 04:14:49 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3D8C7DDA63C6E070E1D4;
        Wed, 15 Apr 2020 16:14:46 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Wed, 15 Apr 2020 16:14:35 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 3/6] RDMA/hns: Simplify the qp state convert code
Date:   Wed, 15 Apr 2020 16:14:32 +0800
Message-ID: <1586938475-37049-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1586938475-37049-1-git-send-email-liweihang@huawei.com>
References: <1586938475-37049-1-git-send-email-liweihang@huawei.com>
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
index 6816278..d95af32 100644
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
+	static const enum ib_qp_state map[] = {
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

