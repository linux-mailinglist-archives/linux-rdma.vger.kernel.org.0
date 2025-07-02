Return-Path: <linux-rdma+bounces-11836-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77DFAF5A92
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 16:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FACA16BB69
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 14:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EE0286420;
	Wed,  2 Jul 2025 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrwU8sxA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E37E288C38;
	Wed,  2 Jul 2025 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465260; cv=none; b=kXj4TnahHgu0WfekMpj9KglZoyz5Ndjicqk0RGdsn0Z1i9kmFe+zzrJblW5+Hz1zfk3CFF1h887RlCC5Nr5/12U+5PmX6NkBimQHXucEJHyNRaIJ3FC+g5FwuP/PjX56viyNBcxdrNwPKISjELlnEG8Ry7t+SCJPzDBdRQMMitk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465260; c=relaxed/simple;
	bh=mTghYG16uqf81hPKOPwgfpUOHxtzVIWN9TKCcG0uDPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuQBIUxsp98KykberdWuabJ2JysNG8nESI/ePtPL19eofV2ifIEVBSkq1LKgG5awiNFUIFqAKkwrnO/bVxmyt2Z50tB9BnTH1cKNxxK50DcPveCHlCx9ByXTHvr2cR2P4jTevnvwgD69NYveCGj56ej69q8nYE/0etteM87EHg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrwU8sxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716E2C4CEE7;
	Wed,  2 Jul 2025 14:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751465259;
	bh=mTghYG16uqf81hPKOPwgfpUOHxtzVIWN9TKCcG0uDPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NrwU8sxArSIqCpc3vW31Q6ExWLGXvsz5BcWqIXL/qzjcOGbNASZzSZ5kistqcz/hv
	 DayzgHrmnz59OuVcCCc7gujethjASQ0Rzghh1SAWdB+vdJ8xY+Z01rLbYzmDcMpG8F
	 MCx3+PaXKF2IWWFIDi9PptvLyaBDf+NUQNJRb4dhpySx5VKyvN6ZaaqLW60oo3pE9k
	 196aI0T12ml5XaSWfcJSBHldMNZX5AD7B6M5328HiK+KJxwOJrs3VN38bLlNOkdBlZ
	 e5BGkdtEPk34bNbTOTYoOEmd6Pf42705Dp8bhUdEKstQjPka2MxrFrIjR3Ae/ZgAYf
	 ETHLFbAVaK6Bw==
Date: Wed, 2 Jul 2025 15:07:35 +0100
From: Simon Horman <horms@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
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
Message-ID: <20250702140735.GE41770@horms.kernel.org>
References: <c88711327f4d74d5cebc730dc629607e989ca187.1751370035.git.leon@kernel.org>
 <20250701193858.GA41770@horms.kernel.org>
 <20250702082847.GH6278@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702082847.GH6278@unreal>

On Wed, Jul 02, 2025 at 11:28:47AM +0300, Leon Romanovsky wrote:
> On Tue, Jul 01, 2025 at 08:38:58PM +0100, Simon Horman wrote:
> > On Tue, Jul 01, 2025 at 03:08:12PM +0300, Leon Romanovsky wrote:
> > > From: Stav Aviram <saviram@nvidia.com>
> > > 
> > > Add a NULL check before accessing device memory to prevent a crash if
> > > dev->dm allocation in mlx5_init_once() fails.
> > > 
> > > Fixes: c9b9dcb430b3 ("net/mlx5: Move device memory management to mlx5_core")
> > > Signed-off-by: Stav Aviram <saviram@nvidia.com>
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > > Changelog:
> > > v1:
> > >  * Removed extra IS_ERR(dm) check.
> > > v0:
> > > https://lore.kernel.org/all/e389fa6ef075af1049cd7026b912d736ebe3ad23.1751279408.git.leonro@nvidia.com
> > > ---
> > >  drivers/infiniband/hw/mlx5/dm.c                  | 2 +-
> > >  drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c | 4 ++--
> > >  drivers/net/ethernet/mellanox/mlx5/core/main.c   | 2 +-
> > >  3 files changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/infiniband/hw/mlx5/dm.c b/drivers/infiniband/hw/mlx5/dm.c
> > > index b4c97fb62abf..9ded2b7c1e31 100644
> > > --- a/drivers/infiniband/hw/mlx5/dm.c
> > > +++ b/drivers/infiniband/hw/mlx5/dm.c
> > > @@ -282,7 +282,7 @@ static struct ib_dm *handle_alloc_dm_memic(struct ib_ucontext *ctx,
> > >  	int err;
> > >  	u64 address;
> > >  
> > > -	if (!MLX5_CAP_DEV_MEM(dm_db->dev, memic))
> > > +	if (!dm_db || !MLX5_CAP_DEV_MEM(dm_db->dev, memic))
> > >  		return ERR_PTR(-EOPNOTSUPP);
> > 
> > nit: -EOPNOTSUPP doesn't feel like the right error code
> >      in the !dm_db case.
> 
> Why? This error is returned to the user through mlx5_ib_alloc_dm().

Because, as I understand things, such a case would be due to a memory
allocation failure, not by the device not supporting a feature.

handle_alloc_dm_memic() already returns ERR_PTR(-ENOMEM) if kzalloc() fails.
I'd suggest doing so for the !dm_db case too.

But I don't feel particularly strongly about this.

