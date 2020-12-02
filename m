Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402BF2CB800
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Dec 2020 10:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388028AbgLBJBq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Dec 2020 04:01:46 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8909 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388027AbgLBJBn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Dec 2020 04:01:43 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CmCc35j6pz77Br;
        Wed,  2 Dec 2020 17:00:35 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 2 Dec 2020 17:00:54 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 03/11] RDMA/hns: Do shift on traffic class of UD SQ WQE
Date:   Wed, 2 Dec 2020 16:59:05 +0800
Message-ID: <1606899553-54592-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1606899553-54592-1-git-send-email-liweihang@huawei.com>
References: <1606899553-54592-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The high 6 bits of traffic class in GRH is DSCP (Differentiated Services
Codepoint), the driver should shift it before the hardware gets it. In
addition, there is no need to check whether it's RoCEv2 when filling TC
into QPC because the DSCP field is meaningless for RoCEv1.

Fixes: 606bf89e98ef ("RDMA/hns: Refactor for hns_roce_v2_modify_qp function")
Fixes: d6a3627e311c ("RDMA/hns: Optimize wqe buffer set flow for post send")
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  2 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 13 +++++--------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index a5c6bb0..1981501 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -119,6 +119,8 @@
 
 #define HNS_ROCE_QP_BANK_NUM 8
 
+#define DSCP_SHIFT 2
+
 /* The chip implementation of the consumer index is calculated
  * according to twice the actual EQ depth
  */
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 8d37067..13c8a2c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -430,7 +430,8 @@ static int fill_ud_av(struct hns_roce_v2_ud_send_wqe *ud_sq_wqe,
 	roce_set_field(ud_sq_wqe->byte_36, V2_UD_SEND_WQE_BYTE_36_HOPLIMIT_M,
 		       V2_UD_SEND_WQE_BYTE_36_HOPLIMIT_S, ah->av.hop_limit);
 	roce_set_field(ud_sq_wqe->byte_36, V2_UD_SEND_WQE_BYTE_36_TCLASS_M,
-		       V2_UD_SEND_WQE_BYTE_36_TCLASS_S, ah->av.tclass);
+		       V2_UD_SEND_WQE_BYTE_36_TCLASS_S,
+		       ah->av.tclass >> DSCP_SHIFT);
 	roce_set_field(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_M,
 		       V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_S, ah->av.flowlabel);
 	roce_set_field(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_SL_M,
@@ -4596,15 +4597,11 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 	roce_set_field(qpc_mask->byte_24_mtu_tc, V2_QPC_BYTE_24_HOP_LIMIT_M,
 		       V2_QPC_BYTE_24_HOP_LIMIT_S, 0);
 
-	if (is_udp)
-		roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_TC_M,
-			       V2_QPC_BYTE_24_TC_S, grh->traffic_class >> 2);
-	else
-		roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_TC_M,
-			       V2_QPC_BYTE_24_TC_S, grh->traffic_class);
-
+	roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_TC_M,
+		       V2_QPC_BYTE_24_TC_S, grh->traffic_class >> DSCP_SHIFT);
 	roce_set_field(qpc_mask->byte_24_mtu_tc, V2_QPC_BYTE_24_TC_M,
 		       V2_QPC_BYTE_24_TC_S, 0);
+
 	roce_set_field(context->byte_28_at_fl, V2_QPC_BYTE_28_FL_M,
 		       V2_QPC_BYTE_28_FL_S, grh->flow_label);
 	roce_set_field(qpc_mask->byte_28_at_fl, V2_QPC_BYTE_28_FL_M,
-- 
2.8.1

