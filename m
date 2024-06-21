Return-Path: <linux-rdma+bounces-3404-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C56912D09
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 20:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA3F1C23C7B
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 18:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0964417A92C;
	Fri, 21 Jun 2024 18:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqLbLQlE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6401791EF
	for <linux-rdma@vger.kernel.org>; Fri, 21 Jun 2024 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718993438; cv=none; b=nuISAPq8WeCbULPXg/ckptiemG7ksHVvGghRfugOu3h0RIdlDnN+e6qRLd3xOXB4De/psASEyixE9sl0LnDvPPQJdcLZNDyMzRL/PuRxqYERjo7NCr05nG/XXwT+ywjl8i2T2BpWWC0GWQdkawOXycma/ebZ/2YVxX+1b9NSIT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718993438; c=relaxed/simple;
	bh=nCDw3VCPlDZb73outaExKiKzWTg09HZdfE0kCS+pf8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVK9ZBmy8c/WCEHIzdxiDPKrzWgXJ28rtBrCWHj8o9KQdiFqg+nwOeq+U20/4yZP/ALkWw9uBWp6ylIeAYxzDtmHbm8hyWPDrnvYHDkoAsvjSEUUVshRatRHnU4imUeu3oYS0yQoouPrHIDR4OBkR3clcku4X8UH8Yy8lqQx7cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqLbLQlE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB8AC2BBFC;
	Fri, 21 Jun 2024 18:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718993438;
	bh=nCDw3VCPlDZb73outaExKiKzWTg09HZdfE0kCS+pf8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nqLbLQlEWiIXrVNlZkJ8GhxZfxw14M/tcSHztVygt4WqyJcgZz0iPge9tqnNeoeJT
	 qDsPxMN42pjl+R9X8RMGV6AkeUtNPIq2IflAd4cx2MoMbumIKk3dietgRq7qrR/n7f
	 KkMP2neS7+HirfZOz79RQwDz5pUu4zR4CXZv023Oaxrx45rcJ1q4IxGEj5rH4F7n1w
	 AEnIiOywT3cOigNePOv1UHSWmgFjpz3hfR2/jcjdJVhpL1D+c5vVntMSjhAGrK4m7N
	 FdIdkZSYNZOg5rKWBzzMYKU3smFQ9jw4vEYaRlkMElsS1iTh9FUiAA7irezVtnTpgd
	 W7iNh+aq8zFzQ==
Date: Fri, 21 Jun 2024 21:10:33 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: Open-coded get_netdev implementation in MANA IB
Message-ID: <20240621181033.GQ4025@unreal>
References: <20240617115622.GC6805@unreal>
 <PAXPR83MB05592C30E6FEAE52F8B53E32B4CD2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240617123824.GD6805@unreal>
 <PAXPR83MB05590EC3282ADD96AFFB149CB4CF2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR83MB05590EC3282ADD96AFFB149CB4CF2@PAXPR83MB0559.EURPRD83.prod.outlook.com>

On Wed, Jun 19, 2024 at 02:14:15PM +0000, Konstantin Taranov wrote:
> > Yes, the thing is that probably we were supposed to move to
> > ib_device_get_netdev() and don't invest time in mana_ib_get_netdev()
> > helper at all.
> > 
> > > I sure can fix it and use ib_device_get_netdev api.
> > >
> > > Should I send it to the rdma-next on the top of the latest commit?
> > 
> > Yes, please.
> > 
> 
> Hi Leon,
> 
> While preparing the patch, I realized that ib_device_get_netdev is not public
> and it is defined in core_priv.h. Should I move the declaration and export the symbol?

Let's keep it as is for now. I will try to return to this task after we
find a way to remove .get_netdev() callback from the drivers.

Sorry for wasting your time.

Thanks

> 
> Thanks

