Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642423A2591
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 09:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhFJHgj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 03:36:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230216AbhFJHgi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Jun 2021 03:36:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0813A613C8;
        Thu, 10 Jun 2021 07:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623310482;
        bh=O1B3V2YPO+YDp3N7oiYD0TcuWdFjo3OnLD6+S6ZVUYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dfAgcFxv2C+3x9JN7Hc1OC16J444Krsc4aHaJPL28gn6cQfNgIZ5/2r/L0bS/8lF2
         54fFyvWORyRwMM4H9hKT26z4keSnP+tRcWgtk2xlE75fWnDHy/ExFL7xVYb6FrWlQv
         FJHgR4qJ373zht/QUYBf1qP4i29yUORllsCMzAtzpYd86GYvXibn237z3xjZQ+Pp0y
         1QqVFNBiSIII9scrDcEszro86QiSpAl1L/Jyu0nnV9dJxMVxTLOgixstcQyIRE8R6l
         iocR/QNZRFnJIUoJ4FyUrOQnqFWBehIGRkUA/VvjOkyT2sQLZ525kVh+1gOfsccvFZ
         oZserdl87dJZw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alaa Hleihel <alaa@nvidia.com>, Aharon Landau <aharonl@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-rc 3/3] IB/mlx5: Fix initializing CQ fragments buffer
Date:   Thu, 10 Jun 2021 10:34:27 +0300
Message-Id: <90a0e8c924093cfa50a482880ad7e7edb73dc19a.1623309971.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623309971.git.leonro@nvidia.com>
References: <cover.1623309971.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Alaa Hleihel <alaa@nvidia.com>

Function init_cq_frag_buf() can be called to initialize the current CQ
fragments buffer cq->buf, or the temporary cq->resize_buf that is filled
during CQ resize operation.

However, the offending commit started to use function get_cqe() for
getting the CQEs, the issue with this change is that get_cqe() always
returns CQEs from cq->buf, which leads us to initialize the wrong
buffer, and in case of enlarging the CQ we try to access elements beyond
the size of the current cq->buf and eventually hit a kernel panic.

 [exception RIP: init_cq_frag_buf+103]
  [ffff9f799ddcbcd8] mlx5_ib_resize_cq at ffffffffc0835d60 [mlx5_ib]
  [ffff9f799ddcbdb0] ib_resize_cq at ffffffffc05270df [ib_core]
  [ffff9f799ddcbdc0] llt_rdma_setup_qp at ffffffffc0a6a712 [llt]
  [ffff9f799ddcbe10] llt_rdma_cc_event_action at ffffffffc0a6b411 [llt]
  [ffff9f799ddcbe98] llt_rdma_client_conn_thread at ffffffffc0a6bb75 [llt]
  [ffff9f799ddcbec8] kthread at ffffffffa66c5da1
  [ffff9f799ddcbf50] ret_from_fork_nospec_begin at ffffffffa6d95ddd

Fix it by getting the needed CQE by calling mlx5_frag_buf_get_wqe() that
takes the correct source buffer as a parameter.

Fixes: 388ca8be0037 ("IB/mlx5: Implement fragmented completion queue (CQ)")
Signed-off-by: Alaa Hleihel <alaa@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/cq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index eb92cefffd77..9ce01f729673 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -849,15 +849,14 @@ static void destroy_cq_user(struct mlx5_ib_cq *cq, struct ib_udata *udata)
 	ib_umem_release(cq->buf.umem);
 }
 
-static void init_cq_frag_buf(struct mlx5_ib_cq *cq,
-			     struct mlx5_ib_cq_buf *buf)
+static void init_cq_frag_buf(struct mlx5_ib_cq_buf *buf)
 {
 	int i;
 	void *cqe;
 	struct mlx5_cqe64 *cqe64;
 
 	for (i = 0; i < buf->nent; i++) {
-		cqe = get_cqe(cq, i);
+		cqe = mlx5_frag_buf_get_wqe(&buf->fbc, i);
 		cqe64 = buf->cqe_size == 64 ? cqe : cqe + 64;
 		cqe64->op_own = MLX5_CQE_INVALID << 4;
 	}
@@ -883,7 +882,7 @@ static int create_cq_kernel(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *cq,
 	if (err)
 		goto err_db;
 
-	init_cq_frag_buf(cq, &cq->buf);
+	init_cq_frag_buf(&cq->buf);
 
 	*inlen = MLX5_ST_SZ_BYTES(create_cq_in) +
 		 MLX5_FLD_SZ_BYTES(create_cq_in, pas[0]) *
@@ -1184,7 +1183,7 @@ static int resize_kernel(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *cq,
 	if (err)
 		goto ex;
 
-	init_cq_frag_buf(cq, cq->resize_buf);
+	init_cq_frag_buf(cq->resize_buf);
 
 	return 0;
 
-- 
2.31.1

