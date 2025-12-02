Return-Path: <linux-rdma+bounces-14862-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E9BC9BEF5
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Dec 2025 16:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E503A8E66
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Dec 2025 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AD42561A2;
	Tue,  2 Dec 2025 15:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifZRCRUx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA43213D891;
	Tue,  2 Dec 2025 15:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764689066; cv=none; b=s27xNZbjtYJ4W5b3odJEfoQftv18y05ZgyuywRG99JgDnpzvZ5FXnLGTjx7DOvLUGUq4Uu1pV+QKe5yL/lQjB469OmBVFaFPzQm4Mjgnm94bMc3KlJwY1SZ+KuI6azod3r5y2D/sYjhpUHc+/u9FK4o7khpxGJ/ylQM1apKUzj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764689066; c=relaxed/simple;
	bh=v2RVGAjLwEszDVgjudJDCI9J7LHEnzEKmt1lYJDEido=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eh5bs1y3owwqCqV4m7ZaGf78Q8SeGw1No1VkIsMK00FzzoOzUztJjb7AX3kDXg0IdoDEklz9bHBbuesJTWGd0X1aMfXqvCAcmXIb98S4bTdeBz3/kmkSLmZBDnevx9K5jnTCO8V20OkNeyZGQakmMLbqxiuOGGlSLMESHMhuu/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifZRCRUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF90C4CEF1;
	Tue,  2 Dec 2025 15:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764689066;
	bh=v2RVGAjLwEszDVgjudJDCI9J7LHEnzEKmt1lYJDEido=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ifZRCRUxM+X9CeSmrhoX7a7JxoBC0wCimXvtvqqcoqTJJosA7wl25cpDfuXk5S5vm
	 Cbv+k/O0iu5i1Gs57n/R6uK9gXozOq7URieS8Whbjwo4tAu1jWJ4w/jeA9k2ec+0PS
	 5NYsAoRf1mXzWot+GXUmk2IHV+6tPBoocdlUCYW1tHXu/7SqQEHPJwmrQaNzaYT55H
	 khcE7gQpsXLSyPR1rgHdckyd2k7u4eDo3KnETmp6EY8zX8Ja7pYJZoMeubHQsXJMhz
	 iOatb3XJpTnKtpGokWX8As78PvrnIrG3WpfsVFlmRlNQSNFC2MJpokgIlyQzyLkG9R
	 IiuTaCd69iWsA==
Date: Tue, 2 Dec 2025 15:24:21 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net 2/2] net/mlx5e: Avoid unregistering PSP twice
Message-ID: <aS8EpZ3UYkfwpCyH@horms.kernel.org>
References: <1764602008-1334866-1-git-send-email-tariqt@nvidia.com>
 <1764602008-1334866-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1764602008-1334866-3-git-send-email-tariqt@nvidia.com>

On Mon, Dec 01, 2025 at 05:13:28PM +0200, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> PSP is unregistered twice in:
> _mlx5e_remove -> mlx5e_psp_unregister
> mlx5e_nic_cleanup -> mlx5e_psp_unregister
> 
> This leads to a refcount underflow in some conditions:
> ------------[ cut here ]------------
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 2 PID: 1694 at lib/refcount.c:28 refcount_warn_saturate+0xd8/0xe0
> [...]
>  mlx5e_psp_unregister+0x26/0x50 [mlx5_core]
>  mlx5e_nic_cleanup+0x26/0x90 [mlx5_core]
>  mlx5e_remove+0xe6/0x1f0 [mlx5_core]
>  auxiliary_bus_remove+0x18/0x30
>  device_release_driver_internal+0x194/0x1f0
>  bus_remove_device+0xc6/0x130
>  device_del+0x159/0x3c0
>  mlx5_rescan_drivers_locked+0xbc/0x2a0 [mlx5_core]
> [...]
> 
> Do not directly remove psp from the _mlx5e_remove path, the PSP cleanup
> happens as part of profile cleanup.
> 
> Fixes: 89ee2d92f66c ("net/mlx5e: Support PSP offload functionality")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


