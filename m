Return-Path: <linux-rdma+bounces-4368-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BB5951E2C
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 17:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30111F22F9D
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 15:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE3C1B4C42;
	Wed, 14 Aug 2024 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flUVwimz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174831B4C38;
	Wed, 14 Aug 2024 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723648158; cv=none; b=I5SqECkPXCqnlw0y+lt995Vtf/ZiQQuSPb+JaRGnP7CvcFvzHQaqnYjTgLW2RFFe+a9sd9ehuI2BgE3nD6k4Hc0mNcZNgZqej4ovhUq5tPU1JHpMjrrxjHHfQK4BO20cowDXhrNN56JqRRwro21TLFITVl/bgTrAXuot03YCdSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723648158; c=relaxed/simple;
	bh=XhIk/ivJe9y/rFLSzxxGWtrccGrpo6Zo1KfaOrHUh0A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uTpCN5n9jEuoHg9T7z/b/m0okMCNWzeUV0f1qSIUdmuwxZdMeB5eANT22qClI8DERVcdVRIMP0dRTXC6H7U19zLyY+Km2ZIOcStNBq0Kqa760k9MYXpYB3qN6WTR2aQ+2z+VZd374Oss/Vd6MlQmZRjsBynMMxvYlSkkPH88uv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flUVwimz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEF7C116B1;
	Wed, 14 Aug 2024 15:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723648157;
	bh=XhIk/ivJe9y/rFLSzxxGWtrccGrpo6Zo1KfaOrHUh0A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=flUVwimzH7kKJ075Wx5f8LVKW0LbSvueMiSoq5G5rJqfot7EoqUHkR1LLhfURHmMk
	 DyXOdkM1A02mYqsd4Cp6ASe3m7jug9VLitb45786NlXmKdtU70AIVjYr8v9AEyl+m9
	 OHgfhQLoM6YtXLYcr3vLLfidluRpUNHW1TOu4Uf45W/OQyTaqu7S4E/iZ0EG+wWe4d
	 bFKaKLyv1tOyfvKiFRGb+ssQusYjc9iVKWfwue5tDOtllx0PrFuZ9U6J3mIaHK/cyE
	 fmgAhdNFmXVPt6dcepm2Q2HjyB+NPX8aZsHejMNwJEe7PaxszKgtLhdwUGtqI3d/eh
	 L8aNgZbB1NdMA==
Date: Wed, 14 Aug 2024 08:09:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>, "moderated list:INTEL
 ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>, Jeroen de Borst
 <jeroendb@google.com>, Jiri Pirko <jiri@resnulli.us>, Leon Romanovsky
 <leon@kernel.org>, open list <linux-kernel@vger.kernel.org>, "open
 list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Praveen
 Kaligineedi <pkaligineedi@google.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Shailend Chand
 <shailend@google.com>, Tariq Toukan <tariqt@nvidia.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Willem de Bruijn <willemb@google.com>, Yishai
 Hadas <yishaih@nvidia.com>, Ziwei Xiao <ziweixiao@google.com>
Subject: Re: [RFC net-next 0/6] Cleanup IRQ affinity checks in several
 drivers
Message-ID: <20240814080915.005cb9ac@kernel.org>
In-Reply-To: <ZryfGDU9wHE0IrvZ@LQ3V64L9R2.home>
References: <20240812145633.52911-1-jdamato@fastly.com>
	<20240813171710.599d3f01@kernel.org>
	<ZrxZaHGDTO3ohHFH@LQ3V64L9R2.home>
	<ZryfGDU9wHE0IrvZ@LQ3V64L9R2.home>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 13:12:08 +0100 Joe Damato wrote:
> Actually... how about a slightly different approach, which caches
> the affinity mask in the core?

I was gonna say :)

>   0. Extend napi struct to have a struct cpumask * field
> 
>   1. extend netif_napi_set_irq to:
>     a. store the IRQ number in the napi struct (as you suggested)
>     b. call irq_get_effective_affinity_mask to store the mask in the
>        napi struct
>     c. set up generic affinity_notify.notify and
>        affinity_notify.release callbacks to update the in core mask
>        when it changes

This part I'm not an export on.

>   2. add napi_affinity_no_change which now takes a napi_struct
> 
>   3. cleanup all 5 drivers:
>     a. add calls to netif_napi_set_irq for all 5 (I think no RTNL
>        is needed, so I think this would be straight forward?)
>     b. remove all affinity_mask caching code in 4 of 5 drivers
>     c. update all 5 drivers to call napi_affinity_no_change in poll
> 
> Then ... anyone who adds support for netif_napi_set_irq to their
> driver in the future gets automatic support in-core for
> caching/updating of the mask? And in the future netdev-genl could
> dump the mask since its in-core?
> 
> I'll mess around with that locally to see how it looks, but let me
> know if that sounds like a better overall approach.

Could we even handle this directly as part of __napi_poll(),
once the driver gives core all of the relevant pieces of information ?

