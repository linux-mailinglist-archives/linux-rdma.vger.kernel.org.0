Return-Path: <linux-rdma+bounces-11755-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8824AED9F1
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 12:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 248101896B29
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 10:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D26323B60B;
	Mon, 30 Jun 2025 10:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shzjZHNy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441311D6AA;
	Mon, 30 Jun 2025 10:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751279760; cv=none; b=roS3uNKUn2v8tFBbkP1hT06tk9n+Ql6QgpArLhQbnMlRYwsiIi+5fORjNXrRBynyNTPAZn8XOf9cpEAdarrER1hvWYydvQONhwFNoI0SWXEeGa944CGV1FtYsQrTuA/sq+flzocgooa+DZHUSDemImoo9olJnR6quL85wEoZ1Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751279760; c=relaxed/simple;
	bh=D6reJ6Ipd9xg1Em6f7tXtzdoIcj9ApvrMUd8XDhNz7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ezmFiv+CjEc/HxS/VxCxUXQuRsHsCRY68mrEQO1eGZyS+BjUPkxChMJ1N2rD4nNareyo6GpjGXouZpdmo9YWXCEhSM8Fwq0NyCwqMlITgWv+fE0jcWRj3yEy8XVIDXlVRgHLdyhUN6rcxF6rnIJJdItoJpvyQKNFmhP1SOrMiyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shzjZHNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D6AC4CEEB;
	Mon, 30 Jun 2025 10:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751279759;
	bh=D6reJ6Ipd9xg1Em6f7tXtzdoIcj9ApvrMUd8XDhNz7Q=;
	h=From:To:Cc:Subject:Date:From;
	b=shzjZHNy9TAszHe7GWEIeSqNEMawWONJGj3wvybp7sz/Mt1hggBXjBiS96xRr6+55
	 qF0IiyPCRRXkqBp2lOzPPFkdvyVR0e/ktCnE/Mp3xyeiwIt+s52J3NaJp5XVIobsfQ
	 D2iggqascF0dd0MJ0Py3r9X9XwaIAU+oCcAlY9Spxn1RcQWcBwfOQdu64INQXLil6B
	 XtXtF2Ls6/1+3btGbdAEDO86P+hbDp9tNfT8/G8gmwPNyC+pydXdSykkPvsp924neL
	 AYG9UcTKZjdvhi4Ry8NHH5W3oAAnVCXD1hQgrf0uhLoqTwFlsDQSBPWVPpBCXvj5wc
	 wctI16aYkXjUg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Stav Aviram <saviram@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <markb@mellanox.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next] net/mlx5: Check device memory pointer before usage
Date: Mon, 30 Jun 2025 13:35:53 +0300
Message-ID: <e389fa6ef075af1049cd7026b912d736ebe3ad23.1751279408.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stav Aviram <saviram@nvidia.com>

Add a NULL check before accessing device memory to prevent a crash if
dev->dm allocation in mlx5_init_once() fails.

Fixes: c9b9dcb430b3 ("net/mlx5: Move device memory management to mlx5_core")
Signed-off-by: Stav Aviram <saviram@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/dm.c                  | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/dm.c b/drivers/infiniband/hw/mlx5/dm.c
index b4c97fb62abf..9ded2b7c1e31 100644
--- a/drivers/infiniband/hw/mlx5/dm.c
+++ b/drivers/infiniband/hw/mlx5/dm.c
@@ -282,7 +282,7 @@ static struct ib_dm *handle_alloc_dm_memic(struct ib_ucontext *ctx,
 	int err;
 	u64 address;
 
-	if (!MLX5_CAP_DEV_MEM(dm_db->dev, memic))
+	if (!dm_db || !MLX5_CAP_DEV_MEM(dm_db->dev, memic))
 		return ERR_PTR(-EOPNOTSUPP);
 
 	dm = kzalloc(sizeof(*dm), GFP_KERNEL);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c
index 7c5516b0a844..8115071c34a4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c
@@ -30,7 +30,7 @@ struct mlx5_dm *mlx5_dm_create(struct mlx5_core_dev *dev)
 
 	dm = kzalloc(sizeof(*dm), GFP_KERNEL);
 	if (!dm)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	spin_lock_init(&dm->lock);
 
@@ -96,7 +96,7 @@ struct mlx5_dm *mlx5_dm_create(struct mlx5_core_dev *dev)
 err_steering:
 	kfree(dm);
 
-	return ERR_PTR(-ENOMEM);
+	return NULL;
 }
 
 void mlx5_dm_cleanup(struct mlx5_core_dev *dev)
-- 
2.50.0


