Return-Path: <linux-rdma+bounces-1380-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819D4877E0A
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 11:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1C261C21017
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 10:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634A824A11;
	Mon, 11 Mar 2024 10:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+BU3siB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C0A37160;
	Mon, 11 Mar 2024 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710152577; cv=none; b=n1SauKi212uR4xjjlJr5sKrK9C3703MYOjc4OlIhzFDlWWEyWLwCS8k15q5aM+HwIqABlLrGfhNl7uidGPFkisJtu5vxPTA20LhUG7HdSCF6f92bBVY2Ascc2BFNXzuMEir4PFGdok/EcfhfxTrTs6T7X7iiJZI9pKVTEOxUkHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710152577; c=relaxed/simple;
	bh=9cIM+nRjrHPDMX7yHdDPez80yWHfuQAfiv1f2p4e9wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6d6DcJgJQ+FZtWttozdM3EZey0X4L7IdjqUqaJ/EjefK+4FeV7l7fxPdUHhhEPjAme2mC6Zwx4dL/XB8LEsYuc9UnrCdYBlqLCeu/dHesIX4rRkOlDaHURtPOJITlRbtoIg/IUj+ccZ4M6BByXFHgX4cHQo2M/Se331XkEubxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+BU3siB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC41C433F1;
	Mon, 11 Mar 2024 10:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710152576;
	bh=9cIM+nRjrHPDMX7yHdDPez80yWHfuQAfiv1f2p4e9wA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g+BU3siB4Cw2C9qL4QK/PI7tjlvioV2cf+LXmVB4hBgkyC4r771XFllURI1B3o/qS
	 Q6EEYUqYWz79GIrTU4drGCJKmJgzhnIIzsdVaOHgEs8ZvzFvxTeYqeoaZsgLWgnIbI
	 5INghdys41B6skIDaY5DqtYT5sLvoOV/ZldKCPJrNsmpIbPgtfbttrfi8h8eqeUPGO
	 3lpc2wJvcDSneSNCE/OyhYUwtJgiLE4C6WwWJqgFixj0f93w6l8kIw3lRxGbTjI84F
	 ABcnLLgwTB11N5HoZZRxKnZlDEROxjngtWaZ7VTjzWkC3cHpYZNIsYSTTVUGKUjJEd
	 l9ZEHjf2LEcDg==
Date: Mon, 11 Mar 2024 12:22:51 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, kuba@kernel.org,
	keescook@chromium.org,
	"open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] IB/hfi1: allocate dummy net_device dynamically
Message-ID: <20240311102251.GJ12921@unreal>
References: <20240308182951.2137779-1-leitao@debian.org>
 <20240310101451.GD12921@unreal>
 <Ze7YNu5TrzClQcxy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze7YNu5TrzClQcxy@gmail.com>

On Mon, Mar 11, 2024 at 03:08:54AM -0700, Breno Leitao wrote:
> Hello Leon,
> 
> On Sun, Mar 10, 2024 at 12:14:51PM +0200, Leon Romanovsky wrote:
> > On Fri, Mar 08, 2024 at 10:29:50AM -0800, Breno Leitao wrote:
> > > struct net_device shouldn't be embedded into any structure, instead,
> > > the owner should use the priv space to embed their state into net_device.
> > 
> > Why?
> 
> From my experience, you can leverage all the helpers to deal with the
> relationship between struct net_device and you private structure. Here
> are some examples that comes to my mind:
> 
> * alloc_netdev() allocates the private structure for you
> * netdev_priv() gets the private structure for you
> * dev->priv_destructor sets the destructure to be called when the
>   interface goes away or failures.

Everything above is true, but it doesn't relevant to HFI1 devices which
are not netdev devices.

> 
> > > @@ -360,7 +360,11 @@ int hfi1_alloc_rx(struct hfi1_devdata *dd)
> > >  	if (!rx)
> > >  		return -ENOMEM;
> > >  	rx->dd = dd;
> > > -	init_dummy_netdev(&rx->rx_napi);
> > > +	rx->rx_napi = alloc_netdev(sizeof(struct iwl_trans_pcie *),
> > > +				   "dummy", NET_NAME_UNKNOWN,
> > 
> > Will it create multiple "dummy" netdev in the system? Will all devices
> > have the same "dummy" name?
> 
> Are these devices visible to userspace?

HFI devices yes, dummy device no.

> 
> This allocation are using NET_NAME_UNKNOWN, which implies that the
> device is not expose to userspace.

Great

> 
> Would you prefer a different name?

I prefer to see some new wrapper over plain alloc_netdev, which will
create this dummy netdevice. For example, alloc_dummy_netdev(...).

> 
> > > +				   init_dummy_netdev); +	if
> > > (!rx->rx_napi) +		return -ENOMEM;
> > 
> > You forgot to release previously allocated "rx" here.
> 
> Good catch, I will update.

Thanks

> 
> Thanks

