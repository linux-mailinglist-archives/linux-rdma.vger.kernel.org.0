Return-Path: <linux-rdma+bounces-15585-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 660A3D24D81
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 14:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D8493008769
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 13:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8973A0EBC;
	Thu, 15 Jan 2026 13:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRzSAEEz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D373A0B16;
	Thu, 15 Jan 2026 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768485439; cv=none; b=HsLIFeAS1XtTjZ289FEdlEo8D7PY+Hc6iqVVIHWYFQ3aISOAhxNK+ZwYz9eG91BBxir6lQgIJOX8cUtD+Gje6zMppf9lNf4OqOTaU5jvrjzoTY2TGsM69Aq+Wo4M0FuF0KL+Dvg2JYsJq6fLTK0vJwGxHOc6HOYplnYTvtAMoGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768485439; c=relaxed/simple;
	bh=XJpYmyxLElp9QrN6rQuvujZEFsxlhrm3jkFPfqdeULo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIYxJf5q1XW9kb+UxykuXUxsKhVNc/T3VPEyn49676qYm2CgW3j9+Hary31TPLmpehgOw2cEjVstiHtmH9heyQ2OUUAOX2ADeigotGUrPJ5YsGf8DqMRQaZgUypHgn+DXxpPhZqkwkp+OGTYEeb23I4eRjnAxsnvrsiOIclvqwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRzSAEEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F56C116D0;
	Thu, 15 Jan 2026 13:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768485438;
	bh=XJpYmyxLElp9QrN6rQuvujZEFsxlhrm3jkFPfqdeULo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DRzSAEEzR89gN7cy3OJV00H0ogEcP94OwM3brv9uEfAcdp9jl3nOBSqn8cq1kjQVJ
	 PHh8frVTmEflMjDg53qvl0SzUai0Zdv2F0ZoHiZ1gV28+BSsktchAcOJreLBI19Pek
	 8jvOaZYkXWpwEi4WhW4n4LTqcZI65TWfnhJRMrFkUHMqZ25svuti9wOS1FDKFtPEk7
	 LvWnkJzScdbWWpFBPxgJuVo6jhFzyNowc5vgHFzmhlFlCd2CBRiQwU61f6MNUldTCK
	 L/Kgbk9d9ctQyiZuShGAaRkd+44+XczZMh9edWIceeVtbjYKep6fr500hAWGuFy//m
	 Ee2W8OrOy0Ryg==
Date: Thu, 15 Jan 2026 13:57:13 +0000
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
	Moshe Shemesh <moshe@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 0/3] net/mlx5e: RX datapath enhancements
Message-ID: <aWjyOVQp73jmsmSN@horms.kernel.org>
References: <1768224129-1600265-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1768224129-1600265-1-git-send-email-tariqt@nvidia.com>

On Mon, Jan 12, 2026 at 03:22:06PM +0200, Tariq Toukan wrote:
> Hi,
> 
> This series by Dragos introduces multiple RX datapath enhancements to
> the mlx5e driver.
> 
> First patch adds SW handling for oversized packets in non-linear SKB
> mode.
> 
> Second patch adds a reclaim mechanism to mitigate memory allocation
> failures with memory providers.
> 
> Third patch moves SHAMPO to use static memory for the headers, rather
> than replenishing the memory from a page_pool.
> This introduces an interesting performance tradeoff where copying the
> header pays off.

Thanks,

This series looks good to me.
I particularly like the code complexity reduction in patch 3/3.

For the series,

Reviewed-by: Simon Horman <horms@kernel.org>


