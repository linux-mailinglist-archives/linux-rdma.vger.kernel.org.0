Return-Path: <linux-rdma+bounces-15512-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62894D19694
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 15:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88D69306EEEE
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 14:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF9422F16E;
	Tue, 13 Jan 2026 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfLUfnZ4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6261F181F;
	Tue, 13 Jan 2026 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313730; cv=none; b=Ei1kAVQHuk4vIyBkiHvD/+9bK3Wug1DIUYrYw/SCxQDTqbpNY1fa44/cSBVwCcmVPFRtY4UtR/KjfTQXsPrfD3ZKzrWff6BKZklJsj7MWnkTkIrjXZR/1f9GI7evUp9kVrZ6pOPhK6AXUHrwUMC+Ph8Wvv58NoUX5yPma4dgrmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313730; c=relaxed/simple;
	bh=pzaUGPEggsSCFOX8IaD7pFi7kGWvSrUq+qBXjCUIJCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7LA6YbFl/EbIEGjaU+frMRIiQ2ReUyPmfbRZxBNIAfuhCYeNqVV4Ekn0tkn1WHkPJF1Un6Kq72mcO7fvDq1l46y+9EKMSzXv7pXBGGLR8su8JdPd5afapgkLhzK5SOTfB9s/TwGJ//R4bIWczvrdJAkzw0WHJB21BL5dKwyAxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfLUfnZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A907C116C6;
	Tue, 13 Jan 2026 14:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768313729;
	bh=pzaUGPEggsSCFOX8IaD7pFi7kGWvSrUq+qBXjCUIJCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kfLUfnZ4gR0oTBqIIpTgYwbP3NGSdleMFSGJjtluj7SkwjNc7V+nFOUrc1uTAwNwE
	 UKSuhES4L1mXys9tBZBub1/j6eCoDOp1OtgYVGsHwSkwb3t4nn6DQi5dFZtKGtk6yB
	 11Z0CTlhq6BS0CJxmQulMsZKhbrKbRPcj7yDRUw14dJ6fkGyg6fwkyva7ylIsFgwt4
	 k2s7rCsP1nztIFd3Rfe95Jqmme0TRXnQg7z/z5DaIrhBKhSUhj7dIJ+xZQ3Jms0jVL
	 OT9SRQopidEJhkruh+DnSpU5o+7GlfpeL7cpOK96nsh1CiwPUo+qb05VqSQjNd5d5v
	 0LWyMkerpQbRw==
Date: Tue, 13 Jan 2026 16:15:25 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Edward Srouji <edwards@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Mark Bloch <mbloch@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Roi Dayan <roid@nvidia.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Or Har-Toov <ohartoov@nvidia.com>
Subject: Re: [PATCH rdma-next] IB/mlx5: Fix port speed query for representors
Message-ID: <20260113141525.GC179508@unreal>
References: <20260113-port-speed-query-fix-v1-1-234cacc991fa@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113-port-speed-query-fix-v1-1-234cacc991fa@nvidia.com>

On Tue, Jan 13, 2026 at 03:31:26PM +0200, Edward Srouji wrote:
> From: Or Har-Toov <ohartoov@nvidia.com>
> 
> When querying speed information for a representor in switchdev mode,
> the code previously used the first device in the eswitch, which may not
> match the device that actually owns the representor. In setups such as
> multi-port eswitch or LAG, this led to incorrect port attributes being
> reported.
> 
> Fix this by retrieving the correct core device from the representor's
> eswitch before querying its port attributes.
> 
> Fixes: 27f9e0ccb6da ("net/mlx5: Lag, Add single RDMA device in multiport mode")
> Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Edward Srouji <edwards@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index e81080622283..d0c6648ee035 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -561,12 +561,23 @@ static int mlx5_query_port_roce(struct ib_device *device, u32 port_num,
>  	 * of an error it will still be zeroed out.
>  	 * Use native port in case of reps
>  	 */
> -	if (dev->is_rep)
> -		err = mlx5_query_port_ptys(mdev, out, sizeof(out), MLX5_PTYS_EN,
> -					   1, 0);
> -	else
> -		err = mlx5_query_port_ptys(mdev, out, sizeof(out), MLX5_PTYS_EN,
> -					   mdev_port_num, 0);
> +	if (dev->is_rep) {
> +		struct mlx5_eswitch_rep *rep;
> +		struct mlx5_core_dev *esw_mdev;
> +
> +		rep = dev->port[port_num - 1].rep;
> +		if (rep) {
> +			esw_mdev = mlx5_eswitch_get_core_dev(rep->esw);
> +			if (esw_mdev)

When can this esw_mdev be NULL? We are in representor code, so
mlx5_esw_allowed() should evaluate to true in mlx5_eswitch_get_core_dev().
Is there any scenario where it wouldn't?

> +				mdev = esw_mdev;
> +		}
> +
> +		mdev_port_num = 1;
> +	}
> +
> +	err = mlx5_query_port_ptys(mdev, out, sizeof(out), MLX5_PTYS_EN,
> +				   mdev_port_num, 0);
> +
>  	if (err)
>  		goto out;
>  	ext = !!MLX5_GET_ETH_PROTO(ptys_reg, out, true, eth_proto_capability);
> 
> ---
> base-commit: 325e3b5431ddd27c5f93156b36838a351e3b2f72
> change-id: 20260113-port-speed-query-fix-592efa2b4e36
> 
> Best regards,
> -- 
> Edward Srouji <edwards@nvidia.com>
> 

