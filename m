Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E752C514B
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Nov 2020 10:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732405AbgKZJb0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Nov 2020 04:31:26 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8595 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732380AbgKZJbY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Nov 2020 04:31:24 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ChXYn4l62zLsNk;
        Thu, 26 Nov 2020 17:30:53 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 26 Nov 2020 17:31:15 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-rc] RDMA/hns: Fix retry_cnt and rnr_cnt when querying QP
Date:   Thu, 26 Nov 2020 17:29:37 +0800
Message-ID: <1606382977-21431-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

The maximum number of retransmission should be returned when querying QP,
not the value of retransmission counter.

Fixes: 99fcf82521d9 ("RDMA/hns: Fix the wrong value of rnr_retry when querying qp")
Fixes: 926a01dc000d ("RDMA/hns: Add QP operations support for hip08 SoC")
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 6d30850..ce4a476 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4989,11 +4989,11 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 					      V2_QPC_BYTE_28_AT_M,
 					      V2_QPC_BYTE_28_AT_S);
 	qp_attr->retry_cnt = roce_get_field(context.byte_212_lsn,
-					    V2_QPC_BYTE_212_RETRY_CNT_M,
-					    V2_QPC_BYTE_212_RETRY_CNT_S);
+					    V2_QPC_BYTE_212_RETRY_NUM_INIT_M,
+					    V2_QPC_BYTE_212_RETRY_NUM_INIT_S);
 	qp_attr->rnr_retry = roce_get_field(context.byte_244_rnr_rxack,
-					    V2_QPC_BYTE_244_RNR_CNT_M,
-					    V2_QPC_BYTE_244_RNR_CNT_S);
+					    V2_QPC_BYTE_244_RNR_NUM_INIT_M,
+					    V2_QPC_BYTE_244_RNR_NUM_INIT_S);
 
 done:
 	qp_attr->cur_qp_state = qp_attr->qp_state;
-- 
2.8.1

