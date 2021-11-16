Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8656A453537
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Nov 2021 16:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbhKPPIw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Nov 2021 10:08:52 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14753 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238102AbhKPPI2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Nov 2021 10:08:28 -0500
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Htq7B4Dr0zZd51;
        Tue, 16 Nov 2021 23:03:02 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 16 Nov 2021 23:05:24 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 16 Nov 2021 23:05:24 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <leon@kernel.org>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2 rdma-core 2/2] libhns: Add support for direct wqe
Date:   Tue, 16 Nov 2021 23:03:16 +0800
Message-ID: <20211116150316.21925-3-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211116150316.21925-1-liangwenpeng@huawei.com>
References: <20211116150316.21925-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
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

The process of post send of HIP08/09:

   +-----------+
   | post send |
   +-----+-----+
         |
   +-----+-----+
   | write WQE |
   +-----+-----+
         |
         | udma_to_device_barrier()
         |
   +-----+-----+   Y  +-----------+  N
   |  HIP09 ?  +------+ multi WR ?+-------------+
   +-----+-----+      +-----+-----+             |
         | N                | Y                 |
   +-----+-----+      +-----+-----+    +--------+--------+
   |  ring DB  |      |  ring DB  |    |direct WQE (ST4) |
   +-----------+      +-----------+    +-----------------+

Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 providers/hns/hns_roce_u.h       |  5 +++-
 providers/hns/hns_roce_u_hw_v2.c | 44 +++++++++++++++++++++++++-------
 providers/hns/hns_roce_u_hw_v2.h | 31 ++++++++++++----------
 providers/hns/hns_roce_u_verbs.c | 26 +++++++++++++++++--
 util/mmio.h                      | 27 +++++++++++++++++++-
 5 files changed, 107 insertions(+), 26 deletions(-)

diff --git a/providers/hns/hns_roce_u.h b/providers/hns/hns_roce_u.h
index 1616db9f..c6f70d9b 100644
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
diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
index c044807e..0f56763e 100644
--- a/providers/hns/hns_roce_u_hw_v2.c
+++ b/providers/hns/hns_roce_u_hw_v2.c
@@ -33,6 +33,7 @@
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <string.h>
+#include <sys/mman.h>
 #include "hns_roce_u.h"
 #include "hns_roce_u_db.h"
 #include "hns_roce_u_hw_v2.h"
@@ -297,20 +298,40 @@ static void hns_roce_update_rq_db(struct hns_roce_context *ctx,
 }
 
 static void hns_roce_update_sq_db(struct hns_roce_context *ctx,
-				  unsigned int qpn, unsigned int sl,
-				  unsigned int sq_head)
+				  struct hns_roce_qp *qp)
 {
 	struct hns_roce_db sq_db = {};
 
-	sq_db.byte_4 = htole32(qpn);
+	sq_db.byte_4 = htole32(qp->verbs_qp.qp.qp_num);
 	roce_set_field(sq_db.byte_4, DB_BYTE_4_CMD_M, DB_BYTE_4_CMD_S,
 		       HNS_ROCE_V2_SQ_DB);
-	sq_db.parameter = htole32(sq_head);
-	roce_set_field(sq_db.parameter, DB_PARAM_SL_M, DB_PARAM_SL_S, sl);
+	sq_db.parameter = htole32(qp->sq.head);
+	roce_set_field(sq_db.parameter, DB_PARAM_SL_M, DB_PARAM_SL_S, qp->sl);
 
 	hns_roce_write64(ctx->uar + ROCEE_VF_DB_CFG0_OFFSET, (__le32 *)&sq_db);
 }
 
+static void hns_roce_write512(uint64_t *dest, uint64_t *val)
+{
+	mmio_memcpy_x64(dest, val, sizeof(struct hns_roce_rc_sq_wqe));
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
+	 hns_roce_write512(qp->dwqe_page, wqe);
+}
+
 static void hns_roce_v2_update_cq_cons_index(struct hns_roce_context *ctx,
 					     struct hns_roce_cq *cq)
 {
@@ -339,8 +360,7 @@ static struct hns_roce_qp *hns_roce_v2_find_qp(struct hns_roce_context *ctx,
 		return NULL;
 }
 
-static void hns_roce_v2_clear_qp(struct hns_roce_context *ctx,
-				 struct hns_roce_qp *qp)
+void hns_roce_v2_clear_qp(struct hns_roce_context *ctx, struct hns_roce_qp *qp)
 {
 	uint32_t qpn = qp->verbs_qp.qp.qp_num;
 	uint32_t tind = (qpn & (ctx->num_qps - 1)) >> ctx->qp_table_shift;
@@ -1234,6 +1254,7 @@ int hns_roce_u_v2_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 			break;
 		case IBV_QPT_UD:
 			ret = set_ud_wqe(wqe, qp, wr, nreq, &sge_info);
+			qp->sl = to_hr_ah(wr->wr.ud.ah)->av.sl;
 			break;
 		default:
 			ret = EINVAL;
@@ -1249,10 +1270,12 @@ out:
 	if (likely(nreq)) {
 		qp->sq.head += nreq;
 		qp->next_sge = sge_info.start_idx;
-
 		udma_to_device_barrier();
 
-		hns_roce_update_sq_db(ctx, ibvqp->qp_num, qp->sl, qp->sq.head);
+		if (nreq == 1 && (qp->flags & HNS_ROCE_QP_CAP_DIRECT_WQE))
+			hns_roce_write_dwqe(qp, wqe);
+		else
+			hns_roce_update_sq_db(ctx, qp);
 
 		if (qp->flags & HNS_ROCE_QP_CAP_SQ_RECORD_DB)
 			*(qp->sdb) = qp->sq.head & 0xffff;
@@ -1544,6 +1567,9 @@ static int hns_roce_u_v2_destroy_qp(struct ibv_qp *ibqp)
 	if (ret)
 		return ret;
 
+	if (qp->flags & HNS_ROCE_QP_CAP_DIRECT_WQE)
+		munmap(qp->dwqe_page, HNS_ROCE_DWQE_PAGE_SIZE);
+
 	hns_roce_v2_clear_qp(ctx, qp);
 
 	hns_roce_lock_cqs(ibqp);
diff --git a/providers/hns/hns_roce_u_hw_v2.h b/providers/hns/hns_roce_u_hw_v2.h
index c13d82e3..af72cd70 100644
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
 
@@ -376,4 +379,6 @@ struct hns_roce_ud_sq_wqe {
 
 #define MAX_SERVICE_LEVEL 0x7
 
+void hns_roce_v2_clear_qp(struct hns_roce_context *ctx, struct hns_roce_qp *qp);
+
 #endif /* _HNS_ROCE_U_HW_V2_H */
diff --git a/providers/hns/hns_roce_u_verbs.c b/providers/hns/hns_roce_u_verbs.c
index c0069b8b..11db2a34 100644
--- a/providers/hns/hns_roce_u_verbs.c
+++ b/providers/hns/hns_roce_u_verbs.c
@@ -1119,7 +1119,8 @@ static int hns_roce_store_qp(struct hns_roce_context *ctx,
 
 static int qp_exec_create_cmd(struct ibv_qp_init_attr_ex *attr,
 			      struct hns_roce_qp *qp,
-			      struct hns_roce_context *ctx)
+			      struct hns_roce_context *ctx,
+			      uint64_t *dwqe_mmap_key)
 {
 	struct hns_roce_create_qp_ex_resp resp_ex = {};
 	struct hns_roce_create_qp_ex cmd_ex = {};
@@ -1136,6 +1137,7 @@ static int qp_exec_create_cmd(struct ibv_qp_init_attr_ex *attr,
 				    &resp_ex.ibv_resp, sizeof(resp_ex));
 
 	qp->flags = resp_ex.drv_payload.cap_flags;
+	*dwqe_mmap_key = resp_ex.drv_payload.dwqe_mmap_key;
 
 	return ret;
 }
@@ -1187,11 +1189,23 @@ static int hns_roce_alloc_qp_buf(struct ibv_qp_init_attr_ex *attr,
 	return ret;
 }
 
+static int mmap_dwqe(struct ibv_context *ibv_ctx, struct hns_roce_qp *qp,
+		     uint64_t dwqe_mmap_key)
+{
+	qp->dwqe_page = mmap(NULL, HNS_ROCE_DWQE_PAGE_SIZE, PROT_WRITE,
+			     MAP_SHARED, ibv_ctx->cmd_fd, dwqe_mmap_key);
+	if (qp->dwqe_page == MAP_FAILED)
+		return -EINVAL;
+
+	return 0;
+}
+
 static struct ibv_qp *create_qp(struct ibv_context *ibv_ctx,
 				struct ibv_qp_init_attr_ex *attr)
 {
 	struct hns_roce_context *context = to_hr_ctx(ibv_ctx);
 	struct hns_roce_qp *qp;
+	uint64_t dwqe_mmap_key;
 	int ret;
 
 	ret = verify_qp_create_attr(context, attr);
@@ -1210,7 +1224,7 @@ static struct ibv_qp *create_qp(struct ibv_context *ibv_ctx,
 	if (ret)
 		goto err_buf;
 
-	ret = qp_exec_create_cmd(attr, qp, context);
+	ret = qp_exec_create_cmd(attr, qp, context, &dwqe_mmap_key);
 	if (ret)
 		goto err_cmd;
 
@@ -1218,10 +1232,18 @@ static struct ibv_qp *create_qp(struct ibv_context *ibv_ctx,
 	if (ret)
 		goto err_store;
 
+	if (qp->flags & HNS_ROCE_QP_CAP_DIRECT_WQE) {
+		ret = mmap_dwqe(ibv_ctx, qp, dwqe_mmap_key);
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
diff --git a/util/mmio.h b/util/mmio.h
index 101af9dd..01d1455e 100644
--- a/util/mmio.h
+++ b/util/mmio.h
@@ -210,8 +210,33 @@ static inline void mmio_memcpy_x64(void *dest, const void *src, size_t bytecnt)
 {
 	s390_mmio_write(dest, src, bytecnt);
 }
-#else
 
+#elif defined(__aarch64__) || defined(__arm__)
+#include <arm_neon.h>
+
+static inline void _mmio_memcpy_x64_64b(void *dest, const void *src)
+{
+	vst4q_u64(dest, vld4q_u64(src));
+}
+
+static inline void _mmio_memcpy_x64(void *dest, const void *src, size_t bytecnt)
+{
+	do {
+		_mmio_memcpy_x64_64b(dest, src);
+		bytecnt -= sizeof(uint64x2x4_t);
+		src += sizeof(uint64x2x4_t);
+	} while (bytecnt > 0);
+}
+
+#define mmio_memcpy_x64(dest, src, bytecount)                                  \
+	({                                                                     \
+		if (__builtin_constant_p((bytecount) == 64))                   \
+			_mmio_memcpy_x64_64b((dest), (src));                   \
+		else                                                           \
+			_mmio_memcpy_x64((dest), (src), (bytecount));          \
+	})
+
+#else
 /* Transfer is some multiple of 64 bytes */
 static inline void mmio_memcpy_x64(void *dest, const void *src, size_t bytecnt)
 {
-- 
2.33.0

