Return-Path: <linux-rdma+bounces-8305-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F47A4DF93
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 14:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74EDB1791BE
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 13:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AE12046B6;
	Tue,  4 Mar 2025 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5NSN8Xf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A4920469F
	for <linux-rdma@vger.kernel.org>; Tue,  4 Mar 2025 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095864; cv=none; b=AtRtA/N9bJJhxeFx0XN7SRZQe3So7jxsVBmewwW5mWRU6kLaHhu1vbJF58J5Vu0UNWqyUlvk7VpMA75ZdKuwsLf2Og0jbkR/MNCSEN5R375V+YVdYCvpyZOyhVYZ3L+WxZIBjA0vfMti9/PJp9Zr/5/2/jFBBhmIsEBIcEm9exU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095864; c=relaxed/simple;
	bh=J5jFucQ+Tu3g+Kor4A7z9m2XkGyps4x2wNuaS94pLmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUt4PSUUatVJAH9bheivgJAgxrStzy68PDQielXhJnYsX2V5JwjjiZV8qQ+WSbYki/F6/hLX6Bmw3QN4JlNei7AzV1Pp7hvyswIi/vwbIwmF0XuA2n5SqZpsXWtmiJ2GzVRqjYlogWdDobY852K9fdv5mrj8PCAdOAu6j6zIygo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5NSN8Xf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A68C4CEE5;
	Tue,  4 Mar 2025 13:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741095863;
	bh=J5jFucQ+Tu3g+Kor4A7z9m2XkGyps4x2wNuaS94pLmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n5NSN8XfKiKDaqdreg0jHKpoNeB3fetfop8jDr1j7qjhnrpz4DohTtl9jFh06NjCW
	 aPr+18x//NAg8D+WkiO5YlGyfRIxS8buhiD9Kti9M9DxMoXJrES2rhiAlbN4NRcDtW
	 nZFnjROBcKQ0hHDSFo7AStTqNHNcP/WRyJ5o8FtQzoHqIKajMEmm2nrRIAT2ve4Npo
	 +UQy3XfC9fYu6YBMEaPEi8Oh/RXC1fyblUZs3Me4OzXWQvHpbeqsCpnJ2Mshq0rdhk
	 XgBElfSVg8iFbf6E9gktJ6+lYtHo5KtETEWglw5f6gleBZpA0fMPlx1i2ZkSkBUlac
	 DV9BCA3bey0kQ==
Date: Tue, 4 Mar 2025 15:44:18 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>, linux-rdma@vger.kernel.org,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 1/6] RDMA/uverbs: Introduce UCAP (User
 CAPabilities) API
Message-ID: <20250304134418.GF1955273@unreal>
References: <cover.1740574943.git.leon@kernel.org>
 <558b28bc07d2067478ec638da87e01a551caa367.1740574943.git.leon@kernel.org>
 <20250304131852.GH133783@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304131852.GH133783@nvidia.com>

On Tue, Mar 04, 2025 at 09:18:52AM -0400, Jason Gunthorpe wrote:
> On Wed, Feb 26, 2025 at 04:17:27PM +0200, Leon Romanovsky wrote:
> > +int ib_create_ucap(enum rdma_user_cap type)
> > +{
> > +	struct ib_ucap *ucap;
> > +	int ret;
> > +
> > +	if (type >= RDMA_UCAP_MAX)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&ucaps_mutex);
> > +	ret = ib_ucaps_init();
> > +	if (ret)
> > +		goto unlock;
> > +
> > +	ucap = ucaps_list[type];
> > +	if (ucap) {
> > +		ucap->refcount++;
> > +		mutex_unlock(&ucaps_mutex);
> > +		return 0;
> > +	}
> > +
> > +	ucap = kzalloc(sizeof(*ucap), GFP_KERNEL);
> > +	if (!ucap) {
> > +		ret = -ENOMEM;
> > +		goto unlock;
> > +	}
> > +
> > +	device_initialize(&ucap->dev);
> > +	ucap->dev.class = &ucaps_class;
> > +	ucap->dev.devt = MKDEV(MAJOR(ucaps_base_dev), type);
> > +	ucap->dev.release = ucap_dev_release;
> > +	dev_set_name(&ucap->dev, ucap_names[type]);
> 
> Missing error handling on dev_set_name()

Most of the kernel users don't check dev_set_name(). It can't fail in
reality.

> 
> > +#define UCAP_ENABLED(ucaps, type) (!!((ucaps) & (1U << type)))
> 
> Missing () around type
> 
> Why not use a static inline?

I don't think that static inline gives any benefit here.

Thanks

> 
> Jason

