Return-Path: <linux-rdma+bounces-4222-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AA8949857
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2024 21:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55DBE1C211DE
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2024 19:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816CA14A089;
	Tue,  6 Aug 2024 19:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCnhfoLY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAC614901A;
	Tue,  6 Aug 2024 19:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972819; cv=none; b=N5qygm+/EUHGlDypJD8pUl/cQx8/y2ZRgqjoYu4cnahYfov+Q/KYNshWjm6v62fsDV4DIsMLnaIo16tADZm9Jkay+6OI9ROKyVhHZapw4B79CApxgmdSfACLg3Hm3jYh3Gd3d0XKYLgZ7tZiZoHy1Rh+xYfQYoLpeSUhVKeDYNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972819; c=relaxed/simple;
	bh=Ksaiilzzj7YrsLDz/h9N0t7bhMsZ6HG9XzjE586OUy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3j5usLKGCfv4HexhvRk96/Cau0/qIiUTZZh+NMZ51ugk5yZC/NQwXZpHb/K5LCwaKRUQnnKUpbA+dCjGnS/i7dl3KOrJ5kI7cWJdOCIHdMm2wNpArpZknBQd/oytHfYap/csxISR5MkFK2YOaRHox6pj+lUQHofYK83rpD3u+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCnhfoLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD9BC4AF0E;
	Tue,  6 Aug 2024 19:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722972819;
	bh=Ksaiilzzj7YrsLDz/h9N0t7bhMsZ6HG9XzjE586OUy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LCnhfoLYUJjzUbriyA5wG7FYi/WGT7h9GmY6gJY4/J5FrHEENnl3pEWMaX2RAr0KA
	 SORZ2PaRYBtX2uMNjfBdahsXzncZ8vXxEw66hD2R8SUNqQYr/+BDL+uSVL9tAvudi+
	 Ya0/COw/Sl/5DLAOLKSagw3JCyrw2lh7V637gQfz3xeiSXT0i/5RNrSrmfVFUuPmV0
	 TGpWif+nZ0blQU17ihC5k0kMCUY7k9g8N9Nv++ObitCBPS0C7zqCCe05rtIgLMDY1j
	 JMlbe+lfeB9CsfLI0RlN6BFkbUinaGgN471J1a6tvpcavP8c1Ap7ehXl2pKFGf3vB8
	 iJ9JVQrBldolw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	shuah@kernel.org,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	ahmed.zaki@intel.com,
	andrew@lunn.ch,
	willemb@google.com,
	pavan.chebbi@broadcom.com,
	petrm@nvidia.com,
	gal@nvidia.com,
	jdamato@fastly.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v3 03/12] eth: mlx5: allow disabling queues when RSS contexts exist
Date: Tue,  6 Aug 2024 12:33:08 -0700
Message-ID: <20240806193317.1491822-4-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806193317.1491822-1-kuba@kernel.org>
References: <20240806193317.1491822-1-kuba@kernel.org>
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

Reviewed-by: Gal Pressman <gal@nvidia.com>
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


