Return-Path: <linux-rdma+bounces-13249-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AF1B516BF
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 14:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0694E706D
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 12:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B71319867;
	Wed, 10 Sep 2025 12:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQcAg+h/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF483176E4;
	Wed, 10 Sep 2025 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757506917; cv=none; b=spWdaRxcu/nlSOfKiyflNcABXuNcbUPBSHB0SUfcl7REPnjuQcbLJP5S9iPb8Eoul79Tk95h7EV1s4lVEJr4MiS95s54VwCMgrABIGAv46KEoAAQVR/OL6oCDlVPC+4vbNuzYXeSIsP+aypnpBG6NELv+f3mSoz7CJNTJ6+F3Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757506917; c=relaxed/simple;
	bh=n59irqxSGsvzQvA5L9wGZ9uWkKm4Jb4znbdYPJEyXKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSo5LggscAwF5VSJRz6mDKQEA4KgWBGyr+w1iCleFTU8CaIQlx6D+ebGOoyz71mkap8iUIBqmQhddUPdCSYWRC3gohdqbjxvOIqjYuIB9t44o3il5iUiBSmhc9XmWLbZie/WZG4u2H9EPn/ND31p0T3aNYA7J6g+kyMkkXmWc9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQcAg+h/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EB7C4CEF8;
	Wed, 10 Sep 2025 12:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757506917;
	bh=n59irqxSGsvzQvA5L9wGZ9uWkKm4Jb4znbdYPJEyXKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dQcAg+h/2Gfs+wLHKFVvg0SWlt8YJAfpvxGyAQkG9+5/BknT8zL4rmyjK5jRos3h4
	 8NFQ0wUBzAUVdyCAgkipHI0sUH3SkU4ZQ2ATtAi2ql1NbiA6XDl/kHbbtz8GAZ00el
	 etzWUEDNpRrBc3vSZJELBNOt9KMSWR1QT/gK8Xv2uwAKKzADiFfjtDy65VE0xZKqKI
	 Tiru6o069i48LHUH1SMJVwfktFeBipssaJo8Za+9H41XoCFVUtJMKbq6B/vd3fyw9e
	 gu3v+EiVPtysCUPw12y+1QMiIE5D2piqJkH9Yw8ri9MmX5sF6IEuJDCeNrgImpWg0F
	 AAlcswf4fJm2w==
Date: Wed, 10 Sep 2025 15:21:52 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Parav Pandit <parav@nvidia.com>
Cc: Edward Srouji <edwards@nvidia.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH 1/4] RDMA/core: Squash a single user static function
Message-ID: <20250910122152.GR341237@unreal>
References: <20250907160833.56589-1-edwards@nvidia.com>
 <20250907160833.56589-2-edwards@nvidia.com>
 <20250910081735.GJ341237@unreal>
 <CY8PR12MB719561454E13288C929E5E70DC0EA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB719561454E13288C929E5E70DC0EA@CY8PR12MB7195.namprd12.prod.outlook.com>

On Wed, Sep 10, 2025 at 10:51:08AM +0000, Parav Pandit wrote:
> 
> 
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: 10 September 2025 01:48 PM
> > 
> > On Sun, Sep 07, 2025 at 07:08:30PM +0300, Edward Srouji wrote:
> > > From: Parav Pandit <parav@nvidia.com>
> > >
> > > In order to reduce dependencies in IFF_LOOPBACK in route and neighbour
> > > resolution steps, squash the static function to its single caller and
> > > simplify the code. No functional change.
> > 
> > It needs more explanation why it is true. 
> After second look at the code, it is not true.
> It is not true for the case when dev->flags has IFF_LOOPBACK and translate_ip() failed.
> In existing code, when translate_ip() fails, code still sets dev_addr->network.
> dev_addr->network is not referred if the process_one_req() has error.
> 
> > Before this change, we set dev_addr-
> > >network to some value and returned error.
> > That error propagated upto process_one_req(), which handles only some
> > errors and ignores rest.
> > 
> > So now, we continue to handle REQ without proper req->addr->network.
> >
> Not exactly. When error is returned by the code addr->network is not filled up, which is correct thing to do.
> 
> So at best, commit message should be updated to remove "No functional change".
> 
> Will send v1.

Parav,

Please setup your e-mail client, your reply is mixed with mine and
repeats it.

Thanks

>  
> > Thanks
> > 
> > >
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > Reviewed-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
> > > Signed-off-by: Edward Srouji <edwards@nvidia.com>
> > > ---
> > >  drivers/infiniband/core/addr.c | 49
> > > ++++++++++++++--------------------
> > >  1 file changed, 20 insertions(+), 29 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/core/addr.c
> > > b/drivers/infiniband/core/addr.c index be0743dac3ff..594e7ee335f7
> > > 100644
> > > --- a/drivers/infiniband/core/addr.c
> > > +++ b/drivers/infiniband/core/addr.c
> > > @@ -465,34 +465,6 @@ static int addr_resolve_neigh(const struct dst_entry
> > *dst,
> > >  	return ret;
> > >  }
> > >
> > > -static int copy_src_l2_addr(struct rdma_dev_addr *dev_addr,
> > > -			    const struct sockaddr *dst_in,
> > > -			    const struct dst_entry *dst,
> > > -			    const struct net_device *ndev)
> > > -{
> > > -	int ret = 0;
> > > -
> > > -	if (dst->dev->flags & IFF_LOOPBACK)
> > > -		ret = rdma_translate_ip(dst_in, dev_addr);
> > > -	else
> > > -		rdma_copy_src_l2_addr(dev_addr, dst->dev);
> > > -
> > > -	/*
> > > -	 * If there's a gateway and type of device not ARPHRD_INFINIBAND,
> > > -	 * we're definitely in RoCE v2 (as RoCE v1 isn't routable) set the
> > > -	 * network type accordingly.
> > > -	 */
> > > -	if (has_gateway(dst, dst_in->sa_family) &&
> > > -	    ndev->type != ARPHRD_INFINIBAND)
> > > -		dev_addr->network = dst_in->sa_family == AF_INET ?
> > > -						RDMA_NETWORK_IPV4 :
> > > -						RDMA_NETWORK_IPV6;
> > > -	else
> > > -		dev_addr->network = RDMA_NETWORK_IB;
> > > -
> > > -	return ret;
> > > -}
> > > -
> > >  static int rdma_set_src_addr_rcu(struct rdma_dev_addr *dev_addr,
> > >  				 unsigned int *ndev_flags,
> > >  				 const struct sockaddr *dst_in,
> > > @@ -503,6 +475,7 @@ static int rdma_set_src_addr_rcu(struct
> > rdma_dev_addr *dev_addr,
> > >  	*ndev_flags = ndev->flags;
> > >  	/* A physical device must be the RDMA device to use */
> > >  	if (ndev->flags & IFF_LOOPBACK) {
> > > +		int ret;
> > >  		/*
> > >  		 * RDMA (IB/RoCE, iWarp) doesn't run on lo interface or
> > >  		 * loopback IP address. So if route is resolved to loopback
> > @@
> > > -512,9 +485,27 @@ static int rdma_set_src_addr_rcu(struct rdma_dev_addr
> > *dev_addr,
> > >  		ndev = rdma_find_ndev_for_src_ip_rcu(dev_net(ndev),
> > dst_in);
> > >  		if (IS_ERR(ndev))
> > >  			return -ENODEV;
> > > +		ret = rdma_translate_ip(dst_in, dev_addr);
> > > +		if (ret)
> > > +			return ret;
> > > +	} else {
> > > +		rdma_copy_src_l2_addr(dev_addr, dst->dev);
> > >  	}
> > >
> > > -	return copy_src_l2_addr(dev_addr, dst_in, dst, ndev);
> > > +	/*
> > > +	 * If there's a gateway and type of device not ARPHRD_INFINIBAND,
> > > +	 * we're definitely in RoCE v2 (as RoCE v1 isn't routable) set the
> > > +	 * network type accordingly.
> > > +	 */
> > > +	if (has_gateway(dst, dst_in->sa_family) &&
> > > +	    ndev->type != ARPHRD_INFINIBAND)
> > > +		dev_addr->network = dst_in->sa_family == AF_INET ?
> > > +						RDMA_NETWORK_IPV4 :
> > > +						RDMA_NETWORK_IPV6;
> > > +	else
> > > +		dev_addr->network = RDMA_NETWORK_IB;
> > > +
> > > +	return 0;
> > >  }
> > >
> > >  static int set_addr_netns_by_gid_rcu(struct rdma_dev_addr *addr)
> > > --
> > > 2.21.3
> > >
> > >

