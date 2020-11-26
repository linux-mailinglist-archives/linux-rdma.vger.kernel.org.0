Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59212C4F1F
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Nov 2020 08:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388266AbgKZHGH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Nov 2020 02:06:07 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8404 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388248AbgKZHGG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Nov 2020 02:06:06 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ChTL826p4z73xr;
        Thu, 26 Nov 2020 15:05:36 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 26 Nov 2020 15:05:49 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v4 for-next 2/2] RDMA/hns: Add support for QP stash
Date:   Thu, 26 Nov 2020 15:04:11 +0800
Message-ID: <1606374251-21512-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1606374251-21512-1-git-send-email-liweihang@huawei.com>
References: <1606374251-21512-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Stash is a mechanism that uses the core information carried by the ARM AXI
bus to access the L3 cache. It can be used to improve the performance by
increasing the hit ratio of L3 cache. QPs need to enable stash by default.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |   6 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 130 +++++++++++++++--------------
 2 files changed, 75 insertions(+), 61 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d0f561d..8cc9002 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3986,6 +3986,12 @@ static void modify_qp_reset_to_init(struct ib_qp *ibqp,
 	hr_qp->access_flags = attr->qp_access_flags;
 	roce_set_field(context->byte_252_err_txcqn, V2_QPC_BYTE_252_TX_CQN_M,
 		       V2_QPC_BYTE_252_TX_CQN_S, to_hr_cq(ibqp->send_cq)->cqn);
+
+	if (hr_dev->caps.qpc_sz < HNS_ROCE_V3_QPC_SZ)
+		return;
+
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_STASH)
+		hr_reg_enable(&context->ext, QPCEX_STASH);
 }
 
 static void modify_qp_init_to_init(struct ib_qp *ibqp,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 917d6cf..980c403 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -466,68 +466,72 @@ enum hns_roce_v2_qp_state {
 	HNS_ROCE_QP_NUM_ST
 };
 
+struct hns_roce_v2_qp_context_ex {
+	__le32 data[64];
+};
 struct hns_roce_v2_qp_context {
-	__le32	byte_4_sqpn_tst;
-	__le32	wqe_sge_ba;
-	__le32	byte_12_sq_hop;
-	__le32	byte_16_buf_ba_pg_sz;
-	__le32	byte_20_smac_sgid_idx;
-	__le32	byte_24_mtu_tc;
-	__le32	byte_28_at_fl;
-	u8	dgid[GID_LEN_V2];
-	__le32	dmac;
-	__le32	byte_52_udpspn_dmac;
-	__le32	byte_56_dqpn_err;
-	__le32	byte_60_qpst_tempid;
-	__le32	qkey_xrcd;
-	__le32	byte_68_rq_db;
-	__le32	rq_db_record_addr;
-	__le32	byte_76_srqn_op_en;
-	__le32	byte_80_rnr_rx_cqn;
-	__le32	byte_84_rq_ci_pi;
-	__le32	rq_cur_blk_addr;
-	__le32	byte_92_srq_info;
-	__le32	byte_96_rx_reqmsn;
-	__le32	rq_nxt_blk_addr;
-	__le32	byte_104_rq_sge;
-	__le32	byte_108_rx_reqepsn;
-	__le32	rq_rnr_timer;
-	__le32	rx_msg_len;
-	__le32	rx_rkey_pkt_info;
-	__le64	rx_va;
-	__le32	byte_132_trrl;
-	__le32	trrl_ba;
-	__le32	byte_140_raq;
-	__le32	byte_144_raq;
-	__le32	byte_148_raq;
-	__le32	byte_152_raq;
-	__le32	byte_156_raq;
-	__le32	byte_160_sq_ci_pi;
-	__le32	sq_cur_blk_addr;
-	__le32	byte_168_irrl_idx;
-	__le32	byte_172_sq_psn;
-	__le32	byte_176_msg_pktn;
-	__le32	sq_cur_sge_blk_addr;
-	__le32	byte_184_irrl_idx;
-	__le32	cur_sge_offset;
-	__le32	byte_192_ext_sge;
-	__le32	byte_196_sq_psn;
-	__le32	byte_200_sq_max;
-	__le32	irrl_ba;
-	__le32	byte_208_irrl;
-	__le32	byte_212_lsn;
-	__le32	sq_timer;
-	__le32	byte_220_retry_psn_msn;
-	__le32	byte_224_retry_msg;
-	__le32	rx_sq_cur_blk_addr;
-	__le32	byte_232_irrl_sge;
-	__le32	irrl_cur_sge_offset;
-	__le32	byte_240_irrl_tail;
-	__le32	byte_244_rnr_rxack;
-	__le32	byte_248_ack_psn;
-	__le32	byte_252_err_txcqn;
-	__le32	byte_256_sqflush_rqcqe;
-	__le32	ext[64];
+	__le32 byte_4_sqpn_tst;
+	__le32 wqe_sge_ba;
+	__le32 byte_12_sq_hop;
+	__le32 byte_16_buf_ba_pg_sz;
+	__le32 byte_20_smac_sgid_idx;
+	__le32 byte_24_mtu_tc;
+	__le32 byte_28_at_fl;
+	u8 dgid[GID_LEN_V2];
+	__le32 dmac;
+	__le32 byte_52_udpspn_dmac;
+	__le32 byte_56_dqpn_err;
+	__le32 byte_60_qpst_tempid;
+	__le32 qkey_xrcd;
+	__le32 byte_68_rq_db;
+	__le32 rq_db_record_addr;
+	__le32 byte_76_srqn_op_en;
+	__le32 byte_80_rnr_rx_cqn;
+	__le32 byte_84_rq_ci_pi;
+	__le32 rq_cur_blk_addr;
+	__le32 byte_92_srq_info;
+	__le32 byte_96_rx_reqmsn;
+	__le32 rq_nxt_blk_addr;
+	__le32 byte_104_rq_sge;
+	__le32 byte_108_rx_reqepsn;
+	__le32 rq_rnr_timer;
+	__le32 rx_msg_len;
+	__le32 rx_rkey_pkt_info;
+	__le64 rx_va;
+	__le32 byte_132_trrl;
+	__le32 trrl_ba;
+	__le32 byte_140_raq;
+	__le32 byte_144_raq;
+	__le32 byte_148_raq;
+	__le32 byte_152_raq;
+	__le32 byte_156_raq;
+	__le32 byte_160_sq_ci_pi;
+	__le32 sq_cur_blk_addr;
+	__le32 byte_168_irrl_idx;
+	__le32 byte_172_sq_psn;
+	__le32 byte_176_msg_pktn;
+	__le32 sq_cur_sge_blk_addr;
+	__le32 byte_184_irrl_idx;
+	__le32 cur_sge_offset;
+	__le32 byte_192_ext_sge;
+	__le32 byte_196_sq_psn;
+	__le32 byte_200_sq_max;
+	__le32 irrl_ba;
+	__le32 byte_208_irrl;
+	__le32 byte_212_lsn;
+	__le32 sq_timer;
+	__le32 byte_220_retry_psn_msn;
+	__le32 byte_224_retry_msg;
+	__le32 rx_sq_cur_blk_addr;
+	__le32 byte_232_irrl_sge;
+	__le32 irrl_cur_sge_offset;
+	__le32 byte_240_irrl_tail;
+	__le32 byte_244_rnr_rxack;
+	__le32 byte_248_ack_psn;
+	__le32 byte_252_err_txcqn;
+	__le32 byte_256_sqflush_rqcqe;
+
+	struct hns_roce_v2_qp_context_ex ext;
 };
 
 #define	V2_QPC_BYTE_4_TST_S 0
@@ -896,6 +900,10 @@ struct hns_roce_v2_qp_context {
 #define	V2_QPC_BYTE_256_SQ_FLUSH_IDX_S 16
 #define V2_QPC_BYTE_256_SQ_FLUSH_IDX_M GENMASK(31, 16)
 
+#define QPCEX_FIELD_LOC(h, l) FIELD_LOC(struct hns_roce_v2_qp_context_ex, h, l)
+
+#define QPCEX_STASH QPCEX_FIELD_LOC(82, 82)
+
 #define	V2_QP_RWE_S 1 /* rdma write enable */
 #define	V2_QP_RRE_S 2 /* rdma read enable */
 #define	V2_QP_ATE_S 3 /* rdma atomic enable */
-- 
2.8.1

