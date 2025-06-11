Return-Path: <linux-rdma+bounces-11204-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6CBAD596D
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jun 2025 17:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5601892AED
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jun 2025 15:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112982BDC1B;
	Wed, 11 Jun 2025 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVOA0Npf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A2B2BD5BB;
	Wed, 11 Jun 2025 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653995; cv=none; b=HBDLP3e8AGC1i99TdA6qBLK2nrZnMOjaw5wXrHBWmYILMXHe2qz3evtA3/Y09tcHKnJ0iZziRf8MW2pFWYomeMVFuLdRDPL33eEQ7k/3xfS4UoNrhd79e/Vi3ORbSLg2baMX1TT2i1K0w+SzO5c1Ved1HfoaegXoFyhN5GuG0DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653995; c=relaxed/simple;
	bh=k7uvwDoCQy7WbgbdbUpZHePfkgjqcUTHAu2jnYCKAZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhJVGF5HdjUalzadGrMsLPJrulk48Kx4GeWBpRvFHXSwLwUUxqww9YIGcojHEl2iOl6Sr8+5oqIFAnxMoVdzsqyKLUKzqjWGj2fN2SDFxmE7XcFo/OGmSNEFgBXXm6+N3O0n+O1v1QlU5boNZPixiSg7kDJ+7ogbqXsD6D+1w6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVOA0Npf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44075C4CEF1;
	Wed, 11 Jun 2025 14:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749653995;
	bh=k7uvwDoCQy7WbgbdbUpZHePfkgjqcUTHAu2jnYCKAZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YVOA0NpfLjZiLMFXJeoYffEhJgjY3b4BNlsk7AJMEnBHH2LBJHGemvVuowAqEA/q8
	 J+NsGzW9fG3XkylwLjzJXrcvKaalqgDHmCVJL+aQl56tupQA7G0qDbDyTQ4JsBI7ns
	 bKc1Xl9gfh+3CjQXC7DaQdmM6xoanRxVpij4gh8gZ2KTvNEGHRjXByV3u7XUFDEPVn
	 jVBFQZVY9CdSZ74SHdEQvJe4tIfaNrAGP0P4fWyTpkupE6kUv4bw3TGUA5aYd9L185
	 ou5bxjqsh8t83oBB/MMAyfXcGComu2Pyk7Y5QxBNMGeG8cA39fbT1DfR72lnlauoQT
	 zkXddDVf8h8oA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-net-drivers@amd.com
Subject: [PATCH net-next 3/9] net: ethtool: require drivers to opt into the per-RSS ctx RXFH
Date: Wed, 11 Jun 2025 07:59:43 -0700
Message-ID: <20250611145949.2674086-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611145949.2674086-1-kuba@kernel.org>
References: <20250611145949.2674086-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RX Flow Hashing supports using different configuration for different
RSS contexts. Only two drivers seem to support it. Make sure we
uniformly error out for drivers which don't.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: saeedm@nvidia.com
CC: tariqt@nvidia.com
CC: leon@kernel.org
CC: ecree.xilinx@gmail.com
CC: linux-rdma@vger.kernel.org
CC: linux-net-drivers@amd.com
---
 include/linux/ethtool.h                              | 3 +++
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 1 +
 drivers/net/ethernet/sfc/ethtool.c                   | 1 +
 net/ethtool/ioctl.c                                  | 8 ++++++++
 4 files changed, 13 insertions(+)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 5e0dd333ad1f..fc1c2379e7ff 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -855,6 +855,8 @@ struct kernel_ethtool_ts_info {
  * @cap_rss_ctx_supported: indicates if the driver supports RSS
  *	contexts via legacy API, drivers implementing @create_rxfh_context
  *	do not have to set this bit.
+ * @rxfh_per_ctx_fields: device supports selecting different header fields
+ *	for Rx hash calculation and RSS for each additional context.
  * @rxfh_per_ctx_key: device supports setting different RSS key for each
  *	additional context. Netlink API should report hfunc, key, and input_xfrm
  *	for every context, not just context 0.
@@ -1084,6 +1086,7 @@ struct ethtool_ops {
 	u32     supported_input_xfrm:8;
 	u32     cap_link_lanes_supported:1;
 	u32     cap_rss_ctx_supported:1;
+	u32	rxfh_per_ctx_fields:1;
 	u32	rxfh_per_ctx_key:1;
 	u32	cap_rss_rxnfc_adds:1;
 	u32	rxfh_indir_space;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index ea078c9f5d15..90c760057bb6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -2619,6 +2619,7 @@ static void mlx5e_get_ts_stats(struct net_device *netdev,
 const struct ethtool_ops mlx5e_ethtool_ops = {
 	.cap_link_lanes_supported = true,
 	.cap_rss_ctx_supported	= true,
+	.rxfh_per_ctx_fields	= true,
 	.rxfh_per_ctx_key	= true,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES |
diff --git a/drivers/net/ethernet/sfc/ethtool.c b/drivers/net/ethernet/sfc/ethtool.c
index 83d715544f7f..afbedca63b29 100644
--- a/drivers/net/ethernet/sfc/ethtool.c
+++ b/drivers/net/ethernet/sfc/ethtool.c
@@ -262,6 +262,7 @@ const struct ethtool_ops efx_ethtool_ops = {
 	.set_rxnfc		= efx_ethtool_set_rxnfc,
 	.get_rxfh_indir_size	= efx_ethtool_get_rxfh_indir_size,
 	.get_rxfh_key_size	= efx_ethtool_get_rxfh_key_size,
+	.rxfh_per_ctx_fields	= true,
 	.rxfh_per_ctx_key	= true,
 	.cap_rss_rxnfc_adds	= true,
 	.rxfh_priv_size		= sizeof(struct efx_rss_context_priv),
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 330ca99800ce..bd9fd95bb82f 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1075,6 +1075,10 @@ ethtool_set_rxfh_fields(struct net_device *dev, u32 cmd, void __user *useraddr)
 	if (rc)
 		return rc;
 
+	if (info.flow_type & FLOW_RSS && info.rss_context &&
+	    !ops->rxfh_per_ctx_fields)
+		return -EINVAL;
+
 	if (ops->get_rxfh) {
 		struct ethtool_rxfh_param rxfh = {};
 
@@ -1105,6 +1109,10 @@ ethtool_get_rxfh_fields(struct net_device *dev, u32 cmd, void __user *useraddr)
 	if (ret)
 		return ret;
 
+	if (info.flow_type & FLOW_RSS && info.rss_context &&
+	    !ops->rxfh_per_ctx_fields)
+		return -EINVAL;
+
 	ret = ops->get_rxnfc(dev, &info, NULL);
 	if (ret < 0)
 		return ret;
-- 
2.49.0


