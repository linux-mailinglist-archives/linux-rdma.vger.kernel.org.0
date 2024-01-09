Return-Path: <linux-rdma+bounces-568-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A21828065
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jan 2024 09:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663FC1F27EF8
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jan 2024 08:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1808728DAF;
	Tue,  9 Jan 2024 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZtGb1NT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA97A224E9;
	Tue,  9 Jan 2024 08:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F52AC433F1;
	Tue,  9 Jan 2024 08:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704788322;
	bh=CUhGrW6qhuLcXbuLUpV22kqI6zTuSh9T5/ELNVxH5ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XZtGb1NTGzY6XB2aYRMNdNY15fKBSO4zcgAqXGZFD2MwThLy9mWbPhznoFg1QyJgL
	 +m5/oTtR2/Gt6P/ae2r7tiUGlvAlwIDRov/n3IC+WueVWJpxvzBIElNp/JkJF2MEp1
	 9/NKVI2qP8z1u1Q8juT2ek/DRyRejnVZSAe6Wwm1ubra8iCqfF/bu+tSN/rFw1xv3W
	 UXvttAIdLbeFfscQ3b5EEGJPP4WdH/BHhEY51qeKl9NUs0aMuTI1GTr2IBMF86idJj
	 LsN6TUxWn696lkLFpQXpNfdrp8LdK1mF+0HXTvdDwn7PNujC/FTSuJOvB70JtHNocC
	 W2LtgNDouVV8w==
Date: Tue, 9 Jan 2024 08:18:37 +0000
From: Simon Horman <horms@kernel.org>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maor Gottlieb <maorg@mellanox.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] net/mlx5e: fix a double-free in arfs_create_groups
Message-ID: <20240109081837.GJ132648@kernel.org>
References: <20240108152605.3712050-1-alexious@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108152605.3712050-1-alexious@zju.edu.cn>

On Mon, Jan 08, 2024 at 11:26:04PM +0800, Zhipeng Lu wrote:
> When `in` allocated by kvzalloc fails, arfs_create_groups will free
> ft->g and return an error. However, arfs_create_table, the only caller of
> arfs_create_groups, will hold this error and call to
> mlx5e_destroy_flow_table, in which the ft->g will be freed again.
> 
> Fixes: 1cabe6b0965e ("net/mlx5e: Create aRFS flow tables")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> Reviewed-by: Simon Horman <horms@kernel.org>

When working on netdev (and probably elsewhere)
Please don't include Reviewed-by or other tags
that were explicitly supplied by someone: I don't recall
supplying the tag above so please drop it.

> ---
> Changelog:
> 
> v2: free ft->g just in arfs_create_groups with a unwind ladde.
> ---
>  .../net/ethernet/mellanox/mlx5/core/en_arfs.c   | 17 +++++++++--------
>  drivers/net/ethernet/mellanox/mlx5/core/en_fs.c |  1 -
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
> index bb7f86c993e5..c96f4c571b63 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
> @@ -252,13 +252,14 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
>  	int err;
>  	u8 *mc;
>  
> +	ft->num_groups = 0;
> +

Although I suggested the above change, I think it
probably suitable for a separate patch. For one thing,
this is not mentioned in the patch subject. And for another,
it's probably better to change one thing at a time.

>  	ft->g = kcalloc(MLX5E_ARFS_NUM_GROUPS,
>  			sizeof(*ft->g), GFP_KERNEL);
>  	in = kvzalloc(inlen, GFP_KERNEL);
>  	if  (!in || !ft->g) {
> -		kfree(ft->g);
> -		kvfree(in);
> -		return -ENOMEM;
> +		err = -ENOMEM;
> +		goto free_ft;
>  	}

I would probably have split this up a bit:

>  
>  	mc = MLX5_ADDR_OF(create_flow_group_in, in, match_criteria);
> @@ -278,7 +279,7 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
>  		break;
>  	default:
>  		err = -EINVAL;
> -		goto out;
> +		goto free_ft;
>  	}
>  
>  	switch (type) {
> @@ -300,7 +301,7 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
>  		break;
>  	default:
>  		err = -EINVAL;
> -		goto out;
> +		goto free_ft;
>  	}
>  
>  	MLX5_SET_CFG(in, match_criteria_enable, MLX5_MATCH_OUTER_HEADERS);
> @@ -327,7 +328,9 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
>  err:
>  	err = PTR_ERR(ft->g[ft->num_groups]);
>  	ft->g[ft->num_groups] = NULL;
> -out:
> +free_ft:
> +	kfree(ft->g);
> +	ft->g = NULL;
>  	kvfree(in);
>  
>  	return err;

I think that I would have named the labels err_*, which
I think is more idiomatic. So combined with my suggestion
above, I suggest something like:

-err:
+err_clean_group:
        err = PTR_ERR(ft->g[ft->num_groups]);
        ft->g[ft->num_groups] = NULL;
-out:
+err_free_in:
        kvfree(in);
+err_free_g:
+       kfree(ft->g);
+	ft->g = NULL;

 	return err;


> @@ -343,8 +346,6 @@ static int arfs_create_table(struct mlx5e_flow_steering *fs,
>  	struct mlx5_flow_table_attr ft_attr = {};
>  	int err;
>  
> -	ft->num_groups = 0;
> -
>  	ft_attr.max_fte = MLX5E_ARFS_TABLE_SIZE;
>  	ft_attr.level = MLX5E_ARFS_FT_LEVEL;
>  	ft_attr.prio = MLX5E_NIC_PRIO;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
> index 777d311d44ef..7b6aa0c8b58d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
> @@ -883,7 +883,6 @@ void mlx5e_fs_init_l2_addr(struct mlx5e_flow_steering *fs, struct net_device *ne
>  void mlx5e_destroy_flow_table(struct mlx5e_flow_table *ft)
>  {
>  	mlx5e_destroy_groups(ft);
> -	kfree(ft->g);
>  	mlx5_destroy_flow_table(ft->t);
>  	ft->t = NULL;

Is the above still needed in some cases, and safe in all cases?

