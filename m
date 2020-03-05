Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70B5D17A876
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 16:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgCEPES (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 10:04:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:47750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbgCEPES (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Mar 2020 10:04:18 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9BBF20801;
        Thu,  5 Mar 2020 15:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583420657;
        bh=KtQWsQuC/uDds54bsvJGHLAy+1yba/7jZ80yd6oGR+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M1G6ZGXZUm+eejKKdAFuiSG2ak5lA9WJCGlKGWCSNPPjyBbKZFdxWAuIYguC3Mybn
         vrmkLqx5YGUN7tYYDAxb+5+XM518TzKPco5rTb0Jo0Mo8ArVD1DWM+Ms3t8aNyX1kZ
         /CCYXK7ZGNQkbRnLJgpAkGWal7kkpp4BtZlb7muw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [RFC PATCH rdma-core 03/11] mlx5: Implement ECE callbacks
Date:   Thu,  5 Mar 2020 17:03:48 +0200
Message-Id: <20200305150356.208843-4-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305150356.208843-1-leon@kernel.org>
References: <20200305150356.208843-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Add an implementation for get and set ECE options to mlx5 provider.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 providers/mlx5/mlx5.c  |  6 ++----
 providers/mlx5/mlx5.h  | 10 ++++++++++
 providers/mlx5/qp.c    | 33 +++++++++++++++++++++++++++++++++
 providers/mlx5/verbs.c |  9 +++++++++
 4 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/providers/mlx5/mlx5.c b/providers/mlx5/mlx5.c
index a3ca14f4..ba2ddd84 100644
--- a/providers/mlx5/mlx5.c
+++ b/providers/mlx5/mlx5.c
@@ -51,10 +51,6 @@

 static void mlx5_free_context(struct ibv_context *ibctx);

-#ifndef PCI_VENDOR_ID_MELLANOX
-#define PCI_VENDOR_ID_MELLANOX			0x15b3
-#endif
-
 #ifndef CPU_OR
 #define CPU_OR(x, y, z) do {} while (0)
 #endif
@@ -155,11 +151,13 @@ static const struct verbs_context_ops mlx5_ctx_common_ops = {
 	.open_xrcd = mlx5_open_xrcd,
 	.post_srq_ops = mlx5_post_srq_ops,
 	.query_device_ex = mlx5_query_device_ex,
+	.query_ece = mlx5_query_ece,
 	.query_rt_values = mlx5_query_rt_values,
 	.read_counters = mlx5_read_counters,
 	.reg_dm_mr = mlx5_reg_dm_mr,
 	.alloc_null_mr = mlx5_alloc_null_mr,
 	.free_context = mlx5_free_context,
+	.set_ece = mlx5_set_ece,
 };

 static const struct verbs_context_ops mlx5_ctx_cqev1_ops = {
diff --git a/providers/mlx5/mlx5.h b/providers/mlx5/mlx5.h
index 494cbe04..c609d786 100644
--- a/providers/mlx5/mlx5.h
+++ b/providers/mlx5/mlx5.h
@@ -85,6 +85,10 @@ enum {
 	MLX5_DBG_DR		= 1 << 6,
 };

+#ifndef PCI_VENDOR_ID_MELLANOX
+#define PCI_VENDOR_ID_MELLANOX			0x15b3
+#endif
+
 extern uint32_t mlx5_debug_mask;
 extern int mlx5_freeze_on_error_cqe;

@@ -570,6 +574,9 @@ struct mlx5_qp {
 	uint32_t			rqn;
 	uint32_t			sqn;
 	uint64_t			tir_icm_addr;
+
+	struct ibv_ece default_ece;
+	struct ibv_ece ece;
 };

 struct mlx5_ah {
@@ -1109,4 +1116,7 @@ static inline bool srq_has_waitq(struct mlx5_srq *srq)

 bool srq_cooldown_wqe(struct mlx5_srq *srq, int ind);

+int mlx5_query_ece(struct ibv_qp *qp, struct ibv_ece *ece);
+int mlx5_set_ece(struct ibv_qp *qp, struct ibv_ece *ece);
+
 #endif /* MLX5_H */
diff --git a/providers/mlx5/qp.c b/providers/mlx5/qp.c
index 1e65d8b9..587bc3e6 100644
--- a/providers/mlx5/qp.c
+++ b/providers/mlx5/qp.c
@@ -2938,3 +2938,36 @@ void mlx5_clear_qp(struct mlx5_context *ctx, uint32_t qpn)
 	else
 		ctx->qp_table[tind].table[qpn & MLX5_QP_TABLE_MASK] = NULL;
 }
+
+int mlx5_query_ece(struct ibv_qp *qp, struct ibv_ece *ece)
+{
+	struct mlx5_qp *mqp = to_mqp(qp);
+
+	if (!mqp->ece.vendor_id) {
+		/* ECE wasn't set yet */
+		ece->vendor_id = mqp->default_ece.vendor_id;
+		ece->options = mqp->default_ece.options;
+
+		return 0;
+	}
+
+	ece->vendor_id = mqp->ece.vendor_id;
+	ece->options = mqp->ece.options;
+	return 0;
+}
+
+int mlx5_set_ece(struct ibv_qp *qp, struct ibv_ece *ece)
+{
+	struct mlx5_qp *mqp = to_mqp(qp);
+
+	/* This is a mark for modify_qp() that ECE is set */
+	mqp->ece.vendor_id = mqp->default_ece.vendor_id;
+
+	if (mqp->default_ece.vendor_id != ece->vendor_id)
+		mqp->ece.options = 0;
+	else
+		mqp->ece.options = mqp->default_ece.options & ece->options;
+
+	ece->options = mqp->ece.options;
+	return 0;
+}
diff --git a/providers/mlx5/verbs.c b/providers/mlx5/verbs.c
index b6794906..761d215b 100644
--- a/providers/mlx5/verbs.c
+++ b/providers/mlx5/verbs.c
@@ -1808,6 +1808,13 @@ static int create_dct(struct ibv_context *context,
 	return 0;
 }

+static void init_qp_ece(struct ibv_qp *qp)
+{
+	struct mlx5_qp *mqp = to_mqp(qp);
+
+	mqp->default_ece.vendor_id = PCI_VENDOR_ID_MELLANOX;
+}
+
 static struct ibv_qp *create_qp(struct ibv_context *context,
 				struct ibv_qp_init_attr_ex *attr,
 				struct mlx5dv_qp_init_attr *mlx5_qp_attr)
@@ -2139,6 +2146,8 @@ static struct ibv_qp *create_qp(struct ibv_context *context,
 	if (attr->comp_mask & IBV_QP_INIT_ATTR_SEND_OPS_FLAGS)
 		qp->verbs_qp.comp_mask |= VERBS_QP_EX;

+	init_qp_ece(ibqp);
+
 	return ibqp;

 err_destroy:
--
2.24.1

