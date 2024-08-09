Return-Path: <linux-rdma+bounces-4259-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0975394C8C9
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 05:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7037286DB1
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 03:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0891B969;
	Fri,  9 Aug 2024 03:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njCmDFFe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2701B810;
	Fri,  9 Aug 2024 03:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723173513; cv=none; b=gbZ6YtbKOPBsFiEtxtXe++9xIXRChUBr/VYYf5pMUUil2C9eAEigHVu368CJi0HpCdG9WIfa78gAw+SMwNKHC0ct77QLy66sfBlukRt95RGYoaThWg/eYPriDe2sP3YSDzMIW+db++Mkym3HbtKV19nr0M63TyVRFDLCl7b/ziU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723173513; c=relaxed/simple;
	bh=vp5tQFqVNxgN2/iDjMuM1QNnTI3pWFIbDyKW+UM4dng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXkOj0qIfqTQhM5D7a00N1gUVHLfR4SeQw3EtLzvu0t7gb2bljswpLJDExJ7pbDiRiqE/FTafPimDD29XI7ZdhxlRHsgy8o3/SFved2sOHa5CId2EBufCVzeYBt4U2obyQjAhEbi43ki2notUgp597PN+kyYNuFki0IDVPEb6jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njCmDFFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64881C32782;
	Fri,  9 Aug 2024 03:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723173513;
	bh=vp5tQFqVNxgN2/iDjMuM1QNnTI3pWFIbDyKW+UM4dng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=njCmDFFep036SwrP5dulrA+A2qWCQX8+EGIs+kexvfqxXjKImUg5J/3gZ+ppr4X2a
	 NKYHr+xl9cw2N3H82JrWwCLturcVqA8DvAiIIl/sC3nSyfTvOqv7XOn7tnX8nBqshS
	 0UQzwoNFk1ein04AhTtNYzDH6XrDPOh73dWXdDrbXg32dLdD8KZmbi3wqHZu54UgAm
	 YKhdrARiqzCNQ085VPrNOHSmyP7N2N1cRDnSZpRRjDb5fyXuqxW4VKs6IAgLIDlRYe
	 I5k33Nr4pk+eH4G+AH9G5T8WBDoVgw0hKQL/Akc882x2l6XelgKxnTCEBtSQMIKwi/
	 3eekIswdpGs6Q==
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
Subject: [PATCH net-next v4 03/12] eth: mlx5: allow disabling queues when RSS contexts exist
Date: Thu,  8 Aug 2024 20:18:18 -0700
Message-ID: <20240809031827.2373341-4-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240809031827.2373341-1-kuba@kernel.org>
References: <20240809031827.2373341-1-kuba@kernel.org>
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
2.46.0


