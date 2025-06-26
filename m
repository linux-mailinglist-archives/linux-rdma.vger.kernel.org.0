Return-Path: <linux-rdma+bounces-11675-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47174AE9D3F
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 14:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C7321C435F1
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 12:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55238E55B;
	Thu, 26 Jun 2025 12:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijH+1dgk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1463E17BA1
	for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 12:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939598; cv=none; b=QFZIgK7LqV0cdLiZGL8QwnJLMlz4+iEF4mUiVDkKS2PjazI7812/1s1cGlj3Eq9Ra4MYZpyYeecckOlklIo8DbW6AKCcXI0LiZjN5ymlvD1W4fOxYVq06/9f0PMVwlld1KYHVjH0vwEyM+lBeA5LqiRkp4qS34d8xJJZoq6VA5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939598; c=relaxed/simple;
	bh=AcinQbaI/052kyFiQJevWZC97XUo0S/Tc2WZ6+5uJTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjiYJTEE6InbpozdR70nT62fcAYfI3aOHV7lGc8c2cLdkxoaTWLfIHxTqTRHy1qEp36K76ZUJLqEme8cqHDmS4jT4QTe8RhFZEW4esa0QA9wLZCixx4n9oaJZJ/muLfdqtnD6ZOwhDdqvHj+mkBmxQzZpXV6JF8pN4zd5QR6ZIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijH+1dgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F3DC4CEEB;
	Thu, 26 Jun 2025 12:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750939597;
	bh=AcinQbaI/052kyFiQJevWZC97XUo0S/Tc2WZ6+5uJTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ijH+1dgkJWVhyQpSQz/zQ1UlL1sM3WIVSNleUnNVBisgtW9rOrdkVhCh+NPi5NlL+
	 Re5W+W61j1bNWDVLqL+PlRljcmDpCQl6FPqIWxeGiduRUOfeykGQHgUDgKQSb7gExN
	 0/mEsEzWCiN3yrhjq1S4xh6POYP17e4wvzosECoVMmuTnqpE/VcVTrGj7GSa4eMMmF
	 9cwmFCA5agItOaRE2oylEkT598GH7DVq/JCRPWRfcC9F1YffAzfqPUAEhvsXfmeClB
	 YZ4hTP1riJAMX5aBQ+euLPp8Bt0sUp0Ewx/pip9oX8oEnEzfE5Ulex6SY8gtygjvC3
	 JB103wMlL0Vgw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next v1 5/7] RDMA/mlx5: Check CAP_NET_RAW in user namespace for devx create
Date: Thu, 26 Jun 2025 15:05:56 +0300
Message-ID: <7a1f2295de05e62274be997632f508259e2eee41.1750938869.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750938869.git.leon@kernel.org>
References: <cover.1750938869.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Parav Pandit <parav@nvidia.com>

Currently, the capability check is done in the default
init_user_ns user namespace. When a process runs in a
non default user namespace, such check fails. Due to this
when a process is running using podman, it fails to create
the devx object.

Since the RDMA device is a resource within a network namespace,
use the network namespace associated with the RDMA device to
determine its owning user namespace.

Fixes: a8b92ca1b0e5 ("IB/mlx5: Introduce DEVX")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/devx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index e5551736ee14..44b4521619c4 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -159,7 +159,7 @@ int mlx5_ib_devx_create(struct mlx5_ib_dev *dev, bool is_user, u64 req_ucaps)
 	uctx = MLX5_ADDR_OF(create_uctx_in, in, uctx);
 	if (is_user &&
 	    (MLX5_CAP_GEN(dev->mdev, uctx_cap) & MLX5_UCTX_CAP_RAW_TX) &&
-	    capable(CAP_NET_RAW))
+	    rdma_dev_has_raw_cap(&dev->ib_dev))
 		cap |= MLX5_UCTX_CAP_RAW_TX;
 	if (is_user &&
 	    (MLX5_CAP_GEN(dev->mdev, uctx_cap) &
-- 
2.49.0


