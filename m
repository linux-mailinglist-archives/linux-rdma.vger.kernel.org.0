Return-Path: <linux-rdma+bounces-4193-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCB5946762
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Aug 2024 06:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76989B2158F
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Aug 2024 04:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B78C132106;
	Sat,  3 Aug 2024 04:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfzI7yBB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61AF12B17C;
	Sat,  3 Aug 2024 04:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722659213; cv=none; b=T4zReXtwWQa1YAgsgcQ+8g1+Ttc9Y4Cx27gHkVPItweMfFr8LEIcymyEknOfGCB4IyJZUV010q8fLbTxN16NBjqeWNP2+mWcGGxa2VTri6yIfms9vWNhytT6oOhL7SqTrEB5SrX6l2shOZXmRz4SYNS2NNyLfRJYWZrhrWoSnIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722659213; c=relaxed/simple;
	bh=87XPti6RVqAiNW3eWPIQm2vFmmfDS6ddZiot77zPsWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMhk+QXvFkF12DG3AyKygWKaNl29eLechvBitwWYpMM+X7yJLZa5Nh7JXY5x21gw4euOMIManmC5IL490TrG/IDQRi48B0vFVJrQCGwa1yuMrnSAqb2Zr10e8dwxtkBhgpXGFLlBABjE+1eV2fpMwEmyU/z6QYtZxdK4SZ91Ku4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfzI7yBB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB107C4AF12;
	Sat,  3 Aug 2024 04:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722659212;
	bh=87XPti6RVqAiNW3eWPIQm2vFmmfDS6ddZiot77zPsWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lfzI7yBBXFi14uuqoXT2SPOZQKetjPQPCMd4+gd5Q3WC6ez5YSidNSl8yBCsZ51By
	 PdZn6dY5jJb6x0UZFls96PDCicx5veh2NYHDX8ooZxrGz3uaCQs+UMKL4iMv/R58Ax
	 BKwVDTQE7RKthSgfhnRNTd0suBqiIVlqNGKu4yV4EYHn36kMjCUfFNG9Q+jPTyVaQb
	 9TqeBvyj/aAdcmW/l7ON2A7uAEjkGLU09FF11D90jREAzHtmwxhxruZ+NZ1lGNrD5r
	 p+yUG2LB3CaxmJRSYGzQ20kgmUon1mn1VG5/sqCS6thGN0FGA+BgBXquSEbhdI5SMZ
	 xuF959SmiNp5g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dxu@dxuuu.xyz,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	donald.hunter@gmail.com,
	gal.pressman@linux.dev,
	tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>,
	saeedm@nvidia.com,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v2 03/12] eth: mlx5: allow disabling queues when RSS contexts exist
Date: Fri,  2 Aug 2024 21:26:15 -0700
Message-ID: <20240803042624.970352-4-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803042624.970352-1-kuba@kernel.org>
References: <20240803042624.970352-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 24ac7e544081 ("ethtool: use the rss context XArray
in ring deactivation safety-check") core will prevent queues from
being disabled while being used by additional RSS contexts.
The safety check is no longer necessary, and core will do a more
accurate job of only rejecting changes which can actually break
things.

Reviewed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: saeedm@nvidia.com
CC: tariqt@nvidia.com
CC: leon@kernel.org
CC: linux-rdma@vger.kernel.org
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 36845872ae94..0b941482db30 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -445,7 +445,6 @@ int mlx5e_ethtool_set_channels(struct mlx5e_priv *priv,
 	unsigned int count = ch->combined_count;
 	struct mlx5e_params new_params;
 	bool arfs_enabled;
-	int rss_cnt;
 	bool opened;
 	int err = 0;
 
@@ -499,17 +498,6 @@ int mlx5e_ethtool_set_channels(struct mlx5e_priv *priv,
 		goto out;
 	}
 
-	/* Don't allow changing the number of channels if non-default RSS contexts exist,
-	 * the kernel doesn't protect against set_channels operations that break them.
-	 */
-	rss_cnt = mlx5e_rx_res_rss_cnt(priv->rx_res) - 1;
-	if (rss_cnt) {
-		err = -EINVAL;
-		netdev_err(priv->netdev, "%s: Non-default RSS contexts exist (%d), cannot change the number of channels\n",
-			   __func__, rss_cnt);
-		goto out;
-	}
-
 	/* Don't allow changing the number of channels if MQPRIO mode channel offload is active,
 	 * because it defines a partition over the channels queues.
 	 */
-- 
2.45.2


