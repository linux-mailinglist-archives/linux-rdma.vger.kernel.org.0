Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAC7813B72E
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2020 02:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgAOBqY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jan 2020 20:46:24 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8719 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728879AbgAOBqX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Jan 2020 20:46:23 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 41E12AFBF438852C18E3;
        Wed, 15 Jan 2020 09:46:21 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Wed, 15 Jan 2020 09:46:12 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Add support for extended atomic in userspace
Date:   Wed, 15 Jan 2020 09:42:26 +0800
Message-ID: <1579052546-11746-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jiaran Zhang <zhangjiaran@huawei.com>

To support extended atomic operations including cmp & swap and fetch & add
of 8 bytes, 16 bytes, 32 bytes, 64 bytes in userspace, some field in qpc
should be configured.

Signed-off-by: Jiaran Zhang <zhangjiaran@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 16 +++++++++++++++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  3 ++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index f1e0ba6..7edf3d8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1692,7 +1692,7 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
 	caps->max_srq_desc_sz	= HNS_ROCE_V2_MAX_SRQ_DESC_SZ;
 	caps->qpc_entry_sz	= HNS_ROCE_V2_QPC_ENTRY_SZ;
 	caps->irrl_entry_sz	= HNS_ROCE_V2_IRRL_ENTRY_SZ;
-	caps->trrl_entry_sz	= HNS_ROCE_V2_TRRL_ENTRY_SZ;
+	caps->trrl_entry_sz	= HNS_ROCE_V2_EXT_ATOMIC_TRRL_ENTRY_SZ;
 	caps->cqc_entry_sz	= HNS_ROCE_V2_CQC_ENTRY_SZ;
 	caps->srqc_entry_sz	= HNS_ROCE_V2_SRQC_ENTRY_SZ;
 	caps->mtpt_entry_sz	= HNS_ROCE_V2_MTPT_ENTRY_SZ;
@@ -3286,6 +3286,9 @@ static void set_access_flags(struct hns_roce_qp *hr_qp,
 	roce_set_bit(context->byte_76_srqn_op_en, V2_QPC_BYTE_76_ATE_S,
 		     !!(access_flags & IB_ACCESS_REMOTE_ATOMIC));
 	roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_ATE_S, 0);
+	roce_set_bit(context->byte_76_srqn_op_en, V2_QPC_BYTE_76_EXT_ATE_S,
+		     !!(access_flags & IB_ACCESS_REMOTE_ATOMIC));
+	roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_EXT_ATE_S, 0);
 }
 
 static void set_qpc_wqe_cnt(struct hns_roce_qp *hr_qp,
@@ -3653,6 +3656,12 @@ static void modify_qp_init_to_init(struct ib_qp *ibqp,
 			     IB_ACCESS_REMOTE_ATOMIC));
 		roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_ATE_S,
 			     0);
+		roce_set_bit(context->byte_76_srqn_op_en,
+			     V2_QPC_BYTE_76_EXT_ATE_S,
+			     !!(attr->qp_access_flags &
+				IB_ACCESS_REMOTE_ATOMIC));
+		roce_set_bit(qpc_mask->byte_76_srqn_op_en,
+			     V2_QPC_BYTE_76_EXT_ATE_S, 0);
 	} else {
 		roce_set_bit(context->byte_76_srqn_op_en, V2_QPC_BYTE_76_RRE_S,
 			     !!(hr_qp->access_flags & IB_ACCESS_REMOTE_READ));
@@ -3668,6 +3677,11 @@ static void modify_qp_init_to_init(struct ib_qp *ibqp,
 			     !!(hr_qp->access_flags & IB_ACCESS_REMOTE_ATOMIC));
 		roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_ATE_S,
 			     0);
+		roce_set_bit(context->byte_76_srqn_op_en,
+			     V2_QPC_BYTE_76_EXT_ATE_S,
+			     !!(hr_qp->access_flags & IB_ACCESS_REMOTE_ATOMIC));
+		roce_set_bit(qpc_mask->byte_76_srqn_op_en,
+			     V2_QPC_BYTE_76_EXT_ATE_S, 0);
 	}
 
 	roce_set_field(context->byte_16_buf_ba_pg_sz, V2_QPC_BYTE_16_PD_M,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 76a14db..c9be484 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -81,6 +81,7 @@
 #define HNS_ROCE_V2_QPC_ENTRY_SZ		256
 #define HNS_ROCE_V2_IRRL_ENTRY_SZ		64
 #define HNS_ROCE_V2_TRRL_ENTRY_SZ		48
+#define HNS_ROCE_V2_EXT_ATOMIC_TRRL_ENTRY_SZ	100
 #define HNS_ROCE_V2_CQC_ENTRY_SZ		64
 #define HNS_ROCE_V2_SRQC_ENTRY_SZ		64
 #define HNS_ROCE_V2_MTPT_ENTRY_SZ		64
@@ -643,7 +644,7 @@ struct hns_roce_v2_qp_context {
 #define	V2_QPC_BYTE_76_ATE_S 27
 
 #define	V2_QPC_BYTE_76_RQIE_S 28
-
+#define	V2_QPC_BYTE_76_EXT_ATE_S 29
 #define	V2_QPC_BYTE_76_RQ_VLAN_EN_S 30
 #define	V2_QPC_BYTE_80_RX_CQN_S 0
 #define V2_QPC_BYTE_80_RX_CQN_M GENMASK(23, 0)
-- 
2.8.1

