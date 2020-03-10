Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4527717F1D6
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 09:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCJIXF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 04:23:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgCJIXF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 04:23:05 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E9E42467F;
        Tue, 10 Mar 2020 08:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583828584;
        bh=QDO2fdmtqaEAPmiK89oIhnb2azmGDr9PkJi3hgM3iz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M0DmsDs0o3rJn01XvlafDQ8RlQuxGy98rcyD3LTeQSPvkbvmfBgAObtYch00PwK/J
         Z98I4y0AWAHRDYN0yPle41xgTtBA3Je2ZuOfmikXIMek4tdBCSSiXZhTmx/u65Dmpw
         +mpgDoDuvlJ6u+GB1Q1acOHnv8JtGOIMbLnj8xtk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Artemy Kovalyov <artemyko@mellanox.com>,
        linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-next v1 07/12] RDMA/mlx5: Always remove MRs from the cache before destroying them
Date:   Tue, 10 Mar 2020 10:22:33 +0200
Message-Id: <20200310082238.239865-8-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200310082238.239865-1-leon@kernel.org>
References: <20200310082238.239865-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

The cache bucket tracks the total number of MRs that exists, both inside
and outside of the cache. Removing a MR from the cache (by setting
cache_ent to NULL) without updating total_mrs will cause the tracking to
leak and be inflated.

Further fix the rereg_mr path to always destroy the MR. reg_create will
always overwrite all the MR data in mlx5_ib_mr, so the MR must be
completely destroyed, in all cases, before this function can be
called. Detach the MR from the cache and unconditionally destroy it to
avoid leaking HW mkeys.

Fixes: afd1417404fb ("IB/mlx5: Use direct mkey destroy command upon UMR unreg failure")
Fixes: 56e11d628c5d ("IB/mlx5: Added support for re-registration of MRs")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 55e31f6effda..9b980ef326b4 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -479,6 +479,16 @@ static struct mlx5_ib_mr *alloc_cached_mr(struct mlx5_cache_ent *req_ent)
 	return mr;
 }
 
+static void detach_mr_from_cache(struct mlx5_ib_mr *mr)
+{
+	struct mlx5_cache_ent *ent = mr->cache_ent;
+
+	mr->cache_ent = NULL;
+	spin_lock_irq(&ent->lock);
+	ent->total_mrs--;
+	spin_unlock_irq(&ent->lock);
+}
+
 void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 {
 	struct mlx5_cache_ent *ent = mr->cache_ent;
@@ -488,7 +498,7 @@ void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 		return;
 
 	if (mlx5_mr_cache_invalidate(mr)) {
-		mr->cache_ent = NULL;
+		detach_mr_from_cache(mr);
 		destroy_mkey(dev, mr);
 		if (ent->available_mrs < ent->limit)
 			queue_work(dev->cache.wq, &ent->work);
@@ -1445,9 +1455,8 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 		 * UMR can't be used - MKey needs to be replaced.
 		 */
 		if (mr->cache_ent)
-			err = mlx5_mr_cache_invalidate(mr);
-		else
-			err = destroy_mkey(dev, mr);
+			detach_mr_from_cache(mr);
+		err = destroy_mkey(dev, mr);
 		if (err)
 			goto err;
 
@@ -1459,8 +1468,6 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 			mr = to_mmr(ib_mr);
 			goto err;
 		}
-
-		mr->cache_ent = NULL;
 	} else {
 		/*
 		 * Send a UMR WQE
-- 
2.24.1

