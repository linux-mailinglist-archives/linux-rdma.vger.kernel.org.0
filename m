Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56345312121
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Feb 2021 04:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhBGDQS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 6 Feb 2021 22:16:18 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12861 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhBGDP7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 6 Feb 2021 22:15:59 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DYDl44y3Kz7hLs;
        Sun,  7 Feb 2021 11:13:52 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Sun, 7 Feb 2021 11:15:10 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH RFC rdma-core 5/5] libhns: Add support for configuring DCA
Date:   Sun, 7 Feb 2021 11:12:54 +0800
Message-ID: <1612667574-56673-6-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1612667574-56673-1-git-send-email-liweihang@huawei.com>
References: <1612667574-56673-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Add a group of environment variables for configuring DCA memory pool which
is as follows:
 HNS_DCA_MAX_SIZE - the max size when expand the memory pool.
 HNS_DCA_MIN_SIZE - the reverved size when shrink the memory pool.
 HNS_DCA_UNIT_SIZE - the increase unit size when expand the memory pool.

Also append 'IBV_QP_CREATE_DYNAMIC_CONTEXT_ATTACH' for creating a DCA QP.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 libibverbs/cmd_qp.c              |  3 ++-
 libibverbs/verbs.h               |  1 +
 providers/hns/hns_roce_u.c       | 52 ++++++++++++++++++++++++++++++++++++++--
 providers/hns/hns_roce_u_verbs.c | 18 ++++++++++----
 4 files changed, 67 insertions(+), 7 deletions(-)

diff --git a/libibverbs/cmd_qp.c b/libibverbs/cmd_qp.c
index 056f397..f9899ad 100644
--- a/libibverbs/cmd_qp.c
+++ b/libibverbs/cmd_qp.c
@@ -38,7 +38,8 @@ enum {
 					IBV_QP_CREATE_SCATTER_FCS |
 					IBV_QP_CREATE_CVLAN_STRIPPING |
 					IBV_QP_CREATE_SOURCE_QPN |
-					IBV_QP_CREATE_PCI_WRITE_END_PADDING
+					IBV_QP_CREATE_PCI_WRITE_END_PADDING |
+					IBV_QP_CREATE_DYNAMIC_CONTEXT_ATTACH
 };
 
 
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index 656b0f9..db37dce 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -918,6 +918,7 @@ enum ibv_qp_create_flags {
 	IBV_QP_CREATE_CVLAN_STRIPPING		= 1 << 9,
 	IBV_QP_CREATE_SOURCE_QPN		= 1 << 10,
 	IBV_QP_CREATE_PCI_WRITE_END_PADDING	= 1 << 11,
+	IBV_QP_CREATE_DYNAMIC_CONTEXT_ATTACH	= 1 << 13,
 };
 
 enum ibv_qp_create_send_ops_flags {
diff --git a/providers/hns/hns_roce_u.c b/providers/hns/hns_roce_u.c
index 28b1130..3ba99ed 100644
--- a/providers/hns/hns_roce_u.c
+++ b/providers/hns/hns_roce_u.c
@@ -92,6 +92,10 @@ static const struct verbs_context_ops hns_common_ops = {
 static int init_dca_context(struct hns_roce_context *ctx, int page_size)
 {
 	struct hns_roce_dca_ctx *dca_ctx = &ctx->dca_ctx;
+	int unit_size = 0;
+	long max_size = 0;
+	long min_size;
+	char *env;
 	int ret;
 
 	if (!(ctx->cap_flags & HNS_ROCE_CAP_FLAG_DCA_MODE))
@@ -102,8 +106,52 @@ static int init_dca_context(struct hns_roce_context *ctx, int page_size)
 	if (ret)
 		return ret;
 
-	dca_ctx->unit_size = page_size * HNS_DCA_DEFAULT_UNIT_PAGES;
-	dca_ctx->max_size = HNS_DCA_MAX_MEM_SIZE;
+	env = getenv("HNS_DCA_UNIT_SIZE");
+	if (env) {
+		unit_size = atoi(env);
+		/* Disable DCA only for this process */
+		if (unit_size == 0)
+			return 0;
+	}
+
+	if (unit_size < 1)
+		unit_size = page_size * HNS_DCA_DEFAULT_UNIT_PAGES;
+
+	unit_size = align(unit_size, page_size);
+
+	/*
+	 * not set OR 0: Unlimited memory pool increase.
+	 * others: Maximum memory pool size to be increased.
+	 */
+	env = getenv("HNS_DCA_MAX_SIZE");
+	if (env)
+		max_size = atol(env);
+
+	if (max_size == 0)
+		max_size = HNS_DCA_MAX_MEM_SIZE;
+	else
+		max_size = DIV_ROUND_UP(max_size, unit_size);
+
+	/*
+	 * not set: The memory pool cannot be reduced.
+	 * others: The size of free memory in the pool cannot exceed this value.
+	 * 0: Always reduce the free memory in the pool.
+	 */
+	env = getenv("HNS_DCA_MIN_SIZE");
+	if (env) {
+		min_size = atol(env);
+		if (min_size > 0)
+			min_size = DIV_ROUND_UP(min_size, unit_size);
+		else
+			min_size = 0;
+	} else {
+		min_size = HNS_DCA_MAX_MEM_SIZE;
+	}
+
+	dca_ctx->unit_size = unit_size;
+	dca_ctx->max_size = max_size;
+	dca_ctx->min_size = min_size;
+
 	dca_ctx->mem_cnt = 0;
 
 	return 0;
diff --git a/providers/hns/hns_roce_u_verbs.c b/providers/hns/hns_roce_u_verbs.c
index 6ec8b12..0697328 100644
--- a/providers/hns/hns_roce_u_verbs.c
+++ b/providers/hns/hns_roce_u_verbs.c
@@ -542,7 +542,7 @@ int hns_roce_u_destroy_srq(struct ibv_srq *srq)
 }
 
 enum {
-	CREATE_QP_SUP_CREATE_FLAGS = 0,
+	CREATE_QP_SUP_CREATE_FLAGS = IBV_QP_CREATE_DYNAMIC_CONTEXT_ATTACH,
 };
 
 enum {
@@ -688,10 +688,11 @@ static int calc_qp_buff_size(struct hns_roce_device *hr_dev,
 	return 0;
 }
 
-static inline bool check_qp_support_dca(bool pool_en, enum ibv_qp_type qp_type)
+static inline bool check_qp_support_dca(bool pool_en, enum ibv_qp_type qp_type,
+					uint32_t create_flags)
 {
 	if (pool_en && (qp_type == IBV_QPT_RC || qp_type == IBV_QPT_XRC_SEND))
-		return true;
+		return !!(create_flags & IBV_QP_CREATE_DYNAMIC_CONTEXT_ATTACH);
 
 	return false;
 }
@@ -730,7 +731,8 @@ static int qp_alloc_wqe(struct ibv_qp_init_attr_ex *attr,
 			goto err_alloc;
 	}
 
-	if (check_qp_support_dca(ctx->dca_ctx.max_size != 0, attr->qp_type)) {
+	if (check_qp_support_dca(ctx->dca_ctx.max_size != 0,
+				 attr->qp_type, attr->create_flags)) {
 		/* when DCA is enabled, use a buffer list to store page addr */
 		qp->buf.buf = NULL;
 		qp->page_list.max_cnt = hr_hw_page_count(qp->buf_size);
@@ -901,6 +903,14 @@ static int qp_exec_create_cmd(struct ibv_qp_init_attr_ex *attr,
 	struct hns_roce_create_qp_ex cmd_ex = {};
 	int ret;
 
+	/*
+	 * When handling the command in kernel space, the user QP enable
+	 * the DCA mode by checking whether the cmd.buf_addr is NULL but
+	 * not the attr->create_flags has the DCA enable bit, so clear
+	 * this bit before command is ready to run.
+	 */
+	attr->create_flags &= ~IBV_QP_CREATE_DYNAMIC_CONTEXT_ATTACH;
+
 	cmd_ex.sdb_addr = (uintptr_t)qp->sdb;
 	cmd_ex.db_addr = (uintptr_t)qp->rdb;
 	cmd_ex.buf_addr = (uintptr_t)qp->buf.buf;
-- 
2.8.1

