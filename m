Return-Path: <linux-rdma+bounces-14254-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FD8C3505D
	for <lists+linux-rdma@lfdr.de>; Wed, 05 Nov 2025 11:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C030518C1EF6
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Nov 2025 10:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057222C11E6;
	Wed,  5 Nov 2025 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbTbojWi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB3926F28D;
	Wed,  5 Nov 2025 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762337050; cv=none; b=KH6goyQgYXhJITCj0OxD3odNMkQ+4j007YO2aS2iVyM+ZpGXLigd+JG+vWFjzRVfJw2uH2J/MBcMXaFnpnpU/hhnlyIAzQpHfJ2eF0QMtW/zxkhzCNp1mAKqNrriMLTh7NXYTJ22NNqDVGlQkyyCfnRzScvwu/cRoZ5MCrrnRiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762337050; c=relaxed/simple;
	bh=rBbUA2igNXZEkS24OqY0dBWwt4WuBRqYmZYorPEGYz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImsKxydYxeFaK4ek9vn2CkBvF/wSt4DuY7fjsCuuE/AsDSZtTKyMQ+CQOOUvCNHEEK+ymYg0nzi/b3Pm/szH9Nmt6O+mFH2qJnFTeFk2b6JXNAGmzQjr2EovsPIneGYwthvWtCDG539v4NTi0+B9E2rqtVQCwMOliYPyaz6ywCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbTbojWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98997C116D0;
	Wed,  5 Nov 2025 10:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762337050;
	bh=rBbUA2igNXZEkS24OqY0dBWwt4WuBRqYmZYorPEGYz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hbTbojWiVxW9GO1kuox6/4/GFmp9VG4rJLK7trpQhKcbQbBOySeicNSKqTSOadj9g
	 5vm6p5d14Uh6MU3HOYjVhK9HT1ontj3IiB6D5MVfJQBiDHbU7fKIQHOkxGb/cRPwUh
	 uJrA+e7QZVXdxwzqYLn43CfdDAlmhOx4Th6Vb3pFFkITkpj+bywDplv/zidSaAOC6p
	 xaaxL88R951KDYgd7ETNxnjEX2g7V6Tm6NRODikSqNDsNEofRuzDMNJvbgYhtgjY2c
	 CPXBI+zYc/58zbNpGv6lYQohj+gooPQEhhR0IyLtQdL1KxCRBO2df8gPZeVXvZY4iD
	 ZJx+6edRHxLCA==
Date: Wed, 5 Nov 2025 10:04:05 +0000
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
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net V2 2/3] net/mlx5e: SHAMPO, Fix skb size check for 64K
 pages
Message-ID: <aQshFdIQ4uZBj7XI@horms.kernel.org>
References: <1762238915-1027590-1-git-send-email-tariqt@nvidia.com>
 <1762238915-1027590-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1762238915-1027590-3-git-send-email-tariqt@nvidia.com>

On Tue, Nov 04, 2025 at 08:48:34AM +0200, Tariq Toukan wrote:
> From: Dragos Tatulea <dtatulea@nvidia.com>
> 
> mlx5e_hw_gro_skb_has_enough_space() uses a formula to check if there is
> enough space in the skb frags to store more data. This formula is
> incorrect for 64K page sizes and it triggers early GRO session
> termination because the first fragment will blow up beyond
> GRO_LEGACY_MAX_SIZE.
> 
> This patch adds a special case for page sizes >= GRO_LEGACY_MAX_SIZE
> (64K) which uses the skb->len instead. Within this context,
> the check is safe from fragment overflow because the hardware
> will continuously fill the data up to the reservation size of 64K
> and the driver will coalesce all data from the same page to the same
> fragment. This means that the data will span one fragment or at most
> two for such a large page size.
> 
> It is expected that the if statement will be optimized out as the
> check is done with constants.
> 
> Fixes: 92552d3abd32 ("net/mlx5e: HW_GRO cqe handler implementation")
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


