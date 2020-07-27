Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59BC22E75C
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jul 2020 10:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgG0ILw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jul 2020 04:11:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43754 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726897AbgG0ILw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Jul 2020 04:11:52 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8FFB98D6B39AA97E445C;
        Mon, 27 Jul 2020 16:11:47 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Mon, 27 Jul 2020 16:11:37 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 1/7] RDMA/hns: Remove redundant hardware opcode definitions
Date:   Mon, 27 Jul 2020 16:10:43 +0800
Message-ID: <1595837449-29193-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1595837449-29193-1-git-send-email-liweihang@huawei.com>
References: <1595837449-29193-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

HNS_ROCE_SQ_OPCODE_XXXs and HNS_ROCE_V2_WQE_OP_XXXs have same values, so
remove a set of redundant definitions. In addition, remove the suffix of
HNS_ROCE_V2_WQE_OP_BIND_MW_TYPE.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 26 +++++++++++++-------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 18 +-----------------
 2 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 2b0b676..35d46b7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3169,51 +3169,51 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 		/* SQ corresponding to CQE */
 		switch (roce_get_field(cqe->byte_4, V2_CQE_BYTE_4_OPCODE_M,
 				       V2_CQE_BYTE_4_OPCODE_S) & 0x1f) {
-		case HNS_ROCE_SQ_OPCODE_SEND:
+		case HNS_ROCE_V2_WQE_OP_SEND:
 			wc->opcode = IB_WC_SEND;
 			break;
-		case HNS_ROCE_SQ_OPCODE_SEND_WITH_INV:
+		case HNS_ROCE_V2_WQE_OP_SEND_WITH_INV:
 			wc->opcode = IB_WC_SEND;
 			break;
-		case HNS_ROCE_SQ_OPCODE_SEND_WITH_IMM:
+		case HNS_ROCE_V2_WQE_OP_SEND_WITH_IMM:
 			wc->opcode = IB_WC_SEND;
 			wc->wc_flags |= IB_WC_WITH_IMM;
 			break;
-		case HNS_ROCE_SQ_OPCODE_RDMA_READ:
+		case HNS_ROCE_V2_WQE_OP_RDMA_READ:
 			wc->opcode = IB_WC_RDMA_READ;
 			wc->byte_len = le32_to_cpu(cqe->byte_cnt);
 			break;
-		case HNS_ROCE_SQ_OPCODE_RDMA_WRITE:
+		case HNS_ROCE_V2_WQE_OP_RDMA_WRITE:
 			wc->opcode = IB_WC_RDMA_WRITE;
 			break;
-		case HNS_ROCE_SQ_OPCODE_RDMA_WRITE_WITH_IMM:
+		case HNS_ROCE_V2_WQE_OP_RDMA_WRITE_WITH_IMM:
 			wc->opcode = IB_WC_RDMA_WRITE;
 			wc->wc_flags |= IB_WC_WITH_IMM;
 			break;
-		case HNS_ROCE_SQ_OPCODE_LOCAL_INV:
+		case HNS_ROCE_V2_WQE_OP_LOCAL_INV:
 			wc->opcode = IB_WC_LOCAL_INV;
 			wc->wc_flags |= IB_WC_WITH_INVALIDATE;
 			break;
-		case HNS_ROCE_SQ_OPCODE_ATOMIC_COMP_AND_SWAP:
+		case HNS_ROCE_V2_WQE_OP_ATOM_CMP_AND_SWAP:
 			wc->opcode = IB_WC_COMP_SWAP;
 			wc->byte_len  = 8;
 			break;
-		case HNS_ROCE_SQ_OPCODE_ATOMIC_FETCH_AND_ADD:
+		case HNS_ROCE_V2_WQE_OP_ATOM_FETCH_AND_ADD:
 			wc->opcode = IB_WC_FETCH_ADD;
 			wc->byte_len  = 8;
 			break;
-		case HNS_ROCE_SQ_OPCODE_ATOMIC_MASK_COMP_AND_SWAP:
+		case HNS_ROCE_V2_WQE_OP_ATOM_MSK_CMP_AND_SWAP:
 			wc->opcode = IB_WC_MASKED_COMP_SWAP;
 			wc->byte_len  = 8;
 			break;
-		case HNS_ROCE_SQ_OPCODE_ATOMIC_MASK_FETCH_AND_ADD:
+		case HNS_ROCE_V2_WQE_OP_ATOM_MSK_FETCH_AND_ADD:
 			wc->opcode = IB_WC_MASKED_FETCH_ADD;
 			wc->byte_len  = 8;
 			break;
-		case HNS_ROCE_SQ_OPCODE_FAST_REG_WR:
+		case HNS_ROCE_V2_WQE_OP_FAST_REG_PMR:
 			wc->opcode = IB_WC_REG_MR;
 			break;
-		case HNS_ROCE_SQ_OPCODE_BIND_MW:
+		case HNS_ROCE_V2_WQE_OP_BIND_MW:
 			wc->opcode = IB_WC_REG_MR;
 			break;
 		default:
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index e176b0a..53c26f3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -179,27 +179,11 @@ enum {
 	HNS_ROCE_V2_WQE_OP_ATOM_MSK_FETCH_AND_ADD	= 0x9,
 	HNS_ROCE_V2_WQE_OP_FAST_REG_PMR			= 0xa,
 	HNS_ROCE_V2_WQE_OP_LOCAL_INV			= 0xb,
-	HNS_ROCE_V2_WQE_OP_BIND_MW_TYPE			= 0xc,
+	HNS_ROCE_V2_WQE_OP_BIND_MW			= 0xc,
 	HNS_ROCE_V2_WQE_OP_MASK				= 0x1f,
 };
 
 enum {
-	HNS_ROCE_SQ_OPCODE_SEND = 0x0,
-	HNS_ROCE_SQ_OPCODE_SEND_WITH_INV = 0x1,
-	HNS_ROCE_SQ_OPCODE_SEND_WITH_IMM = 0x2,
-	HNS_ROCE_SQ_OPCODE_RDMA_WRITE = 0x3,
-	HNS_ROCE_SQ_OPCODE_RDMA_WRITE_WITH_IMM = 0x4,
-	HNS_ROCE_SQ_OPCODE_RDMA_READ = 0x5,
-	HNS_ROCE_SQ_OPCODE_ATOMIC_COMP_AND_SWAP = 0x6,
-	HNS_ROCE_SQ_OPCODE_ATOMIC_FETCH_AND_ADD = 0x7,
-	HNS_ROCE_SQ_OPCODE_ATOMIC_MASK_COMP_AND_SWAP = 0x8,
-	HNS_ROCE_SQ_OPCODE_ATOMIC_MASK_FETCH_AND_ADD = 0x9,
-	HNS_ROCE_SQ_OPCODE_FAST_REG_WR = 0xa,
-	HNS_ROCE_SQ_OPCODE_LOCAL_INV = 0xb,
-	HNS_ROCE_SQ_OPCODE_BIND_MW = 0xc,
-};
-
-enum {
 	/* rq operations */
 	HNS_ROCE_V2_OPCODE_RDMA_WRITE_IMM = 0x0,
 	HNS_ROCE_V2_OPCODE_SEND = 0x1,
-- 
2.8.1

