Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C835A298DB5
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 14:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421228AbgJZNWu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 09:22:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1776731AbgJZNTq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Oct 2020 09:19:46 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5998622265;
        Mon, 26 Oct 2020 13:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603718386;
        bh=PJHiRrOSw7My/JUwmS3Bw+/FZRkU5NJbmwAlX2AW8v8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lxz7yjraWZ5GPzdSi978DOobQ+rKHmcdddejX83jHHMRIepIs+AEv9vTg9sOeL9xC
         rQ2QgQkE30uhUri8Ocrj/0fP1jwM28OWjIAaFth47D9r+Lzv4wqucH1YLHcA23cBWs
         y+dACZ5wDWVtK5NbrCKcZ97wmmIhzP6kq2BOdARE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 1/7] RDMA/mlx5: Remove mlx5_ib_mr->order
Date:   Mon, 26 Oct 2020 15:19:30 +0200
Message-Id: <20201026131936.1335664-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026131936.1335664-1-leon@kernel.org>
References: <20201026131936.1335664-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

The is only ever set to non-zero if the MR is from the cache, and if it is
cached then the order is in cached_ent->order.

Make it clearer that use_umr_mtt_update() only returns true for cached MRs
and remove the redundant data.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 1 -
 drivers/infiniband/hw/mlx5/mr.c      | 5 +++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index b1f2b34e5955..93310dda01b6 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -601,7 +601,6 @@ struct mlx5_ib_mr {
 	struct ib_umem	       *umem;
 	struct mlx5_shared_mr_info	*smr_info;
 	struct list_head	list;
-	unsigned int		order;
 	struct mlx5_cache_ent  *cache_ent;
 	int			npages;
 	struct mlx5_ib_dev     *dev;
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 910120b551c5..c9be69fcc1ea 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -126,7 +126,9 @@ static int destroy_mkey(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 static inline bool mlx5_ib_pas_fits_in_mr(struct mlx5_ib_mr *mr, u64 start,
 					  u64 length)
 {
-	return ((u64)1 << mr->order) * MLX5_ADAPTER_PAGE_SIZE >=
+	if (!mr->cache_ent)
+		return false;
+	return ((u64)1 << mr->cache_ent->order) * MLX5_ADAPTER_PAGE_SIZE >=
 		length + (start & (MLX5_ADAPTER_PAGE_SIZE - 1));
 }
 
@@ -172,7 +174,6 @@ static struct mlx5_ib_mr *alloc_cache_mr(struct mlx5_cache_ent *ent, void *mkc)
 	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
 	if (!mr)
 		return NULL;
-	mr->order = ent->order;
 	mr->cache_ent = ent;
 	mr->dev = ent->dev;
 
-- 
2.26.2

