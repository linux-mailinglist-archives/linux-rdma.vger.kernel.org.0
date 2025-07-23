Return-Path: <linux-rdma+bounces-12412-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D780B0EB7A
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 09:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07C727AC087
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 07:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B96D271460;
	Wed, 23 Jul 2025 07:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+MiU0gQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82C52343C2;
	Wed, 23 Jul 2025 07:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753254655; cv=none; b=gqQbjtq29XGC7YEqvWNb285sjKF819bYMV576KT4Vxid69d19+ZzprXgEziwE2QRs2s24GumLkhpep0ysWcQxyea2/TgfvsN8wb0T4+VtvVbezGAToxUT8qKKEMUZHbghjuVQKcHGZKYreD0+xlCtQIxqMtnxZ+7F+uBnlNLJ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753254655; c=relaxed/simple;
	bh=LtZZ+pL+54XbUsH86XC7eT0lo0x6zk/Anu05ecDY0V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DB/aiO7+0mDMX9XTXQeuoOYF9w8Ti5efJNH7cjfdo6zKAwazGvhDTbKnawwGPQhPB+NwnGjmblDiBodZL2ThLke3gcm1CrJNUlH7aLQfbQsJ9TWB+B0L+5xYOgl70/IhWnyXTQlLYSBXKp0zilnHy5dcYokYpsZy0WrCMQkRwbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+MiU0gQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8DFC4CEF4;
	Wed, 23 Jul 2025 07:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753254655;
	bh=LtZZ+pL+54XbUsH86XC7eT0lo0x6zk/Anu05ecDY0V8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+MiU0gQ0/C509a3tjri8tl+mscBPdQ/71d1BZ4kYkBzNhWxst+H5d0YZ9nfMAJVt
	 IUQ2zc6HBJ/IlzX1EFNAbXGFuUUohrB2DUSKsHq6UvxtdT3iwunutM4iG3vg2hM04y
	 8mMf9sOgVF1Iyjz5ms6eDvYm40y/8xLGcwpwvDvYalOMLROBcNYJmCcxOqoTEXOWu6
	 sW1Zol1xaJ215LJC8zNABZCauwgV+Xll/Aq3bwwDRCbhvABiPPWqtkCyIw3wh/NkOo
	 DfE+ntOlrLYb8vQmOwVVRS9Hk82QqhzY3+yofLwIeYEMbvi50HNK5LXsLk0Uf2z/9T
	 EzlaB+L5c7otw==
Date: Wed, 23 Jul 2025 10:10:50 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Cassen <acassen@corp.free.fr>
Subject: Re: [PATCH net-next V2 1/2] net/mlx5e: Support routed networks
 during IPsec MACs initialization
Message-ID: <20250723071050.GL402218@unreal>
References: <1753194228-333722-1-git-send-email-tariqt@nvidia.com>
 <1753194228-333722-2-git-send-email-tariqt@nvidia.com>
 <aICGmVC06H+WTy6s@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aICGmVC06H+WTy6s@mev-dev.igk.intel.com>

On Wed, Jul 23, 2025 at 08:52:09AM +0200, Michal Swiatkowski wrote:
> On Tue, Jul 22, 2025 at 05:23:47PM +0300, Tariq Toukan wrote:
> > From: Alexandre Cassen <acassen@corp.free.fr>
> > 
> > Remote IPsec tunnel endpoint may refer to a network segment that is
> > not directly connected to the host. In such a case, IPsec tunnel
> > endpoints are connected to a router and reachable via a routing path.
> > In IPsec packet offload mode, HW is initialized with the MAC address
> > of both IPsec tunnel endpoints.
> > 
> > Extend the current IPsec init MACs procedure to resolve nexthop for
> > routed networks. Direct neighbour lookup and probe is still used
> > for directly connected networks and as a fallback mechanism if fib
> > lookup fails.
> > 
> > Signed-off-by: Alexandre Cassen <acassen@corp.free.fr>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> > Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> > ---
> >  .../mellanox/mlx5/core/en_accel/ipsec.c       | 82 ++++++++++++++++++-
> >  1 file changed, 80 insertions(+), 2 deletions(-)

<...>

> > @@ -274,18 +281,89 @@ static void mlx5e_ipsec_init_macs(struct mlx5e_ipsec_sa_entry *sa_entry,
> >  	case XFRM_DEV_OFFLOAD_IN:
> >  		src = attrs->dmac;
> >  		dst = attrs->smac;
> > -		pkey = &attrs->addrs.saddr.a4;
> > +
> > +		switch (addrs->family) {
> > +		case AF_INET:
> > +			fl4.flowi4_proto = x->sel.proto;
> > +			fl4.daddr = addrs->saddr.a4;
> > +			fl4.saddr = addrs->daddr.a4;
> > +			pkey = &addrs->saddr.a4;
> > +			break;
> > +		case AF_INET6:
> > +			fl6.flowi6_proto = x->sel.proto;
> > +			memcpy(fl6.daddr.s6_addr32, addrs->saddr.a6, 16);
> > +			memcpy(fl6.saddr.s6_addr32, addrs->daddr.a6, 16);
> > +			pkey = &addrs->saddr.a6;
> > +			break;
> > +		default:
> > +			return;
> > +		}
> >  		break;
> >  	case XFRM_DEV_OFFLOAD_OUT:
> >  		src = attrs->smac;
> >  		dst = attrs->dmac;
> > -		pkey = &attrs->addrs.daddr.a4;
> 
> Isn't it worth to move getting pkey to separate function? The switch is
> the same with OFFLOAD_IN and OFFLOAD_OUT.

The content of the switch is completely opposite, as an example for pkey:
In OFFLOAD_IN:
pkey = &addrs->...S...addr.a4;
pkey = &addrs->...S...addr.a6;

In OFFLOAD_OUT:
pkey = &addrs->...D...addr.a4;
pkey = &addrs->...D...addr.a6;

There is only one line which is common: "... = x->sel.proto;"

> 
> > +		switch (addrs->family) {
> > +		case AF_INET:
> > +			fl4.flowi4_proto = x->sel.proto;
> > +			fl4.daddr = addrs->daddr.a4;
> > +			fl4.saddr = addrs->saddr.a4;
> > +			pkey = &addrs->daddr.a4;
> > +			break;
> > +		case AF_INET6:
> > +			fl6.flowi6_proto = x->sel.proto;
> > +			memcpy(fl6.daddr.s6_addr32, addrs->daddr.a6, 16);
> > +			memcpy(fl6.saddr.s6_addr32, addrs->saddr.a6, 16);
> > +			pkey = &addrs->daddr.a6;
> > +			break;
> > +		default:
> > +			return;

<...>

> >  	n = neigh_lookup(&arp_tbl, pkey, netdev);
> >  	if (!n) {
> >  		n = neigh_create(&arp_tbl, pkey, netdev);
> 
> Code looks fine,
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Thanks

> 
> > -- 
> > 2.31.1
> 

