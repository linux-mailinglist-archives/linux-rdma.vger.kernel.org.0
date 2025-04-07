Return-Path: <linux-rdma+bounces-9194-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA6AA7E66B
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 18:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F46189DE70
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 16:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BDB209F3C;
	Mon,  7 Apr 2025 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVRIsCwT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A216F206F3D;
	Mon,  7 Apr 2025 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042700; cv=none; b=UQWL74iF5LIrp0YhyynvoR4dOSxFS4z0AnheIaPa5phN15lUmrz7hhFQD2Q5QXlG+USSFOQVvMWPKOqbfI99wv/HqDuDl+p7c4V/DqX42kMM6gc1tx+2qrgScStgVAEurvrLbKRsy3MrUa25kvifnXy9pjpNaXTATC+47HvQYoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042700; c=relaxed/simple;
	bh=Npy/xy0YV1ziwkRI72xXbsBU6c5ZpgqGLAv3/5M2HgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQ3ucAfkIPp5CRtwWGIVzp7pqNPzJglGilVK66NVFVVwdKqPD40plv0oepGPSyDQgVwbkc6H9wuo5V04x7CRRU8GzRt8VyX3jnU0zeivGW3C+no8q/8JrfFZNAG8sWnHvtd0EVAXLvfQe50QtsGY8AJbW1kj0V3SjSe+LOnaPe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVRIsCwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52057C4CEDD;
	Mon,  7 Apr 2025 16:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744042700;
	bh=Npy/xy0YV1ziwkRI72xXbsBU6c5ZpgqGLAv3/5M2HgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kVRIsCwT+c6EbalzQ8v601BWz4AtFEcupFLn/1nR//IQRZbJUmUMlOWsp12GLXMzV
	 R9zN/8xEoglBghyQ1+7ICgEIXdK9WWHoe4gKi067Ltvp4z6C2PKnYUATPq3HBHFS7t
	 6HP9Yrr+q/3ZhfXa9C5q9qtfGRJyIl4YXh7Hop7JG82R5cVrRHFGeXIXR/zFo/iNrF
	 UTAomdSPbn88DYS/QwzOuViJhQ8tRVVv1ZXMRFuKhrhMS4rAMQNIUsjWq/VKmFml+p
	 rfxB9Ii7fedu+nrGnoTwNYfwJ3Kjg/4ZHDx5GfaEeu2BdVbn6sdxhmDDtCUWpCDy8G
	 r6gUrtGZxLTnw==
Date: Mon, 7 Apr 2025 17:18:15 +0100
From: Simon Horman <horms@kernel.org>
To: Charles Han <hanchunchao@inspur.com>
Cc: saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, lariel@nvidia.com,
	paulb@nvidia.com, maord@nvidia.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] net/mlx5e: fix potential null dereference in
 mlx5e_tc_nic_create_miss_table
Message-ID: <20250407161815.GR395307@horms.kernel.org>
References: <0e08292e-9280-4ef6-baf7-e9f642d33177@gmail.com>
 <20250407072032.5232-1-hanchunchao@inspur.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407072032.5232-1-hanchunchao@inspur.com>

On Mon, Apr 07, 2025 at 03:20:31PM +0800, Charles Han wrote:
> mlx5_get_flow_namespace() may return a NULL pointer, dereferencing it
> without NULL check may lead to NULL dereference.
> Add a NULL check for ns.
> 
> Fixes: 66cb64e292d2 ("net/mlx5e: TC NIC mode, fix tc chains miss table")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> index 9ba99609999f..c2f23ac95c3d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> @@ -5216,6 +5216,10 @@ static int mlx5e_tc_nic_create_miss_table(struct mlx5e_priv *priv)
>  	ft_attr.level = MLX5E_TC_MISS_LEVEL;
>  	ft_attr.prio = 0;
>  	ns = mlx5_get_flow_namespace(priv->mdev, MLX5_FLOW_NAMESPACE_KERNEL);
> +	if (!ns) {
> +		netdev_err(priv->mdev, "Failed to get flow namespace\n");

Hi Charles,

This does not seem to be correct. gcc-14.2.0 says:

drivers/net/ethernet/mellanox/mlx5/core/en_tc.c: In function 'mlx5e_tc_nic_create_miss_table':
drivers/net/ethernet/mellanox/mlx5/core/en_tc.c:5220:32: error: passing argument 1 of 'netdev_err' from incompatible pointer type [-Wincompatible-pointer-types]
 5220 |                 netdev_err(priv->mdev, "Failed to get flow namespace\n");
      |                            ~~~~^~~~~~
      |                                |
      |                                struct mlx5_core_dev *
In file included from ./include/linux/skbuff.h:39,
                 from ./include/linux/netlink.h:7,
                 from ./include/net/flow_offload.h:6,
                 from drivers/net/ethernet/mellanox/mlx5/core/en_tc.c:34:
./include/net/net_debug.h:20:42: note: expected 'const struct net_device *' but argument is of type 'struct mlx5_core_dev *'
   20 | void netdev_err(const struct net_device *dev, const char *format, ...);
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~^~~

...

-- 
pw-bot: changes-requested

