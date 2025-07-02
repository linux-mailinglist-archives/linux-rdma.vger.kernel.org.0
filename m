Return-Path: <linux-rdma+bounces-11823-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E94FAAF0E04
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 10:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209E41C25D1B
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 08:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2217823817F;
	Wed,  2 Jul 2025 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYLmw7dE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FF01EDA12;
	Wed,  2 Jul 2025 08:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751444933; cv=none; b=jhobTm1oMoGQaP+RNEnqNaZf8sw5pnoPrY1vvpspM7v/jUDOfS0luHr5a32JeuLGBUNFmpRpIDNzCHOiJOvSA9XHWpr11iBcZpPiav7gkmmhLZ5tzlXTmdKce9tOTGWOEk+Usi7hB38S2p8KeG5y7gMyAKDTmqQVR8nZJ6NC1eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751444933; c=relaxed/simple;
	bh=HMhGhl+nGkttwlmKfCx46IPS/kNi+zmx1F2ZQiHf9Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2O7atUdTY3RzciZURQ3QZDdOroicJNRDb0/+Q4bM2aL8W/RukWUsLH/CN1GcgXNU2/oFH6hb3BFPT/32I910ytceSXr3blGFi6mOkoUNGvxfAQC9ufghawkE9WZaqPZb5jxM2izioDoCoXmsMfIQci4sLZhl7lFe3h8PFuTvGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYLmw7dE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C57C4CEEE;
	Wed,  2 Jul 2025 08:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751444933;
	bh=HMhGhl+nGkttwlmKfCx46IPS/kNi+zmx1F2ZQiHf9Zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QYLmw7dEmPsd6RF01Odg6OhL8C5zww8nQEXsxMjQbj9dWVzEcfSKNY22SDl4f/iGB
	 NBXf4bO3vGiwxCpLL5vB0E0UiTzCz/WS2k2ixoSoPDh1tFMQ1s9HnX2K0MRyQReNzm
	 Q8IxVG1oxMhoYst9Jq8Kpz9K/D4wY2eWNCNlZKbJ6Ike6iaU43rewyK+0vOkF2ktTI
	 Uomv+dqLF0K4ipfwh/TfUYZfThQnhE3olG7YyD4Mo6uthJpNLGxI54KgTc1nurCBL6
	 v46SF7ofRJ92PF5DexJ3hsEuvretl7/w8TLC3cWmVNb771QKYhHHi6OqzNx0oSCONz
	 aon1AfQTIeI3A==
Date: Wed, 2 Jul 2025 11:28:47 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Stav Aviram <saviram@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
	Mark Bloch <markb@mellanox.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH mlx5-next v1] net/mlx5: Check device memory pointer
 before usage
Message-ID: <20250702082847.GH6278@unreal>
References: <c88711327f4d74d5cebc730dc629607e989ca187.1751370035.git.leon@kernel.org>
 <20250701193858.GA41770@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701193858.GA41770@horms.kernel.org>

On Tue, Jul 01, 2025 at 08:38:58PM +0100, Simon Horman wrote:
> On Tue, Jul 01, 2025 at 03:08:12PM +0300, Leon Romanovsky wrote:
> > From: Stav Aviram <saviram@nvidia.com>
> > 
> > Add a NULL check before accessing device memory to prevent a crash if
> > dev->dm allocation in mlx5_init_once() fails.
> > 
> > Fixes: c9b9dcb430b3 ("net/mlx5: Move device memory management to mlx5_core")
> > Signed-off-by: Stav Aviram <saviram@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> > Changelog:
> > v1:
> >  * Removed extra IS_ERR(dm) check.
> > v0:
> > https://lore.kernel.org/all/e389fa6ef075af1049cd7026b912d736ebe3ad23.1751279408.git.leonro@nvidia.com
> > ---
> >  drivers/infiniband/hw/mlx5/dm.c                  | 2 +-
> >  drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c | 4 ++--
> >  drivers/net/ethernet/mellanox/mlx5/core/main.c   | 2 +-
> >  3 files changed, 4 insertions(+), 4 deletions(-)
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
> 
> nit: -EOPNOTSUPP doesn't feel like the right error code
>      in the !dm_db case.

Why? This error is returned to the user through mlx5_ib_alloc_dm().

Thanks

> 
> >  
> >  	dm = kzalloc(sizeof(*dm), GFP_KERNEL);
> 
> ...

