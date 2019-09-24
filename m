Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 562DFBC366
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2019 09:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393313AbfIXHwn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Sep 2019 03:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393126AbfIXHwn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Sep 2019 03:52:43 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A07AA20673;
        Tue, 24 Sep 2019 07:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569311562;
        bh=7TIeTAKe49fHIJtG8BnaklkekNB93IN14F5VzJB7520=;
        h=From:To:Cc:Subject:Date:From;
        b=e623tpkSyNodt/GNNPH/YFwA9nxgMExRkcShsOT56lAXMJz5wi99Xx3GId1EoESPf
         yFBZQsKehyi6CX3G/rLWDWDLdeXAUNNAPwU0nQs+PXokeQYlRi5Wq8VwNyK/8l6maF
         7JmzB2UxbzvsOBQDW+93IlIyWvq49wXEnc4/gCfI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-core] mlx5: Don't assume that input is rounded to power two
Date:   Tue, 24 Sep 2019 10:52:37 +0300
Message-Id: <20190924075237.15612-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The simple arithmetic can be done in order to stop assume
that code provided to ilog32() used in mlx5 is rounded to
power two.

Reviewed-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 providers/mlx5/dr_devx.c | 4 ++--
 providers/mlx5/dr_send.c | 4 ++--
 providers/mlx5/srq.c     | 2 +-
 providers/mlx5/verbs.c   | 8 ++++----
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/providers/mlx5/dr_devx.c b/providers/mlx5/dr_devx.c
index ee1b5486e..cc8c20d34 100644
--- a/providers/mlx5/dr_devx.c
+++ b/providers/mlx5/dr_devx.c
@@ -324,9 +324,9 @@ struct mlx5dv_devx_obj *dr_devx_create_qp(struct ibv_context *ctx,
 	DEVX_SET(qpc, qpc, uar_page, attr->page_id);
 	DEVX_SET(qpc, qpc, cqn_snd, attr->cqn);
 	DEVX_SET(qpc, qpc, cqn_rcv, attr->cqn);
-	DEVX_SET(qpc, qpc, log_sq_size, ilog32(attr->sq_wqe_cnt) - 1);
+	DEVX_SET(qpc, qpc, log_sq_size, ilog32(attr->sq_wqe_cnt - 1));
 	DEVX_SET(qpc, qpc, log_rq_stride, attr->rq_wqe_shift - 4);
-	DEVX_SET(qpc, qpc, log_rq_size, ilog32(attr->rq_wqe_cnt) - 1);
+	DEVX_SET(qpc, qpc, log_rq_size, ilog32(attr->rq_wqe_cnt - 1));
 	DEVX_SET(qpc, qpc, dbr_umem_id, attr->db_umem_id);
 
 	DEVX_SET(create_qp_in, in, wq_umem_id, attr->buff_umem_id);
diff --git a/providers/mlx5/dr_send.c b/providers/mlx5/dr_send.c
index dd9d6eda3..32a60fd95 100644
--- a/providers/mlx5/dr_send.c
+++ b/providers/mlx5/dr_send.c
@@ -210,8 +210,8 @@ static int dr_calc_rq_size(struct dr_qp *dr_qp,
 	wq_size = roundup_pow_of_two(attr->cap.max_recv_wr) * wqe_size;
 	wq_size = max(wq_size, MLX5_SEND_WQE_BB);
 	dr_qp->rq.wqe_cnt = wq_size / wqe_size;
-	dr_qp->rq.wqe_shift = ilog32(wqe_size) - 1;
-	dr_qp->rq.max_post = 1 << (ilog32(wq_size / wqe_size) - 1);
+	dr_qp->rq.wqe_shift = ilog32(wqe_size - 1);
+	dr_qp->rq.max_post = 1 << ilog32(wq_size / wqe_size - 1);
 	dr_qp->rq.max_gs = wqe_size / sizeof(struct mlx5_wqe_data_seg);
 
 	return wq_size;
diff --git a/providers/mlx5/srq.c b/providers/mlx5/srq.c
index 2124480cd..1c15656f6 100644
--- a/providers/mlx5/srq.c
+++ b/providers/mlx5/srq.c
@@ -291,7 +291,7 @@ int mlx5_alloc_srq_buf(struct ibv_context *context, struct mlx5_srq *srq,
 	srq->max_gs = (size - sizeof(struct mlx5_wqe_srq_next_seg)) /
 		sizeof(struct mlx5_wqe_data_seg);
 
-	srq->wqe_shift = ilog32(size) - 1;
+	srq->wqe_shift = ilog32(size - 1);
 
 	srq->max = align_queue_size(max_wr);
 	buf_size = srq->max * size;
diff --git a/providers/mlx5/verbs.c b/providers/mlx5/verbs.c
index a6cd3afe3..aa8920825 100644
--- a/providers/mlx5/verbs.c
+++ b/providers/mlx5/verbs.c
@@ -1400,8 +1400,8 @@ static int mlx5_calc_rwq_size(struct mlx5_context *ctx,
 	wq_size = roundup_pow_of_two(attr->max_wr) * wqe_size;
 	wq_size = max(wq_size, MLX5_SEND_WQE_BB);
 	rwq->rq.wqe_cnt = wq_size / wqe_size;
-	rwq->rq.wqe_shift = ilog32(wqe_size) - 1;
-	rwq->rq.max_post = 1 << (ilog32(wq_size / wqe_size) - 1);
+	rwq->rq.wqe_shift = ilog32(wqe_size - 1);
+	rwq->rq.max_post = 1 << ilog32(wq_size / wqe_size - 1);
 	scat_spc = wqe_size -
 		((rwq->wq_sig) ? sizeof(struct mlx5_rwqe_sig) : 0) -
 		is_mprq * sizeof(struct mlx5_wqe_srq_next_seg);
@@ -1436,8 +1436,8 @@ static int mlx5_calc_rq_size(struct mlx5_context *ctx,
 	if (wqe_size) {
 		wq_size = max(wq_size, MLX5_SEND_WQE_BB);
 		qp->rq.wqe_cnt = wq_size / wqe_size;
-		qp->rq.wqe_shift = ilog32(wqe_size) - 1;
-		qp->rq.max_post = 1 << (ilog32(wq_size / wqe_size) - 1);
+		qp->rq.wqe_shift = ilog32(wqe_size - 1);
+		qp->rq.max_post = 1 << ilog32(wq_size / wqe_size - 1);
 		scat_spc = wqe_size -
 			(qp->wq_sig ? sizeof(struct mlx5_rwqe_sig) : 0);
 		qp->rq.max_gs = scat_spc / sizeof(struct mlx5_wqe_data_seg);
-- 
2.20.1

