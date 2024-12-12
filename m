Return-Path: <linux-rdma+bounces-6481-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6669EF5E6
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 18:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50DC028996B
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 17:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FCD215764;
	Thu, 12 Dec 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0yGXDF3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119542144C4;
	Thu, 12 Dec 2024 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024029; cv=none; b=lQ53af0zsRymuRgLWYG3Rf5vFOxr/mi+TTlSwNBoudlCdkPoO6JC4bwOKJo0conIGQZ3ZxfsEe08ZJU1QqGh9gNFVwndvnuRuGYlbnhyE0JFGsUGumPstOnn3jh0iV1GgSOF+rlW5bmHlMazT056YDAPHi08AQr9MShbSC2r72U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024029; c=relaxed/simple;
	bh=Zmi6Nqj5VlEtvbHsIMFgxSwXD4Xweuc8qDZ0pWDc0W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoNLYrefh45L8o8ExGGn7TdthjI8UPH8ExEOPz1Sju/B54SMaIg7vv7S+1mrXd89JEwbqcrSJVU1vtTAOosu2zS1zIYZc9LHSGMZMkHrGRMk+gcBgWomlu/Vjj35DbUoDw1eaT7GMwiF7gbgm5YSgts/NPKNUsL8fOjCQG+BEZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0yGXDF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D940C4CECE;
	Thu, 12 Dec 2024 17:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734024028;
	bh=Zmi6Nqj5VlEtvbHsIMFgxSwXD4Xweuc8qDZ0pWDc0W0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k0yGXDF37bZfqsK7XsQJqVJWkuxpw0QXp6FyFtnebf9Xk5hO+P8yL5dtx8p4SVxVH
	 XwoBfH8R+1HNwt8oNp1fXXQbTx9mefYVLFDXbeejXT99ZBS93wJFQOsc40+RbUMHsQ
	 Jr4odxJI41x7DQW0Tj/aHBNiJa0zhD4pgdXpLq2J0zkgbPENea8oVSxDJrVgqpQhbm
	 opDIYlH1DZIXL5YbrAQzmLfIp5ep76ixkt/QdJmJJUMHh+jGLTrPMtpF3e4W7ilHf1
	 9TwQ8Fl9jG1/6gDSvHMOTRWZNRNr7+7zjueLDSw6GAEMw04FkWZ6cewaWVCsMLU/z3
	 LVGMnQRCcEpYA==
Date: Thu, 12 Dec 2024 17:20:24 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Leon Romanovsky <leonro@nvidia.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	linux-rdma@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH net-next 04/12] net/mlx5: fs, add counter object to flow
 destination
Message-ID: <20241212172024.GD73795@kernel.org>
References: <20241211134223.389616-1-tariqt@nvidia.com>
 <20241211134223.389616-5-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211134223.389616-5-tariqt@nvidia.com>

On Wed, Dec 11, 2024 at 03:42:15PM +0200, Tariq Toukan wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> Currently mlx5_flow_destination includes counter_id which is assigned in
> case we use flow counter on the flow steering rule. However, counter_id
> is not enough data in case of using HW Steering. Thus, have mlx5_fc
> object as part of mlx5_flow_destination instead of counter_id and assign
> it where needed.
> 
> In case counter_id is received from user space, create a local counter
> object to represent it.
> 
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Unfortunately, I think that this misses two counter_id instances
in mlx5_vnet.c and the following is needed:

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 5f581e71e201..36099047560d 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1952,7 +1952,7 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
 		goto out_free;
 
 #if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
-	dests[1].counter_id = mlx5_fc_id(node->ucast_counter.counter);
+	dests[1].counter = node->ucast_counter.counter;
 #endif
 	node->ucast_rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, dests, NUM_DESTS);
 	if (IS_ERR(node->ucast_rule)) {
@@ -1961,7 +1961,7 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
 	}
 
 #if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
-	dests[1].counter_id = mlx5_fc_id(node->mcast_counter.counter);
+	dests[1].counter = node->mcast_counter.counter;
 #endif
 
 	memset(dmac_c, 0, ETH_ALEN);

You can observe this with an allmodconfig build.


Also, please consider including a "Returns:" section in
the Kernel doc of mlx5_fc_local_create().

-- 
pw-bot: changes-requested

