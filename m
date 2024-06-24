Return-Path: <linux-rdma+bounces-3436-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AC6914E56
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 15:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BAD11F22FD9
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 13:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338C113D639;
	Mon, 24 Jun 2024 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dk94aMVM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D58136E3B
	for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2024 13:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235399; cv=none; b=RAWGthNq7HIHRRqvWYCjGAgYELu/OG+SoIZ08zEkbIhOdufIOU+bylgCDiLtfw1hChnq6asNz1BJNOyC1AYnocZ1IWWQPxEkCCsA8EvyvD0KiZTweLYORC3cOqGxIl3Xq1+ne+bJQkue7rIGkg2K00ok+gu/SyooPVba/WUwMr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235399; c=relaxed/simple;
	bh=OIz5JHw9RZiPBx79UYece3LX1e6MEHOy0mCHXgYe3bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYX5oDhyhqK+LwiZtNPvRx1ubbSfx7GyEcxofP3WklqoNMFknYLJzJYdynQRK6y/+9dg3V15r5i2vZ5Hldjp9ex/G59ArloZL9vX1TkAbBJ5v+vLLiSb0rkGZfMUp6gMrWqBwkTgA5p6WWeKfUz7vGUYr10nD1mslpbS+bJK0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dk94aMVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4DFC2BBFC;
	Mon, 24 Jun 2024 13:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719235398;
	bh=OIz5JHw9RZiPBx79UYece3LX1e6MEHOy0mCHXgYe3bU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dk94aMVMeiVL19SEa2hkWQ24SVzIqHm/AowwLKjKqZsy0U0cB5ZZZMD7isAOM/O+3
	 pgYQkrsoFP6JtyU72qfFd6Xni4GcXuVEI1S5XLdtBGEi7cskHlgP6nC7PBAj5NTmjb
	 /vFr1J5Z/hRRVyF/9MJjKNk6dT+jnFXQCCxIxFMNkbVKUjG3hi+AmzeVMFrX4gpuWE
	 NFFfBwuYmujJJVrgsZ5+eKoaSpEKeZugLYVyu4YqxBvN8LvoNMq6IZI0o7a9BPhPgv
	 728/s5xv4tHKMAwKjNC21we6WIebbASaoKCwF6oypcrbpbYcGFsuVe2/gn92DEvRXU
	 Xrm39ZztbHeQA==
Date: Mon, 24 Jun 2024 16:23:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-rc 1/6] RDMA/cache: Release GID table even if leak
 is detected
Message-ID: <20240624132313.GG29266@unreal>
References: <cover.1716900410.git.leon@kernel.org>
 <a62560af06ba82c88ef9194982bfa63d14768ff9.1716900410.git.leon@kernel.org>
 <20240621132139.GA4179191@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621132139.GA4179191@nvidia.com>

On Fri, Jun 21, 2024 at 10:21:39AM -0300, Jason Gunthorpe wrote:
> On Tue, May 28, 2024 at 03:52:51PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > When the table is released, we nullify pointer to GID table, it means
> > that in case GID entry leak is detected, we will leak table too.
> > 
> > Delete code that prevents table destruction.
> > 
> > Fixes: b150c3862d21 ("IB/core: Introduce GID entry reference counts")
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/infiniband/core/cache.c | 13 ++++---------
> >  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> Since this is causing syzkaller failures and it really doesn't seem
> like stable material I'm dropping it from the rc branch and putting it
> in for-next. Lets see if we can fix the failures before the merge window.

I don't see it in the for-next branch, can you please add it?

Thanks

> 
> Jason

