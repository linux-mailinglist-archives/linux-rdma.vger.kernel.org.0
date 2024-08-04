Return-Path: <linux-rdma+bounces-4197-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 376B7946D8A
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Aug 2024 10:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688FC1C21004
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Aug 2024 08:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C5A1F95A;
	Sun,  4 Aug 2024 08:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJ0PWQWY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E465695;
	Sun,  4 Aug 2024 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722761325; cv=none; b=m890XGUNJXasjXcRmpk9HRgNLEWcQnXHH76yu/YSHx8KLecZOe8bJ0YqqDTC2OfRJOyuQo2nbq4jUrx0XMILSgRU1DNpqkC3DuMq+A0EE9zC7NDe5Kn+em/PDqpf5+Wxf/kLZ4knvp4wTJV6fDK8mf3GjUOz92r8+tit/I7yk+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722761325; c=relaxed/simple;
	bh=Ydur35hDBGfHtuv3jNpMs9Jkoe8MI1AfpUUuDd1ttXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwEQP4D4dAJDcf00Oymk29Eh1Ud/TvI4a7lMWJOhAe5vKjyvQ7YmWwDY6WGSgnKpI0ZXUCC8iaX0rNjb5k/A8chi30Hbrl5wyDT8iX/hs0eKhoPbldSL5LimcSH+IU/bGsRwcoB5u/Xi2Q9SmbVLxYIUYfH7PmiPzmwzNZwZVZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJ0PWQWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06257C32786;
	Sun,  4 Aug 2024 08:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722761324;
	bh=Ydur35hDBGfHtuv3jNpMs9Jkoe8MI1AfpUUuDd1ttXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vJ0PWQWYbb/u+IU8pob32HHRfpVbXC88y7Y8Jq45qU9IETSe9A9JCwuAlDNN+i5ga
	 JADAi5q9SIURrRt800fIsTuzvT5voel0mfqlPgxkcoj5Bkn+qJrxQKzqoBeCU9Ohdu
	 FqkdYTDpuuonInnT+MMcjmq8UbeeK5x8jnuxSXK3cPWayknXyr7TZ4GCYtZTEXuKIo
	 gF+nfIcJnAFXrpNSjznozkdguGy65PE7K9zpl+s0QlpLzPO0jHYi+FiXidJt/aMMKW
	 wIgOqjDPP2bYAYW5HGh88UFBkkIOp9Otk6CRg4FN8fToV7d0bxdPCxfzIh1QO5izpN
	 xwNtHA6pxKz6w==
Date: Sun, 4 Aug 2024 11:48:39 +0300
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
Message-ID: <20240804084839.GA22826@unreal>
References: <20240802072039.267446-1-dtatulea@nvidia.com>
 <20240802091307-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802091307-mutt-send-email-mst@kernel.org>

On Fri, Aug 02, 2024 at 09:14:28AM -0400, Michael S. Tsirkin wrote:
> On Fri, Aug 02, 2024 at 10:20:17AM +0300, Dragos Tatulea wrote:
> > This series parallelizes the mlx5_vdpa device suspend and resume
> > operations through the firmware async API. The purpose is to reduce live
> > migration downtime.
> > 
> > The series starts with changing the VQ suspend and resume commands
> > to the async API. After that, the switch is made to issue multiple
> > commands of the same type in parallel.
> > 
> > Finally, a bonus improvement is thrown in: keep the notifierd enabled
> > during suspend but make it a NOP. Upon resume make sure that the link
> > state is forwarded. This shaves around 30ms per device constant time.
> > 
> > For 1 vDPA device x 32 VQs (16 VQPs), on a large VM (256 GB RAM, 32 CPUs
> > x 2 threads per core), the improvements are:
> > 
> > +-------------------+--------+--------+-----------+
> > | operation         | Before | After  | Reduction |
> > |-------------------+--------+--------+-----------|
> > | mlx5_vdpa_suspend | 37 ms  | 2.5 ms |     14x   |
> > | mlx5_vdpa_resume  | 16 ms  | 5 ms   |      3x   |
> > +-------------------+--------+--------+-----------+
> > 
> > Note for the maintainers:
> > The first patch contains changes for mlx5_core. This must be applied
> > into the mlx5-vhost tree [0] first. Once this patch is applied on
> > mlx5-vhost, the change has to be pulled from mlx5-vdpa into the vhost
> > tree and only then the remaining patches can be applied.
> 
> Or maintainer just acks it and I apply directly.

We can do it, but there is a potential to create a conflict between your tree
and netdev for whole cycle, which will be a bit annoying. Easiest way to avoid
this is to have a shared branch, but in august everyone is on vacation, so it
will be probably fine to apply such patch directly.

Thanks

> 
> Let me know when all this can happen.
> 
> > [0] https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-vhost
> > 
> > Dragos Tatulea (7):
> >   net/mlx5: Support throttled commands from async API
> >   vdpa/mlx5: Introduce error logging function
> >   vdpa/mlx5: Use async API for vq query command
> >   vdpa/mlx5: Use async API for vq modify commands
> >   vdpa/mlx5: Parallelize device suspend
> >   vdpa/mlx5: Parallelize device resume
> >   vdpa/mlx5: Keep notifiers during suspend but ignore
> > 
> >  drivers/net/ethernet/mellanox/mlx5/core/cmd.c |  21 +-
> >  drivers/vdpa/mlx5/core/mlx5_vdpa.h            |   7 +
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c             | 435 +++++++++++++-----
> >  3 files changed, 333 insertions(+), 130 deletions(-)
> > 
> > -- 
> > 2.45.2
> 
> 

