Return-Path: <linux-rdma+bounces-2631-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DB18D1BB9
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 14:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F06F7B24F5B
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 12:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017E516E87B;
	Tue, 28 May 2024 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6YvJb6W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B1116D9AA
	for <linux-rdma@vger.kernel.org>; Tue, 28 May 2024 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716900803; cv=none; b=T1FtxecZR3/fcW6hKbAbZ4cBddBON0kE1PpMHi4OBDicKdowRQjWNQzubPeWcswwPBRnJjlu3P6uCDqDCZeN6Hcqw/5LR99ByDXxqTrbr77VBlKx0yZQAPURRtU7zaqX/W3pb9h6dVMOEh7QZeNU84fmmCyf0n8umS+bDBCu0f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716900803; c=relaxed/simple;
	bh=T9X4/Jsk3ptLSS5AoN6LbKLk43UbEhUp3ngVpQOpVI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhvFLxmntJNEkVvKVwS5rm9xzvVFhjK8HC8BihH//R0484NEmgDrYXx6g4foEdc3doLTHzt8XxPHm3pmORJ3ttsL1/yrnEuvPth31NsWfDhMo73X75P0UFksWC24nk/ulwvP9+vpsAdg8Q4umi0MCIPIkyNX6bFQAZr4WRyLlXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6YvJb6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1F4C32789;
	Tue, 28 May 2024 12:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716900803;
	bh=T9X4/Jsk3ptLSS5AoN6LbKLk43UbEhUp3ngVpQOpVI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B6YvJb6WziXRgphZw9y4+ke7U6PNVoTKeKBVGF/33tsGa7m1a67Nh1ceesRf0m6uw
	 2AboN+mpCT4JRC7yPQJWijTQMTOQZtodTCnxKlcc15sciO1oVjoJ5poR+lVTBTxwzj
	 i/y1z+N77zFMkwKnOh2J7OWKJb6TrJYIR9Us8w2xd+raiIaqBvsSs5xdxsG7nn+GWo
	 N5hK9Daw/eCHRja5gK6nGGioSt9b0ruF4Itlt7eU+9sjVfcKFnCDvjUB4hW2C1xIQm
	 p3m13NGuhMsWgFWWItfAExps/sLW3E8pFu3QTEydjKtHU1+CJgP+wUBnFedbcPpXvr
	 38SARouqDNreA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Mark Zhang <markzhang@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>
Subject: [PATCH rdma-rc 5/6] RDMA/mlx5: Fix unwind flow as part of mlx5_ib_stage_init_init
Date: Tue, 28 May 2024 15:52:55 +0300
Message-ID: <aa40615116eda14ec9eca21d52017d632ea89188.1716900410.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716900410.git.leon@kernel.org>
References: <cover.1716900410.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yishai Hadas <yishaih@nvidia.com>

Fix unwind flow as part of mlx5_ib_stage_init_init to use the correct
goto upon an error.

Fixes: 758ce14aee82 ("RDMA/mlx5: Implement MACsec gid addition and deletion")
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 2366c46eebc8..43660c831b22 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3759,10 +3759,10 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 	spin_lock_init(&dev->dm.lock);
 	dev->dm.dev = mdev;
 	return 0;
-err:
-	mlx5r_macsec_dealloc_gids(dev);
 err_mp:
 	mlx5_ib_cleanup_multiport_master(dev);
+err:
+	mlx5r_macsec_dealloc_gids(dev);
 	return err;
 }
 
-- 
2.45.1


