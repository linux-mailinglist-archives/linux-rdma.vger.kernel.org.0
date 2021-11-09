Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBC044ADBA
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Nov 2021 13:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244579AbhKIMsm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Nov 2021 07:48:42 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:27191 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343585AbhKIMsZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Nov 2021 07:48:25 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HpSMv0nsRz8vH0;
        Tue,  9 Nov 2021 20:43:55 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 9 Nov 2021 20:45:30 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 9 Nov 2021 20:45:30 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH rdma-core 5/7] libhns: Fix wrong type of variables and fields
Date:   Tue, 9 Nov 2021 20:41:01 +0800
Message-ID: <20211109124103.54326-6-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211109124103.54326-1-liangwenpeng@huawei.com>
References: <20211109124103.54326-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xinhao Liu <liuxinhao5@hisilicon.com>

Some variables and fields should be in type of unsigned instead of signed.

Signed-off-by: Xinhao Liu <liuxinhao5@hisilicon.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 providers/hns/hns_roce_u.h       |  6 +++---
 providers/hns/hns_roce_u_hw_v1.c |  6 +++---
 providers/hns/hns_roce_u_hw_v2.c | 11 +++++------
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/providers/hns/hns_roce_u.h b/providers/hns/hns_roce_u.h
index 0d7abd81..d5963941 100644
--- a/providers/hns/hns_roce_u.h
+++ b/providers/hns/hns_roce_u.h
@@ -99,7 +99,7 @@
 #define roce_set_bit(origin, shift, val) \
 	roce_set_field((origin), (1ul << (shift)), (shift), (val))
 
-#define hr_ilog32(n)		ilog32((n) - 1)
+#define hr_ilog32(n)		ilog32((unsigned int)(n) - 1)
 
 enum {
 	HNS_ROCE_QP_TABLE_BITS		= 8,
@@ -203,7 +203,7 @@ struct hns_roce_cq {
 
 struct hns_roce_idx_que {
 	struct hns_roce_buf		buf;
-	int				entry_shift;
+	unsigned int			entry_shift;
 	unsigned long			*bitmap;
 	int				bitmap_cnt;
 	unsigned int			head;
@@ -249,7 +249,7 @@ struct hns_roce_sge_info {
 struct hns_roce_sge_ex {
 	int				offset;
 	unsigned int			sge_cnt;
-	int				sge_shift;
+	unsigned int			sge_shift;
 };
 
 struct hns_roce_rinl_sge {
diff --git a/providers/hns/hns_roce_u_hw_v1.c b/providers/hns/hns_roce_u_hw_v1.c
index ef346424..cc97de30 100644
--- a/providers/hns/hns_roce_u_hw_v1.c
+++ b/providers/hns/hns_roce_u_hw_v1.c
@@ -220,7 +220,7 @@ static int hns_roce_wq_overflow(struct hns_roce_wq *wq, int nreq,
 static struct hns_roce_qp *hns_roce_find_qp(struct hns_roce_context *ctx,
 					    uint32_t qpn)
 {
-	int tind = (qpn & (ctx->num_qps - 1)) >> ctx->qp_table_shift;
+	uint32_t tind = (qpn & (ctx->num_qps - 1)) >> ctx->qp_table_shift;
 
 	if (ctx->qp_table[tind].refcnt) {
 		return ctx->qp_table[tind].table[qpn & ctx->qp_table_mask];
@@ -232,7 +232,7 @@ static struct hns_roce_qp *hns_roce_find_qp(struct hns_roce_context *ctx,
 
 static void hns_roce_clear_qp(struct hns_roce_context *ctx, uint32_t qpn)
 {
-	int tind = (qpn & (ctx->num_qps - 1)) >> ctx->qp_table_shift;
+	uint32_t tind = (qpn & (ctx->num_qps - 1)) >> ctx->qp_table_shift;
 
 	if (!--ctx->qp_table[tind].refcnt)
 		free(ctx->qp_table[tind].table);
@@ -739,7 +739,7 @@ static int hns_roce_u_v1_post_recv(struct ibv_qp *ibvqp, struct ibv_recv_wr *wr,
 				   struct ibv_recv_wr **bad_wr)
 {
 	int ret = 0;
-	int nreq;
+	unsigned int nreq;
 	struct ibv_sge *sg;
 	struct hns_roce_rc_rq_wqe *rq_wqe;
 	struct hns_roce_qp *qp = to_hr_qp(ibvqp);
diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
index 31a0681d..4943a5b1 100644
--- a/providers/hns/hns_roce_u_hw_v2.c
+++ b/providers/hns/hns_roce_u_hw_v2.c
@@ -247,7 +247,7 @@ static void *get_srq_wqe(struct hns_roce_srq *srq, unsigned int n)
 	return srq->wqe_buf.buf + (n << srq->wqe_shift);
 }
 
-static void *get_idx_buf(struct hns_roce_idx_que *idx_que, int n)
+static void *get_idx_buf(struct hns_roce_idx_que *idx_que, unsigned int n)
 {
 	return idx_que->buf.buf + (n << idx_que->entry_shift);
 }
@@ -331,7 +331,7 @@ static void hns_roce_v2_update_cq_cons_index(struct hns_roce_context *ctx,
 static struct hns_roce_qp *hns_roce_v2_find_qp(struct hns_roce_context *ctx,
 					       uint32_t qpn)
 {
-	int tind = (qpn & (ctx->num_qps - 1)) >> ctx->qp_table_shift;
+	uint32_t tind = (qpn & (ctx->num_qps - 1)) >> ctx->qp_table_shift;
 
 	if (ctx->qp_table[tind].refcnt)
 		return ctx->qp_table[tind].table[qpn & ctx->qp_table_mask];
@@ -961,9 +961,8 @@ static int fill_ud_data_seg(struct hns_roce_ud_sq_wqe *ud_sq_wqe,
 	return ret;
 }
 
-static int set_ud_wqe(void *wqe, struct hns_roce_qp *qp,
-		      struct ibv_send_wr *wr, int nreq,
-		      struct hns_roce_sge_info *sge_info)
+static int set_ud_wqe(void *wqe, struct hns_roce_qp *qp, struct ibv_send_wr *wr,
+		      unsigned int nreq, struct hns_roce_sge_info *sge_info)
 {
 	struct hns_roce_ah *ah = to_hr_ah(wr->wr.ud.ah);
 	struct hns_roce_ud_sq_wqe *ud_sq_wqe = wqe;
@@ -1119,7 +1118,7 @@ static int check_rc_opcode(struct hns_roce_rc_sq_wqe *wqe,
 }
 
 static int set_rc_wqe(void *wqe, struct hns_roce_qp *qp, struct ibv_send_wr *wr,
-		      int nreq, struct hns_roce_sge_info *sge_info)
+		      unsigned int nreq, struct hns_roce_sge_info *sge_info)
 {
 	struct hns_roce_rc_sq_wqe *rc_sq_wqe = wqe;
 	struct hns_roce_v2_wqe_data_seg *dseg;
-- 
2.33.0

