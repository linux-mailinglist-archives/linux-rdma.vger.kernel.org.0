Return-Path: <linux-rdma+bounces-4176-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CB1945531
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 02:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F67A2863F6
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 00:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7C4BA4D;
	Fri,  2 Aug 2024 00:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQnVWVBR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75975A94F;
	Fri,  2 Aug 2024 00:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722557889; cv=none; b=A+aHQtaO5jfYMIDIiMb7sqt3WKOE3EDK7B6lMaoD/4ZHZzil48oM74hqOdkMsKV5kj3GjTpNKyDVPDnDZOcNsV238Ut+ESgFyoG5JwlsHS201Fv4fL88Qt2DY7ybs/P93HE3Pue6hmfhLj3NvC98L3qpZd4R7rctSDG5v3hUW+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722557889; c=relaxed/simple;
	bh=JRov3dvT7hpcxruLI+d03AI8SgusuVe28R02jtEs/jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAi3EnVZHAmaHIxtnLQds85yTT9hWUfiS71ulx7asKXXGlEzYfVyhAzrQG25DbnwyhlOnU6e/64yAUXBDDZ4Id7OoKZFcILkHlMc38nKPRbxmZ3mMxhPFuft7AXfMt2dQ4iMQD07gB46MhnjnFqRf0h0M6RaCdmdc5MNa9RyrRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQnVWVBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CA6C4AF13;
	Fri,  2 Aug 2024 00:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722557889;
	bh=JRov3dvT7hpcxruLI+d03AI8SgusuVe28R02jtEs/jI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQnVWVBRW2Gxk2thlyS6Cm0z3ClRKjPF1ds5cwyKHVEOCmve3zEqpOz6/I56YVFJc
	 PoVndif02+PiCkpX0tIadxKlVIpLhGeCeE0UtgVRdJ88MAD2swB+nXJofAMkgMbAfU
	 4yg+FtnEQjV1ng9qAfVFNjdwAWENz/r3eiQzFGQH9fZaIH4yLP9TK72b8pBtFaP5TF
	 ufaQMHsQexq3GWJ4lkVdZlEYQWwOVVjgjx4wEb44xUHG0HocAVRlTKPZxCHvJh8pAS
	 H8/VuXfOJnih4lFOuGrXgCbp4w5By6QH27xClynvmeuXW9v2OP0DcosNxci9q8utaV
	 d1O2F/JnXbzPw==
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
	Jakub Kicinski <kuba@kernel.org>,
	saeedm@nvidia.com,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next 03/12] eth: mlx5: allow disabling queues when RSS contexts exist
Date: Thu,  1 Aug 2024 17:17:52 -0700
Message-ID: <20240802001801.565176-4-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802001801.565176-1-kuba@kernel.org>
References: <20240802001801.565176-1-kuba@kernel.org>
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


