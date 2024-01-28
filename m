Return-Path: <linux-rdma+bounces-783-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEDC83F4D2
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jan 2024 10:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD0B4283329
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jan 2024 09:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B8EDF55;
	Sun, 28 Jan 2024 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRcylVPK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C42DF49
	for <linux-rdma@vger.kernel.org>; Sun, 28 Jan 2024 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706434187; cv=none; b=A/6iTMITs1pi23+CtxWAO/DRf+du6/LP2PrMQ30U2Bx7pNlIbs74S87XkJNnN2E9tPU6LO49zyi1/uuaQbhdrYKZ9DLL3Co8jmSVUnD+vN8sDpJFp27BSOEKdp3Zl+AaUvHfTamJuxjId5cK7rrJOjmCviurMoWTbtWy+d4CK9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706434187; c=relaxed/simple;
	bh=i1cOxzgRSmvp+pz31xeocZ5BFDh1oBZkmLXSHDWexkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iy4Bec14i+TGDDXhh3maREMF4Y0OWO0PTD9jYpWvensTtgRvM1KP51O4caPmK6cK4gI3LhRKaoOfmIRW178ka1iXErD/mcQLUVGFHw3i7ckLQ7ByiSqJxSHZE9Gf4ik3TSVn2wzJPwqnqfWYBOlpwYt09WnaDzxT0GBfqNwMMPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRcylVPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA98DC433F1;
	Sun, 28 Jan 2024 09:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706434187;
	bh=i1cOxzgRSmvp+pz31xeocZ5BFDh1oBZkmLXSHDWexkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eRcylVPKrs/zykszbzwkxhRM0yx3FA1YILJoJ3Ba8+Fg+zBLI3jL/mYUx7/mOjW57
	 VItM1o69sDXfAraOXn9D8hhpI6z8df4GXKMsTmh68e3Po6Cq8Z5p7yyBjWfRYVPxUy
	 +qYH6qRBkaaLUV2BgEXcSSZCIb3WUS6SHjh932cWGTah7eXY8dLr87XOFXn85aeQht
	 PoTCaYLrJOLLeuWlzzXtGxzKZrO0Km4RyJdOLO/iJSCSQZ8moJ9u8NpZgAwKDk2jsE
	 /mv0/l3hUitPHKHkUB4S3jNOLRCgM82UmxKyqKVUHG9AiqR6ZhlqEbRgzb5k8MHtLo
	 y7OyqAVNa2N6Q==
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
Subject: [PATCH rdma-next v1 6/6] RDMA/mlx5: Adding remote atomic access flag to updatable flags
Date: Sun, 28 Jan 2024 11:29:16 +0200
Message-ID: <3e9832e3d74e1d33ec77ba092fb5c4b997174d96.1706433934.git.leon@kernel.org>
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

Currently IB_ACCESS_REMOTE_ATOMIC is blocked from being updated via UMR
although in some cases it should be possible. These cases are checked in
mlx5r_umr_can_reconfig function.

Fixes: ef3642c4f54d ("RDMA/mlx5: Fix error unwinds for rereg_mr")
Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 87552a689e07..db8c436de6ee 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1581,7 +1581,8 @@ static bool can_use_umr_rereg_access(struct mlx5_ib_dev *dev,
 	unsigned int diffs = current_access_flags ^ target_access_flags;
 
 	if (diffs & ~(IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_WRITE |
-		      IB_ACCESS_REMOTE_READ | IB_ACCESS_RELAXED_ORDERING))
+		      IB_ACCESS_REMOTE_READ | IB_ACCESS_RELAXED_ORDERING |
+		      IB_ACCESS_REMOTE_ATOMIC))
 		return false;
 	return mlx5r_umr_can_reconfig(dev, current_access_flags,
 				      target_access_flags);
-- 
2.43.0


