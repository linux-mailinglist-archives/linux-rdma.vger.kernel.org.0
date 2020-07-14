Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FC521EF42
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 13:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgGNL3u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 07:29:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7303 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726252AbgGNL3u (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Jul 2020 07:29:50 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C5C5FF8EB96DD9FAC22B;
        Tue, 14 Jul 2020 19:29:47 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Tue, 14 Jul 2020 19:29:40 +0800
From:   liweihang <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-rc] RDMA/hns: Fix wrong assignment of lp_pktn_ini in QPC
Date:   Tue, 14 Jul 2020 19:28:58 +0800
Message-ID: <1594726138-49294-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Weihang Li <liweihang@huawei.com>

The RoCE Engine will schedule to another QP after one has sent
(2 ^ lp_pktn_ini) packets. lp_pktn_ini is set in QPC and should be
calculated from 2 factors:
1. current MTU as a integer
2. the RoCE Engine's maximum slice length 64KB
But the driver use MTU as a enum ib_mtu and the max inline capability,
the lp_pktn_ini will be much bigger than expected which may cause traffic
of some QPs never get scheduled.

Fixes: b713128de7a1 ("RDMA/hns: Adjust lp_pktn_ini dynamically")
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 34 +++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index dd01a51..0618ced 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3954,6 +3954,15 @@ static int config_qp_sq_buf(struct hns_roce_dev *hr_dev,
 	return 0;
 }
 
+static inline enum ib_mtu get_mtu(struct ib_qp *ibqp,
+				  const struct ib_qp_attr *attr)
+{
+	if (ibqp->qp_type == IB_QPT_GSI || ibqp->qp_type == IB_QPT_UD)
+		return IB_MTU_4096;
+
+	return attr->path_mtu;
+}
+
 static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 				 const struct ib_qp_attr *attr, int attr_mask,
 				 struct hns_roce_v2_qp_context *context,
@@ -3965,6 +3974,7 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	dma_addr_t trrl_ba;
 	dma_addr_t irrl_ba;
+	enum ib_mtu mtu;
 	u8 port_num;
 	u64 *mtts;
 	u8 *dmac;
@@ -4062,23 +4072,23 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	roce_set_field(qpc_mask->byte_52_udpspn_dmac, V2_QPC_BYTE_52_DMAC_M,
 		       V2_QPC_BYTE_52_DMAC_S, 0);
 
-	/* mtu*(2^LP_PKTN_INI) should not bigger than 1 message length 64kb */
+	mtu = get_mtu(ibqp, attr);
+
+	if (attr_mask & IB_QP_PATH_MTU) {
+		roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_MTU_M,
+			       V2_QPC_BYTE_24_MTU_S, mtu);
+		roce_set_field(qpc_mask->byte_24_mtu_tc, V2_QPC_BYTE_24_MTU_M,
+			       V2_QPC_BYTE_24_MTU_S, 0);
+	}
+
+#define MAX_LP_MSG_LEN 65536
+	/* MTU*(2^LP_PKTN_INI) shouldn't be bigger than 64kb */
 	roce_set_field(context->byte_56_dqpn_err, V2_QPC_BYTE_56_LP_PKTN_INI_M,
 		       V2_QPC_BYTE_56_LP_PKTN_INI_S,
-		       ilog2(hr_dev->caps.max_sq_inline / IB_MTU_4096));
+		       ilog2(MAX_LP_MSG_LEN / ib_mtu_enum_to_int(mtu)));
 	roce_set_field(qpc_mask->byte_56_dqpn_err, V2_QPC_BYTE_56_LP_PKTN_INI_M,
 		       V2_QPC_BYTE_56_LP_PKTN_INI_S, 0);
 
-	if (ibqp->qp_type == IB_QPT_GSI || ibqp->qp_type == IB_QPT_UD)
-		roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_MTU_M,
-			       V2_QPC_BYTE_24_MTU_S, IB_MTU_4096);
-	else if (attr_mask & IB_QP_PATH_MTU)
-		roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_MTU_M,
-			       V2_QPC_BYTE_24_MTU_S, attr->path_mtu);
-
-	roce_set_field(qpc_mask->byte_24_mtu_tc, V2_QPC_BYTE_24_MTU_M,
-		       V2_QPC_BYTE_24_MTU_S, 0);
-
 	roce_set_bit(qpc_mask->byte_108_rx_reqepsn,
 		     V2_QPC_BYTE_108_RX_REQ_PSN_ERR_S, 0);
 	roce_set_field(qpc_mask->byte_96_rx_reqmsn, V2_QPC_BYTE_96_RX_REQ_MSN_M,
-- 
2.8.1

