Return-Path: <linux-rdma+bounces-752-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B104583C285
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 13:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37D3EB2179C
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 12:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D222928E3;
	Thu, 25 Jan 2024 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gsr8y0+6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946A5BE6C
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jan 2024 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706185840; cv=none; b=iMX/chLqOXFprBA4bVbCfYhHPoBG3dUkegWR5QRe9TDbhtdUQcqdplTN+bgSM5nrtQqaRqC74TtArIPlOAxJpwbKvR9dCDxtJv88xBd6kE8eCcO9H335psPGg5Zg0miW297iBKEz04xpuXDFD0YaTZdurvKKRD5GzlVBBkg97ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706185840; c=relaxed/simple;
	bh=0GpRh6WesGj1VQ1gExid77UVE9v2LjXvyz1TH4J1aLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBZzo2sK4gQe2JsZZxFJfg25GdMv85sxN6uKAeYbirAXycFhhw3pppstqXxLkwO4JNwroUrGtWaOd+74ufGdIw8owOLro6JcjNDHfp36Qc8bn2HBcocDTobrQma1bq+9L/2t13xy69ggYotuFnw8gyXkqimJktriwmK7Cen2eD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gsr8y0+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FC2C433F1;
	Thu, 25 Jan 2024 12:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706185840;
	bh=0GpRh6WesGj1VQ1gExid77UVE9v2LjXvyz1TH4J1aLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gsr8y0+6gnh/Q8Y5g1JH3cClcS4YBswQZnuAKCtp2wrQnneA7wezcWqtwVSTQhmf1
	 4gstqjCgYTEfYXjLMvGncTbZJHDaAwvCQscrRCsrA7ie2JvrtCqUVwBppxurWj6gAo
	 T1mEUA4tLI5ac0eBZnqKDDEAvQXPOpamTrYWBZY0dSf4KH1bQWkvCbEVpQ3lQLd2oz
	 N3QPEg6NlEY/T/QqRjjAaVRgy54e7xNdhwaN65LrwLJzoBqLZmXQK39z2amLSBjl3F
	 7ZcMcKdEXgLwyApN0VGzOogj6uj259xrSl9XpIsDRVxnqe6X3kvvosjvs1qHLiHia5
	 9GOedqNi2SwTg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Or Har-Toov <ohartoov@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Maor Gottlieb <maorg@nvidia.com>,
	Mark Zhang <markzhang@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Tamar Mashiah <tmashiah@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next 5/6] RDMA/mlx5: Change check for cacheable user mkeys
Date: Thu, 25 Jan 2024 14:30:11 +0200
Message-ID: <4641d8f79a88b07925cab0d8cd1ffc032a9115ef.1706185318.git.leon@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706185318.git.leon@kernel.org>
References: <cover.1706185318.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Or Har-Toov <ohartoov@nvidia.com>

In the dereg flow, UMEM is not a good enough indication whether an MR
is from userspace since in mlx5_ib_rereg_user_mr there are some cases
when a new MR is created and the UMEM of the old MR is set to NULL.
Currently when mlx5_ib_dereg_mr is called on the old MR, UMEM is NULL
but cache_ent can be different than NULL. So, the mkey will not be
destroyed.
Therefore checking if mkey is from user application and cacheable
should be done by checking if rb_key or cache_ent exist and all other kind of
mkeys should be destroyed.

Fixes: dd1b913fb0d0 ("RDMA/mlx5: Cache all user cacheable mkeys on dereg MR flow")
Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 12bca6ca4760..3c241898e064 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1857,6 +1857,11 @@ static int cache_ent_find_and_store(struct mlx5_ib_dev *dev,
 	return ret;
 }
 
+static bool is_cacheable_mkey(struct mlx5_ib_mkey mkey)
+{
+	return mkey.cache_ent || mkey.rb_key.ndescs;
+}
+
 int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 {
 	struct mlx5_ib_mr *mr = to_mmr(ibmr);
@@ -1901,12 +1906,6 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 		mr->sig = NULL;
 	}
 
-	/* Stop DMA */
-	if (mr->umem && mlx5r_umr_can_load_pas(dev, mr->umem->length))
-		if (mlx5r_umr_revoke_mr(mr) ||
-		    cache_ent_find_and_store(dev, mr))
-			mr->mmkey.cache_ent = NULL;
-
 	if (mr->umem && mr->umem->is_peer) {
 		rc = mlx5r_umr_revoke_mr(mr);
 		if (rc)
@@ -1914,7 +1913,9 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 		ib_umem_stop_invalidation_notifier(mr->umem);
 	}
 
-	if (!mr->mmkey.cache_ent) {
+	/* Stop DMA */
+	if (!is_cacheable_mkey(mr->mmkey) || mlx5r_umr_revoke_mr(mr) ||
+	    cache_ent_find_and_store(dev, mr)) {
 		rc = destroy_mkey(to_mdev(mr->ibmr.device), mr);
 		if (rc)
 			return rc;
-- 
2.43.0


