Return-Path: <linux-rdma+bounces-11598-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 398BAAE6EB9
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 20:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9CD17CBE3
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 18:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0912E6D0F;
	Tue, 24 Jun 2025 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f901Alpa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D4E4C74;
	Tue, 24 Jun 2025 18:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750790258; cv=none; b=Qd0YIvFEZzKf28RW4eANJ5UrvXDdy6K2FjhHdgKNu75WStSpWpU5yEGEPfD+Fm/Kx395aHg6v2Bbp7gzs8haqaT+d3u7RWY2THQG1+cfQ3PLr4d3PcVYGI+AAlA9ngUPXTdQVt0CQHztnKEYsOmpzR3iyG2G5hrHVtsq5tQXXY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750790258; c=relaxed/simple;
	bh=SbtBHWetUxbfsI83E1lJ+JPjcvvpq3n6zbKJ0cj3irM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RInjaohZVEU241oYeFpl28VGOiCZUP5gOTMP51hlt4wdzb4ei0gUwG+TlCwwLFwLQOo1v7MhPjkHypaGHah7apgy3bJ8eCYRoS5QDNua7tO6bQxo2lSN4JN0Fy/pNeoG2pX/4o+8jy8gx33nOCa1SQO0i3P81hS5ZNfTwFCfKvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f901Alpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B12C4CEE3;
	Tue, 24 Jun 2025 18:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750790256;
	bh=SbtBHWetUxbfsI83E1lJ+JPjcvvpq3n6zbKJ0cj3irM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f901AlpaR1JXI05zIyJeubsPX6OkYVUpbvy9ASO3rrWSJfPBItB0XTtmBE/0Yo5tI
	 F2iIdp9yz2eZrieUpnOh7Hu2aGOPKwSRK31HBMP8e09yTYbb8X4jripXWyRn7lSOms
	 +oFK6RqpAXpGIwpiTRBpO5umOvvp731qx5D0RPxOxqPIuIx28BzBMwTloknCbZSkvb
	 FAhd8jkSu4HWT3YriIsPl98L0drEI/GDOEkwZ1e6ngLTxmQdeXsNhQn0ar+AdQ4js+
	 ZJSCh4x0McCXwIjhxiiuoOpknROEOOMAzigBNzX+pBlD19f0397PVvVBb1VCdY5eTt
	 ZSsnL29QvAE+Q==
Date: Tue, 24 Jun 2025 19:37:31 +0100
From: Simon Horman <horms@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, saeedm@nvidia.com,
	gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	moshe@nvidia.com, Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Vlad Dogaru <vdogaru@nvidia.com>
Subject: Re: [PATCH net-next v2 2/8] net/mlx5: HWS, remove incorrect comment
Message-ID: <20250624183731.GE1562@horms.kernel.org>
References: <20250622172226.4174-1-mbloch@nvidia.com>
 <20250622172226.4174-3-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250622172226.4174-3-mbloch@nvidia.com>

On Sun, Jun 22, 2025 at 08:22:20PM +0300, Mark Bloch wrote:
> From: Yevgeny Kliteynik <kliteyn@nvidia.com>
> 
> Removing incorrect comment section that is probably some
> copy-paste artifact.
> 
> Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Reviewed-by: Vlad Dogaru <vdogaru@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


