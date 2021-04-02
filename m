Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8024E352843
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Apr 2021 11:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbhDBJKW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Apr 2021 05:10:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14680 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbhDBJKT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Apr 2021 05:10:19 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FBZ2H38wfznY6N;
        Fri,  2 Apr 2021 17:07:35 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Fri, 2 Apr 2021 17:10:06 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Wenpeng Liang <liangwenpeng@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 7/9] RDMA/hns: Add XRC subtype in QPC and XRC type in SRQC
Date:   Fri, 2 Apr 2021 17:07:32 +0800
Message-ID: <1617354454-47840-8-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617354454-47840-1-git-send-email-liweihang@huawei.com>
References: <1617354454-47840-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

A field to distuiguish basic SRQ from XRC SRQ in SRQC and a field in QPC to
determine whether a QP is XRC TGT QP or XRC INI QP are missing.

Fixes: 32548870d438 ("RDMA/hns: Add support for XRC on HIP09")
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 13 +++++++------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  5 ++++-
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 8e15ad8..6a3c177 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4093,9 +4093,13 @@ static void modify_qp_reset_to_init(struct ib_qp *ibqp,
 	roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_VLAN_ID_M,
 		       V2_QPC_BYTE_24_VLAN_ID_S, 0xfff);
 
-	if (ibqp->qp_type == IB_QPT_XRC_TGT)
+	if (ibqp->qp_type == IB_QPT_XRC_TGT) {
 		context->qkey_xrcd = cpu_to_le32(hr_qp->xrcdn);
 
+		roce_set_bit(context->byte_80_rnr_rx_cqn,
+			     V2_QPC_BYTE_80_XRC_QP_TYPE_S, 1);
+	}
+
 	if (hr_qp->en_flags & HNS_ROCE_QP_CAP_RQ_RECORD_DB)
 		roce_set_bit(context->byte_68_rq_db,
 			     V2_QPC_BYTE_68_RQ_RECORD_EN_S, 1);
@@ -4153,11 +4157,6 @@ static void modify_qp_init_to_init(struct ib_qp *ibqp,
 	roce_set_field(qpc_mask->byte_4_sqpn_tst, V2_QPC_BYTE_4_TST_M,
 		       V2_QPC_BYTE_4_TST_S, 0);
 
-	if (ibqp->qp_type == IB_QPT_XRC_TGT) {
-		context->qkey_xrcd = cpu_to_le32(hr_qp->xrcdn);
-		qpc_mask->qkey_xrcd = 0;
-	}
-
 	roce_set_field(context->byte_16_buf_ba_pg_sz, V2_QPC_BYTE_16_PD_M,
 		       V2_QPC_BYTE_16_PD_S, get_pdn(ibqp->pd));
 
@@ -5590,6 +5589,8 @@ static int hns_roce_v2_write_srqc(struct hns_roce_srq *srq, void *mb_buf)
 	}
 
 	hr_reg_write(ctx, SRQC_SRQ_ST, 1);
+	hr_reg_write(ctx, SRQC_SRQ_TYPE,
+		     !!(srq->ibsrq.srq_type == IB_SRQT_XRC));
 	hr_reg_write(ctx, SRQC_PD, to_hr_pd(srq->ibsrq.pd)->pdn);
 	hr_reg_write(ctx, SRQC_SRQN, srq->srqn);
 	hr_reg_write(ctx, SRQC_XRCD, srq->xrcdn);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 88b44f7..2f63c3c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -404,7 +404,8 @@ struct hns_roce_srq_context {
 #define SRQC_CONSUMER_IDX SRQC_FIELD_LOC(127, 112)
 #define SRQC_WQE_BT_BA_L SRQC_FIELD_LOC(159, 128)
 #define SRQC_WQE_BT_BA_H SRQC_FIELD_LOC(188, 160)
-#define SRQC_RSV2 SRQC_FIELD_LOC(191, 189)
+#define SRQC_RSV2 SRQC_FIELD_LOC(190, 189)
+#define SRQC_SRQ_TYPE SRQC_FIELD_LOC(191, 191)
 #define SRQC_PD SRQC_FIELD_LOC(215, 192)
 #define SRQC_RQWS SRQC_FIELD_LOC(219, 216)
 #define SRQC_RSV3 SRQC_FIELD_LOC(223, 220)
@@ -704,6 +705,8 @@ struct hns_roce_v2_qp_context {
 #define	V2_QPC_BYTE_80_RX_CQN_S 0
 #define V2_QPC_BYTE_80_RX_CQN_M GENMASK(23, 0)
 
+#define V2_QPC_BYTE_80_XRC_QP_TYPE_S 24
+
 #define	V2_QPC_BYTE_80_MIN_RNR_TIME_S 27
 #define V2_QPC_BYTE_80_MIN_RNR_TIME_M GENMASK(31, 27)
 
-- 
2.8.1

