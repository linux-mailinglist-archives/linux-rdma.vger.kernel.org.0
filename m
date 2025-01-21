Return-Path: <linux-rdma+bounces-7146-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31867A17958
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 09:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D421886410
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 08:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0281B85CA;
	Tue, 21 Jan 2025 08:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCgVPoH/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E044B1B6D10
	for <linux-rdma@vger.kernel.org>; Tue, 21 Jan 2025 08:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737448766; cv=none; b=pmN8Rr7Q0+1mtO24l48jqBJ931rvi3zJ97Pr+mIZkD/aW4zpf4PcSxWGYeEtu2uWKZOwenw5VxqEwBAff8YZswsOJERfz+8Q7gj/etd0+MjdfO28gvu6pzc2H0x0c8WCPKM7QjDpU3XUk5CSZhS6BYVKxd6YNzwE2SQetWWkZMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737448766; c=relaxed/simple;
	bh=9UtKwPJroowRrIQOBqmFxb5pMuODVjBc9eRFZ/iKdRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMokE93kl5//5DJgTT0lQHRcs50VCVfUClPShPa5CiKKgUynC5HxFeTjeazH3gGU0gf4FRcWEL49cImsJ94/bM7PB2NVZavNNiAdswRTy9bnhfZ79aacKG+XkwXcmYyPm/lsllX1viOOMwHS79UmWnj20oWuoQLdFkqFrwolfaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCgVPoH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B5DC4CEDF;
	Tue, 21 Jan 2025 08:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737448765;
	bh=9UtKwPJroowRrIQOBqmFxb5pMuODVjBc9eRFZ/iKdRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KCgVPoH/dcRW0oIpU0QS2BJUJvpc0WEgFLS11Fon062Xqc8uqk27UGtC9OSnB7aHy
	 9zfGTgOCCQx5welsKYAVqboJymQuu+x5OkrSJT2P9zJfIBV6siW3fKI7/nuQlSgDni
	 22w5yoslgLuM+t2FcsrX1/kiAmYBvuvpgv7UFXETJHzd7LFSNZpOLn1w5qz6hcJHtZ
	 Sj39UnPMPIeFJGHjfQweq/pwWv2URjT3YuqJFNN1dpjwkx7hxyQfB3/I3b419g5NhN
	 k+/nhw+rKsMQCb5NPMTmw3jh42OYAWaKBKBZMMx2GuxyfI4hR8NZRsP4V/Za3hpdrf
	 uwU+yujV3+KUA==
Date: Tue, 21 Jan 2025 10:39:19 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	Artemy Kovalyov <artemyko@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1] RDMA/mlx5: Fix implicit ODP use after free
Message-ID: <20250121083919.GB10702@unreal>
References: <c96b8645a81085abff739e6b06e286a350d1283d.1737274283.git.leon@kernel.org>
 <20250120184922.GS5556@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120184922.GS5556@nvidia.com>

On Mon, Jan 20, 2025 at 02:49:22PM -0400, Jason Gunthorpe wrote:
> On Sun, Jan 19, 2025 at 10:21:41AM +0200, Leon Romanovsky wrote:
>  
> > Fixes: 5256edcb98a1 ("RDMA/mlx5: Rework implicit ODP destroy")
> 
> Cc: stable
> 
> Fixes a user triggerable oops
> > -	if (!refcount_inc_not_zero(&imr->mmkey.usecount))
> > +	xa_lock(&imr->implicit_children);
> > +	if (__xa_cmpxchg(&imr->implicit_children, idx, mr, NULL, GFP_KERNEL) !=
> > +	    mr) {
> > +		xa_unlock(&imr->implicit_children);
> >  		return;
> > +	}
> >  
> > -	xa_erase(&imr->implicit_children, idx);
> >  	if (MLX5_CAP_ODP(mr_to_mdev(mr)->mdev, mem_page_fault))
> > -		xa_erase(&mr_to_mdev(mr)->odp_mkeys,
> > -			 mlx5_base_mkey(mr->mmkey.key));
> > +		__xa_erase(&mr_to_mdev(mr)->odp_mkeys,
> > +			   mlx5_base_mkey(mr->mmkey.key));
> > +	xa_unlock(&imr->implicit_children);
> > +
> > +	if (!refcount_inc_not_zero(&imr->mmkey.usecount))
> > +		return;
> 
> It seems the refcount must be done first:
> 
> 	/*
> 	 * If userspace is racing freeing the parent implicit ODP MR
> 	 * then we can loose the race with parent destruction. In this
> 	 * case mlx5_ib_free_odp_mr() will free everything in the
> 	 * implicit_children xarray so NOP is fine. This child MR
> 	 * cannot be destroyed here because we are under its umem_mutex.
> 	 */
> 	if (!refcount_inc_not_zero(&imr->mmkey.usecount))
> 		return;
> 
> What we must not do is remove something from the xarray and then fail
> to free it.

Yes, like it was before.

> 
> Jason

