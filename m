Return-Path: <linux-rdma+bounces-15545-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2E6D1D164
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 09:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA85C3015595
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 08:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D6737F0E8;
	Wed, 14 Jan 2026 08:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMO8QkIn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D183137C0F2;
	Wed, 14 Jan 2026 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768378766; cv=none; b=Q4wYaz18i0czE1samMx6T7zmhJe+tu92zQkHfKx79OshuoO30opT5mvMYX/YACAx0nhC2K7N+y/n7dtwlelEHDm14Kh8S+5i7NAEDQg8YAsOtWN6k55KE3suuY1x/xmwd3sbA2Z7Rf8BDlZ3Z24rS1L1/IpHO6v3QoUdgTBubt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768378766; c=relaxed/simple;
	bh=EqqF6Tej4uqQYtCT3CEB7H7LCgMq95GyqQGvIwoRDEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pU0zbLo1m2myhfAmN6EDoOTqfldkINqMcRzUaVsajmjkriTcucWAeseHQeZhE2MYrOZ4FvvsM9nDLqv5uO0Y48n+XWpq2I6aF2ds52hkqgneRuVCF3pjRMwkGRkotM+2nfHVQX2PPIYtGBGSao6quZg5UR+Gip1usOg/bVgNRbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMO8QkIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A42EC4CEF7;
	Wed, 14 Jan 2026 08:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768378766;
	bh=EqqF6Tej4uqQYtCT3CEB7H7LCgMq95GyqQGvIwoRDEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uMO8QkInCKFqbRQ7F65Hs+b57YYUqxZeT/6RZV5anMYOJ9vyL9Z6S/0eDNvkkF2op
	 CBJexI9o7NC6mETIwGG1pcU5tXu5C168Nz4qSMqUBEEo3/diCQD/MYkIGLcCSjp6f5
	 foLT+8A9zctD8cibxzmIHkXR49oZlrnRP2fq3D9iF3xtmVdFVQB8deMzHGuKN5gUBb
	 qAWX0bm7zni+d93lolnzngRwKeqBrlpumGQrtxVgrWxTHY8K9nv/SoWwnlP655ABoQ
	 EKZmAcfOqHFd11OAxcn9H005gJwDkPSuQ/4i8ArqitmAC642rFuHNemLe0QWy67WH/
	 /acoBogxHBS0w==
Date: Wed, 14 Jan 2026 08:19:20 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: Re: [PATCH net-next 0/3] net/mlx5: HWS single flow counter support
Message-ID: <aWdRiAIAxoDE1ihV@horms.kernel.org>
References: <1768210825-1598472-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1768210825-1598472-1-git-send-email-tariqt@nvidia.com>

On Mon, Jan 12, 2026 at 11:40:22AM +0200, Tariq Toukan wrote:
> Hi,
> 
> This small series refactors the flow counter bulk initialization code
> and extends it so that single flow counters are also usable by hardware
> steering (HWS) rules.
> 
> Patches 1-2 refactor the bulk init path: first by factoring out common
> flow counter bulk initialization into mlx5_fc_bulk_init(), then by
> splitting the bitmap allocation into mlx5_fs_bulk_bitmap_alloc(), with
> no functional changes.
> 
> Patch 3 initializes bulk data for counters allocated via
> mlx5_fc_single_alloc(), so they can be safely used by HWS rules.

Hi Tariq,

Overall this looks good to me.
Am I correct in thinking that there will
be follow-up patches to make HWS use counters?

