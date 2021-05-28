Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C435B394004
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 11:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhE1Jes (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 05:34:48 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2390 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbhE1Jer (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 05:34:47 -0400
Received: from dggeml759-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Frzsm1Kdmz65Zk;
        Fri, 28 May 2021 17:29:32 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggeml759-chm.china.huawei.com (10.1.199.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 17:33:11 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 17:33:10 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH rdma-core 3/4] libhns: Fixes data type when writing doorbell
Date:   Fri, 28 May 2021 17:32:58 +0800
Message-ID: <1622194379-59868-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622194379-59868-1-git-send-email-liweihang@huawei.com>
References: <1622194379-59868-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

The doorbell data is a __le32[] value instead of uint32_t[], and the DB
register should be written with a little-endian data instead of uint64_t.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 providers/hns/hns_roce_u_db.h    | 13 +++----------
 providers/hns/hns_roce_u_hw_v1.c | 17 +++++++++--------
 providers/hns/hns_roce_u_hw_v2.c | 28 +++++++++++++++++-----------
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/providers/hns/hns_roce_u_db.h b/providers/hns/hns_roce_u_db.h
index b44e64d..453fa5a 100644
--- a/providers/hns/hns_roce_u_db.h
+++ b/providers/hns/hns_roce_u_db.h
@@ -37,18 +37,11 @@
 #ifndef _HNS_ROCE_U_DB_H
 #define _HNS_ROCE_U_DB_H
 
-#if __BYTE_ORDER == __LITTLE_ENDIAN
-#define HNS_ROCE_PAIR_TO_64(val) ((uint64_t) val[1] << 32 | val[0])
-#elif __BYTE_ORDER == __BIG_ENDIAN
-#define HNS_ROCE_PAIR_TO_64(val) ((uint64_t) val[0] << 32 | val[1])
-#else
-#error __BYTE_ORDER not defined
-#endif
+#define HNS_ROCE_WORD_NUM 2
 
-static inline void hns_roce_write64(uint32_t val[2],
-				    struct hns_roce_context *ctx, int offset)
+static inline void hns_roce_write64(__le64 *dest, __le32 val[HNS_ROCE_WORD_NUM])
 {
-	*(volatile uint64_t *) (ctx->uar + offset) = HNS_ROCE_PAIR_TO_64(val);
+	*(volatile __le64 *)dest = *(__le64 *)val;
 }
 
 void *hns_roce_alloc_db(struct hns_roce_context *ctx,
diff --git a/providers/hns/hns_roce_u_hw_v1.c b/providers/hns/hns_roce_u_hw_v1.c
index 8f0a71a..d00230c 100644
--- a/providers/hns/hns_roce_u_hw_v1.c
+++ b/providers/hns/hns_roce_u_hw_v1.c
@@ -65,7 +65,7 @@ static void hns_roce_update_rq_head(struct hns_roce_context *ctx,
 
 	udma_to_device_barrier();
 
-	hns_roce_write64((uint32_t *)&rq_db, ctx, ROCEE_DB_OTHERS_L_0_REG);
+	hns_roce_write64(ctx->uar + ROCEE_DB_OTHERS_L_0_REG, (__le32 *)&rq_db);
 }
 
 static void hns_roce_update_sq_head(struct hns_roce_context *ctx,
@@ -84,7 +84,7 @@ static void hns_roce_update_sq_head(struct hns_roce_context *ctx,
 
 	udma_to_device_barrier();
 
-	hns_roce_write64((uint32_t *)&sq_db, ctx, ROCEE_DB_SQ_L_0_REG);
+	hns_roce_write64(ctx->uar + ROCEE_DB_SQ_L_0_REG, (__le32 *)&sq_db);
 }
 
 static void hns_roce_update_cq_cons_index(struct hns_roce_context *ctx,
@@ -102,7 +102,7 @@ static void hns_roce_update_cq_cons_index(struct hns_roce_context *ctx,
 		       CQ_DB_U32_4_CONS_IDX_S,
 		       cq->cons_index & ((cq->cq_depth << 1) - 1));
 
-	hns_roce_write64((uint32_t *)&cq_db, ctx, ROCEE_DB_OTHERS_L_0_REG);
+	hns_roce_write64(ctx->uar + ROCEE_DB_OTHERS_L_0_REG, (__le32 *)&cq_db);
 }
 
 static void hns_roce_handle_error_cqe(struct hns_roce_cqe *cqe,
@@ -422,10 +422,11 @@ static int hns_roce_u_v1_poll_cq(struct ibv_cq *ibvcq, int ne,
  */
 static int hns_roce_u_v1_arm_cq(struct ibv_cq *ibvcq, int solicited)
 {
-	uint32_t ci;
-	uint32_t solicited_flag;
-	struct hns_roce_cq_db cq_db = {};
+	struct hns_roce_context *ctx = to_hr_ctx(ibvcq->context);
 	struct hns_roce_cq *cq = to_hr_cq(ibvcq);
+	struct hns_roce_cq_db cq_db = {};
+	uint32_t solicited_flag;
+	uint32_t ci;
 
 	ci = cq->cons_index & ((cq->cq_depth << 1) - 1);
 	solicited_flag = solicited ? HNS_ROCE_CQ_DB_REQ_SOL :
@@ -441,8 +442,8 @@ static int hns_roce_u_v1_arm_cq(struct ibv_cq *ibvcq, int solicited)
 	roce_set_field(cq_db.u32_4, CQ_DB_U32_4_CONS_IDX_M,
 		       CQ_DB_U32_4_CONS_IDX_S, ci);
 
-	hns_roce_write64((uint32_t *)&cq_db, to_hr_ctx(ibvcq->context),
-			  ROCEE_DB_OTHERS_L_0_REG);
+	hns_roce_write64(ctx->uar + ROCEE_DB_OTHERS_L_0_REG,
+			 (uint32_t *)&cq_db);
 	return 0;
 }
 
diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
index 2308f78..aa57cc4 100644
--- a/providers/hns/hns_roce_u_hw_v2.c
+++ b/providers/hns/hns_roce_u_hw_v2.c
@@ -293,7 +293,8 @@ static void hns_roce_update_rq_db(struct hns_roce_context *ctx,
 		       HNS_ROCE_V2_RQ_DB);
 	rq_db.parameter = htole32(rq_head);
 
-	hns_roce_write64((uint32_t *)&rq_db, ctx, ROCEE_VF_DB_CFG0_OFFSET);
+	hns_roce_write64(ctx->uar + ROCEE_VF_DB_CFG0_OFFSET,
+			 (__le32 *)&rq_db);
 }
 
 static void hns_roce_update_sq_db(struct hns_roce_context *ctx,
@@ -308,7 +309,8 @@ static void hns_roce_update_sq_db(struct hns_roce_context *ctx,
 	sq_db.parameter = htole32(sq_head);
 	roce_set_field(sq_db.parameter, DB_PARAM_SL_M, DB_PARAM_SL_S, sl);
 
-	hns_roce_write64((uint32_t *)&sq_db, ctx, ROCEE_VF_DB_CFG0_OFFSET);
+	hns_roce_write64(ctx->uar + ROCEE_VF_DB_CFG0_OFFSET,
+			 (__le32 *)&sq_db);
 }
 
 static void hns_roce_v2_update_cq_cons_index(struct hns_roce_context *ctx,
@@ -325,7 +327,8 @@ static void hns_roce_v2_update_cq_cons_index(struct hns_roce_context *ctx,
 	roce_set_field(cq_db.parameter, DB_PARAM_CQ_CMD_SN_M,
 		       DB_PARAM_CQ_CMD_SN_S, 1);
 
-	hns_roce_write64((uint32_t *)&cq_db, ctx, ROCEE_VF_DB_CFG0_OFFSET);
+	hns_roce_write64(ctx->uar + ROCEE_VF_DB_CFG0_OFFSET,
+			 (__le32 *)&cq_db);
 }
 
 static struct hns_roce_qp *hns_roce_v2_find_qp(struct hns_roce_context *ctx,
@@ -659,11 +662,12 @@ static int hns_roce_u_v2_poll_cq(struct ibv_cq *ibvcq, int ne,
 
 static int hns_roce_u_v2_arm_cq(struct ibv_cq *ibvcq, int solicited)
 {
-	uint32_t ci;
-	uint32_t cmd_sn;
-	uint32_t solicited_flag;
-	struct hns_roce_db cq_db = {};
+	struct hns_roce_context *ctx = to_hr_ctx(ibvcq->context);
 	struct hns_roce_cq *cq = to_hr_cq(ibvcq);
+	struct hns_roce_db cq_db = {};
+	uint32_t solicited_flag;
+	uint32_t cmd_sn;
+	uint32_t ci;
 
 	ci = cq->cons_index & ((cq->cq_depth << 1) - 1);
 	cmd_sn = cq->arm_sn & HNS_ROCE_CMDSN_MASK;
@@ -681,8 +685,9 @@ static int hns_roce_u_v2_arm_cq(struct ibv_cq *ibvcq, int solicited)
 		       DB_PARAM_CQ_CMD_SN_S, cmd_sn);
 	roce_set_bit(cq_db.parameter, DB_PARAM_CQ_NOTIFY_S, solicited_flag);
 
-	hns_roce_write64((uint32_t *)&cq_db, to_hr_ctx(ibvcq->context),
-			  ROCEE_VF_DB_CFG0_OFFSET);
+	hns_roce_write64(ctx->uar + ROCEE_VF_DB_CFG0_OFFSET,
+			 (uint32_t *)&cq_db);
+
 	return 0;
 }
 
@@ -1693,8 +1698,9 @@ static int hns_roce_u_v2_post_srq_recv(struct ibv_srq *ib_srq,
 		srq_db.parameter = htole32(srq->idx_que.head &
 					   DB_PARAM_SRQ_PRODUCER_COUNTER_M);
 
-		hns_roce_write64((uint32_t *)&srq_db, ctx,
-				 ROCEE_VF_DB_CFG0_OFFSET);
+		hns_roce_write64(ctx->uar + ROCEE_VF_DB_CFG0_OFFSET,
+				 (uint32_t *)&srq_db);
+
 	}
 
 	pthread_spin_unlock(&srq->lock);
-- 
2.7.4

