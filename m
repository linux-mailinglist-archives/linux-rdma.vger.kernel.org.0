Return-Path: <linux-rdma+bounces-751-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F183283C283
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 13:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A832E1F25707
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 12:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B173168D2;
	Thu, 25 Jan 2024 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jc+wVM/m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F8779D9
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jan 2024 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706185836; cv=none; b=otIh2bPxjTpPtg01LlLboZ2SXQErErGG62Xuw48SNSZVIf6s/w3Xas1k0S9CbPWwzAuXmqjtNGHbY5ttgg8+iQxxr9KKHZwMyj4KVsyk2AB5Et76BIYu+Ezw1xr4V/QT4mqugMPIHJYL8mCcQrBUiu/ePGRwTlinEZddyWzQv0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706185836; c=relaxed/simple;
	bh=ftw8s/q3SdJ5hbrwxyJKiEYKNHIqCm/vNo07aJs33wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQ81f7j2AAIX1lNseut59Jc1Wa7cNWxXZxOaPkPy2aRL4R0Bm9SJk/M6neSACFiJDruDmb1VhVv9k0lAnsvz+UvFLLd9VdrD/em6SUSMdUhGtZYewoLMC+eH7rhNpGjoHbeZlE1aP+f5FYKNEYo/rILG8lzbMynQPKw0I/Om1ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jc+wVM/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342FEC43390;
	Thu, 25 Jan 2024 12:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706185835;
	bh=ftw8s/q3SdJ5hbrwxyJKiEYKNHIqCm/vNo07aJs33wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jc+wVM/mlcvxekIZCHlIZ7sEU0l2PYOFgqX+k1CaYnxwBdnGUuRofhKFBW52puZmw
	 QRC84s6w72Cjcw/Qfi0HXVCvHu+gJZCG2Ji2Ha+5Y6Ij8uV4ADhKN97n7to+SjqXKh
	 w/NFckbpRyUgi//OP3q1mEUp0P/DFBTASV9raJZsn6MYRxYSENc64xr4YQ+Z7xPopS
	 qetZTlZ4XdBKdztZV5ro84oP2+QGnMHGyK4nkpNl1c9AFBMoC9yoT2NBiME1gJ4eNv
	 Isqp9Hmm893ei/LHR1KLTXq7B6tuQyGT11sAkLs/MkZiYnWAzhBwnpQz5AaPF+IGk/
	 ZN7E9EkUJi5+Q==
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
Subject: [PATCH rdma-next 4/6] RDMA/mlx5: Uncacheable mkey has neither rb_key or cache_ent
Date: Thu, 25 Jan 2024 14:30:10 +0200
Message-ID: <cff57806e1c8e339ed9cf3d60f09d89ac9696755.1706185318.git.leon@kernel.org>
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


