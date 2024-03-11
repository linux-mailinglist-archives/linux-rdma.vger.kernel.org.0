Return-Path: <linux-rdma+bounces-1393-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78560878739
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 19:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3FB1F21CC1
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 18:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5615153E11;
	Mon, 11 Mar 2024 18:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXYPrR+W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1132D537FB;
	Mon, 11 Mar 2024 18:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710181534; cv=none; b=a+Xp9yYmFKMIYiixn1U8FkdWSDzkwtbsRgF8XNWPOcva3MXqUu+lare/469QptzhFHVYgz+u3xa69ZUtX7i+a3wDJPBr78C8ZW9j4Ur/jFyF6q5rLod3+SHiTYEXY9PwYntVKWWLo4yDlhoskswHR1k6Kl725MdHclFw+7T4zoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710181534; c=relaxed/simple;
	bh=r3BDLwL9q69U152caiaU1puZXaBqIjvI7xhy1YrI7fw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iz2is98VFjkbZQyMkFh1w34LG6ZC4BsJlqf1+7C9BpENQKqKoUU2ocXkocTzPwwuR5C2+mqNghlpLnvQNzhTkTAIP3Rb26Xfwht+dgbLap1zDp7oHJ9Zbl0yAbrr0d3Fm5ovpBgtVS8fjfYzNzThHWxHj8+PStApS3CY4+FT5PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXYPrR+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F4AC433C7;
	Mon, 11 Mar 2024 18:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710181533;
	bh=r3BDLwL9q69U152caiaU1puZXaBqIjvI7xhy1YrI7fw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MXYPrR+WUmb6e4dbDkvedPj73lMETfPnb3253qEzLmDERUURMB4/oHR77z/0XIgdK
	 VsloJXnCmZVVl4bNUyQU+ccqGJASsJup/AktQhzm4S11SWqj92sNDBTIm+YA0dwJ4f
	 1fIN3y86KzreS0CRO17Z24eZqqA7pHhtQqfeRcVAEGxf8ibQJrDp8fTdiopXPDmu1w
	 uaSkZnkUaZgw+qBLuQvgNuOgHPIWPPI9y8nMW832hNuLzWESo4NY6zTXtiESRTcsEh
	 1OSh7GGqpqqkZMKHsxZBdlPicMdQrlV8xLa52bsDCLjPW28wvbxUbYs0mKZw8YzKCY
	 PyMOHWmKt4W5Q==
Date: Mon, 11 Mar 2024 11:25:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Dennis Dalessandro
 <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 keescook@chromium.org, "open list:HFI1 DRIVER"
 <linux-rdma@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] IB/hfi1: allocate dummy net_device dynamically
Message-ID: <20240311112532.71f1cb35@kernel.org>
In-Reply-To: <20240311102251.GJ12921@unreal>
References: <20240308182951.2137779-1-leitao@debian.org>
	<20240310101451.GD12921@unreal>
	<Ze7YNu5TrzClQcxy@gmail.com>
	<20240311102251.GJ12921@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Mar 2024 12:22:51 +0200 Leon Romanovsky wrote:
> > From my experience, you can leverage all the helpers to deal with the
> > relationship between struct net_device and you private structure. Here
> > are some examples that comes to my mind:
> > 
> > * alloc_netdev() allocates the private structure for you
> > * netdev_priv() gets the private structure for you
> > * dev->priv_destructor sets the destructure to be called when the
> >   interface goes away or failures.  
> 
> Everything above is true, but it doesn't relevant to HFI1 devices which
> are not netdev devices.

Why are they abusing struct net_device then?
If you're willing to take care of removing the use of NAPI from this
driver completely, that'd be great.

> > > Will it create multiple "dummy" netdev in the system? Will all devices
> > > have the same "dummy" name?  
> > 
> > Are these devices visible to userspace?  
> 
> HFI devices yes, dummy device no.
> 
> > 
> > This allocation are using NET_NAME_UNKNOWN, which implies that the
> > device is not expose to userspace.  
> 
> Great
> 
> > 
> > Would you prefer a different name?  
> 
> I prefer to see some new wrapper over plain alloc_netdev, which will
> create this dummy netdevice. For example, alloc_dummy_netdev(...).

Nope, no bona fide APIs for hacky uses.

