Return-Path: <linux-rdma+bounces-4752-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED82396C293
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 17:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A951C288992
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 15:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E0D1DEFC0;
	Wed,  4 Sep 2024 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJNmzCOn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57A61DC052
	for <linux-rdma@vger.kernel.org>; Wed,  4 Sep 2024 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464102; cv=none; b=tbq+t8+vRl1E1Z2ZilyVpbw+jX2NtV2dUv6x1y9Z0wzBgTR7Q61tKv2FIj6Cdf5Vsmv62BJa7GKMKt+Q6cCtDMUqgJOEwb4MUzQmi1Ry5Fm4h/0KdqlchG8tWqAEN7bTP1SHlmV2/83vVERcGjNSx/yWOgU7G9aL2mOJPqWLDPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464102; c=relaxed/simple;
	bh=mLyZu/0YrnFoXo3oZktUF0U0yhywy1vcFaRjwmCklKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unDNQ0E7SktY9+bHHAoiMFmb1BeSI65jMXXPVpTPlDHpPESqGfoZyt09dM7eB92RwabP3sxNp7D+yJ+OkOKtYU49/th50wgRxbdNmzlxXnukXCn7m9z2OQidXMa+qociAr9JEWgVZ46MyNsZH3gZckvq61dAdFMOchA/vhjK+jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJNmzCOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BF8C4CEC2;
	Wed,  4 Sep 2024 15:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725464102;
	bh=mLyZu/0YrnFoXo3oZktUF0U0yhywy1vcFaRjwmCklKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BJNmzCOnkHFY09i6a52eIPei8T81RMuqlEK9V59dvgLhMoOTcFEVhEuZbZ4jMGGn9
	 ux+8Vdv5zOYtcbK8h309JdUV11PRJE3xgnYbSM14c4rar82NLruDhWrxUmflFoz9Xx
	 Z9smjJRZY2Bt46VbMF3a0xvsnp+sZqczNXEvFovU1g1fbpRy6KhX5OqfcZczkCuUaq
	 CEimChPsfsS9m6UoyPRQ1nWY+9R2nE9vle7UavUKGCY5T+aH40SNlD1fb28/c0eyHE
	 lH5axTlo/FhAN7SPLoYxRTquZJ6ufzGy6YFUJkmL4tZEg4HVfPBVhzPTm26PZG/3w0
	 ADMnpn5BR4OeA==
Date: Wed, 4 Sep 2024 18:34:57 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
	syzbot+b8b7a6774bf40cf8296b@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-next] RDMA/core: Skip initialized but not leaked GID
 entries
Message-ID: <20240904153457.GO4026@unreal>
References: <7cce156160c4da8062e3cc8c5e9d5b7880feaafd.1725284500.git.leonro@nvidia.com>
 <20240904143113.GG3915968@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904143113.GG3915968@nvidia.com>

On Wed, Sep 04, 2024 at 11:31:13AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 02, 2024 at 04:42:52PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Failure in driver initialization can lead to a situation where the GID
> > entries are set but not used yet. In this case, the kref will be equal to 1,
> > which will trigger a false positive leak detection.
> 
> Why does that happen??
> 
> 
> > For example, these messages are printed during the driver initialization
> > and followed by release_gid_table() call:
> > 
> >  infiniband syz1: ib_query_port failed (-19)
> >  infiniband syz1: Couldn't set up InfiniBand P_Key/GID cache
> 
> Okay, but who set the ref=1?
> 
> > diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> > index b7c078b7f7cf..c6aec2e04d4c 100644
> > --- a/drivers/infiniband/core/cache.c
> > +++ b/drivers/infiniband/core/cache.c
> > @@ -800,13 +800,15 @@ static void release_gid_table(struct ib_device *device,
> >  		return;
> >  
> >  	for (i = 0; i < table->sz; i++) {
> > +		int gid_kref;
> > +
> >  		if (is_gid_entry_free(table->data_vec[i]))
> >  			continue;
> >  
> > -		WARN_ONCE(true,
> > +		gid_kref = kref_read(&table->data_vec[i]->kref);
> > +		WARN_ONCE(gid_kref > 1,
> >  			  "GID entry ref leak for dev %s index %d ref=%u\n",
> > -			  dev_name(&device->dev), i,
> > -			  kref_read(&table->data_vec[i]->kref));
> > +			  dev_name(&device->dev), i, gid_kref);
> >  	}
> 
> I'm not convinced, I think the bug here is something wrong on the
> refcounting side not the freeing side. Ref should not be 1. Seems like
> missing error unwinding in the init side.

I dropped this patch as the real fix is here 1403c8b14765 ("IB/core: Fix ib_cache_setup_one error flow cleanup")

Thanks

> 
> Jason
> 

