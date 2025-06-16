Return-Path: <linux-rdma+bounces-11367-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264E8ADBA83
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 22:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2D93AE159
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 20:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79471F099A;
	Mon, 16 Jun 2025 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+zXodZV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712A82E40E;
	Mon, 16 Jun 2025 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750104271; cv=none; b=HJyYwcvgTV1RXqnkWmWlDRdWylCYzSdJP2xe2Yp1RhCj0S4sOkJCc+djO7/P8SNU0XZkiK8MUNnVl1sFqtp7rmMFYr+ldaTd2Am0pfC8Lk7HIrQjXCN64ZjDxVaYAc+ncwtA4FstiYjKEp+WSD9+gyLgWHi/JDyv1/h8oLVhMaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750104271; c=relaxed/simple;
	bh=Et21XFiupMhtztsIix5XoNNyWOX94OGDV/Hx4l9I1UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXc4q5xb0NZ5BRkZ6D7g1qbIC9jmfDrFiAt0E37G/JH1zbv0IfgWMOdlBFMt2Z+nQpHxhO17yMeRV5Fm/LNiSlqZIHJuyhtsMNd7F2ZgrQVsEXAbWCfYFn+xgeFx7soOeh+a5bmEx2HEs6ggOZQuUcm9NPAR5P/ctaCsM+Sdj0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+zXodZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAC1C4CEEA;
	Mon, 16 Jun 2025 20:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750104271;
	bh=Et21XFiupMhtztsIix5XoNNyWOX94OGDV/Hx4l9I1UA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I+zXodZVJH4kHho9Ufv8FbtQvgUgfCH4AfNHCPLYPw002zjOYi4Tp+k2QA7qpdc80
	 3klgaouwg3LLarOktqriyrb/lrrsv+xQgfgF4npfu95Qej8/M6FdMCjZPwdGLXpfyF
	 nFJnXeRxLGeqaE3OuvGQKfhUqKPQotW9tecd9LS2rV5Fu9MIv3mQeU3CLa/nOLlatB
	 7AtMiXDLo6QCX1Y9ADWe+KbnFfNWQlsPEhu5z7fIoGkNfuSERTP2gvrvfXpnAqdGYD
	 +23REHbx2HniHUeB0gw9m0b4QIHzz8sTAzFo3WGLROPxzhb7EKngcGURVRYFr5nuwf
	 4I0uZKvdg9nvw==
Date: Mon, 16 Jun 2025 21:04:27 +0100
From: Simon Horman <horms@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Mark Zhang <markzhang@nvidia.com>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH net] net/mlx4e: Remove redundant definition of IB_MTU_XXX
Message-ID: <20250616200427.GC5000@horms.kernel.org>
References: <aca9b2c482b4bea91e3750b15b2b00a33ee0265a.1750062150.git.leon@kernel.org>
 <20250616163602.GA4794@horms.kernel.org>
 <20250616183305.GF750234@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616183305.GF750234@unreal>

On Mon, Jun 16, 2025 at 09:33:05PM +0300, Leon Romanovsky wrote:
> On Mon, Jun 16, 2025 at 05:36:02PM +0100, Simon Horman wrote:
> > On Mon, Jun 16, 2025 at 11:24:23AM +0300, Leon Romanovsky wrote:
> > > From: Mark Zhang <markzhang@nvidia.com>
> > > 
> > > Remove them to avoid "redeclaration of enumerator" build error, as they
> > > are already defined in ib_verbs.h. This is needed for the following
> > > patch, which need to include the ib_verbs.h.
> > > 
> > > Fixes: 096335b3f983 ("mlx4_core: Allow dynamic MTU configuration for IB ports")
> > > Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
> > > Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Hi Mark, Leon, all,
> > 
> > If I understand things correctly, without this patch the driver
> > compiles and functions correctly. But if it is modified to
> > include rdma/ib_verbs.h, which is required for some other forthcoming
> > change, then the other parts of this patch are needed to avoid a build
> > failure.
> 
> Yes, the inclusion of rdma/ib_verbs.h was needed for series, which at
> the end doesn't need it. I can drop Fixes line if it is important.
> 
> There is no following patches for this. It is standalone change.

Sure, that is fine by me.
But please drop the Fixes tag and resubmit for net-next.

Thanks

