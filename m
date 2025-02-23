Return-Path: <linux-rdma+bounces-8017-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86145A40D7D
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Feb 2025 09:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1BC53B011C
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Feb 2025 08:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31BA1FCFE6;
	Sun, 23 Feb 2025 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuXAqNLE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27351FC7CE
	for <linux-rdma@vger.kernel.org>; Sun, 23 Feb 2025 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740300750; cv=none; b=XxBiz/d2tcamtNeCAeToZpRnqGOqn0czbdTBymigSVIUsWSUfieSDerSFkjpqNDBPVT0tKklEeHWavGzxVR93+gFbnMzjkEHjKBr1WYBMbD7cXLE55S0mnMw3Pk1fqgzDMON36jpAsLoPgqNGMvu0xr7jERwrPkYpp10ypX0rVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740300750; c=relaxed/simple;
	bh=nhr/V753Y65F9KXsThidgP+38E49+1et8qJYFfalYcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLe4wL6I5Rx/0L0gdV3KXsYmFQLPX11JmdFAvivE4WB026qMHSjUHi1o3A5g8AuOwRQM/PWpkYiqZhETZmNHqpfUSo3uFaMwD7jWSOksDqbA+gfo/F3yAhkgCUBMh8pXC9u7yaiXxwmjRTR424lFpmgAETr+IvxPgo+eeVBy1Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuXAqNLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F5CC4CEDD;
	Sun, 23 Feb 2025 08:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740300750;
	bh=nhr/V753Y65F9KXsThidgP+38E49+1et8qJYFfalYcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HuXAqNLEPaMKaecK4PSyjlXXNi5ufHuOX5GKc631Jjl69fDfaoBJFL4l0NEMf1gaS
	 4CpxtOvC9i8e3nxRNHTHH3YPlrQcAr82Ek+/8RFCTKGv8ABD17ma2sq/rhUDbaBuDC
	 JluHj7LhMPiYeIdWwKWlVWU+mJYfHJ0oPadz/LssdM57aAEA6BOK3bq6UFOz4+VeOF
	 4wAmH2C0HJ5VaaLO7f/vq2ZGP4DTeN9L3qctjuSVvtS9td67R4ONHD9iGU9vVrx1RP
	 /m1IUAPAg3CyBbXrXeKBUPLamrSrWTaOPmP0XQd/bY5sAtwE/Szlb7G1K2iwcvEUb7
	 ILDKTcgHtXv6g==
Date: Sun, 23 Feb 2025 10:52:26 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Maher Sanalla <msanalla@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/uverbs: Propagate errors from
 rdma_lookup_get_uobject()
Message-ID: <20250223085226.GW53094@unreal>
References: <520b83c80829714cebc3c99b8ea370a039f6144c.1739973096.git.leon@kernel.org>
 <20250219144616.GO4183890@nvidia.com>
 <20250219155647.GI53094@unreal>
 <20250219175335.GA28076@nvidia.com>
 <20250220065938.GJ53094@unreal>
 <20250220090652.GN53094@unreal>
 <20250220135352.GA50639@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220135352.GA50639@nvidia.com>

On Thu, Feb 20, 2025 at 09:53:52AM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 20, 2025 at 11:06:52AM +0200, Leon Romanovsky wrote:
> > > Mainly -EBUSY from FW command interface, so users can safely call again
> > > to modify QP.
> > 
> > Forget about this comment, I was distracted, and it is -EBUSY from
> > uverbs_try_lock_object() and not from FW command interface.
> 
> Userspace is doing something really wrong if it is triggering that..

And right now, userspace isn't aware of it. Users will be aware of it, after
we will return real error code and not mask everything under same -EINVAL.

Thanks

> 
> Jason

