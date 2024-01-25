Return-Path: <linux-rdma+bounces-753-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A490583C284
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 13:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1321C218CD
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 12:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D92716429;
	Thu, 25 Jan 2024 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JY4PQArG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38DE522C
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jan 2024 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706185844; cv=none; b=bSvInvZ9IV0aPxzNhzIjy/Jlzuex62bucMr6mMaYlSOZl8utpdax7kMzF7Yfn3I8mT7wMb8A/hvOCithWBDL8NJtr+K5+lncNJZ1bBCCwSuK2Ky6NiZF10HelAIb4594+b6MDMcCy/ofZzEKc1n6q60dFLNwJ7Aw/9xCulhcxxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706185844; c=relaxed/simple;
	bh=b6XrefpZxqHzO8+voyptnLLZ7OQjhrvkpTHwP+2hiq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4qXU7UEQHogDagDuoraTOMsnNzzZJwbb7Q2ZkOsXhoZRi7WptX95DIlNwslJ/u1OWIMYc5YGkfWacjq3A9Cr12yUJFM8+Dvhib5B6laRSUu3u/sDhwi582Ok5t1hE+wAFDVNuUHxflN/5AvAwrlIK7VVtWzeFInBRwa+j4WiXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JY4PQArG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64ABC43390;
	Thu, 25 Jan 2024 12:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706185844;
	bh=b6XrefpZxqHzO8+voyptnLLZ7OQjhrvkpTHwP+2hiq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JY4PQArGNJnVzO8RRGPZPyqHL4tF0ENnfqzUjknYOQKBxPDBtLEV5hikzyMu6MC8z
	 /9MCCRFO93Tig+hc3h4fG/TnT2KaAfykFs5lXQ2pUJ8DkqFV6Las0Yphz5l+MitkW5
	 quCV5awe4zs15znc6Xh9uirEKmIdNvEiMSJxw2u+REeTTYlebQGq0YEzCCZC2IQq1O
	 2ARKef96RJBT1iuJtgbkKdQbVDROcwWoUCS4EDsODBNniDWWEdrEt0DpX1YL0d7esA
	 ovw/uy3ZJDZZZ+S1MFO5JFx4iI4iBg7TQAXPlCAnp1h0k1DnVIhzzJ6zcoPyHVmRz7
	 RvjAEU64Iityw==
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
Subject: [PATCH rdma-next 6/6] RDMA/mlx5: Adding remote atomic access flag to updatable flags
Date: Thu, 25 Jan 2024 14:30:12 +0200
Message-ID: <9886e62b12c00380cfd7dbdcf31d37926a19ced7.1706185318.git.leon@kernel.org>
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
index 3c241898e064..8bf6cec79e52 100644
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


