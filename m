Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 348E7CD33F
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Oct 2019 17:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbfJFPyv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 6 Oct 2019 11:54:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbfJFPyv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 6 Oct 2019 11:54:51 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B3A02084B;
        Sun,  6 Oct 2019 15:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570377290;
        bh=mbwJQYOL7sQfcCNXTmiUaiJpjDplMxeAfj5ACxbegCk=;
        h=From:To:Cc:Subject:Date:From;
        b=vYCmNqOlmtwhs5LLXqfSNOqH1b6HE7E0mfoVte/hXg8KiKG4qwX5tfnzp8CCVjA0q
         q17foY2sivTSOy30wHjPfUVdLK4S69O5VorwDVvw9kKlu0z6YPPywDCuD78MKZDhWp
         0Bdd3vjU4RuiSfyp0MNrAfGWkQUnxIkgh57jt38k=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Parav Pandit <parav@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-next] IB/mlx5: Introduce and use mkey context setting helper routine
Date:   Sun,  6 Oct 2019 18:54:43 +0300
Message-Id: <20191006155443.31068-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

Introduce and use set_mkc_access_pd_addr_fields() which sets mkey
context's access rights, PD, address fields.
Thereby avoid the code duplication.

Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 34 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 1eff031ef048..2b57f0e085d6 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -705,6 +705,20 @@ int mlx5_mr_cache_cleanup(struct mlx5_ib_dev *dev)
 	return 0;
 }
 
+static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
+					  struct ib_pd *pd)
+{
+	MLX5_SET(mkc, mkc, a, !!(acc & IB_ACCESS_REMOTE_ATOMIC));
+	MLX5_SET(mkc, mkc, rw, !!(acc & IB_ACCESS_REMOTE_WRITE));
+	MLX5_SET(mkc, mkc, rr, !!(acc & IB_ACCESS_REMOTE_READ));
+	MLX5_SET(mkc, mkc, lw, !!(acc & IB_ACCESS_LOCAL_WRITE));
+	MLX5_SET(mkc, mkc, lr, 1);
+
+	MLX5_SET(mkc, mkc, pd, to_mpd(pd)->pdn);
+	MLX5_SET(mkc, mkc, qpn, 0xffffff);
+	MLX5_SET64(mkc, mkc, start_addr, start_addr);
+}
+
 struct ib_mr *mlx5_ib_get_dma_mr(struct ib_pd *pd, int acc)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
@@ -728,16 +742,8 @@ struct ib_mr *mlx5_ib_get_dma_mr(struct ib_pd *pd, int acc)
 	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
 
 	MLX5_SET(mkc, mkc, access_mode_1_0, MLX5_MKC_ACCESS_MODE_PA);
-	MLX5_SET(mkc, mkc, a, !!(acc & IB_ACCESS_REMOTE_ATOMIC));
-	MLX5_SET(mkc, mkc, rw, !!(acc & IB_ACCESS_REMOTE_WRITE));
-	MLX5_SET(mkc, mkc, rr, !!(acc & IB_ACCESS_REMOTE_READ));
-	MLX5_SET(mkc, mkc, lw, !!(acc & IB_ACCESS_LOCAL_WRITE));
-	MLX5_SET(mkc, mkc, lr, 1);
-
 	MLX5_SET(mkc, mkc, length64, 1);
-	MLX5_SET(mkc, mkc, pd, to_mpd(pd)->pdn);
-	MLX5_SET(mkc, mkc, qpn, 0xffffff);
-	MLX5_SET64(mkc, mkc, start_addr, 0);
+	set_mkc_access_pd_addr_fields(mkc, acc, 0, pd);
 
 	err = mlx5_core_create_mkey(mdev, &mr->mmkey, in, inlen);
 	if (err)
@@ -1195,16 +1201,8 @@ static struct ib_mr *mlx5_ib_get_dm_mr(struct ib_pd *pd, u64 start_addr,
 
 	MLX5_SET(mkc, mkc, access_mode_1_0, mode & 0x3);
 	MLX5_SET(mkc, mkc, access_mode_4_2, (mode >> 2) & 0x7);
-	MLX5_SET(mkc, mkc, a, !!(acc & IB_ACCESS_REMOTE_ATOMIC));
-	MLX5_SET(mkc, mkc, rw, !!(acc & IB_ACCESS_REMOTE_WRITE));
-	MLX5_SET(mkc, mkc, rr, !!(acc & IB_ACCESS_REMOTE_READ));
-	MLX5_SET(mkc, mkc, lw, !!(acc & IB_ACCESS_LOCAL_WRITE));
-	MLX5_SET(mkc, mkc, lr, 1);
-
 	MLX5_SET64(mkc, mkc, len, length);
-	MLX5_SET(mkc, mkc, pd, to_mpd(pd)->pdn);
-	MLX5_SET(mkc, mkc, qpn, 0xffffff);
-	MLX5_SET64(mkc, mkc, start_addr, start_addr);
+	set_mkc_access_pd_addr_fields(mkc, acc, start_addr, pd);
 
 	err = mlx5_core_create_mkey(mdev, &mr->mmkey, in, inlen);
 	if (err)
-- 
2.20.1

