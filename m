Return-Path: <linux-rdma+bounces-11364-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 430EDADB8E0
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 20:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9EF2174BFE
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 18:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE083289803;
	Mon, 16 Jun 2025 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsMmGEAe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0761A073F;
	Mon, 16 Jun 2025 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750098793; cv=none; b=GMQcas9mh1CdtFcci+uBwoyRYWPvU9T5E1GvRibylZ0UxZ2IRJCXws59+NlzKt/ghvlgaMGG5wiJjxNLp1CLFM/A2g7zAcpetb0wVVHK7XqYiLSJivQ35iWs/Yo4SK9gnBjcBcq3ZwcPytffShOUdL8vTeB7X585xxGKwxQ5wnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750098793; c=relaxed/simple;
	bh=dDQ4gFb4TdhNT0XrYLb+9ORfw6SOtIEMuCOcf7M2hLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YC8Ym6RXvYwfXMHHe/ie29fADVJyz7FSw9clEGT7PCpkd6IEXvcyzwYgvwWgJYpTa5S50Bp/OIxFm52iALA5za7xLYJ/nqlAz/ldOHeeHDpQgTeMmBkyFn68x2f8vWEf42bZd0JBA9U9LRIT1oN2PfCpCNdrvAGBs8/dvJy3Nh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsMmGEAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7A8C4CEEA;
	Mon, 16 Jun 2025 18:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750098793;
	bh=dDQ4gFb4TdhNT0XrYLb+9ORfw6SOtIEMuCOcf7M2hLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AsMmGEAekZVhhRLMncby2wH2z0UUxkqKNyu8HiIoptI9qkMvyEPWwL6g+0h7pf1NF
	 Shy2253+N1PG1y3j2ceVH0Zx5Pf2dEGYyG+dvqStQWM0gh9074lgCPEydVZYUYhk7o
	 PvCMl9S0kb+wR2//hPzG13bcDx+1An6w5RWbRFGk3qe1QfgQTTseGQlLyAgQ9z1kDU
	 Dx/lwwJdrmQXcbiLCCZgKro9JnLyMhdLqm+SRjosyD7DIgYSsQ6WG7aqgtwf2pwjri
	 A9hKnyvM+IX+83lLcbs71O7jWwpbMKtoR1WSUMVjylPLwVGxQP64nLmQSFEQh4BSWF
	 hFfrfYKVxA12Q==
Date: Mon, 16 Jun 2025 21:33:05 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Mark Zhang <markzhang@nvidia.com>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH net] net/mlx4e: Remove redundant definition of IB_MTU_XXX
Message-ID: <20250616183305.GF750234@unreal>
References: <aca9b2c482b4bea91e3750b15b2b00a33ee0265a.1750062150.git.leon@kernel.org>
 <20250616163602.GA4794@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616163602.GA4794@horms.kernel.org>

On Mon, Jun 16, 2025 at 05:36:02PM +0100, Simon Horman wrote:
> On Mon, Jun 16, 2025 at 11:24:23AM +0300, Leon Romanovsky wrote:
> > From: Mark Zhang <markzhang@nvidia.com>
> > 
> > Remove them to avoid "redeclaration of enumerator" build error, as they
> > are already defined in ib_verbs.h. This is needed for the following
> > patch, which need to include the ib_verbs.h.
> > 
> > Fixes: 096335b3f983 ("mlx4_core: Allow dynamic MTU configuration for IB ports")
> > Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
> > Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi Mark, Leon, all,
> 
> If I understand things correctly, without this patch the driver
> compiles and functions correctly. But if it is modified to
> include rdma/ib_verbs.h, which is required for some other forthcoming
> change, then the other parts of this patch are needed to avoid a build
> failure.

Yes, the inclusion of rdma/ib_verbs.h was needed for series, which at
the end doesn't need it. I can drop Fixes line if it is important.

There is no following patches for this. It is standalone change.

Thanks

