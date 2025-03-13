Return-Path: <linux-rdma+bounces-8670-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D148A5F82A
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 15:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E172D19C44C1
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 14:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0B1267F6A;
	Thu, 13 Mar 2025 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZvJJZm0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27DA25FA25
	for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876212; cv=none; b=mIXc3KtE8XIC6sYdYa0+Vye+LWZ1IVYAe7j/DtgEWtgQxKAsSPogWEVH9QTcLfq2NzQuOkk5Hza+I4XCaHrdsNNxn8jpc6zm+3S6QSUIbzw0j/Nj+WLqj+CoFBwnVvu91Lyh/P8hHER3v22ls1JjJic2o42M4tJNXUPx1AC6SmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876212; c=relaxed/simple;
	bh=5ZAVIAWXRvwgm4Y4Y/GASwm71yC7wPd1k9FljBiw8rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMvHe/FGcTn0lGbmbM++vihptHCOxLAwQhzWigFhpQrv0yQupkj6VLR0YwQJzh4f18OhfzEcbMCurwJf9t6qR6ZkXDEcS4/dzV0UHcBZ27bIWiBL70aDEOZE23RVrsSTFlMqv/cW8FWYUnj4bkQKe8mTjrsbkwdUEqCmFwWrpv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZvJJZm0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C71EC4CEE5;
	Thu, 13 Mar 2025 14:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741876211;
	bh=5ZAVIAWXRvwgm4Y4Y/GASwm71yC7wPd1k9FljBiw8rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LZvJJZm0z5UUsdSaf2z06tDJAbtYmcyjGcLiu+Js8eKjFgABx+NBcmP3xF5E7f1DC
	 BRjfyhDc85KfMmTajSQZJwcL+p3OvZTFwIZYOt4A28gKpOzf5gMhl+fqy8edg5Nhxf
	 Dlc99ERUwLWcwWBCKDZZ6TuanCWRAVTfLRXTHPE+9kZdvpQ69n1BRG3XNJ6Yp1rDWY
	 kMdMtguaHY3yKWH3PtZfLD/x16vKuJL0FhGZzW5P/eff/Z+UIDoquofmHAvKaaw7iG
	 N2moNQ4afZhFc087mvRy3TtZndL6v7HZrDGLzswIRTaNbgXi6ChTsyLCVBLirb8AtA
	 aFVRLNe4QJCYw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Michael Guralnik <michaelgur@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next 1/7] RDMA/mlx5: Fix MR cache initialization error flow
Date: Thu, 13 Mar 2025 16:29:48 +0200
Message-ID: <c41d525fb3c72e28dd38511bf3aaccb5d584063e.1741875692.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741875692.git.leon@kernel.org>
References: <cover.1741875692.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Guralnik <michaelgur@nvidia.com>

Destroy all previously created cache entries and work queue when rolling
back the MR cache initialization upon an error.

Fixes: 73d09b2fe833 ("RDMA/mlx5: Introduce mlx5r_cache_rb_key")
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index bb02b6adbf2c..1ffa4b3d0f76 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -919,6 +919,25 @@ mlx5r_cache_create_ent_locked(struct mlx5_ib_dev *dev,
 	return ERR_PTR(ret);
 }
 
+static void mlx5r_destroy_cache_entries(struct mlx5_ib_dev *dev)
+{
+	struct rb_root *root = &dev->cache.rb_root;
+	struct mlx5_cache_ent *ent;
+	struct rb_node *node;
+
+	mutex_lock(&dev->cache.rb_lock);
+	node = rb_first(root);
+	while (node) {
+		ent = rb_entry(node, struct mlx5_cache_ent, node);
+		node = rb_next(node);
+		clean_keys(dev, ent);
+		rb_erase(&ent->node, root);
+		mlx5r_mkeys_uninit(ent);
+		kfree(ent);
+	}
+	mutex_unlock(&dev->cache.rb_lock);
+}
+
 int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 {
 	struct mlx5_mkey_cache *cache = &dev->cache;
@@ -970,6 +989,8 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 err:
 	mutex_unlock(&cache->rb_lock);
 	mlx5_mkey_cache_debugfs_cleanup(dev);
+	mlx5r_destroy_cache_entries(dev);
+	destroy_workqueue(cache->wq);
 	mlx5_ib_warn(dev, "failed to create mkey cache entry\n");
 	return ret;
 }
@@ -1003,17 +1024,7 @@ void mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
 	mlx5_cmd_cleanup_async_ctx(&dev->async_ctx);
 
 	/* At this point all entries are disabled and have no concurrent work. */
-	mutex_lock(&dev->cache.rb_lock);
-	node = rb_first(root);
-	while (node) {
-		ent = rb_entry(node, struct mlx5_cache_ent, node);
-		node = rb_next(node);
-		clean_keys(dev, ent);
-		rb_erase(&ent->node, root);
-		mlx5r_mkeys_uninit(ent);
-		kfree(ent);
-	}
-	mutex_unlock(&dev->cache.rb_lock);
+	mlx5r_destroy_cache_entries(dev);
 
 	destroy_workqueue(dev->cache.wq);
 	del_timer_sync(&dev->delay_timer);
-- 
2.48.1


