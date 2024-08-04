Return-Path: <linux-rdma+bounces-4199-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A96F946F60
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Aug 2024 16:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07191F21B00
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Aug 2024 14:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A6655885;
	Sun,  4 Aug 2024 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvTAlS8A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C914FD51A;
	Sun,  4 Aug 2024 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722783153; cv=none; b=n/T887JZQSs5Yyoi42uQ/SyyBvaUNVS1VQRwkA/l3kFMAT4c8sZHyBDR/6A+5T5e+aDLu1MOmvLDlm0eYtnfb0mFblEYzBxlsTNL7KDcMjGCD+aJkO0xw03BIRD7Im/B/ckWtWAWOqR9ddWVb3Yt5XVLVWglolb1nPc/zaBVYcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722783153; c=relaxed/simple;
	bh=+CxXwu9gHav08Z39Ndm7bqrsS3hSpnAC7qU0Tm8Bwh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVKqah5dnXHV/zEVmVxk8GQYnxD6YmGRJSGRmHZXpHOW60MWpUL/2XOIkGE4ODaKKyoiuUJVP67LEU/a+xvdtSqHxZaDBxl32t4uQhhcGLd+qSd9d9ADQk9k4fzK1dOO8PyUSvM+8Y9AhueT62Nu5tvUnRJVe5cCRCPIOL8AzYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvTAlS8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE5DC32786;
	Sun,  4 Aug 2024 14:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722783153;
	bh=+CxXwu9gHav08Z39Ndm7bqrsS3hSpnAC7qU0Tm8Bwh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KvTAlS8AGAIaGZ81aK3i29sZQDobgYVExxeR7C9H7YP7eRZU78mJw5HrJdyHAcn7k
	 ZCx36t7Lgp6MLZafwPs/s4F97yT5cEZH0rlLl2rRj6XhZdma0z3Ixvbi7lwL120C5c
	 DkPd9DfVQsqYR+ZDkcF+Wnd4L0VTLpkrGOEnDnCb7WWRiWoRRsj5QdRW54f58YoHZF
	 Vs6neVYwxTWGUfbAcCriWVG9uChrf5aJqMSeQhJBzU6h8EHmUcOAQXzk3HkEBl2foQ
	 sVIYS3ypNjJ1d5AvES4gALFwn1eEwiH8G8SsV/pSI0hyHxvtz3459hywy64hsmffRo
	 n9iOW/SMWXceA==
Date: Sun, 4 Aug 2024 17:52:27 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH vhost 0/7] vdpa/mlx5: Parallelize device suspend/resume
Message-ID: <20240804145227.GB22826@unreal>
References: <20240802072039.267446-1-dtatulea@nvidia.com>
 <20240802091307-mutt-send-email-mst@kernel.org>
 <20240804084839.GA22826@unreal>
 <20240804093909-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804093909-mutt-send-email-mst@kernel.org>

On Sun, Aug 04, 2024 at 09:39:29AM -0400, Michael S. Tsirkin wrote:
> On Sun, Aug 04, 2024 at 11:48:39AM +0300, Leon Romanovsky wrote:
> > On Fri, Aug 02, 2024 at 09:14:28AM -0400, Michael S. Tsirkin wrote:
> > > On Fri, Aug 02, 2024 at 10:20:17AM +0300, Dragos Tatulea wrote:
> > > > This series parallelizes the mlx5_vdpa device suspend and resume
> > > > operations through the firmware async API. The purpose is to reduce live
> > > > migration downtime.
> > > > 
> > > > The series starts with changing the VQ suspend and resume commands
> > > > to the async API. After that, the switch is made to issue multiple
> > > > commands of the same type in parallel.
> > > > 
> > > > Finally, a bonus improvement is thrown in: keep the notifierd enabled
> > > > during suspend but make it a NOP. Upon resume make sure that the link
> > > > state is forwarded. This shaves around 30ms per device constant time.
> > > > 
> > > > For 1 vDPA device x 32 VQs (16 VQPs), on a large VM (256 GB RAM, 32 CPUs
> > > > x 2 threads per core), the improvements are:
> > > > 
> > > > +-------------------+--------+--------+-----------+
> > > > | operation         | Before | After  | Reduction |
> > > > |-------------------+--------+--------+-----------|
> > > > | mlx5_vdpa_suspend | 37 ms  | 2.5 ms |     14x   |
> > > > | mlx5_vdpa_resume  | 16 ms  | 5 ms   |      3x   |
> > > > +-------------------+--------+--------+-----------+
> > > > 
> > > > Note for the maintainers:
> > > > The first patch contains changes for mlx5_core. This must be applied
> > > > into the mlx5-vhost tree [0] first. Once this patch is applied on
> > > > mlx5-vhost, the change has to be pulled from mlx5-vdpa into the vhost
> > > > tree and only then the remaining patches can be applied.
> > > 
> > > Or maintainer just acks it and I apply directly.
> > 
> > We can do it, but there is a potential to create a conflict between your tree
> > and netdev for whole cycle, which will be a bit annoying. Easiest way to avoid
> > this is to have a shared branch, but in august everyone is on vacation, so it
> > will be probably fine to apply such patch directly.
> > 
> > Thanks
> 
> We can let Linus do something, it's ok ;)

Right and this is how it was for years - Linus dealt with the conflicts
between RDMA and netdev, until he pushed us to have a shared branch :).

However, in this specific cycle and for this specific change, we probably won't
get any conflicts between various trees.

Thanks

> 
> > > 
> > > Let me know when all this can happen.
> > > 
> > > > [0] https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-vhost
> > > > 
> > > > Dragos Tatulea (7):
> > > >   net/mlx5: Support throttled commands from async API
> > > >   vdpa/mlx5: Introduce error logging function
> > > >   vdpa/mlx5: Use async API for vq query command
> > > >   vdpa/mlx5: Use async API for vq modify commands
> > > >   vdpa/mlx5: Parallelize device suspend
> > > >   vdpa/mlx5: Parallelize device resume
> > > >   vdpa/mlx5: Keep notifiers during suspend but ignore
> > > > 
> > > >  drivers/net/ethernet/mellanox/mlx5/core/cmd.c |  21 +-
> > > >  drivers/vdpa/mlx5/core/mlx5_vdpa.h            |   7 +
> > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c             | 435 +++++++++++++-----
> > > >  3 files changed, 333 insertions(+), 130 deletions(-)
> > > > 
> > > > -- 
> > > > 2.45.2
> > > 
> > > 
> 

