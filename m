Return-Path: <linux-rdma+bounces-10544-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EAFAC108B
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 17:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F48A26B54
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 15:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760A3299ABA;
	Thu, 22 May 2025 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URgW4ent"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0F2299A9F;
	Thu, 22 May 2025 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929499; cv=none; b=LYJUUI8d58mFCRIsyopJUEKiWUJ1y0+dEntHjJu1mjMqmul4wAt2bebOoheR+UaC0X3YNpQP1nudosDJ9KtEUKH+ADcWybZQyZorMH/JsGbZpoB1tVjBCPOJKgpEpw6tF1tE20vzY9fczHEkBTwB8S79RwDYsaEouBF1Tzd5j58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929499; c=relaxed/simple;
	bh=oZlR7yo0+Ugd/6NoEevZTKmjfPxUmIvjJzl+2dimF98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KV//KYLEV1DhC8iqBxoU2MMBwTIaVgHvRGjFfSBjHQb3JI7Q3B5d/LKkT1EEp/WNo5y+U/S1dv8FZeyHko4M/Gl9CUQCLS46CXb2aABve7Odedo4B96z5oVxnJ5plMPZR1hWqLFiWFpNGKv0vz4jENcbkmQkQhtNpfqYc3w93gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URgW4ent; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3FCC4CEE4;
	Thu, 22 May 2025 15:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747929499;
	bh=oZlR7yo0+Ugd/6NoEevZTKmjfPxUmIvjJzl+2dimF98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=URgW4enteSKDITqzxXwON4MNjWlNx9jvqaU/30nlDLRrGeG3JFhlMeDQlTtDPHvWO
	 nexhsjoMpwiJohRCzE/gz/Au/bWmUINoYGoU+yjmYGopYIz2ApEXRkmWjc8QO9EdmQ
	 WEpiEbZUghCxvmpjX0PUjdn4DSU/xtEj+js0wfXKrhKmGXRcBD7XKqGoMU+9EVRhZ2
	 6NCBI0WKG8a2nRBEc/fYnw6HOHNerNNZ6012kJkmuqUgKTk6Mq7E6j7wTTvFFp4Y0G
	 nEWPcjzC9h8sD5mdplmiuDRVa5TX1PfTC32KwNjFbN/tTgC1Kx2E7KOe5mhc6KO3hx
	 XmcS1x28I+WGA==
Date: Thu, 22 May 2025 16:58:14 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net-next] net/mlx5e: Allow setting MAC address of
 representors
Message-ID: <20250522155814.GJ365796@horms.kernel.org>
References: <1747898036-1121904-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1747898036-1121904-1-git-send-email-tariqt@nvidia.com>

On Thu, May 22, 2025 at 10:13:56AM +0300, Tariq Toukan wrote:
> From: Mark Bloch <mbloch@nvidia.com>
> 
> A representor netdev does not correspond to real hardware that needs to
> be updated when setting the MAC address. The default eth_mac_addr() is
> sufficient for simply updating the netdev's MAC address with validation.
> 
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

I note that this is consistent with at least nfp_repr_netdev_ops.

Reviewed-by: Simon Horman <horms@kernel.org>

