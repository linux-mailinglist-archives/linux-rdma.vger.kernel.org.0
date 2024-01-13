Return-Path: <linux-rdma+bounces-623-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E1F82CD80
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jan 2024 16:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246DD284001
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jan 2024 15:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAACA1C27;
	Sat, 13 Jan 2024 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8dSd36e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACA31C16;
	Sat, 13 Jan 2024 15:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3BEC433F1;
	Sat, 13 Jan 2024 15:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705159998;
	bh=a6Ra8/vW20LqIUs9s37sHdzXHXZxogXvoS1zUc0El3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l8dSd36ej497TKceU3Qsy8VxpLEUAfUPXC6n1FJE54MokQT4OwMUHEYC/czQFaZQw
	 uTbccaH3L+xnx114iixt7ab12pWgT5tiaSi9A4iNY77nQmbdROGYbjU+rDkOjIV+qM
	 uSqd/vN9YJDuPo7sRpNjU6nWK+eg+Hxz7Z5jbSOjZ0g7AqZzDl+o/hHNkjbpgnYePJ
	 QtVzy5c5/94vJhSZK5wYRlFWqZYWh66LlRBBWSmh39KWPdcOvSyrJD/WC9T2k/uzdi
	 eAw1txfsm4R3d71W6NXI4E7mOXLjUl5/w/YV0ThY02uCFj4zX5fC+EVUZfCCtqE2dz
	 lbnSzMwZot9bg==
Date: Sat, 13 Jan 2024 15:33:13 +0000
From: Simon Horman <horms@kernel.org>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maor Gottlieb <maorg@mellanox.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v3] net/mlx5e: fix a double-free in arfs_create_groups
Message-ID: <20240113153313.GH392144@kernel.org>
References: <20240112072916.3726945-1-alexious@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112072916.3726945-1-alexious@zju.edu.cn>

On Fri, Jan 12, 2024 at 03:29:16PM +0800, Zhipeng Lu wrote:
> When `in` allocated by kvzalloc fails, arfs_create_groups will free
> ft->g and return an error. However, arfs_create_table, the only caller of
> arfs_create_groups, will hold this error and call to
> mlx5e_destroy_flow_table, in which the ft->g will be freed again.
> 
> Fixes: 1cabe6b0965e ("net/mlx5e: Create aRFS flow tables")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>

Thanks, I think this is getting close.

Can you please prepare a v4 with the nits below fixed?
And please target at the 'net' tree, by making sure it
is based on the main branch of that tree, and marking
the subject as follows:

	Subject: [PATCH net v3] ...

> ---
> Changelog:
> 
> v2: free ft->g just in arfs_create_groups with a unwind ladder.
> v3: split the allocation of ft->g and in. Rename the error label.
>     remove some refector change in v2.
> ---
>  .../net/ethernet/mellanox/mlx5/core/en_arfs.c | 26 +++++++++++--------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
> index bb7f86c993e5..0424ae068a60 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
> @@ -254,11 +254,13 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
>  
>  	ft->g = kcalloc(MLX5E_ARFS_NUM_GROUPS,
>  			sizeof(*ft->g), GFP_KERNEL);
> -	in = kvzalloc(inlen, GFP_KERNEL);
> -	if  (!in || !ft->g) {
> -		kfree(ft->g);
> -		kvfree(in);
> +	if(!ft->g)

nit: (one) space after if, please

>  		return -ENOMEM;
> +
> +	in = kvzalloc(inlen, GFP_KERNEL);
> +	if  (!in) {

nit: one space is enough after if

> +		err = -ENOMEM;
> +		goto err_free_g;
>  	}
>  
>  	mc = MLX5_ADDR_OF(create_flow_group_in, in, match_criteria);

...

