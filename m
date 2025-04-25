Return-Path: <linux-rdma+bounces-9811-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56369A9CF35
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 19:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063E71BC0A54
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 17:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14CA1FBC8B;
	Fri, 25 Apr 2025 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G408ymw+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703261DE3C1;
	Fri, 25 Apr 2025 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745601011; cv=none; b=gn/Mh9lG3K1Z/7U8n6Tkou13VkQ/o7xG9KjqQR8gjkUEXs8efsL/pKwC2rYedwxNdlUgtsX+mbPZ8a+5fNLH1snkGvJ5PsyEA1Tz58LUw1FrFv6yoU1HtRhx+pVfFb6pV1fUtxPLA3ZjaalBrI9O0G/xmqLxbAbT/y8hAsov2kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745601011; c=relaxed/simple;
	bh=1KoatvE0hByfcBrnabFxpn1aAGj+++zSJC5A4aEOP4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6FZWA0pmXOSsc5SLncmp2UJ1ztHabYI/YUzXLxwHijnlVQIYOM9/MDxF2YWliHbeCjPnQb7p3a5NPtUwb7dwUsiboQe3sYint6+BAAnOEUzBeWrzyup1GW4FfL6IvQMNjJw6JjvkCzgA9S7375Oe/d6ctYvieay05ZrT1fXARY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G408ymw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EECC4CEE9;
	Fri, 25 Apr 2025 17:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745601010;
	bh=1KoatvE0hByfcBrnabFxpn1aAGj+++zSJC5A4aEOP4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G408ymw+1A6ygIAhqq0ANRt0QQdndUzkrTkWGh9z4OcXr3JDJIfW94zKoyVtYymMC
	 nPWGUdx63vOxas4vRuG08v4sNHHoE2jZc58diAzTLNXFyH3P4R+SPuAOZ2o/fju5ci
	 6fM3+mh0Kpv36Bx8CLLy0e/IDk5RlCaVb2FdzxCot5ZG2gYQYVb9VJ7HxCUrd1Q1oS
	 mTliLyiTO+2v+dPKMG0/sTEG0XZt/K2JQSxFsojhyvphoPc+BZIQkpjOm16hzAWbMZ
	 SBoGyYNjDL5g+bKIdmEuIVFkySwYrPhT3hk+madwwDXCKmh96685J8Z02evw8lnuGE
	 QWKY3pDHwaH/A==
Date: Fri, 25 Apr 2025 20:10:05 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, shannon.nelson@amd.com,
	brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	andrew+netdev@lunn.ch, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Boyer <andrew.boyer@amd.com>
Subject: Re: [PATCH 08/14] RDMA/ionic: Register auxiliary module for ionic
 ethernet adapter
Message-ID: <20250425171005.GU48485@unreal>
References: <20250423102913.438027-1-abhijit.gangurde@amd.com>
 <20250423102913.438027-9-abhijit.gangurde@amd.com>
 <20250424130813.GZ1213339@ziepe.ca>
 <ab361812-566e-5454-ab2c-40757a8808da@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab361812-566e-5454-ab2c-40757a8808da@amd.com>

On Fri, Apr 25, 2025 at 03:46:06PM +0530, Abhijit Gangurde wrote:
> On 4/24/25 18:38, Jason Gunthorpe wrote:
> > On Wed, Apr 23, 2025 at 03:59:07PM +0530, Abhijit Gangurde wrote:
> > > +static int ionic_aux_probe(struct auxiliary_device *adev,
> > > +			   const struct auxiliary_device_id *id)
> > > +{
> > > +	struct ionic_aux_dev *ionic_adev;
> > > +	struct net_device *ndev;
> > > +	struct ionic_ibdev *dev;
> > > +
> > > +	ionic_adev = container_of(adev, struct ionic_aux_dev, adev);
> > > +	ndev = ionic_api_get_netdev_from_handle(ionic_adev->handle);
> > It must not do this, the net_device should not go into the IB driver,
> > like this that will create a huge complex tangled mess.
> > 
> > The netdev(s) come in indirectly through the gid table and through the
> > net notifiers and ib_device_set_netdev() and they should only be
> > touched in paths dealing with specific areas.
> > 
> > So don't use things like netdev_err, we have ib_err/dev_err and
> > related instead for IB drivers to use.
> 
> Sure. Will remove storing of net_device in the IB driver and its
> references in the next spin. Will wait for some more feedback
> before rolling out v2.

The problem is that coupling with net_device is so distracting that
both of us are not really invested time into deep review of this series.

Another problematic pattern is usage of "void *handle" to convey
information between aux devices. Please use struct pointer instead of
void for that.

Thanks

> 
> Thanks,
> Abhijit
> 
> > 
> > > +struct ionic_ibdev {
> > > +	struct ib_device	ibdev;
> > > +
> > > +	struct device		*hwdev;
> > > +	struct net_device	*ndev;
> > Same here, this member should not exist, and it didn't hold a
> > refcount for this pointer.
> > 
> > Jason

