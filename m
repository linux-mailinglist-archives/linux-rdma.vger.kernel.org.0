Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0A6394006
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 11:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhE1Jes (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 05:34:48 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2447 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhE1Jer (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 05:34:47 -0400
Received: from dggeml759-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Frztd579sz66wf;
        Fri, 28 May 2021 17:30:17 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggeml759-chm.china.huawei.com (10.1.199.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 17:33:11 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 17:33:11 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH rdma-core 4/4] libhns: Add support for direct wqe
Date:   Fri, 28 May 2021 17:32:59 +0800
Message-ID: <1622194379-59868-5-git-send-email-liweihang@huawei.com>
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

From: Yixing Liu <liuyixing1@huawei.com>

The current write wqe mechanism is to write to DDR first, and then notify
the hardware through doorbell to read the data. Direct wqe is a mechanism
to fill wqe directly into the hardware. In the case of light load, the wqe
will be filled into pcie bar space of the hardware, this will reduce one
memory access operation and therefore reduce the latency. SIMD instructions
allows cpu to write the 512 bits at one time to device memory, thus it can
be used for posting direct wqe.

Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 providers/hns/hns_roce_u.h       |  7 ++++--
 providers/hns/hns_roce_u_hw_v2.c | 52 ++++++++++++++++++++++++++++++++++++----
 providers/hns/hns_roce_u_hw_v2.h | 29 ++++++++++++----------
 providers/hns/hns_roce_u_verbs.c | 39 ++++++++++++++++++++++++++++++
 4 files changed, 108 insertions(+), 19 deletions(-)

diff --git a/providers/hns/hns_roce_u.h b/providers/hns/hns_roce_u.h
index 3c4b162..2ffb604 100644
--- a/providers/hns/hns_roce_u.h
+++ b/providers/hns/hns_roce_u.h
@@ -81,6 +81,8 @@
 
 #define INVALID_SGE_LENGTH 0x80000000
 
+#define HNS_ROCE_DWQE_PAGE_SIZE 65536
+
 #define HNS_ROCE_ADDRESS_MASK 0xFFFFFFFF
 #define HNS_ROCE_ADDRESS_SHIFT 32
 
@@ -280,13 +282,14 @@ struct hns_roce_qp {
 	struct hns_roce_sge_ex		ex_sge;
 	unsigned int			next_sge;
 	int				port_num;
-	int				sl;
+	uint8_t				sl;
 	unsigned int			qkey;
 	enum ibv_mtu			path_mtu;
 
 	struct hns_roce_rinl_buf	rq_rinl_buf;
 	unsigned long			flags;
 	int				refcnt; /* specially used for XRC */
+	void				*dwqe_page;
 };
 
 struct hns_roce_av {
@@ -417,7 +420,7 @@ hns_roce_u_create_qp_ex(struct ibv_context *context,
 
 struct ibv_qp *hns_roce_u_open_qp(struct ibv_context *context,
 				  struct ibv_qp_open_attr *attr);
-
+void hns_roce_v2_clear_qp(struct hns_roce_context *ctx, struct hns_roce_qp *qp);
 int hns_roce_u_query_qp(struct ibv_qp *ibqp, struct ibv_qp_attr *attr,
 			int attr_mask, struct ibv_qp_init_attr *init_attr);
 
diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
index aa57cc4..28d455b 100644
--- a/providers/hns/hns_roce_u_hw_v2.c
+++ b/providers/hns/hns_roce_u_hw_v2.c
@@ -33,10 +33,15 @@
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <string.h>
+#include <sys/mman.h>
 #include "hns_roce_u.h"
 #include "hns_roce_u_db.h"
 #include "hns_roce_u_hw_v2.h"
 
+#if defined(__aarch64__) || defined(__arm__)
+#include <arm_neon.h>
+#endif
+
 #define HR_IBV_OPC_MAP(ib_key, hr_key) \
 		[IBV_WR_ ## ib_key] = HNS_ROCE_WQE_OP_ ## hr_key
 
@@ -313,6 +318,39 @@ static void hns_roce_update_sq_db(struct hns_roce_context *ctx,
 			 (__le32 *)&sq_db);
 }
 
+static inline void hns_roce_write512(uint64_t *dest, uint64_t *val)
+{
+#if defined(__aarch64__) || defined(__arm__)
+	uint64x2x4_t dwqe;
+
+	/* Load multiple 4-element structures to 4 registers */
+	dwqe = vld4q_u64(val);
+	/* store multiple 4-element structures from 4 registers */
+	vst4q_u64(dest, dwqe);
+#else
+	int i;
+
+	for (i = 0; i < HNS_ROCE_WRITE_TIMES; i++)
+		hns_roce_write64(dest + i, val + HNS_ROCE_WORD_NUM * i);
+#endif
+}
+
+static void hns_roce_write_dwqe(struct hns_roce_qp *qp, void *wqe)
+{
+	struct hns_roce_rc_sq_wqe *rc_sq_wqe = wqe;
+
+	/* All kinds of DirectWQE have the same header field layout */
+	roce_set_bit(rc_sq_wqe->byte_4, RC_SQ_WQE_BYTE_4_FLAG_S, 1);
+	roce_set_field(rc_sq_wqe->byte_4, RC_SQ_WQE_BYTE_4_DB_SL_L_M,
+		       RC_SQ_WQE_BYTE_4_DB_SL_L_S, qp->sl);
+	roce_set_field(rc_sq_wqe->byte_4, RC_SQ_WQE_BYTE_4_DB_SL_H_M,
+		       RC_SQ_WQE_BYTE_4_DB_SL_H_S, qp->sl >> HNS_ROCE_SL_SHIFT);
+	roce_set_field(rc_sq_wqe->byte_4, RC_SQ_WQE_BYTE_4_WQE_INDEX_M,
+		       RC_SQ_WQE_BYTE_4_WQE_INDEX_S, qp->sq.head);
+
+	hns_roce_write512(qp->dwqe_page, wqe);
+}
+
 static void hns_roce_v2_update_cq_cons_index(struct hns_roce_context *ctx,
 					     struct hns_roce_cq *cq)
 {
@@ -342,8 +380,7 @@ static struct hns_roce_qp *hns_roce_v2_find_qp(struct hns_roce_context *ctx,
 		return NULL;
 }
 
-static void hns_roce_v2_clear_qp(struct hns_roce_context *ctx,
-				 struct hns_roce_qp *qp)
+void hns_roce_v2_clear_qp(struct hns_roce_context *ctx, struct hns_roce_qp *qp)
 {
 	uint32_t qpn = qp->verbs_qp.qp.qp_num;
 	uint32_t tind = (qpn & (ctx->num_qps - 1)) >> ctx->qp_table_shift;
@@ -1240,6 +1277,7 @@ int hns_roce_u_v2_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 			break;
 		case IBV_QPT_UD:
 			ret = set_ud_wqe(wqe, qp, wr, nreq, &sge_info);
+			qp->sl = to_hr_ah(wr->wr.ud.ah)->av.sl;
 			break;
 		default:
 			ret = EINVAL;
@@ -1255,10 +1293,13 @@ out:
 	if (likely(nreq)) {
 		qp->sq.head += nreq;
 		qp->next_sge = sge_info.start_idx;
-
 		udma_to_device_barrier();
 
-		hns_roce_update_sq_db(ctx, ibvqp->qp_num, qp->sl, qp->sq.head);
+		if (nreq == 1 && (qp->flags & HNS_ROCE_QP_CAP_DIRECT_WQE))
+			hns_roce_write_dwqe(qp, wqe);
+		else
+			hns_roce_update_sq_db(ctx, qp->verbs_qp.qp.qp_num, qp->sl,
+					      qp->sq.head);
 
 		if (qp->flags & HNS_ROCE_QP_CAP_SQ_RECORD_DB)
 			*(qp->sdb) = qp->sq.head & 0xffff;
@@ -1564,6 +1605,9 @@ static int hns_roce_u_v2_destroy_qp(struct ibv_qp *ibqp)
 
 	hns_roce_unlock_cqs(ibqp);
 
+	if (qp->flags & HNS_ROCE_QP_CAP_DIRECT_WQE)
+		munmap(qp->dwqe_page, HNS_ROCE_DWQE_PAGE_SIZE);
+
 	hns_roce_free_qp_buf(qp, ctx);
 
 	free(qp);
diff --git a/providers/hns/hns_roce_u_hw_v2.h b/providers/hns/hns_roce_u_hw_v2.h
index c13d82e..b319826 100644
--- a/providers/hns/hns_roce_u_hw_v2.h
+++ b/providers/hns/hns_roce_u_hw_v2.h
@@ -40,6 +40,8 @@
 
 #define HNS_ROCE_CMDSN_MASK			0x3
 
+#define HNS_ROCE_SL_SHIFT 2
+
 /* V2 REG DEFINITION */
 #define ROCEE_VF_DB_CFG0_OFFSET			0x0230
 
@@ -133,6 +135,8 @@ struct hns_roce_db {
 #define DB_BYTE_4_CMD_S 24
 #define DB_BYTE_4_CMD_M GENMASK(27, 24)
 
+#define DB_BYTE_4_FLAG_S 31
+
 #define DB_PARAM_SRQ_PRODUCER_COUNTER_S 0
 #define DB_PARAM_SRQ_PRODUCER_COUNTER_M GENMASK(15, 0)
 
@@ -216,8 +220,16 @@ struct hns_roce_rc_sq_wqe {
 };
 
 #define RC_SQ_WQE_BYTE_4_OPCODE_S 0
-#define RC_SQ_WQE_BYTE_4_OPCODE_M \
-	(((1UL << 5) - 1) << RC_SQ_WQE_BYTE_4_OPCODE_S)
+#define RC_SQ_WQE_BYTE_4_OPCODE_M GENMASK(4, 0)
+
+#define RC_SQ_WQE_BYTE_4_DB_SL_L_S 5
+#define RC_SQ_WQE_BYTE_4_DB_SL_L_M GENMASK(6, 5)
+
+#define RC_SQ_WQE_BYTE_4_DB_SL_H_S 13
+#define RC_SQ_WQE_BYTE_4_DB_SL_H_M GENMASK(14, 13)
+
+#define RC_SQ_WQE_BYTE_4_WQE_INDEX_S 15
+#define RC_SQ_WQE_BYTE_4_WQE_INDEX_M GENMASK(30, 15)
 
 #define RC_SQ_WQE_BYTE_4_OWNER_S 7
 
@@ -239,6 +251,8 @@ struct hns_roce_rc_sq_wqe {
 
 #define RC_SQ_WQE_BYTE_4_RDMA_WRITE_S 22
 
+#define RC_SQ_WQE_BYTE_4_FLAG_S 31
+
 #define RC_SQ_WQE_BYTE_16_XRC_SRQN_S 0
 #define RC_SQ_WQE_BYTE_16_XRC_SRQN_M \
 	(((1UL << 24) - 1) << RC_SQ_WQE_BYTE_16_XRC_SRQN_S)
@@ -311,23 +325,12 @@ struct hns_roce_ud_sq_wqe {
 #define UD_SQ_WQE_OPCODE_S 0
 #define UD_SQ_WQE_OPCODE_M GENMASK(4, 0)
 
-#define UD_SQ_WQE_DB_SL_L_S 5
-#define UD_SQ_WQE_DB_SL_L_M GENMASK(6, 5)
-
-#define UD_SQ_WQE_DB_SL_H_S 13
-#define UD_SQ_WQE_DB_SL_H_M GENMASK(14, 13)
-
-#define UD_SQ_WQE_INDEX_S 15
-#define UD_SQ_WQE_INDEX_M GENMASK(30, 15)
-
 #define UD_SQ_WQE_OWNER_S 7
 
 #define UD_SQ_WQE_CQE_S 8
 
 #define UD_SQ_WQE_SE_S 11
 
-#define UD_SQ_WQE_FLAG_S 31
-
 #define UD_SQ_WQE_PD_S 0
 #define UD_SQ_WQE_PD_M GENMASK(23, 0)
 
diff --git a/providers/hns/hns_roce_u_verbs.c b/providers/hns/hns_roce_u_verbs.c
index 7b44829..f97144e 100644
--- a/providers/hns/hns_roce_u_verbs.c
+++ b/providers/hns/hns_roce_u_verbs.c
@@ -1115,6 +1115,37 @@ static int hns_roce_store_qp(struct hns_roce_context *ctx,
 	return 0;
 }
 
+static off_t get_dwqe_mmap_offset(unsigned long qpn, int page_size, int cmd)
+{
+	off_t offset = 0;
+	unsigned long idx;
+
+	idx = qpn * (HNS_ROCE_DWQE_PAGE_SIZE / page_size);
+
+	hns_roce_mmap_set_command(cmd, &offset);
+	hns_roce_mmap_set_index(idx, &offset);
+
+	return offset * page_size;
+}
+
+static int mmap_dwqe(struct ibv_context *ibv_ctx, struct hns_roce_qp *qp)
+{
+	struct hns_roce_device *hr_dev = to_hr_dev(ibv_ctx->device);
+	int page_size = hr_dev->page_size;
+	off_t offset;
+
+	offset = get_dwqe_mmap_offset(qp->verbs_qp.qp.qp_num, page_size,
+				      HNS_ROCE_MMAP_DWQE_PAGE);
+
+	qp->dwqe_page = mmap(NULL, HNS_ROCE_DWQE_PAGE_SIZE, PROT_WRITE,
+			     MAP_SHARED, ibv_ctx->cmd_fd, offset);
+
+	if (qp->dwqe_page == MAP_FAILED)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int qp_exec_create_cmd(struct ibv_qp_init_attr_ex *attr,
 			      struct hns_roce_qp *qp,
 			      struct hns_roce_context *ctx)
@@ -1216,10 +1247,18 @@ static struct ibv_qp *create_qp(struct ibv_context *ibv_ctx,
 	if (ret)
 		goto err_store;
 
+	if (qp->flags & HNS_ROCE_QP_CAP_DIRECT_WQE) {
+		ret = mmap_dwqe(ibv_ctx, qp);
+		if (ret)
+			goto err_dwqe;
+	}
+
 	qp_setup_config(attr, qp, context);
 
 	return &qp->verbs_qp.qp;
 
+err_dwqe:
+	hns_roce_v2_clear_qp(context, qp);
 err_store:
 	ibv_cmd_destroy_qp(&qp->verbs_qp.qp);
 err_cmd:
-- 
2.7.4

