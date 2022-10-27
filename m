Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBDC60F42D
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 11:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbiJ0J6o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 05:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbiJ0J6N (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 05:58:13 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C22BC63E
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 02:57:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VTB5Lci_1666864666;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VTB5Lci_1666864666)
          by smtp.aliyun-inc.com;
          Thu, 27 Oct 2022 17:57:47 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next 3/3] RDMA/erdma: Implement atomic operations support
Date:   Thu, 27 Oct 2022 17:57:41 +0800
Message-Id: <20221027095741.48044-4-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20221027095741.48044-1-chengyou@linux.alibaba.com>
References: <20221027095741.48044-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add atomic operations support in post_send and poll_cq implementation.
Also, rename 'laddr' and 'lkey' in struct erdma_sge to 'addr' and 'key',
because this structure is used for both local and remote SGEs.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_cq.c |  2 ++
 drivers/infiniband/hw/erdma/erdma_hw.h | 18 ++++++++++---
 drivers/infiniband/hw/erdma/erdma_qp.c | 36 +++++++++++++++++++++++---
 3 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_cq.c b/drivers/infiniband/hw/erdma/erdma_cq.c
index 58e0dc5c75d1..cabd8678b355 100644
--- a/drivers/infiniband/hw/erdma/erdma_cq.c
+++ b/drivers/infiniband/hw/erdma/erdma_cq.c
@@ -64,6 +64,8 @@ static const enum ib_wc_opcode wc_mapping_table[ERDMA_NUM_OPCODES] = {
 	[ERDMA_OP_REG_MR] = IB_WC_REG_MR,
 	[ERDMA_OP_LOCAL_INV] = IB_WC_LOCAL_INV,
 	[ERDMA_OP_READ_WITH_INV] = IB_WC_RDMA_READ,
+	[ERDMA_OP_ATOMIC_CAS] = IB_WC_COMP_SWAP,
+	[ERDMA_OP_ATOMIC_FAD] = IB_WC_FETCH_ADD,
 };
 
 static const struct {
diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
index 808e7ee56d93..1b2e2b70678f 100644
--- a/drivers/infiniband/hw/erdma/erdma_hw.h
+++ b/drivers/infiniband/hw/erdma/erdma_hw.h
@@ -344,9 +344,9 @@ struct erdma_cqe {
 };
 
 struct erdma_sge {
-	__aligned_le64 laddr;
+	__aligned_le64 addr;
 	__le32 length;
-	__le32 lkey;
+	__le32 key;
 };
 
 /* Receive Queue Element */
@@ -413,6 +413,16 @@ struct erdma_readreq_sqe {
 	__le32 rsvd;
 };
 
+struct erdma_atomic_sqe {
+	__le64 hdr;
+	__le64 rsvd;
+	__le64 fetchadd_swap_data;
+	__le64 cmp_data;
+
+	struct erdma_sge remote;
+	struct erdma_sge sgl;
+};
+
 struct erdma_reg_mr_sqe {
 	__le64 hdr;
 	__le64 addr;
@@ -472,7 +482,9 @@ enum erdma_opcode {
 	ERDMA_OP_REG_MR = 14,
 	ERDMA_OP_LOCAL_INV = 15,
 	ERDMA_OP_READ_WITH_INV = 16,
-	ERDMA_NUM_OPCODES = 17,
+	ERDMA_OP_ATOMIC_CAS = 17,
+	ERDMA_OP_ATOMIC_FAD = 18,
+	ERDMA_NUM_OPCODES = 19,
 	ERDMA_OP_INVALID = ERDMA_NUM_OPCODES + 1
 };
 
diff --git a/drivers/infiniband/hw/erdma/erdma_qp.c b/drivers/infiniband/hw/erdma/erdma_qp.c
index c7f343173cb9..b672cdc6449e 100644
--- a/drivers/infiniband/hw/erdma/erdma_qp.c
+++ b/drivers/infiniband/hw/erdma/erdma_qp.c
@@ -285,15 +285,16 @@ static int erdma_push_one_sqe(struct erdma_qp *qp, u16 *pi,
 	u32 wqe_size, wqebb_cnt, hw_op, flags, sgl_offset;
 	u32 idx = *pi & (qp->attrs.sq_size - 1);
 	enum ib_wr_opcode op = send_wr->opcode;
+	struct erdma_atomic_sqe *atomic_sqe;
 	struct erdma_readreq_sqe *read_sqe;
 	struct erdma_reg_mr_sqe *regmr_sge;
 	struct erdma_write_sqe *write_sqe;
 	struct erdma_send_sqe *send_sqe;
 	struct ib_rdma_wr *rdma_wr;
-	struct erdma_mr *mr;
+	struct erdma_sge *sge;
 	__le32 *length_field;
+	struct erdma_mr *mr;
 	u64 wqe_hdr, *entry;
-	struct ib_sge *sge;
 	u32 attrs;
 	int ret;
 
@@ -361,7 +362,7 @@ static int erdma_push_one_sqe(struct erdma_qp *qp, u16 *pi,
 		sge = get_queue_entry(qp->kern_qp.sq_buf, idx + 1,
 				      qp->attrs.sq_size, SQEBB_SHIFT);
 		sge->addr = rdma_wr->remote_addr;
-		sge->lkey = rdma_wr->rkey;
+		sge->key = rdma_wr->rkey;
 		sge->length = send_wr->sg_list[0].length;
 		wqe_size = sizeof(struct erdma_readreq_sqe) +
 			   send_wr->num_sge * sizeof(struct ib_sge);
@@ -423,6 +424,35 @@ static int erdma_push_one_sqe(struct erdma_qp *qp, u16 *pi,
 		regmr_sge->stag = cpu_to_le32(send_wr->ex.invalidate_rkey);
 		wqe_size = sizeof(struct erdma_reg_mr_sqe);
 		goto out;
+	case IB_WR_ATOMIC_CMP_AND_SWP:
+	case IB_WR_ATOMIC_FETCH_AND_ADD:
+		atomic_sqe = (struct erdma_atomic_sqe *)entry;
+		if (op == IB_WR_ATOMIC_CMP_AND_SWP) {
+			wqe_hdr |= FIELD_PREP(ERDMA_SQE_HDR_OPCODE_MASK,
+					      ERDMA_OP_ATOMIC_CAS);
+			atomic_sqe->fetchadd_swap_data =
+				cpu_to_le64(atomic_wr(send_wr)->swap);
+			atomic_sqe->cmp_data =
+				cpu_to_le64(atomic_wr(send_wr)->compare_add);
+		} else {
+			wqe_hdr |= FIELD_PREP(ERDMA_SQE_HDR_OPCODE_MASK,
+					      ERDMA_OP_ATOMIC_FAD);
+			atomic_sqe->fetchadd_swap_data =
+				cpu_to_le64(atomic_wr(send_wr)->compare_add);
+		}
+
+		sge = get_queue_entry(qp->kern_qp.sq_buf, idx + 1,
+				      qp->attrs.sq_size, SQEBB_SHIFT);
+		sge->addr = atomic_wr(send_wr)->remote_addr;
+		sge->key = atomic_wr(send_wr)->rkey;
+		sge++;
+
+		sge->addr = send_wr->sg_list[0].addr;
+		sge->key = send_wr->sg_list[0].lkey;
+		sge->length = send_wr->sg_list[0].length;
+
+		wqe_size = sizeof(*atomic_sqe);
+		goto out;
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.27.0

