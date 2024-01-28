Return-Path: <linux-rdma+bounces-781-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3AB83F4CF
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jan 2024 10:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82C31F21E89
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jan 2024 09:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE29DF60;
	Sun, 28 Jan 2024 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDeHMOUs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298FFDDDC
	for <linux-rdma@vger.kernel.org>; Sun, 28 Jan 2024 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706434180; cv=none; b=Zl7oQyyAehzAynAEoWJIt7pDuZbWvU8ohvI0L2zvEAESTj9Jul04bCx+xtdFxYBj/AoEiohSiH3XEFIIS2y9L7XywuCg0vgGYlJvxUbVMg1H7mz835FumPKVNFwHGDsmf5eYzli1tr48ewrEdd29osJ2dntMamYO/p9GHVhodeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706434180; c=relaxed/simple;
	bh=ftw8s/q3SdJ5hbrwxyJKiEYKNHIqCm/vNo07aJs33wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3cALW68cSXhnQ+veFQodcX4ceAqG9griM0fMyc01YB5Zb4t6oij5zuYKTMvxnKBK1UXaabZ+3KJFVe3+w23xQY3pcaYTECF/ibBqwOkTJQMPo3oOKGQbaYNNaPXUp3xQjZhW8TD1S4KkCMzOg4tLjHfFWnrAlwoX8FpiR+V3ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDeHMOUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BA1C433C7;
	Sun, 28 Jan 2024 09:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706434179;
	bh=ftw8s/q3SdJ5hbrwxyJKiEYKNHIqCm/vNo07aJs33wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qDeHMOUsVswx2iu5RsVHIMkOyAo+cqX0I9aeiJW6o0qOb21GZBCIkxJPuBtVF+Bsc
	 OVvip9Tz5cDo4mHLRHuKcjkdDoOdUhtSfJAjSllzYE9G61xMQo871hqjSNgnginaw1
	 kE5YrNo+NcUdtP9tvluGwGsb4CoE9tyBFWlzsVwJQQLaqQKaVOB57bktTCQCnk8Rkm
	 R40kqsyXa4noSutS7oA8Oer7Mkb9db1Ykm7XZFW71ta7ptGiWD1yIwjo9fMNI6b7y4
	 FSdl9VPpz9RI+9qQ1GkyIiveZQikBWfob2jNfhH18vPKNTYHK450di7/DHAIpZJ/tY
	 E/KHzX8dWwk/Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Or Har-Toov <ohartoov@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Maor Gottlieb <maorg@nvidia.com>,
	Mark Zhang <markzhang@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Tamar Mashiah <tmashiah@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next v1 4/6] RDMA/mlx5: Uncacheable mkey has neither rb_key or cache_ent
Date: Sun, 28 Jan 2024 11:29:14 +0200
Message-ID: <cff57806e1c8e339ed9cf3d60f09d89ac9696755.1706433934.git.leon@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706433934.git.leon@kernel.org>
References: <cover.1706433934.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Or Har-Toov <ohartoov@nvidia.com>

As some mkeys can't be modified with UMR due to some UMR limitations,
like the size of translation that can be updated, not all user mkeys can
be cached.

Fixes: dd1b913fb0d0 ("RDMA/mlx5: Cache all user cacheable mkeys on dereg MR flow")
Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 4bdf3da579f4..69b1722c2280 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -643,7 +643,7 @@ struct mlx5_ib_mkey {
 	unsigned int ndescs;
 	struct wait_queue_head wait;
 	refcount_t usecount;
-	/* User Mkey must hold either a rb_key or a cache_ent. */
+	/* Cacheable user Mkey must hold either a rb_key or a cache_ent. */
 	struct mlx5r_cache_rb_key rb_key;
 	struct mlx5_cache_ent *cache_ent;
 };
-- 
2.43.0


