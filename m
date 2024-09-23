Return-Path: <linux-rdma+bounces-5053-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4121A97F0B7
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2024 20:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7202F1C2195A
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2024 18:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9391B1A0716;
	Mon, 23 Sep 2024 18:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwvChQLi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CEA19F473;
	Mon, 23 Sep 2024 18:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727116549; cv=none; b=N8GyN4dA1R58vPxP2MhnIbBa95v/sBTsaPcRTcxqVdhzrj4h4iQZg/Sk0O4XjHxjIPcv9SFrWVUMw31Q5qcQkRduLSSLOHsSgd0L4Bf4wFj0hpXBU+lDaYuxNX2cv4KidKofiGJdaDMSl7KwQT8lYzm01PPF+InygjtTtMNOYGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727116549; c=relaxed/simple;
	bh=4UPhsqO6WqP/k8vbj8cJkDj5DiOyZtZBnaZOuxjS83g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcXf2TVXLD8mZ4gQXpvO0KGLsCFO+Tfbvmb7ziplDiVhvNqOxBHNRL19Ezw4DymgGTzF3QX+gf7GK+OMS7jHwFdZVqK1i/59IYKiKO19H/TeKFSSwO/SDksTpmA6il662pYhWj1een3tfAlYzYKpeW4gc1t4sZ8YJvlx2WKEnsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwvChQLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEA9C4CEC4;
	Mon, 23 Sep 2024 18:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727116548;
	bh=4UPhsqO6WqP/k8vbj8cJkDj5DiOyZtZBnaZOuxjS83g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kwvChQLiMkbMKBGjBgb9+0HXGbOsXVqEv8wOnFOeFuRg6Y1aCUVk3sPRs2zQtHLiL
	 kGW3TVBBsfG6u/SZiTputvU7grn6rhPWc9bJoPdRPrbvX34YQohf9DkYFGWbtJqAW8
	 5fkQxjdWYYcPQmbwLz6Yb8XFWINytnzFKm6bXhJVrXDHZb5qWUMlnzYX1MTmbPCfrY
	 JOaMiS988+gIKf1XQgPx+iolNi9Izdt95jWLkKsdaPFtAZ03g+3PR9NgzEG0t1LGxT
	 RlDM1wexAlQG6LlPjF6sxu5iVCm1ITdUYn5om1tY/9XVUWwJb/+2k1Mi3bASEYcAia
	 ALHaj6oaO4fVQ==
Date: Mon, 23 Sep 2024 19:35:43 +0100
From: Simon Horman <horms@kernel.org>
To: Elena Salomatkina <esalomatkina@ispras.ru>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxim Mikityanskiy <maximmi@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Maor Dickman <maord@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5e: Fix NULL deref in mlx5e_tir_builder_alloc()
Message-ID: <20240923183543.GA4028748@kernel.org>
References: <20240923113455.24541-1-esalomatkina@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923113455.24541-1-esalomatkina@ispras.ru>

On Mon, Sep 23, 2024 at 02:34:55PM +0300, Elena Salomatkina wrote:
> In mlx5e_tir_builder_alloc() kvzalloc() may return NULL
> which is dereferenced on the next line in a reference
> to the modify field.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: a6696735d694 ("net/mlx5e: Convert TIR to a dedicated object")
> Signed-off-by: Elena Salomatkina <esalomatkina@ispras.ru>

Hi Elena,

Unfortunately your patch doesn't apply. This appears to be because
it has been white-space mangled, somehow: tabs have turned into 4 spaces.

I would suggest using b4, or git format-patch + git send-email.
To send patches.

Also, as a fix, this patch should be targeted at net, like this:

	Subject [PATCH net v2] ...

This and more information about sending Networking patches can be
found here: https://docs.kernel.org/process/maintainer-netdev.html

> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en/tir.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
> index d4239e3b3c88..72310452fce5 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
> @@ -23,6 +23,8 @@ struct mlx5e_tir_builder *mlx5e_tir_builder_alloc(bool modify)
>     struct mlx5e_tir_builder *builder;
>  
>     builder = kvzalloc(sizeof(*builder), GFP_KERNEL);
> +   if (!builder)
> +       return NULL;

nit: blank line here please

>     builder->modify = modify;
>  
>     return builder;

-- 
pw-bot: changes-requested

