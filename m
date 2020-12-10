Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F83A2D5BB0
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Dec 2020 14:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388740AbgLJN0L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Dec 2020 08:26:11 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9588 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389230AbgLJN0L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Dec 2020 08:26:11 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CsF4L51NzzM33m;
        Thu, 10 Dec 2020 21:24:02 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Dec 2020 21:24:38 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v3 for-next 06/11] RDMA/hns: Remove unnecessary access right set during INIT2INIT
Date:   Thu, 10 Dec 2020 21:22:47 +0800
Message-ID: <1607606572-11968-7-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1607606572-11968-1-git-send-email-liweihang@huawei.com>
References: <1607606572-11968-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixian Liu <liuyixian@huawei.com>

As the qp access right is checked and setted in common function
hns_roce_v2_set_opt_fields(), there is no need to set again for a special
case INIT2INIT.

Fixes: 926a01dc000d ("RDMA/hns: Add QP operations support for hip08 SoC")
Fixes: 7db82697b8bf ("RDMA/hns: Add support for extended atomic in userspace")
Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 46 ------------------------------
 1 file changed, 46 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index b2b8052..6d80cda 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3975,7 +3975,6 @@ static void modify_qp_reset_to_init(struct ib_qp *ibqp,
 
 	roce_set_bit(context->byte_172_sq_psn, V2_QPC_BYTE_172_FRE_S, 1);
 
-	hr_qp->access_flags = attr->qp_access_flags;
 	roce_set_field(context->byte_252_err_txcqn, V2_QPC_BYTE_252_TX_CQN_M,
 		       V2_QPC_BYTE_252_TX_CQN_S, to_hr_cq(ibqp->send_cq)->cqn);
 
@@ -4004,51 +4003,6 @@ static void modify_qp_init_to_init(struct ib_qp *ibqp,
 	roce_set_field(qpc_mask->byte_4_sqpn_tst, V2_QPC_BYTE_4_TST_M,
 		       V2_QPC_BYTE_4_TST_S, 0);
 
-	if (attr_mask & IB_QP_ACCESS_FLAGS) {
-		roce_set_bit(context->byte_76_srqn_op_en, V2_QPC_BYTE_76_RRE_S,
-			     !!(attr->qp_access_flags & IB_ACCESS_REMOTE_READ));
-		roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_RRE_S,
-			     0);
-
-		roce_set_bit(context->byte_76_srqn_op_en, V2_QPC_BYTE_76_RWE_S,
-			     !!(attr->qp_access_flags &
-			     IB_ACCESS_REMOTE_WRITE));
-		roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_RWE_S,
-			     0);
-
-		roce_set_bit(context->byte_76_srqn_op_en, V2_QPC_BYTE_76_ATE_S,
-			     !!(attr->qp_access_flags &
-			     IB_ACCESS_REMOTE_ATOMIC));
-		roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_ATE_S,
-			     0);
-		roce_set_bit(context->byte_76_srqn_op_en,
-			     V2_QPC_BYTE_76_EXT_ATE_S,
-			     !!(attr->qp_access_flags &
-				IB_ACCESS_REMOTE_ATOMIC));
-		roce_set_bit(qpc_mask->byte_76_srqn_op_en,
-			     V2_QPC_BYTE_76_EXT_ATE_S, 0);
-	} else {
-		roce_set_bit(context->byte_76_srqn_op_en, V2_QPC_BYTE_76_RRE_S,
-			     !!(hr_qp->access_flags & IB_ACCESS_REMOTE_READ));
-		roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_RRE_S,
-			     0);
-
-		roce_set_bit(context->byte_76_srqn_op_en, V2_QPC_BYTE_76_RWE_S,
-			     !!(hr_qp->access_flags & IB_ACCESS_REMOTE_WRITE));
-		roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_RWE_S,
-			     0);
-
-		roce_set_bit(context->byte_76_srqn_op_en, V2_QPC_BYTE_76_ATE_S,
-			     !!(hr_qp->access_flags & IB_ACCESS_REMOTE_ATOMIC));
-		roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_ATE_S,
-			     0);
-		roce_set_bit(context->byte_76_srqn_op_en,
-			     V2_QPC_BYTE_76_EXT_ATE_S,
-			     !!(hr_qp->access_flags & IB_ACCESS_REMOTE_ATOMIC));
-		roce_set_bit(qpc_mask->byte_76_srqn_op_en,
-			     V2_QPC_BYTE_76_EXT_ATE_S, 0);
-	}
-
 	roce_set_field(context->byte_16_buf_ba_pg_sz, V2_QPC_BYTE_16_PD_M,
 		       V2_QPC_BYTE_16_PD_S, to_hr_pd(ibqp->pd)->pdn);
 	roce_set_field(qpc_mask->byte_16_buf_ba_pg_sz, V2_QPC_BYTE_16_PD_M,
-- 
2.8.1

