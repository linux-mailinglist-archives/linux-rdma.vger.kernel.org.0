Return-Path: <linux-rdma+bounces-13939-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C7EBEE5C3
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Oct 2025 14:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B4C44E4838
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Oct 2025 12:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4912EA158;
	Sun, 19 Oct 2025 12:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLGo3Znb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349C2354AC9;
	Sun, 19 Oct 2025 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760878769; cv=none; b=Ry+eOeLivhfGI1ibAbapEMp2DcmCNviY+5pMJ38bto7Vpw+R3ZD0HWvO7OYLffyTrshZKoGgLp6pnxcUZjXOyBuSIUfaOVHSTT75WvqtkTJ4YdsQA+YnOTHiMDrI0kUAWNZ++FZm2Y1fMBUMukW6BabHD2OKy9B4+wmwYAXbNEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760878769; c=relaxed/simple;
	bh=lhydb80HhVBVgkSnReVAUtolbHDZHGSSKYBAS5qfncU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCD7DdibIxcyJBTnb2/yt23myHH8STyuYpH12y4lGRIgKdas7tzms9/p3QM8ifbi1GyfemxyVaNsSPObAb9M9Dnzabnh1UA7jiVVaLxZ85IhHlVuBANULK/749IdNRUEPj4Wo9OU8SbLaQ8glMdRkjWHM01tSE9aw+UJDQFo4Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLGo3Znb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AB1C4CEE7;
	Sun, 19 Oct 2025 12:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760878768;
	bh=lhydb80HhVBVgkSnReVAUtolbHDZHGSSKYBAS5qfncU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SLGo3Znb71BCOzWVnH7Sf9NsuQvyG4VppjygRg84GX2O3bPEvDOYQpQz82tlox48K
	 BEt8hMCGun9/vbbIbnmoaAUWmhkgslc6WOaMta4TH/WZ9i3NSKVJpaEnHdxQ9pSbSI
	 jRu7Z9QqYCAa4DdTRbPNtcSSIjpXhiPqdNe7WPPt7vWWJ6CVQHlLYPG43rt5eH80YL
	 Qp0YPd7etuo4l538P0D+QbI6FvHGCsLD+DpBe5nyBYEekNd8kn1QsUy0EYO63EUgM0
	 0d4xpFxpLzcXfDoBZE7r5hAjHF6OaqoF9EmoobF2nU1RXaiSqoqAEtzBOc9tEM42wz
	 wn4vAkg+AObNg==
Date: Sun, 19 Oct 2025 15:59:23 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH mlx5-next] {rdma,net}/mlx5: Query vports mac address from
 device
Message-ID: <20251019125923.GI6199@unreal>
References: <20251016014055.2040934-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016014055.2040934-1-saeed@kernel.org>

On Wed, Oct 15, 2025 at 06:40:55PM -0700, Saeed Mahameed wrote:
> From: Adithya Jayachandran <ajayachandra@nvidia.com>
> 
> Before this patch during either switchdev or legacy mode enablement we
> cleared the mac address of vports between changes. This change allows us
> to preserve the vports mac address between eswitch mode changes.
> 
> Signed-off-by: Adithya Jayachandran <ajayachandra@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c             |  2 +-
>  .../net/ethernet/mellanox/mlx5/core/eswitch.c | 20 ++++++----------
>  .../mellanox/mlx5/core/eswitch_offloads.c     |  3 +++
>  .../net/ethernet/mellanox/mlx5/core/vport.c   | 24 +++++++++----------
>  include/linux/mlx5/vport.h                    |  3 ++-
>  5 files changed, 25 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index fc1e86f6c409..90daa58126f4 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -842,7 +842,7 @@ static int mlx5_query_node_guid(struct mlx5_ib_dev *dev,
>  		break;
>  
>  	case MLX5_VPORT_ACCESS_METHOD_NIC:
> -		err = mlx5_query_nic_vport_node_guid(dev->mdev, &tmp);
> +		err = mlx5_query_nic_vport_node_guid(dev->mdev, 0, false, &tmp);
>  		break;

IB changes are pretty straightforward.

Thanks,
Acked-by: Leon Romanovsky <leon@kernel.org> # RDMA

