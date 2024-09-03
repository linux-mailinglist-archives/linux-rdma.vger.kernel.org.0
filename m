Return-Path: <linux-rdma+bounces-4714-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C680B969BA0
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 13:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719EB1F2529B
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 11:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24AA1A42C2;
	Tue,  3 Sep 2024 11:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gefml+WH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816A51A42B3
	for <linux-rdma@vger.kernel.org>; Tue,  3 Sep 2024 11:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725362705; cv=none; b=pI75h3Rk4uGa6kTz/4sn8pnyP+365Dy8f24/TMcE6pgiD3R/K735ctzdFmpD9udouBJET3Bod13JId/CsYDkujTWeVM87zYpPB6heq49mRuo/KUYt6bW3o2qdE7XNdzRPT95NYyvotpM9ywaCkO9VudOZPlKr0bCd/azZ6TPEZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725362705; c=relaxed/simple;
	bh=ZG4EFnbDx7TddsG90VDGCNy+1YIKAFuIShpWeP91iU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6xUOw4ByM0Haz3ZuV48JqHWWo5QLlrHcyaSYjvkTDJZ2JdtRXMbHU6uE06FpKZck8lc/87akTLLMQMUuh/Xz7HlWjjj3aa1Hl1HEAT4yxrq+1b8t0PA+kW+nP/iyUh8sJJW/QplPRKderOGenf3qCz0Vss6ZZutzOM54zRfoKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gefml+WH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDFAC4CEC4;
	Tue,  3 Sep 2024 11:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725362705;
	bh=ZG4EFnbDx7TddsG90VDGCNy+1YIKAFuIShpWeP91iU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gefml+WHFiZshbDXVwG/t1Mbu1VFkmve6FH3Z8lZ/aFxXVGst9/r7cA4RCTFOKFHp
	 FyMprBRf5GTaXQbGt7RVPvTKHm+rTPO72OWFlGfJbPMsD1JgshVuI/QFNLrd1MShIu
	 cfBu5GBrJLVRyiaGmyYfjPR58v4ZjAr9f7czSBASHxx2IGyfN5vCQnD46SEZpvw+vu
	 +XmrUw7/S75nfTUlRQ5g/pyS3O264pYWztjjyGtujkeTw1oKjLDnqOVRD2d9VCwqUh
	 epiMlNWB2rB4tTzT0VA1oH7x4mRlfAbNwBS84jA6EJ0R+wlVuFc9LJqFH3j/pcTqbu
	 XRPr4AMyC39Kg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Michael Guralnik <michaelgur@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Shay Drory <shayd@nvidia.com>
Subject: [PATCH rdma-next 3/4] RDMA/mlx5: Limit usage of over-sized mkeys from the MR cache
Date: Tue,  3 Sep 2024 14:24:49 +0300
Message-ID: <8ba3a6e3748aace2026de8b83da03aba084f78f4.1725362530.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725362530.git.leon@kernel.org>
References: <cover.1725362530.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Guralnik <michaelgur@nvidia.com>

When searching the MR cache for suitable cache entries, don't use mkeys
larger than twice the size required for the MR.
This should ensure the usage of mkeys closer to the minimal required size
and reduce memory waste.

On driver init we create entries for mkeys with clear attributes and
powers of 2 sizes from 4 to the max supported size.
This solves the issue for anyone using mkeys that fit these
requirements.

In the use case where an MR is registered with different attributes,
like an access flag we can't UMR, we'll create a new cache entry to store
it upon dereg.
Without this fix, any later registration with same attributes and smaller
size will use the newly created cache entry and it's mkeys, disregarding
the memory waste of using mkeys larger than required.

For example, one worst-case scenario can be when registering and
deregstering a 1GB mkey with ATS enabled which will cause the creation of
a new cache entry to hold those type of mkeys. A user registering a 4k MR
with ATS will end up using the new cache entry and an mkey that can
support a 1GB MR, thus wasting x250k memory than actually needed in the HW.

Additionally, allow all small registration to use the smallest size
cache entry that is initialized on driver load even if size is larger
than twice the required size.

Fixes: 73d09b2fe833 ("RDMA/mlx5: Introduce mlx5r_cache_rb_key")
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 80038e3998af..c17a35014a2b 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -49,6 +49,7 @@ enum {
 	MAX_PENDING_REG_MR = 8,
 };
 
+#define MLX5_MR_CACHE_PERSISTENT_ENTRY_MIN_DESCS 4
 #define MLX5_UMR_ALIGN 2048
 
 static void
@@ -662,6 +663,7 @@ mkey_cache_ent_from_rb_key(struct mlx5_ib_dev *dev,
 {
 	struct rb_node *node = dev->cache.rb_root.rb_node;
 	struct mlx5_cache_ent *cur, *smallest = NULL;
+	u64 ndescs_limit;
 	int cmp;
 
 	/*
@@ -680,10 +682,18 @@ mkey_cache_ent_from_rb_key(struct mlx5_ib_dev *dev,
 			return cur;
 	}
 
+	/*
+	 * Limit the usage of mkeys larger than twice the required size while
+	 * also allowing the usage of smallest cache entry for small MRs.
+	 */
+	ndescs_limit = max_t(u64, rb_key.ndescs * 2,
+			     MLX5_MR_CACHE_PERSISTENT_ENTRY_MIN_DESCS);
+
 	return (smallest &&
 		smallest->rb_key.access_mode == rb_key.access_mode &&
 		smallest->rb_key.access_flags == rb_key.access_flags &&
-		smallest->rb_key.ats == rb_key.ats) ?
+		smallest->rb_key.ats == rb_key.ats &&
+		smallest->rb_key.ndescs <= ndescs_limit) ?
 		       smallest :
 		       NULL;
 }
@@ -964,7 +974,7 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 	mlx5_mkey_cache_debugfs_init(dev);
 	mutex_lock(&cache->rb_lock);
 	for (i = 0; i <= mkey_cache_max_order(dev); i++) {
-		rb_key.ndescs = 1 << (i + 2);
+		rb_key.ndescs = MLX5_MR_CACHE_PERSISTENT_ENTRY_MIN_DESCS << i;
 		ent = mlx5r_cache_create_ent_locked(dev, rb_key, true);
 		if (IS_ERR(ent)) {
 			ret = PTR_ERR(ent);
-- 
2.46.0


