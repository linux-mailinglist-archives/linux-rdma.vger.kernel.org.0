Return-Path: <linux-rdma+bounces-12326-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 917E0B0B4E4
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jul 2025 12:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6217817A926
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jul 2025 10:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861871F2BB5;
	Sun, 20 Jul 2025 10:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFU0B/Ju"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C391DBB3A;
	Sun, 20 Jul 2025 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753007409; cv=none; b=QKpwYuK8fYKI4jjBMBBMu5MAPNpCw8B1l5QhCexOdlkcoU6+q16rmWHbcZql3Y/LGLoSxG1PpkIrwHOYleSGDdsAPWBbwkQdIb6tq0+0WrcomdLFXHmNYLiIDHVCJU07fPrNL4F6RGZjM6w7tmv5VlCxBFgGDRqgxSH5XBi/WtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753007409; c=relaxed/simple;
	bh=J92ChcRnDttWm9ZMqpwKbQR0/39abVygpXfEDwM1XU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psNu3xY9pcq7HcrZ6oX/MIX/6qUBZH4iJ7kImlGK1y1XSaBzx0IOJWMzk2QkUx1qZmpyUkCg7hv7jG4Oyrd4i47X71ilMsUpTqLbIetwMj/VlABvGcly2h+KevL1zom74XM2W+XJQnMUD+C4e9uSGjXsVjzxtxzOewcjotR8ahA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFU0B/Ju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C611BC4CEE7;
	Sun, 20 Jul 2025 10:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753007408;
	bh=J92ChcRnDttWm9ZMqpwKbQR0/39abVygpXfEDwM1XU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MFU0B/JufihuasPZrquWC1GFzNqNRIWTymvqOvM+JUohH7UJtMwgY07U+OOEosiCS
	 +sx76Fbp3KsfNU/7vYb22NP4keJGU8Ga1+o0HN1oYNr8xn27QNM0ZuneCOEqBINMJl
	 QdYqf/Ngmtn9QBltRNeXxFGVG8/EeOPSaz2jKrfV7Ld7/AOEfDRQhniKT+hyDON73Q
	 B8CoP6ZiOxBjXwbVS3jMoeo+nWg5/rLuyXsjUyKUl3J++Lu66U/VumCbEXeFK6h9rG
	 nGgvHc27nkqlzL8lYqGvFDecUwPX+JrBwB2bHp82LeLAHmkWL1NVmIRS7KnVcaYFiv
	 Rl+dwUvNcUO3Q==
Date: Sun, 20 Jul 2025 13:30:03 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Yonatan Maman <ymaman@nvidia.com>
Cc: =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alistair Popple <apopple@nvidia.com>,
	Ben Skeggs <bskeggs@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Daisuke Matsuda <dskmtsd@gmail.com>, Shay Drory <shayd@nvidia.com>,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] *** GPU Direct RDMA (P2P DMA) for Device Private
 Pages ***
Message-ID: <20250720103003.GH402218@unreal>
References: <20250718115112.3881129-1-ymaman@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718115112.3881129-1-ymaman@nvidia.com>

On Fri, Jul 18, 2025 at 02:51:07PM +0300, Yonatan Maman wrote:
> From: Yonatan Maman <Ymaman@Nvidia.com>
> 
> This patch series aims to enable Peer-to-Peer (P2P) DMA access in
> GPU-centric applications that utilize RDMA and private device pages. This
> enhancement reduces data transfer overhead by allowing the GPU to directly
> expose device private page data to devices such as NICs, eliminating the
> need to traverse system RAM, which is the native method for exposing
> device private page data.
> 
> To fully support Peer-to-Peer for device private pages, the following
> changes are proposed:
> 
> `Memory Management (MM)`
>  * Leverage struct pagemap_ops to support P2P page operations: This
> modification ensures that the GPU can directly map device private pages
> for P2P DMA.
>  * Utilize hmm_range_fault to support P2P connections for device private
> pages (instead of Page fault)
> 
> `IB Drivers`
> Add TRY_P2P_REQ flag for the hmm_range_fault call: This flag indicates the
> need for P2P mapping, enabling IB drivers to efficiently handle P2P DMA
> requests.
> 
> `Nouveau driver`
> Add support for the Nouveau p2p_page callback function: This update
> integrates P2P DMA support into the Nouveau driver, allowing it to handle
> P2P page operations seamlessly.
> 
> `MLX5 Driver`
> Utilize NIC Address Translation Service (ATS) for ODP memory, to optimize
> DMA P2P for private device pages. Also, when P2P DMA mapping fails due to
> inaccessible bridges, the system falls back to standard DMA, which uses host
> memory, for the affected PFNs

I'm probably missing something very important, but why can't you always
perform p2p if two devices support it? It is strange that IB and not HMM
has a fallback mode.

Thanks

> 
> Previous version:
> https://lore.kernel.org/linux-mm/20241201103659.420677-1-ymaman@nvidia.com/
> https://lore.kernel.org/linux-mm/20241015152348.3055360-1-ymaman@nvidia.com/
> 
> Yonatan Maman (5):
>   mm/hmm: HMM API to enable P2P DMA for device private pages
>   nouveau/dmem: HMM P2P DMA for private dev pages
>   IB/core: P2P DMA for device private pages
>   RDMA/mlx5: Enable P2P DMA with fallback mechanism
>   RDMA/mlx5: Enabling ATS for ODP memory
> 
>  drivers/gpu/drm/nouveau/nouveau_dmem.c | 110 +++++++++++++++++++++++++
>  drivers/infiniband/core/umem_odp.c     |   4 +
>  drivers/infiniband/hw/mlx5/mlx5_ib.h   |   6 +-
>  drivers/infiniband/hw/mlx5/odp.c       |  24 +++++-
>  include/linux/hmm.h                    |   3 +-
>  include/linux/memremap.h               |   8 ++
>  mm/hmm.c                               |  57 ++++++++++---
>  7 files changed, 195 insertions(+), 17 deletions(-)
> 
> -- 
> 2.34.1
> 

