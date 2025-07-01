Return-Path: <linux-rdma+bounces-11796-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D887FAEF69C
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 13:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080881BC83D6
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 11:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103A2255E40;
	Tue,  1 Jul 2025 11:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2p31y/l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16231DC994;
	Tue,  1 Jul 2025 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751369606; cv=none; b=mB29ksUz3JyhZsl/u1LtUuRKJ5MZh3GDNVtCDeytb56PqQovUTDWrxqhYk0IQwnFrW5he1Tm87g2S3IgZQsp3ut8FWxrX9mgnqSPAahRt3AmCBHaEu3sdvp7khtISJsgNozezm8HIYVlHTyRyO7Eso82dWYnZMsm1P4WDbkQo3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751369606; c=relaxed/simple;
	bh=fjDfVMjyd0Zd1ckqMWWzPMrZbI1wjZt7E89YrnJZ4ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCXvGJytkYF2FYgn0l2qfAx7aQxoWrizW87BE7Vr7KA9Oqpiw7X0SbYmxKQO+baUdoIF4LcX5qyuMjuw3BDzU3i8RVkKkeYXujqiLgmgV0N2QrGOb0GfRxtr1NhT1tRDZ/+8potzdkxEtyyAs75IiGN2mugaaV3tT9C9k0fDzaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2p31y/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA57DC4CEEB;
	Tue,  1 Jul 2025 11:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751369606;
	bh=fjDfVMjyd0Zd1ckqMWWzPMrZbI1wjZt7E89YrnJZ4ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B2p31y/lFHpWe/VUCE2QUulqA7F70TmKKbCzyWBEeXmdS/nuC3kAj8gNDaSGn+4dI
	 ScI5NebEDCR8J1yf79v7X0Scv3qBEC0b6J7YyfIcThYoOtUrhTy3StLqC9KDG+Y6UU
	 +Ju86Bk+o8RqRBZuiFIY/B6nEqjTQ3zY+ug174LRBjVsWGpvaFytmSUozdh4+hisUm
	 nofVtjyCzj8zCfB0b8K3RUwmLZi64ZDQNmgxCxrLkey1k60IcWq4Z4Jfcts7k5KHdi
	 IEQDaGWEwCOjdEpcB1E5OK6mPEg9XColMwUTZLSVEoYbB3RZYE3V3xt37ViZKaAN3X
	 JKwFXRa/yOZBg==
Date: Tue, 1 Jul 2025 14:33:18 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Stav Aviram <saviram@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
	Mark Bloch <markb@mellanox.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH mlx5-next] net/mlx5: Check device memory pointer before
 usage
Message-ID: <20250701113318.GB6278@unreal>
References: <e389fa6ef075af1049cd7026b912d736ebe3ad23.1751279408.git.leonro@nvidia.com>
 <aGJtbp/nXrCqbvbO@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGJtbp/nXrCqbvbO@mev-dev.igk.intel.com>

On Mon, Jun 30, 2025 at 12:56:46PM +0200, Michal Swiatkowski wrote:
> On Mon, Jun 30, 2025 at 01:35:53PM +0300, Leon Romanovsky wrote:
> > From: Stav Aviram <saviram@nvidia.com>
> > 
> > Add a NULL check before accessing device memory to prevent a crash if
> > dev->dm allocation in mlx5_init_once() fails.
> > 
> > Fixes: c9b9dcb430b3 ("net/mlx5: Move device memory management to mlx5_core")
> > Signed-off-by: Stav Aviram <saviram@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/infiniband/hw/mlx5/dm.c                  | 2 +-
> >  drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/mlx5/dm.c b/drivers/infiniband/hw/mlx5/dm.c
> > index b4c97fb62abf..9ded2b7c1e31 100644
> > --- a/drivers/infiniband/hw/mlx5/dm.c
> > +++ b/drivers/infiniband/hw/mlx5/dm.c
> > @@ -282,7 +282,7 @@ static struct ib_dm *handle_alloc_dm_memic(struct ib_ucontext *ctx,
> >  	int err;
> >  	u64 address;
> >  
> > -	if (!MLX5_CAP_DEV_MEM(dm_db->dev, memic))
> > +	if (!dm_db || !MLX5_CAP_DEV_MEM(dm_db->dev, memic))
> >  		return ERR_PTR(-EOPNOTSUPP);
> >  
> >  	dm = kzalloc(sizeof(*dm), GFP_KERNEL);
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c
> > index 7c5516b0a844..8115071c34a4 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c
> > @@ -30,7 +30,7 @@ struct mlx5_dm *mlx5_dm_create(struct mlx5_core_dev *dev)
> >  
> >  	dm = kzalloc(sizeof(*dm), GFP_KERNEL);
> >  	if (!dm)
> > -		return ERR_PTR(-ENOMEM);
> > +		return NULL;
> >  
> >  	spin_lock_init(&dm->lock);
> >  
> > @@ -96,7 +96,7 @@ struct mlx5_dm *mlx5_dm_create(struct mlx5_core_dev *dev)
> >  err_steering:
> >  	kfree(dm);
> >  
> > -	return ERR_PTR(-ENOMEM);
> > +	return NULL;
> 
> In mlx5_init_once() IS_ERR is used (still). It should be consistent.
> Looks like you can use IS_ERR() instead of checking just dm_db, however,
> mlx5_dm_create() returns also NULL. I am not sure if it is fine (will
> not cause an error in mlx5_init_once()).
> 
> Maybe the best is to change a check in mlx5_init_once() from IS_ERROR()
> to just !dm.

We need to remove IS_ERR() check from all places.

> 
> Thanks
> 
> >  }
> >  
> >  void mlx5_dm_cleanup(struct mlx5_core_dev *dev)
> > -- 
> > 2.50.0

