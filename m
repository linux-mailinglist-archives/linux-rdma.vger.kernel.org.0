Return-Path: <linux-rdma+bounces-13362-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A948DB5739F
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 10:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ACCC17C385
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 08:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8422F3614;
	Mon, 15 Sep 2025 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1p+J/wi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA34E2F28EE;
	Mon, 15 Sep 2025 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926315; cv=none; b=CqVyHg6E3cqa01zU2Wn2bOPaeIDcO49skAs8lVbq9L+rhNpvx7ZSoEUbCxLF3nLGXHGI80LN2NyiXfVvTVLeKtzwKzrwz0jf3tXRhunsuJ6WAw5toIfvqnSeVlTe6O/IKp2p0faIJdw67w9cZS5kb5paAXCi/j55lXilaBwEYNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926315; c=relaxed/simple;
	bh=zgTyu2IVPRbQbX73aW4fq2zkqmj1x1GIQuq8W/aVZO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXL5YLfvInvLbB3uMAXGycf3bN7nCdqbOT6GPVvxnnKQH4ie+ZhM15IFJQUwpTlXIXh+GrtT+YfvmiA1h6780hyxyWLoMvftgfabzVigJiuEZf/NM+4xioAUkfBMbEymv2zbMQBaXzJLKRFCHfX+cBv3WOtzmiMv9LN1PJK5Ee8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1p+J/wi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66899C4CEF1;
	Mon, 15 Sep 2025 08:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757926315;
	bh=zgTyu2IVPRbQbX73aW4fq2zkqmj1x1GIQuq8W/aVZO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F1p+J/wikOOHjwhw2cBejpdU/zptoP9jH9AJlbKUZeNxyjlvDQXx5osIF8bbicpGa
	 Hz+JhRvxgO6bBlPGXQcik/UxXwKRyYtyZXA2CDvH8l0FgXtLueHOecsUaSzDHZfBa0
	 Lq5zROAXjh2OvHPzBSAg1V35X7P5Cbzx8KtVnfZrqffnD/5cA/7BkCdubiG460X1y1
	 EQTrBb8QR7CT/gfv6HfLfD2KLGsm2PWa6CwL8qprL7u0Nj3KfYmJJ9kPFHn/0rrWnR
	 KHzKyweoKPU3qtGuYTqIn4YilGumgYupUQLWc2F840LWRdvGSLdB/Kf7FhYVyAR0wk
	 cP6q7cDk5wRng==
Date: Mon, 15 Sep 2025 09:51:50 +0100
From: Simon Horman <horms@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: Re: [PATCH net-next 4/4] net/mlx5: Lag, add net namespace support
Message-ID: <20250915085150.GN224143@horms.kernel.org>
References: <1757572267-601785-1-git-send-email-tariqt@nvidia.com>
 <1757572267-601785-5-git-send-email-tariqt@nvidia.com>
 <20250912140902.GC30363@horms.kernel.org>
 <5af63b6d-8609-4799-83b7-fa3daca390bb@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5af63b6d-8609-4799-83b7-fa3daca390bb@nvidia.com>

On Sat, Sep 13, 2025 at 04:52:17AM +0300, Mark Bloch wrote:
> 
> 
> On 12/09/2025 17:09, Simon Horman wrote:
> > On Thu, Sep 11, 2025 at 09:31:07AM +0300, Tariq Toukan wrote:
> >> From: Shay Drory <shayd@nvidia.com>
> >>
> >> Update the LAG implementation to support net namespace isolation.
> >>
> >> With recent changes to the devcom framework allowing namespace-aware
> >> matching, the LAG layer is updated to register devcom clients with the
> >> associated net namespace. This ensures that LAG formation only occurs
> >> between mlx5 interfaces that reside in the same namespace.
> >>
> >> This change ensures that devices in different namespaces do not interfere
> >> with each other's LAG setup and behavior. For example, if two PCI PFs are
> >> in the same namespace, they are eligible to form a hardware LAG.
> >>
> >> In addition, reload behavior for LAG is adjusted to handle namespace
> >> contexts appropriately.
> >>
> >> Signed-off-by: Shay Drory <shayd@nvidia.com>
> >> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> >> Reviewed-by: Parav Pandit <parav@nvidia.com>
> >> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> >> ---
> >>  drivers/net/ethernet/mellanox/mlx5/core/devlink.c |  5 -----
> >>  drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 14 +++++++++++---
> >>  drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h |  1 +
> >>  3 files changed, 12 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> >> index a0b68321355a..bfa44414be82 100644
> >> --- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> >> +++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> >> @@ -204,11 +204,6 @@ static int mlx5_devlink_reload_down(struct devlink *devlink, bool netns_change,
> >>  		return 0;
> >>  	}
> >>  
> >> -	if (mlx5_lag_is_active(dev)) {
> >> -		NL_SET_ERR_MSG_MOD(extack, "reload is unsupported in Lag mode");
> >> -		return -EOPNOTSUPP;
> >> -	}
> >> -
> > 
> > Maybe I'm missing something obvious. But I think this could do with
> > some further commentary in the commit message. Or perhaps being a separate
> > patch.
> 
> While one could split this into two patches, first enabling LAG creation
> within a namespace, then separately removing the devlink reload restriction
> that separation feels artificial.
> 
> Both changes are required to deliver complete support for LAG in namespaces
> Since removing the reload restriction is a trivial change, it is better
> to deliver the entire feature in this single patch.
> 
> Will clarify and add this justification to the commit message.

Thanks, much appreciated.

