Return-Path: <linux-rdma+bounces-12618-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E8DB1CB82
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 19:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A0518C4D69
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 17:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C043128DF0C;
	Wed,  6 Aug 2025 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSPedcTn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7288F1E7C03;
	Wed,  6 Aug 2025 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754503102; cv=none; b=J26pYj9rIa0CZLXDJi9KbTCs1XlnIOPVZORf6B+FF8iuoK+yKlhtIb1onKenVTvQIHipqLz7M9xaQAAwzWuM2KJGsEul0Bq4RmNgEMdWc+JajQw8oQEJC8hOdvEtyuWZelWN3nNd5mlNJRK/LqF2CFd9/zeoZX5IumLMpNMCfOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754503102; c=relaxed/simple;
	bh=QRv/wMrnx6kdm9+dkuQm+1R6GRmMJS9e4RFnl9DCqgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIVX2pt9n9DYm9jvjjQkGMQoC+npyEaq6/LX51P4ymn93AnRifKKtfNGzLZWV1a6LgUFSNozNkQ8rGST+wsbxNlEIi7ig6crgy2zZMRPjqPcCKuFycvEAaeeq601tnvSH5NGrdL3YKT+6of+DTHJWW8l0vzz3cjoyE9VMRY7FDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSPedcTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82CCC4CEF7;
	Wed,  6 Aug 2025 17:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754503102;
	bh=QRv/wMrnx6kdm9+dkuQm+1R6GRmMJS9e4RFnl9DCqgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SSPedcTnb9PNFJz5BquW88b7de3lTQAmDba8eXMpQiteJlXzluzbH2j45kR4N6RQz
	 o10imlbS0xV9f/PuyG69RxEB1PHVyBVxEpHnNok/8mEkS/Wi3qJVEyrzf3gnXks46i
	 rwHjVx9dBKw85guTrX7GccXznHPudxj2Tt7xh3coZVn2MifKXj1OgBxe10KW8xIFM0
	 u/VRZElnuJU6cQE/CXgFKclWAkzNk23uoZPHI4lcRcKgGpdVh01d/YvVWu2kWt6HcH
	 a6aRbLFJWadwqOAELuptKiaB1ZjO7RQFYo2sgbtn0RCB+KyonKHnvlU/tMb5dI4iLT
	 CQTaR+dOoA60A==
Date: Wed, 6 Aug 2025 20:58:18 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Simon Horman <horms@kernel.org>, shannon.nelson@amd.com,
	brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, corbet@lwn.net, andrew+netdev@lunn.ch,
	allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/14] net: ionic: Export the APIs from net driver to
 support device commands
Message-ID: <20250806175818.GV402218@unreal>
References: <20250723173149.2568776-1-abhijit.gangurde@amd.com>
 <20250723173149.2568776-4-abhijit.gangurde@amd.com>
 <20250725164106.GI1367887@horms.kernel.org>
 <20250801170014.GG26511@ziepe.ca>
 <20250801132128.69940aab@kernel.org>
 <5d495e57-71f5-e465-cba0-d727c6b36167@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d495e57-71f5-e465-cba0-d727c6b36167@amd.com>

On Wed, Aug 06, 2025 at 01:24:04PM +0530, Abhijit Gangurde wrote:
> 
> On 8/2/25 01:51, Jakub Kicinski wrote:
> > On Fri, 1 Aug 2025 14:00:14 -0300 Jason Gunthorpe wrote:
> > > > Perhaps I misunderstand things, or otherwise am on the wrong track here.
> > > > But this seems to open the possibility of users of ionic_adminq_post_wait(),
> > > > outside the Ethernet driver, executing a wide range or admin commands.
> > > > It seems to me that it would be nice to narrow that surface.
> > > The kernel is monolithic, it is not normal to spend performance
> > > aggressively policing APIs.
> > > 
> > > mlx5 and other drivers already have interfaces almost exactly like this.
> > Which is not to say that it's a good idea.
> 
> Thank you for the feedback, and apologies for the delay. This discussion
> prompted a thorough internal review.
> Although a precedent for similar interfaces exists in other RDMA drivers,
> the point is well-taken and we understand the concern about a wide API. To
> address this, two potential approaches are being considered,
> 1. The function can be documented as a privileged, clarifying that it
> performs no input sanitization and making the caller responsible for device
> access.
> 2. Alternatively, a new, narrower function could be introduced specifically
> for RDMA use that validates commands against an explicit allow list.
> 
> We are open to either approach and would appreciate a guidance on the
> preferred direction.

I suggest you to take standard kernel coding pattern and create
in-kernel API which suits your "in-kernel customers". There is no
need in any "allow list" for in-kernel APIs. Let's don't bring
complexity and defense programming style where it is not needed
and here it is not needed.

Thanks

> 
> Abhijit
> 
> 

