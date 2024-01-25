Return-Path: <linux-rdma+bounces-760-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBF583CD12
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 21:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380C5299999
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 20:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D5D135A79;
	Thu, 25 Jan 2024 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNACCMrn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBB3135A7C
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jan 2024 20:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212954; cv=none; b=r0NMaMh6C7V6FQwaGwqv+H5sf5/NIAuSwBrcUcvkRSUsS6Zma1WPdm/7+PMUZ5HW490bHaufMiOZ8zd3mn55nNOTFKvUm3SjAO+Zso/H43BLcbaXMYOIC0JKqaA7mHsXZIv45ScB2uyGs5UzD71aw85nDy5nWHhGDyPWNqE/9/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212954; c=relaxed/simple;
	bh=vhFiDD3WQe+zInsGgloH9BGYu6cFAdJDRE3OMGCMsHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plhPbSvCJ3QHHWqaqAb8tVOUZ6L+mfa/r3YQ6P0IDPXbfvKOkiib/5amlbcixbtHHj/Tz7WRcfxqs5JQZfMA87xTfzOy1cCRo1CP7dbsLMpvcUp+olBDteDLuQWIbSzTHmwzEr7eYA9kXp18eh4lbJx0jC35Nfjp7+7NnEVsY/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNACCMrn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E00CC433C7;
	Thu, 25 Jan 2024 20:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706212954;
	bh=vhFiDD3WQe+zInsGgloH9BGYu6cFAdJDRE3OMGCMsHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PNACCMrnkIUtYI/R/Dk9b5WkcW9MDncDrkuA5YdE5EkMfkzhi9CDEaU1F6m5fBltp
	 cpgS7GtBn0rglbI0JGBYQcQ572Nt85mSIVpWBDACwQ2xbaYveQI6LwhwwMULENvoQU
	 +BnLeJkTOwwyM/D/iG8M25ZixQftDkvHs8w7A+ZAhloNHYMnCLebDvKJxIcU+ouGtw
	 6am9Mnt/ZNXvVXI39s6TeGwmOFpSKHxspsJM0LLPPFObwdS0LwaTnQ/3ag6G0bHVQk
	 Bx6cv8dr6aQ1EXcmnp1ZZ64eh3NLzUDoqetxo9pZ7UgXD9tqJKjUwwGe28wUlIo3EN
	 wa/QgzmcuSdeg==
Date: Thu, 25 Jan 2024 22:02:30 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Junxian Huang <huangjunxian6@hisilicon.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org,
	Maor Gottlieb <maorg@nvidia.com>, Mark Zhang <markzhang@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Tamar Mashiah <tmashiah@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 5/6] RDMA/mlx5: Change check for cacheable user
 mkeys
Message-ID: <20240125200230.GD9841@unreal>
References: <cover.1706185318.git.leon@kernel.org>
 <4641d8f79a88b07925cab0d8cd1ffc032a9115ef.1706185318.git.leon@kernel.org>
 <36037101-dd46-d956-4555-d02eeb04dd0b@hisilicon.com>
 <20240125133824.GM1455070@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125133824.GM1455070@nvidia.com>

On Thu, Jan 25, 2024 at 09:38:24AM -0400, Jason Gunthorpe wrote:
> On Thu, Jan 25, 2024 at 08:52:57PM +0800, Junxian Huang wrote:
> > 
> > 
> > On 2024/1/25 20:30, Leon Romanovsky wrote:
> > > From: Or Har-Toov <ohartoov@nvidia.com>
> > > 
> > > In the dereg flow, UMEM is not a good enough indication whether an MR
> > > is from userspace since in mlx5_ib_rereg_user_mr there are some cases
> > > when a new MR is created and the UMEM of the old MR is set to NULL.
> > > Currently when mlx5_ib_dereg_mr is called on the old MR, UMEM is NULL
> > > but cache_ent can be different than NULL. So, the mkey will not be
> > > destroyed.
> > > Therefore checking if mkey is from user application and cacheable
> > > should be done by checking if rb_key or cache_ent exist and all other kind of
> > > mkeys should be destroyed.
> > > 
> > > Fixes: dd1b913fb0d0 ("RDMA/mlx5: Cache all user cacheable mkeys on dereg MR flow")
> > > Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > >  drivers/infiniband/hw/mlx5/mr.c | 15 ++++++++-------
> > >  1 file changed, 8 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> > > index 12bca6ca4760..3c241898e064 100644
> > > --- a/drivers/infiniband/hw/mlx5/mr.c
> > > +++ b/drivers/infiniband/hw/mlx5/mr.c
> > > @@ -1857,6 +1857,11 @@ static int cache_ent_find_and_store(struct mlx5_ib_dev *dev,
> > >  	return ret;
> > >  }
> > >  
> > > +static bool is_cacheable_mkey(struct mlx5_ib_mkey mkey)
> > 
> > I think it's better using a pointer as the parameter instead of the struct itself.
> 
> Indeed, that looks like a typo

It is suboptimal to pass struct by value, because whole struct will be copied,
but it is not a mistake too.

Thanks

> 
> Thanks,
> Jason
> 

