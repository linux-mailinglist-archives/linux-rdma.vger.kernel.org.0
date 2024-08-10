Return-Path: <linux-rdma+bounces-4295-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CA294DAF0
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Aug 2024 07:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1501C214A5
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Aug 2024 05:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39125A10B;
	Sat, 10 Aug 2024 05:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkGvaFnS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07BD4D108;
	Sat, 10 Aug 2024 05:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723268486; cv=none; b=p7tyPshAHVC3Wh6evgPwoyBrm/FA4rqG9my6mVBUL2wBZkdD72LFBcPJZIYyjSibhcdi5CyJy8fCtUZdxK/QAXY+3kdxVqNMKFxgHD2m407oIzXCogXIwwbM03VUfuZF6e4N6mtrOSUXAPpIiPZduBWiUE9/P5Ezhf5BNMldya8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723268486; c=relaxed/simple;
	bh=v4PFyZZsLSqb2a67c3LKpA2NBtGrrBo+DJt1Ah+0Dxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvLnJTVf8DqG38LMvg9LU+hxOkKBKIlRFVzM5eYGwwNtXLtajJrZ9m/2Sa0VzLv2wHfMYOGYC78s41Ded0CMjAGz8BpXqx9K3uPBTsJ1VjaodhGjjSbnP/u2MRnfu5o7mqu5teUkDEZPuF52ys7tCmhQgaAHGIm85ir/DCSo6I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkGvaFnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62425C4AF10;
	Sat, 10 Aug 2024 05:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723268486;
	bh=v4PFyZZsLSqb2a67c3LKpA2NBtGrrBo+DJt1Ah+0Dxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mkGvaFnSdup4KcCCjCUNlEkZ4wbZ1nHk3xTrkul5om5XgTcvDBZEXR5MiU9E9Jown
	 AyUwEkBnF2+vIsQ0n/FZ4MPyMY6QY5JqmooUy/Zi42+fYJ9z2B/zCa5vgFjXqi4Yuy
	 vxLgu2KerqD42CsJXD3OxKTUzHXxNe2KAYMByFCBwaxUh3EkmIOzE1sOWK2h8YRCEJ
	 LIUFMennLyJGr2SPw+TOhOe71/IJQJA05HBGAeiBdyOjsI48fqusEC8MdcSuT1fU+P
	 yE8Qsj6tsb5kSAidVhsWBh6p2hayyHNpB4RHqMED7vraiv5mZA/AZbuxE/9KGeP3F9
	 ys2itO9hcDpkA==
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
Subject: [PATCH net-next v5 03/12] eth: mlx5: allow disabling queues when RSS contexts exist
Date: Fri,  9 Aug 2024 22:37:19 -0700
Message-ID: <20240810053728.2757709-4-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240810053728.2757709-1-kuba@kernel.org>
References: <20240810053728.2757709-1-kuba@kernel.org>
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
index 56bdb4d07b7a..8af509397f63 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -433,7 +433,6 @@ int mlx5e_ethtool_set_channels(struct mlx5e_priv *priv,
 	unsigned int count = ch->combined_count;
 	struct mlx5e_params new_params;
 	bool arfs_enabled;
-	int rss_cnt;
 	bool opened;
 	int err = 0;
 
@@ -487,17 +486,6 @@ int mlx5e_ethtool_set_channels(struct mlx5e_priv *priv,
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
2.46.0


