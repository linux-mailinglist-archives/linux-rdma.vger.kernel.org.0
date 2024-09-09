Return-Path: <linux-rdma+bounces-4841-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33D797220D
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 20:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCE411C238AC
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 18:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C5D1494B1;
	Mon,  9 Sep 2024 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twObmMuC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E6A2135B
	for <linux-rdma@vger.kernel.org>; Mon,  9 Sep 2024 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725907659; cv=none; b=FQHohCV2X+ybkhtt5rTZYqQjyN7otaJlYyFwaPC/d8nFH7NqoJIfDgszoJRt6vLGLMMUESAC1AERE2jb8rOBxAC7vU4VWZ3avIVBppRkLMZOCWEb5eWqdSgmf+XZEjLyC/0FjAy0JRjK3qUqCj7uLMFWacKoygF3IlHQeTZjt20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725907659; c=relaxed/simple;
	bh=deEeZ0PFIxwubGBEXOl4qN2c8EdPX5YRV8wLxkIyRg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WmzJnIJ2nRFmTXs31SpJBdmqb7s/hZZfRGIgBCWFgVuQyAJWJ7zQ/+ycLVN8sFcOB+jcppcZGpVh+q2xWrtoKIl5Opy05A+tYAsddTvrqZIY2reLfGbtgUeji+jYPz7FfTAvBYXBP4uQUOSEF1xqeXGtuZaH9pVRn/ikQL+u8xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twObmMuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5ECC4CEC5;
	Mon,  9 Sep 2024 18:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725907659;
	bh=deEeZ0PFIxwubGBEXOl4qN2c8EdPX5YRV8wLxkIyRg8=;
	h=From:To:Cc:Subject:Date:From;
	b=twObmMuCZQLu/PDlhkFqYi6y44lZ2dZeT5hoQX19nF0A1k/B3ZnBFzHHXYDYFLzmn
	 JrKA6FuEj28wYg5kexpFDGEJ0Gs25B/ibJdM0OrthKxmLmzT3Z25cl4rdj2kjrk4V1
	 RMMmf3qSxZogvbr8X74+FPJ0429eQhAuZtn1BSuHsaITtFuo3tkur93AvTSDBnSnWr
	 MNMQWwXcjLFAiRmgOlDEKPYKLsytwRZOCD1kpAUhnZ2KsGMC2kGNkXWD8MWXpiPHEp
	 XPgYrwucJhGgrpDmkXi1Hi4eKJukKocfJ104PDEbONkxiUojr4IUJBVcosyyvPCuvq
	 Rg6WiT0GGsypg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Gal Shalom <galshalom@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/mlx5: Consider the query_vuid cap for data_direct
Date: Mon,  9 Sep 2024 21:47:33 +0300
Message-ID: <274c4f6f1ac0b1078243dd296695a49dbe58e7d1.1725907637.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yishai Hadas <yishaih@nvidia.com>

Consider also the query_vuid cap before enabling the data_direct
functionality.

This may prevent a syndrome from the FW in case the query_vuid command
is not supported. (e.g. migratable VF)

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Reviewed-by: Gal Shalom <galshalom@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index b182248f2e79..b4476df96ed5 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3571,7 +3571,8 @@ static int mlx5_ib_data_direct_init(struct mlx5_ib_dev *dev)
 	char vuid[MLX5_ST_SZ_BYTES(array1024_auto) + 1] = {};
 	int ret;
 
-	if (!MLX5_CAP_GEN(dev->mdev, data_direct))
+	if (!MLX5_CAP_GEN(dev->mdev, data_direct) ||
+	    !MLX5_CAP_GEN_2(dev->mdev, query_vuid))
 		return 0;
 
 	ret = mlx5_cmd_query_vuid(dev->mdev, true, vuid);
@@ -3592,7 +3593,8 @@ static int mlx5_ib_data_direct_init(struct mlx5_ib_dev *dev)
 
 static void mlx5_ib_data_direct_cleanup(struct mlx5_ib_dev *dev)
 {
-	if (!MLX5_CAP_GEN(dev->mdev, data_direct))
+	if (!MLX5_CAP_GEN(dev->mdev, data_direct) ||
+	    !MLX5_CAP_GEN_2(dev->mdev, query_vuid))
 		return;
 
 	mlx5_data_direct_ib_unreg(dev);
-- 
2.46.0


