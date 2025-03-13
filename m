Return-Path: <linux-rdma+bounces-8673-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3892EA5F845
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 15:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99FDA3B6080
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 14:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CFF2690F8;
	Thu, 13 Mar 2025 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezTHtyPK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5872690E7
	for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876225; cv=none; b=eMTJr1qnxfaKTpgmN+KS1YmgtroAtHHHj3lqLFSLybIOdiPadFow+zrdmhjsaZfuKMOM0ri5bWdudQwaPpxGxe4wYZeRiUsf75OBbqI/4POB1uvoP3GkXAmFDBEDCZH4jA14I2HebG2Nihmx6Xj6F+gBYiY80IjgxIGw1a59syY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876225; c=relaxed/simple;
	bh=rSZjgtr2KN+VIBRbHPArVctg5jOfdOMSyyFLCmzdNik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aUwtRA0POozYm28dKdDx4vZLOJkR+HRttrGj8N4Jgbf/CPwyx261xCgASieL4B+CxeGFRneAbGQNWtwhN8szNZsCmh+TehLvNX1/PIf85FERCESdDQVSbVf7lWGvfdiAdOfJMBXGV9X+Y0VOTDKCE+HAA4hOjJnRNc2J+iAp5EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezTHtyPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6DCC4CEEB;
	Thu, 13 Mar 2025 14:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741876224;
	bh=rSZjgtr2KN+VIBRbHPArVctg5jOfdOMSyyFLCmzdNik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ezTHtyPKrvgN6ozoZvW4gNGmmHr/0AqBmvlcfswfXC14cC3MBJFe3cnRDdbSIf2kj
	 jGtizB/2PueC6pzZgKmAmOTPLLWoQxJZKv+7TXHCma5hvkp69oYzxuES9wfHNL0CE5
	 VfGa1EF7bV/SOrlyCD3hVduS3BR6niOs45EoRP9pPJiv2R7D2HOSuqlZxVm2x3jsUA
	 e9DmGnfttmUVsiZkz7xWHTUWUxeW80aOs8FsVGmNqIawI5eB6QeGCgL3j5rOAnMmgd
	 p0SfCQscqS8c7BHaszXVQKm+jS4NvHwih6b1326/aY6jJTketn0GLDD/6tdso8NKJG
	 UT2kTRHCWJrtg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Michael Guralnik <michaelgur@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next 3/7] RDMA/mlx5: Drop access_flags from _mlx5_mr_cache_alloc()
Date: Thu, 13 Mar 2025 16:29:50 +0200
Message-ID: <4d769c51eb012c62b3a92fd916b7886c25b56fbf.1741875692.git.leon@kernel.org>
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

Drop the unused access_flags parameter.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index cbab0240c7e5..2e5e25bb53f3 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -718,8 +718,7 @@ mkey_cache_ent_from_rb_key(struct mlx5_ib_dev *dev,
 }
 
 static struct mlx5_ib_mr *_mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
-					struct mlx5_cache_ent *ent,
-					int access_flags)
+					       struct mlx5_cache_ent *ent)
 {
 	struct mlx5_ib_mr *mr;
 	int err;
@@ -794,7 +793,7 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 	if (!ent)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	return _mlx5_mr_cache_alloc(dev, ent, access_flags);
+	return _mlx5_mr_cache_alloc(dev, ent);
 }
 
 static void mlx5_mkey_cache_debugfs_cleanup(struct mlx5_ib_dev *dev)
@@ -1155,7 +1154,7 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 		return mr;
 	}
 
-	mr = _mlx5_mr_cache_alloc(dev, ent, access_flags);
+	mr = _mlx5_mr_cache_alloc(dev, ent);
 	if (IS_ERR(mr))
 		return mr;
 
-- 
2.48.1


