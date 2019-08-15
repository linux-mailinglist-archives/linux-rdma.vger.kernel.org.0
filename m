Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECCF08E6FE
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2019 10:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbfHOIi5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Aug 2019 04:38:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfHOIi5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Aug 2019 04:38:57 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C07A22387;
        Thu, 15 Aug 2019 08:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565858336;
        bh=ZyzqQf17cnEyHFW9E++HcPHt+RGN+l++Znjp64bFEak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cv/FAEJZXBoV/aKe7iCw7y5DqEOZ3E1YFbZzNiW0opDaugMee/flpafuTRM+LAAv6
         qKcUiEJNXlITmW0pwPnpAV7FchHtelTX+OYT4buqCGo28JifzjAe/mYu6xaWjzUqxs
         JnGSk7Xe5nYo9VN7Uz5SXZ1guZAMdAeLJJD5xKKA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Ido Kalir <idok@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Moni Shoua <monis@mellanox.com>
Subject: [PATCH rdma-rc 5/8] IB/mlx5: Consolidate use_umr checks into single function
Date:   Thu, 15 Aug 2019 11:38:31 +0300
Message-Id: <20190815083834.9245-6-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190815083834.9245-1-leon@kernel.org>
References: <20190815083834.9245-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Moni Shoua <monis@mellanox.com>

Introduce helper function to unify various use_umr checks.

Signed-off-by: Moni Shoua <monis@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 14 ++++++++++++++
 drivers/infiniband/hw/mlx5/mr.c      |  4 +---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index f6a53455bf8b..9ae587b74b12 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1475,4 +1475,18 @@ int bfregn_to_uar_index(struct mlx5_ib_dev *dev,
 			bool dyn_bfreg);
 
 int mlx5_ib_qp_set_counter(struct ib_qp *qp, struct rdma_counter *counter);
+
+static inline bool mlx5_ib_can_use_umr(struct mlx5_ib_dev *dev,
+				       bool do_modify_atomic)
+{
+	if (MLX5_CAP_GEN(dev->mdev, umr_modify_entity_size_disabled))
+		return false;
+
+	if (do_modify_atomic &&
+	    MLX5_CAP_GEN(dev->mdev, atomic) &&
+	    MLX5_CAP_GEN(dev->mdev, umr_modify_atomic_disabled))
+		return false;
+
+	return true;
+}
 #endif /* MLX5_IB_H */
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index b74fad08412f..8bce65c03b84 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1293,9 +1293,7 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (err < 0)
 		return ERR_PTR(err);
 
-	use_umr = !MLX5_CAP_GEN(dev->mdev, umr_modify_entity_size_disabled) &&
-		  (!MLX5_CAP_GEN(dev->mdev, umr_modify_atomic_disabled) ||
-		   !MLX5_CAP_GEN(dev->mdev, atomic));
+	use_umr = mlx5_ib_can_use_umr(dev, true);
 
 	if (order <= mr_cache_max_order(dev) && use_umr) {
 		mr = alloc_mr_from_cache(pd, umem, virt_addr, length, ncont,
-- 
2.20.1

